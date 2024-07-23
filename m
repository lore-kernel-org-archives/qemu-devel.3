Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDC9C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDDK-0004Rf-CD; Tue, 23 Jul 2024 06:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDDH-00043V-Tm
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDDG-0001uy-98
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DoP8zpcWwKhsBbn/dEN5fS4FX6tEBJxOhfXfCwMS67w=;
 b=RnT5chH9gEV7x5r+TLRalWaAJ84lFaEVhlODwhXmsUNE9bKbVXo8PRj5egVtkdebT1l1sQ
 kfJmsR4WkJS13h3CSx7NKNCo8KT/auCQqnybesSGd+4ZVQ7GRajhrp+c2O+ODQSyiL47S0
 yKV3uHB9ERFKi/6YtS7VT6g8q9bvQg4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-3XUBFoKbOIiuEusXqvRiHQ-1; Tue, 23 Jul 2024 06:57:44 -0400
X-MC-Unique: 3XUBFoKbOIiuEusXqvRiHQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a77c6ea022fso115023866b.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732262; x=1722337062;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DoP8zpcWwKhsBbn/dEN5fS4FX6tEBJxOhfXfCwMS67w=;
 b=aric/AkE6M5beGpnKCD1jC6N7aFdP+n+wkclYFMJufKBSU4Ikf9MWDtmWB+KiYM3Hd
 gZTKfbnBHYSP1avnjqR3N/0V8QLIMkb+PDeDlUz5Fw2GXYSNgpo9ofnjtxMA97IWz5kn
 hQB1Dd1P9WCcnUjs5opbdnii+PzM2WiaAR0pOi3lylI5rLqIwZsMlAfxrsHE+RvkgYSH
 y7yiHSHUyTD77i7d8t4iLupr7B15yvdmr+Q5ajG6bZi7kbYgltS/il3ayZRlmnw++PzM
 C4+eZkSByn1Aq/XvLfpUBEOWAd6/NzBcIZk4/7KYh+vPPHxgHARo4MIiS+7NaqBHbSgC
 0J4A==
X-Gm-Message-State: AOJu0YyqguIDXAJRD2KGGIbve0oOw5iIPAYn6RtfawrbMpHfUTbNIeiv
 km/xaW+NUYRoWRmCKew0UdNU+tXYFjwRjx6oUV8Y+HhNzF5mQGguu+uJ8RqjPClmClMTiES6Cyp
 dxVRz5Ooi6K6Dyk0VJiGljBDW24dR+xVGm1W4JnNIuyED4Wot7gbKsP2cXXL+myfMLxyqxYx8aN
 qr1va+Zbrwu75SJl0rb8RoVObDvZgIjg==
X-Received: by 2002:a17:907:7d8e:b0:a77:d9b5:ad4b with SMTP id
 a640c23a62f3a-a7a9424ec2dmr182119066b.9.1721732262497; 
 Tue, 23 Jul 2024 03:57:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB6lXnvla0A7/BGaTicXR+yl9n6GLM/shEz2UcbCs5L5zya+ff8MnsMI2uJag6zk6cTyQf1Q==
X-Received: by 2002:a17:907:7d8e:b0:a77:d9b5:ad4b with SMTP id
 a640c23a62f3a-a7a9424ec2dmr182116566b.9.1721732261858; 
 Tue, 23 Jul 2024 03:57:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c8bed67sm523190266b.124.2024.07.23.03.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:57:41 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:57:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL v2 27/61] virtio: Add VIRTIO_F_IN_ORDER property definition
Message-ID: <0b0bb34f342f04ab8255a64edb7c6aec7105dc94.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jonah Palmer <jonah.palmer@oracle.com>

Extend the virtio device property definitions to include the
VIRTIO_F_IN_ORDER feature.

The default state of this feature is disabled, allowing it to be
explicitly enabled where it's supported.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20240710125522.4168043-7-jonah.palmer@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index fdc827f82e..d2a1938757 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -373,7 +373,9 @@ typedef struct VirtIORNGConf VirtIORNGConf;
     DEFINE_PROP_BIT64("packed", _state, _field, \
                       VIRTIO_F_RING_PACKED, false), \
     DEFINE_PROP_BIT64("queue_reset", _state, _field, \
-                      VIRTIO_F_RING_RESET, true)
+                      VIRTIO_F_RING_RESET, true), \
+    DEFINE_PROP_BIT64("in_order", _state, _field, \
+                      VIRTIO_F_IN_ORDER, false)
 
 hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
 bool virtio_queue_enabled_legacy(VirtIODevice *vdev, int n);
-- 
MST


