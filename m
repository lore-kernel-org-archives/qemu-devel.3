Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7ACD24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJH4-0008GF-D2; Fri, 11 Oct 2024 13:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1szJ7c-0003Vx-As
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:08:13 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1szEjW-0006K8-22
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 08:27:04 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20c71603217so18346325ad.3
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 05:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1728649620; x=1729254420; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nPqb+4tCljq6bPss+HnjKA1+Za02LBbMAkJGMlMaBw0=;
 b=IPkFobtERm8RNcdC22nLZpZ1Adk7phDwl6HtwKkB1yYy9slnoHbRCrxDzkz+bTaTaA
 EKeAdHrIgF7ou3R1g9JV71VkxCMdYBvZVBr0N2bb5ESczaL3L+zBHCwisj9SH/7x5jvU
 mX1jdP3LOjr9SFI18DgCbVCHZJ9fCHN4aZq2sh2R6MtRX4tTy2Ti0UpdDOhmABIgffb6
 qdM3CVliF0iakK6/yRLMLm97TeAQ23Dxfqwut7HnQ4vLgHQSH/4KToX/vmm9t0nGV/J7
 2OYqi3feyJih98QdxoTtuMxUFKcdzxVjxVKi7l1Wo29i5lAGeWPuSuRCEfKavMKhf2jF
 84wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728649620; x=1729254420;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nPqb+4tCljq6bPss+HnjKA1+Za02LBbMAkJGMlMaBw0=;
 b=wWMV7/Ty+B87W04/xkCNM607er/1hEcvx86Q+MY3BE4tK8vtHZq6r2Gy7MzEPv6tWk
 P6gpt+fhwIkkBBdLX+Spuq/kh7GndRKa/C47LXwuwBuwe7H8k0LANSILb+a0Yo6xC5LS
 TFmCYWlsEklKuc1uUF3FeJ4ewEyoLePFszRyze/MfaGDofwaIl7s1tlmfi0VgjZXLVst
 wOU1Bd+O50rZ5DoSkABSSc7gXQfZ8ApnA54GADIi8oMuPlJ9GPJselLCm5ODACi092IR
 CPVBX3pgv9a7+oMZgpI5dejxH3xkvcX/4yA+Eqhb5pEmR/vxrF1PUfyoV7510NpSefmh
 oRPg==
X-Gm-Message-State: AOJu0YxdVb7TR8qp0HNl2tKahWu3XlKk1NzYBYlOct2fN03Z8cAWvzIl
 PPVuRFgN7GILMx5YSvT8VYkGkPqxpwO7qL8PSVwUkrmcx4xi72Uzm0k90oDd0OQ=
X-Google-Smtp-Source: AGHT+IEqY1LczGw9ubz/0ALu2iMdu52wMpqea2BrBmq4mAS6fBBhjamxqu2uY2yXzciElyEfvyfZQA==
X-Received: by 2002:a17:902:ec83:b0:205:68a4:b2d8 with SMTP id
 d9443c01a7336-20ca13f74a2mr34126485ad.11.1728649620221; 
 Fri, 11 Oct 2024 05:27:00 -0700 (PDT)
