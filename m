Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D246D1F9D8
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 21:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0pRk-0001GE-Jm; Tue, 15 Oct 2024 17:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <randrianasulu@gmail.com>)
 id 1t0pRZ-0001FY-48
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 17:51:06 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <randrianasulu@gmail.com>)
 id 1t0pRU-0004SZ-Km
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 17:51:02 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20c803787abso2256255ad.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 14:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729029059; x=1729633859; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n2TJAB8FLjzVHFC8Lbv0dT7vRytt5e8+yJxwFKzGhu8=;
 b=HhAoegiXKGsk7MXIxt2cVop/6CdLxKlWznnzo2GetrW2ItQT29vVOx7r6d+d0Cberj
 EELbsdVYXd91m95Vq/wYLYl9dFDVsLYTSAkxLUXVb5OQXl/o1Klg1aXn7LGxYStRUdl7
 ZbE7TnNddZAAEI/lBN0fHV2fXEGvqyyXiUBN1qRFogtfZDd6bU4yxafKm2+2RyDOwNow
 2iPgcMZMjjTItdQjoxGiKIODCZ/YWsey1REZxtMeRxQg2W5He1Lnl8Pu+wTmARloz89Q
 RNXuYn3kd+SEdTIPIWbXHLg1GvD6zjPxZTLUc9RwqpDypJcmX27V9gILOgj25vq54mLA
 lofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729029059; x=1729633859;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n2TJAB8FLjzVHFC8Lbv0dT7vRytt5e8+yJxwFKzGhu8=;
 b=ZeshLIo2BfCLtOMolr/DYqIboccPf8IcKK6QudiWZOJwaQ8ygWPn+gzmFk1K7aQ6AM
 H/zxfEr0q+krmOXVyT9uuL6ihf7oHo1ivfk/3obhekB2BqmJUVT5sX+K3evFAmaIWFpf
 4wB3D+glRRmlqlS05thhjlF1oXLUDYBKLt6LppIMqoDNd/oOic0AHEDJvAgrmCxqHKud
 TNt1Z2BezfNIsZ+j+I4ngjD+CDf9fsqjxL1C21FZTFbo1vXNsSI/qkvmbRk0K4qCPyAx
 QTIpkeb9UmmxLkpcgeMd/0GgJHTWIX+XfsnNiB3CUM5akoPdFiu+Efp3Mqjv5RYjoWKx
 vA9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMTYUFuEev4EqX3tUNomg9bTmhRFij5jQUzz4dKCxzYfbjIdJrlS7tEtIhviUqwrDuXpYTNTAO50Po@nongnu.org
X-Gm-Message-State: AOJu0YzPO5ckY9S7SwhOUyoJGwELrHne7C4z5AoBdazvJGmSyhd9SzXm
 veblLJMvuR62WRMW0JWUywygxWgpxnO8C1zRyn/vPKwsXpAjFYFI5W1L0xe5cPSXNum+oNOsCEH
 6pKxddrZDYw5o8RuaE8Nl6qMRopU=
X-Google-Smtp-Source: AGHT+IFXQ2I+Jtq0BOZbb0Ro03wDHX+p2Uj/t7j3Id/lJR/ObtwBh2ZYXSourwkny1Y2QfQjvzX2Tm6AtAtvtgapQts=
X-Received: by 2002:a17:902:f686:b0:20c:68af:a4e3 with SMTP id
 d9443c01a7336-20ca03d67dfmr270000975ad.22.1729029058916; Tue, 15 Oct 2024
 14:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <CA+rFky6nRpHj8xKa7Wnw_coe_gbJoSXn61fc87-w0Z_7V-aBPw@mail.gmail.com>
 <CAFEAcA_-ncUdRTO+CpFCf44OY6toTBWw8-5y5zbnr3PSfn2sGA@mail.gmail.com>
 <c6c9ddd2-49bb-4c15-bc58-e72063be3a21@redhat.com>
 <CA+rFky7AOmikj40fR8ivC5s2aFT+tnKoVJ5fPRkm7i490FOwzw@mail.gmail.com>
 <CA+rFky61Xc1=J5XWbL2bNeSExErF=PHyzCn4XZ_O12uuA668RA@mail.gmail.com>
