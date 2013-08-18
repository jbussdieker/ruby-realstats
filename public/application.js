$(function() {

  var series = {
    label: "Value",
    lines: {
      show: true,
      fill: true
    },
    data: []
  };

  var plot = null;
  var container = $("#placeholder");
  var datalen = container.outerWidth() / 2 || 300;
  var index = 0;

  ws.onmessage = function(evt) {
    var d = $.parseJSON(evt.data);
    series.data.push([index, d]);
    index = index + 1;
    while (series.data.length > datalen) {
      series.data.shift();
    }
    if (plot) {
      plot.setData([series]);
      plot.setupGrid();
      plot.draw();
    } else {
      plot = $.plot(container, [series], {
        series: {
          shadowSize: 0
        },
        xaxis: {
          show: false
        }
      });
      plot.draw();
    }
  }
  ws.onopen = function(evt) {
    $('#conn_status').html('<b class="label label-success">Connected</b>');
  }
  ws.onerror = function(evt) {
    $('#conn_status').html('<b>Error</b>');
  }
  ws.onclose = function(evt) {
    $('#conn_status').html('<b class="label label-danger">Closed</b>');
  }
});
