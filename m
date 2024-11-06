Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F64D59F50
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 16:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8iZO-0004I9-NP; Wed, 06 Nov 2024 11:07:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t8iZM-0004Hb-5t
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 11:07:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t8iZI-0004Zd-Nq
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 11:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730909260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OO+1Xz9kPoxa2BLbOM9BMqtCrXow0wDqno+akvmyg1o=;
 b=KfEXXyTnGMsBJsItfYIZxr3e+cVz5hEEgoacIxisiNLPnn3KVDIAb7cW5i6xTireJYx3XL
 ceA0PKi22Tz+tdPOKYlYxC1+LOsFKhENPbvynrCSZZyMZ4h6pPEYPMI592U3wHDAa5r/U2
 qNs3pBb54H5X2EW9WBa5+BnfKMk8FEU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-ccERuHlpP4a9AnkGiuwhLA-1; Wed, 06 Nov 2024 11:07:38 -0500
X-MC-Unique: ccERuHlpP4a9AnkGiuwhLA-1
X-Mimecast-MFC-AGG-ID: ccERuHlpP4a9AnkGiuwhLA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d4d51b4efso3056446f8f.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 08:07:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730909257; x=1731514057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OO+1Xz9kPoxa2BLbOM9BMqtCrXow0wDqno+akvmyg1o=;
 b=g2HWFnZEL+F4Wj06SMvzR1uxUzxrC8VHVizyNRxJDEIGRG+5wsfT/WVJICrWR31ztC
 pTtNSwljc3kZQTROWimzZzTgjKsFls+6lRKkwbd7WGYSjMpbrm0PK2RrxWKzN3Z/bvVL
 V2NlY+OqaWbYLtSZgB8wpRA58+gdLjrrICx0yQOlWuABqRjWnbtUeU/ncbYneaOgG13o
 dDbiX79ZP3hPv9g+vx5XDi7VLmZPgW1/A+bAcIqRJoCg+WHO0NUIqEakHwxh/ZwOFuTr
 Jdl5CPD7GC4v4qFthSUt5gxJPT6Tvv/Tk+vOdK/GZIufW2B2NZyLn4gqvbqmvrzIX9Il
 5MSQ==
X-Gm-Message-State: AOJu0YzPC6alzKSkZ3qHoBS7M6GIQy7Mh7tM2lx81NJ58WSONBp7BW79
 xlKYzpkDI53F9lsbQEHM2lkVXN/dkg8KVtSjsd77DthP0TyghWF203HiIc+qq5clz7xk37TcN3l
 FSmPSNJKGXry2T6//fEJNkwVOPcgEeZzSPRCoe02F96aIxWOXJrY0
X-Received: by 2002:a5d:4cd0:0:b0:376:37e:2729 with SMTP id
 ffacd0b85a97d-3806115ae83mr26848947f8f.31.1730909257417; 
 Wed, 06 Nov 2024 08:07:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IET7NyMXXtbfhh38XxrPWOJgvtM7hhc4L0QFI+kmHjxnzWDDX8wMSYC6lxoIoMFGJQSfrjjSQ==
X-Received: by 2002:a5d:4cd0:0:b0:376:37e:2729 with SMTP id
 ffacd0b85a97d-3806115ae83mr26848893f8f.31.1730909256927; 
 Wed, 06 Nov 2024 08:07:36 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113de0esm19679552f8f.85.2024.11.06.08.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 08:07:36 -0800 (PST)
Date: Wed, 6 Nov 2024 17:07:34 +0100
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
Message-ID: <20241106170734.0c7a5adb@imammedo.users.ipa.redhat.com>
In-Reply-To: <28a19ad7554e4b70819e1435669eeba3@huawei.com>
References: <20241106130331.205020-1-salil.mehta@huawei.com>
 <20241106130331.205020-3-salil.mehta@huawei.com>
 <20241106145635.77332d7c@imammedo.users.ipa.redhat.com>
 <28a19ad7554e4b70819e1435669eeba3@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 6 Nov 2024 14:45:42 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:

> Hi Igor,
> 
> >  From: qemu-arm-bounces+salil.mehta=huawei.com@nongnu.org <qemu-
> >  arm-bounces+salil.mehta=huawei.com@nongnu.org> On Behalf Of Igor
> >  Mammedov
> >  Sent: Wednesday, November 6, 2024 1:57 PM
> >  To: Salil Mehta <salil.mehta@huawei.com>
> >  
> >  On Wed, 6 Nov 2024 13:03:30 +0000
> >  Salil Mehta <salil.mehta@huawei.com> wrote:
> >    
> >  > Checking `is_present` first can break x86 migration from new Qemu
> >  > version to old Qemu. This is because CPRS Bit is not defined in the
> >  > older Qemu register block and will always be 0 resulting in check
> >  > always failing. Reversing the logic to first check `is_enabled` can
> >  > alleviate below problem:
> >  >
> >  > -                If ((\_SB.PCI0.PRES.CPEN == One))
> >  > -                {
> >  > -                    Local0 = 0x0F
> >  > +                If ((\_SB.PCI0.PRES.CPRS == One))
> >  > +                {
> >  > +                    If ((\_SB.PCI0.PRES.CPEN == One))
> >  > +                    {
> >  > +                        Local0 = 0x0F
> >  > +                    }
> >  > +                    Else
> >  > +                    {
> >  > +                        Local0 = 0x0D
> >  > +                    }
> >  >                  }
> >  >
> >  > Suggested-by: Igor Mammedov <imammedo@redhat.com>  
> >  'Reported-by' maybe, but certainly not suggested.  
> 
> 
> No issues. I can change.
> 
> 
> >  
> >  After more thinking and given presence is system wide that doesn't change
> >  at runtime, I don't see any reason for introducing presence bit as ABI (and
> >  undocumented on top of that).  
> 
> 
> This is a wrong assumption. Presence bit can change in future. We have taken
> into account this aspect by design in the kernel code as well. Both virtual

