Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4B1C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whVOp-0007PB-IL; Wed, 08 Jul 2026 12:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1whVOi-0007F9-DT; Wed, 08 Jul 2026 12:45:20 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1whVOe-0003Lr-4N; Wed, 08 Jul 2026 12:45:18 -0400
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [51.210.158.128])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4gwP8m2nvyz6V6v;
 Wed,  8 Jul 2026 16:45:12 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Wed,  8 Jul 2026 16:45:12 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.54.155])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gwP8l72S8z6KRW; Wed,  8 Jul 2026 16:45:11 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id D14F7203D78; 
 Wed,  8 Jul 2026 16:45:09 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-111S005162a6c14-e86c-4a00-b644-c8d91a225d99,
 2D223E717D9FA260C3726021AC4FE3AAA9F332FE) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <f7659f14-3961-4021-b936-8739a01a2d65@kaod.org>
Date: Wed, 8 Jul 2026 18:45:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] tests/qtest: aspeed_smc: Add fast-read test coverage
To: Bin Meng <bmeng.cn@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Bin Meng <bin.meng@processmission.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260708111544.1440761-1-clg@redhat.com>
 <20260708111544.1440761-3-clg@redhat.com>
 <CAEUhbmWWmX9BKwS2m12vPk=rN_DxzCKqsm=h9g26QdHcX3gHqw@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <CAEUhbmWWmX9BKwS2m12vPk=rN_DxzCKqsm=h9g26QdHcX3gHqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 9122041048619723821
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGszzCa6Plw9XuHTjPf67GSsxXG9dq6BPqMe7UIwYeG/RzQJ95XUz5jNa6UYUtqQn9bCg4lSCW0g42IYKKfpnZjrC8L53YD3oFzmV+0Yo29SEV6JYXBY8kRz5Y30/L84pJGrRJ7IpoUs1xrU8jRL/nNXPai4ABznUP4uiDv8Dq1KA9KO4rbrAPtJQcX62yxiCJVhR+ragqVmRwpBdhkFjPmPX81ejUrS+jk0fxy/QSmiMzKnBIO52DXvTQZmNNoM8AYUoLYmMjqMhO9hWyVwH9zTSva9ZGyp+NQoISlN60IsApmXsytqW3pqtB0qv3yYmS/i0UAt/GwWQCgVpk45mQGdgf5Fa3yVfayiRPN8YPu1W5/E5o+sVfvMHKawaAGqw4A0ftLI7O982XLPAxoywFrtM9G22eFW6RV/yMvdFk0HAxDsFdjRtxKPMx5wkKsebDHt1RTPljZ7n2my4ZVPjcXZtpIXAyNqJMZJYEEG5YpO4YdCrIpIrY+dL9SywEzCuO7i7XUmShUS+Ue3JgsYGmkMBPtEspy6HSD2YuS1D0pGzC0HByHg/aThL6CKzGjEbyA3ohfm1A17PinpmKbSqtEjexKT1AA/+YLuGIvpVbiZF67nc4a/MnJ7yb2in5g7LxSaO40VoJV9WaawMBaYCBR5Kk0qzDZfniXAKzMnd0+DA
DKIM-Signature: a=rsa-sha256; bh=fLsC9SPir3DC5E0J4NqTpZebntcaUsb+9Zn0LmFgf88=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1783529113; v=1;
 b=mufjizid6Uqbfv41254LVRK9wZmYqCQB5nooAgxefrmt9T+UIT82IKqxDGoBNiHVgbpypEXF
 7HoOfLMER24Lm+tIzllxRaTJGw9VgrsuNZO0FmOJEqVmNBjL1WzLpEhYs9scAjqzpEniLv/7SPr
 VNQTlvzhdFh2yxc4u85H3635kl552J1YyVWvYjo69lZeXA4q/6XW8TtYAHcYqWld5NDBw2729np
 eu+ZJI550V4yPFX47Gt4jhoUtAnT77LnFT7/T12bXTNZiWLNUSF9WedzGqqozWXisRboNHMDpXU
 TP219qpF2NAcUpr+fNfR7k9FIkAzSIgzvWAnDcL7Zuw7g==
Received-SPF: pass client-ip=46.105.34.251; envelope-from=clg@kaod.org;
 helo=smtpout1.mo528.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/8/26 17:29, Bin Meng wrote:
> On Wed, Jul 8, 2026 at 7:17 PM Cédric Le Goater <clg@redhat.com> wrote:
>>
>> Add read_page_mem_fast_read (CTRL_FREADMODE with dummy byte) and
>> write_page_fast_read (user-mode FAST_READ) tests.
>>
>> Signed-off-by: Cedric Le Goater <clg@redhat.com>
>> ---
>>   tests/qtest/aspeed-smc-utils.h |  5 ++++
>>   tests/qtest/aspeed-smc-utils.c | 49 ++++++++++++++++++++++++++++++++++
>>   tests/qtest/aspeed_smc-test.c  | 21 +++++++++++++++
>>   tests/qtest/ast2700-smc-test.c |  4 +++
>>   4 files changed, 79 insertions(+)
>>
>> diff --git a/tests/qtest/aspeed-smc-utils.h b/tests/qtest/aspeed-smc-utils.h
>> index e2fd8ff1bd16..5a86514caf35 100644
>> --- a/tests/qtest/aspeed-smc-utils.h
>> +++ b/tests/qtest/aspeed-smc-utils.h
>> @@ -44,6 +44,8 @@
>>   #define   CTRL_FREADMODE       0x1
>>   #define   CTRL_WRITEMODE       0x2
>>   #define   CTRL_USERMODE        0x3
>> +#define   CTRL_DUMMY_LOW_SHIFT   6
>> +#define   CTRL_DUMMY_HIGH_SHIFT  14
>>   #define SR_WEL BIT(1)
>>
>>   /*
>> @@ -55,6 +57,7 @@ enum {
>>       WRDI = 0x4,
>>       BULK_ERASE = 0xc7,
>>       READ = 0x03,
>> +    FAST_READ = 0x0b,
>>       PP = 0x02,
>>       WRSR = 0x1,
>>       WREN = 0x6,
>> @@ -90,5 +93,7 @@ void aspeed_smc_test_status_reg_write_protection(const void *data);
>>   void aspeed_smc_test_write_block_protect(const void *data);
>>   void aspeed_smc_test_write_block_protect_bottom_bit(const void *data);
>>   void aspeed_smc_test_write_page_qpi(const void *data);
>> +void aspeed_smc_test_read_page_mem_fast_read(const void *data);
>> +void aspeed_smc_test_write_page_fast_read(const void *data);
>>
>>   #endif /* TESTS_ASPEED_SMC_UTILS_H */
>> diff --git a/tests/qtest/aspeed-smc-utils.c b/tests/qtest/aspeed-smc-utils.c
>> index ed125741eb36..9883ade0815c 100644
>> --- a/tests/qtest/aspeed-smc-utils.c
>> +++ b/tests/qtest/aspeed-smc-utils.c
>> @@ -697,3 +697,52 @@ void aspeed_smc_test_write_page_qpi(const void *data)
>>       flash_reset(test_data);
>>   }
>>
>> +static void read_page_mem_fast_read(const AspeedSMCTestData *data,
>> +                                uint32_t addr, uint32_t *page)
>> +{
>> +    uint32_t ctrl_reg = R_CTRL0 + data->cs * 4;
>> +    uint32_t ctrl = spi_readl(data, ctrl_reg);
>> +    int i;
>> +
>> +    /* Set FREADMODE with FAST_READ command and 1 dummy byte */
>> +    ctrl &= ~(CTRL_USERMODE | (0xff << 16) |
>> +              (0x3 << CTRL_DUMMY_LOW_SHIFT) |
>> +              (0x1 << CTRL_DUMMY_HIGH_SHIFT) |
>> +              CTRL_IO_MODE_MASK);
>> +    ctrl |= CTRL_FREADMODE | (FAST_READ << 16) |
>> +            (1 << CTRL_DUMMY_LOW_SHIFT);
>> +    spi_writel(data, ctrl_reg, ctrl);
> 
> Could just call spi_ctrl_set_fast_read()?

Yeah. I could introduce a common helper if it's what you mean.

Thanks,

C.


> 
>> +
>> +    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
>> +        page[i] = make_be32(flash_readl(data, addr + i * 4));
>> +    }
>> +}
>> +
>> +void aspeed_smc_test_read_page_mem_fast_read(const void *data)
>> +{
>> +    test_read_page_mem(data, read_page_mem_fast_read);
>> +}
>> +
>> +static void read_page_fast_read(const AspeedSMCTestData *data,
>> +                                uint32_t addr, uint32_t *page)
>> +{
>> +    int i;
>> +
>> +    spi_ctrl_start_user(data);
>> +
>> +    flash_writeb(data, 0, EN_4BYTE_ADDR);
>> +    flash_writeb(data, 0, FAST_READ);
>> +    flash_writel(data, 0, make_be32(addr));
>> +    /* 1 dummy byte for standard SPI fast-read */
>> +    flash_writeb(data, 0, 0x00);
>> +
>> +    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
>> +        page[i] = make_be32(flash_readl(data, 0));
>> +    }
>> +    spi_ctrl_stop_user(data);
>> +}
>> +
>> +void aspeed_smc_test_write_page_fast_read(const void *data)
>> +{
>> +    test_write_page(data, read_page_fast_read);
>> +}
>> diff --git a/tests/qtest/aspeed_smc-test.c b/tests/qtest/aspeed_smc-test.c
>> index 39af1df0ed75..bbda15ad17ea 100644
>> --- a/tests/qtest/aspeed_smc-test.c
>> +++ b/tests/qtest/aspeed_smc-test.c
>> @@ -68,6 +68,15 @@ static void test_palmetto_bmc(AspeedSMCTestData *data)
>>                           data, aspeed_smc_test_read_status_reg);
>>       qtest_add_data_func("/ast2400/smc/status_reg_write_protection",
>>                           data, aspeed_smc_test_status_reg_write_protection);
>> +    qtest_add_data_func("/ast2400/smc/read_page_mem_fast_read",
>> +                        data, aspeed_smc_test_read_page_mem_fast_read);
>> +    qtest_add_data_func("/ast2400/smc/write_page_fast_read",
>> +                        data, aspeed_smc_test_write_page_fast_read);
>> +    /*
>> +     * Block protect tests must be run last because the block protect
>> +     * state is not cleared by reset_memory() and silently prevents
>> +     * subsequent flash writes.
>> +     */
>>       qtest_add_data_func("/ast2400/smc/write_block_protect",
>>                           data, aspeed_smc_test_write_block_protect);
>>       qtest_add_data_func("/ast2400/smc/write_block_protect_bottom_bit",
>> @@ -115,6 +124,10 @@ static void test_ast2500_evb(AspeedSMCTestData *data)
>>                           data, aspeed_smc_test_read_status_reg);
>>       qtest_add_data_func("/ast2500/smc/write_page_qpi",
>>                           data, aspeed_smc_test_write_page_qpi);
>> +    qtest_add_data_func("/ast2500/smc/read_page_mem_fast_read",
>> +                        data, aspeed_smc_test_read_page_mem_fast_read);
>> +    qtest_add_data_func("/ast2500/smc/write_page_fast_read",
>> +                        data, aspeed_smc_test_write_page_fast_read);
>>   }
>>
>>   static void test_ast2600_evb(AspeedSMCTestData *data)
>> @@ -158,6 +171,10 @@ static void test_ast2600_evb(AspeedSMCTestData *data)
>>                           data, aspeed_smc_test_read_status_reg);
>>       qtest_add_data_func("/ast2600/smc/write_page_qpi",
>>                           data, aspeed_smc_test_write_page_qpi);
>> +    qtest_add_data_func("/ast2600/smc/read_page_mem_fast_read",
>> +                        data, aspeed_smc_test_read_page_mem_fast_read);
>> +    qtest_add_data_func("/ast2600/smc/write_page_fast_read",
>> +                        data, aspeed_smc_test_write_page_fast_read);
>>   }
>>
>>   static void test_ast1030_evb(AspeedSMCTestData *data)
>> @@ -201,6 +218,10 @@ static void test_ast1030_evb(AspeedSMCTestData *data)
>>                           data, aspeed_smc_test_read_status_reg);
>>       qtest_add_data_func("/ast1030/smc/write_page_qpi",
>>                           data, aspeed_smc_test_write_page_qpi);
>> +    qtest_add_data_func("/ast1030/smc/read_page_mem_fast_read",
>> +                        data, aspeed_smc_test_read_page_mem_fast_read);
>> +    qtest_add_data_func("/ast1030/smc/write_page_fast_read",
>> +                        data, aspeed_smc_test_write_page_fast_read);
>>   }
>>
>>   int main(int argc, char **argv)
>> diff --git a/tests/qtest/ast2700-smc-test.c b/tests/qtest/ast2700-smc-test.c
>> index 33fc47230ee5..9ad04b574c0d 100644
>> --- a/tests/qtest/ast2700-smc-test.c
>> +++ b/tests/qtest/ast2700-smc-test.c
>> @@ -52,6 +52,10 @@ static void test_ast2700_evb(AspeedSMCTestData *data)
>>                           data, aspeed_smc_test_read_status_reg);
>>       qtest_add_data_func("/ast2700/smc/write_page_qpi",
>>                           data, aspeed_smc_test_write_page_qpi);
>> +    qtest_add_data_func("/ast2700/smc/read_page_mem_fast_read",
>> +                        data, aspeed_smc_test_read_page_mem_fast_read);
>> +    qtest_add_data_func("/ast2700/smc/write_page_fast_read",
>> +                        data, aspeed_smc_test_write_page_fast_read);
>>   }
>>
>>   int main(int argc, char **argv)
> 
> Regards,
> Bin
> 


