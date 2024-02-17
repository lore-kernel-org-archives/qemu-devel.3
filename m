Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582C4C48BC3
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 08:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbFdo-0008KQ-KO; Sat, 17 Feb 2024 03:01:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbFdf-0008JD-BS
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 03:01:36 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbFda-0003Iz-Ar
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 03:01:34 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d70b0e521eso23252585ad.1
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 00:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708156887; x=1708761687;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/oUa/m3j6N+SGoUDbXChizcm11JI1QB5HKNL+fidvys=;
 b=UtQbOwPEf4XBnxq3RAn25064IV9/georDQtEetwiop3DbzBN/nl8lvFmuJqi9NOATb
 RalTdJri08T5Y9ddme5lOFLFqXi6VzCxNUITKtXn734jPT2QXTuVXCjYIMEN+zhYlPy8
 MnV0Hh1gaCYKyQ89P71Jelk5lDtIXoOskqro7vbO6X6C1q4XmkhT9wgpA0Bqv2J1JA+D
 deYX48UhmqB58SxvdRsS8DUOdXAnnhW7QHbLfYcD9Bg4cpQMPlPo78ug/3QtvAHx8/gl
 2l4yWZH3tolikVRc59gmjT8Hp1cIUEqxGjcBxPtgMM1uDX1c9H6YxU2WDYAfiuKTBJwY
 6qYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708156887; x=1708761687;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/oUa/m3j6N+SGoUDbXChizcm11JI1QB5HKNL+fidvys=;
 b=ej+tlAuAM2NsZvukUTfBVdx6r0NNNBneegRZBpZxpPN+QXHK9PXakL0zr1e+cwd85F
 FmPZWgnIlgCj7n+L1nAjU9HxLXUkOz6pk2cmLtbIiXTPHs543ZYa+54syTwIN8s7f7OQ
 AU479ZxZV35dE0CDIxDph6qFoUyB6k5+Obyz2bsSv5F7QuOHkv0HxT/ukT9Twdhf9KL0
 xxDYO2K9NMQxdM7ahlhGagx4tLBDVl1NALSpXT4Vx4KoQ/TCUX4prEcrA4AcKJVDkWsB
 ncSF4pMo7hUWRaajO5kafO6lHxOTKS2xTc6AxTyWFP81NNwbHw+ZIle+6XGWP5BFwCTc
 5Yjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM5TRZN4DuOyCYgcBqeLNvjpMsjlo7LNLk/gfpE6HTfmOMRhLZC6VIfqBuLlvNrQCSRqnti4wHZdsplmx/6OlfLktxrC0=
X-Gm-Message-State: AOJu0YwoDCFweLRAPvq3tUuy/Tw70ZkWQGZ4xdHEjzr9Pw82WJW4+kx4
 SzFfV8sNqBtVZyMW+tA2OAsicRXeWtJ9Zq5iZpmcyewzwuoNuU0/FGDF3ZaZJcU=
X-Google-Smtp-Source: AGHT+IFtKdrqAg/YHzurC8U9rB59bhu0467F2B4etNMpR1lrYn8ivjuQfP/Oz0WeOewEOxr5YwOR5A==
X-Received: by 2002:a17:903:1c9:b0:1db:d42f:fdb9 with SMTP id
 e9-20020a17090301c900b001dbd42ffdb9mr40139plh.40.1708156887288; 
 Sat, 17 Feb 2024 00:01:27 -0800 (PST)
Received: from [157.82.200.138] ([157.82.200.138])
 by smtp.gmail.com with ESMTPSA id
 km14-20020a17090327ce00b001db535f1549sm936241plb.235.2024.02.17.00.01.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 00:01:26 -0800 (PST)
Message-ID: <c38a22b5-01e8-40f1-bfc4-4bba9bf7b516@daynix.com>
Date: Sat, 17 Feb 2024 17:01:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/23] plugins: add an API to read registers
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240216163025.424857-19-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
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

