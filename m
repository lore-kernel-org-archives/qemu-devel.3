Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0043AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 14:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saz9V-00060C-VY; Mon, 05 Aug 2024 10:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luzhixing12345@gmail.com>)
 id 1saz9P-0005z3-5G
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 10:57:31 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luzhixing12345@gmail.com>)
 id 1saz9N-00019R-47
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 10:57:30 -0400
Received: by mail-pg1-x543.google.com with SMTP id
 41be03b00d2f7-6e7b121be30so6739109a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 07:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722869846; x=1723474646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WyIlyDL0SlkbUCH/CF/j5TBoVf5m7kE01dbuSMkuH6w=;
 b=ewcRppisldCjiMYd4Xjq5TyYNGWUllCTxJDcKMyspscSmCqRlZOEoSK0mktd/TIUpH
 +LxH+78Mm1jHThcvzTqdGgELxYOojzhLpebt5u/EwydYr36/J7K59+7WXxSe3s0+9wzh
 X0veENEv3vtOKy3Aw8z5cX6UtDsaIqjVhkj7gqkCcDb6T2Q/69Ytm+wIdZ/d/mrI61gp
 Wx4yBx0WVVylmzaARuvqV2/Eix076GPwfc0F4Jhhq/oxTVVXSLhE+w5dh7T1wrAJWneE
 cFZEVXxh/UUpfcgp5SbKhr9HbuTNPt8kqyj6PiJt4EtQE+4M4bWG8d/wx6KGZdUTJJ+G
 XMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722869846; x=1723474646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WyIlyDL0SlkbUCH/CF/j5TBoVf5m7kE01dbuSMkuH6w=;
 b=vbBHR4ntormGgAT1NhKE2jp+Q4hU3rZAsJ1ZM9S3iE9S2m5Wcw6qz90WUk28Ric4zL
 4EmVmAnBK2+PwxIVDjPUbi+7UASO/eeExGoJTjn2iN3kGzPlLgaifOv/2d4xSXk5Z2qK
 JBAMd9twflCU9KRUy3J42NNBfxGkNY5hDd91G/6ONa+A2SlRSQ+XEw8l45q3w7fOCCtf
 fp6P9cCfbNuTas7qNLvhsOHJ9L+KFzg9lKohWruj239a8Dz7P5J475f9/l52Tc+F75Ii
 WkOUNdj8ko18/yNkzzvq21PpDsN74aV63lMml9t7jXl4mcA71sOxV+4X2CWxXC2i6UX0
 zAgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhWGR0bnOIYOS8ABIuxQ3jPO6BRSiK0y35uYnxoD6zu0PdePvIBQU7F08GCE6DgZZB5G16xURrp+9XYj74JnClj3ojVeU=
X-Gm-Message-State: AOJu0YxWCgEgcRT/X3BVMIFuAu2gjHEc9CqD3kTsQZq4/UznX49a4BLb
 ww2dIJzHzW8LeWQ+mpEv9Ek3YkcC/3+rNfMLTyEo8Z04eaGxfMcc0iWtmPnt4xJnwQ==
X-Google-Smtp-Source: AGHT+IGq8VdFGT9kJQ7Ste0NqabPcOIUy9+XUx4TDUS77LZ27c36fTqeEBAnTuK02RbwSrmw5FQa9A==
X-Received: by 2002:a17:90b:4b47:b0:2ca:f39c:8d76 with SMTP id
 98e67ed59e1d1-2cff955ce6dmr11380835a91.39.1722869845689; 
 Mon, 05 Aug 2024 07:57:25 -0700 (PDT)
Received: from localhost.localdomain ([39.144.190.14])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cfdc4cf655sm10513359a91.38.2024.08.05.07.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 07:57:25 -0700 (PDT)
From: luzhixing12345 <luzhixing12345@gmail.com>
To: sgarzare@redhat.com
Cc: luzhixing12345@gmail.com,
	mst@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v2] docs: fix vhost-user protocol doc
Date: Mon,  5 Aug 2024 22:57:03 +0800
Message-Id: <20240805145703.24425-1-luzhixing12345@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tqmw3wdsxkm66yh7qwpf2r2xdpckvf7hofblsyan2pmnfbttys@eh326n7d326m>
References: <tqmw3wdsxkm66yh7qwpf2r2xdpckvf7hofblsyan2pmnfbttys@eh326n7d326m>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=luzhixing12345@gmail.com; helo=mail-pg1-x543.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

add a ref link to Memory region description, improve type description

add extra type(64 bits) to Log description structure fields

fix ’s to 's

Signed-off-by: luzhixing12345 <luzhixing12345@gmail.com>
---
 docs/interop/vhost-user.rst | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index d8419fd2f1..2e50f2ddfa 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -167,6 +167,8 @@ A vring address description
 Note that a ring address is an IOVA if ``VIRTIO_F_IOMMU_PLATFORM`` has
 been negotiated. Otherwise it is a user address.
 
+.. _memory_region_description:
+
 Memory region description
 ^^^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -180,7 +182,7 @@ Memory region description
 
 :user address: a 64-bit user address
 
-:mmap offset: 64-bit offset where region starts in the mapped memory
+:mmap offset: a 64-bit offset where region starts in the mapped memory
 
 When the ``VHOST_USER_PROTOCOL_F_XEN_MMAP`` protocol feature has been
 successfully negotiated, the memory region description contains two extra
@@ -190,7 +192,7 @@ fields at the end.
 | guest address | size | user address | mmap offset | xen mmap flags | domid |
 +---------------+------+--------------+-------------+----------------+-------+
 
-:xen mmap flags: 32-bit bit field
+:xen mmap flags: a 32-bit bit field
 
 - Bit 0 is set for Xen foreign memory mapping.
 - Bit 1 is set for Xen grant memory mapping.
@@ -211,7 +213,7 @@ Single memory region description
 
 :padding: 64-bit
 
-A region is represented by Memory region description.
+:region: region is represented by :ref:`Memory region description <memory_region_description>`.
 
 Multiple Memory regions description
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -224,7 +226,7 @@ Multiple Memory regions description
 
 :padding: 32-bit
 
-A region is represented by Memory region description.
+:regions: regions field contains 8 regions of type :ref:`Memory region description <memory_region_description>`.
 
 Log description
 ^^^^^^^^^^^^^^^
@@ -233,9 +235,9 @@ Log description
 | log size | log offset |
 +----------+------------+
 
-:log size: size of area used for logging
+:log size: a 64-bit size of area used for logging
 
-:log offset: offset from start of supplied file descriptor where
+:log offset: a 64-bit offset from start of supplied file descriptor where
              logging starts (i.e. where guest address 0 would be
              logged)
 
@@ -382,7 +384,7 @@ the kernel implementation.
 
 The communication consists of the *front-end* sending message requests and
 the *back-end* sending message replies. Most of the requests don't require
-replies. Here is a list of the ones that do:
+replies, except for the following requests:
 
 * ``VHOST_USER_GET_FEATURES``
 * ``VHOST_USER_GET_PROTOCOL_FEATURES``
@@ -1239,11 +1241,11 @@ Front-end message types
   (*a vring descriptor index for split virtqueues* vs. *vring descriptor
   indices for packed virtqueues*).
 
-  When and as long as all of a device’s vrings are stopped, it is
+  When and as long as all of a device's vrings are stopped, it is
   *suspended*, see :ref:`Suspended device state
   <suspended_device_state>`.
 
-  The request payload’s *num* field is currently reserved and must be
+  The request payload's *num* field is currently reserved and must be
   set to 0.
 
 ``VHOST_USER_SET_VRING_KICK``
@@ -1662,7 +1664,7 @@ Front-end message types
   :reply payload: ``u64``
 
   Front-end and back-end negotiate a channel over which to transfer the
-  back-end’s internal state during migration.  Either side (front-end or
+  back-end's internal state during migration.  Either side (front-end or
   back-end) may create the channel.  The nature of this channel is not
   restricted or defined in this document, but whichever side creates it
   must create a file descriptor that is provided to the respectively
@@ -1714,7 +1716,7 @@ Front-end message types
   :request payload: N/A
   :reply payload: ``u64``
 
-  After transferring the back-end’s internal state during migration (see
+  After transferring the back-end's internal state during migration (see
   the :ref:`Migrating back-end state <migrating_backend_state>`
   section), check whether the back-end was able to successfully fully
   process the state.
-- 
2.34.1


