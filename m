Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E31606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XYGdOKGf;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AidJfQ1y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiwz-0005dB-Rr; Tue, 27 Oct 2026 11:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xLiwu-0005cn-DK
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:18:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xLiwq-0001dQ-T2
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793114326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mt0/WI5+v0F3ZzOHEOedFTWJ1W1YxKjDZT/vdANXWio=;
 b=XYGdOKGf3rie9H3sTYvLBYmibHf6vaurTm67lI34Hnn+yI560zKL4e3gnsjzAm9uTUKRhh
 S1TqxMCwkz5D1fr3X4TephGgkEl/g8e6mdqFJGnDcFokuRskTs7uxbRltDlBCktFiB7/Vg
 gtpquSAh8lOjMIQpQoOxQVULoWuZ91A=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-jngUKNDuMhuaLOGPUCT2QQ-1; Tue, 27 Oct 2026 11:18:42 -0400
X-MC-Unique: jngUKNDuMhuaLOGPUCT2QQ-1
X-Mimecast-MFC-AGG-ID: jngUKNDuMhuaLOGPUCT2QQ_1793114321
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso8755235eec.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 08:18:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793114321; cv=none;
 d=google.com; s=arc-20260327;
 b=e/I2HorNarbscP3Ol3xsavfSvP+lVcWbtBSVXFBFQEnFKAOpxkRWCMuqgHNKzE4l1n
 NoGmd4eVVLgL2lqHTgLiBjmQMnFvI9HJ95uFFpRAnIYC4PqSxypjq+MG9Cn03Kz+8vUC
 X7P/MBAjLRfi7m1pRCdKXBpMkfLdFSL2E9zE0go29ZfpuJJmqDj8b64WNICLoS/B9o2n
 drjJzYX/Mi8nPSQ3q/4sevpBEjACytrAH/CkmpDu0ahz5RFowT4LC3parJerVE+N1JKg
 SukrchfzcipDNb/cdudsgbYMSIT5IVT2B1WZO39A7kgCGUxMvKGmsnIfU3w2j523SRpP
 JhmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Mt0/WI5+v0F3ZzOHEOedFTWJ1W1YxKjDZT/vdANXWio=;
 fh=8C66zEw4UC/+J4JLdlwPlRp1KB9eAtvewTdv+LZKEN0=;
 b=cngOKsZiqHoYAPKxHfmK/dXf5DCRgKpoke1mjUy2SnxZyNRgUAlwiDl9qYWlvsZuSb
 OejcoK+Lt+De//Oyit2YUtuhu2pzfdWOO26HLyrgr+JEEQrRkIsJ9rwRfhNSzZoHL0Uq
 jgm3FiwGLTLY1SHDFrSBisgT6g4X0EOY9bZHlsqwy1Iwb/s8eT09sUiziVMrQH42pCMk
 OqhairulfbW4g5dJexpbJceDSaqxxh2XKevw6+JwC1JGOQdCTP5sXDkK2ABSskf7tg0u
 gZVoMdkZHg2zMLRX13bCyWylDuaXVkFzLUwzdorzlEAhb4gAVFc13HlPweSXkZQYDA8T
 Fcqg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793114321; x=1793719121; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Mt0/WI5+v0F3ZzOHEOedFTWJ1W1YxKjDZT/vdANXWio=;
 b=AidJfQ1yBOMw+RYRRxHmO2z9sd75tdUAueKXBqqTEZZDpW2riXrT2p8F9jCurh9LhY
 +Ni3X7tTfYAA3RL3IvG/AiVo9m4Mgkv5c5yGptgalYCfxmxgk3FwkmxvNmAIV3lcbEo+
 nqQyxOS08GB6BSzMZP6CsVzANMqvB6uDiPw3k5HipYER8Upwj5Xne+z/4QCSKPis6A5Y
 ij4uvOT5Iqqg7x/m4WE6LRz8MeAys4cFqJIgTln5MhWiIMdvxKaGu66KqsVR6G3lNIHz
 0syjeFhp5WUppkaHvkn3N+2D8Y9EH+Jxzxh2tjZNdHFa2aMdCymyR4Wdvn3bP/3j1L8E
 1qKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793114321; x=1793719121;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Mt0/WI5+v0F3ZzOHEOedFTWJ1W1YxKjDZT/vdANXWio=;
 b=UcuDHAri3RwycppUD0NpMh+OotRIf5QWPtbzrCX5LiZR1JeiiOTPccyDJCk6/UoxXY
 Mo/msDL+gyn+RFUqH95AY1dLjkvuvUt3iKr8pltQRsSOx3Bskm6ku+0ZeM5oZuJpccco
 Cpnt/q+cz/RtWjsSqW70OsspmPS9ghXRKjtITfwmHMiQpaTOlhsH6PLagfNslqRQyOnR
 Dt0XWmjtrmpjCiO+bSpcqXMzNCZ/dDIMGNUrG2nZNfUEFvPbi1CDZ2dXuMw2YoknCV4Y
 wwS//EzZ+YpP3X9wqOdQgbJ+flFeEcWtwSRMJyKGPYSumnBCQ2xhrJbKbEl1lpmKufD5
 0IFg==
