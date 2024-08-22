Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F942C5320E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 20:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shEUx-00050E-BU; Thu, 22 Aug 2024 16:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1shEUs-0004zg-6F
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 16:33:30 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1shEUp-0001nE-DH
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 16:33:29 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2021537a8e6so11758145ad.2
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 13:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724358805; x=1724963605; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F/Y9UJez5Sdh+DpJLXtESStWqGu84u4tSgjv1tBBda0=;
 b=krRtR9droeDl60hW7I4n3ZAKu8m0hlWPWl4VR+G92q+FSQ0/e0sRvNItJNoy9BDsiE
 Lq1tcl5zi9yPxZHquygnFGLocy9/bquy3hjUyLB5Ry3TJ8iaLWCgPpGt4OEDQELiQsEr
 71uZQrMBmiOFckxynfuiBKBZyT/ityMBXDxap2TBvErMC8UNZxS28VEP06owr99IiC9x
 iYgFmNtZ3AkkbL+KVgmrRA/tYY7Cu1K4LuQxS8o7YKORtWEbyupEUixB3JxHlrEqYf0Q
 e73e1GQWjHd2qqeEO/1knHd5gKP7m4guRfjFzpFsfktRUEJz7PGIueRQlu0a4LyMA4X0
 l3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724358805; x=1724963605;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F/Y9UJez5Sdh+DpJLXtESStWqGu84u4tSgjv1tBBda0=;
 b=riiaF9kJcW5kgKS987uqCa+A4NAdL4W5a/0x8iTODCGrEj5Mxd0t3ki4Uiq6cW9qia
 k9h5B55K2RUMsVKogI4Rw0F++7NUlwlndPhSZYdzt4Vr1dthSsFltn29zM8KvNe1T4yE
 Gwa5uitYb0ZiLqvUfAeSg5KpaIGt1W6gRJCzxSn5xA01RQKGCuvyGfXwxN3GqxtU8+Ye
 VtUF3PwUdR8wXhgFpCbQwp0g+UPu+9Wr0yWPRGRtfg16xltMpiSqLHQM0sJ5CYCRH6jl
 sxXXwjTVk3Cgm6ASXMbCIP7sZtkIGlY2POVQM1F6c4Ym/ds95R2yWuIOtJmKfgvgIkY7
 u8wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkyVIRzhLu/Nn29C/R1H1FBPPD07APA1zA8keaVM/JDBgp33yhiBWYFBhA2m3KXnHc9PmDYkB4O6ah@nongnu.org
X-Gm-Message-State: AOJu0Yw0V8JSa5GY+I6BqNnAgdDmJ+6eq9gVEbsMpZsrMTIaCXDiQykD
 /dpZqvDsV5Y6gn8NDaJzstjSFGDnkJA/iq3lo7QjE41MsQjBhdnHWQWflZVyZNg=
X-Google-Smtp-Source: AGHT+IHP5oZD9CeWgBiJWrUBAj+1QfVkkctRNJrqSV2yu9Rj75Yx/JnYJ0gFHrp4oiavqVF2BwQk8Q==
X-Received: by 2002:a17:903:2442:b0:202:562c:f3c7 with SMTP id
 d9443c01a7336-20367d329b2mr94162275ad.10.1724358804803; 
 Thu, 22 Aug 2024 13:33:24 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::27bd? ([2604:3d08:9384:1d00::27bd])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20385608eb5sm16507215ad.188.2024.08.22.13.33.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 13:33:24 -0700 (PDT)
Message-ID: <d134a954-0380-41dc-9e3b-75e1dc2e2bbf@linaro.org>
Date: Thu, 22 Aug 2024 13:33:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: add plugin API to read guest memory
Content-Language: en-US
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240821235607.208622-1-rowanbhart@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240821235607.208622-1-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

Hi Rowan, thanks for your contribution.

