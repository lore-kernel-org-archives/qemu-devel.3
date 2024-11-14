Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C78D6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeHE-00076h-4Z; Thu, 14 Nov 2024 13:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeHD-00072f-0G
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:09:07 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeHB-0003j0-DW
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:09:06 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-720be27db74so739053b3a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731607744; x=1732212544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NeaCN6i0e89IXcBzo4NkvN87duM0mCertmoCbm4YPhs=;
 b=KyAf0hqp59L/ggXtlN/jwt1qXaOVQO8V3lPmRKtah7/+3XrtFo0n1vnHXepAdZs7Ya
 WDPEmMvC8zWs9gBYbDggBXVJRX/XDwXtvJX1g/bv1T72wdegokbDJmReT7RerMu6Hj79
 YDGyTrgAbSQeF/TUpKhCKCefw9g9tGj5f23kUwVsMiRxGW9FVdBrFC9zU01kk+o295Vx
 Aot3mdgE6QWK+8SmRFCuIyC0owy2ZZLPe7iNxcMibP1+NsY236Lq3sa5UaNgwaeRBw4f
 1AEJh4dnij3kWV4UNTd90zcaWljMkrNlQvkYf9RwcziZLnqJ7cZLR9rzizN1Cngv78vL
 gJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731607744; x=1732212544;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NeaCN6i0e89IXcBzo4NkvN87duM0mCertmoCbm4YPhs=;
 b=suKVuePa6k6rTLAEo/HvGd7b29C7lnCU9Yz5ayrP2iJbGQxcqpWY5qNcWduAqJILCz
 9NWXzM/y99hEKyeKXC2DSC0lH0rbja693y7izHkmCGhtD+e53yX1Au7mmRn4QFdSsRKs
 qyAOFquFdzeH9co5w/x6GNTyvS0IjmK1wsxVIiAyrEyKWDLPcbZ009hUXi9UuHA17RSE
 3EoH5CyLOkXBGTAHDaqf3/dqb8S/RhNKXF9cyWeysFfwk0Snl3iRsvGdrToLZhMHbt2X
 NLnXm5eIc3kha7iUCeQozVBTdUDGC1WLy18SUo2G34lVSn6+vByVC155h3xZyxB16lsO
 8zWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOXWxHQIfkcBRXfI7RhenlOyek5BT/hLZmoixk9kG54wAVgrcDfExLeLsni3JyphMym5d7wyM6XNix@nongnu.org
X-Gm-Message-State: AOJu0YwrT4z0GtuK4qUY/NBn2LUzjh1z7g+HcFzfISPRZALVtBQmcK5y
 zinL1ZLpZmdKNdFcukmyCpnYcWTOdoOpkCU7wQ7p3UJ6IxHrD0G1qfE6bBeUBmg=
X-Google-Smtp-Source: AGHT+IEjHqswNHkIfzcdZpwTNiEJ+Cht/ft02OupPuk34GhlJHiXbuS598C64Z+7qApFGO2ujhGNfw==
X-Received: by 2002:a05:6a00:3403:b0:724:6c55:a8fb with SMTP id
 d2e1a72fcca58-7246c55aa17mr3743479b3a.9.1731607743913; 
 Thu, 14 Nov 2024 10:09:03 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9d2c0dsm1539654b3a.174.2024.11.14.10.09.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:09:03 -0800 (PST)
Message-ID: <115df330-258e-4ba5-9490-f6555edd699b@linaro.org>
Date: Thu, 14 Nov 2024 10:09:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/54] accel/tcg: Delay plugin adjustment in
 probe_access_internal
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-22-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 11/14/24 08:00, Richard Henderson wrote:
> Remove force_mmio and place the expression into the IF
> expression, behind the short-circuit logic expressions
> that might eliminate its computation.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 3e24529f4f..a4c69bcbf1 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1373,7 +1373,6 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
>       CPUTLBEntry *entry = tlb_entry(cpu, mmu_idx, addr);
>       uint64_t tlb_addr = tlb_read_idx(entry, access_type);
>       int flags = TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
> -    bool force_mmio = check_mem_cbs && cpu_plugin_mem_cbs_enabled(cpu);
>       CPUTLBEntryFull *full;
>   
>       if (!tlb_hit(tlb_addr, addr)) {
> @@ -1404,9 +1403,14 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
>       *pfull = full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
>       flags |= full->slow_flags[access_type];
>   
> -    /* Fold all "mmio-like" bits into TLB_MMIO.  This is not RAM.  */
> -    if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY | TLB_CHECK_ALIGNED))
> -        || (access_type != MMU_INST_FETCH && force_mmio)) {
> +    /*
> +     * Fold all "mmio-like" bits, and required plugin callbacks, to TLB_MMIO.
> +     * These cannot be treated as RAM.
> +     */
> +    if ((flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY | TLB_CHECK_ALIGNED))
> +        || (access_type != MMU_INST_FETCH
> +            && check_mem_cbs
> +            && cpu_plugin_mem_cbs_enabled(cpu))) {
>           *phost = NULL;
>           return TLB_MMIO;
>       }

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


