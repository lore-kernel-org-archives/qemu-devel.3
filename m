Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB4EEDEC12
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 07:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxgVs-0005lD-54; Wed, 04 Mar 2026 02:19:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vxgVq-0005jr-1q
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 02:19:18 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vxgVo-0002i7-7Y
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 02:19:17 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-439c5b40f60so547114f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 23:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772608753; x=1773213553; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GtF/ydXKXlpvjZfs4a6kDTX7iBmjo3+UHR2CzgdyNFA=;
 b=k837D3agJg4MENynjgymYBL5UATAcyLq6r+FjgUrCqMCUhKtNcRGrOvycrLUjX3YX4
 qGuatmdggAHwR39x65YLP+YlFxzlhyLGw1qk1/1PB8tDa9Ru7X59a4j+qU+0FkKWkIJX
 ORGzO8YrArKz54k+lxMjWjW03zvVZQRVw8JRPEq0A7XHuKSxKu657l769wXTCUttCDO9
 0I9BTUzNX+q9IyeRNnZtcVTeciJ1XHD56GL+/yi5WoFqgPu/57rUl265dpbPq8rhLRrT
 kSSZ6V5C1oeL3HwAT5T1aHNcRwKOHO8G686HXCCKUK5h9vO40/gzcH98uDBYTO2OllC6
 rwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772608753; x=1773213553;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GtF/ydXKXlpvjZfs4a6kDTX7iBmjo3+UHR2CzgdyNFA=;
 b=l5pqMO7pbiNuXBkO/xnhBmw8G0UP033C4PIudcnfxQtFDLESK+an+uQZBxNOONdAyO
 mDNoam/QXSY+JwcQw8IL6acDAVLOOF/uAskYN+eEW7j24MmbE7sjJWmEHM5TuZssSkXA
 oH5JgLGT0aWQGpl/sX7SYABlKxSRUc5A7a7lbTxxkkWlPSRne6dqIf55sAsuG8zhN7IU
 zAwIWd3sDi6iVvsyLIgN6lUbk7Yod9HT+jpbobhrVnRkslxsE7YqDfnqfvqyoVVTfoNP
 n4NmrnPNmiw8HadMwtafqhviU7RASVoUvxqndZuGA0+0LYtBWFrNcxt9fq7YJrId4eIW
 lQAA==
X-Gm-Message-State: AOJu0YyHzaX8Q28TQLHySPM71gN/F2qt7oWX7KsMOEoNFqAaoJlQOjs7
 QhZ7Rw0HNl0zH6ELicqogfDQBDuQSDK7mpwB/y/l2noihD4pdqziAVvf1eMIXbsqHVo=
X-Gm-Gg: ATEYQzzZ+5ZL7DcxXdTD8d/iOfZ4j5+WP0kwQFGdBqhBmkDK5DE8HCKczbRw8qiVkoi
 SLXsPRpeBtXODda33IZ75JUhpj9StcMJqGl4iGqgFE5gjWU5ND6K31HgO1usZP7PzoXLBVZXOjG
 87VP6dwltmb//N+vjX/Z9KaZbl1ZztnzKfHkKg/3UjdpKadmjE6NAOxlc/dEWRjySOlZpOGdLkT
 PFLveJj7AOrxjFOPdS3W4tTOGCRZfebrRSJDP7KNNmhO+3e/ncpOLp4/FFKXVxkU1HugU+9/aAF
 0VmnZtP+/9yIX6B2pXDdW9pUv9FKfodubplzDNqZ7fNf2BDjBhAks1bSD+nxaD3hlgug0WQU81E
 F/KYrs4KJfm67KmzCIeqGkr00uTN2YxstQjFadJ/Xs9NGS0biA3s0rtFfK/eR6wVHsRCF3ye6oo
 xrDkfQqbN0T9nuWHZq3XwITIad9I2RTe0oc9KdvcrVW1OwsRUZI16tgR9lJur/+NBIGQ==
X-Received: by 2002:a05:6000:400a:b0:439:b59e:5e64 with SMTP id
 ffacd0b85a97d-439c7f90a71mr1514844f8f.11.1772608753303; 
 Tue, 03 Mar 2026 23:19:13 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439abdf5430sm29784630f8f.5.2026.03.03.23.19.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 23:19:12 -0800 (PST)
