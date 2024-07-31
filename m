Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DED8C3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 01:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYyGk-0000a3-Hp; Tue, 30 Jul 2024 21:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYyGi-0000WR-SQ
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:36:44 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYyGh-0007Gh-0h
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:36:44 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7093abb12edso3948308a34.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 18:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722389801; x=1722994601; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pQF4s9uQnFfbaRqSbtrsGmn90L2sjVXg9peNVQkjyHw=;
 b=aVXaodLfJASBGfH9PZcERvWruik3vYXJukumW5ry6Tkbl6xTQlutR0hMHH1drxWsTP
 AgJQDjRz7o9RCSGdmHWGcxQfIzXNv0fmsuQToVPswnxi4tZJaqROIAFFsBHYA1dPpb+0
 gX/lsrSY8jYDL6Qkj4jIsMp3Z6aiMaD/5+6EVG1j4irhG2KNiY0y8gsy/7wPemDc6VO3
 gx/j7HzcwGBsiGNVGIKa0qsSuwOH3OfYh23KLui2KKX0Nc+pyAWUNMsBPncCmdm8GyVf
 oCjVNRaLpvztlAMzvgf6J/Wv7D85Q+Sbz4CkUypjnLemM8aQxZazbLKzRYzUyenZX9cm
 h4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722389801; x=1722994601;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pQF4s9uQnFfbaRqSbtrsGmn90L2sjVXg9peNVQkjyHw=;
 b=UFEPnHxE7bPkkctn3lKIA8uVKuZTNIVtBqt7wlv2qESulw7c0LxpMwI39iUt0UFfp3
 hdDzs1F//NP3QM5Mrrf/jg0rX96lbWTKsZNjqnFchUtgOH92oNmDzLJ/aGSeBS75bOPO
 wGDSNRGPQRbM8HbJpvLkEKuQooaWq7Ul7LVQhKcY0VXp7h2JaTDvQF33VWtSH2p7+w4A
 uaeqpFJzJXi/kG15PRx1LGTWgc2p7+wT4XSSzv05qX+40V6n7zB4lfRQrCusb2RR0MVv
 zbDHeQupEoqSJbOEEnkHgqFMNn8PdV2vLD6mMfLYOQS3rLZjo2DcFl+XOrFifJ86Mrfa
 HkKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRgZe5ycS+G03/kxMZEDh5+C2rAHod5r0lUgWXsns5j+Q7CnJTnBz/4aCjqpSwdXi1jQ8nHA9aiLeL51H2RTyZ+OKmv5c=
X-Gm-Message-State: AOJu0YyeGZQ9Dp0iHUSKplVNH0RHbbuVWAVbE/KmkNHyXfjz8sIGg8hq
 G0ZhfFfapgryd/R2oSt9l7j2qYfgixmoAThAqUcuJRylwnenitfjg7z+/Jp9kHI=
X-Google-Smtp-Source: AGHT+IFvXvQHLu7h37rSLPcRRGkIddaN8q+y2yYvH2Fo6I+zhgvpkfbXFnuqAOWvVP+zIUK1CC623g==
X-Received: by 2002:a9d:7748:0:b0:703:5c2d:56a7 with SMTP id
 46e09a7af769-70940c7016fmr14165611a34.24.1722389801178; 
 Tue, 30 Jul 2024 18:36:41 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:7406:659b:9ac8:69bb?
 (2403-580a-f89b-0-7406-659b-9ac8-69bb.ip6.aussiebb.net.
 [2403:580a:f89b:0:7406:659b:9ac8:69bb])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead86ff31sm9330509b3a.144.2024.07.30.18.36.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 18:36:40 -0700 (PDT)
Message-ID: <a1c3324c-6065-44cf-ac52-f7038f99680d@linaro.org>
Date: Wed, 31 Jul 2024 11:36:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] target/arm: Pass env pointer through to gvec_bfdot
 helper
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240730160306.2959745-1-peter.maydell@linaro.org>
 <20240730160306.2959745-4-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730160306.2959745-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

On 7/31/24 02:03, Peter Maydell wrote:
> Pass the env pointer through to the gvec_bfdot helper,
> so we can use it to add support for FEAT_EBF16.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/helper.h             |  4 ++--
>   target/arm/tcg/translate-a64.c  | 27 ++++++++++++++++++++++++-
>   target/arm/tcg/translate-neon.c | 35 +++++++++++++++++++++++++++++++--
>   target/arm/tcg/translate-sve.c  | 15 +++++++++++++-
>   target/arm/tcg/vec_helper.c     |  3 ++-
>   5 files changed, 77 insertions(+), 7 deletions(-)
> 
> diff --git a/target/arm/helper.h b/target/arm/helper.h
> index 970d059dec5..aece9fd4aa7 100644
> --- a/target/arm/helper.h
> +++ b/target/arm/helper.h
> @@ -1027,8 +1027,8 @@ DEF_HELPER_FLAGS_5(gvec_ummla_b, TCG_CALL_NO_RWG,
>   DEF_HELPER_FLAGS_5(gvec_usmmla_b, TCG_CALL_NO_RWG,
>                      void, ptr, ptr, ptr, ptr, i32)
>   
> -DEF_HELPER_FLAGS_5(gvec_bfdot, TCG_CALL_NO_RWG,
> -                   void, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_6(gvec_bfdot, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, i32)

Because env expands to TCGv_ptr in the translation context, I suspect that you can use 
that here.  Worth a try, anyway, so that

> -void HELPER(gvec_bfdot)(void *vd, void *vn, void *vm, void *va, uint32_t desc)
> +void HELPER(gvec_bfdot)(void *vd, void *vn, void *vm, void *va,
> +                        void *envp, uint32_t desc)

this doesn't have to use void *.

Either way,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