On 2024/02/17 1:30, Alex Bennée wrote:
> We can only request a list of registers once the vCPU has been
> initialised so the user needs to use either call the get function on
> vCPU initialisation or during the translation phase.
> 
> We don't expose the reg number to the plugin instead hiding it behind
> an opaque handle. This allows for a bit of future proofing should the
> internals need to be changed while also being hashed against the
> CPUClass so we can handle different register sets per-vCPU in
> hetrogenous situations.
> 
> Having an internal state within the plugins also allows us to expand
> the interface in future (for example providing callbacks on register
> change if the translator can track changes).
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1706
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Message-Id: <20240103173349.398526-39-alex.bennee@linaro.org>
> Based-on: <20231025093128.33116-18-akihiko.odaki@daynix.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> ---
> v4
>    - the get/read_registers functions are now implicitly for current
>    vCPU only to accidental cpu != current_cpu uses.
> ---
>   include/qemu/qemu-plugin.h   |  48 +++++++++++++++-
>   plugins/api.c                | 107 +++++++++++++++++++++++++++++++++++
>   plugins/qemu-plugins.symbols |   2 +
>   3 files changed, 155 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 93981f8f89f..3b6b18058d2 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -11,6 +11,7 @@
>   #ifndef QEMU_QEMU_PLUGIN_H
>   #define QEMU_QEMU_PLUGIN_H
>   
> +#include <glib.h>
>   #include <inttypes.h>
>   #include <stdbool.h>
>   #include <stddef.h>
> @@ -229,8 +230,8 @@ struct qemu_plugin_insn;
>    * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
>    * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
>    *
> - * Note: currently unused, plugins cannot read or change system
> - * register state.
> + * Note: currently QEMU_PLUGIN_CB_RW_REGS is unused, plugins cannot change
> + * system register state.
>    */
>   enum qemu_plugin_cb_flags {
>       QEMU_PLUGIN_CB_NO_REGS,
> @@ -707,4 +708,47 @@ uint64_t qemu_plugin_end_code(void);
>   QEMU_PLUGIN_API
>   uint64_t qemu_plugin_entry_code(void);
>   
> +/** struct qemu_plugin_register - Opaque handle for register access */
> +struct qemu_plugin_register;
> +
> +/**
> + * typedef qemu_plugin_reg_descriptor - register descriptions
> + *
> + * @handle: opaque handle for retrieving value with qemu_plugin_read_register
> + * @name: register name
> + * @feature: optional feature descriptor, can be NULL
> + */
> +typedef struct {
> +    struct qemu_plugin_register *handle;
> +    const char *name;
> +    const char *feature;
> +} qemu_plugin_reg_descriptor;
> +
> +/**
> + * qemu_plugin_get_registers() - return register list for current vCPU
> + *
> + * Returns a GArray of qemu_plugin_reg_descriptor or NULL. Caller
> + * frees the array (but not the const strings).
> + *
> + * Should be used from a qemu_plugin_register_vcpu_init_cb() callback
> + * after the vCPU is initialised, i.e. in the vCPU context.
> + */
> +GArray *qemu_plugin_get_registers(void);
> +
> +/**
> + * qemu_plugin_read_register() - read register for current vCPU
> + *
> + * @handle: a @qemu_plugin_reg_handle handle
> + * @buf: A GByteArray for the data owned by the plugin
> + *
> + * This function is only available in a context that register read access is
> + * explicitly requested via the QEMU_PLUGIN_CB_R_REGS flag.
> + *
> + * Returns the size of the read register. The content of @buf is in target byte
> + * order. On failure returns -1
> + */
> +int qemu_plugin_read_register(struct qemu_plugin_register *handle,
> +                              GByteArray *buf);
> +
> +
>   #endif /* QEMU_QEMU_PLUGIN_H */
> diff --git a/plugins/api.c b/plugins/api.c
> index 54df72c1c00..483f04e85e4 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -8,6 +8,7 @@
>    *
>    *  qemu_plugin_tb
>    *  qemu_plugin_insn
> + *  qemu_plugin_register
>    *
>    * Which can then be passed back into the API to do additional things.
>    * As such all the public functions in here are exported in
> @@ -35,10 +36,12 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
>   #include "qemu/plugin.h"
>   #include "qemu/log.h"
>   #include "tcg/tcg.h"
>   #include "exec/exec-all.h"
> +#include "exec/gdbstub.h"
>   #include "exec/ram_addr.h"
>   #include "disas/disas.h"
>   #include "plugin.h"
> @@ -410,3 +413,107 @@ uint64_t qemu_plugin_entry_code(void)
>   #endif
>       return entry;
>   }
> +
> +/*
> + * Register handles
> + *
> + * The plugin infrastructure keeps hold of these internal data
> + * structures which are presented to plugins as opaque handles. They
> + * are global to the system and therefor additions to the hash table
> + * must be protected by the @reg_handle_lock.
> + *
> + * In order to future proof for up-coming heterogeneous work we want
> + * different entries for each CPU type while sharing them in the
> + * common case of multiple cores of the same type.
> + */
> +
> +static QemuMutex reg_handle_lock;
> +
> +struct qemu_plugin_register {
> +    const char *name;
> +    int gdb_reg_num;
> +};
> +
> +static GHashTable *reg_handles; /* hash table of PluginReg */
> +
> +/* Generate a stable key - would xxhash be overkill? */
> +static gpointer cpu_plus_reg_to_key(CPUState *cs, int gdb_regnum)
> +{
> +    uintptr_t key = (uintptr_t) cs->cc;
> +    key ^= gdb_regnum;
> +    return GUINT_TO_POINTER(key);
> +}

