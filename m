Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD738D3DEAB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 18:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1s36-000573-A5; Fri, 18 Oct 2024 14:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1t1s35-00055W-89
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 14:50:07 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1t1s33-0004rx-GQ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 14:50:07 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-539e66ba398so4114e87.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 11:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1729277403; x=1729882203; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w39f3RZxODqRYxj0UB6TYZMSn76kWSv0kpZQh81AiJM=;
 b=Jxq0N+f58IpcPa3FI40/YJCdRYx65v9qWfgNMaLvri5GVutzQbLDZ1osHf9IplAw1s
 2fW8G2N7WxUvfW5Wx3Pc3IW/qq9UXxYTW72SPYmeOOy1gneTxrrtgB4Rlg4i87E+b08a
 gc3/jBl+B+pTvh1UllVdZYWmlNL7KJQMrhfKjpU/m6aOQTsVhyFE+TWwPnXCunkwD4tN
 STPlCGDzY1iFuZYYRWk/QzpUKpJxxVwPTGMsVXPKQvzsYoQgBx72vyVC/bUyvtWjEJeZ
 P149GfPWipb2B8gmzCYlGv67Dx7X+qNqdWjTHc3zDz2aL8HAiOmF/PHrLbEagwjMP1yI
 KaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729277403; x=1729882203;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w39f3RZxODqRYxj0UB6TYZMSn76kWSv0kpZQh81AiJM=;
 b=nwpbax5VC/GR2J9AWGIv5dDdJq6yN8MckdpFUJHuI1QH4ZftmKAE8qaaz4lbnB6i43
 g5hnZ0tsIUL7q8slM6uFCRqtTE1EJqnckXg1YYPhvKpzvea94XEOC15SdY+F8oVSeikD
 VJEMmItnVVu+9WRu7Xi8/cI9b4wVOC2Z1a/tdWGkneyvwRxMfZit5eXgx2z/ESTbyKHg
 mVD5apBq1r1X2BIaugDz6knOsu6itF07uZKjYNLIPYi3G++yLs5Z9g9pS7pSOs/JX38w
 TWkxxJn8QLODZ/9RoPMKexxLfq6P+QLOx7ZlkpfNzrHP2eyuwn4izfYCxv9JsyPIVxHU
 mi8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9fPCpvSyobfujX1heRT9wFX3sMzoVM4NCwEwRrGs7RUbZC8dZYunWdf5MAb/GWsyrJ+RL0RlOH/SI@nongnu.org
X-Gm-Message-State: AOJu0YzzqOzHIiEAUO3Z3s6jcDV85obBFB2DdAzAuRur5p4oWTGUTRPY
 cIm9x4RX5jop4oEazEwYGcCaNuAwZVgBJKBCWjcn5M7ZEkiJLOIi7eqrJG0qsw86skEd0CKt6a0
 PZqOQ+tBZsqZDxXJBFFeHnU1autO7MOv0G/2v
X-Google-Smtp-Source: AGHT+IFg8G98kG0cFBsxuglnb1x9Hdv4xdl7FnYpwy2KE88jI0SWGDL2Witze8z0I96ztX3S9h077k7cBRGvI1q7CA4=
X-Received: by 2002:a05:6512:3d90:b0:533:49ab:780e with SMTP id
 2adb3069b0e04-53a1acdd3cemr58285e87.2.1729277402480; Fri, 18 Oct 2024
 11:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20241010173929.3910466-1-tavip@google.com>
 <CAFEAcA9X1bdtxRL9fm_rnw9ezMZSW6HaURfMsA4aLMSHM4fzdw@mail.gmail.com>
 <ZxKHSB8l1HmtxrZ6@redhat.com>
 <CAFEAcA_Q_6Vd00Hyy4cUtMCN9=nX=SxqhRAB6Fhrd5_D_jyD0A@mail.gmail.com>
