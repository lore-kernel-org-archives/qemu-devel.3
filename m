Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B85EC48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 07:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcgkR-00008e-Vp; Wed, 21 Feb 2024 02:10:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rcgkP-000086-C9
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 02:10:29 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rcgkM-0005iq-D9
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 02:10:29 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dc139ed11fso11921545ad.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 23:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1708499302; x=1709104102;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xbDHAMXCSWwQLMvR0+NEyRiJYdqRFrvsARXGJfdO2XA=;
 b=anbetUTfWqdk+o02wAIx1UDiurO2ZXUHBKLj8XBX2zaxVLWHkdQ2fdNNQnX7SPHDWg
 kxlZ0/pZFOAY6TcZFLn1/jmC8cYCZzBOZJ6XHk83P/JmHS7RBWaoVpWgrBFP6yIgtnBP
 /dtJdfAqj5LzZiuRpT2klLR+1/qaXSOFL4Z7606agteDOj8wryG+EP2zaMAIFALFsSt5
 GbFlSHSFQnP7OB7RhOK2TDsvAnGmbMj7+6MaovlKe4e1C2wglu0j270M8CBbO0cXyRjp
 F52Thlh3lezZY1bm66uOS5MtEi9n/QB7BxlPuvZHmgl0ux7lIuhrEsnTQbF+RvU1Q2Qc
 j0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708499302; x=1709104102;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xbDHAMXCSWwQLMvR0+NEyRiJYdqRFrvsARXGJfdO2XA=;
 b=PwT3I/FAUX7ef50qS4S8pfg7sk0surFtm1ytQSKOwrJStZJ3IZJZTRsCCqGXWV3qla
 +VINj0c7nq4zHPiozQMezUFBGSeKpl+n0tLVGozpYdr046tP1JTBNtrfL1avA2tLlkEj
 D7drl2RorguFWV2O1OSHyFClbH1UvA19/NfulAtQ7dOWMMnKSvzRO0rlG2belJmQfMGi
 AF6Uu6VuguE0Ymiv4scWvtCkGAXBEUvc7zUMHD8qoW5koBl9qjnT9Pg/KGQKX9Kc0X/w
 1ojggSdY5SXxhGHMtux9QQ/RQLnkjxXuivHlEQ9cFq7fBfHk5ZrJGwjoFtgaP3xAOK9S
 Ynxw==
X-Gm-Message-State: AOJu0YwRXxrBExdUKVJv/N5aJ6Xo1XxMTX0fd3njJfkGq042g2NTd0Tk
 Kml+McOdTzQpir5+ThwwCRZuiOTXkzpzyTrMztpCY8n0XyAXDCGcc6+B+ZGIfoYyB+U+0MERVlM
 svjtBDpnlixbBnKs0+fJcMvhcJsNphRTZ8ymY4+S59mOEJEAqBN/+rii9
X-Google-Smtp-Source: AGHT+IERjPXurMS4MYpJlZolgFDcH2kl6hPsKzTk/tMWDdEkUdW2qd7VDxZdm+jtETCyCw4Hh/9YIUFahYrcIk/4T48=
X-Received: by 2002:a17:90b:1881:b0:299:1cce:f3c3 with SMTP id
 mn1-20020a17090b188100b002991ccef3c3mr21944881pjb.7.1708499300315; Tue, 20
 Feb 2024 23:08:20 -0800 (PST)
MIME-Version: 1.0
References: <91c52e03e46ff0a96559b4e7d66ded582b2ec4e1.1708486450.git.yong.huang@smartx.com>
 <874je22u83.fsf@pond.sub.org>
In-Reply-To: <874je22u83.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Wed, 21 Feb 2024 15:08:04 +0800
Message-ID: <CAK9dgmZkLZiT_W0UjB+=EN9_vAK5Qy5XKRMBhHBQ98sRBbiAQw@mail.gmail.com>
Subject: Re: [PATCH] qapi: Craft the BlockdevCreateOptionsLUKS comment
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e505fb0611defd5b"
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62a.google.com
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

