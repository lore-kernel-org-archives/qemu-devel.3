Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B20C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 05:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sepW2-0007lq-BE; Fri, 16 Aug 2024 01:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sepW0-0007iy-L7
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 01:28:44 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sepVx-0005r5-Sh
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 01:28:44 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3db35ec5688so939371b6e.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 22:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723786120; x=1724390920;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cHpQ/7harHbiL2yEZq7hSuisLaMoMh2PAPMr9b/XTb8=;
 b=NsgvOOAxzf/mJGHP6C+1O584OAaHrpLW2H/6HnBmK42e6aDGEouNPLXVW32jvxsFpK
 ipt1PbYUr7T2+gzbK6sOvpO4sFjOSJe9XUoZ82UvX50aUeXuUDYV8nF/jDEJ9W4hLfmj
 zMyWbzmjDkW46H8q7y/M9YYPUujzDAeBmBimkXRpNz/b9sh7fLNx4SOum0LERv+fDmsf
 HR3at7/aQ5uvmt14I97AXQordv+gWrPCsF43x6/GnzovFoEz37c5SXNYpyGaSruSy/xD
 PQCydlJgP+f5MQGuYydz3AWQ5f7JYH8dlu0Iz8R6sbWU4UApd0zM4NJd5+dBO9KdkIIs
 YyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723786120; x=1724390920;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cHpQ/7harHbiL2yEZq7hSuisLaMoMh2PAPMr9b/XTb8=;
 b=UQJMfYJLuRICqTlQShqn5z9kM27i/A0WqqbkzQcH2bIt14D2dX1p98j3xq5tO7Acvi
 AOpsCyqdNO8L2ldrlPLiK9hhbGCs9+9/79ImKf6fsQzef2r3nXwQ5+GTd1rdPlAnq10v
 1WZF5JIGH48FJFDwRcdjwxUP1x+7PZSxYLbk72Zbol2fJzz3tsbcJUnP3wNz7ZnXgSy7
 5xbdv5pmufACKWZsPHKyEvJCAfBHvjYk82cUhDA+qlxjcLAFKEdWfR0yBKk17BzLAxaj
 /7GlijGgGOkDssk9ElvG5EpOLY6AxuMto0km/iiSW7yMiWNb3Z4lbiEmprr7trHTCJCv
 46DA==
X-Gm-Message-State: AOJu0YyaelU6DBAPQHAde4grtVF+KSRqee1PzNWj3CC0q3z7WlxXQzl+
 snDF63H4LfN6lESK2A/M2gmwAzWRBIKIB3oz8HXxhbLk96YnN1CqVukM4hf47u4=
X-Google-Smtp-Source: AGHT+IFIwgcTEf6ZkLriIT5NgRIPXoPKtbmlopbG2l47d62PWGv7TMlKRbOgCYGaFvNmovs3tHFwQQ==
X-Received: by 2002:a05:6808:3091:b0:3db:1aa4:a5f7 with SMTP id
 5614622812f47-3dd3ad4fce4mr1773578b6e.25.1723786120382; 
 Thu, 15 Aug 2024 22:28:40 -0700 (PDT)
Received: from [157.82.207.214] ([157.82.207.214])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7c6b61e10b8sm2090650a12.47.2024.08.15.22.28.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 22:28:40 -0700 (PDT)
Message-ID: <748eeda6-0400-4cbb-9322-57e092afaa0a@daynix.com>
Date: Fri, 16 Aug 2024 14:28:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] contrib/plugins: Add a plugin to generate basic block
 vectors
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
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
 <8e027dfd-4fa7-4eab-852a-6f9d649c4b53@linaro.org>
 <f6f9f742-3213-436c-8f73-d4f32da5d7d2@daynix.com>
Content-Language: en-US
In-Reply-To: <f6f9f742-3213-436c-8f73-d4f32da5d7d2@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::233;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 URI_DOTEDU=1 autolearn=no autolearn_force=no
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

