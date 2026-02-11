Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C880E9E2E7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 11:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq8WH-0001NT-NF; Wed, 11 Feb 2026 06:36:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1vq8WF-0001N6-UY
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 06:36:31 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1vq8WE-0005uN-AS
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 06:36:31 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b885a18f620so1010785266b.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 03:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770809788; x=1771414588; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DYIo839IYG0MOxDk0s4cW9OcfF7rPSOxqXyzcmoIfDg=;
 b=L3uRT20vzieJjQQTsatyJgB6KK2AVEIc5xfEovJSAYoM50nDmCiwy1ccrXm1Y7dc1Z
 qDvEqm0xDDKGoE/BMc9rq4sZPUspwfPtI5pMB23X4bx+9/LeZwX4johD+ncKoD7P0HSO
 Wlh/z48FR312ExeYl3ZBnmOD50P9hfT4LjGZBD3df3m5f96ViJsbclQs1coi/JWNoGGW
 aODbC5cMUhCu2hUKF+7D+XrdOU6OLL80sE2fUGugDpUx7aWhboZheeVL6pUwxNYcb24S
 ZcdCqZufwFlB+LvRMU4g96KLDOmoSKyMHkfj5t5g6B8Jivsx502nSr9hVLtuU9C2yjTd
 ITQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770809788; x=1771414588;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DYIo839IYG0MOxDk0s4cW9OcfF7rPSOxqXyzcmoIfDg=;
 b=FI7kHsfZ5lQBIz2CNL4S5KTEBgws3nth7WHIZ5ft6h1ttHcC4EYc2h5gP+XbNZxKYZ
 gdzXVZXc/Brk4aHtoPEnZcD5KreucwxwfyY2zRAqoTO4wfFn4LHRTSairR8GwBUJlspA
 CvaFUE2VM3SZXp+VSwYt3ozIPC3rMbdconU14FJcZjtejtFfupFiu9pWTk0UNhNsVJ/e
 AxgjFZIBVEhiWtVagxd4ekYa8gnFfZWUg+TBUCzurH768gAH5o98ym5e/CllipEH2xIC
 MonDDKbgkDVShPiQ1BVQvUQCRye4IotOC7yIgTM1RBBldbXhZjMVeqc/eqXa1inuvXHl
 RVbQ==
X-Gm-Message-State: AOJu0YylghbFT4r0dEAv0gDtNdSsgygnQbfNol8VcZe4ILEn2biJS4fd
 QsQjdxeAlq2Zzjil9V7jllRWby/EZ8hEhQECmvZcxKSQfoLYbk4Es1Pd
X-Gm-Gg: AZuq6aI8SvqM8i06xcotNtrh893sR1uwck1ECDAs4oAQx6Nf4ZiDMbfu1l00WhPs3+H
 EKDbcKJF1qzkBPKP5lzPDs0K+4L0TXZKWoz1HMWPptrpxtk8BlTFjRBsl3BMz0V4nj6GxObJ2zT
 oSdIkbMt4qcBd4m055FWF8ctT1PgLgPWKk81D8GHrCrjJ+P5jycRKNcet6x9i6gdLsfcREpuYmo
 8Tq8fS8ABVwpxnPBz+32ae63Y+6Bye1On6CQ/Kg+iW4ThHrh8mj2whtdiPPs+hxs2YIkaPi6qNX
 WazLTrBlHu7zhqnN2eZs8zy8oyICi9hNQ2Ynl7ybni4H5NDOO9xNx8QFFSF1iRr2UXtBJ7fKkmh
 neyUxEXTpG/4QVAXWLoIWi/wNO4qxRscV4TtIL4L+0RXaSqwkoIbWtPYDaVka4K3GiujM9XgYj2
 ngnmQx5UCmLEn1OkjrdbpYFF7rzlwxxkKGH0qgckFHr5ekmn8jTa01PjvYgbcbekdJugdE/x+lb
 te/Q0jZuYTH2FvBu7Zz28D39A1ZYT2xTAUDyZrIPF2HsFCkFgHUgRhG11iE+ixyf5DmkHMvd3Iy
 udMFGgCoeNI1CZesUG4RNraKpgfFlbDEDzibTR+3OXG7T/A+qIoF4ilPGm/Yug==