--000000000000e505fb0611defd5b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:43=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Hyman Huang <yong.huang@smartx.com> writes:
>
> > Add comment in detail for commit 433957bb7f (qapi:
> > Make parameter 'file' optional for
> > BlockdevCreateOptionsLUKS).
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >  qapi/block-core.json | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index ab5a93a966..42b0840d43 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -4973,7 +4973,25 @@
> >  ##
> >  # @BlockdevCreateOptionsLUKS:
> >  #
> > -# Driver specific image creation options for LUKS.
> > +# Driver specific image creation options for LUKS. Note that
> > +# @file is required if @preallocation is specified and equals
> > +# PREALLOC_MODE_ON. The following three scenarios determine how
> > +# creation logic behaves when @preallocation is either equal to
> > +# PREALLOC_MODE_OFF or is not given:
> > +#
> > +#  1) When @file is given only, format the block device referenced
> > +#     by @file as the LUKS specification and trunk it to the @size.
>
> Do you mean "truncate it to @size"?
>
Yes, :( sorry for the spelling mistake.


>
> > +#     In this case, the @size should reflect amount of space made
> > +#     available to the guest, so the trunk size must take account
> > +#     of that which will be used by the crypto header.
> > +#
> > +#  2) When @header is given only, just format the block device
> > +#     referenced by @header as the LUKS specification.
> > +#
> > +#  3) When both @file and @header are given, block device
> > +#     referenced by @file should be trunked to @size, and block
> > +#     device referenced by @header should be formatted as the LUKS
> > +#     specification.
> >  #
> >  # @file: Node to create the image format on, mandatory except when
> >  #        'preallocation' is not requested
>
> Let's see whether I understand.
>
> blockdev-create with "driver": "luks" can work in three different ways:
>
> 1. Create an image with a LUKS header
>
> 2. Create just a detached LUKS header
>
> 3. Create an image and a detached LUKS header
>
> Correct?
>

Yes


> @file and @header are BlockdevRef, which means they refer to existing
> images with arbitrary driver.  Could be "file", "qcow2", or anything.
>
> Correct?
>
Yes


>
> To get 1., specify @file, but not @header.
>
> To get 2., specify @header, but not @file.
>
> To get 3., specify both.
>
> Specifying neither is an error.
>
> Correct?
>

Yes


> In any case, @size is the logical size of the image (how much data it
> can hold).
>

Yes


>
> With 1., the actual image size is a bit larger due to the LUKS header.
> The @file image is resized to that size: if it's shorter, it's grown, if
> it's longer, it's truncated.
>

Yes


> With 2., @size is merely recorded in the detached LUKS header.
>

In LUKS1 specification, payload data size is not contained in the header,
so in this case, @size is not recorded in the detached LUKS header.
The creation logic just does the LUKS header formatting only.


>
> With 3., @size is recorded in the detached LUKS header, and the @file
> image is resized as with 1.
>

Same reason as above, @size is not recorded and @file image is
resized to @size exactly.


>
> Correct?
>
>
Thanks for the comment,

Yong

--=20
Best regards

--000000000000e505fb0611defd5b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 21, 20=
24 at 2:43=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat=
.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Hyman Huan=
g &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang=
@smartx.com</a>&gt; writes:<br>
<br>
&gt; Add comment in detail for commit 433957bb7f (qapi:<br>
&gt; Make parameter &#39;file&#39; optional for<br>
&gt; BlockdevCreateOptionsLUKS).<br>
&gt;<br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qapi/block-core.json | 20 +++++++++++++++++++-<br>
&gt;=C2=A0 1 file changed, 19 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/qapi/block-core.json b/qapi/block-core.json<br>
&gt; index ab5a93a966..42b0840d43 100644<br>
&gt; --- a/qapi/block-core.json<br>
&gt; +++ b/qapi/block-core.json<br>
&gt; @@ -4973,7 +4973,25 @@<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @BlockdevCreateOptionsLUKS:<br>
&gt;=C2=A0 #<br>
&gt; -# Driver specific image creation options for LUKS.<br>
&gt; +# Driver specific image creation options for LUKS. Note that<br>
&gt; +# @file is required if @preallocation is specified and equals<br>
&gt; +# PREALLOC_MODE_ON. The following three scenarios determine how<br>
&gt; +# creation logic behaves when @preallocation is either equal to<br>
&gt; +# PREALLOC_MODE_OFF or is not given:<br>
&gt; +#<br>
&gt; +#=C2=A0 1) When @file is given only, format the block device referenc=
ed<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0by @file as the LUKS specification and trunk it =
to the @size.<br>
<br>
Do you mean &quot;truncate it to @size&quot;?<br></blockquote><div><div cla=
ss=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-se=
rif"></div><div class=3D"gmail_default" style=3D"font-family:&quot;comic sa=
ns ms&quot;,sans-serif">Yes, :( sorry for the spelling mistake.</div></div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:r=
gb(204,204,204);padding-left:1ex">
<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0In this case, the @size should reflect amount of=
 space made<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0available to the guest, so the trunk size must t=
ake account<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0of that which will be used by the crypto header.=
<br>
&gt; +#<br>
&gt; +#=C2=A0 2) When @header is given only, just format the block device<b=
r>
&gt; +#=C2=A0 =C2=A0 =C2=A0referenced by @header as the LUKS specification.=
<br>
&gt; +#<br>
&gt; +#=C2=A0 3) When both @file and @header are given, block device<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0referenced by @file should be trunked to @size, =
and block<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0device referenced by @header should be formatted=
 as the LUKS<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0specification.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @file: Node to create the image format on, mandatory except wh=
en<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;preallocation&#39; is not requ=
ested<br>
<br>
Let&#39;s see whether I understand.<br>
<br>
blockdev-create with &quot;driver&quot;: &quot;luks&quot; can work in three=
 different ways:<br>
<br>
1. Create an image with a LUKS header<br>
<br>
2. Create just a detached LUKS header<br>
<br>
3. Create an image and a detached LUKS header<br>
<br>
Correct?<br></blockquote><div><br></div><div class=3D"gmail_default" style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Yes</div><div class=
=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-seri=
f"><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(2=
04,204,204);padding-left:1ex">
<br>
@file and @header are BlockdevRef, which means they refer to existing<br>
images with arbitrary driver.=C2=A0 Could be &quot;file&quot;, &quot;qcow2&=
quot;, or anything.<br>
<br>
Correct?<br></blockquote><div><div class=3D"gmail_default" style=3D"font-fa=
mily:&quot;comic sans ms&quot;,sans-serif"></div><div class=3D"gmail_defaul=
t" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Yes</div></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color=
:rgb(204,204,204);padding-left:1ex">
<br>
To get 1., specify @file, but not @header.<br>
<br>
To get 2., specify @header, but not @file.<br>
<br>
To get 3., specify both.<br>
<br>
Specifying neither is an error.<br>
<br>
Correct?<br></blockquote><div><br></div><div class=3D"gmail_default" style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Yes</div><div class=
=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-seri=
f"><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(2=
04,204,204);padding-left:1ex">
<br>
In any case, @size is the logical size of the image (how much data it<br>
can hold).<br></blockquote><div><br></div><div><div class=3D"gmail_default"=
 style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Yes</div></div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:r=
