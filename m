Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE78C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 03:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdLDs-0006qc-5M; Wed, 29 Jan 2025 22:28:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tdLDq-0006pp-0x; Wed, 29 Jan 2025 22:28:06 -0500
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tdLDo-0007yW-Dp; Wed, 29 Jan 2025 22:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1738207680;
 bh=pgDb+adZTooHqfIslcsU8s6nscTALv9h2vLmELwsp3o=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=BmCEmDJ1tqTfrUFOZiXZSyLX30P6tHMj0DuWpA4BaO7kwLtNBglAorNX8n4F804nL
 45JcvI+0Wmcu1WtrxY+zIzFu7Jz17xEAUDJQSRy0lb8jzSroandmV1ffv9SxM3mIDM
 h3LRLKH6WnE8Hn3hyIQmuxB0gB3pNRPCyhTMyOr/vKkdSDfTH3Ayhx2KFtK2VNl5HL
 hHkQXpmdnWWYt4c0q0S1EAbEY3nFrLpgavAGw+wnFUGo9MiDTt+CLfGLdCckCSeM4l
 8ZRTgmxranHrcoLa+leCjkozLMdWMr46NhG3W1D/1z8EU4YUWEyEeye0MRP4TPyeIn
 +VTEaVpxlhboQ==
Received: from [192.168.68.112] (58-7-158-64.dyn.iinet.net.au [58.7.158.64])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 047FE73803;
 Thu, 30 Jan 2025 11:27:59 +0800 (AWST)
Message-ID: <a79adeedb42dd323f4b6dc0b02b3e4efe1edea92.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 01/18] hw/intc/aspeed: Rename INTC to INTC0
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?ISO-8859-1?Q?C=E9dric?= Le
 Goater <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Joel Stanley
 <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
Date: Thu, 30 Jan 2025 13:57:59 +1030
In-Reply-To: <20250121070424.2465942-2-jamin_lin@aspeedtech.com>
References: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
 <20250121070424.2465942-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 2025-01-21 at 15:04 +0800, Jamin Lin wrote:
> The design of the INTC has significant changes in the AST2700 A1. In
> the
> AST2700 A0, there was one INTC controller, whereas in the AST2700 A1,
> there were two INTC controllers: INTC0 (CPU DIE) and INTC1 (I/O DIE).
>=20
> The previous INTC model only supported the AST2700 A0 and was
> implemented for
> the INTC0 (CPU DIE). To support the future INTC1 (I/O DIE) model,
> rename INTC
> to INTC0.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
> =C2=A0hw/arm/aspeed_ast27x0.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 6 +--
> =C2=A0hw/intc/aspeed_intc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 90 +++++++++++++++++----------------
> --
> =C2=A0include/hw/arm/aspeed_soc.h=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0include/hw/intc/aspeed_intc.h |=C2=A0 2 +-
> =C2=A04 files changed, 50 insertions(+), 50 deletions(-)
>=20
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 4114e15ddd..ba461fcd3c 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -56,7 +56,7 @@ static const hwaddr aspeed_soc_ast2700_memmap[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_DEV_ETH2]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D=C2=A0 0x14060000,
> =C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_DEV_ETH3]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D=C2=A0 0x14070000,
> =C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_DEV_EMMC]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D=C2=A0 0x12090000,
> -=C2=A0=C2=A0=C2=A0 [ASPEED_DEV_INTC]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
=C2=A0 0x12100000,
> +=C2=A0=C2=A0=C2=A0 [ASPEED_DEV_INTC0]=C2=A0=C2=A0=C2=A0=C2=A0 =3D=C2=A0 =
0x12100000,
> =C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_DEV_SLI]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D=C2=A0 0x12C17000,
> =C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_DEV_SLIIO]=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
=C2=A0 0x14C1E000,
> =C2=A0=C2=A0=C2=A0=C2=A0 [ASPEED_GIC_DIST]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D=C2=A0 0x12200000,
> @@ -372,7 +372,7 @@ static void aspeed_soc_ast2700_init(Object *obj)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 object_initialize_child(obj, "sli", &s->sli,
> TYPE_ASPEED_2700_SLI);
> =C2=A0=C2=A0=C2=A0=C2=A0 object_initialize_child(obj, "sliio", &s->sliio,
> TYPE_ASPEED_2700_SLIIO);
> -=C2=A0=C2=A0=C2=A0 object_initialize_child(obj, "intc", &a->intc,
> TYPE_ASPEED_2700_INTC);
> +=C2=A0=C2=A0=C2=A0 object_initialize_child(obj, "intc", &a->intc,
> TYPE_ASPEED_2700_INTC0);

Shouldn't we also change the propname to "intc0" (... if we're to
continue with that style of naming)?

Andrew

