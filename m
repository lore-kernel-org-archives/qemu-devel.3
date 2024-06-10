Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D42C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 17:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGjIX-0005Kd-FA; Mon, 10 Jun 2024 13:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGjIV-0005It-Jv
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:59:11 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGjIT-0001ai-DL
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:59:11 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4223c77e4b1so1077935e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718042348; x=1718647148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GNte3Osrk4NBFN17tMmuMGXy/JnFYDWs3NUrv+YBw84=;
 b=evegldKYw4ZvacVCr0aic+N5Il6gMuAIdBpahAIIw4X52ow5k1Ta0Sx0Qv3PNIV0So
 5q3WsSueXQ7F591r2yznR5U5p9khuY+B4/W0QWcxxyoT6psIzdrzwzltZotxAVzCI27o
 8TuMSmbhw8+uVsOGlJx5AQAWY+87vowYz78+at3Uhpk+GZsDuFRr3fi7GU8xcD0kAlsT
 26WWuLNY8GGlV53M5yCnEkD2JHr+aFzRpxiJ/6e3YMXJ3H+LDwNbo6ew8v/4c22IrRYX
 q/4xZ2UtHyzpvnZnxBuxxipvT5wXDoQF6/GIjQUdddt/i0TzpcBFUq7FqqHMZ3rM1fSn
 ntAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718042348; x=1718647148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GNte3Osrk4NBFN17tMmuMGXy/JnFYDWs3NUrv+YBw84=;
 b=Phuxyfm52wpnvE9MHW1Fgk5fhAX24DbWak1UcHr8R1FPrmvdcaRc6SpASxzjHm0XFW
 GRqWDyqlX59o6cgIWDYujnj9WClCJgmL8fMhMmhS7mu7EH6glcUxCQABoPVXj+2Q53YT
 lJ2zglZAEbAArnwUduU6U19UUaZhBMnPFGBoEyOMvGFQBEX8IQhiONTAybN2uwoD2jLH
 P1ffFqUFCmUXmzoYIQcJQBlc/5OebPSk1NEEdjRJwVGUOVB1NCx9bqfN3V6vQgL82PjU
 n5lUGUv9h6UT1sn+7xF+8Q6YPzJOY9ZXEs833TCpaR+RlzNASUQJmbaKr5bQRrNm+7zB
 torQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVswcNbQg8QQhN+Of1VfiP0a1oZcsQT4AVvvkTTOUY6M1UjWH7FsaB6+t3TVpbDeEsL7yAhWAzBy0jlmp+kT7BUxfs/GsU=
X-Gm-Message-State: AOJu0YzEh8XOrrS1pd4I1shJP5feuNU7XU4WonCzTudC5HBJLKeieCZw
 wGcHb6plOnmcRBXIIG5rQqlPZYESV+eNfP58uUqLPB3DxBvvOMqV6Ols3XtqmqY=
X-Google-Smtp-Source: AGHT+IG7iPsZxgFPnE4L2bCB8PtwqGG35kr03sgugf2XVKSiuorhnPCGQp14fEROySn6Nru2Appsbg==
X-Received: by 2002:a05:600c:1907:b0:419:f241:633b with SMTP id
 5b1f17b1804b1-421649ea685mr92311205e9.8.1718042347748; 
 Mon, 10 Jun 2024 10:59:07 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4224385670fsm1523025e9.16.2024.06.10.10.59.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jun 2024 10:59:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH 2/3] monitor: Allow passing HMP arguments to QMP
 HumanReadableText API
Date: Mon, 10 Jun 2024 19:58:51 +0200
Message-ID: <20240610175852.21215-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610175852.21215-1-philmd@linaro.org>
References: <20240610175852.21215-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Allow HMP commands implemented using the HumanReadableText API
(via the HMPCommand::cmd_info_hrt handler) to pass arguments
to the QMP equivalent command. The arguments are serialized as
a JSON dictionary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/writing-monitor-commands.rst | 15 ++++++++++++++-
 qapi/machine.json                       | 24 ++++++++++++++++++++++++
 include/monitor/monitor.h               |  3 ++-
 monitor/monitor-internal.h              |  2 +-
 accel/tcg/monitor.c                     |  4 ++--
 hw/core/loader.c                        |  2 +-
 hw/core/machine-qmp-cmds.c              |  9 +++++----
 hw/usb/bus.c                            |  2 +-
 monitor/hmp-target.c                    |  3 ++-
 monitor/hmp.c                           | 11 +++++++----
 10 files changed, 59 insertions(+), 16 deletions(-)

