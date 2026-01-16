Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58CCD4A5FD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 05:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgcCd-0004ky-EY; Fri, 16 Jan 2026 00:16:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vgcCb-0004kH-RQ
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 00:16:53 -0500
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vgcCZ-0001dF-AB
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 00:16:53 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.249.71])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4dsp4F6FrFz5y8C;
 Fri, 16 Jan 2026 05:16:45 +0000 (UTC)
Received: from kaod.org (37.59.142.101) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 16 Jan
 2026 06:16:45 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G0047be64982-8d77-415b-ab33-2486a7c80117,
 356448E47ECF6FF3573990070D4D23F6C14CAFA2) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <7b67c00a-2bf3-4a25-aae4-9d4dd932486a@kaod.org>
Date: Fri, 16 Jan 2026 06:16:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/1] hw/i2c/aspeed: Introduce 'bus-label' to customize
 bus naming
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Kane Chen
 <kane_chen@aspeedtech.com>, Peter Maydell <peter.maydell@linaro.org>, Steven
 Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, Markus Armbruster
 <armbru@redhat.com>
CC: <troy_lee@aspeedtech.com>
References: <20260112083054.4151945-1-kane_chen@aspeedtech.com>
 <5e72f6d4-6914-4797-85f6-6131af0d1349@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSBDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQGthb2Qub3JnPsLBeAQTAQIAIgUCW7yjdQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AACgkQUaNDx8/77KGRSxAAuMJJMhJdj7acTcFtwof7CDSfoVX0owE2FJdd
 M43hNeTwPWlV5oLCj1BOQo0MVilIpSd9Qu5wqRD8KnN2Bv/rllKPqK2+i8CXymi9hsuzF56m
 76wiPwbsX54jhv/VYY9Al7NBknh6iLYJiC/pgacRCHtSj/wofemSCM48s61s1OleSPSSvJE/
 jYRa0jMXP98N5IEn8rEbkPua/yrm9ynHqi4dKEBCq/F7WDQ+FfUaFQb4ey47A/aSHstzpgsl
 TSDTJDD+Ms8y9x2X5EPKXnI3GRLaCKXVNNtrvbUd9LsKymK3WSbADaX7i0gvMFq7j51P/8yj
 neaUSKSkktHauJAtBNXHMghWm/xJXIVAW8xX5aEiSK7DNp5AM478rDXn9NZFUdLTAScVf7LZ
 VzMFKR0jAVG786b/O5vbxklsww+YXJGvCUvHuysEsz5EEzThTJ6AC5JM2iBn9/63PKiS3ptJ
 QAqzasT6KkZ9fKLdK3qtc6yPaSm22C5ROM3GS+yLy6iWBkJ/nEYh/L/du+TLw7YNbKejBr/J
 ml+V3qZLfuhDjW0GbeJVPzsENuxiNiBbyzlSnAvKlzda/sBDvxmvWhC+nMRQCf47mFr8Xx3w
 WtDSQavnz3zTa0XuEucpwfBuVdk4RlPzNPri6p2KTBhPEvRBdC9wNOdRBtsP9rAPjd52d73O
 wU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhWpOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNL
 SoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZKXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVU
 cP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwpbV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+
 S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc
 9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFUCSLB2AE4wXQkJbApye48qnZ09zc929df5gU6
 hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iSYBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616d
 tb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6gLxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/
 t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1c
 OY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0SdujWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475
 KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/JxIqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8
 o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoX
 ywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjKyKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0
 IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9jhQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Ta
 d2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yops302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it
 +OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/pLHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1n
 HzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBUwYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVIS
 l73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lUXOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY
 3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfAHQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4Pls
 ZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQizDiU6iOrUzBThaMhZO3i927SG2DwWDVzZlt
 KrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gDuVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <5e72f6d4-6914-4797-85f6-6131af0d1349@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: df4eb063-e03e-4545-9e17-c7619d275184
