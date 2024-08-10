Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAF4C3DA7F
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2024 11:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sckZF-0004XL-3f; Sat, 10 Aug 2024 07:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sckZ9-0004WS-PE
 for qemu-devel@nongnu.org; Sat, 10 Aug 2024 07:47:25 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sckZ7-0007P1-M0
 for qemu-devel@nongnu.org; Sat, 10 Aug 2024 07:47:23 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fec34f94abso26944335ad.2
 for <qemu-devel@nongnu.org>; Sat, 10 Aug 2024 04:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723290439; x=1723895239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1vKleXDpVbY0mF+npajestsBdmngztylqnlLsJWqYZA=;
 b=tH9SySPsXLQ+FlJk/J65FWTXLW+OndfFqQKH9Fb7wBh6kp62smqKKZKTwaPkNL/qXH
 eHpEJoV1PuJD+IKG7Ok5luR/VZfiih4bh6b7gfCrk25tEB+4qD7jopCo9xvgd5rQtror
 9KFE8SXE7zBBQx1d2CVZs4sxyEEmK19/t7v8PVioJ7CDHNmscY9D7t6Ylz6OTZv0gsnh
 o6Voup7o33rrdnJuldpghAoywo7KK/XQASH2pZ4ATXG92tiAxrfakjaT7//lPCebc/TF
 NQtCh01LnyIVc6tGcwyFdXH2/M1rkIoPWMTaj3Y4ipJ3Dm9IiJVaHgquhUTPDg76IsH6
 LWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723290439; x=1723895239;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1vKleXDpVbY0mF+npajestsBdmngztylqnlLsJWqYZA=;
 b=aRjMSyF+oTJMCQ5wXezdhdeRj/4rtvHGhHMlgoJJITxCaGvsmtC6gJW09VxebYoWhu
 XMkj7Ep992Zl+dqioReD8R0SvTCne4DvAOARtT4ZHh+XXjOeVQq6Ed5qJ+VDv07qEykp
 JGA7P6VbG6AEkUUiKqNXaJhd6Owo2p3zIpRMltL0walQON4R8moM4jI/Um0ikYtfo+WJ
 zhZO9XNPAB3jDLyrR9tjQzGalXZc/JkzQGkqfurxp59Up44BF34MdsOPXm43mTPQhVRf
 2HzWeNTF01Vm3QKmvVcUUjdFPmXlSj1F32/4gaeIFk0UkRlchGyeqlEKyvCTNCte1fmo
 mtpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEq7HeRX9BpSKIV3kR9r8n6pv/EkGahlUxK0nTB/GrY+DTmcifsKlkHpg3OYWX2YiKueMHXkRHyGcA3g3NXoFU0k3iDgQ=
X-Gm-Message-State: AOJu0YzzI54EBzs2vNJbwPi4nq8+fG/JL+ERjOBE/p9x5BDZpKXw6kMM
 Ceiom+HKBh4j4rSLKY/S6fJL3tFSc8X1qKSSNwXHtSK/1+JrSwgS1glP06U2FiEqBCcRMcWsMLe
 sK88=
X-Google-Smtp-Source: AGHT+IHK5wpNAMxY2sUNv26IeFwozqsyQFVHVQkXQ2JLmmxrEjXMlIfESRmJY7uib6Y4FkUSUfwn8Q==
X-Received: by 2002:a17:902:d485:b0:1fd:6529:7436 with SMTP id
 d9443c01a7336-200ae4bb0f3mr51449975ad.8.1723290439383; 
 Sat, 10 Aug 2024 04:47:19 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-200bba0a994sm10554615ad.237.2024.08.10.04.47.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Aug 2024 04:47:18 -0700 (PDT)
Message-ID: <7fc05b05-2b98-41c5-a486-c49c99b51af5@linaro.org>
Date: Sat, 10 Aug 2024 21:47:14 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/57] target/mips: Pass ptw_mmu_idx down from
 mips_cpu_tlb_fill
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
 <20240202055036.684176-17-richard.henderson@linaro.org>
 <1c84a15e-5083-4199-a0f3-59fb3c71e421@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <1c84a15e-5083-4199-a0f3-59fb3c71e421@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 8/10/24 04:11, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 2/2/24 06:49, Richard Henderson wrote:
>> Rather than adjust env->hflags so that the value computed
>> by cpu_mmu_index() changes, compute the mmu_idx that we
>> want directly and pass it down.
>>
>> Introduce symbolic constants for MMU_{KERNEL,ERL}_IDX.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/mips/cpu.h                   |  4 +++-
>>   target/mips/tcg/sysemu/tlb_helper.c | 32 ++++++++++++-----------------
>>   2 files changed, 16 insertions(+), 20 deletions(-)
> 
> 
>> @@ -944,12 +940,10 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>>            * Memory reads during hardware page table walking are performed
>>            * as if they were kernel-mode load instructions.
>>            */
>> -        int mode = (env->hflags & MIPS_HFLAG_KSU);
>> -        bool ret_walker;
>> -        env->hflags &= ~MIPS_HFLAG_KSU;
>> -        ret_walker = page_table_walk_refill(env, address, mmu_idx);
>> -        env->hflags |= mode;
>> -        if (ret_walker) {
>> +        int ptw_mmu_idx = (env->hflags & MIPS_HFLAG_ERL ?
>> +                           MMU_ERL_IDX : MMU_KERNEL_IDX);
> 
> Checking https://gitlab.com/qemu-project/qemu/-/issues/2470.
> 
> Parenthesis are mis-placed.
> 
>            int ptw_mmu_idx = (env->hflags & MIPS_HFLAG_ERL) ?
>                               MMU_ERL_IDX : MMU_KERNEL_IDX;

This makes no difference to the evaluation of this expression.

> 
> Revisiting, we loose possible MMU_USER_IDX value but
> - we don't use it
> - this is sysemu code so we only expect MMU_KERNEL_IDX
> 
> Is that right?

The comment above is correct that ptw reads are performed in kernel mode.

The code previously saved the current mode, cleared the user bit, performed the operation, 
and then restored the previous mode.  There was no possible MMU_USER_IDX during that interval.

The code currently skips the save/restore and simply selects MMU_KERNEL_IDX.


r~

