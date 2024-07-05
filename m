Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B23C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 03:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPZuS-00033Q-6t; Thu, 04 Jul 2024 23:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1sPZuP-000319-PY; Thu, 04 Jul 2024 23:46:53 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1sPZuN-0005gE-U1; Thu, 04 Jul 2024 23:46:53 -0400
Received: from [192.168.68.112]
 (ppp118-210-145-155.adl-adc-lon-bras33.tpg.internode.on.net
 [118.210.145.155])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9238920127;
 Fri,  5 Jul 2024 11:46:48 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1720151209;
 bh=PJL/QYxtnw3cIFLSDrpuEEOWLd7k9kmpBz2UEz4EgWU=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=AeFvoG5yC1Jbo8wLuGEQ7AovU6UhGCw2d+y4QjE+jnHQ98x2zCDUqzetIs20+VtBJ
 90KjumMgXtykZoJ76YpysJ4yIR0omBIueM+a9QkSsttTE9qWwnzlAC33Mn2bIbIDIE
 Oc+6JNQp9vjoQ+5d2dJhz44O6Qc11ZRtYiAWPIdp1HH5Q4yC7Pa2Fei3lhCWg0dExa
 ApAOqSCi2x4o7F9OMo1YeymKuc2SSPnZM1B/153t1kL6nRgLqMFN6JPLhkQEzrfYtH
 QlzD9nPqxxaZZd5g6X/xwAKqX/yNkzZj0vu04+xsaxjNBwywIJLSxsAi+U7VFWgvk5
 IVyRediMWi+kw==
Message-ID: <c434c7e88153a134bc6ba2dc202595211702398c.camel@codeconstruct.com.au>
Subject: Re: [PATCH 0/8] aspeed: Add boot from eMMC support (AST2600)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Peter
 Maydell <peter.maydell@linaro.org>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Date: Fri, 05 Jul 2024 13:16:48 +0930
In-Reply-To: <20240704053651.1100732-1-clg@redhat.com>
References: <20240704053651.1100732-1-clg@redhat.com>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 2024-07-04 at 07:36 +0200, C=C3=A9dric Le Goater wrote:
> From: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> Hello,
>=20
> This series enables boot from eMMC on the rainier-bmc machine, which
> is the default behavior and also on the AST2600 EVB using a machine
> option to change the default.
>=20
> It depends solely on the availability of an eMMC device model which is
> currently being discussed upstream. Numerous patches have been merged
> already and remaining ones [1] should be in 9.1 development cycle.
> Since the changes of this series are small and localized, it would be
> an interesting extension of the AST2600 SoC model for QEMU 9.1.
>=20
> First 6 patches adjust the machine setup and HW strapping to boot from
> eMMC, the last 2 are for the AST2600 EVB and are optional.
>=20
> Thanks,
>=20
> C.
>=20
> [1] https://github.com/legoater/qemu/commits/aspeed-9.1

I built the series using the tree you linked above. It works well!

In that context:

Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>

