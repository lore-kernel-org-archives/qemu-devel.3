Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0318EF9D0D1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCeHk-00057k-5k; Tue, 14 Apr 2026 09:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCeHi-00056D-DX
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:58:34 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCeHg-000274-Kf
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:58:34 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488ad135063so54611955e9.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 06:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776175111; x=1776779911; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YWCK6zHpRg8AYHbG6EJmza2gRwpNL7XYQLEGmhT+z8I=;
 b=E9iGKhkHdUSDepzdZywOKfuacCcFrJBdw6LWWs82oD898Ni+C0cOFoshstfeaT364C
 rAE99kj/4VPJcjMWDg2XNjJB6ZjfqTTJpCgwrRcn5SvuYOG/402NpX0YNaMbvEaD+GPj
 Z3p74PDdWGB6NA/4RdDcQupk0KX5kp7dHlSz9ShoMHw6CvNLyIQFNDYL4LNU79Den+sO
 zTZR2Sfg+PRQlwWk6/iZ64jTHRUFRXX1wLwHC6PDAwmQWg0qzirmusa1+ASJar6T3vzV
 khyr7pLkI1n1Z8o2nsivElh7VBbSm6hm50KEMrZc5FspTip7YdfzahDt4THsZZkymmeV
 Vkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776175111; x=1776779911;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YWCK6zHpRg8AYHbG6EJmza2gRwpNL7XYQLEGmhT+z8I=;
 b=S83Ex4hTjN9U9PuUxZTdpcY3R0SJrQlR//Mx861zKXeLFLck62OWkfuwH71ncnoPKF
 F1kJPDgud47m1JgVVTGYThXlbwJlh4FDYCPbxSjR5r1Xbn77hvjkBaEtfcT2HEs119li
 cAb1cOW3XmT3K6W86E/j500a0NIRrDpSP2dMNbe8VKxyVckqE3mmLG+bOHtXOIqlLLTm
 CGjbLJ4kLy3lMwOstZLezlVtiSwKZ09QCmx0C4Xz6z80vkz4O7zb4dKSCtVxi/IdQQ6A
 H56hYhKIHS3Ms2PcbJnZ2k9xCVXQDLnNOs3dcYu50OQO/CoiQ3cYTP/YBGzAY/dqwARc
 cxFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QpnooFMrUHKRuN+mV60DcltRhq5dGVLpebu11x/57GLNh6o8YrpKAgaQVW/gkg5uhNTZJo3s9Ut1q@nongnu.org
X-Gm-Message-State: AOJu0Yx4P9BQIzaOzgGCbW0kBg1PVFyuFgYcxZD76qOEGa/Z30qC2Hql
 Lhs+NVPG7MDEw4YeVbrzc3tqjDkqUmVmvG8Y/e/a+Zk3rJSW0nEcdMGBTrXVcykQxWQ=
X-Gm-Gg: AeBDieuAIggWiLRw+2Ocg75usqT3zlLY/oOTN107ExNMZ6y8PboF5Vfh4FZduH+56W5
 TioFBfrEf9YhLxRFNT3F5XzbpMNuvQmNEUAya324OiHxdjL3HEUdjtm78CuuQrYOXxhUFACajwp
 daH8esroGLUIK7qXjQV8Ud7grypMFvwe7SG5fFhAWMUo7n4h5I0B3FIWKQ4IYSyr/KXXVFi7Cqu
 WZghtU/tj80jp30J2mw39nmYs2/M1nMQVsxv5Gd1RHTx9u5CL4QiachV27qQvuHb6//Z17sl6fd
 LMXtAz6rqhBhXMBHT/msWXXYoz6d4VeiFYCLJyVVqlb/TLS24zWv2tkGsFBXjBvayHR8CSQqjPv
 iHNFM2BBXG2iYXVQHQcZg3m2zbwiq1lxTRxKubshp8K16dYbOY4DguADfPaxSQI7OPxWBREdsDs
 lcuIZDS/5DcHIu9ncET9xfEi7svS3tJ87L14NbCELJd6qIE+Du3SCdmLreIXobqoCY/g==
X-Received: by 2002:a05:600c:a305:b0:488:ab37:b442 with SMTP id
 5b1f17b1804b1-488d68c7f92mr165637685e9.28.1776175110961; 
 Tue, 14 Apr 2026 06:58:30 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d6881ea1sm124307585e9.33.2026.04.14.06.58.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 06:58:30 -0700 (PDT)
