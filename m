Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8A8CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 07:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBpKr-0003kd-Jr; Thu, 23 Oct 2025 03:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vBf0k-0000Dw-E4
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 16:00:42 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vBf0i-0005eh-JL
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 16:00:42 -0400
Received: by mail-ed1-x542.google.com with SMTP id
 4fb4d7f45d1cf-63e11cfb4a9so3617483a12.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 13:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761163237; x=1761768037; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XG6FuJLdSPLvb94o5n/OK/hHZm0hXL9XfEb5Zc6feWM=;
 b=GBG8SkN8TBPGTJXqBy7O+uScUv5wFzkeyCqrW9Jryu5Bk6w3jldSnDit2r5o8alzrQ
 ulvS41hrlcOG33sr3PKiS13hvUAbyBKBKQXWznW5dgye3Web4A3r6QJJ+lrtpjoguhK3
 i0V65kaSQtR4VZNdYJMOgFlvz3ynob9xidL95v/5f6dbCvuIAItag3DEDUgBGZcCvjdo
 Oz9Csxqa6shF94HI1QknfeQwXCfdOOkCfLeI0R3aBf6AcAZr3utF1Q7bUvKTkWgdGWhh
 q8BJgYn3DCBWNG6C8oIY/C+n9H2uR3S/mJZaox7iuuqoQ2v29UQmwsH0z6l1B+2DNxYZ
 i0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761163237; x=1761768037;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XG6FuJLdSPLvb94o5n/OK/hHZm0hXL9XfEb5Zc6feWM=;
 b=RwxfV6/KcSwNm79UzivJSr2mWCUONEoxcShHt3QuCIcDIG4ic4b7rSOWt7wtkEQI2L
 cfJk26M4QHqcghqozOGv/+r9LHDZ6kI3Xo4BxWtOE4CqfWNwVozUCpNvL8hCstmT2Cgd
 0Getv8PryWnG9YZf+Sw07nx74mZpgaPewuKbKiq2HGs/NIjcBUXM3BT9qwbaLbquHbQj
 HhNjKm5AT/hghZUzHSMksrXS1ibNXnlgRlEHiRZT/+adEI8/5iDsSsGXWQaswREfnmZu
 vvlTtWeEFMTC+lqzS0Cp2rFTpVH1BLlj8SvA/o/YWOMZT3ja9XVqzW9EuXf3udXL5Ho1
 Ye9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO8uzfv4qOopPXhVbjz55BcjzR46cZCsxA5YLJCZ9ptfEugIxlOynNOvOPJ3z/ihZS/JVrVX+OnugW@nongnu.org
X-Gm-Message-State: AOJu0Yyx4Fl1/7OA4+5zRjyUgFl6bUQx8l0DrXX4VZmCFEffkuLhcCmL
 uFsnsPHTLH1YV+9z/C6osIGGHFLgLsJFuRV4mxUeiiqbkbuUoq+tcOlQNc/jQ7Cp9JoMDqb2h6C
 LMOrBm5CarfEdUv2LPyMF8Detd/V7RI8=
X-Gm-Gg: ASbGncuC4j0Cn4BtYoFK6rp7KW7h4lq5KVInLvAg/sHlyQ73UNISIFFQR2d+c7+qrzD
 FZqqs6BI7PYkOiJVg5jb8GgIT1HVFycoxdsBarummLgybWXvPGEX+1v+3i4H7MTRGQMKtQXQuA+
 iZzvP2VXT/Wm8PhiFKYDRthyi2O3OIKhWlrkSxBf7hPU7VfKXOb7medu2d1cKVGidCcTICpFqdp
 15wlnF2sl8+FHFBTNfDKrOGMrL3QcF1lCEHketVeEVtB2Q9bEzTk0nQpgLPv0kq1QslEpTBY7qC
 3NJDkKG923kKKEaT3SZeQdNXesIghgAYPfzMTCqnpC6MzCD90Wk=
X-Google-Smtp-Source: AGHT+IFVjHS2iJacrXvSgimK092DVjkg1+MYVNAtliznDCUWBjMS045i1yclySTIMEE3YTp2AHS1M2Rl3HQQvgsT1GU=
X-Received: by 2002:a05:6402:5c8:b0:63c:b6d:240f with SMTP id
 4fb4d7f45d1cf-63c1f6c411amr19663764a12.31.1761163236671; Wed, 22 Oct 2025
 13:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20251017200653.23337-1-deller@kernel.org>
 <20251017200653.23337-3-deller@kernel.org>
 <e9a945e3-3280-4c25-82be-557c322b3e5d@linaro.org>
In-Reply-To: <e9a945e3-3280-4c25-82be-557c322b3e5d@linaro.org>
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Date: Thu, 23 Oct 2025 01:30:24 +0530
X-Gm-Features: AS18NWBsxBzVjDZZA7_KwFefgm-2rpD2Sh01u3u5Epc6ea5mTCQBD5W0CgqAUb0
Message-ID: <CAGkZZ+sdERjKgkk=K3Bb+BrLRA6CJVCciLvcu0Nb2K=b03UOJQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] ncr710: Add driver for the NCR 53c710 SCSI chip
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: deller@kernel.org, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>
Content-Type: multipart/alternative; boundary="0000000000001d02f40641c4c539"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-ed1-x542.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Oct 2025 03:01:48 -0400
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

