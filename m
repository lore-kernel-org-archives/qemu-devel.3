Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C1D10F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYMC-0005Px-US; Wed, 08 Apr 2026 15:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAYJU-0008Vo-N3
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:11:44 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAEoP-0000nS-Ry
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 18:22:23 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ab077e3f32so23397235ad.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 15:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775600540; x=1776205340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n0wgNLa9n9Vgc0kuCG4RsEiFVidf8BLE6jw9JT+iAmc=;
 b=GEeX1qCF2BXI/pvnwzlF0/26YiLEAMDZ/E3uCVBZK/HNcEuhyymOW8qXf+0D0OcHYV
 AhCQ8sWLkIQ26kE5sOrxXZMj4R42RVfpbtzwpMoGoskbsx3k6543dbWq0ug7WmYoF84Q
 Rx0XYwkhBkLRzOWmAY0iUKZ0ylJRt7vmwyCtZ8ldzb5rrf6obxbhyFViFAy1w8J3v67r
 BdoBLHTzYAOWyzgZZ5FpsTWyq7pQQk04nD/O4oNsOxlGtc6xDWfAg+vFA4SDtfHaH7+l
 5zfDxo3yLgI9DJjLFexUTqwZjSWFiH03Y/nsSBW8e/DW8YiXHO7Z3N9tuLnXhZX2HfgO
 YlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775600540; x=1776205340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n0wgNLa9n9Vgc0kuCG4RsEiFVidf8BLE6jw9JT+iAmc=;
 b=Hzh2rdKypx2RPEJ+UfQy7+9Z9XTfe1P/sDya3HuVYu1p5MIaV5hTRi/m+OuhdI99v9
 eNi1JbCGXrLVptxbLkBTSHkKGJcHv4X5QxKnRX/YQGNCKP6wb2qRHxsEuXkpYG9eTNRb
 csiU/TP8SB/HlHSGl/pJQgp2oDIfuG7hNbxG+WDa6w0sXd+h40BFwWcCUpW0QNSF7r7W
 DeInjzpkR+qf36MRayh7UsAOdW/dpCt8NBWcctjPcfyiyLLrOTXcQJu9BdrY9WmuKyF+
 XVMb1zxV/fLIOO+VfG3RM9NC16K6IKoH5ycRsVq15joG56Y48YdjRGz9E2po0vKjbDwl
 8CHQ==
X-Gm-Message-State: AOJu0YxeGx2YmvtxFOprXR4KHOr/q/JFTFm/cHvs0fSDSXEQE27Evn7j
 Hn6KYjPteZNltBiQobtm221KypCn6iKhry36cheirZB00/rIJCg0nX1BpFbcCdIuSJ30vPxDIFJ
 aMF7NBHo=
X-Gm-Gg: AeBDieslgEmCVEoCWrR6vN5HQNPi2IjYrvBjEx4L/11w58WvyRsdgk/Eh+h9ga+RamC
 QC0JHp1KuVwKF6/7s8/w2xQaEa5aLpW6D1vbaha1bZiqci+KRPUFgFibBpqI+/3cypvaVUumQrC
 pKHvZdee1ZWE8ApRkWPvr8uIgZkDhFIwCDjZGcP6mk8W1qakRyNEMG6IOjNzzya9lRXp/Wo4x/1
 /MgGomcpAAj9gEuTDUMqVmAKnfSwdJWc99lmAEhm/1oiIKYBTPLRNe5MzRB3I7tWFG3ZnCdFYe/
 mjE2rbj2mr2EAaEINgpoHVBIk7s2QkK7+rOzsr6xxaBk8HYKMhnZv/qLw5vff/MpTo+Sj6ICK0D
 3Tzh89X4gvtNuhhhQU37IuWP0MX1YG/NqeL+MVCuOTXxBHE6RcoKq6meHuWqeTn6zyDlUh2IqwX
 7d0TJ1xteK27TxR3QyEzOcSbJIA44PxrMzQ6kr7HXlRivaaexN+8KI+yEotcY/ctSm8akVrP7ZW
 PcF
X-Received: by 2002:a17:903:4b43:b0:2b0:775f:febf with SMTP id
 d9443c01a7336-2b2817b89e0mr240772285ad.40.1775600540482; 
 Tue, 07 Apr 2026 15:22:20 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d5csm180412065ad.38.2026.04.07.15.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 15:22:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v11 05/21] target/arm/tcg/translate-vfp.c: make compilation
 unit common
Date: Tue,  7 Apr 2026 15:21:52 -0700
Message-ID: <20260407222208.271838-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
References: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Richard Henderson <richard.henderson@linaro.org>
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


