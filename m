Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCD3E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 12:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNsul-0000ND-Bi; Wed, 18 Dec 2024 07:12:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tNsuk-0000N4-Q5
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 07:12:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tNsuc-0000eT-Qw
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 07:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734523940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N/mi+1bQY3qqkA88d/JAY07Tvq6N7JGdcSvyKVYdhfk=;
 b=jHVAOm1sPswiVZZhWZg/gvwXP16qyCttg6ii4vIwbSOWEeKR+zONtIp82qAgcLL4gW9Yjy
 Wo69qPahQmbkKEAMdJ2Jyk0d5yCE8Ll3lVsSRlWic8P5uVS1aRQoGtfmxORp0rg1jcHLHp
 1mxY6gz4nd8+x1f9Xr7lo/hRt01P+3Y=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-2a80CjnkMb-QbVnMOk095g-1; Wed, 18 Dec 2024 07:12:19 -0500
X-MC-Unique: 2a80CjnkMb-QbVnMOk095g-1
X-Mimecast-MFC-AGG-ID: 2a80CjnkMb-QbVnMOk095g
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d8edc021f9so109949646d6.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 04:12:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734523939; x=1735128739;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N/mi+1bQY3qqkA88d/JAY07Tvq6N7JGdcSvyKVYdhfk=;
 b=uttJIeakHyaUQZRmbL9N8VWt4x+vQiZGBwjT5o03/PRqR9UA2SBs97z2H/ynWr6Wnl
 3r/dTeG8TZv+HfkGvokKAzEg3UiCDRsvPa9zpD/LrMo/pgnInSDDuqU3wL3YB/5JxmB2
 LmI9/CZvAn2X9RgAt3JsA0f+b/nIJspBYU6GOm6PX98otnzjgxX93Hp9HeYztKv6DG13
 4doz/nz+jVR8qEnve0b2OPR1ya+X89P9DytgdsSbFtCLrLdEEcJtRgxeI542mfZvdHuz
 f5T9LDxmlX7Cwd+4Z8TCd5xS9t8dDTmk+d9YI2hpTgDb2JhUiXc/VFO45iDB/ubC4HhU
 E6Gg==
X-Gm-Message-State: AOJu0YzcExfL3SFONIe9Whr+vszLER2jXRs1A4e56pTkhJTe89prV7h8
 Qxfu8w2cc8FMGvozTtVRjmocvVMf8Pf6OP+1XE9PuzVeRERR0VyTU+mDavNI4UW6P3Pu3c/1QAK
 vXQyND5xYp3OfUQNUv8eXgkie7MgHseN1iHSOZNY1hOhuiyJ9+l6LSa4MoBpy8VZnt70mmsVzcx
 HhznBIb5ZMiJn3p+MNpo11q84zVzY=
X-Gm-Gg: ASbGncu9P5ZMODTw67muKR46z5b4Gwgu9dlIgS0j8sd+5MnpzLkzwkD4tvAonrXlbSp
 jyqAfHsLWTJevG/33LV18Nz+2XGX6/e9YXYntKjcs
X-Received: by 2002:ad4:5ae9:0:b0:6d8:7efe:f791 with SMTP id
 6a1803df08f44-6dd091ac3e0mr51989826d6.18.1734523938867; 
 Wed, 18 Dec 2024 04:12:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSZW9pjRunNmw9gsVEdmBZE2LiBUOeB7N5XUFX4PrAeXu5g5rAbjRy/FTPOXVyJhxIa5q+0iXVlfn65mdeUyE=
X-Received: by 2002:ad4:5ae9:0:b0:6d8:7efe:f791 with SMTP id
 6a1803df08f44-6dd091ac3e0mr51989556d6.18.1734523938584; Wed, 18 Dec 2024
 04:12:18 -0800 (PST)
MIME-Version: 1.0
References: <20241218120321.34998-1-kkostiuk@redhat.com>
 <Z2K6_ftN9J2Uo4pV@redhat.com>
In-Reply-To: <Z2K6_ftN9J2Uo4pV@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 18 Dec 2024 14:12:06 +0200
Message-ID: <CAPMcbCoyzSPJHk0J76A5Q_HZm2gfsS7KAWC4ddUV5n02pKxOgw@mail.gmail.com>
Subject: Re: [PULL 0/3] Misc QGA patches for 2024-12-18
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000036cf1406298a53f3"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

--00000000000036cf1406298a53f3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Sorry, I just missed it.
I will send one more PR in a few days and include it.

