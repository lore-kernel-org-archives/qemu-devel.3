Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFF3C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpmVF-0000Rl-2q; Fri, 31 Jul 2026 08:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmVD-0000QW-HD
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:38:15 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmVC-00018H-5M
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:38:15 -0400
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47f9ab7ee38so550929f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 05:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785501492; x=1786106292;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H0i9wFR+0jszuSIzriUDQZoOMEXHplug+y13hr3wwAQ=;
 b=GdNJgdEMcjY2bC1aIKNDpBlmbpT8+tK3dBM8wG2LWf/QGpJhXJQTY5YHLbHNGcWW+T
 0eGnEQWHRvBEICHA/S4hbiY0QkHaTuCGs72h1IO4DYEglqhGzfdfJkxch4sLOvXkI/1v
 BEVlrYONcycyIhifSoiwzuATayjcxNG2tztSifRRgZ57utJxyGop0V0nGDzniDzRxP0p
 fWUaQ62DRjokMV+BHB6eKhoUNxwgkoRlKvexJrld+13NPeF5FReWRBgQIQUAbwzMqzZm
 zg9QcpsSI0IbPVvu0WGWLdMZqC2Ey8wFzMoQY1zL4+NTbQjNKYzcF6sPEaWWm81hKR+n
 Lx8Q==
X-Gm-Message-State: AOJu0Yx/GfO+r3OmIfBEzxP8JTRoHHHKgdRhvVks67iIw8MVVThXFDz1
 x6HB4eBdK7lSNinjeT4DMisMkIjt3BGhECn5NPxiJr5iX3vLvV8riWIgm8XkHrjN
X-Gm-Gg: AR+sD11KLH3k+6YvdOpjyxv+M74rcrmFEAY2wE7vXhxNXkvFXCBEx4bwR2El/ADAFWS
 S0o6YVOX+IX8WaKi55JkhoLENBUkqzCh2qChwdaA3NeE75bjiCkkI2QkABGGqgt88tcHVDjnE8Z
 KII9QLOG3MV11tSQVUcTy4Xa79QDJQRv0KwoNVrxvdnldqZNnZaoNK9+6rYfrq2t5MH0WFEe/9G
 iEyHES+udsU2sQ7GiqwAZGDj+3Qu5u0+OKs0zI/Py1985/gKetlbLL6YpndVinSPJKvqcTQca9p
 57DXTC2Wbv6dc1y2cr5WLuJzlapytr3OiKnhXOevX0ZPJ5aRYiNqR7QwVE4R4vAS2ybmttpEESA
 rB4ZDbPgkRwAgXeakR4tQmr/Q1hm1lh1RNp4zPVdnHv4aWDivrN4UpwNqT5HdC96yDVtkjcdmC8
 OJJLF+sSdVbxsRqY0aV/hv/KEhdwRT1ivee+SzWQU2VV2qJvAQ6W8h3t7nTI7bqd2pd5WgtQRH6
 H2Ll9gPIFiLMp7mcERroQGwMS3TpW7Jaai/
X-Received: by 2002:a5d:5f48:0:b0:47f:9822:d99b with SMTP id
 ffacd0b85a97d-47fd2a426f8mr4362739f8f.0.1785501492502; 
 Fri, 31 Jul 2026 05:38:12 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e296csm4474934f8f.12.2026.07.31.05.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:38:11 -0700 (PDT)
Date: Fri, 31 Jul 2026 12:45:13 +0200
Subject: [PATCH v2 14/25] hw/arm: catalina: use the real TMP75 model
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-sanmiguel-bmc-locator-v2-14-1266926ba769@free.fr>
References: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
In-Reply-To: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Emmanuel Blot <eblot@meta.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785494708; l=948;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=yr6ARhHsRJdWelmON/tAwpVgyc94u96MVCdEOI7hMno=;
 b=+vP28J89xkAkyyQIPR39YLuI2lDmZqn8xSBG6w8WrD32a+VWYSs397H+VlsUQBjDilpeF8hRB
 EMdQUT4TIcqDtCp9Dg/7Xt/xBmvTD/zs61OvIcs/xaLARYiT4x8aVW4
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.49; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f49.google.com
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

The Catalina BMC instantiates several ti,tmp75 temperature sensors. Now
that hw/sensor/tmp105.h provides a proper TMP75 model, drop the local
TYPE_TMP75 alias (and its guard) so the board instantiates the accurate
device rather than a plain TMP105.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/arm/aspeed_ast2600_catalina.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 33e75338ef..928e140b21 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -22,12 +22,6 @@
 #define CATALINA_BMC_HW_STRAP2 0x00000800
 #define CATALINA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
 
-/*
- * Guard the alias against the TYPE_TMP75 that hw/sensor/tmp105.h now
- * defines.
- */
-#undef TYPE_TMP75
-#define TYPE_TMP75 TYPE_TMP105
 #define TYPE_TMP421 "tmp421"
 #define TYPE_DS1338 "ds1338"
 

-- 
2.50.1


