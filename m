Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC72C79FA7
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cRF-0007TW-WC; Mon, 07 Sep 2026 12:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cRE-0007QC-A3
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:43:20 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cRB-0002pg-RO
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:43:20 -0400
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-482e067e908so3092477f8f.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788799396; x=1789404196;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ojXOoPy7qb9Ji3StIqOoikH1Y+fN6ya8UhzSWcfVEz4=;
 b=ZThtO8b2qok75u3dhTAF2xUWmfg4tsXNCmI1J9+PsFtAg4SuVSaP9p1MRxM4PWNWHc
 zrUC/bKoUZL6anfEO6Q28gN1gR5+M2es0uKFkAWoCHqnSkKkWNrHGihGBbLCD5FtRBYD
 bKO5eQdTQnafeeJx6JvfqIhca1ISxJ2hEBrk9+g+FJaEEDdH0EUsIRC3cpppXHYCPlRb
 BPbDmz572qYKn/29GxmXZtIOpyiXi1TXQTGLEoK7GRuC2u2KLn2JNMT31X/bUSqlFwyn
 nEB77V7beaq8BU1fS4M90f6cEO46Bz/6iYFphhwI2hP4nUWWkGq2CjETAuHSU2SjLxel
 8CCg==
X-Gm-Message-State: AFuF++lDqZk8ewetnsuRLxBrMng84ZuIPE+lbVjgEhPp2cPMohDgHzw2
 /ligRiP1/qfgzqJ8N7TTos07wg6htMx78nHc7+Dc2z6PA35oAmoWcAsCkBz0CwHv
X-Gm-Gg: AYBFou0kTatbW/buTns4475lTCylXfDhWe03Z2mvjokRhxvTUV7ffet2VdY1LPBgE3A
 SPY7brOOIzUngsMKw/+7BImZRhunjORNHPKwvmjC+EpKBnFfkq9PaKI070snwt0yObjzCSnnDo0
 ne0aCGj30LpZfsyQtpT/uCejfkAMB/QOqu/FoavW1Fq9AQtFVB6gHFfhBAQx6QO29o3vKwc6MUX
 k2O3P8wyo2WxYo69+AoR66SHrIE72CgXjShdSVvJAuZamzFY3p1x5kHqpUMWaq2aRzyVy2gsZ8L
 mdKMC6BFkhQLWc5NuvbZWFeFz0djIvPEP2oGQyIpNufDVYTy4ro+b+2IHlFbDMFatT2yS/d6vKM
 h8Kvn8NKYdZdDvPrszop823kdPYw0e8ih7sprEtyZME4SlJm9SpFZP3zdcfyl9jcA3I4IbxN5Mq
 4nNDq2vpmSmTelpulTHpYvkMbndIKnEn6U+uSg0JAGo+xuPLbQqCHxemS05ffyQhTWtanNDW0X/
 k4Cteh9wSJe3q/s6ec3yUgKgYsrPTdTl10lvJY5ovUMSw==
X-Received: by 2002:a05:6000:1863:b0:485:8a46:704c with SMTP id
 ffacd0b85a97d-4858a46716bmr21823339f8f.30.1788799396182; 
 Mon, 07 Sep 2026 09:43:16 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858ac2b4cdsm28550376f8f.16.2026.09.07.09.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:43:15 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:41:54 +0200
Subject: [PATCH 04/50] hw/i2c: pca954x: drop unused header inclusions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bmc-minerva-v1-4-0d83ad610c3b@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799319; l=840;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=uUIqo2cMsRAcBY+czFTMxvhiWXutmm3Zl9xFpRFXck0=;
 b=zDu2jnqnvbVCx2F+4Yl7UpI+XoysiLJwJphorKoCApt7XdSoDeuVqvz8LYcgIUrNG58L4m+OM
 optoI6Xt6vcBCMKQws3B6b64hdvAB9MjyaauK3l2NPxwly6BDC2SHWC
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.43; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f43.google.com
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

The qapi/error.h, hw/core/sysbus.h and qemu/module.h headers are
included but not used by i2c_mux_pca954x.c. Remove them.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/i2c/i2c_mux_pca954x.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
index c6034460284..c8e75da8b2e 100644
--- a/hw/i2c/i2c_mux_pca954x.c
+++ b/hw/i2c/i2c_mux_pca954x.c
@@ -15,15 +15,12 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
 #include "hw/i2c/smbus_slave.h"
 #include "hw/core/qdev.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/core/sysbus.h"
 #include "qemu/log.h"
-#include "qemu/module.h"
 #include "qemu/queue.h"
 #include "qom/object.h"
 #include "trace.h"

-- 
2.50.1


