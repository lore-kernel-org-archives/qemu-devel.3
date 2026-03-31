Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982BAFF60F4
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 18:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7dSm-0001UP-EN; Tue, 31 Mar 2026 14:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7dSj-0001Qk-Lc
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 14:05:13 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7dSc-0002yl-47
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 14:05:13 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-486fd27754bso58852885e9.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 11:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774980302; x=1775585102; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=foSv8Vqtqx4VyVwFuN20VB+Oj1GsrSNAOdP75TJQPrg=;
 b=stMQCRRddpq4XhBaY5wsV+zt6ZjXJz7pU5UepS6ZluMXnD/Iva+e6/vmufhnoReJMb
 2fo0goVtVwKrh60DcwE1hRYMtRfIAJbKICWwR8Q8P1c+GCiwCjtYlXtmQVbp2ZWm9uoQ
 kdfuMqDUmEip78qtkb8JxKGjouePQPFwDA4WeS8m7KEqyHV5DNEMBb3yUydn5AIo7kWk
 n9ounTW6La9gWsc7Jj6QXe3pEeAb0FiwuRoj/XaHBSYE7sU8pZnHH2GlyrT6UttbhuTH
 w7u7qgdh6veViKJNzdTC+CBnpgWrhY9LxUP+p3AgAJn77fQgavnd92uFkBJXGwm/LSyp
 Ef0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774980302; x=1775585102;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=foSv8Vqtqx4VyVwFuN20VB+Oj1GsrSNAOdP75TJQPrg=;
 b=iSzwwwsaNqwSwnPdn1sWFvo8maWYu+FHCXcIU1nVa0JzYzXa0n0AKIGcMh1YUOyeEk
 RwJs+2poGAwBq0O0m4NxmFqmCu7/ph8YLxzWRHOnMvttGAe0mE9A+4XQfT5BQgn2Kd59
 hDVGzaOqaCpwmYky2TdxYlVbu4XtJPDqGUad2x8RZXpvf3UWp3n5V0tRKmhV0oOUIm/B
 +2ToQXIzS7AsQ1sqwz5+rITwl6Jo3McW3MOarnLeBN4xjq0NdR1p2m+8Y7K/sGzKhCcC
 EjzaozpuqvJ5ePfiVk/U9u5wxcm0jrs6gBrPuBnLYDWQQNpHtkoceJTr2eQtiWj+9sXd
 jKsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnuBGQaspDrbRMYIcCmhNZQA4R+4zzSQ3RD4pP65snRLmKnLOnD83+n1hNrqbZuyFTw4RMnhUjHg1k@nongnu.org
X-Gm-Message-State: AOJu0YzE1VRaAh9cIpHxkARulYajvNtwF14gekgIE/NWtFLaL3RxIEMo
 ulmymqe8vR9r2BaTCZ72OHbDisymQCkQ4FgUYtC8wSbf22Jfjz3/QIVEq/VUQKHDeJA=
X-Gm-Gg: ATEYQzwd4cyjXg0kLuWYIK/mKGU5/h7cvhf6c+WyxroZy1U/lQpAUdkVXuk4txN9ffx
 R5GhNe8b6mzzQa0pgAoh2On2biLSPB9++R6jdfIkS4MgQbI1haaILIcSR6+rOpuAdtfhKylEI0p
 HSci76d51ptXdz67C4IzREjOxQXgubvCk4H61szY+L/vggkyg+RVHrupNDP/9tljWRHy017WIkZ
 KfLShbfLmjGQtbCKjiREKz0Ovg0QozM1iesxsSXCpEFydF/NmeogJj1TzRcNYvk2/re6naSYUkF
 SmXO+COzS1tNT16X+WBzAPrn8p7iMOc2y4IVe0ObVaebBjh0j9DoUD1g2tD8VMVNS78hrLlF7dC
 QqdIkHblzDfTP/gLAM/Dm54j+agm/RTKcPL5z+bS9gZjU+6qRA4JjTaDhP8+Sh9tfokZx+NhT1t
 OuYRNyr1zlxOnikjjAkuRn7RX1IOZiHQHb7U7ibS2uXzlDDHHAC94T/YKhSpBYmnXUvQ==
