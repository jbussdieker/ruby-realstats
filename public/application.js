$(function() {
  // We use an inline data source in the example, usually data would
  // be fetched from a server
  var ws = new WebSocket("ws://localhost:8080/");

  var series = {
    label: "Value",
    lines: {
      show: true,
      fill: false
    },
    data: []
  };

  var plot = null;
  var datalen = 100;

  ws.onmessage = function(evt) {
    var d = $.parseJSON(evt.data);
    series.data.push([Date.now(), d]);
    while (series.data.length > datalen) {
      series.data.shift();
    }
    if (plot) {
      plot.setData([series]);
      plot.setupGrid();
      plot.draw();
    } else {
      plot = $.plot("#placeholder", [series], {
        series: {
          shadowSize: 0	// Drawing is faster without shadows
        },
        xaxis: {
        }
      });
      plot.draw();
    }
  }
  ws.onopen = function(evt) {
    $('#conn_status').html('<b>Connected</b>');
  }
  ws.onerror = function(evt) {
    $('#conn_status').html('<b>Error</b>');
  }
  ws.onclose = function(evt) {
    $('#conn_status').html('<b>Closed</b>');
  }
});