--0000000000001d02f40641c4c539
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 12:50=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philm=
d@linaro.org>
wrote:

> On 17/10/25 22:06, deller@kernel.org wrote:
> > From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
> >
> > Add an emulation for the NCR 53c710 SCSI chip.
> > This SCSI chip was used widely in historic machines, e.g. as SCSI core
> > in the LASI controller in HP PA-RISC machines.
> >
> > This driver was developed during the Google Summer of Code 2025 program=
.
> >
> > Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
> > Signed-off-by: Helge Deller <deller@gmx.de>
> > ---
> >   hw/scsi/lasi_ncr710.c |  303 +++++
> >   hw/scsi/lasi_ncr710.h |   53 +
> >   hw/scsi/ncr53c710.c   | 2477 ++++++++++++++++++++++++++++++++++++++++=
+
>
> This is really huge.


Dear Philippe,
Certainly, since its a new driver, which is similar in size (ie in lines)
like other SCSI drivers:
  2431:: lsi53c895a.c
  2580:: megasas.c
Also considering the LASI wrapper interface for it to interact.
Which is required for our NCR710 core to function.

I would request you to refer to v3 of the patch, in which we have broken
down the initial patch into #2a and #2b.
Thank you,
Soumyajyotii

>
>
>   hw/scsi/ncr53c710.h   |  270 +++++
> >   hw/scsi/trace-events  |   33 +
> >   5 files changed, 3136 insertions(+)
> >   create mode 100644 hw/scsi/lasi_ncr710.c
> >   create mode 100644 hw/scsi/lasi_ncr710.h
> >   create mode 100644 hw/scsi/ncr53c710.c
> >   create mode 100644 hw/scsi/ncr53c710.h
>
>

--0000000000001d02f40641c4c539
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div dir=3D"ltr"><div dir=3D"lt=
r"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Thu, Oct 23, 2025 at 12:50=E2=80=AFAM Philippe Mathieu-Daud=C3=A9=
 &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank">philmd@linaro.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On 17/10/25 22:06, <a href=3D"mailto:deller@kernel.org" target=3D"_blank"=
>deller@kernel.org</a> wrote:<br>
&gt; From: Soumyajyotii Ssarkar &lt;<a href=3D"mailto:soumyajyotisarkar23@g=
mail.com" target=3D"_blank">soumyajyotisarkar23@gmail.com</a>&gt;<br>
&gt; <br>
&gt; Add an emulation for the NCR 53c710 SCSI chip.<br>
&gt; This SCSI chip was used widely in historic machines, e.g. as SCSI core=
<br>
&gt; in the LASI controller in HP PA-RISC machines.<br>
&gt; <br>
&gt; This driver was developed during the Google Summer of Code 2025 progra=
m.<br>
&gt; <br>
&gt; Signed-off-by: Soumyajyotii Ssarkar &lt;<a href=3D"mailto:soumyajyotis=
arkar23@gmail.com" target=3D"_blank">soumyajyotisarkar23@gmail.com</a>&gt;<=
br>
&gt; Signed-off-by: Helge Deller &lt;<a href=3D"mailto:deller@gmx.de" targe=
t=3D"_blank">deller@gmx.de</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/scsi/lasi_ncr710.c |=C2=A0 303 +++++<br>
&gt;=C2=A0 =C2=A0hw/scsi/lasi_ncr710.h |=C2=A0 =C2=A053 +<br>
&gt;=C2=A0 =C2=A0hw/scsi/ncr53c710.c=C2=A0 =C2=A0| 2477 +++++++++++++++++++=
++++++++++++++++++++++<br>
<br>
This is really huge.</blockquote><div><br></div><div>Dear Philippe,=C2=A0</=
div><div>Certainly, since its a new driver, which is similar in size (ie in=
 lines) like other SCSI drivers:</div><div dir=3D"auto"><div dir=3D"auto">=
=C2=A0 2431:: lsi53c895a.c</div><div dir=3D"auto">=C2=A0 2580:: megasas.c</=
div><div dir=3D"auto">Also considering the LASI wrapper interface for it to=
 interact.</div><div dir=3D"auto">Which is required for our NCR710 core to =
function.</div><div><br></div><div dir=3D"auto"><div dir=3D"auto">I would r=
equest you to refer to v3 of the patch, in which we have broken down the in=
itial patch into #2a and #2b.</div><div dir=3D"auto">Thank you,</div><div d=
ir=3D"auto">Soumyajyotii</div></div></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">=C2=A0<br></blockquote><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
&gt;=C2=A0 =C2=A0hw/scsi/ncr53c710.h=C2=A0 =C2=A0|=C2=A0 270 +++++<br>
&gt;=C2=A0 =C2=A0hw/scsi/trace-events=C2=A0 |=C2=A0 =C2=A033 +<br>
&gt;=C2=A0 =C2=A05 files changed, 3136 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/scsi/lasi_ncr710.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/scsi/lasi_ncr710.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/scsi/ncr53c710.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/scsi/ncr53c710.h<br>
<br>
</blockquote></div></div>
</div>

--0000000000001d02f40641c4c539--

