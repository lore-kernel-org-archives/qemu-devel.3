Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5B8F9D0D1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCeAt-0002ea-G8; Tue, 14 Apr 2026 09:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCeAr-0002dw-9b
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:51:29 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCeAp-0000pA-9e
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:51:29 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so75524335e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 06:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776174685; x=1776779485; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IvCeu4ois7Ph8/C6iHh4bD0JVMEsUo3k8rspA7idOC8=;
 b=O5dur+OHtscw/ntskYKOpgCohJAvlFZc8bXikmcWsZ8beKJQ+MVjR+/HzJPsiv48Z3
 aVtB4rpb2X5wjBexa2fP2cLzptPT306/iMRRpbETbIU2Mmuy0l9p9acmSvebvco5mHsn
 C9Sw0Y6rvD8LsrGVyReip2Jp0CmC60lqjndMdTh0MIY6nMuFa4zBo7Ma2Rl8TiEVipmk
 bPJy+phtg1EYy7G++SGJPm/m0eO/JfzDLszb9Qx+ZigHMq7ilHZuO1UTpoa5RIhaDKOB
 K0L2Ju2IGp8OVkgZcKO/5Cm/y7iHvQSwJcyyOxlupg+nW6APfIx7Ewv5KkGlPPRHF8QB
 9zhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776174685; x=1776779485;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IvCeu4ois7Ph8/C6iHh4bD0JVMEsUo3k8rspA7idOC8=;
 b=g3Qs0IePZNWgSueccQJ31JyR0KtaE8YCMEjf002RBZLvJcsKSnqVmZonLlCMCG4Rub
 c2uIA1bzJ9P+BGIu83GH48i/vwpVqgt2JMZTU+agrEeI/x9VMneaJce72Bg2EXahYk5Z
 aPAJep21SaWIMwH6i0B0YKBKlwiIYv1kTBdg6sJIWjxB9RgASk3Z884WeMWbVaOZOnkq
 bgQ2JW9wJKaws0d0LJntVzkBmTdhU7yt4XghztsIA+ca9nrc7ini60MKX758eLpR0B+x
 b52BeqHHdvq0r5NUiq3ti9o8AyFb4rIqqbCWexYSD3ffHnvRjVsMpgwXz0t4FmR657nM
 f3eg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fZhyGldZOLGgYWMmGFx9WJfkA+MR8+H9OomlRQWXp1b01WLsZSRSW0mjzhEiX6E6Ioivy6HhmiNcC@nongnu.org
X-Gm-Message-State: AOJu0YzpaWTfpOt+GTv9HdXT16U8B//wCkZT7N8qRh/w61Pkl/ScI+23
 4VzO0tMPcJkWBuU1goj4sLBlQ1rsEyJgmdd3osbj5gdmAhXw8/cAUaL8FYSEW5cvO04=
X-Gm-Gg: AeBDiev6z3bR0oSlGgWQcHF4HNZTh+efgJkc2M3Cx0CZ1Z76A/tFWi0AdABVke3sDdd
 u0e3KGh/hLx28R/a9LUB2ZAl116yfwBP9owGoTwLHi9l6UJ9/9fiMqwMHovF71kg1jCEa3TKLkW
 EbwvpE+rfmcrsOmDc+OZWKVO12STdygcE3YwbYtRp6IZ4x7+ntr0PrGS6gflc8rcwXKPWvsvcOG
 si9PsfPMgGjoPosVH3rlA7A3LvDpTkilRUCvXrtIzzKF6srmK58tA89FWr1YbiQYrZNa2Nt/x76
 wvuneTqeF+hmKnmUjWWJgzlRpkc5ZUVIOpcIL69KYtoZn2MqEbq/e0QuBDP4kvYQYGMSWiGerlV
 KDx7VJpE2ep0KY45Lpu4x3EL+HJxzckfrcjFDGxQMm67+ZHlBW2ZGCqPrtD02uuU6qLBju4KsrX
 f9JF5JnBwL6IZTeQfyYdp3WNV39yJfrfr9hk/EIRtiX0vX93g0FNYQRRoM2sMTI5FUMw==
X-Received: by 2002:a05:600c:64cd:b0:487:21c7:2885 with SMTP id
 5b1f17b1804b1-488d67df57dmr249849215e9.5.1776174685417; 
 Tue, 14 Apr 2026 06:51:25 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ee019e44sm90819475e9.15.2026.04.14.06.51.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 06:51:24 -0700 (PDT)
