Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A654B606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yyuDKeF0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQ3o-0003uv-CP; Thu, 29 Oct 2026 09:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMQ34-0003MD-CH
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:20:08 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMQ32-0007Qy-Eq
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:20:06 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6f5a0893610so1681077eaf.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793280002; x=1793884802; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VeIDZIZ2FhIooO396WvTwCJAsYQmpp8kN5+dmjjN0O0=;
 b=yyuDKeF037EaHz2TezpKfmI3K1jRXBmkh/7yyN8z8qCHD9rW2n5e8sxqgKFX6tJNGi
 hdC8QMBzFcMKpZXG+tEA7qdUZ4Z2KudAZu4F3sC+yrY2aGYAk5hBuKG7qpiVm8HNiobG
 IkN33TUBXnxQYVa7xF+C+WCwudJrlyMQPHbgprq10EyL2SIlJlXJ7rMVnQ7sw1l4Gh7g
 H41ZF+o/Jrfa28G5y0i2m2l2Vg6NKSYKV3p4pPCuXDwiGqFRLzLe3B1uGtxlNwnTFIKe
 uo/cYOu+99k7olPzxKy9z4NbsFIJ7nWfioKvQ8nT3mkfjFmjajygHzNuiTpk2PAgnjyF
 wCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793280002; x=1793884802;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VeIDZIZ2FhIooO396WvTwCJAsYQmpp8kN5+dmjjN0O0=;
 b=IsNt8OJOWnx//qJGe+8EHOhqAdQxHbhYAdRnPlcSTGufetFDufsDXAuTuvod9Jq/ls
 XdqYgrvtcxkfRI3V1BAo9to+Eeibo6OfGoTWxT7vV1fkbhXipfN8menFL535hNQnLDFY
 8532s61VjDOkzSVhAkfvC0HLbc8v4p4qj3JBkHqzHm/pU5wKldb1tinNipbBEmPYO+2u
 BYxWeiI2XLFIUcpYn5uzW90E47goCIizXAoqpA+zeXw9tAM7+7mvS5VhZWp6b5/zzwyq
 B6jF8XjMlIHpQCVYkbP9MwBQySyMVSb0ZjhNbNYTPyoAyGO3zlNYHeJQfWk5a/56rxr5
 4Zjw==
X-Gm-Message-State: AFq9FYLH2SFPD55uuhg3+cLCU3vfheykTWqcMr7/FBYX21z0p4DfDviy
 AS+DfvVB8j/cij0Z1RuO9DUgokKKC8pNGTS0w53UWzZe2oRtzzl+YkS1UNhUfmfJ+BJ2DYiW5yW
 ToADG
X-Gm-Gg: AYBFou0hVLyiuVns2ceaS8r0VvzYEWwoY4RQ+FlIVCbAO0l9LkLZmoLJRIPBM6CoUJZ
 YM5YpwU6NQ81vlPmc8X2Uxb3pOf5CwcP2toSRwj3YhXwSSCQ5qO3vL59hYBAxaGfMj6ZLWMcLHs
 Gb9QD56bq/y/UBY0odj0PXTTH+7LZvVAZRfwAHDjtN4rJGOMS4BAHGqIPcgHxsqadS+tc0wu+n+
 zhZ+JLqbjjiSkH71ysJppKPx81Ia9A1DFD6SsfiyIxbeplH7aAbus7Sfuojq2pXwBVcCqg0C6gb
 dV1bhQPAfS06ASE9IDOn1p3i4U/QLxEPUKCV7GH/OZby4aiaQsLf7/+aqaxgXlCRahpFU8j7lzq
 bu5WVdjkHG6/+gA9buCLoWN7BfiyMKQw45AAWN4+CKpTALfXqStbY2+N29oxTpGX4uSBfk2MXmo
 QqqMzcsU+UvZP8+tm6lXkVB5IhJuF7KWU64TJIPXUnNi7fet4uHAb0/3xqONUItcvxW9TEgwl2G
 GKHHSIfRyCJGt37d8J2FrLNqWvoDTUzc6PmXWiqNyme3ZQk124aRZuVyWGEeBNieWtaAmuNXzuq
 XMXJWWwnqm7cdALIGPjZGc+Y9irR6HPjcKhcU0xbOsHV5cK7zA/z3MFEyKB+f8CCLw==
