Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DC1D46611
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSVT-0000kF-O9; Thu, 15 Jan 2026 13:55:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSV6-0000dI-Rh
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:20 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSV3-0005sr-CM
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:19 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-432d2670932so1027880f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503314; x=1769108114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MZSrvEIlk9r04onLNJkYuSgINfXXG+Ma+gvj4K7ywbE=;
 b=fkcDbNSUT6VYUFehoj2jqmYjEQw1aRsiGXFE0b56KX1DMAcY0zurowWZ+Sbl7J+cYM
 U9onx6AU4/0kU0D/ForlrvxtvwmE1aHHuTVuBcVxWQcZ8/jtmtdA2Ds7nl8fcMb1SWpm
 GNLKnyfRg2hL2ztPC8EzcY2fe158mGacuLmEmKL4PRmSkVDXXGmyQ9YEgSXNqIr0axcD
 qPm4rr1UlWYCedL2UVEU3EC7RaDsq17v5IP6MGn9y6vuc+4yMRPKfaTWQiwwo9RWzIoU
 Knm5YIhfFYMrer91408AcrirPBryY2InCUPplQaG9FL8suQRg0I3DWjwX+srBq2/1LQs
 Uuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503314; x=1769108114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MZSrvEIlk9r04onLNJkYuSgINfXXG+Ma+gvj4K7ywbE=;
 b=rqoCeI0+p47j5JSfVBAkUaXayW9zeVydWe2SiNxS+9U8K6R1fq2mTReGEOwFh8CMm9
 1zvmsYq8djFhibNU/MAbppRgCuvT/OWbL2ZLanokQwfyXAlytL6mW/S4n1+yv1GWCbNL
 5LYrHhH34bNBagfSwegJwVLxsA1h2U8xjvpfAN+7Pct+lFERCO3ewIw0s4hKtKVsPINr
 oWSk0sURn4elS4NY2wVBQG0Pqtc1HPRnE6ahY0Bc2O/xMDOYas87inh4OUZ0Xce6/2qD
 jXtr0dUwZe+/LYgRObj+ZKQ+EN/6j4fUymyhgehga3WVUYyFHnDY2Lv7wSJxjaY0zh6f
 1cXA==
X-Gm-Message-State: AOJu0YxIv7c7TvU9kPejRgHlcNIMkdvAxmZXSV257yH8/VtAWZxhvIyM
 qN7dRQaewn7Ydu5t5b79BUN0vKUrkUkARRpYcWfOnCxHOQFrwvyLsfuviMUsBASXlx+WlEMnE9q
 IcFZX
X-Gm-Gg: AY/fxX5HCDGMU40vEBM1+Ykf0+k3TXSeoGeo20pSppBo0FWDvdTRhmiFq7nRsxJBkxp
 fbCp6zXkXCG2ZZ5K57u+JAzVutWjlFeF4Wu+nXLrFdzocyJyA/5bn2Pp7tTfCVZY6pbB1b7VVQo
 YRg5bV6xm+mVZ/kZacMi4Z4RAh/Ndgq0mPe2aOiYJzP2h7QeWLCmqliesabWgNJst6HeZBP449V
 fWT06nerXtbrvL0+z0pbz/sNisOSiiayRk9m+OLdPX7fhpAtVCH2QXB0X6zwa3myGET+P9nuXtk
 1vAOFd580EAIAW29DuVxHDwvaVW7tXxshvL3cqUQz8yyNvkK8zHANMTLZEj69jsvatL9bC2cf1t
 qJ1UcLGahlFZk/biY35xXMFZ7QzNZET9b0a2wndKqzlYy8I/vl0oMkLDfCm7pI68CqCKc/j3bYV
 PpsaS+7FGQJhQlDELF7DG3ODO3L2vbOCyh+T4CfoZw1ygo+qEU4n4Kplpqxiv8dDDzh9sW61hXv
 xoTIv9mWD9WjoohO+7tY8vvrddhWhB/E3O7iS2Ib6g+Zw==
X-Received: by 2002:a05:6000:2910:b0:42f:b3b9:874d with SMTP id
 ffacd0b85a97d-43569bc4a81mr456484f8f.37.1768503313727; 
 Thu, 15 Jan 2026 10:55:13 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/25] tests: Add test for ASID2 and write/read of feature bits
Date: Thu, 15 Jan 2026 18:54:47 +0000
Message-ID: <20260115185508.786428-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
References: <20260115185508.786428-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jim MacArthur <jim.macarthur@linaro.org>

Test for presence of ASID2; if it is, check FNG1, FNG0, and A2 are
writable, and read value shows the update. If not present, check these
read as RES0.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/system/asid2.c | 76 ++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 tests/tcg/aarch64/system/asid2.c

diff --git a/tests/tcg/aarch64/system/asid2.c b/tests/tcg/aarch64/system/asid2.c
new file mode 100644
index 0000000000..7d5466af34
--- /dev/null
+++ b/tests/tcg/aarch64/system/asid2.c
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ * ASID2 Feature presence and enabled TCR2_EL1 bits test
+ *
+ * Copyright (c) 2025 Linaro Ltd
+ *
+ */
+
+#include <stdint.h>
+#include <minilib.h>
+
+#define ID_AA64MMFR3_EL1 "S3_0_C0_C7_3"
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
+    uint64_t idreg3;
+    uint64_t idreg4;
+    int tcr2_present;
+    int asid2_present;
+
+    /* Mask is FNG1, FNG0, and A2 */
+    const uint64_t feature_mask = (1ULL << 18 | 1ULL << 17 | 1ULL << 16);
+    const uint64_t in = feature_mask;
+
+    asm("mrs %[idreg3], " ID_AA64MMFR3_EL1 "\n\t"
+        : [idreg3] "=r" (idreg3));
+
+    tcr2_present = ((idreg3 & 0xF) != 0);
+
+    if (!tcr2_present) {
+        ml_printf("TCR2 is not present, cannot perform test");
+        return 0;
+    }
+
+    asm("mrs %[idreg4], " ID_AA64MMFR4_EL1 "\n\t"
+        : [idreg4] "=r" (idreg4));
+
+    asid2_present = ((idreg4 & 0xF00) != 0);
+
+    asm("msr " TCR2_EL1 ", %[x0]\n\t"
+        "mrs %[x1], " TCR2_EL1 "\n\t"
+        : [x1] "=r" (out)
+        : [x0] "r" (in));
+
+    if (asid2_present) {
+        if ((out & feature_mask) == in) {
+            ml_printf("OK\n");
+            return 0;
+        } else {
+            ml_printf("FAIL: ASID2 present, but read value %lx != "
+                      "written value %lx\n",
+                      out & feature_mask, in);
+            return 1;
+        }
+    } else {
+        if (out == 0) {
+            ml_printf("TCR2_EL1 reads as RES0 as expected\n");
+            return 0;
+        } else {
+            ml_printf("FAIL: ASID2, missing but read value %lx != 0\n",
+                      out & feature_mask, in);
+            return 1;
+        }
+    }
+}
-- 
2.47.3


