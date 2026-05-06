Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2684AFF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcni-0004pU-AJ; Wed, 06 May 2026 10:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcnW-0004eT-B4
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:00:23 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcnT-0000WI-3Y
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:00:21 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488ad135063so61538535e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076016; x=1778680816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OZc/qj8164mdY6T/5n89bkW8BxCd+kZMWJMjvNjnIUY=;
 b=P8XYSN6igs3uwxcuWujUlFeI9jLtsruTzletm6RzMDE0KxJXYrylhW1CjuzCM0KXVt
 kTBCFiEI23lXOBhdxorVdAOUJfj1S2s4hCiw4K0Ocq5S8FwUsPckJq5UTwJohMcOu30k
 maPn5g05XQL1TB79Wn9FmyudlNgAGpI4JI+b86U2x0A/WZjr8QWt57eV/Y9E3KZgiuCo
 cflixI1ofbmLXSut+sZpSz3jqEmp+tb+SjVcfnmfCNuxJ/yUNtpgjL+NBgCi2PLMX11+
 60oSD+JsEHyt08NXD0dd1grD74zzy4p8oeD3P0LO+F/oFPPLecpFO11TgbYm0bvgu9sM
 vEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076016; x=1778680816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OZc/qj8164mdY6T/5n89bkW8BxCd+kZMWJMjvNjnIUY=;
 b=BOoJ6ZHNuCQmN42ZFgiVWbMNfjUTzZ7jnSIefZxwBTL+5pRzQJLJH2Sevx5M13uViJ
 YD0bAssUR/vcAcm5FeWvV+zcdrRCaB3FTp28/1kIz4k1Hm/OZHPsn5GVTQSbRLX9+tGz
 wcOm+vWe7Xu7bAEotMF4AFoBj6rmsiJUbJfpH/geygrRy6wRRaC8hAksyPlUeEsMMrgc
 c6YxU64NQa6c6aFaZdIEK4XVyr0WuOUg+s26RX+Deem+LQnY+oqk3BfFuFhIyUiD5Eas
 rs/DWKUaPkC1HdxRgGlgobuspGs7mNM1rR3I1kl4+tIu/ZUL/ZCdbkms3cmxvpH6jrYg
 L7jA==
X-Gm-Message-State: AOJu0YxwDqcSFjBGLPhk+lIyKQ707FPKMKUV0OZJs5mAil1OgjW5rVoT
 xXz41Xs7q6WEEWF4/PsPTfa9gjMdUBmZu6xAabTcAgN1x3QD6PVJ7dXhwIkk40reOumtuKlaXdu
 eni6LNVA=
X-Gm-Gg: AeBDieuIDTA0u2ckUWpBfedJz9aNWJ/MJyW3u+GjP6Nq8svITXGASim0KZ5gsie05x8
 55YJ+fwjM11CW1WpvaKIIdp1SBORvJxOg57zSrzwj8EV6NLPdNIWDR7ONkjwBhGgIIMpfkYJvvz
 qOl/++2czsTC0JR0oGaYzUwhg0OkIG8+0GXlg9R0C/aJ1ftkmrqpN5+qoxm5+b9fyoBioNVeZ0R
 L8VoYqDuRyKiCdi0I0aH+BU6ZR5putJ0ClFtnAOX2JuRJkwKMi7cA9eZ7lYzNj7lWtxxFH1T2YZ
 P/8NRrIW4Q1gXdADQbdyHr0UgE1lkED034IYQdVhJuzTjHPifeECBSPaNHiSHtHcXW6tvjNEAlA
 PRr1jv2RGJpdVP5zoMOPqMEV9U9Uzg4qqC6Dm+DHEy/rYTq/5pyhxbXP5R5whSwJlF1Iol1Yf21
 gDK8mL5OYxJPrEN9h2jSN3BwnchYgGEpUMNAC/dHfR0M7IZTQNm3CPfRtlpaGg4UZenXS7NG4uw
 s6SQfD5kQA=
