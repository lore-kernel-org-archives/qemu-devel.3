Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C725B10FCACC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 19:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8184-0006dw-Cf; Wed, 01 Apr 2026 15:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w817p-0006Ti-2A
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:21:14 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w817m-0002zX-9k
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:21:12 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35d965648a2so59240a91.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 12:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775071269; x=1775676069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJA80joocb7PLTdewT/mj6/EXqr99Qh7WPXPAXbSMOA=;
 b=OjPh94gbQSxtdse3VVR7CGo/ZOFWc1L3AXYC8lH/xboyZjpPx4zS8cWJmpZKsI2UZM
 zXjW+Vgc4jDtMo2Nn/4fhsbtm6F0SYgrhHHZCd1R1tx5fPz0LJLBc6Bq51yKESUQsWDM
 vj8DGqD/GtvPONbDXVAcwEzowxheUShUYWtCbozd/94TdnuB3svch51pQiZMRVKQ9x+u
 94H2HysD6w/te0eVu6xqcwDtVK4DY2NIA66YQch3l7bEawb1+WvfSD6tIadMO3NpSDEO
 tLK+FxpJ46ymLUWcQLm1w8YOGXA2lfwFkhwUdGGO4+GYApPB7j6hN9x25o0k9uBg5B1d
 zxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775071269; x=1775676069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lJA80joocb7PLTdewT/mj6/EXqr99Qh7WPXPAXbSMOA=;
 b=aK8SFEjv1HoMfgJBBJ4QO4+SUk8/wqY815FhqfFKz+S+ZAFikvGXwKRuo3zBgBjmy1
 6P6LQnuKbTakmjYANJW75VXuHMqCk1UwXqVnbaw4I1y7ctC8zVtXeFUsCBtqaKhMxZ3l
 j7ZAc8YLm9vFQlc6N73z7trSWJwquYJKVUADiP143JPWoQQnLlDACbhZInEnFaut4uZo
 J3e6Qjzl2bXXqIbk8QAsravGCNpSrQe41y+MbBQjqjIJv3SmGQCaGTMGTQKOlnAE4786
 wthDtFLiwTvhvnpIZtd7tj/NoR2q6B6Vbru/MaIdyhnknt6rO9lvlHkNe9SIGl9FScb5
 2w/w==
X-Gm-Message-State: AOJu0Yy4SLRZCJofkJjlD9MzeM6SJBMoJKH1jBSCNKIdFStnwqLL5MzX
 Q/vamnSdcwedDpbzcU/8LEpEk/MnUytkrmLIBjqDKa53tsbyAR8Z5QuvI5Tqc46do6oDpZqQsA3
 ej4YyevBlGQ==
X-Gm-Gg: ATEYQzxQhsU1P33YXhczXy94TiqXSjJz7lJa7xXGf1n+uczin6kw3sXjLyv7RmJNkCJ
 lf0f8heneIu7sw4xFvuG8YfvTQEGoCxelUDwakitndegVKcBeyM8+Ak9Mk9VF64YbtJyR5RzWhq
 fAflJ7ODNK33k9r+2rsMW4e89Es5acFHeJhCFkv0dODrLwkEE+WIY+SJRRWNzFjN+dABeKoezM7
 L9ChAwJvKRcyCPQSExZnFJ54Rm9Rdv1Nab4gzTJPyG/eBcE0GN6rjWb8NDOo8lDIS2Li3MSgtvo
 8IGFN6ntnwgwws36J70aYHU+yZUBXEtr6d3Dz94PEGzdu+2Pk4feOmjHFdp+5ZcmtEoVwq0ESYk
 hykeqboXIezfu6h2bdj8TmkMjuI9n9t4RgyL2Evr3CBb3cfq0ba/cJ8qIHYRbkqnJkI6qEyYtX6
 Ccc3OxqRUhCVi63jOLaV85zaUyvp7tc7MV7N4WqW1w2acmyReAKzxf2niyG+oHj9dnTsiy9Fkuz
 V6h
X-Received: by 2002:a17:90b:52c7:b0:35d:a90d:580e with SMTP id
 98e67ed59e1d1-35dc6fa653fmr3744378a91.23.1775071268593; 
 Wed, 01 Apr 2026 12:21:08 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe41b11fsm5633113a91.0.2026.04.01.12.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 12:21:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 jim.macarthur@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 05/12] target/arm/tcg/translate-vfp.c: make compilation
 unit common
Date: Wed,  1 Apr 2026 12:20:50 -0700
Message-ID: <20260401192057.1182724-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
References: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

Generated decode files must be duplicated between user and system, as
they are generated in private folders per libs, and can't be included
otherwise, as meson does not give control on output folder.
Indeed, meson generator is a different approach than custom_target, and
this is a limitation by design.

They were already duplicated between arch variants anyway, so nothing
new here. They will now be compiled once for system binaries, and still
per target for user binaries.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 3e96c77df73..5f33ecd76e0 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -5,12 +5,15 @@ gen_a64 = [
   decodetree.process('sme-fa64.decode', extra_args: '--static-decode=disas_sme_fa64'),
 ]
 
+vfp_d = [
+  decodetree.process('vfp.decode', extra_args: '--decode=disas_vfp'),
+  decodetree.process('vfp-uncond.decode', extra_args: '--decode=disas_vfp_uncond'),
+]
+
 gen_a32 = [
   decodetree.process('neon-shared.decode', extra_args: '--decode=disas_neon_shared'),
   decodetree.process('neon-dp.decode', extra_args: '--decode=disas_neon_dp'),
   decodetree.process('neon-ls.decode', extra_args: '--decode=disas_neon_ls'),
-  decodetree.process('vfp.decode', extra_args: '--decode=disas_vfp'),
-  decodetree.process('vfp-uncond.decode', extra_args: '--decode=disas_vfp_uncond'),
   decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp'),
   decodetree.process('mve.decode', extra_args: '--decode=disas_mve'),
   decodetree.process('a32.decode', extra_args: '--static-decode=disas_a32'),
@@ -30,7 +33,6 @@ arm_ss.add(files(
   'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
-  'translate-vfp.c',
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
@@ -60,7 +62,9 @@ arm_common_ss.add(files(
   'crypto_helper.c',
 ))
 
-arm_common_system_ss.add(files(
+arm_common_system_ss.add(
+  vfp_d,
+  files(
   'cpregs-at.c',
   'debug.c',
   'hflags.c',
@@ -68,14 +72,18 @@ arm_common_system_ss.add(files(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate-vfp.c',
   'vec_helper.c',
   'vfp_helper.c',
 ))
-arm_user_ss.add(files(
+arm_user_ss.add(
+  vfp_d,
+  files(
   'debug.c',
   'hflags.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'translate-vfp.c',
   'vec_helper.c',
   'vfp_helper.c',
 ))
-- 
2.47.3