On 2024/08/16 14:13, Akihiko Odaki wrote:
> On 2024/08/15 14:48, Pierrick Bouvier wrote:
>> On 8/14/24 20:04, Akihiko Odaki wrote:
>>> SimPoint is a widely used tool to find the ideal microarchitecture
>>> simulation points so Valgrind[2] and Pin[3] support generating basic
>>> block vectors for use with them. Let's add a corresponding plugin to
>>> QEMU too.
>>>
>>> Note that this plugin has a different goal with tests/plugin/bb.c.
>>>
>>> This plugin creates a vector for each constant interval instead of
>>> counting the execution of basic blocks for the entire run and able to
>>> describe the change of execution behavior. Its output is also
>>> syntactically simple and better suited for parsing, while the output of
>>> tests/plugin/bb.c is more human-readable.
>>>
>>> [1] https://cseweb.ucsd.edu/~calder/simpoint/
>>> [2] https://valgrind.org/docs/manual/bbv-manual.html
>>> [3] 
>>> https://www.intel.com/content/www/us/en/developer/articles/tool/pin-a-dynamic-binary-instrumentation-tool.html
>>>
>>> Signed-off-by: Yotaro Nada <yotaro.nada@gmail.com>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>> Changes in v2:
>>> - Merged files variable into the global scoreboard.
>>> - Added a lock for bbs.
>>> - Added a summary to contrib/plugins/bbv.c.
>>> - Rebased.
>>> - Link to v1: 
>>> https://lore.kernel.org/r/20240813-bb-v1-1-effbb77daebf@daynix.com
>>> ---
>>>   docs/about/emulation.rst |  30 +++++++++
>>>   contrib/plugins/bbv.c    | 158 
>>> +++++++++++++++++++++++++++++++++++++++++++++++
>>>   contrib/plugins/Makefile |   1 +
>>>   3 files changed, 189 insertions(+)
>>>
>>> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
>>> index c03033e4e956..72d7846ab6f8 100644
>>> --- a/docs/about/emulation.rst
>>> +++ b/docs/about/emulation.rst
>>> @@ -381,6 +381,36 @@ run::
>>>     160          1      0
>>>     135          1      0
>>> +Basic Block Vectors
>>> +...................
>>> +
>>> +``contrib/plugins/bbv.c``
>>> +
>>> +The bbv plugin allows you to generate basic block vectors for use 
>>> with the
>>> +`SimPoint <https://cseweb.ucsd.edu/~calder/simpoint/>`__ analysis tool.
>>> +
>>> +.. list-table:: Basic block vectors arguments
>>> +  :widths: 20 80
>>> +  :header-rows: 1
>>> +
>>> +  * - Option
>>> +    - Description
>>> +  * - interval=N
>>> +    - The interval to generate a basic block vector specified by the 
>>> number of
>>> +      instructions (Default: N = 100000000)
>>> +  * - outfile=PATH
>>> +    - The path to output files.
>>> +      It will be suffixed with ``.N.bb`` where ``N`` is a vCPU index.
>>> +
>>> +Example::
>>> +
>>> +  $ qemu-aarch64 \
>>> +    -plugin contrib/plugins/libbbv.so,interval=100,outfile=sha1 \
>>> +    tests/tcg/aarch64-linux-user/sha1
>>> +  SHA1=15dd99a1991e0b3826fede3deffc1feba42278e6
>>> +  $ du sha1.0.bb
>>> +  23128   sha1.0.bb
>>> +
>>>   Hot Blocks
>>>   ..........
>>> diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
>>> new file mode 100644
>>> index 000000000000..41139f423fe2
>>> --- /dev/null
>>> +++ b/contrib/plugins/bbv.c
>>> @@ -0,0 +1,158 @@
>>> +/*
>>> + * Generate basic block vectors for use with the SimPoint analysis 
>>> tool.
>>> + * SimPoint: https://cseweb.ucsd.edu/~calder/simpoint/
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include <stdio.h>
>>> +#include <glib.h>
>>> +
>>> +#include <qemu-plugin.h>
>>> +
>>> +typedef struct Bb {
>>> +    struct qemu_plugin_scoreboard *count;
>>> +    unsigned int index;
>>> +} Bb;
>>> +
>>> +typedef struct Vcpu {
>>> +    uint64_t count;
>>> +    FILE *file;
>>> +} Vcpu;
>>> +
>>> +QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
>>> +static GHashTable *bbs;
>>> +static GRWLock bbs_lock;
>>> +static char *filename;
>>> +static struct qemu_plugin_scoreboard *vcpus;
>>> +static uint64_t interval = 100000000;
>>> +
>>> +static void plugin_exit(qemu_plugin_id_t id, void *p)
>>> +{
>>> +    for (int i = 0; i < qemu_plugin_num_vcpus(); i++) {
>>> +        fclose(((Vcpu *)qemu_plugin_scoreboard_find(vcpus, i))->file);
>>> +    }
>>> +
>>> +    g_hash_table_unref(bbs);
>>> +    g_free(filename);
>>> +    qemu_plugin_scoreboard_free(vcpus);
>>> +}
>>> +
>>> +static void free_bb(void *data)
>>> +{
>>> +    qemu_plugin_scoreboard_free(((Bb *)data)->count);
>>> +    g_free(data);
>>> +}
>>> +
>>> +static qemu_plugin_u64 count_u64(void)
>>> +{
>>> +    return qemu_plugin_scoreboard_u64_in_struct(vcpus, Vcpu, count);
>>> +}
>>> +
>>> +static qemu_plugin_u64 bb_count_u64(Bb *bb)
>>> +{
>>> +    return qemu_plugin_scoreboard_u64(bb->count);
>>> +}
>>> +
>>> +static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
>>> +{
>>> +    g_autofree gchar *vcpu_filename = NULL;
>>> +    Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus, vcpu_index);
>>> +
>>> +    vcpu_filename = g_strdup_printf("%s.%u.bb", filename, vcpu_index);
>>> +    vcpu->file = fopen(vcpu_filename, "w");
>>> +}
>>> +
>>> +static void vcpu_interval_exec(unsigned int vcpu_index, void *udata)
>>> +{
>>> +    Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus, vcpu_index);
>>> +    GHashTableIter iter;
>>> +    void *value;
>>> +
>>> +    if (!vcpu->file) {
>>> +        return;
>>> +    }
>>> +
>>> +    vcpu->count -= interval;
>>> +
>>> +    fputc('T', vcpu->file);
>>> +
>>> +    g_rw_lock_reader_lock(&bbs_lock);
>>> +    g_hash_table_iter_init(&iter, bbs);
>>> +
>>> +    while (g_hash_table_iter_next(&iter, NULL, &value)) {
>>> +        Bb *bb = value;
>>> +        uint64_t bb_count = qemu_plugin_u64_get(bb_count_u64(bb), 
>>> vcpu_index);
>>> +
>>> +        if (!bb_count) {
>>> +            continue;
>>> +        }
>>> +
>>> +        fprintf(vcpu->file, ":%u:%" PRIu64 " ", bb->index, bb_count);
>>> +        qemu_plugin_u64_set(bb_count_u64(bb), vcpu_index, 0);
>>> +    }
>>> +
>>> +    g_rw_lock_reader_unlock(&bbs_lock);
>>> +    fputc('\n', vcpu->file);
>>> +}
>>> +
>>> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb 
>>> *tb)
>>> +{
>>> +    uint64_t n_insns = qemu_plugin_tb_n_insns(tb);
>>> +    uint64_t vaddr = qemu_plugin_tb_vaddr(tb);
>>> +    Bb *bb = g_hash_table_lookup(bbs, &vaddr);
>>
>> Missing a read_lock for this access.
> 
> I expect vcpu_tb_trans() will not be executed concurrently.

No, QEMU doesn't lock unless it is userspace emulation. I'll add the 
read lock.

Regards,
Akihiko Odaki