I have pointed out this is theoretically prone to collisions and unsafe.

> +
> +/*
> + * Create register handles.
> + *
> + * We need to create a handle for each register so the plugin
> + * infrastructure can call gdbstub to read a register. We also
> + * construct a result array with those handles and some ancillary data
> + * the plugin might find useful.
> + */
> +
> +static GArray *create_register_handles(CPUState *cs, GArray *gdbstub_regs)
> +{
> +    GArray *find_data = g_array_new(true, true,
> +                                    sizeof(qemu_plugin_reg_descriptor));
> +
> +    WITH_QEMU_LOCK_GUARD(&reg_handle_lock) {
> +
> +        if (!reg_handles) {
> +            reg_handles = g_hash_table_new(g_direct_hash, g_direct_equal);
> +        }
> +
> +        for (int i = 0; i < gdbstub_regs->len; i++) {
> +            GDBRegDesc *grd = &g_array_index(gdbstub_regs, GDBRegDesc, i);
> +            gpointer key = cpu_plus_reg_to_key(cs, grd->gdb_reg);
> +            struct qemu_plugin_register *val = g_hash_table_lookup(reg_handles,
> +                                                                   key);
> +
> +            /* skip "un-named" regs */
> +            if (!grd->name) {
> +                continue;
> +            }
> +
> +            /* Doesn't exist, create one */
> +            if (!val) {
> +                val = g_new0(struct qemu_plugin_register, 1);
> +                val->gdb_reg_num = grd->gdb_reg;
> +                val->name = g_intern_string(grd->name);
> +
> +                g_hash_table_insert(reg_handles, key, val);
> +            }
> +
> +            /* Create a record for the plugin */
> +            qemu_plugin_reg_descriptor desc = {
> +                .handle = val,
> +                .name = val->name,
> +                .feature = g_intern_string(grd->feature_name)
> +            };
> +            g_array_append_val(find_data, desc);
> +        }
> +    }
> +
> +    return find_data;
> +}
> +
> +GArray *qemu_plugin_get_registers(void)
> +{
> +    g_assert(current_cpu);
> +
> +    g_autoptr(GArray) regs = gdb_get_register_list(current_cpu);
> +    return regs->len ? create_register_handles(current_cpu, regs) : NULL;
> +}
> +
> +int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
> +{
> +    g_assert(current_cpu);
> +
> +    return gdb_read_register(current_cpu, buf, reg->gdb_reg_num);
> +}
> +
> +static void __attribute__((__constructor__)) qemu_api_init(void)
> +{
> +    qemu_mutex_init(&reg_handle_lock);
> +
> +}
> diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
> index adb67608598..27fe97239be 100644
> --- a/plugins/qemu-plugins.symbols
> +++ b/plugins/qemu-plugins.symbols
> @@ -3,6 +3,7 @@
>     qemu_plugin_end_code;
>     qemu_plugin_entry_code;
>     qemu_plugin_get_hwaddr;
> +  qemu_plugin_get_registers;
>     qemu_plugin_hwaddr_device_name;
>     qemu_plugin_hwaddr_is_io;
>     qemu_plugin_hwaddr_phys_addr;
> @@ -19,6 +20,7 @@
>     qemu_plugin_num_vcpus;
>     qemu_plugin_outs;
>     qemu_plugin_path_to_binary;
> +  qemu_plugin_read_register;
>     qemu_plugin_register_atexit_cb;
>     qemu_plugin_register_flush_cb;
>     qemu_plugin_register_vcpu_exit_cb;