X-Received: by 2002:a05:600c:15d1:b0:48d:112c:f582 with SMTP id
 5b1f17b1804b1-48e51e1e415mr31846455e9.11.1778076015499; 
 Wed, 06 May 2026 07:00:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538acf23sm48307795e9.8.2026.05.06.07.00.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:00:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 038/110] target/mips: Remove unnecessary target_ulong uses in
 LD/ST Multiple
Date: Wed,  6 May 2026 15:54:10 +0200
Message-ID: <20260506135524.20617-39-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

@do_r31 is a boolean, @base_reglist an unsigned size
and @i an unsigned index.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260417035734.32334-3-philmd@linaro.org>
---
 target/mips/tcg/ldst_helper.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index ffe1895706a..0def1f296ae 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -216,13 +216,11 @@ void helper_lwm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
 {
     MemOpIdx oi = memop_idx;
     unsigned mem_idx = get_mmuidx(oi);
-    target_ulong base_reglist = reglist & 0xf;
-    target_ulong do_r31 = reglist & 0x10;
+    unsigned base_reglist = reglist & 0xf;
+    bool do_r31 = reglist & 0x10;
 
     if (base_reglist > 0 && base_reglist <= ARRAY_SIZE(multiple_regs)) {
-        target_ulong i;
-
-        for (i = 0; i < base_reglist; i++) {
+        for (unsigned i = 0; i < base_reglist; i++) {
             env->active_tc.gpr[multiple_regs[i]] =
                 (target_long)cpu_ldl_mmuidx_ra(env, addr, mem_idx, GETPC());
             addr += 4;
@@ -240,13 +238,11 @@ void helper_swm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
 {
     MemOpIdx oi = memop_idx;
     unsigned mem_idx = get_mmuidx(oi);
-    target_ulong base_reglist = reglist & 0xf;
-    target_ulong do_r31 = reglist & 0x10;
+    unsigned base_reglist = reglist & 0xf;
+    bool do_r31 = reglist & 0x10;
 
     if (base_reglist > 0 && base_reglist <= ARRAY_SIZE(multiple_regs)) {
-        target_ulong i;
-
-        for (i = 0; i < base_reglist; i++) {
+        for (unsigned i = 0; i < base_reglist; i++) {
             cpu_stl_mmuidx_ra(env, addr, env->active_tc.gpr[multiple_regs[i]],
                               mem_idx, GETPC());
             addr += 4;
@@ -264,13 +260,11 @@ void helper_ldm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
 {
     MemOpIdx oi = memop_idx;
     unsigned mem_idx = get_mmuidx(oi);
-    target_ulong base_reglist = reglist & 0xf;
-    target_ulong do_r31 = reglist & 0x10;
+    unsigned base_reglist = reglist & 0xf;
+    bool do_r31 = reglist & 0x10;
 
     if (base_reglist > 0 && base_reglist <= ARRAY_SIZE(multiple_regs)) {
-        target_ulong i;
-
-        for (i = 0; i < base_reglist; i++) {
+        for (unsigned i = 0; i < base_reglist; i++) {
             env->active_tc.gpr[multiple_regs[i]] =
                 cpu_ldq_mmuidx_ra(env, addr, mem_idx, GETPC());
             addr += 8;
@@ -288,13 +282,11 @@ void helper_sdm(CPUMIPSState *env, target_ulong addr, target_ulong reglist,
 {
     MemOpIdx oi = memop_idx;
     unsigned mem_idx = get_mmuidx(oi);
-    target_ulong base_reglist = reglist & 0xf;
-    target_ulong do_r31 = reglist & 0x10;
+    unsigned base_reglist = reglist & 0xf;
+    bool do_r31 = reglist & 0x10;
 
     if (base_reglist > 0 && base_reglist <= ARRAY_SIZE(multiple_regs)) {
-        target_ulong i;
-
-        for (i = 0; i < base_reglist; i++) {
+        for (unsigned i = 0; i < base_reglist; i++) {
             cpu_stq_mmuidx_ra(env, addr, env->active_tc.gpr[multiple_regs[i]],
                               mem_idx, GETPC());
             addr += 8;
-- 
2.53.0