In-Reply-To: <CA+rFky61Xc1=J5XWbL2bNeSExErF=PHyzCn4XZ_O12uuA668RA@mail.gmail.com>
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Wed, 16 Oct 2024 00:50:46 +0300
Message-ID: <CA+rFky724Mce4OsN4=Q35xo=auN=mUJorouPGSwk25NJDuyvpg@mail.gmail.com>
Subject: Re: ALSA support in qemu-user?
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000dcfb7606248af2c0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=randrianasulu@gmail.com; helo=mail-pl1-x634.google.com
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

--000000000000dcfb7606248af2c0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 15 =D0=BE=D0=BA=D1=82. 2024 =D0=B3., 17:06 Andrew Randrianasu=
lu <randrianasulu@gmail.com>:

>
>
> =D0=BF=D0=BD, 14 =D0=BE=D0=BA=D1=82. 2024 =D0=B3., 17:26 Andrew Randriana=
sulu <randrianasulu@gmail.com>:
>
>>
>>
>> On Mon, Oct 14, 2024 at 12:21=E2=80=AFPM Thomas Huth <thuth@redhat.com> =
wrote:
>>
>>> On 14/10/2024 11.06, Peter Maydell wrote:
>>> > On Mon, 14 Oct 2024 at 02:13, Andrew Randrianasulu
>>> > <randrianasulu@gmail.com> wrote:
>>> >>
>>> >> some 8 years ago this patch was sent  to qemu-devel:
>>> >>
>>> >> https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg05333.html
>>> >> "[Qemu-devel] [PATCH 7/7] Add ALSA ioctls"
>>> >>
>>> >> I wonder why it was rejected, may be as part of series?
>>> >
>>> > Hard to say from this distance, but looking at the patch
>>> > I think it probably was just that it was on the end of
>>> > a series that did a bunch of other things and the earlier
>>> > patches in the series had issues.
>>>
>>> Yes, looks like there were review comments on the series that were not
>>> addressed:
>>>
>>>   https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg05557.html
>>>   https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg05364.html
>>>
>>> But mainly one of the problems were that the patches haven't been send
>>> in a
>>> proper threaded way, so it was hard to follow the series:
>>>
>>>   https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg05546.html
>>>
>>> Anyway, looking at the other patches, it seems most of them were not
>>> related
>>> to ALSA, so you might be fine in just picking that patch, get it to wor=
k
>>> with the latest version of QEMU again and send just that single updated
>>> patch to this mailing list again. YMMV of course.
>>>
>>
>> I tried  to apply patch but unfortunately mplayer still complain:
>>
>> [AO_ALSA] alsa-lib: pcm_hw.c:1578:(snd1_pcm_hw_open_fd) USER_PVERSION
>> failed
>>
>> [AO_ALSA] alsa-lib: pcm_dmix.c:1092:(snd_pcm_dmix_open) unable to open
>> slave
>> [AO_ALSA] Playback open error: Inappropriate ioctl for device
>>
>> this is 32-bit mplayer/qemu-i386 on top of 64-bit kernel (x86_64)
>>
>> qemu git 3860a2a8de56fad71db42f4ad120eb7eff03b51f
>>
>> ./configure --prefix=3D/usr --target-list=3Di386-linux-user
>>
>>
> so, may be qemu internal changed a bit, I tried to add MK_PTR around
> int/long types in ioctl.h like it was done for alsa timer ctl before
>
> but what to do with unsingned long in syscall_defs.h ?
>
> there is abi_int so I changed simple  int to that.
>
> Anyway with attached patch it still fails to play, while arecord -L /apla=
y
> -L show their lists
>
> normal speaker-test run:
>
> strace -e ioctl /usr/bin/speaker-test 2>&1 | grep PVERSION
>  ioctl(3, SNDRV_CTL_IOCTL_PVERSION, 0xff8bd008) =3D 0
>
>    ioctl(4, AGPIOC_INFO or SNDRV_PCM_IOCTL_PVERSION, 0xff8bcefc) =3D 0
>
>  ioctl(4, AGPIOC_RESERVE or SNDRV_PCM_IOCTL_USER_PVERSION, 0xff8bcf08) =
=3D 0
>
> failed run with qemu-i386:
>
> strace -e ioctl qemu-i386 /usr/bin/speaker-test 2>&1 | grep PVERSION
>  ioctl(3, SNDRV_CTL_IOCTL_PVERSION, 0xff8410ac) =3D 0
>
>  ioctl(4, AGPIOC_INFO or SNDRV_PCM_IOCTL_PVERSION, 0xff8410ac) =3D 0
>


