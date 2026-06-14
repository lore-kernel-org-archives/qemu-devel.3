Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEACCD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDP-00009n-Jq; Sun, 14 Jun 2026 15:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDI-0007mJ-Kl
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDF-0002iE-V0
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dxQiufrlju7WrdEUkSc4WpPk6ds42ZX5EDbbuJfT9OE=;
 b=H65Pu3kpbib9/GfBbDEwM7Xb1b5JmGafx1ckEUWyknys35jMzxWR+pnhU5Lv4oi8VsA8d1
 BtkP2c8PJo1JcDy3FqUiFu0dOGnTyms9D4+bEzbrDN+PIdII2JeNuUFBU7GV29nZbHmcK2
 xNFGkCXl53KBBm1qd/Tk4UIqO9vgb9w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-sgII0XexNkOi90w00nGBtQ-1; Sun, 14 Jun 2026 15:09:40 -0400
X-MC-Unique: sgII0XexNkOi90w00nGBtQ-1
X-Mimecast-MFC-AGG-ID: sgII0XexNkOi90w00nGBtQ_1781464179
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490cc1ae292so15158465e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464179; x=1782068979; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dxQiufrlju7WrdEUkSc4WpPk6ds42ZX5EDbbuJfT9OE=;
 b=heKcja27/R6kWyBK2Lmn6baokQulB/hBmTop6nS0ULMWOxdZ0/ng07OWiLYuBWzvs3
 6V8xax1Gq+5RfaluVmJ0vZ9dWhktaa5re2cqPF0wL0MYKNE9v0XGdK0dY5Yygy20dNGx
 8pESDStl5cfL6TuTcbt71B0tGI0ckAoRZ+Ap1Ogn4GVupNO8BrF8tzvHEk+NwuLT1Ndh
 YJpZuSl7McSSFVhEx58g5HS8ec1hwbJeTgMima/IHaEqlH/SW7jtdkGzgHEeHk8gGKVR
 B5lT+0fo2FBjxarIBRDzFqPJXZ/qnajmWeHpGOrVrPsbOe39FiDAExTl0uOm4S0iPB9s
 O2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464179; x=1782068979;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dxQiufrlju7WrdEUkSc4WpPk6ds42ZX5EDbbuJfT9OE=;
 b=bvy1FPoeVVNsY/nJiOhGIgQRrMwXzxBpcxWZn9G46lGRCaligWUMoawAE8T8NGzmUl
 jhTTufDPnBrPSsC433IogniD2I3/fFhJdx7AoBg/iZjZITxBsc/yiXvQsWSDHyNdOQuP
 RZLxJQ1HwkX7nWo4dMqkxLkvsHCRIoYe8s03kd/uYhdtouf/l2gEwjmf1JBqTQV0kIrt
 ZZUJSwlhhndHpc5DiIPp75Miyq4KRUbF/+CWF+jaPOcEymcmS2F6/+T8QVn1fCRLVb+G
 UdAAdeROu4lT9mnE4XIk5mlnbnaEVupn1bgMD5TAsyO4NGosoQ9Lk8d1E3ExCyyLDPjC
 Sv5g==
X-Gm-Message-State: AOJu0YyLLRleOZ+5x11LvcuhTQ517rsC+qXz1kFHlL49N/fFtmkXkoOY
 K1G4OYWBRYo5/5MOBbbL+WRXKeUpU80EaOFtuEE8LE0yCTpUC/nRu3uMBe2yE61hnB4gL+tdIHU
 MU6CtSMMTbFmX+jpBRZh2m7enEqQ/v1pK018aTcDm86Cz18WJEVmJx0zGEQezjREsnVlvjd9KDi
 kwmzG4u26QuW16eXn/1oDx7lzO37Pwg3PFqQ==
X-Gm-Gg: Acq92OGwT7p6g8kCMI9qwI500ZUoY69PrCd7vzA4Hq97rKdDeGlRaId4ZDiVQ89mFsw
 5K3wXQlDc5e3uVpkrvQoOgfCz4qY8ImnS3eLt5DvZm3atkHVVjNNbr08rrdV19g9lHE7dz+1TPI
 PxSzBYSqBf7DYTM6N9LFZl8vuNdbNqj+XZlYxq5EHvjJnhsZEnrP78Za/JvZsbq8faaOJQkULZd
 Ly5ovTyUcZX8uccXL9VbSRHm6avUg/aTGguQYLoZHpxtjOvSeVc6oCRCnZ2VfQELEda7ICzWvH1
 hOLek4nEK+W9kL404ppSEWWo08LAOaKPs268qA9hS9yrgwtIbmCVZJiMkJ/grRu6BECnBmR53Nk
 60ulM7J/wwHG+Xc/Tcptm7KxcSNolMLiMO7ZmUpXqBCY=
