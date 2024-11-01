Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B1DE6F08E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 21:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6zG3-0007YA-A0; Fri, 01 Nov 2024 17:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6zG1-0007Xg-Fv
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 17:32:37 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6zG0-0008Hr-06
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 17:32:37 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7206304f93aso2260232b3a.0
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 14:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730496754; x=1731101554; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1h5gLyWKit4TuhQReHHVAmZXpNfnbhxQ+ePvwwyJokU=;
 b=xsH0eYRsp4lHSGROudOlTQFj02PHZXz0Sw6X/SQjsd/TVblf919fXoEncdGKMMQYcA
 1mvCOYUzSGPyaSWR4+huSJ0N+B3/Qqf9XK5cPbJkju/JOciHDz7wIWE9OMth3v8+1Tde
 SU1YMg6ZhVSsH4Pta8opmyf+Xwwyu39LYsVQEtyeVGE7aCPwo9i2g4zmngtJetmNtG8u
 or1JjuZVJorSQBDcHsp08dNJUhOAqSM8m3+hXGUhCzwM1XuDTveXtlKMYHdKRgec9Oma
 Yiqw+ncvVOHHhvbKHMCIQP6wnG4YEiPoGJ/AW8iZETzXEAOZhiXsT/c2iSB4rwiM5NbQ
 tBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730496754; x=1731101554;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1h5gLyWKit4TuhQReHHVAmZXpNfnbhxQ+ePvwwyJokU=;
 b=IVPZuwY+BuXEQwEuCCtj1vHZqESkxh9HEL7uO6aLTU/tRZb4VYEDDR5sFbEKkxVvUN
 KiMP1ayTjLvKl4L2mPExgZ4/qb7FUQOTzdRN9eqAKvNa+wBe4SM629g0XkpY7zBYeIU0
 8N4iisxgbgaivHFNYPUNcKc3PzkQMXL8NAOy/a5dFuisBIJhVt0LFKvSC45ho1e03r4S
 TNr8dJJN2PNFsInSxLjOgBJSDPpEKrYg7AAGeDC3csAHATlQLXnmwkFvp0GOE5Dge6ZS
 lnXm68vvKzjPsA0nRimyMh/R5TTSLrpv9Tud7uu6kP89A6aRq9O0zrzkkWuzDaniExo9
 8Vbg==
X-Gm-Message-State: AOJu0Yx9nH5svabWAhpjMDfdHlq8Q8DTjJqhiY9heGD8NY/2YwC8Z36i
 5xQZWaonPoxJJ+F6VDco31xk2Ve1zzZG90XLzvRW7OE9i3LOY2OeP6BFTMNPyPg=
X-Google-Smtp-Source: AGHT+IGlQMG4HGlJ5ykixHFWxp6Xhkru4h70PG/94PE6+jL1wHFgUPZI1yGcEjsZjOtWgxDFISxRiA==
X-Received: by 2002:a05:6a00:22c5:b0:71e:4655:59ce with SMTP id
 d2e1a72fcca58-720c967e609mr7901748b3a.0.1730496753857; 
 Fri, 01 Nov 2024 14:32:33 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc31680fsm3095372b3a.207.2024.11.01.14.32.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Nov 2024 14:32:33 -0700 (PDT)
Message-ID: <85f34a23-bbe0-4996-9735-3d6d1a708727@linaro.org>
Date: Fri, 1 Nov 2024 14:32:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb: Use __attribute__((packed)) vs __packed
To: Roque Arcudia Hernandez <roqueh@google.com>, thuth@redhat.com,
 richard.henderson@linaro.org, jansene@google.com, mjt@tls.msk.ru
Cc: qemu-devel@nongnu.org
References: <20241101211720.3354111-1-roqueh@google.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241101211720.3354111-1-roqueh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

On 11/1/24 14:17, Roque Arcudia Hernandez wrote:
> __packed is non standard and is not present in clang-cl.
> __attribute__((packed)) has the same semantics.
> 
> Signed-off-by: Erwin Jansen <jansene@google.com>
> Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> ---
>   include/hw/usb/dwc2-regs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/usb/dwc2-regs.h b/include/hw/usb/dwc2-regs.h
> index 523b112c5e..b8b4266543 100644
> --- a/include/hw/usb/dwc2-regs.h
> +++ b/include/hw/usb/dwc2-regs.h
> @@ -838,7 +838,7 @@
>   struct dwc2_dma_desc {
>           uint32_t status;
>           uint32_t buf;
> -} __packed;
> +} QEMU_PACKED;
>   
>   /* Host Mode DMA descriptor status quadlet */
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


