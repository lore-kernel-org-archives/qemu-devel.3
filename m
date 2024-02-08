Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374D4C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 20:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYAgI-0004xl-HY; Thu, 08 Feb 2024 15:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYAgH-0004xN-4x
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 15:07:33 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYAgF-0002GN-LA
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 15:07:32 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d51ba18e1bso2005475ad.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 12:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707422849; x=1708027649; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1J/T0NWpLpQNugR1MVsfCXzq0xs5VWOLjbRJqqhRDE4=;
 b=OgK4N1e8s9jhnztbqxdjBkFvF9GmRs63sxiMGs3OkB2IIEiNcbW56MZ2+aNV6Ya+2L
 8EJFkWeby3fVdq0g2Ynu0f4dTE402HnolhgC/f/zUyBE7hp+EtuonBnm9lSIEi7sNi2H
 znCUG5dd4khRHQuh+2nl+8yvApUUg1I8YO0js5aqNJVIXBBjchy2YRPaSOu8i2i0IdQ4
 C7jDRVNo2UNPfUwK2dg1my+Pp/UV0zLqFGGsx9LffFisuaNA+7mn+xZAbfPNSSKZzzoL
 LuxY3JWBCIAXjHjN+x6Sav9gvfuCXQ1d7RpUDRAHTTsUitHUXhnBJuyuMyDHuibWOQai
 idTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707422849; x=1708027649;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1J/T0NWpLpQNugR1MVsfCXzq0xs5VWOLjbRJqqhRDE4=;
 b=RSCZITDjUCXyzF2J2sx7dU5v64OLbE8HVKqFilhLak00uLpubry4fDgokQf4UT0wxU
 dAnn70dy5mRUZEF9KdZAkHm9xKu3qF9y2oMZSE1FD0anKEURfhNElEYhURbzLFv66MwQ
 IOpDdglfXuAJq9Vi02GjFEvndIF8sgaKZb+8NChrv4xkBcln9WFkLQhsJxgV/pQ76iv2
 h3Dfmf18LDidlkOGO7FbNQWBgc3PtWe4JQQ/gE+91+WZTC6+KQhnuQlby33yAJnL5JxC
 sukdsdsYnOy8kuaQG5K37jg68Gi/RZ/ZUzGRbhiFOsgyZ3U0p0UaHdkwnvz9LjhJTc6g
 D1QA==
X-Gm-Message-State: AOJu0YzgBhq5yvkeQEW1Dt7t5vbRQL2DMPSOJ3TiH8+fww7DU3/LP23m
 GuTyHGg7w2d2tMrzBfpfUu7v8zrrRGZuca6na7VwbtkV8Pxmxq3xKgFrlkUxbQ1qneeO30Djb7x
 8
X-Google-Smtp-Source: AGHT+IFGOviUdrAnbCvmrWc8vU/YWL4enTUbS6YwZ71fcWBjgbjrq/jgqBfwk20dLN2UaDbiA8+xpQ==
X-Received: by 2002:a17:903:18b:b0:1d7:428f:50fd with SMTP id
 z11-20020a170903018b00b001d7428f50fdmr204830plg.31.1707422849467; 
 Thu, 08 Feb 2024 12:07:29 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWH7zvwlFu28iVq/+Fhl/1wxEzKdhr/9Ejw7toZpqE2lGdeozoE2XPSWD46yuQAOJD5HNcEJb9mJDS6XwllU56fbRBvuIzLMS1KiyHmx/UCBv9NTdVRK3jw
Received: from [192.168.4.112] (066-027-223-101.inf.spectrum.com.
 [66.27.223.101]) by smtp.gmail.com with ESMTPSA id
 e16-20020a170902cf5000b001d77a0e1374sm147972plg.151.2024.02.08.12.07.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 12:07:29 -0800 (PST)
Message-ID: <099ba824-7e79-4c2b-a548-5922d69a5720@linaro.org>
Date: Thu, 8 Feb 2024 10:07:26 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] util/bufferiszero: introduce an inline wrapper
Content-Language: en-US
To: Alexander Monakov <amonakov@ispras.ru>
Cc: qemu-devel@nongnu.org, Mikhail Romanov <mmromanov@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240206204809.9859-1-amonakov@ispras.ru>
 <20240206204809.9859-3-amonakov@ispras.ru>
 <b2160783-08ae-4ec7-8e49-e493cabac7b2@linaro.org>
 <cdbe132a-38e0-1200-bebb-ca0dfc3e1e7b@ispras.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cdbe132a-38e0-1200-bebb-ca0dfc3e1e7b@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 2/6/24 21:13, Alexander Monakov wrote:
> Thank you. I agree we shouldn't penalize non-x86 hosts here, but to be honest
> I'd really like to keep this optimization because so many places in Qemu invoke
> buffer_is_zero with a constant length, allowing the compiler to optimize out
> the length test.

Hmm.  True, both migration and image copy use large blocks frequently.


> Would you be open to testing availability of optimized variants
> in the inline wrapper like this:
> 
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index 62b153e603..7a2145ffef 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -209,11 +209,12 @@ static inline bool buffer_is_zero(const void *vbuf, size_t len)
>           return true;
>       }
> 
> +#if defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
>       if (len >= 256) {
>           return buffer_is_zero_len_256_plus(vbuf, len);
> -    } else {
> -        return buffer_is_zero_len_4_plus(vbuf, len);
>       }
> +#endif
> +    return buffer_is_zero_len_4_plus(vbuf, len);

Plausible.

Also, now that we're down to two variants instead of four, perhaps a statically predicted 
direct branch or two might be better than an indirect branch?  E.g.

bool buffer_is_zero_len_256_plus(buf, len)
{
#ifdef CONFIG_AVX2_OPT
     if (select_accel & CPUINFO_AVX2) {
         return buffer_zero_avx2(buf, len);
     }
#endif
#ifdef __SSE2__
     if (select_accel & CPUINFO_SSE2) {
         return buffer_zero_sse2(buf, len);
     }
#endif
     return buffer_is_zero_len_4_plus(buf, len);
}

where select_accel would be set by test_buffer_is_zero_next_accel() etc.


r~