diff --git a/docs/devel/writing-monitor-commands.rst b/docs/devel/writing-monitor-commands.rst
index 930da5cd06..843458e52c 100644
--- a/docs/devel/writing-monitor-commands.rst
+++ b/docs/devel/writing-monitor-commands.rst
@@ -561,6 +561,7 @@ returns a ``HumanReadableText``::
  # Since: 6.2
  ##
  { 'command': 'x-query-roms',
+   'data': { 'json-args': 'str'},
    'returns': 'HumanReadableText',
    'features': [ 'unstable' ] }
 
@@ -578,7 +579,7 @@ Implementing the QMP command
 The QMP implementation will typically involve creating a ``GString``
 object and printing formatted data into it, like this::
 
- HumanReadableText *qmp_x_query_roms(Error **errp)
+ HumanReadableText *qmp_x_query_roms(const char *json_args, Error **errp)
  {
      g_autoptr(GString) buf = g_string_new("");
      Rom *rom;
@@ -596,6 +597,18 @@ object and printing formatted data into it, like this::
 The actual implementation emits more information.  You can find it in
 hw/core/loader.c.
 
+For QMP command taking (optional) parameters, these parameters are
+serialized as a JSON dictionary, and can be retrieved using the QDict
+API. If the previous ``x-query-roms`` command were taking a "index"
+argument, it could be retrieved as::
+
+ HumanReadableText *qmp_x_query_roms(const char *json_args, Error **errp)
+ {
+     g_autoptr(GString) buf = g_string_new("");
+     QDict *qdict = qobject_to(QDict, qobject_from_json(json_args, &error_abort));
+     uint64_t index = qdict_get_int(qdict, "index");
+     ...
+ }
 
 Implementing the HMP command
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/qapi/machine.json b/qapi/machine.json
index 1283d14493..6da72f2585 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1697,6 +1697,8 @@
 #
 # Query interrupt statistics
 #
+# @json-args: HMP arguments encoded as JSON string (unused for this command).
+#
 # Features:
 #
 # @unstable: This command is meant for debugging.
@@ -1706,6 +1708,7 @@
 # Since: 6.2
 ##
 { 'command': 'x-query-irq',
+  'data': { 'json-args': 'str'},
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ] }
 
@@ -1714,6 +1717,8 @@
 #
 # Query TCG compiler statistics
 #
+# @json-args: HMP arguments encoded as JSON string (unused for this command).
+#
 # Features:
 #
 # @unstable: This command is meant for debugging.
@@ -1723,6 +1728,7 @@
 # Since: 6.2
 ##
 { 'command': 'x-query-jit',
+  'data': { 'json-args': 'str'},
   'returns': 'HumanReadableText',
   'if': 'CONFIG_TCG',
   'features': [ 'unstable' ] }
@@ -1732,6 +1738,8 @@
 #
 # Query NUMA topology information
 #
+# @json-args: HMP arguments encoded as JSON string (unused for this command).
+#
 # Features:
 #
 # @unstable: This command is meant for debugging.
@@ -1741,6 +1749,7 @@
 # Since: 6.2
 ##
 { 'command': 'x-query-numa',
+  'data': { 'json-args': 'str'},
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ] }
 
@@ -1749,6 +1758,8 @@
 #
 # Query TCG opcode counters
 #
+# @json-args: HMP arguments encoded as JSON string (unused for this command).
+#
 # Features:
 #
 # @unstable: This command is meant for debugging.
