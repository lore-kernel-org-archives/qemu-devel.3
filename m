Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D4CCD37B4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 13:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpeQ-0004IR-0e; Wed, 04 Sep 2024 09:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1slpdn-0001xX-8K
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 09:01:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1slpda-000791-AW
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 09:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725454882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kHj+bROijDGqxhwjqHALQoQ839ffIPrm1+o2AZQgWSc=;
 b=PTiIKEGZJennwtvsMdc4+YgAdikO63TxhGATiiUlhK5/fnxsLLrVN+7WvwSP48M55nAJZ4
 Ay1yRAdC7jdYP7gaXMO7BUQoW5l0veD4o9OrGR4fKZq+MRbPLOGhi/tfjZkeaqXS8FjOZf
 ZirGh7Cfw0u4ZL4P2+fkqxXToQQTqho=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-cYUgGEnxOKmYVeAcBYG1WQ-1; Wed, 04 Sep 2024 09:01:20 -0400
X-MC-Unique: cYUgGEnxOKmYVeAcBYG1WQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2d45800a8f3so5780402a91.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 06:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725454879; x=1726059679;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kHj+bROijDGqxhwjqHALQoQ839ffIPrm1+o2AZQgWSc=;
 b=cIPY/Yeeg8E94VWh4We3+roSPDgRGmMf+GuGPGSyKqljv4NZd3S+QwrcRtgLQRFERn
 Jxu3lq0mb0D4DMp9HsTHvFxP88fYSXu3K0RapBh8JgLRb3NQqxXXTjJWlK+cb88nr2kU
 W1n6jK0KRG3ga63mUr/U+uLPnS3aMHaFYVbeUPv/GeQnm4T51yuajQY7ju0kFoVAOvT+
 AFn/246H4vjtiHKWNfVJDGGD4Y9hrTFFr+cY8G3b4mbjVkok+FewSCfBfEqoFIlbiO9d
 mkn/dCAjoqU6XU20dbUpSHjhJbCSEztx1b5RRmsQDUuSy+t1Gxq1orSJiaQL9DpWB/bW
 JyHA==
X-Gm-Message-State: AOJu0YzCbCJkYSbRJtusHomXtLbie1K2DQYXNg0vWE/XWpfdOixULtiP
 +DWX2PuPiojiCJeTC2aia1IkRVdjxyzah+BpG/hf7fmu6S/C+9CckqG07HOsFhlVhdnHfgdw78j
 zyWftUYf/ND+pTv6EXUY6DGoc4sthtHQYd0aLB2WqZt8C5HkQe5NE6u7Tx1tdLvGz1pAyXP42MY
 2wUjDut1UVs3Rm/mTnphFoZ30eKj4=
X-Received: by 2002:a17:90a:8d0e:b0:2cf:2ab6:a157 with SMTP id
 98e67ed59e1d1-2d89728ba16mr11962232a91.12.1725454878528; 
 Wed, 04 Sep 2024 06:01:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLAEiHxNNlg7kj1RIhaLDpfxR1Qab6aR0BUWhFmALJ3L5ZcdJ7oKFEAHaAlsnbH/9V6OOjKYVMv2hp1APbysA=
X-Received: by 2002:a17:90a:8d0e:b0:2cf:2ab6:a157 with SMTP id
 98e67ed59e1d1-2d89728ba16mr11962185a91.12.1725454878109; Wed, 04 Sep 2024
 06:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240628145710.1516121-1-aesteve@redhat.com>
 <20240628145710.1516121-6-aesteve@redhat.com>
 <20240711085533.GG563880@dynamic-pd01.res.v6.highway.a1.net>
In-Reply-To: <20240711085533.GG563880@dynamic-pd01.res.v6.highway.a1.net>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 4 Sep 2024 15:01:06 +0200
Message-ID: <CADSE00L=U4jmEvosaSt=a2EQ654kfh4cKzNLQFpFXX==pHZ0Hg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/5] vhost_user: Implement mem_read/mem_write
 handlers
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, david@redhat.com, 
 slp@redhat.com, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000016078006214ac589"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--00000000000016078006214ac589
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 10:55=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.c=
om>
wrote:

