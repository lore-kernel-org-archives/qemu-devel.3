Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E92BC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 21:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwRDZ-0001YM-AN; Tue, 18 Aug 2026 17:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wwRDW-0001XW-TE; Tue, 18 Aug 2026 17:19:30 -0400
Received: from smtpout7.mo539.mail-out.ovh.net ([51.210.91.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wwRDU-0007vH-Ko; Tue, 18 Aug 2026 17:19:30 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [79.137.60.226])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4hPjJ34YfQz4Dwb;
 Tue, 18 Aug 2026 21:19:15 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue, 18 Aug 2026 21:19:14 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.58.197])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hPjJ26t0kz4CMZ; Tue, 18 Aug 2026 21:19:14 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.5])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 6F2D1203F42; 
 Tue, 18 Aug 2026 21:19:13 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-114S008b28ac61c-4ed3-4d66-9af1-b845ca9018f4,
 89C2A8DA583E85FD8389CCC5514D70A45810139E) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 2.10.174.70
Message-ID: <63bb2452-d48d-4216-a9e8-f6525fe54e75@kaod.org>
Date: Tue, 18 Aug 2026 23:19:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/i2c/aspeed_i2c: Latch received bytes for SMBus
 block reads
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 "Mikail.Sadic@ibm.com" <Mikail.Sadic@ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260814020836.3119613-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260814020836.3119613-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 14722830135542524939
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGrYAfbnQJENrFhcPDzTyQl8JH0Ltc0hPBCWVgi6x94CWv276LK+U0ffN03BfwzKW7XjKYSxVM56ZNpxx9dx0BTpYi0sl9lo0137XMK4b7277mIAGAcBb/3sWE0Y9u1LuiBLE2UPfx9njDRShGmRNQoC23CjzidigETGQ5beyU3wIN76eneComTPcrgKnL8MMIF1Wzprx/Z+4Vhcw9E9OK825lKOuAydMs26tkp1REfRiN6UM10liZFp6FjmF4x/DnMDu5m4KGBj45apJCq8a2BpbtVJuuPTCDtzs9g1X12r1clKKsrXiOgyO8AId2E3FyI3TvLkftGS5YJQKqAMxsZYcLpu+YXPGufnxU4wsq7cQWnHnz6wx6e6IsUS6sTPJWuqIC05tk3K8Gelsw4VHqWXBod/O8wzAES8xraxiaWw6/5FwDOE2oXGpQqEOeGqvn2YurisnigunBnKR7vN6vsFOfDfEYbcmygHzvTZ371lU0p/yOqurxxCMGegFRsWWw7+EuPEP7o72mulDNf14WCixwpfhMz3RF+PL/HxuJLw6dctTPfh1s8CxuM5xXavKNKXfZNUsG1XPpc1RV4mQd2tE8OuWJUDW66Z13OvMPUk7AcyUqF8Bl2iCTixHmDH0paNpSzL2latkLrcqHhsZdIusEyRL1SDMvzeUtsuBTE0Q
DKIM-Signature: a=rsa-sha256; bh=4s4X+Rm1Lev8duRNz8Vi6zbxGcgluF8oRtU9ZNESCEk=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1787087956; v=1;
 b=kqJ8YnJ/FXslo48lmUqLaU/dJnnoEHPXh5bLd9/PFbp4WAfx6DmadhqUCbDxo27rrhiXCLC4
 k+0qJvzIC1JNUtKcYfzSY+D0MLVG2W2v58mYlJ2qm4ZEy5s2HZ0xWl/b4brx9XXv+MFkJ1qodUS
 CUmmLrfJp/uJ2vrmGllx0KVHt4cLwpQYrBOREO2gxckEpAOiHwm5kPLOWOXUu5xU/Dyr8tgUDHL
 540tytgkCVnPrUiGRlvPwlR49lK3nBQlCq5lfWdU0q/O4aGRWGTr4bgRiyqT4Kg1CAVALxEZkuq
 YMTpLXs7HBLJmOebJ2psWOpN2KPam7KlYEloAnukD07yw==
Received-SPF: pass client-ip=51.210.91.46; envelope-from=clg@kaod.org;
 helo=smtpout7.mo539.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/14/26 04:08, Jamin Lin wrote:
> An SMBus block read takes the block length from the first byte of the
> transfer, and firmware reads that byte back from a register rather than
> from the transfer buffer. The receive paths never updated those
> registers, so block reads reported a bogus length.
> 
> On AST2600 the driver reads the length from the receive byte buffer,
> I2CC_MS_TXRX_BYTE_BUF[15:8]. The datasheet documents that field as valid
> while the DMA buffer is not enabled. The byte mode receive path already
> updated it, but the pool buffer path did not, and the driver selects
> buffer mode by default.
> 
> On AST2700 the driver reads the length from offset 0x84 instead.
> 
> Add I2CC_BYTE_DATA_LOG at 0x84 and latch received bytes into it. The pool
> buffer, DMA-to-pool and DMA-to-DRAM paths latch their first byte, the byte
> mode path latches every byte. Each latch also updates the receive byte
> buffer unless RX_DMA_EN is set, which is the datasheet condition and does
> not depend on FUNC_CFG_DMA_EN. The byte data log only exists on AST2700
> and AST1040, so it is gated on a class flag.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Tested-by: Mikail Sadic <mikail.sadic@ibm.com>
> ---
>   hw/i2c/aspeed_i2c.c         | 38 +++++++++++++++++++++++++++++++++++--
>   include/hw/i2c/aspeed_i2c.h |  3 +++
>   2 files changed, 39 insertions(+), 2 deletions(-)
>   
Applied to

     https://github.com/legoater/qemu aspeed-next

Thanks,

C.



