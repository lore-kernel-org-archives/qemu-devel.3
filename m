Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37CDC3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 23:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTUro-0004zs-Ol; Mon, 15 Jul 2024 19:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sTUrn-0004zO-QQ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 19:12:23 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sTUrl-0008Dq-Pq
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 19:12:23 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fb457b53c8so39860405ad.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 16:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721085140; x=1721689940; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SwqeC+CBi7ipCIU/O9Ca47RDN0i1Obb0QQKO7S/4yok=;
 b=X4EWWBzuvtgKbqd5h+Z204Ee095AhfLMzKDAhNCf2kMRmVAN6XsmAM5w1jtlxDuPPC
 62v+at6f5Mc4U5bEiUSl/YI8p9QDIfab5IqNOqt4+h4MVNn58CwLkErNHh5BjW7oB/l+
 NQ/agSYnFGhEbwa1EoUmRHM0Hm/bLS03l6Z5CmrQRsxixdc6WDFiu+rqFIJQYHN4xu0E
 sg+EVLOPAFOljAnz5T9vAdieltwga8qRk6V6W+eOf2Dm0+Fqc2rA1B3edwfMExXg8Bo3
 A5Z8H21AjzFo3RmBCoP1bK3oE8kX4v8HOq9hyoyoZmioM4TPhOBQ9l43ik+2CkXXj4R/
 nfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721085140; x=1721689940;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SwqeC+CBi7ipCIU/O9Ca47RDN0i1Obb0QQKO7S/4yok=;
 b=qLyEb+XBfEXxM9GX8BQSPVD4tBgtukl7wnL+W6BfNK75AIDoGtJ9k2SGaMN8gfGHG+
 rz0T4NTwN7bP/Jp8EyFnDGd/2EkxqNS3lFLm6vRdPSR++8/8mOBqgZuYKpPbog7p9Eo0
 ppiPKBzKJQeBytJfzvGKh//V7azqTunn3QVllA2623OTGRt2gYvQLs9uYzPDgCOIF8gh
 APQBrfc0iMcdGriHw6U/Ew5FH51LFYzD1jM14XWu1+wa4SxfCEm0RhfA0AMO+tiV9jJ2
 tnNj6+IhYSQeKCfnZlQ48nlIw+U7PDWJXqxy2DuFNDkhc9ZHUyGi7SsP9mp1enXbhJzK
 ZXMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqILE5P0CitDAnPoJSCscKkL7EIvVmpCvSEvmIRixQusscsnafkU8l3lZCuZE8VN9E6X1g3Ud7+SpcnXBn2Br4aytBkoE=
X-Gm-Message-State: AOJu0Yw4jKo1Ay0m72QGs0HHT3a8EvSseYYWIWurNUYNrq9z/q7Z5O/D
 yIA3EvTAHvsvZ28/8+bBsE6MkHKCVj14liSqscQ8JV1mu4bEHgl2AMBgdTbYWC4=
X-Google-Smtp-Source: AGHT+IFULYnFcw0BAfQEIvYBmcD81mUr2XVBC4ZJ/CdBPIacG/CgUIDdcl1AKBB8vZarDcN6F3XxNQ==
X-Received: by 2002:a17:902:cec5:b0:1fb:6574:8366 with SMTP id
 d9443c01a7336-1fc3d9c4baemr3056885ad.51.1721085139839; 
 Mon, 15 Jul 2024 16:12:19 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::bfd3? ([2604:3d08:9384:1d00::bfd3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bb70107sm46627855ad.43.2024.07.15.16.12.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 16:12:19 -0700 (PDT)
Message-ID: <3c9c625b-6442-4e2d-9f27-793d91e8d89c@linaro.org>
Date: Mon, 15 Jul 2024 16:12:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] plugins/stoptrigger: TCG plugin to stop execution
 under conditions
Content-Language: en-US
To: Simon Hamelin <simon.hamelin@grenoble-inp.org>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240715081521.19122-2-simon.hamelin@grenoble-inp.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240715081521.19122-2-simon.hamelin@grenoble-inp.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 7/15/24 01:15, Simon Hamelin wrote:
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
> v4:
>    - remove unnecessary lock
> 
>   contrib/plugins/Makefile      |   1 +
>   contrib/plugins/stoptrigger.c | 151 ++++++++++++++++++++++++++++++++++
>   docs/devel/tcg-plugins.rst    |  22 +++++
>   3 files changed, 174 insertions(+)
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
> index 0000000000..03ee22f4c6
> --- /dev/null
> +++ b/contrib/plugins/stoptrigger.c
> @@ -0,0 +1,151 @@
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
> +    exit_code = GPOINTER_TO_INT(
> +        g_hash_table_lookup(addrs_ht, GUINT_TO_POINTER(insn_vaddr)));
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
> +            if (g_hash_table_contains(addrs_ht, insn_vaddr)) {
> +                /* Exit triggered by address */
> +                qemu_plugin_register_vcpu_insn_exec_cb(
> +                    insn, exit_address_reached, QEMU_PLUGIN_CB_NO_REGS,
> +                    insn_vaddr);
> +            }
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
> +            g_hash_table_insert(addrs_ht, GUINT_TO_POINTER(exit_addr),
> +                                GINT_TO_POINTER(exit_code));
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