X-Received: by 2002:a17:907:d14:b0:b83:1433:78de with SMTP id
 a640c23a62f3a-b8f714f97fbmr105962866b.12.1770809787937; 
 Wed, 11 Feb 2026 03:36:27 -0800 (PST)
Received: from ?IPv6:2001:1c0f:81f:8e00:561f:8baa:54e2:9aa0?
 (2001-1c0f-081f-8e00-561f-8baa-54e2-9aa0.cable.dynamic.v6.ziggo.nl.
 [2001:1c0f:81f:8e00:561f:8baa:54e2:9aa0])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8f6ecadb32sm51723866b.64.2026.02.11.03.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 03:36:27 -0800 (PST)
Message-ID: <a319dce1e9ed3daefe744d4a198748bd5fa55b7f.camel@gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Implement frame number overflow event
From: Howard Spoelstra <hsp.cat7@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>, Peter Maydell
 <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Phil =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>
Date: Wed, 11 Feb 2026 12:36:26 +0100
In-Reply-To: <04edd79e-2ec4-912e-d8ad-6012feaa3c99@eik.bme.hu>
References: <20260209001836.5413F5969F2@zero.eik.bme.hu>
 <CAFEAcA-HwiOfh6sXa3OvFtrMotoaEpB9ZoLXq_5aXDoVqh8wqA@mail.gmail.com>
 <61b053d3-70e0-4b63-8b32-c8c7bef36229@eik.bme.hu>
 <04edd79e-2ec4-912e-d8ad-6012feaa3c99@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=hsp.cat7@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 2026-02-10 at 16:40 +0100, BALATON Zoltan wrote:
> On Tue, 10 Feb 2026, BALATON Zoltan wrote:
> > On Tue, 10 Feb 2026, Peter Maydell wrote:
> > > On Mon, 9 Feb 2026 at 00:19, BALATON Zoltan <balaton@eik.bme.hu>
> > > wrote:
> > > >=20
> > > > According to specification 6.5.6 FrameNumberOverflow Event when
> > > > bit 15
> > > > of frame count changes (either from 1 to 0 or 0 to 1) a
> > > > FrameNumberOverflow interrupt should be generated.
> > > >=20
> > > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > >=20
> > > Is this a bug fix for some specific problem (e.g. it fixes
> > > handling for some guest OS)? If so, we should say what it's
> > > fixing in the commit message, so that if we ever come back
> > > to this in future we know what we need to test to make sure
> > > we don't re-break it.
> >=20
> > Primarily it fixes what it says in the commit message: compliance
> > to the=20
> > actual specification but it also seems to help MacOS to be able to
> > use=20
> > usb-audio which was how Howard found it. Unless there's something
> > else to=20
> > change in the patch I'm not sending a v2 feel free to tweak commit
> > message on=20
> > merge if needed.
>=20
> There's also this ticket that Howard sent me:
> https://gitlab.com/qemu-project/qemu/-/issues/3274
> but I don't know if we can add a Resolves to this patch for that as
> it=20
> only solves one of the issues the patch in that ticket tries to solve
> but=20
> apparently this is enough for MacOS 9. I hoped those involved in that
> ticket could test this or comment on this patch.
>=20
> Regards,
> BALATON Zoltan
>=20
> For Mac OS 9.x this patch is sufficient. But not for Mac OS X guests.
> They require a second patch along the lines the one I sent earlier.
> That second patch is also based on hcd-ohci not conforming to the
> standard regarding (start_addr > end_addr) if these are not on the
> same page and the start_addr is higher than the end_addr. See spec
> 4.3.2.3.1 Buffer Addressing.
>=20
> Best,
Howard

