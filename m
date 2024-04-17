Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93358C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 19:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxB0o-0003Zz-Ra; Wed, 17 Apr 2024 15:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1rxB0l-0003ZN-2m
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 15:32:04 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1rxB0f-0002Zs-EE
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 15:32:01 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1e86333bbe9so1355ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1713382314; x=1713987114; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xpRlvm3zq19Wnwz8plVPrkl3/j00gqXDJ5eWHYKOHWI=;
 b=rARUYUsVVyaTAYr5ZXr3LW0ifDopiSgxISZnNHj0xlB5LwoX/AvZZO73nG2tPl8y4g
 PcW3ehDJGFk8/CXpExtxdZkiU8rNh0o/wBpB8USQyGsnxgpMtyiFiYZzAP2+McieqZ6q
 gbJO87vKFHMowlhS0YSiRYxHyvw5u8U8Ksw0/kbocCRSJMiPjCAd3TAX8zUm14icHybT
 6GyMz6tb6e5CNw+EGYmVzrTLa8TNh8tJb9Sbq7jbxmM6csq9fAtP/nwbMgPFJ1s9hIKo
 VHvC/Q9VMicqQ03ZC9D1RIzvNEsqgulwVPDbVU3Unlt6L7NR8dlNQmbZjRlQ7fyGK88z
 tTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713382314; x=1713987114;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xpRlvm3zq19Wnwz8plVPrkl3/j00gqXDJ5eWHYKOHWI=;
 b=IFEW6EszOrQD6+q8/JrRx8h08lfnS9w4wAJNPVDAD0QLV5KhOPgLCJLOJrp9F1AxRF
 TEFLmj/A3GTL/J34pifGAAJNMbnivCzMfO8dDmS8u4/jiBkperdlIBddpeTIunEi+zhg
 +4u4KKF0bmsGquBk0hW44gSlPvKcZteFHCwE4Gvu689IazwpIW8nar+QiXMlwgpK/ctW
 Ov3Age+upHMhtFxaxik6ryk2Gc3cddbHo/VMX28kILNiwcJVEN2AXkIemMVwgJHNinUD
 6zSt5A/h+KZTyzGhVQNnP2YOFuQGLTyhI1KUvr9PhAW07cYnUGpt35XHBPfQHIbIRrJM
 obqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/YxZvFzKwypvfzd3KUbE7CbxczpQGwWy6iL+fYLKtcxXg3p9qZBgVRkGEzXWuBCKVR7ev5WPpnBqSbNUvulVOj7UxLzE=
X-Gm-Message-State: AOJu0YxTV+GLttWLBhR60f7Z4cs0Dpb5Yi41Dlb0/H1AaTOWaVvkd74d
 NYp0f4X9sOlQIAwvnGmq5tDMjlmKGXemEQ/+fcsoWvLRfrx50QzoFt/99R0EHyWGiJmj3UMp1G+
 zj8BnA4DRy3h/mCUwPh1OUsLNX81kI03fYCPC
X-Google-Smtp-Source: AGHT+IHV9Usz0kJToFxRUspsxNDucomV4SjAirGge2EmjRyIVh4i3ojmdKtUkN34Ml59/3XfkMcW9vgbo6uNz2kRkms=
X-Received: by 2002:a17:903:40c4:b0:1e4:33a6:b0d4 with SMTP id
 t4-20020a17090340c400b001e433a6b0d4mr34053pld.9.1713382314062; Wed, 17 Apr
 2024 12:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAOGAQeqOVAHJ4VxQNKqO43hmLJdxpA6E_JEQrfL380SwT4Y73w@mail.gmail.com>
 <Zh0NiI9ZfS5uzs5Z@redhat.com>
In-Reply-To: <Zh0NiI9ZfS5uzs5Z@redhat.com>
From: Roman Kiryanov <rkir@google.com>
Date: Wed, 17 Apr 2024 12:31:41 -0700
Message-ID: <CAOGAQerx0DmHvJNf05wuJFOtXVwDFTt7fy0-GmBZ7xKoLAHTKQ@mail.gmail.com>
Subject: Re: Hermetic virtio-vsock in QEMU
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org, 
 QEMU Developers <qemu-devel@nongnu.org>, JP Cottin <jpcottin@google.com>, 
 Erwin Jansen <jansene@google.com>, Mehdi Alizadeh <mett@google.com>
Content-Type: multipart/alternative; boundary="00000000000032ef0a06164fe8de"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=rkir@google.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--00000000000032ef0a06164fe8de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

thank you for looking into this. I checked how VHOST_USER_VSOCK and it
refers to the vhost-user protocol. It is implemented in the
subprojects/libvhost-user library, but this library depends on poll.h
and linux/vhost.h files. Do you know if it builds/works on Windows?

