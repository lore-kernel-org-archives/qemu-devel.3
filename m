Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD37D4337E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 16:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t95p3-0005qi-2R; Thu, 07 Nov 2024 11:57:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t95p0-0005qP-MV
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:57:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t95ox-000864-HD
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730998640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rrCTtWuu+7TAJvD8VFDy9NKfEB2Ww99Dp+mj3g6wArE=;
 b=M6K9u2xWozfSCg2Re4UerdCQ4sogJn+0QtDJHX/7QxkkbkpnLIZ1lSfoRb0X6ibfWLBYj2
 7btBx5bj0kFunkLaNVYo6gH2fUwO1gRqyD6XUgPcxlUwbFc6GWTQst7OSnXzIpZR3OUcMG
 HKG1vzNTeL1Ne6v07v4saVzrp93FXR8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-nOcgCK92O16c-4AgirMf2A-1; Thu, 07 Nov 2024 11:57:19 -0500
X-MC-Unique: nOcgCK92O16c-4AgirMf2A-1
X-Mimecast-MFC-AGG-ID: nOcgCK92O16c-4AgirMf2A
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43159603c92so7905945e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 08:57:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730998638; x=1731603438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rrCTtWuu+7TAJvD8VFDy9NKfEB2Ww99Dp+mj3g6wArE=;
 b=dz+BnfP0+9ZRCgdai8nOxLBwD7bS2tj0/r11DbGGqJGEUWOR44uyioxHGbEoU7wh20
 wm+Vwc1JI1H0vt67qUOKUZZOixE4qUKUSb+mTCFhFQjerf+gy4mXlULHMWkQlkI+o48H
 NoGEuegBzHmzcfdNTc6aPhPn4fJpndbt+xCVUIRJU6hqmwXECtkReXZ1ps7FZ7UPkDMu
 CEQSlWN3DoruqFL3Zca4X7f35Sx4JqwCMe/kAKOmK6yVXJ+7mKKZHI8jiyB4un4Zdqd8
 SONOeqp08ITlOK2CbUNi5HDb2zjkZe52H5VmNCgvQKY/j6RcJdn7mu8Kac/QBI740owZ
 X/aQ==
X-Gm-Message-State: AOJu0YwtjqH1u2OTaXReuzCzd6ud19IMMTblvIVSPUZusRH1SgLG80jj
 AB45eWz2J4mz5baeEnJELprl5xIV4ja8KIub91ya5j5xrFVM6Mq6B2EK1xPDxathJY+zZsK1sRx
 vKKBym0rdQczmVr7g2d/VrrZ4wh+UBBNNKK1A2bRZiyEKUl70ZAWO
X-Received: by 2002:a05:600c:3d8a:b0:431:57e5:b251 with SMTP id
 5b1f17b1804b1-4328327e6d2mr182011945e9.28.1730998638155; 
 Thu, 07 Nov 2024 08:57:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGt87q4fr9JkRJuJWURsxi6+B7b9KWmB1jInFj8n3mFsLEr5xphNcAWS0KY/DPgM76FCEqwRQ==
X-Received: by 2002:a05:600c:3d8a:b0:431:57e5:b251 with SMTP id
 5b1f17b1804b1-4328327e6d2mr182011635e9.28.1730998637732; 
 Thu, 07 Nov 2024 08:57:17 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa70a1f8sm70293115e9.30.2024.11.07.08.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 08:57:16 -0800 (PST)
Date: Thu, 7 Nov 2024 17:57:15 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "anisinha@redhat.com"
 <anisinha@redhat.com>, "eduardo@habkost.net" <eduardo@habkost.net>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "peterx@redhat.com" <peterx@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "gshan@redhat.com"
 <gshan@redhat.com>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>, "salil.mehta@opnsrc.net"
 <salil.mehta@opnsrc.net>, zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng
 (C)" <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>, Linuxarm
 <linuxarm@huawei.com>, "gustavo.romero@linaro.org"
 <gustavo.romero@linaro.org>
Subject: Re: [PATCH 2/3] Fix: Reverse CPUs presence check logic for x86
 backward compatability