X-Received: by 2002:a05:600c:3542:b0:490:b4a8:e031 with SMTP id
 5b1f17b1804b1-490ec480e65mr121660405e9.4.1781464178703; 
 Sun, 14 Jun 2026 12:09:38 -0700 (PDT)
X-Received: by 2002:a05:600c:3542:b0:490:b4a8:e031 with SMTP id
 5b1f17b1804b1-490ec480e65mr121660105e9.4.1781464178158; 
 Sun, 14 Jun 2026 12:09:38 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922035b4absm184726005e9.11.2026.06.14.12.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:09:37 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Albert Esteve <aesteve@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alyssa Ross <hi@alyssa.is>, Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 093/106] vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
Message-ID: <588acb45c29f8c30f98b5cbafb9fd09cb932bd88.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Albert Esteve <aesteve@redhat.com>

Add SHMEM_MAP/_UNMAP request to the vhost-user
spec documentation.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Alyssa Ross <hi@alyssa.is>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260304165223.2166175-4-aesteve@redhat.com>
---
 docs/interop/vhost-user.rst | 64 +++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 883b1e90a2..4182d721ca 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -362,6 +362,28 @@ Device state transfer parameters
   In the future, additional phases might be added e.g. to allow
   iterative migration while the device is running.
 
+MMAP request
+^^^^^^^^^^^^
+
++-------+---------+-----------+------------+-----+-------+
+| shmid | padding | fd_offset | shm_offset | len | flags |
++-------+---------+-----------+------------+-----+-------+
+
+:shmid: a 8-bit shared memory region identifier
+
+:fd_offset: a 64-bit offset of this area from the start
+            of the supplied file descriptor
+
+:shm_offset: a 64-bit offset from the start of the
+             pointed shared memory region
+
+:len: a 64-bit size of the memory to map
+
+:flags: a 64-bit value:
+
+  - 0: Pages are mapped read-only
+  - 1: Pages are mapped read-write
+
 C structure
 -----------
 
@@ -387,6 +409,7 @@ In QEMU the vhost-user message is implemented with the following struct:
           VhostUserInflight inflight;
           VhostUserShared object;
           VhostUserTransferDeviceState transfer_state;
+          VhostUserMMap mmap;
       };
   } QEMU_PACKED VhostUserMsg;
 
@@ -1083,6 +1106,7 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_DEVICE_STATE            19
   #define VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT 20
   #define VHOST_USER_PROTOCOL_F_GPA_ADDRESSES           21
+  #define VHOST_USER_PROTOCOL_F_SHMEM_MAP               22
 
 Front-end message types
 -----------------------
@@ -1904,6 +1928,46 @@ is sent by the front-end.
   when the operation is successful, or non-zero otherwise. Note that if the
   operation fails, no fd is sent to the backend.
 
+``VHOST_USER_BACKEND_SHMEM_MAP``
+  :id: 9
+  :equivalent ioctl: N/A
+  :request payload: fd and ``struct VhostUserMMap``
+  :reply payload: N/A
+
+  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
+  successfully negotiated, this message can be submitted by the backends to
+  advertise a new mapping to be made in a given VIRTIO Shared Memory Region.
+  Upon receiving the message, the front-end will mmap the given fd into the
+  VIRTIO Shared Memory Region with the requested ``shmid``.
+
+  If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and
+  back-end set the ``VHOST_USER_NEED_REPLY`` flag, the front-end
+  must respond with zero when operation is successfully completed,
+  or non-zero otherwise.
+
+  Mapping over an already existing map is not allowed and requests shall fail.
+  Therefore, the memory range in the request must correspond with a valid,
+  free region of the VIRTIO Shared Memory Region. Also, note that mappings
+  consume resources and that the request can fail when there are no resources
+  available. Lastly, mappings are automatically unmapped by the front-end
+  across device reset operation.
+
+``VHOST_USER_BACKEND_SHMEM_UNMAP``
+  :id: 10
+  :equivalent ioctl: N/A
+  :request payload: ``struct VhostUserMMap``
+  :reply payload: N/A
+
+  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
+  successfully negotiated, this message can be submitted by the backends so
+  that the front-end un-mmaps a given range (``shm_offset``, ``len``) in the
+  VIRTIO Shared Memory Region with the requested ``shmid``. Note that the
+  given range shall correspond to the entirety of a valid mapped region.
+
+  If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and the back-end
+  sets the ``VHOST_USER_NEED_REPLY`` flag, the front-end must respond with
+  zero when operation is successfully completed, or non-zero otherwise.
+
 .. _reply_ack:
 
 VHOST_USER_PROTOCOL_F_REPLY_ACK
-- 
MST


