Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97170F99369
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqta-0006OV-Hp; Thu, 23 Apr 2026 06:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtW-0006LW-QB
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:51 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtU-00022B-5S
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:50 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso3509332f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938566; x=1777543366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GP7zINidX0alauIbPBcoImfXTpXjnaXesFDiZ3dF3Ls=;
 b=rtFoemHuTP7JvymushbG1a47OFtdr3spNAKgQa7LArzv/buAT3YOvEezjMKfMSe3sp
 XqnDZ57XUUsBYJBsDLf7qrDXRZ0wF5/POYAfHMUUDmBl5893XFCWBICEZCELafpOgMe+
 mqyksmsEBPIZEcr6/y+BMEpKrGV4mmBcwnc5L0gu01tVezM87Cx27fQPvyQFUD2cYGR4
 0YO9vw6d1KQvpBp3XZO+YwfZGc1spnNbvewTpieuYnG2LPJnE04XtOtze0HcxTzktsFC
 t157UBBz7Jxr+FpyHmJOsxvlodBPc8Xo5CY5UDQeGDRWCL/ziLffhWXhzCrA2qFYjbnu
 vJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938566; x=1777543366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GP7zINidX0alauIbPBcoImfXTpXjnaXesFDiZ3dF3Ls=;
 b=qBrDyQtwBNPaHDn1asZsVpmeK8+KAmmcTCJjLYbueKpxi5w9e9UY6Nk9S4TFocl+sh
 RJ0bS7KjTdeFaYhVwjUK3bbC42qWu6GXYkh8oH9XFIPQpbZx6VUbSNr2rbo5YrQ/jl7o
 Ldvz0EZiMX9MIcLb3tyN7Nm5QYWzpc6sEcTELVr2djUr1Y9s+Cm7ZMIlZNykM7B7xNvi
 iCkyUwc+kUEtzpaAjZbgQEZ0SbELOMQ5HPXnbhpGpFRRqqt/oYOGzD/zn5+JdTMOdMS2
 DvgDP75JUvHvUehC3V6FrGckZbhmuOunigEP6eT9GWe49/WQX6ew1y+vElfiOIUuD/JP
 7HqQ==
X-Gm-Message-State: AOJu0YxSAKXYO7fzITFRI+oHUBFO0ay2ZlmlRwCqHS4DqWezy+pQO7W2
 ta4eQUmUH31vpgY4clGi4auYBus4LeGKVRqcjS21Fu3oHtF43JE3pt0kjlsaL10q/u+uiBS3Tcc
 /qjbp
X-Gm-Gg: AeBDiet0zHwferDY8LOKaq6Ln9X1NURCXDFSmZXB5KCExzJ3Wu+Gj9xh/8D1OWyE5AZ
 dWVQdKQ7bAYerL8AlypeR7qW0snvNThSID8xztz84qPSwpSWfW50LgEidkBO/EsdD+1jlzSo1JD
 PX36cXa2mljFGeEvEtvxQs4TDx7ZKdELjQjiSpXjTiq6JQuDtLYN3HXiiNI7npgLE8V65ZaIiT0
 1Egbiv39k0Z+VPEnSQHMPgAWY5t6AuzmE1QF6HabzLMyeSAkjSnactwMdHe1UwP8t2L3cScYU+j
 RwceDemUDvWira+j3JLFx1pflDo25C5Taa1hKfyvMYGaYRMtmOfjDHSdT2SASuKyOvTr/VROQr4
 ykzyct+2d/KZYHcijRiTvyoSBJ4LyKpDauxQWGIsupQv0cx8PjGFn3Vp0kHEon/aGRuH81vskLH
 zL3icdb4y+n+HosbLZlNnkIDZ/fGznv6wdzLrX2CZsxHamqR69vnwS2aarwgjRYcBbaB4dfyc/r
 wNET1ZyofEeMRGqUdnKWwEyRTL3FHWltg0lw+7FzA==
X-Received: by 2002:a05:6000:24ca:b0:43d:4a43:53db with SMTP id
 ffacd0b85a97d-43fe3df2552mr40118994f8f.26.1776938566244; 
 Thu, 23 Apr 2026 03:02:46 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.02.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:02:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/59] target/arm/tcg/translate-vfp.c: make compilation unit
 common
Date: Thu, 23 Apr 2026 11:01:44 +0100
Message-ID: <20260423100229.2941820-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Generated decode files must be duplicated between user and system, as
they are generated in private folders per libs, and can't be included
otherwise, as meson does not give control on output folder.
Indeed, meson generator is a different approach than custom_target, and
this is a limitation by design.

They were already duplicated between arch variants anyway, so nothing
new here. They will now be compiled once for system binaries, and still
per target for user binaries.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260407222208.271838-6-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/meson.build | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 3e96c77df7..5f33ecd76e 100644
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
2.43.0