To give some context on the answer, we are currently working to add a 
similar "read_memory" API, but associated to memory callbacks for 
plugins 
(https://lore.kernel.org/qemu-devel/20240724194708.1843704-1-pierrick.bouvier@linaro.org/T/#t).

A key aspect of what you propose here, is that the memory may have 
changed during the write time, and when you read it, while what we 
propose guarantees to track every change correctly.

It's not a bad thing, and both API are definitely complementary. When 
talking to Alex, he was keen to add a global read_memory API (like you 
propose), after we merge the first one.

@Alex: any thought on this?

Regarding your patch, it would be much easier if you could split that in 
different commits. Adding API first, then modify each plugin in a 
different commit. This way, it would be easier to review. I'll make my 
comments in this patch, but for v2, please split those individual 
commits, and a cover letter, describing your changes 
(https://github.com/stefanha/git-publish is a great tool if you want to 
easily push series).

On 8/21/24 16:56, Rowan Hart wrote:
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> ---
>   docs/about/emulation.rst     |  16 ++++-
>   include/qemu/qemu-plugin.h   |  24 +++++++-
>   plugins/api.c                |  21 +++++++
>   plugins/qemu-plugins.symbols |   1 +
>   tests/tcg/plugins/mem.c      |  37 +++++++++++-
>   tests/tcg/plugins/syscall.c  | 113 +++++++++++++++++++++++++++++++++++
>   6 files changed, 208 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
> index eea1261baa..9c68e37887 100644
> --- a/docs/about/emulation.rst
> +++ b/docs/about/emulation.rst
> @@ -354,6 +354,8 @@ Behaviour can be tweaked with the following arguments:
>       - Use callbacks on each memory instrumentation.
>     * - hwaddr=true|false
>       - Count IO accesses (only for system emulation)
> +  * - read=true|false
> +    - Read the memory content of each access and display it
>   
>   System Calls
>   ............
> @@ -388,6 +390,19 @@ run::
>     160          1      0
>     135          1      0
>   
> +Behaviour can be tweaked with the following arguments:
> +
> +.. list-table:: Syscall plugin arguments
> +  :widths: 20 80
> +  :header-rows: 1
> +
> +  * - Option
> +    - Description
> +  * - print=true|false
> +    - Print the number of times each syscall is called
> +  * - log_writes=true|false
> +    - Log the buffer of each write syscall in hexdump format
> +
>   Test inline operations
>   ......................
>   
> @@ -777,4 +792,3 @@ Other emulation features
>   When running system emulation you can also enable deterministic
>   execution which allows for repeatable record/replay debugging. See
>   :ref:`Record/Replay<replay>` for more details.
> -
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index c71c705b69..d4ec73574b 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -57,11 +57,19 @@ typedef uint64_t qemu_plugin_id_t;
>    * - Remove qemu_plugin_register_vcpu_{tb, insn, mem}_exec_inline.
>    *   Those functions are replaced by *_per_vcpu variants, which guarantee
>    *   thread-safety for operations.
> + *
> + * version 3:
> + * - modified arguments and return value of qemu_plugin_insn_data to copy
> + *   the data into a user-provided buffer instead of returning a pointer
> + *   to the data.
> + *

Is it a change left on your side, or a bad diff?

> + * version 4:
> + * - added qemu_plugin_read_memory_vaddr
>    */
>   
>   extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
>   
> -#define QEMU_PLUGIN_VERSION 3
> +#define QEMU_PLUGIN_VERSION 4
>   
>   /**
>    * struct qemu_info_t - system information for plugins
> @@ -852,6 +860,20 @@ typedef struct {
>   QEMU_PLUGIN_API
>   GArray *qemu_plugin_get_registers(void);
>   
> +/**
> + * qemu_plugin_read_memory_vaddr() - read from memory using a virtual address
> + *
> + * @addr: A virtual address to read from
> + * @len: The number of bytes to read, starting from @addr
> + *
> + * Returns a GByteArray with the read memory. Ownership of the GByteArray is
> + * transferred to the caller, which is responsible for deallocating it after
> + * use. On failure returns NULL.
> + */
> +QEMU_PLUGIN_API
> +GByteArray *qemu_plugin_read_memory_vaddr(uint64_t addr,
> +                                          size_t len);
> +

IMHO, it would be better to pass the buffer as a parameter, instead of 
allocating a new one everytime.

bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *buf, 
size_t len).

