Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA74C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 15:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOfs2-0003ia-0t; Tue, 02 Jul 2024 11:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOfs0-0003i0-1X; Tue, 02 Jul 2024 11:56:40 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOfru-0004OK-Na; Tue, 02 Jul 2024 11:56:39 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-58b0dddab8cso2253846a12.0; 
 Tue, 02 Jul 2024 08:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719935790; x=1720540590; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P3lquXr5QXS9jyPyNuj8cd5vUM6EcvLnI4W8+p6aEHA=;
 b=Qb7ap20kDIyMVku3n8GpAGmW0A1i1RIz/LO+FrjU7fRrhLIUYweBUCJFzxwGoVuqp9
 qiobcF4LcUA8OBnp+uW2w9GKQuwIfV6SNY80cwlpD9ufw8gWnsCRZ75k67KnJNnL/QsQ
 vQEAKtaFnuCHtDbQ91gxhxW2D6zxNsQ1jC7aMsrdqQStRL0fKItrOnpkuEznr7Ouvip6
 4aEixhrPkvFCGQQHbzpAr76nfU5opgJ/Mgj80+JYg7B148fzJfZVIrboUmry1trpopDp
 qoZdLVN8ghYeyZr7sJYDRPU9Kbcq/XKAfKdBbobXWiHyEAUzm7kn9kh4cX0GobOhM2a/
 i31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719935790; x=1720540590;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P3lquXr5QXS9jyPyNuj8cd5vUM6EcvLnI4W8+p6aEHA=;
 b=ZBD1pdvcbwMpVMwrndXGtrb7UZUW1Bo6xjmOSpyGI4/92nmO0cH4DQBjc/qJNIJKw8
 U5r/qRCbcs4AnTTP8XT9vMG9OOUSYgd/6hQpPOG4tlJpqqyVGXWkrKn0yR6mu9UWthhM
 WlKUXDROPOuWutBN7x6nJadrYYbda835aNeYswBoLDJR43ICMKqsH8JhrEE3Z2wcMxxS
 uiy9hBkwT5DHJErViK1+1Xb5b1VCLw+MiVGX0VeXFhdpH6p2UaZM95gmpWOshBQu95cq
 0WgDpVcrulD33lr8MpGOY9JL5lVyocQh2R0yDS3spBcUtpRdQBi+T+1LCiwoIA3b2mmm
 nPPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdPpVQQFnPLNILfF/dSDhzc72n883GL9mPoFsWPCv4pPYUdh+lJI4XaFfQopU03ouG1uzK3SdXCV+tQpgNqUUNvCGIkbnZBa6eZxupkokxuNdi5ObAjcet2uI=
X-Gm-Message-State: AOJu0YwXPjud7FsQ641ytRPj1tQho1Ays9B+cwDivOl15jfKucuy7IJZ
 hg67Sd1zrFrtyDR+E8wJQtuprcgFJ4bYzg5UpVlMx5Fby1evBT0YHJlg+/W+ACy4XK1hv2WtJvV
 +z/5eAtzYvblQ15UYF792Tegf6A==
X-Google-Smtp-Source: AGHT+IGOv+etiMa4XP3opxZ44KBLqO5olvjnR/HaIkSJPy34hVO7uJeLTCqD4yE7Cz2lE7omzOZdhtJzCTUVro1V5qQ=
X-Received: by 2002:a17:906:da04:b0:a68:b557:76f5 with SMTP id
 a640c23a62f3a-a7514498a74mr545196466b.69.1719935790212; Tue, 02 Jul 2024
 08:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240702152750.3017426-1-zheyuma97@gmail.com>
 <b72e40c9-c2de-487c-a9ad-a52c1f286d77@linaro.org>
 <42fbede9-89fa-469e-bec5-b3d414c4e42f@linaro.org>
