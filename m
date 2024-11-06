Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DD9D59F52
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 16:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8jAk-0004Wo-A6; Wed, 06 Nov 2024 11:46:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t8jAi-0004Wf-D6
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 11:46:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t8jAg-0007cn-EM
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 11:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730911577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BbMa3jREDJCZr08qM4t5oMx0g16cJ9q1VF1WlaWTIfc=;
 b=cY+IxXSb2cIPAeMHwndBsufeb6VjSdEY3FebYTAURRsYHUQnwD1tQ71O6gVnCzkurYMU97
 uRCYykiFSFIXXQTFmMycrWfX0NhoUOX0opS6H5NS36VaqZi3MDjAaLrIqa0wD5g7Nn7zwL
 0s+T2pcaNPDfyk/jYa6ceKr0t8759C0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-e9QRgzehPla8HbYYF7myyA-1; Wed, 06 Nov 2024 11:45:06 -0500
X-MC-Unique: e9QRgzehPla8HbYYF7myyA-1
X-Mimecast-MFC-AGG-ID: e9QRgzehPla8HbYYF7myyA
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6cbf76b01deso101573786d6.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 08:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730911505; x=1731516305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BbMa3jREDJCZr08qM4t5oMx0g16cJ9q1VF1WlaWTIfc=;
 b=D/pFK8eeXnztgOwjHDdTnWsOD4YTuVzNSpbxow5Ta65FrziuhrxKhkIApJEOVa6wK1
 ZRtQNMzm5vRc8afKrrdpBCtvb29XsGMOI3bMy2L67YOE+BupfdAYFziFAlFpmnz4uEnE
 oE4xIiJNUKnR0j2UD10tk50xRKSMTQL63L8PAP5JAIfxAMFCb1h2iyNS3ToxY3TZJ3Pz
 OjVccvEG6k6XzudBew8Q78nkFVTa3IdvOQ3480hyxJLosYp4f3x1QTIvleRRFlJv75be
 u4tzN9zVo7C4lcz6N3DglHa1OGc0VEXlz6ExMUIuUBFshv4MxAdtJgK3gE5a//TVvV9K
 J4Dw==
X-Gm-Message-State: AOJu0YwHbHKqvHTT68ob2qLdJehf56uxrY0xkRy+Aei1h7/gEtHEHr5B
 CpvLzDbIfMqDyJK+LuZvUzqkaK+ReR6I+6WsEAjevQGLYkankTtYXJKEBLW0OB8s9i41vGiLlC3
 0EA5htGnIg2OwKKeF+RqJguyjb9C3ucpPVGrM/9zT4fGxlmLGHiyYNCrmJRUIgNgQnQndYsseQ5
 8MkD6yrFgvZg7+Fhmxds8QepG4ut1I8Qr1N8BRbw==
X-Received: by 2002:a05:6214:d64:b0:6d3:67df:5f97 with SMTP id
 6a1803df08f44-6d367df5fd5mr300280036d6.7.1730911505397; 
 Wed, 06 Nov 2024 08:45:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzNKexrPf8Y8LD/I6n2Qx3bVRelq+e58OpsUVsFMWPwJPWReG2cC5tIhedBv7Q9N7KbwiB73/+dXUtcOjuPsw=
X-Received: by 2002:a05:6214:d64:b0:6d3:67df:5f97 with SMTP id
 6a1803df08f44-6d367df5fd5mr300279646d6.7.1730911505138; Wed, 06 Nov 2024
 08:45:05 -0800 (PST)
MIME-Version: 1.0
References: <20241106084134.1133061-1-demeng@redhat.com>
 <20241106084134.1133061-4-demeng@redhat.com>
 <ZytxOoOft042eG1z@redhat.com>
In-Reply-To: <ZytxOoOft042eG1z@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 6 Nov 2024 18:44:54 +0200
Message-ID: <CAPMcbCpZzw2BTSNxMLobjWXsa3M8vc5o_szm1VqGBjgj8nrUkQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] qemu-ga: Avoiding freeing line prematurely
To: qemu-devel@nongnu.org
Cc: Dehan Meng <demeng@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 michael.roth@amd.com, peter.maydell@linaro.org
Content-Type: multipart/alternative; boundary="00000000000066dc460626413db9"
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

--00000000000066dc460626413db9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Wed, Nov 6, 2024 at 3:38=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:

> On Wed, Nov 06, 2024 at 04:41:34PM +0800, Dehan Meng wrote:
> > It's now only freed at the end of the function.
> >
> > Signed-off-by: Dehan Meng <demeng@redhat.com>
> > ---
> >  qga/commands-linux.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
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

--00000000000066dc460626413db9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 6=
, 2024 at 3:38=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:ber=
range@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">On Wed, Nov 06, 2024 at 04:41:34PM +08=
00, Dehan Meng wrote:<br>
&gt; It&#39;s now only freed at the end of the function.<br>
&gt; <br>
&gt; Signed-off-by: Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com" tar=
get=3D"_blank">demeng@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qga/commands-linux.c | 7 ++-----<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 5 deletions(-)<br>
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
</blockquote></div>

--00000000000066dc460626413db9--


