Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121F6C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 08:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkJXX-0007zv-UT; Wed, 13 Mar 2024 04:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rkJXT-0007zb-V1
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:00:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rkJXR-000713-N4
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710316835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oi2vnmmBzCWB567PGY+8n1qdildTzQRHfRpxJaSS2nw=;
 b=XrpMyiYuZ8ZvGiBsnKZmxYKnt6+NCx214u3Fgd7jdLr8o7d3jse6YMROMHy92eSL7XafLp
 mXW0B/CVG4tYOiYJHcrcGhNYpYhMT22YGmNWUL7Lsk+qJvuFDeUgj0hGmuX7ahqHYPYako
 /A80cZ5FjPjW/JZmvYqY30/p1N25ExA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-k6PdrrFSOwK3u_laIN_82g-1; Wed, 13 Mar 2024 04:00:31 -0400
X-MC-Unique: k6PdrrFSOwK3u_laIN_82g-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-29a5bae5b3fso5923993a91.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 01:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710316830; x=1710921630;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oi2vnmmBzCWB567PGY+8n1qdildTzQRHfRpxJaSS2nw=;
 b=ImziEcrnCXHNXdwVps7fXb/bYEMGm3oDRzUIDl6QdKSYWZCaMkAiadZGj8eKImohqo
 DO3rDr5kfybRrfLYV4gOa5NjhwSiDQzmUPhPs7rvXTAeBlsFrRlDINY6XK0ZZCXklxlX
 tS5GMzj5ny9nLKa208s77XXy6CyM1LS7qif5HjjstryZuKuao6Ur1Ve20qjmlctmzS0a
 /iN404pgOaOu7IsqSQ0ncX19NcjZTnSbp8EusQW1LGeTv0RmzCfAito4AwwKlh2K+KR9
 ofqU+4eHZQz0x/twNgGxJTzI7XgzZHjpC543G08DkjDRQ/YxPs9SExxjvozNS8bP1uhP
 H1og==
X-Gm-Message-State: AOJu0Yym6zKtqFezig3wIrzez0RSWiYyzJ5pUu3JlmiRTCVovk4Wd3WX
 iMaQgUHTjHTXYslDVwts7tQ0iukjfJwZmpagFV/pF8JjDV5MeQSzQDZhOqmulvdslYxYZDtSPHQ
 OjTHhm8Be8Mtd7Wx9y8Onm7FQKZ0Zz5aBsIJ2HHhSCRQtk+bCmMs/uVmQ5CHyk4lfWW6oeTwFi3
 zzJec5dNIxmjyFEFzlfC4vnoeVwyY=
X-Received: by 2002:a17:90a:eb07:b0:29c:5ba6:c518 with SMTP id
 j7-20020a17090aeb0700b0029c5ba6c518mr1602857pjz.6.1710316830273; 
 Wed, 13 Mar 2024 01:00:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEgbJLpPOEyXZusvCXIhRmFlfAVPfHzXRezU53CuurNQJBqhmzW3wCz8sFwSmLvsYjZc/236bQCffnM2hbY6w=
X-Received: by 2002:a17:90a:eb07:b0:29c:5ba6:c518 with SMTP id
 j7-20020a17090aeb0700b0029c5ba6c518mr1602837pjz.6.1710316829941; Wed, 13 Mar
 2024 01:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240219143423.272012-1-aesteve@redhat.com>
 <20240312142033-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240312142033-mutt-send-email-mst@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 13 Mar 2024 09:00:18 +0100
Message-ID: <CADSE00LSoSyqomKtCQM-AxAKvtz2+Hmc=0r6KDeyy+LdNYfBEg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Virtio dmabuf improvements
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, alex.bennee@linaro.org, 
 philmd@linaro.org, kraxel@redhat.com, marcandre.lureau@gmail.com
Content-Type: multipart/alternative; boundary="0000000000001a40a50613862b6a"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000001a40a50613862b6a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 7:23=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:

> On Mon, Feb 19, 2024 at 03:34:18PM +0100, Albert Esteve wrote:
> > v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg1005257.html
> > v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg1014615.html
> > v3: Virtio dmabuf improvements
> > v3 -> v4
> >   - Changed GMutex by QemuMutex in virtio-dmabuf
> >   - Made the value at VirtioSharedObject an union
> >     to make naming more clear
> >   - Added some documentation
>
> Dropped everything except patch 1 for now.
>

Got it. Thanks!


