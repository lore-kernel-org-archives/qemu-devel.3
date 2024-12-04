Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E94E7716F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 23:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIya8-0008Q2-3w; Wed, 04 Dec 2024 18:14:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIya7-0008Pk-98
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 18:14:55 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIya4-0007cE-El
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 18:14:53 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7259d6ae0c8so323385b3a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 15:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733354090; x=1733958890; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/57cZlsOEGQNxoC6WFVv8IRWH8gVSyIMlumupU0338E=;
 b=RBFAYqWYQPqDGjgf2wMdDoE8G3eze7+hT1xYKGS+iQ/YpalHzNAuVgDWLyw1o+XoTg
 pusJOB0RDAry8lM2QLa3j4BXr7TnFxzyv5FNTk4eP6uRlmD6aUdwFpduDVd3jscytCSF
 zfY6/L1r/lMgdoN6WilTUSTdHitZ29Jbo4SHHZ65ydVYGxFVw4+Q+Im+ulSF3zCEW5eP
 mNBKWtoM8BAuZxWz16mKYqoh3bpiFHoMSzZEcaSoxbr8jeUHBuie6BPEq9aNon7GeA+j
 1t97OdO/KS55JlK6bl5eStnxsyJqp1ZFk2K5/PgG2Kdycqiu2ai7LuiK8vNDRJrAXW20
 pLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733354090; x=1733958890;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/57cZlsOEGQNxoC6WFVv8IRWH8gVSyIMlumupU0338E=;
 b=gx1P9lZaa5Dc0GkAtw0KQEQV4O7o/QZE7L27do9BRcQcHdVwSD4xfW6v2fB4jMlizV
 zd3PIp/ykCl44nLb54egHdHME0hKq3YCsz7ogIZXBipthc8/COINeGN4aZxoCSUySUBP
 TZ9p7ARhE/7/R+FyFLW7ZUwQ595gK+tdjHw7v6p9xAQ6uernloVp7/y8FZm6mYUNxz0Y
 FT+SJCuFYsfcJxDYO4zI1eVr1o5zXLNeraYfH6dM5vKx1bR6ja05EDC9B4Qql0i7HWDa
 JpeZHMM57w64epY1Mhhk1xPkbHejFpvk+tAbmXcHILFJXOjs4lnGRAT2h0WEr14cOU9x
 wkng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPghHiIVWZnd48QA1k4/d2ZuEVvhYaRBj6+Vh6SMzDKV/AYmLwUg08rL9AZlw/Gm/1vSJyeLyHbONQ@nongnu.org
X-Gm-Message-State: AOJu0YyKsC9hVTLL0iiCNzqLvjTmsKQaEFFHMLDgzRZAP160nIxUuXyd
 3Ud66vN9fZGzo5FSCDYn8JNcBSTALQaiwy5a0N9S/UKtapLrnENy0+hJbb+xijg=
X-Gm-Gg: ASbGncuFhToNmh/d+gV6WEhXuXSTuBZ+7dv6uI6zuhai6PMbm+OSCHXLJY3Er/QxHqd
 67t7SaB/5TCNbgAiU3iaHS7z2ZiXhGnRzRJKNs7sAhsoG6uB1U2gB+I/IewWWHfePg0rCup5Smp
 bjedvALEEg8sUi9tWE5AnDPb9yMQLOIt2djsnAD0CyZaOkpJ/ElUpcKMGVohz5g7x+xW7WKdQ7I
 64+NpC0Ymr4h8udZbu/BGBeGjky4HZ0szNB7YFZKANRVi0Xlp7qaaf8xbRWfP4n6tD3DcrXkjvx
 QYfCg9cT83lxMfaJwtZZVg==
X-Google-Smtp-Source: AGHT+IGGhq2ldlZS+tH/n1sfcPcQ9PK63crXm8KXBjtTeRMwcE13w2ZaElktkfu2nXTnVjvmLLWVVA==
X-Received: by 2002:a05:6a00:391d:b0:725:936d:4181 with SMTP id
 d2e1a72fcca58-725936d4317mr4279608b3a.19.1733354090580; 
 Wed, 04 Dec 2024 15:14:50 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a29c5ad8sm35563b3a.8.2024.12.04.15.14.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 15:14:50 -0800 (PST)
Message-ID: <76cbce17-0318-436c-b295-0a8ef12b24b9@linaro.org>
Date: Wed, 4 Dec 2024 15:14:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 04/11] contrib/plugins: add plugin showcasing new
 dicontinuity related API
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <cover.1733063076.git.neither@nut.email>
 <fa02142d349ceb6c95e80301a7f5c57ae5df6329.1733063076.git.neither@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <fa02142d349ceb6c95e80301a7f5c57ae5df6329.1733063076.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NEW_PRODUCTS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/2/24 11:26, Julian Ganz wrote:
