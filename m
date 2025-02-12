Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3985EC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 07:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti75J-0003lv-8n; Wed, 12 Feb 2025 02:23:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ti75B-0003jj-Sr
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 02:22:53 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ti756-0002Gd-5E
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 02:22:51 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-439585a0544so2538245e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 23:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739344964; x=1739949764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rrHBEe7cT70K/634OpO3wwXZn3PGwiJwKEjoKS4YbvA=;
 b=F3qgoDv0cgF3+zDBkCxwLijNF9fSOvZdmHhzRxA3GL8cEmavBRK923ZqvSmVSXIQY9
 Ai5eABtRejkD4lIs1HE5SxfeDllp86AmN2sE1zZUYQ4UMQeNOPcObLKL/UvFqv5/yINc
 jc61UgIRhD1BwerIGsVYWV+fXprpFrTrGWYsXx3POGTwVNoqPQURLtoZuNagjfA3hVOa
 kLdnjffP7vvW87+Pvqfa8Pwap0Lu5oRpeNwDA4K1cZvlCnKED1m6z5wH8E56YK3MmKLw
 9peSkuAq3kqQT1Vdt+ohGMcLt0RrtosnsEhmjNWHGWAMfICnPhv5VgAK8192GCjbQhEj
 TgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739344964; x=1739949764;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rrHBEe7cT70K/634OpO3wwXZn3PGwiJwKEjoKS4YbvA=;
 b=eDgqaN5Fbnyp5UuSzoYEEqc8b+UG8rVzUn40fhS5SFDWLTGICi0EdvP6YlG04yI+cy
 1m4CZmItvTydzC5hwRQEQXPpSjsYGCkIH77MBtzrYUwxd+nPTi11GNiGjKmqjznIH9aN
 ObKyHheKGbhiHYfeTYAjCrWUpEP28zBSUQKptGO6tXGKifq+/jQuwXhyLqGpt2RH0oMQ
 AFTQinQwyFF57c06NtQ9XtGv3G4xgRMZAKqDpOKhDHkrBOcxub9NcU4i9FojGWVvbggr
 dvMywA8x7J/uE7NV7+8buJ8NIj4C4cIBDGQACWtapbJLYzOU0Rj9KOTQrd8qrpzex3HG
 jbdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXzBBSfM0Uatz+kenTMvvTGvo7BGxRfmg8kStFE69FRo/6oWQ0GLLuWAgy2riTo8URfKVTNpI7KxlV@nongnu.org
X-Gm-Message-State: AOJu0YzLQl7wg/SVyb4T8eDWoRTt+mgJ/syB0YsCoa4McKenC/Yib4Z3
 9ruO9XBvOu4xAUxa79HRGUQhO2Evc0RQ/shQHOyNrypVkTX7dlYMZRK9uiFVcik=
X-Gm-Gg: ASbGncsmpKhKnFBAPAZvWqRtFP9wPGzjE+Yxij2C1Nu1PWU1c9b2I7Epy9Ux5LGOcms
 N1Nb5LTo1Gpk748YWxLXuvRWA7Skc16n4vbMJELE3I9wwN6wShNNLYH4vWKWN3unpaA6y8vHU2i
 +o7j5UKtE0S890bmuvrDjGmK7/QhR8V4tNdgg3w3bNFWIbXtJFvlzNBoM3CWJJWzmv2BD7S+DEn
 iQqOP/mfuwmLzwnmpIp26rPH9k1l6EEbCys4QyO6bs5ln8h9o+rkZdGsTiLt8ym582u8ozakSLk
 4plLTN52QPzQbrUYWCYrMpj1DbEoSe+SmViw7q/n7Q9oCXa0fXPR+clff84=
X-Google-Smtp-Source: AGHT+IETsonGoBc3TRggu+4ziZkA0O+wemnwtkbrjdfFNKAclT5fG/rYxBfkZRboDmCl2DzavjhPcg==
X-Received: by 2002:a05:600c:3d10:b0:439:448c:6132 with SMTP id
 5b1f17b1804b1-43959a83f86mr10803885e9.22.1739344964634; 
 Tue, 11 Feb 2025 23:22:44 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1b8868sm10708835e9.39.2025.02.11.23.22.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 23:22:44 -0800 (PST)
Message-ID: <9759c6f3-18c7-4693-a2db-8a10fea182c8@linaro.org>
Date: Wed, 12 Feb 2025 08:22:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] accel/tcg: Fix tlb_set_page_with_attrs, tlb_set_page
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Anton Johansson <anjo@rev.ng>
References: <20250205040341.2056361-1-richard.henderson@linaro.org>
 <20250205040341.2056361-10-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250205040341.2056361-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 5/2/25 05:03, Richard Henderson wrote:
> The declarations use vaddr for size.

Which seems dubious, since TARGET_PAGE_SIZE is int IIUC.

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 17e2251695..75d075d044 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1193,7 +1193,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>   
>   void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
>                                hwaddr paddr, MemTxAttrs attrs, int prot,
> -                             int mmu_idx, uint64_t size)
> +                             int mmu_idx, vaddr size)
>   {
>       CPUTLBEntryFull full = {
>           .phys_addr = paddr,
> @@ -1208,7 +1208,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
>   
>   void tlb_set_page(CPUState *cpu, vaddr addr,
>                     hwaddr paddr, int prot,
> -                  int mmu_idx, uint64_t size)
> +                  int mmu_idx, vaddr size)
>   {
>       tlb_set_page_with_attrs(cpu, addr, paddr, MEMTXATTRS_UNSPECIFIED,
>                               prot, mmu_idx, size);


