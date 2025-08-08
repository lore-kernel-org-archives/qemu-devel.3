Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3198C87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 16:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukPoZ-0005NT-UB; Fri, 08 Aug 2025 12:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukPoQ-0005JE-NO
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:19:24 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukPoO-0001v7-95
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:19:22 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2400f746440so18862285ad.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 09:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754669958; x=1755274758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WW+nRzqybbKRH+r/Ot471yJ9eOde91Ntg6p0vn1hjmE=;
 b=BQQ40suLKqueW8A1BUrFxVEgs6RJ96ub82Ej7y3mP9i50EEc7bMBkbc7B4utZeZtSk
 OrW2Jz7FmQVYtnexzvyuVE7rCKlYq9B9NC4pNbSUqwVKROlcJpMzckTNs8180w2/S0fW
 btbVRpYLmlC6oSsJDkWhugY9GHOm2Sr3/xwshSKi/Yd61fud0GI7lRSKN+mVe48xmqKc
 FHIjOEafRmDEiuemsIiun/K1BMJ1KIU7V1E9npTHkBwamhHAbqCIMeqSnAPsiaxIUOoY
 gVF0+p++PjtSPdagxMj9hWXRoju2KB5wzLFtAzmvRU2qAydswoX0U4FWKWqhsqg3Sbzk
 jeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754669958; x=1755274758;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WW+nRzqybbKRH+r/Ot471yJ9eOde91Ntg6p0vn1hjmE=;
 b=RVV0Jhmkaz8AvSp3mHp1FF8Xzae9Y2CgDj0cMkXPlDhp+W8A0S1BwO7sie4sXQKH8U
 QCJrHlv6W5E84eTRDpqsmC/ZsSjCFMcTDXdweaKUvnxmSuMdv2kt3h6VPcQ1jLx/KhbO
 DJEHvPEsIzP0u9dK31Tm28l5axiWxmmpezbTxa/wNqLnkZMnLYqr3JqX/cYNrkuMRWqw
 M05CuQGTxRb2+GyWjB0vZbsIByILEIGWQT3/9PvIUByeT9fZtk1Nnkq3okIB7E+wcc/o
 gaiBHQEGLzSfh8M4hDP00FBkEjvmv4nEqON0/grk5ZFf/d8fsduBLbM4d3v2VF2MS6x3
 ORAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAfuUDYmGdiBULBqXn6VDHvGTcFvNkVj0SvjsAgbI/dAVW53IgGwMX9EjrN8deQy9TUTEvcdYdasoE@nongnu.org
X-Gm-Message-State: AOJu0Ywgt2kg8TE3Bj84Y2mviZvFcCdTuuBRlyEeVhco+6GEJfxljLNQ
 dPtf95CAYsNhdrnTXSGBGCo5Qc5HMU4Cg8Gx5oMItF+2TFL8NT77+hXf72czty5n17Q=
X-Gm-Gg: ASbGncv04EL7LSKhcQswIbjqsZ7KdpmxizBEitm5lTZu2RDVROXFZ2u1sege5O6sM4D
 C9bZgeNx4+ZAeEqM4O2iLbkrANXwYKcg2BtGUcbrjQ6uGmMIWagl/YFk5YLHZPSqdqycSJV3x+w
 b8OnePZPLMt7Yhz1N8Zu64Hw4z9a5vEo6WmZ73/Y2fDFRrcqsjoiJXc5TMs6f2HO6/riZampAzA
 2fTBYJTMm517442PSajBFxbCPzV3oU903tua85WC5DRSbGj6ljEO4tOpiHAH0sGD4HoNJ61V44x
 5nyY143MYBvCRmBJdhKoKuFk1bpdh6DAkIIA/5faff5gEEv4OMNR7iR+eQ6M7k/Igz9bKIaGcoy
 76MBQy+LiuoEpSDozYCBXOyjt6rMjgxFexcE=
X-Google-Smtp-Source: AGHT+IGeUu8k8Khj36Gw+DWynvAfn7pgmfT7G0ypKNZMhif/fI7D14SrmcxdkfE9RfEi6oVKvvz+Bg==
X-Received: by 2002:a17:902:ec82:b0:240:6fda:582a with SMTP id
 d9443c01a7336-242c21c0b4fmr51115795ad.23.1754669957734; 
 Fri, 08 Aug 2025 09:19:17 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63ee49ebsm24700001a91.19.2025.08.08.09.19.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 09:19:17 -0700 (PDT)