> We recently introduced new plugin API for registration of discontinuity
> related callbacks. This change introduces a minimal plugin showcasing
> the new API. It simply counts the occurances of interrupts, exceptions
> and host calls per CPU and reports the counts when exitting.
> ---
>   contrib/plugins/meson.build |  3 +-
>   contrib/plugins/traps.c     | 96 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 98 insertions(+), 1 deletion(-)
>   create mode 100644 contrib/plugins/traps.c
> 
> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
> index 63a32c2b4f..9a3015e1c1 100644
> --- a/contrib/plugins/meson.build
> +++ b/contrib/plugins/meson.build
> @@ -1,5 +1,6 @@
>   contrib_plugins = ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotblocks',
> -                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger']
> +                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger',
> +                   'traps']
>   if host_os != 'windows'
>     # lockstep uses socket.h
>     contrib_plugins += 'lockstep'
> diff --git a/contrib/plugins/traps.c b/contrib/plugins/traps.c
> new file mode 100644
> index 0000000000..ecd4beac5f
> --- /dev/null
> +++ b/contrib/plugins/traps.c
> @@ -0,0 +1,96 @@
> +/*
> + * Copyright (C) 2024, Julian Ganz <neither@nut.email>
> + *
> + * Traps - count traps
> + *
> + * License: GNU GPL, version 2 or later.
> + *   See the COPYING file in the top-level directory.
> + */
> +
> +#include <stdio.h>
> +
> +#include <qemu-plugin.h>
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
> +
> +typedef struct {
> +    uint64_t interrupts;
> +    uint64_t exceptions;
> +    uint64_t hostcalls;
> +    bool active;

The active field can be removed, as you can query 
qemu_plugin_num_vcpus() to know (dynamically) how many vcpus were created.

> +} TrapCounters;
> +
> +static struct qemu_plugin_scoreboard *traps;
> +static size_t max_vcpus;
> +
> +static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
> +{
> +    TrapCounters* rec = qemu_plugin_scoreboard_find(traps, vcpu_index);
> +    rec->active = true;
> +}

Once active is removed, this function can be removed too.

> +
> +static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index,
> +                        enum qemu_plugin_discon_type type, uint64_t from_pc,
> +                        uint64_t to_pc)
> +{
> +    TrapCounters* rec = qemu_plugin_scoreboard_find(traps, vcpu_index);
> +    switch (type) {
> +    case QEMU_PLUGIN_DISCON_INTERRUPT:
> +        rec->interrupts++;
> +        break;
> +    case QEMU_PLUGIN_DISCON_EXCEPTION:
> +        rec->exceptions++;
> +        break;
> +    case QEMU_PLUGIN_DISCON_HOSTCALL:
> +        rec->hostcalls++;
> +        break;
> +    default:
> +        /* unreachable */

You can use g_assert_not_reached() ensure it's unreachable. We removed 
assert(0) from the codebase and replaced those with it.

> +        break;
> +    }
> +}
> +
> +static void plugin_exit(qemu_plugin_id_t id, void *p)
> +{
> +    g_autoptr(GString) report;
> +    report = g_string_new("VCPU, interrupts, exceptions, hostcalls\n");
> +    int vcpu;
> +
> +    for (vcpu = 0; vcpu < max_vcpus; vcpu++) {

vcpu < qemu_plugin_num_vcpus()

> +        TrapCounters *rec = qemu_plugin_scoreboard_find(traps, vcpu);
> +        if (rec->active) {
> +            g_string_append_printf(report,
> +                                   "% 4d, % 10"PRId64", % 10"PRId64", % 10"
> +                                   PRId64"\n",
> +                                   vcpu,
> +                                   rec->interrupts, rec->exceptions,
> +                                   rec->hostcalls);
> +        }
> +    }
> +
> +    qemu_plugin_outs(report->str);
> +    qemu_plugin_scoreboard_free(traps);
> +}
> +
> +QEMU_PLUGIN_EXPORT
> +int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
> +                        int argc, char **argv)
> +{
> +    if (!info->system_emulation) {
> +        fputs("trap plugin can only be used in system emulation mode.\n",
> +              stderr);
> +        return -1;
> +    }
> +
> +    max_vcpus = info->system.max_vcpus;
> +    traps = qemu_plugin_scoreboard_new(sizeof(TrapCounters));
> +    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
> +    qemu_plugin_vcpu_for_each(id, vcpu_init);
> +
> +    qemu_plugin_register_vcpu_discon_cb(id, QEMU_PLUGIN_DISCON_TRAPS,
> +                                        vcpu_discon);
> +

The change from QEMU_PLUGIN_DISCON_TRAPS to QEMU_PLUGIN_DISCON_ALL 
should be included in this patch, instead of next one.

> +    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> +
> +    return 0;
> +}


