Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB5ECCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 11:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3YIU-0007wN-Mg; Tue, 30 Sep 2025 07:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1v3YIH-0007sy-2k; Tue, 30 Sep 2025 07:13:18 -0400
Received: from smtpout2.mo529.mail-out.ovh.net ([79.137.123.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1v3YIA-000174-RK; Tue, 30 Sep 2025 07:13:15 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.231.193])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4cbb595w06z5xHh;
 Tue, 30 Sep 2025 11:13:01 +0000 (UTC)
Received: from kaod.org (37.59.142.100) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Tue, 30 Sep
 2025 13:13:01 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R003ce42045c-629d-492e-8d7e-a674b623c77e,
 012DEA80DA8F652C9231DB37D1304F33C12A2C6A) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <e493e89d-d161-4c5b-abf2-053034aa82b4@kaod.org>
Date: Tue, 30 Sep 2025 13:13:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aspeed: Add Supermicro X11 SPI machine type
To: Guenter Roeck <linux@roeck-us.net>
CC: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery
 <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
References: <20221025165109.1226001-1-linux@roeck-us.net>
 <dbea5c97-071e-4d7c-a022-8cd5d9cf6171@kaod.org>
 <e6ad0500-29b5-422f-a584-34d33a5e9a0a@roeck-us.net>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <e6ad0500-29b5-422f-a584-34d33a5e9a0a@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG8EX1.mxp5.local (172.16.2.71) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 0e066b3c-908a-4898-8671-8a5aa70ba92c
X-Ovh-Tracer-Id: 13491940061823929126
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEwimGix62z5d6ymBRsktbNn+Rff4WB+yiWe9qPmZYtq7+GRL2pgCyzXe+4F57PWh/iIa1R/1+AzoO1DkKYhIYTz781ov3rZ6NtSrzY7NTBbauH6RXCoeZGM0pWwtCgpq3gtvO3JFiaDP+rhixV8rWcnAiDjUrtQMABrpQAI059Y3uA0q7XcJDQfSEzzfK91TWMi8/LO9nlZX2n5SQ4RMN7+jbtHJgQwGgtNS6StYo++pOhf+wQGwUNNVywtYWtWhMeBnHkek2FtjPNMYtDCoB0ey72LGM2QIs/LYm0q3a5w6PjqFX9s5gYb9J8xd0Dj3YzSi/oKzo24seLjQyd8I7+thbv2ZzPIfgT1gBoDdL9Hn29Yr7QwvrJyjsUbwwJl2vuU9+VVYrmE/6stcwttPdvs4KJhYD3WEY+MvYUEMA4pj5/e8QGJulyC5Ql+Y3fZPmCRflJpWlTmfzvk0eRx4UOvA/zS96Jf3XjkXjifklhzwEgbLZ0Bq30sQHJhaPKzLufY9RCckj9mkqIUrmQN+rg36ILNOEVLhv0cWTM2SAFub6qyKItEZFCtf5Mc7fvcDCvfR2j5dnehX7i4Heu4TaLWP0Eo09/G/RvVEConznfQBIgGVDZujsTrxnMI0Wlha96NQhvyUeoUe0cuojk4q8FA2/lZykbQfwmEWz60u/OXg
DKIM-Signature: a=rsa-sha256; bh=R+xvhpupGTYzNQ9a040wfBj7JORG0AwjbrY+8dkK9Fs=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1759230782; v=1;
 b=k0hspo6qvhaSeXoKKvCOOl3HHE1Z0GU7cs1q/GbFYyW6EKLj1SQhVPuwF6CSZNekBLa579iG
 pCMO56uMYiW/82G2O3QZ7fH9mb4+d0wXgO28nkFA/ECKeNBdVlQ9Q6KKgurQ287QStO1EG9VbFw
 CW6aWlHI0uPKj6WF4jtxlN7zUXA3Flds54U/Q3iDNBQ1d0WFtIiqP+RbBhCw2MvGNknDGBekaW4
 JjvNWIm1RPmCRmBgtUiZ2o0+0BKpz59bYMiWozd/9h1tLL3J+9R/09HDpPFu6uxtunKR4v+2sbB
 +AJCGRr4Z+0aX/fnDreDEa927n8ocxO9vz+xivN+5nMcg==
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout2.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/30/25 12:08, Guenter Roeck wrote:
> On 9/29/25 22:55, Cédric Le Goater wrote:
>> On 10/25/22 18:51, Guenter Roeck wrote:
>>> supermicrox11-bmc is configured with ast2400-a1 SoC. This does not match
>>> the Supermicro documentation for X11 BMCs, and it does not match the
>>> devicetree file in the Linux kernel.
>>>
>>> As it turns out, some Supermicro X11 motherboards use AST2400 SoCs,
>>> while others use AST2500.
>>>
>>> Introduce new machine type supermicrox11-spi-bmc with AST2500 SoC
>>> to match the devicetree description in the Linux kernel. Hardware
>>> configuration details for this machine type are guesswork and taken
>>> from defaults as well as from the Linux kernel devicetree file.
>>>
>>> The new machine type was tested with aspeed-bmc-supermicro-x11spi.dts
>>> from the Linux kernel and with Linux versions 6.0.3 and 6.1-rc2.
>>> Linux booted successfully from initrd and from both SPI interfaces.
>>> Ethernet interfaces were confirmed to be operational.
>>>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>
>> Hello Guenter
>>
>> Would it be possible to contribute a functional test for this
>> machine ?
>>
>> Since this machine contributes little to the Aspeed models,
>> its value lies in the firmware it can run to exercise the
>> models. Without functional tests, I plan to schedule the
>> removal in the QEMU 10.2 cycle.
>>
> 
> I use it to test the Linux kernel. Nor worth enough to spend more time on.
> Just drop it; I'll drop the respective test runs.
Can the FW be downloaded ?

C.

