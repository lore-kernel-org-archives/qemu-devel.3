Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96A3C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 17:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLROa-0002eX-R8; Sun, 23 Jun 2024 13:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLROZ-0002eE-5a
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 13:52:55 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLROX-00052N-Ar
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 13:52:54 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3d21b3da741so1981412b6e.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 10:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719165172; x=1719769972; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Toq+ylrFRcuGJ1WW10h3NWrs3Kkqug4RTLTR4Pv2+IE=;
 b=SwbXJMtOvS63+3l9Y4XLmkO9ZF8aHTxhDnLwAFm2iH7LLGKQry9Pm9xOjXyXpRBQCo
 qx4WoWtpUJNbGu2ip/eijb3J6lmhErcD80KLJk46m/98wEocBMt2KJ5CvmQm3lrN94a9
 GzRIjzCwOz/oMwjVvzzNcy13NV+hS9FWAKQwji6da4/UpK8iE0Zqdk4Aw6rbaD1ECgv3
 dub4kNwrHKLjebfCj7x5jbxLPxAgdNOHc4hJtrdR23b3PdQzScX6dcKQbXlw5mh0+onx
 P6xSVI3PuaztT9RGhTbjYZeFpCBUN0+Vq2AX0zWSLhIcv0A46kbFC/A+OGS5YilJOnAG
 X1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165172; x=1719769972;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Toq+ylrFRcuGJ1WW10h3NWrs3Kkqug4RTLTR4Pv2+IE=;
 b=aQRDge1ub2diPgvx5bJL+BRq1r5ENDt435VYKRfvtwWy+Yv7h3fsPexzub5h78i83/
 cWkhH8AWMZ0CQl0Gl0PHF5Rt63OYkZRaek3hRF1vQjChfFMz6M+Kg8vgw1SRnQQhuaBq
 QhPDOx8VPUS1kfTVPfAc9gg+hT8vxEmTCVGHCivD6cKP6dQUtEQYfkQh6+NCiWSBuqgZ
 iscmljixDXnFJaYk0QX1kKZ0DXR/x9LvHXQPSL6fvQIlt1l4I0TrQej529jG/KoDxD9U
 KP+U5AqPNl3ge9Ru8fEUNktm9GooPykFtrrhmit7HbuNJ5eCRDYLyFfJEDlnvCrV5vI9
 T/TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk/qfaAc8azheBjMbQqV5+Z3ZBZkGx84YhV6KJD4lh3OnsYeYWveIs1kAz6bdODyOAkPtG/9afdSOkYhKFOtBFSqXw3Aw=
X-Gm-Message-State: AOJu0YzAk2oYcSCLDu648TdzbeV+w3MxF1o54u7ougTKNZ2znONjtoj1
 qCPZgc/dlJZ6bu9qiv4AlDHtvtlMlBLlBqUo8u/+EniffJ/eNa5WgvelNHEIkOM=
X-Google-Smtp-Source: AGHT+IFCSb43ywispJqf4rRTlTTmgUHslYUYs9rnmCqs0ucJdSqDK9PYlIeaKExruAo6R9fJaGuyuA==
X-Received: by 2002:a05:6808:1808:b0:3d2:17f7:5761 with SMTP id
 5614622812f47-3d545a6a445mr3711689b6e.43.1719165171726; 
 Sun, 23 Jun 2024 10:52:51 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7180e5f7396sm3378894a12.69.2024.06.23.10.52.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 10:52:51 -0700 (PDT)
Message-ID: <6664471b-7223-4c6e-a106-ce272be72f28@linaro.org>
Date: Sun, 23 Jun 2024 10:52:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc/mem_helper.c: Remove a conditional from
 dcbz_common()
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20240622204833.5F7C74E6000@zero.eik.bme.hu>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240622204833.5F7C74E6000@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

