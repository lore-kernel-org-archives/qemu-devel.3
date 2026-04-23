Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3CAF99368
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqta-0006OW-KM; Thu, 23 Apr 2026 06:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtZ-0006N4-04
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:53 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtX-00023P-Ak
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:52 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d75312379so4751242f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938570; x=1777543370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g9YvA1O3UTs0XbhIrlFOBKfilX2+X6JufRIf4Y5Kogc=;
 b=EI8m0lKEnwcr8DO0G4o5Tlp6CGacPixeZjc9QGmXCFH2cGcwwSB8s2ACx/J9vV8kT0
 zoiPoutYRI0xk1V7dT6XBtjU5Cenxmnxt+esPOD8l9p01hXXVFY6VcP8+5OqRdBmAJLy
 dLjeYVKN9pXHjDNyh6SX5WZkZSj3Ctq8/S+LTLpdpgE0+1Gys5wwH4A8iTkeErd9mfgS
 t07aeuiKd58mtjTVTjPeWa4lamEYzYPtmASvEEeFyz6hZ1NWm69aGEa853iKsoj2/aHk
 tozI/sgWkI1yd6pb70gZCiXXGG26tFbM9SKjXDaF6J+pkPcXdR5sv9wWdzaBy9RhB5d1
 FZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938570; x=1777543370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=g9YvA1O3UTs0XbhIrlFOBKfilX2+X6JufRIf4Y5Kogc=;
 b=XP5VRab5859riG0+ObOE7oKDXkZQl18SPc/KF6sa8ayUdOwZOJLwkRyo1jEV2DOU6B
 xefGcqutPuxHY+UIYfspgRk8i9pVbBg2wupuy+osE5wt4WSnd3D4n+7ItoXcBunZceMx
 VnnVGZiB01aCF+i/RuDL0OhRcl55vrRN4remhT5Ufh17N3VwSFMPDAOo7ur3ppsz1HGm
 s/pRlY3QObcjtVO6gSjzmOwvtWTOnpc+WEbsS5idW8vud1R8yxmRI8616vPwXuZjfD5M
 rZCWhjn7CQw6BQEz/gDK1V2T+cAf3WlHzKnu0Ljvj9HYG5zSC5OCyZCwuWw/wrMaRmnY
 FWTA==
X-Gm-Message-State: AOJu0Yy6JA0EtOQzdSWs/RPdO8Y2qYNqvpwadWmrwVIuX2XJ3D61grKg
 Bi8VfrG4jFMZ+SCcpQhcmODCBTG2A73fl2f3/V9ehnUTofU6ARIm+NVX5cb4w6uTOVkB2ZXB7zp
 wWABN
X-Gm-Gg: AeBDieuZE+3TSZGHsfpbmy2WAxm2ZHEZbkNuXpRixkSqXLYonyUBH84TLjSJWc0IRPV
 X+gSowzFIkTDnXH20zr+dUaF/lz+zwlp6kkpxiEIOvYZxIiY0GMbtTBuRU4U+6pLX5YU3/MUCIx
 sEQmKvks0HbfBxpMmGxcvXihpiGexpO5VmvaRgCP99DwBh1AniIK4fjw/n6sNo9DMoEdYb9HCA8
 mIrOqIBTF4A9qQFeXqL5bg1MhVW3Pd404NZXhRL8ZR7/hfldDRo9llvNI7i7U5iWsEvigJIUWqJ
 0Qhd/u7Qt4yk2nDukWdZsVLh169POyWmfT5RzgCygc7M88hDtdKMSHr8TV83SZYXRB7E5tZybLE
 r0yqq285OyOUYHD7s9sQ0KsFwnzL/szEVGilYiVje+HKaD3JtvUDooXoEbbF7g/X7t63C6ItBih
 dwnsOIVkLkKS22LZnopxEs8auUoBnNhfKSQ2bWpyIh9ZMkZ7r75dKiTsZuGIsLUEBp53n8bAq7y
 RdKZVESx1hO24ZLJhhJNOSKrwNesHFEGctHgugE5Q==
X-Received: by 2002:a05:6000:1ac5:b0:43d:73d4:b1a with SMTP id
 ffacd0b85a97d-43fe407c0d8mr41820384f8f.19.1776938569595; 
 Thu, 23 Apr 2026 03:02:49 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.02.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:02:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/59] target/arm/tcg/translate-m-nocp.c: make compilation unit
 common
Date: Thu, 23 Apr 2026 11:01:47 +0100
Message-ID: <20260423100229.2941820-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260407222208.271838-9-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/meson.build | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 89c3b47682..70beec7a6c 100644
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
2.43.0


