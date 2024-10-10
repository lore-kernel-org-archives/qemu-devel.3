Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B5BCFC5E9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 17:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syx8d-0002AP-Ky; Thu, 10 Oct 2024 13:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3UxEIZwUKCtQJ0L8F6EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--tavip.bounces.google.com>)
 id 1syx8T-00028M-KF
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 13:39:38 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3UxEIZwUKCtQJ0L8F6EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--tavip.bounces.google.com>)
 id 1syx8R-0004nL-GH
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 13:39:37 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-71df5102bc0so1266065b3a.0
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 10:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728581973; x=1729186773; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KyL3Gv7dnqr3mFoxSkQFDIJynBhVVlfMkibVKt5vHvc=;
 b=XnHLYSbfUctFbaZlSqDMkbntp5lMIJEMN55z5OJ8FYAJrmaP+2pRNZgaJYVs9K4F7f
 D+XCYUmVKsyQV6NJV2hPqbSpiM6qCI29Sd5Y6v5mUublmCDA78R1YteLgvYvMFaDeDIG
 RINrfOSM4VzNcnnVv/9ItFyT5skLJWqB7S49fCEOanmKf91l6koSJIFduVjMAMMdaKzB
 DrpbxRiJ3Wwkl3WM9kUk/LdGNRnwxOe9+L4Ne4DPFWviMTd7ec68TTFfvuY5goXhai9A
 J8TmCzY7nrqCKGGjodDxTDHgte6QG78+cTevv/8Uss8acPLpvdQrTN3g8D6lMhOaf/o6
 cWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728581973; x=1729186773;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KyL3Gv7dnqr3mFoxSkQFDIJynBhVVlfMkibVKt5vHvc=;
 b=DbMq8wKoGDPkYhixjHGXC15F2BT/bh7ScpBBGy4iAPuyzmJayLUhE2uVV1qnF3W9Oi
 suJXc0oVPDmvjaz2oc0PbPB02YwXODOxCSszvA2qSScCLO3JQRmCe5eOwC5dZfeW74aD
 X0vxI3Y8f+QDbwCG0XRxqYY8DzQ0eZXhHeuhK5qPlDLt0ue2r0QZ6vJT7SZgATKn+dVj
 zNp9lAnio5Q+MsViNiVxoePWrRD7Mh/Tlf3FwaWIzBxA4w22pE2SzHu78cTA+DYrh+tS
 5t6bcynlisM5hUN/PF437m8yNs4xVi9S+TzWBFMTb/dHapS2xAcBgsJdsjg7QKS3ovfz
 LuYQ==
X-Gm-Message-State: AOJu0YxU+nptmIRNaR02q3qMBg1w3MmeURnaGm2xReiXCTNPkcy4Uf1D
 6IEJ6jofSSsX6IJysYKxXXu+JCsq8RNHf+dWPvqTIBhYibaSH/7fIo9IIrgFYNa90dfX9hKSVEP
 EC99rsPSgGkBv8Z7WXecrAhbMRk35WuuB1z65mExYt4wEAcI3fw9EllQT0pfFW0i8pTauvSs58l
 T1CJs+idc9NMQVOF2ihkVmy/782Q==
X-Google-Smtp-Source: AGHT+IG2+yDRYIN5nW5obWOBaTRdcCVx/2/phak85gGgF5zolUJXnq5GHFBx04AXcyE4SIJSDxxWHUutdQ==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:6a00:2d8a:b0:71d:fc7c:4a34
 with SMTP id
 d2e1a72fcca58-71e1dbff219mr24014b3a.6.1728581971486; Thu, 10 Oct 2024
 10:39:31 -0700 (PDT)
Date: Thu, 10 Oct 2024 10:39:29 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010173929.3910466-1-tavip@google.com>
Subject: [RFC PATCH] cli: add connect-gpios option
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3UxEIZwUKCtQJ0L8F6EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--tavip.bounces.google.com;
 helo=mail-pf1-x449.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.023,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: Valentin Ghita <valentinghita@google.com>

