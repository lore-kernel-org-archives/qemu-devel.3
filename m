Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDE8C52D70
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 10:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sauqm-0000SW-0M; Mon, 05 Aug 2024 06:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sauqk-0000S2-Jj
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 06:21:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sauqi-00050t-Hi
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 06:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722853313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eGL/5XaGw4L9foaBL7Q1IGixdt40JqzA2I9CGK+aghU=;
 b=Tcau9jZbdv0tFy/W0jR5oMMS1jliOIh5LoPoMMrZdlVN3BXt7PId20gAXKqeLc5rSjkZuD
 ctbW479Eio7gXbtkP4lUhR7i067roWa+cCpuwYKaMlCYbmhXPG2t+FCHb256eww3/CINj4
 T8EBQYz9RpvixIo4+oGdXG8CZWoX5RM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-Q15uoCjwP9eAQoYVdT1hSA-1; Mon, 05 Aug 2024 06:21:51 -0400
X-MC-Unique: Q15uoCjwP9eAQoYVdT1hSA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6b7a1c45abbso112114526d6.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 03:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722853311; x=1723458111;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eGL/5XaGw4L9foaBL7Q1IGixdt40JqzA2I9CGK+aghU=;
 b=FFe2U0DIGcmswRXU1XS5eyQFUjzLtyCNaAyGozBZfwpga6aHBzm4WIxFxblTvbVDrb
 bFma7Q1bVpllHxu8ZAABQfkwscjfId47lL1YplvmkIyT1nfSvZJAqeBoZJ7v49C989ZQ
 PaIGblIzo9ie9R/CfQ7GFza8fiWxnee9vdges3sczo8IJOdppc/XKjn1Iu/SC1ngB0pz
 0AABilOZxS1fLE4xSxHzN/EMM9Nd6iHNXalfHTiXc4uMsvMpzA10ndhfDrZSe/ZIBxBq
 C4lDwjdSozOg/vFNez9nAsOLwtGg7bybWAQu8i2OKX9QMNl5Puc6oVJc5NiP4BrEESwF
 M9pg==
X-Gm-Message-State: AOJu0Yya6OW2nvSHb8pPyMNfARfNyADu4ewsx/CPZe+c0BBTDcOAXUgd
 v//swp1iFTo+yU1L1eDcAMf3nhZw4L/e1eQosPf0UP9jIiTQkH81gQVTH6tV2MQVdGH7i/z9rVV
 HzkOoZuMxfFT4UjABljHe/DE3TpgEygLVGPCfqcTp2Ac1i8b6KkA8
X-Received: by 2002:a05:6214:84d:b0:6b5:2be1:cd6e with SMTP id
 6a1803df08f44-6bb91d372acmr216972876d6.4.1722853311055; 
 Mon, 05 Aug 2024 03:21:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWOyqnNM5DYw8Lhxh7reA4Isy3hGrrRHlRPgxudaBPmm4ff4RMobjmJDD0ca7yoT+Khs/jcg==
X-Received: by 2002:a05:6214:84d:b0:6b5:2be1:cd6e with SMTP id
 6a1803df08f44-6bb91d372acmr216972616d6.4.1722853310583; 
 Mon, 05 Aug 2024 03:21:50 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-79.retail.telecomitalia.it.
 [82.57.51.79]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bb9c79b2aasm33874626d6.54.2024.08.05.03.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 03:21:50 -0700 (PDT)
Date: Mon, 5 Aug 2024 12:21:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: luzhixing12345 <luzhixing12345@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] docs: fix vhost-user protocol doc
Message-ID: <tqmw3wdsxkm66yh7qwpf2r2xdpckvf7hofblsyan2pmnfbttys@eh326n7d326m>
References: <20240804050420.20165-1-luzhixing12345@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240804050420.20165-1-luzhixing12345@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Aug 04, 2024 at 01:04:20PM GMT, luzhixing12345 wrote:
>add a ref link to Memory region description
>
>add extra type(64 bits) to Log description structure fields
>
>fix ’s to 's
>
>---
> docs/interop/vhost-user.rst | 22 +++++++++++++---------
> 1 file changed, 13 insertions(+), 9 deletions(-)

