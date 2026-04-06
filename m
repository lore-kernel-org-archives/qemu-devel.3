Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BBAE9D828
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 00:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9Xek-00021Z-Nc; Sun, 05 Apr 2026 20:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9Xei-00020m-Mh
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:17:28 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9Xeh-000108-50
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:17:28 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-82cd6614a90so1442948b3a.3
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 17:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775434645; x=1776039445; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+cmSZ4Go5K4fsWPrlXv779RUA043RZLj1ZNTmdj4sb0=;
 b=N69rFTYgFhDqFYUgBdZPsZKZxvDFu3tFWMpo1AuYREX4Nxm7cfAh61L1m4XWV82ufn
 boKOCmxkoNNWWZI2FiFPUFjjfACSPJBqR0gILjEsTdnugXKJTcpGgb6M7hF6+eR6X/Fd
 zn9i4tO785DeVolKg4zboErGO5MNP7JVDDlkbyeFsfE/foLiD4B4jzkE8eoxGrKupZqd
 TN4P1UtnO2s6P9ObJ+5PJMuypm86nIQ8Tljqi3RzuVT5RXPt9Ph0P22mOCDkbRDHcq7b
 qxxvirTDXUPXwpBgObDqek+NarAYvBao1mb/LL1fFYgugDOevtJiMrD2zNPeMyN5t8Wb
 zIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775434645; x=1776039445;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+cmSZ4Go5K4fsWPrlXv779RUA043RZLj1ZNTmdj4sb0=;
 b=dVZNQ2foVc4qKhBsstjgT2ABhmrk8efvLPLcCHm7ibs+HeDcQcyimF3tuDH8ylx8NA
 PDbOkYIE8T+rutLZyWvcGN44053FXtOZX9fc7oil1AQn1Th2D3Q/MqIkfq85dEjqNa5r
 fbHL3T74bW/GcSgkJBn/ky8Jh0KTG4eJymPHqAVe+O9Xqwa32hO5u0VyyLOz2+BNbuLx
 Kq63qejkUKzdFFGU2+Rnnqm9LuwqC241k5WUdgmVi2GzApIWsdABthliExQxn1nXlZ+e
 YiRCimUH7XwpuqwRO7ZJmbKjwNJX+TWvEssZxP6ClPp6qhV+ph9lxEQksYZ7TQ4iQtKN
 uoFQ==
X-Gm-Message-State: AOJu0Yz88W8owIiESMTTzvnrc0ohoo3oYfhwHWevc3XO2f0qblbOefXA
 QJ5An+0XUXppXrUmK/pTD0IisDs0no7WpoT69xHj2LrQ89DNCWOnHYxvaXukfoLpN9YbwESoEmq
 3XXbS
X-Gm-Gg: AeBDietdBYZT8mQKCd/LmwbylxOGoPTUqDeIBCZAEfbogzYhOdXt3btTzx7Vy3ctwV0
 Qoi0inpCf1HD5pZIAIgHnZXfE0vDL52jdQ76bheHqKH0hJz7PB2805zqpuj97jC1eJf09JkcX8l
 3kBH3jmRWZlTuBhhVQ9aDn46rJwJHik4zpJHW1u4VNjD60efePeAtP1pgABrlNTnTxJd12ZE80I
 yh0qm39SZl5XPy3Kg1QnYaQu+1OS3cZJdstA/2c2mmTktylh4mSU/w4w1vrkKsWgitidYkPKPCW
 Q8Vjp8OAGwse00/jGJaYSWrNlo+PFIKfqhPQ0ee626tu6JB/QXd4J9GdR66lx81/ry4fH2C0IY2
 BvW4OiEOJYhbsQ1Gjag3tRi79NhVxv3A0h+iF1cgSVDfDjz2X8HskOJbrQO+OSpCUejBx41rXkY
 6GZJAVI89ggufI2lO4SD8IhRUr3FA5IX8k7/RDF6asCr4E4U2oD8fdRZXls/YIAYWr7jU=
X-Received: by 2002:a05:6a00:408d:b0:829:8c23:f70e with SMTP id
 d2e1a72fcca58-82d0dbabbf2mr9958179b3a.45.1775434645086; 
 Sun, 05 Apr 2026 17:17:25 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9ca14b3sm13889497b3a.54.2026.04.05.17.17.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 17:17:24 -0700 (PDT)
Message-ID: <9065ca22-4683-4338-b8ff-5fb54640592c@linaro.org>
Date: Mon, 6 Apr 2026 10:17:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 21/35] target/arm: use syndrome helpers to query VNCR
 bit
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-22-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-22-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 3/21/26 00:05, Alex Bennée wrote:
> These are only valid for data abort syndromes.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/tcg/tlb_helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
> index c74d8e785a6..bbe1e70bc43 100644
> --- a/target/arm/tcg/tlb_helper.c
> +++ b/target/arm/tcg/tlb_helper.c
> @@ -48,7 +48,7 @@ static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
>        * ST64BV, or ST64BV0 insns report syndrome info even for stage-1
>        * faults and regardless of the target EL.
>        */
> -    if (template_syn & ARM_EL_VNCR) {
> +    if (FIELD_EX32(template_syn, DABORT_ISS, VNCR)) {
>           /*
>            * FEAT_NV2 faults on accesses via VNCR_EL2 are a special case:
>            * they are always reported as "same EL", even though we are going
> @@ -190,7 +190,7 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
>        * because we masked that out in disas_set_insn_syndrome())
>        */
>       bool is_vncr = (access_type != MMU_INST_FETCH) &&
> -        (env->exception.syndrome & ARM_EL_VNCR);
> +        FIELD_EX32(env->exception.syndrome, DABORT_ISS, VNCR);
>   
>       if (is_vncr) {
>           /* FEAT_NV2 faults on accesses via VNCR_EL2 go to EL2 */

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