Message-ID: <20241107175715.4f07ae22@imammedo.users.ipa.redhat.com>
In-Reply-To: <2bb1abda0787405b95af0233940e3df7@huawei.com>
References: <20241106130331.205020-1-salil.mehta@huawei.com>
 <20241106130331.205020-3-salil.mehta@huawei.com>
 <20241106145635.77332d7c@imammedo.users.ipa.redhat.com>
 <28a19ad7554e4b70819e1435669eeba3@huawei.com>
 <20241106170734.0c7a5adb@imammedo.users.ipa.redhat.com>
 <2bb1abda0787405b95af0233940e3df7@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 6 Nov 2024 19:05:15 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:

> Hi Igor,
> 
> Thanks for replying back and the reviews. Please find my replies
> inline.
> 
> >  From: Igor Mammedov <imammedo@redhat.com>
> >  Sent: Wednesday, November 6, 2024 4:08 PM
> >  To: Salil Mehta <salil.mehta@huawei.com>
> >  
> >  On Wed, 6 Nov 2024 14:45:42 +0000
> >  Salil Mehta <salil.mehta@huawei.com> wrote:
> >    
> >  > Hi Igor,
> >  >  
> >  > >  From: qemu-arm-bounces+salil.mehta=huawei.com@nongnu.org  
> >  <qemu-  
> >  > > arm-bounces+salil.mehta=huawei.com@nongnu.org> On Behalf Of Igor
> >  > > Mammedov
> >  > >  Sent: Wednesday, November 6, 2024 1:57 PM
> >  > >  To: Salil Mehta <salil.mehta@huawei.com>
> >  > >
> >  > >  On Wed, 6 Nov 2024 13:03:30 +0000
> >  > >  Salil Mehta <salil.mehta@huawei.com> wrote:
> >  > >  
> >  > >  > Checking `is_present` first can break x86 migration from new Qemu
> >  > > > version to old Qemu. This is because CPRS Bit is not defined in  
> >  > > the  > older Qemu register block and will always be 0 resulting in
> >  > > check  > always failing. Reversing the logic to first check
> >  > > `is_enabled` can  > alleviate below problem:  
> >  > >  >
> >  > >  > -                If ((\_SB.PCI0.PRES.CPEN == One))
> >  > >  > -                {
> >  > >  > -                    Local0 = 0x0F
> >  > >  > +                If ((\_SB.PCI0.PRES.CPRS == One))
> >  > >  > +                {
> >  > >  > +                    If ((\_SB.PCI0.PRES.CPEN == One))
> >  > >  > +                    {
> >  > >  > +                        Local0 = 0x0F
> >  > >  > +                    }
> >  > >  > +                    Else
> >  > >  > +                    {
> >  > >  > +                        Local0 = 0x0D
> >  > >  > +                    }
> >  > >  >                  }
> >  > >  >
> >  > >  > Suggested-by: Igor Mammedov <imammedo@redhat.com>  
> >  'Reported-by'  
> >  > > maybe, but certainly not suggested.  
> >  >
> >  >
> >  > No issues. I can change.
> >  >
> >  >  
> >  > >
> >  > >  After more thinking and given presence is system wide that doesn't
> >  > > change  at runtime, I don't see any reason for introducing presence
> >  > > bit as ABI (and  undocumented on top of that).  
> >  >
> >  >
> >  > This is a wrong assumption. Presence bit can change in future. We have
> >  > taken into account this aspect by design in the kernel code as well.
> >  > Both virtual  
> >  
> >  Above does imply that support for really hotpluggable CPUs might be
> >  implemented in the future.
> >  Can you point to relevant kernel code/patches?  
> 
> 
> Let me make it clear so that there is no confusion, there is no support of
> physical "CPU" hot-plug on ARM platforms right now and nor will there be
> any in future as it does not makes sense to have. The point I made in the
> patches is about hot-plug was at different granularity which has not been
> denied by ARM.

_STA and ACPI cphp registers are per logical CPU and can't be anything else
per spec.

how different granularity is relevant here?

> 
> >    
> >  > and physical CPU hot plug can co-exists or entirely as sole features.
> >  > This is a requirement.  
> >  
> >  
> >  I don't see any _must_ requirements here whatsoever. If/when ARM
> >  reaches point where standby and hotplug cpus are mixed within VM
> >  instance, we might have to expose presence bit to guest dynamically but it
> >  is totally not needed within observable future and premature.  
> 
> 
> >  Your cpu class presence check also works target-wise just with more boiler
> >  code
> >  + not needed presence bit ABI for guest side,
> >  The same as my suggestion only from other side.
> >  
> >  But regardless of that as long as machine has doesn't mix always present
> >  CPUs with hotpluggable ones within the same instance, changing AML side
> >  as I've just suggested works.  
> 
> 
> Sure, I'm not disagreeing. It will work by adding the flag you've suggested
> but it will work even by not adding any flag and not defining a `persistent`
> hook for any architecture.

hook is more complicated and hidden way, than directly passing down
configuration data to routine that builds AML where it is needed,
but that's cosmetics in the end.

However there is more to your hook approach, it exposes is_present bit
in cphp flag register which is ABI to guest which we will have to
maintain forever and guest will do not necessary round-trip to QEMU
to query it, while alternative is much simpler AML change without any
ABI changes to care about.

The point is we shouldn't add new ABI unless we have to.
In this case new ABI (is_presence flag) is not _must_,
and much simpler static AML change is sufficient. 

> >  
> >  If ARM ever gets real cpu hotplug as your comment above hints, my
> >  suggestion also works fine. With only difference that board code would turn
> >  off always_present_cpus if hotpluggable CPUs are used instead of standby.  
> 
> 
> Sure, but is it necessary to define a new flag when you can do even without it?
> Having few lines of extra code (literally 2-3 only) should not be a major cause of
> worry, especially, if it makes design more clear and easy to understand. This is
> not a performance code either.
>
> Again, I appreciate your compact logic. I'm not disagreeing with it.
> 
> 
> >  > >  Instead changing AML code to account for it would be better,
> >  > > something like
> >  > >  this:
> >  > >
> >  > >  diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h index
> >  > >  32654dc274..4a3e591120 100644
> >  > >  --- a/include/hw/acpi/cpu.h
> >  > >  +++ b/include/hw/acpi/cpu.h
> >  > >  @@ -55,6 +55,7 @@ void cpu_hotplug_hw_init(MemoryRegion *as,  
> >  Object  
> >  > > *owner,  typedef struct CPUHotplugFeatures {
> >  > >       bool acpi_1_compatible;
> >  > >       bool has_legacy_cphp;
> >  > >  +    bool always_present_cpus;  
> >  >
> >  >
> >  > This has to be fetched from architecture code. Please see other
> >  > changes in the V3 patch-set.  
> >  
> >  I've seen, that and it doesn't have to be fetched dynamically.  
> 
> 
> Agreed, it is not necessary to be fetched. Hence, if you do not define the
> hook. In later case, it assumes the existing logic, which x86 has been following.
> It will work.

It is better to get rid of not necessary hook altogether, and
replace it with a simple AML change.

> >  In my opinion the series was not ready to be merged (Michael probably
> >  picked it by mistake).
> >  
> >  We don't really need this in 9.2 as it is only ARM cpu 'hotplug'
> >  related, and the later is not ready for 9.2.
> >  I'd prefer the series being reverted and we continue improving series,
> >  instead of rushing it and fixing broken thing up.
> >  
> >    
> >  >
> >  >  
> >  > >       bool fw_unplugs_cpu;
> >  > >       const char *smi_path;
> >  > >   } CPUHotplugFeatures;
> >  > >  diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c index
> >  > > 5cb60ca8bc..2bcce2b31c
> >  > >  100644
> >  > >  --- a/hw/acpi/cpu.c
> >  > >  +++ b/hw/acpi/cpu.c
> >  > >  @@ -452,15 +452,16 @@ void build_cpus_aml(Aml *table,  
> >  MachineState  
> >  > > *machine, CPUHotplugFeatures opts,
> >  > >
> >  > >           method = aml_method(CPU_STS_METHOD, 1, AML_SERIALIZED);
> >  > >           {
> >  > >  +            uint8_t default_sta = opts.always_present_cpus?0xd:0;
> >  > >               Aml *idx = aml_arg(0);
> >  > >  -            Aml *sta = aml_local(0);
> >  > >  +            Aml *sta = aml_local(default_sta);
> >  > >
> >  > >               aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
> >  > >               aml_append(method, aml_store(idx, cpu_selector));
> >  > >               aml_append(method, aml_store(zero, sta));
> >  > >               ifctx = aml_if(aml_equal(is_enabled, one));
> >  > >               {
> >  > >  -                aml_append(ifctx, aml_store(aml_int(0xF), sta));
> >  > >  +                aml_append(ifctx, aml_or(aml_int(0xF), sta, sta));
> >  > >               }
> >  > >               aml_append(method, ifctx);
> >  > >               aml_append(method, aml_release(ctrl_lock))
> >  > >
> >  > >  then for ARM set
> >  > >   CPUHotplugFeatures::always_present_cpus = true to get present flag
> >  > > always enabled  
> >  >
> >  >
> >  > We MUST fetch this from architecture code as this can dynamically
> >  > change in future and hence, we need to keep that flexibility  
> >  
> >  CPUHotplugFeatures::always_present_cpus can be set dynamically per VM
> >  instance or per Machine type.  
> 
> 
> Yes, but you need a code for that and I'm not sure what is being saved by
> introducing an extra flag then?

beside snippet, I've suggested. You need to delete all is_present callback
related logic, than it save quite a bit, and not only on lines of code.

I guess, I need to send a patch to get point across.

> 
> 
> >  > >  After that revert _all_ other presence bit related changes that
> >  > > were just  merged.
> >  > >  (I did ask to get rid of that in previous reviews but it came back
> >  > > again for no  good reason).  
> >  >
> >  >
> >  > The CPUs AML in the V2 patch-set would have broken the x86  
> >  functionality.
> >  
> >  Frankly speaking, I don't see much progress. All that happens on respins is
> >  flipping between what I asked to remove before to some earlier concept.  
> 
> 
> I think then you've missed the code which addressed one of your key concerns
> in the V1 patch-set that would have broken x86 migration i.e. presence of the
> `is_enabled` state in the CPU Hot-plug VMSD. That has been removed. Maybe
> you would like to go through the change log of the V3 patch-set
> 
> https://lore.kernel.org/qemu-devel/20241018163118.0ae01a84@imammedo.users.ipa.redhat.com/
> 
> Below is the relevant excerpt from your many comments:
> 
> [...]
> >      .fields = (const VMStateField[]) {
> >          VMSTATE_BOOL(is_inserting, AcpiCpuStatus),
> >          VMSTATE_BOOL(is_removing, AcpiCpuStatus),
> > +        VMSTATE_BOOL(is_present, AcpiCpuStatus),
> > +        VMSTATE_BOOL(is_enabled, AcpiCpuStatus),  
> 
> that's likely will break x86 migration,
> but before bothering peterx, maybe we won't need this hunk if
> is_enabled is migrated as part of vCPU state.
> 

what has been done in v3 is moving is_present/is_enabled,
elsewhere (callbacks in this case). While argument was that
both are not necessary to begin with.

> [...]
> 
> 
> >  And all of that for the purpose to workaround/accommodate fake cpu
> >  hotplug hacks.  
> 
> 
> I've to respectfully disagree on this. This is your assumption which is far from
> reality. The accompanying main series of this will never have vCPUs which are
> *not* present.

Reality of your last posted main series (v5), disagrees with what you are saying here

 [PATCH RFC V5 12/30] arm/virt: Release objects for *disabled* possible vCPUs after init
  https://patchew.org/QEMU/20241015100012.254223-1-salil.mehta@huawei.com/20241015100012.254223-13-salil.mehta@huawei.com/

after this patch, new is_present hook would let you bury the lie
about CPU being present inside ARM specific code.

> BTW, these changes have been tested by Oracle folks with that
> series and are known to work.
> 
> https://lore.kernel.org/qemu-devel/C4FEC9E7-69DB-428A-A85F-30170F98814B@oracle.com/

One can write anything and it can even work somehow,
that however doesn't mean it's something merge-able,
maintainable, ...whatever else come to mind...

> 
> Thanks!
> 
> Best regards
> Salil.
> 
> 


