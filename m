Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621E9C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 16:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgRJO-0003Da-He; Tue, 20 Aug 2024 12:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sgRJ9-0002UR-NN
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 12:02:09 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sgRJ7-0007N8-Nh
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 12:02:07 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7141b04e7a3so334465b3a.3
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 09:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724169723; x=1724774523; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fdy+/mPgHXYFV6LXpgIdVTCmsAHi684eeT3IjHbx5VU=;
 b=kAW4QEeaxnuzloflj/cn0DWlCslXmCtWebM3xuF2iLa7+60LOMtWNDPacHDDoE+nEL
 Jlzwks9iqyNoHNqZ/Xni3VlbvBu6y4zQjBqSCGj8gz/khoEgSUQDochtkRwD45cTrqYJ
 oIOWwMTLQrwkYnkO9v8QKXiComc/M48YdJJ7wpPNURYJYIYmANyouyVCpIelLdGR08PN
 LVQC4UI/8T3prRUsGU8mwC8bxrTVoutYwqG0E5a9j2xO22Pmg5k0puYAmsOX3QEHPfdR
 psUYg9sJa9QEpYo5sC8t4/wRG/oNBNp7qjnJZedw1IbGLu877f6lT6R3VaW/gil9AMo9
 pJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724169723; x=1724774523;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fdy+/mPgHXYFV6LXpgIdVTCmsAHi684eeT3IjHbx5VU=;
 b=eP5IrR7AyodUoByR0XH5IPpkrK2BkbvZRcVXEpLVd5Nc/ZF1UrNEjUF9qXweo4WKw4
 NbAvxOuhsld+K1HUw2FH/tjaUEnZFkPnz8Px6O5tso0UM00sCKBHNy1ZLrp6KWUVFKt8
 wcBHD6x/WVgF4jM4graSIma9LCIxYf9mYqy8QjwS5gauEPwqhMz2diaLzVYUPxf9/aDs
 yR0NG284atpOII5s0nlVsO1ZzCKLnt0ii9axmy0N7TRVpCSSEHhgg0oKMhvLKB8hp2GT
 iIpNw4mkqWXfiQUnx8J5X3JJJ0t07+FOO7A+tFYow01rrP/G0913eJUFW4UaZNeT0W2j
 kVIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiusu30ezHPpnj/+/o/DE1/bWGMtcsEX4ZLiP2KlFycuwUBbtzIIA5xGCwDUyImQe6Fy/k2NZKpjVY2oBEyxUDYj8YhFw=
X-Gm-Message-State: AOJu0YymIL8et7HYU+eF1kPjB69yixFeTgGoOAtrDsTTS+UA2QIyXHo0
 tM2K8y3bqQ0e0Y8QHIZxYZlxx8Xm0+ETyIQU2AErCV3E8F+jNz9j5Vmo4QtZEVuTyyBp3re5Hou
 71RQLVA==
X-Google-Smtp-Source: AGHT+IF3kf1sOSfexLrfFLP+1rdFNNzJSGRnEhyKd114+jH+h4t3wEU+JROgNvNBdFHTSuVOo0T3hw==
X-Received: by 2002:a05:6a00:2d9f:b0:710:4d08:e094 with SMTP id
 d2e1a72fcca58-713c4dfbe65mr17838599b3a.2.1724169722841; 
 Tue, 20 Aug 2024 09:02:02 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::27bd? ([2604:3d08:9384:1d00::27bd])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127add68desm8387424b3a.29.2024.08.20.09.02.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 09:02:02 -0700 (PDT)
Message-ID: <5fcf8fcb-c100-4d3b-aca0-a9a46a7b7040@linaro.org>
Date: Tue, 20 Aug 2024 09:02:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1] target/i386: Fix tss access size in switch_tss_ra
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240819074052.207783-1-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240819074052.207783-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 8/19/24 00:40, Richard Henderson wrote:
> The two limit_max variables represent size - 1, just like the
> encoding in the GDT, thus the 'old' access was off by one.
> Access the minimal size of the new tss: the complete tss contains
> the iopb, which may be a larger block than the access api expects,
> and irrelevant because the iopb is not accessed during the
> switch itself.
> 
> Fixes: 8b131065080a ("target/i386/tcg: use X86Access for TSS access")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2511
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/tcg/seg_helper.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
> index bab552cd53..3b8fd827e1 100644
> --- a/target/i386/tcg/seg_helper.c
> +++ b/target/i386/tcg/seg_helper.c
> @@ -378,7 +378,7 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
>   
>       /* X86Access avoids memory exceptions during the task switch */
>       mmu_index = cpu_mmu_index_kernel(env);
> -    access_prepare_mmu(&old, env, env->tr.base, old_tss_limit_max,
> +    access_prepare_mmu(&old, env, env->tr.base, old_tss_limit_max + 1,
>                          MMU_DATA_STORE, mmu_index, retaddr);
>   
>       if (source == SWITCH_TSS_CALL) {
> @@ -386,7 +386,8 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
>           probe_access(env, tss_base, 2, MMU_DATA_STORE,
>                        mmu_index, retaddr);
>       }
> -    access_prepare_mmu(&new, env, tss_base, tss_limit,
> +    /* While true tss_limit may be larger, we don't access the iopb here. */
> +    access_prepare_mmu(&new, env, tss_base, tss_limit_max + 1,
>                          MMU_DATA_LOAD, mmu_index, retaddr);
>   
>       /* save the current state in the old TSS */

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

