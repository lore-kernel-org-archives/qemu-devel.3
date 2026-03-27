Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A5910F2853
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6AOm-0006BV-Hb; Fri, 27 Mar 2026 12:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AOe-00068W-T5
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:50:56 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AOd-0005Fi-7R
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:50:56 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c742824e1d3so820734a12.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774630254; x=1775235054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GvXc5w4/HrhK32EYEuNiFYOfrNSSsMEH7KaGOeb7ixs=;
 b=PA9zzlcaN4Lik4PHyxXgjrpUSAop+wR5Rb9nB3UXD0kRCDxVrrLkX1n7Tdx7m72ESL
 DX6q3S4tyqA9X0/1D5WANxWXPvMm1f9HnVIiO3M4uolsqpnHjKMM8u2SEMwpvsRib8ev
 5VN9kQ90bH7QZxhHJ1aCzVv5oFE+8VtS1rKLFhNmOTPk7B2UylYBtpBTUWLsRwVVk+/j
 1BUPAr6DjuHfDYdBeJKJfdJEBmoJ/3duEqMMV7qOy4LpaX6iHfSN2vV/21b4eNt3bJ9t
 lQvTFA4BeOOFXHDbvtb+QXBujMhkn+z56/i4Ug8xgXMCqbc7Qdw7qQ8oQ9GI4Vgb2jQ+
 p3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774630254; x=1775235054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GvXc5w4/HrhK32EYEuNiFYOfrNSSsMEH7KaGOeb7ixs=;
 b=B9raMwMDfSLChSs621uf2VHKH1e6b3MXbIPipesZgOrir/Y1+mGkQcOcNaUepzLUdY
 ximsNYoUFGGoh0FfqH/TZhvgKPhCWOGiEcfVmstv7Z3Is89U0cAm0QErWM/e+sGnrjko
 c+XVUvsXgrvnItyhGQHpumMNNVy7RlnpEIGplYtFhRdhtaf10GrCdtzchS3Lez6B17CG
 lHuLPR71wZbvoknNZ9RmG3XuLfyuBp7yhSLbvTdC7sIHL9VGEQZsEz7gISSy+LDmntTI
 GWBggpYwT+WhxhuRsTTnOnMBmihUwJSv+8hAFruY/H0g2i0tueR6KcdUsunqitS01WOY
 UKNA==
X-Gm-Message-State: AOJu0Ywv5VYAL20CYw41smO/S4SMC8d5GA+LN4uEAXO6nwoz7M+BMI/s
 6LYyTVqNOO1mBjRkBl/Sd9tT6Yxr+6XHklXbvrS2eZFLUmNIgwZqD2gG8rVdHHXyij20yQTPRGa
 KXOBVmI0=
X-Gm-Gg: ATEYQzwuPn/9zm01aX91kjvyM0VZU6yrfDluOQBWnLIDsO3a6IPV5oc6S2DRM+yieZX
 ctgecsT9d4U7q17TPMcseUVaI60/vbgUPHt/0G0qjldrMOEceIkYXA9DCW99QYkTJYyGk+n0nN0
 QO43sl3Z1LorcdbFOyyhBE9YLYPWKmVFzpCtxzXUm4jud0U9u9V7qCFSnryzutK6Kx0BsQ4EXK4
 4zsDXUg9heyDKN/oEtRlCj1wIJhpGSWbDW9V9oVUEBy7edlY93x8XmPU7c3rFROKiAy8p7ciwk3
 ykqV6wxWnP0hmb8LJfVSZX2Ldcvjob2SWWo0hBdAdGNDbSbGAh1rsKlV8FaNnFrymKfTnq+Xd+5
 0rJ28KEjrmecHHKcW7dp8/Jpd/gp9KlK/+/OBLA94TM8drAUeVe6R6n0lZBFnWTtHazGVmK/03S
 fmnV7sQyi/g5G6M4T1RsNj1bjAFSVlV8mMDtAjec7nXWWF/lpUx/3Bm9osaoW3Xfoe0t1BNyr74
 jB5
X-Received: by 2002:a05:6a20:a12a:b0:398:95b7:c41a with SMTP id
 adf61e73a8af0-39c8794c0b4mr3643922637.20.1774630253493; 
 Fri, 27 Mar 2026 09:50:53 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c767399e0casm5514038a12.31.2026.03.27.09.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:50:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 06/12] target/arm/tcg/translate-neon.c: make compilation
 unit common
Date: Fri, 27 Mar 2026 09:50:36 -0700
Message-ID: <20260327165042.604105-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 46bf4a6d76b..c14c9242df5 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -29,7 +29,6 @@ arm_ss.add(files(
   'translate.c',
   'translate-m-nocp.c',
   'translate-mve.c',
-  'translate-neon.c',
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
@@ -60,6 +59,9 @@ arm_common_ss.add(files(
 ))
 
 arm_common_system_ss.add(
+  decodetree.process('neon-shared.decode', extra_args: '--decode=disas_neon_shared'),
+  decodetree.process('neon-dp.decode', extra_args: '--decode=disas_neon_dp'),
+  decodetree.process('neon-ls.decode', extra_args: '--decode=disas_neon_ls'),
   decodetree.process('vfp.decode', extra_args: '--decode=disas_vfp'),
   decodetree.process('vfp-uncond.decode', extra_args: '--decode=disas_vfp_uncond'),
   files(
@@ -70,6 +72,7 @@ arm_common_system_ss.add(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate-neon.c',
   'translate-vfp.c',
   'vec_helper.c',
   'vfp_helper.c',
@@ -79,6 +82,7 @@ arm_user_ss.add(files(
   'hflags.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'translate-neon.c',
   'translate-vfp.c',
   'vec_helper.c',
   'vfp_helper.c',
-- 
2.47.3


