Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514E3C3DA49
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2024 21:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYAzi-0003Dq-0O; Sun, 28 Jul 2024 16:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qeed.quan@gmail.com>)
 id 1sYAzc-0003BQ-6Y
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 16:59:48 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <qeed.quan@gmail.com>)
 id 1sYAza-00049d-Bz
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 16:59:47 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a7a975fb47eso430201666b.3
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2024 13:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722200383; x=1722805183; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QJN2M2Da/nGRkUERSiJMq20N/UjcqP0IRxMIoa714ew=;
 b=VegfIEDAV+/FA2IJF/h51fSjkpY4G1TV4NPZcR69/K9cjUdUy7E2PcYxUkJmY7pJ5V
 ItGEXC/uvlVxAZgTB7R4CPRMdFMkZBdJOvfZ81IgU1LdPrOnM9NbJtyv7mS7fERYehCB
 /vAODdY+gO483TE0DfHqxh6UStFpm5kBmbrbMWjH+6i5ElWxbQFPGjSiOnhiMMuD3GRY
 rSe/sbVgNKDHaBFYACFBL7XlOq+9z0rVahf9AFDWiCR0GgWMf8I8QyjM3Pr9k72z0M6V
 Sp+ZAkT6ExRiFKp5ahmU+xXmlj7s+/qDviZ6OoYa+AiuDjK83emoV6kI2lBZTMIdD/Vg
 HEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722200383; x=1722805183;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QJN2M2Da/nGRkUERSiJMq20N/UjcqP0IRxMIoa714ew=;
 b=GzKW9wioqrv5MvgFPQ27Mo2Bfvdiup2iejyZoXszfvrvNbUGmib2YEh0bb0d0vyton
 aqApIdfn1Qcni66nN4akLlJn0LwUWpnNCMUKhBOCzlatRdMJyz4c3g+6zhWWPiXxgU/j
 HRmsdDMGtGUbVu6UN53qYBqhFbuWYT/eAyTkzb0VjJ2ezfhShz4t/3UeQehSU/yF68RR
 SBVwRYjgSvJ2sO1zUUP5/RB+Pn/fueZa+yKF77YffCRmV6IaY8q6S7hqvwhhHKPxb8WM
 dIWa0IrXgiiSO2qryKrg/5L67JmLFeMonpfBr+jQRnUVLScqg4icCGzP69WiVR6/CuHv
 ASIQ==
X-Gm-Message-State: AOJu0YyMDGXWTHHV8EuXeSqcUvEoZp6RVkMU6rGTHdVJv66BjGV81mUV
 ZzBZQzYxiLwZAK1VxnCIfdyaCKazMo55/SK4NIfumGkIgkZPztZIn41eaKbjYm17mrxL8GIaIxw
 +Gd7wWsMpyV3+6+T0Eyj5ZNcf70o/K+y83Ls=
X-Google-Smtp-Source: AGHT+IF6mDESaIaTrCqFGMzmARjbpYOQ0z6a/OXvHRbv2vSn+9kA333yoLFKUDbZH3p/dRCGe/++mRlAKNgVF0adYNk=
X-Received: by 2002:a17:907:1c19:b0:a7a:b620:aa3a with SMTP id
 a640c23a62f3a-a7d40166db9mr416102866b.52.1722200383331; Sun, 28 Jul 2024
 13:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <CACUh7aGriKAtKtUW5c1X2ipy4RX0Mt_gwwfdQRC94EZNvE89jg@mail.gmail.com>
 <e8832eee-01fe-4cef-d6c4-31fb63677d5c@eik.bme.hu>
In-Reply-To: <e8832eee-01fe-4cef-d6c4-31fb63677d5c@eik.bme.hu>
From: quan <qeed.quan@gmail.com>
Date: Sun, 28 Jul 2024 15:59:32 -0500
Message-ID: <CACUh7aGb7pQUAyWSj8UuWaYJVA8ZYs1HAM0kUsQ736K-mLLHeQ@mail.gmail.com>
Subject: Re: Using parallel port on the Pegasos 2
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 philmd@linaro.org
Content-Type: multipart/alternative; boundary="00000000000014a636061e5506a1"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=qeed.quan@gmail.com; helo=mail-ej1-x62b.google.com
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

--00000000000014a636061e5506a1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have tried this on qemu 8.2.0 (I downloaded it and compiled with
--enable-debug), this build does not seem to hit the breakpoint
portio_write function when writing to 0x3bc while it does on the latest
qemu git version.

