Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E40CA0EEB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Aug 2025 16:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqDWf-0006r9-0R; Sun, 24 Aug 2025 12:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqDWc-0006qs-T2; Sun, 24 Aug 2025 12:24:58 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqDWa-0001kv-2C; Sun, 24 Aug 2025 12:24:58 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-61c51f56fc7so683719a12.1; 
 Sun, 24 Aug 2025 09:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756052692; x=1756657492; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dwDtQ0ivD5R0VBy5xshbePvfN0FwUBx8XtTF2m1KQyc=;
 b=XMGwvwwi0HqLpHpHg2YUAmKL9kZkqB0fGaKKbcjRjkK0tKq5JkAS0tvNGEwIGW72Up
 EpXFbahIbYUIij3Ul86bqWrO/QB6qTz7Q2y0N8W71wpls2OKucODod/C6+k7ZQaJhVzm
 OTeKL30Tq5IGnf8pIknwV66NnQwn9Bil6Zp2abDHWkQq8siTeU1Osj8hDztKYZiLOo7I
 o9Cmu4PyJJsIxKHJMlKhkUePP3NHw+0U4IR+vb1NnaHBQkowPDt/cnWZgcPGt22tMZ5T
 hfdy4ZQBkxnRDhtR/abnI1SddTrvQX5dgY5DmBEzlCwqhCWGYvHEryWUQExo8BAbYdCf
 1koQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756052692; x=1756657492;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dwDtQ0ivD5R0VBy5xshbePvfN0FwUBx8XtTF2m1KQyc=;
 b=Vaw5V4U/n6eYeiUSgz6Nj2DpULp6fUXwZgIxRwS+o47jUywSuJhZcAyPhsy907FAB6
 498yLk7kSQ4kcJsR3D69ee1KyJ0144JmeXXG2nF/GRkBuWlgmujJvwTJvE1lggFxUn2v
 wC0f70ujjU8CfH1H9CsVPwSTzeYu/wodSIM9Ul2QE2XXiHHUDpSKxNIhmTzuQkoib90w
 N4lMP/Qbb+USxMqdH0mVgddW5BZZJNRtvpgbGBHrNx9kStoXeMFxGxeVwr7RCvKX1M2J
 AB4A9ql8v3mtaUj/cYxluWf8Ct6lkhqFadcMDCUMa/LQRqYqL/rkQJRTPPkFk2/VPBAp
 VpRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEvaZZBEgrFtmpJnKB0SGhxkHpjiPC84Z0CZeZnl6wjMKG1cuM8n/CQOC1vHyj7kvNbFDCbZT+KYIVEw==@nongnu.org,
 AJvYcCVfX809CNbaplB/p4OUERc1VNhObg7ImNPSYp1YOxq+eH5cun0EtelDIKUIOF+Qo107sM2bkPPBow==@nongnu.org,
 AJvYcCVjcEocr+kEvxyPWInuIb3Mi24Rss+oHLaOIH9G9GXYwOQ+0MMgMO14Aa0YDcNZWd822YssPQaC7SqaMg==@nongnu.org
X-Gm-Message-State: AOJu0YyTqEQhCgZLMsEFbVMAxjCJIZ4IN/ajxZmBOUU8B+Cv2ORxkLvL
 wxDLdIOPmKLlp5Lz+ZeyqePFyMb8PJrQpqm++Bx+BZHs9EneP4w3lbwZ9Ucm5sGywf1XC6E/vH8
 A1m3nQ22PjDtUEUb5XZRP7avQC3rK1hk=
X-Gm-Gg: ASbGnctUFjQiw8oZZxqe8biNWQUMqDnBH6TIiVsWS+fu3v17UqWH29Gl/+2JSBMI8me
 cq5m2xNGmwdK9OTsC3KJFC9omM6U4CrLG1v4RAoqy5wcKuCO1vDoZlFM1Rcg7LB/a999pmOT6zn
 Afd4wSiNCm74JEnF25nSOeJFJQMG25f944LP0jx6GK2Eh6bkmS+AY+rRo/4z/Da15kz6NBlWXZr
 yLg6A==
X-Google-Smtp-Source: AGHT+IHN0FtUEkb2m8RMYPj9BM1V2+Kzva3RD5Muei5D8rn2IHA13OsqbpAIF+4ABZyu1SS9AyoXrJmocJfINi7/Usc=
X-Received: by 2002:a05:6402:4349:b0:618:528b:7f9b with SMTP id
 4fb4d7f45d1cf-61c1b6fb807mr7232662a12.31.1756052692168; Sun, 24 Aug 2025
 09:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250815090113.141641-1-corvin.koehne@gmail.com>
 <20250815090113.141641-10-corvin.koehne@gmail.com>
 <CAFEAcA-mTTLEtE72W=-R9O=m7zSUiL5bGf7TMXoFP=Xqvmq2OA@mail.gmail.com>
