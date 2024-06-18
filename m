Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE21C2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 21:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJgRl-0000tK-Mh; Tue, 18 Jun 2024 17:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1sJgRi-0000r2-RQ
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 17:32:55 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1sJgRg-0005KA-TU
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 17:32:54 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2c19e6dc3dcso5013610a91.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 14:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718746369; x=1719351169; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/OTLggQpqB0FKFp25JGks8iWiUys5U6k+gD1fBzUFpU=;
 b=f/YXeh53+laYuZZPcf1wjfZjYx+cY4AMrHL6FmfoXkQ0A7cHibbY/XWn8/zmGs5Evz
 sZFvVrXceHb9/0GFADOcaoVcocvxtslhOWW0dmvalQqhvA25zGeFJanWHOmeRgUM4Sq4
 MFCawPRWjvlYzzZsbPe5ZHAjTG+dVYt30S35jqdT7UBoE0y4FHLlPCJ57kJ+TTToE1yx
 zjHfwlXQP6rSjHAKifKu7ZKI3uCjNAdmx/VZeLrKtsE+g89itdJTe76DTJXuV1tkQbCa
 YD4Q4nLvgtiaOfzewxkn3THvpjVsHRk65anHiCPH4AyY55AaJGhXCoMcNzWJGqhlKi9T
 Xm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718746369; x=1719351169;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/OTLggQpqB0FKFp25JGks8iWiUys5U6k+gD1fBzUFpU=;
 b=c4DNcITU4IO2sYs+9uPzrOH4Y6c4jOPyvD38NAkVdQT/knCpHgYg+50oz8isXvYk9s
 gKR17RaDIBJHGREfyW9whQtRfCMqowcAUfdavDdc8lZSyHQfyqWm7GTuj6s9c2D6z4hW
 zGVIUvLXKRAEvhW4poPjXHhKlZdb7P9K2HFwYHUA43Nt4M1j7RnVLEgPJb/nUuFwSJrc
 VDTWObUxgsmBQ+Y48XvX/DV0U4o0ftYZBednEoblCyI9D6W3+5OHkq9sLCx9+HuhP8/V
 hQGteVtd+8GMGvhy/LJgZBT1JJ1S8q/ujaoar78hqaW3jlH2pgOUph6yrur8+mnt/Q3p
 ru4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUIgMHb95kLx5TpD4dUPoeo0FS11l39RyK5aoS/w4w49vTeujLVfaRYxzidvodveicUir+rfT5TJConwfSjhJdJDigcGs=
X-Gm-Message-State: AOJu0YyRACtAGPfIrjRDHFZoZIaRlAxGfLK99SH9mqbsx87c4kB+w10D
 eRF6CoYlv/IlJ09txgV2weO8sSIpAyN15zDfS5xOdgZY5VVNovwBl29vOapKPF8BdbBIMqdCo5U
 +mams3FH3Wz1EV82/qaSN1CdmH0Id6jC7
X-Google-Smtp-Source: AGHT+IFfGacfa4ng7XHZMiAK79wdYi7JyBdONcWrtdSm5J+df/jnfK5QWtz8ekIBQrt8NmbPC03hfhiL4D4SdZKkUYY=
X-Received: by 2002:a17:90a:ec13:b0:2c7:c09b:3030 with SMTP id
 98e67ed59e1d1-2c7c09b30b1mr136238a91.34.1718746369421; Tue, 18 Jun 2024
 14:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240618135610.3109175-1-zheyuma97@gmail.com>
 <CADBGO7_XF5REzENPGupwMB-EOHXS78SG5v=yZ6TRZ_7yVgWUtg@mail.gmail.com>
 <c60ac5cc-c592-46bc-b09a-b918253cb6cd@linaro.org>
In-Reply-To: <c60ac5cc-c592-46bc-b09a-b918253cb6cd@linaro.org>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Tue, 18 Jun 2024 14:32:21 -0700
Message-ID: <CADBGO7_=_1SNB2EN9Up7QB4TGOFqWQekBTTvLAJvMtpb73nRug@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-dwc2: Handle invalid address access in read
 and write functions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000cefaa4061b30d20b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pauldzim@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

