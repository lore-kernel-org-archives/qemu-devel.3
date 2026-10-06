Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48942CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENAo-0005JZ-Sf; Wed, 07 Oct 2026 04:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEIS8-0003zo-Ec
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:36:36 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEIS2-0008Nf-9e
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:36:21 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5ba3ac592faso4174135e87.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 20:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791344116; x=1791948916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MewfHFxCBjuMnAba+cWeGMRb7nH3xWgUzUxej45VPmE=;
 b=er+L0azU9y2URdPNOfmOdepkHQYnmyYRFr7zF3zk5eWkrRnTfu/dJhn3rSQLD8nS9m
 GFbkpeJi4WdTRUbgEzF/YwDV1pd992GaSt6ZecprUdS5UnXawn0gh5xwNTIqK1yqVOHk
 MbqvlxO6oxvSp222VhB2z4OQnlPNvwVEL4uoJpOpcAaKaqvdzFMsZPSNZDczYUGY/f4s
 tPK+uoQbOXnXGlzawn1qQtT5U2DHBYG3jGNt6iS+ZcdirRYk55qF+thStk6czYaqTRvR
 oxsnUVfWSp3UXATdV208Q+yApea+XlrsAd9w9llT8HuPGVqOrImPai2GZOjsdo3BwVUd
 Xh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791344116; x=1791948916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MewfHFxCBjuMnAba+cWeGMRb7nH3xWgUzUxej45VPmE=;
 b=CcEKL/u2+BXZuuz/zrMCFpYEl9EGFBlCtuHc/ffhEaivrRO64fTo6xPVsXv9xzua6G
 Twh9kO2NzpGvUdscWPkmFByALsAKbYquHldlfpoD8w1hwJZW42lV7kKtchW4zWunlEZd
 Y3vfW5hq2gku1yGYTh23ZiuQKThflqE/kqbYx8jW3QiPYJxUZs/KNjTr5Tn0leqcX6gn
 /pmbaWJrouycdYFBxfOC7dLbjYecdL76+5npjGtyGP/nZXkqiOlMV2ivt42zZVv69mz3
 uMySpbb/HRYVWLAxi6Kx/yBfeZAjn7nhej+7sdijHYXLthVKfRTgza2JTgGh3Q2BC1cA
 /7OQ==
X-Gm-Message-State: AFq9FYI8/XtR1RMsTH7+0tHnW+hBTr6rVHM6CZOLfPBRZCSfvBDSjywc
 BNKBDSB6O7dyXfsurC93ZOfsTO1Hb+kCLe6sGIUwnYjh3Tih2KTH1IGexHWGvg==
X-Gm-Gg: AYBFou2l5KqE7O6r2dNYU+3AjdD7HCPiIUtwCdha9IxjAf5tVVzsY97ZwuaTj3SAXig
 hU5qwPMi99ms3a1MhxfaCgqlfApKEYWTOPcrg+jJ4CV04eKoqmOFAT2G4ufc7PQ/lpe6uiOZdiy
 CW6Yoj21sMubDx3iT7G5DLZzHnYrH8qlxPZc7AHcJ6/FY0dxRsWvx3wdzUALQ4ORQU9X+Ebp1sp
 QLSik6UaFk1YQ2ABOZwXvEkMN9TpLBnqji6rZcZjQXHgB9UD3GLuU//ePGJZSPD9JKiMHBptal2
 USK+dcf3R4rEZL4qEBvoGzGzPtVM/nfGUM72XcL+f1LQr2E2hw2MQrbW5fWeVTjZR3nwDWiFOx0
 01Tr3F7kO5MDMgWRisfB+VuzRmhztHxANdeHr0NHteR8oWEm+JLoBUwk90dvFjKRq2qtstdORtY
 +qFA5Le00MSKyrVQeSyr9uGJJIEEhYcYN/DIVFy/1zfLkIQ8epfEEV/7Pjy6s28d+eJS6YQIvl5
 jTdLSsZTuz3bXtPDoEmM0e89JEJ+sj8iz5BYQ==
X-Received: by 2002:a05:6000:4a06:b0:48b:b1a0:5926 with SMTP id
 ffacd0b85a97d-48c47fe7917mr18295557f8f.18.1791275746063; 
 Tue, 06 Oct 2026 01:35:46 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:45 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 21/31] Kconfig: Extract config FSL_IMX7_GPR from config IMX
Date: Tue,  6 Oct 2026 10:34:33 +0200
Message-ID: <20261006083445.30362-22-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Over time, QEMU has grown a number of i.MX boards and the monolithic
config IMX drags in unneeded dependencies into each SoC model. Extract
config FSL_IMX7_GPR to eventually eliminate config IMX.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig      | 1 +
 hw/misc/Kconfig     | 3 +++
 hw/misc/meson.build | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 2084813e1c..51fa2e2ee4 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -579,6 +579,7 @@ config FSL_IMX7
     imply TEST_DEVICES
     imply I2C_DEVICES
     select A15MPCORE
+    select FSL_IMX7_GPR
     select PCI
     select IMX
     select IMX_FEC
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 3f17d29053..cf9ea68219 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -97,6 +97,9 @@ config IMX
 config IMX_RNG
     bool
 
+config FSL_IMX7_GPR
+    bool
+
 config FSL_IMX8MP_ANALOG
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 61e128ab7a..c31c173e5a 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -60,6 +60,7 @@ system_ss.add(when: 'CONFIG_AXP2XX_PMU', if_true: files('axp2xx.c'))
 system_ss.add(when: 'CONFIG_REALVIEW', if_true: files('arm_sysctl.c'))
 system_ss.add(when: 'CONFIG_ECCMEMCTL', if_true: files('eccmemctl.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pmu.c', 'exynos4210_clk.c', 'exynos4210_rng.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX7_GPR', if_true: files('imx7_gpr.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_ANALOG', if_true: files('imx8mp_analog.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_CCM', if_true: files('imx8mp_ccm.c'))
 system_ss.add(when: 'CONFIG_IMX_RNG', if_true: files('imx_rngc.c'))
@@ -71,7 +72,6 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx6ul_ccm.c',
   'imx7_ccm.c',
   'imx7_src.c',
-  'imx7_gpr.c',
   'imx7_snvs.c',
   'imx_ccm.c',
 ))
-- 
2.56.0