In-Reply-To: <CAFEAcA-mTTLEtE72W=-R9O=m7zSUiL5bGf7TMXoFP=Xqvmq2OA@mail.gmail.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Sun, 24 Aug 2025 18:24:39 +0200
X-Gm-Features: Ac12FXx1rX97XDQJIupzcERL60KnzyZYlxrpEh9uM3w6pZ7ijFGy4Hp0swjY9H4
Message-ID: <CAJy5ezr1AQGuMoB9KZM0zsVOc+m5vinmgu6+zkM3w8E_ny5ybA@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] hw/misc: Add dummy ZYNQ DDR controller
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>, 
 qemu-devel@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 qemu-arm@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ec72fa063d1ee0f5"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x536.google.com
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

--000000000000ec72fa063d1ee0f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 5:44=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Fri, 15 Aug 2025 at 10:01, Corvin K=C3=B6hne <corvin.koehne@gmail.com>
> wrote:
> >
> > From: YannickV <Y.Vossen@beckhoff.com>
> >
> > A dummy DDR controller for ZYNQ has been added. While all registers are
> present,
> > not all are functional. Read and write access is validated, and the use=
r
> mode
> > can be set. This provides a basic DDR controller initialization,
> preventing
> > system hangs due to endless polling or similar issues.
> >
> > Signed-off-by: Yannick Vo=C3=9Fen <y.vossen@beckhoff.com>
> > ---
> >  hw/misc/Kconfig                  |   3 +
> >  hw/misc/meson.build              |   1 +
> >  hw/misc/xlnx-zynq-ddrc.c         | 393 +++++++++++++++++++++++++++++++
> >  include/hw/misc/xlnx-zynq-ddrc.h | 140 +++++++++++
> >  4 files changed, 537 insertions(+)
> >  create mode 100644 hw/misc/xlnx-zynq-ddrc.c
> >  create mode 100644 include/hw/misc/xlnx-zynq-ddrc.h
> >
> > diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> > index 8f9ce2f68c..99548e146f 100644
> > --- a/hw/misc/Kconfig
> > +++ b/hw/misc/Kconfig
> > @@ -220,4 +220,7 @@ config IOSB
> >  config XLNX_VERSAL_TRNG
> >      bool
> >
> > +config XLNX_ZYNQ_DDRC
> > +    bool
> > +
> >  source macio/Kconfig
> > diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> > index 55f493521b..6ee7b6c71d 100644
> > --- a/hw/misc/meson.build
> > +++ b/hw/misc/meson.build
> > @@ -89,6 +89,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
> >  ))
> >  system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
> >  system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
> > +system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('xlnx-zynq-ddrc.c'))
> >  system_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true:
> files('xlnx-zynqmp-crf.c'))
> >  system_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true:
> files('xlnx-zynqmp-apu-ctrl.c'))
> >  system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files(
> > diff --git a/hw/misc/xlnx-zynq-ddrc.c b/hw/misc/xlnx-zynq-ddrc.c
> > new file mode 100644
> > index 0000000000..8151a0e3ee
> > --- /dev/null
> > +++ b/hw/misc/xlnx-zynq-ddrc.c
>
> All new files must start with a comment which at least
> (a) says what the file is for and (b) has the SPDX
> license indicator. You can optionally also add an authorship
> or copyright line here if you/your employer need that.
>
> Same applies to the .h file.
>
> > +static void zynq_ddrctrl_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    device_class_set_legacy_reset(dc, zynq_ddrctrl_reset);
> > +}
>
> This looks like it's missing registration of a vmstate
> struct for state save/load.
>
> thanks
> -- PMM
>


Except for the stuff that Peter mentions, the rest looks good to me!

Cheers,
Edgar

--000000000000ec72fa063d1ee0f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 19,=
 2025 at 5:44=E2=80=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@=
linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Fri, 15 Aug 2025 at 10:01, Corvin K=
=C3=B6hne &lt;<a href=3D"mailto:corvin.koehne@gmail.com" target=3D"_blank">=
corvin.koehne@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: YannickV &lt;<a href=3D"mailto:Y.Vossen@beckhoff.com" target=3D"=
_blank">Y.Vossen@beckhoff.com</a>&gt;<br>
&gt;<br>
&gt; A dummy DDR controller for ZYNQ has been added. While all registers ar=
e present,<br>
&gt; not all are functional. Read and write access is validated, and the us=
er mode<br>
&gt; can be set. This provides a basic DDR controller initialization, preve=
nting<br>
&gt; system hangs due to endless polling or similar issues.<br>
&gt;<br>
&gt; Signed-off-by: Yannick Vo=C3=9Fen &lt;<a href=3D"mailto:y.vossen@beckh=
off.com" target=3D"_blank">y.vossen@beckhoff.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/misc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 hw/misc/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 hw/misc/xlnx-zynq-ddrc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 393 =
+++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 include/hw/misc/xlnx-zynq-ddrc.h | 140 +++++++++++<br>
&gt;=C2=A0 4 files changed, 537 insertions(+)<br>
&gt;=C2=A0 create mode 100644 hw/misc/xlnx-zynq-ddrc.c<br>
&gt;=C2=A0 create mode 100644 include/hw/misc/xlnx-zynq-ddrc.h<br>
&gt;<br>
&gt; diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig<br>
&gt; index 8f9ce2f68c..99548e146f 100644<br>
&gt; --- a/hw/misc/Kconfig<br>
&gt; +++ b/hw/misc/Kconfig<br>
&gt; @@ -220,4 +220,7 @@ config IOSB<br>
&gt;=C2=A0 config XLNX_VERSAL_TRNG<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool<br>
&gt;<br>
&gt; +config XLNX_ZYNQ_DDRC<br>
&gt; +=C2=A0 =C2=A0 bool<br>
&gt; +<br>
&gt;=C2=A0 source macio/Kconfig<br>
&gt; diff --git a/hw/misc/meson.build b/hw/misc/meson.build<br>
&gt; index 55f493521b..6ee7b6c71d 100644<br>
&gt; --- a/hw/misc/meson.build<br>
&gt; +++ b/hw/misc/meson.build<br>
&gt; @@ -89,6 +89,7 @@ system_ss.add(when: &#39;CONFIG_RASPI&#39;, if_true:=
 files(<br>
&gt;=C2=A0 ))<br>
&gt;=C2=A0 system_ss.add(when: &#39;CONFIG_SLAVIO&#39;, if_true: files(&#39=
;slavio_misc.c&#39;))<br>
&gt;=C2=A0 system_ss.add(when: &#39;CONFIG_ZYNQ&#39;, if_true: files(&#39;z=
ynq_slcr.c&#39;))<br>
&gt; +system_ss.add(when: &#39;CONFIG_ZYNQ&#39;, if_true: files(&#39;xlnx-z=
ynq-ddrc.c&#39;))<br>
&gt;=C2=A0 system_ss.add(when: &#39;CONFIG_XLNX_ZYNQMP_ARM&#39;, if_true: f=
iles(&#39;xlnx-zynqmp-crf.c&#39;))<br>
&gt;=C2=A0 system_ss.add(when: &#39;CONFIG_XLNX_ZYNQMP_ARM&#39;, if_true: f=
iles(&#39;xlnx-zynqmp-apu-ctrl.c&#39;))<br>
&gt;=C2=A0 system_ss.add(when: &#39;CONFIG_XLNX_VERSAL&#39;, if_true: files=
(<br>
&gt; diff --git a/hw/misc/xlnx-zynq-ddrc.c b/hw/misc/xlnx-zynq-ddrc.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..8151a0e3ee<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/misc/xlnx-zynq-ddrc.c<br>
<br>
All new files must start with a comment which at least<br>
(a) says what the file is for and (b) has the SPDX<br>
license indicator. You can optionally also add an authorship<br>
or copyright line here if you/your employer need that.<br>
<br>
Same applies to the .h file.<br>
<br>
&gt; +static void zynq_ddrctrl_class_init(ObjectClass *klass, void *data)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 device_class_set_legacy_reset(dc, zynq_ddrctrl_reset);<=
br>
&gt; +}<br>
<br>
This looks like it&#39;s missing registration of a vmstate<br>
struct for state save/load.<br>
<br>
thanks<br>
-- PMM<br></blockquote><div><br></div><div><br></div><div>Except for the st=
uff that Peter mentions, the rest looks good to me!</div><div><br></div><di=
v>Cheers,</div><div>Edgar</div><div>=C2=A0</div></div></div>

--000000000000ec72fa063d1ee0f5--