In-Reply-To: <42fbede9-89fa-469e-bec5-b3d414c4e42f@linaro.org>
From: Zheyu Ma <zheyuma97@gmail.com>
Date: Tue, 2 Jul 2024 17:56:18 +0200
Message-ID: <CAMhUBjnrV=DNZKCNZ1_TNq8_+YTD6QEoBK1AV=+qD33LTaWJXg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/char/pl011: Avoid division-by-zero in
 pl011_get_baudrate()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000cfeff3061c45c1a9"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=zheyuma97@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000cfeff3061c45c1a9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Tue, Jul 2, 2024 at 5:44=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> On 2/7/24 17:40, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Zheyu,
> >
> > On 2/7/24 17:27, Zheyu Ma wrote:
> >> In pl011_get_baudrate(), when we calculate the baudrate we can
> >> accidentally divide by zero. This happens because although (as the
> >> specification requires) we treat UARTIBRD =3D 0 as invalid, we aren't
> >> correctly limiting UARTIBRD and UARTFBRD values to the 16-bit and 6-bi=
t
> >> ranges the hardware allows, and so some non-zero values of UARTIBRD ca=
n
> >> result in a zero divisor.
> >>
> >> Enforce the correct register field widths on guest writes and on inbou=
nd
> >> migration to avoid the division by zero.
> >>
> >> ASAN log:
> >> =3D=3D2973125=3D=3DERROR: AddressSanitizer: FPE on unknown address
> 0x55f72629b348
> >> (pc 0x55f72629b348 bp 0x7fffa24d0e00 sp 0x7fffa24d0d60 T0)
> >>      #0 0x55f72629b348 in pl011_get_baudrate hw/char/pl011.c:255:17
> >>      #1 0x55f726298d94 in pl011_trace_baudrate_change
> >> hw/char/pl011.c:260:33
> >>      #2 0x55f726296fc8 in pl011_write hw/char/pl011.c:378:9
> >>
> >> Reproducer:
> >> cat << EOF | qemu-system-aarch64 -display \
> >> none -machine accel=3Dqtest, -m 512M -machine realview-pb-a8 -qtest st=
dio
> >> writeq 0x1000b024 0xf8000000
> >> EOF
> >>
> >> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> >> ---
> >> Changes in v2:
> >> - Enforce the correct register field widths on writes to both UARTIBRD
> >>    and UARTFBRD registers.
> >> - Mask UARTIBRD to 16 bits and UARTFBRD to 6 bits in the pl011_post_lo=
ad
> >>    function to prevent division by zero during inbound migration.
> >> ---
> >>   hw/char/pl011.c | 7 +++++--
> >>   1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> >> index 8753b84a84..ba5f7cfbda 100644
> >> --- a/hw/char/pl011.c
> >> +++ b/hw/char/pl011.c
> >> @@ -374,11 +374,11 @@ static void pl011_write(void *opaque, hwaddr
> >> offset,
> >>           s->ilpr =3D value;
> >>           break;
> >>       case 9: /* UARTIBRD */
> >> -        s->ibrd =3D value;
> >> +        s->ibrd =3D value & 0xffff;
> >
> > LGTM but could you add a definition instead of these magic values?
> >
> > Similarly to the ones in the top if this file:
> >
> >    /* Flag Register, UARTFR */
> >    #define PL011_FLAG_RI   0x100
> >    #define PL011_FLAG_TXFE 0x80
> >    ...
> >
> >    /* Integer Baud Rate Divider, UARTIBRD */
> >    #define IBRD_MASK 0x3f
> >
> >    /* Fractional Baud Rate Divider, UARTFBRD */
> >    #define FBRD_MASK 0xffff
> >
> > Then use these definitions :)
>
> Since I have the patch, let's share it to save you some time:
>
> -- >8 --
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index 8753b84a84..7f9a85708e 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -87,6 +87,12 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq,
> Chardev *chr)
>   #define CR_DTR      (1 << 10)
>   #define CR_LBE      (1 << 7)
>
> +/* Integer Baud Rate Divider, UARTIBRD */
> +#define IBRD_MASK 0x3f
> +
> +/* Fractional Baud Rate Divider, UARTFBRD */
> +#define FBRD_MASK 0xffff
> +
>   static const unsigned char pl011_id_arm[8] =3D
>     { 0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1 };
>   static const unsigned char pl011_id_luminary[8] =3D
> @@ -374,11 +380,11 @@ static void pl011_write(void *opaque, hwaddr offset=
,
>           s->ilpr =3D value;
>           break;
>       case 9: /* UARTIBRD */
> -        s->ibrd =3D value;
> +        s->ibrd =3D value & IBRD_MASK;
>           pl011_trace_baudrate_change(s);
>           break;
>       case 10: /* UARTFBRD */
> -        s->fbrd =3D value;
> +        s->fbrd =3D value & FBRD_MASK;
>           pl011_trace_baudrate_change(s);
>           break;
>       case 11: /* UARTLCR_H */
> @@ -531,6 +537,9 @@ static int pl011_post_load(void *opaque, int
> version_id)
>           s->read_pos =3D 0;
>       }
>
> +    s->ibrd &=3D IBRD_MASK;
> +    s->fbrd &=3D FBRD_MASK;
> +
>       return 0;
>   }
>

