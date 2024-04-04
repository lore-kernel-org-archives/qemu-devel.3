Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BE6CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 19:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsSXJ-000660-Vw; Thu, 04 Apr 2024 15:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsSXJ-00065q-FN
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:14:09 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsSXH-0005bK-VU
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:14:09 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56829f41f81so1939197a12.2
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 12:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712258046; x=1712862846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Akez/1J4Qb6iNF6NCgcGNV+l9m0ULLqhTgwyXKIYR5w=;
 b=biuIz3Lb7k3OiGzK1KJnKEVvgp+6unv2z7LZBcXfRlR9x+vzOju/3IAtritJhOANW/
 sMTxr9CYV2tTYf/ndxx/+FfOXxWyN0OPdXi/n7XjtV+EF2KcZ2gf4XF5dV1UKgFGOVxq
 JWtLIFgFhHAzTddAvDYXmreSD5q4R8A8QzPcUJLe0JwEqvePypnzoHx4ht8RE6MGcjuq
 kjy25UM8nEmuFyft0zHNku1X0rcv5A+QO+9a/KtNTC5Rq1bABwC6/3Bx3IKyEnz6JmZ8
 x+Rg4PuHap5WcN78KUDmGJWP1i7eEN2e+lKLJgqI7DIuQE3HyQVKGmVRKolLkI6I7g7r
 W4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712258046; x=1712862846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Akez/1J4Qb6iNF6NCgcGNV+l9m0ULLqhTgwyXKIYR5w=;
 b=EY0GoxafG6E+tn+ivC/4F3gnpFLoMIOr2vtj6VkufET2SkYZrLHmRUxEDxKxnsDKRX
 lMDqHduZyiJU1hiruKe1j1hL/YOSJfgHoM9NtFrdEy16upkwdIjo0KwqhFV8ie9jeOz3
 BfJli2tdoayo3pFp4NXZ4sF2Omi1OA91ixP6ysAXgH1wXQwm39D1OgpUTrXsY8XK5cFH
 k5G9XymdQqzprCtSNxAK4/cTS2Rh3V3DgcIa3IZM+gMDWY4ZHyYqigLipv9+3Ih/+BwH
 Gp8tlBPRKKK/tdCaZ8oiqT/O9Kza/4RC/IlH6dbu5ppZp/N3M6b75LV7RDkNZ++UvPr9
 n2rw==
X-Gm-Message-State: AOJu0Yzr8qYQ5cd1bSZ99wpP38ZAWK3Hm6WT8v+ddr5++dSfE+s32HkQ
 gdeAbKhDsavdcgDe1LDuBIUUXY2F15NQy2Ba2ttFrrvHznQCHqAhuBcH+s4y34QXsIa6xq0HmGd
 3
X-Google-Smtp-Source: AGHT+IGLoMb8t7r7GYKSxyW4HkphOCxA+5iDuPIbupfj+qcbb7fGAayvTK+8ByhvNfY46zdM8c7Ojw==
X-Received: by 2002:a17:906:ca04:b0:a4e:8508:d807 with SMTP id
 jt4-20020a170906ca0400b00a4e8508d807mr2252811ejb.0.1712258046324; 
 Thu, 04 Apr 2024 12:14:06 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.216.111])
 by smtp.gmail.com with ESMTPSA id
 l3-20020a1709067d4300b00a466af74ef2sm9352805ejp.2.2024.04.04.12.14.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Apr 2024 12:14:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Amit Shah <amit@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH-for-9.0 4/4] hw/virtio/virtio-crypto: Protect from DMA
 re-entrancy bugs
Date: Thu,  4 Apr 2024 21:13:39 +0200
Message-ID: <20240404191339.5688-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240404191339.5688-1-philmd@linaro.org>
References: <20240404191339.5688-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Cc: qemu-stable@nongnu.org
Suggested-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio-crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index fe1313f2ad..ac1b67d1fb 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1080,8 +1080,8 @@ static void virtio_crypto_device_realize(DeviceState *dev, Error **errp)
         vcrypto->vqs[i].dataq =
                  virtio_add_queue(vdev, 1024, virtio_crypto_handle_dataq_bh);
         vcrypto->vqs[i].dataq_bh =
-                 qemu_bh_new_guarded(virtio_crypto_dataq_bh, &vcrypto->vqs[i],
-                                     &dev->mem_reentrancy_guard);
+                 virtio_bh_new_guarded(vdev, virtio_crypto_dataq_bh,
+                                       &vcrypto->vqs[i]);
         vcrypto->vqs[i].vcrypto = vcrypto;
     }
 
-- 
2.41.0


