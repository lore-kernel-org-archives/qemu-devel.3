Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EF8C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 16:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBcs7-0003Wp-AY; Mon, 27 May 2024 12:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBcs3-0003Vk-Ao
 for qemu-devel@nongnu.org; Mon, 27 May 2024 12:06:47 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBcs1-00011k-IF
 for qemu-devel@nongnu.org; Mon, 27 May 2024 12:06:47 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-357d533b744so1787045f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 09:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716826004; x=1717430804; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C6lwrpKu21HlYZ5GMXTKDszlEcE4hsmHXDZWcHi8bvI=;
 b=PFsAopfUuK4mYaERJMHYAbRJP95qCalWhmY8u/JOENUfGcZve+sM00u88PXhP05utD
 kYV842dnmRpK5Jb7+l8JIruBUFP/TbNJdbA4EefUPsRtGsh0I0U23IghZwUhQc0FPEVm
 RFsK04DaaVIVdaqAQjvWmjulBhkjJCYKzW9PSKDhe1b6bOPoSpRbRPcvbM5Sb+XUp5si
 PYuXsdclevdF+RrCAzttByvPGrsF3Icw5rqTiBPo+xPkk2Zw8fyZmrvOlVczuKHYKeFF
 mHevlyjgItS0bXU6TV+usCtfJExIEcyQzVS3I5p08QI7uHlh1MJVf+KADsAm/8im4000
 Qehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716826004; x=1717430804;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C6lwrpKu21HlYZ5GMXTKDszlEcE4hsmHXDZWcHi8bvI=;
 b=Kk+ORCNlGrFKKnjSi3is6Rbu8c6/VQb0X5JZ6Pgi/uEa/WeMu52xW5Gso+grg9H3mm
 0nz3fB6Rngikwd29HS9DLMyKO2ErtmrvQ0wXVbQppMmRNE2Vpkb+qrv6TISv3lk0+isZ
 I7Kny9f9zrK3KVO2XJ23CWYdegR77+rOs4espmkCtbW8SxLklyPx0htUfb1ndUpAEdGX
 lP6/+ZMMJC31wjpvtKFYLU0RLwDHNU/XlDt3/JIq/hXvYlNDpLZh7EGkmRh/i1x18s2i
 ubES4f1i5HNRk3YgPGs+a5u8BYQ5SIvmiQu5mgC+Qcec7TloKENkaDegGuJ3UpZH6BuW
 NXiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsash7xjpOBxEb58qUyt/G26AAXHABJ7WrT2DaHR91WmsD4OwmRJwrrE5zpQNOl3+NVsU0IENd+szzuBl0ZQtxrCYG3nQ=
X-Gm-Message-State: AOJu0Yw4NrYPn9Lrcf3Us/Fk+hzlFnsS25CUvi6FXukvtiF2Ee+IUGWo
 Q1AKryZwexRI0cBHh6J/V+bIkmXXM+iKy5fcWfkz7Q24G02hJkqqT75gm3+MZ+6bWtZQK3m/5B6
 X
X-Google-Smtp-Source: AGHT+IFNHs+BD4ooQKOJwYkAQD2URSmLbJHHuMazXmPyZuZSKrJrHLspyCxiXaf93qumc4UVqnzlBg==
X-Received: by 2002:a05:6000:1541:b0:359:733c:c8d6 with SMTP id
 ffacd0b85a97d-359733cc9fbmr2436007f8f.67.1716826003749; 
 Mon, 27 May 2024 09:06:43 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557dcf06dcsm9461164f8f.106.2024.05.27.09.06.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 09:06:43 -0700 (PDT)
Message-ID: <2d64463d-0694-4d6e-a8c4-5bfad2cf801d@linaro.org>
Date: Mon, 27 May 2024 18:06:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/16] aspeed/smc: support 64 bits dma dram address
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240527080231.1576609-1-jamin_lin@aspeedtech.com>
 <20240527080231.1576609-9-jamin_lin@aspeedtech.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240527080231.1576609-9-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Jamin,

On 27/5/24 10:02, Jamin Lin wrote:
> AST2700 support the maximum dram size is 8GiB
> and has a "DMA DRAM Side Address High Part(0x7C)"
> register to support 64 bits dma dram address.
> Add helper routines functions to compute the dma dram
> address, new features and update trace-event
> to support 64 bits dram address.
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/ssi/aspeed_smc.c         | 52 +++++++++++++++++++++++++++++++------
>   hw/ssi/trace-events         |  2 +-
>   include/hw/ssi/aspeed_smc.h |  1 +
>   3 files changed, 46 insertions(+), 9 deletions(-)