Message-ID: <09a8120a-051c-4d39-9506-5922f5d65697@linaro.org>
Date: Fri, 8 Aug 2025 09:19:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/9] contrib/plugins/uftrace: skeleton file
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>, Gustavo Romero
 <gustavo.romero@linaro.org>, =?UTF-8?Q?Alex_Benn_=C3=A9_e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
 <20250808020702.410109-2-pierrick.bouvier@linaro.org>
 <t0o24e.37nl0tbfod6ih@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <t0o24e.37nl0tbfod6ih@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 8/8/25 1:14 AM, Manos Pitsidianakis wrote:
> On Fri, 08 Aug 2025 05:06, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>> We define a scoreboard that will hold our data per cpu. As well, we
>> define a buffer per cpu that will be used to read registers and memories
>> in a thread-safe way.
>>
>> For now, we just instrument all instructions with an empty callback.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>> contrib/plugins/uftrace.c   | 74 +++++++++++++++++++++++++++++++++++++
>> contrib/plugins/meson.build |  3 +-
>> 2 files changed, 76 insertions(+), 1 deletion(-)
>> create mode 100644 contrib/plugins/uftrace.c
>>
>> diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
>> new file mode 100644
>> index 00000000000..d60c1077496
>> --- /dev/null
>> +++ b/contrib/plugins/uftrace.c
>> @@ -0,0 +1,74 @@
>> +/*
>> + * Copyright (C) 2025, Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> + *
>> + * Generates a trace compatible with uftrace (similar to uftrace record).
>> + * https://github.com/namhyung/uftrace
>> + *
>> + * See docs/about/emulation.rst|Uftrace for details and examples.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include <qemu-plugin.h>
>> +#include <glib.h>
>> +
>> +QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
>> +
>> +typedef struct Cpu {
>> +    GByteArray *buf;
>> +} Cpu;
>> +
>> +static struct qemu_plugin_scoreboard *score;
>> +
>> +static void track_callstack(unsigned int cpu_index, void *udata)
>> +{
>> +}
>> +
>> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>> +{
>> +    size_t n_insns = qemu_plugin_tb_n_insns(tb);
>> +
>> +    for (int i = 0; i < n_insns; i++) {
> 
> s/int i/size_t i/
>

Yep, that's better.

>> +        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
> 
> This can return NULL,
>

It will return NULL only if i is out of the tb range, which will never 
happen here, because i < n_insns.
As you can see in all other plugins we have, there is never a NULL check 
for the return of qemu_plugin_tb_get_insn.
It points a good thing in the API though, that maybe we should simply 
assert i is in the range, because there is no reason for a user to use a 
random index that may fall out of the tb range.

>> +
>> +        uintptr_t pc = qemu_plugin_insn_vaddr(insn);
> 
> And this would lead to a NULL dereference (it performs insn->vaddr
> access)
> 
>> +        qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callstack,
>> +                QEMU_PLUGIN_CB_R_REGS,
>> +                (void *) pc);
> 
> Hm indentation got broken here, should be
> 

Thanks, probably when I created the intermediate series of patches.

> 
> +        qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callstack,
> +                                               QEMU_PLUGIN_CB_R_REGS,
> +                                               (void *)pc);
> 
>> +
>> +    }
>> +}
>> +
>> +static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
>> +{
>> +    Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
>> +    cpu->buf = g_byte_array_new();
>> +}
>> +
>> +static void vcpu_end(unsigned int vcpu_index)
>> +{
>> +    Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
>> +    g_byte_array_free(cpu->buf, true);
>> +    memset(cpu, 0, sizeof(Cpu));
> 
> Nitpick, cpu->buf = NULL; is easier to understand (suggestion)
>

Yes, it does not hurt, I'll add it.

>> +}
>> +
>> +static void at_exit(qemu_plugin_id_t id, void *data)
>> +{
>> +    for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
>> +        vcpu_end(i);
>> +    }
>> +
>> +    qemu_plugin_scoreboard_free(score);
>> +}
>> +
>> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>> +                                           const qemu_info_t *info,
>> +                                           int argc, char **argv)
>> +{
>> +    score = qemu_plugin_scoreboard_new(sizeof(Cpu));
>> +    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>> +    qemu_plugin_register_atexit_cb(id, at_exit, NULL);
>> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>> +
>> +    return 0;
>> +}
>> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
>> index 1876bc78438..7eb3629c95d 100644
>> --- a/contrib/plugins/meson.build
>> +++ b/contrib/plugins/meson.build
>> @@ -1,5 +1,6 @@
>> contrib_plugins = ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotblocks',
>> -                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger']
>> +                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger',
>> +                   'uftrace']
>> if host_os != 'windows'
>>    # lockstep uses socket.h
>>    contrib_plugins += 'lockstep'
>> -- 
>> 2.47.2
>>
> 
> If no other comments rise for this patch, you can add my r-b after
> fixing the NULL check:
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


