Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A967CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CrF-0000Yt-RW; Fri, 10 Oct 2025 09:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cqt-00089Z-67
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:08:08 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cpj-00044O-QE
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:08:05 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-421851bca51so1275487f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101610; x=1760706410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iDU1xy3z9pv7QWtUV0PajmdrAHQUAe2qx4ObhYEQ1ZU=;
 b=Qoltn6nOozclJivXOM1B0n8DoagBQN42NNngjJW7bYgP7i4aJ70po68AXHXS8UwVMe
 iDaxlEkeu0fcP/i1tBYrL6582jfIKHmXokvVajnZfOlfw6Fdv638Gn6pVrDWf4zsz5Vn
 /DqoF7gwpLbDA98fnvEmhiFWCZqhEGPIe8hppDqlEwG/BFoBHKBF1ymClST6M67n2X25
 aCl+Cp67YLF1i7iHi4RsER3uV8UIYXSINykfL7sF1kFzhafIAc3F2H9iME2L3TfsTDlH
 Kvv9C/8XWVBSb8LQm8+Ko+NfFWvlFM68qoW6chMbAIP1YHJUTM9aLjrSYZai6jCyMs56
 wKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101610; x=1760706410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iDU1xy3z9pv7QWtUV0PajmdrAHQUAe2qx4ObhYEQ1ZU=;
 b=nW6y0wf1hjwRG91rqW1Ra2PgmcLSSWqwNaT1rD3joIovNCuAyMNWi8X0lk2cI+Qsh1
 T8AZX8ucyFklOnAyhDfRAUrYRsj8QQnk8BYRYPlxYJl6VjXlG8t63GH+uViqVo5seBOm
 s2CuDSaTEMMnCtbizKzIKFzolUrP2ANqa1WEBbxJta0qYf5zo9W1N5Qka0cQj1b8ChT+
 mPV6YOQyqqy5TZexQCySeiZaV2BWxLPy99uykbQqF7qlO0WqvlsR+VE58Sr5vRTnfmIM
 6iTJedRgbn0z/hVZUTrSCS3Ptah4+wwHCuCciJk/MuDlLGlpvtU7iitEYE5bzSX3zQ20
 WzVg==
X-Gm-Message-State: AOJu0YwgjrFdKFBVLbff0MBFSTLKUicwj5rRsbf7/pBa8mfEH/fIpvP8
 v0OcbWnYbW5ZLvRHUUMGls/AVwDc2SjWrGH0m/nXZ19ugv1oZIipLO4aMbeHaEPTFuodJddW8L6
 Il+JV
X-Gm-Gg: ASbGncssyKee3t84U+Z6YTe0NNiYPP+jviNUMwX0i3knxwXlfZldF6w5Y4Iht12o3Ap
 wJf+pwJ8mbdIOu5wqyMzad1sTElHM27w06QKrwp/+q3o4k5kkPD2voYJNHGoN25j7oZcyWrYKT5
 8G8N4QjEiim9FOAMxjQOG4C2S20uAdtpxFnBcTgEpB6Y8XSMwUzzNcrPLyexm3Qx8WNjjVu0hE4
 FEU+hnL5vk24BSrm4YOQM5f1Pf6POMMcwlgSO/hqhzDxSzmQDagx2J/vlpj4vNvBtWlXCgJZ+ob
 D6vcWhtvpUGzqCsoPHW29+w33T6XU8g/Q1v80YL0dVFZU9kNZK94RISJ51PajCJg01FuwZhrbXB
 P0zibi5ZTnmFTx28aK3dpvR7S7KzNB/rSDx4Ux5qbNBgt+elHx5DPkq6kcPJaJA==
X-Google-Smtp-Source: AGHT+IEKFLzxAcOwXRd1KKHBYTqFvVgxrASmkZyrxr+jY21wQrXZ/JicWeU132YsP0PboPM5k7mALQ==
X-Received: by 2002:a05:6000:178a:b0:3da:d015:bf84 with SMTP id
 ffacd0b85a97d-42666ac72e7mr7470435f8f.25.1760101609876; 
 Fri, 10 Oct 2025 06:06:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 73/76] tests/tcg/aarch64: Add gcsss
