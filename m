Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA12C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 07:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWt4q-0003Vz-9H; Thu, 25 Jul 2024 03:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sWt4o-0003V0-Fy
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 03:39:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sWt4l-0000Rg-29
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 03:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721893185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aPtTy+hiTTCQNg8ISQGE+rv3Oo2dekazPYwXABRGyTM=;
 b=WXvN91XB2rYoyQlJj8TFb/TesdCug/Z4Nlk+FuLlSeerkJm5Pct8onFBM5IFdlgyJq5Z0n
 I3YwRG1F8cZyHyweNbtQI0ELZC9IFgxS5NMsx1UEicywX3jG/wW/LdZ1exTGk0iIIzSXX3
 G7JvrNKeTEx9mwODgmIQ+rddS6lntlI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-Q4GhhlPpOZyB_65vkhy_pg-1; Thu, 25 Jul 2024 03:39:44 -0400
X-MC-Unique: Q4GhhlPpOZyB_65vkhy_pg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-428077f91a9so1353485e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 00:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721893183; x=1722497983;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aPtTy+hiTTCQNg8ISQGE+rv3Oo2dekazPYwXABRGyTM=;
 b=KDa3w5rHPfanN+C5R4NV9i9w2qrdV8kAbB/xZXxjRcEg0GjLM2tHsEzA9CnO/uGoQ9
 useRdJdjmBmGC8h9H/umJmKMDt4qV8dhkGxepq1jK4GWsSVIxW3dWKqsj8QlBYXLQ0vh
 o4sbqsoCyIDimPO6MIWlXE5q06njRX52lIWDlep5+LExV0RGyIPnuNkDYhYuqQrMZfAg
 t4SB3OS3BrW2jwdcC/JxL+N4+LvMMiXg9oGTS37AwaV2fwc4YLeDCdt/NT2RNjHFitMV
 lGnb76wG7D/wE1RtEKD1C/0ZQEk4nSFXschEOrlH3Yumk9mAnemtxffbFCue/nGCIjuY
 iRJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPodKlV/9oVZm24VnrxfIhHEuIEPiZrz68smtAPKH9yMCZAsUd4xVtmQoTXKjkLAtklDwDK/Jgw9OLN4kxTV4w8l+Zw/Q=
X-Gm-Message-State: AOJu0YzjT5CcLfCs8XLQqvKpTfQ9WwikpyhdVQfYk5FAEzVEXi+YOFqv
 3G1FKTSIcqqb1pI9ANkt5olEGC31MkZDho50ERX+IdY3MxKxKJJ2BY5Gpe5OEIsQv5Zf4fgp62I
 a41K8N/taYZR6ZjQLR7D7bq4vkksjevaQPOeAiWNPG813sLQj2ZdI
X-Received: by 2002:a05:600c:3c92:b0:426:711c:6591 with SMTP id
 5b1f17b1804b1-427f99eeedcmr34438085e9.4.1721893183158; 
 Thu, 25 Jul 2024 00:39:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXk7TlIy5RWL67UMGsCUP04RVwo6TiupJHFFzo8OPzZcPlyIwNDDNf+sRguIehqGhSDmF0/g==