>
> > Various improvements for the virtio-dmabuf module.
> > This patch includes:
> >
> > - Check for ownership before allowing a vhost device
> >   to remove an object from the table.
> > - Properly cleanup shared resources if a vhost device
> >   object gets cleaned up.
> > - Rename virtio dmabuf functions to `virtio_dmabuf_*`
> >
> > Albert Esteve (5):
> >   hw/virtio: check owner for removing objects
> >   hw/virtio: document SharedObject structures
> >   hw/virtio: change dmabuf mutex to QemuMutex
> >   hw/virtio: cleanup shared resources
> >   hw/virtio: rename virtio dmabuf API
> >
> >  docs/interop/vhost-user.rst       |  4 +-
> >  hw/display/virtio-dmabuf.c        | 98 +++++++++++++++++++------------
> >  hw/virtio/vhost-user.c            | 31 +++++++---
> >  hw/virtio/vhost.c                 |  3 +
> >  hw/virtio/virtio.c                |  3 +
> >  include/hw/virtio/virtio-dmabuf.h | 73 +++++++++++++++++------
> >  tests/unit/test-virtio-dmabuf.c   | 82 +++++++++++++++++++-------
> >  7 files changed, 211 insertions(+), 83 deletions(-)
> >
> > --
> > 2.43.1
>
>

--0000000000001a40a50613862b6a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br clear=3D"all"><div><div dir=3D"ltr" c=
lass=3D"gmail_signature"><div dir=3D"ltr"><p style=3D"color:rgb(0,0,0);font=
-family:RedHatText,sans-serif;font-weight:bold;margin:0px;padding:0px;font-=
size:14px"><br></p></div></div></div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 12, 2024 at 7:23=E2=80=AFP=
M Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 Mon, Feb 19, 2024 at 03:34:18PM +0100, Albert Esteve wrote:<br>
&gt; v1: <a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg1=
005257.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.=
com/qemu-devel@nongnu.org/msg1005257.html</a><br>
&gt; v2: <a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg1=
014615.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.=
com/qemu-devel@nongnu.org/msg1014615.html</a><br>
&gt; v3: Virtio dmabuf improvements<br>
&gt; v3 -&gt; v4<br>
&gt;=C2=A0 =C2=A0- Changed GMutex by QemuMutex in virtio-dmabuf<br>
&gt;=C2=A0 =C2=A0- Made the value at VirtioSharedObject an union<br>
&gt;=C2=A0 =C2=A0 =C2=A0to make naming more clear<br>
&gt;=C2=A0 =C2=A0- Added some documentation<br>
<br>
Dropped everything except patch 1 for now.<br></blockquote><div><br></div><=
div>Got it. Thanks!</div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
<br>
&gt; Various improvements for the virtio-dmabuf module.<br>
&gt; This patch includes:<br>
&gt; <br>
&gt; - Check for ownership before allowing a vhost device<br>
&gt;=C2=A0 =C2=A0to remove an object from the table.<br>
&gt; - Properly cleanup shared resources if a vhost device<br>
&gt;=C2=A0 =C2=A0object gets cleaned up.<br>
&gt; - Rename virtio dmabuf functions to `virtio_dmabuf_*`<br>
&gt; <br>
&gt; Albert Esteve (5):<br>
&gt;=C2=A0 =C2=A0hw/virtio: check owner for removing objects<br>
&gt;=C2=A0 =C2=A0hw/virtio: document SharedObject structures<br>
&gt;=C2=A0 =C2=A0hw/virtio: change dmabuf mutex to QemuMutex<br>
&gt;=C2=A0 =C2=A0hw/virtio: cleanup shared resources<br>
&gt;=C2=A0 =C2=A0hw/virtio: rename virtio dmabuf API<br>
&gt; <br>
&gt;=C2=A0 docs/interop/vhost-user.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 =
+-<br>
&gt;=C2=A0 hw/display/virtio-dmabuf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 98 +++++=
++++++++++++++------------<br>
&gt;=C2=A0 hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
| 31 +++++++---<br>
&gt;=C2=A0 hw/virtio/vhost.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 3 +<br>
&gt;=C2=A0 hw/virtio/virtio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 3 +<br>
&gt;=C2=A0 include/hw/virtio/virtio-dmabuf.h | 73 +++++++++++++++++------<b=
r>
&gt;=C2=A0 tests/unit/test-virtio-dmabuf.c=C2=A0 =C2=A0| 82 +++++++++++++++=
++++-------<br>
&gt;=C2=A0 7 files changed, 211 insertions(+), 83 deletions(-)<br>
&gt; <br>
&gt; -- <br>
&gt; 2.43.1<br>
<br>
</blockquote></div></div>

--0000000000001a40a50613862b6a--


