Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8C3C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 00:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgCds-0004Dw-Hi; Mon, 19 Aug 2024 20:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sgCdk-0004Ab-Fx
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:22:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1sgCdh-0003nG-RO
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724113340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4MKczJNn7eWeSgYJzFg8/eo5vyV7rrNgXziv7QtGHbg=;
 b=eXNWp3YVqu3woa6iEzyDgEx0A+TZOJqbVuGSctm76bftEJaz56kwHxA5LhmfEYjCjnNQa6
 yVBXOOU48rOLWyUVpaG/FqUtm94oavbgQaGFHRPDOQkiMXsPv8TdW9EOKE7SjeHrBSVV/D
 tDNz+UxItDJSEr+Pp5pyaCML8gLuJHA=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-KNhPz7-nNkWSwKYB_IO8Qg-1; Mon, 19 Aug 2024 20:22:17 -0400
X-MC-Unique: KNhPz7-nNkWSwKYB_IO8Qg-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-70d1a9bad5dso4908027b3a.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 17:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724113336; x=1724718136;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4MKczJNn7eWeSgYJzFg8/eo5vyV7rrNgXziv7QtGHbg=;
 b=LpzQBUsSO1trk+pElaRDJfbpRrTV/9tm0fPBV4TejT3JIAKdxNUYsclZ2k5AaqYV4a
 GwfCZ6aj5MpeD4wcUrrGypPjGldWlvNZnBuzOslWQ62HsO5A2zdeg/dQm2DfeKpUsWDb
 J0ff6VbVJUy09KsMb9PrnJdX6vLWLXTdrBMzB3eeZtHhGNPfTfnQvej3DM3QOU+v8rC0
 Xz3I6O9pGCv1RPzOX0n4kfeiLErlp3yA2/49QelRzrzIO8FS2tZ7H5EK4N6LorWmtDRd
 dpEufKX1ovvAt1FXkbabPb8Mi0YgGOJfszw/AEPC+l2FGriH1r2WyU22iY32awoHspJP
 RYzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVymeSJY3F28rpNmTZyOFEoiitP9I7IyUqVIt6rhPCf1U52WRneRagGUOZegNnXd4Y5hj/7iXUBjioxE9ATuJ4gihXRZo4=
X-Gm-Message-State: AOJu0YzlhE21u3uU/jxW6i6tu6L6JquC1lhc8725wHjjVQzsh9hihUUo
 j/TGLXCFcwfM1epFXPNibZsXpoEiYjRknNHqOUf5nitvoebJnFozU+Q5rIv0sRbNKIBBJTq/6gI
 dB9HNLysVQENtbGw1dG/HzFxo4CoSEeQIjP1LRWWH7ucA33YCJ9L2
X-Received: by 2002:a05:6a00:148b:b0:70d:278e:4e94 with SMTP id
 d2e1a72fcca58-713c5285995mr13467695b3a.30.1724113336264; 
 Mon, 19 Aug 2024 17:22:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQoXmJDVtY+h31V0AAtrA9aSybqxzCE8Yr4NDPfiZ8lxXvk4KfBuj7jkN8vbZxKr96a6F8aQ==
X-Received: by 2002:a05:6a00:148b:b0:70d:278e:4e94 with SMTP id
 d2e1a72fcca58-713c5285995mr13467659b3a.30.1724113335722; 
 Mon, 19 Aug 2024 17:22:15 -0700 (PDT)