X-Received: by 2002:a05:600c:3c92:b0:426:711c:6591 with SMTP id
 5b1f17b1804b1-427f99eeedcmr34437805e9.4.1721893182633; 
 Thu, 25 Jul 2024 00:39:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:2c00:5f6:3120:375a:3e4?
 (p200300cbc7062c0005f63120375a03e4.dip0.t-ipconnect.de.
 [2003:cb:c706:2c00:5f6:3120:375a:3e4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f9372a3fsm63111605e9.13.2024.07.25.00.39.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 00:39:42 -0700 (PDT)
Message-ID: <d20cdad7-89c2-47f7-8acf-dcce767d8db5@redhat.com>
Date: Thu, 25 Jul 2024 09:39:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/s390x: filter deprecated properties based on
 model expansion type
To: Markus Armbruster <armbru@redhat.com>
Cc: Collin Walling <walling@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, thuth@redhat.com, wangyanan55@huawei.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 Jiri Denemark <jdenemar@redhat.com>
References: <20240719181741.35146-1-walling@linux.ibm.com>
 <87h6cksk4h.fsf@pond.sub.org>
 <28ea8260-a411-4651-8e2a-1fcc009f5043@linux.ibm.com>
 <87bk2nrzou.fsf@pond.sub.org>
 <9f8023a4-3edd-476f-9243-677138be3921@linux.ibm.com>
 <87cyn2ugyi.fsf@pond.sub.org> <87v80tudo7.fsf@pond.sub.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <87v80tudo7.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25.07.24 09:35, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
>> Collin Walling <walling@linux.ibm.com> writes:
>>
>>> On 7/24/24 3:56 AM, Markus Armbruster wrote:
>>>> Collin Walling <walling@linux.ibm.com> writes:
>>> Let me try to explain the purpose of @deprecated-props and see if it
>>> helps bring us closer to some semblance of a mutual understanding so we
>>> can work together on a concise documentation for this field.
>>>
>>> s390 has been announcing features as deprecated for some time now, which
>>> was fine as a way to let users know that they should tune their guests
>>> to no longer user these features.  Now that we are approaching the
>>> release of generations that will drop these deprecated features
>>> outright, we encounter an issue: if users have not been mindful with
>>> disabling these announced-deprecated-features, then their guests running
>>> on older models will not be able to migrate to machines running on newer
>>> hardware.
>>>
>>> To alleviate this, I've added the @deprecated-props array to the
>>> CpuModelInfo struct, and this field is populated by a
>>> query-cpu-model-expansion* return.  It is up the the user/management app
>>> to make use of this data.
>>>
>>> On the libvirt side (currently in development), I am able to easily
>>> retrieve the host-model with a full expansion, parse the
>>> @deprecated-props, and then cache them for later use (e.g. when
>>> reporting the host-model with these features disabled, or enabling a
>>> user to define their domain with deprecated-features disabled via a
>>> convenient XML attribute).
>>>
>>> tl;dr @deprecated-props is only reported via a
>>> query-cpu-model-expansion, and it is up to the user/management app to
>>> figure out what to do with them.
>>
>> Got it.
>>
>> Permit me a digression.  In QAPI/QMP, we do something similar: we expose
>> deprecation in introspection (query-qmp-schema), and what to do with the
>> information is up to the management application.  We provide one more
>> tool to it: policy for handling deprecated interfaces, set with -compat.
>> It permits "testing the future".  See qapi/compat.json for details.
>> Whether such a thing would be usful in your case I can't say.
>>
>>>> On closer examination, more questions on CpuModelInfo emerge.  Uses:
>>>>
>>>
>>> I will attempt to expand on each input @model (CpuModelInfo) as if they
>>> were documented in the file.
>>>
>>>> * query-cpu-model-comparison both arguments
>>>>
>>>>    Documentation doesn't say how exactly the command uses the members of
>>>>    CpuModelInfo, i.e. @name, @props, @deprecated-props.  Can you tell me?
>>>>
>>>
>>> Note: Compares ModelA and ModelB.
>>>
>>> Both @models must include @name.  @props is optional.  @deprecated-props
>>> is ignored.
>>>
>>> @name: the name of the CPU model definition to look up.  The definition
>>> will be compared against the generation, GA level, and a static set of
>>> properties of the opposing model.
>>>
>>> @props: a set of additional properties to include in the model's set of
>>> properties to be compared.
>>>
>>> @deprecated-props: ignored.  The user should consider these properties
>>> beforehand and decide if these properties should be disabled/omitted on
>>> the respective model.
>>>
>>>> * query-cpu-model-expansion argument @model and return value member
>>>>    @model.
>>>>
>>>>    The other argument is the expansion type, on which the value of return
>>>>    value model.deprecated-props depends, I believe.  Fine.
>>>>
>>>>    Documentation doesn't say how exactly the command uses the members of
>>>>    CpuModelInfo arguments, i.e. @name, @props, @deprecated-props.  Can
>>>>    you tell me?
>>>>
>>>
>>> The @model must include @name.  @props is optional.  @deprecated-props
>>> is ignored.
>>>
>>> @name: the name of the CPU model definition to look up.  The definition
>>> is associated with a set of properties that will populate the return data.
>>>
>>> @props: a set of additional properties to include in the model's set of
>>> expanded properties.
>>>
>>> @deprecated-props: ignored.  The user should consider these properties
>>> beforehand and decide if these properties should be disabled/omitted on
>>> the model.
>>
>> Return value member @model will have @name, may have @props and
>> @deprecated-props.
>>
>> Absent @props is the same as {}.  Only x86 uses {}.
>>
>> Absent @deprecated-props is the same as {}.  No target uses {}.  Can be
>> present only on S390.
>>
>> Aside: returning the same thing in two different ways, like absent and
>> {}, is slightly more complex than necessary.  But let's ignore that
>> here.
>>
>>>> * query-cpu-model-baseline both arguments and return value member
>>>>    @model.
>>>>
>>>>    Same, except we don't have an expansion type here.  So same question,
>>>>    plus another one: how does return value model.deprecated-props behave?
>>>>
>>>
>>> Note: Creates a baseline model based on ModelA and ModelB.
>>>
>>> The @models must include @name.  @props is optional.  @deprecated-props
>>> is ignored.
>>>
>>> @name: the name of the CPU model definition to look up.  The definition,
>>> GA level, and a static set of properties will be used to determine the
>>> maximum model between ModelA and ModelB.
>>>
>>> @props: a set of additional properties to include in the model's set of
>>> properties to be baselined.
>>>
>>> @deprecated-props: ignored.  The user should consider these properties
>>> beforehand and decide if these properties should be disabled/omitted on
>>> the respective model.
>>
>> Return value member @model is just like in query-cpu-model-expansion.
>>
>> Unlike query-cpu-model-expansion, we don't have an expansion type.  The
>> value of @deprecated-props depends on the expansion type.  Do we assume
>> a type?  Which one?
>>
>>>> If you can't answer my questions, we need to find someone who can.
>>>>
>>>
>>> Hopefully this provides clarity on how CpuModelInfo and its respective
>>> fields are used in each command.  @David should be able to fill in any
>>> missing areas / expand / offer corrections.
>>>
>>>> [...]
>>
>> This helps, thanks!
>>
>> Arguments that are silently ignored is bad interface design.
>>
>> Observe: when CpuModelInfo is an argument, @deprecated-props is always
>> ignored.  When it's a return value, absent means {}, and it can be
>> present only for certain targets (currently S390).
>>
>> The reason we end up with an argument we ignore is laziness: we use the
>> same type for both roles.  We can fix that easily:
>>
>>      { 'struct': 'CpuModel',
>>        'data': { 'name': 'str',
>>                  '*props': 'any' } }
>>
>>      { 'struct': 'CpuModelInfo',
>>        'base': 'CpuModel',
>>        'data': { '*deprecated-props': ['str'] } }
>>
>> Use CpuModel for arguments, CpuModelInfo for return values.
>>
>> Since @deprecated-props is used only by some targets, I'd make it
>> conditional, i.e. 'if': 'TARGET_S390X'.
> 
> If we want just query-cpu-model-expansion return deprecated properties,
> we can instead move @deprecated-props from CpuModelInfo to
> CpuModelExpansionInfo.

That might a bit more sense, because deprecated-props does not make any 
sense as input parameter, for example.

-- 
Cheers,

David / dhildenb


