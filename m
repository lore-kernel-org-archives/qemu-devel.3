Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1F8C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeCa-0000fg-M8; Tue, 02 Jul 2024 10:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCS-0008Vr-B1
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCA-0008Lc-5h
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iKFeowSJAGhilDZfxfLdJ5fHZQGvWfI2BMoyWfTY0Wo=;
 b=DHK7awJUuTkReY/KFSV08GmDRQMZujf/Jyis2rhp/8aNCON2/nwXy71jpIoMcAyXQo+i5H
 bPGSHO0PByCoDb9mzdOfGIxq+gxzAaSEMZDx8UFKTAh5R//sFKdLLbdUoTzlVZJvlJDvXO
 Ek++HYpQUWlymELREBgeEEiYRPG0wKg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-S6WE9z1OPcWLDDU0trQP2A-1; Tue, 02 Jul 2024 10:09:18 -0400
X-MC-Unique: S6WE9z1OPcWLDDU0trQP2A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4256809ae27so27882905e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929356; x=1720534156;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iKFeowSJAGhilDZfxfLdJ5fHZQGvWfI2BMoyWfTY0Wo=;
 b=Cfgivc6UgTHqAXJ2ENaaS3zIaSOQTO+PlhPN3AWwrUbt9R+EkhgKBkk6EPlhf/MqmO
 uVokh+Qyk2w23Gh7ONSnwbg2u+5AILCpN3Mk58Rk+YaSzR0S9eRaVcgrqPA9+SJookbT
 6Lq5qfvVF3sjsczhhoD8lmig9wAEioxFV7Dc90rtyJGS6kyKTsETmXAHg8i/Fe4i8S2o
 Ow7j+6rkYubqEc5BUNuDKnyWgcOU86JAzGJR3RZnlZF02bR6XUPaiobdPBthqmULZG1U
 /hPB3HDoiza0noIbNttKhGpC9O+uiV2YFfEOywNHCOYUgGIvMkfHYfefb3EZ9I5lIj+u
 kCXQ==
X-Gm-Message-State: AOJu0Ywx1sCJQ2VU4qgxMPeWCkKQEeIXu5v/KWmT4cO7R0ufA2nyQT+t
 TdM2IthJW7/FC3vlA8xsxdFs4yaGJvx3Mbpq1tezRiQwW3BNOHG5xemHcRWNf1wsqgAczykHvVI
 r6Gdix9MMwxdoA2HbVtz/HsnczncYuKdAZeH2pKUOd8EouOr3tFmXqAj7W17lK2i+wGUrTNMb8v
 bn4WZ8LLphJ1vRqg1WvR8BZ4mxeECJlA==
X-Received: by 2002:a05:600c:3089:b0:425:7835:4382 with SMTP id
 5b1f17b1804b1-4257a06da46mr69368105e9.34.1719929355854; 
 Tue, 02 Jul 2024 07:09:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYhhUxgOUBoVeoPojhGnoBsde97DcBQEjbJucX4F1iYVRgfogJwjvGPENSsEJ+Wjx7ap5bjQ==
X-Received: by 2002:a05:600c:3089:b0:425:7835:4382 with SMTP id
 5b1f17b1804b1-4257a06da46mr69367865e9.34.1719929355305; 
 Tue, 02 Jul 2024 07:09:15 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a103371sm13375112f8f.101.2024.07.02.07.09.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:09:14 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:09:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 BillXiang <xiangwencheng@dayudpu.com>
Subject: [PULL 44/91] vhost-user: Skip unnecessary duplicated
 VHOST_USER_SET_LOG_BASE requests
Message-ID: <df4de32475fe554351d63049a8c92783c724ec36.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: BillXiang <xiangwencheng@dayudpu.com>

The VHOST_USER_SET_LOG_BASE requests should be categorized into
non-vring specific messages, and should be sent only once.
If send more than once, dpdk will munmap old log_addr which may has been used and cause segmentation fault.

Signed-off-by: BillXiang <xiangwencheng@dayudpu.com>
Message-Id: <20240613065150.3100-1-xiangwencheng@dayudpu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index c407ea8939..00561daa06 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -371,6 +371,7 @@ static bool vhost_user_per_device_request(VhostUserRequest request)
     case VHOST_USER_RESET_DEVICE:
     case VHOST_USER_ADD_MEM_REG:
     case VHOST_USER_REM_MEM_REG:
+    case VHOST_USER_SET_LOG_BASE:
         return true;
     default:
         return false;
-- 
MST


