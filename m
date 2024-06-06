Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE6AC27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 14:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFDfO-0001S6-F7; Thu, 06 Jun 2024 10:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sFDfF-0001JA-2b; Thu, 06 Jun 2024 10:00:26 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sFDfC-0002Us-JL; Thu, 06 Jun 2024 10:00:24 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57a7dc13aabso1230770a12.0; 
 Thu, 06 Jun 2024 07:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717682418; x=1718287218; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OuysbczA2AOZKq7qXjXbjISEK3yoS23lBFuqU5TwJ4Y=;
 b=ceJiW55zjbsJ4kLDegTp1xjvWJncQjcqG/XSAyFr3+LIgSzJQt/WF2l9q9Sb41BVty
 K4P6niRYvt5mT8K/xCEybQtS+52sokYdLInRbc/o6XIMRqnLd0ezaFyjR4ZOwPjFh/0Z
 DBQBmRRmZsAe67KsUs2SiYNUDd4KPvu1r3HSc9VtdtLF23K1QonUC4DxfDJeElzGBYJw
 2nXsUOkgaLH1SrhKBwQQ17epNrFQwciL47f2ehin+TYINF1LRqRdnLu4olCUf2gjzMXW
 FAgtCDIcuU+ZH/v5a0BV1MG65jV9OZxs0bRj1c6br93bSP+CmvveZPKk+BjL5HaKFWiq
 xurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717682418; x=1718287218;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OuysbczA2AOZKq7qXjXbjISEK3yoS23lBFuqU5TwJ4Y=;
 b=tFJBbCXZsNm7ReYBIKUVkJcVLSJ5PadMKjH65pGg7rKJGTOPEFC6d3FV8Pe8WQyk4B
 65/E8U6bone+poflqZaRWQUDVKcBlf6EYlSKKeVu00LeySEboGi6H/ydf4nMZwU0MyYn
 Rc4pWD+KFgLhMfsX3fQRBWWLX98bugAfsU9Y+QQAM1wVi8jtTlUml2yfn3Ow8Bb3Cggi
 Rjxitiogi4Wh6i+k7eG0yqPfQDZAU7+qFG1/zSFNLu/FTai4JqSIoU7Qt/YnjHv/cIG9
 8l8o5rdJTXr7AqGb/Txx0ayu0io8TQzG3Gpb4rfMObXja7z4OOqlwX8Exb8G7e7IpESF
 0LDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSqo1PMeuqrPIoSQ+vbh/hLMtsAVDDe7u9NfJBO9uXZLjkqweE7QZoZLZAlbPn8I1hKDQaEhbbNpsoH9l2yO9qldcwnRlvUrqMg/X1916XzstpaCiZn41hsVs=
X-Gm-Message-State: AOJu0YzTpACj5bIw2ZnP0adaNPYQ5xt2Ekhbc2xwBukLydgXDP05K+G9
 7EENsIMappiKadUDiwGV0wNuDUxNvLtREL9JpAeZpV/QNWCNY+xZt/cbI9lH0RYPr3emgcJKUbq
 eYaJmKht+VQUVwcji5XPUSyK2Zbk=
X-Google-Smtp-Source: AGHT+IFPOTI7CyWhw0HQ9wI4jiR230g7W7TbhiOz9I5IFdH4Uox3PS2veSDJ7c2UJ+1VyaIkylxoPM4Fa9Vn47rBlJI=
X-Received: by 2002:a50:c303:0:b0:57a:2de8:c47d with SMTP id
 4fb4d7f45d1cf-57a8b6b88b6mr3350565a12.21.1717682417392; Thu, 06 Jun 2024
 07:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240606095952.2133-1-andrew.yuan@jaguarmicro.com>
 <CAJy5ezqq51bJG4O9HA-Pv4sw9rYqGdFW-EezCRPfDbTx=9SwyQ@mail.gmail.com>
 <CAFEAcA8fSS-qt6KmN_06uEMXddjbqjATh-FkUJVSrPuiu50+PQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8fSS-qt6KmN_06uEMXddjbqjATh-FkUJVSrPuiu50+PQ@mail.gmail.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 6 Jun 2024 16:00:05 +0200
Message-ID: <CAJy5ezobs9UUd37a05BtV_5Jm=B_jhsPuv068L-j=qAWGvZ72w@mail.gmail.com>
Subject: Re: [PATCH] hw/net: cadence_gem: fix: type2_compare_x_word_0 error
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Andrew.Yuan" <andrew.yuan@jaguarmicro.com>, luc.michel@amd.com,
 alistair@alistair23.me, 
 jasowang@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000536a0f061a391ace"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000536a0f061a391ace
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 2:06=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org>
wrote:

> On Thu, 6 Jun 2024 at 12:04, Edgar E. Iglesias <edgar.iglesias@gmail.com>
> wrote:
> >
> > On Thu, Jun 6, 2024 at 12:00=E2=80=AFPM Andrew.Yuan <andrew.yuan@jaguar=
micro.com>
> wrote:
> >>
> >>         In the Cadence IP for Gigabit Ethernet MAC Part Number: IP7014
> IP Rev: R1p12 - Doc Rev: 1.3 User Guide, the specification for the
> type2_compare_x_word_0 register is as follows:
> >>         The byte stored in bits [23:16] is compared against the byte i=
n
> the received frame from the selected offset+0, and the byte stored in bit=
s
> [31:24] is compared against the byte in
> >>         the received frame from the selected offset+1.
> >>
> >>         However, there is an implementation error in the cadence_gem
> model in qemu=EF=BC=9A
> >>         the byte stored in bits [31:24] is compared against the byte i=
n
> the received frame from the selected offset+0
> >>
> >>         Now, the error code is as follows:
> >>         rx_cmp =3D rxbuf_ptr[offset] << 8 | rxbuf_ptr[offset];
> >>
> >>         and needs to be corrected to=EF=BC=9A
> >>         rx_cmp =3D rxbuf_ptr[offset + 1] << 8 | rxbuf_ptr[offset];
> >>
> >> Signed-off-by: Andrew.Yuan <andrew.yuan@jaguarmicro.com>
> >
> >
> >
> > LGTM:
> > Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> >
> > At some point it would be nice to add the missing logic for the
> DISABLE_MASK bit that
> > extends the compare range from 16 to 32-bits.
>
> I had a look at this device's code, and I'm trying to
> figure out how we know at this point that there really are
> two bytes pointed to by rxbuf_ptr.
>  * The get_queue_from_screen() function takes a rxbufsize
>    argument, but it never uses it...
>  * the callsite in gem_receive() will (in the "strip FCS" case)
>    pass its buf argument as rxbuf_ptr, but it will use a
>    rxbufsize argument which has been raised to at least
>    GEM_DMACFG_RBUFSZ_MUL, even if the input size argument
>    is smaller, so even if get_queue_from_screen() honoured
>    its rxbufsize argument it wouldn't help
>
> Would somebody who understands the device like to have a look ?
>
>
Yes, I agree that it looks strange. The padding to minimum 60B seems wrong
since we're blindly extending buf from something less than 60B to 60B
and then potentially copying from it...

Cheers,
Edgar


> This is a separate issue from the incorrect array offset
> argument this patch fixes, though.
>
> thanks
> -- PMM
>

--000000000000536a0f061a391ace
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, Jun 6, 2024 at 2:06=E2=80=AFPM Pe=
ter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@l=
inaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Thu, 6 Jun 2024 at 12:04, Edgar E. I=
glesias &lt;<a href=3D"mailto:edgar.iglesias@gmail.com" target=3D"_blank">e=
dgar.iglesias@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Thu, Jun 6, 2024 at 12:00=E2=80=AFPM Andrew.Yuan &lt;<a href=3D"mai=
lto:andrew.yuan@jaguarmicro.com" target=3D"_blank">andrew.yuan@jaguarmicro.=
com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0In the Cadence IP for Gigabit Eth=
ernet MAC Part Number: IP7014 IP Rev: R1p12 - Doc Rev: 1.3 User Guide, the =
specification for the type2_compare_x_word_0 register is as follows:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The byte stored in bits [23:16] i=
s compared against the byte in the received frame from the selected offset+=
0, and the byte stored in bits [31:24] is compared against the byte in<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the received frame from the selec=
ted offset+1.<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0However, there is an implementati=
on error in the cadence_gem model in qemu=EF=BC=9A<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the byte stored in bits [31:24] i=
s compared against the byte in the received frame from the selected offset+=
0<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Now, the error code is as follows=
:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rx_cmp =3D rxbuf_ptr[offset] &lt;=
&lt; 8 | rxbuf_ptr[offset];<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and needs to be corrected to=EF=
=BC=9A<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rx_cmp =3D rxbuf_ptr[offset + 1] =
&lt;&lt; 8 | rxbuf_ptr[offset];<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Andrew.Yuan &lt;<a href=3D"mailto:andrew.yuan@jagua=
rmicro.com" target=3D"_blank">andrew.yuan@jaguarmicro.com</a>&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; LGTM:<br>
&gt; Reviewed-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@am=
d.com" target=3D"_blank">edgar.iglesias@amd.com</a>&gt;<br>
&gt;<br>
&gt; At some point it would be nice to add the missing logic for the DISABL=
E_MASK bit that<br>
&gt; extends the compare range from 16 to 32-bits.<br>
<br>
I had a look at this device&#39;s code, and I&#39;m trying to<br>
figure out how we know at this point that there really are<br>
two bytes pointed to by rxbuf_ptr.<br>
=C2=A0* The get_queue_from_screen() function takes a rxbufsize<br>
=C2=A0 =C2=A0argument, but it never uses it...<br>
=C2=A0* the callsite in gem_receive() will (in the &quot;strip FCS&quot; ca=
se)<br>
=C2=A0 =C2=A0pass its buf argument as rxbuf_ptr, but it will use a<br>
=C2=A0 =C2=A0rxbufsize argument which has been raised to at least<br>
=C2=A0 =C2=A0GEM_DMACFG_RBUFSZ_MUL, even if the input size argument<br>
=C2=A0 =C2=A0is smaller, so even if get_queue_from_screen() honoured<br>
=C2=A0 =C2=A0its rxbufsize argument it wouldn&#39;t help<br>
<br>
Would somebody who understands the device like to have a look ?<br>
<br></blockquote><div><br></div><div>Yes, I agree that it looks strange. Th=
e padding to minimum 60B seems wrong</div><div>since we&#39;re blindly exte=
nding buf from something less than 60B to 60B</div><div>and then potentiall=
y copying from it...</div><div><br></div><div>Cheers,</div><div>Edgar</div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
This is a separate issue from the incorrect array offset<br>
argument this patch fixes, though.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div>

--000000000000536a0f061a391ace--