In-Reply-To: <CAFEAcA_Q_6Vd00Hyy4cUtMCN9=nX=SxqhRAB6Fhrd5_D_jyD0A@mail.gmail.com>
From: Octavian Purdila <tavip@google.com>
Date: Fri, 18 Oct 2024 11:49:50 -0700
Message-ID: <CAGWr4cSfrONXCZd6ZaJ23F-uHBvc6nf9WZw6gmBfuHtyoUZ0VQ@mail.gmail.com>
Subject: Re: [RFC PATCH] cli: add connect-gpios option
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, pbonzini@redhat.com, eduardo@habkost.net, 
 armbru@redhat.com, =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=tavip@google.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Fri, Oct 18, 2024 at 9:09=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Fri, 18 Oct 2024 at 17:05, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
> >
> > On Fri, Oct 18, 2024 at 04:38:24PM +0100, Peter Maydell wrote:
> > > On Thu, 10 Oct 2024 at 18:39, Octavian Purdila <tavip@google.com> wro=
te:
> > > >
> > > > From: Valentin Ghita <valentinghita@google.com>
> > > >
> > > > Add option to allow for connecting device GPIOs. This is useful whe=
n
> > > > adding a peripheral device from the command line which uses an
> > > > interrupt.
> > > >
> > > > It takes the following options:
> > > >
> > > > * in-dev-path, out-dev-path - required, the device canonical object
> > > >   path (e.g. /machine/peripheral-anon/device[0],
> > > >   /machine/iotkit/cluster0/armv7m0) for the devices that should hav=
e
> > > >   their in <-> out GPIOs connected
> > > >
> > > > * in-gpio-name, out-gpio-name - optional, the name of the GPIO list=
;
> > > >   if not specified, the unnamed GPIO list is used
> > > >
> > > > * in-gpio-index, out-gpio-index - optional, the index in the GPIO l=
ist
> > > >   that identifies the GPIO to be used; if not specified 0 (the firs=
t
> > > >   GPIO in the list) is used
> > > >
> > > > Usage example:
> > > >
> > > >  # add the tmp105 sensor and connects its irq line to the CPU
> > > >  qemu-system-arm \
> > > >   --machine mps2-an505 \
> > > >   --device tmp105,bus=3D/versatile_i2c/i2c,address=3D0x50 \
> > > >   --connect-gpios out-dev-path=3D/machine/peripheral-anon/device[0]=
,\
> > > >     in-dev-path=3D/machine/iotkit/cluster0/armv7m0,in-gpio-index=3D=
100
> > >
> > >
> > > This seems to be moving down the path towards "create and
> > > wire up machines on the command line". We shouldn't
> > > be doing that ad-hoc with one small commandline option
> > > at a time, we should be doing it with a coherent plan.
> >
> > Yeah, as a general rule, adding new CLI args is pretty undesirable.
> > To avoid that we could utilize QOM for representing data:
> > eg a "gpio-connection" object:
> >
> >   --object gpio-connection,out-dev-path=3D/machine/peripheral-anon/devi=
ce[0],\
> >            in-dev-path=3D/machine/iotkit/cluster0/armv7m0,in-gpio-index=
=3D100
> >
> > this would be OK if we're fine with some code somewhere that iterates
> > over the 'gpio-connection' object instances performing the wiring.
>
> Maybe, but as I say we would want an overall design for this,
> not a single "well this happens to let this one user do this
> one specific thing" approach.
>
> At the moment our design is "QEMU command line options are for
> doing the equivalent of plugging in PCI cards into slots, not
> for the equivalent of soldering chips onto boards". And in
> that view of the world "link this gpio line from the tmp105
> up to the armv7m interrupt controller" is not something to do on
> the command line, because it's definitely soldering wires.
> So for current QEMU the answer is "if the AN505 has a tmp105
> sensor, we should be creating it in the C code for the machine,
> and if it doesn't then we don't support creating it on the
> command line".
>

I should have used a better example, like:

qemu-system-arm \
  --machine rt595-evk \
  --device tmp105,bus=3D/flexcomm6-i2c,address=3D0x50 \
  --connect-gpios in-dev-path=3D/machine/soc/gpio,in-gpio-index=3D22,\
    out-dev-path=3D/machine/peripheral-anon/device[0]

This enables use-cases like plugging in daughter cards on a board that
has I2C/SPI/GPIO pins exposed on a header. IMO this is very similar to
plugging in PCI cards into slots.

