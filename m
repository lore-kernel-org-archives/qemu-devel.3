Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0570C369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 11:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Ml4-0003Rn-48; Mon, 28 Apr 2025 07:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9Mky-0003Mb-JV
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 07:34:41 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9Mkw-00070i-9K
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 07:34:40 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-224171d6826so70256865ad.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 04:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745840075; x=1746444875; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fu7sRBtJPEYmTWcMmeOGRGS0ZMmaoMKDbYrKi7QmIlM=;
 b=Nehel6kWAMJT/YtKhkYhOymDr3nV4E/WUwZYjJnlKYZcrDCirXm/Cn3TAb8fQWrBHx
 nSeV8UNgAqPeR35zyGavUWCMUi5TgUoBAS1mqu0hrwxmt3Zn+J/VMw1rKE2IjHXColql
 07cDFbX4k7VuFk+E0qcrNM0nRUHpH738CKqMMbrhvywTm+/VgIy1DwtY1IIZCHk6E8GE
 1YujLG9YBX+/XCRfxmRQIN1WYbC/zLlN5exkedcv9kG6TuhwlGm9kz8/dTUW4EEeSWZW
 q54C+oyTXdDNS35PwFvn5St+cwJD0kujUFxxGw6Zl3E+1FW0ftuN51cnfbGe5auslZFF
 BPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745840075; x=1746444875;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fu7sRBtJPEYmTWcMmeOGRGS0ZMmaoMKDbYrKi7QmIlM=;
 b=xPD85U6Ab3sUrht2TnQ43x00Kge5s6fcIM9SPA9pY/dgjZoNxJWo+LayYqvG0gFQtF
 7NGp6y7vA/WTyiEMp56gbgngq3p/TpDAxXGBbQNPIXB/5TCZoiTEscRYUsqWXJZdL5a6
 Q+vD3CBfyWBE/doVbf2mhzeh4k3gC97A06M6k4VydKdk4L7F68JOOQWBP4DUbCrYauKi
 EaqhXkJpR+kM4C0JTxdya32vhfmqKgOeSNqotpJ+VBV4dUgKYIYLXoFmHavVUpDsQrA5
 C0da5MV5A7vTfZq+/2YkKIHSUkKZB5Hef5cjO/A72+2ui7DW+uPYg6r81Lgw+nyDPUWw
 WxJw==
X-Gm-Message-State: AOJu0YyTEqT7Iv3rhGSZ2ZNZ2aNB9DXv/bd+73RNnQD0f6Y70+zH0kKS
 OOZIi4OQmh3kZcQRP8bovqy0SUV852SF3O9w1vT/5rKnqx4S7vnX8hki4UhqObg4tF9TmY46n0c
 l
X-Gm-Gg: ASbGncudz51gl3hlV9Wd1IXg7H9Eem4WmBXdykA3xAVu25emzSL4esmS6WTsz3GB/kX
 yj4qDcGexdw53sl/xAtIWlDqp+ffPHpbbibIPfNBVOxOECNSAtXT1l/r909QTZN7vyKPE1tLD6N
 g3JjnjH+Osq/Y6Bux10bupDkeFJUow7vIt/Hquv83YDJeUgcgGX/OZ3DM91wJGNw1B57HWXoSpD
 R/uY2R9bo+3lIVl0uDOoqEnLA2mtKkStJ8dOIjnNbcQarLJILr5GOf07FmoG3YA/AreZiw414/C
 DY9hLGp/iaM033s2CSXQ+PzR9RfSsXvIa+N06TiHiCY6F6+/c8ezGRI=
X-Google-Smtp-Source: AGHT+IHeFrEeB01OKdN0AiwQ+HaAdRP4E72PH//lutC4leuC+ms2VjU33MrwWbrwvS0/S/S7I2w2Kw==
X-Received: by 2002:a17:902:f60e:b0:224:c46:d166 with SMTP id
 d9443c01a7336-22dc6a684famr140115785ad.40.1745840075577; 
 Mon, 28 Apr 2025 04:34:35 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db51026dfsm80351235ad.170.2025.04.28.04.34.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 04:34:35 -0700 (PDT)
Message-ID: <cff08cd2-9223-42e1-aa54-d5094b74ebf4@ventanamicro.com>
Date: Mon, 28 Apr 2025 08:34:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] target/riscv: widen scounteren to target_ulong
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20250425160203.2774835-1-dbarboza@ventanamicro.com>
 <20250425160203.2774835-9-dbarboza@ventanamicro.com>
 <20250427-e13fa003b1bfad48e17bcee9@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250427-e13fa003b1bfad48e17bcee9@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
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



