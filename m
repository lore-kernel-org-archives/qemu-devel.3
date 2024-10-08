Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C82CED24E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxyuI-0005bQ-2w; Mon, 07 Oct 2024 21:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3nIgEZwUKCv0yf0nulttlqj.htrvjrz-ij0jqstslsz.twl@flex--tavip.bounces.google.com>)
 id 1sxysv-00089N-LA
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:35 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3nIgEZwUKCv0yf0nulttlqj.htrvjrz-ij0jqstslsz.twl@flex--tavip.bounces.google.com>)
 id 1sxyss-0000Cg-1v
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:32 -0400
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2e08c6fd74fso6742404a91.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 18:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728350365; x=1728955165; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=HOp7WmLBwFJSSIU5qqNv1E/gmBAstHCHNzzXu4V4CBY=;
 b=gcV5sD3hgDjDnWMy3BmQm1g9rgsrSLYaaLPiQ13VmiDPVXfnjSQI39+PJS0b2QijWx
 oamPPd5TuH9unpmiNMyeBNJf0fkl4Sg5Ki0Q5cSrMpWl8IH6oskPZSnhNjSw7JJdJf+3
 Phj7ve9b5iydeZb0EgKwGUuQmBYNsI66Wuy5eYGIp2ezkWD/+g9pi6FLMI9zLFkPu0RQ
 HchOV2UhAKWlDaVLVVPEesJY6vSYQQqMYSt2HVguk8U/PW0htF5NHXv/ddaumKmSIFSv
 xcUqZ3O5CTsuJCtqYIZGZ7dg538hKy/hBX/AYWRE9EWTvaaKC7uJqzx3BIdOYe2FraIS
 f7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728350365; x=1728955165;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HOp7WmLBwFJSSIU5qqNv1E/gmBAstHCHNzzXu4V4CBY=;
 b=YDTNy7DKqrPunxYnBB6zpjV/9SFbkPlmCkVmPQJy7tyymIE6DzyKvoAQyqkFpImx4r
 lbn4Ogtwh+z2r+GjBcSW60jtqGaKPxo92N8cl+OH+soAj8j4Qaf6zufty1OBk71hriRE
 JK8Xks05+tMew1srHeaWwokhR6ge2kPwWZvTyBee62w0EE57/eawei45yUgykYt0XveZ
 vYcK1z6g6zP0iEjwSiIs+tXTGV5zglm1uxbxlKSDy3VcqelJLQYvWeLrpFL/DFv5sErx
 bMKVtkHmcuJoRRY5HLVLXtyIZXr02d4x3/t0fe24hcurJkevlyUSqGJpPHVCGVK+twL6
 Ozyg==
X-Gm-Message-State: AOJu0YybfRttPAIdB+sXfbbxR6MfLnFB9CMg91uFAqsyQPaMnWJFxDha
 azj05bwjr7Oye5XtpJV2NYwwekE3VfgM9umgb4xmS/tRgPs9akNCI0tDju43yCrbvlXghK15fJ8
 lvDbepuENoYUKf4JoH+g7j+IYiKV3FG8HPgoDu6CMD92kwLQkqKNwH2pQDmKYLMZfRLG6gdQPMj
 8Sg56CmC5z7g2u3GK8OGYgAYuEbQ==
X-Google-Smtp-Source: AGHT+IFJXWzm9uvmfE9DGIxc/k5/9wTOYabBReC34NNJb04CYptvSM3L/sEK2L2WeiVcgcOnDgOuaxXMJg==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:903:234e:b0:206:96ae:dc30
 with SMTP id
 d9443c01a7336-20bff1c282bmr3551625ad.10.1728350364927; Mon, 07 Oct 2024
 18:19:24 -0700 (PDT)
Date: Mon,  7 Oct 2024 18:18:43 -0700
In-Reply-To: <20241008011852.1439154-1-tavip@google.com>
Mime-Version: 1.0
References: <20241008011852.1439154-1-tavip@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008011852.1439154-18-tavip@google.com>
Subject: [PATCH v2 17/25] tests/qtest: add flexcomm tests
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3nIgEZwUKCv0yf0nulttlqj.htrvjrz-ij0jqstslsz.twl@flex--tavip.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.024,
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

Add flexcomm function selection unit tests.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 tests/qtest/flexcomm-test.c | 82 +++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build     |  1 +
 2 files changed, 83 insertions(+)
 create mode 100644 tests/qtest/flexcomm-test.c

diff --git a/tests/qtest/flexcomm-test.c b/tests/qtest/flexcomm-test.c
new file mode 100644
index 0000000000..ffbee8bfb8
--- /dev/null
+++ b/tests/qtest/flexcomm-test.c
@@ -0,0 +1,82 @@
+/*
+ * Copyright (C) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/main-loop.h"
+#include "exec/memory.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+
+#include "hw/misc/flexcomm.h"
+#include "hw/arm/svd/flexcomm.h"
+#include "hw/arm/svd/rt500.h"
+#include "reg-utils.h"
+
+#define FLEXCOMM_BASE RT500_FLEXCOMM0_BASE
+
+static void select_test(gconstpointer data)
+{
+    static const unsigned persel[] = {
+        FLEXCOMM_PERSEL_USART,
+        FLEXCOMM_PERSEL_SPI,
+        FLEXCOMM_PERSEL_I2C,
+    };
+
+    g_assert(REG32_READ_FIELD(FLEXCOMM, PSELID, PERSEL) == 0);
+
+    /* no register access until a function is selected  */
+    readl_fail(FLEXCOMM_BASE);
+    writel_fail(FLEXCOMM_BASE, 0);
+
+    for (int i = 0; i < ARRAY_SIZE(persel); i++) {
+
+        REG32_WRITE(FLEXCOMM, PSELID, persel[i]);
+        g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM, PSELID, PERSEL), ==,
+                         persel[i]);
+
+        /* test that we can access function registers */
+        writel(FLEXCOMM_BASE, 0xabcd);
+        readl(FLEXCOMM_BASE);
+    }
+
+    /* try to select something invalid */
+    REG32_WRITE(FLEXCOMM, PSELID, 7);
+    /* check for no function selected */
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM, PSELID, PERSEL), ==, 0);
+
+    /* now select and lock USART */
+    REG32_WRITE(FLEXCOMM, PSELID,
+                FIELD_DP32(FLEXCOMM_PERSEL_USART, FLEXCOMM_PSELID, LOCK, 1));
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM, PSELID, PERSEL), ==,
+                     FLEXCOMM_PERSEL_USART);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM, PSELID, LOCK), ==, 1);
+
+    /* try to change the selection to spi */
+    REG32_WRITE(FLEXCOMM, PSELID, FLEXCOMM_PERSEL_SPI);
+    /* it should still be locked USART */
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM, PSELID, PERSEL), ==,
+                     FLEXCOMM_PERSEL_USART);
+    g_assert_cmpuint(REG32_READ_FIELD(FLEXCOMM, PSELID, LOCK), ==, 1);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_data_func("/flexcomm/select", NULL, select_test);
+    qtest_start("-M rt595-evk");
+    ret = g_test_run();
+    qtest_end();
+
+    return ret;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 2b90abf000..f35bb52aa2 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -233,6 +233,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
    config_all_devices.has_key('CONFIG_DM163')? ['dm163-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_FLEXCOMM')? ['flexcomm-test'] : []) + \
   ['arm-cpu-features',
    'boot-serial-test']
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog


