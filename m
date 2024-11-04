Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC07D1BDF4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84Ge-0003IX-FP; Mon, 04 Nov 2024 16:05:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Ga-0003I3-Iu
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:05:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84GY-0005G3-Q5
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pO6/xC2LQ7SXQPgMt07W6ylNJnGRBeackbjMBgbgr2Q=;
 b=MaB2oUb0SQdUj/hMUPnh+RnJt6WX+M2fEzpKZYNooP8wYYKz/HePOyXLygurfm6WRJ5Mkh
 7QjkKMC/fh3ZLqSeAUX3Ch6ddugDO5ujW0zzQvYXf5S+2u79jbYQEuzl6p7oD3R1pEHGZI
 AiefKSJe0bJsmg64A+M0GIG4vsBCoHI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-oOFO74lmO2aVHRkwi4xSwQ-1; Mon, 04 Nov 2024 16:05:34 -0500
X-MC-Unique: oOFO74lmO2aVHRkwi4xSwQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315eaa3189so39500425e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:05:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754333; x=1731359133;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pO6/xC2LQ7SXQPgMt07W6ylNJnGRBeackbjMBgbgr2Q=;
 b=vj1gHMRAulRUYq707K8dK7VtmHSqMciHOiyopXZzRGurzFTSvvuISIAo6NrWYaMJCY
 7YEnGegQrBmaLfikVFxeHTVjEhVl49Q/P61L/eiXBdR/3hPOb8Ja6LsaNqINF4Au/Cg2
 mb0w5vvYe2lFNENggfWk1q/Vl7a4bucU+hPr7uPXsh7OXaUmRZrWFRMO4scQDFbROybH
 rdA4Hn/70hsNe2ZxDV5idDasBcf0mBAil6YpkRFW9roRjvID+hEYQyjF3nNP11tMYCJO
 SVy/nZShwkrVJWYww+Mk393vquaB9+2oFXGiol/7hhRBLVSavXNl93k16iarQOPCKQ7H
 5WtQ==
X-Gm-Message-State: AOJu0YzBG2lnIVbI8tvksTAC1tNzyWh2HNSygfBsEO2qZdwAH9eXQaQL
 8xyUcGD+QrY6JE7GBtSzfRsL8a+HnsDOqTXA/jfmJAQrrry68UHhgggqSfg+Qb7UaX+fqwNHn9/
 VGr4JTcxxm+dO4M3Ndr/4bpBJLwDcSm3hLJrSFXgEY+5xpNuNy10ZLOjUgqLQ+s4beIq2DvDu1G
 xauXl34yhKMsPQHg5NXMZTazxpMe6WKw==
X-Received: by 2002:a05:600c:3507:b0:426:59fe:ac27 with SMTP id
 5b1f17b1804b1-4328327c3d5mr156658635e9.26.1730754332956; 
 Mon, 04 Nov 2024 13:05:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRY98VI1e4LNpdEUOQ4xrvZTCDqiXNSkMpTVbzWEBYqZySB5e1KqhoeNo6HmbQYElDRF1yTw==
X-Received: by 2002:a05:600c:3507:b0:426:59fe:ac27 with SMTP id
 5b1f17b1804b1-4328327c3d5mr156658345e9.26.1730754332426; 
 Mon, 04 Nov 2024 13:05:32 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7d15sm14338176f8f.8.2024.11.04.13.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:05:31 -0800 (PST)
Date: Mon, 4 Nov 2024 16:05:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 luzhixing12345 <luzhixing12345@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 02/65] docs: fix vhost-user protocol doc
Message-ID: <b87ea798eb83693286cb2db6606280431e02628d.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: luzhixing12345 <luzhixing12345@gmail.com>

Some editorial tweaks to the doc:

Add a ref link to Memory region description and Multiple Memory region
description.

Descriptions about memory regions are merged into one line.

Add extra type(64 bits) to Log description structure fields

Fix ’s to 's

Signed-off-by: luzhixing12345 <luzhixing12345@gmail.com>
Message-Id: <20240911060400.3472-1-luzhixing12345@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


