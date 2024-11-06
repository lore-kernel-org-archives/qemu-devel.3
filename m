Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6418D59F53
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 16:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8j9P-0003Um-PJ; Wed, 06 Nov 2024 11:44:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t8j9O-0003UW-5n
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 11:44:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t8j9M-0007Jb-59
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 11:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730911495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mexpvllo14QsOMaLo+k9vHhQfbmJo9eYEUNcwCrTCSk=;
 b=Y//hfhtvILh/EOZHhlx0gjZbaO+KzYDwdRvlqmXkpxfkzbrbWlJxd5xLtzLPP7QlqFRofG
 V23sXTB1QNfw5dM5BEe2PsutAZ+2frIDFz13Hcl8gSzRNFM4EquWbP6RzVmcbS99ohR/oz
 PFvPSYzTDm6hvmEfd+fh7sSAi0OZjKA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-q3mXcduWObK7TAJz53g5qw-1; Wed, 06 Nov 2024 11:44:53 -0500
X-MC-Unique: q3mXcduWObK7TAJz53g5qw-1
X-Mimecast-MFC-AGG-ID: q3mXcduWObK7TAJz53g5qw
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3e60dde7f62so47243b6e.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 08:44:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730911493; x=1731516293;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mexpvllo14QsOMaLo+k9vHhQfbmJo9eYEUNcwCrTCSk=;
 b=tBdJUSZqSIx8Gm+t0gF4EKFdkrLhC+BHjrzlDwfJQg8CMoNOlM6NS1NKLFggooeqWr
 3ObZzhFE6Po2NSawzpSB1KC5RQofcExkwjyoF6rc4Ni78YmZgprhttm3D4qvMNCynybj
 D+mb/mmzYh7+CuoVc98zXTf3t/IdGWhNu58jzawC5Q9rEhJ8jH5PrOXqn3Vo8v7F+Yz+
 +b5L6gr8Mo7mmejq1ymrvvHP/c0/1dJqEeX1dNJkel9xzP5rMUVsZ6IGvXclh+tZ5oUd
 BVGVORlhadSD1FiU+oi7jr16JaF7TxAEAdxU0PzZP32e6CtocQPE7B/CEQFupONRH6AF
 sQpQ==
X-Gm-Message-State: AOJu0YwmV/+7/ZbvvKbLrdSpaZ18FLNoJiiied9laBzWzEACqyZq2MS4
 NiqqmERC4URvPLsVofjisSVGhMQe0Z/BYHSPwdwsgRLq6BCpGSNMNqizOBtmDwoMa98yTSyOwQl
 Lk3VM1qtoLdWiXHulZauSJESI4G88+KxlZsEbaakrqiT5cCfYlLbC/v+/jex5gFVA8BI19OVF+p
 Ul33sCbJsiLg6DphM4d7lHIYRGkflQUHoTeO4uhg==
X-Received: by 2002:a05:6808:318e:b0:3e3:e3ae:b774 with SMTP id
 5614622812f47-3e758ce93d0mr20323898b6e.36.1730911492972; 
 Wed, 06 Nov 2024 08:44:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEG2MKL+uW9aGS6qV/XvJjrunRjj9hj9Iy8f09wV76ScRAVmHPXD9L+EvUsCw4DSWS2GPpJHO7VXUJHtGukvBQ=
X-Received: by 2002:a05:6808:318e:b0:3e3:e3ae:b774 with SMTP id
 5614622812f47-3e758ce93d0mr20323869b6e.36.1730911492672; Wed, 06 Nov 2024
 08:44:52 -0800 (PST)
MIME-Version: 1.0
References: <20241106084134.1133061-1-demeng@redhat.com>
 <20241106084134.1133061-3-demeng@redhat.com>
 <Zytw1kwZhKb_zX5S@redhat.com>
In-Reply-To: <Zytw1kwZhKb_zX5S@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 6 Nov 2024 18:44:42 +0200
Message-ID: <CAPMcbCq_CpXH0JqjKPaJnzxTtD2K=9T1BJG0CBW7nYVKQ7JDtA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] qemu-ga: Optimize var declaration and definition
To: qemu-devel@nongnu.org
Cc: Dehan Meng <demeng@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 michael.roth@amd.com, peter.maydell@linaro.org
Content-Type: multipart/alternative; boundary="000000000000a8a1400626413c4a"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, HTML_OBFUSCATE_05_10=0.26, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--000000000000a8a1400626413c4a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Wed, Nov 6, 2024 at 3:36=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:

> On Wed, Nov 06, 2024 at 04:41:33PM +0800, Dehan Meng wrote:
> > Variable declarations moved to the beginning of blocks
> > Followed the coding style of using snake_case for variable names.
> > Proper initialization of param 'size_t n' to '0' for
> >
> > Signed-off-by: Dehan Meng <demeng@redhat.com>
> > ---
> >  qga/commands-linux.c | 43 +++++++++++++++++++------------------------
> >  1 file changed, 19 insertions(+), 24 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
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

--000000000000a8a1400626413c4a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a hr=
ef=3D"mailto:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>=
&gt;</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Wed, Nov 6, 2024 at 3:36=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a h=
ref=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, Nov 06, 2024 =
at 04:41:33PM +0800, Dehan Meng wrote:<br>
&gt; Variable declarations moved to the beginning of blocks<br>
&gt; Followed the coding style of using snake_case for variable names.<br>
&gt; Proper initialization of param &#39;size_t n&#39; to &#39;0&#39; for<b=
r>
&gt; <br>
&gt; Signed-off-by: Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com" tar=
get=3D"_blank">demeng@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qga/commands-linux.c | 43 +++++++++++++++++++-------------------=
-----<br>
&gt;=C2=A0 1 file changed, 19 insertions(+), 24 deletions(-)<br>
<br>
Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.=
com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
<br>
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
</blockquote></div></div>

--000000000000a8a1400626413c4a--


