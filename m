Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D25C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8ls9-0006fs-W2; Mon, 21 Sep 2026 17:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8ls7-0006bG-Cd
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:23 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8ls5-0000Od-QE
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:23 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccff31419so29373825e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027290; x=1790632090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C2GB3nohdzPOzv9i6PVHmINQoygYxtFrSGPMn4uD1Uo=;
 b=IreeJXQB/S3g0FBhMEbeXzuVQPDLf7DAYSd5mAiK0hje/hX1Gyj/5S4POUunh9htEf
 S8WmN0tNs0DprMqPjExNwdJe3eqhnCOEWfe1GKU6ID5DA5VTEDLRc6Ce6fyhwzvm8dln
 ikQpOayY/7FHq4SDDXtAoU1xVO5s1qwSLo6nckuneU1vcfdxJeUG7CrYp3rIcx4sWjRa
 UEA/yaHQN8egIe8jYaR+iahCBSi1DAKsQF4cUBfn5z++watpdeIY30R0OWFSBtbaV+23
 CzJtVSIGZ6D5MGCUhvFVf6Mm6H3fSzUiGiaWkh6wVaIhHResgmLUqwjIdv8L0nrU1sNQ
 YTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027290; x=1790632090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C2GB3nohdzPOzv9i6PVHmINQoygYxtFrSGPMn4uD1Uo=;
 b=OFdh96QMjidJTL8/GsjS1lnqU/PQXCP9mgDgOPxnvEVEwELB9Jiyld5SenrGHI1CnF
 n+TcLlU5qBDdkgVh9dX4mqIy7UFLCdvCTkxWgool6szbVBlotbu+Qjg7S6x6DybXr4e4
 86gFi4I14KXaOt8g0OLthW/qUzxIAhDX6yIQF6FoWb1UerCW2g20DWrPPE4Z9D4Otz3o
 lxwPN+bPpLDDvUeUszgwqlnOH6SCqKbVQxvUFtqc2R0vmqAqIr5gG1k2R15aKrSCKTGx
 Pli8QLYj1+F2P/HDAVBPg98pPjsqcw3yOKeefQt/CZTKkCgjqlte0/6vs1TuHogDQsoY
 hFqw==
X-Gm-Message-State: AFuF++nwM4BX1U4GlrnnsWjDqKK0WGgnoXs5OfRlHrZCKULUV+6LRqVg
 2aMtXh22ANxmYH0OqoSpjSeAspLn7pc8tYCErijP7QEBse/VIhMs/Wf3GfdOOw==
X-Gm-Gg: AYBFou3/5+h9TeyeEM1Na5NSR4NTfxOagg37UGrScbsbGo9D0irfXD2DsfOgybvG2xL
 nrW+jVPYH/5j7TDsdMAq1dChObQW5H0qMQvgidi8uiB7cQpP18W7qmyhkPoTWGIMWeWY61b6I7r
 Bmutd1GO7pmL3lqCRIHN5nMn+JlUjmEc3hBVpBOjQYGx7UFwNpZeZi4kPlQVGPrGNRFkFC5CxKq
 CnNyhSvEvilUEooxe3xWg9gFzx+SdQsRNm5xM592qk0sZpDY4sUESxBHRc1jnFyWPIL0Sp07Mum
 A9qQYkf1Y+MxTKUVwJNGWDk4ywraF90oRE9PxXdEjG7POU2TK365yp364t5jOg+Hb2DTATNKDme
 4r+3cJxu5w+EH2rVLuqqk6dtecVhdEvI365mAn88i/mGa3xNW+mfdrTkuCKwu1g38V5L/yNICkq
 5Ja+NudEtn8zIgjVIJUykhdbHFlbnWjsqjSLtVvCsMXhzt3ylXd4Er72PCrLIWB1j0yaKfXXHxr
 odlAIxuUf8qS6h19vXT+1xKYuaXR9ImxZdeMv+iXM1u6Yjkc31Bi4PNFDq6yZYWgjLjOdRagQfw
 Dvs=
X-Received: by 2002:a05:600c:6085:b0:49d:797:8488 with SMTP id
 5b1f17b1804b1-49fc567338bmr164755215e9.1.1790027290402; 
 Mon, 21 Sep 2026 14:48:10 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:48:09 -0700 (PDT)
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
Subject: [PATCH 32/42] Kconfig: Remove config IMX
Date: Mon, 21 Sep 2026 23:47:00 +0200
Message-ID: <20260921214710.29422-33-shentey@gmail.com>
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

The previous changes removed all uses of config IMX. Remove the now
hollow config item.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig  | 7 -------
 hw/misc/Kconfig | 3 ---
 2 files changed, 10 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 13b29475d9..860df5ba9d 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -480,7 +480,6 @@ config FSL_IMX25
     imply I2C_DEVICES
     select FSL_IMX25_CCM
     select GPIO_IMX
-    select IMX
     select IMX_AVIC
     select IMX_EPIT
     select IMX_FEC
@@ -500,7 +499,6 @@ config FSL_IMX31
     select FSL_IMX31_CCM
     select GPIO_IMX
     select SERIAL_MM
-    select IMX
     select IMX_AVIC
     select IMX_EPIT
     select IMX_GPT
@@ -518,7 +516,6 @@ config FSL_IMX6
     select FSL_IMX6_SRC
     select FSL_IMX7_SNVS
     select GPIO_IMX
-    select IMX
     select IMX_EPIT
     select IMX_FEC
     select IMX_GPT
@@ -602,7 +599,6 @@ config FSL_IMX7
     select FSL_IMX7_SRC
     select GPIO_IMX
     select PCI
-    select IMX
     select IMX_FEC
     select IMX_GPCV2
     select IMX_GPT
@@ -626,7 +622,6 @@ config FSL_IMX8MP
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select GPIO_IMX
-    select IMX
     select IMX_FEC
     select IMX_GPT
     select IMX_I2C
@@ -656,7 +651,6 @@ config FSL_IMX8MM
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
2.55.0


