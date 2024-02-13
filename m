Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D354C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 11:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZr8c-0000eU-1J; Tue, 13 Feb 2024 06:39:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZr8a-0000e7-1N
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 06:39:44 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZr8Y-0004wt-JC
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 06:39:43 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33cddf4b4b5so230644f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 03:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707824380; x=1708429180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aqIuH3/f/UdVewyAkvF9KDu0xi4D/gTgnUtJ++4EPoA=;
 b=sYaRGExZ20wS7TODgBE3/UKKXCAbeRSAl0kHYnxJ4xxhfYaDU1dstLxyjeCLPWqGHL
 yJXK4P0uN0jOaWYspyWqcdDmoUWUwPlQRJT216Dfc2tMBpbKC2lz+k13S/N+fTK5Sztx
 2J6MfJP9YZD5seX1ZcjvryDS2yqLtnRCLxU/b7xKqb9UAcAw3OWT8jdKbK9tLF6v6F4r
 hZ9YbdLDKmUDgZ9Nueyf31J8QX97nig3dlbUR0mabaO7pqKvFPUksArvw0xnxg/GOC9Y
 A0w6e2IlF3R3dOKXFm50OqzE7yl7Rr1pIvS5A08WJ7SUqOTAghqTQnxdGTLXWEzc3LlI
 iVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707824380; x=1708429180;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aqIuH3/f/UdVewyAkvF9KDu0xi4D/gTgnUtJ++4EPoA=;
 b=Xr8aWLTNSZ0kCdbTEGF0SBOXaV57VODdtF3pUo6cU9uoO+C+dn1MCvNbPnh0eQxRgR
 16bhMm2uV6mpzggonuHLQQH+mvRoDQoh5ey5WJKsPBvDXe5xeaJQvwFzoKUu86ZqfnPa
 yAm3lFazodYoOuvfohzQr90dDdJPfFH0GCluLjOMYjw7Are4AmsAnKRdlFX5FXzJSAw3
 /PU5oUq8R8+qJcF/AKCe4roMGPVYpA9si80A4/G4CQ8o1khcz/wEQPv4d21ih+BXlmh/
 fPC1RXhXRdQ8dFArafIT/HKKbDkrikiXU13WfV5B8mmccQ3euF50kYw+DGmv8T0DmAHM
 lRxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIRY8kFYtMyNAUube3CH7YtWyGNF2KioXvqXsGO0G6LYYF2txKXxeQ4eq0a66u0P+LfEOBkDqqum9fTdN7BVBta61DIBo=
X-Gm-Message-State: AOJu0Yz+EM8Y0jghjnCdEY+AziAQoMf41+jI4Wxq8saZED+8cYVbYhzN
 eJO6MmQjC2jxA0SvyA06P3Rn9kfsqoCaHvHc5nvI5Ci85JgZaVSHIgR0evEiATo=
X-Google-Smtp-Source: AGHT+IEjEcepEZoFV57Fzz2xCA1XWdZnRFds9yQPgfUlCjhevBHi7ZaXWKONk/walHl/wolKCvuyWw==
X-Received: by 2002:adf:eec9:0:b0:33b:2281:ef32 with SMTP id
 a9-20020adfeec9000000b0033b2281ef32mr7416124wrp.69.1707824379717; 
 Tue, 13 Feb 2024 03:39:39 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU7mfnUWH+GjZ2b0hyUIm8p9qUEZwK1utzB7N6VDBFSq8AeKGcayBKnlFxvZ6slC5cl8DW9Pj05/ZzghYurNupYxdROEXw=
Received: from [192.168.69.100] ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 m10-20020adff38a000000b0033b0d2ba3a1sm9329550wro.63.2024.02.13.03.39.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 03:39:39 -0800 (PST)
Message-ID: <d694fd2d-d09c-4b44-8d07-f4fa70473ec5@linaro.org>
Date: Tue, 13 Feb 2024 12:39:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mips: remove unnecessary "select PTIMER"
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240129115811.1039965-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240129115811.1039965-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 29/1/24 12:58, Paolo Bonzini wrote:
> There is no use of ptimer functions in mips_cps.c or any other related
> code.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/mips/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
> index 505381a0bba..ab61af209a0 100644
> --- a/hw/mips/Kconfig
> +++ b/hw/mips/Kconfig
> @@ -50,7 +50,6 @@ config LOONGSON3V
>   
>   config MIPS_CPS
>       bool
> -    select PTIMER
>       select MIPS_ITU
>   
>   config MIPS_BOSTON

Thanks, patch queued.