Thanks for your helpful patch :)

regards,
Zheyu

--000000000000cfeff3061c45c1a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi=C2=A0Philippe,</div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 2, 2024 at 5=
:44=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 2/7/24 17:40, Philippe Mathieu-Daud=C3=A9 wrot=
e:<br>
&gt; Hi Zheyu,<br>
&gt; <br>
&gt; On 2/7/24 17:27, Zheyu Ma wrote:<br>
&gt;&gt; In pl011_get_baudrate(), when we calculate the baudrate we can<br>
&gt;&gt; accidentally divide by zero. This happens because although (as the=
<br>
&gt;&gt; specification requires) we treat UARTIBRD =3D 0 as invalid, we are=
n&#39;t<br>
&gt;&gt; correctly limiting UARTIBRD and UARTFBRD values to the 16-bit and =
6-bit<br>
&gt;&gt; ranges the hardware allows, and so some non-zero values of UARTIBR=
D can<br>
&gt;&gt; result in a zero divisor.<br>
&gt;&gt;<br>
&gt;&gt; Enforce the correct register field widths on guest writes and on i=
nbound<br>
&gt;&gt; migration to avoid the division by zero.<br>
&gt;&gt;<br>
&gt;&gt; ASAN log:<br>
&gt;&gt; =3D=3D2973125=3D=3DERROR: AddressSanitizer: FPE on unknown address=
 0x55f72629b348<br>
&gt;&gt; (pc 0x55f72629b348 bp 0x7fffa24d0e00 sp 0x7fffa24d0d60 T0)<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 #0 0x55f72629b348 in pl011_get_baudrate h=
w/char/pl011.c:255:17<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 #1 0x55f726298d94 in pl011_trace_baudrate=
_change <br>
&gt;&gt; hw/char/pl011.c:260:33<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 #2 0x55f726296fc8 in pl011_write hw/char/=
pl011.c:378:9<br>
&gt;&gt;<br>
&gt;&gt; Reproducer:<br>
&gt;&gt; cat &lt;&lt; EOF | qemu-system-aarch64 -display \<br>
&gt;&gt; none -machine accel=3Dqtest, -m 512M -machine realview-pb-a8 -qtes=
t stdio<br>
&gt;&gt; writeq 0x1000b024 0xf8000000<br>
&gt;&gt; EOF<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Zheyu Ma &lt;<a href=3D"mailto:zheyuma97@gmail.com"=
 target=3D"_blank">zheyuma97@gmail.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; Changes in v2:<br>