Above does imply that support for really hotpluggable CPUs might be implemented
in the future.
Can you point to relevant kernel code/patches?

> and physical CPU hot plug can co-exists or entirely as sole features.  This is
> a requirement.


I don't see any _must_ requirements here whatsoever. If/when ARM reaches point
where standby and hotplug cpus are mixed within VM instance, we might have to
expose presence bit to guest dynamically but it is totally not needed within
observable future and premature.

Your cpu class presence check also works target-wise just with more boiler code
+ not needed presence bit ABI for guest side,
The same as my suggestion only from other side.

But regardless of that as long as machine has doesn't mix always present CPUs
with hotpluggable ones within the same instance, changing AML side
as I've just suggested works.

If ARM ever gets real cpu hotplug as your comment above hints, my suggestion
also works fine. With only difference that board code would turn off
always_present_cpus if hotpluggable CPUs are used instead of standby.

> 
> >  
> >  Instead changing AML code to account for it would be better, something like
> >  this:
> >  
> >  diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h index
> >  32654dc274..4a3e591120 100644
> >  --- a/include/hw/acpi/cpu.h
> >  +++ b/include/hw/acpi/cpu.h
> >  @@ -55,6 +55,7 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object
> >  *owner,  typedef struct CPUHotplugFeatures {
> >       bool acpi_1_compatible;
> >       bool has_legacy_cphp;
> >  +    bool always_present_cpus;  
> 
> 
> This has to be fetched from architecture code. Please see other changes in the V3
> patch-set.

I've seen, that and it doesn't have to be fetched dynamically.
In my opinion the series was not ready to be merged
(Michael probably picked it by mistake).

We don't really need this in 9.2 as it is only ARM cpu 'hotplug'
related, and the later is not ready for 9.2.
I'd prefer the series being reverted and we continue improving series,
instead of rushing it and fixing broken thing up.


> 
> 
> >       bool fw_unplugs_cpu;
> >       const char *smi_path;
> >   } CPUHotplugFeatures;
> >  diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c index 5cb60ca8bc..2bcce2b31c
> >  100644
> >  --- a/hw/acpi/cpu.c
> >  +++ b/hw/acpi/cpu.c
> >  @@ -452,15 +452,16 @@ void build_cpus_aml(Aml *table, MachineState
> >  *machine, CPUHotplugFeatures opts,
> >  
> >           method = aml_method(CPU_STS_METHOD, 1, AML_SERIALIZED);
> >           {
> >  +            uint8_t default_sta = opts.always_present_cpus?0xd:0;
> >               Aml *idx = aml_arg(0);
> >  -            Aml *sta = aml_local(0);
> >  +            Aml *sta = aml_local(default_sta);
> >  
> >               aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
> >               aml_append(method, aml_store(idx, cpu_selector));
> >               aml_append(method, aml_store(zero, sta));
> >               ifctx = aml_if(aml_equal(is_enabled, one));
> >               {
> >  -                aml_append(ifctx, aml_store(aml_int(0xF), sta));
> >  +                aml_append(ifctx, aml_or(aml_int(0xF), sta, sta));
> >               }
> >               aml_append(method, ifctx);
> >               aml_append(method, aml_release(ctrl_lock))
> >  
> >  then for ARM set
> >   CPUHotplugFeatures::always_present_cpus = true to get present flag
> >  always enabled  
> 
> 
> We MUST fetch this from architecture code as this can dynamically change in
> future and hence, we need to keep that flexibility

CPUHotplugFeatures::always_present_cpus can be set dynamically per VM instance
or per Machine type.

> >  
> >  After that revert _all_ other presence bit related changes that were just
> >  merged.
> >  (I did ask to get rid of that in previous reviews but it came back again for no
> >  good reason).  
> 
> 
> The CPUs AML in the V2 patch-set would have broken the x86 functionality.

Frankly speaking, I don't see much progress. All that happens on respins
is flipping between what I asked to remove before to some earlier concept.
And all of that for the purpose to workaround/accommodate fake cpu hotplug hacks.

> Thanks
> Salil.
> 