Received: from [192.168.68.54] ([103.210.27.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127aef574asm7120615b3a.114.2024.08.19.17.22.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 17:22:15 -0700 (PDT)
Message-ID: <52ae18ca-0a5a-44d4-95f5-56cfc7a035a8@redhat.com>
Date: Tue, 20 Aug 2024 10:22:00 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V3 11/29] arm/virt: Create GED dev before *disabled*
 CPU Objs are destroyed
To: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>
Cc: "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "shahuang@redhat.com" <shahuang@redhat.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>, Linuxarm <linuxarm@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-12-salil.mehta@huawei.com>
 <143ad7d2-8f45-4428-bed3-891203a49029@redhat.com>
 <b6bdee28101741169048819c0d562bfc@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <b6bdee28101741169048819c0d562bfc@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Salil,

On 8/19/24 10:10 PM, Salil Mehta wrote:
>>   From: Gavin Shan <gshan@redhat.com>
>>   Sent: Tuesday, August 13, 2024 2:05 AM
>>   To: Salil Mehta <salil.mehta@huawei.com>; qemu-devel@nongnu.org;
>>   qemu-arm@nongnu.org; mst@redhat.com
>>   
>>   On 6/14/24 9:36 AM, Salil Mehta wrote:
>>   > ACPI CPU hotplug state (is_present=_STA.PRESENT,
>>   > is_enabled=_STA.ENABLED) for all the possible vCPUs MUST be
>>   > initialized during machine init. This is done during the creation of
>>   > the GED device. VMM/Qemu MUST expose/fake the ACPI state of the
>>   > disabled vCPUs to the Guest kernel as 'present' (_STA.PRESENT) always
>>   > i.e. ACPI persistent. if the 'disabled' vCPU objectes are destroyed
>>   > before the GED device has been created then their ACPI hotplug state
>>   > might not get initialized correctly as acpi_persistent flag is part of the
>>   CPUState. This will expose wrong status of the unplugged vCPUs to the
>>   Guest kernel.
>>   >
>>   > Hence, moving the GED device creation before disabled vCPU objects get
>>   > destroyed as part of the post CPU init routine.
>>   >
>>   > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>>   > ---
>>   >   hw/arm/virt.c | 10 +++++++---
>>   >   1 file changed, 7 insertions(+), 3 deletions(-)
>>   >
>>   > diff --git a/hw/arm/virt.c b/hw/arm/virt.c index
>>   > 918bcb9a1b..5f98162587 100644
>>   > --- a/hw/arm/virt.c
>>   > +++ b/hw/arm/virt.c
>>   > @@ -2467,6 +2467,12 @@ static void machvirt_init(MachineState
>>   > *machine)
>>   >
>>   >       create_gic(vms, sysmem);
>>   >
>>   > +    has_ged = has_ged && aarch64 && firmware_loaded &&
>>   > +              virt_is_acpi_enabled(vms);
>>   > +    if (has_ged) {
>>   > +        vms->acpi_dev = create_acpi_ged(vms);
>>   > +    }
>>   > +
>>   >       virt_cpu_post_init(vms, sysmem);
>>   >
>>   >       fdt_add_pmu_nodes(vms);
>>   > @@ -2489,9 +2495,7 @@ static void machvirt_init(MachineState
>>   *machine)
>>   >
>>   >       create_pcie(vms);
>>   >
>>   > -    if (has_ged && aarch64 && firmware_loaded &&
>>   virt_is_acpi_enabled(vms)) {
>>   > -        vms->acpi_dev = create_acpi_ged(vms);
>>   > -    } else {
>>   > +    if (!has_ged) {
>>   >           create_gpio_devices(vms, VIRT_GPIO, sysmem);
>>   >       }
>>   >
>>   
>>   It's likely the GPIO device can be created before those disabled CPU objects
>>   are destroyed. It means the whole chunk of code can be moved together, I
>>   think.
> 
> I was not totally sure of this. Hence, kept the order of the rest like that. I can
> definitely check again if we can do that to reduce the change.
> 

@has_ged is the equivalent to '!vmc->no_ged' initially and then it's overrided by
the following changes in this patch. The syntax of @has_ged has been changed and
it's not the best name to match the changes. There are two solutions: (1) Rename
@has_ged to something meaningful and matching with the changes; (2) Move the whole
chunk of codes, which I preferred. The GPIO device and GED device are supplementing
to each other, meaning GPIO device will be created when GED device has been disallowed.

     has_ged = has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms);

The code to be moved together in virt.c since they're correlated:

     if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
         vms->acpi_dev = create_acpi_ged(vms);
     } else {
         create_gpio_devices(vms, VIRT_GPIO, sysmem);
     }
     
     if (vms->secure && !vmc->no_secure_gpio) {
         create_gpio_devices(vms, VIRT_SECURE_GPIO, secure_sysmem);
     }

      /* connect powerdown request */
      vms->powerdown_notifier.notify = virt_powerdown_req;
      qemu_register_powerdown_notifier(&vms->powerdown_notifier);

Thanks,
Gavin





