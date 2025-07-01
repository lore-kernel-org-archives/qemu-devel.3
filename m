Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67199C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 09:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWXIR-00024A-6P; Tue, 01 Jul 2025 05:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uWXIM-000224-6C
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 05:28:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uWXIH-000178-V9
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 05:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751362127;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FGqTT2w+KS6jckIHM+NDWJhU0IE5n4M12BMJuWiciJY=;
 b=CJD2zloGQrr3euI+yKgAO+/ed+SZ4O5RpoWt1cmFZU+Z+G2HqJXQY9iZUfWMjzmFv03hyC
 fS8scZ/36W0diMRFvc/hBuFKgz+B7iLqUH/kjaQT9LAjLplxZ8e0gXqjAdJ3vrWZSCCM2o
 hdT84A2f2x9Ost+PcZXrj7I7bjz+BSg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-cw4wi6XVPWi6Ys1PtPHnxw-1; Tue, 01 Jul 2025 05:28:46 -0400
X-MC-Unique: cw4wi6XVPWi6Ys1PtPHnxw-1
X-Mimecast-MFC-AGG-ID: cw4wi6XVPWi6Ys1PtPHnxw_1751362125
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4eb6fcd88so2321605f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 02:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751362125; x=1751966925;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FGqTT2w+KS6jckIHM+NDWJhU0IE5n4M12BMJuWiciJY=;
 b=tOGk0b6v6Xp29GMaXDbwONGbMqCiFMuENja9lXFB/0TRjRIpqdGQ3nMlw4k9fmTQY7
 3FRN1WHmSZYhMwNojZIJmZp/l+LH69jMnWjBY9Ktn61R/yoLlRB1cUI5gXSPctNPDAF0
 7sB/qlWTo6aoIAiG3H5jD/IIl9ac7pOchyOLtSgSHO+dS9ZqWxWvbi8JvVCOqYW7/T5k
 bPLQTgjehitOgcH2wA0Q7W83im20NWKrx74aclIvtC05OxdbVb0M9ck02kwKP/2oqVLJ
 9n4jGV9DLptimIQKHnZO9Y4+fH7lcN8uH5dzsxcF798gkIQWA4mFnW7/iahRSGiHPRaD
 vnBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd6rVMdO2h0QclxjB7aYJEqwbFfof3quG5D9Pj1aqR0QURhCjoL4ozbdolPWZiH0NXRdT3NnAOrZ1I@nongnu.org
X-Gm-Message-State: AOJu0Yxjyr6ebPNvmxdy4ZJOhuLu2H+UfUGX0U/F7r1i3u4tWVYDRmSe
 314lgPMNJSnOtDg3i6heqh7UGRojP8kIjBVAIlLxbnrlQE3mh+15WiHxyXMH1bRSeuyCZqGLxrS
 GDqTAxteYxhUPD7mIIbVzi/KIad+BmNoUBfbNgcmmiRrG5Dxnvg5kd3zX
X-Gm-Gg: ASbGncskR8ZO1XaSmkg259r7pvKBCbhPbMdRtND7fkGSgtxP6rRfP7lJFs4qTPQmCYy
 jCZ/GMT7+sBgUa4PfVqAiD3i0KwxIhs6U9uP8d0ILkod/TiHefKdJ2RIvcn7irRdlRsDGW9alN6
 Xm9qLUHFT/37YdjXd9Rez7M1qJkegv4t4v5L9Rd3h8A5BevKwRf6Fv/bVpG53PQGR0ibtR7DH8r
 mK13i72UpesA+fBGBmubuKoquDGqfzAjY4kiVCV9Nv2wazGuYaY1CIHyVSGpdrl/rv7oOpiiyxa
 w7taFzgvH1liFEBQcwuruuvLaXfa29C0FwxsgHvY6jkPczsOWPtXd2K6Ym3AlYc6OlL2JQ==
X-Received: by 2002:a05:6000:440f:b0:3a3:6595:9209 with SMTP id
 ffacd0b85a97d-3a8fdeffb3emr9012492f8f.36.1751362124916; 
 Tue, 01 Jul 2025 02:28:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpIso0AhElduHuCY/K2/Db51M3EnSrQ3U2C2GyiInQ8hfwA1RqIGDMHKl+nFT8RVKCKBqgGA==
X-Received: by 2002:a05:6000:440f:b0:3a3:6595:9209 with SMTP id
 ffacd0b85a97d-3a8fdeffb3emr9012462f8f.36.1751362124439; 
 Tue, 01 Jul 2025 02:28:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823ad0fesm194636705e9.25.2025.07.01.02.28.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 02:28:43 -0700 (PDT)
Message-ID: <6c138685-82cb-4dad-b562-2d898c8414e2@redhat.com>
Date: Tue, 1 Jul 2025 11:28:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 29/32] hw/arm/virt: Let virt support pci hotplug/unplug
 GED event
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, imammedo@redhat.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20250627095620.3300028-1-eric.auger@redhat.com>
 <20250627095620.3300028-30-eric.auger@redhat.com>
 <20250630135315.000041b2@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250630135315.000041b2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Jonathan

On 6/30/25 2:53 PM, Jonathan Cameron wrote:
> On Fri, 27 Jun 2025 11:55:18 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> Set up the IO registers used to communicate between QEMU
>> and ACPI.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Follow on comment inline.  Otherwise LGTM
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
thanks!
>
>> ---
>> v2 -> v3:
>> - remove acpi_ged_state->pcihp_state.use_acpi_hotplug_bridge = true;
>> - use sysbus_mmio_map_name for all regs (Igor)
>> - create_pcie left at its original place
>>
>> v1 -> v2:
>> - use ACPI_PCIHP_REGION_NAME
>> ---
>>  hw/arm/virt.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 878c567354..d8706ef9c8 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -686,6 +686,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>>      SysBusDevice *sbdev;
>>      int irq = vms->irqmap[VIRT_ACPI_GED];
>>      uint32_t event = ACPI_GED_PWR_DOWN_EVT;
>> +    bool acpi_pcihp;
>>  
>>      if (ms->ram_slots) {
>>          event |= ACPI_GED_MEM_HOTPLUG_EVT;
>> @@ -704,6 +705,18 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>>      sysbus_mmio_map_name(sbdev, TYPE_ACPI_GED, vms->memmap[VIRT_ACPI_GED].base);
>>      sysbus_mmio_map_name(sbdev, ACPI_MEMHP_REGION_NAME,
>>                           vms->memmap[VIRT_PCDIMM_ACPI].base);
>> +
>> +    acpi_pcihp = object_property_get_bool(OBJECT(dev),
>> +                                          ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, NULL);
>> +
>> +    if (acpi_pcihp) {
> As mentioned in earlier patch review, with this code you now have means to set the event
> bitmap as done in other cases.  Maybe just do that here as well?
see my previous reply

Hope this clarifies

Eric
>
>> +        int pcihp_region_index;
>> +
>> +        pcihp_region_index = sysbus_mmio_map_name(sbdev, ACPI_PCIHP_REGION_NAME,
>> +                                                  vms->memmap[VIRT_ACPI_PCIHP].base);
>> +        assert(pcihp_region_index >= 0);
>> +    }
>> +
>>      sysbus_connect_irq(sbdev, 0, qdev_get_gpio_in(vms->gic, irq));
>>  
>>      return dev;


