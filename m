Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA77D17148
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 23:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t31uy-0003um-2e; Mon, 21 Oct 2024 19:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1t31uv-0003th-2b; Mon, 21 Oct 2024 19:34:29 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1t31ut-0001IK-0m; Mon, 21 Oct 2024 19:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1729553655;
 bh=d5JG5wsjW6g0mdPZ4zU9j4RNCbMgtN5vhJXF39unCJY=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=dJFw6+bbE8K2hVjPq0+GMFMViwTaxI8L6NmHSCR4jkZCmshsZM0oUGEkFYxnUlo8I
 gu4ioocE0FN56C75emwEE92WA8HsMyVLB93vwzOpuPFXcD8cw+A0IAESg5lln/PW/l
 5ZdBkcxshypDuA8yW7DD9fYa4M89k+vDyn7snrkkQHtB6SpTV3wmx9lYh6mce7HGqI
 +j5C7ruJThqcxZq7im1nsgRG6hdjsqrN4iYALqIguf7QiFu8cupNmXXLbGd3ayzTzB
 sdy4pVCJqNvO2l6fxk0W79DrWZ6T4rJk9FI+yfLfXo1LpWG5ENoCgz+GySA9bRTIZg
 In6kjSCjM5G9w==
Received: from [192.168.68.112]
 (ppp118-210-184-223.adl-adc-lon-bras34.tpg.internode.on.net
 [118.210.184.223])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0F7D2649D3;
 Tue, 22 Oct 2024 07:34:12 +0800 (AWST)
Message-ID: <df7845ea9bb3b4841ba18dbeb10e9b109a28af51.camel@codeconstruct.com.au>
Subject: Re: [SPAM] [PATCH v1 11/16] test/qtest/aspeed_smc-test: Support to
 test all flash models
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Joel
 Stanley <joel@jms.id.au>,  Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
Date: Tue, 22 Oct 2024 10:04:11 +1030
In-Reply-To: <777c3650-5e02-4ab0-a900-ecb0e425b935@kaod.org>
References: <20241018053112.1886173-1-jamin_lin@aspeedtech.com>
 <20241018053112.1886173-12-jamin_lin@aspeedtech.com>
 <777c3650-5e02-4ab0-a900-ecb0e425b935@kaod.org>
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

On Mon, 2024-10-21 at 14:39 +0200, C=C3=A9dric Le Goater wrote:
> On 10/18/24 07:31, Jamin Lin wrote:
> > Currently, these test cases used the hardcode offset 0x1400000 (0x14000=
 * 256)
> > which was beyond the 16MB flash size for flash page read/write command =
testing.
> > However, the default fmc flash model of ast1030-a1 EVB is "w25q80bl" wh=
ose size
> > is 1MB. To test all flash models, introduces a new page_addr member in =
TestData
> > structure, so users can set the offset for flash parge read/write comma=
nd
> > testing.
>=20
> The commit title and description are confusing. By "all flash" models,
> do you mean "all Aspeed SoC" models ?

I think it only relates to the SoCs insofar as the AST1030 embeds some
flash in the SoC? Otherwise it's dependent on the flash model
associated with the board?

>=20
> Since the change is introducing a 'page_addr' data field. I think
> this should be the title.

I agree that including something about page_addr in the title would be
an improvement.

Andrew

