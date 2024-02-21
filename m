Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A966FC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoYB-0005Lm-G8; Wed, 21 Feb 2024 10:30:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rcoNK-0004TK-Vk
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:19:12 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rciJ2-0006JM-Qk
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 03:50:23 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5d4a1e66750so4582615a12.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 00:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1708505415; x=1709110215;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ae6/xGKTpGAlvhJG1ss+Z46Jcbj14OcQkfGmu6t6WRI=;
 b=P4Y5i2mzxuk0UIROPmxIlECCXzsG6G6krgEjFIFurWvKxpWrhDE2tBntcsnkdYCmvq
 1CgbNMY69uLoWTEHmEKAoB9dqpkLcbrE6jJ7Ontfd2FubCZkZzqVu46VFGNz7QbEDXYj
 QVc94vbpM9rth9K2nLYYU0RO+pKzfsFMjwpoBK7aHsPEGHMDHtzPE0ZS5zXHDAjfVtA+
 VuyItNBppTgd9OsDfkoY+15WHQPDdIk0VwfpQRcpvmF4OeUEfKOIeXr44chgcMfOl8hL
 pBBslnBfwFP1mNskS2yzJnMSdmejV52OwVX8xBlprO6U93dd5t69vdxNasoTaPEqHDSB
 GN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708505415; x=1709110215;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ae6/xGKTpGAlvhJG1ss+Z46Jcbj14OcQkfGmu6t6WRI=;
 b=Uha+bDxpz2F2z42W3EAdbloe9vHQXMF3eRLOlykYNhGsMFzv/Bsp/lwsrQHBmOISQ6
 HbKKvCizdObEwiLgAuH1YqgAtrNT9/KdSy9Z4RS09SNExdtpqYCdjumImVH6f6Zjjto4
 PFpaURmV8xMVyVdrmsOiM0mQoI5HcfJ4Rrnfe+8wEEhGHUJ/wddBl8TVgrMbJNcEcutx
 uIznvAAjmj5JMBh91esgFfd2PV6PJvkuHyqurhwE4xDIR29gzlCHZoAVJD6kAotIofov
 Y3L6+ZRfkorRSU00z7KMa53Q7ksZcPrvHg5hffv8diMxI5ZzjA3GTYzQrNcJV6eCpYb/
 +otQ==
X-Gm-Message-State: AOJu0YybKs6CJGyHy0oK1bNDIRwoEBoC+Am7gT8DoqweURagMToWxk3l
 6hsL0J3I1tLQ6hKoiEnNl3z9sy0E8w80JirM6Mq5MLF+4418EeeUadpBR4JMh6bWk2ZnUHjuBNw
 dA2/4i6xsu0uNjohOZDSyNUNsA53UgzgzGEUsZw==
X-Google-Smtp-Source: AGHT+IHS3per3uxVzdAn5bZFdBWZMVDCOujhwntS2sfAqkZkvwycO+ODdyQv/luevHhr/0FpaRhIls9fXvkgGJ/xujM=
X-Received: by 2002:a17:90b:397:b0:299:14e4:6579 with SMTP id
 ga23-20020a17090b039700b0029914e46579mr13536785pjb.22.1708505413375; Wed, 21
 Feb 2024 00:50:13 -0800 (PST)
MIME-Version: 1.0
References: <91c52e03e46ff0a96559b4e7d66ded582b2ec4e1.1708486450.git.yong.huang@smartx.com>
 <874je22u83.fsf@pond.sub.org>
 <CAK9dgmZkLZiT_W0UjB+=EN9_vAK5Qy5XKRMBhHBQ98sRBbiAQw@mail.gmail.com>
 <875xyiz0ho.fsf@pond.sub.org>
