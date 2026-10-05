Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0712CA6001
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfpx-0006wy-TS; Mon, 05 Oct 2026 06:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmn-0002OX-DO
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:19:11 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmj-000144-AQ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:19:08 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48870973bddso449630f8f.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791195543; x=1791800343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4YQL5m4zq+Pgk78JS657IhliqFYCX7VRgAFFPt0Enmk=;
 b=PwpZjNf2HgMx1BUZnbYyMN+M59jQtOVw5J0U35WTa60j3t0LEyYoCYusn8vO0cG4D5
 tOIPQXejTV0AK3Y3opzt4pqzeV97cEtUa3S6otlsHo4cijaVtqvNIGPtfLVsglBtMiqj
 hN7D/wfPf+gjtl0DiGqz5ztFU6uZMxP5kdUAHYpcvlVDp2wuTRMBT9mG3cMv4H7xcJev
 efGQjLmrEHBHWHVkptVQZDytT9gAwBtH09Bs8Yv4d5BvyRZuci2CEEcHFxMYtwSNM2Ml
 Kir0AtbKq/VczC+3ttFI/BRPyTxgrYG5ZC+Mkg9bCxTfX7yZ7LJRyunni07ix2//+c/A
 1aig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195543; x=1791800343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4YQL5m4zq+Pgk78JS657IhliqFYCX7VRgAFFPt0Enmk=;
 b=jdxTLJ80uq6ZwyvIMwiTxCkQrISvlb8hpAZEwbbjWklyQZ6A86nu7upnjGoUh/rkdO
 TYPDq9sVbt/9wQnEnOUOC9ixAHcVLwy+bKE8QqxYgyigO+F/PTumcziqjPY0voHVoV26
 ysqWVGC87sVCK+oUvrKnj9LkR9kRNybqGgvXMfpt+vVdQc76yZx0gTsRjYwWo7C3Z3Ke
 HKXAkFLgBxEfDAkQxPDxPnCc4o78nmJZkY8cmritRHoaqtGXvKF0R9PN/flBma5NNQ8b
 MUGduC5RRSBXaWabAs53sp9ZzQCpXJRZwjqjU4eZ1kLfe4K1crERURduX6P4BbfDVf/2
 YJJg==
X-Gm-Message-State: AFq9FYJoI+D0ur1PQP+7cBhW20FfNZrWijUGKBlTzfPBSEqZmVojJZQt
 FfdEXUBvc4dm1/6sm/2BB5yXK3Dh9n2TxLEfYfgUUgTmaXDEmUtY20C3X10Fcg==
X-Gm-Gg: AYBFou16tgF6Oanpcc0Z1yH/KM2y4a8cD4fI0UN9dMQLHtrqklzrc0k9pxcf8JwaSgc
 /aa4zUnrr11PUyJSdtzEY7gzWzmzY/3lVqv3+m0Y5usocm+/ZEyBgwWlcCkR2KjcgxFwcjbSPdK
 nnXw0zEcsN09zweSScireOoZWh5bDPZqbQ78kivvUUIJr/LVqVdceHxysLEGfg7MHvBpBx8pZgT
 43ekU00fS2QJGc0F6q6lhd0g3PVkJQVxV+QMNCMbcyRhfbr/nLxxqA2Zg+MSfegbl/W8KJ1QEXJ
 U8KOSXHfjndG7crmpDc0CqeWDhU7aFA1v7S9nH45jtnNLxGMD9+/+hMSqdEuvWx9/Zzz9cuWCm8
 l12vv3BWL7Yk2ZeVohhpSrcsk7oM+eQIzvSvN2EAJwKzlgLPGFepmJK1qXAzppkYCZZDw0OCoQO
 sobMOqyN17fE7YMy91iEw0/h5IHQqQQ48eFMAeShVb6Ccczsul3nChLBESCbBWlstbABdFTO4PE
 1tJ2m8clhRfy+3LaBqA3WqPJoZcaU1lP8ALDrA=
X-Received: by 2002:a05:6000:643:b0:48c:4f93:993f with SMTP id
 ffacd0b85a97d-48c4f939cc0mr8107543f8f.14.1791195543128; 
 Mon, 05 Oct 2026 03:19:03 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm2742111f8f.37.2026.10.05.03.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:19:02 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 30/31] Kconfig: Remove config IMX
Date: Mon,  5 Oct 2026 12:17:57 +0200
Message-ID: <20261005101800.10821-31-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005101800.10821-1-shentey@gmail.com>
References: <20261005101800.10821-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x433.google.com
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

The previous changes removed all uses of config IMX. Remove the now
hollow config item.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig  | 7 -------
 hw/misc/Kconfig | 3 ---
 2 files changed, 10 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 543220be6b..642dd86217 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -481,7 +481,6 @@ config FSL_IMX25
     imply I2C_DEVICES
     select FSL_IMX25_CCM
     select GPIO_IMX
-    select IMX
     select IMX_AVIC
     select IMX_EPIT
     select IMX_FEC
@@ -501,7 +500,6 @@ config FSL_IMX31
     select FSL_IMX31_CCM
     select GPIO_IMX
     select SERIAL_MM
-    select IMX
     select IMX_AVIC
     select IMX_EPIT
     select IMX_GPT
@@ -519,7 +517,6 @@ config FSL_IMX6
     select FSL_IMX6_SRC
     select FSL_IMX7_SNVS
     select GPIO_IMX
-    select IMX
     select IMX_EPIT
     select IMX_FEC
     select IMX_GPT
@@ -603,7 +600,6 @@ config FSL_IMX7
     select FSL_IMX7_SRC
     select GPIO_IMX
     select PCI
-    select IMX
     select IMX_FEC
     select IMX_GPCV2
     select IMX_GPT
@@ -627,7 +623,6 @@ config FSL_IMX8MP
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select GPIO_IMX
-    select IMX
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
@@ -657,7 +652,6 @@ config FSL_IMX8MM
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select GPIO_IMX
-    select IMX
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
@@ -700,7 +694,6 @@ config FSL_IMX6UL
     select FSL_IMX6UL_CCM
     select FSL_IMX7_SNVS
     select GPIO_IMX
-    select IMX
     select IMX6UL_LCDIF
     select IMX_EPIT
     select IMX_FEC
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index ab238767b8..93666c4ac0 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -89,9 +89,6 @@ config IVSHMEM_FLAT_DEVICE
 config ECCMEMCTL
     bool
 
-config IMX
-    bool
-
 config IMX_CCM
     bool
 
-- 
2.56.0


