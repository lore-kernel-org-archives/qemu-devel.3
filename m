Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBF5C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 17:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSKFY-0006k2-BH; Fri, 12 Jul 2024 13:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sSKFQ-0006jC-Cr
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 13:39:58 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sSKFE-0003qH-Gf
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 13:39:56 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-75c3acf90f0so1725065a12.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 10:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720805983; x=1721410783; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w5S4Dzgk0DT9Pee6tcJrVWNJeVLLs1eY2CiBxP/V7n8=;
 b=eqymb5blVHmIm4o3hzepE1ZJq2nhEP7rZNPa/UV49hbkMIcLZ9u9JEhRWmReno8Wqi
 J6zBetGpycPIqPFTIqTBiDfGtpW43/yQCaRJggF+Ko6xoZJ3agIFX5zTBhqUYOEkvnXh
 +nN3FEhuRi5ibrR7N9C0XahBgbexEKX2lVdzU1HvOCrbG7PepnU9VboroWbDAYCUMEu+
 vlX09P1ZisysmsZPOVE9iQfMBExhM8umiYXv/6RU+6SdU7qHF9qOX8MjMahrhprCjaTj
 66IolaXwfsyjjs3A43z6wZNjwgq1ubS6dqZlRIrMulfpG5bsOkU5KrpOtMZqFjxuUaJk
 J7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720805983; x=1721410783;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w5S4Dzgk0DT9Pee6tcJrVWNJeVLLs1eY2CiBxP/V7n8=;
 b=ZSRGonNnVw8jugJIq5AKDHKGNex4kpawDhXvOv1kRCBFdDoaJ3HMkAYW978aStYKyw
 NNVhXTaHUVc3odUBEOoJ0pQ5QV7YL9AKuOnRwQvMKtR5s1RK04LwXET/2HzbyVKkLi+e
 1V0iBxWSIaZbxPHVGtp5VpW1VS5a++jTHlKD2nMOS4PnlGRmc8LeSnl9PTR+yyYxpvKo
 YoIi8tuye3CQRq5mEMjXQ+G5A2kU58Fdwd6n3RD5vBy6CCuuDwwC1DVDIt1Ya1HEJ3/X
 sQRG+f4V5JRpwW+rGm1+e170laWeT8zJ9bHm6zjcu4SGZVs9e5zMV1xOHe1RmCQmWqxl
 AHmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXn9iBRmNZQ6wDe1p4eYD5V0Q9G3DZFFem8UdyDdlJp/s3Fh4tLiWeAYdNQd8wXBYs5RXWMJT4ZO4bK/WzmGJXrbu7qiQ=
X-Gm-Message-State: AOJu0YyKXCPBoEWNTGAGWAdpWr3OOCCzelmXRkCXbJ7NQ6bZ84b0WpdF
 TD9MvwslmWTya5gCQUoYOuUSnsLAydTNc3K21iivCTrZMwaJh2cqq3Q6YBWZ67Y=
X-Google-Smtp-Source: AGHT+IFuQaWvbQvbO3V8rZLrQdXAlYqDfWlTBoYAsuR84+3Owvf3CjzeAhUYljW9Vq1x6QNv81q0vg==
X-Received: by 2002:a05:6a20:7f96:b0:1c2:93a7:2556 with SMTP id
 adf61e73a8af0-1c2984cf106mr13976577637.41.1720805982626; 
 Fri, 12 Jul 2024 10:39:42 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::bfd3? ([2604:3d08:9384:1d00::bfd3])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-77d66db03f8sm5991377a12.69.2024.07.12.10.39.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jul 2024 10:39:42 -0700 (PDT)
Message-ID: <585f77de-e8cd-4387-a01a-cdd6e3d279b2@linaro.org>
Date: Fri, 12 Jul 2024 10:39:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] plugins/stoptrigger: TCG plugin to stop execution
 under conditions
