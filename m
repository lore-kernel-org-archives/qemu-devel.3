Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3CFC3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 06:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se7ZA-0001UF-Gb; Wed, 14 Aug 2024 02:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1se7Z8-0001Te-Js
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 02:33:02 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1se7Z6-0002iL-3D
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 02:33:02 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70d2b921cdfso5601331b3a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 23:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723617178; x=1724221978;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Efm/CGOjylRexP++hdaclqo7GwQBkfRY8/dWs49ruC8=;
 b=qULfTyBDPEEzS3QlxOoUdmgk3k96YlWGj9TYLU5WDg0A4atOP8vRaE+G9aWlvw37wK
 BCilJdgfhNEnqfkbmIlHpqsVD6+Xe2Dnt14ObVKGlsu5EqrPpQCuooBEUEM44b2nHfuT
 Wj3pDzkSg0xerzThiWAf7xV/AhJuofZ93br/jFscl+CLYUdLLKVeyupl/5ZpsWt0SEXQ
 wKrYFovUJmX4euwUGEErTVuYTWBA56BXPBKhxjv1vBBiqBlObUEBjBD8vulwe38Bd0yH
 B+aRr5kMKoXQcG+ujWzurGOoxpVv9NTQnMmDPNDAJn3ASgd/IiT7d3Q3aNOibHDcC8Cw
 ZNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723617178; x=1724221978;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Efm/CGOjylRexP++hdaclqo7GwQBkfRY8/dWs49ruC8=;
 b=rUNbt6EubPTblIGwVstWVvSj3QT532B7JqWWAqbM0hTMQCO+x8jio6zKepEXrboGYm
 2L4Z7oTfueAkwSt/SgYSO2u2h9dGtAMWxRBRcPVk1qB3X7D7vJrgxJit9JBmebOX+WHn
 N/NI7p1qQf7FDDAMReu1ght7590j+FQPUnoiTPmxo5uRYNI1aBMJqQ8qHhdywYO9pZVV
 CK8EfB1iwA+SWZONzL+CCDY/3JpTq+phLTa7vmZ+rk89v1MB/lfn7Bqz+/zu8VF/xoJc
 fNbF63XP/3o9NFxgFLljHTsWzYxS1h2kDSk3Qdt0e+J7tuNODKFw9KaaiWUNZLuvB+Px
 V87g==
X-Gm-Message-State: AOJu0YyJPzb3r4nPY/k6xymdQtxvIKqQ+zZ80pc0CarTjVZuFkxtB60R
 1HrDxaWpldYaeKoVsq3LXCaIPcTnLAJrqYd8fbNkp0GzyLgbnvqdX7N3Vvn/hFs=
X-Google-Smtp-Source: AGHT+IFBsMcmrNyQbeK1ZaJ66JKUZ4nOTxwQJcrjF+5QdAPyAXYxfaZspn/hrgLm6o1QcA2WXfjgFg==
X-Received: by 2002:a05:6a00:9284:b0:70a:f22d:caf5 with SMTP id
 d2e1a72fcca58-712670f6858mr2627789b3a.5.1723617178059; 
 Tue, 13 Aug 2024 23:32:58 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7c69e8f8a74sm1665374a12.10.2024.08.13.23.32.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 23:32:57 -0700 (PDT)
Message-ID: <76cf39cb-ef99-4b5f-8908-1a437b4c3120@daynix.com>
Date: Wed, 14 Aug 2024 15:32:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins: Add a plugin to generate basic block
 vectors
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
References: <20240813-bb-v1-1-effbb77daebf@daynix.com>
 <0e0ee7a5-f8e4-44f0-83d9-918b0ef71396@linaro.org>
 <767b0e96-d7ad-418f-8d84-cb7e49dc2510@daynix.com>
 <5e877d1a-9a6b-4de5-9c3e-d654908a3922@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <5e877d1a-9a6b-4de5-9c3e-d654908a3922@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
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

