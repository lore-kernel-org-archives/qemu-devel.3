Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F91EED613
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 15:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1solIt-0003U2-AC; Thu, 12 Sep 2024 11:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1solIr-0003Nq-HS
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 11:00:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1solIp-00015P-DT
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 11:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726153210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o8QHQlei/5e8WLXoN1kQ0dOp6fN9SwQAn9QR08rpEac=;
 b=Vh+CpMM8RyLPb7ZXD83bEjlEEPmlipdZkTyaUGgJpTXVXoT+GiXI5HGzszsN88sl6zIV0p
 TTJC/4zVt0ysjnHbcS3uZ0/nb3nPiv0seikl64N0r58lEXBvDWnTysaK3KHJnbX2K7W6tC
 lBWydJVaxn6657YqwFXtqOLKKm5cI9o=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-IrlSQHvjMMm9TmBtbE-qjw-1; Thu, 12 Sep 2024 11:00:07 -0400
X-MC-Unique: IrlSQHvjMMm9TmBtbE-qjw-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-718d6ad6105so1719440b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 08:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726153206; x=1726758006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o8QHQlei/5e8WLXoN1kQ0dOp6fN9SwQAn9QR08rpEac=;
 b=PV1LQecEp18jZbUl9fVO4unzROP04yIsmIdzmNLQaf3z2z7P565JtCdVPCz2fcBxmc
 Mp5Z4ULykRCMbe19pVEvSMhTm8PeQppyxV/FY5yCrbVMLOniBqHNlncE5uIXfAoGu035
 f/GhmYzmIwFwfVZ5OBAHXZLjf3qMsaam0xsKgi0LvL44lXYZxVh6sZjyzLPJ1smTjdZC
 DUoxRiJznPUzSdrC596SL906XU3RBFH8r7lhIvoQ3s+QPXuBg9r3pR/e4uU6pXFzCdCR
 bCGr387/rwETFnyvu+nLjM3MHfPDHJLLK3OPSc4kuax7RVFD1twzj6TdFNpIlrc2ZHwD
 vn4w==
X-Gm-Message-State: AOJu0YzjX04G0Ve6xdbSf8qCN40fbnW0hj4yT6olGsyYfGei5oO46CJa
 ennQ4PzRMq2ef2zLht5l2xqnnFohUxrsQ/u8N2hz/T/8/MM8LlRp2d4itOGfSKeECpn3Au7IGkN
 AyGNzV4fmRfaTTd62iU7Vx7gkCynwk9RT6fhT4Gk7rnTIVBRa+5ZFBZWkwuV74GRaNheImoAGKh
 6BNMWGHpsfNizVl4w+mZnIBDASA4w9FVzmXAAckw==
X-Received: by 2002:a05:6300:668b:b0:1cf:1b7d:8481 with SMTP id
 adf61e73a8af0-1cf7620cbd2mr4326364637.32.1726153204128; 
 Thu, 12 Sep 2024 08:00:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpZFucGUqOYotRDsYYZ+nF1tg+hoLxfWMXHz3p0ThEqxLt4E5E5zyiv98prVvnvJNjp8VqsbjjdX3cI0SHbyQ=
X-Received: by 2002:a05:6300:668b:b0:1cf:1b7d:8481 with SMTP id
 adf61e73a8af0-1cf7620cbd2mr4326319637.32.1726153203634; Thu, 12 Sep 2024
 08:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240912145335.129447-1-aesteve@redhat.com>
In-Reply-To: <20240912145335.129447-1-aesteve@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 12 Sep 2024 16:59:52 +0200
Message-ID: <CADSE00JBa2Z4RmezL3h7Pc0gXjNBy8YEA4Gn7J_2xjG9h6MkuQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] vhost-user: Add SHMEM_MAP/UNMAP requests
To: qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, slp@redhat.com, 
 hi@alyssa.is, mst@redhat.com, david@redhat.com, jasowang@redhat.com, 
 stefanha@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 stevensd@chromium.org
Content-Type: multipart/alternative; boundary="00000000000087f4ac0621ed5c03"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--00000000000087f4ac0621ed5c03
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Link to the documentation:
https://lore.kernel.org/all/20240912144432.126717-1-aesteve@redhat.com/T/#t

On Thu, Sep 12, 2024 at 4:53=E2=80=AFPM Albert Esteve <aesteve@redhat.com> =
wrote:

