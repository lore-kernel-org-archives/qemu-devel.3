Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC97C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 19:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdx4E-0005Rz-O7; Tue, 13 Aug 2024 15:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sdx4D-0005Qi-EX
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 15:20:25 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sdx49-0005VT-6d
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 15:20:24 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2cd48ad7f0dso4564139a91.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 12:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723576818; x=1724181618; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SOh16Quk6/Pm1j/gqQahPtMUhaFdvygWljkCsUQRves=;
 b=NHb1zwlV5tVfiydiB+cXJopFwleFZ455D+Fum5+QKQpNrHl5APIZhgA8ifAXSVrKqq
 pwqqVpRb6eTqtzcL99pUOfrSADlsOJqmwvjLCOcZ320iuK5w8sb11P9KC7YKG/WoTgYO
 4i8lcIDVqmKULoUZuobCtIx5b/EhsBRY8TXDEqlPLriizhAZgqps9W23/tlXBt8DtrtZ
 TosaqPti8oQKD37731lgrzVPYLLGUb1I9sE9rQxXhuqnEp4CMhtqZ9FI5mfqe4FvnLsT
 PJMoxCa+px8nDUYsqpMNVLAht3faKSos93ezTwV0D2+5zuJsMz3WFNRtG8RSq5Anw+Ox
 f3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723576818; x=1724181618;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SOh16Quk6/Pm1j/gqQahPtMUhaFdvygWljkCsUQRves=;
 b=LtQ13kVzElwzKhfWFcU5nc9hdTltds0VO/3ruyvnpoWEFxOPLMygyQcPEBUn3LhSER
 MCThqbKzw/Tbm500yJcm8kXBc2S8Bn4rtCPivXlJ7iK2dg2E3ZJSBC7T+AXkmlbEKms7
 99WXlNpnHr1ws4zTFwBPzR1y4Jm8GcwMrRgiMS4klPqVAh5oWOXV8aWylGL/9mwE/R5c
 H5qAjHtpGX9k8s2ASCa+5tBnoCfChvniBu/Ui6z1BL2fXUVb2owp1xXoGBjON8IY03+i
 jPgBoVdE4PeE0UPDXFqrJRJFWDGTqCgynpgKdLJ+oClvE1YqPIAUwRZvWoseZUxxe2eR
 oYgA==
X-Gm-Message-State: AOJu0YzMFVL3/8ZBF3gZwyZFmF7u/yQL2VMpaKKIPRyCVWgZwDenCCnc
 qLIDowqyaQxXxgOP1kL0fK+dK3PRg0Zqf8XuU+37WIjTcwzLBBwIv3eLe7NTZ0A=
X-Google-Smtp-Source: AGHT+IFXqD1rTtILueFC/LmoX9ixOuarH4vFgKgdikcGI/ROFtpxoRaB1J/hXOxbm+6dOhFilwy6eg==
X-Received: by 2002:a17:90a:bb8b:b0:2c5:32c3:a777 with SMTP id
 98e67ed59e1d1-2d3aab4f168mr621014a91.28.1723576817550; 
 Tue, 13 Aug 2024 12:20:17 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00:5b09:8db7:b002:cf61?
 ([2604:3d08:9384:1d00:5b09:8db7:b002:cf61])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1c9c5e65asm11112480a91.4.2024.08.13.12.20.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 12:20:17 -0700 (PDT)
Message-ID: <0e0ee7a5-f8e4-44f0-83d9-918b0ef71396@linaro.org>
Date: Tue, 13 Aug 2024 12:20:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins: Add a plugin to generate basic block
 vectors
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Cc: qemu-devel@nongnu.org, Yotaro Nada <yotaro.nada@gmail.com>
References: <20240813-bb-v1-1-effbb77daebf@daynix.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240813-bb-v1-1-effbb77daebf@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, URI_DOTEDU=1 autolearn=no autolearn_force=no
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

Hi Akihiko, and thanks for contributing this new plugin.

Recently, plugins documentation has been modified, and list of plugins 
and their doc is now in "docs/about/emulation.rst". You may want to 
rebase on top of master.

Globally, I'm ok with this plugin and the implementation. Just a few 
fixes are needed for concurrent accesses.

On 8/12/24 23:46, Akihiko Odaki wrote:
> SimPoint is a widely used tool to find the ideal microarchitecture
> simulation points so Valgrind[2] and Pin[3] support generating basic
> block vectors for use with them. Let's add a corresponding plugin to
> QEMU too.
> 
> Note that this plugin has a different goal with tests/plugin/bb.c.
> 
> This plugin creates a vector for each constant interval instead of
> counting the execution of basic blocks for the entire run and able to
> describe the change of execution behavior. Its output is also
> syntactically simple and better suited for parsing, while the output of
> tests/plugin/bb.c is more human-readable.
> 