gb(204,204,204);padding-left:1ex">
<br>
With 1., the actual image size is a bit larger due to the LUKS header.<br>
The @file image is resized to that size: if it&#39;s shorter, it&#39;s grow=
n, if<br>
it&#39;s longer, it&#39;s truncated.<br></blockquote><div><br></div><div cl=
ass=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-s=
erif">Yes</div><div class=3D"gmail_default" style=3D"font-family:&quot;comi=
c sans ms&quot;,sans-serif"><br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:soli=
d;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
With 2., @size is merely recorded in the detached LUKS header.<br></blockqu=
ote><div><br></div><div class=3D"gmail_default"><div class=3D"gmail_default=
" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">In LUKS1 speci=
fication, payload data size is not contained in the header,</div><div class=
=3D"gmail_default" style=3D"font-family:Arial,Helvetica,sans-serif"><font f=
ace=3D"comic sans ms, sans-serif">so in this case, @size is not recorded in=
 the detached LUKS header.<span class=3D"gmail-Apple-converted-space">=C2=
=A0</span></font></div><div class=3D"gmail_default"><font face=3D"comic san=
s ms, sans-serif">The creation logic just does the LUKS header formatting o=
nly.</font></div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:so=
lid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
With 3., @size is recorded in the detached LUKS header, and the @file<br>
image is resized as with 1.<br></blockquote><div><br></div><div><div class=
=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-seri=
f">Same reason as above, @size is not recorded and=C2=A0@file image is</div=
><div class=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">resi=
zed to @size exactly.=C2=A0</font></div></div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1=
px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:=
1ex">
<br>
Correct?<br>
<br>
</blockquote></div><div><br></div><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif">Thanks for the comment,</div=
><br clear=3D"all"><div><div class=3D"gmail_default" style=3D"font-family:&=
quot;comic sans ms&quot;,sans-serif">Yong</div><br></div><span class=3D"gma=
il_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signatur=
e"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</=
font></div></div></div>

--000000000000e505fb0611defd5b--

