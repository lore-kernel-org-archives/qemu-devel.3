Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FB6CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 09:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruU27-00060W-1P; Wed, 10 Apr 2024 05:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU25-000601-Bs
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:14:17 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU23-0005ba-VD
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:14:17 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a51ddc783e3so370649866b.0
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 02:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712740454; x=1713345254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/MZTGZdwMOzZ2yxKjK4p8nmin3fYzpAE8Zer+jhlYRQ=;
 b=u1FU4Smc6L/452yzc96I6Iar/c9yr+3knoCyCv7lelrHxiHD+97kbewGjZxBFTqLPz
 f1iYDjp0oIsQ9QgpUInRzdzbYT5aXAQMAu/s/SAy5Gt1mTe/VTK3zrBGpwmLa7jELsAz
 xHsD2lR1pWN1rWjnC1jkFwtdjt7GUUn58WS5I3ULUzdTnGm9bjEZRZvj3yZzjk8sVrNN
 3u02sKdzZ5nRGMVzbnKa1J/a5mh35tYEYV7CESHa3WFaypnsaZExMGO3DQo9i2e1/8Rm
 6ypVqw4geXFc7RMjTEArsoH4cYzwYL5XPeTtuXEMIfc/5NV3kCQ5BilzN6g8d+ndxQkR
 unpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712740454; x=1713345254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/MZTGZdwMOzZ2yxKjK4p8nmin3fYzpAE8Zer+jhlYRQ=;
 b=XYHgalY9oO7oEcXhw993bOcGm6R0WALB4JlpCve8tOuRcPSMGglKiqs3WTw8a7ckuQ
 sRJp4OfxYbg2CM2I/h3shZViZpedad4siDsvRiB9G1hmweReYz+HOcLmClBYOYNzUXm5
 M2Qzo+pSiVRHACKElsSiGK2tgQpe5NWLBpxo/VpRMxYOnvl42HWAs7gwYnEaeOJB8hy+
 ix7vVggqOoXugoqu828mBInFiuiwU6bxJuJGxHmv5ugw8hDp/gMhYFmbiNd00xmtwdbs
 7mZTAYL7zK+A32+jY+/G4qusfgvj8C1owpGOdcC5NO4mAHQVzO/CIet+gUGr/SHpkAe3
 ZVJA==
X-Gm-Message-State: AOJu0YynM9lw85H86qgr+btlP3ue2Y/J4101nA5b+7HGRxILwwh6rfiy
 9n062awUyJVFef37iS4WAXTRJPp9W2BPBBLcqitmd2uwZWb8iJuGU+zgmD4fi0zuqcRZZcLtbMb
 F
X-Google-Smtp-Source: AGHT+IGo37IkCX/up1RQnu58ITbbHvNBsONYaqD03IrTxmSJVUnBfS43et6OuVabKaxiBL8GCMSFrg==
X-Received: by 2002:a17:906:448b:b0:a51:a676:db26 with SMTP id
 y11-20020a170906448b00b00a51a676db26mr1131338ejo.21.1712740454346; 
 Wed, 10 Apr 2024 02:14:14 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 lv27-20020a170906bc9b00b00a51a67f08d0sm6600986ejb.77.2024.04.10.02.14.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 02:14:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 09/16] hw/misc/applesmc: Do not call DeviceReset from
 DeviceRealize
Date: Wed, 10 Apr 2024 11:13:08 +0200
Message-ID: <20240410091315.57241-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410091315.57241-1-philmd@linaro.org>
References: <20240410091315.57241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

QDev core layer always call DeviceReset() after DeviceRealize(),
no need to do it manually. Remove the extra call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20240408095217.57239-2-philmd@linaro.org>
---
 hw/misc/applesmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 72300d0cbc..8e65816da6 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -342,7 +342,6 @@ static void applesmc_isa_realize(DeviceState *dev, Error **errp)
     }
 
     QLIST_INIT(&s->data_def);
-    qdev_applesmc_isa_reset(dev);
 }
 
 static Property applesmc_isa_properties[] = {
-- 
2.41.0


