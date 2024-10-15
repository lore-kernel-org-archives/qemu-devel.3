Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CAED216A7
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iCe-0008KG-9Q; Tue, 15 Oct 2024 10:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <randrianasulu@gmail.com>)
 id 1t0iCb-0008Iu-U8
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:07:09 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <randrianasulu@gmail.com>)
 id 1t0iCW-0001NN-6k
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:07:08 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20cceb8d8b4so18092445ad.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729001208; x=1729606008; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jgb9vkFBJduZDB2ZImQcsNiJVWHydJeX5SbJ5m860j0=;
 b=Q97pDqBJ5meq7WZ8tgOApPkMHrVctgW4qYcoaEYfL6nV/dyfrzJvoh3tfRn7elp1m4
 gFn3XlfBQxPixe4+knosvhdjB5nPSKRx/Ywy1otLER10vg1xmsOrcXUPR5CPXOVIq4im
 sgkuW34uERHil4h7q5UUGIzEXwczFZxMDkRriFQ7Yx04C7+zk37XSaptkhlQbXVI9f5q
 ZRFepzx1HjZIQzZd4rMpo7WfMlceQoU2OnOKlop77hQ7ytnC/pMw0g1aX3yRAhs+jmrm
 mDcXBd9GQxenGM1HidRD0IsyzbNOzY3koNsFmyj1SGuZyso+lwH4W9W7BKxNV3NnC3qI
 C65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001208; x=1729606008;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jgb9vkFBJduZDB2ZImQcsNiJVWHydJeX5SbJ5m860j0=;
 b=hhtjWfW4aBZmHv/kvnY+qF+ip9kgIlqpN2axyNF5szONLwikRCy0R7u4L/+xGpjVxY
 lOUO8sOEKfSoZZZdJLeoIp76jxkJTonI88OX7xc4zvXmWgY2vmZJO41jhbmuljcaM9Oh
 a66KPeHrZVLQkI88msLlDQUzoasP1EqS6ppQu8gPXBukz3xxNdnsY8KVgijIUIGwOT2s
 NddO8VFxCteAn9JNjAOsOwK/4QkpAGh+J7al/GCIzRB/ASClkeD7KofTEbHzrOFzzWY3
 v0Qobdp7Q9mYFWL7iRkCYgw7i0hwH8zDO4T0ALcyPZhFyrxe4XgCbVBgIB9Y0InJvUQT
 RjUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/1vOoX3MJHdQrCgRDNp08ro5v2J0SFLJBj/XMfrRbcEXLn2lV/CQ7ubbvRSTJcrQmuvNUwW1oaoU2@nongnu.org
X-Gm-Message-State: AOJu0YyO+4BS4+rQCV9decsRq04MDOqBD1MV58aMTNH8O/5+SRUxCbcO
 /+qPoHZpPv1Cl9NGpCrPMK3xMTJuEhIRQC8NHHnzqkA9RNrfVJDoGqYFAyPRZIIdtU7ExwVmy1U
 eDrqKRBQO001/wg9FJ6jGPR4BOc5PgA==
X-Google-Smtp-Source: AGHT+IFZWQS3zIOuqo2c/o7shAtwtA73/3oBpKANdGXdJvBU3h6/BGzOOlKHwXQd9OYD3txIoI4C7Nbv9FkxkEq5Qzg=
X-Received: by 2002:a17:902:d544:b0:20c:8f98:5dbb with SMTP id
 d9443c01a7336-20ca039a022mr247805935ad.16.1729001207814; Tue, 15 Oct 2024
 07:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <CA+rFky6nRpHj8xKa7Wnw_coe_gbJoSXn61fc87-w0Z_7V-aBPw@mail.gmail.com>
 <CAFEAcA_-ncUdRTO+CpFCf44OY6toTBWw8-5y5zbnr3PSfn2sGA@mail.gmail.com>
 <c6c9ddd2-49bb-4c15-bc58-e72063be3a21@redhat.com>
 <CA+rFky7AOmikj40fR8ivC5s2aFT+tnKoVJ5fPRkm7i490FOwzw@mail.gmail.com>
In-Reply-To: <CA+rFky7AOmikj40fR8ivC5s2aFT+tnKoVJ5fPRkm7i490FOwzw@mail.gmail.com>
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Tue, 15 Oct 2024 17:06:32 +0300
Message-ID: <CA+rFky61Xc1=J5XWbL2bNeSExErF=PHyzCn4XZ_O12uuA668RA@mail.gmail.com>
Subject: Re: ALSA support in qemu-user?
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>
Content-Type: multipart/mixed; boundary="000000000000cefdbd062484762c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=randrianasulu@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000cefdbd062484762c
Content-Type: multipart/alternative; boundary="000000000000cefdbb062484762a"

--000000000000cefdbb062484762a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 14 =D0=BE=D0=BA=D1=82. 2024 =D0=B3., 17:26 Andrew Randrianasu=
lu <randrianasulu@gmail.com>:

>
>
> On Mon, Oct 14, 2024 at 12:21=E2=80=AFPM Thomas Huth <thuth@redhat.com> w=
rote:
>
>> On 14/10/2024 11.06, Peter Maydell wrote:
>> > On Mon, 14 Oct 2024 at 02:13, Andrew Randrianasulu
>> > <randrianasulu@gmail.com> wrote:
>> >>
>> >> some 8 years ago this patch was sent  to qemu-devel:
>> >>
>> >> https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg05333.html
>> >> "[Qemu-devel] [PATCH 7/7] Add ALSA ioctls"
>> >>
>> >> I wonder why it was rejected, may be as part of series?
>> >
>> > Hard to say from this distance, but looking at the patch
>> > I think it probably was just that it was on the end of
>> > a series that did a bunch of other things and the earlier
>> > patches in the series had issues.
>>
>> Yes, looks like there were review comments on the series that were not
>> addressed:
>>
>>   https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg05557.html
>>   https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg05364.html
>>
>> But mainly one of the problems were that the patches haven't been send i=
n
>> a
>> proper threaded way, so it was hard to follow the series:
>>
>>   https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg05546.html
>>
>> Anyway, looking at the other patches, it seems most of them were not
>> related
>> to ALSA, so you might be fine in just picking that patch, get it to work
>> with the latest version of QEMU again and send just that single updated
>> patch to this mailing list again. YMMV of course.
>>
>
> I tried  to apply patch but unfortunately mplayer still complain:
>
> [AO_ALSA] alsa-lib: pcm_hw.c:1578:(snd1_pcm_hw_open_fd) USER_PVERSION
> failed
>
> [AO_ALSA] alsa-lib: pcm_dmix.c:1092:(snd_pcm_dmix_open) unable to open
> slave
> [AO_ALSA] Playback open error: Inappropriate ioctl for device
>
> this is 32-bit mplayer/qemu-i386 on top of 64-bit kernel (x86_64)
>
> qemu git 3860a2a8de56fad71db42f4ad120eb7eff03b51f
>
> ./configure --prefix=3D/usr --target-list=3Di386-linux-user
>
>
so, may be qemu internal changed a bit, I tried to add MK_PTR around
int/long types in ioctl.h like it was done for alsa timer ctl before

