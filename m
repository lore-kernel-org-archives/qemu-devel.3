Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2E3CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIdj-0000db-QP; Thu, 15 Oct 2026 06:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIdU-0000Xu-Ay
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:24:33 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIdR-0003Dw-Sq
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:24:32 -0400
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a022fee0caso48096255e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792059867; x=1792664667;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dNC31SG6tiYYAq8uQ1zQOLn6F7XfN2if+RjCHtoxlkE=;
 b=ym43x81CyF83xYkK2rvfgtdrB8zHQT6r6KruAxql/1m74fJ9iHLgmkuapmfBdzV0hg
 psVVwFsX/MPl17FhIeTaYzEVAEKdo1mAGeueM2F5qmrozZH0h2sLAZHmu5RMh2Z+CKJR
 KRpyR51s4sI90OIDqeX0kvq73CgoVFgxrcuV5e2su2/HdGtR/q+rjdEY1QWdDIODIOr/
 BbjvbJyYwa37JK+/3qNhDyMedw0/lkH9eOWRkoFHBWwmT2ka7kjF37IiiyvMePeJzya8
 ThV3FJRLu+xMxcrc3Oem7c2tAriWnmvmcBNXQGYqyddAIo8+uE7pL4YAs9fAPWTlekrj
 Ureg==
X-Gm-Message-State: AFq9FYLC/w8YzjtyQOIOQku4BnPP1iNJDT7HcLa+GFnKc2QF75NbqaZ3
 LJ5Htup95g9v6PAw9zi4NQvcOvtNr3yQYMPOx4YJTzvovCs3MsnQjoJmA4uRI5Rd
X-Gm-Gg: AYBFou2zvOoSadmOaPduUiDOgT+ie4lCYeRAoIyqV/FvTG2K1FKoRYdpKBxAEK5f0vK
 UGdDGpFapn24lmGkn3HBRq/QsDS5QbWoXbVkHxKavoK1bQYuuatypNV5xEIcI42Lnv0ahrs8yrY
 UMS1K6AY8blsF9k3Do8+PDvsjNY3eR2bwU31TrH2+WSPNnpUfXRxZU6h/sVPX5OLOpQcE9NYtNy
 h0Qirz0EsU5P6qAR8u5Xec0DGBHwjpXrx4zxu7PPPS3kuQW0qUDo5ar4fM3YjJ2MDH5b/OpSY0x
 EqWcAq3nl9pgbnPABABlT1OQ6Q5fTBXJPUHypL3fbFRt6ZOz9DPg27wzv+mIaYl0hgWkP88DyWo
 9JH54xvIYVrGVNmsTe4q1z4KB0JnPRzRmpokWSqNFeuOo9EAmwCq1hGScg66xhMdu8oeaWVPMjN
 NSr5CEsPZNGIAVOWvNZnXIOVVchcU/uklGc8ZUD28Bb3nWw3+yw5OsQ8cSXdqaq2KUp5v8HkCni
 HChEyNfW08FSIN2T026JQTzm2eg1WzPDPUqiJcCZrUMsg==
X-Received: by 2002:a05:600c:8217:b0:4a1:a496:fc17 with SMTP id
 5b1f17b1804b1-4a1a4bd3da9mr208995325e9.5.1792059866880; 
 Thu, 15 Oct 2026 03:24:26 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd67a080sm58130415e9.3.2026.10.15.03.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:24:26 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:27:50 +0200
Subject: [PATCH v3 03/50] hw/arm: sanmiguel: remove the second SPI flash
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261015-bmc-minerva-v3-3-7d50c8a108e5@free.fr>
References: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
In-Reply-To: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>, Jamin Lin <jaminlin1207@gmail.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792056474; l=1376;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=LoL21Mo6nZPDtcu3z5xfCRDOzqt2QUyWNp/sfG9scgA=;
 b=v7uLCb5TivHjhWB9UP6ai8dZtB0I9JfUwHYzvVT4LjgQUJ+jwNseXX6QZkhjENbfyuX0/Atjv
 dopfJQFiMacBtFvz/NXmPX/wHDIeWKD1e7WfGRFQwModuh6/WFlf6xV
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.46; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f46.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The board only populates the flash device attached to the FMC
controller; the SoC SPI controllers are left unused. Advertising a
part there presents the guest with a flash device the hardware does
not have.

While here, add the missing year to the copyright line.

Reviewed-by: Jamin Lin <jaminlin1207@gmail.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/arm/aspeed_ast2600_sanmiguel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/aspeed_ast2600_sanmiguel.c b/hw/arm/aspeed_ast2600_sanmiguel.c
index 345a9c9416..ac2aef740a 100644
--- a/hw/arm/aspeed_ast2600_sanmiguel.c
+++ b/hw/arm/aspeed_ast2600_sanmiguel.c
@@ -1,7 +1,7 @@
 /*
  * Facebook SanMiguel BMC
  *
- * Copyright (c) Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
@@ -384,7 +384,7 @@ static void aspeed_machine_sanmiguel_class_init(ObjectClass *oc,
     amc->hw_strap1 = SANMIGUEL_BMC_HW_STRAP1;
     amc->hw_strap2 = SANMIGUEL_BMC_HW_STRAP2;
     amc->fmc_model = "mx66l1g45g";
-    amc->spi_model = "mx66l1g45g";
+    amc->spi_model = NULL;
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC0_ON;
     amc->i2c_init  = sanmiguel_bmc_i2c_init;

-- 
2.53.0-Meta


