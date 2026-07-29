Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F58CC53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp6EC-0002rk-H9; Wed, 29 Jul 2026 11:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6E9-0002rV-9O
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:29:50 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6E6-0008HC-Ly
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:29:49 -0400
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso13857035e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 08:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785338984; x=1785943784;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CfEjIUkd1zt60lZLBgFbE1W+Iz0xdud8IZhMTmuXKvc=;
 b=sG4Kvv1BKSAsU5idgxh/Jwgd0qV0nFsrN7D8XXrLUnRCnii6Itj/Vna2b9caEJCGCF
 0zhvolujWLBsJS/1HEMeP4SVlG/WZgl2T/4BAeTyhLMBIlwJXg9IyUSfun+QypH3Ni2g
 8i8BDahCui/zC9w/MVbqQqNsGYJ2D84dqmeuan7QAoejjlxU88W5OSoh93gsadeYwQqj
 HPOGj76X1tDuX+whBxHuaoLZXYjkB+SP2P2LruxygWGd3Hanvgn6LmUHyOA+o9aXYJET
 jnlI15msIbmeH6t57pKfb/lliAGlVwOMPUmEYEjl7o0BrUTOUTvnpqXPnjwURY7gPWsM
 VhOA==
X-Gm-Message-State: AOJu0Yx0yebXgOoGGZNydUDbCuodqSKJcsjsi+V0ciyKPYcx2WvIljrt
 ZYWaoa0UU/IPmGfDIqp2bv+z+GTi0A5a5ydf5SPHC6URSOWGxTcFhdq7I2AVLy31
X-Gm-Gg: AR+sD13Jmjux8PZhdIKU6DhsxlCptoSAhvMCJKpJS8eQThYxUPr6cV0FNftCg0k+DeQ
 ymdehahoWe3p3wbPAcu8OtWftoYuq55cZbeky8LcYF7/Matrvi4+FIiKXbp4Wsn9wJpkF/gzftJ
 pH38HkJgTYkqGP524W7UMFgrqeGhS9/X6cs6edoFvacD8PJylEo0VE2+LhVf8qeRtBlp3z+auQN
 lLePvorf89sqaVFfsP8YQQ5WE48seQKAsIzpZ+1ei48AhbUnyX2IEsIYCz+5QE+psgS2Zof12Vt
 xLCEBTJRGTLUNcW9RgOpYN1AhR1H1KPSS8pB/GlSNShOWRDPogq1xMJw17xxjqlYgKltadCqTHv
 eZ84Gd9mWtTGGjHa+y6UNtq12ed9Dw4Kke2rSQcJvkZBPXY3XbraTygOD9NmWXEBqHeSUXotG6c
 mxiCHD4K7GMUJYdNPtC0bzfb2aM3BuE47PZNVSk+aBUnJILqhlgBK0LZ0d+ddQZ0XCMZipvySXj
 UNpnk2wqdfYllC97DQFJNcxgxNsYBIrEXIs
X-Received: by 2002:a05:600c:1d1b:b0:493:bb0:3b43 with SMTP id
 5b1f17b1804b1-496c6426bc8mr88334435e9.2.1785338983588; 
 Wed, 29 Jul 2026 08:29:43 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496fa42effasm51998495e9.2.2026.07.29.08.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:29:43 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:12:42 +0200
Subject: [PATCH 06/25] hw/arm: aspeed: guard board-local temperature-sensor
 aliases
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-sanmiguel-bmc-locator-v1-6-c8f9a8d101f6@free.fr>
References: <20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr>
In-Reply-To: <20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Emmanuel Blot <eblot@meta.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785337963; l=1761;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=0daG7vmYYOhBzkb799hhbKaLINYeD4dhpsEpss5vX3s=;
 b=/Hx/kpQyWinE0jKj7tGWmxccvsmNreGxOPzUT/P9BqQZIjlL7eZFPq9UzQfrZ48K+ziC+zm5l
 l+xRsImQyi4DTDc6/oziggsZPMRmAIPJ+sKLYbETBgfLz2NgtyuP6B3
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.49; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f49.google.com
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

The Catalina and Fuji machines define TYPE_TMP75 (and, on Fuji,
TYPE_LM75) as local aliases of TYPE_TMP105 because no distinct model
existed. A following change adds a canonical TYPE_TMP75 to
hw/sensor/tmp105.h that would clash with these aliases.

Guard each alias with an #undef so the header definition can be
introduced without a redefinition warning, ahead of switching the boards
to the real models. No functional change.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/arm/aspeed_ast2600_catalina.c | 5 +++++
 hw/arm/aspeed_ast2600_fuji.c     | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index f714c9d1b32..33e75338efc 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -22,6 +22,11 @@
 #define CATALINA_BMC_HW_STRAP2 0x00000800
 #define CATALINA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
 
+/*
+ * Guard the alias against the TYPE_TMP75 that hw/sensor/tmp105.h now
+ * defines.
+ */
+#undef TYPE_TMP75
 #define TYPE_TMP75 TYPE_TMP105
 #define TYPE_TMP421 "tmp421"
 #define TYPE_DS1338 "ds1338"
diff --git a/hw/arm/aspeed_ast2600_fuji.c b/hw/arm/aspeed_ast2600_fuji.c
index 37db252e276..6dc3535f0cb 100644
--- a/hw/arm/aspeed_ast2600_fuji.c
+++ b/hw/arm/aspeed_ast2600_fuji.c
@@ -15,7 +15,13 @@
 #include "hw/sensor/tmp105.h"
 #include "hw/nvram/eeprom_at24c.h"
 
+/*
+ * Guard the aliases against the TYPE_TMP75 that hw/sensor/tmp105.h now defines;
+ * TYPE_LM75 is guarded too for consistency (no LM75 model exists yet).
+ */
+#undef TYPE_LM75
 #define TYPE_LM75 TYPE_TMP105
+#undef TYPE_TMP75
 #define TYPE_TMP75 TYPE_TMP105
 #define TYPE_TMP422 "tmp422"
 

-- 
2.50.1


