Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE35C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 18:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siekU-000783-2n; Mon, 26 Aug 2024 14:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1siekS-00077W-Vh
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 14:47:28 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1siekQ-00022H-Ql
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 14:47:28 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2021a99af5eso41558745ad.1
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 11:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724698045; x=1725302845; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ehgicMr6gkg2uGKaV2yUQFJuNaHWfEvdy0TigzDI6S4=;
 b=DEd1ktiZZAgpSQHAMxfL+u39Ft/011XEupyx8NE7/pctd6iLRctMBh1kIFEg5d77vb
 LjX/zMOxmaU2cNA6ahnYvUkw85s7QaIeTotSOKEPa9TUhRtnEUdfhryzr5QvFrdnR3A3
 dP7Jh04jag69cRC+PCTWtr01IygWEbwuQGe4Th8XgVGyqpANTHNK1Xt1O/Klz+dGV66W
 FdibHQUJ31HxQFYIU6051OK/SPNT4JqLNYs9+NnNLLaOlJmrgNNgJMfwoQnnudRFkLVT
 nc8D5Cj80b91cu9Kwy73oj83LfWUaYD8w0mu8y90UX7cs+cOyt5RPETJpSyHJ8v8Kh4z
 3SXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724698045; x=1725302845;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ehgicMr6gkg2uGKaV2yUQFJuNaHWfEvdy0TigzDI6S4=;
 b=MzNTWCCTGynY/gVro/34sNdyxq7W/B+yNEEL+3+mXgiDPYkQ/fW+MfooyvpPrIZ6PC
 ZCX7zY161+JSLStuA+r59XAw5lX7xLyeRSSjRRIq72x0VhRkoGiMmwFF9lP3JJzAGs91
 idRUQzSdmM2cUjZ8+G/pzs8V052+MR1c2hweiD8LZFwG7khj1L9V6tk/OJGgGSOivvNB
 7W3CM8EJB6oIMi9ZLbNwicQEbBk6YZGOzxc6VGs86a65Qv/Bfag8hvzJQ4wwcOBAMI76
 E6X2h4Jr+vJNQMTNBQvqcGkXhRzzQvCrOwKIrCp35QDaAkKWuhtREnlhYkp8Aoi6hzKr
 SnZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5ctjqtyPzrCqtaDPjgmf3cN09l7znkcGa+D64VpfAbtx3NTmCJnJwVU1kdv6hjNSIMmmn94cflwu+@nongnu.org
X-Gm-Message-State: AOJu0YwxbiWOXVIXqalwkeOy+rHG/uC/iyQA8Q+41C+YI6ju3ohNyBRJ
 iZZMZfryHkgDcFbAkKR59FnOiw/a7lAmTfRTap05pdhAgAM9riyw
X-Google-Smtp-Source: AGHT+IGFXZF59ICKMXTK362qSuZulpp43MALOSSFDGSR1aZTohgR4OkYVjm0E0G3iy2QgzlmNd+gWA==
X-Received: by 2002:a17:903:22cd:b0:1fb:1b16:eb7b with SMTP id
 d9443c01a7336-2039e469e8amr132144225ad.16.1724698044699; 
 Mon, 26 Aug 2024 11:47:24 -0700 (PDT)
Received: from [192.168.1.211] ([50.46.173.74])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20385607f94sm70395135ad.182.2024.08.26.11.47.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 11:47:24 -0700 (PDT)
Message-ID: <bffcb1ae-151f-4cc5-be32-0221edd7539d@gmail.com>
Date: Mon, 26 Aug 2024 11:47:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: add plugin API to read guest memory
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240821235607.208622-1-rowanbhart@gmail.com>
 <d134a954-0380-41dc-9e3b-75e1dc2e2bbf@linaro.org>
Content-Language: en-US
From: Rowan Hart <rowanbhart@gmail.com>
In-Reply-To: <d134a954-0380-41dc-9e3b-75e1dc2e2bbf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Alex & Pierrick,

Thank you for the feedback! This is my first contribution to QEMU, so I'm glad
it at least passes the initial smell test :)

> I'll make my comments in this patch, but for v2, please split those individual
> commits, and a cover letter, describing your changes (https://github.com/
> stefanha/git-publish is a great tool if you want to easily push series).

Will do! Mailing list dev is new to me but I will do a practice run to try and
not mess it up.



>> +QEMU_PLUGIN_API
>> +GByteArray *qemu_plugin_read_memory_vaddr(uint64_t addr,
>> +                                          size_t len);
>> +
> 
> IMHO, it would be better to pass the buffer as a parameter, instead of allocating a new one everytime.
> 
> bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *buf, size_t len).