On 2024/08/14 14:41, Pierrick Bouvier wrote:
> On 8/13/24 21:56, Akihiko Odaki wrote:
>> On 2024/08/14 4:20, Pierrick Bouvier wrote:
>>> Hi Akihiko, and thanks for contributing this new plugin.
>>
>> Hi,
>>
>> Thanks for reviewing
>>
>>>
>>> Recently, plugins documentation has been modified, and list of plugins
>>> and their doc is now in "docs/about/emulation.rst". You may want to
>>> rebase on top of master.
>>
>> I see. I'll rebase and update the documentation with v2.
>>
>>>
>>> Globally, I'm ok with this plugin and the implementation. Just a few
>>> fixes are needed for concurrent accesses.
>>>
>>> On 8/12/24 23:46, Akihiko Odaki wrote:
>>>> SimPoint is a widely used tool to find the ideal microarchitecture
>>>> simulation points so Valgrind[2] and Pin[3] support generating basic
>>>> block vectors for use with them. Let's add a corresponding plugin to
>>>> QEMU too.
>>>>
>>>> Note that this plugin has a different goal with tests/plugin/bb.c.
>>>>
>>>> This plugin creates a vector for each constant interval instead of
>>>> counting the execution of basic blocks for the entire run and able to
>>>> describe the change of execution behavior. Its output is also
>>>> syntactically simple and better suited for parsing, while the output of
>>>> tests/plugin/bb.c is more human-readable.
>>>>
>>>
>>> I think it can be confusing to have two plugins named bb. How about
>>> simpoint, or bbv?
>>
>> How about renaming tests/tcg/plugins/bb.c to simple-bb.c instead and
>> keep the name of contrib/plugins/bb.c concise?
>>
>> tests/tcg/plugins/bb.c is simple and good as a sample, but less useful
>> in practice than this plugin due to differences described earlier. On
>> the other hand, this plugin is designed to be utilized for practical
>> purpose so I want to keep its name short and save typing.
>>
> 
> I would recommend using the <tab> key to save typing. I'm kidding :)
> 
> More seriously, I get your point, but I don't think this new plugin is 
> generic enough to be qualified as "the" bb plugin (nor the 
> tests/tcg/plugins/bb neither, but it predates this new plugin). It 
> outputs format for SimPoint, so how about simpoint (accessible after 
> typing si<tab>)?

Perhaps bbv is a better naming. I expect there are more use cases of 
basic block vectors than feeding it for SimPoint. Searching for "basic 
block vectors" with Google Scholar show this terminology has a 
consistent meaning and used in several researches.

