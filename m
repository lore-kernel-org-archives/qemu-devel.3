Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F4BC3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 01:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzQ6v-0000GR-0b; Mon, 31 Mar 2025 21:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tzQ6i-0000F8-IK; Mon, 31 Mar 2025 21:08:01 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tzQ6f-0004gT-Vt; Mon, 31 Mar 2025 21:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1743469666;
 bh=AeXoW4qhjGDr3OZ+osAyoKWodzZ7uNbS3OT0JucGZ7o=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=huqzEA9i8JcJeY/OFthNJXafGaAwCBEAV/1m3icFnw7b6TrUEqg6lbmsuiqQoILfO
 P3p/1G5C20vfqNsfBdu+mdSYIygVV/NoKaRRUq3rc+8Y/383DAoFH+1VyqFSGXwQQ+
 9lT5490P20qNb9NvoWnEdaLbfh0vB9cxtod+xsw7+qhXNTtbpcnlM8a0iSTw+s4ocB
 9cODOu+EuMgHOqjnLhk5XwE85L71Je3QoS+6sluV/AGMB1+rjatMAqYEql1A5T0/7N
 QU/7lRX3ql6oIoiwjpgU9KJj/JZ0l83iTdrlYZbP9GIb6QltnAqnVviEVK+vI5n4nr
 qDsS9Rt9a6hCQ==
Received: from [10.194.67.88] (unknown [180.150.112.225])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id BD1707B352;
 Tue,  1 Apr 2025 09:07:44 +0800 (AWST)
Message-ID: <3720f2efc3778e722adc8add248954b46070139c.camel@codeconstruct.com.au>
Subject: Re: [PATCH-for-10.0 1/2] hw/misc/aspeed_scu: Set
 MemoryRegionOps::impl::access_size to 32-bit
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>, 
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-arm@nongnu.org
Date: Tue, 01 Apr 2025 11:37:43 +1030
In-Reply-To: <20250331230444.88295-2-philmd@linaro.org>
References: <20250331230444.88295-1-philmd@linaro.org>
 <20250331230444.88295-2-philmd@linaro.org>
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
> All MemoryRegionOps::read/write() handlers switch over a 32-bit
> aligned value, because converted using TO_REG(), which is defined
> as:
>=20
> =C2=A0 #define TO_REG(offset) ((offset) >> 2)
>=20
> So all implementations are 32-bit.
> Set min/max access_size accordingly.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>


