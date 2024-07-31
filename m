Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659FDC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 16:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZCWW-0005Ec-84; Wed, 31 Jul 2024 12:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZCWU-0005Ax-41
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 12:49:58 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZCWQ-0001lM-Ol
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 12:49:57 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42812945633so39578305e9.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722444592; x=1723049392; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8kYomY1MwcqtgqowEJB4dI0J8aYR7xvl+SLSgtqkg30=;
 b=D+Xw5xspEUNAoHmg+D9RemJ86f9ex2NUsH68jIBOKxEbBCGqa+M429BGH/tCJWjE2U
 WHKf/ZDrRWCHQkUPXaZBCU8DogA0JenSPcnAc5fogl08lXLONCSDmR7V0HNd2Ch5jm1G
 68H0cVzv4E6zhmtmasKDEnxcPE5o0aboERsMjn5OXvPxRAbb9xUL5wuLC/XPH4Ok4TVs
 hH386tpLAXQ1ZLsbfuCCZQwA6xIbXz+XlxPHfZyaNKoDQD04EOq+dJT6XDqvHNcRhsLg
 RvgNoOlUyCJAaZo8MTNMK95Q05wkREofCHMfdLPWaYUx6rMV51j+k7AaDpyd0bj77KF/
 Kk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722444592; x=1723049392;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8kYomY1MwcqtgqowEJB4dI0J8aYR7xvl+SLSgtqkg30=;
 b=uJ/XiL2MZiMwtCka1p4eRb33SusAVo42a6oMULlFGw8quiFrBm11kyN4VLhPv1PZlc
 TA0aJDkWkpuTaCz02LN9S78HfsGSIxxEotiFy3bXBQBAkgcMThhJyT/GfpR4A8rSlCSs
 AW4jgOLgnTJbaj+AQL84pStDqhgUYbBQfEmK7wwxtVFzc2NUGaIusgQTPeKbVqQOBmQX
 VU2ExfW7n5RFilAs5VIxVPxfNPktI9Dr5O9gdudKeIOremdpqlswO0MsKRadrWhbAmxl
 nRghXVjy35iPO2wvs3SS7K8B1g/e3Ycf0MwIhTolAWo6/+dBgqSlrLFmBcBmYJif0jQE
 m4sQ==
X-Gm-Message-State: AOJu0Yx4RvYclO8PwTZEjW2bcIJ3v4yvKqIMU7b4TLjvQ0IVWN3ycP3u
 +7/B6rBEwfcipscTK5qchSbNsWdBdlef1TxHKbPz4DgRMP6r9lHUmIhLYF1IWccbFPE0EEHAL2+
 /
X-Google-Smtp-Source: AGHT+IFhXLvwnwzvCssJf5WOxCBLnNOnTuKh+fK43eXsymX0hjiOs/Kg978ZcvQE3+1ncx0CQPPo6w==
X-Received: by 2002:a05:600c:4751:b0:426:6667:5c42 with SMTP id
 5b1f17b1804b1-428a99e02eemr265625e9.4.1722444591801; 
 Wed, 31 Jul 2024 09:49:51 -0700 (PDT)
Received: from [192.168.45.175] (226.red-88-28-12.dynamicip.rima-tde.net.
 [88.28.12.226]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36858197sm17868866f8f.68.2024.07.31.09.49.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 09:49:51 -0700 (PDT)
Message-ID: <91b3632c-4557-4e78-87aa-30f333c61c0c@linaro.org>
Date: Wed, 31 Jul 2024 18:49:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 5/5] hw/sd/sdhci: Check ADMA descriptors can be
 accessed
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Zheyu Ma <zheyuma97@gmail.com>,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
References: <20240730092138.32443-1-philmd@linaro.org>
 <20240730092138.32443-6-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730092138.32443-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30/7/24 11:21, Philippe Mathieu-Daudé wrote:
> Since malicious guest can write invalid addresses to
> the ADMASYSADDR register, we need to check whether the
> descriptor could be correctly filled or not.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d7dfca0807 ("hw/sdhci: introduce standard SD host controller")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/sd/sdhci.c      | 86 ++++++++++++++++++++++++++--------------------
>   hw/sd/trace-events |  2 +-
>   2 files changed, 49 insertions(+), 39 deletions(-)
> 
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 66b9364e9e..eb0476b9aa 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -698,53 +698,62 @@ static void trace_adma_description(const char *type, const ADMADescr *dscr)
>       trace_sdhci_adma_desc(type, dscr->addr, dscr->length, dscr->attr, dscr->incr);
>   }
>   
> -static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
> +static MemTxResult get_adma_description(SDHCIState *s, ADMADescr *dscr)
>   {
>       uint32_t adma1 = 0;
>       uint64_t adma2 = 0;
>       hwaddr entry_addr = (hwaddr)s->admasysaddr;
> +    MemTxResult res;
> +
>       switch (SDHC_DMA_TYPE(s->hostctl1)) {
>       case SDHC_CTRL_ADMA2_32:
> -        dma_memory_read(s->dma_as, entry_addr, &adma2, sizeof(adma2),
> -                        MEMTXATTRS_UNSPECIFIED);
> -        adma2 = le64_to_cpu(adma2);
> -        /* The spec does not specify endianness of descriptor table.
> -         * We currently assume that it is LE.
> -         */
> -        dscr->addr = (hwaddr)extract64(adma2, 32, 32) & ~0x3ull;
> -        dscr->length = (uint16_t)extract64(adma2, 16, 16);
> -        dscr->attr = (uint8_t)extract64(adma2, 0, 7);
> -        dscr->incr = 8;
> -        trace_adma_description("ADMA2_32", dscr);
> +        res = dma_memory_read(s->dma_as, entry_addr, &adma2, sizeof(adma2),
> +                              MEMTXATTRS_UNSPECIFIED);
> +        if (res == MEMTX_OK) {
> +            adma2 = le64_to_cpu(adma2);
> +            /* The spec does not specify endianness of descriptor table.
> +             * We currently assume that it is LE.
> +             */
> +            dscr->addr = (hwaddr)extract64(adma2, 32, 32) & ~0x3ull;
> +            dscr->length = (uint16_t)extract64(adma2, 16, 16);
> +            dscr->attr = (uint8_t)extract64(adma2, 0, 7);
> +            dscr->incr = 8;
> +            trace_adma_description("ADMA2_32", dscr);
> +        }
>           break;
>       case SDHC_CTRL_ADMA1_32:
> -        dma_memory_read(s->dma_as, entry_addr, &adma1, sizeof(adma1),
> -                        MEMTXATTRS_UNSPECIFIED);
> -        adma1 = le32_to_cpu(adma1);
> -        dscr->addr = (hwaddr)(adma1 & 0xFFFFF000);
> -        dscr->attr = (uint8_t)extract32(adma1, 0, 7);
> -        dscr->incr = 4;
> -        if ((dscr->attr & SDHC_ADMA_ATTR_ACT_MASK) == SDHC_ADMA_ATTR_SET_LEN) {
> -            dscr->length = (uint16_t)extract32(adma1, 12, 16);
> -        } else {
> -            dscr->length = 4 * KiB;
> +        res = dma_memory_read(s->dma_as, entry_addr, &adma1, sizeof(adma1),
> +                              MEMTXATTRS_UNSPECIFIED);
> +        if (res == MEMTX_OK) {
> +            adma1 = le32_to_cpu(adma1);
> +            dscr->addr = (hwaddr)(adma1 & ~0xfff);
> +            dscr->attr = (uint8_t)extract32(adma1, 0, 7);
> +            dscr->incr = 4;
> +            if ((dscr->attr & SDHC_ADMA_ATTR_ACT_MASK) == SDHC_ADMA_ATTR_SET_LEN) {
> +                dscr->length = (uint16_t)extract32(adma1, 12, 16);
> +            } else {
> +                dscr->length = 4 * KiB;
> +            }
> +            trace_adma_description("ADMA1_32", dscr);
>           }
> -        trace_adma_description("ADMA1_32", dscr);
>           break;
>       case SDHC_CTRL_ADMA2_64:
> -        dma_memory_read(s->dma_as, entry_addr, &dscr->attr, 1,
> -                        MEMTXATTRS_UNSPECIFIED);
> -        dma_memory_read(s->dma_as, entry_addr + 2, &dscr->length, 2,
> -                        MEMTXATTRS_UNSPECIFIED);
> -        dscr->length = le16_to_cpu(dscr->length);
> -        dma_memory_read(s->dma_as, entry_addr + 4, &dscr->addr, 8,
> -                        MEMTXATTRS_UNSPECIFIED);
> -        dscr->addr = le64_to_cpu(dscr->addr);
> -        dscr->attr &= (uint8_t) ~0xC0;
> -        dscr->incr = 12;
> -        trace_adma_description("ADMA2_64", dscr);
> +        res = dma_memory_read(s->dma_as, entry_addr, &dscr->attr, 1,
> +                              MEMTXATTRS_UNSPECIFIED);
> +        res |= dma_memory_read(s->dma_as, entry_addr + 2, &dscr->length, 2,
> +                               MEMTXATTRS_UNSPECIFIED);
> +        res |= dma_memory_read(s->dma_as, entry_addr + 4, &dscr->addr, 8,
> +                               MEMTXATTRS_UNSPECIFIED);
> +        if (res == MEMTX_OK) {
> +            dscr->length = le16_to_cpu(dscr->length);
> +            dscr->addr = le64_to_cpu(dscr->addr);
> +            dscr->attr &= (uint8_t) ~0xc0;
> +            dscr->incr = 12;
> +            trace_adma_description("ADMA2_64", dscr);
> +        }
>           break;
>       }
> +    return res;
>   }
>   
>   /* Advanced DMA data transfer */
> @@ -755,7 +764,6 @@ static void sdhci_do_adma(SDHCIState *s)
>       const uint16_t block_size = s->blksize & BLOCK_SIZE_MASK;
>       const MemTxAttrs attrs = { .memory = true };
>       ADMADescr dscr = {};

'dscr' is only zero-initialized here, ...

> -    MemTxResult res;
>       int i;
>   
>       if (s->trnmod & SDHC_TRNS_BLK_CNT_EN && !s->blkcnt) {
> @@ -765,12 +773,14 @@ static void sdhci_do_adma(SDHCIState *s)
>       }
>   
>       for (i = 0; i < SDHC_ADMA_DESCS_PER_DELAY; ++i) {
> +        MemTxResult res;
> +
>           s->admaerr &= ~SDHC_ADMAERR_LENGTH_MISMATCH;
>   
> -        get_adma_description(s, &dscr);

... then filled in this loop being reused without clearing ...

> -        trace_sdhci_adma_loop(dscr.addr, dscr.length, dscr.attr);
> +        res = get_adma_description(s, &dscr);
> +        trace_sdhci_adma_loop(dscr.addr, dscr.length, dscr.attr, res);
>   
> -        if ((dscr.attr & SDHC_ADMA_ATTR_VALID) == 0) {
> +        if (res != MEMTX_OK || (dscr.attr & SDHC_ADMA_ATTR_VALID) == 0) {

... checking error condition here.

By reducing its scope, it becomes zero-initialized each time and we can
safely check the ATTR_VALID bit, with no need for duplicated information
with MEMTX, thus reducing this patch size.

>               /* Indicate that error occurred in ST_FDS state */
>               s->admaerr &= ~SDHC_ADMAERR_STATE_MASK;
>               s->admaerr |= SDHC_ADMAERR_STATE_ST_FDS;

ST_FDS is indeed the correct error to report, since s->admasysaddr
isn't increased and points to the faulty address.

