Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696F1C3DA60
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 09:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTer6-0007M1-MY; Tue, 16 Jul 2024 05:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTer5-0007IU-O7
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:52:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTer3-0001EN-Nx
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721123536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UpF3qQq2kmXRL4FEhfI32M1trhYoK+BGVkbJvwzIOM8=;
 b=aew3Dp99Kv/JIHTLyNYd0lHX0tYEGX5rLRTh5V7wGrrlcAgrjVGuF1shqUKmZCRf1pbR4L
 +00Zz2N7t1oc0y4BD4FaD4pqPtuX1xgIauPbHn5jTxuPF3PPs3fy4HC6+q0f+5XVn888Pu
 QdXBNf8aIwthAe0MD6jArq6iI53EAbY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-VaIygq4QOQemuxv2sVIUfQ-1; Tue, 16 Jul 2024 05:52:13 -0400
X-MC-Unique: VaIygq4QOQemuxv2sVIUfQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-367a058fa21so3074653f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 02:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721123533; x=1721728333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UpF3qQq2kmXRL4FEhfI32M1trhYoK+BGVkbJvwzIOM8=;
 b=VTaHba+dpPkp7cBEHEYs+XrEhekfA5zacX30RqKnEJmvFIUPaN8Q2+D0+/UL8f5lcM
 OsjQjh18nYNGxtcbmbNVgPvtsECzxReu4zYQL3c6Flkg0iSF9ebKjcvmDPBxW+/i2W8M
 u1pgEvuTNSO1DQAg3wLwWa3Agyn47eLp9zn03BeprH8bAa/Zxvx07Ouqr2IopWC6Nwth
 YqkWrOsigtUZ2Hf9wWmM4Eyt8Z+cwOu/az9/r/uBhezWx77+5LYyCcrWAKOP0BUM+mKo
 QH9sM8wYclTVjQbfWWiBGkL2DRYatNG33xyvUmLzMMKLF9osTNKbMogxjOVodNLC//mr
 8SuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUddYx5GLACjAhPuFsb7O371yvDSm/KSSgJ6tmT6LRN/s1ojUsZHr66S4BpCZQhq+ymHzguZLlmbiYAMjI8cd6/+FsLjjY=
X-Gm-Message-State: AOJu0YyW1GmdESqVXsAu/qQKy/+WgB5o5psxRT89hT9VjP2hxagl1Erw
 pubMaptgozemtjqyxMEKuy84n2qGQjHW99MJ7E53FbdXZxcSDBtctlJfrGq8OZxGFEP4aDZXmVK
 kXIKcAuLNUBB1wk7Eq34AaaPSYe9MsHcvP9cy6XJQPPru3KQdKK72
X-Received: by 2002:a5d:6612:0:b0:360:866f:5083 with SMTP id
 ffacd0b85a97d-368274eb83cmr982086f8f.32.1721123532801; 
 Tue, 16 Jul 2024 02:52:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxtQ9AQrtbNpmZFz7OQNZ0eAQvauOpzpGZcxmgZuMBkcCo8etr4f5naiFZkcHn8Tj3oqxdZg==
X-Received: by 2002:a5d:6612:0:b0:360:866f:5083 with SMTP id
 ffacd0b85a97d-368274eb83cmr982075f8f.32.1721123532411; 
 Tue, 16 Jul 2024 02:52:12 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dabf0e4sm8512161f8f.33.2024.07.16.02.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 02:52:11 -0700 (PDT)
Date: Tue, 16 Jul 2024 11:52:10 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@opnsrc.net>
Cc: Salil Mehta <salil.mehta@huawei.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "andrew.jones@linux.dev"
 <andrew.jones@linux.dev>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "will@kernel.org" <will@kernel.org>, "gshan@redhat.com"
 <gshan@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>, "karl.heubaum@oracle.com"
 <karl.heubaum@oracle.com>, "miguel.luis@oracle.com"
 <miguel.luis@oracle.com>, zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng
 (C)" <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "npiggin@gmail.com" <npiggin@gmail.com>, "harshpb@linux.ibm.com"
 <harshpb@linux.ibm.com>, Linuxarm <linuxarm@huawei.com>, peterx@redhat.com