Add option to allow for connecting device GPIOs. This is useful when
adding a peripheral device from the command line which uses an
interrupt.

It takes the following options:

* in-dev-path, out-dev-path - required, the device canonical object
  path (e.g. /machine/peripheral-anon/device[0],
  /machine/iotkit/cluster0/armv7m0) for the devices that should have
  their in <-> out GPIOs connected

* in-gpio-name, out-gpio-name - optional, the name of the GPIO list;
  if not specified, the unnamed GPIO list is used

* in-gpio-index, out-gpio-index - optional, the index in the GPIO list
  that identifies the GPIO to be used; if not specified 0 (the first
  GPIO in the list) is used

Usage example:

 # add the tmp105 sensor and connects its irq line to the CPU
 qemu-system-arm \
  --machine mps2-an505 \
  --device tmp105,bus=/versatile_i2c/i2c,address=0x50 \
  --connect-gpios out-dev-path=/machine/peripheral-anon/device[0],\
    in-dev-path=/machine/iotkit/cluster0/armv7m0,in-gpio-index=100

Signed-off-by: Valentin Ghita <valentinghita@google.com>
[tavip: pass device path, gpio name and gpio index as explicit
options, use --connect-gpios instead of --connect-pins, use
object_resolve_path instead of custom search based on qbus_find]
Signed-off-by: Octavian Purdila <tavip@google.com>
---
 include/monitor/qdev.h  |   3 ++
 include/sysemu/sysemu.h |   1 +
 monitor/qmp-cmds.c      |   3 ++
 system/qdev-monitor.c   | 103 ++++++++++++++++++++++++++++++++++++++++
 system/vl.c             |  24 ++++++++++
 qemu-options.hx         |  31 ++++++++++++
 6 files changed, 165 insertions(+)

diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
index 1d57bf6577..dc05b70146 100644
--- a/include/monitor/qdev.h
+++ b/include/monitor/qdev.h
@@ -6,6 +6,7 @@
 void hmp_info_qtree(Monitor *mon, const QDict *qdict);
 void hmp_info_qdm(Monitor *mon, const QDict *qdict);
 void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp);
+void qmp_connect_gpios(QDict *qdict, QObject **ret_data, Error **errp);
 
 int qdev_device_help(QemuOpts *opts);
 DeviceState *qdev_device_add(QemuOpts *opts, Error **errp);
@@ -36,4 +37,6 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
  */
 const char *qdev_set_id(DeviceState *dev, char *id, Error **errp);
 
+int qdev_connect_gpios(QemuOpts *opts, Error **errp);
+
 #endif
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 5b4397eeb8..66c5f5129e 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -106,6 +106,7 @@ extern QemuOptsList qemu_drive_opts;
 extern QemuOptsList bdrv_runtime_opts;
 extern QemuOptsList qemu_chardev_opts;
 extern QemuOptsList qemu_device_opts;
+extern QemuOptsList qemu_connect_gpios_opts;
 extern QemuOptsList qemu_netdev_opts;
 extern QemuOptsList qemu_nic_opts;
 extern QemuOptsList qemu_net_opts;
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index f84a0dc523..3333598a5b 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -203,6 +203,9 @@ static void __attribute__((__constructor__)) monitor_init_qmp_commands(void)
     qmp_register_command(&qmp_commands, "device_add",
                          qmp_device_add, 0, 0);
 
+    qmp_register_command(&qmp_commands, "connect_gpios",
+                         qmp_connect_gpios, 0, 0);
+
     QTAILQ_INIT(&qmp_cap_negotiation_commands);
     qmp_register_command(&qmp_cap_negotiation_commands, "qmp_capabilities",
                          qmp_marshal_qmp_capabilities,
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 44994ea0e1..16d417610a 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -735,6 +735,68 @@ err_del_dev:
     return NULL;
 }
 