I think it can be confusing to have two plugins named bb. How about 
simpoint, or bbv?

> [1] https://cseweb.ucsd.edu/~calder/simpoint/
> [2] https://valgrind.org/docs/manual/bbv-manual.html
> [3] https://www.intel.com/content/www/us/en/developer/articles/tool/pin-a-dynamic-binary-instrumentation-tool.html
> 
> Signed-off-by: Yotaro Nada <yotaro.nada@gmail.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   docs/devel/tcg-plugins.rst |  20 ++++++
>   contrib/plugins/bb.c       | 153 +++++++++++++++++++++++++++++++++++++++++++++
>   contrib/plugins/Makefile   |   1 +
>   3 files changed, 174 insertions(+)
> 
> diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
> index 9cc09d8c3da1..2859eecc13b9 100644
> --- a/docs/devel/tcg-plugins.rst
> +++ b/docs/devel/tcg-plugins.rst
> @@ -332,6 +332,26 @@ run::
>     160          1      0
>     135          1      0
>   
> +- contrib/plugins/bb.c
> +
> +The bb plugin allows you to generates basic block vectors for use with the
> +`SimPoint <https://cseweb.ucsd.edu/~calder/simpoint/>`__ analysis tool.
> +
> +It has two options, ``interval`` and ``outfile``. ``interval`` specifies the
> +interval to generate a basic block vector by the number of instructions. It is
> +optional, and its default value is 100000000. ``outfile`` is the path to
> +output files, and it will be suffixed with ``.N.bb`` where ``N`` is a vCPU
> +index.
> +
> +Example::
> +
> +  $ qemu-aarch64 \
> +    -plugin contrib/plugins/libb.so,interval=100,outfile=sha1 \
> +    tests/tcg/aarch64-linux-user/sha1
> +  SHA1=15dd99a1991e0b3826fede3deffc1feba42278e6
> +  $ du sha1.0.bb
> +  23128   sha1.0.bb
> +
>   - contrib/plugins/hotblocks.c
>   
>   The hotblocks plugin allows you to examine the where hot paths of
> diff --git a/contrib/plugins/bb.c b/contrib/plugins/bb.c
> new file mode 100644
> index 000000000000..4f1266d07ff5
> --- /dev/null
> +++ b/contrib/plugins/bb.c
> @@ -0,0 +1,153 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +

A brief summary and the link to simpoint page can be added as a comment 
here.

> +#include <stdio.h>
> +#include <glib.h>
> +
> +#include <qemu-plugin.h>
> +
> +typedef struct Bb {
> +    struct qemu_plugin_scoreboard *count;
> +    unsigned int index;
> +} Bb;
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
> +static GHashTable *bbs;
> +static GPtrArray *files;
> +static char *filename;
> +static struct qemu_plugin_scoreboard *count;
> +static uint64_t interval = 100000000;
> +
> +static void plugin_exit(qemu_plugin_id_t id, void *p)
> +{
> +    g_hash_table_unref(bbs);
> +    g_ptr_array_unref(files);
> +    g_free(filename);
> +    qemu_plugin_scoreboard_free(count);
> +}
> +
> +static void free_bb(void *data)
> +{
> +    qemu_plugin_scoreboard_free(((Bb *)data)->count);
> +    g_free(data);
> +}
> +
> +static void free_file(void *data)
> +{
> +    fclose(data);
> +}
> + > +static directly count_u64(void)
> +{
> +    return qemu_plugin_scoreboard_u64(count);
> +}
> +
> +static qemu_plugin_u64 bb_count_u64(Bb *bb)
> +{
> +    return qemu_plugin_scoreboard_u64(bb->count);
> +}
> +
> +static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
> +{
> +    g_autofree gchar *vcpu_filename = NULL;
> +
> +    if (vcpu_index >= files->len) {
> +        g_ptr_array_set_size(files, vcpu_index + 1);
> +    } else if (g_ptr_array_index(files, vcpu_index)) {
> +        return;
> +    }
> +

You need a lock for files array for expansion/access.

> +    vcpu_filename = g_strdup_printf("%s.%u.bb", filename, vcpu_index);
> +    g_ptr_array_index(files, vcpu_index) = fopen(vcpu_filename, "w");
> +}
> +
> +static void vcpu_tb_exec(unsigned int vcpu_index, void *udata)

