Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A698C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 11:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdpIw-0004mJ-PL; Tue, 13 Aug 2024 07:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdpIv-0004lb-Cp
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 07:03:05 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdpIp-0004xx-Ph
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 07:03:02 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70d2b921c48so4011321b3a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 04:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723546970; x=1724151770; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1wAm1xnIwf8JHprxOXl9qTnKn13ic4Imwp4W6zMeQzM=;
 b=OyZ5p9TO8z6cir1yY0yLDjEw53ybn7S4ZuwS1NnfQKcuffCcNwXEOKq/+G3R8paR80
 X/34gR+MevXzkWNP+QFZtGd2D83eunnRLcFyrRXmbsM4c/T9HS9aCxPOgySm4pf/Qynx
 uBvw4GBRqM3NEWqkv/1nO48dwYlU7wG1/qu9GLYRd5loTggZou4CcNpKZbD6oLXF1Is8
 7njegH7xqFObh96OKzytmXK171z1C8d/2eOwjoHAxSqvQzIg8Ei5It0dWYqGgT9bRXg/
 ST8RDLyLd3iP3dciqb/EXIyc1Wzr7mlSLxb+lZgss1AKx+l/w3D6oV9FrQ0bKlnxIZHX
 gB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723546970; x=1724151770;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1wAm1xnIwf8JHprxOXl9qTnKn13ic4Imwp4W6zMeQzM=;
 b=HKs544pQFxkB3PdYaqScxDVLmGOeFTfK3kvgDhfk7+vZYoW9e0K3RHoUxdUJSiVHBS
 5Rz5D7oQFNNsmr+rjaIoR87uveJwT35+ch4isRrFB+z4q/h99XTnkwuLffuApe2noBVH
 lRdfszLWfYVAUYPpBzMUyjSYOQDExqmseVRYftKD0u8UHNAgqC1pkhXsWNPvmpRhjH7j
 Vl5U8yqzMGqfCvGP8ukb6pJu1FZa+arA2j9XAPVnhJ7L2woKdPLS6LJJbd2NAgo8APy+
 V2FLfsDD1YrYZn+Gm78IjhCWX3JFw7xTHikDdT/Erva47L5wnn8NIpHk/BzRG93H8i7H
 gwkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGSpz94kXpsqUY6D82FiXZrdd1w073XtibXwQEIVuDSkRL3EkBRscxgluEkcp3XpBHuj/0ISpxyGfsUPxk91/8m86LhfE=
X-Gm-Message-State: AOJu0YyEVNK8+prjIKVl9bCpsfLcrcknRH1PURKoFbVRMeJHLLgMZxYX
 0iCSiNf3rEaxMLF+068quYDvU3xAOgJR7y9s1J8PbdOMCDMgPOaIXIaipTNX9q8=
X-Google-Smtp-Source: AGHT+IGoa8H7fHUg36o1igiKFZFs4haJSr321qmizSIOBLt9ai1zQ/uqARBlH71/I4d6ftDObuBIpA==
X-Received: by 2002:a05:6a20:9d8e:b0:1c4:87b0:9157 with SMTP id
 adf61e73a8af0-1c8d74af5f4mr3644322637.22.1723546969832; 
 Tue, 13 Aug 2024 04:02:49 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e58c7e49sm5599344b3a.93.2024.08.13.04.02.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 04:02:49 -0700 (PDT)
Message-ID: <28dd1808-8a10-49a3-b324-be1496cd0aa4@linaro.org>
Date: Tue, 13 Aug 2024 21:02:41 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 1/2] target/mips: Pass page table entry size in
 bytes to get_pte()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Waldemar Brodkorb <wbx@uclibc-ng.org>
References: <20240813101856.49469-1-philmd@linaro.org>
 <20240813101856.49469-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813101856.49469-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 8/13/24 20:18, Philippe Mathieu-Daudé wrote:
> In order to simplify a bit, pass the PTE size in
> bytes rather than bits.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/sysemu/tlb_helper.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
> index 3ba6d369a6..a8caf3ade8 100644
> --- a/target/mips/tcg/sysemu/tlb_helper.c
> +++ b/target/mips/tcg/sysemu/tlb_helper.c
> @@ -592,13 +592,13 @@ static void raise_mmu_exception(CPUMIPSState *env, target_ulong address,
>    * resulting in a TLB or XTLB Refill exception.
>    */
>   
> -static bool get_pte(CPUMIPSState *env, uint64_t vaddr, int entry_size,
> +static bool get_pte(CPUMIPSState *env, uint64_t vaddr, unsigned entry_bytes,
>           uint64_t *pte)
>   {
> -    if ((vaddr & ((entry_size >> 3) - 1)) != 0) {
> +    if ((vaddr & (entry_bytes - 1)) != 0) {
>           return false;
>       }
> -    if (entry_size == 64) {
> +    if (entry_bytes == 8) {
>           *pte = cpu_ldq_code(env, vaddr);
>       } else {
>           *pte = cpu_ldl_code(env, vaddr);

Considering the next patch, where you need to make the MemOpIdx,
why not pass in the size as MemOp?

> @@ -630,8 +630,8 @@ static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
>       int psn = (env->CP0_PWCtl >> CP0PC_PSN) & 0x3F;
>       int hugepg = (env->CP0_PWCtl >> CP0PC_HUGEPG) & 0x1;
>       int pf_ptew = (env->CP0_PWField >> CP0PF_PTEW) & 0x3F;
> -    uint32_t direntry_size = 1 << (directory_shift + 3);
> -    uint32_t leafentry_size = 1 << (leaf_shift + 3);
> +    uint32_t direntry_size = 1 << directory_shift;
> +    uint32_t leafentry_size = 1 << leaf_shift;

This would then be just directory_shift/leaf_shift unchanged.


r~

