Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3413CC3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 01:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzQ88-0000iO-9b; Mon, 31 Mar 2025 21:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tzQ7p-0000au-Iv; Mon, 31 Mar 2025 21:09:12 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tzQ7n-0004xq-IM; Mon, 31 Mar 2025 21:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1743469744;
 bh=OJM+1iFnYxgpP8U7Ia7G3gSRn07/YIXewjJMWPeUWss=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=TIWcdk6TVeRl2vBUEgWMrbMC204lDHLjorBwYtJziwgUCXhDf1aMNYfMHvO6X9D1v
 Br24JMsaMFkkRFrBQLvbsX+RpoDQ3310rEmxm3T5HIc2tJCDUb8Gj8l5iyxpifK0LI
 QRPT5O4JELTCDm9L/FJ9ppPv+s0iChuTPW74UUFgoYovemKQWu3sDfjYfH9xFNVri6
 26Vzv1EESVMFlwVfmwgqcoIvLXOrLz9GbDzgB+sQW7ugUCzqbSl4R5QEcYcjzyrGHO
 OPBEQgrT5ME+fEtlCyAsVqpsNEp7kLGKvNVdb4B7qBY6iwpepFNUfcz52kjUtWZkED
 0vcNdxvnejZVw==
Received: from [10.194.67.88] (unknown [180.150.112.225])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D668F7B352;
 Tue,  1 Apr 2025 09:09:03 +0800 (AWST)
Message-ID: <7c8bb3cd3df86236f59615fb6e8b64a0a65bebf7.camel@codeconstruct.com.au>
Subject: Re: [PATCH-for-10.0 2/2] hw/misc/aspeed_scu: Correct minimum access
 size for AST2500 / AST2600
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>, 
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-arm@nongnu.org
Date: Tue, 01 Apr 2025 11:39:03 +1030
In-Reply-To: <20250331230444.88295-3-philmd@linaro.org>
References: <20250331230444.88295-1-philmd@linaro.org>
 <20250331230444.88295-3-philmd@linaro.org>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, 2025-04-01 at 01:04 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> From: Joel Stanley <joel@jms.id.au>
>=20
> Guest code was performing a byte load to the SCU MMIO region, leading
> to the guest code crashing (it should be using proper accessors, but
> that is not Qemu's bug). Hardware and the documentation[1] both agree
> that byte loads are okay, so change all of the aspeed SCU devices to
> accept a minimum access size of 1.
>=20
> [1] See the 'ARM Address Space Mapping' table in the ASPEED docs.
> This
> is section 6.1 in the ast2400 and ast2700, and 7.1 in the ast2500 and
> ast2600 datasheets.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2636
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Troy Lee <leetroy@gmail.com>
> Message-ID: <20241118021820.4928-1-joel@jms.id.au>
> [PMD: Rebased, only including SCU changes]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

