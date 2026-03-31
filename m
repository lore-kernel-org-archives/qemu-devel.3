Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB78109B464
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Yq2-0002xH-Kl; Tue, 31 Mar 2026 09:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Yq1-0002ws-FG
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:08:57 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Ypz-0002x5-UA
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:08:57 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so45497545e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 06:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774962534; x=1775567334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L4z6nJHOEdc4d6s8tAjAXV7MpXmsj4XRi6jXPQjDPpo=;
 b=IcfzcGogetKLU9E18zy/V87vk0UaJfFkA9lGoRONfQzNKEZ+8KcX2Mr690IdRgN2PF
 KQ+QJyf0PUQoh2nud3RLJK1VsfdBHyTCwAEinDu3Uuv5YzZH2cwyYW7V1FNHC6HiCp0p
 l3Q9F3P5qcNo2pTfKQ7VpHYQvlcA7jTuyOZwQT38A2Lq98eourJgHyKevI8fb5RoOYl5
 NknBXg8R3QJN7YzRGNLmDFsXkOnrfmBCHsA7AYTBM8WnMvRFbxF1j724ulcBlBuqESWp
 /CfHfFgQUNcYvsDyq3Uw+1lTh404yZkj2yrFzoANPp2pr8784vzQWAvCflruzHqPq9XE
 wyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774962534; x=1775567334;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L4z6nJHOEdc4d6s8tAjAXV7MpXmsj4XRi6jXPQjDPpo=;
 b=MaYCjprUh68Y81UnEjQlWcI7l5nqDoDx7hpH+7Bj+W31kxKo3vTfdJ+zVyanRzY3OO
 c29MdywoxFnaBVx5bAWKeSGkE2rNlU9NW4b1REctnm7bKDdiNtpPBtgRjsZQjCVBuwjG
 G/hqMh5IrzypIREdBr3aaKEmQ0DZuStFjVhbkyiIuklvlNaj2U6Dsqw+mr5IQb2JUhTP
 /vok1GZCn+i+aCJ4FBgUyMiqLHCP4NBidezbkgN9eJg7X25U2FpqXBZMnfegdvYJuwIy
 aCaAxywHr7jN7/VfOHeKjfdCGVUtAMmgZIYxPMbcvZEAR3PYO9qZEEFerTW0xpcUMbCA
 uhZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ6uOSxq4ry3+X+dOH6RNRt2qlJ6uyGxH37hOsy9gVVw8xdhpkAF798Hqo904fgM3pgw22rOdyOWQr@nongnu.org
X-Gm-Message-State: AOJu0YxXvDxOY/gnM845WatNZRySFqkouF+97i0IWQZZjM3XFJ7jaH8S
 R0DDT7w7Kivz1TJhj9Wv+fzyY8AgbAGY9LPiGirqIasZQh7lRq5/rSGh1VDy3wb57c5W+o2vL+3
 cddZClh4=
X-Gm-Gg: ATEYQzzsN4JoVW+FLNXJkBZi7zcM/IxA0vPsSA3mqE05xmXb/RNGrzGpTr4odCQUTkx
 fJRqydiN/t7u9ob5/7N2KZzH4SmitvcfD3teDPxeEFGYLMao2iHpMn5QKNh6h2qdPPfqXfmRdnB
 hWh3C7ybZ+KF9oCj3xHU1w68igPu7FHLDggHz6J94b8CcWUJlSMVt7+x9l9UeR6z89QoA30SMsr
 FtNFE9ZeBlRI0TgZMLFA1fSlVOcduF5mPCz/BOXSPZPWIif87I0hWvIuq7SX5aafwsYwEfDmY/+
 NZCGJTJ/TZlIlt5N895YWGwSJ1VvAy02vP5eUlx62Ndke+OMm7TaGGmWZ1eKPO5RNNiDJY6yc+Q
 yEQHBtipZSW1h/2ZxkE2Vxw/yrKwpE6VuvNcv8UrB4dY8N8Bs9hHKiGR01ZCDDEkaIX5TT1JXL3
 QEC51pvI9aSmQqcUtyl8PSLDUhLyKuSQUlYs/GMg70syG26obxMKPVRb6wug==
X-Received: by 2002:a05:600c:450a:b0:485:531d:28b9 with SMTP id
 5b1f17b1804b1-48727d774e6mr287687285e9.14.1774962534325; 
 Tue, 31 Mar 2026 06:08:54 -0700 (PDT)
Received: from [10.193.39.66] (43.149.216.82.rev.sfr.net. [82.216.149.43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e829c43sm33493425e9.5.2026.03.31.06.08.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 06:08:53 -0700 (PDT)
Message-ID: <29055103-a354-4079-88fa-ee239a3aa2ef@linaro.org>
Date: Tue, 31 Mar 2026 15:08:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ati-vga: Silence warning about operator precedence
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>, Peter Maydell <peter.maydell@linaro.org>
References: <cover.1774904832.git.balaton@eik.bme.hu>
 <24161ec41f118ad097387f8a84897dee7b4747b8.1774904832.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <24161ec41f118ad097387f8a84897dee7b4747b8.1774904832.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 30/3/26 23:09, BALATON Zoltan wrote:
> Coverity in CID 1645969 warns about possible operator precendence
> issue which is a false positive in this case but simplify the
> expression to silence the warning.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/display/ati_2d.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 23527b2c50..9baf6ff37b 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -91,7 +91,7 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
>       ctx->host_data_active = s->host_data.active;
>       ctx->left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
>       ctx->top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
> -    ctx->need_swap = HOST_BIG_ENDIAN != s->vga.big_endian_fb ? true : false;
> +    ctx->need_swap = (HOST_BIG_ENDIAN != s->vga.big_endian_fb);

Do we really need the parenthesis?

>       ctx->frgd_clr = s->regs.dp_brush_frgd_clr;
>       ctx->palette = s->vga.palette;
>       ctx->dst_offset = s->regs.dst_offset;


