Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA5CC02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 08:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tasnw-00065C-Kg; Thu, 23 Jan 2025 03:43:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tasnu-00064z-Kd
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 03:43:10 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tasnt-0007UJ-3N
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 03:43:10 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so4145815e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 00:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737621787; x=1738226587; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LGQDCt+Cv4IFB2AYEoCrDUVcG7NbF6PTYHm3qPI+HYw=;
 b=USPs1zMBt4I1yTlFjrSvk1gBog2u0FzlEABPrAaUwg21r5ZhWJAJ9dtayJSAKPQ74H
 CPcpexEuXNj8JZYtLygt7QzYwwdade1+v/x4Uw+sd/Ztfc5iWJUjl0kCqu0qzaIBJo3J
 qWP0EZ5FcEVxx7ffnfZzp3curi1gcSMzqf+hzkOgQc0nDw1Hl6geZ+P/T3LO1da9kZjF
 CGhA0XoK+MWKHbRm2UE/xFYlCL+QwxcWwezM2oHA+s35XHgYxZuTvlWG4x/JeMuZqzeS
 a8K6tgLEa1D+InpK9Bpam3v+X2lb/SIGfMbLQ+Gu0otEmJ9RrCluYLJj1Xt0hhJS2Qf6
 c2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737621787; x=1738226587;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LGQDCt+Cv4IFB2AYEoCrDUVcG7NbF6PTYHm3qPI+HYw=;
 b=SBVjMYrqFmtmyNRJ9R29oG7Kgi9O2RVMjT/I6M6TpTjaKOW3xoPw9ACIZu8bW4sRTe
 glFODujElrVcsTUtIp24yhv7PD/+/wHn6jUhYhJNa8XKId1Bhw45ehCZqEWPvlH/NNwQ
 MoK8w4v3eomZ76O5Stf/zRz0BcoeGw16znwMSTx0ubWNOjExAaIpkzwm1tRgLF8W9wl8
 ggUS6FhxIJDHz6mlu4YUrzh6akQaE1rpuzcpubQhX51guEV3eatups7VEGIuZa66C91+
 Uu0/xml0e7Be5APEXU85KF6D4626R72Qq+8N+5wsdodrUEYrygAqIBkxDDd+skuGHylR
 xJwg==
X-Gm-Message-State: AOJu0YzO2YbcoABvwSUSJwQO7coOvh8TSdRAX2JjMOnjz8tOJUXl5MCg
 yw/S75jxLP0ZLgqfPDZiqt15vWMOQAyNE81kQNf5i8FMn+3JtcR5wV/btPi/dUOiB7GIOBt2bKT
 xpE4=
X-Gm-Gg: ASbGncv7YAOHLh27/Wt5T0xQPfI9gypF2ZQeoLOzaMnQhtTtt22Di/qDPqPRCgRp1bO
 p+RkkMKblgSfD7xC2yHp/wrY3toFguJw9J0N9Kwu6GJzc41kDQZ7kSvY1isaeCuZNxIbGdnT3qq
 9DajXwQErLAmQ9c4C6LUoUXWPvvwBc7sFxnFgPUWmEPLaLms9X4q6YP4TRXbJC2t9Nne16oxADE
 HDT8wRHXUxIInb/u9WqGRjMNqceQGhI4I4OMp0LR4kNDXf1ovbNL4gRayWizeUsPsVJCNpsquu4
 wiFA1AUPhcmaUaeD1Qryo3pDJhqXOdMTdqr/uVDKqAs6RqXw
X-Google-Smtp-Source: AGHT+IGHpiBND/Pl4JBSTbjUj8D4wGvBW7A7+jcLD+CPj8JJp0cnxudCMltNsV70x5LV7vAI67J0iQ==
X-Received: by 2002:a05:6000:2a9:b0:38a:86fe:52b5 with SMTP id
 ffacd0b85a97d-38bf566274amr25875292f8f.14.1737621787345; 
 Thu, 23 Jan 2025 00:43:07 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf327decbsm18914702f8f.90.2025.01.23.00.43.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2025 00:43:06 -0800 (PST)
Message-ID: <7a020e94-841a-4a3c-bdea-12c00579ef3f@linaro.org>
Date: Thu, 23 Jan 2025 09:43:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] audio: Add functions to initialize buffers
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
References: <20250123-coreaudio-v5-0-6873df4215a0@daynix.com>
 <20250123-coreaudio-v5-3-6873df4215a0@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250123-coreaudio-v5-3-6873df4215a0@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Hi Akihiko,

On 23/1/25 08:18, Akihiko Odaki wrote:
> These functions can be used to re-initialize buffers when hardware
> parameters change due to device hotplug, for example.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>   audio/audio_int.h |  2 ++
>   audio/audio.c     | 24 ++++++++++++++++++------
>   2 files changed, 20 insertions(+), 6 deletions(-)


> index 87b4e9b6f2f356b6e5e972eabc100cf270fcbc29..17c6bbd0ae9e6ff810c0989dbfa1710ef674ff0a 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1407,12 +1407,18 @@ void audio_run(AudioState *s, const char *msg)
>   #endif
>   }
>   
> +void audio_generic_initialize_buffer_in(HWVoiceIn *hw)
> +{
> +    g_free(hw->buf_emul);
> +    hw->size_emul = hw->samples * hw->info.bytes_per_frame;
> +    hw->buf_emul = g_malloc(hw->size_emul);

What about using g_realloc()? Otherwise LGTM.

> +    hw->pos_emul = hw->pending_emul = 0;
> +}