Sure, this makes perfect sense. I considered both and picked wrong so not hard
to change.

>>   /**
>>    * qemu_plugin_read_register() - read register for current vCPU
>>    *
>> diff --git a/plugins/api.c b/plugins/api.c
>> index 2ff13d09de..f210ca166a 100644
>> --- a/plugins/api.c
>> +++ b/plugins/api.c
>> @@ -527,6 +527,27 @@ GArray *qemu_plugin_get_registers(void)
>>       return create_register_handles(regs);
>>   }
>>   +GByteArray *qemu_plugin_read_memory_vaddr(vaddr addr, size_t len)
>> +{
>> +    g_assert(current_cpu);
>> +
>> +    if (len == 0) {
>> +        return NULL;
>> +    }
>> +
>> +    GByteArray *buf = g_byte_array_sized_new(len);
>> +    g_byte_array_set_size(buf, len);
>> +
>> +    int result = cpu_memory_rw_debug(current_cpu, addr, buf->data, buf->len, 0);
>> +
>> +    if (result < 0) {
>> +        g_byte_array_unref(buf);
>> +        return NULL;
>> +    }
>> +
>> +    return buf;
>> +}
>> +
>>   int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
>>   {
>>       g_assert(current_cpu);
>> diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
>> index ca773d8d9f..3ad479a924 100644
>> --- a/plugins/qemu-plugins.symbols
>> +++ b/plugins/qemu-plugins.symbols
>> @@ -20,6 +20,7 @@
>>     qemu_plugin_num_vcpus;
>>     qemu_plugin_outs;
>>     qemu_plugin_path_to_binary;
>> +  qemu_plugin_read_memory_vaddr;
>>     qemu_plugin_read_register;
>>     qemu_plugin_register_atexit_cb;
>>     qemu_plugin_register_flush_cb;
>> diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
>> index b650dddcce..c65d48680b 100644
>> --- a/tests/tcg/plugins/mem.c
>> +++ b/tests/tcg/plugins/mem.c
>> @@ -24,7 +24,7 @@ typedef struct {
>>   static struct qemu_plugin_scoreboard *counts;
>>   static qemu_plugin_u64 mem_count;
>>   static qemu_plugin_u64 io_count;
>> -static bool do_inline, do_callback;
>> +static bool do_inline, do_callback, do_read;
>>   static bool do_haddr;
>>   static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
>>   @@ -58,6 +58,30 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
>>       } else {
>>           qemu_plugin_u64_add(mem_count, cpu_index, 1);
>>       }
>> +
>> +    if (do_read) {
>> +        size_t size = qemu_plugin_mem_size_shift(meminfo);
>> +        GByteArray *data = qemu_plugin_read_memory_vaddr(vaddr, size);
>> +
>> +        if (data) {
>> +            g_autoptr(GString) out = g_string_new("");
>> +
>> +            if (qemu_plugin_mem_is_store(meminfo)) {
>> +                g_string_append(out, "store: ");
>> +            } else {
>> +                g_string_append(out, "load: ");
>> +            }
>> +
>> +            g_string_append_printf(out, "vaddr: 0x%" PRIx64 " data: 0x",
>> +                                   vaddr);
>> +            for (size_t i = 0; i < data->len; i++) {
>> +                g_string_append_printf(out, "%02x", data->data[i]);
>> +            }
>> +            g_string_append(out, "\n");
>> +            qemu_plugin_outs(out->str);
>> +            g_byte_array_free(data, TRUE);
>> +        }
>> +    }
> 
> See other series, merging an API for getting values read on a memory access. It's a better fit to implement this. So I think it's better to drop this plugin modification.

Ok, will drop this one and keep the modification to the syscalls plugin only as
an example of how to use the API.

>>   }
>>     static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>> @@ -86,7 +110,6 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>>                                              const qemu_info_t *info,
>>                                              int argc, char **argv)
>>   {
>> -
>>       for (int i = 0; i < argc; i++) {
>>           char *opt = argv[i];
>>           g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
>> @@ -117,6 +140,11 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>>                   fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
>>                   return -1;
>>               }
>> +        } else if (g_strcmp0(tokens[0], "read") == 0) {
>> +            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &do_read)) {
>> +                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
>> +                return -1;
>> +            }
>>           } else {
>>               fprintf(stderr, "option parsing failed: %s\n", opt);
>>               return -1;
>> @@ -129,6 +157,11 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>>           return -1;
>>       }
>>   +    if (do_read && !do_callback) {
>> +        fprintf(stderr, "can't enable memory reading without callback\n");
>> +        return -1;
>> +    }
>> +
>>       counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
>>       mem_count = qemu_plugin_scoreboard_u64_in_struct(
>>           counts, CPUCount, mem_count);
>> diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
>> index 72e1a5bf90..67c7c404c4 100644
>> --- a/tests/tcg/plugins/syscall.c
>> +++ b/tests/tcg/plugins/syscall.c
>> @@ -22,8 +22,56 @@ typedef struct {
>>       int64_t errors;
>>   } SyscallStats;
>>   +struct SyscallInfo {
>> +    const char *name;
>> +    int64_t write_sysno;
>> +};
>> +
>> +const struct SyscallInfo arch_syscall_info[] = {
>> +    { "aarch64", 64 },
>> +    { "aarch64_be", 64 },
>> +    { "alpha", 4 },
>> +    { "arm", 4 },
>> +    { "armeb", 4 },
>> +    { "avr", -1 },
>> +    { "cris", -1 },
>> +    { "hexagon", 64 },
>> +    { "hppa", -1 },
>> +    { "i386", 4 },
>> +    { "loongarch64", -1 },
>> +    { "m68k", 4 },
>> +    { "microblaze", 4 },
>> +    { "microblazeel", 4 },
>> +    { "mips", 1 },
>> +    { "mips64", 1 },
>> +    { "mips64el", 1 },
>> +    { "mipsel", 1 },
>> +    { "mipsn32", 1 },
>> +    { "mipsn32el", 1 },
>> +    { "or1k", -1 },
>> +    { "ppc", 4 },
>> +    { "ppc64", 4 },
>> +    { "ppc64le", 4 },
>> +    { "riscv32", 64 },
>> +    { "riscv64", 64 },
>> +    { "rx", -1 },
>> +    { "s390x", -1 },
>> +    { "sh4", -1 },
>> +    { "sh4eb", -1 },
>> +    { "sparc", 4 },
>> +    { "sparc32plus", 4 },
>> +    { "sparc64", 4 },
>> +    { "tricore", -1 },
>> +    { "x86_64", 1 },
>> +    { "xtensa", 13 },
>> +    { "xtensaeb", 13 },
>> +    { NULL, -1 },
>> +};
>> +
>>   static GMutex lock;
>>   static GHashTable *statistics;
>> +static bool do_log_writes;
>> +static int64_t write_sysno = -1;
>>     static SyscallStats *get_or_create_entry(int64_t num)
>>   {
>> @@ -54,6 +102,51 @@ static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_index,
>>           g_autofree gchar *out = g_strdup_printf("syscall #%" PRIi64 "\n", num);
>>           qemu_plugin_outs(out);
>>       }
>> +
>> +    if (do_log_writes && num == write_sysno) {
>> +        GByteArray *data = qemu_plugin_read_memory_vaddr(a2, a3);
>> +
>> +        g_autoptr(GString) out = g_string_new("");
>> +
>> +        size_t rows = (data->len % 16 == 0)
>> +            ? (data->len / 16)
>> +            : ((data->len / 16) + 1);
>> +        for (size_t row = 0; row < rows; row++) {
>> +            size_t len = (rows != data->len / 16 && row == rows - 1)
>> +                ? (data->len % 16)
>> +                : 16;
>> +            for (size_t i = 0; i < len; i++) {
>> +                g_string_append_printf(out, "%02x ",
>> +                    data->data[(row * 16) + i]);
>> +                if (i != 0 && i % 4 == 0) {
>> +                    g_string_append(out, " ");
>> +                }
>> +            }
>> +            for (size_t i = len; i < 16; i++) {
>> +                g_string_append(out, "   ");
>> +                if (i != 0 && i % 4 == 0) {
>> +                    g_string_append(out, " ");
>> +                }
>> +            }
>> +            g_string_append(out, " | ");
>> +            for (size_t i = 0; i < len; i++) {
>> +                g_string_append_printf(out,
>> +                    (data->data[(row * 16) + i] >= 0x21
>> +                        && data->data[(row * 16) + i] <= 0x7e)
>> +                    ? "%c"
>> +                    : ".", data->data[(row * 16) + i]);
>> +                if (i != 0 && i % 4 == 0) {
>> +                    g_string_append(out, " ");
>> +                }
>> +            }
>> +            g_string_append(out, "\n");
>> +        }
> 
> Could you add a comment to show what is expected format? From the code, with all these loops and ternary expressions, it's not easy to follow. 

Indeed. I will just generally simplify this

Thanks!

-Rowan