Using the  trace:memory_region_ops_write option for 8.2.0, the other
devices like serial and rtc does get hit, but it never prints a write for
'parallel', as if its disabled somehow.

Quan

On Sun, Jul 28, 2024 at 2:17=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:

> On Sun, 28 Jul 2024, quan wrote:
> > I am playing around with the parallel port on the pegasos 2 and I notic=
ed
> > the following issue:
> > The parallel port on startup is set to iobase 0x378, then later it gets
> > remapped to iobase 0x3bc.
> > When I tried writing to the 0x3bc location with
> > trace:memory_region_ops_write on, I get logs about writing to the
> location
> > 'parallel', so far so good, but the writes don't make it through (it
> never
> > calls parallel_ioport_write* functions)
> >
> > I traced it through where it calls portio_write, and inside the
> > portio_write code:
> > This line always fails for me:
> > const MemoryRegionPortio *mrp =3D find_portio(mrpio, addr, size, true);
> > This is due to the mrpio has the offset of 0x44 (0x3bc-0x378) in the
> list,
> > and the 'addr' in the code ranges from (0-15) (address relative to
> 0x3bc),
> > so it can never match the parallel io function to execute.
> >
> > This seems like a bug to me. I think there is some issue where the
> > portio_list is not getting updated properly after the remapping to 0x3b=
c.
> >
> > The other devices (Serial, RTC, PM, VGA) responds properly for me, so i=
t
> is
> > only the parallel port that has this issue.
>
> Is this something that broke recently or can the same be reproduced with
> QEMU v8.2.0. The relocation of these devices was implemented around commi=
t
> 35a6380b4ed27f (and the ones before that). Adding Bernhard to cc as well.
>
> Regards,
> BALATON Zoltan
>

--00000000000014a636061e5506a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I have tried this on qemu 8.2.0 (I downloaded it and compi=
led with --enable-debug), this build does not seem to hit the breakpoint po=
rtio_write function when writing to 0x3bc while it does on the latest qemu =
git version.<div><br></div><div>Using the=C2=A0 trace:memory_region_ops_wri=
te option for 8.2.0, the other devices like serial and rtc does get hit, bu=
t it never prints a write for &#39;parallel&#39;, as if its disabled someho=
w.</div><div><br></div><div>Quan</div></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Jul 28, 2024 at 2:17=E2=80=AF=
PM BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu">balaton@eik.bme=
.hu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On Sun, 28 Jul 2024, quan wrote:<br>
&gt; I am playing around with the parallel port on the pegasos 2 and I noti=
ced<br>
&gt; the following issue:<br>
&gt; The parallel port on startup is set to iobase 0x378, then later it get=
s<br>
&gt; remapped to iobase 0x3bc.<br>
&gt; When I tried writing to the 0x3bc location with<br>
&gt; trace:memory_region_ops_write on, I get logs about writing to the loca=
tion<br>
&gt; &#39;parallel&#39;, so far so good, but the writes don&#39;t make it t=
hrough (it never<br>
&gt; calls parallel_ioport_write* functions)<br>
&gt;<br>
&gt; I traced it through where it calls portio_write, and inside the<br>
&gt; portio_write code:<br>
&gt; This line always fails for me:<br>
&gt; const MemoryRegionPortio *mrp =3D find_portio(mrpio, addr, size, true)=
;<br>
&gt; This is due to the mrpio has the offset of 0x44 (0x3bc-0x378) in the l=
ist,<br>
&gt; and the &#39;addr&#39; in the code ranges from (0-15) (address relativ=
e to 0x3bc),<br>
&gt; so it can never match the parallel io function to execute.<br>
&gt;<br>
&gt; This seems like a bug to me. I think there is some issue where the<br>
&gt; portio_list is not getting updated properly after the remapping to 0x3=
bc.<br>
&gt;<br>
&gt; The other devices (Serial, RTC, PM, VGA) responds properly for me, so =
it is<br>
&gt; only the parallel port that has this issue.<br>
<br>
Is this something that broke recently or can the same be reproduced with <b=
r>
QEMU v8.2.0. The relocation of these devices was implemented around commit =
<br>
35a6380b4ed27f (and the ones before that). Adding Bernhard to cc as well.<b=
r>
<br>
Regards,<br>
BALATON Zoltan<br>
</blockquote></div>

--00000000000014a636061e5506a1--

