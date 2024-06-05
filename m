Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFC6C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF0AA-0002wn-Oy; Wed, 05 Jun 2024 19:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0A9-0002wf-Bl
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:35:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0A7-00058I-Q3
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717630523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QKgBtghpdntZCNxsubdg5dbN8fdbQsXq4OpajtHNP9c=;
 b=KH3aog82e6y4eMGHrUbQOqqR2WFf3VOxJD/tlM7k4fp7d4mmpGIpmSipmzqI/KVXCUNV6J
 FuLnczQa7k+vuUB3E22svTx+FxrAZhoGtLY5oxhaBEvRKNuv5LHmuhz8LfNeWMw7ccqLnf
 FTIUFtrKxdpoN4EmjUUy7SPG5H7DGso=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-vyAoZxVyOeKOASzIWNQM_g-1; Wed, 05 Jun 2024 19:35:22 -0400
X-MC-Unique: vyAoZxVyOeKOASzIWNQM_g-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-35dca4a8f2dso200592f8f.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 16:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717630520; x=1718235320;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QKgBtghpdntZCNxsubdg5dbN8fdbQsXq4OpajtHNP9c=;
 b=WuzeKIuk0GjHnu/S6O2XoOeDgmzjT3NniHRDyVMMWO8sq50ezI4jxhGIinf4+Flgbo
 tpGNCceK9rFTk3anXT0O7A91ATS3yPQbf9ErOANMXc4NscPLLttBY5H9vLfyEG+CnJWh
 7hoDa96kNzzQpZqWv626tZ+2ysD/dXuXF0dkGmOa3K4KTj7et7h/jVLWAcY+pmsvM8sV
 Gbbw5irCz8MyQV+ef9zz3EwWFmNBK/sOa7VUScRhECPhH6c860po/Euswe/CVxrmuGGy
 /kauqUV5KZNtCMlvAe8eZGX/kRwzldRwSGRoVJAKfSBEUrxy+ZPxB3tVb240ZA63ewrj
 Q8jA==
X-Gm-Message-State: AOJu0YxWGyTITLlVrhdFemCW6YOIZRPFqkOKTiyM+0Nl1HrarAcigmv0
 7kMNp2lDsB1kkPW+eJvW0X2IfEZf8RjRsgZqmmwbtLMpxedPwYu0wzjy4laEwUpEyHMTsjcmxG8
 tgl4gxAPPzk3erw+9ea9qRgnn4KAc4lloL8c+gh4r5GEOCGMJP9PLuZm/tVhVrKCVlpq6JSaLjr
 l4QMB1MOrjQstqX5Q/cnuiLd9TZUeNfA==
X-Received: by 2002:a5d:588e:0:b0:354:f38c:6d0b with SMTP id
 ffacd0b85a97d-35e8ef087abmr3503896f8f.37.1717630520430; 
 Wed, 05 Jun 2024 16:35:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB+qZ4UlcLGNxrDB/PojJu5NSA6tmO9Rl2SWJ+nqO7Kfho39j9GS78xJz0FFrc7RIwogL2/g==
X-Received: by 2002:a5d:588e:0:b0:354:f38c:6d0b with SMTP id
 ffacd0b85a97d-35e8ef087abmr3503880f8f.37.1717630520015; 
 Wed, 05 Jun 2024 16:35:20 -0700 (PDT)
Received: from redhat.com ([2.55.56.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c8070ebeasm6363566b.181.2024.06.05.16.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 16:35:19 -0700 (PDT)
Date: Wed, 5 Jun 2024 19:35:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: [PULL v3 10/41] vhost-vsock: add VIRTIO_F_RING_PACKED to feature_bits
Message-ID: <1ca9549c981cf118bc7a52dc7d5cebce75a918fa.1717630437.git.mst@redhat.com>
References: <cover.1717630437.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717630437.git.mst@redhat.com>
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