X-Gm-Message-State: AFq9FYIm/oU/kUUBuHQlNisjdzu9kAND/je3BQsGTwCuhZwJwkResVLQ
 BP8BALPWq6aLjSsNXf/2CWPJA5SzacbW+3eANKC+19V4F6hAHBBV0KLaLlxe18KhxXhq6KPSjxN
 cCz0kBCnmaQ70B8I7WyS9Mp3I1AU/vCcj7bZLsAsHFGwuU/3wnSmsf90nZT04Irmq5o/QH9rFHm
 FKOeWbHlicyMcIOzd6NIf8fvZQpvlHpKo=
X-Gm-Gg: AYBFou2ONAAGjhq/ho06k4R8TRhAbcBRiBZuseBBuST+zXlkK12MLrF6qcZr6UcmOfF
 M1Ndk4Okc8S9KaqiJID4yF9KCpvB7Fi7BRoLJ+wqYB1UmtVkFBu6CvkmO0hFpKpa22wGRRl5Enf
 r5bl2RrVksAYqz0JVJE4QJbIoeeAQP2HK15y1lp4Ef+NMUNi4/2VK3k4buNkUiAmtLRHDCn2F5P
 XcqxKo3iDOgml9bNA==
X-Received: by 2002:a05:693c:6091:b0:35f:8c5d:5928 with SMTP id
 5a478bee46e88-369e863c999mr15705066eec.30.1793114320633; 
 Tue, 27 Oct 2026 08:18:40 -0700 (PDT)
X-Received: by 2002:a05:693c:6091:b0:35f:8c5d:5928 with SMTP id
 5a478bee46e88-369e863c999mr15705040eec.30.1793114320090; Tue, 27 Oct 2026
 08:18:40 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260929150100.66035-1-bogorodskiy@gmail.com>
 <atn7ALZqDJw7bGjU@tulp>
In-Reply-To: <atn7ALZqDJw7bGjU@tulp>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 27 Oct 2026 17:18:25 +0200
X-Gm-Features: AclHuK_-EkwC1eETkhYe1JkoM9o9_FqgtdhZXGX2-GZiNob2lcChrQOXt4A1mG4
Message-ID: <CAPMcbCpi=Gzsrkk0HF9nX9HpHicuAP2rmmFKUopykpm6mzSnjg@mail.gmail.com>
Subject: Re: [PATCH v2] tests/unit/test-qga: enable on FreeBSD
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000174d54065ed3f688"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000174d54065ed3f688
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Thu, Oct 22, 2026 at 3:01=E2=80=AFPM Roman Bogorodskiy <bogorodskiy@gmai=
l.com>
wrote:

>   Roman Bogorodskiy wrote:
>
> > FreeBSD has all necessary commands implemented,
> > so enable test-qga for it.
> >
> > Requires only minimal portability fixes for sockets
> > in connect_qga().
> >
> > Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> > Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> > ---
> > Changes since v1:
> >
> >  - Drop SUN_LEN() for 'len' calculation on FreeBSD,
> >    use 'len =3D sizeof(remote)' on all platforms.
> >
> >  tests/unit/meson.build | 2 +-
> >  tests/unit/test-qga.c  | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
>
> ping?
>
>

--000000000000174d54065ed3f688
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br clear=3D"all"></div>Reviewed-by: Kostiantyn Kosti=
uk &lt;<a href=3D"mailto:kkostiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</=
div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Thu, Oct 22, 2026 at 3:01=E2=80=AFPM Roman Bogorodsk=
iy &lt;<a href=3D"mailto:bogorodskiy@gmail.com">bogorodskiy@gmail.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0=
 Roman Bogorodskiy wrote:<br>
<br>
&gt; FreeBSD has all necessary commands implemented,<br>
&gt; so enable test-qga for it.<br>
&gt; <br>
&gt; Requires only minimal portability fixes for sockets<br>
&gt; in connect_qga().<br>
&gt; <br>
&gt; Signed-off-by: Roman Bogorodskiy &lt;<a href=3D"mailto:bogorodskiy@gma=
il.com" target=3D"_blank">bogorodskiy@gmail.com</a>&gt;<br>
&gt; Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.=
com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt; Changes since v1:<br>
&gt; <br>
&gt;=C2=A0 - Drop SUN_LEN() for &#39;len&#39; calculation on FreeBSD,<br>
&gt;=C2=A0 =C2=A0 use &#39;len =3D sizeof(remote)&#39; on all platforms.<br=
>
&gt; <br>
&gt;=C2=A0 tests/unit/meson.build | 2 +-<br>
&gt;=C2=A0 tests/unit/test-qga.c=C2=A0 | 4 ++--<br>
&gt;=C2=A0 2 files changed, 3 insertions(+), 3 deletions(-)<br>
<br>
ping?<br>
<br>
</blockquote></div>

--000000000000174d54065ed3f688--


