Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1867AD132B5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 12:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7wVn-00025Z-SD; Mon, 04 Nov 2024 07:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t7wVX-0001so-IC
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:48:40 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t7wVU-0003As-ED
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:48:34 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4315c1c7392so36046645e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 04:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730724510; x=1731329310; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LcEn+jhI8R3XvrV9KMQ/q343gWawxnMW6rdC6JsA3Ek=;
 b=qBNp6J0X76BRX2N6UbXgLzGgU58PsGdWx9q3vcWG3fGjtVXZD8AjL9Vy6lyOSmCJ5g
 qwIu9fHHPEFT/49aCnX/aQbMNR7lGHzCOc6QL4RqKCLysP2rTtVJ6t8Za1cDvTw0Pp4I
 3vddeaWB072SS0blhUmZxqaXU3VkqiRLOVgKxWve18OgHoP9TGzxXe8PZd77xFzRQQk7
 TEREzfjZM6Prd1AAJFDnu59JQ86zsiMw43uGaHMum3FYvnsnLmH3dm33DIyIrapK/m7Z
 61p634AULwwwM6JFCl2KF4UP/if19N0LyUTbirKarpJdpJ0H0weFou1j8vc9BoX0It1p
 Hz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730724510; x=1731329310;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LcEn+jhI8R3XvrV9KMQ/q343gWawxnMW6rdC6JsA3Ek=;
 b=iqWcz777OPo/idKQbqT1D1VQO7FdqxLw10TJG5J1KvKbTW7jLsTbdIPEdVLgBRJN2o
 pzvX3VkU0Q0Jm6jJ0a3bgHwdiUX2UTa/DMeMKVsoiduJ5LEN/mMU9B6EJQEt1ha526KX
 HnXyQZCxkNGUeLoGElmeCFmUnIyhDuyFitys6k/adUJbiL1hLBY7vKXi+r3u3MBM4Y3q
 r3WmyWQS0/BCuXQjY7WTAMi4CCitRvtfbAb4WAodMeKXdRezgUgpYlcGp1iYl5Xft2OD
 C/8WY7qtdcTBRaYuAQOOsQ4eBFXQFdtaFgyUXsmKiCRoWVnZ5bv3ARwDQNYhI0qk1ikM
 14hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2eBafwmgcVLSdeA/rZfNFW/FohS0GrjFqsMMJTeA+x8c7Tp43ro5t5aWzZ+VQUtBbYYc6jLFVL7/V@nongnu.org
X-Gm-Message-State: AOJu0YwOgjEL1YiCn7ZQpWvkfGUkKhyaH6yKRaPHPew3ljr+Go37z4EJ
 BRYqSZ0mzEr1ka6Fp2mHGr5lWje3dJXThafzUkcjA4nf52Kts9JdWwKoHXRZIRQ=
X-Google-Smtp-Source: AGHT+IFRCDSe5LTZ/HQFfImnXc1ZX0AVl1iZ1i5RkXcnr432FgVMB2EK8W5vJ58jB16/kRcCu4/h6A==
X-Received: by 2002:a05:6000:78a:b0:37c:d299:b5f0 with SMTP id
 ffacd0b85a97d-381c7ae0a06mr7782431f8f.59.1730724509628; 
 Mon, 04 Nov 2024 04:48:29 -0800 (PST)
Received: from [192.168.21.227] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e747csm13145345f8f.64.2024.11.04.04.48.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 04:48:29 -0800 (PST)
Message-ID: <54c99505-21ef-422c-a7fe-a2d7dabc3d6c@linaro.org>
Date: Mon, 4 Nov 2024 12:48:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 2/2] target/riscv: rvv: improve performance of RISC-V
 vector loads and stores on large amounts of data.
To: Paolo Savini <paolo.savini@embecosm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>
References: <20241029194348.59574-1-paolo.savini@embecosm.com>
 <20241029194348.59574-3-paolo.savini@embecosm.com>
 <7a046c99-c4e7-4395-8dc9-9139e9bfba06@linaro.org>
 <96e7601d-14aa-4741-8f6a-ae4a1c397a44@embecosm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <96e7601d-14aa-4741-8f6a-ae4a1c397a44@embecosm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

On 10/30/24 15:25, Paolo Savini wrote:
> Thanks for the review Richard.
> 
> On 10/30/24 11:40, Richard Henderson wrote:
>> On 10/29/24 19:43, Paolo Savini wrote:
>>> This patch optimizes the emulation of unit-stride load/store RVV instructions
>>> when the data being loaded/stored per iteration amounts to 16 bytes or more.
>>> The optimization consists of calling __builtin_memcpy on chunks of data of 16
>>> bytes between the memory address of the simulated vector register and the
>>> destination memory address and vice versa.
>>> This is done only if we have direct access to the RAM of the host machine,
>>> if the host is little endiand and if it supports atomic 128 bit memory
>>> operations.
>>>
>>> Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
>>> ---
>>>   target/riscv/vector_helper.c    | 17 ++++++++++++++++-
>>>   target/riscv/vector_internals.h | 12 ++++++++++++
>>>   2 files changed, 28 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
>>> index 75c24653f0..e1c100e907 100644
>>> --- a/target/riscv/vector_helper.c
>>> +++ b/target/riscv/vector_helper.c
>>> @@ -488,7 +488,22 @@ vext_group_ldst_host(CPURISCVState *env, void *vd, uint32_t byte_end,
>>>       }
>>>         fn = fns[is_load][group_size];
>>> -    fn(vd, byte_offset, host + byte_offset);
>>> +
>>> +    /* __builtin_memcpy uses host 16 bytes vector loads and stores if supported.
>>> +     * We need to make sure that these instructions have guarantees of atomicity.
>>> +     * E.g. x86 processors provide strong guarantees of atomicity for 16-byte
>>> +     * memory operations if the memory operands are 16-byte aligned */
>>> +    if (!HOST_BIG_ENDIAN && (byte_offset + 16 < byte_end) &&
>>> +            ((byte_offset % 16) == 0) && HOST_128_ATOMIC_MEM_OP) {
>>> +      group_size = MO_128;
>>> +      if (is_load) {
>>> +        __builtin_memcpy((uint8_t *)(vd + byte_offset), (uint8_t *)(host + 
>>> byte_offset), 16);
>>> +      } else {
>>> +        __builtin_memcpy((uint8_t *)(host + byte_offset), (uint8_t *)(vd + 
>>> byte_offset), 16);
>>> +      }
>>
>> I said this last time and I'll say it again:
>>
>>     __builtin_memcpy DOES NOT equal VMOVDQA
> I am aware of this. I took __builtin_memcpy as a generic enough way to emulate loads and 
> stores that should allow several hosts to generate the widest load/store instructions they 
> can and on x86 I see this generates instructions vmovdpu/movdqu that are not always 
> guaranteed to be atomic. x86 though guarantees them to be atomic if the memory address is 
> aligned to 16 bytes.

No, AMD guarantees MOVDQU is atomic if aligned, Intel does not.
See the comment in util/cpuinfo-i386.c, and the two CPUINFO_ATOMIC_VMOVDQ[AU] bits.

See also host/include/*/host/atomic128-ldst.h, HAVE_ATOMIC128_RO, and atomic16_read_ro.
Not that I think you should use that here; it's complicated, and I think you're better off 
relying on the code in accel/tcg/ when more than byte atomicity is required.


r~

