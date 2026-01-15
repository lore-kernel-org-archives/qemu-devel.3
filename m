Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71FBD46603
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 17:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgR0d-0000VR-Pf; Thu, 15 Jan 2026 12:19:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vgR0c-0000Th-BA
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 12:19:46 -0500
Received: from 8.mo552.mail-out.ovh.net ([46.105.37.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vgR0Z-0001iZ-7Q
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 12:19:46 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.250])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4dsV8p4L52z5w8v;
 Thu, 15 Jan 2026 17:19:38 +0000 (UTC)
Received: from kaod.org (37.59.142.103) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Thu, 15 Jan
 2026 18:19:37 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G00530064f3a-23c3-4fb3-8e70-76d507a0d96b,
 730BEF4863DC82B2970748FB5926F4A3C98AA806) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <a155b02b-c684-49d3-bbe3-fbeb22e20878@kaod.org>
Date: Thu, 15 Jan 2026 18:19:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] hw/i2c/aspeed: Introduce 'bus-label' to customize
 bus naming
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
References: <20260112083054.4151945-1-kane_chen@aspeedtech.com>
 <20260112083054.4151945-2-kane_chen@aspeedtech.com>
 <cd9a0f11-7d36-4e58-afc8-96113ceb3613@kaod.org>
 <SI6PR06MB7631282EF8FFF2DDEDE798F5F78CA@SI6PR06MB7631.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SI6PR06MB7631282EF8FFF2DDEDE798F5F78CA@SI6PR06MB7631.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: e57bb083-ae4a-4310-9bd0-84dc96106505
X-Ovh-Tracer-Id: 2425751352218717106
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTG2vuGerzsbX8R8h8maQVkhbjq9ocs9OTpwuP1MfDdVjrsVpSvqUwI8A+EWg0WfARnIjayZxWw2i4GAy/kpTnGqMlU4dC9gEQbyQYK+Q68oVHqIl08f4B2yRZTZhZFM7QX7lQVWK8X0vo26Xe9nsjhLQlpYoD+QKK0HrKItQWDdXVnFAdRhovmBK1fqJr8StBFvCS6K2rKe0MfMjrLSqKe0iVDPMqv7gFPNY1VRZKE2gVuaafA2lczUW6qlObm3qHMV+gnBmn68FfqkCx6pvUB5lAK3s4+OrkK40llrWntotFiFmjvkPx9Ol8gyK36kLenxfAEvrA3HBwZcVgquCIXVUrmZCNPzNjjHeN7RRZe++yMmHnYb4M6lgM1Z/ncv/yShrH1VkOE1XdHUODI22Ey1PyOO+8iaR17gXBi7Bc/tSMN/rkwG4uNETWxElQNZwM9kRIPVPCeoWcP2gnH0qaoDHpkIE4ztMeE6JGeAqUQE+3XWOFmTyeL70GUG88/0qZEi/eRiGBw5SN4c+lP1Ant0J9oMqgkkam0tUYo/84lMUIJqruZAb/vPpqDnW9W4N6+AlzSJ4Z4TOWYSzyKtyGybXPhRY4tCLQQxz4ZCOApdHDkuOPfwWzXZ55ypkZygNqYF3JShTaimBXr4+c+nBagoZ35HTqy+eg3bN3o4ZfnL9Q
DKIM-Signature: a=rsa-sha256; bh=i9nv/eujdYCGqiUm2kaFA6156k3BLstihX1MeRMwNAQ=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1768497579; v=1;
 b=g4V68MCIaAF+g5mTYurNMngAdGxP5Ev7BHIpd++2rKFKCxX0/XkDsPrZuCE3nLZrFa8fGDX7
 Dz4Z9BIrJIkGgmeAkQLO6oSj8M+6jt2WVpdHoWtbPHvd/fxWQAUBCU02evi+Pm5IZp0pMEDHrSI
 nbyKqqo4Pmd87Y5lH0uBdKVcy8D4b2cIpTtHy+WyTrjN8Wh5gW3iwx2GRfMUDBvuX4uQch6fecP
 /ANUdKRsHC3Y1pgWhNWUq1N5xGonZHFMyEUszfAno6JPGsocrTJ90qxcgQWKXcf/PfTwNhFQFvP
 ClbDv6aY6pLZU47peRHIJdwgAr7xH9VTy/eZYG2jJSneg==
Received-SPF: pass client-ip=46.105.37.156; envelope-from=clg@kaod.org;
 helo=8.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 1/15/26 08:19, Kane Chen wrote:
>> -----Original Message-----
>> From: Cédric Le Goater <clg@kaod.org>
>> Sent: Thursday, January 15, 2026 3:15 PM
>> To: Kane Chen <kane_chen@aspeedtech.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Steven Lee <steven_lee@aspeedtech.com>; Troy
>> Lee <leetroy@gmail.com>; Jamin Lin <jamin_lin@aspeedtech.com>; Andrew
>> Jeffery <andrew@codeconstruct.com.au>; Joel Stanley <joel@jms.id.au>;
>> open list:ASPEED BMCs <qemu-arm@nongnu.org>; open list:All patches CC
>> here <qemu-devel@nongnu.org>
>> Cc: Troy Lee <troy_lee@aspeedtech.com>
>> Subject: Re: [PATCH v1 1/1] hw/i2c/aspeed: Introduce 'bus-label' to customize
>> bus naming
>>
>> On 1/12/26 09:30, Kane Chen via wrote:
>>> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>>>
>>> On some Aspeed-based machines, multiple I2C controllers may exist
>>> across different components, such as the primary SoC and an external
>>> IO expander or co-processor (e.g., AST1700). Using the current static
>>> naming convention results in object name conflicts when multiple
>>> controllers attempt to instantiate buses with the same ID.
>>>
>>> This patch introduces a 'bus-label' property for the Aspeed I2C
>>> controller. This allows higher-level layers, such as the SoC realize
>>> function, to provide a unique identifier for the buses. The I2C bus
>>> object name is then constructed using this label (e.g., "ioexp0.0"
>>> instead of the default "aspeed.i2c.bus.0").
>>>
>>> This enhancement ensures unique bus identifiers across the system and
>>> resolves naming conflicts in multi-controller configurations.
>>>
>>> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
>>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>>
>> Thanks,
>>
>> C.
> Hi Cédric,
> 
> Thanks for your review.

Applied to aspeed-next.

Thanks,

C.

