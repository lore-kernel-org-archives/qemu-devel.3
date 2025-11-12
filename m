Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236A7CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 09:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ74D-0007b5-Ak; Wed, 12 Nov 2025 04:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vJ731-0007DB-Fe
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 04:21:51 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vJ72x-0000KB-B4
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 04:21:50 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42b32ff5d10so289848f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 01:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762939290; x=1763544090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QCmbuzlFctFTuAvlqtwNCWvtyNBdqtOcVTo7CS0tXFs=;
 b=pUfqDScbRue/J434YxWCr9SVCRPJTe2HnoqpLN2VrcFsYEfqNTl4uQf7aveYOZg4hY
 SRZbBRLtpfdFZ0Hs2Wwsh2kpBc8nh46rSIZqK/jws3j2Lcnsc6qFY/kLf5mIx3ac1ZM3
 LfOQopVSkDTL3ZEcejvf20uJuZnwY9xzH+S8kc4t6S62l1GBvrKzs5v7UTDOtj/5FZ4O
 D7fc0o+EbjTXn87Fsgz1PpUslgZZc4a71LcxO26oAa1dHDRaTzq4atf5Jiv1/VAS29kp
 OqlN++36pECHOSCt1v6lRlwhKFWrY8F8LZcdt9aJhrl3rqDOYuZNc50Uyr8CBnbMxadU
 IBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762939290; x=1763544090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QCmbuzlFctFTuAvlqtwNCWvtyNBdqtOcVTo7CS0tXFs=;
 b=Y5hKJK0BZvol1GMDJ2hWdfLxpZDGDts7kY8c3O5e8Vg4kvFZxS80F1ek7GF7znQc7X
 coYpaBRJhNF1B8Mo/9Ehrlzan8j8aw06F9N3xDzBK1JEnrkjFTJlJyO0tRsbPWcEUvVZ
 OE44gCGw8CvfQhMsm6+zE+7/GlcoPtoGNwdx0VPCTGrqkMPFh3wmAgDUWO/CYLZPWGFF
 +DhZ/6Kag7i1EGNwFuWuoSd72DiXbdh59db06E+MSdjTkL81XEb1wfovTrWXSPYkqeU5
 3yICrXVwOAgep72y18XOE5Fa2CWQtuVq025OcCK2f3VBpXfLlPTFWkJCs3THLmpbCmQW
 4PwQ==
X-Gm-Message-State: AOJu0YzxiqygNmW/VVC+UWvjr5s9+73kbi0My1b3+w7DLJfLowu2wxuk
 e1EHSmH0bcHtT0D3A9pbvRyEb11OsGDj4yUeVemn9DGcEJvraQx/z6tfflQpk1JXCJ7QiXDj2fc
 i72Ykz8M=
X-Gm-Gg: ASbGncsZPyFmi8ETSLEnZypgTMjGSl3BU30xxQp050tXUSLvFCXfnr5KIW5o0JEBZMX
 t5795yvJg06Mm9zIdkWdqK7H7oaeLBa5BLo6+gDueNhT1r9kCcTweONouy7DuhXp/frQw7fMR9l
 ClVEoToikzastatoxsXUi68OcYSWh3geia/vO3eAUG0nCzg0WpH7CH6EDT41tkHxP5RaqfS0IqN
 SVggkJ6m+0d4T1Gu+sAZ6qFUP5b/T4UNTB0zgB/D7iWwFY8VCKjOUy8TWFv6ltdpMHbVlmGUwWY
 wKXuepjQaj3pj51MGx/5oTt29wAv2Z/c7COfTa/7Zdc0+kdlsRrhM5uSDyLclk1yMw1JeYru2Kx
 yV8m7ODxtsyeDOBh7nKkdcAGgqBdMku2CDZZluZxC5Dp9Qkr4NPnBA56KXwXhT67lp89taWSyz5
 0O
X-Google-Smtp-Source: AGHT+IHlE57c72CdsAnmOxHaB6SKY7AsVSIJ45fP4I1Pyqu5HNBCrEmRVLOtSWNvjxyMjYHHpqG3ng==
X-Received: by 2002:a05:6000:2891:b0:429:cc39:99c0 with SMTP id
 ffacd0b85a97d-42b4b817244mr1863936f8f.1.1762939290096; 
 Wed, 12 Nov 2025 01:21:30 -0800 (PST)
Received: from jimm-x1.. ([2a10:d582:31e:0:df7:7499:aeed:c296])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42abe62bf35sm32572495f8f.7.2025.11.12.01.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 01:21:29 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH 3/3] tests: Add test for ASID2 and write/read of feature bits
Date: Wed, 12 Nov 2025 09:17:52 +0000
Message-ID: <20251112092048.450090-4-jim.macarthur@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112092048.450090-1-jim.macarthur@linaro.org>
References: <20251112092048.450090-1-jim.macarthur@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x42e.google.com
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

Tests ASID2 is present and FNG1, FNG0, and A2 are writable, and read
value shows the update.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 tests/tcg/aarch64/system/asid2.c | 53 ++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 tests/tcg/aarch64/system/asid2.c

diff --git a/tests/tcg/aarch64/system/asid2.c b/tests/tcg/aarch64/system/asid2.c
new file mode 100644
index 0000000000..53dbdc13cc
--- /dev/null
+++ b/tests/tcg/aarch64/system/asid2.c
@@ -0,0 +1,53 @@
+/*
+ * ASID2 Feature presence and enabled TCR2_EL1 bits test
+ *
+ * Copyright (c) 2025 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
+#include <minilib.h>
+
+#define ID_AA64MMFR4_EL1 "S3_0_C0_C7_4"
+#define TCR2_EL1 "S3_0_C2_C0_3"
+
+int main()
+{
+    /*
+     * Test for presence of ASID2 and three feature bits enabled by it:
+     * https://developer.arm.com/documentation/109697/2025_09/Feature-descriptions/The-Armv9-5-architecture-extension
+     * Bits added are FNG1, FNG0, and A2. These should be RES0 if A2 is
+     * not enabled and read as the written value if A2 is enabled.
+     */
+
+    uint64_t out;
+    uint64_t idreg;
+
+    /* Mask is FNG1, FNG0, and A2 */
+    const uint64_t feature_mask = (1ULL << 18 | 1ULL << 17 | 1ULL << 16);
+    const uint64_t in = feature_mask;
+
+    asm("mrs %[x1], " ID_AA64MMFR4_EL1 "\n\t"
+        : [x1] "=r" (idreg));
+    if ((idreg & 0xF00) == 0x100) {
+        /* ASID2 is enabled */
+    } else {
+        ml_printf("FAIL: ASID2 not present in ID_AA64MMFR4 (%lx)\n", idreg);
+        return 1;
+    }
+
+    asm("msr " TCR2_EL1 ", %[x0]\n\t"
+        "mrs %[x1], " TCR2_EL1 "\n\t"
+        : [x1] "=r" (out)
+        : [x0] "r" (in));
+
+    if ((out & feature_mask) == in) {
+        ml_printf("OK\n");
+        return 0;
+    } else {
+        ml_printf("FAIL: read value %lx != written value %lx\n",
+                  out & feature_mask, in);
+        return 1;
+    }
+}
-- 
2.43.0


