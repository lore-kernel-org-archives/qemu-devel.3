Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E1FF46C45
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9lVi-000352-Oy; Mon, 06 Apr 2026 11:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVg-00033j-Rk
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:05:04 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVe-0003tI-Ps
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:05:04 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2b0afa0210bso19639185ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 08:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775487901; x=1776092701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bpOML7tmZexsHhxO8SKUFq6iYscD6sM9NhAFa5aVm2s=;
 b=wWfbpRDcxTVpFQ7/s8aV8zygS1VbR3YErc68VM3EHOP4Y1lIObmDCFEi0iVdwzGQLZ
 6Sx6sx91Fluqgd/Us6ju5F7NUZPk2I4Rti/76+CD1eLdKkVeTpGOC4L1zHePtJnip+5s
 y2nXJs2dndjF+NO3IYCityG21fTxEjCd9NFByXCtvTaPxfKxLw6Ckfp3vJeIY9cfmkQf
 s5/TdVZOkEClRU/oM9eLDhJsxj4alD71IaIBuIuZHAaBjKWnhG3a0rFqMQp4fy1qry2P
 QHqIixuUB1kG+jR3gWshUPC7yoVqtIwB6h4MVPJAucY54A0Y4jrWNDRQASGf9aG05xEC
 gOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775487901; x=1776092701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bpOML7tmZexsHhxO8SKUFq6iYscD6sM9NhAFa5aVm2s=;
 b=hqStlIpF4bbdnT+0lZVrvDO+QlrqvwWQTQsnDzCDEJycD/NcJ8/PyG7KTShlRPWXLw
 h6AITP5a0m4CSE6GUldgie3kklMXQ1ZomZKw0udmT41LIJTPJ5oljZkmLTWdLSv2iE5g
 CbY1412GnWpwZ8KGkimIk4NuP1JQr2HBSKgQGslGqJWuaP6pzwmbJDSnt7uCteHwmmk6
 HVvVfSPcek8MstFP1SYWVo7ji/+/A0TNLCrcNMJT8wgFCjLpldne9U+dnLeikO6U4uoU
 VQEcPYUhqy69Gu0xynft4xZV79va1nzgOFSZ8hUJNbeqHg74xDra1lIV2eESOnj2X5w1
 /YPQ==
X-Gm-Message-State: AOJu0YwfAT5iicn9WHcwC2U4DCEGh/SCGjkJmb3X11Sthli6l2RbAuv3
 6nF2rGJRP7PIvG4nCTZy3TGfpMvvgKrf/o5xag/ASTK6dQTF6hUvSHapze9HFeV5TvFrbRfzcNE
 +alIvLinIEw==
X-Gm-Gg: AeBDieu/P59mGEYWK7QLX5y4ip3dnjs+SHV0tQm6JeublB9X2HveHqhlSVS2ZGepl/K
 q2cc1zeFBb2ghHaXuWqK/N5gqatnLqFdhceYDIQsrWui8TUsFKY9cY8iCBTpjeNCShLBx8hk0yr
 MyhMa9d98Cz0tK8xnd53ItjjQcrWPwL1nNSm1yJkUibxIolT8R6YEdquSBIoda2cL7VqiRK8Eb2
 x+vmfZZSLVtUdoLAmwC2lJkbM9gUzv4LPFs9vPTal/MOgQDLFBq5h4BCGGmRfov6yrKGXga2xAd
 6xt6EgIa4KSST80Kr++GTOtMluk5pKEbsnAX85IfkD/rdG7UcwN9xX/X9Pgqi3/QxywGWhv0E82
 /m9r3DnoRg/75JxN3sn2POA13YJL8CyAkjawjMn/ufeUWBsHkQTnnUAiBUBpVSIgYWibZAztECW
 pcUEWNEkfKYb4dhkTkXLX9Ewq06GSRL0ouplibEO+hWlIv8YK9on+wL8D1nwEMo9xmiz5qbS/i4
 yf1
X-Received: by 2002:a17:903:388f:b0:2b2:4eec:980b with SMTP id
 d9443c01a7336-2b2817d87e7mr152583195ad.7.1775487901063; 
 Mon, 06 Apr 2026 08:05:01 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d72sm137770075ad.51.2026.04.06.08.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 08:05:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org,
 jim.macarthur@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 07/14] target/arm/tcg/translate-mve.c: make compilation
 unit common
Date: Mon,  6 Apr 2026 08:04:27 -0700
Message-ID: <20260406150434.407201-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
References: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


