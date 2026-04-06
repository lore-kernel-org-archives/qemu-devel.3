Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5C0F46C49
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9lVg-00033I-Em; Mon, 06 Apr 2026 11:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVf-00031s-Cu
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:05:03 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVd-0003st-PF
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:05:03 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2b23f90f53aso36832535ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 08:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775487900; x=1776092700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uukBbBYYNyrggNOyo7VdnlUk/PBaz4ldLT648BT7MPc=;
 b=N3mK/b0MmET7r7p1v/qKL048e+Cn9MtTcoed3107+RQU4QkEzo2ZyJom2YFA2zC0GU
 FKFDA+6B7ycnvphULZcO1lLuPo7QvgJeLMKBQSaBzBbIWqsmTXK1EcM3a2J4pRakSAqw
 2FwqADjgrjzrCt/o90z9gNPfRUzgaE7VVSPb0KiJ+BMklzwy5cW6BCYB0NO3B6tkQ8WF
 MDWuvqoE9RzHECLol93OQK4BPBGh+pfIRyAkNZVlQA7qdSyDzcuuXAacUkT8HmlztZ18
 9kLb5E+l7YoZ+DOX86m4LguxtLHcnBBmu6U5iFcIu/9CL7DjRDe5ZEljWeyEgw7aXfUO
 Q7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775487900; x=1776092700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uukBbBYYNyrggNOyo7VdnlUk/PBaz4ldLT648BT7MPc=;
 b=og0jS17aNKEhWnV7/4B8vvwkE6NxQnL45NHJsslZZUGa3k1mR9Ns4n2O1GXv79/GwY
 KYc9vfAJTPS6T02un7EzpXT3TAD1O8sM/W9SCSvEblqyHAP/eS619bAGQWBFIHYEnZhe
 +sGelN0fMMIIF9mFFubkfV38oxj6R7Y27QvpbHVTXV2IGNmh0U9dIKjrEJ5c/DZjAnmM
 DfWBLUfmR/NVdNn/B+CsUE2qt4ExDUEDcuuLxAlnidEFv9hog1OO+++dtYJ1cx1J7q7M
 o2LFSY8Z2atvaMzDPJqy8KD6nb04/8yIhw00LnCYkW4jT431UidgigXktX3m3AgiVSwI
 I+Cw==
X-Gm-Message-State: AOJu0YxnZ2LjdVQ1J9XeeuGwWVqJmhgew2w6rUCBWZpcapu8JkIa0OKq
 REcIx9kF1DI6AmZomfLuD3/wSqJQgoI8pEkzHeRsQClPSGFG7ykUXBdiSRl1vVV+PAaoKhuLU5k
 lJs0C1051kg==
X-Gm-Gg: AeBDieskUyBo6puqc+n62TGcXCQRFBH/QULLqocbosm0PRsP17oG4i5CqfXob1IqNKh
 NC9iimiwu801ZBubEx0ujc3NEJS+F4195rxwJz2867HOYjD1mLLz7WkIRtvOPmrprX3UrCh9I0/
 RkooshyI7nBxPk7BtiSdaqKoG/vNIXzMx9MkwTofw0Y/j2m9a8P5boKjhIsodAgyGmN67hsYZ9m
 F7fGZKYIGsbYOcy5ME23drsMXxslodyTGwD7b+XLY1hnvgwasPtGIDTlcgMxoUlb4iVa5NgdvSh
 UA2wEfSoxhILjas5nwYclIfdIbtzcq/Dk23NnwQpCfey0a+ivdND46xZLVU3Oum27fe6Y0dQY6J
 nRGOXiwv8ZcICNU6ieYklYTnzvwx9A1uA8F6i76WononL0BDQP3M82yoqVQDoTk40msp36zIyHC
 JebJZCJ4t8KzRTshYHyVOR5iEAysah8FNHf+EJr532k9KDDFS4UNivP/UgKwTfxHo9K4UCu4zSe
 S8RxLF6qda2/Hg=
X-Received: by 2002:a17:902:e749:b0:2b0:6e12:bb21 with SMTP id
 d9443c01a7336-2b2817ef051mr147747355ad.41.1775487900211; 
 Mon, 06 Apr 2026 08:05:00 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d72sm137770075ad.51.2026.04.06.08.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 08:04:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org,
 jim.macarthur@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 06/14] target/arm/tcg/translate-neon.c: make compilation
 unit common
Date: Mon,  6 Apr 2026 08:04:26 -0700
Message-ID: <20260406150434.407201-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
References: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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
 target/arm/tcg/meson.build | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 5f33ecd76e0..8d9112f6da2 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -10,10 +10,13 @@ vfp_d = [
   decodetree.process('vfp-uncond.decode', extra_args: '--decode=disas_vfp_uncond'),
 ]
 
-gen_a32 = [
+neon_d = [
   decodetree.process('neon-shared.decode', extra_args: '--decode=disas_neon_shared'),
   decodetree.process('neon-dp.decode', extra_args: '--decode=disas_neon_dp'),
   decodetree.process('neon-ls.decode', extra_args: '--decode=disas_neon_ls'),
+]
+
+gen_a32 = [
   decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp'),
   decodetree.process('mve.decode', extra_args: '--decode=disas_mve'),
   decodetree.process('a32.decode', extra_args: '--static-decode=disas_a32'),
@@ -32,7 +35,6 @@ arm_ss.add(files(
   'translate.c',
   'translate-m-nocp.c',
   'translate-mve.c',
-  'translate-neon.c',
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
@@ -63,6 +65,7 @@ arm_common_ss.add(files(
 ))
 
 arm_common_system_ss.add(
+  neon_d,
   vfp_d,
   files(
   'cpregs-at.c',
@@ -72,17 +75,20 @@ arm_common_system_ss.add(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate-neon.c',
   'translate-vfp.c',
   'vec_helper.c',
   'vfp_helper.c',
 ))
 arm_user_ss.add(
+  neon_d,
   vfp_d,
   files(
   'debug.c',
   'hflags.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'translate-neon.c',
   'translate-vfp.c',
   'vec_helper.c',
   'vfp_helper.c',
-- 
2.47.3