X-Received: by 2002:a05:6820:3390:20b0:6b1:afc8:3162 with SMTP id
 006d021491bc7-713eb054d8bmr2122362eaf.7.1793280001968; 
 Thu, 29 Oct 2026 06:20:01 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-7142bb765a3sm4247682eaf.4.2026.10.29.06.20.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 06:20:01 -0700 (PDT)
Message-ID: <d38a8380-9e17-4286-9b3b-a92020cb087f@linaro.org>
Date: Thu, 29 Oct 2026 08:19:59 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/33] util/cutils: Add STR_ARRAY_ELEM_OR_NULL() for
 string table lookups
To: qemu-devel@nongnu.org
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
 <20261022215115.19680-3-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261022215115.19680-3-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 16:50, Philippe Mathieu-Daudé wrote:
> Many functions map an enum or exception number to a name, either
> with a switch statement or by indexing a string table after an
> open-coded bounds check. Add STR_ARRAY_ELEM_OR_NULL(array, index),
> which returns array[index], or NULL when index is out of bounds,
> so such code can use a static table and a single call.
> 
> The array is passed as 'const char *const *', so only arrays of
> strings are accepted; hence the STR_ prefix rather than a generic
> name.
> 
> Misuse is caught at build time:
> - pointer instead of array: "negative width in bit-field" error,
>    plus -Wsizeof-pointer-div (GCC);
> - array of non-strings (int[], char[][N], int *[]):
>    -Wincompatible-pointer-types;
> - array of non-const 'char *': -Wincompatible-pointer-types (GCC),
>    -Wincompatible-pointer-types-discards-qualifiers (clang);
> - pointer as index: -Wint-conversion.
> 
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   include/qemu/cutils.h | 17 +++++++++++++++++
>   include/qemu/osdep.h  |  3 +++
>   util/cutils.c         |  6 ++++++
>   3 files changed, 26 insertions(+)
> 
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index d249f226766..ad4c778ea3a 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -19,6 +19,23 @@ const char *si_prefix(unsigned int exp10);
>    */
>   const char *iec_binary_prefix(unsigned int exp2);
>   
> +const char *str_array_elem_or_null(const char *const *array,
> +                                   size_t nelem, uint64_t index);
> +
> +/**
> + * STR_ARRAY_ELEM_OR_NULL() - Return a string array element, or NULL if
> + *                            out of bounds
> + * @array: array of strings to index
> + * @index: index of the element to return
> + *
> + * Return @array[@index] if @index is a valid index, otherwise return
> + * NULL. @index is converted to uint64_t, so negative values of signed
> + * types are out of bounds and also yield NULL. Useful to look up entries
> + * in enum-indexed string tables without a prior bounds check.
> + */
> +#define STR_ARRAY_ELEM_OR_NULL(array, index) \
> +    str_array_elem_or_null(array, ARRAY_SIZE(array), index)
> +
>   /**
>    * pstrcpy:
>    * @buf: buffer to copy string into
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 5d5695ade28..50c7ce33b6a 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -532,6 +532,9 @@ void QEMU_ERROR("code path is reachable")
>    * ARRAY_SIZE() - Return the number of elements of an array
>    * @x: the array
>    *
> + * For bounds-checked lookups in arrays of strings, see
> + * STR_ARRAY_ELEM_OR_NULL() in "qemu/cutils.h".
> + *
>    * Note: fails to build if @x is a pointer.
>    */
>   #ifndef ARRAY_SIZE
> diff --git a/util/cutils.c b/util/cutils.c
> index 91ddadfd15a..d8a04ead5a4 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -954,6 +954,12 @@ const char *iec_binary_prefix(unsigned int exp2)
>       return prefixes[exp2 / 10];
>   }
>   
> +const char *str_array_elem_or_null(const char *const *array,
> +                                   size_t nelem, uint64_t index)
> +{
> +    return index >= nelem ? NULL : array[index];
> +}
Why is this trivial function out of line?

Otherwise,
Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

