Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECD4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 05:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sepyH-0002Kz-3k; Fri, 16 Aug 2024 01:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sepyF-0002IJ-Mb
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 01:57:55 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sepyD-00018l-0Q
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 01:57:55 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5bec87ececeso787873a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 22:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723787871; x=1724392671; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=moxxOXsf7VBnzDKqQVZCJVJPXVi+ejimRY+DSd29oIw=;
 b=V4NCTGaH/0BoaiKiK2xf/Uyocc5sMCk3a1Og0wS0TqA3tUbXjoVU+LoAfZ/a4sqns+
 4BgZI3qvm4Q1XzAWNvnCiQW5uJGhLOWxH6/PIqOQTLaHeRIfJWRaYL4ia/5ltMkYG71Y
 RrKeMbRpOf6ytbWGVKvL326kRNMM1fFYlKNohjZXeCLCHVlnO4GDDjoCCDu2o/wdFAu2
 TeqdFoqHeX5vIDSN1c5ysck+JPpGAAyHmVGXcUCnu1B4OuxUg5pM6+141JlTW4n12Cc1
 Unu22NkAZLGJHJIcHsYme4jFtSoaPOLJX0uYkxVClcHM004OUSR3okcTwQnDKIWjqDyW
 nXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723787871; x=1724392671;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=moxxOXsf7VBnzDKqQVZCJVJPXVi+ejimRY+DSd29oIw=;
 b=q7jPhy3TfB1ZOGn3hx5jjoU33U3FMy7Bu/jb5wpLVxgioLIUlsWcmK6tq9ZW7lZxoQ
 +05WTeBaYT0EWO+mpf9vX+PPrgBToU2NoqxPfUSFwcjpEmpFWKUaNJE/ZklaGay5dOwF
 nxLAF3XkyNTeXvo+aHqOtfSZNb9L4/Io3CHDxROa7K72eYUhTNAUAv7vaGP9jllFN76m
 KB4ybPinj5rXq+frP0I+yC5I4wdjK+mG9Avu2mw0baD08FiaWsKbQXCqLtGeqzMR5l3J
 pD6BYRRxnW77x7/LL/c1+FnSteTo4MLQMQeSvdVnb4Pm8FVorCnTQZFRsz7ZgyMJtP3u
 KdnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsHEKW8mGZfrKe0IFa0zeQYNv9leyHpququvVxh419toAj8TMLscOv2IcdhFslBWyDQrMC7XMWKgJ/X6j6yVogY6cSN2U=
X-Gm-Message-State: AOJu0YyL2VLt22+ny4QoosciLMfCYNVNWPkpKzTognRVBeXp6lToZCvY
 OCY92CjeVeljtmXwuCvA3sxyq8wQgGESmX1ThPrJrJr112Z5P9yqKNZ0T+RUxBw=
X-Google-Smtp-Source: AGHT+IFtWWytK/+gu3rT2K0uxB2bbpXFdj46+Y197ohDDR8v1XlUFcnDxXXczp73HcTDc6euvns1zw==
X-Received: by 2002:a05:6402:26ce:b0:5a3:b866:eaee with SMTP id
 4fb4d7f45d1cf-5beca4d9518mr1134896a12.7.1723787871154; 
 Thu, 15 Aug 2024 22:57:51 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-185.dsl.sta.abo.bbox.fr.
 [176.184.30.185]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebbde48a9sm1750874a12.25.2024.08.15.22.57.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 22:57:50 -0700 (PDT)
Message-ID: <8fe5dda6-a72d-4c63-8c57-75197709da9b@linaro.org>
Date: Fri, 16 Aug 2024 07:57:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1] linux-user: Handle short reads in mmap_h_gt_g
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, qemu-stable@nongnu.org, Warner Losh <imp@bsdimp.com>
References: <20240815213231.303424-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240815213231.303424-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

On 15/8/24 23:32, Richard Henderson wrote:
> In particular, if an image has a large bss, we can hit
> EOF before reading all host_len bytes of the mapping.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: eb5027ac618 ("linux-user: Split out mmap_h_gt_g")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2504
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/mmap.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 6418e811f6..de9ab13754 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -853,10 +853,21 @@ static abi_long mmap_h_gt_g(abi_ulong start, abi_ulong len,
>       }
>   
>       if (misaligned_offset) {
> -        /* TODO: The read could be short. */

I note there are other short reads in {linux,bsd}-user/mmap.c.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> -        if (pread(fd, p, host_len, offset + real_start - start) != host_len) {
> -            do_munmap(p, host_len);
> -            return -1;
> +        size_t o = 0;
> +        while (1) {
> +            ssize_t r = pread(fd, p + o, host_len - o,
> +                              o + offset + real_start - start);
> +            if (likely(r == host_len - o) || r == 0) {
> +                /* Complete or EOF */
> +                break;
> +            }
> +            if (unlikely(r == -1)) {
> +                /* Error */
> +                do_munmap(p, host_len);
> +                return -1;
> +            }
> +            /* Short read -- iterate */
> +            o += r;
>           }
>           if (!(host_prot & PROT_WRITE)) {
>               mprotect(p, host_len, host_prot);