@@ -1758,6 +1769,7 @@
 # Since: 6.2
 ##
 { 'command': 'x-query-opcount',
+  'data': { 'json-args': 'str'},
   'returns': 'HumanReadableText',
   'if': 'CONFIG_TCG',
   'features': [ 'unstable' ] }
@@ -1767,6 +1779,8 @@
 #
 # Query system ramblock information
 #
+# @json-args: HMP arguments encoded as JSON string (unused for this command).
+#
 # Features:
 #
 # @unstable: This command is meant for debugging.
@@ -1776,6 +1790,7 @@
 # Since: 6.2
 ##
 { 'command': 'x-query-ramblock',
+  'data': { 'json-args': 'str'},
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ] }
 
@@ -1784,6 +1799,8 @@
 #
 # Query information on the registered ROMS
 #
+# @json-args: HMP arguments encoded as JSON string (unused for this command).
+#
 # Features:
 #
 # @unstable: This command is meant for debugging.
@@ -1793,6 +1810,7 @@
 # Since: 6.2
 ##
 { 'command': 'x-query-roms',
+  'data': { 'json-args': 'str'},
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ] }
 
@@ -1801,6 +1819,8 @@
 #
 # Query information on the USB devices
 #
+# @json-args: HMP arguments encoded as JSON string (unused for this command).
+#
 # Features:
 #
 # @unstable: This command is meant for debugging.
@@ -1810,6 +1830,7 @@
 # Since: 6.2
 ##
 { 'command': 'x-query-usb',
+  'data': { 'json-args': 'str'},
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ] }
 
@@ -1870,6 +1891,8 @@
 #
 # Query information on interrupt controller devices
 #
+# @json-args: HMP arguments encoded as JSON string (unused for this command).
+#
 # Features:
 #
 # @unstable: This command is meant for debugging.
