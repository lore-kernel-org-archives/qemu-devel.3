Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496A3C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 10:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp388-0008LK-CQ; Mon, 03 Mar 2025 05:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp37r-00089K-Ln; Mon, 03 Mar 2025 05:34:20 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp37q-00076u-70; Mon, 03 Mar 2025 05:34:19 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2239aa5da08so18127015ad.3; 
 Mon, 03 Mar 2025 02:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740998056; x=1741602856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDU1zpgxw5NQE1GZ4VMSDId7tdssn+1yod5XCqVYjkE=;
 b=NXX0ZYFxvVq4DQtG7rSN9khmtcJp5A6WbqtGrn9Qf4ENyaBLUse+fMu3BpQ1/0J+iG
 ItRZfV81lwKHclj2bfRaocQKQeqXyfUbdDX4DVBkm/2MnnrynNePeiVdfpDs6M50QAfP
 J/IKOAwkvinNvl6jb6jNfJSdEGGkBIiAp7SFxzMD6ZwaXa0HixPSJ8GFsO9OQbtBS9bx
 n0GWVKyUdoTSVhzxG9ra0QS9UHvi0UizAwOASxP6JqvWhwT5nR8p/4+tLgiCgvoNalKE
 VGB2syU55bTymAfKcb6epaTj1rEjl76XORvUe43biijWjxG2ODzdnwf4ssZzeNT2JMzj
 9c9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740998056; x=1741602856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cDU1zpgxw5NQE1GZ4VMSDId7tdssn+1yod5XCqVYjkE=;
 b=fSv4S/vWglKI85XI6HREXLd+nDF6Kg6Jgeaxb4Cv7NUkf+Nje9FWmkUahRMtKF0s1p
 xDJFLBazBeAo/7y0lYZsThjCOjYmnlQQbAE0P3Vhi7tl2UsmC4OHJhqw76f9SsrtYFWH
 HW13YAlnp6COyxRqwvFcy5INU+BLkv2aFGqxmUdT2mtLw7t/A5HFMvXEeqRvGAbjrAOo
 YdNNcFQw1JrnNcAWTPgrzKzIdpPGiU6vnmSe426y8uCHcQSf62wX3teXsJJnMX3h3ZTw
 4Bn+iyDPkpoh6boqa/xLHZ8rx7HC7aZZF4doNHKDjotCcmZqsJ8fpdrEcawhLU77XYey
 1j8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw/Ar+JP3llorILz9Q7DGn55199llmHUYaqmp5KoByeJe3NvsbxHpvAGbYyq3pWbcMwS7IUuofMGHs@nongnu.org
X-Gm-Message-State: AOJu0Yxy3El8EewnRZ5vCIHVAiElRcjQfsDMgloFBrOM9kiLxhM2cvF3
 eDi4m3ATAtkw/Y3EyUJPMHBTpMNOmxytLFzSqosA98WjDcE/h0KZL7RK7g==
X-Gm-Gg: ASbGncsxG+nQInRVk7/Fmqcxw+Zh3IrO6CdiCykjJjSfjCZHesJzGNa0PPU04dZjUX9
 0km/NS0p2Xjjv6DbzA54a/vqY/UVm7DWQnfnir4ixBJuzZDRN+4tXsrKVFBu7+MRet/g3m9eLaU
 hIVsCMYMdbH2iXV4nftCe9dRqDq6aS33YCK3ertidCF+gmGrSMAow8UZipUv5EIhhYs64IrBBo5
 qNfCCwTtuPu70MbA5J8xbjDe7ukW+7+cEd9hc/kHRbjhonVDpZGkDm03DGhl6m6hm77KrHKP5rC
 e3+UFaKbbqcnV+BgOGKA81GD44jK52aCGHl6jnsuAdKktEZPR1Q=
X-Google-Smtp-Source: AGHT+IH6xRcFBwzh+Ic9nr2PTYlxIhI7c+ELjGK17IVu1+3Iju6NnB12UDW/hG936QyK5y+5qG/WqA==
X-Received: by 2002:a17:90b:3fcb:b0:2fe:9581:fbea with SMTP id
 98e67ed59e1d1-2febabf414amr20026398a91.29.1740998056129; 
 Mon, 03 Mar 2025 02:34:16 -0800 (PST)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea698f309sm8594558a91.42.2025.03.03.02.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 02:34:15 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 4/6] ppc/pnv: Move PNOR to offset 0 in the ISA FW space
Date: Mon,  3 Mar 2025 20:33:55 +1000
Message-ID: <20250303103359.578994-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303103359.578994-1-npiggin@gmail.com>
References: <20250303103359.578994-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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

skiboot has a bug that does not handle ISA FW access correctly for IDSEL
devices > 0, and the current PNOR default address and size puts 64MB in
device 0 and 64MB in device 1, which causes skiboot to hit this bug and
breaks PNOR accesses.

Move the PNOR address down to 0 for now, so a 256MB PNOR can be accessed
via device 0.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv_pnor.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/pnv_pnor.h b/include/hw/ppc/pnv_pnor.h
index 2e37ac88bf1..19c2d642e82 100644
--- a/include/hw/ppc/pnv_pnor.h
+++ b/include/hw/ppc/pnv_pnor.h
@@ -13,9 +13,11 @@
 #include "hw/sysbus.h"
 
 /*
- * PNOR offset on the LPC FW address space
+ * PNOR offset on the LPC FW address space. For now this should be 0 because
+ * skiboot 7.1 has a bug where IDSEL > 0 (LPC FW address > 256MB) access is
+ * not performed correctly.
  */
-#define PNOR_SPI_OFFSET         0x0c000000UL
+#define PNOR_SPI_OFFSET         0x00000000UL
 
 #define TYPE_PNV_PNOR  "pnv-pnor"
 OBJECT_DECLARE_SIMPLE_TYPE(PnvPnor, PNV_PNOR)
-- 
2.47.1