&gt;&gt; - Enforce the correct register field widths on writes to both UART=
IBRD<br>
&gt;&gt; =C2=A0=C2=A0 and UARTFBRD registers.<br>
&gt;&gt; - Mask UARTIBRD to 16 bits and UARTFBRD to 6 bits in the pl011_pos=
t_load<br>
&gt;&gt; =C2=A0=C2=A0 function to prevent division by zero during inbound m=
igration.<br>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0 hw/char/pl011.c | 7 +++++--<br>
&gt;&gt; =C2=A0 1 file changed, 5 insertions(+), 2 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/hw/char/pl011.c b/hw/char/pl011.c<br>
&gt;&gt; index 8753b84a84..ba5f7cfbda 100644<br>
&gt;&gt; --- a/hw/char/pl011.c<br>
&gt;&gt; +++ b/hw/char/pl011.c<br>
&gt;&gt; @@ -374,11 +374,11 @@ static void pl011_write(void *opaque, hwaddr=
 <br>
&gt;&gt; offset,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s-&gt;ilpr =
=3D value;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 9: /* UARTIBRD */<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s-&gt;ibrd =3D value;<=
br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s-&gt;ibrd =3D value &=
amp; 0xffff;<br>
&gt; <br>
&gt; LGTM but could you add a definition instead of these magic values?<br>
&gt; <br>
&gt; Similarly to the ones in the top if this file:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 /* Flag Register, UARTFR */<br>
&gt;=C2=A0 =C2=A0 #define PL011_FLAG_RI=C2=A0=C2=A0 0x100<br>
&gt;=C2=A0 =C2=A0 #define PL011_FLAG_TXFE 0x80<br>
&gt;=C2=A0 =C2=A0 ...<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 /* Integer Baud Rate Divider, UARTIBRD */<br>
&gt;=C2=A0 =C2=A0 #define IBRD_MASK 0x3f<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 /* Fractional Baud Rate Divider, UARTFBRD */<br>
&gt;=C2=A0 =C2=A0 #define FBRD_MASK 0xffff<br>
&gt; <br>
&gt; Then use these definitions :)<br>
<br>
Since I have the patch, let&#39;s share it to save you some time:<br>
<br>
-- &gt;8 --<br>
diff --git a/hw/char/pl011.c b/hw/char/pl011.c<br>
index 8753b84a84..7f9a85708e 100644<br>
--- a/hw/char/pl011.c<br>
+++ b/hw/char/pl011.c<br>
@@ -87,6 +87,12 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, <br=
>
Chardev *chr)<br>
=C2=A0 #define CR_DTR=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 10)<br>
=C2=A0 #define CR_LBE=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 7)<br>
<br>
+/* Integer Baud Rate Divider, UARTIBRD */<br>
+#define IBRD_MASK 0x3f<br>
+<br>
+/* Fractional Baud Rate Divider, UARTFBRD */<br>
+#define FBRD_MASK 0xffff<br>
+<br>
=C2=A0 static const unsigned char pl011_id_arm[8] =3D<br>
=C2=A0 =C2=A0 { 0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1 };<br>
=C2=A0 static const unsigned char pl011_id_luminary[8] =3D<br>
@@ -374,11 +380,11 @@ static void pl011_write(void *opaque, hwaddr offset,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;ilpr =3D value;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 case 9: /* UARTIBRD */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;ibrd =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;ibrd =3D value &amp; IBRD_MASK;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pl011_trace_baudrate_change(s);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 case 10: /* UARTFBRD */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;fbrd =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;fbrd =3D value &amp; FBRD_MASK;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pl011_trace_baudrate_change(s);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 case 11: /* UARTLCR_H */<br>
@@ -531,6 +537,9 @@ static int pl011_post_load(void *opaque, int version_id=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;read_pos =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 s-&gt;ibrd &amp;=3D IBRD_MASK;<br>
+=C2=A0 =C2=A0 s-&gt;fbrd &amp;=3D FBRD_MASK;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0 }<br></blockquote><div><br></div><div>Thanks for your helpful patch =
:)</div><div><br></div><div>regards,</div><div>Zheyu</div></div></div>

--000000000000cfeff3061c45c1a9--

