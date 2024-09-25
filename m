Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D52CCF58C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 13:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stRvj-00040q-K6; Wed, 25 Sep 2024 09:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1stRvh-00040G-2F
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 09:19:41 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1stRvf-0002Wq-4p
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 09:19:40 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e24985919c8so2031777276.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 06:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727270377; x=1727875177; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EBXG3+zXtA4aJ3iQBr9I5aX/exYIW6TE0bHLZ4OOsEc=;
 b=B4X9/y5h/fdhLzp9aekTfGGEaLclqsg7vfRILHzJPv3tEeS7GDmTf82PrMrJCK+KVZ
 rJSPvyQf1ni1ikPJLOW2vZgleamkrcjv8NTVtaaAE0HtQ3B2tWlUm8GvN/IXIJQj7sYS
 mWRwlTcqZ7hvPSMlCWC9ROLbLZVwcsvb58PhINy5nbDMFyOWrYP9eNeq7D7xJu3DhkIU
 Fa9n+Y5uVCb7nOf0lVTB9xD0d/C5o/Z3ZoXF0+FW8N1ANQqjN10PJxJMitxtNsOrFJwf
 m6rKbu0+bsgapFluOA8tq7z42bZQM/fM90WhByf6xh9/69kheYsgmiY2LBYFwXcqTNfr
 WQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727270377; x=1727875177;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EBXG3+zXtA4aJ3iQBr9I5aX/exYIW6TE0bHLZ4OOsEc=;
 b=ty8M74HLZPuBrRyE13LpECl4TCcxGCSd8SP4k1K22tUjspx3l9VZeAjLXQ7xGVoqPQ
 SA6OqBDtZuK+Bv/8jMef8U4rZFM1pd9S2J7LVGwH84SfUWxD4bxnXWl0o6ujtgyN0g/h
 nFkG3BP5nUwmbxn4zP151mZCOzzgvBPkb6lUH7q6kVHfLTUGIxInGWf6XSwmGz1OPTZq
 V2NaPuJV4fUVyHLBAOilqcbetSM9obl9BmsYYkWrC66R1Ar0UeJfmLmvY/AR4NfcQMFD
 FKdPi823bZunWb+t8ntlg3T9sGUR7/QNj4WxIlOK7lNWVEJRB4XgK+wpp6atAvPcY2JF
 +WBw==
X-Gm-Message-State: AOJu0YyeeNIX1q9toWR6SJ+enaaZW0cWmJv7Q+t3zeVHQJaTpfOQ/lmn
 UHVosYS6XTp2ZbM58/0oiiAvnsvZT3X6Z89lcGPWF0TgpagTSKkbQtsGAzkgKCc=
X-Google-Smtp-Source: AGHT+IF2jxQm8kYNCQhl/oyr2RM7Zo836VFwMXjFMT4+uNMN6+wx+PO53n+TXvSczicf//6fdDACsA==
X-Received: by 2002:a05:6902:1006:b0:e22:67bb:c7e8 with SMTP id
 3f1490d57ef6-e24d9dc647emr1839021276.38.1727270377174; 
 Wed, 25 Sep 2024 06:19:37 -0700 (PDT)
Received: from [192.168.68.110] ([187.101.184.93])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-84e73b2631dsm1690487241.16.2024.09.25.06.19.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 06:19:36 -0700 (PDT)
Message-ID: <f4c52806-1722-43fc-b4b4-ab17c930d4cd@ventanamicro.com>
Date: Wed, 25 Sep 2024 10:19:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qapi, machine-qmp-cmds.c: query-accelerator support
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 zhao1.liu@intel.com, eblake@redhat.com, armbru@redhat.com,
 ajones@ventanamicro.com
References: <20240919112056.620917-1-dbarboza@ventanamicro.com>
 <ZuwXjyqhxwHBEvR_@redhat.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <ZuwXjyqhxwHBEvR_@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yb1-xb35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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



On 9/19/24 9:22 AM, Daniel P. Berrangé wrote:
> On Thu, Sep 19, 2024 at 08:20:56AM -0300, Daniel Henrique Barboza wrote:
>> Add a QMP command that shows all specific properties of the current
>> accelerator in use.
> 
> Why do we need to expose /everything/ ?

I wouldn't mind pick and choose advertised properties for the accelerators
like we do with other APIs.

This would mean that each arch should choose what to advertise or not, given that
some accelerator properties might be relevant just for some archs. The API would
be implemented by each arch individually.