> On Fri, Jun 28, 2024 at 04:57:10PM +0200, Albert Esteve wrote:
> > Implement function handlers for memory read and write
> > operations.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  hw/virtio/vhost-user.c | 34 ++++++++++++++++++++++++++++++----
> >  1 file changed, 30 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 18cacb2d68..79becbc87b 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -1884,16 +1884,42 @@ static int
> >  vhost_user_backend_handle_mem_read(struct vhost_dev *dev,
> >                                     VhostUserMemRWMsg *mem_rw)
> >  {
> > -    /* TODO */
> > -    return -EPERM;
> > +    ram_addr_t offset;
> > +    int fd;
> > +    MemoryRegion *mr;
> > +
> > +    mr =3D vhost_user_get_mr_data(mem_rw->guest_address, &offset, &fd)=
;
> > +
> > +    if (!mr) {
> > +        error_report("Failed to get memory region with address %"
> PRIx64,
> > +                     mem_rw->guest_address);
> > +        return -EFAULT;
> > +    }
> > +
> > +    memcpy(mem_rw->data, memory_region_get_ram_ptr(mr) + offset,
> mem_rw->size);
>
> Don't try to write this from scratch. Use address_space_read/write(). It
> supports corner cases like crossing MemoryRegions.
>

I am having issues getting the address space from the vhost_dev struct to
feed
address_spave_read/write() function with the first parameter. But I found
mr->ops.
Would something like this perhaps be enough?

```
    mr->ops->read_with_attrs(mr->opaque, mem_rw->guest_address,
                             &mem_rw->data, mem_rw->size,
                             MEMTXATTRS_UNSPECIFIED);
```


>
> > +
> > +    return 0;
> >  }
> >
> >  static int
> >  vhost_user_backend_handle_mem_write(struct vhost_dev *dev,
> >                                     VhostUserMemRWMsg *mem_rw)
> >  {
> > -    /* TODO */
> > -    return -EPERM;
> > +    ram_addr_t offset;
> > +    int fd;
> > +    MemoryRegion *mr;
> > +
> > +    mr =3D vhost_user_get_mr_data(mem_rw->guest_address, &offset, &fd)=
;
> > +
> > +    if (!mr) {
> > +        error_report("Failed to get memory region with address %"
> PRIx64,
> > +                     mem_rw->guest_address);
> > +        return -EFAULT;
> > +    }
> > +
> > +    memcpy(memory_region_get_ram_ptr(mr) + offset, mem_rw->data,
> mem_rw->size);
> > +
> > +    return 0;
> >  }
> >
> >  static void close_backend_channel(struct vhost_user *u)
> > --
> > 2.45.2
> >
>

--00000000000016078006214ac589
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 11, 2024 at 10:55=
=E2=80=AFAM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stef=
anha@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">On Fri, Jun 28, 2024 at 04:57:10PM +0200, Albert Esteve wrot=
e:<br>
&gt; Implement function handlers for memory read and write<br>
&gt; operations.<br>
&gt; <br>
&gt; Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com"=
 target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/virtio/vhost-user.c | 34 ++++++++++++++++++++++++++++++----<b=
r>
&gt;=C2=A0 1 file changed, 30 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>
&gt; index 18cacb2d68..79becbc87b 100644<br>
&gt; --- a/hw/virtio/vhost-user.c<br>
&gt; +++ b/hw/virtio/vhost-user.c<br>
&gt; @@ -1884,16 +1884,42 @@ static int<br>
&gt;=C2=A0 vhost_user_backend_handle_mem_read(struct vhost_dev *dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserMemR=
WMsg *mem_rw)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 /* TODO */<br>
&gt; -=C2=A0 =C2=A0 return -EPERM;<br>
&gt; +=C2=A0 =C2=A0 ram_addr_t offset;<br>
&gt; +=C2=A0 =C2=A0 int fd;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *mr;<br>
&gt; +=C2=A0 =C2=A0 <br>
&gt; +=C2=A0 =C2=A0 mr =3D vhost_user_get_mr_data(mem_rw-&gt;guest_address,=
 &amp;offset, &amp;fd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!mr) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed to get memory r=
egion with address %&quot; PRIx64,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0mem_rw-&gt;guest_address);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memcpy(mem_rw-&gt;data, memory_region_get_ram_ptr(mr) +=
 offset, mem_rw-&gt;size);<br>
<br>
Don&#39;t try to write this from scratch. Use address_space_read/write(). I=
t<br>
supports corner cases like crossing MemoryRegions.<br></blockquote><div><br=
></div><div>I am having issues getting the address space from the vhost_dev=
 struct to feed</div><div>address_spave_read/write() function with the firs=
t parameter. But I found mr-&gt;ops.</div><div>Would something like this pe=
rhaps be enough?</div><div><br></div><div>```</div><div>=C2=A0 =C2=A0 mr-&g=
t;ops-&gt;read_with_attrs(mr-&gt;opaque, mem_rw-&gt;guest_address,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;mem_rw-&gt;data, mem_rw-&gt;size,<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0MEMTXATTRS_UNSPECIFIED);<br></div><div>```</div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int<br>
&gt;=C2=A0 vhost_user_backend_handle_mem_write(struct vhost_dev *dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserMemR=
WMsg *mem_rw)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 /* TODO */<br>
&gt; -=C2=A0 =C2=A0 return -EPERM;<br>
&gt; +=C2=A0 =C2=A0 ram_addr_t offset;<br>
&gt; +=C2=A0 =C2=A0 int fd;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion *mr;<br>
&gt; +=C2=A0 =C2=A0 <br>
&gt; +=C2=A0 =C2=A0 mr =3D vhost_user_get_mr_data(mem_rw-&gt;guest_address,=
 &amp;offset, &amp;fd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!mr) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed to get memory r=
egion with address %&quot; PRIx64,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0mem_rw-&gt;guest_address);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memcpy(memory_region_get_ram_ptr(mr) + offset, mem_rw-&=
gt;data, mem_rw-&gt;size);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void close_backend_channel(struct vhost_user *u)<br>
&gt; -- <br>
&gt; 2.45.2<br>
&gt; <br>
</blockquote></div></div>

--00000000000016078006214ac589--