@@ -1879,5 +1902,6 @@
 # Since: 9.1
 ##
 { 'command': 'x-query-interrupt-controllers',
+  'data': { 'json-args': 'str'},
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ]}
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 965f5d5450..b21c702c12 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -58,7 +58,8 @@ int64_t monitor_fdset_dup_fd_find(int dup_fd);
 void monitor_register_hmp(const char *name, bool info,
                           void (*cmd)(Monitor *mon, const QDict *qdict));
 void monitor_register_hmp_info_hrt(const char *name,
-                                   HumanReadableText *(*handler)(Error **errp));
+                                   HumanReadableText *(*handler)(const char *json_args,
+                                                                 Error **errp));
 
 int error_vprintf_unless_qmp(const char *fmt, va_list ap) G_GNUC_PRINTF(1, 0);
 int error_printf_unless_qmp(const char *fmt, ...) G_GNUC_PRINTF(1, 2);
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 252de85681..b3aa50834b 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -81,7 +81,7 @@ typedef struct HMPCommand {
      * @cmd_info_hrt to the corresponding QMP handler that returns
      * the formatted text.
      */
-    HumanReadableText *(*cmd_info_hrt)(Error **errp);
+    HumanReadableText *(*cmd_info_hrt)(const char *json_args, Error **errp);
     bool coroutine;
     /*
      * @sub_table is a list of 2nd level of commands. If it does not exist,
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 093efe9714..517c96eeb7 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -199,7 +199,7 @@ static void dump_exec_info(GString *buf)
     tcg_dump_info(buf);
 }
 
-HumanReadableText *qmp_x_query_jit(Error **errp)
+HumanReadableText *qmp_x_query_jit(const char *json_args, Error **errp)
 {
     g_autoptr(GString) buf = g_string_new("");
 
@@ -220,7 +220,7 @@ static void tcg_dump_op_count(GString *buf)
     g_string_append_printf(buf, "[TCG profiler not compiled]\n");
 }
 
-HumanReadableText *qmp_x_query_opcount(Error **errp)
+HumanReadableText *qmp_x_query_opcount(const char *json_args, Error **errp)
 {
     g_autoptr(GString) buf = g_string_new("");
 
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 2f8105d7de..e0da5edbb3 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1679,7 +1679,7 @@ void *rom_ptr_for_as(AddressSpace *as, hwaddr addr, size_t size)
     return cbdata.rom;
 }
 
-HumanReadableText *qmp_x_query_roms(Error **errp)
+HumanReadableText *qmp_x_query_roms(const char *json_args, Error **errp)
 {
     Rom *rom;
     g_autoptr(GString) buf = g_string_new("");
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 130217da8f..fc79772df8 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -214,7 +214,7 @@ MemdevList *qmp_query_memdev(Error **errp)
     return list;
 }
 
-HumanReadableText *qmp_x_query_numa(Error **errp)
+HumanReadableText *qmp_x_query_numa(const char *json_args, Error **errp)
 {
     g_autoptr(GString) buf = g_string_new("");
     int i, nb_numa_nodes;
@@ -311,7 +311,7 @@ MemoryInfo *qmp_query_memory_size_summary(Error **errp)
     return mem_info;
 }
 
-HumanReadableText *qmp_x_query_ramblock(Error **errp)
+HumanReadableText *qmp_x_query_ramblock(const char *json_args, Error **errp)
 {
     g_autoptr(GString) buf = ram_block_format();
 
@@ -351,7 +351,7 @@ static int qmp_x_query_irq_foreach(Object *obj, void *opaque)
     return 0;
 }
 
-HumanReadableText *qmp_x_query_irq(Error **errp)
+HumanReadableText *qmp_x_query_irq(const char *json_args, Error **errp)
 {
     g_autoptr(GString) buf = g_string_new("");
 
@@ -382,7 +382,8 @@ static int qmp_x_query_intc_foreach(Object *obj, void *opaque)
     return 0;
 }
 
-HumanReadableText *qmp_x_query_interrupt_controllers(Error **errp)
+HumanReadableText *qmp_x_query_interrupt_controllers(const char *json_args,
+                                                     Error **errp)
 {
     g_autoptr(GString) buf = g_string_new("");
     object_child_foreach_recursive(object_get_root(),
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index bfab2807d7..daa3f71d47 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -598,7 +598,7 @@ static char *usb_get_fw_dev_path(DeviceState *qdev)
     return fw_path;
 }
 
-HumanReadableText *qmp_x_query_usb(Error **errp)
+HumanReadableText *qmp_x_query_usb(const char *json_args, Error **errp)
 {
     g_autoptr(GString) buf = g_string_new("");
     USBBus *bus;
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 0466474354..81e53a5767 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -157,7 +157,8 @@ void monitor_register_hmp(const char *name, bool info,
 }
 
 void monitor_register_hmp_info_hrt(const char *name,
-                                   HumanReadableText *(*handler)(Error **errp))
+                                   HumanReadableText *(*handler)(const char *json_args,
+                                                                 Error **errp))
 {
     HMPCommand *table = hmp_info_cmds;
 
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 69c1b7e98a..7802a31412 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -29,6 +29,7 @@
 #include "monitor/hmp.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qnum.h"
+#include "qapi/qmp/qjson.h"
 #include "qemu/config-file.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
@@ -1082,11 +1083,13 @@ fail:
     return NULL;
 }
 
-static void hmp_info_human_readable_text(Monitor *mon,
-                                         HumanReadableText *(*handler)(Error **))
+static void hmp_info_human_readable_text(Monitor *mon, QDict *qdict,
+                                         HumanReadableText *(*handler)(const char *,
+                                                                       Error **))
 {
     Error *err = NULL;
-    g_autoptr(HumanReadableText) info = handler(&err);
+    g_autoptr(GString) ret_json = qobject_to_json(QOBJECT(qdict));
+    g_autoptr(HumanReadableText) info = handler(ret_json->str, &err);
 
     if (hmp_handle_error(mon, err)) {
         return;
@@ -1100,7 +1103,7 @@ static void handle_hmp_command_exec(Monitor *mon,
                                     QDict *qdict)
 {
     if (cmd->cmd_info_hrt) {
-        hmp_info_human_readable_text(mon,
+        hmp_info_human_readable_text(mon, qdict,
                                      cmd->cmd_info_hrt);
     } else {
         cmd->cmd(mon, qdict);
-- 
2.41.0


