Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E415E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvzg-0004m5-N9; Thu, 09 Jan 2025 12:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzX-0004ia-3S
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:44 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzT-00070B-Kl
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:42 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso228730366b.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736442398; x=1737047198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/WL5/vy6t1Ak67+R9S2PoF5hou1a9eAangsk5iwlrV8=;
 b=Tgi5n1PfTeHliZFXC88QYiFDFJugzPUq15Xq9kB1+uqs2HOKGzWTdwyFfkiJ81mA6s
 9RaU+47xGpSri8to9gJN87I2pPJnoKTXD0bXkawxh0uCr5mnjUdMgyaomVLG+2bK/KAH
 abfkzDIHa8PkS9uLfvwS8yTw7nWBHalgkpFza40VSZ/u8lWoQYcj4vyeiuDoiDqWpE/r
 DCGtSEBdYo/NjnUOVErIJ2euBlhBQXv+a/vTrVELyFaYfLs5AAbLPxN9RhKo34eKrvGy
 3eFfSI7m+ADItg8fXWAwh7pk6dbAJrafxFfTYblW9x+d1JI2mmae+NSuvEZFzOHvXD1t
 FdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736442398; x=1737047198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/WL5/vy6t1Ak67+R9S2PoF5hou1a9eAangsk5iwlrV8=;
 b=c2nnYk3VDmWSuuLWXZLvVA/6OLjabhs5NfPwzXUQsfEszNaGfG0JaBCYYlClrvgDRE
 r2y+hJw4guYuP8kuFYKev36koh9kzKJ880to9Oysc8i8vWuM7be/7uho2af+z/n3gDOq
 uDb14Ui4tJpZ+SC2geTgWuuGYNKwuZXp14MaImBcPlbDF+U5kBYNOKnpRfbNUL+1O8ga
 Jl5qqJwXkGgc32m4G0Nhu3E3ugsYWj1S1k9Mg9PA93MfKU59bLfi4khWYvUtNdmjWhKg
 8/ddhCy3770IP6lEJNChKdFRr4Pf1RfPRqQF4FyY+2xTU51c4eLlD3zNpLjpr3Z6Qp9v
 UTIA==
X-Gm-Message-State: AOJu0YzS6xZolZiumqw9OAhyIxJ4s3jWVhYTICaVh+eB8CBG5BwnYAAu
 8D2qlK3KKj5iyHPs7HUoon+RYJYpind+ksd4fFezD5FAoRiQrsp86fLEClSHKqI=
X-Gm-Gg: ASbGncv4Z/TLLfERgQcpWY4pfi+fjH9e/AxNYcYZaZhQ8vdq0WgDCe5Zt3G+vhkP4tc
 3nj39urdihdZqsr7EhuEWCd2KZAE8D6WZrzyvsPeuQ4CT+zBGszbRYANCU78LBEDlyUf8I5Gorb
 jl67Ub69vfvV7okld/wYfEUnCMar84pKv21I5ld8ssldT9uv8gHdCcHFqtrSJeTa38Eb3jX+A3M
 DoZFqk+wlCcathdxPPo0UGr20bMrzxYNETjRRoHq+Ii+OZsbzJaNUs=
X-Google-Smtp-Source: AGHT+IHzzWw4q0J3Ryexg0e8KCAZ0EqTKw+5YIA07Lb5JR+U0xOxjLC4cX8vNcctMl04h9gQ5huCOg==
X-Received: by 2002:a17:907:7ea2:b0:aa6:7737:1991 with SMTP id
 a640c23a62f3a-ab2ab16a902mr676412566b.2.1736442398058; 
 Thu, 09 Jan 2025 09:06:38 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95b72ebsm87376466b.165.2025.01.09.09.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 09:06:31 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BD1555FC6C;
 Thu,  9 Jan 2025 17:06:20 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 10/22] system: propagate Error to gdbserver_start (and other
 device setups)
Date: Thu,  9 Jan 2025 17:06:07 +0000
Message-Id: <20250109170619.2271193-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109170619.2271193-1-alex.bennee@linaro.org>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This started as a clean-up to properly pass a Error handler to the
gdbserver_start so we could do the right thing for command line and
HMP invocations.

Now that we have cleaned up foreach_device_config_or_exit() in earlier
patches we can further simplify by it by passing &error_fatal instead
of checking the return value. Having a return value is still useful
for HMP though so tweak the return to use a simple bool instead.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

---
v2
  - split some work into pre-cursor patches
