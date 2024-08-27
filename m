Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BA0C5321D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 01:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sikiX-0003LE-3M; Mon, 26 Aug 2024 21:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jaminlin1207@gmail.com>)
 id 1sikiU-0003K9-Ed; Mon, 26 Aug 2024 21:09:50 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jaminlin1207@gmail.com>)
 id 1sikiS-0004ff-F7; Mon, 26 Aug 2024 21:09:50 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-828fb8977ecso76508439f.2; 
 Mon, 26 Aug 2024 18:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724720986; x=1725325786; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YjASyb0aq53Kz2I2qqRYjeaRoGKkVqgMCPnAuIp1qlc=;
 b=L68zxW/yXVwNrg3i9bAYGH5cbiNLB+rS/OR5H4tsdHoQGDv+YYrJ3E2mmGNoEwhFqd
 Gqd+cT/sOfq2u0gy8vSUJtYMlmR8h+EWMW6jUr9NY/vR/VvFbs7PqPjgnt6cuCtNsxaa
 k8/hLF6W9Cqr1QErNQEcPWWFDSDCE+s4J6hvBEbez8QdGNV3m0x2L3Hoq+mGTPJ2yKRf
 OEr7DEAzUl8cFJIr1hjRPU43M47KUnZ8BgROQvKqRXKcVWMKXWkFazT0WZBinQlpVFqe
 MMUP1xVwzGic4pgppF4+MzL0BEL1w4c8SRfPNhHE9N3F4XcFMbgMGvOqz1mcDhNwv4S0
 85rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724720986; x=1725325786;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YjASyb0aq53Kz2I2qqRYjeaRoGKkVqgMCPnAuIp1qlc=;
 b=bRq/kJYpkEEWSmHnroqFF9t7432/1GLbdntSORzIcdzRSp4zkpANhEBqzw7Lhq4Ggx
 8nNyN5dSeUGtwiEzgfhnHVC/zI1p2PaB506a8k9os1+yH0mvVB+Oqr4lBJ/1OsHFzgt8
 dN7FFCageH4i8OQvycpMMWaxiL3ZOc8RQ0nt4HRZKIe5gwVPlbaBLGjA52oclNKG5Z0U
 SyRL/1yrSB8EV3aT+WRGfd6SqKcUUE0q45e+HAESPfA483TxvCWzQy+5/Wr/l6+hEcHy
 r6+pLmQbpuD7bgXq4hTaSSLXy9KAsTO3vqbgqagocWSLuTJxuchR5pUGbC4hcPjkNdd4
 8qwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ1xIOYdvyV8Dh9+sXH3KCNoEeOfBrBVrHyvuxzeWV0Sc33Wp3dsBrEwWjUeHS2iJ38fUEEgY/2MQVyg==@nongnu.org,
 AJvYcCXcnMNBxlXmF/8SlDBsPUCem/jE7ZsMgSS1Q0T9AGTj4YWzy0vP7blIm88ambFQ68vHda9x5MDbUA==@nongnu.org
X-Gm-Message-State: AOJu0Yxd8yxsfSiKW0ZChYTqRJ7U9lFUoaoN1jNEQ6cAJy0gzfg3uo0a
 3NyIP4gNv4hV5tAcuypggV9Gzo4Omm1R4wc30ti1HU3BxlfzzTDbCn4b6Cn/Xd0+l42mYnxjL2/
 yqd1WFR+mTEwyGDFdVAM6Nhv6/9v1/HA1mco=
X-Google-Smtp-Source: AGHT+IEuHbSMHhciXOQeVWo/jcRj8QkJsrYjVibK7v3oG8+dcoo3wjnL552kan0g5CV6+5onJ0y8jwXXynGyKwR7ARA=
X-Received: by 2002:a05:6e02:1a21:b0:39b:34dd:43d1 with SMTP id
 e9e14a558f8ab-39e3c9c2b0amr140803705ab.22.1724720985688; Mon, 26 Aug 2024
 18:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240718064925.1846074-1-jamin_lin@aspeedtech.com>
 <20240718064925.1846074-5-jamin_lin@aspeedtech.com>
 <de851b5c-5983-44f6-955a-6ba71f966c71@kaod.org>
 <SI2PR06MB5041E3D271FB5839B12E76D4FCAC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <c7d00701-cada-4ed8-856b-85249aa1ac0b@kaod.org>
 <SI2PR06MB5041D50CAC61711661F4B56FFCB42@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <62fad646-c132-4de3-8e57-aaa5cb23cc2f@kaod.org>
In-Reply-To: <62fad646-c132-4de3-8e57-aaa5cb23cc2f@kaod.org>
From: =?UTF-8?B?5p6X5bu65piO?= <jaminlin1207@gmail.com>
Date: Tue, 27 Aug 2024 09:09:34 +0800
Message-ID: <CA+8rw5zLt2WDqO=uN_7=OSb6N7ZQi=hbkKRg2S+DE1V6hsn-LQ@mail.gmail.com>
Subject: Re: [PATCH v1 04/15] hw/i2c/aspeed: support discontinuous register
 memory region of I2C bus
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>, 
 Yunlin Tang <yunlin.tang@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d35;
 envelope-from=jaminlin1207@gmail.com; helo=mail-io1-xd35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Cedric,

