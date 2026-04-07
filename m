Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5C310F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYc0-0004Qo-DF; Wed, 08 Apr 2026 15:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAY9w-0000aR-Cr
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:01:52 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAEoh-0000tt-Vy
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 18:22:41 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-358e3cc5e7eso2725210a91.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 15:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775600559; x=1776205359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U5qEYDYbzP6gv3T4kUPVLqSQIA87qzuUGpDgD/WJ/SI=;
 b=ZFs0XqJX01yLHD7+OvOjiuRunId/5Ri8qMruuLAH9V2VUw8CgBkXImsrWl25TkR5nD
 r8cY1m+CQdRmFIjKFV2DDP2ea4rkQKierHvo55lYdyspLceSHgOoNHe0gpp+CuGiYIbt
 PEQ1N2mhfE3keGetcYol6GdqSQWNI3gBUHZrpU07/HaoU3kL3Y3/YK0YAzVHm8G+Dz+x
 V5Y4E22AhutlmuRuuZMJNRR9UFz1QkFUKnb713d59N2wCDiD07irPVpUO/Pu6pbkTADb
 lPi+aUiKorVLB5h/gg9BXIUHQAt88+Yla6LZddSjS5Lfjprze/Ltl6LfSjwKtcQNPL8U
 lrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775600559; x=1776205359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U5qEYDYbzP6gv3T4kUPVLqSQIA87qzuUGpDgD/WJ/SI=;
 b=hCr0RCOfVDXBgkE4z3Nu2h14OKvwyzrizD6SPz80hn5bm5BW+Kp1qIxR9QuL9B5L71
 7Dt9SawnwYWZN4G13hRC8UVtPq9oJt7YvLets/lsqQRJFY1tVOBj8CrrzXLH6TReItkr
 yLSVC6M1lP2PbMv9ykY6QqTfPcW5o6E9I+rL2Y21vHr2xt5t/dUdPMwaAsLLZ8Ushss9
 izzndXXp3QUlidSQ/gO9PKALZWPbH2mS5zfOScMzyVn4CTgMLOwLymg4s1084S0lH9q+
 JZ1KjQTZgWO6JpPNV4TQwjIp6Edg7zS/Jq843difhFGbxazEk4asxnNUKngz2DqYxo1C
 Dg1A==
X-Gm-Message-State: AOJu0Yz7sJcFPqfvMaJI6io3rxoRPI2OlyCd8Kd8tgxGiDWtBsOSCkfS
 EmKuLB1vsm5OCLJ7aRSDwZt5az6fIPy/WESJiz8aoGdlW5pvjlC2UeAE+FElq614VjromG77T0x
 1FwBwE00=
X-Gm-Gg: AeBDievGsMJVSkiPZlcgOCuPEunvKHnEbAf1HkqbgYX/LfwCAHBUMScdd6i5HhYn0Ag
 q2gUKKD4agkkmP4wx3w5+Wl/jyLp99/azGGzy4kF9+ZGfxRmJUOfY79PoPYUi2E+1n7gDu3pg9g
 y28MNNjWffsNxYz4d2hwLzRCFsMSHbooqH7R2p9q9ZX4qkGb4HI0iOpr9HcNOGc8CmwvtdEU+Dv
 3kIoJmgBwm4ctuQiPP/tok17c8SOfObZRjiPPRkL9CdPzrJULyMR/Gutyxbxzfb3ozaWSvNONTm
 zOJhx2nb/BEkqks79YmXfDOpD0hIESz3UoGq1sMpuyY3pMiAEYNTEtPCWLvwM0xfa8U8IAfBf9B
 jeEgbyQHN6d4ZZjFnIshveUxGHLlSOUA2DcDMsFKAeGiixOyXcgCBR2g8AXIfuK9qNiT5I92evf
 jJJJzflKJ3Wr3sIlmDxV8u0hAstk430YU3YfllsNsLMVzcnBoSV0598+ObWNhJZzrvMzDgGdxAm
 Os2
X-Received: by 2002:a17:903:b8d:b0:2ae:fc60:2650 with SMTP id
 d9443c01a7336-2b2817b24c3mr185697845ad.39.1775600558634; 
 Tue, 07 Apr 2026 15:22:38 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d5csm180412065ad.38.2026.04.07.15.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 15:22:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v11 21/21] target/arm/tcg/translate.c: make compilation unit
 common
Date: Tue,  7 Apr 2026 15:22:08 -0700
Message-ID: <20260407222208.271838-22-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
References: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
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

We removed all target specifics, and can finally compile this file only
once.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 0740de92c1a..506f031f1aa 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -20,20 +20,18 @@ mve_d = decodetree.process('mve.decode', extra_args: '--decode=disas_mve')
 
 m_nocp_d = decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp')
 
-gen_a32 = [
+translate32_d = [
   decodetree.process('a32.decode', extra_args: '--static-decode=disas_a32'),
   decodetree.process('a32-uncond.decode', extra_args: '--static-decode=disas_a32_uncond'),
   decodetree.process('t32.decode', extra_args: '--static-decode=disas_t32'),
   decodetree.process('t16.decode', extra_args: ['-w', '16', '--static-decode=disas_t16']),
 ]
 
-arm_ss.add(gen_a32)
 arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64)
 arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
 
 arm_ss.add(files(
   'cpu32.c',
-  'translate.c',
   'm_helper.c',
   'mve_helper.c',
 ))
@@ -66,6 +64,7 @@ arm_common_system_ss.add(
   m_nocp_d,
   mve_d,
   neon_d,
+  translate32_d,
   vfp_d,
   files(
   'cpregs-at.c',
@@ -77,6 +76,7 @@ arm_common_system_ss.add(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate.c',
   'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
@@ -88,6 +88,7 @@ arm_user_ss.add(
   m_nocp_d,
   mve_d,
   neon_d,
+  translate32_d,
   vfp_d,
   files(
   'debug.c',
@@ -96,6 +97,7 @@ arm_user_ss.add(
   'neon_helper.c',
   'op_helper.c',
   'tlb_helper.c',
+  'translate.c',
   'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
-- 
2.47.3


