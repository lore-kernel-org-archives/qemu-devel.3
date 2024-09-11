Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9766DEE020E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 06:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soGU1-0004ho-On; Wed, 11 Sep 2024 02:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luzhixing12345@gmail.com>)
 id 1soGTz-0004h3-Tu
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:05:39 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luzhixing12345@gmail.com>)
 id 1soGTx-0007j1-Ad
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:05:39 -0400
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-717849c0dcaso5926355b3a.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 23:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726034735; x=1726639535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FIAF1X69aSLXHJC27ryfdtdWE2pXgbLkXo6se6JTYgQ=;
 b=LBjuf068gweTvR1GjfgHnvPQx6ZeFWiTiXGNeDtMUZsqpuoaH7O/0lu4zc4QZ47RHE
 5rF08w6dXv+nnjc2UdVChOflSLUyiadyWdnvuGA+xOZh4e2uCflJVkqq/LUe1Ja15SwI
 D1Ms3IvisIBl3SU8FnxxRoHf1HOUUdcsO1IVqpGZuz3odAOJwfYAUulCIWOkIRs0/wJi
 SFiEcVduKSDZQrXsgRUdMRmIFSKSWqa55Q+Og7GCimlVI+krkIsAnzclz16YXpPQ0XS7
 xwXu2W6RB0xAaEYI4zTftti7jotXwBHhqm7PfWcXADzPYVVPdSJBf5z1gle9VRckH20Y
 hoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726034735; x=1726639535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FIAF1X69aSLXHJC27ryfdtdWE2pXgbLkXo6se6JTYgQ=;
 b=xAZS0HTj3pjnt6QGPvlt+5ZzWNb2wrldqgPa/Q3UNx/lKmfktnEvnTuTX5qaXvehSR
 1asPkxM8MsAJo3wITu3CnLiV6qD+lninBVPhT7B+AL4GhFYyXBT8/wKXN/9yXQw2Gy5b
 LAkGuqFr8xy4ZkneACReVO7fY+gNIOusRD8am7thFx/CDdA/dyEyu7LXbM+ccfPhq8wr
 fZa8uQ3dt3SMyqFqf5Uy/xlDWG5pxwQQ5vJFCDsWITOlANNTMeDsGaAaLraK9TxQbP6P
 qeJmHz9415Zu4z7Wf5ISv3WSGNUzqsDIqvoZ471JB3adMhPtcL0ZrUkRh/D24hkWYvHx
 /zxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeRUadTuWDKHN2eXBKjoUXlUxtZvi1uUiVg6HO7UmNDQUOEQfQ0BW8p4ZVEkMvfFYaNqusdjBwAYgV@nongnu.org
X-Gm-Message-State: AOJu0Yy8wskG7K/fMdjxBBua8atfi1XAEfpcY2v5t1Esn8F0Spme/Pf+
 eLGshxW40ChnUC8jQEns+n95Os6H2jWR8yPRZvifQ7J04EwFLnJA
X-Google-Smtp-Source: AGHT+IGos+XdhiQ9oR+8F5Wx/BBFLs3IFFNNj9KQ2h90qAooLXXD0nXgTZ9F/wAhSwhIxMwvs5RzAg==
X-Received: by 2002:a05:6a00:85a2:b0:70d:2796:bce8 with SMTP id
 d2e1a72fcca58-718d5f3370cmr19731315b3a.20.1726034735097; 
 Tue, 10 Sep 2024 23:05:35 -0700 (PDT)
Received: from localhost.localdomain ([39.144.194.76])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d8256da131sm6662874a12.70.2024.09.10.23.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:05:34 -0700 (PDT)
From: luzhixing12345 <luzhixing12345@gmail.com>
To: mst@redhat.com
Cc: luzhixing12345@gmail.com,
	qemu-devel@nongnu.org,
	sgarzare@redhat.com
Subject: [PATCH v2] docs: fix vhost-user protocol doc
Date: Wed, 11 Sep 2024 14:04:00 +0800
Message-Id: <20240911060400.3472-1-luzhixing12345@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910132855-mutt-send-email-mst@kernel.org>
References: <20240910132855-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=luzhixing12345@gmail.com; helo=mail-pf1-x444.google.com
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

Add a ref link to Memory region description and Multiple Memory region description.

Desciptions about memory regions are merged into one line.

Add extra type(64 bits) to Log description structure fields

Fix ’s to 's

