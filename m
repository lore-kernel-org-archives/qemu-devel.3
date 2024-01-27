Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9DBC46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 03:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTZmn-0006K9-7B; Fri, 26 Jan 2024 22:55:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTZml-0006Jm-0f
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 22:55:15 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTZmj-00087w-DH
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 22:55:14 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5ca29c131ebso1272611a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 19:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706327711; x=1706932511; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QSFyf+dQHWq/uDnTL+ezQMCVKGeItK20rV9aVNH28FA=;
 b=TTHNPCQ4/mOs6WD6YwjaEIf5uXaMBwb/mwhilafESl9DXGPIsdQ9FyyTD+dEgDQtEn
 UvdkEfgUuBY9JX3oHXD0U9yxDPCDZcH3GyTlQXK66gpiX9j0VyHT75MBnZ0y50C81JKn
 zYxg5fjPfLkSUoiFLtIDrgERMxWG7br0+/lH5Q8RQOm2Ue2hagPdppToi8grpI7+udYY
 9n7sPRopWY1417VycYUVpcoA43YpjqyYVo54vQkqM8yozAb8EF2ht3twfqGX15c1LJvv
 b+mcvFeFj1ctNtJKXVGFSC5kELQXu0UMKryXPL1IfVjtRYAOMtTpzroMBK+8Ha8BkT9n
 ZXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706327711; x=1706932511;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QSFyf+dQHWq/uDnTL+ezQMCVKGeItK20rV9aVNH28FA=;
 b=HV3q/CmDMJi+fErSAkG1J5cXhtLnpm4wy1gpHHjEp/88s8UnLTyuDTgQINgEhIqoHa
 fDIUUiaOrzOd24G6jS2Ffidr7E16EcMqnaaF4K1DaNHEzhkksNlnpAOOd5AHHmkQ1UmJ
 ze3kuaIhUNii5a2GrLdrs6u/HJR863EvBqbIQuFCIAbO+AP+DZReNMCY/z88VSsaVJtw
 virNZzs3jHTsIYljZe+HPwLtT3yszjSHBScGW1vDnwg9+iN+DxXHK3xAssSMr0ZhsDmu
 QSf+rBnblRJdJ1zzMeUzIRmbOF4yfUC9O/8br3Djln4NXFDLxTPuj7QsYyMLdR0OygBn
 WXzQ==
X-Gm-Message-State: AOJu0YysnxtRAVtC7na7VvGdkWM+pWiwpvquoeVUvbTC3LqACUMvjqmu
 0buwFV1ruyZj7F9oTte0JqATWcTtgf5Ydq+VlhE6wDJp2g9O4+7PUTlKfByc1+o=
X-Google-Smtp-Source: AGHT+IEJnBm7RppAhbjrkkBhEccCK2ih7K+KgFCaqNhS1uRTvIaWGcbU0nJVzG2v624d+vYCgx5leQ==
X-Received: by 2002:a05:6a20:a29b:b0:19a:fbd9:2651 with SMTP id
 a27-20020a056a20a29b00b0019afbd92651mr720628pzl.110.1706327711568; 
 Fri, 26 Jan 2024 19:55:11 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a62ab04000000b006ddc0c04d58sm1817099pff.110.2024.01.26.19.55.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 19:55:11 -0800 (PST)
Message-ID: <9e74cf9e-9485-4e9e-ad1b-b593b562114f@linaro.org>
Date: Sat, 27 Jan 2024 13:55:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] {linux,bsd}-user: Fail mmap() if size doesn't fit into
 host's size_t
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Warner Losh <imp@bsdimp.com>,
 Laurent Vivier <laurent@vivier.eu>
Cc: Kyle Evans <kevans@freebsd.org>, qemu-devel@nongnu.org
References: <20240125200731.2633-1-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240125200731.2633-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 1/26/24 06:07, Ilya Leoshkevich wrote:
> s390x's branch-relative-long test fails with the following error
> message on 32-bit hosts:
> 
>      qemu-s390x: ../accel/tcg/user-exec.c:493: page_set_flags: Assertion `last <= GUEST_ADDR_MAX' failed.
> 
> The root cause is that the size passed to mmap() by this test does not
> fit into 32 bits and gets truncated. Since there is no chance for such
> mmap() to succeed, detect this condition and fail the mmap() right away.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   bsd-user/mmap.c   | 4 ++++
>   linux-user/mmap.c | 4 ++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
> index 3ef11b28079..5dc327d0ad3 100644
> --- a/bsd-user/mmap.c
> +++ b/bsd-user/mmap.c
> @@ -256,6 +256,10 @@ static abi_ulong mmap_find_vma_aligned(abi_ulong start, abi_ulong size,
>   
>       size = HOST_PAGE_ALIGN(size);
>   
> +    if (size != (size_t)size) {
> +        return (abi_ulong)(-1);
> +    }
> +

I have this same fix in

https://lore.kernel.org/qemu-devel/20240102015808.132373-18-richard.henderson@linaro.org/

so as far as that's concerned,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

But perhaps you got cast your eye across the larger reorg,

https://lore.kernel.org/qemu-devel/20240102015808.132373-1-richard.henderson@linaro.org/

?

r~

