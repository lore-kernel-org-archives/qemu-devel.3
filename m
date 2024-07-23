Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BD3C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDE3-0002JC-LU; Tue, 23 Jul 2024 06:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDDy-0001us-MC
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:58:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDDx-0002F1-7j
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lz5hKldjasJf/3wnZBS+b0jZAsjIEnviapWcUQoy3vQ=;
 b=IvRe32dAAqhFKQff/7jlT8Mn8C+IDG+Ld2ZOwM6Ji85o2Wl1cdw/acd4570uc9DyVm7OI6
 vAFE9RFCrRXK6OA+Y/D2sHIN067lbmhjRfnat5rdkMDth+Nd26U911r6rJfsByBWSjqd3d
 cp2I0lW5rxcyjrlq3gPT7jwRBeM/sUg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-perHOdtjPaSij4Nj3H32Zg-1; Tue, 23 Jul 2024 06:58:26 -0400
X-MC-Unique: perHOdtjPaSij4Nj3H32Zg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a797c5b4f47so51214166b.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732305; x=1722337105;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lz5hKldjasJf/3wnZBS+b0jZAsjIEnviapWcUQoy3vQ=;
 b=OeX9ppJSeHRxj68EB6ff0P9p+bnmi4EzNwzgNk60PDtALWv4qQDK6wBj8TCX+cliAi
 1w3yNG3qedtWgZadL9JJO+7TnglSVCSPTY7vXKgnjTp4ddkp5nHe3vGlFw1yaMV9GOoD
 WEZhtA6+2I7CuqDz1twdnl9YUHlWkzf7Tf76ozetr/DGR+8SnHBA4cXgwzt+SjkHQ5D+
 ZfZKJ0Tk/rC5vPdPY3I+UnfZIk+lrmYEpQ+/W8KNgd5DF/Z45BvAN7I3iHxZKw5MXAa8
 S8uAHq+E0iVd9wfx1HSt+se8Yp9pCDRalUvqSCCZTmd9rfXOjR/R2mVtcsEGPZu7ZmO1
 eFwQ==
X-Gm-Message-State: AOJu0YyMsDChNhY9PyCym5VORB76uvXthMQBhG8pVeoPr+aCu3kI7R+X
 uU+DSTMAJBN1KiDVJj7z+npHcPV8XKTH4z8u1HYhTucoSvAsQL2nDS6OptoZeR9YitOMRZfT7yu
 LN78+KeAkmv3ixzSRXsQxVBGuBdg7fNnGwe9ldtsfXqKXxHpbnVEOVyz7+hpA6fQU+LyJ2j0Frg
 6+qtUWQP5L+ZWsRlip/gJMo0hyKmPn3g==
X-Received: by 2002:a17:907:980a:b0:a77:c5e4:eebf with SMTP id
 a640c23a62f3a-a7a4c225797mr708769866b.54.1721732304990; 
 Tue, 23 Jul 2024 03:58:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdD1iUnh961jTRqz5Kemev4gldowZNdF/cKaZYE6BgoqY3EOTc4rw/rGpz+LMsnxKRqEOkrg==
X-Received: by 2002:a17:907:980a:b0:a77:c5e4:eebf with SMTP id
 a640c23a62f3a-a7a4c225797mr708767666b.54.1721732304442; 
 Tue, 23 Jul 2024 03:58:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a8d9b2d1dsm81809766b.63.2024.07.23.03.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:58:23 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:58:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL v2 34/61] virtio-net: Implement SR-IOV VF
Message-ID: <c2d6db6a1f39780b24538440091893f9fbe060a7.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

A virtio-net device can be added as a SR-IOV VF to another virtio-pci
device that will be the PF.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240715-sriov-v5-7-3f5539093ffc@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-net-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
index e03543a70a..dba4987d6e 100644
--- a/hw/virtio/virtio-net-pci.c
+++ b/hw/virtio/virtio-net-pci.c
@@ -75,6 +75,7 @@ static void virtio_net_pci_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_VIRTIO_NET;
     k->revision = VIRTIO_PCI_ABI_VERSION;
     k->class_id = PCI_CLASS_NETWORK_ETHERNET;
+    k->sriov_vf_user_creatable = true;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     device_class_set_props(dc, virtio_net_properties);
     vpciklass->realize = virtio_net_pci_realize;
-- 
MST


