Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACF2CDD553
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 19:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr0HD-0006Xj-1G; Wed, 18 Sep 2024 15:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3vSjrZgUKCvgyf0nulttlqj.htrvjrz-ij0jqstslsz.twl@flex--tavip.bounces.google.com>)
 id 1sr0HB-0006Pm-Aa
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:45 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3vSjrZgUKCvgyf0nulttlqj.htrvjrz-ij0jqstslsz.twl@flex--tavip.bounces.google.com>)
 id 1sr0H9-0007Ra-Jd
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:45 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-7cf58491fe9so7104a12.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 12:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1726687422; x=1727292222; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=UuK6tEDguSgEq4sOmbOCdqmyqurQ/O4ePv8cGHfnsdc=;
 b=aYpUCMDVgxoI6mBrESeIzBFjYKSwRoT+WOxPae/kEC06zTIZecaGyz1sOnUmUeXEAE
 dxlydeamEalKnLgW5yzhzMsLEV6YnXsds0ts7saICHheHGSrmRfTIgwjIsSoPPWaPOg5
 H13h3Q+2nx/cy2PUMds6L7vxJoe4Jd6LajnSoaXEV4N0Q+mUvzamuDfk9NGAHsuvm0Xn
 fgWBITsKHBbbNxxtDx7dr6v9CryO1Mn7B80NLD0fT4qcL1td5ER5OAegi4iKM8GOLu5E
 UwEQ48PHSRZwrHq/qtBtJMQn1jIU3ksHTXo1P6cvFQ52gKR9gX1AIBRXkyIc0tB++kgj
 61Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726687422; x=1727292222;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UuK6tEDguSgEq4sOmbOCdqmyqurQ/O4ePv8cGHfnsdc=;
 b=loBH+GJa4zPAi1JLMIl6YSBmT9PkeQNR0Z/sukvrTbLFZR2gNo78RJKAouRBxZXkiX
 x4qwd2NXlm3WiF9TdWX2r73jGSR3Qj4f1+b2JMn2ngp1Ehbxpxi+U9Dd/Hp7wxrsqtzf
 E+3vtzVr6IywrgjaiMvtEwilCqx36g8u0XG300a7W1Yv6qRyVDJrg4YlaPa4D6Pppv6B
 76/WqGSDFMZ29aVUYCgm0ROiuMVLCDYrudRrJVHeklmpH8Y8tj1170YoVJfFsjNQzEzD
 1sbex8IxdAQ+q76Fl9d+OCh6qROhkahmYO7DN/LCvl+3wp6N3Bz4GGU6cLd39y8TPkPZ
 /LCw==
X-Gm-Message-State: AOJu0Yz36LVrNv+A3T5CCzt8npwUejPVCrg1/YaMXrWWzi7Fom2vcmYE
 mpM7ImJfe6gLTZZHR+P6IZcZmPsyR+tEg8IUB3AKYQxzL2lcOBu+o4M12wUmeJ9k9THFCNP6hoV
 zIr98QZIoQW0eLjBVeERvJ4C7pgGOHNS9LI4pAOhJJep2bS73IPAIluo4bXt2nKqzt7EdQ5905O
 YzwO+gO2rC8Ly9BOWI0FA7Ba8uJQ==
X-Google-Smtp-Source: AGHT+IF/VVcq0q2HFZVgs0XnP3tsz9awQau2u9tqGE/EyDNtIWx67p5un+DCPyjL/VX/cn54XKMhHglZ6Q==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:902:d486:b0:206:a574:b4f1
 with SMTP id
 d9443c01a7336-20782a68cfcmr17873365ad.8.1726687421442; Wed, 18 Sep 2024
 12:23:41 -0700 (PDT)
Date: Wed, 18 Sep 2024 12:22:52 -0700
In-Reply-To: <20240918192254.3136903-1-tavip@google.com>
Mime-Version: 1.0
References: <20240918192254.3136903-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240918192254.3136903-25-tavip@google.com>
Subject: [PATCH 24/25] systems/qtest: add device clock APIs
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3vSjrZgUKCvgyf0nulttlqj.htrvjrz-ij0jqstslsz.twl@flex--tavip.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5, WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

