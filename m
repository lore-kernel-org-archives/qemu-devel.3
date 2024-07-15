Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E956C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 21:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTTTP-0007wU-Ol; Mon, 15 Jul 2024 17:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTTTN-0007sc-Rg
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 17:43:06 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTTTK-0000uj-S1
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 17:43:05 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-767506e1136so3487072a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 14:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721079780; x=1721684580; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qFlJThacqRcUbiwz/H0Z0GPMFjEVS/7KcMwKMYneQwU=;
 b=HezLn9xnu1Hawn9UhCN0+Ubdy4LvecBS/6KvggRxafYfSpZzEeZ/v2I1ItV/hwS1WM
 3GngV0FTsvc2rs70rSmGG3jyqfAuTUsumGEy++rBS6k4Ht2Z0DpWhTu/s7igbpI061T/
 uYFJ7lmi+Optryha49aWAxDl/xDBliLAH0hLBUVDRQoFCXtSHtsk3LqZOQA1ELhhGTIE
 UzguNTfc4bFuVTigpjjXzG/ocj6pAa8ya+JFHgfN1coEmVeeqYNrm7GwVZrroLAipdmv
 gv4ju+WC6lCXnL4Nhs/CTlAJCY7NHY37WB9ME2dMHuADutuTITHArExPhQ9A72c7uk6f
 Bgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721079780; x=1721684580;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qFlJThacqRcUbiwz/H0Z0GPMFjEVS/7KcMwKMYneQwU=;
 b=ceR/PBSzUiOdn7rki/D7bSKO7tJWUt8OK1KFxwrPoqUZzBromxL23c6mKw1B+jhI+z
 Y9YUtGoJ6Y12nJohyDQaTtVspxkWLYm3ZylpudFg09U4DAahMZBhksEh3HsrshOXeoLo
 gRYaCfhrzNwZxEguQCZ7loqPT3RH6XQi/UZhXs+rAnxx9kVVP2ambRNWK9dfAOjjXdrf
 nUByWd7StXhn00VsgQ0sFSjndZ4OCyA4Qf6Wq8a4YaBpUmSCz9RrDRJWcGsdTuT76b+F
 A1IumtVFfa9kSqRNAsc8hWdBLQiMSVPWo2yagwXvQrttAa2+Q/0dKLUwr5ThNgrNiHmK
 ijdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBUFubqpdHSg+OJYSXtBd6shprJZHSSnax+YSAg/NZrhzF0o8IEKbLCMpb1/A/H4MsKCRqmuvVt3/0F8ceq/obwFlKIf4=
X-Gm-Message-State: AOJu0YzxiaiLMq0+q4f+dUq3xi6ICkqUV8JbyGlUWf/bauzW7+PifHTC
 +rRsa12A45QkBLME7Hq2Rs9DBKAf09v63md2dOCSU9R/9HIE02PEAFtXUKWlD5nua9iO+X5JUeL
 hpOvbew==
X-Google-Smtp-Source: AGHT+IEFoUEYnh4G61GkZ4kVJACf/CLNX5mrTbN0nJQL3t4ib4OO6rGhjG89Nwaa7tXh79VQzn4dtQ==
X-Received: by 2002:a17:90a:6881:b0:2c8:2cd1:881b with SMTP id
 98e67ed59e1d1-2cb373389a9mr256669a91.20.1721079780052; 
 Mon, 15 Jul 2024 14:43:00 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2caedc1709esm4865416a91.34.2024.07.15.14.42.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 14:42:59 -0700 (PDT)
Message-ID: <3d86bfd4-e6ef-464a-a663-21e95e1f6cf6@linaro.org>
Date: Tue, 16 Jul 2024 07:42:51 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/13] target/riscv: Simplify probing in vext_ldff
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, balaton@eik.bme.hu
References: <20240710032814.104643-1-richard.henderson@linaro.org>
 <20240710032814.104643-14-richard.henderson@linaro.org>
 <5a83ce12-9a9c-4c9d-9fee-e37fb6afd19d@sifive.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5a83ce12-9a9c-4c9d-9fee-e37fb6afd19d@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: 37
X-Spam_score: 3.7
X-Spam_bar: +++
X-Spam_report: (3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On 7/15/24 17:06, Max Chou wrote:
>> +                /* Probe nonfault on subsequent elements. */
>> +                flags = probe_access_flags(env, addr, offset, MMU_DATA_LOAD,
>> +                                           mmu_index, true, &host, 0);
>> +                if (flags) {
> According to the section 7.7. Unit-stride Fault-Only-First Loads in the v spec (v1.0)
> 
>       When the fault-only- data-watchpoint trap on an element after the      
> implementations should not reduce vl but instead should trigger the debug trap as 
> otherwise the event might be lost.

Hmm, ok.  Interesting.


> And I think that there is a potential issue in the original implementation that maybe we 
> can fix in this patch.
> 
> We need to assign the correct element load size to the probe_access_internal function 
> called by tlb_vaddr_to_host in original implementation or is called directly in this patch.
> The size parameter will be used by the pmp_hart_has_privs function to do the physical 
> memory protection (PMP) checking.
> If we set the size parameter to the remain page size, we may get unexpected trap caused by 
> the PMP rules that covered the regions of masked-off elements.
> 
> Maybe we can replace the while loop liked below.
> 
> 
> vext_ldff(void *vd, void *v0, target_ulong base,
>            ...
> {
>      ...
>      uint32_t size = nf << log2_esz;
> 
>      VSTART_CHECK_EARLY_EXIT(env);
> 
>      /* probe every access */
>      for (i = env->vstart; i < env->vl; i++) {
>          if (!vm && !vext_elem_mask(v0, i)) {
>              continue;
>          }
>          addr = adjust_addr(env, base + i * size);
>          if (i == 0) {
>              probe_pages(env, addr, size, ra, MMU_DATA_LOAD);
>          } else {
>              /* if it triggers an exception, no need to check watchpoint */
>              void *host;
>              int flags;
> 
>              /* Probe nonfault on subsequent elements. */
>              flags = probe_access_flags(env, addr, size, MMU_DATA_LOAD,
>                      mmu_index, true, &host, 0);
>              if (flags & ~TLB_WATCHPOINT) {
>                  /*
>                   * Stop any flag bit set:
>                   *   invalid (unmapped)
>                   *   mmio (transaction failed)
>                   * In all cases, handle as the first load next time.
>                   */
>                  vl = i;
>                  break;
>              }
>          }
>      }

No, I don't think repeated probing is a good idea.
You'll lose everything you attempted to gain with the other improvements.

It seems, to handle watchpoints, you need to start by probing the entire length non-fault. 
  That will tell you if any portion of the length has any of the problem cases.  The fast 
path will not, of course.

After probing, you have flags for the 1 or two pages, and you can make a choice about the 
actual load length:

   - invalid on first page: either the first element faults,
     or you need to check PMP via some alternate mechanism.
     Do not be afraid to add something to CPUTLBEntryFull.extra.riscv
     during tlb_fill in order to accelerate this, if needed.

   - mmio on first page: just one element, as the second might fault
     during the transaction.

     It would be possible to enhance riscv_cpu_do_transaction_failed to
     suppress the fault and set a flag noting the fault.  This would allow
     multiple elements to be loaded, at the expense of another check after
     each element within the slow tlb-load path.  I don't know if this is
     desirable, really.  Using vector operations on mmio is usually a
     programming error.  :-)

   - invalid or mmio on second page, continue to the end of the first page.

Once we have the actual load length, handle watchpoints by hand.
See sve_cont_ldst_watchpoints.

Finally, the loop loading the elements, likely in ram via host pointer.


r~

