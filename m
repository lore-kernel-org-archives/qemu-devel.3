Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3258CCAC5BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ViD-0000HU-0e; Tue, 30 Sep 2025 04:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3Vi8-0000Ex-Kq
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:27:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3Vi5-0002nR-Da
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759220859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QT4LoFi9HhDvesT6+zn9ZRq4f/stJJdg4oV9HmldI5k=;
 b=Mh45d3Ovvb2IMDgl5rkBYIuOWMJmhCHLFEPv94fTAs0LrU/lL7lEe2t159jJ+4/csa8puw
 TY/6RO17nQELxC/0PMJI3Oo1/Koc64N5+MTXEZ02OswjQC/Tgn+kfVwS8zmKpESrPqxxoP
 D2nLFICw1/fM+FS4lCb/m0HOzjS3prA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-XIEdaSd5MZKRSTpihWKhVA-1; Tue, 30 Sep 2025 04:27:37 -0400
X-MC-Unique: XIEdaSd5MZKRSTpihWKhVA-1
X-Mimecast-MFC-AGG-ID: XIEdaSd5MZKRSTpihWKhVA_1759220856
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e32eb4798so28128345e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759220856; x=1759825656;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QT4LoFi9HhDvesT6+zn9ZRq4f/stJJdg4oV9HmldI5k=;
 b=jFKvC7ja6Wh5bwIbXJ7L7kXk/6799rj0lpjX8rOfD5a4gvNPGy/9mWhq1p4KM0Gwif
 rqzbDEQ3TmjncN/tX+t9s1Qyo6FkjstIoN7BbxsB8nrNjDf9i+raXxGLL6jotzdpmbJp
 7ifYElQ/NtwuppY4DSO4sR5cr79PiE3+Yu/RReB3qaprAQ9yj4MuyxeSLo7EBjeRTY0y
 zPp8Rl/lzgbqzc8/GRkG+xdRaLty8hwZDjumiLaqDRjPggMaMxqbOwhYmASn0AecDtMp
 oLSN7CCDkbvmvTg/WDJnrYo0Bc5BcagvDLdX9c2GojDYdgMdsc07MNxm5c7AibXeCCh9
 Z7TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7ttzEJ4tn4UPNYSMqpNnZKbcqWjo3dItUfGwRTuH1sDkDdMFy3NDaPB1r/3Jf1rJUGCOd93rUdi3H@nongnu.org
X-Gm-Message-State: AOJu0YzeJ0lsktJhKHS792s8glNN+wmlfmNTPurqArXtLMw0na8Bw+KU
 QsGdmbymVOWeXTu+RT0Fh1oeBvWlvamcme56dIUlzLs2yLCcS6LUGjd4MdnYM6mExeMwi3cxens
 2MqINUVTxechXuoYSKufng5z+w/urhNe/b60ZTaFPlyOWi+zaqCTugQi0
X-Gm-Gg: ASbGncshoRZw36D1EFDwuFW8rA/Exa/Hfxx1g21doV8YHHbldu2zk7d6+Lik1U3g/CM
 gHie98wUwL6YuW87hPK+DZ86it7AZmOw/gY/jiEUPizUeRyxiFme5K+AhCuEBT9g8tpgqyBt9aL
 1FLzUXC9GtpwgtpWQgY7puD4jQ+MUhXF9FpcaCuLItmzp9BUUmDmp4mjZWeU0gRj9uSScDc0G0T
 5ARdqIM/Im+HYvKZ+1k6qmdTTLi92dqDhzJ2UEmjKQjr4zs7gjKMT3hhJ2DFCeFTLrXVcNmK4Rm
 geP5YSECvY7Iqw2q8seT8hrn6BzTd5SZydimaPju9cpAF+tDSY3JqcK7i9e2Zjc6zF+Eno7tKl8
 fGB9D67/U