but what to do with unsingned long in syscall_defs.h ?

there is abi_int so I changed simple  int to that.

Anyway with attached patch it still fails to play, while arecord -L /aplay
-L show their lists

normal speaker-test run:

strace -e ioctl /usr/bin/speaker-test 2>&1 | grep PVERSION
 ioctl(3, SNDRV_CTL_IOCTL_PVERSION, 0xff8bd008) =3D 0

   ioctl(4, AGPIOC_INFO or SNDRV_PCM_IOCTL_PVERSION, 0xff8bcefc) =3D 0

 ioctl(4, AGPIOC_RESERVE or SNDRV_PCM_IOCTL_USER_PVERSION, 0xff8bcf08) =3D =
0

failed run with qemu-i386:

strace -e ioctl qemu-i386 /usr/bin/speaker-test 2>&1 | grep PVERSION
 ioctl(3, SNDRV_CTL_IOCTL_PVERSION, 0xff8410ac) =3D 0

 ioctl(4, AGPIOC_INFO or SNDRV_PCM_IOCTL_PVERSION, 0xff8410ac) =3D 0



>
>
>>
>>   Thomas
>>
>>

--000000000000cefdbb062484762a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">=D0=BF=D0=BD, 14 =D0=BE=D0=BA=D1=82. 2024 =D0=B3., 17:=
26 Andrew Randrianasulu &lt;<a href=3D"mailto:randrianasulu@gmail.com" rel=
=3D"noreferrer noreferrer noreferrer" target=3D"_blank">randrianasulu@gmail=
.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div=
 dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Mon, Oct 14, 2024 at 12:21=E2=80=AFPM Thomas Huth &lt;<=
a href=3D"mailto:thuth@redhat.com" rel=3D"noreferrer noreferrer noreferrer =
noreferrer" target=3D"_blank">thuth@redhat.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">On 14/10/2024 11.06, Peter Ma=
ydell wrote:<br>
&gt; On Mon, 14 Oct 2024 at 02:13, Andrew Randrianasulu<br>
&gt; &lt;<a href=3D"mailto:randrianasulu@gmail.com" rel=3D"noreferrer noref=
errer noreferrer noreferrer" target=3D"_blank">randrianasulu@gmail.com</a>&=
gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; some 8 years ago this patch was sent=C2=A0 to qemu-devel:<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2016-06/m=
sg05333.html" rel=3D"noreferrer noreferrer noreferrer noreferrer noreferrer=
" target=3D"_blank">https://lists.gnu.org/archive/html/qemu-devel/2016-06/m=
sg05333.html</a><br>
&gt;&gt; &quot;[Qemu-devel] [PATCH 7/7] Add ALSA ioctls&quot;<br>
&gt;&gt;<br>
&gt;&gt; I wonder why it was rejected, may be as part of series?<br>
&gt; <br>
&gt; Hard to say from this distance, but looking at the patch<br>
&gt; I think it probably was just that it was on the end of<br>
&gt; a series that did a bunch of other things and the earlier<br>
&gt; patches in the series had issues.<br>
<br>
Yes, looks like there were review comments on the series that were not <br>
addressed:<br>
<br>
=C2=A0 <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg=
05557.html" rel=3D"noreferrer noreferrer noreferrer noreferrer noreferrer" =
target=3D"_blank">https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg=
05557.html</a><br>
=C2=A0 <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg=
05364.html" rel=3D"noreferrer noreferrer noreferrer noreferrer noreferrer" =
target=3D"_blank">https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg=
05364.html</a><br>
<br>
But mainly one of the problems were that the patches haven&#39;t been send =
in a <br>
proper threaded way, so it was hard to follow the series:<br>
<br>
=C2=A0 <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg=
05546.html" rel=3D"noreferrer noreferrer noreferrer noreferrer noreferrer" =
target=3D"_blank">https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg=
05546.html</a><br>
<br>
Anyway, looking at the other patches, it seems most of them were not relate=
d <br>
to ALSA, so you might be fine in just picking that patch, get it to work <b=
r>
with the latest version of QEMU again and send just that single updated <br=
>
patch to this mailing list again. YMMV of course.<br></blockquote><div><br>=
</div><div>I tried=C2=A0 to apply patch but unfortunately mplayer still com=
plain:</div><div><br></div><div>[AO_ALSA] alsa-lib: pcm_hw.c:1578:(snd1_pcm=
_hw_open_fd) USER_PVERSION failed<br><br>[AO_ALSA] alsa-lib: pcm_dmix.c:109=
2:(snd_pcm_dmix_open) unable to open slave<br>[AO_ALSA] Playback open error=
: Inappropriate ioctl for device</div><div><br></div><div>this is 32-bit mp=
layer/qemu-i386 on top of 64-bit kernel (x86_64)</div><div><br></div><div>q=
emu git 3860a2a8de56fad71db42f4ad120eb7eff03b51f</div><div><br></div><div>.=
/configure --prefix=3D/usr --target-list=3Di386-linux-user=C2=A0 <br></div>=
<div><br></div><div></div></div></div></blockquote></div></div><div dir=3D"=
auto"><br></div><div dir=3D"auto">so, may be qemu internal changed a bit, I=
 tried to add MK_PTR around int/long types in ioctl.h like it was done for =