Content-Language: en-US
To: Simon Hamelin <simon.hamelin@grenoble-inp.org>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240712080354.11386-2-simon.hamelin@grenoble-inp.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240712080354.11386-2-simon.hamelin@grenoble-inp.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 7/12/24 01:03, Simon Hamelin wrote:
> This new plugin allows to stop emulation using conditions on the
> emulation state. By setting this plugin arguments, it is possible
> to set an instruction count limit and/or trigger address(es) to stop at.
> The code returned at emulation exit can be customized.
> 
> This plugin demonstrates how someone could stop QEMU execution.
> It could be used for research purposes to launch some code and
> deterministically stop it and understand where its execution flow went.
> 
> Co-authored-by: Alexandre Iooss <erdnaxe@crans.org>
> Signed-off-by: Simon Hamelin <simon.hamelin@grenoble-inp.org>
> Signed-off-by: Alexandre Iooss <erdnaxe@crans.org>
> ---
> v2:
>    - use a scoreboard for counting instructions
>    - no longer hook each instruction to exit at given address
>    - add `exit_emulation` function for future use case such as stopping the VM or triggering a gdbstub exception
> 
> v3:
>    - add missing glib include
>    - refactor code to print exit address when icount is reached
> 
>   contrib/plugins/Makefile      |   1 +
>   contrib/plugins/stoptrigger.c | 158 ++++++++++++++++++++++++++++++++++
>   docs/devel/tcg-plugins.rst    |  22 +++++
>   3 files changed, 181 insertions(+)
>   create mode 100644 contrib/plugins/stoptrigger.c
> 
> diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
> index 449ead1130..98a89d5c40 100644
> --- a/contrib/plugins/Makefile
> +++ b/contrib/plugins/Makefile
> @@ -28,6 +28,7 @@ NAMES += hwprofile
>   NAMES += cache
>   NAMES += drcov
>   NAMES += ips
> +NAMES += stoptrigger
>   
>   ifeq ($(CONFIG_WIN32),y)
>   SO_SUFFIX := .dll
> diff --git a/contrib/plugins/stoptrigger.c b/contrib/plugins/stoptrigger.c
> new file mode 100644
> index 0000000000..490afbcbaf
> --- /dev/null
> +++ b/contrib/plugins/stoptrigger.c
> @@ -0,0 +1,158 @@
> +/*
> + * Copyright (C) 2024, Simon Hamelin <simon.hamelin@grenoble-inp.org>
> + *
> + * Stop execution once a given address is reached or if the
> + * count of executed instructions reached a specified limit
> + *
> + * License: GNU GPL, version 2 or later.
> + *   See the COPYING file in the top-level directory.
> + */
> +
> +#include <assert.h>
> +#include <glib.h>
> +#include <inttypes.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#include <qemu-plugin.h>
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
> +
> +/* Scoreboard to track executed instructions count */
> +typedef struct {
> +    uint64_t insn_count;
> +} InstructionsCount;
> +static struct qemu_plugin_scoreboard *insn_count_sb;
> +static qemu_plugin_u64 insn_count;
> +
> +static uint64_t icount;
> +static int icount_exit_code;
> +
> +static bool exit_on_icount;
> +static bool exit_on_address;
> +
> +/* Map trigger addresses to exit code */
> +static GHashTable *addrs_ht;
> +static GMutex addrs_ht_lock;
> +
> +static void exit_emulation(int return_code, char *message)
> +{
> +    qemu_plugin_outs(message);
> +    g_free(message);
> +    exit(return_code);
> +}
> +
> +static void exit_icount_reached(unsigned int cpu_index, void *udata)
> +{
> +    uint64_t insn_vaddr = GPOINTER_TO_UINT(udata);
> +    char *msg = g_strdup_printf("icount reached at 0x%" PRIx64 ", exiting\n",
> +                                insn_vaddr);
> +
> +    exit_emulation(icount_exit_code, msg);
> +}
> +
> +static void exit_address_reached(unsigned int cpu_index, void *udata)
> +{
> +    uint64_t insn_vaddr = GPOINTER_TO_UINT(udata);
> +    char *msg = g_strdup_printf("0x%" PRIx64 " reached, exiting\n", insn_vaddr);
> +    int exit_code;
> +
> +    g_mutex_lock(&addrs_ht_lock);
> +    exit_code = GPOINTER_TO_INT(
> +        g_hash_table_lookup(addrs_ht, GUINT_TO_POINTER(insn_vaddr)));
> +    g_mutex_unlock(&addrs_ht_lock);

This hashtable is read only after qemu_plugin_install, so you can safely 
remove this lock.

> +
> +    exit_emulation(exit_code, msg);
> +}
> +
> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> +{
> +    size_t tb_n = qemu_plugin_tb_n_insns(tb);
> +    for (size_t i = 0; i < tb_n; i++) {
> +        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
> +        gpointer insn_vaddr = GUINT_TO_POINTER(qemu_plugin_insn_vaddr(insn));
> +
> +        if (exit_on_icount) {
> +            /* Increment and check scoreboard for each instruction */
> +            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
> +                insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
> +            qemu_plugin_register_vcpu_insn_exec_cond_cb(
> +                insn, exit_icount_reached, QEMU_PLUGIN_CB_NO_REGS,
> +                QEMU_PLUGIN_COND_EQ, insn_count, icount + 1, insn_vaddr);
> +        }
> +
> +        if (exit_on_address) {
> +            g_mutex_lock(&addrs_ht_lock);
> +            if (g_hash_table_contains(addrs_ht, insn_vaddr)) {
> +                /* Exit triggered by address */
> +                qemu_plugin_register_vcpu_insn_exec_cb(
> +                    insn, exit_address_reached, QEMU_PLUGIN_CB_NO_REGS,
> +                    insn_vaddr);
> +            }
> +            g_mutex_unlock(&addrs_ht_lock);

Same as before, it would avoid the need to lock in the (hot) translation 
path. This should be faster.

> +        }
> +    }
> +}
> +
> +static void plugin_exit(qemu_plugin_id_t id, void *p)
> +{
> +    g_hash_table_destroy(addrs_ht);
> +    qemu_plugin_scoreboard_free(insn_count_sb);
> +}
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> +                                           const qemu_info_t *info, int argc,
> +                                           char **argv)
> +{
> +    addrs_ht = g_hash_table_new(NULL, g_direct_equal);
> +
> +    insn_count_sb = qemu_plugin_scoreboard_new(sizeof(InstructionsCount));
> +    insn_count = qemu_plugin_scoreboard_u64_in_struct(
> +        insn_count_sb, InstructionsCount, insn_count);
> +
> +    for (int i = 0; i < argc; i++) {
> +        char *opt = argv[i];
> +        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
> +        if (g_strcmp0(tokens[0], "icount") == 0) {
> +            g_auto(GStrv) icount_tokens = g_strsplit(tokens[1], ":", 2);
> +            icount = g_ascii_strtoull(icount_tokens[0], NULL, 0);
> +            if (icount < 1 || g_strrstr(icount_tokens[0], "-") != NULL) {
> +                fprintf(stderr,
> +                        "icount parsing failed: '%s' must be a positive "
> +                        "integer\n",
> +                        icount_tokens[0]);
> +                return -1;
> +            }
> +            if (icount_tokens[1]) {
> +                icount_exit_code = g_ascii_strtoull(icount_tokens[1], NULL, 0);
> +            }
> +            exit_on_icount = true;
> +        } else if (g_strcmp0(tokens[0], "addr") == 0) {
> +            g_auto(GStrv) addr_tokens = g_strsplit(tokens[1], ":", 2);
> +            uint64_t exit_addr = g_ascii_strtoull(addr_tokens[0], NULL, 0);
> +            int exit_code = 0;
> +            if (addr_tokens[1]) {
> +                exit_code = g_ascii_strtoull(addr_tokens[1], NULL, 0);
> +            }
> +            g_mutex_lock(&addrs_ht_lock);
> +            g_hash_table_insert(addrs_ht, GUINT_TO_POINTER(exit_addr),
> +                                GINT_TO_POINTER(exit_code));
> +            g_mutex_unlock(&addrs_ht_lock);

qemu_plugin_install will be called before any other callbacks, so no 
need to lock.

> +            exit_on_address = true;
> +        } else {
> +            fprintf(stderr, "option parsing failed: %s\n", opt);
> +            return -1;
> +        }
> +    }
> +
> +    if (!exit_on_icount && !exit_on_address) {
> +        fprintf(stderr, "'icount' or 'addr' argument missing\n");
> +        return -1;
> +    }
> +
> +    /* Register translation block and exit callbacks */
> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
> +    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> +
> +    return 0;
> +}
> diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
> index f7d7b9e3a4..954623f9bf 100644
> --- a/docs/devel/tcg-plugins.rst
> +++ b/docs/devel/tcg-plugins.rst
> @@ -642,6 +642,28 @@ The plugin has a number of arguments, all of them are optional:
>     configuration arguments implies ``l2=on``.
>     (default: N = 2097152 (2MB), B = 64, A = 16)
>   
> +- contrib/plugins/stoptrigger.c
> +
> +The stoptrigger plugin allows to setup triggers to stop emulation.
> +It can be used for research purposes to launch some code and precisely stop it
> +and understand where its execution flow went.
> +
> +Two types of triggers can be configured: a count of instructions to stop at,
> +or an address to stop at. Multiple triggers can be set at once.
> +
> +By default, QEMU will exit with return code 0. A custom return code can be
> +configured for each trigger using ``:CODE`` syntax.
> +
> +For example, to stop at the 20-th instruction with return code 41, at address
> +0xd4 with return code 0 or at address 0xd8 with return code 42::
> +
> +  $ qemu-system-aarch64 $(QEMU_ARGS) \
> +    -plugin ./contrib/plugins/libstoptrigger.so,icount=20:41,addr=0xd4,addr=0xd8:42 -d plugin
> +
> +The plugin will log the reason of exit, for example::
> +
> +  0xd4 reached, exiting
> +
>   Plugin API
>   ==========
>   

Pierrick

