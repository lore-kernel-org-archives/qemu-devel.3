Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C084C36014
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 21:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Rw7-0007Ed-C2; Thu, 03 Apr 2025 17:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u0Rw5-0007EB-HG
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 17:17:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u0Rw4-0003X4-2L
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 17:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743715035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YdG+l5VqR1kry1gwXvIFa+Dslg5D8M14vzoZZ5z9NsU=;
 b=Uf68sPxrUhwwxrAmApj22i0R7zb8jLkU8I8omnpfYP+sNsXYzcc1IxQWgcl2JCLd3xai2p
 NeRmDOwwozUF1BAAr+O3qf2fTOInHUdb9PlX8bphDaMahwbprVJPNB07Uw2YsyRFoaKeQ8
 z47J/YfI4Eb9syazbja9Wn/EA/S6nuc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-cVmYt4EMO3WJVufWhIMwzA-1; Thu, 03 Apr 2025 17:17:14 -0400
X-MC-Unique: cVmYt4EMO3WJVufWhIMwzA-1
X-Mimecast-MFC-AGG-ID: cVmYt4EMO3WJVufWhIMwzA_1743715033
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43ce8f82e66so7486025e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 14:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743715032; x=1744319832;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YdG+l5VqR1kry1gwXvIFa+Dslg5D8M14vzoZZ5z9NsU=;
 b=YTnHuamdclHf8BsWPLL7OE2X9E4MtuokAu8PUUdcX389xd/qCJkgsDJsqItE4UWskP
 wADNG4tB8Wv+r8tOp8+7zg5lj9unm+nIGhnuUisn2WJrKmW0ZpwqNy3JEgQiuz4czQtG
 ff1G+/qvTDIhcKsJ/68iblS4U+1Fz6N7w1B/Hc7qqHoBWJYmMV7ZAO87xuet5yAMcHhA
 vhfJPpfW6jH+0EBHZNZ7uNkz4K8exH2gkG4AP/d1GHpDMqGF1MvL9MybRtjINuKM9GUD
 sQERH4taxnm1KYeKDGtMkD0RqTwoMHJiPBWtDbEJVHwTlX4ZD/yv4pqtDtPvxPqvxMPW
 YSZg==
X-Gm-Message-State: AOJu0Yy8ve12xItVbm+Zw4V5y7y96s95Pry6XGeZvjDlc0UivUHB/iLh
 tf0R6D3mKUSPrfbpDKe33mtPrJ32iAgGIomANtSYpjlGfWCqIR45ET1/UA+GcmueYT0b+M4URuA
 HIep2W5Cb2zEpiGD5MP/x85oFSQec6EMJQBgFWlBU+Q+xFGLGnlF0BifrJZ7kmEHGvprzjceKMy
 6VyY4tfcF4Sqo8NaL3Dn1whftmN09hhw==
X-Gm-Gg: ASbGncuF5Irpb/m3TIuEpebNX3quv+fTsepyosLaWSYhPNEAo0ikrUrviL3AXZzwXFq
 eajABCaI5zYHS0caMXE0jnq/ULcJd/Q71LC27/K9pelFO8hSsfV2vLKor3ES+IfenpKWEv5dtxk
 wKfy+r00uEnreNhgZdGXHHhkzU/gXl3wZQRfVE3FT6VEL3NyhuQsPpFeXUQT5DfEHtaxXw+Mnga
 O8BZCCdKGKr3icbzeqOR8rllCkD6XELZSrGgL0YlfllgbUtK+Se9/9EgubV2bJzZrhc7YGz9mli
 7bWs0jGMqg==
X-Received: by 2002:a05:600c:5394:b0:43e:bdf7:7975 with SMTP id
 5b1f17b1804b1-43ed0db4aa5mr1688285e9.32.1743715032584; 
 Thu, 03 Apr 2025 14:17:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNThS5idRApGETZ2SSlJr51eOZtj0q5yPOzjB+O8Sg575AVb0SZLHMfTfM6ysMUHVNIOJm8w==
X-Received: by 2002:a05:600c:5394:b0:43e:bdf7:7975 with SMTP id
 5b1f17b1804b1-43ed0db4aa5mr1688125e9.32.1743715032062; 
 Thu, 03 Apr 2025 14:17:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c300968cfsm2777392f8f.16.2025.04.03.14.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 14:17:11 -0700 (PDT)
Date: Thu, 3 Apr 2025 17:17:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 1/2] virtio-net: Fix num_buffers for version 1
Message-ID: <c17ad4b11bd268a35506cd976884562df6ca69d7.1743715021.git.mst@redhat.com>
References: <cover.1743715021.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1743715021.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

The specification says the device MUST set num_buffers to 1 if
VIRTIO_NET_F_MRG_RXBUF has not been negotiated.

Fixes: df91055db5c9 ("virtio-net: enable virtio 1.0")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250108-buffers-v1-1-a0c85ff31aeb@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/virtio-net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index de87cfadff..340c6b6422 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1999,6 +1999,8 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
                                     offsetof(typeof(hdr),
                                              virtio_net.hdr.num_buffers),
                                     sizeof(hdr.virtio_net.hdr.num_buffers));
+            } else {
+                hdr.virtio_net.hdr.num_buffers = cpu_to_le16(1);
             }
 
             guest_offset = n->has_vnet_hdr ?
-- 
MST