X-Ovh-Tracer-Id: 14536775174704761848
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE1Vzj1R++xyV6u5xYUyW8zk6GfxKpihphS0DiuIPEq+q5jVuAj0jXysbfLSakR0VqvxfBMSyedq/iH7Yfv1+Bh1DzmneHjPB/wwP+xhzyLP2Zoolb8N6QyRkhLgB+rHD0WXsk7HbxIAMT79EkZtLwI9qR1uoRLVuuSkXPtWa3Zn0Tv1/KN0Y9LHaTwywEJt5+HKRX+dofZC/vFjQCLvwJ0QZ5zGDApswnAFToYzOhLuigHxkzyp0xL9Aoz84Fuxxfpz4Fpz+7NRSK2d3ztRAOajz33qABcz/tI8+43TfOdeSwPbAjTioA0gytBCc4125fxCGYkP+7A7BAaeoz4OIa8LbP96YhA8tMqAtPCWU6lTtpi8Y7ZsujH6w+29+v/vX1wUazJYYHYq9rsPak9ZNPHQMBN6YIaKOXblswV8x3+ztt74/QUDsD+dIDGfAvpF3mepPOTH/XIDu7qIAMZ92Gza4hZvluvODOKCl8QIAv3hMxjWRz+oJVBYpZ1HOwjFvkAeW+w65rhi3ZFQ2Ucs9hNW9eG/Pv906Pebo2eu7WmUCsXss/ps4BXoN23KPLMEnIUj7kR6C4XgoCSbfR+KUIi8c5RrSIiCYWAAHOgMUEW1cqOmJpDdglUZxuPjKv1SeLbu54BOuWB05SDP5XQ4rCKnwRxao6NQ3aAhDsnZS+/JA
DKIM-Signature: a=rsa-sha256; bh=BzVyFzkHnuAOWhGxY53u5PppSnrAxCou6bOXfXPnIak=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1768540607; v=1;
 b=R/Dv12m9Rwi4mdYhKiSwzQX7bG6vM1QBH9zGDNmy827yqdu1hsJIbzjw0SQAWkENKnCsSvNt
 l6WvvVSXJjgw07FUt/KZXstxUuPkfbWFzNJp9ESqidaxMyu9lQGgMBe1KeLPscrg1Ehv1cx5Pqq
 NZ9DnXBvoW0dXaDUAL5XvYYXMLbduZNuyK/I+qDjWVXnfqJoMfDZHUzYrisR5Z8zEaklbzH0Gfn
 oFuff0GB0d3phdH5/y8FX7XbTJ5f5aoyBANrYBDYUIbr6r8i1FqRx1AMMZQ7Zx9j41DbzvOyB9Z
 WNI8U+xqJi47wRkAqACcqRUoERhaC1KXfT2hhYJk5AmPg==
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
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

On 1/15/26 20:47, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> Cc'ing Markus.
> 
> On 12/1/26 09:30, Kane Chen via qemu development wrote:
>> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>>
>> Currently, the Aspeed I2C controller uses a static naming convention
>> for its buses (e.g., "aspeed.i2c.bus.0"). This approach leads to
>> object name conflicts in machine models that incorporate multiple I2C
>> controllers, such as an Aspeed SoC paired with an external IO expander
>> or a co-processor like the AST1700.
>>
> 
> Is this a side-effect of Problem 4: 'The /machine/unattached/ orphanage'
> described here?
> https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/
> 
> This problem isn't specific to I2C nor Aspeed.


See the discussion here :

   https://lore.kernel.org/qemu-devel/006fa26f-6b84-4e82-b6e1-7d1353579441@kaod.org/

The Aspeed SoC has 3*16 I2C buses attached on 3 different I2C
controllers plus the I2C/I3C buses. We need to find a way to
distinguish these groups at the QEMU machine level to be able
to add devices on the right bus when using the command line.

Suggestions welcome !

Thanks,

C.


> 
>> This patch series introduces a 'bus-label' property to the Aspeed I2C
>> controller. By setting this property, higher-level platform code
>> (e.g., the SoC realize function) can provide a unique prefix for the
>> I2C buses.
>>
>> Changes in v1:
>>
>> Added bus-label property to AspeedI2CState.
>> Added bus-name property to AspeedI2CBus.
>> Modified aspeed_i2c_realize to generate bus names based on the label.
>> Updated aspeed_i2c_bus_realize to use the customized name for bus
>> initialization and memory region naming.
>>
>> Example usage: If a controller's bus-label is set to "ioexp0", its buses
>> will be named "ioexp0.0", "ioexp0.1", etc., instead of the default
>> "aspeed.i2c.bus.0".
>>
>> Any feedback or suggestions are appreciated.
>>
>> Best Regards,
>> Kane
>>
>> Kane-Chen-AS (1):
>>    hw/i2c/aspeed: Introduce 'bus-label' to customize bus naming
>>
>>   include/hw/i2c/aspeed_i2c.h |  2 ++
>>   hw/i2c/aspeed_i2c.c         | 27 +++++++++++++++++++++------
>>   2 files changed, 23 insertions(+), 6 deletions(-)
>>
> 