On 6/22/24 13:48, BALATON Zoltan wrote:
> Instead of passing a bool and select a value within dcbz_common() let
> the callers pass in the right value to avoid this conditional
> statement. On PPC dcbz is often used to zero memory and some code uses
> it a lot. This change improves the run time of a test case that copies
> memory with a dcbz call in every iteration from 6.23 to 5.83 seconds.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> This is just a small optimisation removing some of the overhead but
> dcbz still seems to be the biggest issue with this test. Removing the
> dcbz call it runs in 2 seconds. In a profile I see:
>    Children      Self  Command   Shared Object            Symbol
> -   55.01%    11.44%  qemu-ppc  qemu-ppc                 [.] dcbz_common.constprop.0
>                 - 43.57% dcbz_common.constprop.0
>                    - probe_access
>                       - page_get_flags
>                            interval_tree_iter_first
>                 - 11.44% helper_raise_exception_err
>                      cpu_loop_exit_restore
>                      cpu_loop
>                      cpu_exec
>                      cpu_exec_setjmp.isra.0
>                      cpu_exec_loop.constprop.0
>                      cpu_tb_exec
>                      0x7f262403636e
>                      helper_raise_exception_err
>                      cpu_loop_exit_restore
>                      cpu_loop
>                      cpu_exec
>                      cpu_exec_setjmp.isra.0
>                      cpu_exec_loop.constprop.0
>                      cpu_tb_exec
>                    - 0x7f26240386a4
>                         11.20% helper_dcbz
> +   43.81%    12.28%  qemu-ppc  qemu-ppc                 [.] probe_access
> +   39.31%     0.00%  qemu-ppc  [JIT] tid 9969           [.] 0x00007f2624000000
> +   32.45%     4.51%  qemu-ppc  qemu-ppc                 [.] page_get_flags
> +   25.50%     2.10%  qemu-ppc  qemu-ppc                 [.] interval_tree_iter_first
> +   24.67%    24.67%  qemu-ppc  qemu-ppc                 [.] interval_tree_subtree_search
> +   16.75%     1.19%  qemu-ppc  qemu-ppc                 [.] helper_dcbz
> +    4.78%     4.78%  qemu-ppc  [JIT] tid 9969           [.] 0x00007f26240386be
> +    3.46%     3.46%  qemu-ppc  libc-2.32.so             [.] __memset_avx2_unaligned_erms
> Any idea how this could be optimised further? (This is running with
> qemu-ppc user mode emulation but I think with system it might be even
> worse.) Could an inline implementation with TCG vector ops work to
> avoid the helper and let it compile to efficient host code? Even if
> that could work I don't know how to do that so I'd need some further
> advice on this.
> 
>   target/ppc/mem_helper.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index f88155ad45..361fd72226 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -271,12 +271,11 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
>   }
>   
>   static void dcbz_common(CPUPPCState *env, target_ulong addr,
> -                        uint32_t opcode, bool epid, uintptr_t retaddr)
> +                        uint32_t opcode, int mmu_idx, uintptr_t retaddr)
>   {
>       target_ulong mask, dcbz_size = env->dcache_line_size;
>       uint32_t i;
>       void *haddr;
> -    int mmu_idx = epid ? PPC_TLB_EPID_STORE : ppc_env_mmu_index(env, false);
>   
>   #if defined(TARGET_PPC64)
>       /* Check for dcbz vs dcbzl on 970 */
> @@ -309,12 +308,12 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
>   
>   void helper_dcbz(CPUPPCState *env, target_ulong addr, uint32_t opcode)
>   {
> -    dcbz_common(env, addr, opcode, false, GETPC());
> +    dcbz_common(env, addr, opcode, ppc_env_mmu_index(env, false), GETPC());

This is already computed in the translator: DisasContext.mem_idx.
If you pass the mmu_idx as an argument, you can unify these two helpers.


r~

>   }
>   
>   void helper_dcbzep(CPUPPCState *env, target_ulong addr, uint32_t opcode)
>   {
> -    dcbz_common(env, addr, opcode, true, GETPC());
> +    dcbz_common(env, addr, opcode, PPC_TLB_EPID_STORE, GETPC());
>   }
>   
>   void helper_icbi(CPUPPCState *env, target_ulong addr)