>On Sun, Sep 08, 2024 at 10:49:54PM +0800, luzhixing12345 wrote:
>> >On Fri, Sep 06, 2024 at 10:10:45AM +0800, luzhixing12345 wrote:
>> >> Hi, can someone help review this patch?
>> >> 
>> >> Signed-off-by: luzhixing12345 <luzhixing12345@gmail.com>
>> >
>> >You got comments Aug 5, pls address them.
>> 
>> ok, the comments are addressed.
>
>Pls post v2, list the comments addressed in the changelog,
>coming after ---
>
>Thanks!
>
>
>> >On Sun, Aug 04, 2024 at 01:04:20PM GMT, luzhixing12345 wrote:
>> >>add a ref link to Memory region description
>> >>
>> >>add extra type(64 bits) to Log description structure fields
>> >>
>> >>fix ’s to 's
>> >>
>> >>---
>> >> docs/interop/vhost-user.rst | 22 +++++++++++++---------
>> >> 1 file changed, 13 insertions(+), 9 deletions(-)
>> >
>> >Please run `scripts/checkpatch.pl` before sending.
>> >
>> >S-o-b missing here.
>> >
>> >>
>> >>diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>> >>index d8419fd2f1..e34b305bd9 100644
>> >>--- a/docs/interop/vhost-user.rst
>> >>+++ b/docs/interop/vhost-user.rst
>> >>@@ -167,6 +167,8 @@ A vring address description
>> >> Note that a ring address is an IOVA if ``VIRTIO_F_IOMMU_PLATFORM`` has
>> >> been negotiated. Otherwise it is a user address.
>> >>
>> >>+.. _memory_region_description:
>> >>+
>> >> Memory region description
>> >> ^^^^^^^^^^^^^^^^^^^^^^^^^
>> >>
>> >>@@ -180,7 +182,7 @@ Memory region description
>> >>
>> >> :user address: a 64-bit user address
>> >>
>> >>-:mmap offset: 64-bit offset where region starts in the mapped memory
>> >>+:mmap offset: a 64-bit offset where region starts in the mapped memory
>> >>
>> >> When the ``VHOST_USER_PROTOCOL_F_XEN_MMAP`` protocol feature has been
>> >> successfully negotiated, the memory region description contains two extra
>> >>@@ -190,7 +192,7 @@ fields at the end.
>> >> | guest address | size | user address | mmap offset | xen mmap flags | domid |
>> >> +---------------+------+--------------+-------------+----------------+-------+
>> >>
>> >>-:xen mmap flags: 32-bit bit field
>> >>+:xen mmap flags: a 32-bit bit field
>> >>
>> >> - Bit 0 is set for Xen foreign memory mapping.
>> >> - Bit 1 is set for Xen grant memory mapping.
>> >>@@ -211,6 +213,8 @@ Single memory region description
>> >>
>> >> :padding: 64-bit
>> >>
>> >>+:region: :ref:`Memory region description <memory_region_description>`
>> >>+
>> >> A region is represented by Memory region description.
>> >
>> >Should we merge this line with the one added?
>> 
>> Desciptions about memory regions are merged into one line.
>> 
>> >>
>> >> Multiple Memory regions description
>> >
>> >Should we extend also the Multiple Memory region description?
>> 
>> Yes, this patch adds a ref link to it.
>> 
>> >>@@ -233,9 +237,9 @@ Log description
>> >> | log size | log offset |
>> >> +----------+------------+
>> >>
>> >>-:log size: size of area used for logging
>> >>+:log size: a 64-bit size of area used for logging
>> >>
>> >>-:log offset: offset from start of supplied file descriptor where
>> >>+:log offset: a 64-bit offset from start of supplied file descriptor where
>> >>              logging starts (i.e. where guest address 0 would be
>> >>              logged)
>> >>
>> >>@@ -382,7 +386,7 @@ the kernel implementation.
>> >>
>> >> The communication consists of the *front-end* sending message requests and
>> >> the *back-end* sending message replies. Most of the requests don't require
>> >>-replies. Here is a list of the ones that do:
>> >>+replies, except for the following requests:
>> >>
>> >> * ``VHOST_USER_GET_FEATURES``
>> >> * ``VHOST_USER_GET_PROTOCOL_FEATURES``
>> >>@@ -1239,11 +1243,11 @@ Front-end message types
>> >>   (*a vring descriptor index for split virtqueues* vs. *vring descriptor
>> >>   indices for packed virtqueues*).
>> >>
>> >>-  When and as long as all of a device's vrings are stopped, it is
>> >>+  When and as long as all of a device's vrings are stopped, it is
>> >>   *suspended*, see :ref:`Suspended device state
>> >>   <suspended_device_state>`.
>> >>
>> >>-  The request payload's *num* field is currently reserved and must be
>> >>+  The request payload's *num* field is currently reserved and must be
>> >>   set to 0.
>> >>
>> >> ``VHOST_USER_SET_VRING_KICK``
>> >>@@ -1662,7 +1666,7 @@ Front-end message types
>> >>   :reply payload: ``u64``
>> >>
>> >>   Front-end and back-end negotiate a channel over which to transfer the
>> >>-  back-end's internal state during migration.  Either side (front-end or
>> >>+  back-end's internal state during migration.  Either side (front-end or
>> >>   back-end) may create the channel.  The nature of this channel is not
>> >>   restricted or defined in this document, but whichever side creates it
>> >>   must create a file descriptor that is provided to the respectively
>> >>@@ -1714,7 +1718,7 @@ Front-end message types
>> >>   :request payload: N/A
>> >>   :reply payload: ``u64``
>> >>
>> >>-  After transferring the back-end's internal state during migration (see
>> >>+  After transferring the back-end's internal state during migration (see
>> >>   the :ref:`Migrating back-end state <migrating_backend_state>`
>> >>   section), check whether the back-end was able to successfully fully
>> >>   process the state.
>> >>-- 
>> >>2.34.1
>> >>
>> 
>> Signed-off-by: luzhixing12345 <luzhixing12345@gmail.com>
>> ---
>>  docs/interop/vhost-user.rst | 24 +++++++++++++-----------
>>  1 file changed, 13 insertions(+), 11 deletions(-)
>> 
>> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>> index d8419fd2f1..2e50f2ddfa 100644
>> --- a/docs/interop/vhost-user.rst
>> +++ b/docs/interop/vhost-user.rst
>> @@ -167,6 +167,8 @@ A vring address description
>>  Note that a ring address is an IOVA if ``VIRTIO_F_IOMMU_PLATFORM`` has
>>  been negotiated. Otherwise it is a user address.
>>  
>> +.. _memory_region_description:
>> +
>>  Memory region description
>>  ^^^^^^^^^^^^^^^^^^^^^^^^^
>>  
>> @@ -180,7 +182,7 @@ Memory region description
>>  
>>  :user address: a 64-bit user address
>>  
>> -:mmap offset: 64-bit offset where region starts in the mapped memory
>> +:mmap offset: a 64-bit offset where region starts in the mapped memory
>>  
>>  When the ``VHOST_USER_PROTOCOL_F_XEN_MMAP`` protocol feature has been
>>  successfully negotiated, the memory region description contains two extra
>> @@ -190,7 +192,7 @@ fields at the end.
>>  | guest address | size | user address | mmap offset | xen mmap flags | domid |
>>  +---------------+------+--------------+-------------+----------------+-------+
>>  
>> -:xen mmap flags: 32-bit bit field
>> +:xen mmap flags: a 32-bit bit field
>>  
>>  - Bit 0 is set for Xen foreign memory mapping.
>>  - Bit 1 is set for Xen grant memory mapping.
>> @@ -211,7 +213,7 @@ Single memory region description
>>  
>>  :padding: 64-bit
>>  
>> -A region is represented by Memory region description.
>> +:region: region is represented by :ref:`Memory region description <memory_region_description>`.
>>  
>>  Multiple Memory regions description
>>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> @@ -224,7 +226,7 @@ Multiple Memory regions description
>>  
>>  :padding: 32-bit
>>  
>> -A region is represented by Memory region description.
>> +:regions: regions field contains 8 regions of type :ref:`Memory region description ><memory_region_description>`.
>>  
>>  Log description
>>  ^^^^^^^^^^^^^^^
>> @@ -233,9 +235,9 @@ Log description
>>  | log size | log offset |
>>  +----------+------------+
>>  
>> -:log size: size of area used for logging
>> +:log size: a 64-bit size of area used for logging
>>  
>> -:log offset: offset from start of supplied file descriptor where
>> +:log offset: a 64-bit offset from start of supplied file descriptor where
>>               logging starts (i.e. where guest address 0 would be
>>               logged)
>>  
>> @@ -382,7 +384,7 @@ the kernel implementation.
>>  
>>  The communication consists of the *front-end* sending message requests and
>>  the *back-end* sending message replies. Most of the requests don't require
>> -replies. Here is a list of the ones that do:
>> +replies, except for the following requests:
>>  
>>  * ``VHOST_USER_GET_FEATURES``
>>  * ``VHOST_USER_GET_PROTOCOL_FEATURES``
>> @@ -1239,11 +1241,11 @@ Front-end message types
>>    (*a vring descriptor index for split virtqueues* vs. *vring descriptor
>>    indices for packed virtqueues*).
>>  
>> -  When and as long as all of a device’s vrings are stopped, it is
>> +  When and as long as all of a device's vrings are stopped, it is
>>    *suspended*, see :ref:`Suspended device state
>>    <suspended_device_state>`.
>>  
>> -  The request payload’s *num* field is currently reserved and must be
>> +  The request payload's *num* field is currently reserved and must be
>>    set to 0.
>>  
>>  ``VHOST_USER_SET_VRING_KICK``
>> @@ -1662,7 +1664,7 @@ Front-end message types
>>    :reply payload: ``u64``
>>  
>>    Front-end and back-end negotiate a channel over which to transfer the
>> -  back-end’s internal state during migration.  Either side (front-end or
>> +  back-end's internal state during migration.  Either side (front-end or
>>    back-end) may create the channel.  The nature of this channel is not
>>    restricted or defined in this document, but whichever side creates it
>>    must create a file descriptor that is provided to the respectively
>> @@ -1714,7 +1716,7 @@ Front-end message types
>>    :request payload: N/A
>>    :reply payload: ``u64``
>>  
>> -  After transferring the back-end’s internal state during migration (see
>> +  After transferring the back-end's internal state during migration (see
>>    the :ref:`Migrating back-end state <migrating_backend_state>`
>>    section), check whether the back-end was able to successfully fully
>>    process the state.
>> -- 
>> 2.34.1

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


