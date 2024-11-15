Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4324CD68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBzX0-0007vv-4y; Fri, 15 Nov 2024 11:50:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBzWx-0007uv-MD
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:50:48 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBzWw-0003ai-1o
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:50:47 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4315baa51d8so7531785e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 08:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731689444; x=1732294244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EKGJo6RL8JtSuOntPAnWTBPQ2/3pgYHRUszkLKiPvPw=;
 b=rjEaBllrSSJmMJ+DLd7Y5lOdA9GXP2K97OKvoQsu4s8cl4kDZonuxkasr5ieGuVQ5p
 zNXtfUygGvBLPY/MVqWVMHnQ65neBcO3gZUXBOYQSIWiAdAlFPrUTSOzmvarmxwG+08P
 ws8/mn2bUrA5QnsmUpIt87D2tVSTPaBi/QaaKd8mtN1U0+2ZjAnKEAV/s8cf3QZerkXh
 m48HZcRfuOTfp3B0PVbMt9FEUTp004pR6YV3Yc0zxv5F5JiSUUZJ0aU97p8fp4OZYUqN
 3+4cnkBFrvLxk7fihl43hWiFJkpVm48NHolbHKIvLVvsEkRFw5LKYVCOo/DHXi5LBc1l
 nkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731689444; x=1732294244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EKGJo6RL8JtSuOntPAnWTBPQ2/3pgYHRUszkLKiPvPw=;
 b=opfIdM/bBbumUb+yENdSsz4pyMS73+eQIkwS5Nti4UHd8+DNFQPcgsAbgusXlneEPh
 rxuzugyD1RDf3B06IjttKHUdB0KMw3xGSLRxerqZgWT8YHTXMwwWKOuIgJWn5t1FObWM
 GFvX8eJ1KQwVih1rnpsFNhzzK8THZNxhEu1xIbUcd9pOkhXDq2X4JUam2nSLVfcDp0vA
 OIP0Wauy+egVgllDrltgq0xXQMCohkz9f+vgXIrnl4e6dvNH2muonx8TxMu16spyiBor
 tG0gAs2ycJddtXZ9XazHAHcYnvcimuA3+DrL66Fd2XMxyYGZQeCTlM4I1UZGPRmuJxL/
 jYoA==
X-Gm-Message-State: AOJu0YyDEqgYxV2LSod+oJjgMyu6SFXTKDMBt6AWgQSRPR57fSvo9+US
 VbBVRr/axy+0aE5XqUuOgujvxO6iSN7K4wT/licgxTRj3coUpgqTtGiBqrgt56DHM9RJLEDuDL8
 f
X-Google-Smtp-Source: AGHT+IGNQMEGZ2dAEuSPnD2h5Q/zRWVKinQgSAb6NuUEiDyfAorc+LarszXBxeFm5Lcg0OvGQ06p3Q==
X-Received: by 2002:a05:600c:1d0a:b0:42c:acb0:dda5 with SMTP id
 5b1f17b1804b1-432df7179e0mr22855475e9.1.1731689443970; 
 Fri, 15 Nov 2024 08:50:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac0aef0sm60386405e9.28.2024.11.15.08.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 08:50:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Roque Arcudia Hernandez <roqueh@google.com>
Subject: [PATCH 1/3] tests/qtest: Add qtest_system_reset() utility function
Date: Fri, 15 Nov 2024 16:50:39 +0000
Message-Id: <20241115165041.1148095-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115165041.1148095-1-peter.maydell@linaro.org>
References: <20241115165041.1148095-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

We have several qtest tests which want to reset the QEMU under test
during the course of testing something.  They currently generally
have their own functions to do this, which work by sending a
"system_reset" QMP command.  However, "system_reset" only requests a
reset, and many of the tests which send the QMP command forget the
"and then wait for the QMP RESET event" part which is needed to
ensure that the reset has completed.

Provide a qtest_system_reset() function in libqtest so that
we don't need to reimplement this in multiple different tests.

A few tests (for example device hotplug related tests) want to
perform the reset command and then wait for some other event that is
produced during the reset sequence.  For them we provide
qtest_system_reset_nowait() so they can clearly indicate that they
are deliberately not waiting for the RESET event.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/libqtest.h | 25 +++++++++++++++++++++++++
 tests/qtest/libqtest.c | 16 ++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index beb96b18ebd..f23d80e9e5e 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -88,6 +88,31 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
  */
 QTestState *qtest_init_with_serial(const char *extra_args, int *sock_fd);
 
+/**
+ * qtest_system_reset:
+ * @s: #QTestState instance to operate on.
+ *
+ * Send a "system_reset" command to the QEMU under test, and wait for
+ * the reset to complete before returning.
+ */
+void qtest_system_reset(QTestState *s);
+
+/**
+ * qtest_system_reset_nowait:
+ * @s: #QTestState instance to operate on.
+ *
+ * Send a "system_reset" command to the QEMU under test, but do not
+ * wait for the reset to complete before returning. The caller is
+ * responsible for waiting for either the RESET event or some other
+ * event of interest to them before proceeding.
+ *
+ * This function should only be used if you're specifically testing
+ * for some other event; in that case you can't use qtest_system_reset()
+ * because it will read and discard any other QMP events that arrive
+ * before the RESET event.
+ */
+void qtest_system_reset_nowait(QTestState *s);
+
 /**
  * qtest_wait_qemu:
  * @s: #QTestState instance to operate on.
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 817fd7aac52..8de5f1fde30 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -215,6 +215,22 @@ static void qtest_check_status(QTestState *s)
 #endif
 }
 
+void qtest_system_reset_nowait(QTestState *s)
+{
+    /* Request the system reset, but do not wait for it to complete */
+    qtest_qmp_assert_success(s, "{'execute': 'system_reset' }");
+}
+
+void qtest_system_reset(QTestState *s)
+{
+    qtest_system_reset_nowait(s);
+    /*
+     * Wait for the RESET event, which is sent once the system reset
+     * has actually completed.
+     */
+    qtest_qmp_eventwait(s, "RESET");
+}
+
 void qtest_wait_qemu(QTestState *s)
 {
     if (s->qemu_pid != -1) {
-- 
2.34.1


