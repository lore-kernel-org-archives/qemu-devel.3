Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B74CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 16:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCKTw-0005mp-Ty; Fri, 24 Oct 2025 12:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vCKTl-0005kc-Er
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 12:17:26 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vCKTg-0000N4-N6
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 12:17:23 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-78af3fe5b17so1770308b3a.2
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 09:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1761322637; x=1761927437; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E6uzhxh1psBbiU34D81ruT0y+lwt649vh2+AUDnAmHA=;
 b=FSThgytYp6Q2VDJcpyQmmLMcO3fHq4MhMTDO54c9GIc8G47dZL7ZqrwLT3Uv7zGEov
 eJegt3k6b8HwIUiRUgZoIkdqnP9mq0ZJHQqzZg24MVjv9WOys/trKWQ058/nqEYVfMJk
 8/O1j11OctXVmm1rDJdjQjLSPP4YuZn7+iPtf4DQ6OYMBRYngnCvo5e4DoMCgRexZynN
 +VUy1HeG0dhSWlZstOPInB60FGTQo5lxrGcPU6zq7ZkVgbVl0W3uA+or3ynl+2zqAShe
 6f17FoSc8Go+aiyF/uj2CiytGSBAmenjKSFb/wT8/tVYW5/G9eINfsn9gBn56/QARyY1
 zNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761322637; x=1761927437;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E6uzhxh1psBbiU34D81ruT0y+lwt649vh2+AUDnAmHA=;
 b=i5OphFfsXW1txIiAzZlEVdKQ8q0cuEK0Ys7cWVKhTdQ6jswtPGcY1n2ipKLWauqmQJ
 Bi2RhcQk9Wx33MK8W1xl/pYEXb/84hR0av9dxGvkXbs47XJyS4AUY7gAtPkEYvmBrdAU
 b8wJY5gRw+/vJw03TZRkkDa3z1zU7Qx1sdoUQsl+DVe/Rv3BJVJH+GFUmSBkynS2XQ/y
 y5GnMnfp5oRJ7gbTIr1YpOq1HFK3FZdu7Q2w9pa8itbxyzgSe5ruso7pjVm8/+ZycJv9
 iNGJnvwRRzIGE3qrfxz//BE0EjUGBDEd1CWGLIwp44krhJ1jg7PTIoxCuLidtaMiep2P
 SUYA==
X-Gm-Message-State: AOJu0YzsVU+FTZMz5pUMyU3OgaReGnHNbEEfDAbJHKX+mjCpIXvYkZ7R
 B+QFdWekn1zxn3G9quWf1gIg2mlCD6nIgobI0Tqq+wWmbH3E/u/ZvaG4akIzUolUYoA=
X-Gm-Gg: ASbGncvpr2OL5pR39cM+3dF7daJa4Tv+afYxGhcGEQDXfST/po4Xu2Cs/nVwaMtOVRX
 GyrSCm+xkvcqUrQkTCpGBCrJs8kahoCxZEoOKfaed2w6xY8Z53BaZE7pGWZMLqE/d64ii2iVosj
 6E6upBumTFpj0WFSILa3CCjnS9SQU3nPlWNOSXzU+QwzRdswZly5HFF3ON0NrGeT61kWYsJVLyF
 zbyrSC117KYu4WIQ6Bnm0Xf+RwLfu4gCHsPFf2lyJQgO9WzMvaYyO5dJHAitrhNWzif/Wj2Y6JB
 0zZgR/3elcJX7r0+RNhK3M0f4JFXW8vfJBQErhW4pK1j2Yw+4nNyQc01z5tKBprgwKy9Qv+vnbV
 /Jx+5yHz6zumX67pbrp2hNhABqjK2K4BXvbcwF8ezJi7AiALLbTS7h1uvh2QLoL5Mtfns1+vGTw
 zHP04XdB1YRJeK
X-Google-Smtp-Source: AGHT+IGm3awQGimqtr1e2KZX2R0AQ2XTdjFRROYV4XvZG9HF0Ic3c3tF+yGhyTD08y46l3QpNH0STw==
X-Received: by 2002:a17:903:1247:b0:23f:fa79:15d0 with SMTP id
 d9443c01a7336-290cb07adc0mr358146015ad.46.1761322636902; 
 Fri, 24 Oct 2025 09:17:16 -0700 (PDT)
Received: from [192.168.68.110] ([189.38.141.22])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946ddddc34sm60100185ad.20.2025.10.24.09.17.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 09:17:16 -0700 (PDT)
Message-ID: <f9c1c814-c083-4c9b-831c-4cd5ce162002@ventanamicro.com>
Date: Fri, 24 Oct 2025 13:17:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 47/56] target/riscv/kvm: add scounteren CSR
To: Peter Maydell <peter.maydell@linaro.org>, alistair23@gmail.com
Cc: qemu-devel@nongnu.org, Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
 <20250519040555.3797167-48-alistair.francis@wdc.com>
 <CAFEAcA_6zma2=nsBWB7ebb35Jt1cNAChiMG0xnkT3WPEY8csiw@mail.gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA_6zma2=nsBWB7ebb35Jt1cNAChiMG0xnkT3WPEY8csiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x433.google.com
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



On 10/24/25 10:43 AM, Peter Maydell wrote:
> On Mon, 19 May 2025 at 05:25, <alistair23@gmail.com> wrote:
>>
>> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>
>> Add support for the scounteren KVM CSR. Note that env->scounteren is a
>> 32 bit and all KVM CSRs are target_ulong, so scounteren will be capped
>> to 32 bits read/writes.
>>
>> Reported-by: Andrew Jones <ajones@ventanamicro.com>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> Message-ID: <20250429124421.223883-10-dbarboza@ventanamicro.com>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>   target/riscv/kvm/kvm-cpu.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
>> index ca171d5457..82f9728636 100644
>> --- a/target/riscv/kvm/kvm-cpu.c
>> +++ b/target/riscv/kvm/kvm-cpu.c
>> @@ -251,6 +251,7 @@ static KVMCPUConfig kvm_csr_cfgs[] = {
>>       KVM_CSR_CFG("stval",      stval,      RISCV_CSR_REG(stval)),
>>       KVM_CSR_CFG("sip",        mip,        RISCV_CSR_REG(sip)),
>>       KVM_CSR_CFG("satp",       satp,       RISCV_CSR_REG(satp)),
>> +    KVM_CSR_CFG("scounteren", scounteren, RISCV_CSR_REG(scounteren)),
>>       KVM_CSR_CFG("senvcfg",    senvcfg,    RISCV_CSR_REG(senvcfg)),
>>   };
>>
>> @@ -701,6 +702,7 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
>>       env->stval = 0;
>>       env->mip = 0;
>>       env->satp = 0;
>> +    env->scounteren = 0;
>>       env->senvcfg = 0;
>>   }
> 
> Hi -- this came up in a conversation on IRC. Does this new
> CPU state field need migration support adding in machine.c ?


Hmm, I believe it already has, doesn't it?

target/riscv/machine.c:


const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
     .version_id = 10,
     .minimum_version_id = 10,
     .post_load = riscv_cpu_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
(...)
        VMSTATE_UINT32(env.scounteren, RISCVCPU),  <-------


Or are you referring to something else like post_load callbacks and so on? Thanks,

Daniel


> 
> thanks
> -- PMM