> 
>>
>> This can be used as a complement of other APIs like query-machines and
>> query-cpu-model-expansion, allowing management to get a more complete
>> picture of the running QEMU process.
> 
> query-machines doesn't return every single QOM property, just
> a hand selected set of information pieces.
> 
> The query-cpu-model-expansion does return everything, but I
> consider that command to be bad design, as it doesn't distinguish
> between hardware CPU features, and QEMU QOM properties
> 
>>
>> This is the output with a x86_64 TCG guest:
>>
>> $ ./build/qemu-system-x86_64 -S  -display none -accel tcg -qmp tcp:localhost:1234,server,wait=off
>>
>> $ ./scripts/qmp/qmp-shell localhost:1234
>> Welcome to the QMP low-level shell!
>> Connected to QEMU 9.1.50
>>
>> (QEMU) query-accelerator
>> {"return": {"name": "tcg", "props": {"one-insn-per-tb": false, "thread": "multi", "tb-size": 0, "split-wx": false, "type": "tcg-accel"}}}
>>
>> And for a x86_64 KVM guest:
>>
>> $ ./build/qemu-system-x86_64 -S  -display none -accel kvm -qmp tcp:localhost:1234,server,wait=off
>>
>> $ ./scripts/qmp/qmp-shell localhost:1234
>> Welcome to the QMP low-level shell!
>> Connected to QEMU 9.1.50
>>
>> (QEMU) query-accelerator
>> {"return": {"name": "KVM", "props": {"mem-container-smram[0]": "", "xen-gnttab-max-frames": 64, "device": "", "xen-version": 0, "mem-smram[0]": "", "notify-window": 0, "dirty-ring-size": 0, "kvm-shadow-mem": -1, "type": "kvm-accel", "notify-vmexit": "run", "xen-evtchn-max-pirq": 256}}}
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   hw/core/machine-qmp-cmds.c | 34 ++++++++++++++++++++++++++++++++++
>>   qapi/machine.json          | 27 +++++++++++++++++++++++++++
>>   2 files changed, 61 insertions(+)
>>
>> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
>> index 130217da8f..eac803bf36 100644
>> --- a/hw/core/machine-qmp-cmds.c
>> +++ b/hw/core/machine-qmp-cmds.c
> 
>> +AccelInfo *qmp_query_accelerator(Error **errp)
>> +{
>> +    AccelState *accel = current_accel();
>> +    AccelClass *acc = ACCEL_GET_CLASS(accel);
>> +    AccelInfo *info = g_new0(AccelInfo, 1);
>> +    QDict *qdict_out = qdict_new();
>> +    ObjectPropertyIterator iter;
>> +    ObjectProperty *prop;
>> +
>> +    info->name = g_strdup(acc->name);
>> +
>> +    object_property_iter_init(&iter, OBJECT(accel));
>> +    while ((prop = object_property_iter_next(&iter))) {
>> +        QObject *value;
>> +
>> +        if (!prop->get) {
>> +            continue;
>> +        }
>> +
>> +        value = object_property_get_qobject(OBJECT(accel), prop->name,
>> +                                                  &error_abort);
>> +        qdict_put_obj(qdict_out, prop->name, value);
>> +    }
> 
> I'm not at all convinced trhat we should be exposing every single
> QOM property on the accelerator class as public QMP data
> 
>> +
>> +    if (!qdict_size(qdict_out)) {
>> +        qobject_unref(qdict_out);
>> +    } else {
>> +        info->props = QOBJECT(qdict_out);
>> +    }
>> +
>> +    return info;
>> +}
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index a6b8795b09..d0d527d1eb 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -1898,3 +1898,30 @@
>>   { 'command': 'x-query-interrupt-controllers',
>>     'returns': 'HumanReadableText',
>>     'features': [ 'unstable' ]}
>> +
>> +##
>> +# @AccelInfo:
>> +#
>> +# Information about the current accelerator.
>> +#
>> +# @name: the name of the current accelerator being used
>> +#
>> +# @props: a dictionary of the accelerator properties
>> +#
>> +# Since: 9.2
>> +##
>> +{ 'struct': 'AccelInfo',
>> +  'data': { 'name': 'str',
>> +            '*props': 'any' } }
> 
> This is way too open ended. IMHO ideally we would never add more
> instances of the 'any' type, as it has many downsides
> 
>   - zero documentation about what is available
>   - no version info about when each prop was introduced
>   - no ability to tag fields as deprecated
> 
> For this new API, IMHO 'name' should be an enumeration of the
> accelerator types, and thenm 'props' should be a discrinated
> union of accelerator specific structs

We have accelerator properties that differs from arch to arch, e.g. x86 has properties like
notify-vmexit, declared in kvm_arch_accel_class_init() from target/i386/kvm/kvm.c, that no
other arch has access to. RISC-V has its own share of these properties too.

Is it possible to declare specific structs based on arch for the API? In a quick glance
it seems like we're doing something like that with query-cpus-fast, where s390x has
additional properties that are exposed.


Thanks,

Daniel



> 
>> +
>> +##
>> +# @query-accelerator:
>> +#
>> +# Shows information about the accelerator in use.
>> +#
>> +# Returns: a CpuModelExpansionInfo describing the expanded CPU model
>> +#
>> +# Since: 9.2
>> +##
>> +{ 'command': 'query-accelerator',
>> +  'returns': 'AccelInfo' }
>> -- 
>> 2.45.2
>>
>>
> 
> With regards,
> Daniel

