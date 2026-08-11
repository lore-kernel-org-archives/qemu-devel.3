Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43491C5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wteXJ-0005Vj-Fk; Tue, 11 Aug 2026 00:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteXG-0005RX-80
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:22 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteXE-0002ni-8G
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:21 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso3303219a91.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786424179; x=1787028979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VBaWQSdCYE2IBo8s3FoQsypGFeS3hFwdDTP5RAAyi4Q=;
 b=H8okg8O5gvuVoGxExtkN6ftZ9mmAr8vyGbb5Ke0jQBlTUVvj7T3ODVLFpibSPhdGuA
 fp1dnDSPMir3Fn+YqL05Tr17bZmrly6d34cj2JnhVGgBkzYKfa/qCjyZxEc7O/P/msH9
 K7RN1SjmwEPG6Fi5pZWSwA/FiAZrwAEyno2BWbWvkLD7sLCVFNiibNIrAXkTgc09fL4M
 BJk4jBmkyT862qhk6Ks8E7tJ/Cqlzjd3lH25s6l0KHgho1qvFeBeIBlZKwx03griB6SI
 E/x0DA6l+5IFJ0PE7DOxchRfkLhj5gti88a45pssbVlN37HGc17zTg4z3bW8qBn6UAJt
 Tmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786424179; x=1787028979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VBaWQSdCYE2IBo8s3FoQsypGFeS3hFwdDTP5RAAyi4Q=;
 b=ZZDWxWXr4IMdvxnDMcyHPLx25RGYKU7JNY4JyxNwQ1CbrMLFAdFQLZTJnvX+MRcHcT
 5TWnpWsxwXTxs+27yoow5xuQq69hGq32pLvgd/SUsWXo2PR3DOZR8GhcvKi/pcR/tQgT
 0UeJIggaSfrNgcV51nVOavJx6a6omDycBjyJ11obWMstgSBow4N6jG3UA70KHxv6Xme1
 2COGFmxE5UW0xA+gpgl5xIdR9W8mdQNcSW8pJsbw/UuzTg7UZCBRfQY1PsPcRdx8BQz6
 oXKB365ymKo9yAQYeZaLdYcZqOOHj4plERC5W8cUeSfQpk89a1l/iyLzSgs1uFZKxOlQ
 7xLA==
X-Gm-Message-State: AOJu0YwlSN6MS6QrwxYs5XziUBmjKth9ijAfaSKkro6VKrTqCf9AbTLC
 UwZlb1Q9zQm7zV+B0i76mfUglE5wsgW0Pt0/Tu8qLNy54OChY3OI/7BwYT7cx39t2hjyjz7aslV
 fBvOC
X-Gm-Gg: AR+sD12NjKWzY/G1tH3mDF+GgmQavv+BpUlWv1oDoefaBKdJ6i2FBFlx+/2pH61nNzF
 9PCJadpdW70VcksC7g/wDck+ns0Wuhr1JKPHh4bi4QUkSe6dtMPrY79v1XjH4X40WezjptftnIv
 RTa0skmUL5WyzYs4LxfvYCMBNGzI2KBIX+YOdW/OLh4Bd8L4Yl32NBjp2YeLEqH60v8gfe1/gTA
 i5HKC7aHs1ltyeTF2Lj4ApSVq2r6PMjFtRporBCttQopbUjK7YH/IhLG7UKhKFMyisyr6feVsoO
 17jS/TW5UILI6J0IcnpneLM7j7v97H53zMgu/GeSUF87zqV4bmk7mp7ctR3+Vol/aKKBim1vWt1
 ozIRdI8xlPnyvycXefWEf9iF7z082XnnQAz3Si1ma6j/gula6thzr2ZXpRRyCcvR1sHZt6sTb/n
 t5SNeb+rw1q8WUJunMnXB3TNd8UltltZEKiEV8S0t/zV8vsD8yynsIiYW3ThZxoLzu2Ep0EbU3i
 lo7swbHrXd6GHMExJlJ
