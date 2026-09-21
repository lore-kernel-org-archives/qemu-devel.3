Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6542C982DE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 04:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Vji-0005WA-Gn; Mon, 21 Sep 2026 00:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jwhitakera@gmail.com>)
 id 1x8Vjb-0005Vs-1r
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 00:34:31 -0400
Received: from mail-pz2-x0d.google.com ([2607:f8b0:4864:3b::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jwhitakera@gmail.com>)
 id 1x8VjX-0004wp-61
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 00:34:30 -0400
Received: by mail-pz2-x0d.google.com with SMTP id
 41be03b00d2f7-cc1cea4bfb6so1051470a12.3
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2026 21:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789965264; x=1790570064; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wYQf/S8KudPK3D/LKHQz0Xbaim4/O64jzEmy9xCnMtg=;
 b=b6kN/bNUdvDMS7uITWGkpMNfNxY4+lzDc0z2PxcTs2CACWj5X/CANBbjakd7nYBdbm
 hZ0GmNkvq1knoltmyZYsxgpijx4nLr/R8hXHsUABEdkJNf//R7yN/0OjAlotfstg52ud
 /+qpYa2/Av5eyKPy/QowlcDE/kcikSJDqaLUfyRoLzM3xNi62Is+sfbcS3qP1hZMAvz3
 r969We/Y8g5xJvT3GLkCQe4X+DebkEPRmujOcoRLvnEYrGhzfVi41f6suQaBSFayqov+
 0ZkijQPiaomBJ8BqimpluSWdy0Fqxyz0E/3BJSawle2NBgdxS6ByrA1jtsBHExyYL+5k
 3sYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789965264; x=1790570064;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wYQf/S8KudPK3D/LKHQz0Xbaim4/O64jzEmy9xCnMtg=;
 b=Av1u10Y4Gy2XC74J92nrblxXJxBdrjBGSZgJ4jctU3KY55GHyfibVxb3nx29waOaCc
 JRS1IRB8PS5o/tpKMrh9f1M5yEH8Y/6xv7qIyym1HqHtCYYVOz/mLupKzpQwfOYeUkil
 ksqtexPGx5iZH/8Tq6cwaQGcjQyLEU6cjKEIiFn9m4vcMv4lcYlaQwSqZgZ+lGC5OpLK
 /HQLQpq/i/WwWR/BsOZ24NmtGlf4WhOEO3AaxqIDQ9AtsMboh1XWjelyomSvcL2jGPPJ
 hxbXuxeStLQOmvGjeeZUXRague/QbTVWi25A1k8c2uVO2rGolm4GdtLrnn4GhbJDWEst
 bZMg==
X-Gm-Message-State: AFuF++lmsifGAsup059wbhe+qht/LU9l8aq5cPqiROIrvNbWCar96kpf
 LJqe2vcLA8s8qCbOaN3UUTwsqnc3cdDfs3OHuKrJ7tWCgrMf/sEN17tE
X-Gm-Gg: AYBFou3BawmVp/Lc7HDvwPin0ukOQT06RQ5drDwLxj8zg93M/eH+KDAnZtw3JacYRRo
 nVcuytLkwEPD5pZ9V8wb6RZz63eVtVihzpWKMdUJNcksL2Gfre1k9UeXhY5IkN7n4vgMyklsodn
 CWFLhpYf90sZ1KILjE1lbey5wdwuMkmeAU3XCEKsclhz2YZR9onfXPp4ZndFMIpIApXG19FN6J+
 8ZlT97BSlxSppW3LD7aykXkd5weIdp2LHWzrrZxyBLyAYusA43J/lA9bUBQgfrd2cEvUFD28ygF
 F8FXshzrM4bS7Ht2eCVHTK2wl7Yq/53cn3buepPc1wasIHOhrlrz1ujsObnqmLh/SY0ziewEd6y
 +Rb6dHphWio9luImuIW9KMNE4X6e7EETfLBXG4vT64Z5CuZ50t8qqvrcJgD8FWF6ZXBDf+h6LYO
 JATe0LdgW85qfcl5kklbSwShl+wSKK8lM6MYIaXu9VVmeDmhUVk3DYVRFcJNndKONGcxQ55NomM
 jGQHbRBjfZi6f+QGCL+1YZ4nTXo3SU16hToqVfnE9dU
X-Received: by 2002:a05:6a20:e212:b0:3dd:a196:30a6 with SMTP id
 adf61e73a8af0-3dda19633dcmr9023106637.86.1789965263691; 
 Sun, 20 Sep 2026 21:34:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:88b2:a50:a9ca:268c:17b3:ded?
 ([2600:1700:88b2:a50:a9ca:268c:17b3:ded])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144da432647sm25670738c88.5.2026.09.20.21.34.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2026 21:34:23 -0700 (PDT)
Message-ID: <e448ac6e-9071-43ba-ba43-2f4d8a7584aa@gmail.com>
Date: Sun, 20 Sep 2026 21:34:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char/stm32l4x5_usart.c: Support writes smaller than
 32-bit
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jacob Whitaker Abrams <satur9nine@gmail.com>
References: <20260817011008.652105-1-satur9nine@gmail.com>
 <CAFEAcA_sQiXSEnJu-WDq-bZBpxRPt5dqJb4t4bCum+xvPKp21g@mail.gmail.com>
Content-Language: en-US
From: Jacob Whitaker Abrams <jwhitakera@gmail.com>
In-Reply-To: <CAFEAcA_sQiXSEnJu-WDq-bZBpxRPt5dqJb4t4bCum+xvPKp21g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::d;
 envelope-from=jwhitakera@gmail.com; helo=mail-pz2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 9/15/26 06:58, Peter Maydell wrote:
> On Mon, 17 Aug 2026 at 06:03, Jacob Whitaker Abrams
> <jwhitakera@gmail.com> wrote:
>> Official STM32CubeL4 drivers use and require support for 16-bit writes to
>> UART registers for proper function.
> This is a breach of the datasheet (assuming I have the right one:
> RM0351 "STM32L47xxx, STM32L48xxx, STM32L49xxx and STM32L4Axxx
> advanced Arm®-based 32-bit MCUs"), which is pretty clear:
> "The peripheral registers have to be accessed by words (32 bits)".
>
> Still, if the official drivers are doing it then presumably the
> hardware actually does allow smaller accesses.
>
> Do the drivers do small accesses to the top parts of registers,
> or do they always use 4-aligned addresses but just sometimes
> do smaller width accesses ? If only the latter is needed, we
> can make the code simpler (reads return the full register value
> and the QEMU core code chops off the unneeded high parts, writes
> are "write as if zero-extended").

Yes it is a documentation error, we discussed this in 2024, Nicolas Fillon at STM wrote back to me "I see we are making 16 bit access read and write to these 16 bit registers in our library for both HAL and LL so this should be a documentation issue."

It appears specifically to affect the USART peripheral inside the chip, here is the official C struct they use in their source code, it contains uint16_t sized registers resulting in 16-bit memory assembly operations:

typedef struct
{
  __IO uint32_t CR1;         /*!< USART Control register 1,                 Address offset: 0x00 */
  __IO uint32_t CR2;         /*!< USART Control register 2,                 Address offset: 0x04 */
  __IO uint32_t CR3;         /*!< USART Control register 3,                 Address offset: 0x08 */
  __IO uint32_t BRR;         /*!< USART Baud rate register,                 Address offset: 0x0C */
  __IO uint16_t GTPR;        /*!< USART Guard time and prescaler register,  Address offset: 0x10 */
  uint16_t  RESERVED2;       /*!< Reserved, 0x12                                                 */
  __IO uint32_t RTOR;        /*!< USART Receiver Time Out register,         Address offset: 0x14 */
  __IO uint16_t RQR;         /*!< USART Request register,                   Address offset: 0x18 */
  uint16_t  RESERVED3;       /*!< Reserved, 0x1A                                                 */
  __IO uint32_t ISR;         /*!< USART Interrupt and status register,      Address offset: 0x1C */
  __IO uint32_t ICR;         /*!< USART Interrupt flag Clear register,      Address offset: 0x20 */
  __IO uint16_t RDR;         /*!< USART Receive Data register,              Address offset: 0x24 */
  uint16_t  RESERVED4;       /*!< Reserved, 0x26                                                 */
  __IO uint16_t TDR;         /*!< USART Transmit Data register,             Address offset: 0x28 */
  uint16_t  RESERVED5;       /*!< Reserved, 0x2A                                                 */
  __IO uint32_t PRESC;       /*!< USART Prescaler register,                 Address offset: 0x2C */
} USART_TypeDef;

>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2540
>> Signed-off-by: Jacob Whitaker Abrams <satur9nine@gmail.com>
>> ---
>>  hw/char/stm32l4x5_usart.c          | 93 +++++++++++++++++++++++-------
>>  tests/qtest/stm32l4x5_usart-test.c | 50 +++++++++++++++-
>>  2 files changed, 120 insertions(+), 23 deletions(-)
>>
>> diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
>> index dd1b099195..88c4a3b5a7 100644
>> --- a/hw/char/stm32l4x5_usart.c
>> +++ b/hw/char/stm32l4x5_usart.c
>> @@ -154,8 +154,15 @@ REG32(RDR, 0x24)
>>  REG32(TDR, 0x28)
>>      FIELD(TDR, TDR, 0, 9)
>>
>> +#define ISR_RESET_VALUE (0x020000C0)
>> +
>>  static void stm32l4x5_update_isr(Stm32l4x5UsartBaseState *s)
>>  {
>> +    if (!(s->cr1 & R_CR1_UE_MASK)) {
>> +        s->isr = ISR_RESET_VALUE;
>> +        return;
>> +    }
> This seems to be an unrelated change to adding 16-bit access handling ?

Fair point, I will remove that from the upcoming v2 patch.

>> +
>>      if (s->cr1 & R_CR1_TE_MASK) {
>>          s->isr |= R_ISR_TEACK_MASK;
>>      } else {
>> @@ -404,9 +411,11 @@ static uint64_t stm32l4x5_usart_base_read(void *opaque, hwaddr addr,
>>                                       unsigned int size)
>>  {
>>      Stm32l4x5UsartBaseState *s = opaque;
>> +    hwaddr base = addr & ~0x3ULL;
>> +    unsigned int offset = addr & 0x3;
>>      uint64_t retvalue = 0;
>>
>> -    switch (addr) {
>> +    switch (base) {
>>      case A_CR1:
>>          retvalue = s->cr1;
>>          break;
>> @@ -451,6 +460,13 @@ static uint64_t stm32l4x5_usart_base_read(void *opaque, hwaddr addr,
>>          break;
>>      }
>>
>> +    /* Adjust for partial access */
>> +    if (size == 1) {
>> +        retvalue = (retvalue >> (offset * 8)) & 0xFF;
>> +    } else if (size == 2) {
>> +        retvalue = (retvalue >> (offset * 8)) & 0xFFFF;
>> +    }
> You can avoid the if():
>
>    retvalue = extract32(retvalue, offset * 8, size * 8);
OK I will do so.
>> +
>>      trace_stm32l4x5_usart_read(addr, retvalue);
>>
>>      return retvalue;
>> @@ -460,55 +476,88 @@ static void stm32l4x5_usart_base_write(void *opaque, hwaddr addr,
>>                                    uint64_t val64, unsigned int size)
>>  {
>>      Stm32l4x5UsartBaseState *s = opaque;
>> -    const uint32_t value = val64;
>> +    hwaddr base = addr & ~0x3ULL;
>> +    unsigned int offset = addr & 0x3;
>> +    uint32_t value = (uint32_t)val64;
>> +
>> +    /* Build mask for partial access */
>> +    uint32_t mask;
>> +    if (size == 4) {
>> +        mask = 0xFFFFFFFF;
>> +    } else if (size == 2) {
>> +        mask = 0xFFFF << (offset * 8);
>> +    } else if (size == 1) {
>> +        mask = 0xFF << (offset * 8);
>> +    } else {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Unsupported access size %u\n", __func__, size);
>> +        return;
>> +    }
>> +    value = (value << (offset * 8)) & mask;
>>
>>      trace_stm32l4x5_usart_write(addr, value);
>>
>> -    switch (addr) {
>> -    case A_CR1:
>> -        s->cr1 = value;
>> +    switch (base) {
>> +    case A_CR1: {
>> +        uint32_t old = s->cr1;
>> +        s->cr1 = (old & ~mask) | value;
> If you write these as
>   s->cr1 = deposit32(s->cr1, value, offset * 8, size * 8);
>
> then you don't need to calculate a mask or shift-and-mask
> the value by hand.

OK I will.

Regards,

Jacob Abrams


