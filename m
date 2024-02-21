Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474C4C5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 20:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rct2g-0001kk-BU; Wed, 21 Feb 2024 15:18:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rct2S-0001fC-Rf
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 15:17:57 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rct2P-0006uf-Qd
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 15:17:56 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dc3b4b9b62so1458595ad.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 12:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708546672; x=1709151472;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gDew28SdckRQPQT3k5bec3vwAaO8IN6eDcspz5j4evQ=;
 b=1hLJHbHFBRjp2geVNz8aY2QGrmVHhRJP3f36dpmuuPynAVRd4AffN79PFBJxSb2civ
 S9D4848gQ12jUfMv9U9hnyWsY7nuk1C9HmsgUlNgzDB77EL4fbjHq3oTCTISjms/QEEH
 CG5y5PnS6t4Qo7QHgIRRq4L71Wl0SqpsGjhMcam+/OLQU9392xGXYTOopj8UFB94iQXn
 VlGG7pM8PTvC5n3vBXjcIxKAH4rCzGPtKA4LbFbBtusT8ZipZ1QrKmxd6c35AftltH6x
 c16GrL7Ci0SMqgzpDl9Db4NzWLFkQV7h7dxqBolMyH2kyhjg3sMnrAckvIAUYmnOwCa8
 AzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708546672; x=1709151472;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gDew28SdckRQPQT3k5bec3vwAaO8IN6eDcspz5j4evQ=;
 b=I1vu+c3tk/RjgyUKbE6uhPT6iZT2se50SPueU+DXRv4EffdkGd1dv8kpQ9TSmCPIeY
 HvJE99NI9sUSShKq+3JZ1HqE+pbM0XZj6nuk8fPea/1T286UMhumwgguvvmWW8kVu7Ye
 +9mPkWOJAVWHmdG5SLWMUD3MlCB0BbM7/eXxpme8eeXv14AJG2E+UMK08rpmtoh4Gcm8
 EV/KGDvKYv6NCc5wbH7sA43H9vKGpS0xA9rWgZz2r62bbHSCnu75/uZr/IP59QmaAceb
 962D2HjqvyNuacSPdEq1hP2XhqgPSH0k6/7jyTPh6EHpW/uKnFUT9AS20v5EdlcsskCq
 XkIg==
X-Gm-Message-State: AOJu0Ywcq+Va2R6wWajkzPFmbKDmQBzHcTEkfq47VdM6fNxoGDlTJAEh
 EW3UH8qsD8Zo7lTpR4YByo7f0RvCM/dP0VKgXAwp8eKiUfpzMiulG4F4tqQB2oU=
X-Google-Smtp-Source: AGHT+IGeCROeCdyOW7mBa2aEpSJKsKa8hAEwPXfkiqA5Yreggyy6bKmX2z43SUQIyEW8Zi9pAjjVgQ==
X-Received: by 2002:a17:903:2345:b0:1db:c113:29bb with SMTP id
 c5-20020a170903234500b001dbc11329bbmr678965plh.34.1708546671931; 
 Wed, 21 Feb 2024 12:17:51 -0800 (PST)
Received: from [172.16.0.69] (c-67-188-2-18.hsd1.ca.comcast.net. [67.188.2.18])
 by smtp.gmail.com with ESMTPSA id
 ks8-20020a170903084800b001dbf5048712sm5996058plb.93.2024.02.21.12.17.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 12:17:51 -0800 (PST)
