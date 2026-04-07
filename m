Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91E9FF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 20:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wACaQ-00047G-Nj; Tue, 07 Apr 2026 15:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaL-00042Y-Gc
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:42 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaJ-0007Kw-5k
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:40 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-35c124d2613so3171976a91.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775591977; x=1776196777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2EDjkncN0A5+3a5tlX7QauSsXmI5/2falsiVKhMVXUw=;
 b=ZkF7PQKIV4dS9B/VcuLN6x70cRwncVD7Q6gmRlt4oaARVgbWJA6qg5hPQT+m0bTQtY
 3BKlDlylisUUPOfAsT8bVyho9CvAvZi0KJbB3saW6VYmZV4pUrdYSdntKvepfla5F2ZN
 KWfiCGeBN6Zb2x8oSgR/g4PJyqu/UFmxpmgY65/LrQtD8MnIhsLlMZ5BYOO+f1YZRNDi
 MnGjEja+xELiD4KV2uXTpLZXD6vfphpZmPos0LzCWlpxuyBOeX3XuZZgsGzWPwqQkGJl
 q31Zk35zNcH2jmxk9djP/7qBLOGhwKr3hE0p+NEduS+uRNzZHagCs/2YqHRXTxo7a+SB
 z3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591977; x=1776196777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2EDjkncN0A5+3a5tlX7QauSsXmI5/2falsiVKhMVXUw=;
 b=KrsRhk0FuQMqmbOCy9vfW0saPng6gCMvs/ehURaCkiyiHNJWHEZ62Cg9kGq5H3+kcM
 yVlS+hqAbcgCENXDM3m8OLonLaW2TJVcLeWkaQhfzEAyC+Nim14pxJkWQbosfipcymlH
 fvsZGGq3iJGwiJLGX5MkxeUC2Gvi8GInMg4NtkTYU/1jRlu2u5aQVPSIdysxKmeumwMy
 mzCj3cyaU4Voe+Qrcc/HvS3Q1AKnU4FWXO2tp+AydezV/EFMaRV1k3vst66iIiJEEUMd
 ruLrJzmVvvxFsawyy8j9j3kqfVonSzhSzJnWOKNVsfx4z85yGqvU+8g9xGiLPzo2LJP+
 c6aQ==
X-Gm-Message-State: AOJu0YxfqKMPsFjLukQ5KpGYuy/JdS2byaOWLKyyhP0S/reeXZ1Zwno1
 s0Ko4jURPtfbO8Wd2mFHNBnzzCzmr/BaSbMojRO8oe9wFdGROeVNDCkMYsTOMRvpRfYBJua6pXB
 HqZHFcw8=
X-Gm-Gg: AeBDieu0KbTAx6+CrtRocThE+jdBIwtqd41T4HtRkDh01iYxpQvEr7e3QeE9/JNd/Ei
 dyCc8ndSuD6Neq/HOBBv4LcEBXIi7KNimpVaUrswUrCXDXZ1rTGTMFbchRjLw6ezUBqn/0xl8RN
 A2uk59bepjkSV0a7Wa3xjgVAmDIIBqE4lOD41P8EAiMENBmOgC5VqfZfr4mGaIceWyhYR1hFsX0
 6EbXi9svhdwanY1fBY5oiyV1CHvrAiANDp5s7BFb45T8Mf4tEzo6VPwxA29B887zliB2N83la4t
 9pFBJrAJAjsbd50SnY4DI0r+ZwKy8o7CLxN4pF1jsT7QzOsB4/YmGNAOBCL2bpSNiduxKkcJvyN
 ND/JUxfPspSh6My1p2d/WGtcMPEeaokZT4+EtUGssSTb9WMPJc9fJaRJrmRdtGA2AXEpDlo5Ci7
 8XVYD4rb6L19MwMNrdbuiWmarny6VREYkacJjq3aBBmZtjrtxxgjsuYymYEcRH2TAOR4Z3YXl96
 Dok
X-Received: by 2002:a17:90b:2b4b:b0:34c:fe7e:84fe with SMTP id
 98e67ed59e1d1-35de69aec1bmr18239240a91.28.1775591977121; 
 Tue, 07 Apr 2026 12:59:37 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e27c9855csm126911a91.3.2026.04.07.12.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:59:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v10 07/21] target/arm/tcg/translate-mve.c: make compilation
 unit common
Date: Tue,  7 Apr 2026 12:59:08 -0700
Message-ID: <20260407195922.196410-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


