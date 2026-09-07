Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1CCC79FA9
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cR4-0007KJ-H0; Mon, 07 Sep 2026 12:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cR2-0007J6-Bx
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:43:08 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cR0-0002oN-Mk
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:43:08 -0400
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49cca4ffdcfso31085625e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788799385; x=1789404185;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6rZV+0Rq4PmlZn+kvmoVgaQLW2OyVLJsEpdjV2a5OvI=;
 b=HQjIohRDviAxiZ9KURvOj4ELkVlEDGVQV9A2U6XmW7Zm0O9gJVMqfaHpI0gqUDVi2Q
 rEd+4kvgXWbPv+nivz2ozWDizEIu+USuxMmakfAR7MJPgabV2F7JrByAKIkb4bmxqlOm
 yUzBZZ+QxfeRxWRJsj1ddcDMsCH9Mnalod9QGx8kjvuFztf0zbSxOHhfb8rBfuhd5Dj7
 oAzHBhNxT1YZp/iU6OjYgqBF/ZTJK1Ra/D1NMaes4md7K/yvCZe+0d6Jbdc8j5P6PHDe
 wTIQyM9xmvHB0lZLjh8Lcu/GZbWQ9cJ5/BTrX/57rnZEV+JhGxdBHKyOtjRt/kSc9X3s
 S38w==
X-Gm-Message-State: AFuF++nem3fou5/GO/7blw1vUu3Ya8eZxaqwDhTvvaJmS0v6fPF8WHIV
 AE9t04KEZa2u2tVxncZZeetfHTL+2wWnrgj9/f744fOKVJa5hxKeZVtc9er4hcGf
X-Gm-Gg: AYBFou22QuxJMyOli+x0Ftpkj55jQzRSY1eAror2Km596f+aL+UeXyeL/aHa5awIrq1
 ZHcLbyGagdy7KRN22hfbn3ruSeFpQttN3U07ScfPvGVth4NOgYHAkDwvhJ1SbUpElWiUVxjolAf
 OFgpBggoc5HlsU2rH7IV02qJgcwrzEU6cWIRGhkAGg51jk1aMVd16dcSt+4BK5xskr+9Ok6quER
 4xn6e+AV+QaX44cxLJh4SQPs/eCKmLo0gOImtdwJR1F1EsZKLb1pvCj4jBpZhEtUX0XR2Th8AVV
 IonYDSlJcsb6Y21QnDgdepumw1ExKOd9a1kyk2wsiNmzzug7qpbSl77iU1lv3OjHhAaFHm9xnEx
 GRHGQrStfLX0AXaW472HZY5EVBUhsTZaRAMN3dlnVdCTFQj+ilJEJEtIqoBnNdK601aw2j9cy2Y
 q2G/ttraIqfkxv78zr/EuKjUdjc1L4lmSCmWdPQkBLhDC9QwDCmixh2xwNtYk6lE0lgOZkouBsI
 xrjjxfE6137+V0ERmMZjDJWNRXJRWk8Fj0=
X-Received: by 2002:a05:600c:1d0d:b0:49d:99c:3bd9 with SMTP id
 5b1f17b1804b1-49d099c3fc9mr105824635e9.33.1788799384968; 
 Mon, 07 Sep 2026 09:43:04 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce46696e8sm291092065e9.0.2026.09.07.09.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:43:04 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:41:53 +0200
Subject: [PATCH 03/50] hw/arm: sanmiguel: remove the second SPI flash
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bmc-minerva-v1-3-0d83ad610c3b@free.fr>
References: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
In-Reply-To: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799319; l=1273;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=A/n8ct+D5Xu+mMgfHstzXeaf3QPL+KzcwDlNWjocwiE=;
 b=cqM5K1I8x8srHtJZ7eQ24cJrKOwHfhjzCBExf6iCiP2xEGdxhprPiDhShDDYyx3oDp/VNGd/U
 B4JJR/ufbTqBFIsfEEdq9W8VAmtwiYqQRpn0eDgPFMyknNP6tP8k0oi
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.51; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f51.google.com
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
index 599ef1701f..1dbbef11f2 100644
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


