Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FBBC47DA9
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 16:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rU7pj-0000Tz-Rf; Sun, 28 Jan 2024 11:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rU7pg-0000T0-6U
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 11:16:32 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rU7pc-0000wu-7i
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 11:16:30 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33aeb088324so318311f8f.2
 for <qemu-devel@nongnu.org>; Sun, 28 Jan 2024 08:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706458583; x=1707063383; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nNQ1mZG/MGqiJb02NhZJ31w2Qw5Q82nN33CYLr2cWWo=;
 b=njBaFUI93VnNXzvsR6it6qggFRGKnH6UuwJKumCOaFTinmVetiQfwSUX8ki9fB/Hvz
 /xka1q6B4cahMXLzTC4S18RTWRLOi0bVmVGe4xpy9sc4CDIVbf234Sh767rEM682Lx74
 qhalorx0q1ol59ZHSLVO5K+C4+4mup5FysSZ0rbliuvBShpSHGgl9QNkESAPqqOmyh8X
 Klr0u+4TGFWn5R6axUT9LjHCEGBIarcFNa2d1BssFBkUKzACfoweyuhjd88NwKLwyPpV
 MTHffvsZlYD7m60elcebWlAAQky905Z8HUlWFGoyAOIIFhVg8Jt+AV6+TspuHfAyN3rO
 bUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706458583; x=1707063383;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nNQ1mZG/MGqiJb02NhZJ31w2Qw5Q82nN33CYLr2cWWo=;
 b=fyQ40BMJGkybyZMtYw1Afd+jdts3885RHWG3TcVawdoh/Lh6Q+OInjiMlkM77P8R/T
 ylzqNn5aNrdi5jsrYPSm0KyBIKjEi0FEbgB6UQgWK+EMhR85tq38Agf3CbYYR0IAiEE5
 0zfR9mN+mv6tjOvdVPukWoJVMAfSKoxHPc0qn164OlAnFSN3n350cZ2zN6J+qjMiv6BF
 NRlkUXhQz9o7cke9mAtjRawv4BLFH3/Mzi2tdeAuU1AIZvYiNExPDIYYEIlr3cxIwvFu
 qL6EcJO4XUFWWqbFdeqMO6pNL1AUI90g0s97DrhB9hNHsYnMuElmHztOhlExDO3/ghng
 DkBQ==
X-Gm-Message-State: AOJu0Ywkq/u+5fNZwj9woUMGqYcqBdASE5hzVdRuh8xaf3rgh72fmYA+
 Lw1EPrhtAwNMo0RM65OKzQIDyGrRR6lmIL7PMNzZVZjwJ/z6S6Wgtx7o68PF8hU=
X-Google-Smtp-Source: AGHT+IEZiXHH6VkkxIr4855VrA6mlwRi5ZK5DAlf4ThQoy+yRYfRVJ2hAzogGQOYO0OnwUHdVFeDqg==
X-Received: by 2002:a5d:604c:0:b0:33a:e5e5:163c with SMTP id
 j12-20020a5d604c000000b0033ae5e5163cmr1763182wrt.71.1706458583105; 
 Sun, 28 Jan 2024 08:16:23 -0800 (PST)
Received: from [192.168.69.100] (sev93-h02-176-184-17-196.dsl.sta.abo.bbox.fr.
 [176.184.17.196]) by smtp.gmail.com with ESMTPSA id
 ch19-20020a5d5d13000000b00337b47ae539sm5942414wrb.42.2024.01.28.08.16.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jan 2024 08:16:22 -0800 (PST)