Message-ID: <8c764e42-753f-43ef-8f74-c86e2b785dfd@linaro.org>
Date: Tue, 14 Apr 2026 15:58:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] hw/sd/sdcard: Optimize erase blocks as zero.
Content-Language: en-US
To: Christian Speich <c.speich@avm.de>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
References: <20260204-sdcard-performance-b4-v3-0-dc1cf172ee57@avm.de>
 <20260204-sdcard-performance-b4-v3-6-dc1cf172ee57@avm.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260204-sdcard-performance-b4-v3-6-dc1cf172ee57@avm.de>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> When erasing blocks as zero, we can use optimized block functions to
> achieve this.
> 
> These allow us to request a large rage to be zeroed, possible optimizing
> this operation and freeing disk space for sparsesly stored images.
> 
> This only is possible when erase-blocks-as-zero=true is used and can
> provide a significant performance boost. The case where 0xFF is used
> during erase is as slow as before.
> 
> Signed-off-by: Christian Speich <c.speich@avm.de>
> ---
>   hw/sd/sd.c | 44 ++++++++++++++++++++++++++++++++++----------
>   1 file changed, 34 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 5ddaa08d77b6b7606005fb59f42f107d254d6e5c..6e3afedbf45d59c2c9b48505ed144a788bc76760 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1331,6 +1331,17 @@ exit:
>       trace_sdcard_rpmb_write_block(req, lduw_be_p(&sd->rpmb.result.result));
>   }
>   
> +/* Requires sd->buf to be filled with 0xFF */
> +static void sd_erase_ff(SDState *sd, uint64_t addr, size_t len)
> +{
> +    int erase_len = 1 << HWBLOCK_SHIFT;
> +    uint64_t erase_addr;
> +
> +    for (erase_addr = addr; erase_addr < addr + len; erase_addr += erase_len) {
> +        sd_blk_write(sd, erase_addr, erase_len);
> +    }
> +}
> +
>   static void sd_erase(SDState *sd)
>   {
>       uint64_t erase_start = sd->erase_start;
> @@ -1338,7 +1349,6 @@ static void sd_erase(SDState *sd)
>       bool sdsc = true;
>       uint64_t wpnum;
>       uint64_t erase_addr;
> -    int erase_len = 1 << HWBLOCK_SHIFT;
>   
>       trace_sdcard_erase(sd->erase_start, sd->erase_end);
>       if (sd->erase_start == INVALID_ADDRESS
> @@ -1367,24 +1377,38 @@ static void sd_erase(SDState *sd)
>       sd->erase_end = INVALID_ADDRESS;
>       sd->csd[14] |= 0x40;
>   
> -    if (sd->erase_blocks_as_zero) {
> -        memset(sd->data, 0x0, erase_len);
> -    } else {
> -        memset(sd->data, 0xFF, erase_len);
> +    if (!sd->erase_blocks_as_zero) {
> +        memset(sd->data, 0xFF, 1 << HWBLOCK_SHIFT);
>       }
>   
> -    for (erase_addr = erase_start; erase_addr <= erase_end;
> -         erase_addr += erase_len) {
> -        if (sdsc) {
> -            /* Only SDSC cards support write protect groups */
> +    /* Only SDSC cards support write protect groups */
> +    if (sdsc) {
> +        for (erase_addr = erase_start; erase_addr <= erase_end;
> +             erase_addr = ROUND_UP(erase_addr + 1, WPGROUP_SIZE)) {
> +            uint64_t wp_group_end = ROUND_UP(erase_addr + 1, WPGROUP_SIZE) - 1;
> +            size_t to_erase = MIN(erase_end, wp_group_end) - erase_addr;

s/to_erase/erase_len/

>               wpnum = sd_addr_to_wpnum(erase_addr);
>               assert(wpnum < sd->wp_group_bits);
>               if (test_bit(wpnum, sd->wp_group_bmap)) {
>                   sd->card_status |= WP_ERASE_SKIP;
>                   continue;
>               }
> +
> +            if (sd->erase_blocks_as_zero) {
> +                blk_pwrite_zeroes(sd->blk, erase_addr + sd_part_offset(sd),
> +                                  to_erase, 0);
> +            } else {
> +                sd_erase_ff(sd, erase_addr, to_erase);
> +            }

Could you extract as sd_blk_erase() helper?

> +        }
> +    } else {
> +        if (sd->erase_blocks_as_zero) {
> +            blk_pwrite_zeroes(sd->blk, erase_start + sd_part_offset(sd),
> +                              erase_end - erase_start, 0);
> +        } else {
> +            sd_erase_ff(sd, erase_start, erase_end - erase_start);
>           }
> -        sd_blk_write(sd, erase_addr, erase_len);
>       }
>   }
>   
> 