--000000000000cefaa4061b30d20b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 1:37=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Hi Paul,
>
> On 18/6/24 20:58, Paul Zimmerman wrote:
> > On Tue, Jun 18, 2024 at 6:56=E2=80=AFAM Zheyu Ma <zheyuma97@gmail.com
> > <mailto:zheyuma97@gmail.com>> wrote:
> >  >
> >  > This commit modifies the dwc2_hsotg_read() and dwc2_hsotg_write()
> > functions
> >  > to handle invalid address access gracefully. Instead of using
> >  > g_assert_not_reached(), which causes the program to abort, the
> functions
> >  > now log an error message and return a default value for reads or do
> >  > nothing for writes.
> >  >
> >  > This change prevents the program from aborting and provides clear lo=
g
> >  > messages indicating when an invalid memory address is accessed.
> >  >
> >  > Reproducer:
> >  > cat << EOF | qemu-system-aarch64 -display none \
> >  > -machine accel=3Dqtest, -m 512M -machine raspi2b -m 1G -nodefaults \
> >  > -usb -drive file=3Dnull-co://,if=3Dnone,format=3Draw,id=3Ddisk0 -dev=
ice \
> >  > usb-storage,port=3D1,drive=3Ddisk0 -qtest stdio
> >  > readl 0x3f980dfb
> >  > EOF
> >  >
> >  > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com
> > <mailto:zheyuma97@gmail.com>>
> >  > ---
> >  >  hw/usb/hcd-dwc2.c | 9 +++++++--
> >  >  1 file changed, 7 insertions(+), 2 deletions(-)
> >  >
> >  > diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
> >  > index 8cac9c0a06..b4f0652c7d 100644
> >  > --- a/hw/usb/hcd-dwc2.c
> >  > +++ b/hw/usb/hcd-dwc2.c
> >  > @@ -1128,7 +1128,10 @@ static uint64_t dwc2_hsotg_read(void *ptr,
> hwaddr addr, unsigned size)
> >  >          val =3D dwc2_pcgreg_read(ptr, addr, (addr - HSOTG_REG(0xe00=
))
> >> 2, size);
> >  >          break;
> >  >      default:
> >  > -        g_assert_not_reached();
> >  > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset
> 0x%"HWADDR_PRIx"\n",
> >  > +                      __func__, addr);
> >  > +        val =3D 0;
> >  > +        break;
> >  >      }
> >  >
> >  >      return val;
> >  > @@ -1160,7 +1163,9 @@ static void dwc2_hsotg_write(void *ptr, hwaddr
> addr, uint64_t val,
> >  >          dwc2_pcgreg_write(ptr, addr, (addr - HSOTG_REG(0xe00)) >> 2=
,
> val, size);
> >  >          break;
> >  >      default:
> >  > -        g_assert_not_reached();
> >  > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset
> 0x%"HWADDR_PRIx"\n",
> >  > +                      __func__, addr);
> >  > +        break;
> >  >      }
> >  >  }
> >  >
> >  > --
> >  > 2.34.1
> >
> > Looks good to me.
> >
> > Reviewed-by: Paul Zimmerman <pauldzim@gmail.com <mailto:
> pauldzim@gmail.com>>
> >
>
> Does that mean on real HW the access to unassigned registers are
> silently ignored as RAZ/WI like this patch? (I don't have access
> to the specs -- IIRC you don't neither, but you might have real
> HW to test).


Hi Phil,

I have an old raspi around somewhere I could probably dig up and
test with, but I'm not familiar with qtest, so I don't know how I
would reproduce the failure on real hw.

Besides, isn't it always better to fail and log an error than just crash?

Regards,
Paul

--000000000000cefaa4061b30d20b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Jun 18, 2024 at 1:37=E2=80=AFPM P=
hilippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@=
linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Hi Paul,<br>
<br>
On 18/6/24 20:58, Paul Zimmerman wrote:<br>
&gt; On Tue, Jun 18, 2024 at 6:56=E2=80=AFAM Zheyu Ma &lt;<a href=3D"mailto=
:zheyuma97@gmail.com" target=3D"_blank">zheyuma97@gmail.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:zheyuma97@gmail.com" target=3D"_blank">zh=
eyuma97@gmail.com</a>&gt;&gt; wrote:<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; This commit modifies the dwc2_hsotg_read() and dwc2_hsotg_w=
rite() <br>
&gt; functions<br>
&gt;=C2=A0 &gt; to handle invalid address access gracefully. Instead of usi=
ng<br>
&gt;=C2=A0 &gt; g_assert_not_reached(), which causes the program to abort, =
the functions<br>
&gt;=C2=A0 &gt; now log an error message and return a default value for rea=
ds or do<br>
&gt;=C2=A0 &gt; nothing for writes.<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; This change prevents the program from aborting and provides=
 clear log<br>
