Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3FDC48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 04:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rceU9-0001E6-GZ; Tue, 20 Feb 2024 23:45:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rceU7-0001BI-N0
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 23:45:31 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rceU1-0007z6-V1
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 23:45:31 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5d4d15ec7c5so5170386a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 20:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708490724; x=1709095524;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lfLJWsa65ASUYlZui0NxNUFsMoaCE+gG01MijQygC9g=;
 b=23e7xhP2Sjd4N+tdRorku4G7u+NxtxqrVPaOKg2CTnEViS82xII5GxgeSK5SEZIv3o
 mYhjlaH0u11mS5FYPx/P3n1iKGDdR5YcTXcryfvDa4UnfAgt265EbC2BYTJ0PM7Uslu2
 70v996rzRi9aPwaOSXL7Kt5WPhhtxFILG93dmTnzdlrFqnHPRZ/5XWjduX85XRt/+Euh
 EBcBW3jRYZd5n2o4rytpkVzs/7oHqItkZ+6l5rwpcsPZdLSedicBQvIPrruF2IoSEcjC
 poGToP3t41+7ylbUsVm8KmtYY+Sg/5LkjzwgdIbpKLZLZEul3GnIf51Goh40Xp1tC3vK
 of/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708490724; x=1709095524;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lfLJWsa65ASUYlZui0NxNUFsMoaCE+gG01MijQygC9g=;
 b=LG2U6DAs3TdMwNfrBkKOfIJrrfZ7HJwjdUvsIiYL/wSMbVYofsJGB8Mmhp1y/cIfI4
 waJ+Me4TtY+WNA9Ix+LBSHDZlrx/Mr2cIo1qvd0fF2tCrXQtnQk4796VTmMjoQ2QWLkJ
 vPEu58gT1aem9gI11FEGzfG/EMMaRAJSB0rvaQSS3VjLAcjc0N/3MzFajZKB2FkHmXow
 i5kHNTzJrXBX7P9gu6xJVVvG0MRjT3wsFkXMdrTs95nAaa56sKDBADxLBz1CHLRZdeud
 T7KDlcC0UJNkiPKL5p4mhjH9iW71GQQJ0jMo2Si9l/QUOH3z3IIyx15PcKKw+bPz6TaH
 2RxQ==
X-Gm-Message-State: AOJu0Yw18ccV77bCJ8/40Jenj6p/A546K4bYAXWfTFjt9tr8u9oJltXO
 RmwjlMf8r94r0h3b7+w+sdHN7FAcimNNmznE7daMliOASAAay5M/qMxLxrRhQz0=
X-Google-Smtp-Source: AGHT+IFxkvhTpn7WYr15xsK9Opo2pt7EBMmd0rceTM0c9yO5qCdM3SZM2ZOJ7mKoEimRnvCYGUfNOw==
X-Received: by 2002:a17:90a:bf82:b0:299:ecba:cc6a with SMTP id
 d2-20020a17090abf8200b00299ecbacc6amr2709783pjs.40.1708490724411; 
 Tue, 20 Feb 2024 20:45:24 -0800 (PST)
Received: from [157.82.203.206] ([157.82.203.206])
 by smtp.gmail.com with ESMTPSA id
 b23-20020a17090a489700b00298ca46547fsm8201030pjh.36.2024.02.20.20.45.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 20:45:24 -0800 (PST)
Message-ID: <bf31a250-9539-448c-9c64-4168ab8741f1@daynix.com>
Date: Wed, 21 Feb 2024 13:45:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/23] plugins: add an API to read registers
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Song Gao <gaosong@loongson.cn>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, John Snow
 <jsnow@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Yanan Wang <wangyanan55@huawei.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Brian Cain
 <bcain@quicinc.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240216163025.424857-1-alex.bennee@linaro.org>
 <20240216163025.424857-19-alex.bennee@linaro.org>
 <c38a22b5-01e8-40f1-bfc4-4bba9bf7b516@daynix.com>
 <87il2jcje8.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87il2jcje8.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::529;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
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

