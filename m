Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF78AC0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 08:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfEkx-0000rw-4x; Tue, 04 Feb 2025 03:58:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tfEkv-0000rn-Vq
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 03:58:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tfEku-0005n0-1e
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 03:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738659481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YY3UtufEO171DklhASd16dhfk6PArhsLRalktNMvttk=;
 b=d80GCpVa0KqQmdccHASEockjmXMym/s0bM4WAGL1wj9PQim9lywnZdxaeaLZ1OeB+HJhjG
 qhHvfjz78PJQcjb0sOImn/eiUhwkl0leeOSM1yODFUtsrC6rA5A2KXpzpqxYv2a8IUmh/c
 f3xretMX3SXSPj65cunSBav5OG0X03U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-kjO8bH1FP9KiogKS8WdaCQ-1; Tue, 04 Feb 2025 03:57:55 -0500
X-MC-Unique: kjO8bH1FP9KiogKS8WdaCQ-1
X-Mimecast-MFC-AGG-ID: kjO8bH1FP9KiogKS8WdaCQ
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ab6d6a9bda9so507452966b.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 00:57:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738659474; x=1739264274;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YY3UtufEO171DklhASd16dhfk6PArhsLRalktNMvttk=;
 b=tm55JdQy/LqUuEB4mxFChuRffCnN3oEGvdlbqoK5D20SFz5oMK6B2YGlgBdeN11WNG
 ScAPLqcSG1R/nrqbYXHXlxmCF1aHwmFRmX6rDYvwfzy7VwN9De7a/zxQVLWQglxj9Dp7
 /iqoggzMkaR3bQVwWg6hXbhLLY9Z2haob8lC9zePN3RtRT7HDMCO63tQhOm4h3/XhgTu
 RX5ehgsVwMxqnHGE9CVDCPRDiJsKQo929Jh1LkZMrXgmHUFGMv2xo4etl8C4jDEiEcOd
 h0FZw8ysrN0rDc/iVw3ApDWebwdKi2+oihrLyBxVc8PzjPzLzL9vP2GNPpZt/xVS+xsi
 y5Ag==
X-Gm-Message-State: AOJu0YyxB+OqxVcqhpVH141CC5DD5e0h7WaL+EdIFj/B86xMPBIt5shp
 fgS8JwYqmV311d1IN//c/UBNed4FMO3fpLB0X0fNU3K618TgXv9114Sl5JiuSAd8RpgZPVCxkLk
 paalaG2CzIYY3qJkBRz/8EH/DG+wFWAQmksKjqOwJeseZWWyZI72X
X-Gm-Gg: ASbGnctmN+N2Q8O5G5C3Fy2xcgy/hCYGv1v3xExpl8yhoW8sJeR5Fzmb082mqLpdpUX
 87dUeqtx0p/hBW3zJ8Dyh5myQoWVVXIeseM2nloD8/MNg7aMRtwttjroKTAuxekrfXKtjNHR1Mz
 SORVOi08Wmu6nx2OtyXOSgMGxNL/eUxdBRtSPWCLGk+lM9xiuP5kEYVWWjq+aDu8/DsZG/uq5MS
 ypXcs/3wuj4VhBX3M78FZqn274JXXrLSWbSuww7Mr62YnpM5d2vnWOkC5J09Fok1MMFQ9tHhhtP
 qBbOrX1tDAUAhs5YvqW2h4jBwwctzCv2bHQo
X-Received: by 2002:a17:907:d91:b0:aac:619:e914 with SMTP id
 a640c23a62f3a-ab6cfce1b88mr2639941366b.16.1738659473986; 
 Tue, 04 Feb 2025 00:57:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEk9oxNBcX23Fqvqason2JnGimxI95LVQdgtOf0AfZX/E5m2RPYuFVg9QlbHHkF7N3GupARTA==