In-Reply-To: <875xyiz0ho.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Wed, 21 Feb 2024 16:49:57 +0800
Message-ID: <CAK9dgmZOEqd=EgBjsiZZoK3R+VQRMqSdUrK_WwKHfP7LiWzQMQ@mail.gmail.com>
Subject: Re: [PATCH] qapi: Craft the BlockdevCreateOptionsLUKS comment
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000042ee5a0611e06a43"
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--00000000000042ee5a0611e06a43
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 4:26=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Yong Huang <yong.huang@smartx.com> writes:
>
> > On Wed, Feb 21, 2024 at 2:43=E2=80=AFPM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> >
> >> Hyman Huang <yong.huang@smartx.com> writes:
> >>
> >> > Add comment in detail for commit 433957bb7f (qapi:
> >> > Make parameter 'file' optional for
> >> > BlockdevCreateOptionsLUKS).
> >> >
> >> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> >> > ---
> >> >  qapi/block-core.json | 20 +++++++++++++++++++-
> >> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> >> > index ab5a93a966..42b0840d43 100644
> >> > --- a/qapi/block-core.json
> >> > +++ b/qapi/block-core.json
> >> > @@ -4973,7 +4973,25 @@
> >> >  ##
> >> >  # @BlockdevCreateOptionsLUKS:
> >> >  #
> >> > -# Driver specific image creation options for LUKS.
> >> > +# Driver specific image creation options for LUKS. Note that
> >> > +# @file is required if @preallocation is specified and equals
> >> > +# PREALLOC_MODE_ON. The following three scenarios determine how
> >> > +# creation logic behaves when @preallocation is either equal to
> >> > +# PREALLOC_MODE_OFF or is not given:
> >> > +#
> >> > +#  1) When @file is given only, format the block device referenced
> >> > +#     by @file as the LUKS specification and trunk it to the @size.
> >>
> >> Do you mean "truncate it to @size"?
> >>
> > Yes, :( sorry for the spelling mistake.
>
> Writing good documentation in a second language is *hard*.  All we can
> reasonably expect from contributors to try their best.  And then we
> improve the text together in review.  Just like we do for code :)
>
> >> > +#     In this case, the @size should reflect amount of space made
> >> > +#     available to the guest, so the trunk size must take account
> >> > +#     of that which will be used by the crypto header.
> >> > +#
> >> > +#  2) When @header is given only, just format the block device
> >> > +#     referenced by @header as the LUKS specification.
> >> > +#
> >> > +#  3) When both @file and @header are given, block device
> >> > +#     referenced by @file should be trunked to @size, and block
> >> > +#     device referenced by @header should be formatted as the LUKS
> >> > +#     specification.
> >> >  #
> >> >  # @file: Node to create the image format on, mandatory except when
> >> >  #        'preallocation' is not requested
> >>
> >> Let's see whether I understand.
> >>
> >> blockdev-create with "driver": "luks" can work in three different ways=
:
> >>
> >> 1. Create an image with a LUKS header
> >>
> >> 2. Create just a detached LUKS header
> >>
> >> 3. Create an image and a detached LUKS header
> >>
> >> Correct?
> >>
> >
> > Yes
> >
> >
> >> @file and @header are BlockdevRef, which means they refer to existing
> >> images with arbitrary driver.  Could be "file", "qcow2", or anything.
> >>
> >> Correct?
> >>
> > Yes
> >
> >
> >>
> >> To get 1., specify @file, but not @header.
> >>
> >> To get 2., specify @header, but not @file.
> >>
> >> To get 3., specify both.
> >>
> >> Specifying neither is an error.
> >>
> >> Correct?
> >>
> >
> > Yes
> >
> >
> >> In any case, @size is the logical size of the image (how much data it
> >> can hold).
> >>
> >
> > Yes
> >
> >
> >>
> >> With 1., the actual image size is a bit larger due to the LUKS header.
> >> The @file image is resized to that size: if it's shorter, it's grown, =
if
> >> it's longer, it's truncated.
> >>
> >
> > Yes
> >
> >
> >> With 2., @size is merely recorded in the detached LUKS header.
> >>
> >
> > In LUKS1 specification, payload data size is not contained in the heade=
r,
> > so in this case, @size is not recorded in the detached LUKS header.
> > The creation logic just does the LUKS header formatting only.
>
> Is @size unused then?
>