X-Received: by 2002:a05:600c:19d0:b0:46e:2cfe:971c with SMTP id
 5b1f17b1804b1-46e3292291cmr170039875e9.0.1759220856178; 
 Tue, 30 Sep 2025 01:27:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/37WBvr+xbhgCpzX3ODncPRH+CdDJH0iK4XSD4EzqgEdID3Mbn5LYr8H6OJnz7BpwRgTtrg==
X-Received: by 2002:a05:600c:19d0:b0:46e:2cfe:971c with SMTP id
 5b1f17b1804b1-46e3292291cmr170039555e9.0.1759220855726; 
 Tue, 30 Sep 2025 01:27:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f3d754sm46535755e9.4.2025.09.30.01.27.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 01:27:35 -0700 (PDT)
Message-ID: <3553e934-f05e-4cab-bf1b-17c149dcfb59@redhat.com>
Date: Tue, 30 Sep 2025 10:27:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: ensure APIC is loaded prior to VFIO PCI devices
To: Peter Xu <peterx@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>
Cc: mst@redhat.com, pbonzini@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org, shenyicong.1023@bytedance.com,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250818131127.1021648-1-yanfei.xu@bytedance.com>
 <aNqrHBMKRp-9Qhw0@x1.local>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aNqrHBMKRp-9Qhw0@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/29/25 17:51, Peter Xu wrote:
> On Mon, Aug 18, 2025 at 09:11:27PM +0800, Yanfei Xu wrote:
>> The load procedure of VFIO PCI devices involves setting up IRT
>> for each VFIO PCI devices. This requires determining whether an
>> interrupt is single-destination interrupt to decide between
>> Posted Interrupt(PI) or remapping mode for the IRTE. However,
>> determining this may require accessing the VM's APIC registers.
>>
>> For example:
>> ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irqs)
>>    ...
>>      kvm_arch_irq_bypass_add_producer
>>        kvm_x86_call(pi_update_irte)
>>          vmx_pi_update_irte
>>            kvm_intr_is_single_vcpu
>>
>> If the LAPIC has not been loaded yet, interrupts will use remapping
>> mode. To prevent the fallback of interrupt mode, keep APIC is always
>> loaded prior to VFIO PCI devices.
>>
>> Signed-off-by: Yicong Shen <shenyicong.1023@bytedance.com>
>> Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
>> ---
>>   hw/intc/apic_common.c       | 1 +
>>   include/migration/vmstate.h | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
>> index 37a7a7019d..394fe02013 100644
>> --- a/hw/intc/apic_common.c
>> +++ b/hw/intc/apic_common.c
>> @@ -379,6 +379,7 @@ static const VMStateDescription vmstate_apic_common = {
>>       .pre_load = apic_pre_load,
>>       .pre_save = apic_dispatch_pre_save,
>>       .post_load = apic_dispatch_post_load,
>> +    .priority = MIG_PRI_APIC,
>>       .fields = (const VMStateField[]) {
>>           VMSTATE_UINT32(apicbase, APICCommonState),
>>           VMSTATE_UINT8(id, APICCommonState),
>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> index 1ff7bd9ac4..22e988c5db 100644
>> --- a/include/migration/vmstate.h
>> +++ b/include/migration/vmstate.h
>> @@ -163,6 +163,7 @@ typedef enum {
>>       MIG_PRI_IOMMU,              /* Must happen before PCI devices */
>>       MIG_PRI_PCI_BUS,            /* Must happen before IOMMU */
>>       MIG_PRI_VIRTIO_MEM,         /* Must happen before IOMMU */
>> +    MIG_PRI_APIC,               /* Must happen before PCI devices */
>>       MIG_PRI_GICV3_ITS,          /* Must happen before PCI devices */
>>       MIG_PRI_GICV3,              /* Must happen before the ITS */
>>       MIG_PRI_MAX,
>> -- 
>> 2.20.1
>>
> 
> +Cedric, +Alex
> 
> queued.
> 

Perhaps we could group the interrupt controller priorities
under a common MIG_PRI_INTC ? PPC is very much the same,
although we managed to order restore from the machine load
handler IIRC.

Anyhow, LGTM.

Thanks,

C.