Date: Fri, 10 Oct 2025 14:05:24 +0100
Message-ID: <20251010130527.3921602-74-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Validate stack switching and recursion depth.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-74-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/gcs.h           |  9 ++++
 tests/tcg/aarch64/gcsss.c         | 74 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  2 +-
 3 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/gcsss.c

diff --git a/tests/tcg/aarch64/gcs.h b/tests/tcg/aarch64/gcs.h
index 770cde6a85a..6f013d0f1e0 100644
--- a/tests/tcg/aarch64/gcs.h
+++ b/tests/tcg/aarch64/gcs.h
@@ -69,3 +69,12 @@
 
 #define gcspr() \
     ({ uint64_t *r; asm volatile("mrs %0, s3_3_c2_c5_1" : "=r"(r)); r; })
+
+#define gcsss1(val) \
+    do {                                                                     \
+        asm volatile("sys #3, c7, c7, #2, %0" : : "r"(val) : "memory");      \
+    } while (0)
+
+#define gcsss2() \
+    ({ uint64_t *r;                                                          \
+       asm volatile("sysl %0, #3, c7, c7, #3" : "=r"(r) : : "memory"); r; })
diff --git a/tests/tcg/aarch64/gcsss.c b/tests/tcg/aarch64/gcsss.c
new file mode 100644
index 00000000000..9550c68e7e7
--- /dev/null
+++ b/tests/tcg/aarch64/gcsss.c
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "gcs.h"
+
+#define IN_PROGRESS(X)  ((uint64_t)(X) | 5)
+#define CAP(X)          (((uint64_t)(X) & ~0xfff) + 1)
+
+static uint64_t * __attribute__((noinline)) recurse(size_t index)
+{
+    if (index == 0) {
+        return gcspr();
+    }
+    return recurse(index - 1);
+}
+
+int main()
+{
+    void *tmp;
+    uint64_t *alt_stack, *alt_cap;
+    uint64_t *orig_pr, *orig_cap;
+    uint64_t *bottom;
+    size_t pagesize = getpagesize();
+    size_t words;
+
+    enable_gcs(0);
+    orig_pr = gcspr();
+
+    /* Allocate a guard page before and after. */
+    tmp = mmap(0, 3 * pagesize, PROT_NONE, MAP_ANON | MAP_PRIVATE, -1, 0);
+    assert(tmp != MAP_FAILED);
+
+    /* map_shadow_stack won't replace existing mappings */
+    munmap(tmp + pagesize, pagesize);
+
+    /* Allocate a new stack between the guards. */
+    alt_stack = (uint64_t *)
+        syscall(__NR_map_shadow_stack, tmp + pagesize, pagesize,
+                SHADOW_STACK_SET_TOKEN);
+    assert(alt_stack == tmp + pagesize);
+
+    words = pagesize / 8;
+    alt_cap = alt_stack + words - 1;
+
+    /* SHADOW_STACK_SET_TOKEN set the cap. */
+    assert(*alt_cap == CAP(alt_cap));
+
+    /* Swap to the alt stack, one step at a time. */
+    gcsss1(alt_cap);
+
+    assert(gcspr() == alt_cap);
+    assert(*alt_cap == IN_PROGRESS(orig_pr));
+
+    orig_cap = gcsss2();
+
+    assert(orig_cap == orig_pr - 1);
+    assert(*orig_cap == CAP(orig_cap));
+    assert(gcspr() == alt_stack + words);
+
+    /* We should be able to use the whole stack. */
+    bottom = recurse(words - 1);
+    assert(bottom == alt_stack);
+
+    /* We should be back where we started. */
+    assert(gcspr() == alt_stack + words);
+
+    /* Swap back to the original stack. */
+    gcsss1(orig_cap);
+    tmp = gcsss2();
+
+    assert(gcspr() == orig_pr);
+    assert(tmp == alt_cap);
+
+    exit(0);
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index fddb7bc9cdc..55ce34e45ee 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -76,7 +76,7 @@ $(SME_TESTS): CFLAGS += $(CROSS_AS_HAS_ARMV9_SME)
 endif
 
 # GCS Tests
-GCS_TESTS += gcsstr gcspushm
+GCS_TESTS += gcsstr gcspushm gcsss
 AARCH64_TESTS += $(GCS_TESTS)
 $(GCS_TESTS): gcs.h
 
-- 
2.43.0