> +static uint64_t aspeed_smc_dma_dram_addr(AspeedSMCState *s)
> +{
> +    return s->regs[R_DMA_DRAM_ADDR] |
> +        ((uint64_t) s->regs[R_DMA_DRAM_ADDR_HIGH] << 32);
> +}
> +
>   static uint32_t aspeed_smc_dma_len(AspeedSMCState *s)
>   {
>       AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(s);
> @@ -903,24 +921,34 @@ static void aspeed_smc_dma_checksum(AspeedSMCState *s)
>   
>   static void aspeed_smc_dma_rw(AspeedSMCState *s)
>   {
> +    AspeedSMCClass *asc = ASPEED_SMC_GET_CLASS(s);
> +    uint64_t dma_dram_offset;
> +    uint64_t dma_dram_addr;
>       MemTxResult result;
>       uint32_t dma_len;
>       uint32_t data;
>   
>       dma_len = aspeed_smc_dma_len(s);
> +    dma_dram_addr = aspeed_smc_dma_dram_addr(s);
> +
> +    if (aspeed_smc_has_dma64(asc)) {
> +        dma_dram_offset = dma_dram_addr - s->dram_base;
> +    } else {
> +        dma_dram_offset = dma_dram_addr;

Here s->dram_base is 0x0. Do we really need to check
aspeed_smc_has_dma64?

> +    }

Maybe simplify improving aspeed_smc_dma_dram_addr() as:

   static uint64_t aspeed_smc_dma_dram_addr(AspeedSMCState *s)
   {
       return (s->regs[R_DMA_DRAM_ADDR]
               | ((uint64_t) s->regs[R_DMA_DRAM_ADDR_HIGH] << 32))
               - s->dram_base;
   }

Then no need for dma_dram_offset, dma_dram_addr is enough.

>   
>       trace_aspeed_smc_dma_rw(s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE ?
>                               "write" : "read",
>                               s->regs[R_DMA_FLASH_ADDR],
> -                            s->regs[R_DMA_DRAM_ADDR],
> +                            dma_dram_offset,
>                               dma_len);
>       while (dma_len) {
>           if (s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE) {
> -            data = address_space_ldl_le(&s->dram_as, s->regs[R_DMA_DRAM_ADDR],
> +            data = address_space_ldl_le(&s->dram_as, dma_dram_offset,
>                                           MEMTXATTRS_UNSPECIFIED, &result);
>               if (result != MEMTX_OK) {
> -                aspeed_smc_error("DRAM read failed @%08x",
> -                                 s->regs[R_DMA_DRAM_ADDR]);
> +                aspeed_smc_error("DRAM read failed @%" PRIx64,
> +                                 dma_dram_offset);
>                   return;
>               }
>   
> @@ -940,11 +968,11 @@ static void aspeed_smc_dma_rw(AspeedSMCState *s)
>                   return;
>               }
>   
> -            address_space_stl_le(&s->dram_as, s->regs[R_DMA_DRAM_ADDR],
> +            address_space_stl_le(&s->dram_as, dma_dram_offset,
>                                    data, MEMTXATTRS_UNSPECIFIED, &result);
>               if (result != MEMTX_OK) {
> -                aspeed_smc_error("DRAM write failed @%08x",
> -                                 s->regs[R_DMA_DRAM_ADDR]);
> +                aspeed_smc_error("DRAM write failed @%" PRIx64,
> +                                 dma_dram_offset);
>                   return;
>               }
>           }
> @@ -953,8 +981,12 @@ static void aspeed_smc_dma_rw(AspeedSMCState *s)
>            * When the DMA is on-going, the DMA registers are updated
>            * with the current working addresses and length.
>            */
> +        dma_dram_offset += 4;
> +        dma_dram_addr += 4;
> +
> +        s->regs[R_DMA_DRAM_ADDR_HIGH] = dma_dram_addr >> 32;
> +        s->regs[R_DMA_DRAM_ADDR] = dma_dram_addr & 0xffffffff;
>           s->regs[R_DMA_FLASH_ADDR] += 4;
> -        s->regs[R_DMA_DRAM_ADDR] += 4;
>           dma_len -= 4;
>           s->regs[R_DMA_LEN] = dma_len;
>           s->regs[R_DMA_CHECKSUM] += data;
> @@ -1107,6 +1139,9 @@ static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
>       } else if (aspeed_smc_has_dma(asc) && addr == R_DMA_LEN &&
>                  aspeed_smc_dma_granted(s)) {
>           s->regs[addr] = DMA_LENGTH(value);
> +    } else if (aspeed_smc_has_dma(asc) && aspeed_smc_has_dma64(asc) &&
> +               addr == R_DMA_DRAM_ADDR_HIGH) {
> +        s->regs[addr] = DMA_DRAM_ADDR_HIGH(value);
>       } else {
>           qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\n",
>                         __func__, addr);
> @@ -1239,6 +1274,7 @@ static const VMStateDescription vmstate_aspeed_smc = {
>   
>   static Property aspeed_smc_properties[] = {
>       DEFINE_PROP_BOOL("inject-failure", AspeedSMCState, inject_failure, false),
> +    DEFINE_PROP_UINT64("dram-base", AspeedSMCState, dram_base, 0),
>       DEFINE_PROP_LINK("dram", AspeedSMCState, dram_mr,
>                        TYPE_MEMORY_REGION, MemoryRegion *),
>       DEFINE_PROP_END_OF_LIST(),


