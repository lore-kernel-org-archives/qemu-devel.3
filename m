Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBBAC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 15:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpr7B-0007Fq-DX; Wed, 05 Mar 2025 10:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpr79-0007Fa-S5
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:56:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpr77-0005Le-RD
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741190211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GfIKL+pGtHkECjYsaUL0ofqXC8SEg9z4KNBSJJ5LoRk=;
 b=IFmjQP0eITW8zdQHlpwgQINUJXIB57x7KDCU3Mbw9X4ffJYzphmsrvvZW99RU0SaaiPmrm
 R5tNSnl1UBUxo4Po6CWmk+LRirlMD9Au3XpgcM6Viv59Wk0ZCeAUr17Yn82Ggb8CBrkbkT
 rPNTMskE1nlFBf8yK5MQO5dCJlzOii4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-LyAAJOfTPJqVoHRsPwrtmg-1; Wed, 05 Mar 2025 10:56:48 -0500
X-MC-Unique: LyAAJOfTPJqVoHRsPwrtmg-1
X-Mimecast-MFC-AGG-ID: LyAAJOfTPJqVoHRsPwrtmg_1741190207
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3910b93cb1eso1638145f8f.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 07:56:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741190207; x=1741795007;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GfIKL+pGtHkECjYsaUL0ofqXC8SEg9z4KNBSJJ5LoRk=;
 b=QGzJOWgIpO3OqyCivnYYHnE4/4M00KxO11LHmZtG+c3AhFEx4r3CuAXhz2pg2h63Ty
 sc8ZVhdJJ8PlWABLNFiGxo23Vv1F6rZwVnrAtMq/K4Sa+fR1TNKKjh4vYfftB/jnwOSQ
 Kl1lPSe5Sg1pZsB1d64O7GLkAPohvVq7uSOdudH1xgSOkgqfic4qetz4Aq7IMT59dvDq
 wmiuDGOEN2saetPjZEWwiSBw2sss+VQoKra515ldLLyfMuq+q1tpaIObb6RcymmTEP9x
 sjuujqv/Ec79tEoeoJLEoswmULZWaVtnGL0YxtfQEdW/k+rXAtdhv3qnLnTsL3F/I/Lq
 ZlHg==
X-Gm-Message-State: AOJu0YwksTSrm2ETBCXAGsg8wviORJRW2lciim1MdxBJMVD2UbB9on7G
 LaImSvP7fF91QJIUqEewzY46pjGPyb9nwryc9y/jlhi/koQMo6XUz3vU5wXo/E4hJTRMC/GA+al
 t8L5f8t+N3LDvAf1a3f5ZKWQl6RPRDlfOppuk/wV0pD6fBEfI/mCG
X-Gm-Gg: ASbGncvV65J1MjcL/4RUKMsxyMFTxQFKnw0RuN7/qF/v1fDh1vCjwQWqpZVARIBmHi9
 H6dfdCVp+lGjKqCWt3k0fsKJO0/DOfBGlusylSf/aQTS+c6s/mn8ffpUfnm0yQ7egfC7mUjoFhu
 hDdMGfBDyBWV1uZWfwGqn0GX5aR8X/E7foGTW/4uRyF9P9xt1OQGpvhfEvGsOTjoBU5ag6lB9kI
 6tuLfxllT2sL2iznixwO+q6LIT7N5VniV9xcAHlqORMivxsKjSC0tSK3I4mJqLARnvlRyI2NfuR
 KLzuk+GhgvlkWQRHk1/G52nFoYWNipQt7grRmOrA6iBynMg=
X-Received: by 2002:a5d:6da5:0:b0:391:80f:8051 with SMTP id
 ffacd0b85a97d-3911f755903mr3893532f8f.21.1741190207126; 
 Wed, 05 Mar 2025 07:56:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqp3rY8KPOoYuS84YjxRhmR8dG+tvoE6cAr48PltoXw74TzQCpoIKUmczfJAZrI2SPWvV/Sw==
X-Received: by 2002:a5d:6da5:0:b0:391:80f:8051 with SMTP id
 ffacd0b85a97d-3911f755903mr3893510f8f.21.1741190206722; 
 Wed, 05 Mar 2025 07:56:46 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485d785sm21298906f8f.83.2025.03.05.07.56.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 07:56:46 -0800 (PST)