Message-ID: <4927c794-a453-434b-aa84-cbcbc4671dc0@linaro.org>
Date: Wed, 4 Mar 2026 08:19:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] gdbstub: Remove @g_pos argument in
 gdb_register_coprocessor()
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Florian Hofhammer
 <florian.hofhammer@fhofhammer.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 qemu-ppc@nongnu.org
References: <20260227213958.21170-1-philmd@linaro.org>
 <20260227213958.21170-5-philmd@linaro.org>
 <80410890-1418-43b4-9265-184fb1910257@linaro.org>
In-Reply-To: <80410890-1418-43b4-9265-184fb1910257@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 4/3/26 07:33, Philippe Mathieu-Daudé wrote:
> On 27/2/26 22:39, Philippe Mathieu-Daudé wrote:
>> gdb_register_coprocessor()'s @g_pos argument is always '0',
>> meaning it is inferred from cpu->gdb_num_regs. Use instead
>> feature->base_reg, but check we don't overwrite other indexed
>> registers.
>>
>> This fixes a bug with the "power-fpu.xml" file [*] which was
>> loaded at index 70 while the base register is 71. This latent
>> bug was exposed by commit 1ec0fbe2dda ("target/ppc: Fix
>> CPUClass::gdb_num_core_regs value").
>>
>> [*] https://lore.kernel.org/qemu-devel/e44df309- 
>> d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de/
>>
>> Reported-by: Florian Hofhammer <florian.hofhammer@fhofhammer.de>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/exec/gdbstub.h     |  3 +--
>>   gdbstub/gdbstub.c          | 16 +++++-----------
>>   target/arm/gdbstub.c       | 21 ++++++++-------------
>>   target/arm/gdbstub64.c     | 19 +++++++------------
>>   target/hexagon/cpu.c       |  2 +-
>>   target/i386/gdbstub.c      |  8 +++-----
>>   target/loongarch/gdbstub.c |  6 +++---
>>   target/m68k/helper.c       |  4 ++--
>>   target/microblaze/cpu.c    |  3 +--
>>   target/ppc/gdbstub.c       | 11 +++++------
>>   target/riscv/gdbstub.c     | 18 ++++++------------
>>   target/s390x/gdbstub.c     | 15 +++++++--------
>>   target/sparc/gdbstub.c     | 12 ++++--------
>>   13 files changed, 53 insertions(+), 85 deletions(-)
>>
>> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
>> index 12e7b5b7282..75eb4d9c365 100644
>> --- a/include/exec/gdbstub.h
>> +++ b/include/exec/gdbstub.h
>> @@ -35,11 +35,10 @@ void gdb_init_cpu(CPUState *cpu);
>>    * @set_reg - set function (gdb modifying)
>>    * @num_regs - number of registers in set
>>    * @xml - xml name of set
>> - * @gpos - non-zero to append to "general" register set at @gpos
>>    */
>>   void gdb_register_coprocessor(CPUState *cpu,
>>                                 gdb_get_reg_cb get_reg, gdb_set_reg_cb 
>> set_reg,
>> -                              const GDBFeature *feature, int g_pos);
>> +                              const GDBFeature *feature);
>>   /**
>>    * gdb_unregister_coprocessor_all() - unregisters supplemental set 
>> of registers
>> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
>> index 6eadae3804e..882bc67e182 100644
>> --- a/gdbstub/gdbstub.c
>> +++ b/gdbstub/gdbstub.c
>> @@ -604,13 +604,14 @@ void gdb_init_cpu(CPUState *cpu)
>>   void gdb_register_coprocessor(CPUState *cpu,
>>                                 gdb_get_reg_cb get_reg, gdb_set_reg_cb 
>> set_reg,
>> -                              const GDBFeature *feature, int g_pos)
>> +                              const GDBFeature *feature)
>>   {
>>       GDBRegisterState *s;
>>       guint i;
>> -    int base_reg = cpu->gdb_num_regs;
>> +    int base_reg;
>> -    assert(!g_pos || g_pos == feature->base_reg);
>> +    assert(feature->base_reg >= cpu->gdb_num_regs);
> 
> This should be:
> 
>    +    assert(!feature->base_reg || feature->base_reg >= cpu- 
>  >gdb_num_regs);

But still not enough:

https://github.com/philmd/qemu/actions/runs/22658072426/job/65672033735

:(

