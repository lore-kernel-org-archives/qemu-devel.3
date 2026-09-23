Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941B6C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Tgm-0008Hy-2Q; Wed, 23 Sep 2026 16:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tg4-00089e-Uz
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:55 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tg3-000501-1H
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:52 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-85469a34908so963822b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 13:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790195690; x=1790800490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MnLKuFltvc/Rg1zMvwUFOIX89Pj2+SfPG/1M0nyAyh0=;
 b=BMyeARjRoHCfyC59pWyR5zay2eYuGMfw4H++JxZgLh33o7ORfPCeQn+AnxmrGCTcGF
 WE7xtNvQDkbmDIIgb169pgAsWi09KJPtEhKuKY0m5Ya2NeNHsGuHkCeZwwNsjajO4Gd7
 FGfHARwaZj3IC0nqXchwADO3o3sdToaQmZrrBB6uEnZK4gibopUsZ6i/2CjmIPqszLAl
 AK8qctcnje1oum1jN4RDZSleecVShhKp236iCA4l5uqA6qIYmmfAYLCSOcxKURAj8B9z
 3ddjYmNYnnj27iDg2IjwXY20BSle7MGQAo/HQOgHmYUMUyTynEy3dISNvnYsMg8VcEus
 c8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790195690; x=1790800490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MnLKuFltvc/Rg1zMvwUFOIX89Pj2+SfPG/1M0nyAyh0=;
 b=s4F5gTGOMWxAbTLRGHO2wTOTqzGZP6ALTogRpN3p4cFHjHt8FhjC95sTtrX5x1wqn/
 p9KCGAtiraHBEtMhK2P3kIzT5LnMi1oTpO2p7xFdlfuawAxl9m956KssIqRKoBfSAlTn
 n60IEVoLAI5NBINhVpOMkCN5lRrWcfcGfAbFD+/761dKZQoY0i0w2fYq+3+545vi2keq
 RJS79Pww6vMU5jsCbMJhJmWTZw1qr+J9ZrKESOiAghNVuKWgS8V+H5xgK2n+Ubl+qMlA
 PylR/sG5ASWt8Gzffmt0Zj4Usi3kAvlNRPz7ZfUcCv1zlxeWBpMCBCDNDCqs03dlxg2I
 elNw==
X-Gm-Message-State: AFuF++kTazmGJG9tGNvAwqFHO9fVwevwujMJBrxHnUH94c5NBUD2hnfx
 SRmL1rPzQujWiqe1Mo5YR472Lv8Zd4r6d5pOhxCL4McOXNalj6HLq0ECv2laMRYb/3wxKzdsl66
 WV0rp
X-Gm-Gg: AYBFou2VXOSpe398Q9azv8uJMGsB3ZE1r7zxdbqXLBVHa0qLwligKdsWgdGm9i0806F
 EI41ys3osZ64DX+HRH0c/adTYXX5K/DTQQvd6c7vdVdK84k19KSB+v69ZaNMhzvUIWE/IMsq2me
 hmdYhN4s+A3g56mBdl4caAzVaQXkECkWhXT5plftKmfmW1OkMTXCsx/CnMr66VOlMIe/WMHqzda
 avCiJ/P28SYTGb+dL5RsTjeOLGM7o69pzFxpMrTUThKPlKJdS2Asf7exV0hJys6LVPSY7OJh5Oy
 DYBmjaJykEf/Ra6J8AEpmSvZ+pg8oqn9E6P5P7YySmDtuEsxcpWIyheF1qjvBtOfk0dsUOUSuvM
 CmtcUH1y09Gm1A7q1FfYY2PzN0YOfMiP2AmsDrsRq/Ijzzh/TyI6v8CaWbcFY6MlE5R0g1k8p1d
 Hj3tA27OgYAndJdBo4suYD/8UeoF71jKIn0AdwU3HGyQujOTK0IbpLbK4dDR2j139lx6AjgecMH
 nokEbhzZMhKRSEC40ldMVCKN9MoAHje4YnxX+rC
X-Received: by 2002:a05:6a00:808a:b0:848:62ab:7b7 with SMTP id
 d2e1a72fcca58-87e9ea63d38mr222600b3a.16.1790195689501; 
 Wed, 23 Sep 2026 13:34:49 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d3894211asm1678638b3a.36.2026.09.23.13.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:34:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PULL 07/16] tests/tcg/arm: Add regression test for #4448
Date: Wed, 23 Sep 2026 13:34:32 -0700
Message-ID: <20260923203441.31276-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923203441.31276-1-richard.henderson@linaro.org>
References: <20260923203441.31276-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/arm/issue4448.c | 51 +++++++++++++++++++++++++++++++++++++++
 tests/tcg/arm/meson.build |  1 +
 2 files changed, 52 insertions(+)
 create mode 100644 tests/tcg/arm/issue4448.c

diff --git a/tests/tcg/arm/issue4448.c b/tests/tcg/arm/issue4448.c
new file mode 100644
index 00000000000..0a498373a89
--- /dev/null
+++ b/tests/tcg/arm/issue4448.c
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <assert.h>
+#include <stdint.h>
+
+/* Signed 64-bit product, constant operand first then second. */
+#define SMULL_CONST_LHS(k, x, lo, hi) \
+    __asm__("mov r0, #" #k "\n\tsmull %0, %1, r0, %2" \
+            : "=&r"(lo), "=&r"(hi) : "r"(x) : "r0", "cc")
+
+#define SMULL_CONST_RHS(k, x, lo, hi) \
+    __asm__("mov r0, #" #k "\n\tsmull %0, %1, %2, r0" \
+            : "=&r"(lo), "=&r"(hi) : "r"(x) : "r0", "cc")
+
+/* Unsigned 64-bit product, for contrast: this one is folded correctly. */
+#define UMULL_CONST_LHS(k, x, lo, hi) \
+    __asm__("mov r0, #" #k "\n\tumull %0, %1, r0, %2" \
+            : "=&r"(lo), "=&r"(hi) : "r"(x) : "r0", "cc")
+
+static int64_t s64(int32_t hi, int32_t lo)
+{
+    return ((int64_t)hi << 32) | (uint32_t)lo;
+}
+
+static uint64_t u64(int32_t hi, int32_t lo)
+{
+    return ((uint64_t)(uint32_t)hi << 32) | (uint32_t)lo;
+}
+
+int main(void)
+{
+    static const int32_t values[] = { 1961612, -1479053948, -7, 0 };
+
+    for (unsigned i = 0; i < sizeof(values) / sizeof(values[0]); i++) {
+        int32_t x = values[i];
+        int32_t lo, hi;
+
+        SMULL_CONST_LHS(1, x, lo, hi);
+        assert(x == s64(hi, lo));
+
+        SMULL_CONST_RHS(1, x, lo, hi);
+        assert(x == s64(hi, lo));
+
+        UMULL_CONST_LHS(1, x, lo, hi);
+        assert((uint32_t)x == u64(hi, lo));
+
+        SMULL_CONST_LHS(0, x, lo, hi);
+        assert(0 == u64(hi, lo));
+    }
+    return 0;
+}
diff --git a/tests/tcg/arm/meson.build b/tests/tcg/arm/meson.build
index 1b491cea026..5c2af2189c5 100644
--- a/tests/tcg/arm/meson.build
+++ b/tests/tcg/arm/meson.build
@@ -39,6 +39,7 @@ tests += {
     'expected_output': 'fcvt.ref',
   },
   'pcalign-a32.c': {'cflags': ['-marm']},
+  'issue4448.c': {},
 }
 
 # Vector SHA1
-- 
2.53.0


