Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1635C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lrz-0006Wu-8j; Mon, 21 Sep 2026 17:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrw-0006VR-7y
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:12 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lru-0000Kn-8R
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:11 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912e4ad9so20229695e9.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027279; x=1790632079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dKNtXcPMeji9PuvuX2zrR8D0ie2/frNPzZFcUmB845A=;
 b=CFIe1aOwHHxwRMqTDZ3lolC3DJDNOFBbUEeMIQAi+MX5eS9PiefN7lBLSMGn2HmNXt
 IngHLjSlp/dysKWOIIoUrpk6dmn7dpynK77A2UbAzP6m2wnhoJ+vnyos+Z7i4a9pIdBY
 PDJy3+is1/9oSnJjopoOfwX315SqPkXE5ZSA13aXYJvDN7HLOo/tyAPfH2wtZQlsD6RJ
 lBQI6gV5QgEkKZjOjl7iCg1lXeAo80BLjHCbP6CugpvqyqsYb3NBRvaFvc/9xFeF+GaS
 AV6bVIxV8ct2EFEo+c+uFo/uQ7mhaF8oTItQuLrf4hdLLMAZiI20Q2GdLRZ8tlsF53kq
 iKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027279; x=1790632079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dKNtXcPMeji9PuvuX2zrR8D0ie2/frNPzZFcUmB845A=;
 b=0Uxhs9hg9nTAxOaWlJ5aXvZvGXEnhskIplSSBBTkoaK6ewy/kLD314AMpaHO60AEZK
 L6EEmyNdP+Jlm3z6tb2KkfVCkO6vy5uxD51PObKKGhEG8RHjfSxGVr2ad/ilZdS/Qfwt
 GnpaQyDOZTf6d6k+H+Q7/4OWOK4aWDm95mvEuH5J5Yby4UyMndtbgX7z9B9Rowza1EEb
 USTOOsGxOtn0c5RW7Mj9XQB0d1hLhrlgcVVYxH/P1w0DCoqBkWSNl60w8S2ncZLjZ0WV
 h3J47Kc0tCGd4JSN5LnT/RbOJwuzV+FvAgoUdG0awBpWaywDeEadcBnDdtOPBvtmxBqF
 UOdw==
X-Gm-Message-State: AFuF++mrytx4HfRHPcScOI7JT4D0vr3AYzqab4Dl501pBeNEIM67J0JC
 +VmeGYRsz1iUXGaRXA8sZzJKyONK+hd2dee4HdH3sIUop0cBsxXfUqRSzB9jUg==
X-Gm-Gg: AYBFou3BdrAQ3P6+ytjuWKkqyZ4S4d59qwFUPRVwl4J8CztSzIE0AakuRfE5RLLGRV6
 8anrEeGVmL5/n7B3QOJlSWr62JHaVkzsX02gnZ8mLtGidNwEGvPz3xU68J8j2EImeSiMkTs0tpa
 jmt8p2xfQc8tdPPljk5Ggul41gA1HW4UmE+w4/T0j4PsoXb8ny5Wp4lhT64w0Rz0VPqJ/ZKtpb+
 ZkxT6PWnJjGbYzXOTyE4OCMY1Xg43x69V2BEBaizMCA+RWM5Rlr2eAV28pfUvHAPnYFTbC/az38
 avAMBNl1xkOm324ZsgfJk0BL7gdFMthJ/M1BsjR8E0XMT3Uk2EBPsSOYZqwfuURkxYL2upDKfo3
 nHM818AcMmXMoCxks/Hw7GBY3cXjPWRDugbiv6qxPF9e2df6cMpofVxdWrywSjc9Sy3Xcxx0/cm
 7IKh7mCebJnYR5Ki05SQYs/jUyqK856/4JdY4o6vF4e3DjBBHRVrOTqLIQpnHxDuPe6UiWG1Aba
 eJjQ8iA0nhXfgJXDfGOMHegIETnwJ2KATVKyyl6dDHxIa0OcMx4HzxnVh87wIEIjGnm4Ms7haG/
 Q+qodsDXxKJ/vQ==
X-Received: by 2002:a05:600c:310d:b0:49d:15b9:2a2a with SMTP id
 5b1f17b1804b1-49fc5721b9dmr182673765e9.10.1790027278806; 
 Mon, 21 Sep 2026 14:47:58 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:47:58 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 24/42] Kconfig: Extract config FSL_IMX{6,
 7}_SRC from config IMX
Date: Mon, 21 Sep 2026 23:46:52 +0200
Message-ID: <20260921214710.29422-25-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Over time, QEMU has grown a number of i.MX boards and the monolithic
config IMX drags in unneeded dependencies into each SoC model. Extract
SoC-specific config FSL_IMX{6,7}_SRC to eventually eliminate config
IMX.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig      | 3 +++
 hw/misc/Kconfig     | 6 ++++++
 hw/misc/meson.build | 4 ++--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index d3dda015c4..7e909485e6 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -504,6 +504,7 @@ config FSL_IMX6
     imply PCIE_DEVICES
     imply I2C_DEVICES
     select A9MPCORE
+    select FSL_IMX6_SRC
     select IMX
     select IMX_FEC
     select IMX_I2C
@@ -579,6 +580,7 @@ config FSL_IMX7
     imply I2C_DEVICES
     select A15MPCORE
     select FSL_IMX7_GPR
+    select FSL_IMX7_SRC
     select PCI
     select IMX
     select IMX_FEC
@@ -661,6 +663,7 @@ config FSL_IMX6UL
     depends on TCG && ARM
     imply I2C_DEVICES
     select A15MPCORE
+    select FSL_IMX6_SRC
     select IMX
     select IMX6UL_LCDIF
     select IMX_FEC
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index cf9ea68219..193a6b5f56 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -97,9 +97,15 @@ config IMX
 config IMX_RNG
     bool
 
+config FSL_IMX6_SRC
+    bool
+
 config FSL_IMX7_GPR
     bool
 
+config FSL_IMX7_SRC
+    bool
+
 config FSL_IMX8MP_ANALOG
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index c31c173e5a..477fbd60fa 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -60,7 +60,9 @@ system_ss.add(when: 'CONFIG_AXP2XX_PMU', if_true: files('axp2xx.c'))
 system_ss.add(when: 'CONFIG_REALVIEW', if_true: files('arm_sysctl.c'))
 system_ss.add(when: 'CONFIG_ECCMEMCTL', if_true: files('eccmemctl.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pmu.c', 'exynos4210_clk.c', 'exynos4210_rng.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX6_SRC', if_true: files('imx6_src.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX7_GPR', if_true: files('imx7_gpr.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX7_SRC', if_true: files('imx7_src.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_ANALOG', if_true: files('imx8mp_analog.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_CCM', if_true: files('imx8mp_ccm.c'))
 system_ss.add(when: 'CONFIG_IMX_RNG', if_true: files('imx_rngc.c'))
@@ -68,10 +70,8 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx25_ccm.c',
   'imx31_ccm.c',
   'imx6_ccm.c',
-  'imx6_src.c',
   'imx6ul_ccm.c',
   'imx7_ccm.c',
-  'imx7_src.c',
   'imx7_snvs.c',
   'imx_ccm.c',
 ))
-- 
2.55.0


