Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683C9C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 18:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scUli-0001n2-Al; Fri, 09 Aug 2024 14:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1scUlb-0001hT-KJ
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 14:55:11 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1scUlY-0004bj-8S
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 14:55:11 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7106e2d0ec1so2025431b3a.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 11:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723229706; x=1723834506;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qyhogcm77iWYx7iyxIh4apVEqvXjco/4P6thr2r5QdI=;
 b=eB6N1mY6b8F78f2wbh5JOgm4GXxMEUI4wJfNeHKhpdn5xU3iXFBtFvFzUdK1nsbMaR
 8qfPV8ebs+uB/xeAToITJXrQPbgFz9VWdfUIw7nUXrGtJW+Nzi2hXl4V7WutXq8XkfYP
 HTtPE7ant1dwz8QHnaNfBy+hrKr+YBs+3mupero6JP0wJrhv7b+2YmupxkOsfu1EV3hl
 QJAiFLgJ4k3PKfb2GmzcGsbJoJ2+w8rpvf3yTvq65H3Fs5WY/3EFpTfdV5SVbsk82Yo9
 hRXS+4KwBl1npeBvNEq9vC3Oy0NPgGspwm/pecQPPtU/EHw8HVbMiYqeBGTjxamIiFyx
 hG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723229706; x=1723834506;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qyhogcm77iWYx7iyxIh4apVEqvXjco/4P6thr2r5QdI=;
 b=nKQlrlyUzvqBk1muVVj6mv99W76uQlxWXIiA7DWO2atQe5OCyc0Q3A8CT4c80HNFxq
 tykmTCTVBCH5ix5nUGokfS+A1D+iXtI/9O0KfMwaBM0q8N7NSBH+TBWrQIIqizziU+33
 qalKBZU8GZE0sLISlqqK16sKRS5oQar273ZdFc8OYystP8Dyl39so+pd7NjkOrsBJ+GZ
 zpUQkbmobxbaBTlfDi8mSRuQqu42DUvFVZopiat40imkNuDWoNyDEnFH58xUDlHnCFCG
 pxPtXVIiG4+5Oa5y9Ef8OG8tv8nQCXziH7+EZChXfITXBUVqbTvRfHtfDS/1jPQ65lOr
 ve3g==
X-Gm-Message-State: AOJu0YwSZsCyIOfSvpsXRMEkpMHzvjStfNdLK6reiA2NPNWUilQOGhhX
 pKNAGfBqM3BCvegs3SEae5FYFK7q4MZigK5pl88pGxv2EgUvwpLzA90ScfkLoA8=
X-Google-Smtp-Source: AGHT+IE/8t8nNXrqz6kvM0GMmtWiKgisC93AKqSzxFQYWJ1+CDkF6KsvPtCu2xorydmJTUCbljas6g==
X-Received: by 2002:a05:6a00:391a:b0:70d:3337:7820 with SMTP id
 d2e1a72fcca58-710dc695b69mr2519244b3a.8.1723229705191; 
 Fri, 09 Aug 2024 11:55:05 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e5874e00sm93786b3a.12.2024.08.09.11.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 11:55:04 -0700 (PDT)
Date: Fri, 9 Aug 2024 11:55:02 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH v3 14/20] target/riscv: mmu changes for zicfiss shadow
 stack protection
Message-ID: <ZrZmBhUnTQY1eaC3@debug.ba.rivosinc.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-15-debug@rivosinc.com>
 <bea52a58-12a7-45d1-b610-d577a7540887@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bea52a58-12a7-45d1-b610-d577a7540887@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 07, 2024 at 01:19:55PM +1000, Richard Henderson wrote:
>On 8/7/24 10:06, Deepak Gupta wrote:
>>      int prot = 0;
>>-    if (pte & PTE_R) {
>>+    /*
>>+     * If PTE has read bit in it or it's shadow stack page,
>>+     * then reads allowed
>>+     */
>>+    if ((pte & PTE_R) || sstack_page) {
>>          prot |= PAGE_READ;
>>      }
>
>I feel like this logic could be simplified somehow.
>I'll think about it.

Ok let me know.

>
>>@@ -1409,6 +1461,11 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>>      qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
>>                    __func__, address, access_type, mmu_idx);
>>+    /* If shadow stack instruction initiated this access, treat it as store */
>>+    if (mmu_idx & MMU_IDX_SS_ACCESS) {
>>+        access_type = MMU_DATA_STORE;
>>+    }
>
>I know you're trying to massage the fault type, but I think this is the wrong place.

Is it okay if I add `mmu_idx` argument to `raise_mmu_exception` ?
Inside `raise_mmu_exception`, then based on `mmu_idx == shadow stack index`, I can convert
a fault due to access_type=MMU_DATA_LOAD into store page fault.

>
>
>r~

