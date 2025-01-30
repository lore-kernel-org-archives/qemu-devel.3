Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5508AC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 03:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdL8H-0005tj-Gj; Wed, 29 Jan 2025 22:22:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tdL8F-0005tW-Ub; Wed, 29 Jan 2025 22:22:19 -0500
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tdL8D-0007Pg-33; Wed, 29 Jan 2025 22:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1738207331;
 bh=JRnk1Jy3uF8oUUdYOGtwQqaTUM7N9ifDICdlGehOZaA=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=jFh12HKMoYjn3xPtP4sVfFqHgAy0PFX9VCyhH2PnZmBRss23zDQEs1SI/7reZF6Fw
 kak2vl/Wzh9opMSuG9rpFGMuH/eDI1Qshd4p6JWg5KtFox0N7DB0EUqZOwnkSQHmJv
 LRXo1yWuRMQkkde3a4gtpquo8Vz/TNbCFkhqSSUXTa0OQ/OP+bDUjn5TRVSBHUIjyV
 wh6bT1DQz8fKVFvDmVVWuSYqHz0ITBV6spVXuYBeE9owH1t0YOWVBOtPZnlZz9mZBu
 ENVTcsEA4eeU7MIdq+oop+Vf4t5vAzM33HEsb56lBfETpFvLjLx5+1NCPkbriAaeD7
 jeOeVDT0RiW1Q==
Received: from [192.168.68.112] (58-7-158-64.dyn.iinet.net.au [58.7.158.64])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3C70E73803;
 Thu, 30 Jan 2025 11:22:10 +0800 (AWST)
Message-ID: <d9575d2cec122e41e11d84667f4d7cc63848b3ce.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 01/18] hw/intc/aspeed: Rename INTC to INTC0
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Joel
 Stanley <joel@jms.id.au>,  "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
Date: Thu, 30 Jan 2025 13:52:09 +1030
In-Reply-To: <2d9247ab-34dd-4dde-a9c0-c04c2d8a1a18@kaod.org>
References: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
 <20250121070424.2465942-2-jamin_lin@aspeedtech.com>
 <2d9247ab-34dd-4dde-a9c0-c04c2d8a1a18@kaod.org>
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

On Wed, 2025-01-29 at 18:03 +0100, C=C3=A9dric Le Goater wrote:
> On 1/21/25 08:04, Jamin Lin wrote:
> > The design of the INTC has significant changes in the AST2700 A1.
> > In the
> > AST2700 A0, there was one INTC controller, whereas in the AST2700
> > A1,
> > there were two INTC controllers: INTC0 (CPU DIE) and INTC1 (I/O
> > DIE).
> >=20
> > The previous INTC model only supported the AST2700 A0 and was
> > implemented for
> > the INTC0 (CPU DIE). To support the future INTC1 (I/O DIE) model,
> > rename INTC
> > to INTC0.
>=20
>=20
> Why not introduce definitions with _INTC_IO_ and leave alone the
> current
> instead ? Do we expect to have more than 2 INTC controllers ?
>=20

There was similar discussion on the devicetree bindings for the SCU a
while back:

https://lore.kernel.org/all/94efc2d4ff280a112b869124fc9d7e35ac031596.camel@=
codeconstruct.com.au/

Ryan didn't like deviating from their internal documentation :(

Andrew

