Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4340AECE569
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 20:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sn21I-0006iS-Pl; Sat, 07 Sep 2024 16:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <satur9nine@gmail.com>)
 id 1sn21G-0006fS-DU
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 16:26:54 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <satur9nine@gmail.com>)
 id 1sn21E-0007X3-Az
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 16:26:54 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20570b42f24so39262715ad.1
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2024 13:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725740810; x=1726345610; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FzpWUX+Pg6MNBiDTwYTTvjDU/EemCmQbzdxBamC8uRQ=;
 b=TNfwZDGP/lwgV2JuSskKQb7KHcd1YE8jztDfienlS5+jkhWZz8aSpTTuEDhmL2DGVP
 Nk8MluC6gJHUThS4qN/SEZOtaKMv+GLOFYHK0r8QiS1J5OkL1fzkjvgnw/gNcU4crmc+
 tf6neyM+agHiCapsjmtmMqEspqULwfVJL+VamAycZILsACWr2NyNs2QbUfjH3DfQ8dzl
 WRD8z52ze+ncD8LP8J+D6Uf6SU1xfBFbMqTRewoxXvuGKjtfL+b1SZdIYnP8FR9+Gc8m
 +RFlnyjluMgHaJpv3jDzyWkBGk63HrFQram+uaxAGW5LDsKZ3/OWYhY5D1imx6nq9A4K
 n/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725740810; x=1726345610;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FzpWUX+Pg6MNBiDTwYTTvjDU/EemCmQbzdxBamC8uRQ=;
 b=CaykhF5Wy4P1MJ4ffcEefbWGD5nzVmYrkkcwb/icV/leAwr8+tAG9IJPwNybfHD4aA
 iSy0U1B/nbA6raYbNAW/8HB5bxYxxw+AM8t8q4TQyuoEHhm4QURg6PUL4/Ht/fax9EGY
 hNL4wo32x3gtNAwyWO8X6Qd6KGaU4WufgSoIAQUjLw2gkAx0r7j+2WcjDuIgmaFElV+Y
 b6v6hDH77aPsubAPPlzifgiLga795ny+ELhAdmJmR+uvlkw5AcohWtrUxGXWZ/iJ6v8R
 MyKJ0BGpCIFf3w0pf6hJnM8ngtoWQz4xasbUiRzwkkouUIBhYrc3QwKBMJ1vm2c6CI3X
 A3dg==
X-Gm-Message-State: AOJu0YxJHtiRl9LykPvOjSsAG3wLEEs31hhCsbQL2E1aHSkPzMicuemd
 dadhRywLrCOHN+hmedw59Rg6aIduRU3ZLXNj2hpYX8MwEW3qCi/mRVOZnJFz
