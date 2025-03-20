Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED53C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 12:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvFL3-0005qS-2w; Thu, 20 Mar 2025 08:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvFL0-0005ob-1y
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:49:32 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvFKy-0006kc-47
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:49:29 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso4770955e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 05:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742474964; x=1743079764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GsNFRFbs/CtgPtcfcOWOEbEr9nXJH1kuya+MMLm6/c8=;
 b=gSVQLV96NCeE5XduJk0jm/ShPHWlSv33QBGNs4rTDoKhIOQC+EkWpcwIiI7g2gjdfD
 xPJ3FLRh6mxIywtv9dXXxIwCzQkevBfPudH6Gc8h0zXMQswU82dHeqqNvRHlcRJSYbDI
 xJpGpi0IKu6auQfKaikFy2gQnbDwW3W/gu3Jk51oRWVJdKHkOAu2zzrj2wHzI4brGvv3
 ExrRUcUb/OSUCRZncA0WxsKXqp+m9szwaVICpUv02NBTrklc+SWrX9T7RvxK8a3Q4Dcm
 Pu/zqHYNWLcy+Q9Viu0BYE1osQaFByEJnFVCuF3on2BCu+jwsaqQ1pDB7lwU5Xix89RY
 /bCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742474964; x=1743079764;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GsNFRFbs/CtgPtcfcOWOEbEr9nXJH1kuya+MMLm6/c8=;
 b=d5JFE5Xdndhg0SfK3eDp8uO2C7xARjlmnYi6P8BAlz4lfq+UHysdCKa7T03kIsOGBA
 WNN/3jEPr60UnUx94H0SAeclqOYEvbH4NeupVXzQjGDejKJKWOwPjuAf2pTt0Yxs2qkA
 9esKphlpBjVMMQrqpVy4wFAcHPo6Ljr3r4wYP++2azdPSObMFoLf5pACs96Ju2/U8/f4
 xzfVsm/sZAaOuzS7ZidFss0k4E7oiHdXgzlk3Vbhm53Ulz7ghNj7+9NJN8dZUGSnhGTK
 UuVPHzfa5sqSB5DEoTRw40UFVpdEaRTQaRqygRSrukBq0A4pUmooHRQY6xYGHuCLHnFK
 Bp6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkbzO0W6Oexd4IcycU3TqwjVsRnuj300QyeUTC+Vcqgnsa7wMnv2iU7G7U/oez4bAJiDYnxS4vVDeK@nongnu.org
X-Gm-Message-State: AOJu0YxTaSJOqkUqNc4WGJLoXSQicuDzfOocBuwo3HY4BVBu+rdRF220
 oJcuQCL6lUuJa8mPQECBWlGAbCyAXBkISktMCdUkKsM3Zo93uqZvFArzhgxe7Ow=
X-Gm-Gg: ASbGncuQqZaQGnvOHxDQ6Yb97Dre1gOXVQdseG72Apip19rovEPZEKvZMA4f+f6Wc5U
 exCZg/zI994ZCu340hRZL0sc4qWeEDpT1hkGpGPBdNa5qXgcT0FKX5XczcnJkrI7WXowNtIlyhN
 mbr3O0JAGvXuJyz8bqM3/dHtBtlyly08+KKwY6972aqS5lMRW0kfPv+mpXEV/CAVXxxOq6HyBHH
 KmEuusaPtc86xru4oZz3hSqFl4u9WzF7NUuSEz0jhII/6otCHB5OB2oBPhG+KHFLVc2k1CqatjR
 aC2jW1Bsn/dfv1nHhfwdKLTRIIEkKrVs1eiiyRcXzEvx4tEuy3pFk4LD3+6uzjH5+dARnIa0fN4
 OyMsxzogTz/8F
X-Google-Smtp-Source: AGHT+IE94O5jqdIMEic1PV/zUw/gtoTcnyhS6WB7jfvkRKuGYpOjDfp8Mu3l54BQvC00b2SUX92HFg==
X-Received: by 2002:a05:600c:1e0f:b0:43d:16a0:d98d with SMTP id
 5b1f17b1804b1-43d491918c5mr34030395e9.15.1742474964264; 
 Thu, 20 Mar 2025 05:49:24 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f37665sm48558785e9.2.2025.03.20.05.49.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 05:49:23 -0700 (PDT)
Message-ID: <5e3cc809-8f29-4aaf-9537-beccd8d96353@linaro.org>
Date: Thu, 20 Mar 2025 13:49:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] load_aout: replace bswap_needed with big_endian
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20250320124313.819222-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250320124313.819222-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 20/3/25 13:43, Paolo Bonzini wrote:
> Targets know whether they are big-endian more than they know if
> the endianness is different from the host: the former is mostly
> a constant, at least in machine creation code, while the latter
> has to be computed with TARGET_BIG_ENDIAN != HOST_BIG_ENDIAN or
> something like that.
> 
> load_aout, however, takes a "bswap_needed" argument.  Replace
> it with a "big_endian" argument; even though all users are
> big-endian, it is cheap enough to keep the optional swapping
> functionality even for little-endian boards.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/loader.h   | 2 +-
>   hw/core/loader.c      | 4 ++--
>   hw/ppc/mac_newworld.c | 7 +------
>   hw/ppc/mac_oldworld.c | 7 +------
>   hw/sparc/sun4m.c      | 9 +--------
>   hw/sparc64/sun4u.c    | 9 +--------
>   6 files changed, 7 insertions(+), 31 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