On 4/27/25 2:59 AM, Andrew Jones wrote:
> On Fri, Apr 25, 2025 at 01:02:02PM -0300, Daniel Henrique Barboza wrote:
>> We want to support scounteren as a KVM CSR. The KVM UAPI defines every
>> CSR size as target_ulong, and our env->scounteren is fixed at 32 bits.
>>
>> The other existing cases where the property size does not match the KVM
>> reg size happens with uint64_t properties, like 'mstatus'. When running
>> a 32 bit CPU we'll write a 32 bit 'sstatus' KVM reg into the 64 bit
>> 'mstatus' field. As long as we're consistent, i.e. we're always
>> reading/writing the same words, this is ok.
>>
>> For scounteren, a KVM guest running in a 64 bit CPU will end up writing
>> a 64 bit reg in a 32 bit field. This will have all sort of funny side
>> effects in the KVM guest that we would rather avoid.
>>
>> Increase scounteren to target_ulong to allow KVM to read/write the
>> scounteren CSR without any surprises.
>>
>> Aside from bumping the version of the RISCVCPU vmstate no other
>> behavioral changes are expected.
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/cpu.h     | 9 ++++++++-
>>   target/riscv/machine.c | 6 +++---
>>   2 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index f5a60d0c52..66d4ddfcb4 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -400,7 +400,14 @@ struct CPUArchState {
>>        */
>>       bool two_stage_indirect_lookup;
>>   
>> -    uint32_t scounteren;
>> +    /*
>> +     * scounteren is supposed to be an uint32_t, as the spec
>> +     * says. We're using a target_ulong instead because the
>> +     * scounteren KVM CSR is defined as target_ulong in
>> +     * kvm_riscv_csr, and we want to avoid having to deal
>> +     * with an ulong reg being read/written in an uint32_t.
>> +     */
>> +    target_ulong scounteren;
> 
> I'm having second thoughts about this. It seems like it should be
> avoidable with the use of an intermediary buffer (which we already
> have -- the uint64_t reg) and with tracking the size of the env state
> by capturing the size with the new macro used to build the array.

scounteren is an uint32_t field so I'm not sure why we need to track it.


> Then,
> 
> for reading:
>   1. read the kvm reg into a buffer of the size kvm says it is
>   2. only write the bytes we can store from the buffer into the env state,
>      using the size field to know how many that is
> 
> for writing:
>   1. put the env state into a buffer of the size kvm says the register is,
>      ensuring any upper unused bytes of the buffer are zero
>   2. write the buffer to kvm


So in short we would just read/write the lower 32 bits of scounteren, making it
a 32 bit CSR as far as QEMU is concerned. Given that it is a 32 bit CSR in the
RISC-V ISA too I guess it's safe for QEMU to do this assumption.


Thanks,

Daniel


> 
> Thanks,
> drew
> 
>>       uint32_t mcounteren;
>>   
>>       uint32_t scountinhibit;
>> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
>> index df2d5bad8d..f3477e153b 100644
>> --- a/target/riscv/machine.c
>> +++ b/target/riscv/machine.c
>> @@ -401,8 +401,8 @@ static const VMStateDescription vmstate_ssp = {
>>   
>>   const VMStateDescription vmstate_riscv_cpu = {
>>       .name = "cpu",
>> -    .version_id = 10,
>> -    .minimum_version_id = 10,
>> +    .version_id = 11,
>> +    .minimum_version_id = 11,
>>       .post_load = riscv_cpu_post_load,
>>       .fields = (const VMStateField[]) {
>>           VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
>> @@ -445,7 +445,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>>           VMSTATE_UINTTL(env.mtval, RISCVCPU),
>>           VMSTATE_UINTTL(env.miselect, RISCVCPU),
>>           VMSTATE_UINTTL(env.siselect, RISCVCPU),
>> -        VMSTATE_UINT32(env.scounteren, RISCVCPU),
>> +        VMSTATE_UINTTL(env.scounteren, RISCVCPU),
>>           VMSTATE_UINT32(env.mcounteren, RISCVCPU),
>>           VMSTATE_UINT32(env.scountinhibit, RISCVCPU),
>>           VMSTATE_UINT32(env.mcountinhibit, RISCVCPU),
>> -- 
>> 2.49.0
>>


