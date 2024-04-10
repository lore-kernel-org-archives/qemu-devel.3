Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A330CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 09:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruU1f-0005n0-6K; Wed, 10 Apr 2024 05:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU1a-0005kH-Rc
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:13:48 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU1U-0005YU-Sg
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:13:46 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-516dbc36918so5072070e87.0
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 02:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712740418; x=1713345218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aTtiohc8j0973gwMd1zGGgj7zIH/1fbKuICF0OE6WHs=;
 b=ydX0ENs1cakZyPrHx8g4P8bHfcRva96W5wA/HKkE0GIBKudortLT5HO9cBeI8G/hk6
 q8CdSOby++kdAnXYfc7Th+qsfngRgEE3ptINN12+7a9KgRvXwnxPKN7jrwyHgjMYCLzp
 WaSOZ2MVB4eGInfC6pNM1K4VWbAE0lyEj0Xdwq3lwtw8dzu65iSoANDYPPI6/vHoTZVl
 UsQ/4KRr1nYsniraaAv8eCfTHJ7/qe9KRKtr8Jyt1Fzb2nBJLxmtGXjwArROuZcGlTtZ
 /RBfCySBiaFUSKf4RqxdCfA8Di33tDpRWGQPPlBTTtyxpFdbketZ6H5LSfAE6P0MUbRQ
 2PHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712740418; x=1713345218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aTtiohc8j0973gwMd1zGGgj7zIH/1fbKuICF0OE6WHs=;
 b=az4lh1W2C7cl2NSDgCr3+dqUTQrJ4mETlcMV0lAk6iP1YIIOWbFz56SlfEnbdHSV49
 uPc2ItPvFEXgacWArsiRRanrrCK3n82l/N+Ux8vBApZIopZMfNGR5FtkVukLjqoTCq5m
 UIb6Vda+SldyBqMRO69b6DvMUzxlh8DktDxFbv1gtIFZ7RSHYxBBPTymrQ9F3SvZ8/qL
 9Qc+QMXkRZRMjSuXSxO7U7JtPqVcv5MOTCES5itoXx0/A2SrBnb3tvAIv0xuOBlxKgWC
 80tQKVs2eTf/y9giOI0eM7K0S3XmKkFFccbcGEHt5ud52gavTNigPxR4GvY8LgglQYYD
 r2jA==
X-Gm-Message-State: AOJu0YyCgrBRYgSwqrhuovDgvK3gINMJz/bCfF4smsBblMEqVjSxVTtV
 AcMS+ww8QvkCRMzIyhkngug3T2WsPlz2vsgx3S6buARzzpG0L1P67z/D5QqAX9n06/mW9cdxWBn
 F
X-Google-Smtp-Source: AGHT+IFSrHosw8rD/3TxcC7XkOpoK7Qx97GPqOoe9Lr+K8BLfhzrHr2fCN0HiAEA6wwWOTjQm8pRWg==
X-Received: by 2002:a05:6512:3b26:b0:517:64ec:1251 with SMTP id
 f38-20020a0565123b2600b0051764ec1251mr1427777lfv.15.1712740418030; 
 Wed, 10 Apr 2024 02:13:38 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 ao11-20020a170907358b00b00a51aa517076sm6349767ejc.74.2024.04.10.02.13.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 02:13:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 03/16] hw/char/virtio-serial-bus: Protect from DMA re-entrancy
 bugs
Date: Wed, 10 Apr 2024 11:13:02 +0200
Message-ID: <20240410091315.57241-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410091315.57241-1-philmd@linaro.org>
References: <20240410091315.57241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Replace qemu_bh_new_guarded() by virtio_bh_new_guarded()
so the bus and device use the same guard. Otherwise the
DMA-reentrancy protection can be bypassed.

Fixes: CVE-2024-3446
Cc: qemu-stable@nongnu.org
Suggested-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20240409105537.18308-4-philmd@linaro.org>
---
 hw/char/virtio-serial-bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 016aba6374..2094d213cd 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -985,8 +985,7 @@ static void virtser_port_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    port->bh = qemu_bh_new_guarded(flush_queued_data_bh, port,
-                                   &dev->mem_reentrancy_guard);
+    port->bh = virtio_bh_new_guarded(dev, flush_queued_data_bh, port);
     port->elem = NULL;
 }
 
-- 
2.41.0


