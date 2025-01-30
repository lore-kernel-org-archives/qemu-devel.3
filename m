Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22573C0218D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 03:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdKq0-0003yt-Rx; Wed, 29 Jan 2025 22:03:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tdKpx-0003xf-Ks; Wed, 29 Jan 2025 22:03:25 -0500
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tdKpu-0004zV-EU; Wed, 29 Jan 2025 22:03:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1738206190;
 bh=S5OrvSekYACv8+1dLNThyw1SZ+vG+x19oDy43O1blGs=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=DP+QfC5bxb1c7eMBGhMH44KxM8zMJuol1ilhTDL2G7OqMfLKfAB56EMF+Ambtd/Tu
 7Ap2iK0yhkwrjNFTU1MZeIVkiU2eCpDuTtZeuuruDuj4edtk+8zQshZRipjXDj1rL1
 oL2AB00rfG25LLgoMjyU2jH99BO7WOL/bLaEJde1Gh1QxGRFCPNWcPiM/HbimLNCsy
 emDpimU68Rh0zaj4TOxkBuHowrnQ9CR19os7CQcBBPJDPz3wevu6IIRzC3QWouP4z6
 rIsIgT6Nf7F9DyJTC9EQ7uxSZE2HC/L4tVA/wq7QPBZgTJsojz0un2O7SXN6V3drz4
 wVe1G+RYUQ2ow==
Received: from [192.168.68.112] (58-7-158-64.dyn.iinet.net.au [58.7.158.64])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8825173803;
 Thu, 30 Jan 2025 11:03:08 +0800 (AWST)
Message-ID: <4c7dc177de0e36a6f3e6ee444357f572affc30ca.camel@codeconstruct.com.au>
Subject: Re: [PATCH 0/5] tests/functional: Update Aspeed OpenBMC images
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Troy Lee <troy_lee@aspeedtech.com>, Jamin
 Lin <jamin_lin@aspeedtech.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Thomas Huth <thuth@redhat.com>
Date: Thu, 30 Jan 2025 13:33:07 +1030
In-Reply-To: <78e6b6ad-0422-4b43-95f5-f377ea101f09@redhat.com>
References: <20250128214100.1196243-1-clg@redhat.com>
 <bee99a3ef4821f69f6f1a2f6cfc77c3e247e5d87.camel@codeconstruct.com.au>
 <78e6b6ad-0422-4b43-95f5-f377ea101f09@redhat.com>
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

On Wed, 2025-01-29 at 08:19 +0100, C=C3=A9dric Le Goater wrote:
> On 1/29/25 00:29, Andrew Jeffery wrote:
> > Hi C=C3=A9dric,
> >=20
> > On Tue, 2025-01-28 at 22:41 +0100, C=C3=A9dric Le Goater wrote:
> > > Hello,
> > >=20
> > > This series updates the OpenBMC firmware images to the latest
> > > version
> > > for existing tests and also adds 2 new tests for Aspeed machines
> > > which
> > > were not tested before : witherspoon and bletchley.
> > >=20
> > > Thanks,
> > >=20
> > > C.
> > >=20
> > > C=C3=A9dric Le Goater (5):
> > > =C2=A0=C2=A0 tests/functional: Introduce a new test routine for OpenB=
MC
> > > images
> > > =C2=A0=C2=A0 tests/functional: Update OpenBMC image of palmetto machi=
ne
> > > =C2=A0=C2=A0 tests/functional: Update OpenBMC image of romulus machin=
e
> > > =C2=A0=C2=A0 tests/functional: Introduce a witherspoon machine test
> > > =C2=A0=C2=A0 tests/functional: Introduce a bletchley machine test
> >=20
> > The rest of the patches haven't reached my inbox. Did you send
> > them? It
> > also seems they're missing on lore :)
> >=20
> > https://lore.kernel.org/all/20250128214100.1196243-1-clg@redhat.com/
> I shouldn't send series too late in the evening ...Sorry for the
> noise.
>=20

Hah, no worries. I see Thomas has already reviewed the resend.

Thanks,

Andrew

