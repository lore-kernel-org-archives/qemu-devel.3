Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D7CC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 04:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdLof-0003SX-5M; Wed, 29 Jan 2025 23:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tdLoB-0003Q7-ID; Wed, 29 Jan 2025 23:05:39 -0500
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tdLo7-0003r4-G4; Wed, 29 Jan 2025 23:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1738209928;
 bh=lRW4xmauVAzJq/V1EL2szV83WG7F+jbac36gaALUJCw=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=Ug7OeyoxWAmvrMAtjmLhvlxMv/wSF19s8e18tv5LCtIi3+AEtuEIEkqIEQp3FBLye
 Ls55C8aX0W+Gb5zrgwXas/bVfSbIoi845DpBeMxNjV5z0jSGLlvlxSGRSTiL53pPYj
 sc01w0ULT1Hz/0huqDig8K8bQ9ZJIeZrccB//qNNI9z9VoW5YxBxjr+xErKCzTrrfq
 1Q9hY23k6Obh1LQwsgZ6dsECpQdDmPYqVgs2v6jycjxkJhF4gqWgXs8onJdptaTEU8
 zuGp2upE8DMHgTZBiZPDzrXM1AZwh95VOxA9KoDTU/c5wcCV/Rcy82Lp3KkQdkKny7
 kPzJUYb3R1t2g==
Received: from [192.168.68.112] (58-7-158-64.dyn.iinet.net.au [58.7.158.64])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 168617383B;
 Thu, 30 Jan 2025 12:05:26 +0800 (AWST)
Message-ID: <64382a15c40b33fcfeeecee5489e0a034313b7ec.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 11/18] hw/misc/aspeed_scu: Add Support for
 AST2700/AST2750 A1 Silicon Revisions
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?ISO-8859-1?Q?C=E9dric?= Le
 Goater <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Joel Stanley
 <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
Date: Thu, 30 Jan 2025 14:35:25 +1030
In-Reply-To: <20250121070424.2465942-12-jamin_lin@aspeedtech.com>
References: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
 <20250121070424.2465942-12-jamin_lin@aspeedtech.com>
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
> Added new definitions for AST2700_A1_SILICON_REV and
> AST2750_A1_SILICON_REV to
> identify the A1 silicon revisions.
>=20
> Update "aspeed_ast2700_scu_reset" to set the silicon_rev field in the
> SCU
> registers.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
> =C2=A0hw/misc/aspeed_scu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 3 +++
> =C2=A0include/hw/misc/aspeed_scu.h | 2 ++
> =C2=A02 files changed, 5 insertions(+)
>=20
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index bac1441b06..f049a9fd96 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -559,6 +559,8 @@ static uint32_t aspeed_silicon_revs[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 AST2700_A0_SILICON_REV,
> =C2=A0=C2=A0=C2=A0=C2=A0 AST2720_A0_SILICON_REV,
> =C2=A0=C2=A0=C2=A0=C2=A0 AST2750_A0_SILICON_REV,
> +=C2=A0=C2=A0=C2=A0 AST2700_A1_SILICON_REV,
> +=C2=A0=C2=A0=C2=A0 AST2750_A1_SILICON_REV,
> =C2=A0};
> =C2=A0
> =C2=A0bool is_supported_silicon_rev(uint32_t silicon_rev)
> @@ -938,6 +940,7 @@ static void aspeed_ast2700_scu_reset(DeviceState
> *dev)
> =C2=A0=C2=A0=C2=A0=C2=A0 AspeedSCUClass *asc =3D ASPEED_SCU_GET_CLASS(dev=
);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 memcpy(s->regs, asc->resets, asc->nr_regs * 4);
> +=C2=A0=C2=A0=C2=A0 s->regs[AST2700_SILICON_REV] =3D s->silicon_rev;

Has s->silicon_rev been set?

Should we now remove the AST2700_SILICON_REV entry from asc->resets?

This seems like a fix regardless. Perhaps separate it from the addition
of the new silicon IDs?

> =C2=A0}
> =C2=A0
> =C2=A0static void aspeed_2700_scu_class_init(ObjectClass *klass, void
> *data)
> diff --git a/include/hw/misc/aspeed_scu.h
> b/include/hw/misc/aspeed_scu.h
> index 356be95e45..684b48b722 100644
> --- a/include/hw/misc/aspeed_scu.h
> +++ b/include/hw/misc/aspeed_scu.h
> @@ -54,6 +54,8 @@ struct AspeedSCUState {
> =C2=A0#define AST2700_A0_SILICON_REV=C2=A0=C2=A0 0x06000103U
> =C2=A0#define AST2720_A0_SILICON_REV=C2=A0=C2=A0 0x06000203U
> =C2=A0#define AST2750_A0_SILICON_REV=C2=A0=C2=A0 0x06000003U
> +#define AST2700_A1_SILICON_REV=C2=A0=C2=A0 0x06010103U
> +#define AST2750_A1_SILICON_REV=C2=A0=C2=A0 0x06010003U

These look fine.

Andrew

> =C2=A0
> =C2=A0#define ASPEED_IS_AST2500(si_rev)=C2=A0=C2=A0=C2=A0=C2=A0 ((((si_re=
v) >> 24) & 0xff) =3D=3D
> 0x04)
> =C2=A0