alsa timer ctl before</div><div dir=3D"auto"><br></div><div dir=3D"auto">bu=
t what to do with unsingned long in syscall_defs.h ?</div><div dir=3D"auto"=
><br></div><div dir=3D"auto">there is abi_int so I changed simple=C2=A0 int=
 to that.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Anyway with at=
tached patch it still fails to play, while arecord -L /aplay -L show their =
lists</div><div dir=3D"auto"><br></div><div dir=3D"auto">normal speaker-tes=
t run:</div><div dir=3D"auto"><br></div><div dir=3D"auto">strace -e ioctl /=
usr/bin/speaker-test 2&gt;&amp;1 | grep PVERSION=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=C2=A0</div><div dir=3D"auto">=C2=A0ioctl(3, SNDRV_CTL=
_IOCTL_PVERSION, 0xff8bd008) =3D 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0</div><div dir=3D"auto">=
=C2=A0 =C2=A0ioctl(4, AGPIOC_INFO or SNDRV_PCM_IOCTL_PVERSION, 0xff8bcefc) =
=3D 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</div><div dir=3D"auto">=C2=
=A0ioctl(4, AGPIOC_RESERVE or SNDRV_PCM_IOCTL_USER_PVERSION, 0xff8bcf08) =
=3D 0<br></div><div dir=3D"auto"><br></div><div dir=3D"auto">failed run wit=
h qemu-i386:</div><div dir=3D"auto"><br></div><div dir=3D"auto">strace -e i=
octl qemu-i386 /usr/bin/speaker-test 2&gt;&amp;1 | grep PVERSION=C2=A0 =C2=
=A0=C2=A0</div><div dir=3D"auto">=C2=A0ioctl(3, SNDRV_CTL_IOCTL_PVERSION, 0=
xff8410ac) =3D 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0</div><div dir=3D"auto">=C2=A0ioctl=
(4, AGPIOC_INFO or SNDRV_PCM_IOCTL_PVERSION, 0xff8410ac) =3D 0<br></div><di=
v dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div=
 class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div=
 class=3D"gmail_quote"><div><br></div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<br>
=C2=A0 Thomas<br>
<br>
</blockquote></div></div>
</blockquote></div></div></div>

--000000000000cefdbb062484762a--

--000000000000cefdbd062484762c
Content-Type: application/x-patch; 
	name="0002-linux-user-trying-yo-fix-alsa-ioctls-not-working-yet.patch"
Content-Disposition: attachment; 
	filename="0002-linux-user-trying-yo-fix-alsa-ioctls-not-working-yet.patch"
Content-Transfer-Encoding: base64
Content-ID: <192907ca59daa38aa0a1>
X-Attachment-Id: 192907ca59daa38aa0a1