> Hi all,
>
> v2->v3:
> - Add track for mapped memory in VIRTIO
>   Shared memory regions, so that boundaries
>   can be verified when a request for
>   new mmap is received
> - Use address_space_read/write() for
>   MEM_READ/_WRITE handling methods.
> - Improve/fix support for flexible
>   array members for MEM_READ/_WRITE requests.
> - Split documentation into a separate patch.
> - Various small fixes from previous review.
>
> The usecase for this patch is, e.g., to support
> vhost-user-gpu RESOURCE_BLOB operations,
> or DAX Window request for virtio-fs. In
> general, any operation where a backend
> need to request the frontend to mmap an
> fd into a VIRTIO Shared Memory Region,
> so that the guest can then access it.
>
> After receiving the SHMEM_MAP/UNMAP request,
> the frontend will perform the mmap with the
> instructed parameters (i.e., shmid, shm_offset,
> fd_offset, fd, lenght).
>
> As there are already a couple devices
> that could benefit of such a feature,
> and more could require it in the future,
> the goal is to make the implementation
> generic.
>
> To that end, the VIRTIO Shared Memory
> Region list is declared in the `VirtIODevice`
> struct.
>
> This patch also includes:
> SHMEM_CONFIG frontend request that is
> specifically meant to allow generic
> vhost-user-device frontend to be able to
> query VIRTIO Shared Memory settings from the
> backend (as this device is generic and agnostic
> of the actual backend configuration).
>
> Finally, MEM_READ/WRITE backend requests are
> added to deal with a potential issue when having
> any backend sharing a descriptor that references
> a mapping to another backend. The first
> backend will not be able to see these
> mappings. So these requests are a fallback
> for vhost-user memory translation fails.
>
> Albert Esteve (5):
>   vhost-user: Add VIRTIO Shared Memory map request
>   virtio: Track shared memory mappings
>   vhost_user: Add frontend command for shmem config
>   vhost-user-dev: Add cache BAR
>   vhost_user: Add MEM_READ/WRITE backend requests
>
>  hw/virtio/vhost-user-base.c               |  37 ++-
>  hw/virtio/vhost-user-device-pci.c         |  39 +++-
>  hw/virtio/vhost-user.c                    | 273 ++++++++++++++++++++--
>  hw/virtio/virtio.c                        |  59 +++++
>  include/hw/virtio/vhost-backend.h         |   6 +
>  include/hw/virtio/vhost-user.h            |   1 +
>  include/hw/virtio/virtio.h                |  26 +++
>  subprojects/libvhost-user/libvhost-user.c | 144 ++++++++++++
>  subprojects/libvhost-user/libvhost-user.h |  90 +++++++
>  9 files changed, 648 insertions(+), 27 deletions(-)
>
> --
> 2.45.2
>
>

--00000000000087f4ac0621ed5c03
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Link to the documentation:=C2=A0<a href=3D"https://lore.ke=
rnel.org/all/20240912144432.126717-1-aesteve@redhat.com/T/#t">https://lore.=
kernel.org/all/20240912144432.126717-1-aesteve@redhat.com/T/#t</a></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, S=
ep 12, 2024 at 4:53=E2=80=AFPM Albert Esteve &lt;<a href=3D"mailto:aesteve@=
redhat.com">aesteve@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">Hi all,<br>
<br>
v2-&gt;v3:<br>
- Add track for mapped memory in VIRTIO<br>
=C2=A0 Shared memory regions, so that boundaries<br>
=C2=A0 can be verified when a request for<br>
=C2=A0 new mmap is received<br>
- Use address_space_read/write() for<br>
=C2=A0 MEM_READ/_WRITE handling methods.<br>
- Improve/fix support for flexible<br>
=C2=A0 array members for MEM_READ/_WRITE requests.<br>
- Split documentation into a separate patch.<br>
- Various small fixes from previous review.<br>
<br>
The usecase for this patch is, e.g., to support<br>
vhost-user-gpu RESOURCE_BLOB operations,<br>
or DAX Window request for virtio-fs. In<br>
general, any operation where a backend<br>
need to request the frontend to mmap an<br>
fd into a VIRTIO Shared Memory Region,<br>
so that the guest can then access it.<br>
<br>
After receiving the SHMEM_MAP/UNMAP request,<br>
the frontend will perform the mmap with the<br>
instructed parameters (i.e., shmid, shm_offset,<br>
fd_offset, fd, lenght).<br>
<br>
As there are already a couple devices<br>
that could benefit of such a feature,<br>
and more could require it in the future,<br>
the goal is to make the implementation<br>
generic.<br>
<br>
To that end, the VIRTIO Shared Memory<br>
Region list is declared in the `VirtIODevice`<br>
struct.<br>
<br>
This patch also includes:<br>
SHMEM_CONFIG frontend request that is<br>
specifically meant to allow generic<br>
vhost-user-device frontend to be able to<br>
query VIRTIO Shared Memory settings from the<br>
backend (as this device is generic and agnostic<br>
of the actual backend configuration).<br>
<br>
Finally, MEM_READ/WRITE backend requests are<br>
added to deal with a potential issue when having<br>
any backend sharing a descriptor that references<br>
a mapping to another backend. The first<br>
backend will not be able to see these<br>
mappings. So these requests are a fallback<br>
for vhost-user memory translation fails.<br>
<br>
Albert Esteve (5):<br>
=C2=A0 vhost-user: Add VIRTIO Shared Memory map request<br>
=C2=A0 virtio: Track shared memory mappings<br>
=C2=A0 vhost_user: Add frontend command for shmem config<br>
=C2=A0 vhost-user-dev: Add cache BAR<br>
=C2=A0 vhost_user: Add MEM_READ/WRITE backend requests<br>
<br>
=C2=A0hw/virtio/vhost-user-base.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 37 ++-<br>
=C2=A0hw/virtio/vhost-user-device-pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 39 +++-<br>
=C2=A0hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 273 ++++++++++++++++++++--<br>
=C2=A0hw/virtio/virtio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 59 +++++<br>
=C2=A0include/hw/virtio/vhost-backend.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A06 +<br>
=C2=A0include/hw/virtio/vhost-user.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0include/hw/virtio/virtio.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 26 +++<br>
=C2=A0subprojects/libvhost-user/libvhost-user.c | 144 ++++++++++++<br>
=C2=A0subprojects/libvhost-user/libvhost-user.h |=C2=A0 90 +++++++<br>
=C2=A09 files changed, 648 insertions(+), 27 deletions(-)<br>
<br>
-- <br>
2.45.2<br>
<br>
</blockquote></div>

--00000000000087f4ac0621ed5c03--


