Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCA9D60CF8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 22:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDAad-00024A-V4; Mon, 18 Nov 2024 17:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tDAaZ-00023W-S1; Mon, 18 Nov 2024 17:51:24 -0500
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tDAaX-0002NJ-EA; Mon, 18 Nov 2024 17:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1731970269;
 bh=Q1Nh8Exk+mU0FCsSon3uK1rKupXr3I67HHPMK3uXzBs=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=nSuIAgT64zkep7vVdGoCNED9yd9E9iSYjEnGRx4JPy2qM9ig4TjNkE1IKVx23OHu8
 DZHLed7gf1wyjFUG0OzVPrwsbhYpT5xzkbYrfqs/gAV16SUM9uIYuhm7+cTmlfAhnG
 uCzTqWxoOMxS16odSjiL1u7CK9hS/yJJtOUd9IgoCPfPk0YiiQTHA6LyA/9Su4BwOH
 fjouxn/5yCd4NUPjOGPh97IZmH+RsLa3xiP4F5YV1W9MMwlWB1Z84AVVWZ7xB1UoVV
 BrnDEP0SyosokOOEUlJ1YCNH/Jg1sq91ArXe8VvD99WfD3EBQ7V2T1Odio6Rr7UdDI
 DmwRN7TpfE4GA==
Received: from [192.168.68.112]
 (ppp118-210-181-13.adl-adc-lon-bras34.tpg.internode.on.net [118.210.181.13])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id F3BDA68D9B;
 Tue, 19 Nov 2024 06:51:06 +0800 (AWST)
Message-ID: <dd665bf4cc0ce4e5e9af28149928b5e2650f6d56.camel@codeconstruct.com.au>
Subject: Re: [PATCH] docs: aspeed: Reorganize the "Boot options" section
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>,  Steven Lee <steven_lee@aspeedtech.com>, Troy
 Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,  Joel
 Stanley <joel@jms.id.au>, Jan =?ISO-8859-1?Q?L=FCbbe?=
 <jlu@pengutronix.de>, Guenter Roeck <linux@roeck-us.net>
Date: Tue, 19 Nov 2024 09:21:06 +1030
In-Reply-To: <20241118090648.187720-1-clg@redhat.com>
References: <20241118090648.187720-1-clg@redhat.com>
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

On Mon, 2024-11-18 at 10:06 +0100, C=C3=A9dric Le Goater wrote:
> Add subsubsections for possible boot methods and introduce a new
> section on eMMC boot support for the ast2600-evb and rainier-emmc
> machines, boot partitions assumptions and limitations.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>

Nice!

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

