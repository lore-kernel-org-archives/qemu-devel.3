Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C890FD14885
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 01:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdeYp-0007el-Er; Wed, 07 Jan 2026 20:11:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lihang.lin@gmail.com>)
 id 1vdeYg-0007Xs-HO
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 20:11:27 -0500
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lihang.lin@gmail.com>)
 id 1vdeYe-0005gA-Pe
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 20:11:26 -0500
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-93a9f6efe8bso852625241.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 17:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767834683; x=1768439483; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dmHpd79keWMrZZPoORCBooQhCA7EAOxNXLiaEJ7ICW0=;
 b=cfK88zr/Uyne2uC9yiOUjJkcG4nC9h5jVN3QDx4EKqI83X/htb4x7afVjCJfzcBUgl
 QW5ns5qCVf4gwCmEwDclQrNagU4qlKNt1AgNA5JrwW9M94acJWjvEIC+mwIEcpFNWhG4
 zBn8EmRi/KF9bd/szI7QfQf4AqM31odv2gHqtfIE5V+Va/nji4LnHrtnn8iSvDG2zgTB
 daFLFDJWVkSKt2WICWwhQ/0G+cH5ATm4iW7/h//UlWuQ8+Ze3L6bwDMVrX0C/GzA6gwa
 Djg2d/3NsHnsQ/yqsOnOlkbHAkSC1b+rVF1hqqkSYBkEwaPBtDlYrLxT+o25SdUcWyPe
 WDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767834683; x=1768439483;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dmHpd79keWMrZZPoORCBooQhCA7EAOxNXLiaEJ7ICW0=;
 b=Z1ycjf1Tx2MjToKNhaENnkVnwtANIH1eYJKiS/yksrIOcPMXFPsFXzdKJI3mqTZ+M4
 QciJknquIHPZiQJCvJ4mcdEbarvWNow+cg9++KFJrGosc6BPvIABqX3loq0P5BXv+3Jo
 bmryVE8UhjCID6xki/6FAWYE28mlaPxEjUhV/OWonkN9pTvHGKTsCXNue3rhbR4wQ5NI
 2Kf4mxYuwtk2zNZJu5Vc6yXQFq6dI5DgjyQRXQQKQsIoQDxVkjavOOUHbnedjqewcebJ
 fRQiYwF/V/DUyaw8wV8f26orArGTswTHpVozqrd2IuHpBw+R2TeuwZAUS9vKoqGk/uUT
 79sQ==
X-Gm-Message-State: AOJu0Yxj01nRxhr2Wc7ScyFlFOg6RuVymd23/jlpsHjUCm4taAuC5xDN
 VDanh4IEBv5FBXBb2VBx81Dy0jZvHWi3n7D/EkphfZwqxsoIGYfm25R0U3KiNyQoAI48dMQxb1e
 k9NlIgKBDXj30XyJLbs7hXGdGrMF8GRY=
X-Gm-Gg: AY/fxX5mFij5L2TBBu/UA9Ptn8UDb6g/CZf4FDftqFR5l96VsnOVlBh3WAF+9R9no9G
 K7PKi1ACiRjpKU2D1r06cltGjkteUzzYVzaQAEaFw2LZXLgyLxhl1eGx/tWVF9XIRpTehPo6Sb3
 YYJ/3z8RlIG3nhppr0FcFpcUh6xYe7ZM3ind6vPNwgQT79J8TLk1rSjqabFGTKJ5J76WZXcrBc+
 OLjGEqjQ4Ph+/KK4CcfqD4Ur3lpDRdp/JRw8qM8BdGalKq4aYrMQOvZVAxeyfWeSGBkno8LiOif
 oZ4VikJBbfvwkuSQ8vVYlyUPNnqdr4uuNZlm
X-Google-Smtp-Source: AGHT+IGxnscBaiTFamR4drYd59aywIO5Yt61atMdcn/XShBd+0AY2vJ2v2mDP77naLg6ygxkAgErYnU1rHBE27rEQnE=
X-Received: by 2002:a05:6102:4412:b0:5df:99d3:d9a5 with SMTP id
 ada2fe7eead31-5ecb1e72970mr1440405137.4.1767834683261; Wed, 07 Jan 2026
 17:11:23 -0800 (PST)
MIME-Version: 1.0
References: <20251226064225.791454-1-lihang.lin@gmail.com>
 <CAFEAcA_ovy2HzhVTKJiRNaZvVQ3qvkw0Pres0HZ+TFJjx1wc3g@mail.gmail.com>
 <CAPR+-WF6uSsm6nBY7jmmxKEMSHR3t+d4KG5KAtsDNJPxen-r9A@mail.gmail.com>