Subject: Re: [PATCH V15 0/7] Add architecture agnostic code to support vCPU
 Hotplug
Message-ID: <20240716115210.08ca24ba@imammedo.users.ipa.redhat.com>
In-Reply-To: <4b829bf1-d31c-49eb-b18f-6d87e08c5c04@opnsrc.net>
References: <20240713182516.1457-1-salil.mehta@huawei.com>
 <20240715155436.577d34c5@imammedo.users.ipa.redhat.com>
 <b93b570158794e28bf8c00a949afa8b4@huawei.com>
 <3848723ea2584b9b813c3d76e1e6dd59@huawei.com>
 <20240715171154.2667d187@imammedo.users.ipa.redhat.com>
 <4b829bf1-d31c-49eb-b18f-6d87e08c5c04@opnsrc.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 16 Jul 2024 03:38:29 +0000
Salil Mehta <salil.mehta@opnsrc.net> wrote:

> Hi Igor,
> 
> On 15/07/2024 15:11, Igor Mammedov wrote:
> > On Mon, 15 Jul 2024 14:19:12 +0000
> > Salil Mehta <salil.mehta@huawei.com> wrote:
> >   
> >>>   From: qemu-arm-bounces+salil.mehta=huawei.com@nongnu.org <qemu-
> >>>   arm-bounces+salil.mehta=huawei.com@nongnu.org> On Behalf Of Salil
> >>>   Mehta via
> >>>   Sent: Monday, July 15, 2024 3:14 PM
> >>>   To: Igor Mammedov <imammedo@redhat.com>
> >>>   
> >>>   Hi Igor,
> >>>       
> >>>   >  From: Igor Mammedov <imammedo@redhat.com>
> >>>   >  Sent: Monday, July 15, 2024 2:55 PM
> >>>   >  To: Salil Mehta <salil.mehta@huawei.com>
> >>>   >
> >>>   >  On Sat, 13 Jul 2024 19:25:09 +0100
> >>>   >  Salil Mehta <salil.mehta@huawei.com> wrote:
> >>>   >  
> >>>   >  > [Note: References are present at the last after the revision  
> >>>   > history]  >  > Virtual CPU hotplug support is being added across
> >>>   > various architectures  [1][3].  
> >>>   >  > This series adds various code bits common across all architectures:
> >>>   >  >
> >>>   >  > 1. vCPU creation and Parking code refactor [Patch 1] 2. Update ACPI
> >>>   > > GED framework to support vCPU Hotplug [Patch 2,3] 3. ACPI CPUs AML
> >>>   > > code change [Patch 4,5] 4. Helper functions to support unrealization
> >>>   > > of CPU objects [Patch 6,7]  
> >>>   >
> >>>   >  with patch 1 and 3 fixed should be good to go.
> >>>   >
> >>>   >  Salil,
> >>>   >  Can you remind me what happened to migration part of this?
> >>>   >  Ideally it should be a part of of this series as it should be common
> >>>   > for  everything that uses GED and should be a conditional part of
> >>>   > GED's  VMSTATE.
> >>>   >
> >>>   >  If this series is just a common base and no actual hotplug on top of
> >>>   > it is  merged in this release (provided patch 13 is fixed), I'm fine
> >>>   > with migration  bits being a separate series on top.
> >>>   >
> >>>   >  However if some machine would be introducing cpu hotplug in the same
> >>>   > release, then the migration part should be merged before it or be a
> >>>   > part  that cpu hotplug series.  
> >>>   
> >>>   We have tested Live/Pseudo Migration and it seem to work with the
> >>>   changes part of the architecture specific patch-set.  
> > 
> > have you tested, migration from new QEMU to an older one (that doesn't have cpuhotplug builtin)?  
> 
> 
> Just curious, how can we detect at source Qemu what version of the Qemu
> destination is running. We require some sort of compatibility check but
> then this is a problem not specific to CPU Hotplug?

it's usually managed by version machine types + compat settings for
machine/device.

> We  are not initializing CPU Hotplug VMSD in this patch-set. I was
> wondering then how can a new machine attempt to migrate VMSD state from 
> new Qemu to older Qemu.

If I'm not mistaken without VMSD it shouldn't explode, since CPUHP
code shouldn't create memory-regions that are migrated.
(If I recall correctly, mmio regions aren't going into migration stream)

> ARM vCPU Hotplug patches will be on top of this later in next Qemu cycle.
then it's fine to introduce VMSD later on, just make sure others
who adding cpu hotplug elsewhere also aware of it and pickup the same patch.

> 
> 
> >   
> >>>   
> >>>   Ampere: https://lore.kernel.org/all/e17e28ac-28c7-496f-b212-
> >>>   2c9b552dbf63@amperemail.onmicrosoft.com/
> >>>   Oracle: https://lore.kernel.org/all/46D74D30-EE54-4AD2-8F0E-
> >>>   BA5627FAA63E@oracle.com/
> >>>   
> >>>   
> >>>   For ARM, please check below patch part of RFC V3 for changes related to
> >>>   migration:
> >>>   https://lore.kernel.org/qemu-devel/20240613233639.202896-15-
> >>>   salil.mehta@huawei.com/  
> >>
> >>
> >> Do you wish to move below change into this path-set and make it common
> >> to all instead?  
> > 
> > it would be the best to include this with here.
> >   
> >>
> >>
> >> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> >> index 63226b0040..e92ce07955 100644
> >> --- a/hw/acpi/generic_event_device.c
> >> +++ b/hw/acpi/generic_event_device.c
> >> @@ -333,6 +333,16 @@ static const VMStateDescription vmstate_memhp_state = {
> >>       }
> >>   };
> >>   
> >> +static const VMStateDescription vmstate_cpuhp_state = {
> >> +    .name = "acpi-ged/cpuhp",
> >> +    .version_id = 1,
> >> +    .minimum_version_id = 1,
> >> +    .fields      = (VMStateField[]) {
> >> +        VMSTATE_CPU_HOTPLUG(cpuhp_state, AcpiGedState),
> >> +        VMSTATE_END_OF_LIST()
> >> +    }
> >> +};
> >> +
> >>   static const VMStateDescription vmstate_ged_state = {
> >>       .name = "acpi-ged-state",
> >>       .version_id = 1,
> >> @@ -381,6 +391,7 @@ static const VMStateDescription vmstate_acpi_ged = {
> >>       },
> >>       .subsections = (const VMStateDescription * const []) {
> >>           &vmstate_memhp_state,
> >> +        &vmstate_cpuhp_state,  
> > 
> > I'm not migration guru but I believe this should be conditional
> > to avoid breaking cross-version migration.
> > See 679dd1a957d '.needed = vmstate_test_use_cpuhp. part  
> 
> 
> Sure, thanks for this. As I can see, the needed() function is used at
> the source to decide if the state corresponding to a particular device
> can be forwarded to the destination QEMU/VM. But how can this be used
> to check for cross-version migration?

what I'd do is to make sure that older machine types to not have
cpu hotplug enabled in supported events, and only machine that
has full support for hotplug enabled the bit. And then
machine_init depending on that would manage actual 'ged-event'
property.

Then later VMSD.needed would check ged-event to decide
if section should be used or omitted.


> 
> BTW, I've prepared V16. May I request a quick peek at:
> 
> https://github.com/salil-mehta/qemu/commits/virt-cpuhp-armv8/rfc-v3.arch.agnostic.v16/

looked at
   hw/acpi: Update ACPI GED framework to support vCPU Hotplug

I get that ged_event loop in realize was copy-pasted from _EVT handler,
but that looks a bit complicated (though I won't object, it's matter of taste)

I'd prefer simpler condition than for() {} loop, and just use simpler 'if'

if (enabled_events & ACPI_GED_CPU_HOTPLUG_EVT) {
    init cpu hp code
}

PS:
if you keep for loop, I'd replace  error_report() + abort() with 'error_abort'

> 
> 
> Above does not have the suggested migration change yet. I can add it as
> a separate path
> 
> 
> Best regards,
> Salil
> 
> > 
> > CCing Peter
> >   
> >>           &vmstate_ghes_state,
> >>           NULL
> >>       }
> >>
> >> Maybe I can add a separate patch for this in the end? Please confirm.
> >>
> >> Thanks
> >> Salil.  
> >   
> 


