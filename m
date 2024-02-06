Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76DAC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 17:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXOzv-0003pJ-49; Tue, 06 Feb 2024 12:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXOzt-0003oo-LX
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 12:12:37 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXOzq-0003XY-Je
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 12:12:37 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40fb3b5893eso47649065e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 09:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707239553; x=1707844353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PrRJ5d76QadE8MBCkQGSm2LWsORcf86H/9Nb7qmGBtc=;
 b=ojx3gydlZ84j1rkyFXhGxr2oYHB73q3gjJeAEjmLek46Mgz3kLbhPbq87jObFmfxzA
 2IIeWYw3oLQHNS927OusX48HhIZEGHIixzP4s5DLm9CXboxSCztFT8hgRn4Epz8CBst9
 2AIqDRzqEOuGgCeYJTg/v4q+KtWHkSHwPmZyiv4Uzmmm+0TgxRak51c9G26n6zCKTI0K
 6L0ag67z24xV+vo0hlCrXW3cV+3IMjDi9SoaCwuG7oCCx8Ab022sNF9DHFAfrjLRcVZF
 5XObIFUvaWsMyi9ZA+TgTVRmMTQSsLJSW7Z02pkkWdSCMlNiLe7UjNVvCbavmFstULXx
 +MMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707239553; x=1707844353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PrRJ5d76QadE8MBCkQGSm2LWsORcf86H/9Nb7qmGBtc=;
 b=fLhEAvSr5fq7q5fxnxAzrW6jpxWJ6HgaL4fE7oWpD98+M5fVhLQb/oMSsufiqrPHEj
 N7QDfEDEKPLw0/xoDPgd9zVzIxPoxyLwSDP7or81gYbjsObZen5M8X5DMMbiESKWGJaH
 PUtX6v7r1dzF9IrSstCMWxvfjAnjRcBysa0qcVeinlyOpvhyE+0YWK1d4+l9li/J6lC0
 dEcoDtCTcyidmFcAS3q28w8E8CSkVm8ZCvURWGZkaOgJiTBaDOlFeQzDYXsGPtOwBnTP
 aEIy/NXAeAcljkgzotvCl0wMqjXL3WL8HBdMwP490twhL1T47GRXLxqJeTcBGVZSdzvu
 gaEQ==
X-Gm-Message-State: AOJu0YxHz5pnkjgLpRGd4rGNOtpL+pH9yN3V7Da9gJjNNZ5dbqa8Q0/u
 GXceuQ4RIlXMu28s8WxTd7/b6AxgzKApQudwBgCCgmpWhFAWV4j9JkpxDdcY3jgr5CR7d+Rn44O
 R
X-Google-Smtp-Source: AGHT+IElQ4Fhbni4yimfhg4x4bipMa0zIwk1u8skF7rSpI3LQkffIGa9o8Lt0Kj6tQj5kBIH1I2F5A==
X-Received: by 2002:adf:cc8d:0:b0:336:76de:c171 with SMTP id
 p13-20020adfcc8d000000b0033676dec171mr1726208wrj.62.1707239553103; 
 Tue, 06 Feb 2024 09:12:33 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWrtJt+URG6QvNQSw7sNjxDtAWWtLTan3pIGQKX7+MclM8g4YZyfgLNZ5F+SWfrzDbMwfhwMa/rRzwieUPjjca8A0Wqq8BpyJ7/W+cltLz8HuyQHB2DGK5Io2WagPOeL7sCqZKSivf6rS6PgT/DZBlxxmGg
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a5d4bcc000000b0033905a60689sm2561284wrt.45.2024.02.06.09.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 09:12:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw@amazon.co.uk>,
 Nabih Estefan <nabihestefan@google.com>, Hao Wu <wuhaotsh@google.com>
Subject: [PATCH 1/2] hw/arm/npcm7xx: Call qemu_configure_nic_device() for GMAC
 modules
Date: Tue,  6 Feb 2024 17:12:30 +0000
Message-Id: <20240206171231.396392-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206171231.396392-1-peter.maydell@linaro.org>
References: <20240206171231.396392-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The patchset adding the GMAC ethernet to this SoC crossed in the
mail with the patchset cleaning up the NIC handling. When we
create the GMAC modules we must call qemu_configure_nic_device()
so that the user has the opportunity to use the -nic commandline
option to create a network backend and connect it to the GMACs.

Add the missing call.

Fixes: 21e5326a7c ("hw/arm: Add GMAC devices to NPCM7XX SoC")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/npcm7xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index ff3ecde9043..cc68b5d8f12 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -710,6 +710,7 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < ARRAY_SIZE(s->gmac); i++) {
         SysBusDevice *sbd = SYS_BUS_DEVICE(&s->gmac[i]);
 
+        qemu_configure_nic_device(DEVICE(sbd), false, NULL);
         /*
          * The device exists regardless of whether it's connected to a QEMU
          * netdev backend. So always instantiate it even if there is no
-- 
2.34.1