On 2024/02/20 23:14, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2024/02/17 1:30, Alex Bennée wrote:
>>> We can only request a list of registers once the vCPU has been
>>> initialised so the user needs to use either call the get function on
>>> vCPU initialisation or during the translation phase.
>>> We don't expose the reg number to the plugin instead hiding it
>>> behind
>>> an opaque handle. This allows for a bit of future proofing should the
>>> internals need to be changed while also being hashed against the
>>> CPUClass so we can handle different register sets per-vCPU in
>>> hetrogenous situations.
>>> Having an internal state within the plugins also allows us to expand
>>> the interface in future (for example providing callbacks on register
>>> change if the translator can track changes).
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1706
>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> Message-Id: <20240103173349.398526-39-alex.bennee@linaro.org>
>>> Based-on: <20231025093128.33116-18-akihiko.odaki@daynix.com>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> <snip>
>>> +/*
>>> + * Register handles
>>> + *
>>> + * The plugin infrastructure keeps hold of these internal data
>>> + * structures which are presented to plugins as opaque handles. They
>>> + * are global to the system and therefor additions to the hash table
>>> + * must be protected by the @reg_handle_lock.
>>> + *
>>> + * In order to future proof for up-coming heterogeneous work we want
>>> + * different entries for each CPU type while sharing them in the
>>> + * common case of multiple cores of the same type.
>>> + */
>>> +
>>> +static QemuMutex reg_handle_lock;
>>> +
>>> +struct qemu_plugin_register {
>>> +    const char *name;
>>> +    int gdb_reg_num;
>>> +};
>>> +
>>> +static GHashTable *reg_handles; /* hash table of PluginReg */
>>> +
>>> +/* Generate a stable key - would xxhash be overkill? */
>>> +static gpointer cpu_plus_reg_to_key(CPUState *cs, int gdb_regnum)
>>> +{
>>> +    uintptr_t key = (uintptr_t) cs->cc;
>>> +    key ^= gdb_regnum;
>>> +    return GUINT_TO_POINTER(key);
>>> +}
>>
>> I have pointed out this is theoretically prone to collisions and
>> unsafe.
> 
> How is it unsafe? The aim is to share handles for the same CPUClass
> rather than having a unique handle per register/cpu combo.

THe intention is legitimate, but the implementation is not safe. It 
assumes (uintptr)cs->cc ^ gdb_regnum is unique, but there is no such 
guarantee. The key of GHashTable must be unique; generating hashes of 
keys should be done with hash_func given to g_hash_table_new().