X-Received: by 2002:a17:907:d91:b0:aac:619:e914 with SMTP id
 a640c23a62f3a-ab6cfce1b88mr2639938466b.16.1738659473542; 
 Tue, 04 Feb 2025 00:57:53 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-132.web.vodafone.de.
 [109.42.48.132]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e47f205bsm880451466b.86.2025.02.04.00.57.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 00:57:53 -0800 (PST)
Message-ID: <023ea75f-855d-4e95-82e4-05015554a0c6@redhat.com>
Date: Tue, 4 Feb 2025 09:57:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/pc: Fix crash that occurs when introspecting
 TYPE_PC_MACHINE machines
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250117192106.471029-1-thuth@redhat.com>
 <7e719e2d-1f89-4f67-b519-3279f18bccd6@redhat.com>
 <20250129150352-mutt-send-email-mst@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250129150352-mutt-send-email-mst@kernel.org>
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

On 29/01/2025 21.04, Michael S. Tsirkin wrote:
> On Wed, Jan 29, 2025 at 08:00:40AM +0100, Thomas Huth wrote:
>> On 17/01/2025 20.21, Thomas Huth wrote:
>>> QEMU currently crashes when you try to inspect the machines based on
>>> TYPE_PC_MACHINE for their properties:
>>>
>>>    $ echo '{ "execute": "qmp_capabilities" }
>>>            { "execute": "qom-list-properties","arguments":
>>>                         { "typename": "pc-q35-10.0-machine"}}' \
>>>      | ./qemu-system-x86_64 -M pc -qmp stdio
>>>    {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 9},
>>>     "package": "v9.2.0-1070-g87e115c122-dirty"}, "capabilities": ["oob"]}}
>>>    {"return": {}}
>>>    Segmentation fault (core dumped)
>>>
>>> This happens because TYPE_PC_MACHINE machines add a machine_init-
>>> done_notifier in their instance_init function - but instance_init
>>> of machines are not only called for machines that are realized,
>>> but also for machines that are introspected, so in this case the
>>> listener is added for a q35 machine that is never realized. But
>>> since there is already a running pc machine, the listener function
>>> is triggered immediately, causing a crash since it was not for the
>>> right machine it was meant for.
>>>
>>> Such listener functions must never be installed from an instance_init
>>> function. Let's do it from pc_basic_device_init() instead - this
>>> function is called from the MachineClass->init() function instead,
>>> i.e. guaranteed to be only called once in the lifetime of a QEMU
>>> process.
>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2779
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>    hw/i386/pc.c | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>> index b46975c8a4..85b8a76455 100644
>>> --- a/hw/i386/pc.c
>>> +++ b/hw/i386/pc.c
>>> @@ -1241,6 +1241,9 @@ void pc_basic_device_init(struct PCMachineState *pcms,
>>>        /* Super I/O */
>>>        pc_superio_init(isa_bus, create_fdctrl, pcms->i8042_enabled,
>>>                        pcms->vmport != ON_OFF_AUTO_ON, &error_fatal);
>>> +
>>> +    pcms->machine_done.notify = pc_machine_done;
>>> +    qemu_add_machine_init_done_notifier(&pcms->machine_done);
>>>    }
>>>    void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
>>> @@ -1714,9 +1717,6 @@ static void pc_machine_initfn(Object *obj)
>>>        if (pcmc->pci_enabled) {
>>>            cxl_machine_init(obj, &pcms->cxl_devices_state);
>>>        }
>>> -
>>> -    pcms->machine_done.notify = pc_machine_done;
>>> -    qemu_add_machine_init_done_notifier(&pcms->machine_done);
>>>    }
>>>    static void pc_machine_reset(MachineState *machine, ResetType type)
>>
>> Friendly ping!
>>
>>   Thomas
> 
> 
> donnu how i missed it.  pls address Philip's comment though.

  Hi Michael,

I think we should *not* rename pc_machine_done() since this is about a 
"machine_done" notifier, not about a "basic_device_init_done" or whatever 
notifier. So I'd prefer if we can keep this patch as it is. Unless you 
disagree, could you please pick this up?

  Thanks,
   Thomas


