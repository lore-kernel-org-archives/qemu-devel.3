Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFAAC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 06:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdOL2-0002Tz-5E; Thu, 30 Jan 2025 01:47:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdOKz-0002To-PE
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 01:47:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdOKx-00078P-5e
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 01:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738219656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9+xdp+uhdMZH+f+h5dxzGq3sQBd5hYWFv6bGHjTE0nU=;
 b=BViqHnX0BAUi82KtbZbM660EHngOLevdSNQGcjzQu/WFpxWdXkpTU96CMF27BcAbVQyK+a
 hB9+Ouj1OEL3zIcWokBWskhanjhJ3V3gw3dfv3KQmJudUlXuWP6lepqTTQDzoXX5fYB1em
 nTl44sbWlzgiEw4xhcfuaHaH7DK9mAo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-nB4vjs3CMT20acRNOE7BSQ-1; Thu, 30 Jan 2025 01:47:34 -0500
X-MC-Unique: nB4vjs3CMT20acRNOE7BSQ-1
X-Mimecast-MFC-AGG-ID: nB4vjs3CMT20acRNOE7BSQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4362b9c1641so1611105e9.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 22:47:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738219653; x=1738824453;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9+xdp+uhdMZH+f+h5dxzGq3sQBd5hYWFv6bGHjTE0nU=;
 b=HGtEu0CnP65oX6JWTVpW3fgXNW2aPWrHr+d8JYswME+24rBwBNxt77LOB1K3ExK2p7
 XaPX2FzNJYzYUqNpey+Nmkta6eFmwrdJP4nOvSBPFFF/zo3Ukh3f2zFhybndOEQvCCe3
 DxRRaps9UU6LDMZ1b6i9+Pk1YI18ESF4uTFsNWIHEm8k30KVhic/95m0HE27GJ0f4UxJ
 yXCy0qjFSBTHAZHPDQdN6Auo/SFazvLM20lf7I8gtSRQ3Cr0zax8aAuRweEfc9Ygy61i
 t/GxUtp9VwWJpS+7GXd4rpyT2x2hFa97tS2OrPRvg0M9OgzTXVMBNwd/OPld4gkrHapp
 QgRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoRlEdPgYEvsjo408rWCEbLAucwbcI4mL9BisJfCO5O6D9YGNUmIRXMFt6pUXGl+keCuOCLm2LtVji@nongnu.org
X-Gm-Message-State: AOJu0Yw5vhEPPgHBokfrNAb43xkiotWW/n+0+bVmxKI9+OqeJyswV/uP
 XxNOKt5otQ2weyiRkraY5HAmfqwEMB2LB43Wn9CIE9VtTHnFRRZdNSBeBWjMmOIWrEo3sz4ZKuk
 FwdUe5J/pb6t3+ovauICkzIFQnBhkQ1nWECZKV//zpSseyKqmsxr+
X-Gm-Gg: ASbGnctX6/hlIHM5KmcEpDw0MQBG97LcbzRYtiHoQ3d/xp3R9Aw420fCwLj+QiaRisG
 cz+RFDwM9SWuR3b4e6ySdQSSxdHXGq2e2VlyqF9UYodPKc9aahuiu4FDfrV0KsXbGYDdMCPJCmg
 20FoSaEF+GYhIJbGuXbMo/QQTzMabT0mtEsfLHcnxGdqqj1l0RyRY+Vy14jug7QnP7/czC0z/El
 p0zFpkUp6TyIdh5W2fakixZea50dpAydnTCx0jkdn0k8Pffo8/u1xJa5EpnRThWwPGtG9iX1vT7
 7kEZxKDosWk+FGYarVP4gr9dMNvZJkPtbmBs
X-Received: by 2002:a05:600c:a45:b0:434:f7e3:bfbd with SMTP id
 5b1f17b1804b1-438dc40cf15mr47220565e9.23.1738219652855; 
 Wed, 29 Jan 2025 22:47:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEdxirgvvoD63otXc9hFJLgX/RvlV+PPRRZf+p0mjaGhn3uRAMz3lii3hOMGs2ONtvmN265Q==
