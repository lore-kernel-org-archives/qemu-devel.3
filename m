Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DF7C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ree4o-00022c-9Q; Mon, 26 Feb 2024 11:43:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ree4Z-0001uO-6f
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:43:23 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ree4W-00052W-9b
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:43:22 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5643eccad0bso5134258a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708965799; x=1709570599; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zacmyTmiqU9SagCBBD4kEIuUv8302gDFeGTxL6SrB94=;
 b=K5YuYL0VHDQZeduBMJ0wuopizUdfpdbDgjuau4tOGM3woev4jdQ7t0uu6adxcJ2yNg
 fjHktMJOFaGlbYZ15MlvJUoafechBI8QpUU0rxEIU1Z0+I9RG6e1dM0yZBbfmJtH2rVi
 CIwRFG78mkiPMPQyHGg/iaa7C1yHlyI5fDrUvSdivXqzuivIJwevXb2YBIvjemYrDhJD
 9lO1EObdoAgA62CfgsKbUF1kA4l7oeS9lKEdoxMz0mQ8cv+DUzRP84BTzXb32ejXdyvg
 Cn4eJQxg7fbTdhuXOGkvq2RSXUhefy9VJDsuuaqoX2f7zTndroznSjt0cA9hE27Poo5R
 Jipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708965799; x=1709570599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zacmyTmiqU9SagCBBD4kEIuUv8302gDFeGTxL6SrB94=;
 b=OAMgPNSIY1+dZVXBiBUvqKppPbhQqA9YQTiIrveUN94o7BpbR/gWDCP+DSvuLqN5CT
 nxEnntOMlJtQ5HpO9UYKSt+o1AM2hefOE+YjOl6LRAYts0pOG3m4kRQFBq9nZzsfersf
 mG8n4ou3+Gw5BxgXoHyPv64xZSl3gCiqC0XTB7O1vDFlZiZnDjUgJufD3SObn6lTiRr0
 JTRrhNiGDITEUE1wM2nV+rl7zR6GZOPfr4O8w00RtzH4zEJuN6dGd85hyKdeLVaGV2Y6
 KT5J+I7W0N9NWZPxhrmlx8+Qy+7J42DpsLIcfMqaSiFzzcmsItVIs4r1b3t9y/Rkd39E
 agqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyg76kdOpOrX4ezxAHiC3c/Zr9k1ESQ5+LfTgTIFH2oj8+Q4t4rA5kv6awkPuoz8E4N858VvsZbAstXjcVDd34ZdD4V+c=
X-Gm-Message-State: AOJu0YyleEmBczYBquCn5GAKIbaIhb/AWeLNskjmuMpBHH1VU0zcsrdS
 zxj1R9wf5+VJcdAgoFVH+JmlnBhwuWFxUAXxBKWes7l/cot0DEdp4DxZSwRLnzSob/fWpyliKk8
 GmbM+tX1/9XI8vX9g34P3OIzxgG/eM3pCRDZaAA==
X-Google-Smtp-Source: AGHT+IE0SV44QYePlmJBSsO5+nMHd/GKwOXVF6OVFaWdoFSrpV/bJUin46kjBocSXuDPzUI9iBD8jBazT4NUD1l7+KI=
X-Received: by 2002:aa7:c908:0:b0:565:dfac:a686 with SMTP id
 b8-20020aa7c908000000b00565dfaca686mr2923244edt.38.1708965798762; Mon, 26 Feb
 2024 08:43:18 -0800 (PST)
MIME-Version: 1.0
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <20240226000259.2752893-42-sergey.kambalin@auriga.com>
 <CAFEAcA_xdowvZkxFC7ypEFRJSTLDkdx+9E3_fwPNY=S2sK5=UA@mail.gmail.com>
In-Reply-To: <CAFEAcA_xdowvZkxFC7ypEFRJSTLDkdx+9E3_fwPNY=S2sK5=UA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 16:43:08 +0000
Message-ID: <CAFEAcA88NqshmyH5czz8ZC0Kbb81_-8VHRMCSQDbpHrPwm6AWA@mail.gmail.com>
Subject: Re: [PATCH v6 41/41] Add RPi4B to raspi.rst
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 26 Feb 2024 at 16:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 26 Feb 2024 at 00:03, Sergey Kambalin <serg.oker@gmail.com> wrote:
> >
> > Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  docs/system/arm/raspi.rst | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/docs/system/arm/raspi.rst b/docs/system/arm/raspi.rst
> > index d0a6f08b2b..c21b27744e 100644
> > --- a/docs/system/arm/raspi.rst
> > +++ b/docs/system/arm/raspi.rst
> > @@ -1,5 +1,5 @@
> > -Raspberry Pi boards (``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3ap``, ``raspi3b``)
> > -======================================================================================
> > +Raspberry Pi boards (``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3ap``, ``raspi3b``, ``raspi4b-2g``)
> > +======================================================================================================
> >
> >
> >  QEMU provides models of the following Raspberry Pi boards:
> > @@ -12,12 +12,13 @@ QEMU provides models of the following Raspberry Pi boards:
> >    Cortex-A53 (4 cores), 512 MiB of RAM
> >  ``raspi3b``
> >    Cortex-A53 (4 cores), 1 GiB of RAM
> > -
> > +``raspi4b-2g``
> > +  Cortex-A72 (4 cores), 2 GiB of RAM
> >
> >  Implemented devices
> >  -------------------
> >
> > - * ARM1176JZF-S, Cortex-A7 or Cortex-A53 CPU
> > + * ARM1176JZF-S, Cortex-A7, Cortex-A53 or Cortex-A72 CPU
> >   * Interrupt controller
> >   * DMA controller
> >   * Clock and reset controller (CPRMAN)
> > @@ -34,6 +35,8 @@ Implemented devices
> >   * MailBox controller (MBOX)
> >   * VideoCore firmware (property)
> >   * Peripheral SPI controller (SPI)
> > + * PCIE Root Port (raspi4b-2g)
> > + * GENET Ethernet Controller (raspi4b-2g)
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> For the "no PCI/no ethernet" initial version, I'll drop these last
> two lines; we can add them in when we land the pci and ethernet
> patches.

...better, I'll move them to "missing devices":

--- a/docs/system/arm/raspi.rst
+++ b/docs/system/arm/raspi.rst
@@ -35,12 +35,11 @@ Implemented devices
  * MailBox controller (MBOX)
  * VideoCore firmware (property)
  * Peripheral SPI controller (SPI)
- * PCIE Root Port (raspi4b-2g)
- * GENET Ethernet Controller (raspi4b-2g)
-

 Missing devices
 ---------------

  * Analog to Digital Converter (ADC)
  * Pulse Width Modulation (PWM)
+ * PCIE Root Port (raspi4b-2g)
+ * GENET Ethernet Controller (raspi4b-2g)

-- PMM

