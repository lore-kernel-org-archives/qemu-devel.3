Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C41C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 05:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seTLt-00062W-Fq; Thu, 15 Aug 2024 01:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seTLr-000620-Qw
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 01:48:47 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seTLp-0005Xj-OH
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 01:48:47 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fd90c2fc68so5166025ad.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 22:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723700923; x=1724305723; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OuLdahOjWQIKsaFAaipb1noSJ/Jc/C34rzmpT8uX43I=;
 b=w3TO4hLvdnEUPrtlsaY9WvdCCIUpxf5gZUykGVF0h7n0penaF+UWyWUGx2ezYYstDT
 xjg2vEU7kAD/m5bcsTuKV0KuJOW5Oo9jVVvCg5VxdfWloTzB+Pdb+2B1jIU8QiGzlNsh
 P7O0iaxMGyc+v6YemeMDgON2Y6lJ8wpS/DUYzqngAk1SjxXcNA+qCqpzHceT4wxAnaEJ
 Wxnkm6BC51u7rnw50hrFYGcahYoTYpVaqyIpq8ttcnyE7ZCeMIYStQuDYTvJ7tBNLMtY
 imiTI7h4e2JfO+WhyQrNFoMH+2zpRSBVCVamP1ltxvh6Wfai74jVe2yM4o7muMoP4qhA
 DIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723700923; x=1724305723;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OuLdahOjWQIKsaFAaipb1noSJ/Jc/C34rzmpT8uX43I=;
 b=QvClYO/PUmobYJeg8zwHRcumVDRrLQ95FJufxWEhfLpoUumlTlvQl3o7eED87+NHDh
 hgJzuzcjeEK4qMl1XnprZ3nDgfqjpwdusUa5KjpaEZsd+s60gjbx4+JQyvLoO2Md7rIC
 5FP3rU2z1E3IHCwC/HVQ2YO3bnu3HDrJQkHKkairSRT2aJHuhgGKpqDH9s5lIbdvw6Un
 IxN56Bx31s0AVu8iqLdZopeokT6h5/twmNPe3bMsVqj0Rkcf3BU8oo5bHtM29Y4Gi0eF
 jfvbtzxFpsGp2p8UO5GhYs26QnQYfbBWPQ/YKAXg8Io2o0Me4AWIBqYwhTtzbAfvFowo
 q5kQ==
X-Gm-Message-State: AOJu0YyCXJNh81Q5IO8E2avbyWITpOfm4V1ivJgASI005HIMMvYJheCT
 QXB4WMaBPg5sNZXUWY7hpiI99F8Vdl84UP09dn0AVHa0NtPCMkZSkjqEo0t4qAU=
X-Google-Smtp-Source: AGHT+IEhWcjifEksXcctgGwcosuCx52q40jJpVAhcXxSBUV0D0EP7RCA8OzkrqLcgy5RzhQgOMkoKA==
X-Received: by 2002:a17:903:1c1:b0:1fd:9a23:90cc with SMTP id
 d9443c01a7336-201d63bfe84mr56872255ad.26.1723700923089; 
 Wed, 14 Aug 2024 22:48:43 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f031c63asm4784385ad.111.2024.08.14.22.48.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 22:48:42 -0700 (PDT)
