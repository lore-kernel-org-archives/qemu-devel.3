Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B124FCA178
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 19:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzgIK-0002Q7-MB; Mon, 09 Mar 2026 15:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzgIG-0002Ps-Ec
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 15:29:32 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzgID-0004cg-2p
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 15:29:32 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-439afc58ac7so9362447f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 12:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773084566; x=1773689366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ud9l/59tZJ6PrQzHXsKC0rWDN9j64M2GrQtbFz0nQ74=;
 b=kg5F8DXz/sdZG9oaUEYk0c3Gv0CfymfsWZjFGt5NoHBsm3US2pJTIsRx1mUpOG7+rN
 TZQhPPmqo0OoouoiFNjnA9rK/ia4295toEFappa/PKfEiEkdB3uDxih4etDzObMlsG0a
 N8mFF0DTfEiafaTZlz3tofOh89iFbgNzyj030TYF+SM0LFAAaQoBhbVIDbENwjL8ac0g
 v78pBc4OCltnXwDx46iJM1iw7uosra81zGsW0R6w6/TR0cCIy6BWCZ1DcEcKLfHdFU56
 ypJ32cCRL/2bRYhxyP8D7zxI3XyCYgi/o6m5ThTY2o6oTa5LDxfGdpuBJRhuWXXUiCn2
 7ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773084566; x=1773689366;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ud9l/59tZJ6PrQzHXsKC0rWDN9j64M2GrQtbFz0nQ74=;
 b=b+0bPwyszeFKpB5tQhMx2Jro+bl6BXiaEdCvefr4KOX6IGWf+k2nM3Q8zcL/07FlaS
 VnZUSlxmA84Jez79zql81FFtI1YL9CvEJXpfYetnA187J8rt7OLUHq9j67pEqfvFSR8T
 9mRiUSyKZTLkghEe5dPT7GJNRVJd8FmJMNycUBN3kTvf23UyXOqnd9tr0b40ReGQMNYe
 nkbQtgGkYhGluyqnIBBwzr5ekwnEQMIGS2xk7NoyDl1jumceRj8rC0gbL9LUzri8tffm
 oSb6Kva+A+jfvFDaXSATih70aBAUHS8/3SB4xRHyFVDI/vsDiLeZLqJkpGmDdKoeFMXn
 wfhA==
X-Gm-Message-State: AOJu0Yw0JxwfgZanxBAJCSNf/mqjzy8TFcnXPCg+9OSvkjFK6VHEGCzL
 ExL0psFVR3g/A2Ou2Iyr2YNKyKJWPkBnS7YUKAZwveDCcRCjy7fGKSalQ2G5eXgo3l0X+Zp+HN6
 GU5DMCE8=
X-Gm-Gg: ATEYQzypdsK14epplkOButjK1hoAmNncQYRXHZ8b8/mC7Bz7zcjqRsiEXOQzWB2xBnH
 W0K1gB5UdbdCPhvyW2aZ+U+FPD3s8dKAlxp9oVfrcbOnnSbkkQvfm/8kACZX29M3wxXb1LmfrCQ
 hPVMPR3wBPjW2KTwR1gSqhAA19KEptrL3ZdEv/C22uEzVXQcMAIZdvCsE4bncWPj+rAS8cyNyVj
 RrEa1hWWYUVTwOfU7vPk3F8GyamLhJogWAkMLPgRtoyGYhva5noZVsFN7/xmFpyWOstXS9qb2Uy
 ZpOgP3WLV0W9ZpAw7CdVTbxFTV3pISuVUZVT9RnmOnxtja7sMeYSFHEQqpKkpvzJDZvtXrTHu6/
 TR8XSWqhdDbUfSPcHwm/wuK9u9vKs87ESPUPLgdN+zqLlOHZcBwAKrRZX0Re33s0LT7sokSR/hN
 U9ZPjWTvghGwssbfL6BowgqIwzNv5B0mMseYvXuKLy8AylsyTtiZIypni4ykTxD8mvJKgssh6VD
 qqGW6ELQQ==
