Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238FFEA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMUx-0004FC-Hg; Sun, 08 Mar 2026 18:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMUw-0004Bg-46
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:21:18 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMUr-00013e-Tt
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:21:17 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so8461022f8f.2
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773008470; x=1773613270; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T5Dpj6c1gAeLPkSekT9sJ723kDIxLzlTFepZ8snPZgc=;
 b=UqArWzDNw32eUw5l4Ah/kTWE5LlFXxc3qB7hccH6fKCkkjnQ6S85vAGvR61RHts92k
 IK2uz/GfONgaxPIaB3KoRhoZISc3xw7V77a//gyTwtmw0IzYtB4ExWWBn4lJah6V9Gs2
 6goZrSwdUgjK57BeS9ULJW6qHCfHQ7uQ5DpmW7GpVOiI1qJqhFP3hVdaPRUrvhQVdWNq
 HXRm7PBMr8KwJnBzBb7vAEa/iIDF3vE5F1fLqjKEuRfVtrttko9+k2xqN4p8cNLMZgeW
 Gvh9NlEZGB8NRjOJS+q1twXoqKy1QwwQv3mHdOEHkMFaR6JXBleFCb8TJe8WQmPeJMvj
 xt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773008470; x=1773613270;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T5Dpj6c1gAeLPkSekT9sJ723kDIxLzlTFepZ8snPZgc=;
 b=CFrYmjlRv1FsmMK7w9U7kmD/UP1a+ZuNODJZo+AoHy4hhzAfTeIdnGpn675BwypIsj
 U/BSngnthVXP/EiUw8ylpsRVqNBP9s/gLkyLHDQMhyHIU9JdsvoEKQ57p0bt9NSJfzqZ
 FF9N4mATqgz6plL/rQzCPN5sQI/01NZdEtTLBmGZwy8aAF56bLHbq+5q5SH0ECMI/Qg+
 Py7qJsYQ16Iw1lccSydosdXtKEFqqqrDVI61Ek7K2kCA4qqnc/GsHcRnL8qbos4Oq/a9
 LuQnKYdV4jwlSVlGFxrcLFBCa4006LNk5KTlIvhqMm8o8PzY22D01cHV79VV4OxWe1JP
 +13Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb5wuV+xvwWjriL99kG/y0X22cARO2VMLAYWw/J0yW92z2SCDRXefddpTT9TeYpesLIQyrRWgC6nWW@nongnu.org
X-Gm-Message-State: AOJu0YzN5LJiCV1XHm6/qacjmbGhRF7Ry1gn5Lz5MeOnrkwBXZ9vJZnW
 pntOrVuw+5jxjTdwSvvQkzbBNR9YTKpd0WJp+JFYIZnj2M4+xuD9uhk5/5pB2x64kE8=
X-Gm-Gg: ATEYQzyr4czsRBHQQxWGbPX2P8paILs0Mv9oFz/7+Jr+9MUV5uYRhT/dCXAPziTDDLA
 CttGncDe/cy+ncr+MfuPnti1NzV82Bb9wgOK3kzDixJ6u7soBxVuCZQxvJRnMOWox5u6UdNYbr6
 NCuJHWzFdUENXRvixWGAOFRKICbVF5OPYHamf/ZPvP7dEasd3qSrLGcfoOiTUi9XO8K9UF20yyj
 PIVGgim6YCYOGGrqcJiTjNehX0EHm1frxTABym4/WU8dl0bPMSL6FfxRhH0ULZPPXSF2ySVAGo/
 N8VxEVhfxjnPo5Z+uJgkHhaOGAOJC5yYE2GdZmdTKhWNd1cp3AMVbMTuph/tgWAeJ6wPzfwuuS1
 srY1WRdMBhzjJoX/0KRtyhSJBK8y0Ggi6lsr4zyMy7eyx9D02pLjUSttRB/zXML3I6fg6usnJnb
 Ko+s2eLOxXEEP4GKCs8R2/dCV8iZOT6J9UKmIolVH1BXXXtUEQwRvuOaswMBSD9+cP2d2Oung=