vcpu_tb_exec is a confusing name, as it is called when interval of insn 
is executed. vcpu_interval_exec would be more clear.

> +{
> +    FILE *file = g_ptr_array_index(files, vcpu_index);

Need lock when accessing this array.

> +    uint64_t count = qemu_plugin_u64_get(count_u64(), vcpu_index) - interval;
> +    GHashTableIter iter;
> +    void *value;
> +
> +    if (!file) {
> +        return;
> +    }
> +
> +    qemu_plugin_u64_set(count_u64(), vcpu_index, count);
> + > +    fputc('T', file);

Maybe you can add a comment with a link to 
https://valgrind.org/docs/manual/bbv-manual.html at this point. It's 
already mentioned in the commit message, but IMHO, it's convenient to 
have it here, so we know which data is written exactly.

> +
> +    g_hash_table_iter_init(&iter, bbs);
> +
The access to this hashtable should be under a dedicated lock.

> +    while (g_hash_table_iter_next(&iter, NULL, &value)) {
> +        Bb *bb = value;
> +        uint64_t bb_count = qemu_plugin_u64_get(bb_count_u64(bb), vcpu_index);
> +
> +        if (!bb_count) {
> +            continue;
> +        }
> +
> +        fprintf(file, ":%u:%" PRIu64 " ", bb->index, bb_count);
> +        qemu_plugin_u64_set(bb_count_u64(bb), vcpu_index, 0);
> +    }
> +
> +    fputc('\n', file);
> +}
> +
> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> +{
> +    uint64_t n_insns = qemu_plugin_tb_n_insns(tb);
> +    uint64_t vaddr = qemu_plugin_tb_vaddr(tb);

Need lock for hashtable access.

> +    Bb *bb = g_hash_table_lookup(bbs, &vaddr);
> +
> +    if (!bb) {
> +        uint64_t *key = g_new(uint64_t, 1);
> +
> +        *key = vaddr;
> +        bb = g_new(Bb, 1);
> +        g_hash_table_insert(bbs, key, bb);
> +        bb->count = qemu_plugin_scoreboard_new(sizeof(uint64_t));
> +        bb->index = g_hash_table_size(bbs);
> +    }
> +
> +    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
> +        tb, QEMU_PLUGIN_INLINE_ADD_U64, count_u64(), n_insns);
> +
> +    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
> +        tb, QEMU_PLUGIN_INLINE_ADD_U64, bb_count_u64(bb), n_insns);
> +
> +    qemu_plugin_register_vcpu_tb_exec_cond_cb(
> +        tb, vcpu_tb_exec, QEMU_PLUGIN_CB_NO_REGS,
> +        QEMU_PLUGIN_COND_GE, count_u64(), interval, NULL);
> +}
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> +                                           const qemu_info_t *info,
> +                                           int argc, char **argv)
> +{
> +    for (int i = 0; i < argc; i++) {
> +        char *opt = argv[i];
> +        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
> +        if (g_strcmp0(tokens[0], "interval") == 0) {
> +            interval = g_ascii_strtoull(tokens[1], NULL, 10);
> +        } else if (g_strcmp0(tokens[0], "outfile") == 0) {
> +            filename = tokens[1];
> +            tokens[1] = NULL;
> +        } else {
> +            fprintf(stderr, "option parsing failed: %s\n", opt);
> +            return -1;
> +        }
> +    }
> +
> +    if (!filename) {
> +        fputs("outfile unspecified\n", stderr);
> +        return -1;
> +    }
> +
> +    bbs = g_hash_table_new_full(g_int64_hash, g_int64_equal, g_free, free_bb);
> +    files = g_ptr_array_new_with_free_func(free_file);
> +    count = qemu_plugin_scoreboard_new(sizeof(uint64_t));
> +    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> +    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
> +
> +    return 0;
> +}
> diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
> index 0b64d2c1e3a9..14bc88bb4f86 100644
> --- a/contrib/plugins/Makefile
> +++ b/contrib/plugins/Makefile
> @@ -13,6 +13,7 @@ TOP_SRC_PATH = $(SRC_PATH)/../..
>   VPATH += $(SRC_PATH)
>   
>   NAMES :=
> +NAMES += bb
>   NAMES += execlog
>   NAMES += hotblocks
>   NAMES += hotpages
> 
> ---
> base-commit: 74abb45dac6979e7ff76172b7f0a24e869405184
> change-id: 20240618-bb-93387ddf765b
> 
> Best regards,

Regards,
Pierrick

