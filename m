Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E39BC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDFd-00062Q-Mh; Wed, 14 Feb 2024 06:16:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDFW-0005qz-8V
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:16:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDFU-0007Uo-Om
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5PjSQ+n8yhW/Y6dlynPh+22i7hOBitqudNQgzkqsiGE=;
 b=hnlJ5pTalTQB7THnVo0bFPbos2XsrmbPuIOMahBavhya/PuOu4mCJHrns9a48ccLNGQRoQ
 O6xOwwjvwGP6DMw+2u2fLvZ29G/7Xye0zu5268jooB4AHPrEVXgiD5dYP5TN7Y4+MaQjXM
 XMONx0TTZiFSVFsn/wtikz89jQmeSxM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-G5mHQel8NBOUz6mPhlzpsg-1; Wed, 14 Feb 2024 06:16:19 -0500
X-MC-Unique: G5mHQel8NBOUz6mPhlzpsg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-56217800333so625174a12.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:16:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909377; x=1708514177;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5PjSQ+n8yhW/Y6dlynPh+22i7hOBitqudNQgzkqsiGE=;
 b=DB5vdC1byxUY41MYRi2cvSlH8FAEcLaelT6dddEUpe9+TzV2etiaHPBZW/1QsMFCoZ
 +orNRkpcMbG+m0qFurzaR/T9kCQNNECGi+9ZFHPYulI4rbZdxmX82DCza9YRJ7+iYIzp
 K6q+zoMMG0YrijZ//MoFlpRG3+kCCrj7ITH3uargpI+huogKVAeGfNkPTuIwvQdfv1Lw
 ByIgy0vxb541graw0t4HQ9E4kSjqRmQLCgef6TZLti3n9oaGAiBTzk1H6cP31ZwO2xrc
 lbg4kyfDi5INFM8bCbvSkFitzMorgPUjN4w19BlZruKtMeAavsrIrzSQRzETUlIrFQju
 iaCw==
X-Gm-Message-State: AOJu0YytXqD2IUzu+9tFz3uEbGlBk5Wa8GcEvVK7ZUqa0YFwu2aeJjob
 EK/Q4WlhwIbnQGeJdbI0Y6MER+thGpPQyksRu+0odLu6RsXFcF2adMhbXCE13mZnfYCPBE3f4sI
 kbIOjdHHUuSwq0NG2Q6KYjKxC/pf3CEVU6NjYRbAqybGp47N2aonscb3XsgfYr4K94BfUqHXJje
 kvby/PcisAIRIHjuzwuXTwE1GV+vL03w==
X-Received: by 2002:a05:6402:68b:b0:560:311c:4fcb with SMTP id
 f11-20020a056402068b00b00560311c4fcbmr1682773edy.33.1707909377282; 
 Wed, 14 Feb 2024 03:16:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfJn3MC6LytzZA3b2es6L56pSoo1IY8/mVm8732O+26FD8TZbPtycS7snAdBw/Rv/WroqOPQ==
X-Received: by 2002:a05:6402:68b:b0:560:311c:4fcb with SMTP id
 f11-20020a056402068b00b00560311c4fcbmr1682760edy.33.1707909377002; 
 Wed, 14 Feb 2024 03:16:17 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWAWVJEnDAscxTX86fOco2JV5YDdKm1tc+ScnftSABHqGLj3bXQdUIShsNIsuzIHODRIrnzpD+zYwoGLsHHAWyvBn5Mth5d4LzjtFLawr68ZhYcL/uUpYWLlHTSsXMu9IxmqYYSR3piHBbOnjy18l0s4ec/EaGJvQlRVfnjUEg=
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 i32-20020a0564020f2000b005617e079110sm4141059eda.81.2024.02.14.03.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:16:16 -0800 (PST)
Date: Wed, 14 Feb 2024 06:16:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 57/60] hw/display/virtio-gpu.c: use reset_bh class method
Message-ID: <8b162082cb2d495f8661b7ee3239a36936dab2ee.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

While the VirtioGPU type has a reset_bh field to specify a reset
callback, it's never used. virtio_gpu_reset() calls the general
virtio_gpu_reset_bh() function for all devices that inherit from
VirtioGPU.

While no devices override reset_bh at the moment, a device reset might
require special logic for implementations in the future.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <87fb4fa72ce5b341a6f957513a00dcb79fd5997f.1706626470.git.manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/display/virtio-gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index f8a675eb30..2b73ae585b 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1515,7 +1515,7 @@ void virtio_gpu_reset(VirtIODevice *vdev)
             qemu_cond_wait_bql(&g->reset_cond);
         }
     } else {
-        virtio_gpu_reset_bh(g);
+        aio_bh_call(g->reset_bh);
     }
 
     while (!QTAILQ_EMPTY(&g->cmdq)) {
-- 
MST


