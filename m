Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F339C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 06:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLzJW-0004Vq-ML; Tue, 25 Jun 2024 02:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=+2S4=N3=kaod.org=clg@ozlabs.org>)
 id 1sLzJU-0004Tg-6j; Tue, 25 Jun 2024 02:05:56 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=+2S4=N3=kaod.org=clg@ozlabs.org>)
 id 1sLzJR-0004m6-Kn; Tue, 25 Jun 2024 02:05:55 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W7Z7w1X15z4wcJ;
 Tue, 25 Jun 2024 16:05:48 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W7Z7r4J9rz4wbr;
 Tue, 25 Jun 2024 16:05:44 +1000 (AEST)
Message-ID: <ff45f5c5-5586-4c21-bf86-ad82eb2c5f0d@kaod.org>
Date: Tue, 25 Jun 2024 08:05:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] aspeed/soc: fix coverity issue
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang <yunlin.tang@aspeedtech.com>
References: <20240619093508.2528537-1-jamin_lin@aspeedtech.com>
 <20240619093508.2528537-2-jamin_lin@aspeedtech.com>
 <CAFEAcA8tTHusKOR7JhyU+wwA3JJWq1o5wVaNXugw2S9SjAsESw@mail.gmail.com>
 <b013bd79-c206-446e-b482-91eeb926c70a@kaod.org>
 <SI2PR06MB50412C68BF0AD9B4ED91B75FFCD52@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <SI2PR06MB50412C68BF0AD9B4ED91B75FFCD52@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=+2S4=N3=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

Hello

On 6/25/24 3:55 AM, Jamin Lin wrote:
> Hi Cedric,
>> -----Original Message-----
>> From: Cédric Le Goater <clg@kaod.org>
>> Sent: Monday, June 24, 2024 9:58 PM
>> To: Peter Maydell <peter.maydell@linaro.org>; Jamin Lin
>> <jamin_lin@aspeedtech.com>
>> Cc: Steven Lee <steven_lee@aspeedtech.com>; Troy Lee
>> <leetroy@gmail.com>; Andrew Jeffery <andrew@codeconstruct.com.au>; Joel
>> Stanley <joel@jms.id.au>; open list:ASPEED BMCs <qemu-arm@nongnu.org>;
>> open list:All patches CC here <qemu-devel@nongnu.org>; Troy Lee
>> <troy_lee@aspeedtech.com>; Yunlin Tang <yunlin.tang@aspeedtech.com>
>> Subject: Re: [PATCH v1 1/2] aspeed/soc: fix coverity issue
>>
>> On 6/24/24 2:18 PM, Peter Maydell wrote:
>>> On Wed, 19 Jun 2024 at 10:35, Jamin Lin <jamin_lin@aspeedtech.com>
>> wrote:
>>>>
>>>> Fix coverity defect: DIVIDE_BY_ZERO.
>>>>
>>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>>> ---
>>>>    hw/arm/aspeed_ast27x0.c | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c index
>>>> b6876b4862..d14a46df6f 100644
>>>> --- a/hw/arm/aspeed_ast27x0.c
>>>> +++ b/hw/arm/aspeed_ast27x0.c
>>>> @@ -211,6 +211,12 @@ static void aspeed_ram_capacity_write(void
>> *opaque, hwaddr addr, uint64_t data,
>>>>        ram_size = object_property_get_uint(OBJECT(&s->sdmc),
>> "ram-size",
>>>>                                            &error_abort);
>>>>
>>>> +    if (!ram_size) {
>>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>>> +                      "%s: ram_size is zero",  __func__);
>>>> +        return;
>>>> +    }
>>>> +
>>>
>>> Isn't this a QEMU bug rather than a guest error? The RAM size
>>> presumably should never be zero unless the board set the ram-size
>>> property on the SDMC incorrectly. So the SDMC device should check (and
>>> return an error from its realize
>>> method) that the ram-size property is valid,
>>
>> That's the case in aspeed_sdmc_set_ram_size() which is called from the
>> aspeed machine init routine when the ram size is set.
>>
>> Setting the machine ram size to zero on the command line doesn't report an
>> error though and the size is the default.
>>
>>> and then here we can just assert(ram_size != 0).
>>
>> Yes.
>>
>> Jamin, could you please send a v2 with the commit logs update I proposed ?
>> See the patches on my aspeed-9.1 branch.
> I resend v2 patch with your commit log, https://www.mail-archive.com/qemu-devel@nongnu.org/msg1050302.html

We'll need a v3 with the assert. No hurries. We still have some time
before the soft freeze.

Thanks,

C.




> Do we need to drop this patch, https://www.mail-archive.com/qemu-devel@nongnu.org/msg1050301.html?
> 
> Thanks-Jamin
>>
>> Thanks,
>>
>> C.


