Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C98C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 05:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOsj3-0004qE-4f; Wed, 03 Jul 2024 01:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org>)
 id 1sOsit-0004oo-B4
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 01:40:09 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org>)
 id 1sOsiq-0007by-KI
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 01:40:06 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WDTBL3nNDz4wcC;
 Wed,  3 Jul 2024 15:39:54 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WDT9w3YCkz4wbr;
 Wed,  3 Jul 2024 15:39:32 +1000 (AEST)
Message-ID: <c9e94d4e-d163-4fca-9f8f-69c0e1b0f817@kaod.org>
Date: Wed, 3 Jul 2024 07:39:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [RFC PATCH v42 90/98] hw/sd/sdcard: Add experimental
 'x-aspeed-emmc-kludge' property
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-91-philmd@linaro.org>
 <4b55f817-0e29-45c0-8f56-f997f34e0e97@kaod.org>
 <e1a6b93038e67271fc0bd9efcc7d40802cbbede7.camel@codeconstruct.com.au>
 <2b425f32-41de-4057-a8d0-79411f2519b4@linaro.org>
 <b9824203375f3ebec3fa4ba4b5cb1721a00e8030.camel@codeconstruct.com.au>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <b9824203375f3ebec3fa4ba4b5cb1721a00e8030.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/3/24 7:10 AM, Andrew Jeffery wrote:
> On Tue, 2024-07-02 at 18:15 +0200, Philippe Mathieu-Daudé wrote:
>> On 2/7/24 07:06, Andrew Jeffery wrote:
>>> On Fri, 2024-06-28 at 11:16 +0200, Cédric Le Goater wrote:
>>>> On 6/28/24 9:02 AM, Philippe Mathieu-Daudé wrote:
>>>>> When booting U-boot/Linux on Aspeed boards via eMMC,
>>>>> some commands don't behave as expected from the spec.
>>>>>
>>>>> Add the 'x-aspeed-emmc-kludge' property to allow non
>>>>> standard uses until we figure out the reasons.
>>>>
>>>> I am not aware of any singularity in the eMMC logic provided by Aspeed.
>>>> U-Boot and Linux drivers seem very generic. May be others can tell.
>>>
>>> I'm not aware of any command kludges. The main problem I had when I
>>> wrote the Linux driver for the Aspeed controller was the phase tuning,
>>> but that doesn't sound related.
>>
>> Yeah I don't think anything Aspeed nor U-boot related, we
>> model CSD/CID registers per the SD spec, not MMC. Various
>> fields are identical, but few differ, this might be the
>> problem.
>>
>> I rather respect the spec by default, so until we figure
>> the issue, are you OK to use a 'x-emmc-kludge' property
>> and set it on the Aspeed boards?
> 
> Dropping the implication that it's the fault of the Aspeed controller
> seems reasonable (without further evidence that it's true).

Yes. Let's introduce 'x-emmc-kludge' and move on.

I dropped all emmc support from the aspeed-9.1 branch for now.

Thanks,

C.


