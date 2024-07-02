Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF505C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjzV-0004qW-TT; Tue, 02 Jul 2024 16:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjzK-0004Y5-MT
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:20:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjzF-0001aC-8y
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YWXH9YhJGBTUPtLIg1EJaieR/oMq54SMMzeEyf0UDBU=;
 b=flYqZ/x7GxGSH/bx0K9XWABSzehITGUakGWQcbaunMzMHZDoN670SsqwDqk2XzM92JhItx
 zmQ/zfTMG3ZOMhCUHhRKqrawMXUJgahqjauLr3wyq/qRsqufAnqbRKcwMKSMIM4eUqYrZS
 /SP4YFt1SJuzaL/2jUoqyS7MxRSX8NU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-acjIyXnuOHumOJgH4ahKBQ-1; Tue, 02 Jul 2024 16:20:23 -0400
X-MC-Unique: acjIyXnuOHumOJgH4ahKBQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-364b75a8194so2826585f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951621; x=1720556421;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YWXH9YhJGBTUPtLIg1EJaieR/oMq54SMMzeEyf0UDBU=;
 b=Eo8LL1aih9YlYUgtHIvSeqkXU/pmx2pX9ZGbW3olaqzS1qAvOwGmOY+hSzJQa8pLAx
 IVQ2XCAv0stkmV8TaBFgyJRgUgy32O+Dtai/OS2t3h2N0y1aiWh6dmzugyZ9v3yUeKGC
 lcFIxp8VWc/0jESU3z68jHpjvJCxNsenuziEx1P4yxKXNRzsEIiGb0RT2G2zrDFlsupq
 iBfjav0j2lma3tHkLiIRMU+3s41231TNQG1KWTLgw1ycUVvYi06PQtF2ZSX4Z68OBXvt
 V8I29rn67cdUc3FWXWDaSe0HUAqqrN25pauMRQg7qClv86tOCffabKjGDU6M2j309d8G
 DNkg==
X-Gm-Message-State: AOJu0Yw/Qplylkf8y4N5MnXs52EBf03/PJxKDjxR8IaKOtUZQRXk6ZxQ
 tr2g32yDyllWlmvsB9WKAma4SBfdfwPSi0ZHkO5FQMqIs+TVaccXeirLAsrZoVExX7JG5YTVUmZ
 eODFLzPu+cVrmhNqsZTNc7+Xh9DuGTtw8wSd8MxMV0WTgFw+oKO/xPDlIXU7Nt6idDUwdChx0ON
 pG5E/AaS/oRmKuccVRP/7zkqO9ce8Fgw==
X-Received: by 2002:a05:6000:2c4:b0:366:f84b:a9f8 with SMTP id
 ffacd0b85a97d-3677569d1f3mr7014786f8f.14.1719951621359; 
 Tue, 02 Jul 2024 13:20:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvxGBr0DlgZx04DKEE6XsjQ9mRdNRLZEecLPXdjzDu8TIbMq3XBnVe02WBSDIiE4S9bdav0g==
X-Received: by 2002:a05:6000:2c4:b0:366:f84b:a9f8 with SMTP id
 ffacd0b85a97d-3677569d1f3mr7014770f8f.14.1719951620638; 
 Tue, 02 Jul 2024 13:20:20 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d8df0sm14224798f8f.29.2024.07.02.13.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:20:20 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:20:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
 qemu-stable@nongnu.org, Xoykie <xoykie@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL v2 77/88] virtio: remove virtio_tswap16s() call in
 vring_packed_event_read()
Message-ID: <ea404555c03b6fd907d8a1af5736d02f1fc468a4.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


