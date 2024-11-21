Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1464BE64002
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 19:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tECT2-0006Z8-8q; Thu, 21 Nov 2024 14:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tECSz-0006QV-3z
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:03:49 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tECSx-0007FA-Bg
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:03:48 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4315eeb2601so14694645e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 11:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732215825; x=1732820625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x/EYQSKnaB0nQ2rrN8ALxbk8YBn9f7FB0WvyC01f9/4=;
 b=d+nJynM2+F6O/JyXzZuR+yKMUnCGcndCjgTpAeIbD4AxlAlLTbOM4yoy3Gc77n7n/4
 NnkkuMWg844++YGlGftb4sI0gbe+/GSe5AXMqUMxlePS4OwSDARQRnylIPpBR6XRhn0V
 3w7byeBkHTEwpBBHIIIU/IdFIqS7hHF6zxOE3bk1dYqxcZadUpDVfTvPAaaaG8KZD6kz
 eOgxn89MwkzHSZAIAWVrmIB5J0Wa5Zo6Z+lABiU4/f8v7u9IGZg6UpQ3sV72CWhb16VH
 99AOowtfd8FjZ5k3SBIfyg1GjjkaOG3ngBK+VF+sWMHiAi6UX6k76oj5Qdiy13Wv0J6r
 Hw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732215825; x=1732820625;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x/EYQSKnaB0nQ2rrN8ALxbk8YBn9f7FB0WvyC01f9/4=;
 b=PkzQz4YgSc6lygjyGn7FD8YwvBrbryZa5kWnvXF3bfhE0IdRt1M3rrrkiv3lswmfJL
 w4HIgJTTY9pbYZTc1Jg/+w3SKK91kEFBJ62N4nHbEGYPzFsLnf25XwQ8ikiXEpZJb8Wg
 DRU5jY2YEYBJQTJaI+id3MxK0NFFepXx4KvYjIt20oF9eN4w2mbLAkvWAyFf4SeWNyrA
 IB70lp7LUslA0AK8xlWLQONql/6rAgzKZeFQ6aqR/mEuZm5Hr+bCAoegXTkA4kwEauQ4
 JZNaDXZw3wWL7dDJw/uQOxPxbeyBWcwauLS6SafEAsX+zbzemKGRugygjt0bKXVtCzMG
 87wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPQ2OGrGBX/LMZtxsv1ytdHvs8HVOA24dyfaQijJb26sFtdr88oRefLqsPKQbVLLtCqVtENxLNNtwu@nongnu.org
X-Gm-Message-State: AOJu0Yxe+BqyZcQIV3Z/+926lIaauE72JiOi5BHhJLKU4aKBk2R9tkSH
 Ys8/Xl5ndGn4Q3u1RDeBI+Sd5dexLMA/jjg9yJv0d60KhCPRicGwCe3I+eOOXUc=
X-Gm-Gg: ASbGnct2OpE3ZkQbF+AsIRn2F80hm7vcipPmi712Yx1aQTrJ6mH9mOBJkd8djGlK92I
 skpdiIN0UqKTbthcbxLLcfE8HZ4JJz4PbeAJBbaCVXJlibAFO5TN7iblOmdjXPxLGN7HFzADrG6
 GuU7tDq1t7shddvh9aWCgbHG0DL79l++L5mpGtjNhsGUobBhsFvEMhf77CARKKFgPuVKCqc3NqG
 wn9YjWk2Ab7YiRZN3Eu1OjBR/9+mypCW4WCWVhCpoX58E+gYg8kLubgK3XY3kI9
X-Google-Smtp-Source: AGHT+IEFrXRRkDLpfgUugiemfHn67Y5bXKiXl4g70tYMd+uHUSRZ3sEcOzFX/aKUsYQiURuYr9gwNg==
X-Received: by 2002:a05:600c:5013:b0:431:54f3:11ab with SMTP id
 5b1f17b1804b1-4334f01e2a7mr75075665e9.33.1732215825444; 
 Thu, 21 Nov 2024 11:03:45 -0800 (PST)
Received: from [192.168.69.197] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45d4c68sm64092525e9.22.2024.11.21.11.03.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 11:03:44 -0800 (PST)
Message-ID: <7a3dae57-59ba-45b3-b9e1-392430efe8d2@linaro.org>
Date: Thu, 21 Nov 2024 20:03:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] qom: Create system containers explicitly
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-11-peterx@redhat.com> <Zz8LwhXsa6ail5qo@redhat.com>
 <64d02784-adde-459a-a019-10cdca93734f@linaro.org> <Zz9rDA_xlgweZzeP@x1n>
 <c68b260a-b4ee-48ec-9f5c-3c72a58f424b@linaro.org> <Zz91_IoN0e5E0v2k@x1n>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Zz91_IoN0e5E0v2k@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 21/11/24 19:03, Peter Xu wrote:
