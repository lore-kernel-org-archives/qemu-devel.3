Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2F8C44508
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 17:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjhI4-000702-65; Tue, 14 Jul 2026 13:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wjhI2-0006y7-GV
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 13:51:30 -0400
Received: from smtpout6.mo536.mail-out.ovh.net ([51.210.91.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wjhI0-0003JK-6c
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 13:51:30 -0400
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [51.210.158.128])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4h06LM1NsLz81vs;
 Tue, 14 Jul 2026 17:51:23 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Tue, 14 Jul 2026 17:51:22 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.96.139])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4h06LL5yggz60Mh; Tue, 14 Jul 2026 17:51:22 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.0])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id A732C1B43DB7;
 Tue, 14 Jul 2026 17:51:21 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001ca8eaf0f-9935-45ef-84a0-3e080bbf668d,
 14669520E5D5974EABF02A897D6C170CD5935BAD) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <bf6d933b-c15b-45ca-b20f-62b786e3d434@kaod.org>
Date: Tue, 14 Jul 2026 19:51:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] hw/ssi/aspeed_smc: Add Data FIFO-based flash
 access support for AST2700
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
 <20260707060919.350637-9-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260707060919.350637-9-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 8582172042081643531
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFfIzzS3zqmgrRMLNf6yu6wyC2QTl2nu9we2y+oYUZG5CFCe25DD0dvrfG6u4USA4H2paCMPlIZOqfOJ2lq40jsLqWGC8WAvkFj/2CUz/jxYS1+AMjlo+Jy23k/UuojKnB7Lwd7tZt0ujfsolGkU5X2lVZbdVIVB+CCoLTY8sEfbgrzVHDYwuyTh1HsUX4u8dcdWDkpoheMe7OPrNAsjLYN8qGczH3WbpWAP7PT3FBzEYykA7rhnnVP6pWhRjYXg0jNpEHN9+uLYLIjO38IWr7wQbPYIs+SUJTh1QQ9ZSNILnI8RRD3m0dQIb27HqgQJNKt184OHAUGyHG81/Yr5SNnluljfbAoIm8UKZPd5AbMk/8Cgrfx2Vodc/mf3S35u4GDJH9q9O3cThHZlZKM7KsoHU+14jZS+K1ztPkqJz4VUEfl4ZPsR+kUADfrD6id/GMXfYz7ayPSMljfWr2thsSUdmrzq2UCHPD4wl4oIDvPOTOn2BCAkecn0+2K8STKaKDGaMqwKNoAl4/ybvtnLLg2KNN0/qi/XDJdpLA6OYEBAtfDfbU70EsQzSOgLPwle0OwMNohmh7IO8ORSms4dgeOFfoeNz1zOLscymfLjA/6gkYqGY/AelzgvClDVG32ygTlyLN7ZxfMCAtrMmCnY+vvvypDWdgNcBOnHTSlvhdutg
DKIM-Signature: a=rsa-sha256; bh=NF7ta5Ge37y8HTvpruItz8rSyQ3GmFNStx1K7JhIu9Q=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1784051485; v=1;
 b=Q6cE8vgPUn5bDyUJ0vir1OsdQQ977RjPFvR2RHKXQDatWuf5mDR/fcypopPi1vYxhazo1dj3
 FERB1+sJfU1F6UXrZMEXJ5SzP1tp3A7ZYMKmAkb47mnm4P+4iJOxClQxXPvwUQXJrHkMraWNQQ2
 UBDLhujtVRXnA+sgMvPhjKG5o0fg2qgqb04yOqtPFID3iio1e3O4kSZm3p3y5KiCCa2Bon7c4Jn
 6GfGNq/OrvyoEK3kNaueX1q3BP6n50Fr8DooNsk/bqDsRcujtG44FCiJPbL2sFfOKNx9E4QHb0g
 u0jLao5rLUSd1zibj/T9/ENoMACEmOyIrqjUCGUz8WOqg==
Received-SPF: pass client-ip=51.210.91.15; envelope-from=clg@kaod.org;
 helo=smtpout6.mo536.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 7/7/26 08:09, Jamin Lin wrote:
> AST2700 supports a Data FIFO mode where flash accesses can be performed
> directly through Data FIFO MMIO offsets. The Data FIFO start offset
> increments by one for every 16MB of flash address space, allowing the
> chip select (CS) to be decoded from the Data FIFO offset.
> 
> This change adds Data FIFO support to the Aspeed SMC model and introduces
> a class callback to translate Data FIFO offsets into CS indices. For
> AST2700, the Data FIFO offset is matched against the segment start address
> of each CS to determine the target flash device.
> 
> The SMC register region size (nregs) is also extended dynamically
> based on the number of supported chip selects to cover all possible
> Data FIFO regions.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/ssi/aspeed_smc.h |   3 +-
>   hw/ssi/aspeed_smc.c         | 113 +++++++++++++++++++++++++++++++++---
>   2 files changed, 107 insertions(+), 9 deletions(-)

I am looking for a way to test "Data FIFO-based flash access".
A qtest extension of the ast2700 smc test would be nice to have.

Is the latest SDK kernel using this feature ?

Thanks,

C.