---
 include/exec/gdbstub.h |  8 +++++-
 gdbstub/system.c       | 22 ++++++++--------
 gdbstub/user.c         | 20 ++++++++-------
 linux-user/main.c      |  6 +----
 monitor/hmp-cmds.c     |  2 +-
 system/vl.c            | 58 ++++++++++++++++++++----------------------
 6 files changed, 59 insertions(+), 57 deletions(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index d73f424f56..0675b0b646 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -49,12 +49,18 @@ void gdb_unregister_coprocessor_all(CPUState *cpu);
 /**
  * gdbserver_start: start the gdb server
  * @port_or_device: connection spec for gdb
+ * @errp: error handle
  *
  * For CONFIG_USER this is either a tcp port or a path to a fifo. For
  * system emulation you can use a full chardev spec for your gdbserver
  * port.
+ *
+ * The error handle should be either &error_fatal (for start-up) or
+ * &error_warn (for QMP/HMP initiated sessions).
+ *
+ * Returns true when server successfully started.
  */
-int gdbserver_start(const char *port_or_device);
+bool gdbserver_start(const char *port_or_device, Error **errp);
 
 /**
  * gdb_feature_builder_init() - Initialize GDBFeatureBuilder.
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 2d9fdff2fe..8ce79fa88c 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -330,26 +330,27 @@ static void create_processes(GDBState *s)
     gdb_create_default_process(s);
 }
 
-int gdbserver_start(const char *device)
+bool gdbserver_start(const char *device, Error **errp)
 {
     Chardev *chr = NULL;
     Chardev *mon_chr;
     g_autoptr(GString) cs = g_string_new(device);
 
     if (!first_cpu) {
-        error_report("gdbstub: meaningless to attach gdb to a "
-                     "machine without any CPU.");
-        return -1;
+        error_setg(errp, "gdbstub: meaningless to attach gdb to a "
+                   "machine without any CPU.");
+        return false;
     }
 
     if (!gdb_supports_guest_debug()) {
-        error_report("gdbstub: current accelerator doesn't "
-                     "support guest debugging");
-        return -1;
+        error_setg(errp, "gdbstub: current accelerator doesn't "
+                   "support guest debugging");
+        return false;
     }
 
     if (cs->len == 0) {
-        return -1;
+        error_setg(errp, "gdbstub: missing connection string");
+        return false;
     }
 
     trace_gdbstub_op_start(cs->str);
@@ -374,7 +375,8 @@ int gdbserver_start(const char *device)
          */
         chr = qemu_chr_new_noreplay("gdb", cs->str, true, NULL);
         if (!chr) {
-            return -1;
+            error_setg(errp, "gdbstub: couldn't create chardev");
+            return false;
         }
     }
 
@@ -406,7 +408,7 @@ int gdbserver_start(const char *device)
     gdbserver_system_state.mon_chr = mon_chr;
     gdb_syscall_reset();
 
-    return 0;
+    return true;
 }
 
 static void register_types(void)
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 0b4bfa9c48..fb8f6867ea 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -13,6 +13,7 @@
 #include "qemu/bitops.h"
 #include "qemu/cutils.h"
 #include "qemu/sockets.h"
+#include "qapi/error.h"
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
 #include "exec/gdbstub.h"
@@ -372,15 +373,15 @@ static bool gdb_accept_tcp(int gdb_fd)
     return true;
 }
 
-static int gdbserver_open_port(int port)
+static int gdbserver_open_port(int port, Error **errp)
 {
     struct sockaddr_in sockaddr;
     int fd, ret;
 
     fd = socket(PF_INET, SOCK_STREAM, 0);
     if (fd < 0) {
-        perror("socket");
-        return -1;
+        error_setg(errp, "Failed to bind socket: %s", strerror(errno));
+        return false;
     }
     qemu_set_cloexec(fd);
 
@@ -405,31 +406,32 @@ static int gdbserver_open_port(int port)
     return fd;
 }
 
-int gdbserver_start(const char *port_or_path)
+bool gdbserver_start(const char *port_or_path, Error **errp)
 {
     int port = g_ascii_strtoull(port_or_path, NULL, 10);
     int gdb_fd;
 
     if (port > 0) {
-        gdb_fd = gdbserver_open_port(port);
+        gdb_fd = gdbserver_open_port(port, errp);
     } else {
         gdb_fd = gdbserver_open_socket(port_or_path);
     }
 
     if (gdb_fd < 0) {
-        return -1;
+        return false;
     }
 
     if (port > 0 && gdb_accept_tcp(gdb_fd)) {
-        return 0;
+        return true;
     } else if (gdb_accept_socket(gdb_fd)) {
         gdbserver_user_state.socket_path = g_strdup(port_or_path);
-        return 0;
+        return true;
     }
 
     /* gone wrong */
     close(gdb_fd);
-    return -1;
+    error_setg(errp, "gdbstub: failed to accept connection");
+    return false;
 }
 
 void gdbserver_fork_start(void)
diff --git a/linux-user/main.c b/linux-user/main.c
index b97634a32d..7198fa0986 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -1023,11 +1023,7 @@ int main(int argc, char **argv, char **envp)
     target_cpu_copy_regs(env, regs);
 
     if (gdbstub) {
-        if (gdbserver_start(gdbstub) < 0) {
-            fprintf(stderr, "qemu: could not open gdbserver on %s\n",
-                    gdbstub);
-            exit(EXIT_FAILURE);
-        }
+        gdbserver_start(gdbstub, &error_fatal);
         gdb_handlesig(cpu, 0, NULL, NULL, 0);
     }
 
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 80b2e5ff9f..0aa22e1ae2 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -285,7 +285,7 @@ void hmp_gdbserver(Monitor *mon, const QDict *qdict)
         device = "tcp::" DEFAULT_GDBSTUB_PORT;
     }
 
