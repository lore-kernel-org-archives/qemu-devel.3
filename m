Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2064CCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 10:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urDoh-0005CJ-3g; Wed, 27 Aug 2025 06:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1urDof-0005BQ-2z
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:55:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1urDod-0005H9-10
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756292138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GFX/eBrYG/fm31q244hTyzvDZ7JSl0+5R9/USrbR2Ts=;
 b=D0JUSEDPZjk7FkKbwaz47N4KUu2Z0vJ8QgZXMkIsmZV+57Psj4AURMWeZWW7Y5lu/E/mEM
 Dif5UrXpUfAwIl7SPgAuTMXjomsDLBkNMg1fkHDOz6vzmXH6jaEvN4uSms8jHnkVLY75sf
 kEhJFEdgukIuhj5DK9TmBxQmUgzaR2Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-t0AawVJXPHqO-Kl0GmV-pA-1; Wed, 27 Aug 2025 06:51:33 -0400
X-MC-Unique: t0AawVJXPHqO-Kl0GmV-pA-1
X-Mimecast-MFC-AGG-ID: t0AawVJXPHqO-Kl0GmV-pA_1756291892
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-70ba7aa13c3so231529636d6.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 03:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756291892; x=1756896692;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GFX/eBrYG/fm31q244hTyzvDZ7JSl0+5R9/USrbR2Ts=;
 b=bbQTHYnF+F7Szk/c+EmQe7EchgI4vG0lPbq8tC9cisLnPcRv9hE4Bzwf/gBSc3tdHz
 AGGFI4E79xNXYdHWQfhG5LH5Y7WsJLF01xCoXx15KWPfXzRw1ZvRQei8zz6vcp2Z8x6q
 Ckc7fEl466LBXiJNdr1yn+cFOQvxnR0unIcIhDD/96gWr9kWZKb//wW0AyybEx+z1PZ+
 gfNemm+4mOnDK4sW0AEJtsPOkF68wN/3OWNCV26C0FYPeHR7/xA4BKppLcb3KkqxAkD2
 Qv/7zZ7nZ6o0E+Sp5ZIWBS+ee/M91kqF+PMHTwulwIWGor4ZMkwbwXT/nPL+1eeV7zMb
 Sj2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYxA4TF8Mi6E6nyj4fHpkIlF7HyHDGjw5OAH40CkHY5belpS70WMP7PrDAVy40BVredCAEAJJOK/JW@nongnu.org
X-Gm-Message-State: AOJu0Yz+A8q/IofmO5tWCGfTNpMzAO+l4cfiQbCX8MpExoxyc4Pbgaa9
 IkIWlQqocuQt8P8vUhsRagSpXSEQgCMytTk0RwEXcn7PxjwycSx40KThR5lLmYTJ+7sQCP4uhSb
 VvKpHeAXGjTMywnRWmFoAuCTdFSq2yvdiqIoDZ6k6Nz6NMDHJR/4l2Q6XCuMnucaU0SY8m+Rtep
 lMFiUCC31vrJKhrAicu4V7E3zCZJ2q+AU=
X-Gm-Gg: ASbGncvrrgKF2u7KTa7+tqOqIN8T7FHIXMCBO0fjl4nhTWwDHZ4Z+vdo4opopfifFPm
 azbkJAvwKIf+NuawzGJEbLSoCF0nxFMv1PAwTKpLDu/vg6wEBrf1CwdOao/yqxKtK9+oFfhlNFW
 o2Lvse+Z1CbQ9gwP9iJzSrx8U=
X-Received: by 2002:a05:6214:2aaf:b0:707:5273:9dd2 with SMTP id
 6a1803df08f44-70d97236dcbmr252817356d6.45.1756291892487; 
 Wed, 27 Aug 2025 03:51:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI9ShCG0e/EBldHe+j2F1YHxPfJs1IeH7lZqUIyDeQ4uimOElm1KHlGrlJt4Otw9lJtgIs1BLYxTiRmwfGkuk=
X-Received: by 2002:a05:6214:2aaf:b0:707:5273:9dd2 with SMTP id
 6a1803df08f44-70d97236dcbmr252817156d6.45.1756291891987; Wed, 27 Aug 2025
 03:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250711021714.91258-1-minglei.liu@smartx.com>
 <aHDRGHuLYG4sQY7-@redhat.com>
In-Reply-To: <aHDRGHuLYG4sQY7-@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Wed, 27 Aug 2025 13:51:20 +0300
X-Gm-Features: Ac12FXyiWRwJmsnCgL7kHXDH4-aEgmQxJ5s7pheXQnmNV_uKFx58zKRUVthFlwI
Message-ID: <CAPMcbCruCzfg2yAzOGhWrUj=KJS_6W7oaL8n1aXTiXz84oUaEg@mail.gmail.com>
Subject: Re: [PATCH] qga: Fix truncated output handling in guest-exec status
 reporting
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Minglei Liu <minglei.liu@smartx.com>, qemu-devel@nongnu.org, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000005824a5063d569235"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000005824a5063d569235
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

Best Regards,
Kostiantyn Kostiuk.


On Fri, Jul 11, 2025 at 11:53=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com>
wrote:

> On Fri, Jul 11, 2025 at 10:17:14AM +0800, Minglei Liu wrote:
> > From: "minglei.liu" <minglei.liu@smartx.com>
> >
>
> Fixes: a1853dca743
>
> Broken since day 1 :-(
>
> > Signed-off-by: minglei.liu <minglei.liu@smartx.com>
> > ---
> >  qga/commands.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
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

--0000000000005824a5063d569235
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;<div dir=3D"ltr"><div><br clear=
=3D"all"></div><div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"=
ltr"><div>Best Regards,</div><div>Kostiantyn Kostiuk.</div></div></div></di=
v><br></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Jul 11, 2025 at 11:53=E2=80=AFAM Dani=
el P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">On Fri, Jul 11, 2025 at 10:17:14AM +0800, Minglei Liu wrote:<br>
&gt; From: &quot;minglei.liu&quot; &lt;<a href=3D"mailto:minglei.liu@smartx=
.com" target=3D"_blank">minglei.liu@smartx.com</a>&gt;<br>
&gt;<br>
<br>
Fixes: a1853dca743<br>
<br>
Broken since day 1 :-(<br>
<br>
&gt; Signed-off-by: minglei.liu &lt;<a href=3D"mailto:minglei.liu@smartx.co=
m" target=3D"_blank">minglei.liu@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qga/commands.c | 6 ++++--<br>
&gt;=C2=A0 1 file changed, 4 insertions(+), 2 deletions(-)<br>
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

--0000000000005824a5063d569235--


