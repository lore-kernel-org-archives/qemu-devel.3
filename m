Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D9CC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNuW-0008AV-6B; Wed, 12 Jun 2024 09:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sHNuT-00088K-8B
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:21:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sHNuR-0003rE-9C
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718198462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pHdsPNAWcVJIzb9QuwSNLCuS5KB7zsIyO0VsDiuIkRI=;
 b=JK9Irquou3nae3Eh7vT6Nexj2ZhmuW6ZDfRGScarBpcbmmmJlM2XLADj5dDyPOD4PvOXMp
 59zt3PvzAXu0Xv4VdS439o//yeOc49qI3dZmuzdATzQxuuJyJ+FXNYItKQ9Fksef+073zH
 4qErknXGja/L67gpMaNE/kRzATH/ayQ=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-j3sHuW2aPBCB3cSA1OICZA-1; Wed, 12 Jun 2024 09:21:00 -0400
X-MC-Unique: j3sHuW2aPBCB3cSA1OICZA-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5bad4f46273so3322754eaf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 06:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718198459; x=1718803259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pHdsPNAWcVJIzb9QuwSNLCuS5KB7zsIyO0VsDiuIkRI=;
 b=fXqg9/FWoZ7s7R/ZGmzvnJfNbx38GGbbsdef/O1NId/cqc3g6DZA79VsTVNEeIgfkW
 ZP3a6PSBWlq3MnF8Q12TUpFCy1r0TRKfMWrOWfZSjnZ0x6cyP2YPjy1ZteC+aTyrDyUC
 qUQojx+zb4nDUGO/kpB6Lp5jyy8P3eksUqBwjCldCk6yFf7Uupyp2YNSusj8ZOwIysjV
 FC/+/AYI5JopGXThaJbiJgEud09rC1o8eNVDBMN6tsa9gpH4sA8eJS/SE/oFR74ZYIVA
 oRkkkuIdstBa037+jf2KzuOF26NKOQjKb+JXVMFrG58oy85RA9Bfd0/Movu4/oox2DFK
 4UUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa0xk93HstKExljN7/s5O7vMANeitpOiWjCX6HTepNDO2M9Z8jue5YvdjqwlbtBUDWamqQoWYLQyjFxxOP4r73kkim6Ks=
X-Gm-Message-State: AOJu0YwDBqewZn8NEKhy8dAcrcEUoL0lMnq3ZPVw2IuDkeUAfv1+RLW7
 kM5P+5Y910WKkDMz13h7mCfHzBJcmnOO3BrjRal4Jm1cTHZPphqZGcZDSLGUG9hsSRFG46S9Pf/
 1Rx1uDeYSdxEakrV7McxcTxo5D3zzweMYPT34XS+Qr+wB4uZPmGkI+U+T3beMgKIcwXKhkVqvd7
 hgDlciiLHdsFzjU2WlO7Kbx4tagPQ=
X-Received: by 2002:a05:6820:1acc:b0:5b9:fc9f:6a6c with SMTP id
 006d021491bc7-5bb3b7a4c5dmr1799407eaf.0.1718198459525; 
 Wed, 12 Jun 2024 06:20:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAGDyOINNFuZYsllcJcsqHxev4tFl+S3OLnyTU9PbmnBRrRUXRf57tqys9Wr/BZGDKwlsgmlZxptT93HfBoDU=
X-Received: by 2002:a05:6820:1acc:b0:5b9:fc9f:6a6c with SMTP id
 006d021491bc7-5bb3b7a4c5dmr1799386eaf.0.1718198458998; Wed, 12 Jun 2024
 06:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240612103105.301456-1-demeng@redhat.com>
 <20240612103105.301456-2-demeng@redhat.com>
 <6e00233e-63ab-4513-aa0f-c55ab4ef0747@linaro.org>
 <ZmmaIzYPUlQTF7DK@redhat.com>
In-Reply-To: <ZmmaIzYPUlQTF7DK@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 12 Jun 2024 16:20:47 +0300
Message-ID: <CAPMcbCpuA06_aqA=z=aOLHOQ9Z2opQNDQEUYXzCE5fGopv3mCg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] qga/linux: Add new api 'guest-network-get-route'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Dehan Meng <demeng@redhat.com>, qemu-devel@nongnu.org, michael.roth@amd.com
Content-Type: multipart/alternative; boundary="000000000000cd7da9061ab14051"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

--000000000000cd7da9061ab14051
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel and Philippe

Is it ok to add the version filed to the GuestNetworkRoute struct
to indicate that this is an IPv4 or an IPv6 route or is it better to have
two
different structures?

Best Regards,
Konstantin Kostiuk.


