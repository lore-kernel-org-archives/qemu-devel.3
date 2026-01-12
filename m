Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30519CF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQlq-0002xK-7U; Mon, 12 Jan 2026 17:52:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQlc-0002dq-NU
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:52:10 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQlb-0003BV-9Z
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:52:08 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43246af170aso3285660f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258325; x=1768863125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DTUInP/Tt1Z3d3UClrx1aZRKEsn1LBWbAENhuifa1Fw=;
 b=GFwwOfaRTwTfEbYL362qlgRK8TNLA4h0hXkbnAj6+JFMHJ/GNXjFJC84p0P7mv3VLm
 dDapxABg6WeoJTg5KwqCIDKfPDOIIC67Mtgiewe/gjFsF3cUgHPNVRxTIhE5l5hkDTnp
 u1vPc60DKxC4tvJlZdZBbE5GgqudJ3Sb4/FUQ513Klc/DpreVhiy9pHfeV173Sskvl7v
 4EAiElIktoHanf0zMrhPy8A5VZzZdGwK5GMRIsyOqrNbF9zgYgjSnRw6YboybIo0XciN
 6Hh02T9bbvgOo/CxzrTFJlurA3fwlFu6aMoMeNMOh2naHwExlL6/Yp7JztXPFD7feX5p
 PB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258325; x=1768863125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DTUInP/Tt1Z3d3UClrx1aZRKEsn1LBWbAENhuifa1Fw=;
 b=Rklc9xrY/PJayuVMvRqv+vEpl9bHF04IEfm3WpnRBGzb6csut2ezystvEYpdNZfTy5
 RBWvuQXftJBLMRxD2/gNomW4GnkelW/KWZF8lJ4rX/HU/E81p5i078be5ZLMdt+CS1cJ
 nSY1P5iNLAtjAUnjLtI2O/R7i8nWyjR5InivV0yIylPax7sEHIoSqcS4sxBHW9gnkMu1
 YFKwfGXRciQXEuWpe/r8dmyiLGWr6jUFio3aEXNg3zfxA1zN63w4nO58chJQ3ulae23y
 T3xkhrsU/XLxdjO1PpIg9scXgmPtlYmSAJrMxBlXp6NdLWG8FTxOWfaf8+ajszatF8wM
 FNIA==
X-Gm-Message-State: AOJu0YyorByha5xIzLJGDaF4EG/zcAKhNdCxI1PazeF7qEUd1Ir8A//u
 R1lNLgX5cvCTxfpAvKu3HRp+qkMijQwlMaB5LwSR0b0hoJHXzz93emfje7lA4zRqGuZnFrM5Xgt
 DZeoerHU=
X-Gm-Gg: AY/fxX4+2D+SLuHkEJD3ZQz+/IlriTf8wUav4Dk9xYVlowUXP1x3eiBn3X8RgYuUtbA
 Z4eXjTHLTxqnYPgXLZ8CmuZ1GGUn3GxUhtcUsigkJmPYxFtj1EUQdzv0YtMkYEshZohL87xW0U/
 ASMYBCXJh7rlxr2wJV8E6MACY/yD4/gyymNSKJfLOUwLgL401lGrjDTE5vhIJdzFRpbfmu1Zzw/
 GEq5S8leV6mL7PsRzY4xclOqK7ThPQa60IrgIiK/lUJcOIqf66+8ktGifJmjBnUNPF33kg3JlvM
 NfURoiLpvRJ9q5YRbJ0n5gWGPdjglXjShrwJR2A4D2hPQR/pobBkhfMroCndzpEK4Aas+Ovj1AH
 Jkx7glz5SZdXS/v5VA8iid7ZdenAAqv61ssXJJbaDck555l1jxuGuhUC08uq+rKef6SkogIei0u
 /DxOHv5D0TypTtYIu4LW1tE+PrqpyB3PgY+NpnEEqWXdjgqv+KImk3XDEpq3Ub
X-Google-Smtp-Source: AGHT+IFLhWjiW/9sY8zIwOlx8kPq8I0aEaSOzolUX1F/wmTOhtKHuyrduwv2swrY+MCqj4r2cbWTrQ==
X-Received: by 2002:a05:6000:4012:b0:431:327:5dd6 with SMTP id
 ffacd0b85a97d-43423e7dff5mr1089985f8f.8.1768258325230; 
 Mon, 12 Jan 2026 14:52:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ff0b2sm40657253f8f.42.2026.01.12.14.52.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:52:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/61] target/loongarch: Use hwaddr type for physical addresses
Date: Mon, 12 Jan 2026 23:48:22 +0100
Message-ID: <20260112224857.42068-28-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Replace variables used with get_physical_address(), which
expect a physical addresses, by the 'hwaddr' type, instead
of the 'target_ulong' one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-ID: <20251224161456.89707-4-philmd@linaro.org>
---
 target/loongarch/cpu_helper.c     | 2 +-
 target/loongarch/tcg/tlb_helper.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 4864f4d6d87..2b27274f64e 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -146,7 +146,7 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
                      int access_type, int mmu_idx, int debug)
 {
     CPUState *cs = env_cpu(env);
-    target_ulong index = 0, phys = 0;
+    hwaddr index = 0, phys = 0;
     uint64_t dir_base, dir_width;
     uint64_t base, pte;
     int level;
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 873a0a1b0c4..aab89b9be19 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -691,7 +691,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
 {
     CPUState *cs = env_cpu(env);
     uint64_t badvaddr;
-    target_ulong index, phys;
+    hwaddr index, phys;
     uint64_t dir_base, dir_width;
 
     if (unlikely((level == 0) || (level > 4))) {
@@ -726,7 +726,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
                   uint32_t mem_idx)
 {
     CPUState *cs = env_cpu(env);
-    target_ulong phys, tmp0, ptindex, ptoffset0, ptoffset1;
+    hwaddr phys, tmp0, ptindex, ptoffset0, ptoffset1;
     uint64_t badv;
     uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
     uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
-- 
2.52.0


