Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BE1F46C72
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 18:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9oek-0007Rw-Gw; Mon, 06 Apr 2026 14:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oeZ-0007MB-V0
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:28 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oeY-0002Mo-2j
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:27 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c76864f4e58so1604964a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 11:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775499985; x=1776104785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bpOML7tmZexsHhxO8SKUFq6iYscD6sM9NhAFa5aVm2s=;
 b=suCTVRiiCxPbISISfmgoXDYr2MKyjPJNzl9Vdbm4FQTgkOnQMWzqjmu3mTjg9uFeP7
 JfQzAxpr2Mzw3zmeFVD+2IKp9YsWeI5ZCi7+ywU000Dx0F4SOSzXbD/hYTC+nTIQcMoE
 ZStvcrx5t4dJVAdGbLrQ3/rKnTrYe5I1paQquUwXShFRv1o4OI+6kHHUWKkAx6teP+La
 PjeIA/qB27dLqoeaOX6LZm8OZ4t3VW0bOqetuliBmY3VLORdX669RVZ9s//Z+B+r+7mo
 LbNPU4fJnYJFoq14siHFtFDAmbIpOxU+SbrJDsisT/ztBls3eGKs6I5vPOT1oguWqZ53
 CSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775499985; x=1776104785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bpOML7tmZexsHhxO8SKUFq6iYscD6sM9NhAFa5aVm2s=;
 b=o/kM8n2hzF0RFtiJvjDPXchqVitxtScH8mgcYiRybW7m0Ywz3xFwOYYPo+d9Lv5ETE
 PDGoq91GAgHS2GtefHtr1BP/Wa7uM5tZW718D3yVviXxfXG9XfBz5UM8WTh8lcsnWz9I
 TIJesGg+gGA6VZoSlENJCwAa9icUvImhyc5CyW5/X2WvpvoRVfa+tamFmidc1yzYlrwO
 T2moKVwR2V3jfwMSO8vW5zx1QhJCOXxCouCc6/116AIkpMM4erze1r5WxvW8V07hPdvK
 /YR5/75wvZO6pFfcfqshkMOh72JjIIxLajF19UbYtEmHiePEz5D/Av1aWa7pm0z5wPgj
 kBXg==
X-Gm-Message-State: AOJu0YwS3MZXerEwSgkrLN5itIdB8AbAFnL6h25MUQVgXnlP3kU3SKdR
 Ju5YO94fktYT8W+Xja8CL41v8sd/zBu++K0zK8+lIAvPWOG8s0EhbNcGbiFKiU8SxpC0G//HcE0
 voJCV5Cw25A==
X-Gm-Gg: AeBDiet9Duwy5SizTGpjpcppcSFkeEhJZRwjq9vLGsKiWjkbDQXao9OAoIUzmTXOQ/U
 wTuVL6cPsbJ0SzQh5fgUBFI6yNfpqAarTVuo5zS/7J1NXONx8DB0OZODhpi8m4mVI3fnQbDNgOa
 /joHCjQIqF/waPTAZCjctStCCn37ICb7sk+J/nVKTuK+Fc/P/QjezvtwrzGxkrF+eHF5YvmT1/p
 P3aodGwg604tRNRChKMMsAPA/YJaMfZyJxyPTw+/kvOMxcyScVUlqdNhDfBTUjonlHv9g2Puvxx
 McvMGf7eoI6HsJ/a9RtX4ds2+CjRP8+CGjHLe6mAAkre4+Og27o2Bd+eqY5QZF8QZgBiqYiNSWx
 o22RNL3i7LFovcpZWcM+Q0GwOcaEegEJvzI0ZQCcyDh+2vjMytKWsMt7I9HbF93jx2IejqEVWHP
 4JqKi5jjHL7+GLP2QEo0l69fJlrsC6IA1+gcMh4axXF51h+D+nNmE97swiGjnGgx9d8ZcPXvP/e
 h4S
X-Received: by 2002:a05:6300:210e:b0:398:a3e5:d04b with SMTP id
 adf61e73a8af0-39f2f19e176mr13080592637.33.1775499984571; 
 Mon, 06 Apr 2026 11:26:24 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6561fe9sm12765080a12.15.2026.04.06.11.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 11:26:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-arm@nongnu.org
Subject: [PATCH v8 07/20] target/arm/tcg/translate-mve.c: make compilation
 unit common
Date: Mon,  6 Apr 2026 11:25:56 -0700
Message-ID: <20260406182609.193886-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
References: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 8d9112f6da2..89c3b476822 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -16,9 +16,10 @@ neon_d = [
   decodetree.process('neon-ls.decode', extra_args: '--decode=disas_neon_ls'),
 ]
 
+mve_d = decodetree.process('mve.decode', extra_args: '--decode=disas_mve')
+
 gen_a32 = [
   decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp'),
-  decodetree.process('mve.decode', extra_args: '--decode=disas_mve'),
   decodetree.process('a32.decode', extra_args: '--static-decode=disas_a32'),
   decodetree.process('a32-uncond.decode', extra_args: '--static-decode=disas_a32_uncond'),
   decodetree.process('t32.decode', extra_args: '--static-decode=disas_t32'),
@@ -34,7 +35,6 @@ arm_ss.add(files(
   'gengvec.c',
   'translate.c',
   'translate-m-nocp.c',
-  'translate-mve.c',
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
@@ -65,6 +65,7 @@ arm_common_ss.add(files(
 ))
 
 arm_common_system_ss.add(
+  mve_d,
   neon_d,
   vfp_d,
   files(
@@ -75,12 +76,14 @@ arm_common_system_ss.add(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
   'vec_helper.c',
   'vfp_helper.c',
 ))
 arm_user_ss.add(
+  mve_d,
   neon_d,
   vfp_d,
   files(
@@ -88,6 +91,7 @@ arm_user_ss.add(
   'hflags.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
   'vec_helper.c',
-- 
2.47.3