RnJvbSBjZjdkMWE2MDY3MTUzNzZkMGRmZGEzNTA2NTI2MTJmYWFhYzA0ZDkwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZXcgUmFuZHJpYW5hc3VsdSA8cmFuZHJpYW5hc3VsdUBn
bWFpbC5jb20+CkRhdGU6IFR1ZSwgMTUgT2N0IDIwMjQgMTY6NTI6MjQgKzAzMDAKU3ViamVjdDog
W1BBVENIIDIvMl0gbGludXgtdXNlcjogdHJ5aW5nIHlvIGZpeCBhbHNhIGlvY3Rscywgbm90IHdv
cmtpbmcgeWV0CgotLS0KIGxpbnV4LXVzZXIvaW9jdGxzLmggICAgICAgfCAzNiArKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0KIGxpbnV4LXVzZXIvc3lzY2FsbF9kZWZzLmggfCAy
OCArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDMyIGluc2Vy
dGlvbnMoKyksIDMyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvaW9jdGxz
LmggYi9saW51eC11c2VyL2lvY3Rscy5oCmluZGV4IDNiMGExMzRkMTMuLmYyODBkNzZiNzYgMTAw
NjQ0Ci0tLSBhL2xpbnV4LXVzZXIvaW9jdGxzLmgKKysrIGIvbGludXgtdXNlci9pb2N0bHMuaApA
QCAtNTc1LDcgKzU3NSw3IEBACiAgIElPQ1RMKFNPVU5EX01JWEVSX1dSSVRFX0xPVUQsIElPQ19X
LCBNS19QVFIoVFlQRV9JTlQpKQogICBJT0NUTChTT1VORF9NSVhFUl9XUklURV9SRUNTUkMsIElP
Q19XLCBNS19QVFIoVFlQRV9JTlQpKQogCi0gIElPQ1RMKFNORFJWX0NUTF9JT0NUTF9QVkVSU0lP
TiwgSU9DX1IsIFRZUEVfSU5UKQorICBJT0NUTChTTkRSVl9DVExfSU9DVExfUFZFUlNJT04sIElP
Q19SLCBNS19QVFIoVFlQRV9JTlQpKQogICBJT0NUTChTTkRSVl9DVExfSU9DVExfQ0FSRF9JTkZP
LCBJT0NfUiwgTUtfUFRSKE1LX1NUUlVDVChTVFJVQ1Rfc25kX2N0bF9jYXJkX2luZm8pKSkKICAg
SU9DVEwoU05EUlZfQ1RMX0lPQ1RMX0VMRU1fTElTVCwgSU9DX1JXLCBNS19QVFIoTUtfU1RSVUNU
KFNUUlVDVF9zbmRfY3RsX2VsZW1fbGlzdCkpKQogICBJT0NUTChTTkRSVl9DVExfSU9DVExfRUxF
TV9JTkZPLCBJT0NfUlcsIE1LX1BUUihNS19TVFJVQ1QoU1RSVUNUX3NuZF9jdGxfZWxlbV9pbmZv
KSkpCkBAIC01ODMsNTQgKzU4Myw1NCBAQAogICBJT0NUTChTTkRSVl9DVExfSU9DVExfRUxFTV9X
UklURSwgSU9DX1JXLCBNS19QVFIoTUtfU1RSVUNUKFNUUlVDVF9zbmRfY3RsX2VsZW1fdmFsdWUp
KSkKICAgSU9DVEwoU05EUlZfQ1RMX0lPQ1RMX0VMRU1fTE9DSywgSU9DX1csIE1LX1BUUihNS19T
VFJVQ1QoU1RSVUNUX3NuZF9jdGxfZWxlbV9pZCkpKQogICBJT0NUTChTTkRSVl9DVExfSU9DVExf
RUxFTV9VTkxPQ0ssIElPQ19XLCBNS19QVFIoTUtfU1RSVUNUKFNUUlVDVF9zbmRfY3RsX2VsZW1f
aWQpKSkKLSAgSU9DVEwoU05EUlZfQ1RMX0lPQ1RMX1NVQlNDUklCRV9FVkVOVFMsIElPQ19SVywg
VFlQRV9JTlQpCisgIElPQ1RMKFNORFJWX0NUTF9JT0NUTF9TVUJTQ1JJQkVfRVZFTlRTLCBJT0Nf
UlcsIE1LX1BUUihUWVBFX0lOVCkpCiAgIElPQ1RMKFNORFJWX0NUTF9JT0NUTF9FTEVNX0FERCwg
SU9DX1JXLCBNS19QVFIoTUtfU1RSVUNUKFNUUlVDVF9zbmRfY3RsX2VsZW1faW5mbykpKQogICBJ
T0NUTChTTkRSVl9DVExfSU9DVExfRUxFTV9SRVBMQUNFLCBJT0NfUlcsIE1LX1BUUihNS19TVFJV
Q1QoU1RSVUNUX3NuZF9jdGxfZWxlbV9pbmZvKSkpCiAgIElPQ1RMKFNORFJWX0NUTF9JT0NUTF9F
TEVNX1JFTU9WRSwgSU9DX1JXLCBNS19QVFIoTUtfU1RSVUNUKFNUUlVDVF9zbmRfY3RsX2VsZW1f
aWQpKSkKICAgSU9DVEwoU05EUlZfQ1RMX0lPQ1RMX1RMVl9SRUFELCBJT0NfUlcsIE1LX1BUUihN
S19TVFJVQ1QoU1RSVUNUX3NuZF9jdGxfdGx2KSkpCiAgIElPQ1RMKFNORFJWX0NUTF9JT0NUTF9U
TFZfV1JJVEUsIElPQ19SVywgTUtfUFRSKE1LX1NUUlVDVChTVFJVQ1Rfc25kX2N0bF90bHYpKSkK
ICAgSU9DVEwoU05EUlZfQ1RMX0lPQ1RMX1RMVl9DT01NQU5ELCBJT0NfUlcsIE1LX1BUUihNS19T
VFJVQ1QoU1RSVUNUX3NuZF9jdGxfdGx2KSkpCi0gIElPQ1RMKFNORFJWX0NUTF9JT0NUTF9IV0RF
UF9ORVhUX0RFVklDRSwgSU9DX1JXLCBUWVBFX0lOVCkKKyAgSU9DVEwoU05EUlZfQ1RMX0lPQ1RM
X0hXREVQX05FWFRfREVWSUNFLCBJT0NfUlcsIE1LX1BUUihUWVBFX0lOVCkpCiAgIElPQ1RMKFNO
RFJWX0NUTF9JT0NUTF9IV0RFUF9JTkZPLCBJT0NfUiwgTUtfUFRSKE1LX1NUUlVDVChTVFJVQ1Rf
c25kX2h3ZGVwX2luZm8pKSkKLSAgSU9DVEwoU05EUlZfQ1RMX0lPQ1RMX1BDTV9ORVhUX0RFVklD
RSwgSU9DX1IsIFRZUEVfSU5UKQorICBJT0NUTChTTkRSVl9DVExfSU9DVExfUENNX05FWFRfREVW
SUNFLCBJT0NfUiwgTUtfUFRSKFRZUEVfSU5UKSkKICAgSU9DVEwoU05EUlZfQ1RMX0lPQ1RMX1BD
TV9JTkZPLCBJT0NfUlcsIE1LX1BUUihNS19TVFJVQ1QoU1RSVUNUX3NuZF9wY21faW5mbykpKQot
ICBJT0NUTChTTkRSVl9DVExfSU9DVExfUENNX1BSRUZFUl9TVUJERVZJQ0UsIElPQ19XLCBUWVBF
X0lOVCkKLSAgSU9DVEwoU05EUlZfQ1RMX0lPQ1RMX1JBV01JRElfTkVYVF9ERVZJQ0UsIElPQ19S
VywgVFlQRV9JTlQpCisgIElPQ1RMKFNORFJWX0NUTF9JT0NUTF9QQ01fUFJFRkVSX1NVQkRFVklD
RSwgSU9DX1csIE1LX1BUUihUWVBFX0lOVCkpCisgIElPQ1RMKFNORFJWX0NUTF9JT0NUTF9SQVdN
SURJX05FWFRfREVWSUNFLCBJT0NfUlcsIE1LX1BUUihUWVBFX0lOVCkpCiAgIElPQ1RMKFNORFJW
X0NUTF9JT0NUTF9SQVdNSURJX0lORk8sIElPQ19SVywgTUtfUFRSKE1LX1NUUlVDVChTVFJVQ1Rf
c25kX3Jhd21pZGlfaW5mbykpKQotICBJT0NUTChTTkRSVl9DVExfSU9DVExfUkFXTUlESV9QUkVG
RVJfU1VCREVWSUNFLCBJT0NfVywgVFlQRV9JTlQpCi0gIElPQ1RMKFNORFJWX0NUTF9JT0NUTF9Q
T1dFUiwgSU9DX1JXLCBUWVBFX0lOVCkKKyAgSU9DVEwoU05EUlZfQ1RMX0lPQ1RMX1JBV01JRElf
UFJFRkVSX1NVQkRFVklDRSwgSU9DX1csIE1LX1BUUihUWVBFX0lOVCkpCisgIElPQ1RMKFNORFJW
X0NUTF9JT0NUTF9QT1dFUiwgSU9DX1JXLCBNS19QVFIoVFlQRV9JTlQpKQogICBJT0NUTChTTkRS
Vl9DVExfSU9DVExfUE9XRVJfU1RBVEUsIElPQ19SLCBUWVBFX0lOVCkKIAogLyogYWxzYSBzdHVm
ZiAqLwotICBJT0NUTChTTkRSVl9QQ01fSU9DVExfUFZFUlNJT04gICAgICAgICwgSU9DX1IsIFRZ
UEVfSU5UKQotICBJT0NUTChTTkRSVl9QQ01fSU9DVExfSU5GTyAgICAgICAgICAgICwgSU9DX1Is
TUtfUFRSKE1LX1NUUlVDVChTVFJVQ1Rfc25kX3BjbV9pbmZvKSkpCi0gIElPQ1RMKFNORFJWX1BD
TV9JT0NUTF9UU1RBTVAgICAgICAgICAgLCBJT0NfVywgVFlQRV9JTlQpCi0gIElPQ1RMKFNORFJW
X1BDTV9JT0NUTF9UVFNUQU1QICAgICAgICAgLCBJT0NfVywgVFlQRV9JTlQpCisgIElPQ1RMKFNO
RFJWX1BDTV9JT0NUTF9QVkVSU0lPTiAgICAgICAgLCBJT0NfUiwgTUtfUFRSKFRZUEVfSU5UKSkK
KyAgSU9DVEwoU05EUlZfUENNX0lPQ1RMX0lORk8gICAgICAgICAgICAsIElPQ19SLCBNS19QVFIo
TUtfU1RSVUNUKFNUUlVDVF9zbmRfcGNtX2luZm8pKSkKKyAgSU9DVEwoU05EUlZfUENNX0lPQ1RM
X1RTVEFNUCAgICAgICAgICAsIElPQ19XLCBNS19QVFIoVFlQRV9JTlQpKQorICBJT0NUTChTTkRS
Vl9QQ01fSU9DVExfVFRTVEFNUCAgICAgICAgICwgSU9DX1csIE1LX1BUUihUWVBFX0lOVCkpCiAg
IElPQ1RMKFNORFJWX1BDTV9JT0NUTF9IV19SRUZJTkUgICAgICAgLCBJT0NfUlcsIE1LX1BUUihN
S19TVFJVQ1QoU1RSVUNUX3NuZF9wY21faHdfcGFyYW1zKSkpCiAgIElPQ1RMKFNORFJWX1BDTV9J
T0NUTF9IV19QQVJBTVMgICAgICAgLCBJT0NfUlcsIE1LX1BUUihNS19TVFJVQ1QoU1RSVUNUX3Nu
ZF9wY21faHdfcGFyYW1zKSkpCiAgIElPQ1RMKFNORFJWX1BDTV9JT0NUTF9IV19GUkVFICAgICAg
ICAgLCAwLCBUWVBFX05VTEwpCiAgIElPQ1RMKFNORFJWX1BDTV9JT0NUTF9TV19QQVJBTVMgICAg
ICAgLCBJT0NfUlcsIE1LX1BUUihNS19TVFJVQ1QoU1RSVUNUX3NuZF9wY21fc3dfcGFyYW1zKSkp
CiAgIElPQ1RMKFNORFJWX1BDTV9JT0NUTF9TVEFUVVMgICAgICAgICAgLCBJT0NfUiwgIE1LX1BU
UihNS19TVFJVQ1QoU1RSVUNUX3NuZF9wY21fc3RhdHVzKSkpCi0gIElPQ1RMKFNORFJWX1BDTV9J
T0NUTF9ERUxBWSAgICAgICAgICAgLCBJT0NfUiwgVFlQRV9VTE9ORykKKyAgSU9DVEwoU05EUlZf
UENNX0lPQ1RMX0RFTEFZICAgICAgICAgICAsIElPQ19SLCBNS19QVFIoVFlQRV9VTE9ORykpCiAg
IElPQ1RMKFNORFJWX1BDTV9JT0NUTF9IV1NZTkMgICAgICAgICAgLCAwLCBUWVBFX05VTEwpCiAg
IElPQ1RMKFNORFJWX1BDTV9JT0NUTF9TWU5DX1BUUiAgICAgICAgLCBJT0NfUlcsIE1LX1BUUihN
S19TVFJVQ1QoU1RSVUNUX3NuZF9wY21fc3luY19wdHIpKSkKICAgSU9DVEwoU05EUlZfUENNX0lP
Q1RMX1NUQVRVU19FWFQgICAgICAsIElPQ19SVywgTUtfUFRSKE1LX1NUUlVDVChTVFJVQ1Rfc25k
X3BjbV9zdGF0dXMpKSkKLSAgSU9DVEwoU05EUlZfUENNX0lPQ1RMX0NIQU5ORUxfSU5GTyAgICAs
IElPQ19SLE1LX1BUUihNS19TVFJVQ1QoU1RSVUNUX3NuZF9wY21fY2hhbm5lbF9pbmZvKSkpCisg
IElPQ1RMKFNORFJWX1BDTV9JT0NUTF9DSEFOTkVMX0lORk8gICAgLCBJT0NfUiwgTUtfUFRSKE1L
X1NUUlVDVChTVFJVQ1Rfc25kX3BjbV9jaGFubmVsX2luZm8pKSkKICAgSU9DVEwoU05EUlZfUENN
X0lPQ1RMX1BSRVBBUkUgICAgICAgICAsIDAsIFRZUEVfTlVMTCkKICAgSU9DVEwoU05EUlZfUENN
X0lPQ1RMX1JFU0VUICAgICAgICAgICAsIDAsIFRZUEVfTlVMTCkKICAgSU9DVEwoU05EUlZfUENN
X0lPQ1RMX1NUQVJUICAgICAgICAgICAsIDAsIFRZUEVfTlVMTCkKICAgSU9DVEwoU05EUlZfUENN
X0lPQ1RMX0RST1AgICAgICAgICAgICAsIDAsIFRZUEVfTlVMTCkKICAgSU9DVEwoU05EUlZfUENN
X0lPQ1RMX0RSQUlOICAgICAgICAgICAsIDAsIFRZUEVfTlVMTCkKLSAgSU9DVEwoU05EUlZfUENN
X0lPQ1RMX1BBVVNFICAgICAgICAgICAsIElPQ19XLCBUWVBFX0lOVCkKLSAgSU9DVEwoU05EUlZf
UENNX0lPQ1RMX1JFV0lORCAgICAgICAgICAsIElPQ19XLCBUWVBFX1VMT05HKQorICBJT0NUTChT
TkRSVl9QQ01fSU9DVExfUEFVU0UgICAgICAgICAgICwgSU9DX1csIE1LX1BUUihUWVBFX0lOVCkp
CisgIElPQ1RMKFNORFJWX1BDTV9JT0NUTF9SRVdJTkQgICAgICAgICAgLCBJT0NfVywgTUtfUFRS
KFRZUEVfVUxPTkcpKQogICBJT0NUTChTTkRSVl9QQ01fSU9DVExfUkVTVU1FICAgICAgICAgICwg
MCwgVFlQRV9OVUxMKQogICBJT0NUTChTTkRSVl9QQ01fSU9DVExfWFJVTiAgICAgICAgICAgICwg
MCwgVFlQRV9OVUxMKQotICBJT0NUTChTTkRSVl9QQ01fSU9DVExfRk9SV0FSRCAgICAgICAgICwg
SU9DX1csIFRZUEVfVUxPTkcpCisgIElPQ1RMKFNORFJWX1BDTV9JT0NUTF9GT1JXQVJEICAgICAg
ICAgLCBJT0NfVywgTUtfUFRSKFRZUEVfVUxPTkcpKQogICBJT0NUTChTTkRSVl9QQ01fSU9DVExf
V1JJVEVJX0ZSQU1FUyAgICwgSU9DX1csIE1LX1BUUihNS19TVFJVQ1QoU1RSVUNUX3NuZF94ZmVy
aSkpKQogICBJT0NUTChTTkRSVl9QQ01fSU9DVExfUkVBRElfRlJBTUVTICAgICwgSU9DX1IsIE1L
X1BUUihNS19TVFJVQ1QoU1RSVUNUX3NuZF94ZmVyaSkpKQogICBJT0NUTChTTkRSVl9QQ01fSU9D
VExfV1JJVEVOX0ZSQU1FUyAgICwgSU9DX1csIE1LX1BUUihNS19TVFJVQ1QoU1RSVUNUX3NuZF94
ZmVybikpKQogICBJT0NUTChTTkRSVl9QQ01fSU9DVExfUkVBRE5fRlJBTUVTICAgICwgSU9DX1Is
IE1LX1BUUihNS19TVFJVQ1QoU1RSVUNUX3NuZF94ZmVybikpKQotICBJT0NUTChTTkRSVl9QQ01f
SU9DVExfTElOSyAgICAgICAgICAgICwgSU9DX1csIFRZUEVfSU5UKQorICBJT0NUTChTTkRSVl9Q
Q01fSU9DVExfTElOSyAgICAgICAgICAgICwgSU9DX1csIE1LX1BUUihUWVBFX0lOVCkpCiAgIElP
Q1RMKFNORFJWX1BDTV9JT0NUTF9VTkxJTksgICAgICAgICAgLCAwLCBUWVBFX05VTEwpCiAKICAg
SU9DVEwoU05EUlZfVElNRVJfSU9DVExfUFZFUlNJT04sIElPQ19SLCBNS19QVFIoVFlQRV9JTlQp
KQpkaWZmIC0tZ2l0IGEvbGludXgtdXNlci9zeXNjYWxsX2RlZnMuaCBiL2xpbnV4LXVzZXIvc3lz
Y2FsbF9kZWZzLmgKaW5kZXggYTU2ZGRlMTJlOC4uOTBlMTExMWNkNCAxMDA2NDQKLS0tIGEvbGlu
dXgtdXNlci9zeXNjYWxsX2RlZnMuaAorKysgYi9saW51eC11c2VyL3N5c2NhbGxfZGVmcy5oCkBA
IC0yNjY5LDcgKzI2NjksNyBAQCBzdHJ1Y3QgdGFyZ2V0X3VzZXJfY2FwX2RhdGEgewogfTsKIAog
LyogYXNvdW5kIGRlZmluZXMgKi8KLSNkZWZpbmUgVEFSR0VUX1NORFJWX0NUTF9JT0NUTF9QVkVS
U0lPTiBUQVJHRVRfSU9SKCdVJywgMHgwMCwgaW50KQorI2RlZmluZSBUQVJHRVRfU05EUlZfQ1RM
X0lPQ1RMX1BWRVJTSU9OIFRBUkdFVF9JT1IoJ1UnLCAweDAwLCBhYmlfaW50KQogI2RlZmluZSBU
QVJHRVRfU05EUlZfQ1RMX0lPQ1RMX0NBUkRfSU5GTyBUQVJHRVRfSU9SKCdVJywgMHgwMSwgc3Ry
dWN0IHNuZF9jdGxfY2FyZF9pbmZvKQogI2RlZmluZSBUQVJHRVRfU05EUlZfQ1RMX0lPQ1RMX0VM
RU1fTElTVCBUQVJHRVRfSU9XUignVScsIDB4MTAsIHN0cnVjdCBzbmRfY3RsX2VsZW1fbGlzdCkK
ICNkZWZpbmUgVEFSR0VUX1NORFJWX0NUTF9JT0NUTF9FTEVNX0lORk8gVEFSR0VUX0lPV1IoJ1Un
LCAweDExLCBzdHJ1Y3Qgc25kX2N0bF9lbGVtX2luZm8pCkBAIC0yNjg0LDI3ICsyNjg0LDI3IEBA
IHN0cnVjdCB0YXJnZXRfdXNlcl9jYXBfZGF0YSB7CiAjZGVmaW5lIFRBUkdFVF9TTkRSVl9DVExf
SU9DVExfVExWX1JFQUQgVEFSR0VUX0lPV1IoJ1UnLCAweDFhLCBzdHJ1Y3Qgc25kX2N0bF90bHYp
CiAjZGVmaW5lIFRBUkdFVF9TTkRSVl9DVExfSU9DVExfVExWX1dSSVRFIFRBUkdFVF9JT1dSKCdV
JywgMHgxYiwgc3RydWN0IHNuZF9jdGxfdGx2KQogI2RlZmluZSBUQVJHRVRfU05EUlZfQ1RMX0lP
Q1RMX1RMVl9DT01NQU5EIFRBUkdFVF9JT1dSKCdVJywgMHgxYywgc3RydWN0IHNuZF9jdGxfdGx2
KQotI2RlZmluZSBUQVJHRVRfU05EUlZfQ1RMX0lPQ1RMX0hXREVQX05FWFRfREVWSUNFIFRBUkdF
VF9JT1dSKCdVJywgMHgyMCwgaW50KQorI2RlZmluZSBUQVJHRVRfU05EUlZfQ1RMX0lPQ1RMX0hX
REVQX05FWFRfREVWSUNFIFRBUkdFVF9JT1dSKCdVJywgMHgyMCwgYWJpX2ludCkKICNkZWZpbmUg
VEFSR0VUX1NORFJWX0NUTF9JT0NUTF9IV0RFUF9JTkZPIFRBUkdFVF9JT1IoJ1UnLCAweDIxLCBz
dHJ1Y3Qgc25kX2h3ZGVwX2luZm8pCi0jZGVmaW5lIFRBUkdFVF9TTkRSVl9DVExfSU9DVExfUENN
X05FWFRfREVWSUNFIFRBUkdFVF9JT1IoJ1UnLCAweDMwLCBpbnQpCisjZGVmaW5lIFRBUkdFVF9T
TkRSVl9DVExfSU9DVExfUENNX05FWFRfREVWSUNFIFRBUkdFVF9JT1IoJ1UnLCAweDMwLCBhYmlf
aW50KQogI2RlZmluZSBUQVJHRVRfU05EUlZfQ1RMX0lPQ1RMX1BDTV9JTkZPIFRBUkdFVF9JT1dS
KCdVJywgMHgzMSwgc3RydWN0IHNuZF9wY21faW5mbykKLSNkZWZpbmUgVEFSR0VUX1NORFJWX0NU
TF9JT0NUTF9QQ01fUFJFRkVSX1NVQkRFVklDRSBUQVJHRVRfSU9XKCdVJywgMHgzMiwgaW50KQot
I2RlZmluZSBUQVJHRVRfU05EUlZfQ1RMX0lPQ1RMX1JBV01JRElfTkVYVF9ERVZJQ0UgVEFSR0VU
X0lPV1IoJ1UnLCAweDQwLCBpbnQpCisjZGVmaW5lIFRBUkdFVF9TTkRSVl9DVExfSU9DVExfUENN
X1BSRUZFUl9TVUJERVZJQ0UgVEFSR0VUX0lPVygnVScsIDB4MzIsIGFiaV9pbnQpCisjZGVmaW5l
IFRBUkdFVF9TTkRSVl9DVExfSU9DVExfUkFXTUlESV9ORVhUX0RFVklDRSBUQVJHRVRfSU9XUign
VScsIDB4NDAsIGFiaV9pbnQpCiAjZGVmaW5lIFRBUkdFVF9TTkRSVl9DVExfSU9DVExfUkFXTUlE
SV9JTkZPIFRBUkdFVF9JT1dSKCdVJywgMHg0MSwgc3RydWN0IHNuZF9yYXdtaWRpX2luZm8pCi0j
ZGVmaW5lIFRBUkdFVF9TTkRSVl9DVExfSU9DVExfUkFXTUlESV9QUkVGRVJfU1VCREVWSUNFIFRB
UkdFVF9JT1coJ1UnLCAweDQyLCBpbnQpCi0jZGVmaW5lIFRBUkdFVF9TTkRSVl9DVExfSU9DVExf
UE9XRVIgVEFSR0VUX0lPV1IoJ1UnLCAweGQwLCBpbnQpCi0jZGVmaW5lIFRBUkdFVF9TTkRSVl9D
VExfSU9DVExfUE9XRVJfU1RBVEUgVEFSR0VUX0lPUignVScsIDB4ZDEsIGludCkKKyNkZWZpbmUg
VEFSR0VUX1NORFJWX0NUTF9JT0NUTF9SQVdNSURJX1BSRUZFUl9TVUJERVZJQ0UgVEFSR0VUX0lP
VygnVScsIDB4NDIsIGFiaV9pbnQpCisjZGVmaW5lIFRBUkdFVF9TTkRSVl9DVExfSU9DVExfUE9X
RVIgVEFSR0VUX0lPV1IoJ1UnLCAweGQwLCBhYmlfaW50KQorI2RlZmluZSBUQVJHRVRfU05EUlZf
Q1RMX0lPQ1RMX1BPV0VSX1NUQVRFIFRBUkdFVF9JT1IoJ1UnLCAweGQxLCBhYmlfaW50KQogCi0j
ZGVmaW5lIFRBUkdFVF9TTkRSVl9QQ01fSU9DVExfUFZFUlNJT04gVEFSR0VUX0lPUignQScsIDB4
MDAsIGludCkKKyNkZWZpbmUgVEFSR0VUX1NORFJWX1BDTV9JT0NUTF9QVkVSU0lPTiBUQVJHRVRf
SU9SKCdBJywgMHgwMCwgYWJpX2ludCkKICNkZWZpbmUgVEFSR0VUX1NORFJWX1BDTV9JT0NUTF9J
TkZPIFRBUkdFVF9JT1IoJ0EnLCAweDAxLCBzdHJ1Y3Qgc25kX3BjbV9pbmZvKQotI2RlZmluZSBU
QVJHRVRfU05EUlZfUENNX0lPQ1RMX1RTVEFNUCBUQVJHRVRfSU9XKCdBJywgMHgwMiwgaW50KQot
I2RlZmluZSBUQVJHRVRfU05EUlZfUENNX0lPQ1RMX1RUU1RBTVAgVEFSR0VUX0lPVygnQScsIDB4
MDMsIGludCkKKyNkZWZpbmUgVEFSR0VUX1NORFJWX1BDTV9JT0NUTF9UU1RBTVAgVEFSR0VUX0lP
VygnQScsIDB4MDIsIGFiaV9pbnQpCisjZGVmaW5lIFRBUkdFVF9TTkRSVl9QQ01fSU9DVExfVFRT
VEFNUCBUQVJHRVRfSU9XKCdBJywgMHgwMywgYWJpX2ludCkKICNkZWZpbmUgVEFSR0VUX1NORFJW
X1BDTV9JT0NUTF9IV19SRUZJTkUgVEFSR0VUX0lPV1IoJ0EnLCAweDEwLCBzdHJ1Y3Qgc25kX3Bj
bV9od19wYXJhbXMpCiAjZGVmaW5lIFRBUkdFVF9TTkRSVl9QQ01fSU9DVExfSFdfUEFSQU1TIFRB
UkdFVF9JT1dSKCdBJywgMHgxMSwgc3RydWN0IHNuZF9wY21faHdfcGFyYW1zKQogI2RlZmluZSBU
QVJHRVRfU05EUlZfUENNX0lPQ1RMX0hXX0ZSRUUgVEFSR0VUX0lPKCdBJywgMHgxMikKICNkZWZp
bmUgVEFSR0VUX1NORFJWX1BDTV9JT0NUTF9TV19QQVJBTVMgVEFSR0VUX0lPV1IoJ0EnLCAweDEz
LCBzdHJ1Y3Qgc25kX3BjbV9zd19wYXJhbXMpCiAjZGVmaW5lIFRBUkdFVF9TTkRSVl9QQ01fSU9D
VExfU1RBVFVTIFRBUkdFVF9JT1IoJ0EnLCAweDIwLCBzdHJ1Y3Qgc25kX3BjbV9zdGF0dXMpCi0j
ZGVmaW5lIFRBUkdFVF9TTkRSVl9QQ01fSU9DVExfREVMQVkgVEFSR0VUX0lPUignQScsIDB4MjEs
IGxvbmcpCisjZGVmaW5lIFRBUkdFVF9TTkRSVl9QQ01fSU9DVExfREVMQVkgVEFSR0VUX0lPUign
QScsIDB4MjEsIGFiaV9sb25nKQogI2RlZmluZSBUQVJHRVRfU05EUlZfUENNX0lPQ1RMX0hXU1lO
QyBUQVJHRVRfSU8oJ0EnLCAweDIyKQogI2RlZmluZSBUQVJHRVRfU05EUlZfUENNX0lPQ1RMX1NZ
TkNfUFRSIFRBUkdFVF9JT1dSKCdBJywgMHgyMywgc3RydWN0IHNuZF9wY21fc3luY19wdHIpCiAj
ZGVmaW5lIFRBUkdFVF9TTkRSVl9QQ01fSU9DVExfU1RBVFVTX0VYVCBUQVJHRVRfSU9XUignQScs
IDB4MjQsIHN0cnVjdCBzbmRfcGNtX3N0YXR1cykKQEAgLTI3MTQsNyArMjcxNCw3IEBAIHN0cnVj
dCB0YXJnZXRfdXNlcl9jYXBfZGF0YSB7CiAjZGVmaW5lIFRBUkdFVF9TTkRSVl9QQ01fSU9DVExf
U1RBUlQgVEFSR0VUX0lPKCdBJywgMHg0MikKICNkZWZpbmUgVEFSR0VUX1NORFJWX1BDTV9JT0NU
TF9EUk9QIFRBUkdFVF9JTygnQScsIDB4NDMpCiAjZGVmaW5lIFRBUkdFVF9TTkRSVl9QQ01fSU9D
VExfRFJBSU4gVEFSR0VUX0lPKCdBJywgMHg0NCkKLSNkZWZpbmUgVEFSR0VUX1NORFJWX1BDTV9J
T0NUTF9QQVVTRSBUQVJHRVRfSU9XKCdBJywgMHg0NSwgaW50KQorI2RlZmluZSBUQVJHRVRfU05E
UlZfUENNX0lPQ1RMX1BBVVNFIFRBUkdFVF9JT1coJ0EnLCAweDQ1LCBhYmlfaW50KQogI2RlZmlu
ZSBUQVJHRVRfU05EUlZfUENNX0lPQ1RMX1JFV0lORCBUQVJHRVRfSU9XKCdBJywgMHg0NiwgdW5z
aWduZWQgbG9uZykKICNkZWZpbmUgVEFSR0VUX1NORFJWX1BDTV9JT0NUTF9SRVNVTUUgVEFSR0VU
X0lPKCdBJywgMHg0NykKICNkZWZpbmUgVEFSR0VUX1NORFJWX1BDTV9JT0NUTF9YUlVOIFRBUkdF
VF9JTygnQScsIDB4NDgpCkBAIC0yNzIzLDcgKzI3MjMsNyBAQCBzdHJ1Y3QgdGFyZ2V0X3VzZXJf
Y2FwX2RhdGEgewogI2RlZmluZSBUQVJHRVRfU05EUlZfUENNX0lPQ1RMX1JFQURJX0ZSQU1FUyBU
QVJHRVRfSU9SKCdBJywgMHg1MSwgc3RydWN0IHNuZF94ZmVyaSkKICNkZWZpbmUgVEFSR0VUX1NO
RFJWX1BDTV9JT0NUTF9XUklURU5fRlJBTUVTIFRBUkdFVF9JT1coJ0EnLCAweDUyLCBzdHJ1Y3Qg
c25kX3hmZXJuKQogI2RlZmluZSBUQVJHRVRfU05EUlZfUENNX0lPQ1RMX1JFQUROX0ZSQU1FUyBU
QVJHRVRfSU9SKCdBJywgMHg1Mywgc3RydWN0IHNuZF94ZmVybikKLSNkZWZpbmUgVEFSR0VUX1NO
RFJWX1BDTV9JT0NUTF9MSU5LIFRBUkdFVF9JT1coJ0EnLCAweDYwLCBpbnQpCisjZGVmaW5lIFRB
UkdFVF9TTkRSVl9QQ01fSU9DVExfTElOSyBUQVJHRVRfSU9XKCdBJywgMHg2MCwgYWJpX2ludCkK
ICNkZWZpbmUgVEFSR0VUX1NORFJWX1BDTV9JT0NUTF9VTkxJTksgVEFSR0VUX0lPKCdBJywgMHg2
MSkKIAogCi0tIAoyLjQ2LjIKCg==
--000000000000cefdbd062484762c--