Message-ID: <4e0536d5-d7a8-45f7-b2b2-bff9fe2d92cc@linaro.org>
Date: Tue, 14 Apr 2026 15:51:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] hw/sd/sdhci: Don't use bounce buffer for ADMA
Content-Language: en-US
To: Christian Speich <c.speich@avm.de>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
References: <20260204-sdcard-performance-b4-v3-0-dc1cf172ee57@avm.de>
 <20260204-sdcard-performance-b4-v3-4-dc1cf172ee57@avm.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260204-sdcard-performance-b4-v3-4-dc1cf172ee57@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 4/2/26 14:22, Christian Speich wrote:
> Currently, ADMA will temporarily store data into a local bounce buffer
> when transferring it. This will produce unneeded copies of the data and
> limit us to the bounce buffer size for each step.
> 
> This patch now maps the requested DMA address and passes this buffer
> directly to sdbus_{read,write}_data. This allows to pass much larger
> buffers down to increase the performance. sdbus_{read,write}_data is
> already able to handle arbitrary length and alignments, so we do not
> need to ensure this.
> 
> Signed-off-by: Christian Speich <c.speich@avm.de>
> ---
>   hw/sd/sdhci.c | 102 +++++++++++++++++++++++++++++++---------------------------
>   1 file changed, 55 insertions(+), 47 deletions(-)
> 
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index c86dfa281f4b0218bf6dda7a38d46abfc9638450..6e07711478cb6ca046a7d371a82e2c682ebbda00 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -775,7 +775,7 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
>   
>   static void sdhci_do_adma(SDHCIState *s)
>   {
> -    unsigned int begin, length;
> +    unsigned int length;
>       const uint16_t block_size = s->blksize & BLOCK_SIZE_MASK;
>       const MemTxAttrs attrs = { .memory = true };
>       ADMADescr dscr = {};
> @@ -817,66 +817,74 @@ static void sdhci_do_adma(SDHCIState *s)
>               if (s->trnmod & SDHC_TRNS_READ) {
>                   s->prnsts |= SDHC_DOING_READ;
>                   while (length) {
> -                    if (s->data_count == 0) {
> -                        sdbus_read_data(&s->sdbus, s->fifo_buffer, block_size);
> -                    }
> -                    begin = s->data_count;
> -                    if ((length + begin) < block_size) {
> -                        s->data_count = length + begin;
> -                        length = 0;
> -                     } else {
> -                        s->data_count = block_size;
> -                        length -= block_size - begin;
> -                    }
> -                    res = dma_memory_write(s->dma_as, dscr.addr,
> -                                           &s->fifo_buffer[begin],
> -                                           s->data_count - begin,
> -                                           attrs);
> -                    if (res != MEMTX_OK) {
> +                    dma_addr_t dma_len = length;
> +
> +                    void *buf = dma_memory_map(s->dma_as, dscr.addr, &dma_len,
> +                                               DMA_DIRECTION_FROM_DEVICE,
> +                                               attrs);

We know the descriptor is a consecutive range. Couldn't we map/unmap
outside of the while() loop? (Ditto write path).

> +
> +                    if (buf == NULL) {
> +                        res = MEMTX_ERROR;
>                           break;
> +                    } else {
> +                        res = MEMTX_OK;
>                       }
> -                    dscr.addr += s->data_count - begin;
> -                    if (s->data_count == block_size) {
> -                        s->data_count = 0;
> -                        if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
> -                            s->blkcnt--;
> -                            if (s->blkcnt == 0) {
> -                                break;
> -                            }
> +
> +                    sdbus_read_data(&s->sdbus, buf, dma_len);
> +                    length -= dma_len;
> +                    dscr.addr += dma_len;
> +
> +                    dma_memory_unmap(s->dma_as, buf, dma_len,
> +                                     DMA_DIRECTION_FROM_DEVICE, dma_len);
> +
> +                    if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
> +                        size_t transfered = s->data_count + dma_len;
> +
> +                        s->blkcnt -= transfered / block_size;
> +                        s->data_count = transfered % block_size;
> +
> +                        if (s->blkcnt == 0) {
> +                            s->data_count = 0;
> +                            break;
>                           }
>                       }
>                   }
>               } else {


