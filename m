Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C27C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 15:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMqbS-0005fg-Rh; Thu, 27 Jun 2024 11:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMqbH-0005cy-0b
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:59:51 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMqbF-0008Tl-Bc
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:59:50 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-706642b4403so1398538b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 07:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719500387; x=1720105187; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y0P/7LRXNqMvHo9K+HuC9yprYHuK6eTHv0cut9TUAGY=;
 b=xw8eL9VfijSn0Up+WbwExCq5u5mXxSRK00rJv0JWdVZl8sMPLfrO/VSiH31w3XrP2P
 yqbWu7ovsMbaQ0nryB+Uc84aB0HSRkgXItgSofEsY1zWIAO7wezOyPhHJREk5bKCXSGv
 /4DFuj6/N760KR7pyKyyQhl+bN9lD8YZZHqUpiKACjhggYOdjzQTEEP0nAWb0qYZ5PED
 K63jmtun42I62CMipZZmvoh5yD8LKYM0dGT62QZZqqYVoDiii134Kpysc6Vb1IijYKGS
 6OwLwZs/wS65vnicS1VUZ4vWa+08gqriPtJR2lhstQRdN/EkAlgScwn0vJCIy0L3TPHW
 d4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719500387; x=1720105187;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y0P/7LRXNqMvHo9K+HuC9yprYHuK6eTHv0cut9TUAGY=;
 b=bxY/Nt5CDhEk1ccGPDPv4fp+yXDRzjf5QjRGjDH7SEU8ZJQwsuEHiwc8Bh1VOAYmxM
 z5ySH7Yok4QrJvWJfXF0eBYTvOBYBTZm904TrDb9eZn4Bo2PPvfnFcOGWbWwtRSwy5jG
 lojaNWOMcIPCFAvEEA4GHRi9A90VsZDxkQUJFPXdcXoVZc5gEn3Os5zeSWYibFqvwLlp
 pP2HxZafKOyd081cjkmJOR58Ti8TBKmSoqOchNxKcm4jVMgKmRELefUc0GlW+e+P2173
 ohH0FKqyQIMON3iiWeexsq/bQmDwsJoZBcaeacmRUfvTLzrLUOiZYuk5RzGwUaBpV3np
 5how==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO7iwhYQKpUIbDXtxJsDmf1muxmadtCpQmVtxRs1EKTGHOfX1aki4LoAIus2KQIotxMLzbP8HnyK2f6VGtHHlQxYMAdcs=
X-Gm-Message-State: AOJu0Yy+Y1SZRkv+RGNsa3oG74TURH6QRg0PYcKnYVMCUD4zoQgnhZks
 QAHW8oF64twOqYrd1t29EzUkncZ6gy3DJ6SWXxCetA7xV8BWT642eiyD33F8XmBKf6Srsuj2mH8
 5
X-Google-Smtp-Source: AGHT+IE21QdqAF+E9Fm1xumtEGXI8glsjEIIVnpIrRDDko6YIki1QPkwa9qgyGbh8/kDng0dZiNFpw==
X-Received: by 2002:a05:6a00:2f8e:b0:706:1f67:64d3 with SMTP id
 d2e1a72fcca58-70691435630mr10074618b3a.14.1719500387263; 
 Thu, 27 Jun 2024 07:59:47 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-707faba8ec8sm593698b3a.64.2024.06.27.07.59.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 07:59:46 -0700 (PDT)
Message-ID: <0db3a727-9843-4441-80ac-89732bd7e5ef@linaro.org>
Date: Thu, 27 Jun 2024 07:59:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/tcg: remove unused enum
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240627105919.981453-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240627105919.981453-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 6/27/24 03:59, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 16 ----------------
>   1 file changed, 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 257110ac703..aeb7bc4d51b 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -282,22 +282,6 @@ enum {
>       JCC_LE,
>   };
>   
> -enum {
> -    /* I386 int registers */
> -    OR_EAX,   /* MUST be even numbered */
> -    OR_ECX,
> -    OR_EDX,
> -    OR_EBX,
> -    OR_ESP,
> -    OR_EBP,
> -    OR_ESI,
> -    OR_EDI,
> -
> -    OR_TMP0 = 16,    /* temporary operand register */
> -    OR_TMP1,
> -    OR_A0, /* temporary register used when doing address evaluation */
> -};
> -
>   enum {
>       USES_CC_DST  = 1,
>       USES_CC_SRC  = 2,


