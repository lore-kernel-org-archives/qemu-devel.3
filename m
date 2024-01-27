Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56401C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 08:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTeBN-0001K4-II; Sat, 27 Jan 2024 03:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTeBK-0001Ht-US
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 03:36:54 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTeBI-0002st-CL
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 03:36:53 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-602cab8d7c9so13219307b3.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 00:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706344611; x=1706949411; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3ncPNZiWACSYqaCt1mupjvQcXAKTGXK/opAvlbOeCCQ=;
 b=p269fVmI8pe7giVWIjytgRXuI2qTI+ag/IAo4SAExFsyU7vqgA6mYc1hy5koaum+x6
 x0Xn4yc62EWWJO66Ipyb04Z5NaKhh/nswZ5o5Lv9BK328M8fVrJCjCCKmDk3RzDceeXy
 5n5UZmk91yuFLRwMiKmz3e7WVsYgfWweAdX8xGjlWeMpJwNyDeRaw896IZt0l5OTVZhz
 1GSFOmEhZpZkpzvUPKPknRyHTIFtyr3OXt/ntRm94XbugpSa6BVnw4pCLh+nyIZVwbDj
 01gqWRdUnfxhTJ63CwDmbuWfDyMrMXtJtw7DwWQgmTuVC3t8X+vtSZ5sYUn97xdwQQi7
 oLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706344611; x=1706949411;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3ncPNZiWACSYqaCt1mupjvQcXAKTGXK/opAvlbOeCCQ=;
 b=ofHx8sMIKfq5Vg9jgs7QGxWwDqZvCNVfHPCGqjrldj0KZClrXZNS0JYbLdyh9jwaN/
 kO5khboUrTxINqJrlhCeN5Fa6JhVlnAz32hqZOoyZq/PeiW0Sd6UeUc9QkcNfhSU+EVs
 PQNmF10X6ZpKbYQ58JHSLucPy3wOjA91mcJooRGxlVQkMuP2jY7qYQPjOs4+U/yWaMfM
 trz3IOS9XElCAQL+pf1TEr6i9BZyW3g/Tu3wZ+N3exTbwkNDBaS1pwtKYKwA0QVJoaEa
 vov1EEXzzliTpVsvTh/2L7xmjWnJlYD0LvHap7/dufvxK/mx0dyae1HOBCYyFxUZfgI0
 gjbg==
X-Gm-Message-State: AOJu0YxSEuAOX7KM4ab2roeKk5aYbUgdU5E91APo5YJlNJ37crve9EZR
 NMa9MkBedJIxQ1D0Pts64w1Ev67zpoau6fw6DnpgDXWdt4vEL2LZFtc6+tzDabk=
X-Google-Smtp-Source: AGHT+IEbCcb/s4nsgm76+0DljmBx3FUZaGrpaVodST8RdIhuZlZGtqr3R0FFnYLfAR4KxNi59KdqDg==
X-Received: by 2002:a81:a08c:0:b0:5f6:e869:2a7 with SMTP id
 x134-20020a81a08c000000b005f6e86902a7mr970342ywg.99.1706344610838; 
 Sat, 27 Jan 2024 00:36:50 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:f4e4:75ba:818d:188a?
 ([2001:8003:c96c:3c00:f4e4:75ba:818d:188a])
 by smtp.gmail.com with ESMTPSA id
 u79-20020a0deb52000000b005ff8b88a631sm964230ywe.133.2024.01.27.00.36.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jan 2024 00:36:50 -0800 (PST)
Message-ID: <a88b1741-21df-424f-8ca5-56950d21032f@linaro.org>
Date: Sat, 27 Jan 2024 18:36:42 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/34] exec: [VADDR] Move vaddr defines to separate
 file
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-7-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-7-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112b.google.com
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

On 1/20/24 00:39, Anton Johansson wrote:
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -14,18 +14,6 @@
>   #define EXCP_YIELD      0x10004 /* cpu wants to yield timeslice to another */
>   #define EXCP_ATOMIC     0x10005 /* stop-the-world and emulate atomic */
>   
> -/**
> - * vaddr:
> - * Type wide enough to contain any #target_ulong virtual address.
> - */
> -typedef uint64_t vaddr;
> -#define VADDR_PRId PRId64
> -#define VADDR_PRIu PRIu64
> -#define VADDR_PRIo PRIo64
> -#define VADDR_PRIx PRIx64
> -#define VADDR_PRIX PRIX64
> -#define VADDR_MAX UINT64_MAX
> -
>   /**
>    * Variable page size macros
>    *

This patch does not compile standalone, because the new header isn't included here.


r~

