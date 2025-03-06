Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68022C28B23
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 07:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq5xN-0002XQ-3V; Thu, 06 Mar 2025 02:47:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tq5xJ-0002Vj-BM
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:47:45 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tq5xF-0004jj-U7
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:47:45 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38f406e9f80so262662f8f.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 23:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741247260; x=1741852060; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ERJcXhxy1/ObbXn5t0J/hMiD4CcdF5xsrlCPUqDW6o8=;
 b=w88TpD/bNWvCISEJxRRad26frzU+pA5jDrwSIvLifkRIK+Z/sy0MhtjShaHIPRQIOd
 cMHvUjDR7VRLBRQLtf8uMviL2bHgbLi6/7rWipgrZjCEL0YUiKfwiB5MvZ+FMPIKRojj
 SWhjr/0tyvGsgw5627OpM9oozCjsXpVyK0sWYuqvNZvnqNWnX/J0UlMMDL1B2rFF5xnk
 xxc2GXBV5nuz1AxZZmQgnsPemCX1tOIIAS3ic0Sr81bDKM2rmqsuZMEjDHZdhVHvo7/z
 XpQQfnyw3PJ7AYY27m3ZvIrNhPFi+tIP/Mg8hUc2JCxOIGKSSiD5gdTl5b07v9RvsSZH
 +HxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741247260; x=1741852060;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ERJcXhxy1/ObbXn5t0J/hMiD4CcdF5xsrlCPUqDW6o8=;
 b=g4dcgwAZIErU/9jfmy6hduhCavoQP9ZFBwFO04eS1OxFtonqfDdh80v5lEd+A1X9vH
 EN3IxPtTna5eHChdUCuSnSs9PCSYRWU0Dx61SBxidxfZHlvtydFXB+6anewYQNLmL3ZU
 o3loAYUSlsrcNlRrSV5iYu6mNdSzgOHcaSEnIOOdC5Rfj0rzdTsyB78U3yzXMd6AZOR7
 BD93Q7liHPgF3Wu52MeKjZ6WvBhF+MdselErpKAmKSOP5ZuneKrjVl1zTQEHM7Eegwyo
 3ptvJEwtTkZ1YhcdWtsPi8M52JwF8FM7grSxLgsPPBkBGaLzUPeSW0u9Ao5v8iTpiq8d
 cJQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDHEO8/OSQkg5zlny7cEc/QBb7VzrgX4GVeSfPg8GSbNL6fH+acucfk0aTvUw1Gou1Qbjl+z5XsL1o@nongnu.org
X-Gm-Message-State: AOJu0Yxau+FaSNiWh+xZwhn/LlBgqm3oDs1CpmrrNSI3c3+01od0TZLl
 oDhc1jUPDR3I4afk19CFT4AqZPpXuwUNXMo4J1es+2ul06xIaxP389J6ZYxn/Rs=
X-Gm-Gg: ASbGncsPDoQhFE5bGd/94BuOW1Aum96wsMHHr0CwiSvjL9WWYNFiJNbJ1Kmg4xGPHlG
 xO01a9XNQHcyD2CQOnZtIrNAOFHr3UZc77cuh6YOUDJ0ZTAqXnvnR8a4F7c3Dd9aF9DyZT74Wwr
 ubAwm6KQxxNOpA0oEVhFH5rH1zF2RhTOHDxwej2iQ6q4b9qq4ouJTY6FRM9JowHdi+S4xHEusUs
 2YVDjmK6TpJsIbo7Hm/8hlbqTehGKwFk7RIuzXv0kuKIdGlGPKM5pNfaigI0M0dpp+R1JeXNGhI
 Ly54hvGXmiAq1e8Ut+UJ8f/86Q7VXPxczdPclNK8KCSZ7HTr0t3I0JnmxdgFCmJ9Ng39Tybcba3
 S5AHYdaTWK+v4
X-Google-Smtp-Source: AGHT+IGIe+zZQ09eXOQ7cxk7OVLTCMtyWfl7WSGr4AFkzqYqJIszaNMMGZXNqU/HPgH+fAVaJnVtXw==
X-Received: by 2002:a05:6000:154c:b0:390:e7c1:59c0 with SMTP id
 ffacd0b85a97d-3911f75a94dmr4992264f8f.26.1741247259977; 
 Wed, 05 Mar 2025 23:47:39 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42c5880sm40810155e9.19.2025.03.05.23.47.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 23:47:39 -0800 (PST)
Message-ID: <34ea7324-2df6-4c97-97d3-b37463a3ff7b@linaro.org>
Date: Thu, 6 Mar 2025 08:47:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] target/riscv: Move target-agnostic definitions to
 'cpu-qom.h'
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20250206181827.41557-1-philmd@linaro.org>
 <20250206181827.41557-3-philmd@linaro.org>
 <1faf3550-909d-47ba-89e5-c8955a03784e@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1faf3550-909d-47ba-89e5-c8955a03784e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 9/2/25 08:34, Paolo Bonzini wrote:
> On 2/6/25 19:18, Philippe Mathieu-Daudé wrote:
>> "cpu.h" is target-specific. Definitions which can be used
>> by hw/ code when building QOM blocks can be in "cpu-qom.h",
>> which is target-agnostic.
>>
>> Move the MISA bits (removing the pointless target_ulong cast)
>> and the IRQ index definitions.
> 
> This seems wrong.  Why not move from cpu.h to cpu_bits.h, and include that?

Because of ...

> 
> Paolo
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/riscv/cpu-qom.h  | 40 ++++++++++++++++++++++++++++++++++++++++
>>   target/riscv/cpu.h      | 24 ------------------------
>>   target/riscv/cpu_bits.h | 15 ---------------
>>   3 files changed, 40 insertions(+), 39 deletions(-)


>> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>> index f97c48a3943..80701bc77fe 100644
>> --- a/target/riscv/cpu_bits.h
>> +++ b/target/riscv/cpu_bits.h
>> @@ -720,21 +720,6 @@ typedef enum RISCVException {
>>   #define RISCV_EXCP_INT_FLAG                0x80000000
>>   #define RISCV_EXCP_INT_MASK                0x7fffffff
>> -/* Interrupt causes */
>> -#define IRQ_U_SOFT                         0
>> -#define IRQ_S_SOFT                         1
>> -#define IRQ_VS_SOFT                        2
>> -#define IRQ_M_SOFT                         3
>> -#define IRQ_U_TIMER                        4
>> -#define IRQ_S_TIMER                        5
>> -#define IRQ_VS_TIMER                       6
>> -#define IRQ_M_TIMER                        7
>> -#define IRQ_U_EXT                          8
>> -#define IRQ_S_EXT                          9
>> -#define IRQ_VS_EXT                         10
>> -#define IRQ_M_EXT                          11
>> -#define IRQ_S_GEXT                         12
>> -#define IRQ_PMU_OVF                        13
>>   #define IRQ_LOCAL_MAX                      64
>>   /* -1 is due to bit zero of hgeip and hgeie being ROZ. */
>>   #define IRQ_LOCAL_GUEST_MAX                (TARGET_LONG_BITS - 1)

... this TARGET_LONG_BITS use in cpu_bits.h.

and:

target/riscv/cpu_bits.h:1070:44: error: attempt to use a poisoned identifier
  1070 | #define CPU_INTERRUPT_RNMI                 CPU_INTERRUPT_TGT_EXT_0
       |                                            ^

But I got your idea and will only move these 2 to "cpu.h".

