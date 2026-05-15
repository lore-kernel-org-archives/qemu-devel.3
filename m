Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D6FCD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtGL-0005dx-8x; Fri, 15 May 2026 10:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtGH-0005Ye-KE
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:11:33 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtGE-000442-4P
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:11:32 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so83634165e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778854288; x=1779459088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ij7Lv+xOkw+dnHmI7jo5IUG/QbNAyBo1SM38AVgoOSY=;
 b=PhTNOffkbiIIcVArqfpfNu4cH812Dmbdl28ZzqpGwEMG/CB43LS4rE6KcQR8JaeKhK
 y9pGk9X2sIrp36aEIx22qpjHhIuAJj6lS0aij7bkM+TNdNS7Bnf3fge3W+tETdcQTgsq
 VlSM1/B76b3Imp2hpVpztKCkPInGuvwHHi/OQDvvP1kd43zq/an8qkqyFFMyg4VTsFct
 Ak5ghgXyAm9MVAXskCHpVuP4cafCuBZDCP1aDmaXqJgweJS0SloH0/oEIr2U2avuw3Gn
 2AMkUrEwKhxFhDxJqQ5d5S35WDb9jqG+AL6OmwsWd3X/Osk06RgqSjgCSggSzWoAdVds
 Tsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854288; x=1779459088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ij7Lv+xOkw+dnHmI7jo5IUG/QbNAyBo1SM38AVgoOSY=;
 b=m/SazkzW74zlz+7vZEs6yEbOiEPJ06P63Pryvzliwt0AuOmaCDBAFwpymKhz4zF9oh
 B07dTvyA7N4NN+UZA5eWAXNr9FbJHuhNdlLSnizoW0I8zaD0FLJ2DAtK7mSRLB0yjWSV
 erXXlQWfLGe9Pa3g5aGRdCnjFqMcLvyfjSPIBAwbQyi132lI5eyjkYWSqAMoEdWggVUS
 OatNH4YF6a+Bo0VV0XlX0BY8jMarBkNbqKmB2oks/g6GUkwOrkE55kb+4r4ok/RWBlJH
 Fauids89cXwA7g9Cjl3+5tzr3eEX7Tjsc16Fudl5rc2bPYVsXLZ94Hqt/wR9ZZreuPMQ
 i7QQ==
X-Gm-Message-State: AOJu0YwuVk0r+/QpUrGUAIyANomtX4KmtLSMHHZCyY2zlhYG+OCxZO8q
 jpH2c1ongsYrBno5JePZLutLwm/qjIlrJaTz+KN1MG2x1rPUYsrPApos1cpPR3VZULaHD4VOEAd
 sjeCp1V0=
X-Gm-Gg: Acq92OFk61d5fEtVYZj61JSJm+R8tDg9y1dRaMe9jgEgUrQAYBI3fcbH8xz0+EV5nmI
 jGalyqf+ZdsySIXeUJ+Au6FcOERv/fFfKvKnfAH5quBMmL2NChRxLbB9vKkCspbDLwV6AOW7gMd
 j8+a6MMFRWea2WvQWF2lIrTa+S2x+AVDWSM1/t7QRuK/5qgwjb3vFPbrObyNnMK5d+ZjrdjLQPC
 o9bf2Oqa+3vqq+3t6JRHnEwO21tT0JFV07cZZsB9yGdjnNOXxwZ3MLxG3/4ynRkkkediTnHlPNX
 29itEdstNYfRuWJvrA1B+B/SCVEivrABxJ/hhB0a/eKCSEcSE+9hdb591//sMFps2T5+q2c0fwW
 q3NGJqWPiwPPBsbsSfdaJQue5MeVJv/XK9yjQvj5k6Jndvhdblv9LDz48nmKCPcCwc6s3/6P+zK
 oBcciQ5cCJWl5ONmpM2CaE15a52nj5yqPPVc+AuI+6MyuuIgt/A/dOCLhEzR2KnwbJ2cweRNF6
X-Received: by 2002:a05:600c:1389:b0:48f:d1b8:9a9a with SMTP id
 5b1f17b1804b1-48fe60e515cmr56879045e9.5.1778854287715; 
 Fri, 15 May 2026 07:11:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe661e1sm15155425e9.22.2026.05.15.07.11.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 May 2026 07:11:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 07/20] target/arm: Introduce common system/user meson
 source set
