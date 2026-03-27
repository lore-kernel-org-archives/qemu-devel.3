Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E36910F2857
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6AOg-00069s-Gp; Fri, 27 Mar 2026 12:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AOe-00068R-PY
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:50:56 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AOc-0005FC-ET
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:50:56 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c766a95a72dso1612876a12.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774630253; x=1775235053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9hNSssL71icxnCVZy3/O+/Sz6YGQHHE5H5XHwyq5DTo=;
 b=lUDek4kG33K6msCEAUEKXrO28A95rhB/QBY9KcEB+IYTsZ2tLzI4qfABNxc5pi+LAC
 V/LIS2h9Df/K0kYsSWfypk6ZUksKdZOWCLuKUj+WRV3lpX1ENLqbvAadLZS2NKVea0sw
 RisQXrauj+pcwj3xuNYokXlK0bzbpxSJ6a0KaAZdt+I4uzzI31F5w+Lt5ij3qYJvKlp4
 qbydrMAqskLJazgw0uT4p9+eynIGwBOm/tJUI2FQSuU735jtJtITjpW3vghwsks5ZAgR
 nP2tSte4xv1i2epOCtCJVA+CEWIdwH6UfTL7p95EWm8L5c5G+jXb9JenSPJ/3nq+dwIz
 RWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774630253; x=1775235053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9hNSssL71icxnCVZy3/O+/Sz6YGQHHE5H5XHwyq5DTo=;
 b=asakqBy8eJCPl4EI4iOhgrfl9HZqtphGvcWAbWSkHPPmthf9AUzB7I+S+Y/bmt5NAf
 Tobn4j4l88r/cbZyg7rV9vlYdRJ0RGjW1iSwlt2o7THsiyfQWr9hImxH1AmEQlNp9hK9
 RTCzm41EHxpCj7wPa2XPQQFFnHlbXGwHGTJLw7iImB2NmnYnMtDGXmwEzIjv+cTivNoO
 3mbbJgJWUe76rMmIHSSyWuplEgIr8iXHdStnIqRHAKV0LP1Tpa6ND99QoIXmQHrhtVRe
 4QC5Pp0aWzbulDU+iQvPf9FKeC1SE1gevnKGIpUcE2m/uwJTeKYxlzdHFkodY5GU8/8v
 QnvA==
X-Gm-Message-State: AOJu0YxNb1AsO25st5cpiHM963efFcww7lRSpULKIUK9ybpU9k7ql+sb
 vcDHaxXHc7FJa8rOkSJytKbwIa6bbqx8V5AYXo6ZNzpnOmIdYYQYr7KgoG0qG+ovVIEiSc/4xOA
 NMrFqjC8=
X-Gm-Gg: ATEYQzzZoQHsHd5+yqL+76jiJCvzsfnm6JVy7lwgbwhOKkHYnDiB7MpqRLHPltHIPur
 qt+5tINn5sPPTKrrFGK/4kuU6yMEC4Qhjw4eHqu+W5oxJqD73n1osPAM4hghllzQA4Oo/gCLv2Z
 bkfOvULBOgT36Cv5q0gGyeytaMY7RTSx8vwSN256iB+ZbwBiEs0H18TFmXmJa0do0Imvc4eaLD2
 8f9mEvcfgg/IPbhOqEnuBaBoWO2J8LgVjXM63tp8cPoOibFzXRZIZYtLl1DPtVzHmaKYO5tbPU8
 Vzp/ACrvY0s6vhKP7p2EjpIgNvoxO/1JoVigfRoO3Dsr+/km69GzWVxMRhDm8A6Ap+z1sjQcUqq
 8OcC0toDj3riiZuxzUXTr2siHZunY01ThqH4ijW1sp4Gl5xXR696P3rC13TYlLWYu4HpyywEmcu
 R/LLOQ8tBYxKi37q5VgGLstylk+FUQhvJ8jEVOKqU2mfeItXexE2HmSaEO+utp0dTK3WZ5MKXD2
 wgklS5JXMiuK8k=
X-Received: by 2002:a05:6a20:e292:b0:39b:dea7:562b with SMTP id
 adf61e73a8af0-39c87880250mr3587402637.18.1774630252691; 
 Fri, 27 Mar 2026 09:50:52 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c767399e0casm5514038a12.31.2026.03.27.09.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:50:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 05/12] target/arm/tcg/translate-vfp.c: make compilation
 unit common
Date: Fri, 27 Mar 2026 09:50:35 -0700
Message-ID: <20260327165042.604105-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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

Generated decode files must be duplicated between user and system, as
they are generated in private folders per libs, and can't be included
otherwise, as meson does not give control on output folder.
Indeed, meson generator is a different approach than custom_target, and
this is a limitation by design.

They were already duplicated between arch variants anyway, so nothing
new here.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 3e96c77df73..46bf4a6d76b 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -30,7 +30,6 @@ arm_ss.add(files(
   'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
-  'translate-vfp.c',
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
@@ -60,7 +59,10 @@ arm_common_ss.add(files(
   'crypto_helper.c',
 ))
 
-arm_common_system_ss.add(files(
+arm_common_system_ss.add(
+  decodetree.process('vfp.decode', extra_args: '--decode=disas_vfp'),
+  decodetree.process('vfp-uncond.decode', extra_args: '--decode=disas_vfp_uncond'),
+  files(
   'cpregs-at.c',
   'debug.c',
   'hflags.c',
@@ -68,6 +70,7 @@ arm_common_system_ss.add(files(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate-vfp.c',
   'vec_helper.c',
   'vfp_helper.c',
 ))
@@ -76,6 +79,7 @@ arm_user_ss.add(files(
   'hflags.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'translate-vfp.c',
   'vec_helper.c',
   'vfp_helper.c',
 ))
-- 
2.47.3