Add qtest APIs to check the device clock frequency.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 include/hw/qdev-clock.h       | 10 +++++++
 tests/qtest/libqtest-single.h | 24 +++++++++++++++++
 tests/qtest/libqtest.h        | 22 +++++++++++++++
 hw/core/qdev-clock.c          |  2 +-
 system/qtest.c                | 51 +++++++++++++++++++++++++++++++++++
 tests/qtest/libqtest.c        | 29 ++++++++++++++++++++
 6 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/include/hw/qdev-clock.h b/include/hw/qdev-clock.h
index ffa0f7ba09..19ed34ae88 100644
--- a/include/hw/qdev-clock.h
+++ b/include/hw/qdev-clock.h
@@ -15,6 +15,7 @@
 #define QDEV_CLOCK_H
 
 #include "hw/clock.h"
+#include "hw/qdev-core.h"
 
 /**
  * qdev_init_clock_in:
@@ -161,4 +162,13 @@ typedef struct ClockPortInitElem ClockPortInitArray[];
  */
 void qdev_init_clocks(DeviceState *dev, const ClockPortInitArray clocks);
 
+/**
+ * qdev_get_clocklist:
+ * @dev: the device to find clock for
+ * @name: clock name
+ *
+ * Returns: a named clock list entry or NULL if the clock was not found
+ */
+NamedClockList *qdev_get_clocklist(DeviceState *dev, const char *name);
+
 #endif /* QDEV_CLOCK_H */
diff --git a/tests/qtest/libqtest-single.h b/tests/qtest/libqtest-single.h
index c22037c8b2..51eb69ff74 100644
--- a/tests/qtest/libqtest-single.h
+++ b/tests/qtest/libqtest-single.h
@@ -408,4 +408,28 @@ static inline int64_t clock_step(int64_t step)
     return qtest_clock_step(global_qtest, step);
 }
 
+/**
+ * qtest_qdev_clock_in_get_hz:
+ * @path: QOM path of a device.
+ * @name: Clock name.
+ *
+ * Returns: device clock frequency in HZ
+ */
+static inline uint64_t dev_clock_in_get_hz(const char *path, const char *name)
+{
+    return qtest_dev_clock_in_get_hz(global_qtest, path, name);
+}
+
+/**
+ * qtest_qdev_clock_out_get_hz:
+ * @path: QOM path of a device.
+ * @name: Clock name.
+ *
+ * Returns: device clock frequency in HZ
+ */
+static inline uint64_t dev_clock_out_get_hz(const char *path, const char *name)
+{
+    return qtest_dev_clock_out_get_hz(global_qtest, path, name);
+}
+
 #endif
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index f9bbeb2e60..cfb7098985 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -1169,4 +1169,26 @@ bool have_qemu_img(void);
  */
 bool mkimg(const char *file, const char *fmt, unsigned size_mb);
 
+/**
+ * qtest_qdev_clock_in_get_hz:
+ * @s: #QTestState instance to operate on.
+ * @path: QOM path of a device.
+ * @name: Clock name.
+ *
+ * Returns: device clock frequency in HZ
+ */
+uint64_t qtest_dev_clock_in_get_hz(QTestState *s, const char *path,
+                                   const char *name);
+
+/**
+ * qtest_qdev_clock_out_get_hz:
+ * @s: #QTestState instance to operate on.
+ * @path: QOM path of a device.
+ * @name: Clock name.
+ *
+ * Returns: device clock frequency in HZ
+ */
+uint64_t qtest_dev_clock_out_get_hz(QTestState *s, const char *path,
+                                    const char *name);
+
 #endif
diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
index 82799577f3..3c9e2d5d73 100644
--- a/hw/core/qdev-clock.c
+++ b/hw/core/qdev-clock.c
@@ -144,7 +144,7 @@ void qdev_init_clocks(DeviceState *dev, const ClockPortInitArray clocks)
     }
 }
 
