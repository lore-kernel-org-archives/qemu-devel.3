Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DADCC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 17:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcpl4-0002qj-Ar; Tue, 28 Jan 2025 12:52:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tcpky-0002q8-UV
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 12:52:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tcpkx-0000wl-2d
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 12:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738086728;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Co1qvkzN2SFQkO+88Cn3GMOo2A6hPGhIIGmHVtr2uK4=;
 b=YAjvZ6DF/kUUZo2jvDAPex8rVR5Csf+OITAgt05OrM31kqvD03GdiZU7eBSuLMR+p46oaE
 ds2olcEi4iiofv/50db1brEAvTsVNEkHMbMm+DBmADKslZiYhSRKRkQAK4GkYDpgM4BMH4
 /ltbImBajEbNF8qmgBjXW6aysko4Js0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-o2-bDIeuOnu1JlKIb8AdmQ-1; Tue, 28 Jan 2025 12:52:04 -0500
X-MC-Unique: o2-bDIeuOnu1JlKIb8AdmQ-1
X-Mimecast-MFC-AGG-ID: o2-bDIeuOnu1JlKIb8AdmQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43673af80a6so43629585e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 09:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738086722; x=1738691522;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Co1qvkzN2SFQkO+88Cn3GMOo2A6hPGhIIGmHVtr2uK4=;
 b=qAdWkalaFGnGldRlRYbdJ6aXsz59IIB+7t6zfpvBVYG+7TUHUaq8qnwgFcj98pVo8L
 ZgBvhNT/Iw/Vdf4H0aEhhgevM17H1g72t83ZY24jkveubcalgAZT+2rHlIp0wjlc+6TV
 Nj4Nwf6FV5Sep+ttirVL+aE8jFYEnAo7cBROldC+03ak9tE+sZhIaE1kFuDD2e3GiXhm
 55as4R5ZRiiyyFKIQ09jSB5oYBAmLAbDinxvIvUPOrgFMqfI4ipMPJdX2gV9ws3tn+o4
 PxKBrVG3KsA9CVF2k7EAyIfus2VCzyzT5q8DCXdUTBVbUa3hQNfpvIFzx7HC8cxDHwmy
 tuAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFdDJCoa06yfJgnzxUbD1sYuEdw5wdpBkCRn1DTxpPUFzusyC/CayAKhQ0/HEJYA7I+Vi/b5myaS7Q@nongnu.org
X-Gm-Message-State: AOJu0YyxQlrmRtQrNklIw6o8Tbm96nw88dV7hOAeX8/Do7PgU0H25hLD
 IW7w8g3d6Dchb6bAVRq+g3xrPbW+5afCC6RR3yX+9ebXH+SAUY4Ob89Po2ns43YB1CvYAnwioge
 oHfkAcdQIngoPyuJ4jIgl0bbjC448aJwkep9dJDaQTfj8wiuuFjGU
X-Gm-Gg: ASbGncsaVy9DqFAJzhG6Zsfbwlb4a6Z+gSd+aFEOvWXd5ndfjRGrHrPf9rmSj7v2Wg2
 npwC+w+Uel/tMKzX6d1mviSwBemdwYXkyISbjZ3+xenXDHoIyGl14hgWeDApLb4z1NNlCSvFdWl
 kKFIO69XTzYEI2OS7LPGLNayygnmJE95nd60BibclJ2ewD+NG+i6QMRrtxFCYomiyadxt9RZx9+
 mSt6hXhS0MxtRMxiYN2z2y9zbg7E2wEzx2W5I3lf1BeFfVwKMOVloYxn1g0SQ6MzuK2Poio7fyY
 xDTL48WsP7uLIZ4J9rgnn0w5U2Yer9dvmmAX7RbZXecPodmQTDcg
X-Received: by 2002:a05:600c:4e12:b0:42c:b9c8:2bb0 with SMTP id
 5b1f17b1804b1-438913bdcd2mr378028665e9.4.1738086722489; 
 Tue, 28 Jan 2025 09:52:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFISPq2Lpr+KTh6IoE1YcmqB0qJlnyO3W645qDMYnMoefkRZFPfuXhZizP97zmMcLtGQj8h9g==
X-Received: by 2002:a05:600c:4e12:b0:42c:b9c8:2bb0 with SMTP id
 5b1f17b1804b1-438913bdcd2mr378028445e9.4.1738086722074; 
 Tue, 28 Jan 2025 09:52:02 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd57517fsm173347395e9.38.2025.01.28.09.52.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 09:52:01 -0800 (PST)
Message-ID: <cb91da0e-9163-4e59-a060-4a76a077c5d5@redhat.com>
Date: Tue, 28 Jan 2025 18:52:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/virt: Support larger highmem MMIO regions
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "Matthew R. Ochs" <mochs@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>
Cc: "ddutile@redhat.com" <ddutile@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ankita@nvidia.com" <ankita@nvidia.com>
References: <20250128160237.3379569-1-mochs@nvidia.com>
 <73f3e4cf927845809c6b10424c00c0ff@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <73f3e4cf927845809c6b10424c00c0ff@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Matthew, Shameer,


