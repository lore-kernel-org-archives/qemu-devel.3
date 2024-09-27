Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1534ECEBF6B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 02:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su0aT-0006pc-AF; Thu, 26 Sep 2024 22:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1su0aQ-0006k5-3D; Thu, 26 Sep 2024 22:20:02 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1su0aO-0007rb-5y; Thu, 26 Sep 2024 22:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1727403593;
 bh=cm1nC1Y8MQ1E3bPX8fk0KXIdZ8AlPJE+1PF/2ZLOrRI=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=Jbnj/NeaRdBFdV+9TuheonzdWVuHHiW0cJDEvh19KliyHSdeNp6DoViGjWuoiu5JQ
 zmo8jvcIvEl2dsgKV0CWu7oabl/NMjWR8HawTRFmStHELOZwYb81cOaarZ6fT+FmvN
 5wQpy6wY2AgnrKRfuDPlZcd4g1PaKXpva0M3rD3JJBGPhOoFsxhgy0etlRiSpHEs9q
 pzyw7ImzgiMpoRiWxGBJDZEknaVLiGPn5J0VK5cwSmkJnCpMMvYvCxFxAxUMCo4xC8
 P+joYOC2rQVacZGnKfLLcJqUoILewQNLwY9M5X84JLbvVH44QhfNoyk2KvybwdC/UA
 Ny1RcuoYTQvcA==
Received: from [192.168.68.112]
 (ppp118-210-187-73.adl-adc-lon-bras34.tpg.internode.on.net [118.210.187.73])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 34F9A6502D;
 Fri, 27 Sep 2024 10:19:53 +0800 (AWST)
Message-ID: <599cdb2fa47a4c1da5775be175ec67d66cf7cf43.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 5/6] hw/gpio/aspeed: Add AST2700 support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?ISO-8859-1?Q?C=E9dric?= Le
 Goater <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Joel Stanley
 <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
Date: Fri, 27 Sep 2024 11:49:52 +0930
In-Reply-To: <20240926074535.1286209-6-jamin_lin@aspeedtech.com>
References: <20240926074535.1286209-1-jamin_lin@aspeedtech.com>
 <20240926074535.1286209-6-jamin_lin@aspeedtech.com>
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

On Thu, 2024-09-26 at 15:45 +0800, Jamin Lin wrote:
> AST2700 integrates two set of Parallel GPIO Controller
> with maximum 212 control pins, which are 27 groups.
> (H, exclude pin: H7 H6 H5 H4)
>=20
> In the previous design of ASPEED SOCs,
> one register is used for setting one function for one set which are 32 pi=
ns
> and 4 groups.
> ex: GPIO000 is used for setting data value for GPIO A, B, C and D in AST2=
600.
> ex: GPIO004 is used for setting direction for GPIO A, B, C and D in AST26=
00.
>=20
> However, the register set have a significant change since AST2700.
> Each GPIO pin has their own individual control register. In other words, =
users are able to
> set one GPIO pin=E2=80=99s direction, interrupt enable, input mask and so=
 on
> in the same one register.
>=20
> Currently, aspeed_gpio_read/aspeed_gpio_write callback functions
> are not compatible AST2700.
> Introduce new aspeed_gpio_2700_read/aspeed_gpio_2700_write callback funct=
ions
> and aspeed_gpio_2700_ops memory region operation for AST2700.
> Introduce a new ast2700 class to support AST2700.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>

Some of the wrapping in the commit message could be improved, but
otherwise:

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>


