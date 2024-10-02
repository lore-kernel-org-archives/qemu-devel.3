Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D115CEB2E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 18:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw3k0-0001Ah-OH; Wed, 02 Oct 2024 14:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sw3jy-0001AT-1g
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 14:06:22 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sw3ju-0007UT-Az
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 14:06:20 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20b6458ee37so367495ad.1
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 11:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727892376; x=1728497176; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tEAo1oH+MhSaFS6az2wX8kCjONWVnHZfwbRWsJF/fbA=;
 b=TW5EWGzzKLS9uaOYPa7gtwHBXWyXyoUsRu3ux0IOWe9Pkmi7wwC47X44QvU5k7oc81
 nYjnej84Z2ObaucaHzT1fxSQVAx6PqQ/B/3iVppCfd29iChEIvQyLwvon2pXyU/CeeGm
 B3zDhhrx1mIQInOyDbW8YyF7pIYqFgxruV5u/nSmymv4ibdm26NoUNGPNJOaquXqMW2T
 mMOCnxERoF6FVNQAcmDrMdTULcSmG88OHDJV+rutf+FMkDSlwZMk36puZD1nanptAk5M
 N98eEzFRDRnWX7ShP3HaxXEPDyC98/xCquVqK3OxENM71GgAY5CSbwiSbXh6lQn8VTZh
 7v2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727892376; x=1728497176;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tEAo1oH+MhSaFS6az2wX8kCjONWVnHZfwbRWsJF/fbA=;
 b=P7Biallp1rE0e+p4v5Gbb9LUoKTEi9Xkh7gJ0hm4fqER5VTKl+FwORp6j2uwIam3Ng
 tQb2WVVYFjtQXUDn3na3+gYnZuvlgdnPEoDUz7X/VVQdqxOM04s1AuvkKIPaZrbLZmiH
 WsLDQ59MFYfE30UOS2BHMqACWkL7bj3yORv3xUx5b2Y32TgJD8F6M7TMfOlK+Ds7JlYM
 Xai9nbVYHoXNLc/5jMouP1AzCbYc2qcGmXOEJLGlwHMImys1cnxH6VI8/Jjk9YqAa6Ky
 /GH12JWWIK0mD1D35m5GKGW9baHTXRU2r9ERQjfbI4RP/brMt1ocbfkuvInaxua4B6Vj
 UqBg==
X-Gm-Message-State: AOJu0YxdaeR5vLAPoLVwGr5Y6UlDRgK93ZIjOzZ2jpcS+m3FauZwPImW
 Qv857bVQBvMQUIcglZ8B1vGoBTB5D8LcT2sNibwls9qgHL7dBR2r0UAnRlQxm08=
X-Google-Smtp-Source: AGHT+IF1GwoDHlUe1kjO+VUW+MfyAoRoYK+3i5FfBAJPWoIvH8x+TBT66dEV9U25sIBSUf4h9Bhshg==
X-Received: by 2002:a17:903:112:b0:20b:9f1c:6877 with SMTP id
 d9443c01a7336-20bc5a879d8mr42013355ad.57.1727892375730; 
 Wed, 02 Oct 2024 11:06:15 -0700 (PDT)
Received: from [192.168.68.110] (200-206-229-93.dsl.telesp.net.br.
 [200.206.229.93]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e5fd40sm86754215ad.266.2024.10.02.11.06.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2024 11:06:15 -0700 (PDT)
Message-ID: <046df1e9-5e4c-4f1c-8edb-1ee1244fe340@ventanamicro.com>
Date: Wed, 2 Oct 2024 15:06:11 -0300
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
 <f4c52806-1722-43fc-b4b4-ab17c930d4cd@ventanamicro.com>
 <ZvaN7-W4VLr6TGsm@redhat.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <ZvaN7-W4VLr6TGsm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
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



On 9/27/24 7:50 AM, Daniel P. Berrangé wrote:
> Markus: QAPI design Qs for you at the bottom
> 
> On Wed, Sep 25, 2024 at 10:19:33AM -0300, Daniel Henrique Barboza wrote:
>>
>>
>> On 9/19/24 9:22 AM, Daniel P. Berrangé wrote:
>>> On Thu, Sep 19, 2024 at 08:20:56AM -0300, Daniel Henrique Barboza wrote:
>>>> Add a QMP command that shows all specific properties of the current
>>>> accelerator in use.
>>>
>>> Why do we need to expose /everything/ ?
>>
>> I wouldn't mind pick and choose advertised properties for the accelerators
>> like we do with other APIs.
>>
>> This would mean that each arch should choose what to advertise or not, given that
>> some accelerator properties might be relevant just for some archs. The API would
>> be implemented by each arch individually.
> 
> Well with qemu-system-any we might get multiple arches reporting
> info in the same binary, so we'll need to fan out to fill in the
> per-arch info, after doing a common base.
> 
> Hmmm, i wonder if qemu-system-any will support mixing KVM and TCG ?
> ie KVM for the host native accelerator, combined with TCG for the
> foreign archs ??? Hopefully not !

If you're talking about Phil's patches it seems that it'll be TCG only:

https://lore.kernel.org/qemu-devel/20240305220938.85410-1-philmd@linaro.org/

Patch 2 commit msg states:

------
Add the 'any'-architecture target.

- Only consider 64-bit targets
- Do not use any hardware accelerator (except qtest)
- For architecture constants, use:
   . max of supported targets phys/virt address space
   . max of supported targets MMU modes
   . min of supported targets variable page bits
------


Thanks,

Daniel



> 
>>>> This can be used as a complement of other APIs like query-machines and
>>>> query-cpu-model-expansion, allowing management to get a more complete
>>>> picture of the running QEMU process.
>>>
>>> query-machines doesn't return every single QOM property, just
>>> a hand selected set of information pieces.
>>>
>>> The query-cpu-model-expansion does return everything, but I
>>> consider that command to be bad design, as it doesn't distinguish
>>> between hardware CPU features, and QEMU QOM properties
>>>
>>>>
>>>> This is the output with a x86_64 TCG guest:
>>>>
>>>> $ ./build/qemu-system-x86_64 -S  -display none -accel tcg -qmp tcp:localhost:1234,server,wait=off
>>>>
>>>> $ ./scripts/qmp/qmp-shell localhost:1234
>>>> Welcome to the QMP low-level shell!
>>>> Connected to QEMU 9.1.50
>>>>
>>>> (QEMU) query-accelerator
>>>> {"return": {"name": "tcg", "props": {"one-insn-per-tb": false, "thread": "multi", "tb-size": 0, "split-wx": false, "type": "tcg-accel"}}}
>>>>
>>>> And for a x86_64 KVM guest:
>>>>
>>>> $ ./build/qemu-system-x86_64 -S  -display none -accel kvm -qmp tcp:localhost:1234,server,wait=off
>>>>
>>>> $ ./scripts/qmp/qmp-shell localhost:1234
>>>> Welcome to the QMP low-level shell!
>>>> Connected to QEMU 9.1.50
>>>>
>>>> (QEMU) query-accelerator
>>>> {"return": {"name": "KVM", "props": {"mem-container-smram[0]": "", "xen-gnttab-max-frames": 64, "device": "", "xen-version": 0, "mem-smram[0]": "", "notify-window": 0, "dirty-ring-size": 0, "kvm-shadow-mem": -1, "type": "kvm-accel", "notify-vmexit": "run", "xen-evtchn-max-pirq": 256}}}
>>>>
>>>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>>> ---
>>>>    hw/core/machine-qmp-cmds.c | 34 ++++++++++++++++++++++++++++++++++
>>>>    qapi/machine.json          | 27 +++++++++++++++++++++++++++
>>>>    2 files changed, 61 insertions(+)
>>>>
>>>> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
>>>> index 130217da8f..eac803bf36 100644
>>>> --- a/hw/core/machine-qmp-cmds.c
>>>> +++ b/hw/core/machine-qmp-cmds.c
>>>
>>>> +AccelInfo *qmp_query_accelerator(Error **errp)
>>>> +{
>>>> +    AccelState *accel = current_accel();
>>>> +    AccelClass *acc = ACCEL_GET_CLASS(accel);
>>>> +    AccelInfo *info = g_new0(AccelInfo, 1);
>>>> +    QDict *qdict_out = qdict_new();
>>>> +    ObjectPropertyIterator iter;
>>>> +    ObjectProperty *prop;
>>>> +
>>>> +    info->name = g_strdup(acc->name);
>>>> +
>>>> +    object_property_iter_init(&iter, OBJECT(accel));
>>>> +    while ((prop = object_property_iter_next(&iter))) {
>>>> +        QObject *value;
>>>> +
>>>> +        if (!prop->get) {
>>>> +            continue;
>>>> +        }
>>>> +
>>>> +        value = object_property_get_qobject(OBJECT(accel), prop->name,
>>>> +                                                  &error_abort);
>>>> +        qdict_put_obj(qdict_out, prop->name, value);
>>>> +    }
>>>
>>> I'm not at all convinced trhat we should be exposing every single
>>> QOM property on the accelerator class as public QMP data
>>>
>>>> +
>>>> +    if (!qdict_size(qdict_out)) {
>>>> +        qobject_unref(qdict_out);
>>>> +    } else {
>>>> +        info->props = QOBJECT(qdict_out);
>>>> +    }
>>>> +
>>>> +    return info;
>>>> +}
>>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>>> index a6b8795b09..d0d527d1eb 100644
>>>> --- a/qapi/machine.json
>>>> +++ b/qapi/machine.json
>>>> @@ -1898,3 +1898,30 @@
>>>>    { 'command': 'x-query-interrupt-controllers',
>>>>      'returns': 'HumanReadableText',
>>>>      'features': [ 'unstable' ]}
>>>> +
>>>> +##
>>>> +# @AccelInfo:
>>>> +#
>>>> +# Information about the current accelerator.
>>>> +#
>>>> +# @name: the name of the current accelerator being used
>>>> +#
>>>> +# @props: a dictionary of the accelerator properties
>>>> +#
>>>> +# Since: 9.2
>>>> +##
>>>> +{ 'struct': 'AccelInfo',
>>>> +  'data': { 'name': 'str',
>>>> +            '*props': 'any' } }
>>>
>>> This is way too open ended. IMHO ideally we would never add more
>>> instances of the 'any' type, as it has many downsides
>>>
>>>    - zero documentation about what is available
>>>    - no version info about when each prop was introduced
>>>    - no ability to tag fields as deprecated
>>>
>>> For this new API, IMHO 'name' should be an enumeration of the
>>> accelerator types, and thenm 'props' should be a discrinated
>>> union of accelerator specific structs
>>
>> We have accelerator properties that differs from arch to arch, e.g. x86 has properties like
>> notify-vmexit, declared in kvm_arch_accel_class_init() from target/i386/kvm/kvm.c, that no
>> other arch has access to. RISC-V has its own share of these properties too.
>>
>> Is it possible to declare specific structs based on arch for the API? In a quick glance
>> it seems like we're doing something like that with query-cpus-fast, where s390x has
>> additional properties that are exposed.
> 
> To allow for qemu-system-any, which will eventually have multiple arches in
> one, I guess we'll need multiple levels of nesting. Perhaps  something like
> this:
> 
>    { 'enum': 'AccelType',
>      'data': ['tcg', 'kvm', ....] }
> 
>    { 'union': 'AccelInfo',
>      'type': 'AccelType',
>      'data': {
>          'tcg': 'AccelInfoTCG',
> 	'kvm': 'AccelInfoKVM',
>      } }
> 
>    { 'struct': 'AccelInfoTCGX86',
>      'data': {
>          'notify-vmexit': ...
>      } }
> 
>    { 'struct': 'AccelInfoTCGArch',
>      'data': {
>         'x86': 'AccelInfoTCGX86',
>         'riscv': 'AccelInfoTCGRiscV',
>         ...etc...
>      }
> 
>    { 'struct': 'AccelInfoTCG',
>      'data': {
>           ...non-arch specific fields...,
> 	 'arch': 'AccelInfoTCGArch',
>      } }
> 
>   ...equiv AccelInfoKVM* structs....
> 
> Markus:  any other/better ideas ?
> 
>>>> +
>>>> +##
>>>> +# @query-accelerator:
>>>> +#
>>>> +# Shows information about the accelerator in use.
>>>> +#
>>>> +# Returns: a CpuModelExpansionInfo describing the expanded CPU model
>>>> +#
>>>> +# Since: 9.2
>>>> +##
>>>> +{ 'command': 'query-accelerator',
>>>> +  'returns': 'AccelInfo' }
>>>> -- 
> 
> With regards,
> Daniel