Message-ID: <699311c4-2adc-416c-a1ef-4aee9374913b@rivosinc.com>
Date: Wed, 21 Feb 2024 12:17:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/8] Add Counter delegation ISA extension support
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 kaiwenxue1@gmail.com, Andrew Jones <ajones@ventanamicro.com>
References: <20240217000134.3634191-1-atishp@rivosinc.com>
 <35a4d40c-9d0d-4a0a-a2c9-5d5f7def9b9c@ventanamicro.com>
 <CAHBxVyEnRcvB5iGDv8rE6oJ6L+yvM12ia+T0ZtsAx73TW5PfrQ@mail.gmail.com>
 <de514d34-b0e3-4776-890d-3d5dc738785c@ventanamicro.com>
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <de514d34-b0e3-4776-890d-3d5dc738785c@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=atishp@rivosinc.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 2/21/24 10:26, Daniel Henrique Barboza wrote:
>
>
> On 2/21/24 14:06, Atish Kumar Patra wrote:
>>
>>
>> On Wed, Feb 21, 2024 at 6:58 AM Daniel Henrique Barboza 
>> <dbarboza@ventanamicro.com <mailto:dbarboza@ventanamicro.com>> wrote:
>>
>>     Hi Atish,
>>
>>     This series and its dependency, which I assume it's
>>
>>     "[PATCH v4 0/5] Add ISA extension smcntrpmf support"
>>
>>     Doesn't apply in neither master nor riscv-to-apply.next because 
>> of this patch:
>>
>>     "target/riscv: Use RISCVException as return type for all csr ops"
>>
>>     That changed some functions from 'int' to "RISCVException" type. 
>> The conflicts
>>     from the v4 series are rather trivial but the conflicts for this 
>> RFC are annoying
>>     to deal with. It would be better if you could re-send both series 
>> rebased with
>>     the latest changes.
>>
>>
>> I was waiting for Alistair's ACK on the smcntrpmf series as he had 
>> some comments. It looks like he is okay
>> with the series now (no further questions).  Let me respin both the 
>> series.
>>
>>     One more thing:
>>
>>     On 2/16/24 21:01, Atish Patra wrote:
>>      > This series adds the counter delegation extension support. The 
>> counter
>>      > delegation ISA extension(Smcdeleg/Ssccfg) actually depends on 
>> multiple ISA
>>      > extensions.
>>      >
>>      > 1. S[m|s]csrind : The indirect CSR extension[1] which defines 
>> additional
>>      >     5 ([M|S|VS]IREG2-[M|S|VS]IREG6) register to address size 
>> limitation of
>>      >     RISC-V CSR address space.
>>      > 2. Smstateen: The stateen bit[60] controls the access to the 
>> registers
>>      >     indirectly via the above indirect registers.
>>      > 3. Smcdeleg/Ssccfg: The counter delegation extensions[2]
>>      >
>>      > The counter delegation extension allows Supervisor mode to 
>> program the
>>      > hpmevent and hpmcounters directly without needing the 
>> assistance from the
>>      > M-mode via SBI calls. This results in a faster perf profiling 
>> and very
>>      > few traps. This extension also introduces a scountinhibit CSR 
>> which allows
>>      > to stop/start any counter directly from the S-mode. As the 
>> counter
>>      > delegation extension potentially can have more than 100 CSRs, 
>> the specificaiton
>>      > leverages the indirect CSR extension to save the precious CSR 
>> address range.
>>      >
>>      > Due to the dependancy of these extensions, the following 
>> extensions must be
>>      > enabled to use the counter delegation feature in S-mode.
>>      >
>>      > 
>> "smstateen=true,sscofpmf=true,ssccfg=true,smcdeleg=true,smcsrind=true,sscsrind=true"
>>      >
>>      > This makes the qemu command line quite tedious. In stead of 
>> that, I think we
>>      > can enable these features by default if there is no objection.
>>
>>     It wasn't need so far but, if needed, we can add specialized 
>> setters for extensions
>>     that has multiple dependencies. Instead of the usual setter we 
>> would do something
>>     like:
>>
>>     cpu_set_ssccfg() {
>>
>>           if (enabled) {
>>               smstateen=true
>>               sscofpmf=true
>>               smcdeleg=true
>>               smcsrind=true
>>               sscsrind=true
>>           }
>>     }
>>
>>
>>     The advantage is that this setter would also work for CPUs that 
>> doesn't inherit defaults,
>>     like bare-cps and profile CPUs.
>>
>>
>> Your suggested approach looks good to me. But I was asking about 
>> concerns about enabling these extensions
>> by default rather than the actual mechanism to implement it. Few of 
>> the extensions listed here such as smstateen,smcsrind
>> sscsrind are independent ISA extensions which are used for other ISA 
>> extensions as well.
>>
>> It looks like you are okay with the use case also ?
>
> I don't mind setting new defaults in rv64.
>
>>
>>     That doesn't mean we can't add defaults for rv64, but for this 
>> particular case I wonder if
>>     the 'max' CPU wouldn't be better.
>>
>>
>> Not sure what you mean here. What does 'max' cpu have to do with pmu 
>> extensions ?
>
>
> Save a few exceptions, all the extensions declared in 
> riscv_cpu_extensions[]
> will be enabled in the 'max' CPU, regardless of their default value 
> for the
> rv64 CPU (see riscv_init_max_cpu_extensions() in tcg-cpu.c).
>

