Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840CCC021B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 09:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmUsF-0005WP-1U; Mon, 24 Feb 2025 04:35:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tmUs9-0005VY-Hc
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 04:35:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tmUs3-0007ZT-M0
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 04:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740389715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=muDKENn3P+VryD3sSSPsrou42smhhv6JR+I+9zJ+YGQ=;
 b=CT5TcpdIryNCA3VjTiUX1q6mTftcN27dFXP6+4dmum9WoZ6FL8+xkMWsq9HsjZIckW8dnS
 5oH5xx6Y1mkhEuZwj7Qzz4ZmRZOjv/tfiom4EceVK44YIizl3w9YJMVuA3Z1X9jGmX4d4A
 +83TJkqu1Yqe9rO9/OaF6eNKAHMDyX4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-Tda3zBuvNEiDi7OglMgIkQ-1; Mon, 24 Feb 2025 04:35:12 -0500
X-MC-Unique: Tda3zBuvNEiDi7OglMgIkQ-1
X-Mimecast-MFC-AGG-ID: Tda3zBuvNEiDi7OglMgIkQ_1740389712
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2fc3e239675so13919835a91.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 01:35:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740389712; x=1740994512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=muDKENn3P+VryD3sSSPsrou42smhhv6JR+I+9zJ+YGQ=;
 b=lSD0holY3l8Cv+vAIFhtFfbazbK3LZ6jAZjUpG6mCrzXwJjElqgYwJunBrHRagqQSm
 hAvixDTj6OOD335GiPR84kmYyJyPYcz1O1nFlGtqLgjNzX4UhgDfL1wx91T9FX53lKF3
 WDHuRcz/199Q3uCRi+hZKXrUCwku5Xw/j5xUEEr05WMbomNG5bG9KjENIArLbgzfbkLx
 vjl9AILxOutyhgIsdTNbq/pzPvSaL8HyQPvlxBWw2gaq+E5E9NFdaJs6F3zHyYLhKAU/
 QkWN81jhTX9z0RMH/Kwd2t1fxoqp6EcrxTdL42A/FM5lViPtWud7S6B+fK4xAygFgrWf
 3zuQ==
X-Gm-Message-State: AOJu0YzPf4xWHL4ji8dESeKzJ9D7I4z+pM4kTbFeLicLcxHVNBmlypSn
 YQUYlD52fK+00fHzKdywd3WF3VJY++4q77PDQJ/NV8eX6P4axZI5NzuAPC1xK6fZ5Tkarlv/3WR
 8V8ZbE5Q9Jvt6uToar7zGGdK6wRwsnpe2aR+p5OWSxw71A87vP7nVUwWFrQrJb8Eoc9ocW+zz2E
 wPHwgRwPQPiQgDCLD6LQoJL00ZV00=
X-Gm-Gg: ASbGnct/Ff9LMoCXW+xN/p8mcJOdnP1mYeRSSkY7JZ8ubOQSKFGc/WXRCcnIX+PxwQF
 OMCWERNQjbfTDLjUfLYM7YkUwIR8CE2VGkJYzYK6VUYDPeZgeqAZ+PiPD1BI+OVCO9hucyJDtih
 4=
X-Received: by 2002:a17:90b:4ac5:b0:2ee:f80c:6892 with SMTP id
 98e67ed59e1d1-2fce868c624mr18588996a91.3.1740389711814; 
 Mon, 24 Feb 2025 01:35:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFM11bJOO+rH6KdvimEotRRFTK6yJIx8iSnvpqct5T5Tu/cRHX+nhtk+ni0umbNbjLSmtBAn5UC4RRdDmVSE5g=
X-Received: by 2002:a17:90b:4ac5:b0:2ee:f80c:6892 with SMTP id
 98e67ed59e1d1-2fce868c624mr18588972a91.3.1740389711385; Mon, 24 Feb 2025
 01:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20250217164012.246727-1-aesteve@redhat.com>
 <aad375d5-8dab-41df-9986-4967ef485a71@redhat.com>
 <CADSE00+Tq8KVTW3BhLwRiQLQuFmauHRvXh34zP6fvvYFrB_t9g@mail.gmail.com>
 <40859ece-0850-40cb-b8b9-28d0d76aefde@redhat.com>
In-Reply-To: <40859ece-0850-40cb-b8b9-28d0d76aefde@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 24 Feb 2025 10:35:00 +0100
X-Gm-Features: AWEUYZmiEPV8O9ICshocrqTYGd-M6txKKqVw2xiFRea1o0yHZSA1sgQp--peP2c
Message-ID: <CADSE00JPHcXXK4dhvwY7rrXNV=1WSQYMv8vOGjVE0TG0+fVkNA@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] vhost-user: Add SHMEM_MAP/UNMAP requests
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, slp@redhat.com, stevensd@chromium.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Stefano Garzarella <sgarzare@redhat.com>, stefanha@redhat.com, hi@alyssa.is,
 mst@redhat.com, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Feb 24, 2025 at 10:16=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 24.02.25 09:54, Albert Esteve wrote:
> > On Mon, Feb 17, 2025 at 9:01=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 17.02.25 17:40, Albert Esteve wrote:
> >>> Hi all,
> >>>
> >>
> >> Hi,
> >>
> >> looks like our debugging session was successfu :)
> >>
> >> One question below.
> >>
> >>> v3->v4
> >>> - Change mmap strategy to use RAM blocks
> >>>     and subregions.
> >>> - Add new bitfield to qmp feature map
> >>> - Followed most review comments from
> >>>     last iteration.
> >>> - Merged documentation patch again with
> >>>     this one. Makes more sense to
> >>>     review them together after all.
> >>> - Add documentation for MEM_READ/WRITE
> >>>     messages.
> >>>
> >>> The goal of this patch is to support
> >>> dynamic fd-backed memory maps initiated
> >>> from vhost-user backends.
> >>> There are many devices that could already
> >>> benefit of this feature, e.g.,
> >>> virtiofs or virtio-gpu.
> >>>
> >>> After receiving the SHMEM_MAP/UNMAP request,
> >>> the frontend creates the RAMBlock form the
> >>> fd and maps it by adding it as a subregion
> >>> of the shared memory region container.
> >>>
> >>> The VIRTIO Shared Memory Region list is
> >>> declared in the `VirtIODevice` struct
> >>> to make it generic.
> >>>
> >>> TODO: There was a conversation on the
> >>> previous version around adding tests
> >>> to the patch (which I have acknowledged).
> >>> However, given the numerous changes
> >>> that the patch already has, I have
> >>> decided to send it early and collect
> >>> some feedback while I work on the
> >>> tests for the next iteration.
> >>> Given that I have been able to
> >>> test the implementation with
> >>> my local setup, I am more or less
> >>> confident that, at least, the code
> >>> is in a relatively sane state
> >>> so that no reviewing time is
> >>> wasted on broken patches.
> >>>
> >>> This patch also includes:
> >>> - SHMEM_CONFIG frontend request that is
> >>> specifically meant to allow generic
> >>> vhost-user-device frontend to be able to
> >>> query VIRTIO Shared Memory settings from the
> >>> backend (as this device is generic and agnostic
> >>> of the actual backend configuration).
> >>>
> >>> - MEM_READ/WRITE backend requests are
> >>> added to deal with a potential issue when having
> >>> multiple backends sharing a file descriptor.
> >>> When a backend calls SHMEM_MAP it makes
> >>> accessing to the region fail for other
> >>> backend as it is missing from their translation
> >>> table. So these requests are a fallback
> >>> for vhost-user memory translation fails.
> >>
> >> Can you elaborate what the issue here is?
> >>
> >> Why would SHMEM_MAP make accessing the region fail for other backends =
--
> >> what makes this missing from their translation?
> >
> > This issue was raised by Stefan Hajnoczi in one of the first
> > iterations of this patchset, based upon previous David Gilbert's work
> > on the virtiofs DAX Window.
> >
> > Let me paste here some of his remarks:
> >
> > """
> > Other backends don't see these mappings. If the guest submits a vring
> > descriptor referencing a mapping to another backend, then that backend
> > won't be able to access this memory.
> > """
> > [...]
> > """
> > A bit more detail:
> >
> > Device A has a VIRTIO Shared Memory Region. An application mmaps that
> > memory (examples: guest userspace driver using Linux VFIO, a guest
> > kernel driver that exposes the memory to userspace via mmap, or guest
> > kernel DAX). The application passes that memory as an I/O buffer to
> > device B (e.g. O_DIRECT disk I/O).
> >
> > The result is that device B's vhost-user backend receives a vring
> > descriptor that points to a guest memory address in device A's VIRTIO
> > Shared Memory Region. Since device B does not have this memory in its
> > table, it cannot translate the address and the device breaks.
> > """
> >
> > I have not triggered the issue myself. So the idea is that the next
> > patch will *definitively* include some testing for the commits that I
> > cannot verify with my local setup.
>
> Hah! But isn't that exact problem which is now solved by our rework?
>
> Whatever is mapped in the VIRTIO Shared Memory Region will be
> communicated to all other vhost-user devices. So they should have that
> memory in their map and should be able to access it.

You mean the SET_MEM_TABLE message after the vhost_commit is sent to
all vhost-user devices? I was not sure, as I was testing with a single
device, that would be great, and simplify the patch a lot.

>
> The only thing vhost-user devices cannot access are IIRC ram_device_ptr
> memory regions (e.g., from vfio devices). But that is independent shared
> memory regions.
>
> --
> Cheers,
>
> David / dhildenb
>


