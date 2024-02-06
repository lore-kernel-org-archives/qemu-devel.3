Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834E5C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 22:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXUBV-0006zb-I0; Tue, 06 Feb 2024 17:44:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXUBT-0006xc-7l
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 17:44:55 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXUBR-00084j-3M
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 17:44:54 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-296a02b7104so2117329a91.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 14:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707259491; x=1707864291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VmpG1OK1dBVHpGmcCxVHOINYGxCEWyWQgrTCrGg8iDE=;
 b=pgwuYW/xtsnD2cT4ZJMT5PYySG6DT9Hpvcd5E1GfbyApq4dF0xwIeT7tN2xfMpWzdx
 FCLzW7bUABDh0/A53Cgyg2MKrvdL/b/HeHfamuTL6bAvGFJelXjnF8Mkebvm/V6wJHpc
 paZ5dGs8ESFDcUArB6GFgg2DqtzRZtG5qv3Hi7OpIaZXMCiMyjHgpeTHLb1aemkpM+U6
 jTawBH8fJMETfR8Q0+ZUMR0sIrNNUqA6XJP63kKL1Zi6t618Li+vRxTyuURT6O8vdizk
 vpKsMWLNRmMw8G9V7gPgMAgJ6Hc4JneuVb7/CpI1fUkuwaNEajSudjnZRrn4pATkEKaf
 j5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707259491; x=1707864291;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VmpG1OK1dBVHpGmcCxVHOINYGxCEWyWQgrTCrGg8iDE=;
 b=ZeYN6WrQuuYxR2PTYjPSWRNjkHg7//Kge28kIM4aW7rYMkm5CR+qA8kCje8GSjVTde
 AWzwFAMRMETiHV3XeXy1dYgT7D8q3qks1c7AkcSnY6AaCMDCvOcmPhAxqiuVzGRqVnw8
 Po67c/URFIZUwPH3tS31sjBv50uW34/ctjPqggJM17ei4IYEF4AFwwpJ37MB1326J6vn
 2Wtfnv1F5dIca8knyrojHz5a7ASFNWPEL7q1xm7zvq8grkrbJ8x5nMyG4lZ32D7Kqdmy
 qrDauL38Lo+vrjYHj7BcDJvNbKk7xqc+qfalHgDlB2mWKwHPzl8XNmKS3KbPZDLVhzQf
 PKTg==
X-Gm-Message-State: AOJu0YzfJVMYT7aZxVXbSa9gJzRE4Aduwt1VwYPld+vsLYQF3MWYpcep
 nMMlaAE6DjjFM0u4te7hE4vS+MNQotEQOTkd3GeOdhnRaxCzMskQk3f0kOy37+g=
X-Google-Smtp-Source: AGHT+IGsuI7jaxE1UmonqzJ9QUV2vH4BuWkCEb2YBEp+QmV3nKi77z/FrPvzKQlYz9iEmriTI5QPVg==
X-Received: by 2002:a17:90a:110:b0:296:3a70:ad55 with SMTP id
 b16-20020a17090a011000b002963a70ad55mr943572pjb.34.1707259491322; 
 Tue, 06 Feb 2024 14:44:51 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVuh/4kp/Cgtqzu3Pr7j79fkXL3fG+pLQipqnOzr2L8cRsWfWC/nkJdD9Q4FEEo+wKMV3/2gC8xSBafPPeLTLPctulIRM801bAwmI/tkiZ0mZfxpeQ8R8PmLfE=
Received: from [192.168.0.100] ([43.252.112.200])
 by smtp.gmail.com with ESMTPSA id
 md13-20020a17090b23cd00b002964142cb06sm2322884pjb.11.2024.02.06.14.44.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 14:44:50 -0800 (PST)
Message-ID: <b2160783-08ae-4ec7-8e49-e493cabac7b2@linaro.org>
Date: Wed, 7 Feb 2024 08:44:45 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] util/bufferiszero: introduce an inline wrapper
Content-Language: en-US
To: Alexander Monakov <amonakov@ispras.ru>, qemu-devel@nongnu.org
Cc: Mikhail Romanov <mmromanov@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240206204809.9859-1-amonakov@ispras.ru>
 <20240206204809.9859-3-amonakov@ispras.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240206204809.9859-3-amonakov@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 2/7/24 06:48, Alexander Monakov wrote:
> Make buffer_is_zero a 'static inline' function that tests up to three
> bytes from the buffer before handing off to an unrolled loop. This
> eliminates call overhead for most non-zero buffers, and allows to
> optimize out length checks when it is known at compile time (which is
> often the case in Qemu).
> 
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> Signed-off-by: Mikhail Romanov <mmromanov@ispras.ru>
> ---
>   include/qemu/cutils.h | 28 +++++++++++++++-
>   util/bufferiszero.c   | 76 ++++++++++++-------------------------------
>   2 files changed, 47 insertions(+), 57 deletions(-)
> 
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index 92c927a6a3..62b153e603 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -187,9 +187,35 @@ char *freq_to_str(uint64_t freq_hz);
>   /* used to print char* safely */
>   #define STR_OR_NULL(str) ((str) ? (str) : "null")
>   
> -bool buffer_is_zero(const void *buf, size_t len);
> +bool buffer_is_zero_len_4_plus(const void *, size_t);
> +extern bool (*buffer_is_zero_len_256_plus)(const void *, size_t);

Why 256, when the avx2 routine can handle size 128, and you're about to remove avx512?

You appear to have missed that select_accel_fn() resolves directly to buffer_zero_int, aka 
buffer_is_zero_len_4_plus for non-x86, without an indirect function call.

I think you should not attempt to expose the 4 vs larger implementation detail here in the 
inline function.  Presumably the bulk of the benefit in avoiding the function call is 
already realized via the three byte spot checks.


r~

