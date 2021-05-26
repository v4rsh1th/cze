#include "../print.h"
#include "../../../drivers/monitor/monitor.h"

void clear(void) {
    monitorClear();     // Clear the monitor   
}

void _writek(s8 *str) {
  // Write to Monitor
    monitorWrite(str);  // Write to monitor
}

void _printk(s8 *str) {
  // Print to Monitor
    monitorWrite(str);  // Print to monitor
    monitorWriteChar('\n');
}

void printkCenter(s8 *str) {
  // Print in Center of Monitor
    monitorPrintCenter(str);    // Print in center of monitor
}