Best Regards,
Konstantin Kostiuk.


On Wed, Dec 18, 2024 at 2:07=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> Any reason this skipped inclusion of my patch:
>
>   Subject: [PATCH] qga: implement a 'guest-get-load' command
>
> which you already acked ?
>
> On Wed, Dec 18, 2024 at 02:03:18PM +0200, Konstantin Kostiuk wrote:
> > The following changes since commit
> 8032c78e556cd0baec111740a6c636863f9bd7c8:
> >
> >   Merge tag 'firmware-20241216-pull-request' of
> https://gitlab.com/kraxel/qemu into staging (2024-12-16 14:20:33 -0500)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/kostyanf14/qemu.git tags/qga-pull-2024-12-18
> >
> > for you to fetch changes up to 2657a92b5479c8705b128ed1e55feb8960ed498a=
:
> >
> >   qga: Don't access global variable in run_agent_once() (2024-12-18
> 13:46:16 +0200)
> >
> > ----------------------------------------------------------------
> > qga-pull-2024-12-18
> >
> > ----------------------------------------------------------------
> > Dehan Meng (1):
> >       qemu-ga-win: Fix a typo error
> >
> > Jean-Louis Dupond (1):
> >       qga: skip bind mounts in fs list
> >
> > Michal Privoznik (1):
> >       qga: Don't access global variable in run_agent_once()
> >
> >  qga/commands-linux.c | 25 +++++++++++++++++++++++++
> >  qga/commands-win32.c |  2 +-
> >  qga/main.c           |  2 +-
> >  3 files changed, 27 insertions(+), 2 deletions(-)
> >
> > --
> > 2.47.1
> >
> >
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

--00000000000036cf1406298a53f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Daniel,</div><div><br></div><div>Sorry, I just mis=
sed it.</div><div>I will send one more PR in a few days and include it.<br>=
</div><div><br clear=3D"all"></div><div><div dir=3D"ltr" class=3D"gmail_sig=
nature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regar=
ds,</div><div>Konstantin Kostiuk.</div></div></div></div><br></div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 18=
, 2024 at 2:07=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:ber=
range@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">Any reason this skip=
ped inclusion of my patch:<br>
<br>
=C2=A0 Subject: [PATCH] qga: implement a &#39;guest-get-load&#39; command<b=
r>
<br>
which you already acked ?<br>
<br>
On Wed, Dec 18, 2024 at 02:03:18PM +0200, Konstantin Kostiuk wrote:<br>
&gt; The following changes since commit 8032c78e556cd0baec111740a6c636863f9=
bd7c8:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0Merge tag &#39;firmware-20241216-pull-request&#39; of <a h=
ref=3D"https://gitlab.com/kraxel/qemu" rel=3D"noreferrer" target=3D"_blank"=
>https://gitlab.com/kraxel/qemu</a> into staging (2024-12-16 14:20:33 -0500=
)<br>
&gt; <br>
&gt; are available in the Git repository at:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0<a href=3D"https://github.com/kostyanf14/qemu.git" rel=3D"=
noreferrer" target=3D"_blank">https://github.com/kostyanf14/qemu.git</a> ta=
gs/qga-pull-2024-12-18<br>
&gt; <br>
&gt; for you to fetch changes up to 2657a92b5479c8705b128ed1e55feb8960ed498=
a:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0qga: Don&#39;t access global variable in run_agent_once() =
(2024-12-18 13:46:16 +0200)<br>
&gt; <br>
&gt; ----------------------------------------------------------------<br>
&gt; qga-pull-2024-12-18<br>
&gt; <br>
&gt; ----------------------------------------------------------------<br>
&gt; Dehan Meng (1):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu-ga-win: Fix a typo error<br>
&gt; <br>
&gt; Jean-Louis Dupond (1):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qga: skip bind mounts in fs list<br>
&gt; <br>
&gt; Michal Privoznik (1):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qga: Don&#39;t access global variable in run=
_agent_once()<br>
&gt; <br>
&gt;=C2=A0 qga/commands-linux.c | 25 +++++++++++++++++++++++++<br>
&gt;=C2=A0 qga/commands-win32.c |=C2=A0 2 +-<br>
&gt;=C2=A0 qga/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<=
br>
&gt;=C2=A0 3 files changed, 27 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; --<br>
&gt; 2.47.1<br>
&gt; <br>
&gt; <br>
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

--00000000000036cf1406298a53f3--