>   /**
>    * qemu_plugin_read_register() - read register for current vCPU
>    *
> diff --git a/plugins/api.c b/plugins/api.c
> index 2ff13d09de..f210ca166a 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -527,6 +527,27 @@ GArray *qemu_plugin_get_registers(void)
>       return create_register_handles(regs);
>   }
>   
> +GByteArray *qemu_plugin_read_memory_vaddr(vaddr addr, size_t len)
> +{
> +    g_assert(current_cpu);
> +
> +    if (len == 0) {
> +        return NULL;
> +    }
> +
> +    GByteArray *buf = g_byte_array_sized_new(len);
> +    g_byte_array_set_size(buf, len);
> +
> +    int result = cpu_memory_rw_debug(current_cpu, addr, buf->data, buf->len, 0);
> +
> +    if (result < 0) {
> +        g_byte_array_unref(buf);
> +        return NULL;
> +    }
> +
> +    return buf;
> +}
> +
>   int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
>   {
>       g_assert(current_cpu);
> diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
> index ca773d8d9f..3ad479a924 100644
> --- a/plugins/qemu-plugins.symbols
> +++ b/plugins/qemu-plugins.symbols
> @@ -20,6 +20,7 @@
>     qemu_plugin_num_vcpus;
>     qemu_plugin_outs;
>     qemu_plugin_path_to_binary;
> +  qemu_plugin_read_memory_vaddr;
>     qemu_plugin_read_register;
>     qemu_plugin_register_atexit_cb;
>     qemu_plugin_register_flush_cb;
> diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
> index b650dddcce..c65d48680b 100644
> --- a/tests/tcg/plugins/mem.c
> +++ b/tests/tcg/plugins/mem.c
> @@ -24,7 +24,7 @@ typedef struct {
>   static struct qemu_plugin_scoreboard *counts;
>   static qemu_plugin_u64 mem_count;
>   static qemu_plugin_u64 io_count;
> -static bool do_inline, do_callback;
> +static bool do_inline, do_callback, do_read;
>   static bool do_haddr;
>   static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
>   
> @@ -58,6 +58,30 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
>       } else {
>           qemu_plugin_u64_add(mem_count, cpu_index, 1);
>       }
> +
> +    if (do_read) {
> +        size_t size = qemu_plugin_mem_size_shift(meminfo);
> +        GByteArray *data = qemu_plugin_read_memory_vaddr(vaddr, size);
> +
> +        if (data) {
> +            g_autoptr(GString) out = g_string_new("");
> +
> +            if (qemu_plugin_mem_is_store(meminfo)) {
> +                g_string_append(out, "store: ");
> +            } else {
> +                g_string_append(out, "load: ");
> +            }
> +
> +            g_string_append_printf(out, "vaddr: 0x%" PRIx64 " data: 0x",
> +                                   vaddr);
> +            for (size_t i = 0; i < data->len; i++) {
> +                g_string_append_printf(out, "%02x", data->data[i]);
> +            }
> +            g_string_append(out, "\n");
> +            qemu_plugin_outs(out->str);
> +            g_byte_array_free(data, TRUE);
> +        }
> +    }

See other series, merging an API for getting values read on a memory 
access. It's a better fit to implement this. So I think it's better to 
drop this plugin modification.

>   }
>   
>   static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> @@ -86,7 +110,6 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>                                              const qemu_info_t *info,
>                                              int argc, char **argv)
>   {
> -
>       for (int i = 0; i < argc; i++) {
>           char *opt = argv[i];
>           g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
> @@ -117,6 +140,11 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>                   fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
>                   return -1;
>               }
> +        } else if (g_strcmp0(tokens[0], "read") == 0) {
> +            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &do_read)) {
> +                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
> +                return -1;
> +            }
>           } else {
>               fprintf(stderr, "option parsing failed: %s\n", opt);
>               return -1;
> @@ -129,6 +157,11 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>           return -1;
>       }
>   
> +    if (do_read && !do_callback) {
> +        fprintf(stderr, "can't enable memory reading without callback\n");
> +        return -1;
> +    }
> +
>       counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
>       mem_count = qemu_plugin_scoreboard_u64_in_struct(
>           counts, CPUCount, mem_count);
> diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
> index 72e1a5bf90..67c7c404c4 100644
> --- a/tests/tcg/plugins/syscall.c
> +++ b/tests/tcg/plugins/syscall.c
> @@ -22,8 +22,56 @@ typedef struct {
>       int64_t errors;
>   } SyscallStats;
>   
> +struct SyscallInfo {
> +    const char *name;
> +    int64_t write_sysno;
> +};
> +
> +const struct SyscallInfo arch_syscall_info[] = {
> +    { "aarch64", 64 },
> +    { "aarch64_be", 64 },
> +    { "alpha", 4 },
> +    { "arm", 4 },
> +    { "armeb", 4 },
> +    { "avr", -1 },
> +    { "cris", -1 },
> +    { "hexagon", 64 },
> +    { "hppa", -1 },
> +    { "i386", 4 },
> +    { "loongarch64", -1 },
> +    { "m68k", 4 },
> +    { "microblaze", 4 },
> +    { "microblazeel", 4 },
> +    { "mips", 1 },
> +    { "mips64", 1 },
> +    { "mips64el", 1 },
> +    { "mipsel", 1 },
> +    { "mipsn32", 1 },
> +    { "mipsn32el", 1 },
> +    { "or1k", -1 },
> +    { "ppc", 4 },
> +    { "ppc64", 4 },
> +    { "ppc64le", 4 },
> +    { "riscv32", 64 },
> +    { "riscv64", 64 },
> +    { "rx", -1 },
> +    { "s390x", -1 },
> +    { "sh4", -1 },
> +    { "sh4eb", -1 },
> +    { "sparc", 4 },
> +    { "sparc32plus", 4 },
> +    { "sparc64", 4 },
> +    { "tricore", -1 },
> +    { "x86_64", 1 },
> +    { "xtensa", 13 },
> +    { "xtensaeb", 13 },
> +    { NULL, -1 },
> +};
> +
>   static GMutex lock;
>   static GHashTable *statistics;
> +static bool do_log_writes;
> +static int64_t write_sysno = -1;
>   
>   static SyscallStats *get_or_create_entry(int64_t num)
>   {
> @@ -54,6 +102,51 @@ static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_index,
>           g_autofree gchar *out = g_strdup_printf("syscall #%" PRIi64 "\n", num);
>           qemu_plugin_outs(out);
>       }
> +
> +    if (do_log_writes && num == write_sysno) {
> +        GByteArray *data = qemu_plugin_read_memory_vaddr(a2, a3);
> +
> +        g_autoptr(GString) out = g_string_new("");
> +
> +        size_t rows = (data->len % 16 == 0)
> +            ? (data->len / 16)
> +            : ((data->len / 16) + 1);
> +        for (size_t row = 0; row < rows; row++) {
> +            size_t len = (rows != data->len / 16 && row == rows - 1)
> +                ? (data->len % 16)
> +                : 16;
> +            for (size_t i = 0; i < len; i++) {
> +                g_string_append_printf(out, "%02x ",
> +                    data->data[(row * 16) + i]);
> +                if (i != 0 && i % 4 == 0) {
> +                    g_string_append(out, " ");
> +                }
> +            }
> +            for (size_t i = len; i < 16; i++) {
> +                g_string_append(out, "   ");
> +                if (i != 0 && i % 4 == 0) {
> +                    g_string_append(out, " ");
> +                }
> +            }
> +            g_string_append(out, " | ");
> +            for (size_t i = 0; i < len; i++) {
> +                g_string_append_printf(out,
> +                    (data->data[(row * 16) + i] >= 0x21
> +                        && data->data[(row * 16) + i] <= 0x7e)
> +                    ? "%c"
> +                    : ".", data->data[(row * 16) + i]);
> +                if (i != 0 && i % 4 == 0) {
> +                    g_string_append(out, " ");
> +                }
> +            }
> +            g_string_append(out, "\n");
> +        }

Could you add a comment to show what is expected format? From the code, 
with all these loops and ternary expressions, it's not easy to follow.

> +
> +
> +        qemu_plugin_outs(out->str);
> +
> +        g_byte_array_free(data, TRUE);
> +    }
>   }
>   
>   static void vcpu_syscall_ret(qemu_plugin_id_t id, unsigned int vcpu_idx,
> @@ -127,6 +220,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>               if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &do_print)) {
>                   fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
>               }
> +        } else if (g_strcmp0(tokens[0], "log_writes") == 0) {
> +            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &do_log_writes)) {
> +                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
> +            }
>           } else {
>               fprintf(stderr, "unsupported argument: %s\n", argv[i]);
>               return -1;
> @@ -137,6 +234,22 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>           statistics = g_hash_table_new_full(NULL, g_direct_equal, NULL, g_free);
>       }
>   
> +    if (do_log_writes) {
> +        for (const struct SyscallInfo *syscall_info = arch_syscall_info;
> +            syscall_info->name != NULL; syscall_info++) {
> +
> +            if (g_strcmp0(syscall_info->name, info->target_name) == 0) {
> +                write_sysno = syscall_info->write_sysno;
> +                break;
> +            }
> +        }
> +
> +        if (write_sysno == -1) {
> +            fprintf(stderr, "write syscall number not found\n");
> +            return -1;
> +        }
> +    }
> +

It's good! I appreciate to see this feature.

>       qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
>       qemu_plugin_register_vcpu_syscall_ret_cb(id, vcpu_syscall_ret);
>       qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);

Thanks,
Pierrick