I checked how poll.h is used and the only reference I found is "VU_WATCH_IN
=3D POLLIN", no other VU_WATCH_* items seem to be used (the same applies to
G_IO_* in -glib.c). Maybe retire VU_WATCH_ and poll.h dependency?

For linux/vhost.h, I see it is gated by defined(__linux__)
in libvhost-user.c but not in libvhost-user.h and I think it is not used
in libvhost-user.

Regards,
Roman.


On Mon, Apr 15, 2024 at 4:20=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Wed, Apr 03, 2024 at 02:30:33PM -0700, Roman Kiryanov wrote:
> > Hi Peter, Alex and QEMU,
> >
> > I work in Android Studio Emulator and we use virtio-vsock to emulate
> > devices (e.g. sensors) which live in the Emulator binary. We need to ru=
n
> on
> > Windows and in environments without CONFIG_VHOST_VSOCK, that is why we
> > cannot use vhost-vsock and invented our implementation. I tried to grep
> the
> > QEMU8 sources and I believe virtio-vsock is not available there.
> >
> > Do you think it is a good idea to implement virtio-vsock in QEMU (e.g. =
to
> > run on Windows)? If the answer is yes, could you please point where I
> could
> > start to build an upstreamable solution (not Android Emulator specific)=
?
> It
> > is not clear to me how we should make the device available for clients
> > (sensors, modem, adb, etc) in a generic way.
>
> This issue is proposing the idea of exposing VSOCK using AF_UNIX as the
> host backend, in a manner that's compatible with that used by firecracker
> and cloud-hypervisor:
>
>   https://gitlab.com/qemu-project/qemu/-/issues/2095
>
> Recent versions of Windows support AF_UNIX these days, so hopefully that
> would be satisfactory as an approach ?
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

--00000000000032ef0a06164fe8de
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0Daniel,<div><br></div><div>thank you for looking=
=C2=A0into this. I checked how=C2=A0VHOST_USER_VSOCK and it refers to the v=
host-user protocol. It is implemented in the subprojects/libvhost-user=C2=
=A0library, but this library depends on poll.h and=C2=A0linux/vhost.h files=
. Do you know if it builds/works on Windows?</div><div><br></div><div>I che=
cked how poll.h is used and the only reference I found is &quot;VU_WATCH_IN=
 =3D POLLIN&quot;, no other=C2=A0VU_WATCH_* items seem to be used (the same=
 applies to G_IO_* in -glib.c). Maybe retire VU_WATCH_ and poll.h dependenc=
y?</div><div><br></div><div>For=C2=A0linux/vhost.h, I see it is gated by=C2=
=A0defined(__linux__) in=C2=A0libvhost-user.c but not in=C2=A0libvhost-user=
.h and I think it is not used in=C2=A0libvhost-user.</div><div><br></div><d=
iv>Regards,</div><div>Roman.</div><div><br></div></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 15, 2024 at 4:=
20=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat=
.com" target=3D"_blank">berrange@redhat.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">On Wed, Apr 03, 2024 at 02:30:33=
PM -0700, Roman Kiryanov wrote:<br>
&gt; Hi Peter, Alex and QEMU,<br>
&gt; <br>
&gt; I work in Android Studio Emulator and we use virtio-vsock to emulate<b=
r>
&gt; devices (e.g. sensors) which live in the Emulator binary. We need to r=
un on<br>
&gt; Windows and in environments without CONFIG_VHOST_VSOCK, that is why we=
<br>
&gt; cannot use vhost-vsock and invented our implementation. I tried to gre=
p the<br>
&gt; QEMU8 sources and I believe virtio-vsock is not available there.<br>
&gt; <br>
&gt; Do you think it is a good idea to implement virtio-vsock in QEMU (e.g.=
 to<br>
&gt; run on Windows)? If the answer is yes, could you please point where I =
could<br>
&gt; start to build an upstreamable solution (not Android Emulator specific=
)? It<br>
&gt; is not clear to me how we should make the device available for clients=
<br>
&gt; (sensors, modem, adb, etc) in a generic way.<br>
<br>
This issue is proposing the idea of exposing VSOCK using AF_UNIX as the<br>
host backend, in a manner that&#39;s compatible with that used by firecrack=
er<br>
and cloud-hypervisor:<br>
<br>
=C2=A0 <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2095" rel=
=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/is=
sues/2095</a><br>
<br>
Recent versions of Windows support AF_UNIX these days, so hopefully that<br=
>
would be satisfactory as an approach ?<br>
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

--00000000000032ef0a06164fe8de--

