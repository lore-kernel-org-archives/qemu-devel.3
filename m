Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DB8CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLid-00086t-FI; Tue, 19 May 2026 10:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLia-0007zd-FZ
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:46:49 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLiX-0007oL-CC
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:46:48 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488d2079582so35718835e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 07:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779202003; x=1779806803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DIYh6J4qeeRTQHfvKlvZCgBlqlTwiarImjNJm+8cQwY=;
 b=Q+SaUBKnOwInaFvqRq/hnnjrJfPaFI8PMcQgoJpy+xnhWT3AtgtaZ9J8pSp9ba35FR
 nDUkHmARP8u9lFTtAko3TLMPFynXcYATpM/iyqW5cBbEssx7KvIVw/XIm+vqcnZlYxz5
 t7U4qWf3S8GGg6zgiTHYQKV36uGEY0XqZPb2P4vySNjw3T8jE3iX8bLWU8mt6Xok91FV
 qH7E/ZPdxIyCISLCl5BJ8+Z6Qa98Efdw3zjxu5OVgHeYrzZbYuOoG/qZZQ83wkhLwJja
 7UZGbDZvGAinYsW5aPZt8goxedq021/35IFRv7hX1o9J0tVd8RNyWtcJi4vaf+MZ2knW
 LTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779202003; x=1779806803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DIYh6J4qeeRTQHfvKlvZCgBlqlTwiarImjNJm+8cQwY=;
 b=FelaB6BLLg4zhDnqJ9QOTxeB20QmCAtWql/kpBamy2FPZeR5elbpEqyLouwIdR1pp4
 P52J4UBwfQZpoIb4dJdfRwhy9ycYBYS4/SgG4/Zmy8LEH8ArL9nCvko8FD8LYIPjCtRF
 TTM9N2M4tN67dkLa09yZmN8lgX62dOe2uFkcmSqGMwPLj0O7Hcj0/1PTG6tbh3rmF0Bn
 2xAcQ+awZtAfqKBH7ouVqzCU/fxxyPSeKmx3tAtkOhLY7oF6wu0Ug8doMo3HSvUOa7qR
 aVGvvWmM41x74Av4irGSRMQiRMO6docVwmk3hclhhLqaIHJNcVTQA00uKM7KMwIq7G52
 I3Rg==
X-Gm-Message-State: AOJu0Yw3RYFT/LKwZqt3DYjVEKU2zlDDsI8SzScyaKSkYEQGWlyamllO
 I0kEoXYbxEwO14oHzXoO0mou3WSXYOwRcC0R/Zp4UpXHpP4JsO8P1Awii+MTt9UXiBEyrQ8l26L
 iswAD8+8=
X-Gm-Gg: Acq92OFvRuF0930LXYFDDbDuuQZmSgwXNRofUeyGw67KLs6tZSs/+GCYH8kPT229d6B
 mOH+xVOnicMahssK/VB3UipsJAsmim5sz/PYYE6nCO6e0oLuMUf7DIs9HxKSe1WLi7myqKqhHe6
 Wltu2PEVx6zHPvv/nCzAXXp1kuG+uSagGIMTfmb9WdwELDzsuOidrHdzQMb6rsqd1LwZFsZ3Git
 3g0ma27R50+ZkGCjyj/PB3e/Be1fn8lShXVxDXiIAwQ14HAvI9hC96RKHdSp0QiExFe7Zf2x2I3
 B0nPkIvmRVHvzCeBGe3N9RCX+EWnkGogeLFWAPToPJCI2S986jcVJrwpdci7CH5D24IaUfQX20B
 +r+RZ/h8SBNrhezI7JH2go30lEOunHcAqsZ5V+cjGuGa5fI/ITeb7Iwk8RpApI6oxOYA+41yKWY
 o1nICx53B+dbgC/b8Z9lno4/OhDC721u8sr4zt+mbKfrsyNhyCdaioICnHCwYbuofMv/buKSiy
X-Received: by 2002:a05:600c:48a8:b0:48f:e230:d5ab with SMTP id
 5b1f17b1804b1-48fe651e11cmr190837715e9.31.1779202003347; 
 Tue, 19 May 2026 07:46:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48ff2cb4ae0sm157964445e9.0.2026.05.19.07.46.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 07:46:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 07/18] target/arm: Introduce common system/user meson
 source set
Date: Tue, 19 May 2026 16:45:42 +0200
Message-ID: <20260519144553.91483-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519144553.91483-1-philmd@linaro.org>
References: <20260519144553.91483-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Introduce a source set common to system / user.
No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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
index 1b751d59183..b0f5342245b 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -52,60 +52,42 @@ arm_common_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
 
 arm_common_ss.add(zlib)
-
 arm_common_ss.add(files(
   'arith_helper.c',
   'crypto_helper.c',
   'idau.c',
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


