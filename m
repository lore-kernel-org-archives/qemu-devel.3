Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDDCC3DA64
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 05:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saTQ3-0007Ld-O7; Sun, 04 Aug 2024 01:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luzhixing12345@gmail.com>)
 id 1saTQ2-0007L9-TU
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 01:04:34 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luzhixing12345@gmail.com>)
 id 1saTPz-000597-QM
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 01:04:33 -0400
Received: by mail-io1-xd42.google.com with SMTP id
 ca18e2360f4ac-81fd520fee5so87259739f.2
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2024 22:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722747869; x=1723352669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SaosWFXddIPMnm6QFZrfOckWwg8x6TjfnPBvSFK1JSs=;
 b=f03VAgl5rxwWYo/QxEUt143X3ege/q7CvaZ3g61OVBkAZ3E2j8CS6XXF8eIdLPUCPt
 z5xJ6RSH/zsdlOS2y4MzFPO6ZgB1o+11OXErsBxFiXRekvCFezqTp3nlSvjcYX/Hpget
 HeVTOr8hBtw2TIXHxwAiu8+m8MbUByKG85w+ggdN3V7IGvLehp6h/dX1PjE8X6Te78gd
 uuDH5YJJ1FYLR56DXxcF/P749IYCnFG9bNS+Py+1QKYD/R7WzPMzx6p69reMgGJps4Sa
 XXWqjFaGH+Axl/Pb2dmScb9Dd77WTeYaD0ovicEVD8Zmk8oDiI7Qj0jaFwfLtn0f9Yap
 R8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722747869; x=1723352669;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SaosWFXddIPMnm6QFZrfOckWwg8x6TjfnPBvSFK1JSs=;
 b=lwxs1lqcHZvkZ13Tqz26IzCnm7L0vCEbaO+rga/ZpjguMfJpW3csphKanem2hprnjS
 0ZviSHD9runJHe4XH5pVL4jeJ5cIGepH+efGRl5DbHTChq0cIXaTmKN1+vTglttUp7hf
 P7dlIT4v+3KZWSjfB+tHvvNpqyS0B5vGzzOq3uuudmbDQgpEOF9wGUXLLk8ocJurzbSm
 eKPRZUK2bA9OJvAsrBO1zl2cAaDcii0Eu/UMDm8THPNtr5Ob7IwWyQ9Hi0OdmO44Utmf
 Y49PZW5vyZqOkVWAv9S6aQdbIMktbvdgGqa3Kc6//aEAc6JmCJ9joEqk/U/UQ+kO0Dql
 6wtQ==
X-Gm-Message-State: AOJu0Yy1WXr4uZQMLJ/FxFDcmbvx06FFllPVMt9Yv1cuzzoJoiIxujXJ
 90QDyEa81DYJo+QCJE2ETygx+8tK5xYTVkd3w+TjOO8bTe5fZfC4xru2xlDp
X-Google-Smtp-Source: AGHT+IGkFE/O5sjg4gyTxQVPuGq8Kyr4q+qzggr7mu2G+qV4HHhvVeWTmdC819CkVLcIktA4MCSTHA==
X-Received: by 2002:a05:6e02:12c9:b0:39a:13e3:9176 with SMTP id
 e9e14a558f8ab-39b1fba164bmr119983055ab.15.1722747869294; 
 Sat, 03 Aug 2024 22:04:29 -0700 (PDT)
Received: from localhost.localdomain ([223.104.134.101])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f19da0sm43126405ad.60.2024.08.03.22.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 22:04:28 -0700 (PDT)
From: luzhixing12345 <luzhixing12345@gmail.com>
To: qemu-devel@nongnu.org
Cc: luzhixing12345 <luzhixing12345@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] docs: fix vhost-user protocol doc
Date: Sun,  4 Aug 2024 13:04:20 +0800
Message-Id: <20240804050420.20165-1-luzhixing12345@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=luzhixing12345@gmail.com; helo=mail-io1-xd42.google.com
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

add a ref link to Memory region description

add extra type(64 bits) to Log description structure fields

fix ’s to 's

---
 docs/interop/vhost-user.rst | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index d8419fd2f1..e34b305bd9 100644
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
@@ -211,6 +213,8 @@ Single memory region description
 
 :padding: 64-bit
 
+:region: :ref:`Memory region description <memory_region_description>`
+
 A region is represented by Memory region description.
 
 Multiple Memory regions description
@@ -233,9 +237,9 @@ Log description
 | log size | log offset |
 +----------+------------+
 
-:log size: size of area used for logging
+:log size: a 64-bit size of area used for logging
 
-:log offset: offset from start of supplied file descriptor where
+:log offset: a 64-bit offset from start of supplied file descriptor where
              logging starts (i.e. where guest address 0 would be
              logged)
 
@@ -382,7 +386,7 @@ the kernel implementation.
 
 The communication consists of the *front-end* sending message requests and
 the *back-end* sending message replies. Most of the requests don't require
-replies. Here is a list of the ones that do:
+replies, except for the following requests:
 
 * ``VHOST_USER_GET_FEATURES``
 * ``VHOST_USER_GET_PROTOCOL_FEATURES``
@@ -1239,11 +1243,11 @@ Front-end message types
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
@@ -1662,7 +1666,7 @@ Front-end message types
   :reply payload: ``u64``
 
   Front-end and back-end negotiate a channel over which to transfer the
-  back-end’s internal state during migration.  Either side (front-end or
+  back-end's internal state during migration.  Either side (front-end or
   back-end) may create the channel.  The nature of this channel is not
   restricted or defined in this document, but whichever side creates it
   must create a file descriptor that is provided to the respectively
@@ -1714,7 +1718,7 @@ Front-end message types
   :request payload: N/A
   :reply payload: ``u64``
 
-  After transferring the back-end’s internal state during migration (see
+  After transferring the back-end's internal state during migration (see
   the :ref:`Migrating back-end state <migrating_backend_state>`
   section), check whether the back-end was able to successfully fully
   process the state.
-- 
2.34.1