+static DeviceState *qdev_from_opt(QemuOpts *opts, const char *name,
+                                  Error **errp)
+{
+    Object *obj;
+    const char *path = qemu_opt_get(opts, name);
+
+    if (!path) {
+        error_setg(errp, QERR_MISSING_PARAMETER, name);
+        return NULL;
+    }
+
+    obj = object_resolve_path(path, NULL);
+    if (!obj) {
+        error_setg(errp, "Could not resolve path: %s", path);
+        return NULL;
+    }
+
+    if (!object_dynamic_cast(obj, TYPE_DEVICE)) {
+        error_setg(errp, "%s is not a device", path);
+        return NULL;
+    }
+
+    return DEVICE(obj);
+}
+
+int qdev_connect_gpios(QemuOpts *opts, Error **errp)
+{
+    qemu_irq in_irq;
+    const char *in_gpio_name, *out_gpio_name;
+    int in_gpio_idx = 0, out_gpio_idx = 0;
+    DeviceState *dev;
+
+    dev = qdev_from_opt(opts, "in-dev-path", errp);
+    if (!dev) {
+        return -1;
+    }
+
+    in_gpio_name = qemu_opt_get(opts, "in-gpio-name");
+    out_gpio_name = qemu_opt_get(opts, "out-gpio-name");
+    in_gpio_idx = qemu_opt_get_number(opts, "out-gpio-index", 0);
+    out_gpio_idx = qemu_opt_get_number(opts, "out-gpio-index", 0);
+
+    if (in_gpio_name) {
+        in_irq = qdev_get_gpio_in_named(dev, in_gpio_name, in_gpio_idx);
+    } else {
+        in_irq = qdev_get_gpio_in(dev, in_gpio_idx);
+    }
+
+    dev = qdev_from_opt(opts, "out-dev-path", errp);
+    if (!dev) {
+        return -1;
+    }
+
+    if (out_gpio_name) {
+        qdev_connect_gpio_out_named(dev, out_gpio_name, out_gpio_idx, in_irq);
+    } else {
+        qdev_connect_gpio_out(dev, out_gpio_idx, in_irq);
+    }
+
+    return 0;
+}
+
 /* Takes ownership of @opts on success */
 DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
 {
@@ -885,6 +947,20 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
     object_unref(OBJECT(dev));
 }
 
+void qmp_connect_gpios(QDict *qdict, QObject **ret_data, Error **errp)
+{
+    QemuOpts *opts;
+
+    opts = qemu_opts_from_qdict(qemu_find_opts("connect-gpios"), qdict, errp);
+    if (!opts) {
+        return;
+    }
+
+    qdev_connect_gpios(opts, errp);
+
+    qemu_opts_del(opts);
+}
+
 static DeviceState *find_device_state(const char *id, Error **errp)
 {
     Object *obj = object_resolve_path_at(qdev_get_peripheral(), id);
@@ -1102,6 +1178,33 @@ QemuOptsList qemu_device_opts = {
     },
 };
 
+QemuOptsList qemu_connect_gpios_opts = {
+    .name = "connect-gpios",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_connect_gpios_opts.head),
+    .desc = {
+        {
+            .name = "in-dev-path",
+            .type = QEMU_OPT_STRING,
+        },{
+            .name = "in-gpio-name",
+            .type = QEMU_OPT_STRING,
+        },{
+            .name = "in-gpio-index",
+            .type = QEMU_OPT_NUMBER,
+        },{
+            .name = "out-dev-path",
+            .type = QEMU_OPT_STRING,
+        },{
+            .name = "out-gpio-name",
+            .type = QEMU_OPT_STRING,
+        },{
+            .name = "out-gpio-index",
+            .type = QEMU_OPT_NUMBER,
+        },
+        { /* end of list */ }
+    },
+};
+
 QemuOptsList qemu_global_opts = {
     .name = "global",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_global_opts.head),
