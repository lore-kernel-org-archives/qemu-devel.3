Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30E1D232E3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56p-0004he-RW; Fri, 09 Jan 2026 00:32:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56m-0004Vj-VX
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:24 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56l-0003jw-H7
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:24 -0500
Received: by mail-pj1-x1041.google.com with SMTP id
 98e67ed59e1d1-34c2f335681so2386061a91.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936742; x=1768541542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y6SmAjX10enGgnY+6exZN8V+CFLnPkSqD+E6rjz6Klk=;
 b=EE2+/P0rSqPyC7junQhaVQmj7ZYef5yBwJjxrEIHuqONbcp7Sljyl/pXdTYCAkEt7W
 9n/JpCtsTOluzo3LV0jLbhaVpGvsrkeQk6vQCKKJiPzLThIsKZ24VwWCsM8+qx8XY5HI
 BLHF4rbtcae/82I/3DhI4hw/+vdxIipfOHwGrjv0V2WxT696IgGMcSwWTUrQBM7NN7yD
 sesNv5DB4z7NzTgdi+jghb+pjuGqBdOhZe/7FTbBSKf5L7E+e+IMWFs2d8CgrQH/iXTN
 XMoJ6C2wIC34eiwdGzpqtBx1J/PYeDb/vns+49/86VgZOeNDzKmsEaeUUnbE/KXmbJ0F
 HICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936742; x=1768541542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y6SmAjX10enGgnY+6exZN8V+CFLnPkSqD+E6rjz6Klk=;
 b=R4/j+ii1egU2p3AiAFjwQP646o+Lq/MJKeIEdxsOi1PND9J2Kwuzd5lS4On7a+N1RT
 SZFJWdE2zo6K48z8NmPz2k3A06DsI0MhbKPrKvzyLSTB3w1qjkXpHIdjaeCWdlPo+Rw3
 8Y5mC1dFigHaAbma5uH9BJGXrUJh4R5Lfr6INk+1mDXvZD5Xm5J38+ocE719YjKRX9ar
 dywWYDU/XdafS8y/o/YPAneIZhSvGkvKzWGlGW6I+at8CWQ7ocjq4aiztOxleNVz4SNl
 02kZn13tq8CaBMMv+TqSC9mk3ha4wN82DzjPbcY91mky2/hGPooSxbiBiX6hJxECOi17
 jltw==
X-Gm-Message-State: AOJu0Ywazm0o5QN29v+Sr6/Hb7dJ3Z3B0AI1MVVRqbm5ANn4j0fNDCzC
 0eJvy7GLslJrAENVfHU6Lh4ykkId+QUWenrMQvrCoPHk0ieAoNErw7zYbYBFJOfaArd0aSFg0ca
 x3nLcAmk=
X-Gm-Gg: AY/fxX79pnc8kmO/UWTdFxZ+GP2NhUSUDgjTfX5QBKFMckDVIacjlMzAx7zVgubkRT+
 wkOl+1nCKTceyZ6N15KcQRbv2Rxz0CdvYfGYzMpcI97SA91Do2Swldh94y+DXvbVR3z3GjUpuRb
 k29sbAHe4tGFHgRXPhh6Ke3yzOIcKIAbuwfHwCX/kbYtllPws7/ACaua2dWMRmIkjSGC615aakB
 od/SDFWIVRmXoutWtxvbsxmmNd3ba+l2wvWcEMUkBH5yqvLjQuLE/ymTlYr/tn7t+KOc1MG4QHc
 /CfLn+5+ky/I3AKfyJT0mQE+Ja2BbUSySmc7eQ7zSdPzUOsoROcW0sh6TQjSovRaVz8mFtAnsWh
 xkTJmivQLa+EKmxiL/41ZCjQhJBVHxGM2z7M088gxB3TABfz5UVcOhW0kjMYW+L+2+g34LrI6Nn
 yB9Q7jqrIzy/war2QXt7QX0PY935BsIJmyNKiSxmhr2oDXMDQ3cxgNoxNaLuKzJ0sYa0KboZP8w
 Ao=
X-Google-Smtp-Source: AGHT+IFNlF5WQgLe0FoJ/frOi89UGbXvDc6gYGQU/ErO+4e8pu/bmQBFaYMIw7CDP2YEbAr6/nHjbQ==
X-Received: by 2002:a17:90b:35c1:b0:340:9cf1:54d0 with SMTP id
 98e67ed59e1d1-34f68c339a8mr7138336a91.1.1767936742202; 
 Thu, 08 Jan 2026 21:32:22 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:21 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 20/29] target/arm/tcg/translate-m-nocp.c: make compilation
 unit common
Date: Thu,  8 Jan 2026 21:31:49 -0800
Message-ID: <20260109053158.2800705-21-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1041.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate-m-nocp.c | 2 ++
 target/arm/tcg/meson.build        | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-m-nocp.c b/target/arm/tcg/translate-m-nocp.c
index b92773b4af5..bc9efd2bbd0 100644
--- a/target/arm/tcg/translate-m-nocp.c
+++ b/target/arm/tcg/translate-m-nocp.c
@@ -18,6 +18,8 @@
  */
 
 #include "qemu/osdep.h"
+
+#define TARGET_ADDRESS_BITS 32
 #include "translate.h"
 #include "translate-a32.h"
 
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 24276f24dc0..318a951e4d9 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -27,7 +27,6 @@ arm_ss.add(files(
   'cpu32.c',
   'gengvec.c',
   'translate.c',
-  'translate-m-nocp.c',
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
@@ -61,6 +60,7 @@ arm_common_system_ss.add(
   decodetree.process('vfp.decode', extra_args: '--decode=disas_vfp'),
   decodetree.process('vfp-uncond.decode', extra_args: '--decode=disas_vfp_uncond'),
   decodetree.process('mve.decode', extra_args: '--decode=disas_mve'),
+  decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp'),
   decodetree.process('neon-shared.decode', extra_args: '--decode=disas_neon_shared'),
   decodetree.process('neon-dp.decode', extra_args: '--decode=disas_neon_dp'),
   decodetree.process('neon-ls.decode', extra_args: '--decode=disas_neon_ls'),
@@ -71,6 +71,7 @@ arm_common_system_ss.add(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
@@ -81,6 +82,7 @@ arm_user_ss.add(files(
   'hflags.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
-- 
2.47.3