Now, this is strange.

With additional patch aplay/arecord -l show truncated list of hardware
devices.

If I set

IOCTL(SNDRV_CTL_IOCTL_PCM_NEXT_DEVICE, IOC_R, TYPE_INT)

instead ot MK_PTR(TYPE_INT) in

linux-user/iocts.h

with my two patches

then arecord/aplay under qemu-i386 enumerates all host devices again ...



>
>
>>
>>
>>>
>>>   Thomas
>>>
>>>

--000000000000dcfb7606248af2c0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">=D0=B2=D1=82, 15 =D0=BE=D0=BA=D1=82. 2024 =D0=B3., 17:=
06 Andrew Randrianasulu &lt;<a href=3D"mailto:randrianasulu@gmail.com" targ=
et=3D"_blank" rel=3D"noreferrer">randrianasulu@gmail.com</a>&gt;:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"auto"><div><br><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D0=BD, 14 =D0=BE=
=D0=BA=D1=82. 2024 =D0=B3., 17:26 Andrew Randrianasulu &lt;<a href=3D"mailt=
o:randrianasulu@gmail.com" rel=3D"noreferrer noreferrer noreferrer noreferr=
er noreferrer" target=3D"_blank">randrianasulu@gmail.com</a>&gt;:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon=
, Oct 14, 2024 at 12:21=E2=80=AFPM Thomas Huth &lt;<a href=3D"mailto:thuth@=
redhat.com" rel=3D"noreferrer noreferrer noreferrer noreferrer noreferrer n=
oreferrer" target=3D"_blank">thuth@redhat.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">On 14/10/2024 11.06, Peter May=
dell wrote:<br>
&gt; On Mon, 14 Oct 2024 at 02:13, Andrew Randrianasulu<br>
&gt; &lt;<a href=3D"mailto:randrianasulu@gmail.com" rel=3D"noreferrer noref=
errer noreferrer noreferrer noreferrer noreferrer" target=3D"_blank">randri=
anasulu@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; some 8 years ago this patch was sent=C2=A0 to qemu-devel:<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2016-06/m=
sg05333.html" rel=3D"noreferrer noreferrer noreferrer noreferrer noreferrer=
 noreferrer noreferrer" target=3D"_blank">https://lists.gnu.org/archive/htm=
l/qemu-devel/2016-06/msg05333.html</a><br>
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
05557.html" rel=3D"noreferrer noreferrer noreferrer noreferrer noreferrer n=
oreferrer noreferrer" target=3D"_blank">https://lists.gnu.org/archive/html/=
qemu-devel/2016-06/msg05557.html</a><br>
=C2=A0 <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg=
05364.html" rel=3D"noreferrer noreferrer noreferrer noreferrer noreferrer n=
oreferrer noreferrer" target=3D"_blank">https://lists.gnu.org/archive/html/=
qemu-devel/2016-06/msg05364.html</a><br>
<br>
But mainly one of the problems were that the patches haven&#39;t been send =
in a <br>
proper threaded way, so it was hard to follow the series:<br>
<br>
=C2=A0 <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg=
05546.html" rel=3D"noreferrer noreferrer noreferrer noreferrer noreferrer n=
oreferrer noreferrer" target=3D"_blank">https://lists.gnu.org/archive/html/=
qemu-devel/2016-06/msg05546.html</a><br>
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
(4, AGPIOC_INFO or SNDRV_PCM_IOCTL_PVERSION, 0xff8410ac) =3D 0<br></div></d=
iv></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Now, this is strange.</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">With additional patch aplay/arecord -l show trunca=
ted list of hardware devices.</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">If I set=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">IOC=
TL(SNDRV_CTL_IOCTL_PCM_NEXT_DEVICE, IOC_R, TYPE_INT)<br></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">instead ot MK_PTR(TYPE_INT) in</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">linux-user/iocts.h</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">with my two patches</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">then arecord/aplay under qemu-i386 enumerate=
s all host devices again ...</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex"><div dir=3D"auto"><div dir=3D"auto"></div><div dir=3D"auto"=
><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmai=
l_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmai=
l_quote"><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
=C2=A0 Thomas<br>
<br>
</blockquote></div></div>
</blockquote></div></div></div>
</blockquote></div></div></div>

--000000000000dcfb7606248af2c0--