On Wed, Jun 12, 2024 at 3:53=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Wed, Jun 12, 2024 at 02:48:24PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Hi Dehan,
> >
> > On 12/6/24 12:31, Dehan Meng wrote:
> > > The Route information of the Linux VM needs to be used
> > > by administrators and users when debugging network problems
> > > and troubleshooting.
> > >
> > > Signed-off-by: Dehan Meng <demeng@redhat.com>
> > > ---
> > >   qga/commands-posix.c | 81
> ++++++++++++++++++++++++++++++++++++++++++++
> > >   qga/commands-win32.c |  6 ++++
> > >   qga/qapi-schema.json | 56 ++++++++++++++++++++++++++++++
> > >   3 files changed, 143 insertions(+)
> >
> >
> > > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > > index b3de1fb6b3..58f51aecbb 100644
> > > --- a/qga/qapi-schema.json
> > > +++ b/qga/qapi-schema.json
> > > @@ -1800,3 +1800,59 @@
> > >   { 'command': 'guest-get-cpustats',
> > >     'returns': ['GuestCpuStats']
> > >   }
> > > +
> > > +##
> > > +# @GuestNetworkRoute:
> > > +#
> > > +# Route information, currently, only linux supported.
> > > +#
> > > +# @iface: The destination network or host's egress network interface
> in the routing table
> > > +#
> > > +# @destination: The IP address of the target network or host, The
> final destination of the packet
> >
> > Maybe clearer to start naming this @ipv4 in case you plan @ipv6
> > support later (see @NetdevUserOptions structure in qapi/net.json).
>
> IMHO IPv6 must be supported from the start - it really isn't acceptable
> to write new IPv4 only code today.
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--000000000000cd7da9061ab14051
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Daniel and Philippe</div><div><br></div><div>Is it=
 ok to add the version filed to the GuestNetworkRoute struct</div><div>to i=
ndicate that this is an IPv4 or an IPv6 route or is it better to have two</=
div><div>different structures? <br></div><div><br></div><div><div><div dir=
=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div =
dir=3D"ltr"><div>Best Regards,</div><div>Konstantin Kostiuk.</div></div></d=
iv></div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Wed, Jun 12, 2024 at 3:53=E2=80=AFPM Daniel P. Berran=
g=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On We=
d, Jun 12, 2024 at 02:48:24PM +0200, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; Hi Dehan,<br>
&gt; <br>
&gt; On 12/6/24 12:31, Dehan Meng wrote:<br>
&gt; &gt; The Route information of the Linux VM needs to be used<br>
&gt; &gt; by administrators and users when debugging network problems<br>
&gt; &gt; and troubleshooting.<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com=
" target=3D"_blank">demeng@redhat.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 =C2=A0qga/commands-posix.c | 81 +++++++++++++++++++++++++++=
+++++++++++++++++<br>
&gt; &gt;=C2=A0 =C2=A0qga/commands-win32.c |=C2=A0 6 ++++<br>
&gt; &gt;=C2=A0 =C2=A0qga/qapi-schema.json | 56 +++++++++++++++++++++++++++=
+++<br>
&gt; &gt;=C2=A0 =C2=A03 files changed, 143 insertions(+)<br>
&gt; <br>
&gt; <br>
&gt; &gt; diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
&gt; &gt; index b3de1fb6b3..58f51aecbb 100644<br>
&gt; &gt; --- a/qga/qapi-schema.json<br>
&gt; &gt; +++ b/qga/qapi-schema.json<br>
&gt; &gt; @@ -1800,3 +1800,59 @@<br>
&gt; &gt;=C2=A0 =C2=A0{ &#39;command&#39;: &#39;guest-get-cpustats&#39;,<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&#39;returns&#39;: [&#39;GuestCpuStats&#39;]<b=
r>
&gt; &gt;=C2=A0 =C2=A0}<br>
&gt; &gt; +<br>
&gt; &gt; +##<br>
&gt; &gt; +# @GuestNetworkRoute:<br>
&gt; &gt; +#<br>
&gt; &gt; +# Route information, currently, only linux supported.<br>
&gt; &gt; +#<br>
&gt; &gt; +# @iface: The destination network or host&#39;s egress network i=
nterface in the routing table<br>
&gt; &gt; +#<br>
&gt; &gt; +# @destination: The IP address of the target network or host, Th=
e final destination of the packet<br>
&gt; <br>
&gt; Maybe clearer to start naming this @ipv4 in case you plan @ipv6<br>
&gt; support later (see @NetdevUserOptions structure in qapi/net.json).<br>
<br>
IMHO IPv6 must be supported from the start - it really isn&#39;t acceptable=
<br>
to write new IPv4 only code today.<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div>

--000000000000cd7da9061ab14051--


