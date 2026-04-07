Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16670FF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 20:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wACaQ-00047F-JP; Tue, 07 Apr 2026 15:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaM-00043e-TL
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:42 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaJ-0007L8-DC
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:42 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-354a18c48b5so4767189a91.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775591978; x=1776196778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6du+WyZftkpSSaxLWG65RGyUVCyinpyoeqYIOhYC6lY=;
 b=Cj8u+NKudLo6F6VlIrmdXQYMGJBase4R/LPMPgAScamPmf87ZaQCw1rTFIfaKoLHtU
 rUXI0JXeBmkO1eJD9/edJbnj2b65D2gig5dOYw+FR9iGIVh6n3fy9t5XrxKxIi1ScaRu
 k5tqYfZP1D0hldP2DJeWEsKFtb9tEJ4Q0syHlKT25dWH1d4sP+B+Y4P3A3ysBHmkMKGd
 5i2ipSmtb6H7cbJeb8e7OKEPyRUHYSsNs/RzV9bc+7ZEm2FtsQowawjrQSdkzm3/cQtD
 2cMh84yrk8vzgVy7aAFsaBoRNX3jXxqdheOZDA12d6qjEpvaotopg5L222emeQkiPt1c
 iqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591978; x=1776196778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6du+WyZftkpSSaxLWG65RGyUVCyinpyoeqYIOhYC6lY=;
 b=e3JR4lJaEA5/l5ZzWfGUXg4kyDH1aMc7LUkvoHtzqtCokbSEKUGEzd7k9wgubJ0o1Q
 dQs2IsvL50VpgfjWC/54iLILOVSZkWfLbIQlVSJOJTi7gvz3vXp1CxwMG6xoI7+ZS2zG
 /EKAuvevwaNQVkbrz9F27ibivuyTwqf541YWeizzYPd5sopNUylxhOjFOXcuiu7cltxX
 xaBdORyjEQqZttCwC6IjAwEBWRbDkRaOQ0EH/VBzOPn+Z50A+g/hl2aTizu0vn55hrBK
 rPwbzb4P++cu7DiMf4tBNg9j9Xye7n8cKq+p4zxlNOnpDalHmS2lc3W7lGUV7zHU/TTD
 bVaw==
X-Gm-Message-State: AOJu0YxOmhtUyaSvCCc95ulNH9agjD+EW7MreyysELL6fg2meZsRNyiw
 46za+sW9BB09oCtb94KSnnde2TcpIR4vLf+ufFgH3g74qzjg2RH0lhKrOEItRQ6H7kOUCrbgOwz
 +FXvXgSo=
X-Gm-Gg: AeBDietAey9P12taL3ynmkiJUGH9VErdD7FsT9gZS8VIkgiPOSYwqHfc161ZUD7yiuV
 zwmt2z5GvzbZXnBjEIROEDIWeLyhJH2y/nWOmrMurRE8GxyM9yO8sKdqJweg5sEMAba9Y5Po/65
 DvZS4pMK2By3h/eE3p2ksv+y72M9DrkDMm7x9ECoWvE3g7buw30cYZQMbd6zt3wL3hxyMg8ugAF
 cD0MfxM4wKRedatIAgr5CRlkDzQkLMkvrt5Tsr43w06GMiSnydAGbAJayI4msCHg2ElNXmkcfwT
 +UKXDv7zHRh1P3MMwi1hy3Mxs8PhmeLl4AHrMhECKf4deXVQj4X8oOhGW2m2AzqObgiVcI04+xZ
 6MwcA0tsoGp/1zGrr9g1J83NMc6QMCHj8EHXdmWoJ/th9OnrhtK1AgQq+Y03sJj9GXT5eVoPSxo
 OM3iAnq7r42CvjZKnv3jXLYUag0qAAXYV4E0m8TOe9MVv9AO1p1Xgb4UtGsatrklFFA1FD5UlFN
 Yo/
X-Received: by 2002:a17:90b:52c3:b0:35d:a861:36de with SMTP id
 98e67ed59e1d1-35de691b394mr18135052a91.24.1775591978028; 
 Tue, 07 Apr 2026 12:59:38 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e27c9855csm126911a91.3.2026.04.07.12.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:59:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v10 08/21] target/arm/tcg/translate-m-nocp.c: make compilation
 unit common
Date: Tue,  7 Apr 2026 12:59:09 -0700
Message-ID: <20260407195922.196410-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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
index 89c3b476822..70beec7a6c9 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -18,8 +18,9 @@ neon_d = [
 
 mve_d = decodetree.process('mve.decode', extra_args: '--decode=disas_mve')
 
+m_nocp_d = decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp')
+
 gen_a32 = [
-  decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp'),
   decodetree.process('a32.decode', extra_args: '--static-decode=disas_a32'),
   decodetree.process('a32-uncond.decode', extra_args: '--static-decode=disas_a32_uncond'),
   decodetree.process('t32.decode', extra_args: '--static-decode=disas_t32'),
@@ -34,7 +35,6 @@ arm_ss.add(files(
   'cpu32.c',
   'gengvec.c',
   'translate.c',
-  'translate-m-nocp.c',
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
@@ -65,6 +65,7 @@ arm_common_ss.add(files(
 ))
 
 arm_common_system_ss.add(
+  m_nocp_d,
   mve_d,
   neon_d,
   vfp_d,
@@ -76,6 +77,7 @@ arm_common_system_ss.add(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
@@ -83,6 +85,7 @@ arm_common_system_ss.add(
   'vfp_helper.c',
 ))
 arm_user_ss.add(
+  m_nocp_d,
   mve_d,
   neon_d,
   vfp_d,
@@ -91,6 +94,7 @@ arm_user_ss.add(
   'hflags.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
-- 
2.47.3


