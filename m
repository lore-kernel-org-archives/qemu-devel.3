Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5ED2C982FA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lrp-0006Oj-43; Mon, 21 Sep 2026 17:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrm-0006KC-Vt
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:03 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrl-0000L0-4N
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:02 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485b1d2874fso1262950f8f.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027280; x=1790632080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bg5zoyVfJxoWoXzrof0JerE9989WGIwGQekCeUS9KFE=;
 b=sysoZJrONj56g+mQvX9xwtpTLHhbbkEVzLiWpcTqE4NWNoEwlLD+kkEdAHiWZH5pF0
 VSC9GpBXbCFfyFn16igzRZeT4oi8Hoae3o3nXx6wUO8Iku/GB4PmVWju4JMp9IqFoMJS
 l+5IIq40T/TPrX1yFN7xD/6sXJF2T/SeqiLEVcMDUDhETlNQEJCtxWmzMZcjZ29JGYOp
 FySC/gTgktpfWbP451zJNbfyjAhIyQsux2G/uFkD3TuuTzlxglFrzRczaYf1tZRfAicu
 0+Bvo8mK3dg9EnewmUuKl5Y/Xgsslc9QLRxfHVifaL3JD6W5sOIumg5eznhpnFbtCVsd
 vL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027280; x=1790632080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bg5zoyVfJxoWoXzrof0JerE9989WGIwGQekCeUS9KFE=;
 b=oaIW/OiRiEslYpQCPORDTh+DVj+Np7nn9PNFq/AcKAb54JUmcArMx8PnAmktsuZ0Th
 9L5Kjahj1spm+L6rYxd10LmzNKgPKgGjBwgfKghD15Sw7+B7i0CCjgZIxvzktuZ+Z6WV
 IewYbAI14Tytxm0Nz5k0d1Uxm9kA3CJUsjAW+guf4By8JZXFe0LEohRPa3KRZvz5V9pC
 3KL5BYbGylXk2es1423w9E0MCRSadRyDRiHbbXQeUdUrgblmUDnCaU6CN5p6+FkB2DIY
 4EkXPWteH3AlmbXFuEhZPCo8aaeQZfOrsd2DaoeFg29X+5arkCx5oVnPZBom0TCy6lMy
 E5jw==
X-Gm-Message-State: AFuF++nQr5tWiyQZ2AYHg4SyeYTtGdpQbRqM1PT89mCp9Mh5fyvwfxIt
 q7IHub4w0ZTkexrBR9Oapy12Iqcp+FEd4Qeh+UX8Pb1VdY2ypjNIyC88i1bgBg==
X-Gm-Gg: AYBFou2VzEWPZEiHMqrG+1EkWvEYyMPwogwM/USaxASLO9RUxd80/tUnvE5Ym8l4pAc
 qPgTkpWZdfFCJ1xz05Iaklc43Pge8Ms/XyUQxR2kJ2s8GhCe43Hqe7fPt3oqzxtrh+8WAZ/cUAc
 NrlVkv/jXfrvBXz9Kv2VdjKWGzdiGEm5juC/xcdtHuiTwTmRR94BYGFTzp0qqKBjYhUFzPdC931
 pHIfi8ofiJHZD5xMUy9qWrLHr47efRX9fEY+9jCAu6BFtV4g9wNma5IwWZHMIbFnQVyrz1ELhbs
 ov2YUSB/hrN3LwRZlcDrvcJGErqWJ8LG4eAUCL5HmSG79h+BypgVMZB+BoS/1WT2LwGyD06xSCj
 Z+7KhDYoigH3AT+nVR1fbSbzxLDsENhqnaZz8OR2UvhDbBtUJw3/aRTnVu2TjR7+zE1Vkju0PNg
 aej6+QYsFkhHgFlDF1qr7i+aTv2ofHErFO6COw0M2EhSRhhS96qlPyBsp00TkN1qsONNhyR2dWG
 4sGPs9ppjuITmaRF0JJ1NvtDgctSaQlsCIEEWKjf7ONZds0uGVXCi6suPrwdRipanU88Xlai0aY
 nUVOEPUaujsPVQ==
X-Received: by 2002:a05:600c:4e53:b0:49f:ce79:7a8d with SMTP id
 5b1f17b1804b1-49fd8a731c2mr12382745e9.17.1790027279774; 
 Mon, 21 Sep 2026 14:47:59 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:47:59 -0700 (PDT)
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
Subject: [PATCH 25/42] Kconfig: Extract config FSL_IMX7_SNVS from config IMX
Date: Mon, 21 Sep 2026 23:46:53 +0200
Message-ID: <20260921214710.29422-26-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=shentey@gmail.com; helo=mail-wr2-x10.google.com
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
config FSL_IMX7_SNVS to eventually eliminate config IMX.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig      | 5 +++++
 hw/misc/Kconfig     | 3 +++
 hw/misc/meson.build | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7e909485e6..cd9ddeb822 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -505,6 +505,7 @@ config FSL_IMX6
     imply I2C_DEVICES
     select A9MPCORE
     select FSL_IMX6_SRC
+    select FSL_IMX7_SNVS
     select IMX
     select IMX_FEC
     select IMX_I2C
@@ -580,6 +581,7 @@ config FSL_IMX7
     imply I2C_DEVICES
     select A15MPCORE
     select FSL_IMX7_GPR
+    select FSL_IMX7_SNVS
     select FSL_IMX7_SRC
     select PCI
     select IMX
@@ -599,6 +601,7 @@ config FSL_IMX8MP
     imply PCI_DEVICES
     select ARM_GIC
     select CAN_FLEXCAN
+    select FSL_IMX7_SNVS
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select IMX
@@ -624,6 +627,7 @@ config FSL_IMX8MM
     imply PCI_DEVICES
     imply I2C_DEVICES
     select ARM_GIC
+    select FSL_IMX7_SNVS
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select IMX
@@ -664,6 +668,7 @@ config FSL_IMX6UL
     imply I2C_DEVICES
     select A15MPCORE
     select FSL_IMX6_SRC
+    select FSL_IMX7_SNVS
     select IMX
     select IMX6UL_LCDIF
     select IMX_FEC
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 193a6b5f56..4d47de6a02 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -103,6 +103,9 @@ config FSL_IMX6_SRC
 config FSL_IMX7_GPR
     bool
 
+config FSL_IMX7_SNVS
+    bool
+
 config FSL_IMX7_SRC
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 477fbd60fa..48c5c20455 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -62,6 +62,7 @@ system_ss.add(when: 'CONFIG_ECCMEMCTL', if_true: files('eccmemctl.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pmu.c', 'exynos4210_clk.c', 'exynos4210_rng.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX6_SRC', if_true: files('imx6_src.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX7_GPR', if_true: files('imx7_gpr.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX7_SNVS', if_true: files('imx7_snvs.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX7_SRC', if_true: files('imx7_src.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_ANALOG', if_true: files('imx8mp_analog.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_CCM', if_true: files('imx8mp_ccm.c'))
@@ -72,7 +73,6 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx6_ccm.c',
   'imx6ul_ccm.c',
   'imx7_ccm.c',
-  'imx7_snvs.c',
   'imx_ccm.c',
 ))
 system_ss.add(when: 'CONFIG_MAX78000_AES', if_true: files('max78000_aes.c'))
-- 
2.55.0


