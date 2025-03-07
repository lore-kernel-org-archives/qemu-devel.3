Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F24C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZd8-0007Ci-Vf; Fri, 07 Mar 2025 10:28:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZd1-000733-Qo
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:28:49 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZcw-0001ot-U9
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:28:47 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-391342fc148so533304f8f.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741361321; x=1741966121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=F3KuVTn8B611IFPyA6Mi2UlNCZvQYZ1GukXvvGw/PZ0=;
 b=ASZW8HP1ZYOI/iVCZH79Ou0jvMQFlX3ZKg1utk//OzNqVVSIR1mm0ZBX3hDdVrQ77h
 1iy2Fm61tkFVNybHiTwJbwmrw9HEYf9pYzr7v/ptfGfK5lbv7LbBE6Jl5nVeeSOJnyXN
 je25OMTAyikV8LoQjuy9WO7Lkh9X0W5vX8mbUrIPVLftsGZ45qUyZNmoLENuZrMBZiw+
 qkZkPRtNV7/XFZNR7A9D95TOpGxErsYIm5G5pD4Zy3Wg/s7WXy4xYkciu4YOOTBTSi7z
 hr/coJHrF1DKMoiwz6rLIVgz/MCe4oRUfDeH/F5ucI3QDucOy0mSVhvUFpbOlfnirAA8
 b9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741361321; x=1741966121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F3KuVTn8B611IFPyA6Mi2UlNCZvQYZ1GukXvvGw/PZ0=;
 b=FSTjQHJLWVVzq80u5gyWE5oYPGDXHAOiuMfaW4+SSUrgsIXSOnTTn1J2qKSGgLJD3t
 CzzRHtHkmPpvQv7XNbSLZj5QlzEdojfMlby30DwBGDyBH7F0t+AWxjTlaFeoCvOYnRRl
 icDcddNuKZ3bO+szSTIU9bkFMSBM354KroBmf0uAm+4qWYiLZ3f+Wtdd0BcQqyyAV/2d
 DBajFmU1mRbFcrFdpG3C7Gpc6FBKhlbdEngMk3VQHN67ff+CRDJaiVKi1b74Zqd0uoEj
 elWbf7c5SJUTVMAEyZXgcNE+gQTbYFnIKto3Y3mGRb5Nt7JYYSUSreCf88LjEitEwiUc
 fa+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZkQwrhnd8hgMXMrsevJWnjuAmXGxlpzbOhODvv9FPM750OstxgKTlnDBLgLbffwVo+FKR4KwdmU6w@nongnu.org
X-Gm-Message-State: AOJu0YzpoWMURvrWEtHVn9c72nR1dMlIVp/968lAnSCczUCxLN3ogesK
 7cJ0phXWAzemhRrNDpsGE1J8jocywvpBwy3bEteJpJw1Suo3h189vcq7Dii1VEM6JYT9zIJwuRW
 d
X-Gm-Gg: ASbGnctqk4bLWYdbCDQ9kh+KBRvEYdasQb+sYHEuZFl6nu1h7eYsTTJBXH07JLN0txX
 NH5MbAxqhqVfraZ8bAGh4jG42EZgvxgct9D2y+VhOJ7Fz5gynhki0vuibXspaeyZiiGvSTmip6E
 CRL6+1zDmxH7r7myfup+HICMpfJRTHBgkQZAIE1wWB7CB9595OfuVWLXfX9Y4vSJm63F7r+wsQl
 LgsaRcGZ3MV8rd5RBoArabR1LI5wgdlzCqsGcOOj34qR1zMeMrwxGUQkMMG4qXeeHjSKLAlQqAz
 ajPNMbJXQ6pI0i01ax4jCjfc2XWBX3zeyh7eQob+6HAzC3LQyqE=
X-Google-Smtp-Source: AGHT+IGpM1yB34YCeM5ATo05udrHVgTPsMyRqdYxDa2p4dWiFie3hzZpJHoVaCFq92EdW51AeQa3Lg==
X-Received: by 2002:a5d:5f8f:0:b0:391:2e31:c7e8 with SMTP id
 ffacd0b85a97d-39132d66e3dmr2590353f8f.2.1741361320897; 
 Fri, 07 Mar 2025 07:28:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfe61sm5748750f8f.38.2025.03.07.07.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:28:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] MAINTAINERS: Fix status for Arm boards I "maintain"
Date: Fri,  7 Mar 2025 15:28:38 +0000
Message-ID: <20250307152838.3226398-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

I'm down as the only listed maintainer for quite a lot of Arm SoC and
board types.  In some cases this is only as the "maintainer of last
resort" and I'm not in practice doing anything beyond patch review
and the odd bit of tidyup.

Move these entries in MAINTAINERS from "Maintained" to "Odd Fixes",
to better represent reality.  Entries for other boards and SoCs where
I do more actively care (or where there is a listed co-maintainer)
remain as they are.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Somebody was talking about OMAP on IRC and I was shocked
to see that we claimed it to be in "Maintained" state :-)
---
 MAINTAINERS | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5df6020ed54..29aa32158a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -786,7 +786,7 @@ F: docs/system/arm/kzm.rst
 Integrator CP
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/arm/integratorcp.c
 F: hw/misc/arm_integrator_debug.c
 F: include/hw/misc/arm_integrator_debug.h
@@ -865,7 +865,7 @@ F: docs/system/arm/mps2.rst
 Musca
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/arm/musca.c
 F: docs/system/arm/musca.rst
 
@@ -913,7 +913,7 @@ F: tests/functional/test_aarch64_raspi4.py
 Real View
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/arm/realview*
 F: hw/cpu/realview_mpcore.c
 F: hw/intc/realview_gic.c
@@ -963,7 +963,7 @@ F: tests/functional/test_arm_collie.py
 Stellaris
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/*/stellaris*
 F: hw/display/ssd03*
 F: include/hw/input/gamepad.h
@@ -993,7 +993,7 @@ F: docs/system/arm/stm32.rst
 Versatile Express
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/arm/vexpress.c
 F: hw/display/sii9022.c
 F: docs/system/arm/vexpress.rst
@@ -1002,7 +1002,7 @@ F: tests/functional/test_arm_vexpress.py
 Versatile PB
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/*/versatile*
 F: hw/i2c/arm_sbcon_i2c.c
 F: include/hw/i2c/arm_sbcon_i2c.h
@@ -2006,7 +2006,7 @@ F: include/hw/hyperv/vmbus*.h
 OMAP
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/*/omap*
 F: include/hw/arm/omap.h
 F: docs/system/arm/sx1.rst
-- 
2.43.0


