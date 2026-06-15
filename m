Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE147CD98C7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 12:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ6L1-0004s1-DD; Mon, 15 Jun 2026 08:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wZ6L0-0004rj-Gs
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 08:22:46 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wZ6Ky-0004VP-Nl
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 08:22:46 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5aa68dbb38aso2841985e87.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 05:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781526162; x=1782130962; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=w6xa+Nj4Qvo2+9NgcQDPZ/3tk17AwN5Wknwhm61Rnpc=;
 b=SahscPFTGfD+1tTL1jP/wu8/6yJPo3q493HtI8Duh5mpSNBnsP+cU9iJvgL+Zphz00
 JermduAkI9DA8B2eD8hKi3T8Iqh2jM2cesxEAyI4zIbkVlPdUiok641nsAsVpJy8HVyE
 93SPSOEF/sH75TdztCEFzqgSpMmC4C45noaHgoMClvODPsAr6KADLClQiZEO5aKQ0ua9
 1T8IjWWQctWmjVGPMKJV4Nz6y26xcRfzC0lYC3652EH/X3gC/ALYZZrUlnc/xlLDQTEJ
 57FsPYzGyNagxlZv5Nzb9WK/zBuAX24Ebgybu5wEC/dOu5wHh9TLOdESKqDmlWwQLhAD
 lD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781526162; x=1782130962;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w6xa+Nj4Qvo2+9NgcQDPZ/3tk17AwN5Wknwhm61Rnpc=;
 b=eDMbejdn8Y2srsYb4y8qwz29m43Qo0aLRJc93YmJSdNui4ssU6gk1BVcADIXpE1YDz
 EBjTlAX9btY11YgW9zS81JYmwvmdXnZL9qRSOLm57Qh+u86BzqEaHPotZba8VC0TJcPz
 5ivcjq0p61U7A1sLOMMR8TT8M+5Ba69ApPCFicLPyVdXbB5NZ35YWSMOmekUx+mm56r7
 M0aerlB6orweMFu3lUsJ0E+E4MlSq4ETtDmU7g3hf/m9y/KTIeGxgOmn5kEj8JiPh+wz
 eDqqihLESKUT9NxZYInJ82cSM6xo2O8TP1RcgfFGhit/AlrJsgV+Sgi6q/dKh2VdF9ip
 UNrQ==
X-Gm-Message-State: AOJu0YzsoexwmulX9qat9VCZ0lmwG5H3LYxjf9ybffTWPv4nrAkYgEWw
 bx3XfEJUesCNGbjCmMLPgO1yCqvBi2wuNiCVvlE2W96pJQ1BkQeresrR
X-Gm-Gg: Acq92OFh8VSRvkRsLZbHpfBc6I6wtH86kPmRjd0O2jC8/0X0NmSyqxIrSyfuKEl8Bbq
 /+eDZAif20M8EE0xzlc/B2Tf08J9N+Niq+O3QoWDadpCEJAcsoT6bBMMYJSJzst4bGbCGA4tLm6
 KkSrf9ZOBDWJMkVNnflFerd0f02uEaS1u7pAsDS9z3ZWjL/Gwv4FL3qGRsqXuc/bT83Jigm0jlz
 R5vaNIjqIXaq70Yr+A9RHrhAFNWqLaOivopNjmrcOHACvuKDSC/fhSgksX5rB2lxIGHFpanquRE
 kc96gEo6HK/PQSFxK8QGwhWfeQjoaGaI4YrrlUjvPPZFBhaKoJFvf+Dw1PhMMFJDq+l068xnkhn
 jqgHNrJ7mz5jqGSFbXNOCsX3sv5WM1qsn5WvevUGY1sms8JHerN19iD5qyjaXsKeJkCJDA49RLJ
 7j+gg4APPK3Ra42cr9GCKgEAKWNdR3FgIfllWrsG68sGkaVpU2OR0pdw==
X-Received: by 2002:a05:6512:2388:b0:5aa:64b4:13cf with SMTP id
 2adb3069b0e04-5ad2db245e6mr4267213e87.9.1781526162080; 
 Mon, 15 Jun 2026 05:22:42 -0700 (PDT)
Received: from acidburn.pod.cvut.cz (acidburn.pod.cvut.cz. [147.32.90.2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e16935esm2701651e87.25.2026.06.15.05.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 05:22:41 -0700 (PDT)
Message-ID: <be65c732739e8db8d63fcaf5a90f26d98556a9fd.camel@gmail.com>
Subject: Re: [PATCH v5 0/7] hw/arm/sabrelite: Add FlexCAN support
From: =?UTF-8?Q?Maty=C3=A1=C5=A1?= Bobek <matyas.bobek@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow	
 <shentey@gmail.com>, qemu-arm@nongnu.org, Marc Kleine-Budde
 <mkl@pengutronix.de>,  Oliver Hartkopp <socketcan@hartkopp.net>, Nikita
 Ostrenkov <n.ostrenkov@gmail.com>, Andrey Volkov <andrey@volkov.fr>
Date: Mon, 15 Jun 2026 14:22:40 +0200
In-Reply-To: <CAFEAcA9aX4nhhGW-CxABO80rja9OG2LdwXyJs37=1eyFwPg_ug@mail.gmail.com>
References: <cover.1781111270.git.matyas.bobek@gmail.com>
 <CAFEAcA9aX4nhhGW-CxABO80rja9OG2LdwXyJs37=1eyFwPg_ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=matyas.bobek@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, 2026-06-15 at 13:18 +0100, Peter Maydell wrote:
> On Mon, 15 Jun 2026 at 13:15, Maty=C3=A1=C5=A1 Bobek <matyas.bobek@gmail.=
com>
> wrote:
> >=20
> > This series adds emulation of the FlexCAN CAN controller, version
> > 2,
> > found in NXP i.MX6 series SoCs. The controller is integrated into
> > fsl-imx6 and the Sabrelite ARM board.
> >=20
> > The chip has two FlexCAN controllers, but the Linux Sabrelite
> > device tree enables only one by default. Linux kernel with both
> > controllers enabled has been tested to work properly (using a
> > custom
> > device tree).
> > See docs/system/devices/can.rst for an example of QEMU command line
> > invocation.
> >=20
> > More information about the implementation can be found in my
> > bachelor
> > thesis [1].
> >=20
> > Changes from v4:
> > - renamed can in fsl-imx6 to flexcan
> > - corrected attribution for definitions borrowed from the Linux
> > kernel
> > - rebased onto latest master
> > - Link to v4:
> > https://lore.kernel.org/qemu-devel/cover.1779986496.git.matyas.bobek@gm=
ail.com/
>=20
> Have you fixed the clang sanitizer array-overrun bug that
> I reported against v4?

Oh, I'm afraid I forgot about it. I will fix it and post new version.
Sorry, Matt

