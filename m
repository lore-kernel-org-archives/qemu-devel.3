Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADF9C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 13:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU4c3-0007G4-Vd; Wed, 17 Jul 2024 09:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sU4c1-00077n-CC
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:22:29 -0400
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sU4by-0008O2-Uf
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:22:29 -0400
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-48fde151f25so337627137.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 06:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1721222545; x=1721827345;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F22l6JBK/tX/9RW4E/YLAAs8pwuYoWpwEpH5E2SPXw0=;
 b=ga+02MLnWJMrRAvS+Hfa5q3HTGVzkNqfkBJuqoqw4svRd7F2qr9ZBHnMeeACLglcgj
 FDNWoQ9+QckqdnCXHJv5BmVmuP/aBuIj2m2CUeJV2TEF8nQVUN0F0uEAmwRQTX0tS0Vd
 I0gnft3rvqnrkXSfdVosb7W7+CSeCda5ekWJkpv9E+HaaiUU+jAvidNAjTkxArDPTvGv
 nvabk29On32EtmsthJM9O8BW1f2uv1MMWDaf3ouWsHqhts1jLYkXIPIrqPJ6l0eSuzKw
 Ot5VWRAS0eN0LGR4+V1Dpy15RkaDUhWmKFwLHg5TisSOCVSHkh10c5ysykeajyhTbSY0
 XLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721222545; x=1721827345;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F22l6JBK/tX/9RW4E/YLAAs8pwuYoWpwEpH5E2SPXw0=;
 b=ZF5QrylTjbV/lHyo+1Xw+pTafmDtPuutlU0ZZUU1FMG77phag/pevswgf2AFHrbrP4
 tVWb2emS+Vlu4XbcHzyu1J4gEAv6Ih04Id/6t6asqYhQkNQIdkcwr+aPvJfZK086CUwU
 Mw+B9UwmRT/I5CSsz9njpG0z7eidTqHV53BQG63RDDgG7zLdbwWlwWZbg655xzSFeABN
 QDMVSh25nzp+M/btWv7fdtEBrLQj/6Pv1/kujYEr0ycTBX9+p3YDEcW4SG0lS1xe72Hv
 zKE/J4+JQ5lOIwwUnFGb9im7yqxKvd3gvDSmjPH+4kVMFPrN/6tZJMT4JJNq77sPmVWT
 Yc+w==
X-Gm-Message-State: AOJu0YyeGvBrHmZYmB7MANA+1KUFR8PmPtOYeWIffAkXE2Ja6nCpUddf
 amh5yb6lcZsqbsShi19qknuHnFvTAD98AT/+lfHO3Cnz6BK5XIYyc/OdG05frWfobN59JxRVP0G
 aLAVN5KjLKzh5QUBo+dL3DhXSplkT+cr2c4/4
X-Google-Smtp-Source: AGHT+IGLMVspYYwA3PPsQYSaHY43yNZWxyr79KDasotxAn4JzlehVO6UUb7LYJ05gzENiCliLcw0dvTshrXkMP0R8xA=
X-Received: by 2002:a05:6122:1ad2:b0:4f2:f1f1:a9f2 with SMTP id
 71dfb90a1353d-4f4df68801bmr2309894e0c.4.1721222543769; Wed, 17 Jul 2024
 06:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240624101040.82726-1-phil@philjordan.eu>
 <CAJ+F1CJMzyWr3y7kEGcj2hE8fogLqH_PBcHkXYK=N28+t96OsQ@mail.gmail.com>
 <CAAibmn3s-+_21sUVf9w9HKVysTM9xgxYBq9Vg0+9iNMC1K7=QQ@mail.gmail.com>
 <CAJ+F1CJn_pJoT-bn1NCWcMsOhQhW0Gf3ks9pFJ-3FRdkv1tp6A@mail.gmail.com>