X-Received: by 2002:a05:6000:3113:b0:439:905e:1236 with SMTP id
 ffacd0b85a97d-439da55584amr21731651f8f.2.1773084565653; 
 Mon, 09 Mar 2026 12:29:25 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae3d98asm32493397f8f.30.2026.03.09.12.29.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 12:29:25 -0700 (PDT)
Message-ID: <6a859aab-76c9-4306-9361-2adc9d9e0c4a@linaro.org>
Date: Mon, 9 Mar 2026 20:29:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 22/49] ati-vga: Add scissor clipping register support
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Chad Jablonski <chad@jablonski.xyz>,
 BALATON Zoltan <balaton@eik.bme.hu>
References: <20260308223433.25503-1-philmd@linaro.org>
 <20260308223433.25503-23-philmd@linaro.org>
In-Reply-To: <20260308223433.25503-23-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Hi,

On 8/3/26 23:34, Philippe Mathieu-Daudé wrote:
> From: Chad Jablonski <chad@jablonski.xyz>
> 
> Implement read and write operations on SC_TOP_LEFT, SC_BOTTOM_RIGHT,
> and SRC_SC_BOTTOM_RIGHT registers. These registers are also updated
> when the src and/or dst clipping fields on DP_GUI_MASTER_CNTL are set
> to default clipping.
> 
> Scissor clipping is used when rendering text in X.org. The r128 driver
> sends host data much wider than is necessary to draw a glyph and cuts it
> down to size using clipping before rendering. The actual clipping
> implementation follows in a future patch.
> 
> This also includes a very minor refactor of the combined
> default_sc_bottom_right field in the registers struct to
> default_sc_bottom and default_sc_right. This was done to
> stay consistent with the other scissor registers and prevent repeated
> masking and extraction.
> 
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
> Message-ID: <20260303024730.1489136-7-chad@jablonski.xyz>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/display/ati_int.h  |  9 +++++-
>   hw/display/ati_regs.h |  2 ++
>   hw/display/ati.c      | 70 +++++++++++++++++++++++++++++++++++++++++--
>   3 files changed, 78 insertions(+), 3 deletions(-)


> diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
> index 0a0825db048..3999edb9b71 100644
> --- a/hw/display/ati_regs.h
> +++ b/hw/display/ati_regs.h
> @@ -397,6 +397,8 @@
>   #define GMC_DST_PITCH_OFFSET_CNTL               0x00000002
>   #define GMC_SRC_CLIP_DEFAULT                    0x00000000
>   #define GMC_DST_CLIP_DEFAULT                    0x00000000
> +#define GMC_SRC_CLIPPING                        0x00000004
> +#define GMC_DST_CLIPPING                        0x00000008
>   #define GMC_BRUSH_SOLIDCOLOR                    0x000000d0
>   #define GMC_SRC_DSTCOLOR                        0x00003000
>   #define GMC_BYTE_ORDER_MSB_TO_LSB               0x00000000
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 26fc74b19b3..6cf243bcf95 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -514,7 +514,32 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>           val |= s->regs.default_tile << 16;
>           break;
>       case DEFAULT_SC_BOTTOM_RIGHT:
> -        val = s->regs.default_sc_bottom_right;
> +        val = (s->regs.default_sc_bottom << 16) |
> +              s->regs.default_sc_right;

Coverity is reporting an integer handling issues (SIGN_EXTENSION,
CID 1645615):

 >>>     CID 1645615:         Integer handling issues  (SIGN_EXTENSION)
 >>>     Suspicious implicit sign extension: "s->regs.default_sc_bottom" 
with type "uint16_t" (16 bits, unsigned) is promoted in 
"(s->regs.default_sc_bottom << 16) | s->regs.default_sc_right" to type 
"int" (32 bits, signed), then sign-extended to type "unsigned long" (64 
bits, unsigned).  If "(s->regs.default_sc_bottom << 16) | 
s->regs.default_sc_right" is greater than 0x7FFFFFFF, the upper bits of 
the result will all be 1.

Do you mind posting a fix?

Thanks,

Phil.

