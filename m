Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6E6C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 18:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkp6d-0003yQ-Ag; Wed, 19 Feb 2025 13:47:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3HCe2ZwgKCoc75slz43srzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--wuhaotsh.bounces.google.com>)
 id 1tkp68-00038c-Cs
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:47:10 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3HCe2ZwgKCoc75slz43srzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--wuhaotsh.bounces.google.com>)
 id 1tkp63-0004qO-0d
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:47:03 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-220bf94cb40so794675ad.0
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 10:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1739990813; x=1740595613; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=pqoQYyAvlYbvoO5CKrUwqrjyMLnIsAG6oK22Xi4In1A=;
 b=Dn+b7jKwHYJgnzO5Dba0CKciEZhbRUydFW/K3Yim+0nC+rRlrr1GIQbZ/LTeXszLPT
 LHx+tGhgTWqHsnl9kYqaKROehdDHC2po7tf5BQSAAI7fSnUUqYyfDq4kKE2x0WSbdPcR
 Pgeirawthyw0xdk/2Gw2XblzcNl5QtUD4bNnEfq437xNcYPk/tB38+sAXvjQ2yGjZxGP
 pxHRQCfbjx/GZ2KWOZ9UsWP/+qCxmLa5LhniB1IlFNxzkt4diz2TdVYDJKRLih+E0P4C
 uAlJfgWJO5Gcj7LLSBhXKbSf04UnCn/wSDJT3CKEbow8OJMfiLMIgoW90pCNftu43/I3
 o63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739990813; x=1740595613;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pqoQYyAvlYbvoO5CKrUwqrjyMLnIsAG6oK22Xi4In1A=;
 b=nDM57zeYrUJX7S3pCML2VDaCKLCV7RpMQDeEhhpTIoUzQfZcSrD9yXZuofqaiSEsC2
 E2TZ8Psu+ROOnwZ/xEDFr38HGD9K89GICzeFS9IYSdL0hEESwODl0m3AczaWfNqDVyKo
 9B+dNi0ECVyan13ISP4lmvgE7hjGgdIJKs/u5/Wzh+WVJPJ0f/8fz9VFcihuS9nVqvDj
 P7QQS9mpmdkFK2+IcFQuKQmLnakLz7uTsBQLHupb/SiPANPFINI9CTTiaPGr4WZ9dxra
 d+WdWPOluVvD2kLdAwI5HxmedB28oyEKu15Y9Q589XPVH0zJrpyvJtwbWyU1YZxBf/kY
 Kd5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDdEkeKWdqRIkoaHFHEqHplikGseGtHI3Rc9EcsUhbp7bikusIXXgiz47Uk+YThjeNGHTwE95WRWx5@nongnu.org
X-Gm-Message-State: AOJu0YwQIu1uaAz1LfTqI/tGxTMV82E0o6qG+ck2/SwUZV+Y0CiL2j9F
 K7/4JRauq9wKfj6WoLI8r2QFK10epwn5PGBz0GORNEdnWt82aiebaXDKa/xiJP+ygAtND1vF8+2
 8vDfvXm/uYw==
X-Google-Smtp-Source: AGHT+IF9Y0EIB8mXu7WtYeeVCduDwsK3aDp1M1D2MJS65KhlIvYWhQuH/KCp951ietvNOHsAQHNlFK0OlJHhoQ==
X-Received: from pgbcr11.prod.google.com
 ([2002:a05:6a02:410b:b0:adc:ba1b:f94f])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a108:b0:1ee:8a68:f83e with SMTP id
 adf61e73a8af0-1eed4ed2b12mr8096653637.20.1739990812748; 
 Wed, 19 Feb 2025 10:46:52 -0800 (PST)
Date: Wed, 19 Feb 2025 10:46:08 -0800
In-Reply-To: <20250219184609.1839281-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20250219184609.1839281-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219184609.1839281-18-wuhaotsh@google.com>
Subject: [PATCH v5 17/17] docs/system/arm: Add Description for NPCM8XX SoC
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3HCe2ZwgKCoc75slz43srzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--wuhaotsh.bounces.google.com;
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

This document describes the NPCM8XX SoC and an evaluation board
(NPCM 845 EVB).

Signed-off-by: Hao Wu <wuhaotsh@google.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/nuvoton.rst | 27 ++++++++++++++++++++-------
 hw/arm/npcm8xx_boards.c     |  1 +
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
index 05059378e5..e4827fb43a 100644
--- a/docs/system/arm/nuvoton.rst
+++ b/docs/system/arm/nuvoton.rst
@@ -1,12 +1,13 @@
-Nuvoton iBMC boards (``kudo-bmc``, ``mori-bmc``, ``npcm750-evb``, ``quanta-gbs-bmc``, ``quanta-gsj``)
-=====================================================================================================
+Nuvoton iBMC boards (``kudo-bmc``, ``mori-bmc``, ``npcm750-evb``, ``quanta-gbs-bmc``, ``quanta-gsj``, ``npcm845-evb``)
+======================================================================================================================
 
-The `Nuvoton iBMC`_ chips (NPCM7xx) are a family of ARM-based SoCs that are
+The `Nuvoton iBMC`_ chips are a family of Arm-based SoCs that are
 designed to be used as Baseboard Management Controllers (BMCs) in various
-servers. They all feature one or two ARM Cortex-A9 CPU cores, as well as an
-assortment of peripherals targeted for either Enterprise or Data Center /
-Hyperscale applications. The former is a superset of the latter, so NPCM750 has
-all the peripherals of NPCM730 and more.
+servers. Currently there are two families: NPCM7XX series and
+NPCM8XX series. NPCM7XX series feature one or two Arm Cortex-A9 CPU cores,
+while NPCM8XX feature 4 Arm Cortex-A35 CPU cores. Both series contain a
+different assortment of peripherals targeted for either Enterprise or Data
+Center / Hyperscale applications.
 
 .. _Nuvoton iBMC: https://www.nuvoton.com/products/cloud-computing/ibmc/
 
@@ -27,6 +28,11 @@ There are also two more SoCs, NPCM710 and NPCM705, which are single-core
 variants of NPCM750 and NPCM730, respectively. These are currently not
 supported by QEMU.
 
+The NPCM8xx SoC is the successor of the NPCM7xx SoC. It has 4 Cortex-A35 cores.
+The following machines are based on this chip :
+
+- ``npcm845-evb``       Nuvoton NPCM845 Evaluation board
+
 Supported devices
 -----------------
 
@@ -62,6 +68,8 @@ Missing devices
    * System Wake-up Control (SWC)
    * Shared memory (SHM)
    * eSPI slave interface
+   * Block-transfer interface (8XX only)
+   * Virtual UART (8XX only)
 
  * Ethernet controller (GMAC)
  * USB device (USBD)
@@ -76,6 +84,11 @@ Missing devices
  * Video capture
  * Encoding compression engine
  * Security features
+ * I3C buses (8XX only)
+ * Temperature sensor interface (8XX only)
+ * Virtual UART (8XX only)
+ * Flash monitor (8XX only)
+ * JTAG master (8XX only)
 
 Boot options
 ------------
diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index 19610483f9..3fb8478e72 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -17,6 +17,7 @@
 #include "qemu/osdep.h"
 
 #include "chardev/char.h"
+#include "hw/boards.h"
 #include "hw/arm/npcm8xx.h"
 #include "hw/core/cpu.h"
 #include "hw/loader.h"
-- 
2.48.1.601.g30ceb7b040-goog


