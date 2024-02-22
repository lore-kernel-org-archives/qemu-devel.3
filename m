Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC58C5478C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 21:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdGVN-0007Ve-Dk; Thu, 22 Feb 2024 16:21:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdGVM-0007VW-8n
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 16:21:20 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdGVK-0000cR-Kb
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 16:21:20 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e09143c7bdso71111b3a.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 13:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708636877; x=1709241677; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UCCh/F1oQ842Tcqwks1U7mp9nWMsI9vl+KYbrNtyEo0=;
 b=s4k3tRj15ikfaPLryD3UkOKSeFNug1Er5hYo1TTv1/FbMNRKS+5o6qBe+NQKi38RzI
 XcLuU6QzvZHNrpTWaNWYvJV4WP3YegG2w7nW1CcjgP9ZEtPehCq8sIFUDEuU6CTKAlGs
 h55txebQzK6kJuZCE/uM1wht4mkskcQlhO9GlfgBJihcrWPwxjvb1Wkl5g2EL9z6auKA
 BJSMK+ODdrnIx8DVmPAaaBvXRsyact1ZD4AsHjxsWLsx1IZjOKaVpf5neCXWQ2sNyrsl
 H51ygtRwpLSFNkQ4Zy7ZFRsfuTTwU/KayVMbKvReMhzLwpuH8EU4nakWfZW9hMPsMQ7G
 d8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708636877; x=1709241677;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UCCh/F1oQ842Tcqwks1U7mp9nWMsI9vl+KYbrNtyEo0=;
 b=RavCDi+1VcsxSaQltoJywfLO2AUZdmAB+hGt/B9dzhxU3Epp970KVXnAHmHdx/PcHT
 MmTeOGhJx2CENwiv4pWrxu/XR/SzOEtp0HzinpX+iYVCxyiUzQAFjEu4vqypNrUAMA4D
 28k14iUQ6KpRNckgp3QlHwBOZLfVxjB3X8K8VnPbG4EkCkD5HlLJ5s7XXB4Q5vvfn0sW
 G9vOsvLlkxAwtsS3m9luqB9896OI6EtZYztcan2paLRfQkz/wqiEK1AdPMxFGPQUOpPS
 A84OT7AnzCN9kzX1z9leKwXrz4B10M5jqw1wzIiR5GjkW/jlAVfFTqMDqEyu3nfBwiNh
 8NlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA/FvjZYfmtKeqXeexbJM05Vsi3LO9X+1fZP9c1BPzx5y6lJ0Ww6rZy4hmhrQ/wvkKGuL5/t+kzNvyD7SAcxQSPjOXVvI=
X-Gm-Message-State: AOJu0YymIAmhevzDVSA47QUDFBV75D5YlTplv90MiaUp2MKTLrM7hJw1
 mXWgywwjbi6WUxLprhB1FUXTHDJBQb8eIDlStTx5JRoitBScNAAclh1deyY1eEE=
X-Google-Smtp-Source: AGHT+IGLGtlbicdXcwsgdLRpXtbOJ76WaGeiX1GM253/BpXCfZ9BUDz8+Z+ZarV1GpK9ZgWnuZfLAw==
X-Received: by 2002:a05:6a00:2d96:b0:6e4:8ea7:231d with SMTP id
 fb22-20020a056a002d9600b006e48ea7231dmr126338pfb.5.1708636877128; 
 Thu, 22 Feb 2024 13:21:17 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 kt21-20020a056a004bb500b006e465e1573esm8206831pfb.74.2024.02.22.13.21.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 13:21:16 -0800 (PST)
Message-ID: <cfa50d25-3a82-48f5-b715-1daf16932fc2@linaro.org>
Date: Thu, 22 Feb 2024 11:21:12 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] arm/ptw: Handle atomic updates of page tables
 entries in MMIO during PTW.
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gregory.price@memverge.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: linux-cxl@vger.kernel.org, linuxarm@huawei.com
References: <20240219161229.11776-1-Jonathan.Cameron@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240219161229.11776-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 2/19/24 06:12, Jonathan Cameron wrote:
> I'm far from confident this handling here is correct. Hence
> RFC.  In particular not sure on what locks I should hold for this
> to be even moderately safe.
> 
> The function already appears to be inconsistent in what it returns
> as the CONFIG_ATOMIC64 block returns the endian converted 'eventual'
> value of the cmpxchg whereas the TCG_OVERSIZED_GUEST case returns
> the previous value.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v2: Thanks Peter for reviewing.
>   - Handle the address space as in arm_ldq_ptw() - I should have looked
>     at the code immediately above :(
>     The result ends up a little more convoluted than I'd like. Could factor
>     this block of code out perhaps. I'm also not sure on the fault type
>     that is appropriate here.
>   - Switch to 'need_lock' as per Philippe's feedback on the x86 fixes.
>     likely() doesn't seem appropriate here though.
>   
> target/arm/ptw.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 62 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 5eb3577bcd..ba1a27ca2b 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -711,8 +711,68 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
>       void *host = ptw->out_host;
>   
>       if (unlikely(!host)) {
> -        fi->type = ARMFault_UnsuppAtomicUpdate;
> -        return 0;
> +        /* Page table in MMIO Memory Region */
> +        CPUState *cs = env_cpu(env);
> +        MemTxAttrs attrs = {
> +            .space = ptw->out_space,
> +            .secure = arm_space_is_secure(ptw->out_space),
> +        };
> +        AddressSpace *as = arm_addressspace(cs, attrs);
> +        MemTxResult result = MEMTX_OK;
> +        bool need_lock = !bql_locked();
> +
> +        if (need_lock) {
> +            bql_lock();
> +        }
> +        if (ptw->out_be) {
> +            cur_val = address_space_ldq_be(as, ptw->out_phys, attrs, &result);
> +            if (unlikely(result != MEMTX_OK)) {
> +                fi->type = ARMFault_SyncExternalOnWalk;
> +                fi->ea = arm_extabort_type(result);
> +                if (need_lock) {
> +                    bql_unlock();
> +                }
> +                return old_val;
> +            }

Use BQL_LOCK_GUARD() and avoid all of the repeated unlocks at each return point.

You can merge all of the error paths, e.g.

     cur_val = (ptw->out_be
                ? address_space_ldq_be(as, ptw->out_phys, attrs, &result)
                : address_space_ldq_le(as, ptw->out_phys, attrs, &result));
     if (result == MEMTX_OK && cur_val == old_val) {
         if (ptw->out_be) {
             address_space_stq_be(as, ptw->out_phys, new_val, attrs, &result);
         } else {
             address_space_stq_le(as, ptw->out_phys, new_val, attrs, &result);
         }
     }
     if (unlikely(result != MEMTX_OK)) {
         fi->type = ...
         return old_val;
     }
     return cur_val;



r~