-static NamedClockList *qdev_get_clocklist(DeviceState *dev, const char *name)
+NamedClockList *qdev_get_clocklist(DeviceState *dev, const char *name)
 {
     NamedClockList *ncl;
 
diff --git a/system/qtest.c b/system/qtest.c
index 95bb80a2bc..465666a416 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -19,6 +19,7 @@
 #include "exec/ioport.h"
 #include "exec/memory.h"
 #include "exec/tswap.h"
+#include "hw/qdev-clock.h"
 #include "hw/qdev-core.h"
 #include "hw/irq.h"
 #include "hw/core/cpu.h"
@@ -245,6 +246,20 @@ static void *qtest_server_send_opaque;
  *
  * Forcibly set the given interrupt pin to the given level.
  *
+ * Device clock frequency
+ * """"""""""""""""""""""
+ *
+ * .. code-block:: none
+ *
+ *  > qdev_clock_out_get_hz QOM-PATH CLOCK-NAME
+ *  < OK HZ
+ *
+ * .. code-block:: none
+ *
+ *  > qdev_clock_in_get_hz QOM-PATH CLOCK-NAME
+ *  < OK HZ
+ *
+ * where HZ is the clock frequency in hertz.
  */
 
 static int hex2nib(char ch)
@@ -758,6 +773,42 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         qtest_send_prefix(chr);
         qtest_sendf(chr, "OK %"PRIi64"\n",
                     (int64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+    } else if (strcmp(words[0], "qdev_clock_in_get_hz") == 0 ||
+               strcmp(words[0], "qdev_clock_out_get_hz") == 0) {
+        bool is_outbound = words[0][11] == 'o';
+        DeviceState *dev;
+        NamedClockList *ncl;
+
+        g_assert(words[1]);
+        g_assert(words[2]);
+
+        dev = DEVICE(object_resolve_path(words[1], NULL));
+        if (!dev) {
+            qtest_send_prefix(chr);
+            qtest_send(chr, "FAIL Unknown device\n");
+            return;
+        }
+
+        ncl = qdev_get_clocklist(dev, words[2]);
+        if (!ncl) {
+            qtest_send_prefix(chr);
+            qtest_send(chr, "FAIL Unknown clock\n");
+            return;
+        }
+
+        if (is_outbound && !ncl->output) {
+            qtest_send_prefix(chr);
+            qtest_send(chr, "FAIL Not an output clock\n");
+            return;
+        }
+
+        if (!is_outbound && ncl->output) {
+            qtest_send_prefix(chr);
+            qtest_send(chr, "FAIL Not an input clock\n");
+            return;
+        }
+
+        qtest_sendf(chr, "OK %u\n", clock_get_hz(ncl->clock));
     } else if (process_command_cb && process_command_cb(chr, words)) {
         /* Command got consumed by the callback handler */
     } else {
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 4055d6b953..cc11b5f42e 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -2065,3 +2065,32 @@ bool mkimg(const char *file, const char *fmt, unsigned size_mb)
 
     return ret && !err;
 }
+
+static uint64_t qtest_dev_clock_get_hz(QTestState *s, const char *path,
+                                       const char *name, bool out)
+{
+    gchar **args;
+    int ret;
+    uint64_t value;
+
+    qtest_sendf(s, "qdev_clock_%s_get_hz %s %s\n", out ? "out" : "in",
+                path, name);
+    args = qtest_rsp_args(s, 2);
+    ret = qemu_strtou64(args[1], NULL, 0, &value);
+    g_assert(!ret);
+    g_strfreev(args);
+
+    return value;
+}
+
+uint64_t qtest_dev_clock_out_get_hz(QTestState *s, const char *path,
+                                    const char *name)
+{
+    return qtest_dev_clock_get_hz(s, path, name, true);
+}
+
+uint64_t qtest_dev_clock_in_get_hz(QTestState *s, const char *path,
+                                   const char *name)
+{
+    return qtest_dev_clock_get_hz(s, path, name, false);
+}
-- 
2.46.0.662.g92d0881bb0-goog


