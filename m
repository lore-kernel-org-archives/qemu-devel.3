Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDD9606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=BphbHgfD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVaT-00012p-Ge; Mon, 23 Nov 2026 10:04:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xVVaF-000129-JA
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:04:02 -0500
Received: from smtpout8.mo537.mail-out.ovh.net ([51.210.91.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xVVaC-00029A-U7
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:03:55 -0500
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [79.137.60.225])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4jY8N46qFLz491V;
 Mon, 23 Nov 2026 15:03:48 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon, 23 Nov 2026 15:03:48 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.118.150])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jY8L870Nhz6Q5D; Mon, 23 Nov 2026 15:02:08 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 3EBCC1B44373;
 Mon, 23 Nov 2026 15:02:08 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001434795f7-51ba-439c-9e45-12bae0edf44b,
 B6C8A908DA241A829C2EE32824EAF31EC75DFE0A) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <7b189e18-be09-40ac-9ca9-340aeb76845d@kaod.org>
Date: Mon, 23 Nov 2026 16:02:07 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2] hw/ssi/aspeed_smc: Correct minimum_version_id in
 vmstate
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
References: <20261119171425.3186790-1-peter.maydell@linaro.org>
 <00f62c2a-f094-4922-92c9-2d3c26a012d4@kaod.org>
 <CAFEAcA_mntTSsiZZRH1vOd9g4W2D=2AaNEEXvoucVDyf3ur1SA@mail.gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <CAFEAcA_mntTSsiZZRH1vOd9g4W2D=2AaNEEXvoucVDyf3ur1SA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 6156702166217501707
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEZhUgZLrjni5IWAnWn6OmuCszjnAe2bYANd1je9l2Ggk6jEBbjVfGYxlG85ddfqgXJZOK+ImXgA6EWVLnSCJHZutf3Q3fXCwLICXhTEkq3HNWDZbcZ1UTTlFMlQ59GS6eVf0O2XOgOi9fESr6SfzGeM4wt9n2ULp6Yl9HxjPfF/jhT2Hr1mEdfV7LOaxqEs9iEfebfifrNVvvSGB7RW7jHNs2urQiKbB3g9Rz+N8q27Qb2VntbW+TwTE0FvKPj3bMq0bigTKXLeBBisrPB8ydOgQWqW0Y+hDGwVZovHm8nFeOybqFMPgtNl67NT8yC+mVy0bhnTeMr2MVAl6Ehn6adVck+Va0tmbPlpuITcEAowVKDo/0jruE7774QMzn4uacDjUZXFq7O0d+hDcP8SxvJIZ4R5jLPiHen7rovfLZQ4qP/o7tQn1SyKziF23AVrQs+iXTnRB3jJoIQEqUwxoU1vulb4PJuNQ8ZcksTBnn6eYkIK+OoHffg6GBu+QOz7Jl1Aw5ZzCiE8R657amOFNqUYF1SnTwO7VjVETo8bDcrPckP+Dr2o/J2igNL5aWo/Qqg1MXDJIzoLosdvtfV0feEXZ/xqmkTbNjGQzC3sJ+LgRKWXtByHh6WW7yfXfazuffHMErmIwnKPdmS0qSgxR4LM6IUt6xlzumdwoFH0VWsBA
DKIM-Signature: a=rsa-sha256; bh=JNlp5uzuoY4ECM//pY/mDdz9sWHMDOjj1RMLmwsxIqI=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1795446229; v=1;
 b=BphbHgfDeBcaTJpEKC3jMRfa83Z05mnFNkhmTFgpFpthBEfRS3H/MKcR5UF+aK3iBQshGaGq
 axb2VaS0hBMpNYZtKOX9afkighZWyAXX0G6wMK2sX0m7bCIolWpiB3Y5VllHJcqZID45l9AHuv1
 fIsJFp2uJIi7LB3zUMhdSm6iVDzHOme9gmRs+9gxgT7h+hNlxgHN53Lou6I0n7JxLXuxqdhCj1Q
 Q+NZHb3e/DF4mV/qtf2qc8TV/jxN73e1YzJxLmZ21j1+6OYrPfPSdXqGVxZEsGbtqSsZkFeTWwX
 VG0Q+6XD6D5Oy7x1Rr2g6Vdz0NjAkD7DyRiRM92qP5Zvg==
Received-SPF: pass client-ip=51.210.91.27; envelope-from=clg@kaod.org;
 helo=smtpout8.mo537.mail-out.ovh.net
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 12:33, Peter Maydell wrote:
> On Fri, 20 Nov 2026 at 07:08, Cédric Le Goater <clg@kaod.org> wrote:
>>
>> On 11/19/26 18:14, Peter Maydell wrote:
>>> In commit 29139270d8ad70f2 we made an incompatible change to the
>>> migration state for the aspeed_smc device, and bumped the version_id
>>> and minimum_version_id: this is because we increased ASPEED_SMC_R_MAX
>>> and so the regs array is bigger.
>>>
>>> However, the old vmstate was handling migration from a range of
>>> vmstate versions, with version_id = 3 and minimum_version_id = 1.
>>> The change to ASPEED_SMC_R_MAX is (intentionally) not compatible with
>>> any of those older versions, and so it should have moved
>>> minimum_version_id up to 4 (matching the new version_id), not merely
>>> increment it.
>>>
>>> The effect of this is that trying a migration save on v11.1.3 and
>>> then a load on the current head of git fails in a confusing way
>>> ("Missing section footer for aspeed.smc") rather than clearly ("error
>>> while loading state for instance 0x0 of device 'aspeed.smc':
>>> aspeed.smc: incoming version_id 3 is too old for local minimum
>>> version_id 5").
>>>
>>> Since we now don't need to try to handle migration from versions 2
>>> and 3 at all, we can drop the complications in the vmstate struct (an
>>> unused field, and field only present in version 3 and up). Clean
>>> these up and set the version_id and minimum_version_id to 5
>>> accordingly.
>>>
>>> Fixes: 29139270d8ad70f2 ("hw/ssi/aspeed_smc: Add Data FIFO-based flash access support for AST2700")
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4880
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>    hw/ssi/aspeed_smc.c | 7 +++----
>>>    1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
>>> index ec9ad0f747e..f82947e752e 100644
>>> --- a/hw/ssi/aspeed_smc.c
>>> +++ b/hw/ssi/aspeed_smc.c
>>> @@ -1218,12 +1218,11 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
>>>
>>>    static const VMStateDescription vmstate_aspeed_smc = {
>>>        .name = "aspeed.smc",
>>> -    .version_id = 4,
>>> -    .minimum_version_id = 2,
>>> +    .version_id = 5,
>>> +    .minimum_version_id = 5,
>>>        .fields = (const VMStateField[]) {
>>>            VMSTATE_UINT32_ARRAY(regs, AspeedSMCState, ASPEED_SMC_R_MAX),
>>> -        VMSTATE_UNUSED_V(2, 2), /* was snoop_index/snoop_dummies */
>>> -        VMSTATE_BOOL_V(unselect, AspeedSMCState, 3),
>>> +        VMSTATE_BOOL(unselect, AspeedSMCState),
>>>            VMSTATE_END_OF_LIST()
>>>        }
>>>    };
>>
>>
>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> 
> Thanks. I've applied this to target-arm.next as I plan to send
> a pullreq before the next rc.

Thanks, I don't have much on the aspeed side.

C.



