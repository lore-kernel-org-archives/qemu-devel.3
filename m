Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F05D29C2A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 13:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhpP2-00016i-MP; Mon, 19 Jan 2026 08:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhpOs-00015F-1r
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 08:34:35 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhpOq-0007V5-IQ
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 08:34:33 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so28306245e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 05:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768829669; x=1769434469; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iOxmQ1J41WXUhMgGeJVxa8iUKy2WguYwE4VADeLOhwY=;
 b=iKhoinH2kJVEYh0SpseWT2YnDTFbtKavp/PQjbZB3WZ1MfqUVvU1HHpt6ZpNJhHW9m
 nSRMUGxvhXIvze7khzf701HRGLT9egEZiYFLvigcm4EprkSFgM9yinI2a8T9rKi+IKae
 5OkV0UAxCpEMwlHNS5N5oDtqMpae6ZhcZyAWotZBnkp198NJ7kTWeA6mNKoKwt/Bv8FD
 BR1/j/OiQ2CiiQvQHTPbmNdo4zQvfDVV7XVpkwbB2P6JCkKtT99hrZDhsDP8b9KXdeDm
 99h/hKigWY5vqZRXTOeUUoaMWKDu1by3WkIa8IiVujg3NOdbLVFeiSproLrCIZU9vNIL
 JfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768829669; x=1769434469;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iOxmQ1J41WXUhMgGeJVxa8iUKy2WguYwE4VADeLOhwY=;
 b=epQEmzKq8g8+GgrJKoAxJ7TPY8iU6l3r3Og/2dmymkuKs0fqJONTNZHk4th8qpfRD/
 6QnbMIy6URE9QaW7hP/7jGkyrpG9bCqW4oXsUIKQuWZC+sm8Uo9GY7Mt9y1n2F3w8bIb
 rkzo295SIuBiPTWaUAswOuWruTMxORNAaoNWO1O8xt7FgWuIWJIJJfg1AYEIhFG0q40g
 DR3sHny8IToU5yaRQXgYFdPmSQULsX3RfYC3+kor8p3ncI2slYe5qgtiP5gFwlDnSadk
 gF+wPgMdfNtP7vqhaGiXdM5Ab4V6lzTY2+qRSoUq2SLPjHcFXFM+v9V9PynuIOfodKTm
 tMQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMVi03UKtct3SBtM60xrg4o0jOkLNu9xXm1hCkeTy7DknXOdpVqw4aAFqXimAt8rXWB7M+YjKZkADd@nongnu.org
X-Gm-Message-State: AOJu0Yz/wylLbsENuDjQgpFtTsRBe8qzj5/j21ci9MK9uPbuy3bi5h4Q
 xVBdPYEvFLeXlfLusDM+gPkz/TEw/mGnZZ2EikGl0YFy+jQlaRNZr1RhcwTq82ez+tc=
X-Gm-Gg: AY/fxX4+x4GXHYFOCXxvT50oEzJgEj2d2a2h8/45AaBA8hrkBD5cKhGjavvW0Lxkwy4
 Ine2ffW+ur7WbxAUAGlI+VNskHtoBH/RIc1BjJQQCxvRm818Xuh9oXmrl06v/32L/H8mpoLAGAv
 gWolq4Ke6OY+vtujbWvQxncPUEz8W/2/Gqj7+9yLsgYdjB8PbyFBpN9043qbUL9cODRvdgn2GkF
 q4N7gwgFMxAkmOg5G2ompQYuMvWi6cqnn9YorMCf9SgQJ51RASbrnzAeuMS0wZ3iqlgSPl6GzPd
 UOuEriM4n5TuXwOmwElbGoC9zvgzUsyx7gK95TSmknGZfT8hEI5cnP5+jq37/FFFq/dPYifw6di
 9j0rn9QSa5M2GRXyTie4U5IbS7S5+uGVj4tdMEcey0PWaQnzZrT4Gh7pXaTgvUOBUClVnOXY/Lc
 99mh31Vtf4uKOxhWhTLjx9GcvPYumgywaZwNWRwCJR5Goil9yWcR04Ew==
X-Received: by 2002:a05:600c:46cf:b0:479:3a88:de5e with SMTP id
 5b1f17b1804b1-4801eb15549mr106272385e9.37.1768829669372; 
 Mon, 19 Jan 2026 05:34:29 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8795f1sm193676665e9.6.2026.01.19.05.34.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 05:34:28 -0800 (PST)
Message-ID: <477a2765-eb33-47f7-b027-a5f7ca6800ca@linaro.org>
Date: Mon, 19 Jan 2026 14:34:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bsd-user/syscall_defs.h: define STAT_TIME_T_EXT only for
 32 bits
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, richard.henderson@linaro.org,
 Kyle Evans <kevans@freebsd.org>
References: <20260119075738.712207-1-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260119075738.712207-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 19/1/26 08:57, Pierrick Bouvier wrote:
> Commit 369c1ba2b changed the wrong conditional "#if defined(__i386__)" to
> "#if defined(TARGET_I386)".
> However, TARGET_I386 is defined for target x86_64 also.
> 
> This commit fixes it by identifying correctly 32 bits target.
> 
> Found with:
> $ ./build/qemu-x86_64 \
>    -plugin ./build/contrib/plugins/libstoptrigger,icount=1000000 \
>    -plugin ./build/tests/tcg/plugins/libinsn \
>    -d plugin \
>    ./build/qemu-system-x86_64 --version
> ld-elf.so.1: /lib/libz.so.6: invalid file format
> cpu 0 insns: 59746
> total insns: 59746
> 
> Fixes: 369c1ba2b ("Fix __i386__ test for TARGET_HAS_STAT_TIME_T_EXT")
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   bsd-user/syscall_defs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