Ahh okay. That makes sense. I got confused with maxcpus option.


> If we count both the v4 and this RFC, the following extensions were 
> added in
> riscv_cpu_extensions[]:
>
> +    MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
>
> +    MULTI_EXT_CFG_BOOL("smcsrind", ext_smcsrind, false),
> +    MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
>
> +    MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
> +    MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
>
>
> All of them will be enabled by default in the 'max' CPU.
>
> This is what I was referring to. We can just use the 'max' CPU and 
> don't worry about
> enabling defaults in rv64.
>
We should definitely enable them in 'max' cpu as these extensions are 
ratified.
The comment in the code says it should enable all ratified extensions. 
Is that a guiding policy ?
Qemu allows merging non frozen extensions.

But rv64 still is the default one everyone running. So I feel we should 
enable there as for user convenience.

>
> Thanks,
>
> Daniel
>
>>
>>
>>     Thanks,
>>
>>
>>     Daniel
>>
>>      >
>>      > The first 2 patches decouple the indirect CSR usage from AIA 
>> implementation
>>      > while patch3 adds stateen bits validation for AIA.
>>      > The PATCH4 implements indirect CSR extensions while remaining 
>> patches
>>      > implement the counter delegation extensions.
>>      >
>>      > The Qemu patches can be found here:
>>      > https://github.com/atishp04/qemu/tree/counter_delegation_rfc 
>> <https://github.com/atishp04/qemu/tree/counter_delegation_rfc>
>>      >
>>      > The opensbi patch can be found here:
>>      > https://github.com/atishp04/opensbi/tree/counter_delegation_v1 
>> <https://github.com/atishp04/opensbi/tree/counter_delegation_v1>
>>      >
>>      > The Linux kernel patches can be found here:
>>      > https://github.com/atishp04/linux/tree/counter_delegation_rfc 
>> <https://github.com/atishp04/linux/tree/counter_delegation_rfc>
>>      >
>>      > [1] https://github.com/riscv/riscv-indirect-csr-access 
>> <https://github.com/riscv/riscv-indirect-csr-access>
>>      > [2] https://github.com/riscv/riscv-smcdeleg-ssccfg 
>> <https://github.com/riscv/riscv-smcdeleg-ssccfg>
>>      >
>>      > Atish Patra (1):
>>      > target/riscv: Enable S*stateen bits for AIA
>>      >
>>      > Kaiwen Xue (7):
>>      > target/riscv: Add properties for Indirect CSR Access extension
>>      > target/riscv: Decouple AIA processing from xiselect and xireg
>>      > target/riscv: Support generic CSR indirect access
>>      > target/riscv: Add smcdeleg/ssccfg properties
>>      > target/riscv: Add counter delegation definitions
>>      > target/riscv: Add select value range check for counter delegation
>>      > target/riscv: Add counter delegation/configuration support
>>      >
>>      > target/riscv/cpu.c      |   8 +
>>      > target/riscv/cpu.h      |   1 +
>>      > target/riscv/cpu_bits.h |  34 +-
>>      > target/riscv/cpu_cfg.h  |   4 +
>>      > target/riscv/csr.c      | 713 
>> +++++++++++++++++++++++++++++++++++++---
>>      > target/riscv/machine.c  |   1 +
>>      > 6 files changed, 722 insertions(+), 39 deletions(-)
>>      >
>>      > --
>>      > 2.34.1
>>      >
>>

