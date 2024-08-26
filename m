Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB64C5472E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 19:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sif7U-0001Wr-NT; Mon, 26 Aug 2024 15:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sif7T-0001W6-9K
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 15:11:15 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sif7Q-0004xe-Fy
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 15:11:14 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20231aa8908so36671605ad.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 12:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724699470; x=1725304270; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XS/dDR8f4BIFUF3OSKYd7GHBaWXfODO744UNg3cLjf4=;
 b=Hu11HR6/Oehxke+EOt/IVNGM0JN7Xo8/AjXG1Vpb6WcgQU8eaH1dAz7dsw6t/v1dpx
 Wv4DEQ8mX9fSLyru7HkKjGzq5ATsfDVWrZ7SH8pUKpyOYKVyGQWsh+CKnionbQQ7GVUq
 SOtyoNyNgABgOvaNNZEC9kl3Ut+8YjLY7rKBuZQMT1AiOxwUWYxsAbDjdX1+TWwVXVf9
 fi/dbT3RQPthu8oCC+YyhKblSUcZB4OSihySkYH/w5ElEoYK31RhckG8Bin6c0Zz80nH
 CO11gftivJhauoJ3Pf24DCgs00D9B6hUjjiFwMFSQaQVvbnpd3BUyk48svmFdpG8v277
 0iYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724699470; x=1725304270;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XS/dDR8f4BIFUF3OSKYd7GHBaWXfODO744UNg3cLjf4=;
 b=b2fAgfE39Q77Z7oMZr2uaoreFn150hww8BS+T3VoY0qpnJJKYk7EketZ99E5b2cA5L
 yZ8MrKHVsTzCCf6TjK5WbZP/DY6VwWPtOO8/p1SLj4DqUuRhGuxjJK31PoFLOy/EzFvI
 6tSDJNe1n2O3AfPtKbZ7kAWwjysZXxRHbRLAqu59SjFD4YYQckPnLYCxCrFJKpZKUVKo
 wRBj9R/QzmvHkVCYV7D/MYnf1Zeio9PFD+qjX98arL7p617k0Kie4qIZyuVkKnKx945X
 OfKaqNr013QiiFbCJ3jeY/kLZj/emkYLGV0CVtV5HmIXNXl6dg5HfdnT2G8OV/5EIPXR
 QyQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXMy3efL2CqvHtu1txD5gPpuDBi/R1uaQCXOKGfBddCgm0eYZl3WU1LSF/ySyJ7sJnl8G+IuLWebJl@nongnu.org
X-Gm-Message-State: AOJu0Yw4I9IQdQuAPBU0IVYsVryjeTDYQ44BGX5/xUf7FQhmYTC51ikT
 dtI7DuKD2ErRS4cpavZEu0WvXtYw4JfepDV6BqFNteqRpDCZ0QqfVIHLm+EQP4k=
X-Google-Smtp-Source: AGHT+IEivRMdvhQHSWqsAoI8ei7elpBLyapPWjazBuEJH1i6U4GYaEPry+04EvE//rsWSIfjzc3/tg==
X-Received: by 2002:a17:902:d2c4:b0:202:4b99:fd3b with SMTP id
 d9443c01a7336-204df4d39e1mr5463715ad.42.1724699469667; 
 Mon, 26 Aug 2024 12:11:09 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::27bd? ([2604:3d08:9384:1d00::27bd])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20385569fabsm70602005ad.57.2024.08.26.12.11.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 12:11:09 -0700 (PDT)
Message-ID: <38ca2658-efef-4cf2-b88b-86574920dc01@linaro.org>
Date: Mon, 26 Aug 2024 12:11:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: add plugin API to read guest memory
Content-Language: en-US
To: Rowan Hart <rowanbhart@gmail.com>
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240821235607.208622-1-rowanbhart@gmail.com>
 <d134a954-0380-41dc-9e3b-75e1dc2e2bbf@linaro.org>
 <bffcb1ae-151f-4cc5-be32-0221edd7539d@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <bffcb1ae-151f-4cc5-be32-0221edd7539d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

On 8/26/24 11:47, Rowan Hart wrote:
> Alex & Pierrick,
> 
> Thank you for the feedback! This is my first contribution to QEMU, so I'm glad
> it at least passes the initial smell test :)
> 

Sure, no worries, you did well!

>> I'll make my comments in this patch, but for v2, please split those individual
>> commits, and a cover letter, describing your changes (https://github.com/
>> stefanha/git-publish is a great tool if you want to easily push series).
> 
> Will do! Mailing list dev is new to me but I will do a practice run to try and
> not mess it up.
> 

If you already configured git send-email, git-publish just does all the 
rest for you (collecting reviewers, prepare patches, and send using git 
send-email). In more, it tracks you different versions, so it's pretty 
easy to iterate on a series.

