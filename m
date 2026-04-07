Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DBBFF5138
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 20:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wACaP-00046J-Qn; Tue, 07 Apr 2026 15:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaJ-00040g-KH
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:41 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaH-0007K3-33
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:38 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-358e3cc5e7eso2679633a91.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775591975; x=1776196775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n0wgNLa9n9Vgc0kuCG4RsEiFVidf8BLE6jw9JT+iAmc=;
 b=Wkvg2u5X3+HOQBgfJ5RIgssWHTgqsQlvcZ16bRutT1Ibvr+nrIoAPs3J82p0r89gVp
 Tg9M0HiE0pOqdhtE+vwbr4740GsVK/eLsKlsrqcJ//zPI5Q5Q49z/fzsdAeLFvNwL9Ht
 CEZE0OBDbJfPT/tjaHGyqrhrJS4f7RpT/F7lyvKDwK4cXDrfmyRr6MLmRhCTGdUWkzC1
 MRXVvQp99UKN3yWsOpBwFem90lMAwcCn9K6KktRGXkbTv27nDXvkSKzQ8cLvZXR0QAYr
 5nPieBmQNwGD4vt+8S4a10M/Fzj0FRX/HLDB5cWr1e3DkmFGdmXraiIqXYbjpxuh/rjq
 v2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591975; x=1776196775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n0wgNLa9n9Vgc0kuCG4RsEiFVidf8BLE6jw9JT+iAmc=;
 b=WHuCCrJtVsGM+dK9YessepxPouehnY5uQDfA3TxkUekkCr+nvMp50IHP0zxNBK32vp
 VUijcrXg/WoiQT56SbOcrhUT3mrzBpS5h4UcKHN1VWpkNl009jgR+MkvwryvbX+WK6Hz
 llthjadDoVqaSpI7ouaTFwnu/HYqjbNVME0fycexp3O0drrgxM5GDADFqE1nLSzXRVCh
 Bowcz03cYHseKdAkmBc6wplQ66jderX9HQhCpqT9vcDjIBpdYobHCqV0+k96YkFs/pfD
 4NAl73hQTdcpyVOz5pm5zFVORVc39a4wQxf8unol/uB654p0vVIsN7o1vRg373hZhq1U
 psag==
X-Gm-Message-State: AOJu0YzoxWfiyxYfgA3OusVqVl8iuDsfyWHVW/aN+eTVpfp2UpVveQSh
 hJWNuqzVbmWFolwnJPFQYr6Ny40hJMxFeacDZqUnAAxL8wP0etp5xOTBrHUBSpkXM30umJZNGmk
 +tfifz4M=
X-Gm-Gg: AeBDiesPOmSDHl7lZ91bO0jZTg5mZS2O3qlLN9zHCqUAa+edX8kJbl25gvO0FGV/mEZ
 +qEEQUXse58DNW1aWJQMRCwlx74wPuWvwxVJYXx7VvjgoWeyXbSI1OlJ5Ws66GBJNFDCjpVXcH6
 kwR9M9G/v6k/s9uMrU0V/YBgLOU17QcNjgoGZIQwCF38H30ITDN4LUSjEltzg32nNb98H2nBN+K
 o8N9bb2U8t1NWuMVA5CBF8Mb54FaXQNWoI9QASheBoEvvMgv6KB3E2UMTjHacOvkpKZakSddNjW
 7tyuJr+yxmYlnOYR4Dw70+XNHLxwnjBgmlX7oUkK0urIdzMTe1NIEJ6rgpnOF4glk4UqB3yK8F/
 XyuvMwLupAAxlUGQ2d1zykkVN7M4KOKDZgbPIspiyMzo97kIdZvDqT+QxHDBj06OntAACr7QlLu
 6gV4vDDrO80sL68OX6qxfqkOQlqJM50T/xuglwTpJ6FfxafdEXd4OReqeGrADtz/s2nFwBmG6PY
 ZiO
X-Received: by 2002:a17:90b:3c0c:b0:35b:9d97:63ac with SMTP id
 98e67ed59e1d1-35de684cf9dmr15451798a91.7.1775591975244; 
 Tue, 07 Apr 2026 12:59:35 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e27c9855csm126911a91.3.2026.04.07.12.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:59:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v10 05/21] target/arm/tcg/translate-vfp.c: make compilation
 unit common
Date: Tue,  7 Apr 2026 12:59:06 -0700
Message-ID: <20260407195922.196410-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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


