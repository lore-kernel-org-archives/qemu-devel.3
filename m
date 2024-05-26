Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A35C25B7A
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 17:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBHTh-0006Vu-Vz; Sun, 26 May 2024 13:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sBHTf-0006VN-6S
 for qemu-devel@nongnu.org; Sun, 26 May 2024 13:16:12 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sBHTb-0005U8-Op
 for qemu-devel@nongnu.org; Sun, 26 May 2024 13:16:10 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6f4603237e0so3184777b3a.0
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 10:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716743766; x=1717348566; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lxBTDxzOkpKcHWc+oV7moh6IE1OfEOSm934E6mbjuyM=;
 b=nZ5gT+ZF5eRO0cNAtLIC3MoUFq2Sij8zWesRqVS2TrwTUNzzNA4iC+H2GLXkPxbuUS
 /seUoSjP9v+Z0jPAC9GKLqAqx1mfGQxanXiZPh8pi3gnXkhBMpnHYTx2KtVdh3rcOlTA
 juflBh/JL4mMYYdDOzIOpo3d7EdlAbepAG77+gt6tL1NaO1hTzoX9bs5RqnGEVoHHpin
 5c6F1D8ZX0MBSzwjugV/1enb7EDo8d+ku+2iPedH57JY+CF5OMCj0slVPMFfV7EvSkQO
 TRFtAWSwlYmgONxmwU+yyIvkZx/TqTT4cD/L7jZ53YX13nlpM1hCMbLExChK82ZNIp6z
 lmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716743766; x=1717348566;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lxBTDxzOkpKcHWc+oV7moh6IE1OfEOSm934E6mbjuyM=;
 b=lytJ9EmVW4IEvDxKPcWX0N3F9nuG9IgLwui1amyqk4VRhS09es3hEa9QwxIZ2StIsI
 T0hS3/ckpsqGZ49BVappi/kPuyMyReelupRiL02K3fCcpFoaEaTtAqyqzRLJA8fit1Ji
 t4zhGIyfmPCbjA5znuNYkf6FmpjMtliLsUoSrqJU4nkfZynYDtZUVWNpcMWZrBHfDTyb
 3SHftkThDryOr8Qj9wuPvR0mRQL8rc3fj69KQ0V0yNCLCWP4uWQ4dk+H6AxqVvd/bcy7
 bLjoDh5sWeGY8GXNc7/cbMfaZT5+66U+hp3WxMzGpSBayRekAbwI7xDskihlahymwFv9
 3OsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI1kXdxnEopBiostgeliHKZj+ZlkGtan6k5cXW7xsQoZ+AofiyWNTXh1foFpC/a1th2NrEZwCT95MMMFhIyh0gdx7DrLA=
X-Gm-Message-State: AOJu0YxnCi/K44DqKTFhyUt7OCkPFFMSp0Y5cKENgmwF5KpiOlenjt2S
 2zXF5rJFF0vL7L37lear4Ryy/8NeE/0evsKhURd6FCAgidKcp9lFP2xB4avNRfQ=
X-Google-Smtp-Source: AGHT+IEI5kkIa7ixlOGNYU63Xm5t0WhSGCnMpc4CdKriNPM1/y4ht4f6YWc6EanJ85MqtHRNIk8WUQ==
X-Received: by 2002:a05:6a20:2453:b0:1aa:965d:1332 with SMTP id
 adf61e73a8af0-1b212e135b8mr10134746637.26.1716743765752; 
 Sun, 26 May 2024 10:16:05 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd4da8f6sm3690973b3a.210.2024.05.26.10.16.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 May 2024 10:16:05 -0700 (PDT)
Message-ID: <c0b7bc36-35dd-4bab-a83e-7246c2c57473@ventanamicro.com>
Date: Sun, 26 May 2024 14:16:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] target/riscv: Support Zabha extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 bmeng.cn@gmail.com, liwei1518@gmail.com
References: <20240523124045.1964-1-zhiwei_liu@linux.alibaba.com>
 <8cc80b22-d159-4c8a-8860-30d229bae8d6@ventanamicro.com>
 <fed99165-58da-458c-b68f-a9717fc15034@linux.alibaba.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <fed99165-58da-458c-b68f-a9717fc15034@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42c.google.com
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