IIUC, yes. Creation logic will ignore the @size. See the following code
in function block_crypto_co_create_luks:

    if (luks_opts->header) {
        /* LUKS volume with detached header */
        hdr_bs =3D bdrv_co_open_blockdev_ref(luks_opts->header, errp);
        if (hdr_bs =3D=3D NULL) {
            return -EIO;
        }

        cflags |=3D QCRYPTO_BLOCK_CREATE_DETACHED;

        /* Format the LUKS header node, here just ignore the size
          * and passed zero to block_crypto_co_create_generic */
        ret =3D block_crypto_co_create_generic(hdr_bs, 0, &create_opts,
                                             PREALLOC_MODE_OFF, cflags,
errp);
        if (ret < 0) {
            goto fail;
        }

        /* Format the LUKS payload node */
        if (luks_opts->file) {
            ret =3D block_crypto_co_format_luks_payload(luks_opts, errp);
            if (ret < 0) {
                goto fail;
            }
        }


>
> >> With 3., @size is recorded in the detached LUKS header, and the @file
> >> image is resized as with 1.
> >>
> >
> > Same reason as above, @size is not recorded and @file image is
> > resized to @size exactly.
> >
> >
> >>
> >> Correct?
> >>
> >>
> > Thanks for the comment,
> >
> > Yong
>
>

--=20
Best regards

--00000000000042ee5a0611e06a43
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 21, 20=
24 at 4:26=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat=
.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Yong Huang=
 &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@=
smartx.com</a>&gt; writes:<br>
<br>
&gt; On Wed, Feb 21, 2024 at 2:43=E2=80=AFPM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; w=
rote:<br>
&gt;<br>
&gt;&gt; Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D=
"_blank">yong.huang@smartx.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; Add comment in detail for commit 433957bb7f (qapi:<br>
&gt;&gt; &gt; Make parameter &#39;file&#39; optional for<br>
&gt;&gt; &gt; BlockdevCreateOptionsLUKS).<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@s=
martx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 qapi/block-core.json | 20 +++++++++++++++++++-<br>
&gt;&gt; &gt;=C2=A0 1 file changed, 19 insertions(+), 1 deletion(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/qapi/block-core.json b/qapi/block-core.json<br>
&gt;&gt; &gt; index ab5a93a966..42b0840d43 100644<br>
&gt;&gt; &gt; --- a/qapi/block-core.json<br>
&gt;&gt; &gt; +++ b/qapi/block-core.json<br>
&gt;&gt; &gt; @@ -4973,7 +4973,25 @@<br>
&gt;&gt; &gt;=C2=A0 ##<br>
&gt;&gt; &gt;=C2=A0 # @BlockdevCreateOptionsLUKS:<br>
&gt;&gt; &gt;=C2=A0 #<br>
&gt;&gt; &gt; -# Driver specific image creation options for LUKS.<br>
&gt;&gt; &gt; +# Driver specific image creation options for LUKS. Note that=
<br>
&gt;&gt; &gt; +# @file is required if @preallocation is specified and equal=
s<br>
&gt;&gt; &gt; +# PREALLOC_MODE_ON. The following three scenarios determine =
how<br>
&gt;&gt; &gt; +# creation logic behaves when @preallocation is either equal=
 to<br>
&gt;&gt; &gt; +# PREALLOC_MODE_OFF or is not given:<br>
&gt;&gt; &gt; +#<br>
&gt;&gt; &gt; +#=C2=A0 1) When @file is given only, format the block device=
 referenced<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0by @file as the LUKS specification and =
trunk it to the @size.<br>
&gt;&gt;<br>
&gt;&gt; Do you mean &quot;truncate it to @size&quot;?<br>
&gt;&gt;<br>
&gt; Yes, :( sorry for the spelling mistake.<br>
<br>
Writing good documentation in a second language is *hard*.=C2=A0 All we can=
<br>
reasonably expect from contributors to try their best.=C2=A0 And then we<br=
>
improve the text together in review.=C2=A0 Just like we do for code :)<br>
<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0In this case, the @size should reflect =
amount of space made<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0available to the guest, so the trunk si=
ze must take account<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0of that which will be used by the crypt=
o header.<br>
&gt;&gt; &gt; +#<br>
&gt;&gt; &gt; +#=C2=A0 2) When @header is given only, just format the block=
 device<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0referenced by @header as the LUKS speci=
fication.<br>
&gt;&gt; &gt; +#<br>
&gt;&gt; &gt; +#=C2=A0 3) When both @file and @header are given, block devi=
ce<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0referenced by @file should be trunked t=
o @size, and block<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0device referenced by @header should be =
formatted as the LUKS<br>
&gt;&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0specification.<br>
&gt;&gt; &gt;=C2=A0 #<br>
&gt;&gt; &gt;=C2=A0 # @file: Node to create the image format on, mandatory =
except when<br>
&gt;&gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;preallocation&#39; is=
 not requested<br>
&gt;&gt;<br>
&gt;&gt; Let&#39;s see whether I understand.<br>
&gt;&gt;<br>
&gt;&gt; blockdev-create with &quot;driver&quot;: &quot;luks&quot; can work=
 in three different ways:<br>
&gt;&gt;<br>
&gt;&gt; 1. Create an image with a LUKS header<br>
&gt;&gt;<br>
&gt;&gt; 2. Create just a detached LUKS header<br>
&gt;&gt;<br>
&gt;&gt; 3. Create an image and a detached LUKS header<br>
&gt;&gt;<br>
&gt;&gt; Correct?<br>
&gt;&gt;<br>
&gt;<br>
&gt; Yes<br>
&gt;<br>
&gt;<br>
&gt;&gt; @file and @header are BlockdevRef, which means they refer to exist=
ing<br>
&gt;&gt; images with arbitrary driver.=C2=A0 Could be &quot;file&quot;, &qu=
ot;qcow2&quot;, or anything.<br>
&gt;&gt;<br>
&gt;&gt; Correct?<br>
&gt;&gt;<br>
&gt; Yes<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; To get 1., specify @file, but not @header.<br>
&gt;&gt;<br>
&gt;&gt; To get 2., specify @header, but not @file.<br>
&gt;&gt;<br>
&gt;&gt; To get 3., specify both.<br>
&gt;&gt;<br>
&gt;&gt; Specifying neither is an error.<br>
&gt;&gt;<br>
&gt;&gt; Correct?<br>
&gt;&gt;<br>
&gt;<br>
&gt; Yes<br>
&gt;<br>
&gt;<br>
&gt;&gt; In any case, @size is the logical size of the image (how much data=
 it<br>
&gt;&gt; can hold).<br>
&gt;&gt;<br>
&gt;<br>
&gt; Yes<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; With 1., the actual image size is a bit larger due to the LUKS hea=
der.<br>
&gt;&gt; The @file image is resized to that size: if it&#39;s shorter, it&#=
39;s grown, if<br>
&gt;&gt; it&#39;s longer, it&#39;s truncated.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Yes<br>
&gt;<br>
&gt;<br>
&gt;&gt; With 2., @size is merely recorded in the detached LUKS header.<br>
&gt;&gt;<br>
&gt;<br>
&gt; In LUKS1 specification, payload data size is not contained in the head=
er,<br>
&gt; so in this case, @size is not recorded in the detached LUKS header.<br=
>
&gt; The creation logic just does the LUKS header formatting only.<br>
<br>
Is @size unused then?<br></blockquote><div><div class=3D"gmail_default" sty=
le=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br></div><div clas=
s=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-ser=
if">IIUC, yes. Creation logic will ignore the=C2=A0@size. See the following=
 code</div></div><div class=3D"gmail_default" style=3D"font-family:&quot;co=
mic sans ms&quot;,sans-serif">in function=C2=A0block_crypto_co_create_luks:=
</div><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms=
&quot;,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-fam=
ily:&quot;comic sans ms&quot;,sans-serif">=C2=A0 =C2=A0 if (luks_opts-&gt;h=
eader) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* LUKS volume with detached header=
 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 hdr_bs =3D bdrv_co_open_blockdev_ref(luk=
s_opts-&gt;header, errp);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (hdr_bs =3D=3D =
NULL) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EIO;<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 }<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 cflags |=3D QCRY=
PTO_BLOCK_CREATE_DETACHED;<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Format the=
 LUKS header node, here just ignore the size</div><div class=3D"gmail_defau=
lt" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 * and passed zero to block_crypto_co_create_generi=
c */</div><div class=3D"gmail_default" style=3D"font-family:&quot;comic san=
s ms&quot;,sans-serif">=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D block_crypto_co_=
create_generic(hdr_bs, 0, &amp;create_opts,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PREALLOC_MODE_OF=
F, cflags, errp);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Format the LUKS payload node=
 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (luks_opts-&gt;file) {<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D block_crypto_co_format_luks_payload=
(luks_opts, errp);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt=
; 0) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail=
;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;=
border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt;&gt; With 3., @size is recorded in the detached LUKS header, and the @f=
ile<br>
&gt;&gt; image is resized as with 1.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Same reason as above, @size is not recorded and @file image is<br>
&gt; resized to @size exactly.<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Correct?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; Thanks for the comment,<br>
&gt;<br>
&gt; Yong<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--00000000000042ee5a0611e06a43--

