Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB88DC52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 06:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sipyW-0005Md-Nz; Tue, 27 Aug 2024 02:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3NnbNZgUKCpUIzK7E5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--tavip.bounces.google.com>)
 id 1sipyI-00048s-D0
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:46:31 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3NnbNZgUKCpUIzK7E5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--tavip.bounces.google.com>)
 id 1sipyE-0006CR-LA
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:46:30 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-e178e745c49so7095093276.2
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 23:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1724741174; x=1725345974; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=hjj5euhaeBWVKURTA/20dijhmsqMuqw8o1St7aOFqYA=;
 b=nar7oE+U8dx0VWNi7uOsfDTC/j9GB3f34SREOhb716+rSi4ZjBCpkAY+O1271xUiwg
 tweiFmbWkA/UMYO4VzY1amjcydUdAk7ndGVR1jJF8fSd0LetLqnTuw94jg/j0YQbTI/M
 kOB31PtG4Ln8wEMA/TVteI8XH1hBM5QEw4OdddsmxDRwi9jtljpeT+QoklpDP6N4jVSo
 t60nUHZOEKJ69SNasE4Mvdkz2j5j3JU1Zq65j9N4XBnNJChjb5Ftjc3U6b9B5k7/6JUz
 AFWdKzfKlvkmBeHXQ9+h4K9FAXFd4EyStbgLEfl7QL7Bs2qusHHpo9kzr1dZWC9vKxiJ
 ttPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724741174; x=1725345974;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hjj5euhaeBWVKURTA/20dijhmsqMuqw8o1St7aOFqYA=;
 b=jkH391xt5UGTqiD8T7xtG5fWUCmOmYSbZUQYNlB6CPVsIGTjgRdDZTUOdXGdZgM4DV
 wCaQKJqEOthdtX7lhToLY8IkLU7ck+GeYuWBQ+cT4Wtrjgy2YGFLFUne2y0IF1j/HTmv
 Amoytsay3oVlZ5loEgtGmBSkAtEGeqCU9qcxSv8vm6Gxe4TNhUW6XcGXT53//MC6H58O
 M3Ljr/iN/jqSyvPgZlb6NKTcJKJwghEHLBPghBwqFbhaQNyyHrGhWd9x823reo+yVSQo
 PerSCdLg9sIEBc60fM3y9kSiel4lCG+aloYOGaS4IR8vHuDSbLm29cfLsuccs7prZzNg
 gwig==
X-Gm-Message-State: AOJu0YzFtq/FUkTzsdj2+uqpLQbgWhX27e8HgURV4986FtaOUS9OE8p7
 IqkzzxtfuousExuG7B2e6tdxDLTyFsz3eghvq4tb7abnTDEayK6NBtOljee6R9AOFexpzD1D36y
 /EjzzTN5LhrBlvJ03IUzunkbdxklhXG+4waK3iyBdqKO+0jBaBa+tLChiLDN/z7ogTFLg5XJgyI
 +rVABWpMwJN0Sy01PoRRkHTPCoMQ==
X-Google-Smtp-Source: AGHT+IEYpEp8GxaKx2wwZtNXRLSgHgQElG9BNkWnWXX8lkrzuquUllqAM96QN/n2yjXcm8Pdw1KiKtOOQA==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a25:ab32:0:b0:e11:cd91:a3e2 with
 SMTP id
 3f1490d57ef6-e17a86675a8mr23521276.10.1724741174106; Mon, 26 Aug 2024
 23:46:14 -0700 (PDT)
Date: Mon, 26 Aug 2024 23:45:27 -0700
In-Reply-To: <20240827064529.1246786-1-tavip@google.com>
Mime-Version: 1.0
References: <20240827064529.1246786-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827064529.1246786-24-tavip@google.com>
Subject: [RFC PATCH v3 23/24] systems/qtest: add device clock APIs
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3NnbNZgUKCpUIzK7E5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--tavip.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: tavip <tavip@warp10.c.googlers.com>
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
index 9057d019c6..d1069e233a 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -1161,4 +1161,26 @@ bool have_qemu_img(void);
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
index da46388a6e..0ce4dd7898 100644
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
@@ -789,6 +804,42 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
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
index 62ba49d5d8..68291ce721 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1979,3 +1979,32 @@ bool mkimg(const char *file, const char *fmt, unsigned size_mb)
 
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
2.46.0.295.g3b9ea8a38a-goog