Please run `scripts/checkpatch.pl` before sending.

S-o-b missing here.

>
>diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>index d8419fd2f1..e34b305bd9 100644
>--- a/docs/interop/vhost-user.rst
>+++ b/docs/interop/vhost-user.rst
>@@ -167,6 +167,8 @@ A vring address description
> Note that a ring address is an IOVA if ``VIRTIO_F_IOMMU_PLATFORM`` has
> been negotiated. Otherwise it is a user address.
>
>+.. _memory_region_description:
>+
> Memory region description
> ^^^^^^^^^^^^^^^^^^^^^^^^^
>
>@@ -180,7 +182,7 @@ Memory region description
>
> :user address: a 64-bit user address
>
>-:mmap offset: 64-bit offset where region starts in the mapped memory
>+:mmap offset: a 64-bit offset where region starts in the mapped memory
>
> When the ``VHOST_USER_PROTOCOL_F_XEN_MMAP`` protocol feature has been
> successfully negotiated, the memory region description contains two extra
>@@ -190,7 +192,7 @@ fields at the end.
> | guest address | size | user address | mmap offset | xen mmap flags | domid |
> +---------------+------+--------------+-------------+----------------+-------+
>
>-:xen mmap flags: 32-bit bit field
>+:xen mmap flags: a 32-bit bit field
>
> - Bit 0 is set for Xen foreign memory mapping.
> - Bit 1 is set for Xen grant memory mapping.
>@@ -211,6 +213,8 @@ Single memory region description
>
> :padding: 64-bit
>
>+:region: :ref:`Memory region description <memory_region_description>`
>+
> A region is represented by Memory region description.

Should we merge this line with the one added?

>
> Multiple Memory regions description

Should we extend also the Multiple Memory region description?

>@@ -233,9 +237,9 @@ Log description
> | log size | log offset |
> +----------+------------+
>
>-:log size: size of area used for logging
>+:log size: a 64-bit size of area used for logging
>
>-:log offset: offset from start of supplied file descriptor where
>+:log offset: a 64-bit offset from start of supplied file descriptor where
>              logging starts (i.e. where guest address 0 would be
>              logged)
>
>@@ -382,7 +386,7 @@ the kernel implementation.
>
> The communication consists of the *front-end* sending message requests and
> the *back-end* sending message replies. Most of the requests don't require
>-replies. Here is a list of the ones that do:
>+replies, except for the following requests:
>
> * ``VHOST_USER_GET_FEATURES``
> * ``VHOST_USER_GET_PROTOCOL_FEATURES``
>@@ -1239,11 +1243,11 @@ Front-end message types
>   (*a vring descriptor index for split virtqueues* vs. *vring descriptor
>   indices for packed virtqueues*).
>
>-  When and as long as all of a device’s vrings are stopped, it is
>+  When and as long as all of a device's vrings are stopped, it is
>   *suspended*, see :ref:`Suspended device state
>   <suspended_device_state>`.
>
>-  The request payload’s *num* field is currently reserved and must be
>+  The request payload's *num* field is currently reserved and must be
>   set to 0.
>
> ``VHOST_USER_SET_VRING_KICK``
>@@ -1662,7 +1666,7 @@ Front-end message types
>   :reply payload: ``u64``
>
>   Front-end and back-end negotiate a channel over which to transfer the
>-  back-end’s internal state during migration.  Either side (front-end or
>+  back-end's internal state during migration.  Either side (front-end or
>   back-end) may create the channel.  The nature of this channel is not
>   restricted or defined in this document, but whichever side creates it
>   must create a file descriptor that is provided to the respectively
>@@ -1714,7 +1718,7 @@ Front-end message types
>   :request payload: N/A
>   :reply payload: ``u64``
>
>-  After transferring the back-end’s internal state during migration (see
>+  After transferring the back-end's internal state during migration (see
>   the :ref:`Migrating back-end state <migrating_backend_state>`
>   section), check whether the back-end was able to successfully fully
>   process the state.
>-- 
>2.34.1
>


