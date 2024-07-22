Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B260CC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgkl-0007Xd-JA; Sun, 21 Jul 2024 20:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkj-0007Pf-MA
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgki-0005rZ-2c
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lz5hKldjasJf/3wnZBS+b0jZAsjIEnviapWcUQoy3vQ=;
 b=K+QWImqFALz7i6jNLJJ3hkXBg15KJz/gFb2q1/GONBVwPPMJ0hnmjSV4JmAJYk1mF3LkX9
 5C/HEI8SfkaM4WYOOGpmRjambWtME1z6hO/FF+hrqEuRtZXEi/nDpQHUsZTKHYptUVYOXq
 uAcaZK6txUB5HhcT6pkx3di6q2YXZRU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-3DZ32LAZNUa-apNRGX5Rog-1; Sun, 21 Jul 2024 20:18:06 -0400
X-MC-Unique: 3DZ32LAZNUa-apNRGX5Rog-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4279c75c44dso26778985e9.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607484; x=1722212284;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lz5hKldjasJf/3wnZBS+b0jZAsjIEnviapWcUQoy3vQ=;
 b=EdRe3Sa2eDFk10uA8aY+LIOisiidt5XkmTr3H0IcjXbKpSMrwe7alMNk1Azd7Jx2RX
 TuVq4DyONqTX6A4/fyAoyimygt3yRu9i88tqroWcv1vX1xiey36/vZNC1TfNG/mzz4O0
 Z6Tdtf2kxhwywzITPonjc+M2Ary8Bm6+lGty3x4Efe38dIC2+vF2P0PhgaSx9eX6pZ8E
 fRX/1zbgiQlmlECAnKm1FyWMXk1A2tLWTLblhaSgflltYWh+oEuTX0rrHzpjrGjY0eOx
 Iiq3nzn+c4SpSABy/wKl5J2EJB+p4/VOpGMeBy6RYvzw78H7//Igt05vGpqoYUlR1Wdt
 1rOQ==
X-Gm-Message-State: AOJu0YysAFDanDlvgFexKPFJQFXDvFqsJCzp6yAfV4gef1Sb98wvybvl
 QBNskm975tErmxOjIrD+Wi712JcbyNAO0GBs+Vg2z7QiD/s3yzJouUZCK0uooYGh8kx3GxIHrhp
 bnuXV69NVxGqRM/KpVe4PoxAZxfevLDJkSEXvglJ+cLr4tnAl8nKf9orbEz2AY903/kpYGtcX/r
 GmiyGM/JJlNB9ikLVYpjMVGKKmdWnOUg==
X-Received: by 2002:a05:600c:4f91:b0:426:6960:34ac with SMTP id
 5b1f17b1804b1-427dc578d07mr25724705e9.36.1721607484747; 
 Sun, 21 Jul 2024 17:18:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERw1p3XFSZX6ycE98S/kGgLXCl07MyTFzTP8oCoCxepQoPIafN8aytVQA5D4j0I0rw9zYm2Q==
X-Received: by 2002:a05:600c:4f91:b0:426:6960:34ac with SMTP id
 5b1f17b1804b1-427dc578d07mr25724585e9.36.1721607484208; 
 Sun, 21 Jul 2024 17:18:04 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868bb00sm7016436f8f.43.2024.07.21.17.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:18:03 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:18:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 35/63] virtio-net: Implement SR-IOV VF
Message-ID: <4051d38a4ea4d1e80047e7d6c042d575e3fd2698.1721607331.git.mst@redhat.com>
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