Received: from [192.168.68.110] (201-68-240-198.dsl.telesp.net.br.
 [201.68.240.198]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c0eb486sm22617465ad.176.2024.10.11.05.26.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 05:26:59 -0700 (PDT)
Message-ID: <bd28484c-16f7-47b2-bbb7-b0e31a394129@ventanamicro.com>
Date: Fri, 11 Oct 2024 09:26:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qapi, machine-qmp-cmds.c: query-accelerator support
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 zhao1.liu@intel.com, eblake@redhat.com, ajones@ventanamicro.com
References: <20240919112056.620917-1-dbarboza@ventanamicro.com>
 <ZuwXjyqhxwHBEvR_@redhat.com>
 <f4c52806-1722-43fc-b4b4-ab17c930d4cd@ventanamicro.com>
 <ZvaN7-W4VLr6TGsm@redhat.com> <874j5onsr5.fsf@pond.sub.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <874j5onsr5.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
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



On 10/7/24 6:53 AM, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
>> Markus: QAPI design Qs for you at the bottom
>>
>> On Wed, Sep 25, 2024 at 10:19:33AM -0300, Daniel Henrique Barboza wrote:
>>>
>>>
>>> On 9/19/24 9:22 AM, Daniel P. Berrangé wrote:
>>>> On Thu, Sep 19, 2024 at 08:20:56AM -0300, Daniel Henrique Barboza wrote:
>>>>> Add a QMP command that shows all specific properties of the current
>>>>> accelerator in use.
>>>>
>>>> Why do we need to expose /everything/ ?
>>>
>>> I wouldn't mind pick and choose advertised properties for the accelerators
>>> like we do with other APIs.
>>>
>>> This would mean that each arch should choose what to advertise or not, given that
>>> some accelerator properties might be relevant just for some archs. The API would
>>> be implemented by each arch individually.
>>
>> Well with qemu-system-any we might get multiple arches reporting
>> info in the same binary, so we'll need to fan out to fill in the
>> per-arch info, after doing a common base.
>>
>> Hmmm, i wonder if qemu-system-any will support mixing KVM and TCG ?
>> ie KVM for the host native accelerator, combined with TCG for the
>> foreign archs ??? Hopefully not !
>>
>>>>> This can be used as a complement of other APIs like query-machines and
>>>>> query-cpu-model-expansion, allowing management to get a more complete
>>>>> picture of the running QEMU process.
>>>>
>>>> query-machines doesn't return every single QOM property, just
>>>> a hand selected set of information pieces.
>>>>
>>>> The query-cpu-model-expansion does return everything, but I
>>>> consider that command to be bad design, as it doesn't distinguish
>>>> between hardware CPU features, and QEMU QOM properties
>>>>
>>>>>
>>>>> This is the output with a x86_64 TCG guest:
>>>>>
>>>>> $ ./build/qemu-system-x86_64 -S  -display none -accel tcg -qmp tcp:localhost:1234,server,wait=off
>>>>>
>>>>> $ ./scripts/qmp/qmp-shell localhost:1234
>>>>> Welcome to the QMP low-level shell!
>>>>> Connected to QEMU 9.1.50
>>>>>
>>>>> (QEMU) query-accelerator
>>>>> {"return": {"name": "tcg", "props": {"one-insn-per-tb": false, "thread": "multi", "tb-size": 0, "split-wx": false, "type": "tcg-accel"}}}
>>>>>
>>>>> And for a x86_64 KVM guest:
>>>>>
>>>>> $ ./build/qemu-system-x86_64 -S  -display none -accel kvm -qmp tcp:localhost:1234,server,wait=off
>>>>>
>>>>> $ ./scripts/qmp/qmp-shell localhost:1234
>>>>> Welcome to the QMP low-level shell!
>>>>> Connected to QEMU 9.1.50
>>>>>
>>>>> (QEMU) query-accelerator
>>>>> {"return": {"name": "KVM", "props": {"mem-container-smram[0]": "", "xen-gnttab-max-frames": 64, "device": "", "xen-version": 0, "mem-smram[0]": "", "notify-window": 0, "dirty-ring-size": 0, "kvm-shadow-mem": -1, "type": "kvm-accel", "notify-vmexit": "run", "xen-evtchn-max-pirq": 256}}}
>>>>>
>>>>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>>>> ---
>>>>>    hw/core/machine-qmp-cmds.c | 34 ++++++++++++++++++++++++++++++++++
>>>>>    qapi/machine.json          | 27 +++++++++++++++++++++++++++
>>>>>    2 files changed, 61 insertions(+)
>>>>>
>>>>> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
>>>>> index 130217da8f..eac803bf36 100644
>>>>> --- a/hw/core/machine-qmp-cmds.c
>>>>> +++ b/hw/core/machine-qmp-cmds.c
>>>>
>>>>> +AccelInfo *qmp_query_accelerator(Error **errp)
>>>>> +{
>>>>> +    AccelState *accel = current_accel();
>>>>> +    AccelClass *acc = ACCEL_GET_CLASS(accel);
>>>>> +    AccelInfo *info = g_new0(AccelInfo, 1);
>>>>> +    QDict *qdict_out = qdict_new();
>>>>> +    ObjectPropertyIterator iter;
>>>>> +    ObjectProperty *prop;
>>>>> +
>>>>> +    info->name = g_strdup(acc->name);
>>>>> +
>>>>> +    object_property_iter_init(&iter, OBJECT(accel));
>>>>> +    while ((prop = object_property_iter_next(&iter))) {
>>>>> +        QObject *value;
>>>>> +
>>>>> +        if (!prop->get) {
>>>>> +            continue;
>>>>> +        }
>>>>> +
>>>>> +        value = object_property_get_qobject(OBJECT(accel), prop->name,
>>>>> +                                                  &error_abort);
>>>>> +        qdict_put_obj(qdict_out, prop->name, value);
>>>>> +    }
>>>>
>>>> I'm not at all convinced trhat we should be exposing every single
>>>> QOM property on the accelerator class as public QMP data
>>>>
>>>>> +
>>>>> +    if (!qdict_size(qdict_out)) {
>>>>> +        qobject_unref(qdict_out);
>>>>> +    } else {
>>>>> +        info->props = QOBJECT(qdict_out);
>>>>> +    }
>>>>> +
>>>>> +    return info;
>>>>> +}
>>>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>>>> index a6b8795b09..d0d527d1eb 100644
>>>>> --- a/qapi/machine.json
>>>>> +++ b/qapi/machine.json
>>>>> @@ -1898,3 +1898,30 @@
>>>>>    { 'command': 'x-query-interrupt-controllers',
>>>>>      'returns': 'HumanReadableText',
>>>>>      'features': [ 'unstable' ]}
>>>>> +
>>>>> +##
>>>>> +# @AccelInfo:
>>>>> +#
>>>>> +# Information about the current accelerator.
>>>>> +#
>>>>> +# @name: the name of the current accelerator being used
>>>>> +#
>>>>> +# @props: a dictionary of the accelerator properties
>>>>> +#
>>>>> +# Since: 9.2
>>>>> +##
>>>>> +{ 'struct': 'AccelInfo',
>>>>> +  'data': { 'name': 'str',
>>>>> +            '*props': 'any' } }
>>>>
>>>> This is way too open ended. IMHO ideally we would never add more
>>>> instances of the 'any' type, as it has many downsides
>>>>
>>>>    - zero documentation about what is available
>>>>    - no version info about when each prop was introduced
>>>>    - no ability to tag fields as deprecated
> 
> Yes, 'any' is best avoided in stable interfaces.
> 
>>>> For this new API, IMHO 'name' should be an enumeration of the
>>>> accelerator types, and thenm 'props' should be a discrinated
>>>> union of accelerator specific structs
>>>
>>> We have accelerator properties that differs from arch to arch, e.g. x86 has properties like
>>> notify-vmexit, declared in kvm_arch_accel_class_init() from target/i386/kvm/kvm.c, that no
>>> other arch has access to. RISC-V has its own share of these properties too.
>>>
>>> Is it possible to declare specific structs based on arch for the API? In a quick glance
>>> it seems like we're doing something like that with query-cpus-fast, where s390x has
>>> additional properties that are exposed.
> 
> Yes.  Schema pattern:
> 
>      { 'union: ...,
>        'base': {
>            'target': 'SysEmuTarget',
>            ... target-independent data ... }
>        'data': {
>            T: { ... data for target T ... }
>            ... } }
> 
> On the wire:
> 
>      {"target": T,
>       ... target-independent data ...
>       ... data for target T}
> 
> This is for returning info on a single target.
> 
> Typically, a qemu-system-T will only ever return branch T.  The other
> branches are dead code.  Tolerable.
> 
> With qemu-system-any, which provides multiple (eventually all, we hope)
> targets, the union still has data for just one target.  To get data for
> multiple targets, we'd have to return several objects.
> 
> Fine for query-cpus-fast: it returns a CpuInfoFast per CPU, and each of
> them uses the branch T appropriate for the CPU.
> 
>> To allow for qemu-system-any, which will eventually have multiple arches in
>> one,
> 
> Actually, qemu-system-any can work almost exactly like the existing
> qemu-system-T, until we mix in heterogeneous machines.
> 
> Without heterogeneous machines, qemu-system-any's target T gets fixed at
> some point.  From that point on, no difference to qemu-system-T.
> 
> The "almost" is for running commands before that point.
> 
> This applies to all commands that take the target as implicit input.  I
> believe several exist.
> 
> How accelerators will work for heterogeneous machines is not clear to
> me.  Until it is, I can't really advise on how to design accelerator
> information for them.
> 
>>       I guess we'll need multiple levels of nesting. Perhaps  something like
>> this:
>>
>>    { 'enum': 'AccelType',
>>      'data': ['tcg', 'kvm', ....] }
>>
>>    { 'union': 'AccelInfo',
>>      'type': 'AccelType',
>>      'data': {
>>          'tcg': 'AccelInfoTCG',
>> 	'kvm': 'AccelInfoKVM',
>>      } }
>>
>>    { 'struct': 'AccelInfoTCGX86',
>>      'data': {
>>          'notify-vmexit': ...
>>      } }
>>
>>    { 'struct': 'AccelInfoTCGArch',
>>      'data': {
>>         'x86': 'AccelInfoTCGX86',
>>         'riscv': 'AccelInfoTCGRiscV',
>>         ...etc...
>>      }
>>
>>    { 'struct': 'AccelInfoTCG',
>>      'data': {
>>           ...non-arch specific fields...,
>> 	 'arch': 'AccelInfoTCGArch',
>>      } }
> 
> Here, you want to return data for all targets, not just one.  Instead of
> a sum type (union branches), you use a product type (struct members).
> Feels fair.
> 
>>   ...equiv AccelInfoKVM* structs....
> 
> The only target that can actually work is the one matching the host
> hardware.  Perhaps we want to return just that.
> 
>> Markus:  any other/better ideas ?
> 
> I guess there are other ways to skin this cat.  But I think there are
> questions to ask before we delve deeper:
> 
> 1. query-accelerator use cases?  What accelerator information exactly do
> we need to provide for them?

My original motivation with this API was to expose arch specific attributes
to the guest, most notably RISC-V 'riscv-aia' properties, that are defined by
RISC-V kvm_arch_accel_class_init().

In fact the very first impl I did was just a list of properties that each arch
would want to advertise, like query-cpu-model-expansion does, and then each
arch would be responsible to fill in whatever they want to advertise. I decided
to go with this current approach instead because it would bring more discussions
to the table, instead of making a RISC-V specific API that only RISC-V folks
would care about.

Reading all the thread I wonder if we should go back to my original intent and
make the API arch specific and let every arch define what they want to expose.
Seems simpler than to make a catch all API for all archs. Each arch would be
responsible for the stability of their schema and so on.

We're still adding RISC-V specific properties in the KVM accel, so for now I
wouldn't mind implementing this API for x86 first just to validate the concept.
Granted, I have no idea what x86 would like to expose from the KVM accel (or any
other accel for that matter), so if someone could give me a list on what x86
would like to expose that would be terrific.


Thanks,

Daniel




> 
> 2. How fancy do we want to get for homogeneous qemu-system-any before
> the target gets fixed?
> 
> 3. How will accelerators work for heterogeneous qemu-system-any?
> 
> [...]
> 

