Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAE3C531DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 11:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgMcE-0005fq-1f; Tue, 20 Aug 2024 07:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sgMc3-0005RX-Li
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 07:01:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sgMc0-0000Of-H5
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 07:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724151674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NJHuSSqx9NYPg4fKD8Ic1nfZlMJ/j2PZ+yLAGz2U35U=;
 b=Ip5Gss1QObsPrLjgpJfcnUf1Nc05qY6PeuNoDiSwQ6z7l2aQfE3MTJ9GboJFyrysjiLlUx
 /CE3K+qH8IyGwmUNBxXdNcknAEdMdWGgNQgVintNrj/q5PZ6DPz8HzIQSyw63ddBOKvpt4
 HToPCFmWSdDoDMaAddx6mtBOcGpSeRo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-VES8BGYOMHGN1r0JSuZ1gA-1; Tue, 20 Aug 2024 07:01:13 -0400
X-MC-Unique: VES8BGYOMHGN1r0JSuZ1gA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-428040f49f9so46915925e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 04:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724151671; x=1724756471;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NJHuSSqx9NYPg4fKD8Ic1nfZlMJ/j2PZ+yLAGz2U35U=;
 b=rYS8PDlUeEPP2IijFwm0itFQMP7nsxuqyCxM+4h4Zc0sbENWKWQ2mXGvP3E4NHyej/
 N0pwHIrXkqkdp9eAfgODosWI8xPZKcW4JcoOBluni1ycFqaUjgHxooigXoU/E3+DXyQd
 dBbI8jlSYDrq2TiMS+vtYSjrG2A9eD9OVmWO9DYxNl1nyDceExngurmeFDUUmkD32cdG
 sSNq3dso7CLMMPH6aUaPk1/GTJ+oWYXtG8kCgITPOAqSXMC9UyUp7apaN3WfP5y+gshy
 Et0UCKivrmYpVVMhwwytVXUv1ti8AqcGtwnmc/M6s5appe1kkx/sb1n0OqoEmFeBVu6j
 yk6Q==
X-Gm-Message-State: AOJu0Yw3n4y97DXW//uZpIwmljJhxLTG9iF5vuoF4WT8J07xAYYnwbAD
 A2q1jQjv8toA/gWlgTAn1qhuIxatcvvI0Il1ooHYvygqMiY0pq4Ys/6bIXUhxx9zm1tKroexC98
 jfitjJFi5GFRVs1gCz1OFnv2bHwFlBAiAGvxIiR2BjD6m9FFvIICDJ7CigBC2HucyTEWK2rlOwy
 eQacOzucI7w1y5LfGyX7xd5cd1pv1JTA==
X-Received: by 2002:a05:600c:4692:b0:425:7bbf:fd07 with SMTP id
 5b1f17b1804b1-429ed7856b4mr103466275e9.5.1724151671274; 
 Tue, 20 Aug 2024 04:01:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAEqGWOkwUHY5s5Pe15PmZseCT8CSZQJLiETuNdDihcI0MPpWW/zrA/8Dp8R3Sz72vC8Xo1A==
X-Received: by 2002:a05:600c:4692:b0:425:7bbf:fd07 with SMTP id
 5b1f17b1804b1-429ed7856b4mr103465785e9.5.1724151670351; 
 Tue, 20 Aug 2024 04:01:10 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f4:a812:cb6d:d20c:bd3b:58cf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ed785708sm138876605e9.37.2024.08.20.04.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 04:01:09 -0700 (PDT)
Date: Tue, 20 Aug 2024 07:01:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 1/3] vhost: Add VIRTIO_NET_F_RSC_EXT to vhost feature bits
Message-ID: <f8e09b973ae8489b88394bff0118d19f989bf277.1724151593.git.mst@redhat.com>
References: <cover.1724151593.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724151593.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

VIRTIO_NET_F_RSC_EXT is implemented in the rx data path, which vhost
implements, so vhost needs to support the feature if it is ever to be
enabled with vhost. The feature must be disabled otherwise.

Fixes: 2974e916df87 ("virtio-net: support RSC v4/v6 tcp traffic for Windows HCK")
Reported-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240802-rsc-v1-1-2b607bd2f555@daynix.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/vhost_net.c | 2 ++
 net/vhost-vdpa.c   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index a788e6937e..dedf9ad7c2 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -50,6 +50,7 @@ static const int kernel_feature_bits[] = {
     VIRTIO_F_RING_RESET,
     VIRTIO_F_IN_ORDER,
     VIRTIO_F_NOTIFICATION_DATA,
+    VIRTIO_NET_F_RSC_EXT,
     VIRTIO_NET_F_HASH_REPORT,
     VHOST_INVALID_FEATURE_BIT
 };
@@ -81,6 +82,7 @@ static const int user_feature_bits[] = {
     VIRTIO_F_RING_RESET,
     VIRTIO_F_IN_ORDER,
     VIRTIO_NET_F_RSS,
+    VIRTIO_NET_F_RSC_EXT,
     VIRTIO_NET_F_HASH_REPORT,
     VIRTIO_NET_F_GUEST_USO4,
     VIRTIO_NET_F_GUEST_USO6,
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 03457ead66..46b02c50be 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -88,6 +88,7 @@ const int vdpa_feature_bits[] = {
     VIRTIO_NET_F_MQ,
     VIRTIO_NET_F_MRG_RXBUF,
     VIRTIO_NET_F_MTU,
+    VIRTIO_NET_F_RSC_EXT,
     VIRTIO_NET_F_RSS,
     VIRTIO_NET_F_STATUS,
     VIRTIO_RING_F_EVENT_IDX,
-- 
MST


