Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313B8CA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCFZd-0003aQ-Kg; Thu, 01 Oct 2026 08:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xCFZY-0003Zi-JN
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 08:07:36 -0400
Received: from smtpout7.mo537.mail-out.ovh.net ([51.210.91.26])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xCFZV-0003qu-Ir
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 08:07:36 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4hwVyx542xz48nB;
 Thu,  1 Oct 2026 12:07:21 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu,  1 Oct 2026 12:07:21 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.54.70])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hwVyx095mz1xrb;
 Thu,  1 Oct 2026 12:07:21 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.6])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id B6B2F202C1D; 
 Thu,  1 Oct 2026 12:07:19 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006e6afaedb-9ddf-4640-bbf9-772595ef9fa5,
 B87720B9A20974DAEE7745F8F0A851FD039C1C56) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <0c9ae93c-cd18-4552-9969-0f01568800f3@kaod.org>
Date: Thu, 1 Oct 2026 14:07:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/11] hw/arm/aspeed_ast2400: Use unimp array and table
 for unimplemented devices
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Maydell Peter <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>
References: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
 <20260930072501.2612119-2-jamin_lin@aspeedtech.com>
 <941d7bb6-3205-44cf-8d76-ffbb322a6f4e@oss.qualcomm.com>
 <0cd87753-da91-44ed-a629-43099bfb820d@kaod.org>
 <1197c1ca-14d5-48c1-b497-0c03a781c258@oss.qualcomm.com>
 <330f9a96-4508-4db1-a8a0-fa36c57ed093@kaod.org>
 <672CD4C9-8FCA-4E5A-B610-3F9C51B986B6@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
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
In-Reply-To: <672CD4C9-8FCA-4E5A-B610-3F9C51B986B6@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 5546464416201681980
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFo95sMjzSY7Ea8TjgdeiRWlLAQpr582piUiKXpTyl5sigCLhS5Fa04elxR7y8mHcsY/edaU0Qk/r/Uh6fc+/7vrGp4X1KarFZnCxsJYUu+ZD8RBRecpu884JVp/DN9/90gnJ9abOJxnnCdqJTiFGYJ4y7jCqs/OL++KIlQ1A/Rfr4unWXbq4gGRisfixUnr15aH8bs2Gxo6bBLioMqOfF27QLUtpoTnjswshzHbZDaXMN8JErFrISAJVlceFcwEJgoVu8zG3ThAbtsGQu05L2TlA5OyKvz/LBfk6SmqGkWYCqbVkluu5zqZUfUMX7ugGFZZS/x3pHNmgTvxmSu0dkGIVx0xXTSW82YCBtMnFTXDdRmRhGWzPRskE8dTdKhvcscOYX+p0UdWm/RxMnSVC+6TopUmtLxJLSjNyONrglqy6P0PBuNr3KCrq5Q92hdcbUunE4nTEFXmBGClaRlCs+eUK7xe/amC54lm0rPMDjOxxoVhssYQmgS55OMjfYHTsRcOgtUbMcqR8mpIyFhZBjk+Ob0DNnq4PhLckZuzqmTNohkQTcw2W8D02vZ7AlEluvg1CHgf9Q3yxSykn33QaLWewhi25G0Yi1SLW3zv5v0Zj7mD0t/JznjCAflykqb1WsP4JrXjMRXkVlyon7F+EZ6uFMsxfiX/3tt5+hM51AVJQ
DKIM-Signature: a=rsa-sha256; bh=4qeKRVEbMgCxr8/XpYb+XaWMZj1N0vt3xMDb0BkFeas=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1790856443; v=1;
 b=HscwjvUVRh13KpaCzNKt5M6iG94hRTuF2U72a9fyzBMtVr/1FCdUv6d7gi0rvn3mf8S6529S
 qk3XfsrudHLd4B6PzzNrQZ/zZmKbWkqOK2X/cdJjcHtOV6uLtZa3ebc6tk6Bn3nc5rfM9sEzO0h
 BPz/A4qFRAku1kTuSJc2jQpGaHwam3hxpJFthNlS1GMH7IdDov8hjDeIato+CF+EwVMEkOhWQs4
 8ja9KqZl1V+5M37zAqNP+rxqYgKeBLZ/0QqyAVx/pI3E6uL85KHsy69SJu3R2LsocPrDan5zpGw
 EYanWCbDbgXGDZ3Qed5a0+F08rQpkpdjnlujSFw+dvkxA==
Received-SPF: pass client-ip=51.210.91.26; envelope-from=clg@kaod.org;
 helo=smtpout7.mo537.mail-out.ovh.net
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

On 10/1/26 13:51, Jamin Lin wrote:
> 
> 
>> Cédric Le Goater <clg@kaod.org> 於 2026年10月1日 下午3:41 寫道：
>>
>> ﻿On 9/30/26 14:16, Philippe Mathieu-Daudé wrote:
>>> On 30/9/26 13:50, CÃ©dric Le Goater wrote:
>>>>> Note to Peter: I really think keeping duplicating the
>>>>> UnimplementedDeviceConfig structure is a basic software
>>>>> development antipattern. Could you reconsider your objection?
>>>> What's the background ?
>>> I think that was discussed on IRC, the only ref on the list is:
>>> https://lore.kernel.org/qemu-devel/CAFEAcA_ob6mHqfAAM9iAMae5vfxaYhmcqkk-gJH+s1mHuvFp8g@mail.gmail.com/
>>> create_unimplemented_device() calls qdev_create() and allocate on the
>>> heap, my motivation was to have another helper for in-place init (when
>>> the UnimplementedDeviceState state is embedded in the parent). Now we
>>> ended with such helpers like aspeed_mmio_map_unimplemented() which
>>> realize in place, make_unimp_dev() and create_unimp() init and realize
>>> in place and Jamin adds yet another pattern. While all are valids,
>>> I'd rather unify.
>>
>> Could an array such as  :
>>
>> static const AspeedUnimpDevice aspeed_soc_ast2700_unimp_devs[] = {
>>    { "dpmcu",  "aspeed.dpmcu",  ASPEED_DEV_DPMCU,  0x00040000 },
>>    { "iomem",  "aspeed.io",     ASPEED_DEV_IOMEM,  0x00FE0000 },
>>    { "iomem0", "aspeed.iomem0", ASPEED_DEV_IOMEM0, 0x01000000 },
>>    { "iomem1", "aspeed.iomem1", ASPEED_DEV_IOMEM1, 0x01000000 },
>> };
>>
>> be defined at the class level of the SoC and handled automatically ?
>>
>> I guess would need some kind on common SoC model in that case.
>>
>> C.
>>
> Hi Cédric,
> 
> I will resend v2 and rework the design along these lines.

Please wait a bit for Phil's feedback.

> Defining the unimplemented devices as a class-level array and I will look
> into introducing a common SoC helper/model for this.

This could be a start for a more generalized solution.

> Besides that, we found that patch 11 breaks the AST2700 I/O expander support.

Ah. Did the functional catch this regression ?

> The device list should include:
> 
> ASPEED_DEV_IOEXP0_I2C,
> ASPEED_DEV_IOEXP1_I2C,
> ASPEED_DEV_IOEXP0_I3C,
> ASPEED_DEV_IOEXP1_I3C,
> ASPEED_DEV_IOEXP0_INTCIO,
> ASPEED_DEV_IOEXP1_INTCIO,
> 
> I will fix this in v2 as well.

OK.

Thanks,

C.