On 5/25/24 21:37, LIU Zhiwei wrote:
> 
> On 2024/5/24 19:44, Daniel Henrique Barboza wrote:
>> Hi Zhiwei!
>>
>>
>>
>> On 5/23/24 09:40, LIU Zhiwei wrote:
>>> Zabha adds support AMO operations for byte and half word. If zacas has been implemented,
>>> zabha also adds support amocas.b and amocas.h.
>>>
>>> More details is on the specification here:
>>> https://github.com/riscv/riscv-zabha
>>>
>>> The implemenation of zabha follows the way of AMOs and zacas.
>>>
>>> This patch set is based on these two patch set:
>>> 1. https://mail.gnu.org/archive/html/qemu-riscv/2024-05/msg00207.html
>>> 2. https://mail.gnu.org/archive/html/qemu-riscv/2024-05/msg00212.html
>>
>> These 2 series doesn't seem to apply on top of each other, doesn't matter which
>> order I try. Applying zimop/zcmop first, then zama16b:
>>
>> $ git am \[PATCH\ 1_1\]\ target_riscv\:\ Support\ Zama16b\ extension\ -\ LIU\ Zhiwei\ \<zhiwei_liu@linux.alibaba.com\>\ -\ 2024-05-22\ 0613.eml
>> Applying: target/riscv: Support Zama16b extension
>> error: patch failed: target/riscv/cpu.c:1464
>> error: target/riscv/cpu.c: patch does not apply
>> Patch failed at 0001 target/riscv: Support Zama16b extension
>> hint: Use 'git am --show-current-patch=diff' to see the failed patch
>>
>>
>> Applying zama16b first, then zimop/zcmop:
>>
>> $ git am \[PATCH\ 1_1\]\ target_riscv\:\ Support\ Zama16b\ extension\ -\ LIU\ Zhiwei\ \<zhiwei_liu@linux.alibaba.com\>\ -\ 2024-05-22\ 0613.eml
>> Applying: target/riscv: Support Zama16b extension
>> $
>> $ git am \[PATCH\ 1_4\]\ target_riscv\:\ Add\ zimop\ extension\ -\ LIU\ Zhiwei\ \<zhiwei_liu@linux.alibaba.com\>\ -\ 2024-05-22\ 0329.eml \[PATCH\ 2_4\]\ disas_riscv\:\ Support\ zimop\ disassemble\ -\ LIU\ Zhiwei\ \<zhiwei_liu@linux.alibaba.com\>\ -\ 2024-05-22\ 0329.eml
>> Applying: target/riscv: Add zimop extension
>> error: patch failed: target/riscv/cpu.c:1463
>> error: target/riscv/cpu.c: patch does not apply
>> Patch failed at 0001 target/riscv: Add zimop extension
>>
>>
>> If the series are dependent on each other perhaps it's easier to send everything
>> in a single 11 patches series.
> 
> They don't have dependency on each other. But if we both rebase them to the master branch, they
> couldn't be merged at the time, as them both modify cpu.h and cpu.c in the same place.
> 
> 
> I will send them as a whole patch set(RVA23 patch set) after I fix other issues on implementing the RVA23 profile.


Be aware that we have some RVA23 extensions that are implemented in the ML
but not merged no master yet. E.g. sstvala ended up being implemented after some
changes I did w.r.t tval and EBREAK. These patches are on riscv-to-apply.next.

Also, I took another look at RVA23 mandatory exts and what we have. I think we're
not that far off after these extensions you're adding. What we really seems to be
missing is supm and ssnpm.


Thanks,

Daniel

> 
> Thanks,
> 
> Zhiwei
> 
>>
>>
>> Thanks,
>>
>> Daniel
>>
>>>
>>>
>>> LIU Zhiwei (6):
>>>    target/riscv: Move gen_amo before implement Zabha
>>>    target/riscv: Add AMO instructions for Zabha
>>>    target/riscv: Move gen_cmpxchg before adding amocas.[b|h]
>>>    target/riscv: Add amocas.[b|h] for Zabha
>>>    target/riscv: Enable zabha for max cpu
>>>    disas/riscv: Support zabha disassemble
>>>
>>>   disas/riscv.c                               |  60 ++++++++
>>>   target/riscv/cpu.c                          |   2 +
>>>   target/riscv/cpu_cfg.h                      |   1 +
>>>   target/riscv/insn32.decode                  |  22 +++
>>>   target/riscv/insn_trans/trans_rva.c.inc     |  21 ---
>>>   target/riscv/insn_trans/trans_rvzabha.c.inc | 145 ++++++++++++++++++++
>>>   target/riscv/insn_trans/trans_rvzacas.c.inc |  13 --
>>>   target/riscv/translate.c                    |  36 +++++
>>>   8 files changed, 266 insertions(+), 34 deletions(-)
>>>   create mode 100644 target/riscv/insn_trans/trans_rvzabha.c.inc
>>>