X-Received: by 2002:a05:600c:a45:b0:434:f7e3:bfbd with SMTP id
 5b1f17b1804b1-438dc40cf15mr47220455e9.23.1738219652411; 
 Wed, 29 Jan 2025 22:47:32 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-50-234.web.vodafone.de.
 [109.42.50.234]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc6df36sm49443585e9.25.2025.01.29.22.47.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 22:47:31 -0800 (PST)
Message-ID: <21df1d87-025a-400a-9f55-086f4544dfef@redhat.com>
Date: Thu, 30 Jan 2025 07:47:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/pc: Fix crash that occurs when introspecting
 TYPE_PC_MACHINE machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250117192106.471029-1-thuth@redhat.com>
 <d48f6516-1c8f-4bf0-ae53-7bb364589c25@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <d48f6516-1c8f-4bf0-ae53-7bb364589c25@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 29/01/2025 08.11, Philippe Mathieu-Daudé wrote:
> Hi Thomas,
> 
> On 17/1/25 20:21, Thomas Huth wrote:
>> QEMU currently crashes when you try to inspect the machines based on
>> TYPE_PC_MACHINE for their properties:
>>
>>   $ echo '{ "execute": "qmp_capabilities" }
>>           { "execute": "qom-list-properties","arguments":
>>                        { "typename": "pc-q35-10.0-machine"}}' \
>>     | ./qemu-system-x86_64 -M pc -qmp stdio
>>   {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 9},
>>    "package": "v9.2.0-1070-g87e115c122-dirty"}, "capabilities": ["oob"]}}
>>   {"return": {}}
>>   Segmentation fault (core dumped)
>>
>> This happens because TYPE_PC_MACHINE machines add a machine_init-
>> done_notifier in their instance_init function - but instance_init
>> of machines are not only called for machines that are realized,
>> but also for machines that are introspected, so in this case the
>> listener is added for a q35 machine that is never realized. But
>> since there is already a running pc machine, the listener function
>> is triggered immediately, causing a crash since it was not for the
>> right machine it was meant for.
>>
>> Such listener functions must never be installed from an instance_init
>> function. Let's do it from pc_basic_device_init() instead - this
>> function is called from the MachineClass->init() function instead,
>> i.e. guaranteed to be only called once in the lifetime of a QEMU
>> process.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2779
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   hw/i386/pc.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index b46975c8a4..85b8a76455 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1241,6 +1241,9 @@ void pc_basic_device_init(struct PCMachineState *pcms,
>>       /* Super I/O */
>>       pc_superio_init(isa_bus, create_fdctrl, pcms->i8042_enabled,
>>                       pcms->vmport != ON_OFF_AUTO_ON, &error_fatal);
>> +
>> +    pcms->machine_done.notify = pc_machine_done;
> 
> I could accept if we rename:
> 
>    pc_machine_done() -> pc_basic_device_init_done[_notifier]()

Not sure whether that's such a good idea: The notifier is called when the 
machine init has been done, not when the device init has been done. It just 
happens to be instantiated from a function called pc_basic_device_init() 
now, but that does not really mean that the notifier function should get a 
similar name, should it?

  Thomas


>> +    qemu_add_machine_init_done_notifier(&pcms->machine_done);
>>   }
>>   void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
>> @@ -1714,9 +1717,6 @@ static void pc_machine_initfn(Object *obj)
>>       if (pcmc->pci_enabled) {
>>           cxl_machine_init(obj, &pcms->cxl_devices_state);
>>       }
>> -
>> -    pcms->machine_done.notify = pc_machine_done;
>> -    qemu_add_machine_init_done_notifier(&pcms->machine_done);
>>   }
>>   static void pc_machine_reset(MachineState *machine, ResetType type)
> 


