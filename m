Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69BBC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgkb-0006lJ-DW; Sun, 21 Jul 2024 20:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkY-0006Lt-10
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkW-0005ot-I5
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RbreE3gRMg3HkdLWMl2uNhF2Or3FkZXwY0kwp8ati68=;
 b=HvwmU7w5HoDnZs42uxB2Bxiitw7mtfU73fd8T7Q8QTDgAKqEvCKZu60pHq6rHY2ked5sJs
 L3nJ77YCjmlTjPdiHHiuwoIwkFe2xKFKIzGr8gNbggsw7fplytAJFiuxa9eersW3yJNnV+
 wiqLiay3tfC8LvK5FEMF9Qes1XyRgfg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-r6xD_lWiNQCrUiv5ATiWjg-1; Sun, 21 Jul 2024 20:17:52 -0400
X-MC-Unique: r6xD_lWiNQCrUiv5ATiWjg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-369bf135b49so665206f8f.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607471; x=1722212271;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RbreE3gRMg3HkdLWMl2uNhF2Or3FkZXwY0kwp8ati68=;
 b=YzoUu4GD5XIBc03Fn6MtXBdMQn3cwumd+whR7Ultap4eKiXx6FzeJdJjcmKPh49dlf
 RzNDOX1uk8aTyQP0+s3Gd8IPVlayHcxyzjNyTG0ENN43JeOcg72cAEdkcc/R7LmzstTR
 hzIv5niwvru1s0f5FQyHfcM/n9kso6lbeCFTuNDD86N7NqI/H2f0/zPjyTsH/5+hMfZ4
 56h6PMDo5HDWiZGuQ5laPpOfI6FpxLkws4KNH7Zz7Nr93BhK+CrGkKr3XKG1qm30srTU
 Q7JYjCd96eJs7Sw5ZIzMvp2hIe5aQrIEJ8xKKnG1gFbS+B7nLFjbpscX/QwtADQxYwMJ
 dN7w==
X-Gm-Message-State: AOJu0Yz8Pag2tP6JsGRXafxYWJ4qI/3iMrMy9bKE+kNGymXogCGfMK4J
 EtLap0/r2qi3j2zjrtWfblM7drVMKczyDPrCfPJ9R3UYja9R7TV46q9bIh+XG1xP0vT16ZDGsFv
 y+y0NGfKnv3sYyWcLrs4u7I39+neyG4rw4j7aRYbWma/LLKigB87KbZe4VeKp500ZAgh5pDtGi4
 JwnkwTPjU72U70sxkQmMdpuZV7W3ieyQ==
X-Received: by 2002:adf:ef02:0:b0:368:35b8:129e with SMTP id
 ffacd0b85a97d-36873ed7c49mr4990094f8f.13.1721607470835; 
 Sun, 21 Jul 2024 17:17:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMr+xClpJWFy3DqUbuV6wkHl7tYSkOhCuLKOaeCVEsVlkB6uE2ZqPBS/Voc9BN0tX6PU98EA==
X-Received: by 2002:adf:ef02:0:b0:368:35b8:129e with SMTP id
 ffacd0b85a97d-36873ed7c49mr4990079f8f.13.1721607470242; 
 Sun, 21 Jul 2024 17:17:50 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868bc42sm7025824f8f.46.2024.07.21.17.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:17:49 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:17:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, changpeng.liu@intel.com,
 Raphael Norwitz <raphael@enfabrica.net>
Subject: [PULL 28/63] contrib/vhost-user-blk: fix overflowing expression
Message-ID: <99d7c1b99a3fdb69213c09da6b7614243f877bee.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefano Garzarella <sgarzare@redhat.com>

Coverity reported:

  >>>     CID 1549454:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
  >>>     Potentially overflowing expression
          "le32_to_cpu(desc->num_sectors) << 9" with type "uint32_t"
          (32 bits, unsigned) is evaluated using 32-bit arithmetic, and
          then used in a context that expects an expression of type
          "uint64_t" (64 bits, unsigned).
  199                               le32_to_cpu(desc->num_sectors) << 9 };

Coverity noticed this issue after commit ab04420c3 ("contrib/vhost-user-*:
use QEMU bswap helper functions"), but it was pre-existing and introduced
from the beginning by commit caa1ee4313 ("vhost-user-blk: add
discard/write zeroes features support").

Explicitly cast the 32-bit value before the shift to fix this issue.

Fixes: Coverity CID 1549454
Fixes: 5ab04420c3 ("contrib/vhost-user-*: use QEMU bswap helper functions")
Fixes: caa1ee4313 ("vhost-user-blk: add discard/write zeroes features support")
Cc: changpeng.liu@intel.com
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240712153857.207440-1-sgarzare@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/vhost-user-blk/vhost-user-blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index 9492146855..6cc18a1c04 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -196,7 +196,7 @@ vub_discard_write_zeroes(VubReq *req, struct iovec *iov, uint32_t iovcnt,
     VubDev *vdev_blk = req->vdev_blk;
     desc = buf;
     uint64_t range[2] = { le64_to_cpu(desc->sector) << 9,
-                          le32_to_cpu(desc->num_sectors) << 9 };
+                          (uint64_t)le32_to_cpu(desc->num_sectors) << 9 };
     if (type == VIRTIO_BLK_T_DISCARD) {
         if (ioctl(vdev_blk->blk_fd, BLKDISCARD, range) == 0) {
             g_free(buf);
-- 
MST


