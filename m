Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AF0C87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 16:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukPwm-0004FB-3S; Fri, 08 Aug 2025 12:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukPwe-00048y-FQ
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:27:56 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukPwc-0003Wu-EU
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:27:52 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-76bd2b11f80so2315513b3a.3
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 09:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754670469; x=1755275269; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cZgouQ8bunA5EGb9zT1spd4MOP9pMaN7HGEbPgoH5cY=;
 b=IhzxwGjkR0q1E9P7PZicidW66J0+g5vqS6/GBJ5DDhfJleWZCfBJ2VZhPHhjT5CQf1
 niR4o5pBXrEz8gLHefy/PfqDuaYndQb+V7NH7SmqEQUdFo2Fcp6NBaARxVhu5Uk5YAss
 ZE8DSy5aTGbbru3Gl361hL63LRyQYADa3Ps7hpW5HW8kNy3HFphrSy8FKKWk95aXQLC9
 YfHQZmKyxxhBtQVmRa+fYPaBoJG0zc5GFl2dfNZ4/Ja7+RBGnWNTi9O4i/JN24mTMpQG
 p/uIfpWPzeHcVszSZgosVY3TS6qAshwuz5UuHOhBNag9cYNtToOuEuJ0WZYg83lFMyVv
 TKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754670469; x=1755275269;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cZgouQ8bunA5EGb9zT1spd4MOP9pMaN7HGEbPgoH5cY=;
 b=qSVdsf+ho9WMhmxxEZZf5dXjnD/codT+2yNs8pL+v+JS6bBPfH14SPg5IkXtZQ1MrQ
 C3tKCFp64HmjTxvL5twUNMCJkj6v+U03Wzrj3utMHZRA8jLygFXejiGgdXKd+lGa2P2W
 GrZcbYNloefoHyXencq/QC8D6MIUzpwt0qQ2GHevN4/KFPk8hgGbt3ofyFzFuXEjKyI5
 fnxUNaTmnME1iTYEa7ovD5jAqFHtFOr0Za/6FK6Ck4OulQdBViwoCWWp4gfCZTlcFhWN
 FIoql84pIRUlxzBRKubKQwiVG0wyS1VYuDdSLePljSw07lZDmD9ph1ioLWQhRJqxMdwF
 cquQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT1e3LOeHc5CSLLfrwpwR0LEeKmn6y0pUYbFBCYESDwR6BYkDIGXtz7pvcUQXi7a44Y3aqzEooA/Ll@nongnu.org
X-Gm-Message-State: AOJu0YzxlhcbFobcGRvW1H51KjxCojsdLzrkCz+LX9kHXwla6M+O0dJC
 vGPPMe/DmRNrlatBjOhNH/+ug6Dhx3tjmt2kDVi2Jn+sueau7o850NOgsPsovKnNLz8=
X-Gm-Gg: ASbGncul9ttqvByvINfcuQLjf3kjh1SaSdmJuvMhxb+HfWOl6YqqtlNGVNQk3DtFN5I
 A6lqvjCWfszAUDL9Tv52mQ/VDvm8GPKUysBpaes347l59OiMCQ23OZTBw9UC4bhWEx77yHZJYwO
 t98QDENgms2kTxB3L4+EM5PAFkvC0baTWho9U8/jVDpsWDwwD9+JcM+f+z2dzbZIClIfmj6ls8N
 cVqDeiuJWiyo4tpF46sr/HhiIWcIpwhL1hDqwBpu534EuBXpOJ261jxkpBNHeO8fBsMuedaBhpe
 dexvLlf29zCnkC0GOa4s7qqAk/Gmt8TaxeYJv8Nk7JZF/rLZ4uuIzzPzw2qB+nSCCyPSPqGW/QB
 FRkrTZxv63iFbyBSPHinBMZYnGMVnbi1ztwf0jUO8PID14g==
X-Google-Smtp-Source: AGHT+IEOmd5HyuARH8AqkdcGCquWQbIelT8haqZY2J3I+fK7pschYQYCPTCDGHH9k45tbb6A44EqjA==
X-Received: by 2002:a17:902:ce08:b0:240:5c0e:758b with SMTP id
 d9443c01a7336-242c2279bd6mr51934895ad.50.1754670468051; 
 Fri, 08 Aug 2025 09:27:48 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e585sm213032695ad.40.2025.08.08.09.27.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 09:27:47 -0700 (PDT)
