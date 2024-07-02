Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E375C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjvd-0006q1-RV; Tue, 02 Jul 2024 16:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjuu-0005jc-2p
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:16:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjur-00087K-Uy
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QKgBtghpdntZCNxsubdg5dbN8fdbQsXq4OpajtHNP9c=;
 b=EhKKmxQ7CgBGSmMwa8WLxm9FuwYI2VxHqaTofWoQOPxssCOSx3k6MY3tvbgZ4FwHDIS2p3
 bcXsSnkNasaOS1UtGipXxaN7gIaRjhowGP6Jle2c0ZdGoPJNMBEQ8PlT8aHvfvYj6b9V42
 jYVCdH77ucV++JGzY6ayRoxC4hqP00I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-w0HZz0bhOBuvwaL5pa_sYA-1; Tue, 02 Jul 2024 16:15:51 -0400
X-MC-Unique: w0HZz0bhOBuvwaL5pa_sYA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42566c4aa0fso37108825e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951350; x=1720556150;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QKgBtghpdntZCNxsubdg5dbN8fdbQsXq4OpajtHNP9c=;
 b=QUCT6k78cEpULt0+ibQ740VCpzPXV7qX2zJbCcgGc9JW3kIVydTsxiO3V+0z5AXLvD
 RVdnjMcTaIWyxY3MSredOTQAETRF/fn8s4aejUjy/1hx6MU0m6VeLMhjR/oa2KeUF6T1
 FrohiYwoO/tnahpvuHIDW8m6EAKh0VeV7c+wplxARUV60uPHEVOVOgKOHOCzV9P39aCJ
 nix+F2hmVhYAZZjPJ6Xn05G5HIUkAK5/wgxA3jE8ibD+PuyTdXGWbYOYuj4jLDUc149v
 TA0+Gb9SDCKAJ5kTVIW7DkXr6zgqQDTI1oXnTopBvP13N5nlZ38xva7W34F+WkfRQGvc
 uzyA==
X-Gm-Message-State: AOJu0Yy7KFCpu9eTzneOSfwUoCj22diwNua0EE1gNuUQj2YqDR6kQhao
 PiUWp5mA9OuM+3vLGDpB4zlxz/LZkRxIbDKkwSExyjBNay+91YtrvO8MToKWJty8wf8vopcIVwm
 DhL5v1n6/HJ8A62q6u9uwf/WAkJIHtTo57nPxLCqrmC5HyhC4JwzvDD8CdV3gprWO6kxxCsNAT6
 kHEPVXidMQ1UCt/8c84w8EnelODq/jRg==
X-Received: by 2002:a7b:c452:0:b0:423:6957:89bd with SMTP id
 5b1f17b1804b1-4257a02f401mr64134845e9.12.1719951350236; 
 Tue, 02 Jul 2024 13:15:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBb5FxWYCHwylsBrsnglts8slYFMiP/OWWBAEeSFF0+AXdNfWPEykds0gJTJutdpGj53OSSQ==
X-Received: by 2002:a7b:c452:0:b0:423:6957:89bd with SMTP id
 5b1f17b1804b1-4257a02f401mr64134705e9.12.1719951349729; 
 Tue, 02 Jul 2024 13:15:49 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fc623sm14156551f8f.87.2024.07.02.13.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:15:49 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:15:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: [PULL v2 10/88] vhost-vsock: add VIRTIO_F_RING_PACKED to feature_bits
Message-ID: <a0eebd790ca4f90fc1e3662cb38542ccc21963bf.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

From: Halil Pasic <pasic@linux.ibm.com>

Not having VIRTIO_F_RING_PACKED in feature_bits[] is a problem when the
vhost-vsock device does not offer the feature bit VIRTIO_F_RING_PACKED
but the in QEMU device is configured to try to use the packed layout
(the virtio property "packed" is on).

As of today, the  Linux kernel vhost-vsock device does not support the
packed queue layout (as vhost does not support packed), and does not
offer VIRTIO_F_RING_PACKED. Thus when for example a vhost-vsock-ccw is
used with packed=on, VIRTIO_F_RING_PACKED ends up being negotiated,
despite the fact that the device does not actually support it, and
one gets to keep the pieces.

Fixes: 74b3e46630 ("virtio: add property to enable packed virtqueue")
Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Message-Id: <20240429113334.2454197-1-pasic@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vsock-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/vhost-vsock-common.c b/hw/virtio/vhost-vsock-common.c
index 12ea87d7a7..fd88df2560 100644
--- a/hw/virtio/vhost-vsock-common.c
+++ b/hw/virtio/vhost-vsock-common.c
@@ -22,6 +22,7 @@
 const int feature_bits[] = {
     VIRTIO_VSOCK_F_SEQPACKET,
     VIRTIO_F_RING_RESET,
+    VIRTIO_F_RING_PACKED,
     VHOST_INVALID_FEATURE_BIT
 };
 
-- 
MST