In-Reply-To: <CAJ+F1CJn_pJoT-bn1NCWcMsOhQhW0Gf3ks9pFJ-3FRdkv1tp6A@mail.gmail.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 17 Jul 2024 15:22:10 +0200
Message-ID: <CAAibmn3TKny=DSHR_ZdLztdVZj_EoLzSSF5HGjCAy+vvTx3JpQ@mail.gmail.com>
Subject: Re: [PATCH v2] Cursor: 8 -> 1 bit alpha downsampling improvement
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, akihiko.odaki@daynix.com, lists@philjordan.eu
Content-Type: multipart/alternative; boundary="0000000000004d1d4f061d715a67"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::e34;
 envelope-from=phil@philjordan.eu; helo=mail-vs1-xe34.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--0000000000004d1d4f061d715a67
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Jul 2024 at 15:20, Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmai=
l.com>
wrote:

> Hi
>
> On Wed, Jul 17, 2024 at 5:11=E2=80=AFPM Phil Dennis-Jordan <phil@philjord=
an.eu>
> wrote:
>
>>
>> Mouse cursors with 8 bit alpha were downsampled to 1-bit opacity maps by
>>>> turning alpha values of 255 into 1 and everything else into 0. This
>>>> means that mostly-opaque pixels ended up completely invisible.
>>>>
>>>> This patch changes the behaviour so that only pixels with less than 50=
%
>>>> alpha (0-127) are treated as transparent when converted to 1-bit alpha=
.
>>>>
>>>> This greatly improves the subjective appearance of anti-aliased mouse
>>>> cursors, such as those used by macOS, when using a front-end UI withou=
t
>>>> support for alpha-blended cursors, such as some VNC clients.
>>>>
>>>> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
>>>>
>>>
>>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>
>>
>> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>
>>
>> Thanks for the reviews folks! Is there anything I can do to move this
>> forward? Should I submit a v3 with the review tags included? The patch
>> continues to apply cleanly so it didn't seem necessary, but I admit I'm
>> still not 100% clear on whom I should badger (?) to get favourably recei=
ved
>> patches actually pulled into staging/master.
>>
>> https://patchew.org/QEMU/20240624101040.82726-1-phil@philjordan.eu/
>>
>>
> I'll include it in a UI-related PR.
>
> thanks
>

Thank you!

--0000000000004d1d4f061d715a67
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, 17 Jul 2024 at 15:20, Marc-An=
dr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@gmail.com">marcandre=
.lureau@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex"><div dir=3D"ltr"><div><div dir=3D"ltr">Hi<br></div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 1=
7, 2024 at 5:11=E2=80=AFPM Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@ph=
iljordan.eu" target=3D"_blank">phil@philjordan.eu</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><br><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><di=
v dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">Mouse cursors with 8 bit alpha were downsampled to 1-bit op=
acity maps by<br>
turning alpha values of 255 into 1 and everything else into 0. This<br>
means that mostly-opaque pixels ended up completely invisible.<br>
<br>
This patch changes the behaviour so that only pixels with less than 50%<br>
alpha (0-127) are treated as transparent when converted to 1-bit alpha.<br>
<br>
This greatly improves the subjective appearance of anti-aliased mouse<br>
cursors, such as those used by macOS, when using a front-end UI without<br>
support for alpha-blended cursors, such as some VNC clients.<br>
<br>
Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu"=
 target=3D"_blank">phil@philjordan.eu</a>&gt;<br></blockquote><div><br></di=
v><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;</d=
iv></div></div></blockquote><div><br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Reviewed-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.=
odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;</block=
quote><div><br></div><div>Thanks for the reviews folks! Is there anything I=
 can do to move this forward? Should I submit a v3 with the review tags inc=
luded? The patch continues to apply cleanly so it didn&#39;t seem necessary=
, but I admit I&#39;m still not 100% clear on whom I should badger (?) to g=
et favourably received patches actually pulled into staging/master.<br></di=
v><div><br></div><div><a href=3D"https://patchew.org/QEMU/20240624101040.82=
726-1-phil@philjordan.eu/" target=3D"_blank">https://patchew.org/QEMU/20240=
624101040.82726-1-phil@philjordan.eu/</a>=C2=A0</div><br></div></div></bloc=
kquote><div><br></div><div>I&#39;ll include it in a UI-related PR. <br></di=
v></div><br clear=3D"all"></div><div>thanks</div></div></blockquote><div><b=
r></div><div>Thank you! <br></div></div></div>

--0000000000004d1d4f061d715a67--

