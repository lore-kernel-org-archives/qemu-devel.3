Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929D3C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 21:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tspfp-0004qJ-Q3; Thu, 13 Mar 2025 17:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspfn-0004ka-DZ
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 17:00:59 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspfl-0006Uu-NR
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 17:00:59 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ff4a4f901fso2477971a91.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 14:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741899656; x=1742504456; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=caBoXKqvau9tVBUWPc04AEUBWCoaXhBbw/yVJjhKclQ=;
 b=GVNdIWkaQ5oGCajU6q+WQVwseKroL6Va/jYriPVZgA6K0ObUb9pYw7hc14e4VOhMgz
 HrYT/fGzEpJzWuoW2ImN4zH9ZqUkxRNYX0ajmLYJFLo64FebWm1hWtBu6rj5EftWNKuc
 kFX7gkm8gVTcxV0dq7KVvMuD0JDMarBkLnFckYkIap8zx8rDKu93xy1BJfYjFLqyYZia
 JPN5X1XTm09ps0pQchZBe1lS0wf0+nVfaIdbKOAejyzursFaRHkRvfyU4Lc7OCb5m+dE
 bT1fbW3CjIuJfzRRQhqoXfZURltf11fOA7CE3Swzi60ArREcsKX2A2LAsP/HsJa+AYlU
 X8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741899656; x=1742504456;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=caBoXKqvau9tVBUWPc04AEUBWCoaXhBbw/yVJjhKclQ=;
 b=j/J+B9y3wjXvKB10idYo+FTD+S7MYd4SdX4pLs1sAzhxWpcEwM74qNSgD6QHBxad1x
 Ua1WS2DLAdCbIFmcYeE6wP94B5AsPWH4GuX81CZA2R5LVIbxJi/IkzAPUOgwheVtA9jE
 LpLLdbel6XGar0DgkrkimZfOlOww+7rpanBgky5XQ8JCFZBkH09KrT+0lM7aeH7HO6Bq
 yaws48PJL9NLy7MIQqZtLYzOlHoQoXO80heFzub0Wfu1uFYXWTLrn5lQ96Z75GP2V+zo
 8wIU+/FFuWEwoX/PuK9SbH4go/bKC/+pisRSpN+xT7k9XICVDDPU13NFaqdiRvT1ds0e
 2Iug==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8E4szJQ6wMe1GPkeNWd+bTvJyMQi9NeeDb0fGZiJLoLKqu3FrVxMMGYSligHYdqA0eZ8TZut/Av56@nongnu.org
X-Gm-Message-State: AOJu0Yzes8EctbZrVGjLoW2U7axkkx7z5K0QwHaMSahYV+FuAzJs45TK
 9fhKmuh7dyG/kvYe0PkvEmPy/qjbwTm6Ql8V3sFgccobxxwlmmMbWQ4KnB3tVqA=
X-Gm-Gg: ASbGncsg/RiFF0/c25tMeyzAGZxG2YWPDvAP5D0kqNzWxyE70PSBq5UmhEs8TeCI9aV
 W+AT6K4Zl+v3KkkNPniCoB6uwqy7CSCCNoqEmt3DEitHQfzgY/AbL9ScEaoLZdZppGY5FuQlBzs
 OACU0qL3gDN9L0abIohdKBwR5PikIVYDaBrGhrDHSoATWA4TEVcz6Z1iLmpfBBXrvE4fK3z3K3G
 7iQoZd9vwoTJU6KWYyASGMjozqfyYPeCINIUhHAwk2yWRKxApPosmkfalxmoZnfHI0E1lAL5riX
 tX/qkXP52Rfw8gqVSgpaV9tQ6mX/eoML+W8TUnTkQWWmsOZtMOWB2MpvGg==
X-Google-Smtp-Source: AGHT+IGmrmVHGSQNwqsbav8ropnMeTcwELp46TvZbftpxw8DDSbs6YoyHUIpNUTYg+3fU6dmevTE8Q==
X-Received: by 2002:a17:90b:2f0b:b0:2ee:ee77:227c with SMTP id
 98e67ed59e1d1-30151c9a3cfmr2625a91.3.1741899655952; 
 Thu, 13 Mar 2025 14:00:55 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3011823524dsm4322982a91.15.2025.03.13.14.00.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 14:00:55 -0700 (PDT)
Message-ID: <83cd895a-7a75-4e16-a133-a6bcf1186df3@linaro.org>
Date: Thu, 13 Mar 2025 14:00:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/37] include/hw/s390x: Remove ifndef CONFIG_USER_ONLY in
 css.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-34-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-34-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
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

On 3/12/25 20:45, Richard Henderson wrote:
> We were hiding a number of declarations from user-only,
> although it hurts nothing to allow them.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/s390x/css.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index cd97e2b707..965545ce73 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -238,7 +238,6 @@ uint32_t css_get_adapter_id(CssIoAdapterType type, uint8_t isc);
>   void css_register_io_adapters(CssIoAdapterType type, bool swap, bool maskable,
>                                 uint8_t flags, Error **errp);
>   
> -#ifndef CONFIG_USER_ONLY
>   SubchDev *css_find_subch(uint8_t m, uint8_t cssid, uint8_t ssid,
>                            uint16_t schid);
>   bool css_subch_visible(SubchDev *sch);
> @@ -262,7 +261,6 @@ int css_enable_mss(void);
>   IOInstEnding css_do_rsch(SubchDev *sch);
>   int css_do_rchp(uint8_t cssid, uint8_t chpid);
>   bool css_present(uint8_t cssid);
> -#endif
>   
>   extern const PropertyInfo css_devid_ro_propinfo;
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



