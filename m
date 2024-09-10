Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E36ECE582
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 07:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snv5r-000624-En; Tue, 10 Sep 2024 03:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1snv5l-000617-DC
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 03:15:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1snv5h-0000yM-9f
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 03:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725952505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n6p7tg73wOeLZHJBczFdsrmewAYTTnrhP3z+humjAps=;
 b=J3Bips6HD7YnyFhSOuw0AQgI06dCLhw7duFB18TtuQHC15MhuVjeNCMPuNee6tPr3eMOm4
 Uio8JcPwFLD+MdCz4MRVQk3EoNEgPiCuV4rax1eIkU77B5im7N1dHeb0/LYp1f/So5gax8
 cqbbUqbRz2df1zboblQhIjR8nb8cQD4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-3_1aSDXqMVOOzWmFe9gC8A-1; Tue, 10 Sep 2024 03:15:02 -0400
X-MC-Unique: 3_1aSDXqMVOOzWmFe9gC8A-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-717912c8f27so6091295b3a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 00:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725952501; x=1726557301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n6p7tg73wOeLZHJBczFdsrmewAYTTnrhP3z+humjAps=;
 b=BVcLqL7iDo5gED7KBnRRfg3k8EBCLY13lLqoY9NYn3RMrrh+v46bGT8xghJSa8fTrR
 bWMEoiyS3IDUqpQzt4rj38qLJqajkUg6WdFQFXf8g9YqzvzBdM8dA3UE6gk2Xc7IalfV
 JeB04NATo5TktDqD4LXg7+NJvfRy2Uws3g9Iz30Hddc0CEi/qjQ7BjKLK95+6l3rKl32
 TMzDwZ1n3zxe7TOcuFZl72rs2eW8q+P6psgf3j+Y/DG/umc+A6E4ywiLk1pZj7/CdSjj
 LgIq0PXX0NRDl5ZDKFX6j6RiFJ7vh8Vz6HDOxEBwAWrV1NRzTE4/q2/P7hpgoJkOI9sf
 zy4w==
X-Gm-Message-State: AOJu0YzUC1AexnKzdT6Jhkdk4fnO5dB55zhboeQsiORvJkz9On/3zprL
 gjEmY9hFpCBuXAgbFpB+eEoF1t7vhOE18tACbE0sZzDdzreQo4gyuF2gsUnUOktWVWItkY781YW
 mwXz+qo9DJaLJM+BUqVW5kfdGYyepB4BpEJHkh7eOajMY+IKADk0C+ZbmBbQNRpazGtFeCHH2eH
 2qkVFeWjOzTvAbele9hnyuUCo5eWk=
X-Received: by 2002:a05:6a20:9f9a:b0:1c2:8af6:31d3 with SMTP id
 adf61e73a8af0-1cf2ac71143mr14043813637.10.1725952500885; 
 Tue, 10 Sep 2024 00:15:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh3Yqf1d5/LSDQqa1GjFTSi+xssYPYdv52k4ADMWWxz2WDjJx6ZgzdWj2sNGi65HcdzvvsjiOU1n07q3osFys=
X-Received: by 2002:a05:6a20:9f9a:b0:1c2:8af6:31d3 with SMTP id
 adf61e73a8af0-1cf2ac71143mr14043784637.10.1725952500503; Tue, 10 Sep 2024
 00:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240628145710.1516121-1-aesteve@redhat.com>
 <20240628145710.1516121-6-aesteve@redhat.com>
 <20240711085533.GG563880@dynamic-pd01.res.v6.highway.a1.net>
 <CADSE00L=U4jmEvosaSt=a2EQ654kfh4cKzNLQFpFXX==pHZ0Hg@mail.gmail.com>
 <20240905191839.GG1922502@fedora>
In-Reply-To: <20240905191839.GG1922502@fedora>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 10 Sep 2024 09:14:48 +0200
Message-ID: <CADSE00Le6xqSYRX3UV-EXSTiAz8=a3Wma-QLWQWfzJmPvsJK7Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/5] vhost_user: Implement mem_read/mem_write
 handlers
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, david@redhat.com, 
 slp@redhat.com, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b12ad90621bea136"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

--000000000000b12ad90621bea136
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 9:18=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:

> On Wed, Sep 04, 2024 at 03:01:06PM +0200, Albert Esteve wrote:
> > On Thu, Jul 11, 2024 at 10:55=E2=80=AFAM Stefan Hajnoczi <stefanha@redh=
at.com>
> > wrote:
> >
> > > On Fri, Jun 28, 2024 at 04:57:10PM +0200, Albert Esteve wrote:
> > > > Implement function handlers for memory read and write
> > > > operations.
> > > >
> > > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > > ---
> > > >  hw/virtio/vhost-user.c | 34 ++++++++++++++++++++++++++++++----
> > > >  1 file changed, 30 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > > index 18cacb2d68..79becbc87b 100644
> > > > --- a/hw/virtio/vhost-user.c
> > > > +++ b/hw/virtio/vhost-user.c
> > > > @@ -1884,16 +1884,42 @@ static int
> > > >  vhost_user_backend_handle_mem_read(struct vhost_dev *dev,
> > > >                                     VhostUserMemRWMsg *mem_rw)
> > > >  {
> > > > -    /* TODO */
> > > > -    return -EPERM;
> > > > +    ram_addr_t offset;
> > > > +    int fd;
> > > > +    MemoryRegion *mr;
> > > > +
> > > > +    mr =3D vhost_user_get_mr_data(mem_rw->guest_address, &offset,
> &fd);
> > > > +
> > > > +    if (!mr) {
> > > > +        error_report("Failed to get memory region with address %"
> > > PRIx64,
> > > > +                     mem_rw->guest_address);
> > > > +        return -EFAULT;
> > > > +    }
> > > > +
> > > > +    memcpy(mem_rw->data, memory_region_get_ram_ptr(mr) + offset,
> > > mem_rw->size);
> > >
> > > Don't try to write this from scratch. Use address_space_read/write().
> It
> > > supports corner cases like crossing MemoryRegions.
> > >
> >
> > I am having issues getting the address space from the vhost_dev struct =
to
> > feed
> > address_spave_read/write() function with the first parameter. But I fou=
nd
> > mr->ops.
> > Would something like this perhaps be enough?
> >
> > ```
> >     mr->ops->read_with_attrs(mr->opaque, mem_rw->guest_address,
> >                              &mem_rw->data, mem_rw->size,
> >                              MEMTXATTRS_UNSPECIFIED);
> > ```
>
> You can use dev->vdev->dma_as to get the AddressSpace for
> address_space_read/write():
>

Oof, I see, thanks!
I still struggle a bit with the structs relationships...


>
>   struct vhost_dev {
>       VirtIODevice *vdev;
>
>   struct VirtIODevice
>   {
>       ...
>       AddressSpace *dma_as;
>
> >
> >
> > >
> > > > +
> > > > +    return 0;
> > > >  }
> > > >
> > > >  static int
> > > >  vhost_user_backend_handle_mem_write(struct vhost_dev *dev,
> > > >                                     VhostUserMemRWMsg *mem_rw)
> > > >  {
> > > > -    /* TODO */
> > > > -    return -EPERM;
> > > > +    ram_addr_t offset;
> > > > +    int fd;
> > > > +    MemoryRegion *mr;
> > > > +
> > > > +    mr =3D vhost_user_get_mr_data(mem_rw->guest_address, &offset,
> &fd);
> > > > +
> > > > +    if (!mr) {
> > > > +        error_report("Failed to get memory region with address %"
> > > PRIx64,
> > > > +                     mem_rw->guest_address);
> > > > +        return -EFAULT;
> > > > +    }
> > > > +
> > > > +    memcpy(memory_region_get_ram_ptr(mr) + offset, mem_rw->data,
> > > mem_rw->size);
> > > > +
> > > > +    return 0;
> > > >  }
> > > >
> > > >  static void close_backend_channel(struct vhost_user *u)
> > > > --
> > > > 2.45.2
> > > >
> > >
>

--000000000000b12ad90621bea136
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br clear=3D"all"><div><div dir=3D"ltr" c=
lass=3D"gmail_signature"><div dir=3D"ltr"><p style=3D"color:rgb(0,0,0);font=
-family:RedHatText,sans-serif;font-weight:bold;margin:0px;padding:0px;font-=
size:14px"><br></p></div></div></div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 5, 2024 at 9:18=E2=80=AFPM=
 Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stefanha@redhat=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On Wed, Sep 04, 2024 at 03:01:06PM +0200, Albert Esteve wrote:<br>
&gt; On Thu, Jul 11, 2024 at 10:55=E2=80=AFAM Stefan Hajnoczi &lt;<a href=
=3D"mailto:stefanha@redhat.com" target=3D"_blank">stefanha@redhat.com</a>&g=
t;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Fri, Jun 28, 2024 at 04:57:10PM +0200, Albert Esteve wrote:<br=
>
&gt; &gt; &gt; Implement function handlers for memory read and write<br>
&gt; &gt; &gt; operations.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@r=
edhat.com" target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 hw/virtio/vhost-user.c | 34 ++++++++++++++++++++++++++=
++++----<br>
&gt; &gt; &gt;=C2=A0 1 file changed, 30 insertions(+), 4 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c=
<br>
&gt; &gt; &gt; index 18cacb2d68..79becbc87b 100644<br>
&gt; &gt; &gt; --- a/hw/virtio/vhost-user.c<br>
&gt; &gt; &gt; +++ b/hw/virtio/vhost-user.c<br>
&gt; &gt; &gt; @@ -1884,16 +1884,42 @@ static int<br>
&gt; &gt; &gt;=C2=A0 vhost_user_backend_handle_mem_read(struct vhost_dev *d=
ev,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Vh=
ostUserMemRWMsg *mem_rw)<br>
&gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 /* TODO */<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 return -EPERM;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 ram_addr_t offset;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 int fd;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 MemoryRegion *mr;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 mr =3D vhost_user_get_mr_data(mem_rw-&gt;gues=
t_address, &amp;offset, &amp;fd);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (!mr) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed to ge=
t memory region with address %&quot;<br>
&gt; &gt; PRIx64,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0mem_rw-&gt;guest_address);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 memcpy(mem_rw-&gt;data, memory_region_get_ram=
_ptr(mr) + offset,<br>
&gt; &gt; mem_rw-&gt;size);<br>
&gt; &gt;<br>
&gt; &gt; Don&#39;t try to write this from scratch. Use address_space_read/=
write(). It<br>
&gt; &gt; supports corner cases like crossing MemoryRegions.<br>
&gt; &gt;<br>
&gt; <br>
&gt; I am having issues getting the address space from the vhost_dev struct=
 to<br>
&gt; feed<br>
&gt; address_spave_read/write() function with the first parameter. But I fo=
und<br>
&gt; mr-&gt;ops.<br>
&gt; Would something like this perhaps be enough?<br>
&gt; <br>
&gt; ```<br>
&gt;=C2=A0 =C2=A0 =C2=A0mr-&gt;ops-&gt;read_with_attrs(mr-&gt;opaque, mem_r=
w-&gt;guest_address,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;mem_rw-&gt;data, mem_rw-&gt;size,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MEMTXATTRS_UNSPECIFIED);<br>
&gt; ```<br>
<br>
You can use dev-&gt;vdev-&gt;dma_as to get the AddressSpace for<br>
address_space_read/write():<br></blockquote><div><br></div><div>Oof, I see,=
 thanks!</div><div>I still struggle a bit with the structs relationships...=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0 struct vhost_dev {<br>
=C2=A0 =C2=A0 =C2=A0 VirtIODevice *vdev;<br>
<br>
=C2=A0 struct VirtIODevice<br>
=C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 AddressSpace *dma_as;<br>
<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 static int<br>
&gt; &gt; &gt;=C2=A0 vhost_user_backend_handle_mem_write(struct vhost_dev *=
dev,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Vh=
ostUserMemRWMsg *mem_rw)<br>
&gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 /* TODO */<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 return -EPERM;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 ram_addr_t offset;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 int fd;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 MemoryRegion *mr;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 mr =3D vhost_user_get_mr_data(mem_rw-&gt;gues=
t_address, &amp;offset, &amp;fd);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (!mr) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed to ge=
t memory region with address %&quot;<br>
&gt; &gt; PRIx64,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0mem_rw-&gt;guest_address);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 memcpy(memory_region_get_ram_ptr(mr) + offset=
, mem_rw-&gt;data,<br>
&gt; &gt; mem_rw-&gt;size);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 static void close_backend_channel(struct vhost_user *u=
)<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; 2.45.2<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
</blockquote></div></div>

--000000000000b12ad90621bea136--