X-Received: by 2002:a05:6000:310c:b0:439:b636:1fa4 with SMTP id
 ffacd0b85a97d-439da8951damr15986588f8f.48.1773008470523; 
 Sun, 08 Mar 2026 15:21:10 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae49177sm20939184f8f.35.2026.03.08.15.21.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Mar 2026 15:21:09 -0700 (PDT)
Message-ID: <a04c9f47-d371-4e78-93cd-7798b804f237@linaro.org>
Date: Sun, 8 Mar 2026 23:21:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/17] ati-vga: Implement HOST_DATA transfers to
 enable X.org text rendering
Content-Language: en-US
To: Chad Jablonski <chad@jablonski.xyz>, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260303024730.1489136-1-chad@jablonski.xyz>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260303024730.1489136-1-chad@jablonski.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Hi Chad,

On 3/3/26 03:47, Chad Jablonski wrote:
> This series implements HOST_DATA as a blit source enabling text rendering in
> xterm under X.org with 2D acceleration.
> 
> The series builds up functionality incrementally:
> 
> * Patches   1-6:  Bug fixes and register implementations
> * Patches  7-14:  Refactor of ati_2d_blt to decouple from ATIVGAState
> * Patch      15:  Scissor clipping implementation
> * Patches 16-17:  HOST_DATA register writes, color expansion, and
>                    accumulator flush


> Chad Jablonski (17):
>    ati-vga: Fix framebuffer mapping by using hardware-correct aperture
>      sizes
>    ati-vga: Fix DST_PITCH and SRC_PITCH reads
>    ati-vga: Read aliased values from DP_GUI_MASTER_CNTL
>    ati-vga: Latch src and dst pitch and offset on master_cntl default
>    ati-vga: Implement foreground and background color register writes
>    ati-vga: Add scissor clipping register support
>    ati-vga: Remove dst_x/y updates after blit
>    ati-vga: Consolidate dirty region tracking in ati_2d_blt
>    ati-vga: Remove src and dst stride mutation in ati_2d_blt
>    ati-vga: Use local variables for register values in ati_2d_blt
>    ati-vga: Introduce ATI2DCtx struct for 2D blit context
>    ati-vga: Extract setup_2d_blt_ctx from ati_2d_blt
>    ati-vga: Split ati_2d_do_blt from ati_2d_blt
>    ati-vga: Remove ATIVGAState param from ati_2d_do_blt
>    ati-vga: Implement scissor rectangle clipping for 2D operations
>    ati-vga: Implement HOST_DATA register writes
>    ati-vga: Implement HOST_DATA flush to VRAM

Zoltan asked me to look at your series [*] but unfortunately I'm
getting a build failure when building without PIXMAN starting
with patch #9:

../hw/display/ati_2d.c: In function ‘ati_2d_do_blt’:
../hw/display/ati_2d.c:185:13: error: unused variable ‘src_stride_words’ 
[-Werror=unused-variable]
   185 |         int src_stride_words = ctx->src_stride / sizeof(uint32_t);
       |             ^~~~~~~~~~~~~~~~
../hw/display/ati_2d.c:147:9: error: unused variable ‘dst_stride_words’ 
[-Werror=unused-variable]
   147 |     int dst_stride_words = ctx->dst_stride / sizeof(uint32_t);
       |         ^~~~~~~~~~~~~~~~
../hw/display/ati_2d.c:137:10: error: unused variable ‘use_pixman_blt’ 
[-Werror=unused-variable]
   137 |     bool use_pixman_blt = use_pixman & BIT(1);
       |          ^~~~~~~~~~~~~~
../hw/display/ati_2d.c:136:10: error: unused variable ‘use_pixman_fill’ 
[-Werror=unused-variable]
   136 |     bool use_pixman_fill = use_pixman & BIT(0);
       |          ^~~~~~~~~~~~~~~

I'm queueing the first 8 patches hoping it helps.

Also, please fix the checkpatch.pl coding style errors
before re-posting.

Regards,

Phil.

[*] 
https://lore.kernel.org/qemu-devel/7f1df452-05c2-efa3-fdce-a5d987cfdcc8@eik.bme.hu/