diff --git a/system/vl.c b/system/vl.c
index fe547ca47c..c36562fbeb 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1222,6 +1222,19 @@ static int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
     return 0;
 }
 
+static int connect_gpios_func(void *opaque, QemuOpts *opts, Error **errp)
+{
+    int err;
+
+    err = qdev_connect_gpios(opts, errp);
+    if (err != 0 && *errp) {
+        error_report_err(*errp);
+        return err;
+    }
+
+    return 0;
+}
+
 static int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
     Error *local_err = NULL;
@@ -2665,6 +2678,10 @@ static void qemu_create_cli_devices(void)
         object_unref(OBJECT(dev));
         loc_pop(&opt->loc);
     }
+
+    qemu_opts_foreach(qemu_find_opts("connect-gpios"),
+                      connect_gpios_func, NULL, &error_fatal);
+
     rom_reset_order_override();
 }
 
@@ -2765,6 +2782,7 @@ void qemu_init(int argc, char **argv)
     qemu_add_drive_opts(&bdrv_runtime_opts);
     qemu_add_opts(&qemu_chardev_opts);
     qemu_add_opts(&qemu_device_opts);
+    qemu_add_opts(&qemu_connect_gpios_opts);
     qemu_add_opts(&qemu_netdev_opts);
     qemu_add_opts(&qemu_nic_opts);
     qemu_add_opts(&qemu_net_opts);
@@ -3373,6 +3391,12 @@ void qemu_init(int argc, char **argv)
                     }
                 }
                 break;
+            case QEMU_OPTION_connect_gpios:
+                if (!qemu_opts_parse_noisily(qemu_find_opts("connect-gpios"),
+                                             optarg, false)) {
+                    exit(1);
+                }
+                break;
             case QEMU_OPTION_smp:
                 machine_parse_property_opt(qemu_find_opts("smp-opts"),
                                            "smp", optarg);
diff --git a/qemu-options.hx b/qemu-options.hx
index 20a1ce0d43..011aa66569 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1187,6 +1187,37 @@ SRST
 
 ERST
 
+DEF("connect-gpios", HAS_ARG, QEMU_OPTION_connect_gpios,
+    "-connect-gpios in-dev-path=path,out-dev-path=path[,in-gpio-name=name][,out-gpio-name=name][,in-gpio-index=index][,out-gpio-index=index]\n"
+    "                connect an input and an output gpio.\n",
+    QEMU_ARCH_ALL)
+SRST
+``-connect-gpios in-dev-path=path,out-dev-path=path[,in-gpio-name=name][,out-gpio-name=name][,in-gpio-index=index][,out-gpio-index=index]``
+    Connect an input and an output gpio.
+
+    ``in-dev-path``, ``out-dev-path`` required, the device canonical
+        object path (e.g. /machine/peripheral-anon/device[0],
+        /machine/iotkit/cluster0/armv7m0) for the devices that should
+        have their in <-> out GPIOs connected
+
+    ``in-gpio-name``, ``out-gpio-name`` optional, the name of the GPIO list;
+      if not specified, the unnamed GPIO list is used
+
+    ``in-gpio-index``, ``out-gpio-index`` optional, the index in the GPIO list
+      that identifies the GPIO to be used; if not specified 0 (the first
+      GPIO in the list) is used
+
+    Examples:
+
+    .. parsed-literal::
+
+        # add the tmp105 sensor and connects its irq line to the CPU
+        qemu-system-arm \\
+         --machine mps2-an505 \\
+         --device tmp105,bus=/versatile_i2c/i2c,address=0x50 \\
+         --connect-gpios out-dev-path=/machine/peripheral-anon/device[0],in-dev-path=/machine/iotkit/cluster0/armv7m0,in-gpio-index=100
+ERST
+
 DEF("name", HAS_ARG, QEMU_OPTION_name,
     "-name string1[,process=string2][,debug-threads=on|off]\n"
     "                set the name of the guest\n"
-- 
2.47.0.rc1.288.g06298d1525-goog