X-Received: by 2002:a17:90b:2e8b:b0:380:fead:448d with SMTP id
 98e67ed59e1d1-392ec59c644mr762757a91.13.1786424178725; 
 Mon, 10 Aug 2026 21:56:18 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392ee3084d0sm156818a91.8.2026.08.10.21.56.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 21:56:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/16] util/cpuinfo-riscv: Detect Zbkb
Date: Mon, 10 Aug 2026 21:56:02 -0700
Message-ID: <20260811045605.1246543-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811045605.1246543-1-richard.henderson@linaro.org>
References: <20260811045605.1246543-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

RISCV_HWPROBE_EXT_ZBKB was introduced in linux 6.10
with the rest of the hwprobe api.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/riscv64/host/cpuinfo.h |  1 +
 util/cpuinfo-riscv.c                | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/host/include/riscv64/host/cpuinfo.h b/host/include/riscv64/host/cpuinfo.h
index b2b53dbf62..1f047051a3 100644
--- a/host/include/riscv64/host/cpuinfo.h
+++ b/host/include/riscv64/host/cpuinfo.h
@@ -12,6 +12,7 @@
 #define CPUINFO_ZBS             (1u << 3)
 #define CPUINFO_ZICOND          (1u << 4)
 #define CPUINFO_ZVE64X          (1u << 5)
+#define CPUINFO_ZBKB            (1u << 6)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
index 0291b7218a..8c48b1ea91 100644
--- a/util/cpuinfo-riscv.c
+++ b/util/cpuinfo-riscv.c
@@ -36,7 +36,7 @@ static void sigill_handler(int signo, siginfo_t *si, void *data)
 /* Called both as constructor and (possibly) via other constructors. */
 unsigned __attribute__((constructor)) cpuinfo_init(void)
 {
-    unsigned left = CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZBS
+    unsigned left = CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZBS | CPUINFO_ZBKB
                   | CPUINFO_ZICOND | CPUINFO_ZVE64X;
     unsigned info = cpuinfo;
 
@@ -60,6 +60,9 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
 #if defined(__riscv_arch_test) && \
     (defined(__riscv_vector) || defined(__riscv_zve64x))
     info |= CPUINFO_ZVE64X;
+#endif
+#if defined(__riscv_arch_test) && defined(__riscv_zbkb)
+    info |= CPUINFO_ZBKB;
 #endif
     left &= ~info;
 
@@ -76,7 +79,8 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
             info |= pair.value & RISCV_HWPROBE_EXT_ZBA ? CPUINFO_ZBA : 0;
             info |= pair.value & RISCV_HWPROBE_EXT_ZBB ? CPUINFO_ZBB : 0;
             info |= pair.value & RISCV_HWPROBE_EXT_ZBS ? CPUINFO_ZBS : 0;
-            left &= ~(CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZBS);
+            info |= pair.value & RISCV_HWPROBE_EXT_ZBKB ? CPUINFO_ZBKB : 0;
+            left &= ~(CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZBS | CPUINFO_ZBKB);
 #ifdef RISCV_HWPROBE_EXT_ZICOND
             info |= pair.value & RISCV_HWPROBE_EXT_ZICOND ? CPUINFO_ZICOND : 0;
             left &= ~CPUINFO_ZICOND;
@@ -131,6 +135,15 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
             left &= ~CPUINFO_ZBS;
         }
 
+        if (left & CPUINFO_ZBKB) {
+            /* Probe for Zbkb: brev8 zero,zero. */
+            got_sigill = 0;
+            asm volatile(".insn i 0x13, 5, zero, zero, 0x687"
+                         : : : "memory");
+            info |= got_sigill ? 0 : CPUINFO_ZBKB;
+            left &= ~CPUINFO_ZBKB;
+        }
+
         if (left & CPUINFO_ZICOND) {
             /* Probe for Zicond: czero.eqz zero,zero,zero. */
             got_sigill = 0;
-- 
2.43.0


