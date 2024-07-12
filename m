Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3576C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 15:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSIfA-0000mO-VV; Fri, 12 Jul 2024 11:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Ecin=OM=kaod.org=clg@ozlabs.org>)
 id 1sSIf8-0000lu-6T
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 11:58:22 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Ecin=OM=kaod.org=clg@ozlabs.org>)
 id 1sSIf5-00005r-PA
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 11:58:21 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WLGTf0JRjz4x0t;
 Sat, 13 Jul 2024 01:58:14 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WLGTc5jtbz4wc1;
 Sat, 13 Jul 2024 01:58:12 +1000 (AEST)
Message-ID: <42c0b904-c0f4-40eb-8c5d-3f1011509964@kaod.org>
Date: Fri, 12 Jul 2024 17:58:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 06/12] aspeed/smc: Add DMA calibration settings
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190913154952.27724-1-peter.maydell@linaro.org>
 <20190913154952.27724-7-peter.maydell@linaro.org>
 <CAFEAcA9Bj5k_1kaqtmR4KfshGeDXomo5udFdWLW1cwySG4S=fQ@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CAFEAcA9Bj5k_1kaqtmR4KfshGeDXomo5udFdWLW1cwySG4S=fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Ecin=OM=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 7/12/24 16:39, Peter Maydell wrote:
> On Fri, 13 Sept 2019 at 16:50, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> From: Cédric Le Goater <clg@kaod.org>
>>
>> When doing calibration, the SPI clock rate in the CE0 Control Register
>> and the read delay cycles in the Read Timing Compensation Register are
>> set using bit[11:4] of the DMA Control Register.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> Acked-by: Joel Stanley <joel@jms.id.au>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Message-id: 20190904070506.1052-7-clg@kaod.org
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
> Hi; this is an old patch, but Coverity has suddenly decided
> it doesn't like it (CID 1547822):
> 
>> +static uint8_t aspeed_smc_hclk_divisor(uint8_t hclk_mask)
>> +{
>> +    /* HCLK/1 .. HCLK/16 */
>> +    const uint8_t hclk_divisors[] = {
>> +        15, 7, 14, 6, 13, 5, 12, 4, 11, 3, 10, 2, 9, 1, 8, 0
>> +    };
>> +    int i;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(hclk_divisors); i++) {
>> +        if (hclk_mask == hclk_divisors[i]) {
>> +            return i + 1;
>> +        }
>> +    }
>> +
>> +    qemu_log_mask(LOG_GUEST_ERROR, "invalid HCLK mask %x", hclk_mask);
>> +    return 0;
>> +}
>> +
>> +/*
>> + * When doing calibration, the SPI clock rate in the CE0 Control
>> + * Register and the read delay cycles in the Read Timing Compensation
>> + * Register are set using bit[11:4] of the DMA Control Register.
>> + */
>> +static void aspeed_smc_dma_calibration(AspeedSMCState *s)
>> +{
>> +    uint8_t delay =
>> +        (s->regs[R_DMA_CTRL] >> DMA_CTRL_DELAY_SHIFT) & DMA_CTRL_DELAY_MASK;
>> +    uint8_t hclk_mask =
>> +        (s->regs[R_DMA_CTRL] >> DMA_CTRL_FREQ_SHIFT) & DMA_CTRL_FREQ_MASK;
>> +    uint8_t hclk_div = aspeed_smc_hclk_divisor(hclk_mask);
>> +    uint32_t hclk_shift = (hclk_div - 1) << 2;
> 
> The code of aspeeed_smc_hclk_divisor() has a codepath where it
> can return 0, and this callsite doesn't check for 0, and so
> Coverity thinks that we might end up shifting -1 by 2 to get
> the hclk_shift here, which means we overflow the value, which
> it thinks is probably not what we meant to do.
> 
> In fact this can't happen, because we always pass aspeed_smc_hclk_divisor()
> a value between 0 and 15, and if we do that then we always get back
> a value between 1 and 16. So I think the right fix would be
> to change the qemu_log_mask()/return 0 to be g_assert_not_reached().

I was wondering how to fix it. Thanks for the suggestion. Will do in
the 9.1 cycle.

C.

> 
> thanks
> -- PMM