Message-ID: <48caabe7-c112-4454-96a8-742d154c77ee@redhat.com>
Date: Wed, 5 Mar 2025 16:56:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v2 1/3] hw/s390x: add CPI identifiers to QOM
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 qemu-s390x mailing list <qemu-s390x@nongnu.org>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
References: <20250224120449.1764114-1-shalini@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250224120449.1764114-1-shalini@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 24/02/2025 13.04, Shalini Chellathurai Saroja wrote:
> Add Control-Program Identification (CPI) to the QEMU Object
> Model (QOM). The CPI identifiers provide information about
> the guest operating system. The CPI identifiers are:
> system type, system name, system level and sysplex name.
> 
> The system type provides the OS type of the guest (e.g. LINUX).
> The system name provides the name of the guest (e.g. TESTVM).
> The system level provides the distribution and kernel version
> of the guest OS (e.g. 0x50e00).
> The sysplex name provides the sysplex name of the guest
> (e.g. SYSPLEX).
> 
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> ---
>   hw/s390x/s390-virtio-ccw.c         | 29 +++++++++++++++++++++++++++++
>   include/hw/s390x/s390-virtio-ccw.h |  8 ++++++++
>   qapi/machine.json                  | 24 ++++++++++++++++++++++++
>   3 files changed, 61 insertions(+)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 51ae0c133d..13ea8db1b0 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -50,6 +50,7 @@
>   #include "hw/s390x/virtio-ccw-md.h"
>   #include "system/replay.h"
>   #include CONFIG_DEVICES
> +#include "qapi/qapi-visit-machine.h"
>   
>   static Error *pv_mig_blocker;
>   
> @@ -803,6 +804,26 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
>       s390_ipl_fmt_loadparm(ms->loadparm, val, errp);
>   }
>   
> +static void machine_get_control_program_id(Object *obj, Visitor *v,
> +                                           const char *name, void *opaque,
> +                                           Error **errp)
> +{
> +    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
> +    S390ControlProgramId *cpi;
> +    cpi = &(S390ControlProgramId){
> +        .system_type = g_strndup((char *) ms->cpi.system_type,
> +                       sizeof(ms->cpi.system_type)),
> +        .system_name = g_strndup((char *) ms->cpi.system_name,
> +                       sizeof(ms->cpi.system_name)),
> +        .system_level = g_strdup_printf("0x%lx", ms->cpi.system_level),
> +        .sysplex_name = g_strndup((char *) ms->cpi.sysplex_name,
> +                        sizeof(ms->cpi.sysplex_name)),
> +        .timestamp = ms->cpi.timestamp
> +    };

Could you please indend the sizeof() lines with the "(" after the g_strndup 
in the previous line?

> +
> +    visit_type_S390ControlProgramId(v, name, &cpi, &error_abort);
> +}
> +
>   static void ccw_machine_class_init(ObjectClass *oc, void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> @@ -854,6 +875,14 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
>               "Up to 8 chars in set of [A-Za-z0-9. ] (lower case chars converted"
>               " to upper case) to pass to machine loader, boot manager,"
>               " and guest kernel");
> +    object_class_property_add(oc, "s390-control-program-id",

I think I'd rather drop the "s390-" prefix here. The property is already 
part of the s390-virtio-ccw machine, so it should be obvious that this is 
related to s390.

> +                              "S390ControlProgramId",
> +                              machine_get_control_program_id,
> +                              NULL, NULL, NULL);
> +    object_class_property_set_description(oc, "s390-control-program-id",
> +        "Control-progam identifiers provide data about the guest "

s/progam/program/

> +        "operating system");
> +
>   }
>   
>   static inline void s390_machine_initfn(Object *obj)
> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
> index 686d9497d2..6872f7a176 100644
> --- a/include/hw/s390x/s390-virtio-ccw.h
> +++ b/include/hw/s390x/s390-virtio-ccw.h
> @@ -19,6 +19,13 @@
>   
>   OBJECT_DECLARE_TYPE(S390CcwMachineState, S390CcwMachineClass, S390_CCW_MACHINE)
>   
> +typedef struct ControlProgramId {
> +    uint8_t system_type[8];
> +    uint8_t system_name[8];
> +    uint64_t system_level;
> +    uint8_t sysplex_name[8];
> +    uint64_t timestamp;
> +} QEMU_PACKED ControlProgramId;
>   
>   struct S390CcwMachineState {
>       /*< private >*/
> @@ -33,6 +40,7 @@ struct S390CcwMachineState {
>       uint64_t max_pagesize;
>   
>       SCLPDevice *sclp;
> +    ControlProgramId cpi;
>   };
>   
>   static inline uint64_t s390_get_memory_limit(S390CcwMachineState *s390ms)
> diff --git a/qapi/machine.json b/qapi/machine.json
> index a6b8795b09..c6cbad87e1 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1898,3 +1898,27 @@
>   { 'command': 'x-query-interrupt-controllers',
>     'returns': 'HumanReadableText',
>     'features': [ 'unstable' ]}
> +
> +##
> +# @S390ControlProgramId:
> +#
> +# Control-program identifiers provide data about Linux instance.

If I understood correctly, this could also theoretically be used by other 
guest operating systems? If so, please replace "Linux instance" with "guest 
operating system".

> +#
> +# @system-type: operating system of Linux instance

Replace with:

  @system-type: operating system (e.g. "LINUX")

?

> +#
> +# @system-name: system name of Linux instance

Name of the VM instance ?

> +# @system-level: distribution and kernel version of Linux instance
> +#
> +# @sysplex-name: sysplex name of Linux instance
> +#
> +# @timestamp: latest update of CPI data
> +#
> +# Since: 9.2

9.2 has already been released, so this should be 10.0.

> +##
> +{ 'struct': 'S390ControlProgramId', 'data': {
> +     'system-type': 'str',
> +     'system-name': 'str',
> +     'system-level': 'str',

Not sure, but would it make sense to use a number for the system-level 
instead? At least it's a number in ControlProgramId, not a string.

  Thomas


> +     'sysplex-name': 'str',
> +     'timestamp': 'uint64' } }