X-Received: by 2002:a05:600c:3b1f:b0:488:7c98:e9df with SMTP id
 5b1f17b1804b1-48883306d7emr7209615e9.0.1774980301778; 
 Tue, 31 Mar 2026 11:05:01 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c8bcaf8sm20499005e9.27.2026.03.31.11.05.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 11:05:01 -0700 (PDT)
Message-ID: <b3c7f43b-37e8-47b3-a516-23254f73bbc1@linaro.org>
Date: Tue, 31 Mar 2026 20:05:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] include/user/guest-host.h: Provide g2h etc for both
 abi_ptr and vaddr
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260330143123.1685142-1-peter.maydell@linaro.org>
 <20260330143123.1685142-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260330143123.1685142-3-peter.maydell@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30/3/26 16:31, Peter Maydell wrote:
> In commit 7804c84a ("include/user: Use vaddr in guest-host.h") we
> changed all the functions in guest-host.h that took or returned their
> guest address argument in type abi_ptr to instead use vaddr.
> 
> This introduced regressions for the case of a 32-bit guest and an
> address above 2GB for the common situation where the address is a
> syscall argument stored in a variable of type 'abi_long'.  With
> abi_ptr (which will be an unsigned 32-bit type for 32-bit guests),
> the address is cast to unsigned 32-bit, and then zero-extended to
> 64-bits in g2h_untagged_vaddr().  With the switch to vaddr (which is
> always a 64-bit unsigned type), the guest address will instead be
> sign-extended to 64 bits, which gives the wrong answer.
> 
> Fix this by providing two versions of the affected functions: the
> standard names (g2h(), g2h_untagged(), guest_addr_valid_untagged(),
> guest_range_valid_untagged(), cpu_untagged_addr()) return to using
> the logically-correct abi_ptr type; new versions with a _vaddr()
> prefix use the vaddr type.
> 
> accel/tcg/user-exec.c must change to use the _vaddr() versions; this
> is the only file that uses guest-host.h that we want to compile once.
> All the other uses are in linux-user and bsd-user code that
> inherently has to know the sizes of target-ABI types.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 7804c84a ("include/user: Use vaddr in guest-host.h")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3333
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   accel/tcg/user-exec.c     | 26 ++++++++--------
>   include/user/guest-host.h | 62 +++++++++++++++++++++++++++++++++++----
>   2 files changed, 69 insertions(+), 19 deletions(-)


> +#ifdef COMPILING_PER_TARGET
> +
> +/*
> + * These functions take the guest virtual address as an abi_ptr.  This
> + * is an important difference from a vaddr for the common case where
> + * the address is a syscall argument in a variable of type abi_long,
> + * which may be smaller than the vaddr type. If you pass an address in
> + * an abi_long to these functions then the value will be converted to
> + * an unsigned type and then zero extended to give the vaddr. If you
> + * use the g2h_vaddr() and similar functions which take an argument of
> + * type vaddr, then the value will be sign-extended, giving the wrong
> + * answer for addresses above the 2GB mark on 32-bit guests.
> + *
> + * Providing these functions with their traditional QEMU semantics is
> + * less bug-prone than requiring many callsites to remember to cast
> + * their abi_long variable to an abi_ptr before calling.

Nice fix.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> + */
> +
> +static inline void *g2h(CPUState *cs, abi_ptr x)
> +{
> +    return g2h_vaddr(cs, x);
> +}
> +
> +static inline void *g2h_untagged(abi_ptr x)
> +{
> +    return g2h_untagged_vaddr(x);
> +}
> +
> +static inline bool guest_addr_valid_untagged(abi_ptr x)
> +{
> +    return guest_addr_valid_untagged_vaddr(x);
> +}
> +
> +static inline bool guest_range_valid_untagged(abi_ptr start, abi_ptr len)
> +{
> +    return guest_range_valid_untagged_vaddr(start, len);
> +}
> +
> +static inline abi_ptr cpu_untagged_addr(CPUState *cs, abi_ptr x)
> +{
> +    return cpu_untagged_addr_vaddr(cs, x);
> +}
> +
> +#endif
> +
>   #endif