-    if (gdbserver_start(device) < 0) {
+    if (!gdbserver_start(device, &error_warn)) {
         monitor_printf(mon, "Could not open gdbserver on device '%s'\n",
                        device);
     } else if (strcmp(device, "none") == 0) {
diff --git a/system/vl.c b/system/vl.c
index df59cff865..3c96fc957e 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -811,15 +811,15 @@ static void configure_msg(QemuOpts *opts)
 /***********************************************************/
 /* USB devices */
 
-static int usb_parse(const char *cmdline)
+static bool usb_parse(const char *cmdline, Error **errp)
 {
     g_assert(machine_usb(current_machine));
 
     if (!usbdevice_create(cmdline)) {
-        error_report("could not add USB device '%s'", cmdline);
-        return -1;
+        error_setg(errp, "could not add USB device '%s'", cmdline);
+        return false;
     }
-    return 0;
+    return true;
 }
 
 /***********************************************************/
@@ -1298,23 +1298,19 @@ static void add_device_config(int type, const char *cmdline)
  * @type: device_config type
  * @func: device specific config function, returning pass/fail
  *
- * Any failure is fatal and we exit with an error message.
+ * @func is called with the &error_fatal handler so device specific
+ * error messages can be reported on failure.
  */
-static void foreach_device_config_or_exit(int type, int (*func)(const char *cmdline))
+static void foreach_device_config_or_exit(int type, bool (*func)(const char *cmdline, Error **errp))
 {
     struct device_config *conf;
-    int rc;
 
     QTAILQ_FOREACH(conf, &device_configs, next) {
         if (conf->type != type)
             continue;
         loc_push_restore(&conf->loc);
-        rc = func(conf->cmdline);
+        func(conf->cmdline, &error_fatal);
         loc_pop(&conf->loc);
-        if (rc) {
-            error_setg(&error_fatal, "failed to configure: %s", conf->cmdline);
-            exit(1);
-        }
     }
 }
 
@@ -1445,7 +1441,7 @@ static void qemu_create_default_devices(void)
     }
 }
 
-static int serial_parse(const char *devname)
+static bool serial_parse(const char *devname, Error **errp)
 {
     int index = num_serial_hds;
 
@@ -1460,13 +1456,13 @@ static int serial_parse(const char *devname)
 
         serial_hds[index] = qemu_chr_new_mux_mon(label, devname, NULL);
         if (!serial_hds[index]) {
-            error_report("could not connect serial device"
-                         " to character backend '%s'", devname);
-            return -1;
+            error_setg(errp, "could not connect serial device"
+                       " to character backend '%s'", devname);
+            return false;
         }
     }
     num_serial_hds++;
-    return 0;
+    return true;
 }
 
 Chardev *serial_hd(int i)
@@ -1478,44 +1474,44 @@ Chardev *serial_hd(int i)
     return NULL;
 }
 
-static int parallel_parse(const char *devname)
+static bool parallel_parse(const char *devname, Error **errp)
 {
     static int index = 0;
     char label[32];
 
     if (strcmp(devname, "none") == 0)
-        return 0;
+        return true;
     if (index == MAX_PARALLEL_PORTS) {
-        error_report("too many parallel ports");
-        exit(1);
+        error_setg(errp, "too many parallel ports");
+        return false;
     }
     snprintf(label, sizeof(label), "parallel%d", index);
     parallel_hds[index] = qemu_chr_new_mux_mon(label, devname, NULL);
     if (!parallel_hds[index]) {
-        error_report("could not connect parallel device"
-                     " to character backend '%s'", devname);
-        return -1;
+        error_setg(errp, "could not connect parallel device"
+                   " to character backend '%s'", devname);
+        return false;
     }
     index++;
-    return 0;
+    return true;
 }
 
-static int debugcon_parse(const char *devname)
+static bool debugcon_parse(const char *devname, Error **errp)
 {
     QemuOpts *opts;
 
     if (!qemu_chr_new_mux_mon("debugcon", devname, NULL)) {
-        error_report("invalid character backend '%s'", devname);
-        exit(1);
+        error_setg(errp, "invalid character backend '%s'", devname);
+        return false;
     }
     opts = qemu_opts_create(qemu_find_opts("device"), "debugcon", 1, NULL);
     if (!opts) {
-        error_report("already have a debugcon device");
-        exit(1);
+        error_setg(errp, "already have a debugcon device");
+        return false;
     }
     qemu_opt_set(opts, "driver", "isa-debugcon", &error_abort);
     qemu_opt_set(opts, "chardev", "debugcon", &error_abort);
-    return 0;
+    return true;
 }
 
 static gint machine_class_cmp(gconstpointer a, gconstpointer b)
-- 
2.39.5