C=C3=A9dric Le Goater <clg@kaod.org> =E6=96=BC 2024=E5=B9=B48=E6=9C=8826=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:49=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hello Jamin,
>
> On 7/26/24 08:00, Jamin Lin wrote:
> > Hi Cedric,
>
> I will looked at v2. Sorry for the late reply, I was on PTO.
>
> Thanks,
>
> C.
>
Thanks for help

Due to my company internal policy, it will automatically add the
following statement if I reply the reviewers questions via my outlook
with my aspeed account.
Therefore, I will change to use my personal gmail to reply reviewers questi=
on.
My Chinese name is "=E6=9E=97=E5=BB=BA=E6=98=8E"  gmail: jaminlin1207@gmail=
.com


************* Email Confidentiality Notice ********************
 =E5=85=8D=E8=B2=AC=E8=81=B2=E6=98=8E:
 =E6=9C=AC=E4=BF=A1=E4=BB=B6(=E6=88=96=E5=85=B6=E9=99=84=E4=BB=B6)=E5=8F=AF=
=E8=83=BD=E5=8C=85=E5=90=AB=E6=A9=9F=E5=AF=86=E8=B3=87=E8=A8=8A=EF=BC=8C=E4=
=B8=A6=E5=8F=97=E6=B3=95=E5=BE=8B=E4=BF=9D=E8=AD=B7=E3=80=82=E5=A6=82 =E5=
=8F=B0=E7=AB=AF=E9=9D=9E=E6=8C=87=E5=AE=9A=E4=B9=8B=E6=94=B6=E4=BB=B6=E8=80=
=85=EF=BC=8C=E8=AB=8B=E4=BB=A5=E9=9B=BB=E5=AD=90=E9=83=B5=E4=BB=B6=E9=80=9A=
=E7=9F=A5=E6=9C=AC=E9=9B=BB=E5=AD=90=E9=83=B5=E4=BB=B6=E4=B9=8B=E7=99=BC=E9=
=80=81=E8=80=85,
=E4=B8=A6=E8=AB=8B=E7=AB=8B=E5=8D=B3=E5=88=AA=E9=99=A4=E6=9C=AC=E9=9B=BB=E5=
=AD=90=E9=83=B5=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=92=8C=E9=8A=
=B7=E6=AF=80=E6=89=80=E6=9C=89=E8=A4=87=E5=8D=B0=E4=BB=B6=E3=80=82=E8=AC=9D=
=E8=AC=9D=E6=82=A8=E7=9A=84=E5=90=88=E4=BD=9C!

 DISCLAIMER:
 This message (and any attachments) may contain legally privileged
and/or other confidential information. If you have received it in
error, please notify the sender by reply e-mail and immediately delete
the e-mail and any attachments without copying or disclosing the
contents. Thank you.