Message-ID: <d7c11962-07c0-4c26-83e1-8b0a3d1e43d0@linaro.org>
Date: Sun, 28 Jan 2024 17:16:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/23] target/i386: Prefer fast cpu_env() over slower
 CPU QOM cast macro
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Thomas Huth
 <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, David Woodhouse
 <dwmw2@infradead.org>, xen-devel@lists.xenproject.org
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-11-philmd@linaro.org> <ZbT1R7impEw4whqP@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZbT1R7impEw4whqP@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 27/1/24 13:21, Zhao Liu wrote:
> Hi Philippe,
> 
> On Fri, Jan 26, 2024 at 11:03:52PM +0100, Philippe Mathieu-Daudé wrote:
>> Date: Fri, 26 Jan 2024 23:03:52 +0100
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: [PATCH v2 10/23] target/i386: Prefer fast cpu_env() over slower
>>   CPU QOM cast macro
>> X-Mailer: git-send-email 2.41.0
>>
>> Mechanical patch produced running the command documented
>> in scripts/coccinelle/cpu_env.cocci_template header.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/i386/hvf/vmx.h               | 13 +++-------
>>   hw/i386/vmmouse.c                   |  6 ++---
>>   hw/i386/xen/xen-hvm.c               |  3 +--
>>   target/i386/arch_memory_mapping.c   |  3 +--
>>   target/i386/cpu-dump.c              |  3 +--
>>   target/i386/cpu.c                   | 37 +++++++++------------------
>>   target/i386/helper.c                | 39 ++++++++---------------------
>>   target/i386/hvf/hvf.c               |  8 ++----
>>   target/i386/hvf/x86.c               |  4 +--
>>   target/i386/hvf/x86_emu.c           |  6 ++---
>>   target/i386/hvf/x86_task.c          | 10 +++-----
>>   target/i386/hvf/x86hvf.c            |  6 ++---
>>   target/i386/kvm/kvm.c               |  6 ++---
>>   target/i386/kvm/xen-emu.c           | 32 ++++++++---------------
>>   target/i386/tcg/sysemu/bpt_helper.c |  3 +--
>>   target/i386/tcg/tcg-cpu.c           | 14 +++--------
>>   target/i386/tcg/user/excp_helper.c  |  3 +--
>>   target/i386/tcg/user/seg_helper.c   |  3 +--
>>   18 files changed, 59 insertions(+), 140 deletions(-)
>>
> 
> [snip]
> 
>> diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
>> index 3b1ef5f49a..1e7fd587fe 100644
>> --- a/target/i386/hvf/x86hvf.c
>> +++ b/target/i386/hvf/x86hvf.c
>> @@ -238,8 +238,7 @@ void hvf_get_msrs(CPUState *cs)
>>   
>>   int hvf_put_registers(CPUState *cs)
>>   {
>> -    X86CPU *x86cpu = X86_CPU(cs);
>> -    CPUX86State *env = &x86cpu->env;
>> +    CPUX86State *env = cpu_env(cs);
>>   
>>       wreg(cs->accel->fd, HV_X86_RAX, env->regs[R_EAX]);
>>       wreg(cs->accel->fd, HV_X86_RBX, env->regs[R_EBX]);
>> @@ -282,8 +281,7 @@ int hvf_put_registers(CPUState *cs)
>>   
>>   int hvf_get_registers(CPUState *cs)
>>   {
>> -    X86CPU *x86cpu = X86_CPU(cs);
>> -    CPUX86State *env = &x86cpu->env;
>> +    CPUX86State *env = cpu_env(cs);
>>   
>>       env->regs[R_EAX] = rreg(cs->accel->fd, HV_X86_RAX);
>>       env->regs[R_EBX] = rreg(cs->accel->fd, HV_X86_RBX);
> 
> In this file, there's another corner case:
> 
> diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
> index 3b1ef5f49a8a..9a145aa5aa4f 100644
> --- a/target/i386/hvf/x86hvf.c
> +++ b/target/i386/hvf/x86hvf.c
> @@ -342,8 +342,7 @@ void vmx_clear_int_window_exiting(CPUState *cs)
> 
>   bool hvf_inject_interrupts(CPUState *cs)
>   {
> -    X86CPU *x86cpu = X86_CPU(cs);
> -    CPUX86State *env = &x86cpu->env;
> +    CPUX86State *env = cpu_env(cs);
> 
>       uint8_t vector;
>       uint64_t intr_type;
> @@ -408,7 +407,7 @@ bool hvf_inject_interrupts(CPUState *cs)
>       if (!(env->hflags & HF_INHIBIT_IRQ_MASK) &&
>           (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
>           (env->eflags & IF_MASK) && !(info & VMCS_INTR_VALID)) {
> -        int line = cpu_get_pic_interrupt(&x86cpu->env);
> +        int line = cpu_get_pic_interrupt(env);
>           cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
>           if (line >= 0) {
>               wvmcs(cs->accel->fd, VMCS_ENTRY_INTR_INFO, line |
> 
> 
> For this special case, I'm not sure if the script can cover it as well,
> otherwise maybe it's OK to be cleaned up manually ;-).

BTW I forgot to mention I had to skip target/i386/tcg/translate.c
(7100 LoC) because it is too complex for Coccinelle.

