Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F9AC0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 23:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thckz-00030s-N1; Mon, 10 Feb 2025 18:00:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thcks-0002vG-Nf
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:59:54 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thckq-0001YE-7A
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:59:54 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38dd93a4e8eso1705105f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 14:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739228390; x=1739833190; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6uJYWG/CKUK21TL34ACFa9VcxuKRpp3O2dx6sRfNcbE=;
 b=fodJrOV7AfoSqTJQ7Wgz1RqsxHtQfPinyz7lKLAg4tw00ao1o4w0alRzgAlWfGPAj+
 gPgFNkOh2HFvau9w+jFNm35tTUCRHCb4SGQocGrZU1UxyDOZs7VzBoKiXHTo6D7pPUnE
 oi7xfiMoF8UD3tM1eQS5j3w1Z2ZHnq/Tv2UuJQ6/OlxVwXJ9p25/K3QION3hWra3Wn8G
 MQgumzXjZ0QZTGbl81YAI71iehe2z1qcvqNr9aKr/NTmsM4WNbfi0GNpbAWzT9w2ZItC
 17kAUl00wUMuLaEAgX4gse+cOW+QF/+mslKsFD1P9im4tpL1gpgwE1znuw+SnxYH4bFQ
 JUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739228390; x=1739833190;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6uJYWG/CKUK21TL34ACFa9VcxuKRpp3O2dx6sRfNcbE=;
 b=fhKLPR9u5O+Zru9rfMkUNaXcqltTt2w1yf8VKGkcOWE5nUlVJkWgPCvSgBUS6qVq8D
 wbbSzS+5qTxGEGs8n34x8ekCaD2fnqZikXXosJom+nGOyOO59iVflQgU/BH8YpSELwkL
 eztcB+G2nS28Zu2rNkzojP/dxfzEG68pgpBshcdEO9UutmcZd/zjZi8KxOGmzeNZxZaD
 BrPKDn4ie628vemyQQRjb1J4/V/caFT02ZUVcKln6k0CbO8gpDcAotlHqoWJE673zHSY
 E9X6Dwzt0xpgQk5dCrCtCCq/QteZeU4TvFz/W5tZHLBs6v0Nd1BsxguuhYgPlyk696w9
 tfyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDPgIac95v5690rm4sjAM46sJSgjCjzCc87wk1HGmrKeLOMIY3TFb1/Cow0f7U8AKItveG2Gc3eGTM@nongnu.org
X-Gm-Message-State: AOJu0YzvGQkwLPmYJVoJuyPVoruFfUr1YeBrJyNrQz5/M00fkdc5Iag4
 psQy2caRkbKRExt2eDT1US/HS31HvPzHSRph5LvEpCoDZIVB896Hj9WvO6qfHy0=
X-Gm-Gg: ASbGncsENtKOITz0i9eny2EN2ZwlcTpE0ke3kDyZND1llbGYgjrs77IETQ6UAkEh1dG
 hGgBrCtlnu/og3ve5MBaGBxSrP03hA15fqbhvl6MYU1X4mmM9GjS8ghJ4Xj6NVxzbcc7JGUzbMg
 K3/U5a5KCYb2Iez5km9WuYVtjweq/Dl/ho7n3Qy5U6m/nZBluZSTvLWppgNc8WX/SEHDuEb3yXj
 Io91coqJCo5HCkc4llk2m1c2/0e6BlMRfKYC2+MCREoyAYHqwkrnxD+kdmuAFSgkgv1x/t1UZ+R
 pcRxxnRzv10QyKQmcYjHK0RUVVfN1YPMPtInURyjslOaMl9rMYfi+tMbRjY=
X-Google-Smtp-Source: AGHT+IEVcjOPiCt4w83ifCCGjNLlo3+DZaaCmHPQZQGKnpUOy/GeMQ+ZL8f08e45O+rcOM2iNF5GzA==
X-Received: by 2002:a05:6000:1865:b0:38c:5e03:5bb with SMTP id
 ffacd0b85a97d-38dc9138e84mr14125879f8f.41.1739228390001; 
 Mon, 10 Feb 2025 14:59:50 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd6548b25sm7342066f8f.32.2025.02.10.14.59.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 14:59:49 -0800 (PST)