Message-ID: <8e027dfd-4fa7-4eab-852a-6f9d649c4b53@linaro.org>
Date: Wed, 14 Aug 2024 22:48:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] contrib/plugins: Add a plugin to generate basic block
 vectors
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
References: <20240815-bb-v2-1-6222ee98297b@daynix.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240815-bb-v2-1-6222ee98297b@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 8/14/24 20:04, Akihiko Odaki wrote:
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
> [1] https://cseweb.ucsd.edu/~calder/simpoint/
> [2] https://valgrind.org/docs/manual/bbv-manual.html
> [3] https://www.intel.com/content/www/us/en/developer/articles/tool/pin-a-dynamic-binary-instrumentation-tool.html
> 
> Signed-off-by: Yotaro Nada <yotaro.nada@gmail.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v2:
> - Merged files variable into the global scoreboard.
> - Added a lock for bbs.
> - Added a summary to contrib/plugins/bbv.c.
> - Rebased.
> - Link to v1: https://lore.kernel.org/r/20240813-bb-v1-1-effbb77daebf@daynix.com
> ---
>   docs/about/emulation.rst |  30 +++++++++
>   contrib/plugins/bbv.c    | 158 +++++++++++++++++++++++++++++++++++++++++++++++
>   contrib/plugins/Makefile |   1 +
>   3 files changed, 189 insertions(+)
> 
> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
> index c03033e4e956..72d7846ab6f8 100644
> --- a/docs/about/emulation.rst
> +++ b/docs/about/emulation.rst
> @@ -381,6 +381,36 @@ run::
>     160          1      0
>     135          1      0
>   
> +Basic Block Vectors
> +...................
> +
> +``contrib/plugins/bbv.c``
> +
> +The bbv plugin allows you to generate basic block vectors for use with the
> +`SimPoint <https://cseweb.ucsd.edu/~calder/simpoint/>`__ analysis tool.
> +
> +.. list-table:: Basic block vectors arguments
> +  :widths: 20 80
> +  :header-rows: 1
> +
> +  * - Option
> +    - Description
> +  * - interval=N
> +    - The interval to generate a basic block vector specified by the number of
> +      instructions (Default: N = 100000000)
> +  * - outfile=PATH
> +    - The path to output files.
> +      It will be suffixed with ``.N.bb`` where ``N`` is a vCPU index.
> +
> +Example::
> +
> +  $ qemu-aarch64 \
> +    -plugin contrib/plugins/libbbv.so,interval=100,outfile=sha1 \
> +    tests/tcg/aarch64-linux-user/sha1
> +  SHA1=15dd99a1991e0b3826fede3deffc1feba42278e6
> +  $ du sha1.0.bb
> +  23128   sha1.0.bb
> +
>   Hot Blocks
>   ..........
>   
> diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
> new file mode 100644
> index 000000000000..41139f423fe2
> --- /dev/null
> +++ b/contrib/plugins/bbv.c
> @@ -0,0 +1,158 @@
> +/*
> + * Generate basic block vectors for use with the SimPoint analysis tool.
> + * SimPoint: https://cseweb.ucsd.edu/~calder/simpoint/
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
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
> +typedef struct Vcpu {
> +    uint64_t count;
> +    FILE *file;
> +} Vcpu;
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
> +static GHashTable *bbs;
> +static GRWLock bbs_lock;
> +static char *filename;
> +static struct qemu_plugin_scoreboard *vcpus;
> +static uint64_t interval = 100000000;
> +
> +static void plugin_exit(qemu_plugin_id_t id, void *p)
> +{
> +    for (int i = 0; i < qemu_plugin_num_vcpus(); i++) {
> +        fclose(((Vcpu *)qemu_plugin_scoreboard_find(vcpus, i))->file);
> +    }
> +
> +    g_hash_table_unref(bbs);
> +    g_free(filename);
> +    qemu_plugin_scoreboard_free(vcpus);
> +}
> +
> +static void free_bb(void *data)
> +{
> +    qemu_plugin_scoreboard_free(((Bb *)data)->count);
> +    g_free(data);
> +}
> +
> +static qemu_plugin_u64 count_u64(void)
> +{
> +    return qemu_plugin_scoreboard_u64_in_struct(vcpus, Vcpu, count);
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
> +    Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus, vcpu_index);
> +
> +    vcpu_filename = g_strdup_printf("%s.%u.bb", filename, vcpu_index);
> +    vcpu->file = fopen(vcpu_filename, "w");
> +}
> +
> +static void vcpu_interval_exec(unsigned int vcpu_index, void *udata)
> +{
> +    Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus, vcpu_index);
> +    GHashTableIter iter;
> +    void *value;
> +
> +    if (!vcpu->file) {
> +        return;
> +    }
> +
> +    vcpu->count -= interval;
> +
> +    fputc('T', vcpu->file);
> +
> +    g_rw_lock_reader_lock(&bbs_lock);
> +    g_hash_table_iter_init(&iter, bbs);
> +
> +    while (g_hash_table_iter_next(&iter, NULL, &value)) {
> +        Bb *bb = value;
> +        uint64_t bb_count = qemu_plugin_u64_get(bb_count_u64(bb), vcpu_index);
> +
> +        if (!bb_count) {
> +            continue;
> +        }
> +
> +        fprintf(vcpu->file, ":%u:%" PRIu64 " ", bb->index, bb_count);
> +        qemu_plugin_u64_set(bb_count_u64(bb), vcpu_index, 0);
> +    }
> +
> +    g_rw_lock_reader_unlock(&bbs_lock);
> +    fputc('\n', vcpu->file);
> +}
> +
> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> +{
> +    uint64_t n_insns = qemu_plugin_tb_n_insns(tb);
> +    uint64_t vaddr = qemu_plugin_tb_vaddr(tb);
> +    Bb *bb = g_hash_table_lookup(bbs, &vaddr);

Missing a read_lock for this access.

> +
> +    if (!bb) {
> +        uint64_t *key = g_new(uint64_t, 1);
> +
> +        *key = vaddr;
> +        bb = g_new(Bb, 1);
> +        bb->count = qemu_plugin_scoreboard_new(sizeof(uint64_t));
> +        bb->index = g_hash_table_size(bbs);
> +        g_rw_lock_writer_lock(&bbs_lock);
> +        g_hash_table_insert(bbs, key, bb);
> +        g_rw_lock_writer_unlock(&bbs_lock);
> +    }
> +
> +    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
> +        tb, QEMU_PLUGIN_INLINE_ADD_U64, count_u64(), n_insns);
> +
> +    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
> +        tb, QEMU_PLUGIN_INLINE_ADD_U64, bb_count_u64(bb), n_insns);
> +
> +    qemu_plugin_register_vcpu_tb_exec_cond_cb(
> +        tb, vcpu_interval_exec, QEMU_PLUGIN_CB_NO_REGS,
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
> +    vcpus = qemu_plugin_scoreboard_new(sizeof(Vcpu));
> +    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> +    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
> +
> +    return 0;
> +}
> diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
> index edf256cd9d11..6936591b1022 100644
> --- a/contrib/plugins/Makefile
> +++ b/contrib/plugins/Makefile
> @@ -13,6 +13,7 @@ TOP_SRC_PATH = $(SRC_PATH)/../..
>   VPATH += $(SRC_PATH)
>   
>   NAMES :=
> +NAMES += bbv
>   NAMES += execlog
>   NAMES += hotblocks
>   NAMES += hotpages
> 
> ---
> base-commit: 31669121a01a14732f57c49400bc239cf9fd505f
> change-id: 20240618-bb-93387ddf765b
> 
> Best regards,

Otherwise,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