On 1/28/25 6:36 PM, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Matthew R. Ochs <mochs@nvidia.com>
>> Sent: Tuesday, January 28, 2025 4:03 PM
>> To: qemu-devel@nongnu.org; Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; nathanc@nvidia.com
>> Cc: ddutile@redhat.com; eric.auger@redhat.com; nicolinc@nvidia.com;
>> ankita@nvidia.com
>> Subject: [PATCH] hw/arm/virt: Support larger highmem MMIO regions
>>
>> The MMIO region size required to support virtualized environments with
>> large PCI BAR regions can exceed the hardcoded limit configured in QEMU.
>> For example, a VM with multiple NVIDIA Grace-Hopper GPUs passed
>> through
>> requires more MMIO memory than the amount provided by
>> VIRT_HIGH_PCIE_MMIO
>> (currently 512GB). Instead of updating VIRT_HIGH_PCIE_MMIO, introduce a
>> new parameter, highmem-mmio-size, that specifies the MMIO size required
>> to support the VM configuration.
>>
>> Example usage with 1TB MMIO region size:
>> 	-machine virt,gic-version=3,highmem-mmio-size=1099511627776
> I guess you could do highmem-mmio-size=1024G as well.
>
>> Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
>> ---
>>  docs/system/arm/virt.rst |  4 ++++
>>  hw/arm/virt.c            | 36 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 40 insertions(+)
>>
>> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
>> index e67e7f0f7c50..36344554788a 100644
>> --- a/docs/system/arm/virt.rst
>> +++ b/docs/system/arm/virt.rst
>> @@ -138,6 +138,10 @@ highmem-mmio
>>    Set ``on``/``off`` to enable/disable the high memory region for PCI MMIO.
>>    The default is ``on``.
>>
>> +highmem-mmio-size
>> +  Set extended MMIO memory map size. Must be a power-of-2 and greater
maybe keep the existing terminology, ie. high PCIE MMIO region.
extended_memmap
Would deserve to add some comments on top of extended_memmap[] too.
>> than
>> +  the default size.
>> +
>>  gic-version
>>    Specify the version of the Generic Interrupt Controller (GIC) to provide.
>>    Valid values are:
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 49eb0355ef0c..43d47ffedd9a 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -2773,6 +2773,35 @@ static void virt_set_highmem_mmio(Object *obj,
>> bool value, Error **errp)
>>      vms->highmem_mmio = value;
>>  }
>>
>> +static void virt_get_highmem_mmio_size(Object *obj, Visitor *v, const
>> char *name,
>> +                          void *opaque, Error **errp)
>> +{
>> +    uint64_t size = extended_memmap[VIRT_HIGH_PCIE_MMIO].size;
>> +
>> +    visit_type_size(v, name, &size, errp);
>> +}
>> +
>> +static void virt_set_highmem_mmio_size(Object *obj, Visitor *v, const char
>> *name,
>> +                          void *opaque, Error **errp)
>> +{
>> +    uint64_t size;
>> +
>> +    if (!visit_type_size(v, name, &size, errp))
>> +        return;
> Qemu style mandates braces around.
>
>> +
>> +    if (!is_power_of_2(size)) {
>> +        error_setg(errp, "highmem_mmio_size is not a power-of-2");
>> +        return;
>> +    }
>> +
>> +    if (size < extended_memmap[VIRT_HIGH_PCIE_MMIO].size) {
> Not sure it is better to fallback to default size here instead of setting error.
I think if the user sets a value it shall be obeyed
Note that per the dynamic memory map algo, changing the size will also
change the base address. See

virt_set_high_memmap(). By the wayn why do we forbid a smaller size?

>
>> +        error_setg(errp, "highmem_mmio_size is less than the default (%lu)",
>> +                   extended_memmap[VIRT_HIGH_PCIE_MMIO].size);
>> +        return;
>> +    }
>> +
>> +    extended_memmap[VIRT_HIGH_PCIE_MMIO].size = size;
>> +}
>>
>>  static bool virt_get_its(Object *obj, Error **errp)
>>  {
>> @@ -3446,6 +3475,13 @@ static void virt_machine_class_init(ObjectClass
>> *oc, void *data)
>>                                            "Set on/off to enable/disable high "
>>                                            "memory region for PCI MMIO");
>>
>> +    object_class_property_add(oc, "highmem-mmio-size", "size",
>> +                                   virt_get_highmem_mmio_size,
>> +                                   virt_set_highmem_mmio_size,
>> +                                   NULL, NULL);
>> +    object_class_property_set_description(oc, "highmem-mmio-size",
>> +                                          "Set extended MMIO memory map size");
>> +
> I think this probably needs backward compatibility to keep migration happy.
> Isn't it? See the no_highmem_compact handling.
I guess if we keep the same value as default we are good. The difference
with highmem_compact is it was set by default from 7.2 onwards hence
changing the mmio layout. Here by default you keep the same IIUC.

Thanks

Eric
>
> Thanks,
> Shameer
>