> On Thu, Nov 21, 2024 at 06:29:06PM +0100, Philippe Mathieu-Daudé wrote:
>> On 21/11/24 18:17, Peter Xu wrote:
>>> On Thu, Nov 21, 2024 at 02:01:45PM +0100, Philippe Mathieu-Daudé wrote:
>>>> On 21/11/24 11:30, Daniel P. Berrangé wrote:
>>>>> On Wed, Nov 20, 2024 at 04:57:01PM -0500, Peter Xu wrote:
>>>>>> Always explicitly create QEMU system containers upfront.
>>>>>>
>>>>>> Root containers will be created when trying to fetch the root object the
>>>>>> 1st time.  Machine sub-containers will be created only until machine is
>>>>>> being initialized.
>>>>>>
>>>>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>>>>> ---
>>>>>>     hw/core/machine.c | 19 ++++++++++++++++---
>>>>>>     qom/object.c      | 16 +++++++++++++++-
>>>>>>     2 files changed, 31 insertions(+), 4 deletions(-)
>>>>>
>>>>>
>>>>>> diff --git a/qom/object.c b/qom/object.c
>>>>>> index 214d6eb4c1..810e6f2bd9 100644
>>>>>> --- a/qom/object.c
>>>>>> +++ b/qom/object.c
>>>>>> @@ -1734,12 +1734,26 @@ const char *object_property_get_type(Object *obj, const char *name, Error **errp
>>>>>>         return prop->type;
>>>>>>     }
>>>>>> +static Object *object_root_initialize(void)
>>>>>> +{
>>>>>> +    Object *root = object_new(TYPE_CONTAINER);
>>>>>> +
>>>>>> +    /*
>>>>>> +     * Create all QEMU system containers.  "machine" and its sub-containers
>>>>>> +     * are only created when machine initializes (qemu_create_machine()).
>>>>>> +     */
>>>>>> +    container_create(root, "chardevs");
>>>>>> +    container_create(root, "objects");
>>>>>
>>>>> This is where I would expect 'backend' to have been created
>>>>> rather than ui/console.c, though you could potentially make
>>>>> a case to create it from the machine function, snice console
>>>>> stuff can't be used outside of the machine context, while
>>>>> chardevs/objects can be used in qemu-img/qemu-nbd, etc
>>>
>>> Would it hurt if we do it altogether here even if it won't be used in
>>> qemu-img/qemu-nbd?
>>>
>>> IMHO we should either make it simple (assuming empty containers won't hurt
>>> there..), or we should just leave "backend" to ui/ code, so we don't assume
>>> which binary is using the ui code: whoever uses it will create the container.
>>>
>>>>
>>>> What about creating "backend" container in qemu_create_machine()?
>>>
>>> I remember I started with that but it didn't work.  IIRC that's because
>>> machine_initfn() (or somewhere around the init code) requires the
>>> containers to present, hence it's too late even if we create the containers
>>> right after this line:
>>>
>>>       current_machine = MACHINE(object_new_with_class(OBJECT_CLASS(machine_class)));
>>
>> So qemu_create_machine_containers() really belongs to qemu_create_machine()
>> =)
> 
> Frankly, I don't immediately get this line..

"machine_initfn requires the containers to be present" -> machine_initfn
isn't the place to create them, it has to be before or after. Since it
can't be before, the "after" place is qemu_create_machine_containers().
Sorry for not being very clear :/

> 
> But when I was trying again just to check my memory, I can't see anything
> crash anymore, moving things over.
> 
> So while I'll test some more, I can switch to that if I cannot reproduce
> any issue with it.  That's:
> 
> ===8<===
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index ed613ec4cb..a72c001c3d 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1193,27 +1193,11 @@ static void machine_class_base_init(ObjectClass *oc, void *data)
>       }
>   }
>   
> -static const char *const machine_containers[] = {
> -    "unattached",
> -    "peripheral",
> -    "peripheral-anon"
> -};
> -
> -static void qemu_create_machine_containers(Object *machine)
> -{
> -    int i;
> -
> -    for (i = 0; i < ARRAY_SIZE(machine_containers); i++) {
> -        object_property_add_new_container(machine, machine_containers[i]);
> -    }
> -}
> -
>   static void machine_initfn(Object *obj)
>   {
>       MachineState *ms = MACHINE(obj);
>       MachineClass *mc = MACHINE_GET_CLASS(obj);
>   
> -    qemu_create_machine_containers(obj);
>       ms->dump_guest_core = true;
>       ms->mem_merge = (QEMU_MADV_MERGEABLE != QEMU_MADV_INVALID);
>       ms->enable_graphics = true;
> diff --git a/system/vl.c b/system/vl.c
> index 822f7ff656..cdc0b6e10c 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2112,6 +2112,21 @@ static void parse_memory_options(void)
>       loc_pop(&loc);
>   }
>   
> +static const char *const machine_containers[] = {
> +    "unattached",
> +    "peripheral",
> +    "peripheral-anon"
> +};
> +
> +static void qemu_create_machine_containers(Object *machine)
> +{
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(machine_containers); i++) {
> +        object_property_add_new_container(machine, machine_containers[i]);
> +    }
> +}
> +
>   static void qemu_create_machine(QDict *qdict)
>   {
>       MachineClass *machine_class = select_machine(qdict, &error_fatal);
> @@ -2120,6 +2135,7 @@ static void qemu_create_machine(QDict *qdict)
>       current_machine = MACHINE(object_new_with_class(OBJECT_CLASS(machine_class)));
>       object_property_add_child(object_get_root(), "machine",
>                                 OBJECT(current_machine));
> +    qemu_create_machine_containers(OBJECT(current_machine));
>       object_property_add_child(machine_get_container("unattached"),
>                                 "sysbus", OBJECT(sysbus_get_default()));
>   
> 

Yes, this is exactly what I was thinking of / expecting :)