Date: Fri, 15 May 2026 16:10:18 +0200
Message-ID: <20260515141032.3271-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515141032.3271-1-philmd@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Introduce a source set common to system / user.
No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/meson.build     | 21 +++++++++--------
 target/arm/tcg/meson.build | 48 ++++++++++++--------------------------
 2 files changed, 26 insertions(+), 43 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 4723f9f170a..e56fc943bdf 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -1,6 +1,7 @@
 arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
+arm_common_user_system_ss = ss.source_set()
 arm_system_ss = ss.source_set()
 arm_stubs_ss = ss.source_set()
 arm_user_ss = ss.source_set()
@@ -16,6 +17,13 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
 arm_common_ss.add(files(
   'mmuidx.c',
 ))
+arm_common_user_system_ss.add(files(
+  'cpregs-gcs.c',
+  'cpregs-pmu.c',
+  'debug_helper.c',
+  'helper.c',
+  'vfp_fpscr.c',
+))
 
 arm_common_system_ss.add(files(
   'arm-qmp-cmds.c',
@@ -26,11 +34,6 @@ arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 arm_user_ss.add(files('cpu.c'))
 arm_stubs_ss.add(files('cpu32-stubs.c'))
 arm_user_ss.add(files(
-  'cpregs-gcs.c',
-  'cpregs-pmu.c',
-  'debug_helper.c',
-  'helper.c',
-  'vfp_fpscr.c',
   'el2-stubs.c',
   'cpregs-omap-stub.c',
 ))
@@ -45,15 +48,10 @@ arm_common_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
   'cortex-regs.c',
-  'cpregs-gcs.c',
   'cpregs-omap.c',
-  'cpregs-pmu.c',
   'cpu-irq.c',
-  'debug_helper.c',
-  'helper.c',
   'machine.c',
   'ptw.c',
-  'vfp_fpscr.c',
 ))
 
 subdir('hvf')
@@ -65,6 +63,9 @@ else
     arm_common_system_ss.add(files('tcg-stubs.c'))
 endif
 
+arm_user_ss.add_all(arm_common_user_system_ss)
+arm_common_system_ss.add_all(arm_common_user_system_ss)
+
 target_arch += {'arm': arm_ss}
 target_system_arch += {'arm': arm_system_ss}
 target_user_arch += {'arm': arm_user_ss}
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 4fb2c15f7e0..9eeccb2adca 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -52,59 +52,41 @@ arm_common_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
 
 arm_common_ss.add(zlib)
-
 arm_common_ss.add(files(
   'arith_helper.c',
   'crypto_helper.c',
 ))
 
-arm_common_system_ss.add(
+arm_common_user_system_ss.add(
   m_nocp_d,
   mve_d,
   neon_d,
   translate32_d,
   vfp_d,
   files(
-  'cpregs-at.c',
   'debug.c',
-  'gicv5-cpuif.c',
-  'hflags.c',
   'gengvec.c',
+  'hflags.c',
   'm_helper.c',
   'mve_helper.c',
   'neon_helper.c',
   'op_helper.c',
+  'translate.c',
+  'translate-m-nocp.c',
+  'translate-mve.c',
+  'translate-neon.c',
+  'translate-vfp.c',
+  'vec_helper.c',
+  'vfp_helper.c',
+))
+
+arm_common_system_ss.add(files(
+  'cpregs-at.c',
+  'gicv5-cpuif.c',
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
-  'translate.c',
-  'translate-m-nocp.c',
-  'translate-mve.c',
-  'translate-neon.c',
-  'translate-vfp.c',
-  'vec_helper.c',
-  'vfp_helper.c',
 ))
-arm_user_ss.add(
-  m_nocp_d,
-  mve_d,
-  neon_d,
-  translate32_d,
-  vfp_d,
-  files(
-  'debug.c',
-  'gengvec.c',
-  'hflags.c',
-  'm_helper.c',
-  'mve_helper.c',
-  'neon_helper.c',
-  'op_helper.c',
+arm_user_ss.add(files(
   'tlb_helper.c',
-  'translate.c',
-  'translate-m-nocp.c',
-  'translate-mve.c',
-  'translate-neon.c',
-  'translate-vfp.c',
-  'vec_helper.c',
-  'vfp_helper.c',
 ))
-- 
2.53.0


