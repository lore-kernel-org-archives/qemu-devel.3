Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BA5CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHRF-00086y-AB; Mon, 12 Oct 2026 10:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHR6-0007yM-DB
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:55:33 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHR3-0005Ie-Ob
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:55:32 -0400
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a166199820so12643295e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 07:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791816927; x=1792421727;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ImldGJ+S970Bf5OYd6GaXlG8v143fN7qBqQiDylCmP4=;
 b=iB8EL5kfgkl34Zs4qZ7WAHSPHjhndA5YP9HePBDtpAu/Ik0qcf1xVhSrpBP7XyMota
 34G9s9QbkW+l0Ofh/M6dzeEmA3mbtLdWOWC7WwM0WBpYNNZCFNezKcCDw6S9agk3ayxU
 B+1BSMbXUC0v1e15HKvNnJx3ZEEPvFdp7avzBIaLxzlydFn0+UouqheSE6DdKRDU2m1C
 EMhl6S4T7S4Yh7H8P7BjOZiWU9pXS22IczyX2tIxA5rrSrpTKIPRpvuyYv7ovn/Z7leY
 vof55youon5GKZNTa83vunXg1A9qyNW9EzmoXGdfPCtndCeMUonwrBOCe70BIfrO5Zjj
 fFYg==
X-Gm-Message-State: AFq9FYJ3EWsJmVQBvYFVHtzdx150PsBcQYjE7FMj3c+cupXKRZixv22h
 IdUKNS4Pr3OsnocyYGVLD+eTHV+1x6UMHUyB9jfstdUKridSY6cG+WEFQS2khUlh
X-Gm-Gg: AYBFou2MSlcga6sLf/vLQ8gmFvLCyiCwLWFC2Kj3lmcC2AygjfB4C3V4JL2eZT3I7P3
 Tr/uXTFETTvmrKK3u766LvdT3RaULTdjJHfxgQMssvI4bLExSMu2pYive+Pt+8cbzuHr57T/xUG
 BJZTcdqR8WHVlWSrahGYzGeAjAe66NrslcdIFnTf+Ztb+b8bbu2qy0968tGj8yhCaDDP68bVO77
 II9RxDqT4eOtbm8NrWZM0EUgCtKa0uGfczu4WBQUXj44a4vetg0qJLFoD73sS4FN25VSQhi/yVv
 Wb6FcPUx+djvvHoCDidVu04oH4du0eYn09fbJkHuNpEa21vMEObfpWCrqjoNkOAJZ9UaOyPVk1c
 gYYCvgUett9JyEKt83Z1r/Yick/XfuZDCp+ht0q3TFtaLkOHqhMMd5ohuqeSBkv5cmg2z6Pr22B
 bNWko+J1MPpddo4VL4aU71temgXIWwaFbmqrw3Sb1Nj3l7PtUGdJBQ0KgARUViKPCYDreHQvwN2
 CXYHYZ3ERHHdmDBRPySDM4mjqEfxEiN/KJ4HFp7zjs+nUi7d5yt09vW
X-Received: by 2002:a05:600c:8b78:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4a18e4837f2mr176377965e9.5.1791816926905; 
 Mon, 12 Oct 2026 07:55:26 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2e0dbsm312212015e9.11.2026.10.12.07.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:55:26 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:31:56 +0200
Subject: [PATCH v2 03/50] hw/arm: sanmiguel: remove the second SPI flash
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-bmc-minerva-v2-3-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
In-Reply-To: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
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
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815519; l=1273;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=d5avXaQSHf6bIfiDvZv67RY5xgd1U3dm0wZh/dvYVAk=;
 b=M4EuneDWmdSo+VtSiaypHuk5+OfyPHsRFymuYjEK1qqATk/7ayeW0LBEEEiBPYzFJmbzIduyd
 R3YCUJRus7NCKQNRfHveC+Klhxdd6mCFzXBTgwRcm6g7weRdqcb+h2e
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.42; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f42.google.com
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
2.50.1