&gt;=C2=A0 &gt; messages indicating when an invalid memory address is acces=
sed.<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; Reproducer:<br>
&gt;=C2=A0 &gt; cat &lt;&lt; EOF | qemu-system-aarch64 -display none \<br>
&gt;=C2=A0 &gt; -machine accel=3Dqtest, -m 512M -machine raspi2b -m 1G -nod=
efaults \<br>
&gt;=C2=A0 &gt; -usb -drive file=3Dnull-co://,if=3Dnone,format=3Draw,id=3Dd=
isk0 -device \<br>
&gt;=C2=A0 &gt; usb-storage,port=3D1,drive=3Ddisk0 -qtest stdio<br>
&gt;=C2=A0 &gt; readl 0x3f980dfb<br>
&gt;=C2=A0 &gt; EOF<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; Signed-off-by: Zheyu Ma &lt;<a href=3D"mailto:zheyuma97@gma=
il.com" target=3D"_blank">zheyuma97@gmail.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:zheyuma97@gmail.com" target=3D"_blank">zh=
eyuma97@gmail.com</a>&gt;&gt;<br>
&gt;=C2=A0 &gt; ---<br>
&gt;=C2=A0 &gt; =C2=A0hw/usb/hcd-dwc2.c | 9 +++++++--<br>
&gt;=C2=A0 &gt; =C2=A01 file changed, 7 insertions(+), 2 deletions(-)<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c<br>
&gt;=C2=A0 &gt; index 8cac9c0a06..b4f0652c7d 100644<br>
&gt;=C2=A0 &gt; --- a/hw/usb/hcd-dwc2.c<br>
&gt;=C2=A0 &gt; +++ b/hw/usb/hcd-dwc2.c<br>
&gt;=C2=A0 &gt; @@ -1128,7 +1128,10 @@ static uint64_t dwc2_hsotg_read(void=
 *ptr, hwaddr addr, unsigned size)<br>
&gt;=C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D dwc2_pcgreg_read(=
ptr, addr, (addr - HSOTG_REG(0xe00)) &gt;&gt; 2, size);<br>
&gt;=C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_not_reached();<br>
&gt;=C2=A0 &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_GUEST_ERROR,=
 &quot;%s: Bad offset 0x%&quot;HWADDR_PRIx&quot;\n&quot;,<br>
&gt;=C2=A0 &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0__func__, addr);<br>
&gt;=C2=A0 &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D 0;<br>
&gt;=C2=A0 &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0return val;<br>
&gt;=C2=A0 &gt; @@ -1160,7 +1163,9 @@ static void dwc2_hsotg_write(void *pt=
r, hwaddr addr, uint64_t val,<br>
&gt;=C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dwc2_pcgreg_write(ptr, ad=
dr, (addr - HSOTG_REG(0xe00)) &gt;&gt; 2, val, size);<br>
&gt;=C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_not_reached();<br>
&gt;=C2=A0 &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_GUEST_ERROR,=
 &quot;%s: Bad offset 0x%&quot;HWADDR_PRIx&quot;\n&quot;,<br>
&gt;=C2=A0 &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0__func__, addr);<br>
&gt;=C2=A0 &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 &gt; =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 &gt; =C2=A0}<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; --<br>
&gt;=C2=A0 &gt; 2.34.1<br>
&gt; <br>
&gt; Looks good to me.<br>
&gt; <br>
&gt; Reviewed-by: Paul Zimmerman &lt;<a href=3D"mailto:pauldzim@gmail.com" =
target=3D"_blank">pauldzim@gmail.com</a> &lt;mailto:<a href=3D"mailto:pauld=
zim@gmail.com" target=3D"_blank">pauldzim@gmail.com</a>&gt;&gt;<br>
&gt; <br>
<br>
Does that mean on real HW the access to unassigned registers are<br>
silently ignored as RAZ/WI like this patch? (I don&#39;t have access<br>
to the specs -- IIRC you don&#39;t neither, but you might have real<br>
HW to test).</blockquote><div>=C2=A0</div>Hi Phil,<div><br></div><div>I hav=
e an old raspi around somewhere I could probably dig up and</div><div>test =
with, but I&#39;m not familiar with qtest, so I don&#39;t know how I</div><=
div>would reproduce the failure on real hw.</div><div><br></div><div>Beside=
s, isn&#39;t it always better to fail and log an=C2=A0error than just crash=
?</div><div><br></div><div>Regards,</div><div>Paul</div><div><br></div></di=
v></div>

--000000000000cefaa4061b30d20b--

