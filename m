Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288F8C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 07:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdmBf-0005a1-6t; Tue, 13 Aug 2024 03:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdmBd-0005Yf-V3
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 03:43:21 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdmBb-0007ve-Dq
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 03:43:21 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70d2ae44790so3641317b3a.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 00:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723534997; x=1724139797; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KBSwiNqa049bJ062w81vEeg7cRT0njdTw2Mnb0cEUns=;
 b=bDVG3A5qnP+mRukh24WMnz7inA0stRmD2a/Zh4mePMoUmKOVijCtZkyZF5suVIWk/I
 OrTHmeHLL5b5vd/Wg3eaqjIGFzUqS9rNn5KjMyq/zC60s2YqO48rIyp4q8gtnsXzkaHX
 O9/GxYyqD3mgPfbxNvjnHKRWYagLwsHZFgjos6gmbUqAbZ0xylOaFqDJhmXwBjTm4Dh1
 wTRlGHvBnt1SuAh/dLwmnL1Xe8tT2lYP36gMVsn/rL5v5mNoqgDKhcEfpqjyfWG+PB65
 /m63lXQH6lPngwe0M3CQF59hfDBJi9Nag2/zjgfTELMXCA6EuVjQ3FHGdltEepqxEVpd
 DsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723534997; x=1724139797;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KBSwiNqa049bJ062w81vEeg7cRT0njdTw2Mnb0cEUns=;
 b=bjC5OhS8VqKOZroisFzpV+rlyeA89QA52S6j9gAsiBvmMIvMGRdjAGXH0oqzxVhYMK
 jT0KDh96uWx4kqpt9i+GklQ/yQcw7HDqI25meMcRBsGbRJ3TupbiUn5KxIsWp/CHbjXX
 IFuRfiNAU5/UrSGHKrkfdkHTRlmOHxFiADl3s5E1BB5W/tkaXjLNJHZQQT+anKvcDP6f
 9jOkyUtx7fXkQ4vRUCNsXIta423y2XWinbh2g9r/WGHgdmYfbXmjwzx898xg1ZI6GSYc
 Hw0qG7PPPH7tgr3tNtsiY04A2gg205pUkslkn77FI6urLBq040EzPtaKxX2NrVp//C9o
 E6xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoH0MKmbFzNOszrTFkByjx30tl+G7NopQaECyfF8pZQhKfNchhbw0gQAt5pwdx29sVNbRuQvqlQ+h1g6a3WI9Q6OgXB1k=
X-Gm-Message-State: AOJu0YwrHny7G6xIiVvE15pTQ7qQZjAsr03/D+q5+gYbYAqlWZV3jrnx
 G5H9EmkYHI7drzunJ+xrpJtdv9F2alDT3hxBtcJeOd1R6j7m4AdYoSF1JVkaOIw=
X-Google-Smtp-Source: AGHT+IFYZ+r57K3J4+uxAIUAAphOygIurLmP5x4FhBADzZviVBu+DQepn+S6wJfVUrmMHkmmIcv/WQ==
X-Received: by 2002:a05:6a00:1a8c:b0:70d:244b:cad9 with SMTP id
 d2e1a72fcca58-712552273camr3231565b3a.28.1723534997064; 
 Tue, 13 Aug 2024 00:43:17 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e5a43e48sm5247584b3a.98.2024.08.13.00.43.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 00:43:16 -0700 (PDT)
Message-ID: <aa7facef-acda-4846-98d5-2f7584515035@linaro.org>
Date: Tue, 13 Aug 2024 17:43:07 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv32: Fix masking of physical address
To: Andrew Jones <ajones@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com,
 zong.li@sifive.com, liwei1518@gmail.com, cwshu@andestech.com,
 dbarboza@ventanamicro.com
References: <20240813071355.310710-2-ajones@ventanamicro.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813071355.310710-2-ajones@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 8/13/24 17:13, Andrew Jones wrote:
> C doesn't extend the sign bit for unsigned types since there isn't a
> sign bit to extend. This means a promotion of a u32 to a u64 results
> in the upper 32 bits of the u64 being zero. If that result is then
> used as a mask on another u64 the upper 32 bits will be cleared. rv32
> physical addresses may be up to 34 bits wide, so we don't want to
> clear the high bits while page aligning the address. The fix is to
> revert to using target_long, since a signed type will get extended.
> 
> Fixes: af3fc195e3c8 ("target/riscv: Change the TLB page size depends on PMP entries.")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>   target/riscv/cpu_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 395a1d914061..dfef1b20d1e8 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1323,7 +1323,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>       int ret = TRANSLATE_FAIL;
>       int mode = mmuidx_priv(mmu_idx);
>       /* default TLB page size */
> -    target_ulong tlb_size = TARGET_PAGE_SIZE;
> +    target_long tlb_size = TARGET_PAGE_SIZE;

If rv32 physical addresses are 34 bits, then you probably didn't want target_*long at all.


r~