> 
> Indeed if I add the following:
> 
> --8<---------------cut here---------------start------------->8---
>     plugins/api.c
> @@ -482,6 +482,9 @@ static GArray *create_register_handles(CPUState *cs, GArray *gdbstub_regs)
>                   val->name = g_intern_string(grd->name);
>   
>                   g_hash_table_insert(reg_handles, key, val);
> +            } else {
> +                /* make sure its not a clash */
> +                g_assert(val->gdb_reg_num == grd->gdb_reg);
>               }
>   
>               /* Create a record for the plugin */
> modified   tests/plugin/insn.c
> @@ -46,6 +46,25 @@ typedef struct {
>       char *disas;
>   } Instruction;
>   
> +/*
> + * Initialise a new vcpu with reading the register list
> + */
> +static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
> +{
> +    g_autoptr(GArray) reg_list = qemu_plugin_get_registers();
> +    g_autoptr(GByteArray) reg_value = g_byte_array_new();
> +
> +    if (reg_list) {
> +        for (int i = 0; i < reg_list->len; i++) {
> +            qemu_plugin_reg_descriptor *rd = &g_array_index(
> +                reg_list, qemu_plugin_reg_descriptor, i);
> +            int count = qemu_plugin_read_register(rd->handle, reg_value);
> +            g_assert(count > 0);
> +        }
> +    }
> +}
> +
> +
>   static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
>   {
>       unsigned int i = cpu_index % MAX_CPUS;
> @@ -212,6 +231,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>           sizes = g_array_new(true, true, sizeof(unsigned long));
>       }
>   
> +    /* Register init, translation block and exit callbacks */
> +    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>       qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>       qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>       return 0;
> --8<---------------cut here---------------end--------------->8---
> 
> Nothing trips up during check-tcg (after I fixed "gdbstub: Infer number
> of core registers from XML" to remove the microblaze check on
> cc->gdb_num_core_regs).
> 
>>
>>> +
>>> +/*
>>> + * Create register handles.
>>> + *
>>> + * We need to create a handle for each register so the plugin
>>> + * infrastructure can call gdbstub to read a register. We also
>>> + * construct a result array with those handles and some ancillary data
>>> + * the plugin might find useful.
>>> + */
>>> +
>>> +static GArray *create_register_handles(CPUState *cs, GArray *gdbstub_regs)
>>> +{
>>> +    GArray *find_data = g_array_new(true, true,
>>> +                                    sizeof(qemu_plugin_reg_descriptor));
>>> +
>>> +    WITH_QEMU_LOCK_GUARD(&reg_handle_lock) {
>>> +
>>> +        if (!reg_handles) {
>>> +            reg_handles = g_hash_table_new(g_direct_hash, g_direct_equal);
>>> +        }
>>> +
>>> +        for (int i = 0; i < gdbstub_regs->len; i++) {
>>> +            GDBRegDesc *grd = &g_array_index(gdbstub_regs, GDBRegDesc, i);
>>> +            gpointer key = cpu_plus_reg_to_key(cs, grd->gdb_reg);
>>> +            struct qemu_plugin_register *val = g_hash_table_lookup(reg_handles,
>>> +                                                                   key);
>>> +
>>> +            /* skip "un-named" regs */
>>> +            if (!grd->name) {
>>> +                continue;
>>> +            }
>>> +
>>> +            /* Doesn't exist, create one */
>>> +            if (!val) {
>>> +                val = g_new0(struct qemu_plugin_register, 1);
>>> +                val->gdb_reg_num = grd->gdb_reg;
>>> +                val->name = g_intern_string(grd->name);
>>> +
>>> +                g_hash_table_insert(reg_handles, key, val);
>>> +            }
>>> +
>>> +            /* Create a record for the plugin */
>>> +            qemu_plugin_reg_descriptor desc = {
>>> +                .handle = val,
>>> +                .name = val->name,
>>> +                .feature = g_intern_string(grd->feature_name)
>>> +            };
>>> +            g_array_append_val(find_data, desc);
>>> +        }
>>> +    }
>>> +
>>> +    return find_data;
>>> +}
>>> +
>>> +GArray *qemu_plugin_get_registers(void)
>>> +{
>>> +    g_assert(current_cpu);
>>> +
>>> +    g_autoptr(GArray) regs = gdb_get_register_list(current_cpu);
>>> +    return regs->len ? create_register_handles(current_cpu, regs) : NULL;
>>> +}
>>> +
>>> +int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
>>> +{
>>> +    g_assert(current_cpu);
>>> +
>>> +    return gdb_read_register(current_cpu, buf, reg->gdb_reg_num);
>>> +}
>>> +
>>> +static void __attribute__((__constructor__)) qemu_api_init(void)
>>> +{
>>> +    qemu_mutex_init(&reg_handle_lock);
>>> +
>>> +}
>>> diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
>>> index adb67608598..27fe97239be 100644
>>> --- a/plugins/qemu-plugins.symbols
>>> +++ b/plugins/qemu-plugins.symbols
>>> @@ -3,6 +3,7 @@
>>>      qemu_plugin_end_code;
>>>      qemu_plugin_entry_code;
>>>      qemu_plugin_get_hwaddr;
>>> +  qemu_plugin_get_registers;
>>>      qemu_plugin_hwaddr_device_name;
>>>      qemu_plugin_hwaddr_is_io;
>>>      qemu_plugin_hwaddr_phys_addr;
>>> @@ -19,6 +20,7 @@
>>>      qemu_plugin_num_vcpus;
>>>      qemu_plugin_outs;
>>>      qemu_plugin_path_to_binary;
>>> +  qemu_plugin_read_register;
>>>      qemu_plugin_register_atexit_cb;
>>>      qemu_plugin_register_flush_cb;
>>>      qemu_plugin_register_vcpu_exit_cb;
> 

