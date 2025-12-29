Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E459E9273E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 16:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaGSz-0003ML-Dt; Mon, 29 Dec 2025 11:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vaGSw-0003Ld-Ii; Mon, 29 Dec 2025 11:51:30 -0500
Received: from smtpout4.mo529.mail-out.ovh.net ([217.182.185.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vaGSt-0001ZS-C1; Mon, 29 Dec 2025 11:51:30 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.231.33])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4dg2L14gX9z5vrF;
 Mon, 29 Dec 2025 16:51:21 +0000 (UTC)
Received: from kaod.org (37.59.142.114) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 29 Dec
 2025 17:51:20 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-114S0081a8f5dbb-5100-47c3-8c59-f99eaf53345c,
 5019863659778AFB31EB73BEF4A5941D5F0AC883) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.14.253.154
Message-ID: <006fa26f-6b84-4e82-b6e1-7d1353579441@kaod.org>
Date: Mon, 29 Dec 2025 17:51:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/19] hw/arm/aspeed: Integrate interrupt controller
 for AST1700
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, =?UTF-8?Q?=27Philippe_Mathieu-Daud=C3=A9=27?=
 <philmd@linaro.org>
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-7-kane_chen@aspeedtech.com>
 <465b0714-bd08-40b5-9cf9-5cd206e8548b@kaod.org>
 <SI6PR06MB76312852C6243B1F48202A89F7B0A@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <55adfce4-0dbc-492a-b586-4c46df78007a@kaod.org>
 <SI6PR06MB76318E7A596008386B0AE51CF7BFA@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <ed07c0f2-737d-4d65-917f-d39d02c37063@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <ed07c0f2-737d-4d65-917f-d39d02c37063@kaod.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.114]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 2db1c06d-5cc4-4ab6-8a40-64ed3b7ebc9f
X-Ovh-Tracer-Id: 12792756217286659064
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTG1kufgmKz0QoUOIRJthUEI0AgLMZNa7+j0SaUSQRsWLdzxe4c2taRccsHm4uGAK0Mm/N6dMAO06/kAOaU1BWXNk8dIJm0SGnzQAGSM4K8MidugMRpzSPeh7ZDDTFg5mWi6vTtt6/iQKuBfdfzQdAigHN07zvI5aCpqIWv/LXLfjy1vgZ5TkQG0wJDthiPpFQTTJRDReEj7uRHZnwTSmOg9nl0wbtmGJl0FCVs7Yw7fs0h7dIoi4WG5/Cvo+Xkp2ynPelgWb9xPVMErJ24tggvLLj541fb3VmqjKEmVaRtm0Jkxgt171XZnLZjJEAW4WXdW6baPlZ2WCpKOfhLvluRJd2qaSv0YNDdibq0VRR+hHnm+CDEOwy3AFrngO2yCli5ihr1Gn5JXF2ZhDRoPz+0qyeRBLc2QVLuGgccAVx1A5hDUXXLjeApDN/3XT6eoyiLppiHQJcMXNgMOEh3m04Qimu+oGdAsixf8phgEEfCbCXuXK/nVlIlzGCOUV/4n+0NCl0ZkRKx/6bNGCPINwyR6AOsxndbdKDBijxy3nGzOCfK/3F6vR5We+vjIjEG5iucrZ/FT9oGJYdOmdR32gjmiQ9o81pLAgM5ZiunHF7wswOrBa4Ml2fiaYdwviAeDPSV4J9pDjHGZ2cT3rSF2mcTSz47cSM2fedMSvwWcpQPUKQ
DKIM-Signature: a=rsa-sha256; bh=xou5H9a6HYheFor1nglOj7PsYau7sPey1LvOj0vGnSg=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1767027083; v=1;
 b=QlkU1N+ehZRyc3MD+Rg5b++gmG2K7oNGnfGFRwMBtmZrhY6Sz3e6zdxvOhUbf8y87ei6NJ4v
 VmLJ3RaXPW6ZD2HadqDOXJuL9+44/cgMnSPHVZm0rhaw5b7TunwVL6NSJj1quQwFzmppHKNPzb6
 M2hUuvuknO74kzd7Xq3TwdpqC2SYu0pIxKTjYc0WKAJr/D4ph7iIfKjeIVVMWnqopxnlUtqFf+j
 XRPDMsGIWFlEDvnWEkd4N54XNc18E2W/RyZDgNa/g58ohh7IkZ8ZG4wC0/atDauoFfCRmdA8WAE
 0TZgJwVZQS7XjRWEI3wWOfTJnU7W/ZBLDqKpHc4MKGfoA==
Received-SPF: pass client-ip=217.182.185.173; envelope-from=clg@kaod.org;
 helo=smtpout4.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

+phil

On 12/29/25 12:41, Cédric Le Goater wrote:
> On 12/29/25 11:00, Kane Chen wrote:
>>> -----Original Message-----
>>> From: Cédric Le Goater <clg@kaod.org>
>>> Sent: Sunday, December 28, 2025 1:51 AM
>>> To: Kane Chen <kane_chen@aspeedtech.com>; Peter Maydell
>>> <peter.maydell@linaro.org>; Steven Lee <steven_lee@aspeedtech.com>; Troy
>>> Lee <leetroy@gmail.com>; Jamin Lin <jamin_lin@aspeedtech.com>; Andrew
>>> Jeffery <andrew@codeconstruct.com.au>; Joel Stanley <joel@jms.id.au>;
>>> open list:ASPEED BMCs <qemu-arm@nongnu.org>; open list:All patches CC
>>> here <qemu-devel@nongnu.org>
>>> Cc: Troy Lee <troy_lee@aspeedtech.com>; nabihestefan@google.com
>>> Subject: Re: [PATCH v4 06/19] hw/arm/aspeed: Integrate interrupt controller
>>> for AST1700
>>>
>>> Hello Kane,
>>>
>>>> Thank you for the suggestion. Since I need to submit a v5 patch to
>>>> split the I2C code changes anyway,
>>>
>>> Can you please introduce the bus label property at the end of the patch series ?
>>> Please consider adding a functional test and updating the documentation too.
>>>
>>>> I will handle the naming adjustments and other minor fixes myself in
>>>> that version.
>>>
>>> Thanks,
>>>
>>> C.
>>
>> Hi Cédric,
>>
>> If I move the bus label property to the end of this patch series, it will trigger
>> a test failure in the current patch series. 
> 
> Which test ?
> 
>> To avoid this, I plan to move the bus
>> label changes into a separate patch series and submit it before the AST1700
>> series. I believe this approach ensures both series pass the tests properly.
>> What are your thoughts on this?
> 
> I would like to understand the issue first.
I see.

The AST2700 functional tests fail :

        self.vm.add_args('-device',
                          'tmp105,bus=aspeed.i2c.bus.1,address=0x4d,id=tmp-test')

The "bus label" proposal renames the IO expander I2C buses (32) to avoid
the name conflicts :
  
           /aspeed.ioexp0.i2c.bus.0 (i2c-bus)
           ...
           /aspeed.ioexp0.i2c.bus.15 (i2c-bus)

           /aspeed.ioexp1.i2c.bus.0 (i2c-bus)
           ...
           /aspeed.ioexp1.i2c.bus.15 (i2c-bus)

Since this will be exposed in the user API, it would be best to avoid
introducing poorly chosen names. Having so many I2C buses (48) in a
single machine is somewhat new in QEMU and I am not aware of any naming
convention for this.

May be others do ?

Thanks,

C.