X-Google-Smtp-Source: AGHT+IEU+LmXS7H27vhtvdFwbo/Y7+Vo6xzK+DOtVHFRsAG/Txn8MrhecURB/em/B42TtLwJTKR7zg==
X-Received: by 2002:a17:902:d4c9:b0:205:6f3c:4a65 with SMTP id
 d9443c01a7336-206f04c76a0mr72083505ad.2.1725740809872; 
 Sat, 07 Sep 2024 13:26:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:88b2:a50:2c86:7da2:dc34:a97f?
 ([2600:1700:88b2:a50:2c86:7da2:dc34:a97f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e33a22sm11824475ad.98.2024.09.07.13.26.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Sep 2024 13:26:49 -0700 (PDT)
Message-ID: <d561777d-2c7a-4561-8840-4bca363d28e8@gmail.com>
Date: Sat, 7 Sep 2024 13:26:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char/stm32l4x5_usart.c: Fix ACK and min access size
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
References: <20240902061944.526873-1-satur9nine@gmail.com>
 <CAFEAcA9wP7f_yPYNJmaTDe1bB8cPifErAGpjtsNPKsR0s_65Sg@mail.gmail.com>
Content-Language: en-US
From: Jacob Abrams <satur9nine@gmail.com>
In-Reply-To: <CAFEAcA9wP7f_yPYNJmaTDe1bB8cPifErAGpjtsNPKsR0s_65Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=satur9nine@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/6/24 09:12, Peter Maydell wrote:
> On Mon, 2 Sept 2024 at 14:38, Jacob Abrams <satur9nine@gmail.com> wrote:
>>
>> These changes allow the official STM32L4xx HAL UART driver to function
>> properly with the b-l475e-iot01a machine.
>>
>> Modifying USART_CR1 TE bit should alter USART_ISR TEACK bit, and
>> likewise for RE and REACK bit.
>>
>> USART registers may be accessed via 16-bit instructions.
>>
>> Reseting USART_CR1 UE bit should restore ISR to default value.
>>
>> Fixes: 87b77e6e01ca ("hw/char/stm32l4x5_usart: Enable serial read and write")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2540
>> Signed-off-by: Jacob Abrams <satur9nine@gmail.com>
> 
> Thanks for this patch. I have one question below, and one
> minor nit.
> 
>> ---
>>  hw/char/stm32l4x5_usart.c          | 29 +++++++++++++++++++---
>>  tests/qtest/stm32l4x5_usart-test.c | 39 +++++++++++++++++++++++++++++-
>>  2 files changed, 64 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
>> index fc5dcac0c4..859fc6236a 100644
>> --- a/hw/char/stm32l4x5_usart.c
>> +++ b/hw/char/stm32l4x5_usart.c
>> @@ -154,6 +154,28 @@ REG32(RDR, 0x24)
>>  REG32(TDR, 0x28)
>>      FIELD(TDR, TDR, 0, 9)
>>
>> +#define ISR_RESET_VALUE (0x020000C0)
>> +
>> +static void stm32l4x5_update_isr(Stm32l4x5UsartBaseState *s)
>> +{
>> +    if (!(s->cr1 & R_CR1_UE_MASK)) {
>> +        s->isr = ISR_RESET_VALUE;
>> +        return;
>> +    }
>> +
>> +    if (s->cr1 & R_CR1_TE_MASK) {
>> +        s->isr |= R_ISR_TEACK_MASK;
>> +    } else {
>> +        s->isr &= ~R_ISR_TEACK_MASK;
>> +    }
>> +
>> +    if (s->cr1 & R_CR1_RE_MASK) {
>> +        s->isr |= R_ISR_REACK_MASK;
>> +    } else {
>> +        s->isr &= ~R_ISR_REACK_MASK;
>> +    }
>> +}
> 
> Should we be doing these things based on the value of
> the CR1 bits (as this code does), or instead do them
> when the bit changes from 0 to 1 (or 1 to 0)?
> The wording in the datasheet seems unclear to me; my
> impression is that hardware designers often like to
> do these things on transitions rather than level based,
> but of course you can design h/w both ways...
> 
> I guess it could be tested on real hardware:
>  * write CR1.TE = 1
>  * wait for ISR.TEACK = 1
>  * write ISR.TEACK = 0
>  * write CR1.TE = 1 (i.e. write again to the register
>    without changing its value)
>  * does ISR.TEACK go to 1 again, or does it stay 0?
> 

Per RM0351 all bits in the ISR register are read-only by software, so we cannot test writing ISR.TEACK on a physical chip, the write would be ignored. Precise description in RM0351 is "This bit is set/reset by hardware, when the Transmit Enable value is taken into account by the USART." Based on this I think it is safe to assume that ISR.TEACK should always reflect the value of CR1.TE, though in real hardware it would take some microseconds for TEACK to be updated after TE is changed.

>> +
>>  static void stm32l4x5_update_irq(Stm32l4x5UsartBaseState *s)
>>  {
>>      if (((s->isr & R_ISR_WUF_MASK) && (s->cr3 & R_CR3_WUFIE_MASK))        ||
>> @@ -367,7 +389,7 @@ static void stm32l4x5_usart_base_reset_hold(Object *obj, ResetType type)
>>      s->brr = 0x00000000;
>>      s->gtpr = 0x00000000;
>>      s->rtor = 0x00000000;
>> -    s->isr = 0x020000C0;
>> +    s->isr = ISR_RESET_VALUE;
>>      s->rdr = 0x00000000;
>>      s->tdr = 0x00000000;
>>
>> @@ -456,6 +478,7 @@ static void stm32l4x5_usart_base_write(void *opaque, hwaddr addr,
>>      case A_CR1:
>>          s->cr1 = value;
>>          stm32l4x5_update_params(s);
>> +        stm32l4x5_update_isr(s);
>>          stm32l4x5_update_irq(s);
>>          return;
>>      case A_CR2:
>> @@ -508,12 +531,12 @@ static const MemoryRegionOps stm32l4x5_usart_base_ops = {
>>      .endianness = DEVICE_NATIVE_ENDIAN,
>>      .valid = {
>>          .max_access_size = 4,
>> -        .min_access_size = 4,
>> +        .min_access_size = 2,
>>          .unaligned = false
>>      },
>>      .impl = {
>>          .max_access_size = 4,
>> -        .min_access_size = 4,
>> +        .min_access_size = 2,
>>          .unaligned = false
>>      },
> 
> The effect of these is that a 16-bit write not aligned
> to a (4-aligned) register offset will generate a GUEST_ERROR
> logged message, and a 16-bit write aligned to a 4-aligned
> register offset will write the value zero-extended to 32 bits.
> That seems reasonable to me.
> 

OK sounds good

>>  };
>> diff --git a/tests/qtest/stm32l4x5_usart-test.c b/tests/qtest/stm32l4x5_usart-test.c
>> index 8902518233..ef886074c0 100644
>> --- a/tests/qtest/stm32l4x5_usart-test.c
>> +++ b/tests/qtest/stm32l4x5_usart-test.c
>> @@ -36,6 +36,8 @@ REG32(GTPR, 0x10)
>>  REG32(RTOR, 0x14)
>>  REG32(RQR, 0x18)
>>  REG32(ISR, 0x1C)
>> +    FIELD(ISR, REACK, 22, 1)
>> +    FIELD(ISR, TEACK, 21, 1)
>>      FIELD(ISR, TXE, 7, 1)
>>      FIELD(ISR, RXNE, 5, 1)
>>      FIELD(ISR, ORE, 3, 1)
>> @@ -191,7 +193,7 @@ static void init_uart(QTestState *qts)
>>
>>      /* Enable the transmitter, the receiver and the USART. */
>>      qtest_writel(qts, (USART1_BASE_ADDR + A_CR1),
>> -        R_CR1_UE_MASK | R_CR1_RE_MASK | R_CR1_TE_MASK);
>> +        cr1 | R_CR1_UE_MASK | R_CR1_RE_MASK | R_CR1_TE_MASK);
>>  }
>>
>>  static void test_write_read(void)
>> @@ -202,6 +204,11 @@ static void test_write_read(void)
>>      qtest_writel(qts, USART1_BASE_ADDR + A_TDR, 0xFFFFFFFF);
>>      const uint32_t tdr = qtest_readl(qts, USART1_BASE_ADDR + A_TDR);
>>      g_assert_cmpuint(tdr, ==, 0x000001FF);
>> +
>> +    /* Official STM HAL uses uint16_t for TDR */
>> +    qtest_writew(qts, USART1_BASE_ADDR + A_TDR, 0xFFFF);
>> +    const uint16_t tdr16 = qtest_readw(qts, USART1_BASE_ADDR + A_TDR);
>> +    g_assert_cmpuint(tdr16, ==, 0x000001FF);
>>  }
>>
>>  static void test_receive_char(void)
>> @@ -296,6 +303,35 @@ static void test_send_str(void)
>>      qtest_quit(qts);
>>  }
>>
>> +static void test_ack(void)
>> +{
>> +    uint32_t cr1;
>> +    uint32_t isr;
>> +    QTestState *qts = qtest_init("-M b-l475e-iot01a");
>> +
>> +    init_uart(qts);
>> +
>> +    cr1 = qtest_readl(qts, (USART1_BASE_ADDR + A_CR1));
>> +
>> +    /* Disable the transmitter and receiver. */
>> +    qtest_writel(qts, (USART1_BASE_ADDR + A_CR1),
>> +        cr1 & ~(R_CR1_RE_MASK | R_CR1_TE_MASK));
>> +
>> +    /* Test ISR ACK for transmitter and receiver disabled */
>> +    isr = qtest_readl(qts, (USART1_BASE_ADDR + A_ISR));
>> +    g_assert_false(isr & R_ISR_TEACK_MASK);
>> +    g_assert_false(isr & R_ISR_REACK_MASK);
>> +
>> +    /* Enable the transmitter and receiver. */
>> +    qtest_writel(qts, (USART1_BASE_ADDR + A_CR1),
>> +        cr1 | (R_CR1_RE_MASK | R_CR1_TE_MASK));
>> +
>> +    /* Test ISR ACK for transmitter and receiver disabled */
>> +    isr = qtest_readl(qts, (USART1_BASE_ADDR + A_ISR));
>> +    g_assert_true(isr & R_ISR_TEACK_MASK);
>> +    g_assert_true(isr & R_ISR_REACK_MASK);
> 
> This is missing a
>        qtest_quit(qts);
> at the end of the function. Without it, on non-Linux
> hosts the QEMU process-under-tests will not be properly
> killed. We were also missing one at the end of
> test_write_read() in this file, which we just fixed
> this week in commit d1e8bea9c9c186.
> 

Thanks I will submit a v2 patch with this corrected.

>> +}
>> +
>>  int main(int argc, char **argv)
>>  {
>>      int ret;
>> @@ -308,6 +344,7 @@ int main(int argc, char **argv)
>>      qtest_add_func("stm32l4x5/usart/send_char", test_send_char);
>>      qtest_add_func("stm32l4x5/usart/receive_str", test_receive_str);
>>      qtest_add_func("stm32l4x5/usart/send_str", test_send_str);
>> +    qtest_add_func("stm32l4x5/usart/ack", test_ack);
>>      ret = g_test_run();
>>
>>      return ret;
>> --
>> 2.43.0
> 
> thanks
> -- PMM

regards
-- Jacob Abrams