In-Reply-To: <CAPR+-WF6uSsm6nBY7jmmxKEMSHR3t+d4KG5KAtsDNJPxen-r9A@mail.gmail.com>
From: Lin Li-Hang <lihang.lin@gmail.com>
Date: Thu, 8 Jan 2026 09:11:11 +0800
X-Gm-Features: AQt7F2qHE1HPF7k1yh0lECYo-JU3y9fAA3NfyrgaYhJwQ_YAgqy_1mHwqrPmLrU
Message-ID: <CAPR+-WFBGNDefo+g=po+VX3PWZ-QdjQZvDjs-JpvyUaNAct7hw@mail.gmail.com>
Subject: Re: [PATCH] target/arm/tcg/vfp_helper: Fix incorrect bit field
 deposition in rsqrte_f64
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000005147270647d6167f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=lihang.lin@gmail.com; helo=mail-ua1-x930.google.com
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

--0000000000005147270647d6167f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Is my patch good for you?

Cheers


On Mon, Dec 29, 2025 at 12:19=E2=80=AFPM Lin Li-Hang <lihang.lin@gmail.com>=
 wrote:

> Hi Peter,
>
> Thank you for your reply.
>
> I initially identified this error while reviewing the code and was curiou=
s
> why it hadn't caused any bugs.
> After further testing, it appears the original code behaved correctly by
> coincidence.
>
> The ASL code in the ARM ARM for FRSQRTE states:
>
> ```
> elsif sign =3D=3D '1' then
>          result =3D FPDefaultNaN(fpcr, N);
>          if fpexc then FPProcessException(FPExc_InvalidOp, fpcr);
> ```
>
> As it turns out, the sign bit must be zero by the time it reaches the
> final deposition code, which explains why the incorrect bit placement did
> not surface as a functional bug.
>
>
> On Mon, Dec 29, 2025 at 1:15=E2=80=AFAM Peter Maydell <peter.maydell@lina=
ro.org>
> wrote:
>
>> On Fri, 26 Dec 2025 at 06:43, Li-Hang Lin <lihang.lin@gmail.com> wrote:
>> >
>> > Fix an error in rsqrte_f64() where the sign bit was being
>> > placed incorrectly. Specifically, ensure f64_sign is deposited
>> > into bit 63.
>> >
>> > Additionally, update the comments regarding the exponent (exp) bit
>> > width to reflect the correct double-precision specifications.
>>
>> This seems like it would produce incorrect results -- do you
>> have an example of an instruction plus input data values that p
>> produces a different output value to the hardware?
>>
>> thanks
>> -- PMM
>>
>

--0000000000005147270647d6167f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi=C2=A0Peter,</div><div><br></div><div>Is my patch g=
ood for you?</div><div><br></div><div><div dir=3D"ltr" class=3D"gmail_signa=
ture" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Cheers<br></div><=
/div></div><br></div><br><div class=3D"gmail_quote gmail_quote_container"><=
div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 29, 2025 at 12:19=E2=80=AF=
PM Lin Li-Hang &lt;<a href=3D"mailto:lihang.lin@gmail.com">lihang.lin@gmail=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><div dir=3D"ltr"><div>Hi Peter,</div><div><br></div><div>Thank you for =
your reply.</div><div><br></div><div>I initially identified this error whil=
e reviewing the code and was curious why it hadn&#39;t caused any bugs.</di=
v><div>After further testing, it appears the original code behaved correctl=
y by coincidence.</div><div><br></div><div>The ASL code in the ARM ARM for =
FRSQRTE states:</div><div><br></div><div>```</div><div>elsif sign =3D=3D &#=
39;1&#39; then</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result =3D FPDef=
aultNaN(fpcr, N);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if fpexc then=
 FPProcessException(FPExc_InvalidOp, fpcr);</div><div>```</div><div><br></d=
iv><div>As it turns out, the sign bit must be zero by the time it reaches t=
he final deposition code, which explains why the incorrect bit placement di=
d not surface as a functional bug.</div><div><br></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 29, 2025=
 at 1:15=E2=80=AFAM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linar=
o.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On Fri, 26 Dec 2025 at 06:=
43, Li-Hang Lin &lt;<a href=3D"mailto:lihang.lin@gmail.com" target=3D"_blan=
k">lihang.lin@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Fix an error in rsqrte_f64() where the sign bit was being<br>
&gt; placed incorrectly. Specifically, ensure f64_sign is deposited<br>
&gt; into bit 63.<br>
&gt;<br>
&gt; Additionally, update the comments regarding the exponent (exp) bit<br>
&gt; width to reflect the correct double-precision specifications.<br>
<br>
This seems like it would produce incorrect results -- do you<br>
have an example of an instruction plus input data values that p<br>
produces a different output value to the hardware?<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>
</blockquote></div>

--0000000000005147270647d6167f--