Message-ID: <55a99df1-616f-4ac5-8bd1-fd2b47755df4@linaro.org>
Date: Fri, 8 Aug 2025 09:27:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/9] contrib/plugins/uftrace: define cpu operations and
 implement aarch64
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>, Gustavo Romero
 <gustavo.romero@linaro.org>, =?UTF-8?Q?Alex_Benn_=C3=A9_e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
 <20250808020702.410109-3-pierrick.bouvier@linaro.org>
 <t0o32w.19lmgtfzlutzr@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <t0o32w.19lmgtfzlutzr@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 8/8/25 1:28 AM, Manos Pitsidianakis wrote:
> On Fri, 08 Aug 2025 05:06, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>> We define a new CpuOps structure that will be used to implement tracking
>> independently of guest architecture.
>>
>> As well, we now instrument only instructions following ones that might
>> have touch the frame pointer.
> 
> s/touch/touched
> 
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>> contrib/plugins/uftrace.c | 112 ++++++++++++++++++++++++++++++++++++--
>> 1 file changed, 108 insertions(+), 4 deletions(-)
>>
>> diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
>> index d60c1077496..4b1a2f38143 100644
>> --- a/contrib/plugins/uftrace.c
>> +++ b/contrib/plugins/uftrace.c
>> @@ -11,14 +11,94 @@
>>
>> #include <qemu-plugin.h>
>> #include <glib.h>
>> +#include <stdio.h>
>>
>> QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
>>
>> +typedef struct Cpu Cpu;
>> +
>> +typedef struct {
>> +    void (*init)(Cpu *cpu);
>> +    void (*end)(Cpu *cpu);
>> +    uint64_t (*get_frame_pointer)(Cpu *cpu);
>> +    bool (*does_insn_modify_frame_pointer)(const char *disas);
>> +} CpuOps;
>> +
>> typedef struct Cpu {
>>      GByteArray *buf;
>> +    CpuOps ops;
>> +    void *arch;
>> } Cpu;
>>
>> +typedef struct {
>> +    struct qemu_plugin_register *reg_fp;
>> +} Aarch64Cpu;
>> +
>> static struct qemu_plugin_scoreboard *score;
>> +static CpuOps arch_ops;
>> +
>> +static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_register *reg)
>> +{
>> +    GByteArray *buf = cpu->buf;
>> +    g_byte_array_set_size(buf, 0);
>> +    size_t sz = qemu_plugin_read_register(reg, buf);
>> +    g_assert(sz == 8);
>> +    g_assert(buf->len == 8);
>> +    return *((uint64_t *) buf->data);
>> +}
>> +
>> +static struct qemu_plugin_register *plugin_find_register(const char *name)
>> +{
>> +    g_autoptr(GArray) regs = qemu_plugin_get_registers();
> 
> Question about the plugin API and not this patch per se, if the cpu is
> in a32/thumb mode does it still return the aarch64 registers?
>

I didn't check this part, and it's a good question though.
It would be a massive headache from plugins point of view if registers 
list could vary along execution.

>> +    for (int i = 0; i < regs->len; ++i) {
>> +        qemu_plugin_reg_descriptor *reg;
>> +        reg = &g_array_index(regs, qemu_plugin_reg_descriptor, i);
>> +        if (!strcmp(reg->name, name)) {
>> +            return reg->handle;
>> +        }
>> +    }
>> +    return NULL;
>> +}
>> +
>> +static uint64_t aarch64_get_frame_pointer(Cpu *cpu_)
>> +{
>> +    Aarch64Cpu *cpu = cpu_->arch;
>> +    return cpu_read_register64(cpu_, cpu->reg_fp);
>> +}
>> +
>> +static void aarch64_init(Cpu *cpu_)
>> +{
>> +    Aarch64Cpu *cpu = g_new0(Aarch64Cpu, 1);
>> +    cpu_->arch = cpu;
>> +    cpu->reg_fp = plugin_find_register("x29");
>> +    if (!cpu->reg_fp) {
>> +        fprintf(stderr, "uftrace plugin: frame pointer register (x29) is not "
>> +                        "available. Please use an AArch64 cpu (or -cpu max).\n");
>> +        g_abort();
>> +    }
>> +}
>> +
>> +static void aarch64_end(Cpu *cpu)
>> +{
>> +    g_free(cpu->arch);
>> +}
>> +
>> +static bool aarch64_does_insn_modify_frame_pointer(const char *disas)
>> +{
>> +    /*
>> +     * Check if current instruction concerns fp register "x29".
>> +     * We add a prefix space to make sure we don't match addresses dump
>> +     * in disassembly.
>> +     */
>> +    return strstr(disas, " x29");
> 
> Hm is the whitespace before x29 guaranteed? Neat trick otherwise.
>

At least for aarch64 disassembler, yes, from what I saw.
Either it's the first operand, and then there is a whitespace between 
instruction name and it. Or it's another operand, and we always have a 
whitespace after ','.
I don't think we'll change disassembler soon, but in case this looks too 
fragile, we can always simply return yes if x29 is fine. In worst case, 
we match some additional instructions, but it should not have a huge 
performance hit.

>> +}
>> +
>> +static CpuOps aarch64_ops = {
>> +    .init = aarch64_init,
>> +    .end = aarch64_end,
>> +    .get_frame_pointer = aarch64_get_frame_pointer,
>> +    .does_insn_modify_frame_pointer = aarch64_does_insn_modify_frame_pointer,
>> +};
>>
>> static void track_callstack(unsigned int cpu_index, void *udata)
>> {
>> @@ -28,20 +108,36 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>> {
>>      size_t n_insns = qemu_plugin_tb_n_insns(tb);
>>
>> +    /*
>> +     * We instrument all instructions following one that might have updated
>> +     * the frame pointer. We always instrument first instruction in block, as
>> +     * last executed instruction, in previous tb, may have modified it.
> 
> Modified it how?
>

I ran an assert that latest instruction of a block never contained " 
x29", and it was triggered quickly. I don't remember exactly which 
instruction triggered the assert.

>> +     */
>> +    bool instrument_insn = true;
>>      for (int i = 0; i < n_insns; i++) {
>>          struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
>>
>> -        uintptr_t pc = qemu_plugin_insn_vaddr(insn);
>> -        qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callstack,
>> -                QEMU_PLUGIN_CB_R_REGS,
>> -                (void *) pc);
>> +        if (instrument_insn) {
>> +            uintptr_t pc = qemu_plugin_insn_vaddr(insn);
>> +            qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callstack,
>> +                                                   QEMU_PLUGIN_CB_R_REGS,
>> +                                                   (void *) pc);
>> +            instrument_insn = false;
>> +        }
>>
>> +        char *disas = qemu_plugin_insn_disas(insn);
>> +        if (arch_ops.does_insn_modify_frame_pointer(disas)) {
>> +            instrument_insn = true;
>> +        }
> 
> So if I understand correctly you check if an instruction needs to be
> instrumented and then do it in the next forloop. This means if the last
> insn needs to be instrumented too it is not done, is that ok?
>

Yes, that is why we always instrument the first, to catch this.
There is no (current) way to instrument *after* instruction, and 
probably hard to implement, considering an instruction might generate a 
fault. So the only safe choice left is to instrument the first one of 
any tb.

>>      }
>> }
>>
>> static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
>> {
>>      Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
>> +    cpu->ops = arch_ops;
>> +
>> +    cpu->ops.init(cpu);
>>      cpu->buf = g_byte_array_new();
>> }
>>
>> @@ -65,6 +161,14 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>>                                             const qemu_info_t *info,
>>                                             int argc, char **argv)
>> {
>> +    if (!strcmp(info->target_name, "aarch64")) {
>> +        arch_ops = aarch64_ops;
>> +    } else {
>> +        fprintf(stderr, "plugin uftrace: %s target is not supported\n",
>> +                info->target_name);
>> +        return 1;
>> +    }
>> +
>>      score = qemu_plugin_scoreboard_new(sizeof(Cpu));
>>      qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>>      qemu_plugin_register_atexit_cb(id, at_exit, NULL);
>> -- 
>> 2.47.2
>>
> 
> LGTM overall, it makes sense.