Message-ID: <d831600a-9a61-45c1-a535-f75bb64cdff4@linaro.org>
Date: Mon, 10 Feb 2025 23:59:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] target/arm: Set disassemble_info::endian value
 in disas_set_info()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Thomas Huth
 <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org
References: <20250210212931.62401-1-philmd@linaro.org>
 <20250210212931.62401-4-philmd@linaro.org>
 <7056fbfc-58eb-4881-a6ee-67b3e608a336@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7056fbfc-58eb-4881-a6ee-67b3e608a336@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 10/2/25 23:10, Richard Henderson wrote:
> On 2/10/25 13:29, Philippe Mathieu-Daudé wrote:
>> Have the CPUClass::disas_set_info() callback set the
>> disassemble_info::endian field.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/arm/cpu.c | 10 +++-------
>>   1 file changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 94f1c55622b..68b3a9d3ab0 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -1188,7 +1188,7 @@ static void arm_disas_set_info(CPUState *cpu, 
>> disassemble_info *info)
>>   {
>>       ARMCPU *ac = ARM_CPU(cpu);
>>       CPUARMState *env = &ac->env;
>> -    bool sctlr_b;
>> +    bool sctlr_b = arm_sctlr_b(env);
>>       if (is_a64(env)) {
>>           info->cap_arch = CS_ARCH_ARM64;
>> @@ -1215,13 +1215,9 @@ static void arm_disas_set_info(CPUState *cpu, 
>> disassemble_info *info)
>>           info->cap_mode = cap_mode;
>>       }
>> -    sctlr_b = arm_sctlr_b(env);
>> +    info->endian = BFD_ENDIAN_LITTLE;
>>       if (bswap_code(sctlr_b)) {
>> -#if TARGET_BIG_ENDIAN
>> -        info->endian = BFD_ENDIAN_LITTLE;
>> -#else
>> -        info->endian = BFD_ENDIAN_BIG;
>> -#endif
>> +        info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_LITTLE : 
>> BFD_ENDIAN_BIG;
>>       }
>>       info->flags &= ~INSN_ARM_BE32;
>>   #ifndef CONFIG_USER_ONLY
> 
> This is a faithful adjustment to the existing code, so,
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> However:
> 
> (1) aarch64 code is always little-endian,
> (2) sctlr_b is always false from armv7 (and thus always false for aarch64)
> (3) I think the BE32 logic is wrong -- CONFIG_USER_ONLY is irrelevant.
>      See linux-user/arm/cpu_loop.c, target_cpu_copy_regs.

What about v7-R [*]? I don't see SCTLR_IE defined as 1<<31 for AArch32,
only:

#define SCTLR_EnIA    (1U << 31) /* v8.3, AArch64 only */
#define SCTLR_DSSBS_32 (1U << 31) /* v8.5, AArch32 only */

---

[*] 
https://developer.arm.com/documentation/ddi0406/cb/System-Level-Architecture/System-Control-Registers-in-a-PMSA-implementation/PMSA-System-control-registers-descriptions--in-register-order/SCTLR--System-Control-Register--PMSA

SCTLR_IE, bit[31]

Instruction Endianness. This bit indicates the endianness of the
instructions issued to the processor. The possible values of this bit are:

0: Little-endian byte ordering in the instructions.
1: Big-endian byte ordering in the instructions.

When set to 1, this bit causes the byte order of instructions to be 
reversed at runtime.

This bit is read-only. It is implementation defined which instruction 
endianness is used by an ARMv7-R implementation, and this bit must 
indicate the implemented endianness.

---

For the Cortex-r5* we have, SCTLR_IE is always 0 in reset_sctlr.

Is it OK to consider v7-R implemented as little-endian in QEMU?

