Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F7FC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeEN-0006ks-4f; Tue, 02 Jul 2024 10:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeE0-0005Qj-EL
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDx-0000Sf-1q
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YWXH9YhJGBTUPtLIg1EJaieR/oMq54SMMzeEyf0UDBU=;
 b=he3z1wNg8IJZhKH/NOiIMXHL9ieV9fUrH9BEVf7AVV4FXRDT/rP09FSogJsvXcXHG8edZL
 2CQV2+fFxx5AfxuPIQjWdtb+IcCQPuMipa/ES134DpXRstYuYghkJSUd+d+2wlXn25BXxL
 7goUWmE7mgxv8ETbW0tORdFHPBseo2c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-nKzbKYCBNK6vvN7P2zsauw-1; Tue, 02 Jul 2024 10:11:11 -0400
X-MC-Unique: nKzbKYCBNK6vvN7P2zsauw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42490ae735dso39307985e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929469; x=1720534269;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YWXH9YhJGBTUPtLIg1EJaieR/oMq54SMMzeEyf0UDBU=;
 b=jeH2BbrpBsesM6IAyomOZL2mx9+uMa2Id2mIkETqb7XgNMVK4Smzs6gMFDmw5sysMB
 90M4pkokvbHssk+0qRfEtnV8KJsKLi1JZa80BOykAHbbiwIfZNbX9RCDouJmkg5NRaXQ
 dit6b5ibFwN2MSqlb1Zl+fcKbUeYJG3/K0vSPNEB7r98+yZ6gQKNuRv9J5npibhGFPmB
 36Kqi/orTV8U0xzSY2ivkfneSOvmAFLTW7CG9JCXbz0rUyvWbJFptjpS6opTsW/bfZkG
 FtxbjNwOvtVj8wH2yiJzoj6b+70sYfuyJ9vJw4UJRtd6kxgSpHvk+YbHWLDrdT0QDFed
 cjHA==
X-Gm-Message-State: AOJu0YzZw0A0Kz/1tTgDRGJWsD7prNaN1AhXtPrgJkofTlXd4ZANWnFm
 LLYHHzFHv5BPY+QavZnDj2uNiEt5JsDZeRV18pdI/ZwSxrpjU9yneXkkFSP+7wXFN/q1veAnO5m
 sRvbZjXRfChAEYBgMxFik5y/Y79P6lj7fKRv+lskbBdnf3Zs0HuXKX0n2MzY6yDPe7Mxcfdav55
 2v3i06sTttz35NmUVf3BWkzrFxSIqWZA==
X-Received: by 2002:adf:f18b:0:b0:361:dd0c:678 with SMTP id
 ffacd0b85a97d-367756bc471mr6554379f8f.36.1719929469638; 
 Tue, 02 Jul 2024 07:11:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFkW784N+QYRpKZGuvfSqwvMm0SkFb2EIMkyD6K8g1BQsf04aP1J9tDnDwBxPlOGqHd6nUWg==
X-Received: by 2002:adf:f18b:0:b0:361:dd0c:678 with SMTP id
 ffacd0b85a97d-367756bc471mr6554348f8f.36.1719929468985; 
 Tue, 02 Jul 2024 07:11:08 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3678e5c2b08sm805506f8f.71.2024.07.02.07.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:11:08 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:11:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
 qemu-stable@nongnu.org, Xoykie <xoykie@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL 80/91] virtio: remove virtio_tswap16s() call in
 vring_packed_event_read()
Message-ID: <5f9b2cdb0e4bc7eab026bd5ee8ab120f327b86a8.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Commit d152cdd6f6 ("virtio: use virtio accessor to access packed event")
switched using of address_space_read_cached() to virito_lduw_phys_cached()
to access packed descriptor event.

When we used address_space_read_cached(), we needed to call
virtio_tswap16s() to handle the endianess of the field, but
virito_lduw_phys_cached() already handles it internally, so we no longer
need to call virtio_tswap16s() (as the commit had done for `off_wrap`,
but forgot for `flags`).

Fixes: d152cdd6f6 ("virtio: use virtio accessor to access packed event")
Cc: jasowang@redhat.com
Cc: qemu-stable@nongnu.org
Reported-by: Xoykie <xoykie@gmail.com>
Link: https://lore.kernel.org/qemu-devel/CAFU8RB_pjr77zMLsM0Unf9xPNxfr_--Tjr49F_eX32ZBc5o2zQ@mail.gmail.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240701075208.19634-1-sgarzare@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 3678ec2f88..583a224163 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -323,7 +323,6 @@ static void vring_packed_event_read(VirtIODevice *vdev,
     /* Make sure flags is seen before off_wrap */
     smp_rmb();
     e->off_wrap = virtio_lduw_phys_cached(vdev, cache, off_off);
-    virtio_tswap16s(vdev, &e->flags);
 }
 
 static void vring_packed_off_wrap_write(VirtIODevice *vdev,
-- 
MST


