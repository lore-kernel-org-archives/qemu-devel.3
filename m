Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D65C77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 23:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUCqN-0002qa-5Q; Tue, 24 Jun 2025 19:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1uUCqD-0002pS-8k; Tue, 24 Jun 2025 19:14:13 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1uUCqA-00038I-TL; Tue, 24 Jun 2025 19:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1750806839;
 bh=TZirEK5Lf+fDKpcU6BgJPmCkKx5LZZpaipXUQnEXOqA=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=HSt7LGDNXklGvwpXmUblXoU+PZ5LEP0Wbe2SErlgoNvX4ODjJnrktMbuX5w6EygvG
 T837orcTvpJnF/q+Y3fxzpRnSI3GcNedG/FpsoegJrdVZTvOqsV6nC8sJkTXC6qnWS
 O9lSu1iBG6Xkjh/xr0za+WYIHVqmQDcB8pnBSSFxn2MzZi6B5pkbSHNyaILqmho9wi
 sH2cL3KQ3qN6Xy8/QJ4+O28CjNBMNv9mhZInMxxoUk0RvsOel7Zl7MPD/Hwm4DTArX
 5KQnduP1IzxMzwZoewirUcT7Gl+ydCF0mRToLGb6FMgMJORVH2S1+Xrnbo22HhtMeN
 /NNhWup0iNjJQ==
Received: from [192.168.68.112] (unknown [180.150.112.166])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 40423640CD;
 Wed, 25 Jun 2025 07:13:56 +0800 (AWST)
Message-ID: <2e5e17451b9e59cb8108fb6c2a88f40ba69be4ee.camel@codeconstruct.com.au>
Subject: Re: aspeed: Split the machine definition into individual source files
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, 
 "'qemu-arm@nongnu.org'" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
Cc: Joel Stanley <joel@jms.id.au>, 'Jamin Lin' <jamin_lin@aspeedtech.com>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Peter
 Maydell <peter.maydell@linaro.org>, Patrick Williams <patrick@stwcx.xyz>
Date: Wed, 25 Jun 2025 08:43:56 +0930
In-Reply-To: <e2df1ff1-3ce4-4233-b32e-2bc680725c71@kaod.org>
References: <e2df1ff1-3ce4-4233-b32e-2bc680725c71@kaod.org>
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

On Thu, 2025-06-19 at 11:23 +0200, C=C3=A9dric Le Goater wrote:
> Hi,
>=20
> This is a follow up of a private discussion with Patrick.
>=20
> Aspeed modeling started nearly 10y ago with the palmetto-bmc machine.
> We now have 5 SoCs and 25 machines which are mostly defined in
> in a single aspeed.c file. Multi SoC machines, fby35 and ast2700fc,
> are defined in fby35.c and aspeed_ast27x0-fc.c respectively.
>=20
> Since we started separating the SoCs :
>=20
> =C2=A0=C2=A0 hw/arm/aspeed_ast10x0.c
> =C2=A0=C2=A0 hw/arm/aspeed_ast2400.c
> =C2=A0=C2=A0 hw/arm/aspeed_ast2600.c
> =C2=A0=C2=A0 hw/arm/aspeed_ast27x0.c
> =C2=A0=C2=A0 hw/arm/aspeed_ast27x0-ssp.c
> =C2=A0=C2=A0 hw/arm/aspeed_ast27x0-tsp.c
>=20
> We could do the same for the machines keeping an 'aspeed_ast<rev>'
> prefix (and maybe avoid the 'bmc' suffix). I think this would ease
> introduction of new machines. We would be able to get rid of
> aspeed_eeprom.[ch] and move machine custom data in the machine source
> file. Which seems cleaner.
>=20
> Timing is about right for code reshuffling, still 3w before soft
> freeze, no important changes inflight, but if we start doing this
> conversion, we should do it for all. See the list below for the
> brave.

My involvement has dropped off quite a bit, but for what it's worth,
this seems sensible to me :)

Andrew