Thanks-Jamin
>
>
>
>
> >> Subject: Re: [PATCH v1 04/15] hw/i2c/aspeed: support discontinuous reg=
ister
> >> memory region of I2C bus
> >>
> >> On 7/18/24 11:44, Jamin Lin wrote:
> >>> Hi Cedric,
> >>>
> >>>> Subject: Re: [PATCH v1 04/15] hw/i2c/aspeed: support discontinuous
> >>>> register memory region of I2C bus
> >>>>
> >>>> On 7/18/24 08:49, Jamin Lin wrote:
> >>>>> It only support continuous register memory region for all I2C bus.
> >>>>> However, the register address of all I2c bus are discontinuous for
> >>>>> AST2700.
> >>>>>
> >>>>> Ex: the register address of I2C bus for ast2700 as following.
> >>>>> 0x100 - 0x17F: Device 0
> >>>>> 0x200 - 0x27F: Device 1
> >>>>> 0x300 - 0x37F: Device 2
> >>>>> 0x400 - 0x47F: Device 3
> >>>>> 0x500 - 0x57F: Device 4
> >>>>> 0x600 - 0x67F: Device 5
> >>>>> 0x700 - 0x77F: Device 6
> >>>>> 0x800 - 0x87F: Device 7
> >>>>> 0x900 - 0x97F: Device 8
> >>>>> 0xA00 - 0xA7F: Device 9
> >>>>> 0xB00 - 0xB7F: Device 10
> >>>>> 0xC00 - 0xC7F: Device 11
> >>>>> 0xD00 - 0xD7F: Device 12
> >>>>> 0xE00 - 0xE7F: Device 13
> >>>>> 0xF00 =E2=80=93 0xF7F: Device 14
> >>>>> 0x1000 =E2=80=93 0x107F: Device 15
> >>>>>
> >>>>> Introduce a new class attribute to make user set each I2C bus gap s=
ize.
> >>>>> Update formula to create all I2C bus register memory regions.
> >>>>
> >>>> I don't think this is necessary to model. Could we simply increase
> >>>> tge register MMIO size for the AST2700 bus model and rely on the
> >>>> memops to catch invalid register offsets ?
> >>>>
> >>> Thanks for your review and suggestion.
> >>>
> >>> Sorry, I am not very clearly understand your comments.
> >>> Could you please describe it more detail?
> >>> Thanks-Jamin
> >>
> >> I don't think you need to introduce a gap size class attribute.
> >>
> >> Setting :
> >>
> >>       aic->reg_size =3D 0x100; /* size + gap */
> >>
> >> in aspeed_2700_i2c_class_init() should be enough.
> >>
> > Sorry reply you late.
> >
> > The address space of I2C bus and pool buffer are as following
> > 0x100 - 0x17F: device1_reg  0x1a0 - 0x1bf: device1_buf
> > 0x200 - 0x27F: device2_reg  0x2a0 - 0x2bf:device2_buf
> > 0x300 - 0x37F: device3_reg  0x3a0 -0x3bf: device3_buf
> >
> > I tried to set the aic->reg_size 0x100 and aic->pool_size 0x100.
> > And the memory regions of I2c bus became as following.
> >
> > 0x100-0x1ff aspeed.i2c.bus.0  0x1a0-0x29f aspeed.i2c.bus.0.pool
> > 0x200-0x2ff aspeed.i2c.bus.1  0x2a0-0x39f aspeed.i2c.bus.1.pool
> > 0x300-0x3ff aspeed.i2c.bus.2  0x3a0-0x49f aspeed.i2c.bus.2.pool
> >
> > 0000000014c0f000-0000000014c10fff (prio 0, i/o): aspeed.i2c
> >      0000000014c0f100-0000000014c0f1ff (prio 0, i/o): aspeed.i2c.bus.0
> >      0000000014c0f1a0-0000000014c0f29f (prio 0, i/o): aspeed.i2c.bus.0.=
pool
> >      0000000014c0f200-0000000014c0f2ff (prio 0, i/o): aspeed.i2c.bus.1
> >      0000000014c0f2a0-0000000014c0f39f (prio 0, i/o): aspeed.i2c.bus.1.=
pool
> >      0000000014c0f300-0000000014c0f3ff (prio 0, i/o): aspeed.i2c.bus.2
> >      0000000014c0f3a0-0000000014c0f49f (prio 0, i/o): aspeed.i2c.bus.2.=
pool
> >
> > The memory region of aspeed.i2c.bus.0 (0x100-0x1ff) occupied aspeed.i2c=
.bus.0.pool address space(0x1a0-0x1bf).
> > And the memory region of aspeed.i2c.bus.0.pool (0x1a0-0x29f) occupied a=
speed.i2c.bus.1 address space(0x200-0x27F)
> > That was why I created reg_gap_size and pool_gap_size to fix this issue=
.
> > Do you have any suggestion?
> >
> > Thanks-Jamin
> >
> >> Thanks,
> >>
> >> C.
> >>
> >
> > ************* Email Confidentiality Notice ********************
> > =E5=85=8D=E8=B2=AC=E8=81=B2=E6=98=8E:
> > =E6=9C=AC=E4=BF=A1=E4=BB=B6(=E6=88=96=E5=85=B6=E9=99=84=E4=BB=B6)=E5=8F=
=AF=E8=83=BD=E5=8C=85=E5=90=AB=E6=A9=9F=E5=AF=86=E8=B3=87=E8=A8=8A=EF=BC=8C=
=E4=B8=A6=E5=8F=97=E6=B3=95=E5=BE=8B=E4=BF=9D=E8=AD=B7=E3=80=82=E5=A6=82 =
=E5=8F=B0=E7=AB=AF=E9=9D=9E=E6=8C=87=E5=AE=9A=E4=B9=8B=E6=94=B6=E4=BB=B6=E8=
=80=85=EF=BC=8C=E8=AB=8B=E4=BB=A5=E9=9B=BB=E5=AD=90=E9=83=B5=E4=BB=B6=E9=80=
=9A=E7=9F=A5=E6=9C=AC=E9=9B=BB=E5=AD=90=E9=83=B5=E4=BB=B6=E4=B9=8B=E7=99=BC=
=E9=80=81=E8=80=85, =E4=B8=A6=E8=AB=8B=E7=AB=8B=E5=8D=B3=E5=88=AA=E9=99=A4=
=E6=9C=AC=E9=9B=BB=E5=AD=90=E9=83=B5=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=
=BB=B6=E5=92=8C=E9=8A=B7=E6=AF=80=E6=89=80=E6=9C=89=E8=A4=87=E5=8D=B0=E4=BB=
=B6=E3=80=82=E8=AC=9D=E8=AC=9D=E6=82=A8=E7=9A=84=E5=90=88=E4=BD=9C!
> >
> > DISCLAIMER:
> > This message (and any attachments) may contain legally privileged and/o=
r other confidential information. If you have received it in error, please =
notify the sender by reply e-mail and immediately delete the e-mail and any=
 attachments without copying or disclosing the contents. Thank you.
>
>

