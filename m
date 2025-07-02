Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07316C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 21:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX4w4-0000Fw-DI; Wed, 02 Jul 2025 17:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U4+o=ZP=kaod.org=clg@ozlabs.org>)
 id 1uX4w0-0000F0-8w; Wed, 02 Jul 2025 17:24:04 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U4+o=ZP=kaod.org=clg@ozlabs.org>)
 id 1uX4vn-0004uB-SR; Wed, 02 Jul 2025 17:24:02 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4bXXv33HG1z4x7G;
 Thu,  3 Jul 2025 07:23:27 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4bXXtz6zPWz4wd0;
 Thu,  3 Jul 2025 07:23:23 +1000 (AEST)
Message-ID: <57feb644-8943-4038-9a42-a6c2946ec7b8@kaod.org>
Date: Wed, 2 Jul 2025 23:23:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/arm/aspeed: Add second SPI chip to Aspeed model
To: etanous <etanous@nvidia.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Troy Lee <leetroy@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org
References: <20250701203400.71677-1-etanous@nvidia.com>
 <20250701203400.71677-3-etanous@nvidia.com>
 <a0dfcbf7-cc09-4fb8-bc3b-3d4060fce5e9@kaod.org>
 <aGWII78ihmhn_-q6@edtanousvm.nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <aGWII78ihmhn_-q6@edtanousvm.nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=U4+o=ZP=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 7/2/25 21:27, etanous wrote:
> On Wed, Jul 02, 2025 at 09:00:20AM +0200, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 7/1/25 22:33, Ed Tanous wrote:
>>> Aspeed2600 has two spi lanes;  Add a new struct that can mount the
>>> second SPI.
>>>
>>> Signed-off-by: Ed Tanous <etanous@nvidia.com>
>>> ---
>>>    hw/arm/aspeed.c         | 2 ++
>>>    include/hw/arm/aspeed.h | 2 ++
>>>    2 files changed, 4 insertions(+)
>>>
>>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>>> index d0b333646e..3ef7f6c5b2 100644
>>> --- a/hw/arm/aspeed.c
>>> +++ b/hw/arm/aspeed.c
>>> @@ -465,6 +465,8 @@ static void aspeed_machine_init(MachineState *machine)
>>>            aspeed_board_init_flashes(&bmc->soc->spi[0],
>>>                                  bmc->spi_model ? bmc->spi_model : amc->spi_model,
>>>                                  1, amc->num_cs);
>>> +        aspeed_board_init_flashes(&bmc->soc->spi[1],
>>> +                                  amc->spi2_model, 1, amc->num_cs2);
>>>        }
>>>
>>>        if (machine->kernel_filename && sc->num_cpus > 1) {
>>> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
>>> index 973277bea6..6c36455656 100644
>>> --- a/include/hw/arm/aspeed.h
>>> +++ b/include/hw/arm/aspeed.h
>>> @@ -35,7 +35,9 @@ struct AspeedMachineClass {
>>>        uint32_t hw_strap2;
>>>        const char *fmc_model;
>>>        const char *spi_model;
>>> +    const char *spi2_model;
>>>        uint32_t num_cs;
>>> +    uint32_t num_cs2;
>>>        uint32_t macs_mask;
>>>        void (*i2c_init)(AspeedMachineState *bmc);
>>>        uint32_t uart_default;
>>
>> Another way specifying backends for all SPI devices is to use -blockdev :
>>
>>    $ qemu-system-arm -M ast2600-evb \
>>        -blockdev node-name=fmc0,driver=file,filename=/path/to/fmc0.img \
>>        -device mx66u51235f,bus=ssi.0,cs=0x0,drive=fmc0 \
>>        -blockdev node-name=fmc1,driver=file,filename=/path/to/fmc1.img \
>>        -device mx66u51235f,bus=ssi.0,cs=0x1,drive=fmc1 \
>>        -blockdev node-name=spi1,driver=file,filename=/path/to/spi1.img \
>>        -device mx66u51235f,cs=0x0,bus=ssi.1,drive=spi1 \
>>        -nographic -nodefaults
>>
> 
> I had attempted that at one point.  The second SPI flash is expected to
> be empty on first boot, so building up an empty file with dd seemed like
> a waste, and pushed more details on the user calling the machine to
> know the machine configuration.  FWIW, yoctos 'runqemu' helper script is
> also very useful, but getting it to spit out non-standard args and files
> isn't the easiest.  If what's in this patch is ok, I'd like to stick
> with it.  If not, I can dig deeper into trying to do this on command
> line.

It's fine. we will merge it. I am trying to promote the -blockdev interface
to get rid of -drive but this seems to be wishful thinking.


Thanks,

C.



