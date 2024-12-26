Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E9EE7718F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 08:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQjEG-0002MY-7P; Thu, 26 Dec 2024 03:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3mBNtZwgKCrUrpcVjoncbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--wuhaotsh.bounces.google.com>)
 id 1tQjE6-0002Cr-Sl
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:28:16 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3mBNtZwgKCrUrpcVjoncbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--wuhaotsh.bounces.google.com>)
 id 1tQjE1-000198-OX
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:28:11 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-21640607349so108029535ad.0
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 00:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1735201688; x=1735806488; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=F8RiAlCHl+1NqI9Hasi2td6dnDjrsz5BjuPhZ1v7pKk=;
 b=o9378D/BVgozfZrzdFyPXgt3/Oz7+mf7dMZnDBYuCd14AYOdfgGm9ejQ0If5cXxTfJ
 tCRpOc4sVQZBtaRfZN4MWU/XRWhhZ1HX3dDg3Tk062snOj6XQnTuHMiEdNsU+uevTLM6
 JgneXshBAw6evM9i3IHEgaQtyKXPHVvZ4uXL3DK1Xlnr9Iw2vudEvnbzq/UmMUE5sz87
 /ARUQf5Y3d2szsJ3tka9SxiOBXcVzDvXDOsw78LlgA/oVYNe2L54EpuHBJuUB8p1YT0z
 2hRCawVc+ZuBw943gkb3XbO9AdDJA2UjX14b5t/yZbipvGvGKWNYyD/rYKm9QitsGKmS
 COTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735201688; x=1735806488;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F8RiAlCHl+1NqI9Hasi2td6dnDjrsz5BjuPhZ1v7pKk=;
 b=QjzZBUGwPsPSSdpvTbh8gvrvzYxU/I0hyNsoeYIaoGhI++vbJThV3syAGnjhKviMRQ
 3bfah5hmVB6n7xgNeAfbtuxCFXeEMBuMDTwna8Vw5HIL4QaaDQutgzBTbCqtgdLLyq7a
 MlXAgckQeY8QPTxvC5mVL0bkdY1pgARydX5vgifAQ/yce5msfRcYMXxRcNEy949gS5BF
 Dzouad8OMWt+YUM0QH+j1IXsxyPWb1frnSzuDTziylUJ7spE5vAFJeMkIkbSwpStRAdu
 /7diY9hKeUtcl3qX1OyjNqBDy2wdrbdASnYk2TI85pgwkLJA8qbBt4zCq6TuOLfBv0cG
 2cfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGi/RUkj5qP/F6OV4p5+j2StSZhLKzQN5dsrPlJCK1VHMY4+EQjDnbl4y10O/c+uLk5lFemxL8agZ3@nongnu.org
X-Gm-Message-State: AOJu0Yw/AjuiinOk3NB98ZS1JzuWa2vTaLjtDxTOFMZPBB8HQWUOS2Qf
 iBA9WFWymEMFRcx/5Y5Y1ms0CrD2xbiuCq260oYLxB1qT3DFaJw1FjepwgLRGYR169xVI7kjAdU
 YlauRUxGKRw==
X-Google-Smtp-Source: AGHT+IGvilV7ssgYxVWS/Fl41N4PsmieLAc5u0DLPylKWj4vV9D3USDscn7hRVB3zGkPXfESTVEhJ/F+/RSQ/A==
X-Received: from pfbbr12.prod.google.com
 ([2002:a05:6a00:440c:b0:725:eb9c:47e4])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:1014:b0:1e3:e836:8aea with SMTP id
 adf61e73a8af0-1e5e046f453mr40786073637.14.1735201688208; 
 Thu, 26 Dec 2024 00:28:08 -0800 (PST)
Date: Thu, 26 Dec 2024 08:27:44 +0000
In-Reply-To: <20241226082800.2887689-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20241226082800.2887689-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241226082800.2887689-2-wuhaotsh@google.com>
Subject: [PATCH v2 01/17] docs/system/arm: Add Description for NPCM8XX SoC
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, mimik-dev@google.com, 
 hskinnemoen@google.com, venture@google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3mBNtZwgKCrUrpcVjoncbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--wuhaotsh.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

NPCM8XX SoC is the successor of the NPCM7XX. It features quad-core
Cortex-A35 (Armv8, 64-bit) CPUs and some additional peripherals.

Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 docs/system/arm/nuvoton.rst | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
index 05059378e5..0a1916fb99 100644
--- a/docs/system/arm/nuvoton.rst
+++ b/docs/system/arm/nuvoton.rst
@@ -1,12 +1,13 @@
 Nuvoton iBMC boards (``kudo-bmc``, ``mori-bmc``, ``npcm750-evb``, ``quanta-gbs-bmc``, ``quanta-gsj``)
 =====================================================================================================
 
-The `Nuvoton iBMC`_ chips (NPCM7xx) are a family of ARM-based SoCs that are
+The `Nuvoton iBMC`_ chips are a family of ARM-based SoCs that are
 designed to be used as Baseboard Management Controllers (BMCs) in various
-servers. They all feature one or two ARM Cortex-A9 CPU cores, as well as an
-assortment of peripherals targeted for either Enterprise or Data Center /
-Hyperscale applications. The former is a superset of the latter, so NPCM750 has
-all the peripherals of NPCM730 and more.
+servers. Currently there are two families: NPCM7XX series and
+NPCM8XX series. NPCM7XX series feature one or two ARM Cortex-A9 CPU cores,
+while NPCM8XX feature 4 ARM Cortex-A35 CPU cores. Both series contain a
+different assortment of peripherals targeted for either Enterprise or Data
+Center / Hyperscale applications.
 
 .. _Nuvoton iBMC: https://www.nuvoton.com/products/cloud-computing/ibmc/
 
@@ -27,6 +28,8 @@ There are also two more SoCs, NPCM710 and NPCM705, which are single-core
 variants of NPCM750 and NPCM730, respectively. These are currently not
 supported by QEMU.
 
+The NPCM8xx SoC is the successor of the NPCM7xx SoC.
+
 Supported devices
 -----------------
 
@@ -62,6 +65,8 @@ Missing devices
    * System Wake-up Control (SWC)
    * Shared memory (SHM)
    * eSPI slave interface
+   * Block-tranfer interface (8XX only)
+   * Virtual UART (8XX only)
 
  * Ethernet controller (GMAC)
  * USB device (USBD)
@@ -76,6 +81,11 @@ Missing devices
  * Video capture
  * Encoding compression engine
  * Security features
+ * I3C buses (8XX only)
+ * Temperator sensor interface (8XX only)
+ * Virtual UART (8XX only)
+ * Flash monitor (8XX only)
+ * JTAG master (8XX only)
 
 Boot options
 ------------
-- 
2.47.1.613.gc27f4b7a9f-goog