> 
> 
>>> +QEMU_PLUGIN_API
>>> +GByteArray *qemu_plugin_read_memory_vaddr(uint64_t addr,
>>> +                                          size_t len);
>>> +
>>
>> IMHO, it would be better to pass the buffer as a parameter, instead of allocating a new one everytime.
>>
>> bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *buf, size_t len).
> 
> Sure, this makes perfect sense. I considered both and picked wrong so not hard
> to change.
> 
>>>    /**
>>>     * qemu_plugin_read_register() - read register for current vCPU
>>>     *
>>> diff --git a/plugins/api.c b/plugins/api.c
>>> index 2ff13d09de..f210ca166a 100644
>>> --- a/plugins/api.c
>>> +++ b/plugins/api.c
>>> @@ -527,6 +527,27 @@ GArray *qemu_plugin_get_registers(void)
>>>        return create_register_handles(regs);
>>>    }
>>>    +GByteArray *qemu_plugin_read_memory_vaddr(vaddr addr, size_t len)
>>> +{
>>> +    g_assert(current_cpu);
>>> +
>>> +    if (len == 0) {
>>> +        return NULL;
>>> +    }
>>> +
>>> +    GByteArray *buf = g_byte_array_sized_new(len);
>>> +    g_byte_array_set_size(buf, len);
>>> +
>>> +    int result = cpu_memory_rw_debug(current_cpu, addr, buf->data, buf->len, 0);
>>> +
>>> +    if (result < 0) {
>>> +        g_byte_array_unref(buf);
>>> +        return NULL;
>>> +    }
>>> +
>>> +    return buf;
>>> +}
>>> +
>>>    int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
>>>    {
>>>        g_assert(current_cpu);
>>> diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
>>> index ca773d8d9f..3ad479a924 100644
>>> --- a/plugins/qemu-plugins.symbols
>>> +++ b/plugins/qemu-plugins.symbols
>>> @@ -20,6 +20,7 @@
>>>      qemu_plugin_num_vcpus;
>>>      qemu_plugin_outs;
>>>      qemu_plugin_path_to_binary;
>>> +  qemu_plugin_read_memory_vaddr;
>>>      qemu_plugin_read_register;
>>>      qemu_plugin_register_atexit_cb;
>>>      qemu_plugin_register_flush_cb;
>>> diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
>>> index b650dddcce..c65d48680b 100644
>>> --- a/tests/tcg/plugins/mem.c
>>> +++ b/tests/tcg/plugins/mem.c
>>> @@ -24,7 +24,7 @@ typedef struct {
>>>    static struct qemu_plugin_scoreboard *counts;
>>>    static qemu_plugin_u64 mem_count;
>>>    static qemu_plugin_u64 io_count;
>>> -static bool do_inline, do_callback;
>>> +static bool do_inline, do_callback, do_read;
>>>    static bool do_haddr;
>>>    static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
>>>    @@ -58,6 +58,30 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
>>>        } else {
>>>            qemu_plugin_u64_add(mem_count, cpu_index, 1);
>>>        }
>>> +
>>> +    if (do_read) {
>>> +        size_t size = qemu_plugin_mem_size_shift(meminfo);
>>> +        GByteArray *data = qemu_plugin_read_memory_vaddr(vaddr, size);
>>> +
>>> +        if (data) {
>>> +            g_autoptr(GString) out = g_string_new("");
>>> +
>>> +            if (qemu_plugin_mem_is_store(meminfo)) {
>>> +                g_string_append(out, "store: ");
>>> +            } else {
>>> +                g_string_append(out, "load: ");
>>> +            }
>>> +
>>> +            g_string_append_printf(out, "vaddr: 0x%" PRIx64 " data: 0x",
>>> +                                   vaddr);
>>> +            for (size_t i = 0; i < data->len; i++) {
>>> +                g_string_append_printf(out, "%02x", data->data[i]);
>>> +            }
>>> +            g_string_append(out, "\n");
>>> +            qemu_plugin_outs(out->str);
>>> +            g_byte_array_free(data, TRUE);
>>> +        }
>>> +    }
>>
>> See other series, merging an API for getting values read on a memory access. It's a better fit to implement this. So I think it's better to drop this plugin modification.
> 
> Ok, will drop this one and keep the modification to the syscalls plugin only as
> an example of how to use the API.
> 

Good, thanks!

>>>    }
>>>      static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>>> @@ -86,7 +110,6 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>>>                                               const qemu_info_t *info,
>>>                                               int argc, char **argv)
>>>    {
>>> -
>>>        for (int i = 0; i < argc; i++) {
>>>            char *opt = argv[i];
>>>            g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
>>> @@ -117,6 +140,11 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>>>                    fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
>>>                    return -1;
>>>                }
>>> +        } else if (g_strcmp0(tokens[0], "read") == 0) {
>>> +            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &do_read)) {
>>> +                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
>>> +                return -1;
>>> +            }
>>>            } else {
>>>                fprintf(stderr, "option parsing failed: %s\n", opt);
>>>                return -1;
>>> @@ -129,6 +157,11 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>>>            return -1;
>>>        }
>>>    +    if (do_read && !do_callback) {
>>> +        fprintf(stderr, "can't enable memory reading without callback\n");
>>> +        return -1;
>>> +    }
>>> +
>>>        counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
>>>        mem_count = qemu_plugin_scoreboard_u64_in_struct(
>>>            counts, CPUCount, mem_count);
>>> diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
>>> index 72e1a5bf90..67c7c404c4 100644
>>> --- a/tests/tcg/plugins/syscall.c
>>> +++ b/tests/tcg/plugins/syscall.c
>>> @@ -22,8 +22,56 @@ typedef struct {
>>>        int64_t errors;
>>>    } SyscallStats;
>>>    +struct SyscallInfo {
>>> +    const char *name;
>>> +    int64_t write_sysno;
>>> +};
>>> +
>>> +const struct SyscallInfo arch_syscall_info[] = {
>>> +    { "aarch64", 64 },
>>> +    { "aarch64_be", 64 },
>>> +    { "alpha", 4 },
>>> +    { "arm", 4 },
>>> +    { "armeb", 4 },
>>> +    { "avr", -1 },
>>> +    { "cris", -1 },
>>> +    { "hexagon", 64 },
>>> +    { "hppa", -1 },
>>> +    { "i386", 4 },
>>> +    { "loongarch64", -1 },
>>> +    { "m68k", 4 },
>>> +    { "microblaze", 4 },
>>> +    { "microblazeel", 4 },
>>> +    { "mips", 1 },
>>> +    { "mips64", 1 },
>>> +    { "mips64el", 1 },
>>> +    { "mipsel", 1 },
>>> +    { "mipsn32", 1 },
>>> +    { "mipsn32el", 1 },
>>> +    { "or1k", -1 },
>>> +    { "ppc", 4 },
>>> +    { "ppc64", 4 },
>>> +    { "ppc64le", 4 },
>>> +    { "riscv32", 64 },
>>> +    { "riscv64", 64 },
>>> +    { "rx", -1 },
>>> +    { "s390x", -1 },
>>> +    { "sh4", -1 },
>>> +    { "sh4eb", -1 },
>>> +    { "sparc", 4 },
>>> +    { "sparc32plus", 4 },
>>> +    { "sparc64", 4 },
>>> +    { "tricore", -1 },
>>> +    { "x86_64", 1 },
>>> +    { "xtensa", 13 },
>>> +    { "xtensaeb", 13 },
>>> +    { NULL, -1 },
>>> +};
>>> +
>>>    static GMutex lock;
>>>    static GHashTable *statistics;
>>> +static bool do_log_writes;
>>> +static int64_t write_sysno = -1;
>>>      static SyscallStats *get_or_create_entry(int64_t num)
>>>    {
>>> @@ -54,6 +102,51 @@ static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_index,
>>>            g_autofree gchar *out = g_strdup_printf("syscall #%" PRIi64 "\n", num);
>>>            qemu_plugin_outs(out);
>>>        }
>>> +
>>> +    if (do_log_writes && num == write_sysno) {
>>> +        GByteArray *data = qemu_plugin_read_memory_vaddr(a2, a3);
>>> +
>>> +        g_autoptr(GString) out = g_string_new("");
>>> +
>>> +        size_t rows = (data->len % 16 == 0)
>>> +            ? (data->len / 16)
>>> +            : ((data->len / 16) + 1);
>>> +        for (size_t row = 0; row < rows; row++) {
>>> +            size_t len = (rows != data->len / 16 && row == rows - 1)
>>> +                ? (data->len % 16)
>>> +                : 16;
>>> +            for (size_t i = 0; i < len; i++) {
>>> +                g_string_append_printf(out, "%02x ",
>>> +                    data->data[(row * 16) + i]);
>>> +                if (i != 0 && i % 4 == 0) {
>>> +                    g_string_append(out, " ");
>>> +                }
>>> +            }
>>> +            for (size_t i = len; i < 16; i++) {
>>> +                g_string_append(out, "   ");
>>> +                if (i != 0 && i % 4 == 0) {
>>> +                    g_string_append(out, " ");
>>> +                }
>>> +            }
>>> +            g_string_append(out, " | ");
>>> +            for (size_t i = 0; i < len; i++) {
>>> +                g_string_append_printf(out,
>>> +                    (data->data[(row * 16) + i] >= 0x21
>>> +                        && data->data[(row * 16) + i] <= 0x7e)
>>> +                    ? "%c"
>>> +                    : ".", data->data[(row * 16) + i]);
>>> +                if (i != 0 && i % 4 == 0) {
>>> +                    g_string_append(out, " ");
>>> +                }
>>> +            }
>>> +            g_string_append(out, "\n");
>>> +        }
>>
>> Could you add a comment to show what is expected format? From the code, with all these loops and ternary expressions, it's not easy to follow.
> 
> Indeed. I will just generally simplify this
> 
> Thanks!
> 

You're welcome.

> -Rowan

Pierrick