> 
>>>
>>>> [1] https://cseweb.ucsd.edu/~calder/simpoint/
>>>> [2] https://valgrind.org/docs/manual/bbv-manual.html
>>>> [3]
>>>> https://www.intel.com/content/www/us/en/developer/articles/tool/pin-a-dynamic-binary-instrumentation-tool.html
>>>>
>>>> Signed-off-by: Yotaro Nada <yotaro.nada@gmail.com>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>>    docs/devel/tcg-plugins.rst |  20 ++++++
>>>>    contrib/plugins/bb.c       | 153
>>>> +++++++++++++++++++++++++++++++++++++++++++++
>>>>    contrib/plugins/Makefile   |   1 +
>>>>    3 files changed, 174 insertions(+)
>>>>
>>>> diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
>>>> index 9cc09d8c3da1..2859eecc13b9 100644
>>>> --- a/docs/devel/tcg-plugins.rst
>>>> +++ b/docs/devel/tcg-plugins.rst
>>>> @@ -332,6 +332,26 @@ run::
>>>>      160          1      0
>>>>      135          1      0
>>>> +- contrib/plugins/bb.c
>>>> +
>>>> +The bb plugin allows you to generates basic block vectors for use
>>>> with the
>>>> +`SimPoint <https://cseweb.ucsd.edu/~calder/simpoint/>`__ analysis 
>>>> tool.
>>>> +
>>>> +It has two options, ``interval`` and ``outfile``. ``interval``
>>>> specifies the
>>>> +interval to generate a basic block vector by the number of
>>>> instructions. It is
>>>> +optional, and its default value is 100000000. ``outfile`` is the 
>>>> path to
>>>> +output files, and it will be suffixed with ``.N.bb`` where ``N`` is a
>>>> vCPU
>>>> +index.
>>>> +
>>>> +Example::
>>>> +
>>>> +  $ qemu-aarch64 \
>>>> +    -plugin contrib/plugins/libb.so,interval=100,outfile=sha1 \
>>>> +    tests/tcg/aarch64-linux-user/sha1
>>>> +  SHA1=15dd99a1991e0b3826fede3deffc1feba42278e6
>>>> +  $ du sha1.0.bb
>>>> +  23128   sha1.0.bb
>>>> +
>>>>    - contrib/plugins/hotblocks.c
>>>>    The hotblocks plugin allows you to examine the where hot paths of
>>>> diff --git a/contrib/plugins/bb.c b/contrib/plugins/bb.c
>>>> new file mode 100644
>>>> index 000000000000..4f1266d07ff5
>>>> --- /dev/null
>>>> +++ b/contrib/plugins/bb.c
>>>> @@ -0,0 +1,153 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>>> +
>>>
>>> A brief summary and the link to simpoint page can be added as a comment
>>> here.
>>
>> I'll add them with v2.
>>
>>>
>>>> +#include <stdio.h>
>>>> +#include <glib.h>
>>>> +
>>>> +#include <qemu-plugin.h>
>>>> +
>>>> +typedef struct Bb {
>>>> +    struct qemu_plugin_scoreboard *count;
>>>> +    unsigned int index;
>>>> +} Bb;
>>>> +
>>>> +QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
>>>> +static GHashTable *bbs;
>>>> +static GPtrArray *files;
>>>> +static char *filename;
>>>> +static struct qemu_plugin_scoreboard *count;
>>>> +static uint64_t interval = 100000000;
>>>> +
>>>> +static void plugin_exit(qemu_plugin_id_t id, void *p)
>>>> +{
>>>> +    g_hash_table_unref(bbs);
>>>> +    g_ptr_array_unref(files);
>>>> +    g_free(filename);
>>>> +    qemu_plugin_scoreboard_free(count);
>>>> +}
>>>> +
>>>> +static void free_bb(void *data)
>>>> +{
>>>> +    qemu_plugin_scoreboard_free(((Bb *)data)->count);
>>>> +    g_free(data);
>>>> +}
>>>> +
>>>> +static void free_file(void *data)
>>>> +{
>>>> +    fclose(data);
>>>> +}
>>>> + > +static directly count_u64(void)
>>>> +{
>>>> +    return qemu_plugin_scoreboard_u64(count);
>>>> +}
>>>> +
>>>> +static qemu_plugin_u64 bb_count_u64(Bb *bb)
>>>> +{
>>>> +    return qemu_plugin_scoreboard_u64(bb->count);
>>>> +}
>>>> +
>>>> +static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
>>>> +{
>>>> +    g_autofree gchar *vcpu_filename = NULL;
>>>> +
>>>> +    if (vcpu_index >= files->len) {
>>>> +        g_ptr_array_set_size(files, vcpu_index + 1);
>>>> +    } else if (g_ptr_array_index(files, vcpu_index)) {
>>>> +        return;
>>>> +    }
>>>> +
>>>
>>> You need a lock for files array for expansion/access.
>>
>> I will replace GPtrArray with scoreboard instead.
>>
> 
> Good idea. You'll have to cleanup files at the end manually, as there is 
> no support for custom destructor.
> 
>>>
>>>> +    vcpu_filename = g_strdup_printf("%s.%u.bb", filename, vcpu_index);
>>>> +    g_ptr_array_index(files, vcpu_index) = fopen(vcpu_filename, "w");
>>>> +}
>>>> +
>>>> +static void vcpu_tb_exec(unsigned int vcpu_index, void *udata)
>>>
>>> vcpu_tb_exec is a confusing name, as it is called when interval of insn
>>> is executed. vcpu_interval_exec would be more clear.
>>
>> That makes sense. I will do so with the next version.
>>
>>>
>>>> +{
>>>> +    FILE *file = g_ptr_array_index(files, vcpu_index);
>>>
>>> Need lock when accessing this array.
>>>
>>>> +    uint64_t count = qemu_plugin_u64_get(count_u64(), vcpu_index) -
>>>> interval;
>>>> +    GHashTableIter iter;
>>>> +    void *value;
>>>> +
>>>> +    if (!file) {
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    qemu_plugin_u64_set(count_u64(), vcpu_index, count);
>>>> + > +    fputc('T', file);
>>>
>>> Maybe you can add a comment with a link to
>>> https://valgrind.org/docs/manual/bbv-manual.html at this point. It's
>>> already mentioned in the commit message, but IMHO, it's convenient to
>>> have it here, so we know which data is written exactly.
>>
>> SimPoint should be referred to know the data format. I cited Valgrind
>> only to show the popularity of the format and to motivate its
>> implementation for QEMU.
>>
> 
> I understood that, but it happens that I didn't find a simple 
> description of the format on SimPoint website (maybe I missed it?), 
> while valgrind doc page is clear and concise. Feel free to point the 
> right page if it exists.

The authoritative reference would be README.txt included in SimPoint 
3.2. The Valgrind documentation is more accessible, but anyone who tries 
to generate or parse it should refer to SimPoint.

Regards,
Akihiko Odaki

