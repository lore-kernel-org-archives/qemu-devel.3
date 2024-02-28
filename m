Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF420C54E51
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 05:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfCBN-00037p-Th; Wed, 28 Feb 2024 00:08:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfCBM-00037O-Fq
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:08:40 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfCBF-00059S-Lz
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:08:40 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dc418fa351so3654715ad.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 21:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709096910; x=1709701710;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DMPgVNvmzalgvHPBuzD3V/ryvEAYg9lKZEfro7Y6HD8=;
 b=RKB+aedK9HojP/r4MQu+smK/+lIujEAekWDi9Z9iIZi9+G3QFehevDB+ZM1wROEO89
 yKAHo6TGyXHkBmjLDWPen+zEBHsj2dPXV9hi725lHGcAFxP8Z54LLyPiJ5RkQ0QHue5f
 1dom2T0Rbqg4Y9jnTDZsfRu655RVTn7U41oza7bilDEgtBP19y97ypLJ71C8Os3T9o6T
 9glyvFKSdkoQxfu3Tjz6LMm1QgRUpgL0hgSvUoid4DIg/2ZPg5eLwiNzF0DY2R1+jOng
 1f474M2rIbEGKGEN6b6rabS4Sk+TXGz3JzWAriUrB7KCUydSaIm4HcoZm5gj60mblGL5
 QMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709096910; x=1709701710;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DMPgVNvmzalgvHPBuzD3V/ryvEAYg9lKZEfro7Y6HD8=;
 b=Ja9nhevYk3PTpF51YmBU7K0hhzi14VDPrpOREoZs9fjMLB/BcyVg8FW7bhAnTbkHk3
 TcZLH+Sp/uP0D26JfCNmLPAeunN9/6fy1xo70N1sMHYkhqgecRnqIOzr3ZiLGqrUYmyS
 1JpD309enI3STlafOiKMITufbB3/tfYxSStEIpKp40y9OD++YyJbKH7pIB+Wf/zbX3Ld
 b9Z8+qKrqWNr0fw9VT+MDUHxCFOX5bsNzcJ7e87GGSSKEREaxMfT+uYH+hvP5EHrK9L7
 7m9r/4a/L07UtSn9VAM6WM027GiXTsuiT/+3z0qpAMcLsxoQx9oNhmQ4kd9+dmOrqQNr
 LFUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCXuavr/OIjkhLHf8MG9seOqpyYaW0aY1AnDGeUXRHWV5Hz7TuEuffVpusNh2YuPWUSaF3vV349i3vWYOHMWpVFVFHr4Q=
X-Gm-Message-State: AOJu0YwouaED+sZCfVB5AS0FnZXDBHD1RUsGPhYXYuTyqxMNQHlZ98cF
 UcuTO7SJWYo42u0cHtqLEPPUahPBFuzzjuIUIVkkqgaYkXnJj9WTM7z0i7MAt98=
X-Google-Smtp-Source: AGHT+IEASog9cnsCWy8p3XNTrP9WJ0KoOIuMXN7jhz5aBYD8n85WMe6uvXvLTYvc/MQDDe+LD2m5Xw==
X-Received: by 2002:a17:902:b682:b0:1dc:9bb5:cb5 with SMTP id
 c2-20020a170902b68200b001dc9bb50cb5mr1541958pls.28.1709096910144; 
 Tue, 27 Feb 2024 21:08:30 -0800 (PST)
Received: from [157.82.203.206] ([157.82.203.206])
 by smtp.gmail.com with ESMTPSA id
 km13-20020a17090327cd00b001db5ecb2899sm2376359plb.162.2024.02.27.21.08.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 21:08:29 -0800 (PST)
Message-ID: <69da287a-90c2-46e9-b1f2-4fb899bedbbe@daynix.com>
Date: Wed, 28 Feb 2024 14:08:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/29] plugins: add an API to read registers
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 qemu-arm@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Rolnik <mrolnik@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-s390x@nongnu.org,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, John Snow
 <jsnow@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <bcain@quicinc.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240227144335.1196131-1-alex.bennee@linaro.org>
 <20240227144335.1196131-24-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240227144335.1196131-24-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
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

On 2024/02/27 23:43, Alex Bennée wrote:
> We can only request a list of registers once the vCPU has been
> initialised so the user needs to use either call the get function on
> vCPU initialisation or during the translation phase.
> 
> We don't expose the reg number to the plugin instead hiding it behind
> an opaque handle. For now this is just the gdb_regnum encapsulated in
> an anonymous GPOINTER but in future as we add more state for plugins
> to track we can expand it.
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
> v5
>    - make reg_handles as per-CPUPluginState variable.
> v6
>    - for now just wrap gdb_regnum
> v7
>    - minor style fixes
> ---
>   include/qemu/qemu-plugin.h   | 48 +++++++++++++++++++++++++++++--
>   plugins/api.c                | 55 ++++++++++++++++++++++++++++++++++++
>   plugins/qemu-plugins.symbols |  2 ++
>   3 files changed, 103 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 93981f8f89f..6c5580f4428 100644
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
> + * Returns a potentially empty GArray of qemu_plugin_reg_descriptor.
> + * Caller frees the array (but not the const strings).
> + *
> + * Should be used from a qemu_plugin_register_vcpu_init_cb() callback
> + * after the vCPU is initialised, i.e. in the vCPU context.
> + */

Qualify with QEMU_PLUGIN_API, which was apparently added after this 
patch was authored.

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

Add a period after -1.

> + */
> +int qemu_plugin_read_register(struct qemu_plugin_register *handle,
> +                              GByteArray *buf);
> +
> +
>   #endif /* QEMU_QEMU_PLUGIN_H */
> diff --git a/plugins/api.c b/plugins/api.c
> index 54df72c1c00..908fe7e6fa3 100644
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
> @@ -410,3 +413,55 @@ uint64_t qemu_plugin_entry_code(void)
>   #endif
>       return entry;
>   }
> +
> +/*
> + * Create register handles.
> + *
> + * We need to create a handle for each register so the plugin
> + * infrastructure can call gdbstub to read a register. They are
> + * currently just a pointer encapsulation of the gdb_regnum but in

s/gdb_regnum/gdb_reg/

With all comments fixed,

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

> + * future may hold internal plugin state so its important plugin
> + * authors are not tempted to treat them as numbers.
> + *
> + * We also construct a result array with those handles and some
> + * ancillary data the plugin might find useful.
> + */
> +
> +static GArray *create_register_handles(GArray *gdbstub_regs)
> +{
> +    GArray *find_data = g_array_new(true, true,
> +                                    sizeof(qemu_plugin_reg_descriptor));
> +
> +    for (int i = 0; i < gdbstub_regs->len; i++) {
> +        GDBRegDesc *grd = &g_array_index(gdbstub_regs, GDBRegDesc, i);
> +        qemu_plugin_reg_descriptor desc;
> +
> +        /* skip "un-named" regs */
> +        if (!grd->name) {
> +            continue;
> +        }
> +
> +        /* Create a record for the plugin */
> +        desc.handle = GINT_TO_POINTER(grd->gdb_reg);
> +        desc.name = g_intern_string(grd->name);
> +        desc.feature = g_intern_string(grd->feature_name);
> +        g_array_append_val(find_data, desc);
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
> +    return create_register_handles(regs);
> +}
> +
> +int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
> +{
> +    g_assert(current_cpu);
> +
> +    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg));
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

