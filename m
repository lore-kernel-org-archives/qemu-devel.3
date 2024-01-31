Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C03EC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 06:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV4HT-0001zB-0x; Wed, 31 Jan 2024 01:41:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rV4HN-0001yu-Tj
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 01:41:02 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rV4HI-0007og-O2
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 01:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706683256; x=1738219256;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Utwv8x1yHG+Q/I4M1PRcqkm2D0AGQgovRIihzK8VJwY=;
 b=KeQtaOClzycLwqBwDhSMaVbJEoM+y+6+41fpB10SBTCMj/xaVXIlQDLJ
 5KExFKgJwEUEyywGsMl/nDob+aZOZQAHW5USQWfrUVUIAvbYIycR9uTOO
 wKUE/67N0HaoG22MF6sN7DQx1ASv3YH8OeIzsYv3F5+XHJecTLSsvOn5W
 wTuMVGXn21safEhUYHVQfAbjq+t0NUldszqilBbnkAUk0UK5yh1H1wYrb
 L8dYJcaCrUVpC9+v1+UaI92p/lYITOwzRuJbx7JH6q1QnERR+oqT1TWJa
 oNmrCHvG/PmvyT1F83Pvhs01+Gog/yMJFDQ2dUXki5VnRZBfqEm/Jd1XP A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10261330"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; d="scan'208";a="10261330"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2024 22:40:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3941556"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 30 Jan 2024 22:40:50 -0800
Date: Wed, 31 Jan 2024 14:54:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, kraxel@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] pc: q35: Bump max_cpus to 1856 vcpus
Message-ID: <Zbnum6Mljz6ZoFvx@intel.com>
References: <20240131024906.3920-1-anisinha@redhat.com>
 <ZbnH9Yehg7bWY+ws@intel.com>
 <CAK3XEhOOGFtGPr6h1YpSv54QeBBjVnASUk6k59842vCvBt0qLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK3XEhOOGFtGPr6h1YpSv54QeBBjVnASUk6k59842vCvBt0qLQ@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jan 31, 2024 at 10:47:29AM +0530, Ani Sinha wrote:
> Date: Wed, 31 Jan 2024 10:47:29 +0530
> From: Ani Sinha <anisinha@redhat.com>
> Subject: Re: [PATCH v2] pc: q35: Bump max_cpus to 1856 vcpus
> 
> On Wed, Jan 31, 2024 at 9:27 AM Zhao Liu <zhao1.liu@intel.com> wrote:
> >
> > Hi Ani,
> >
> > On Wed, Jan 31, 2024 at 08:19:06AM +0530, Ani Sinha wrote:
> > > Date: Wed, 31 Jan 2024 08:19:06 +0530
> > > From: Ani Sinha <anisinha@redhat.com>
> > > Subject: [PATCH v2] pc: q35: Bump max_cpus to 1856 vcpus
> > > X-Mailer: git-send-email 2.42.0
> > >
> > > Since commit f10a570b093e6 ("KVM: x86: Add CONFIG_KVM_MAX_NR_VCPUS to allow up to 4096 vCPUs")
> > > Linux kernel can support upto a maximum number of 4096 vCPUS when MAXSMP is
> > > enabled in the kernel. At present, QEMU has been tested to correctly boot a
> > > linux guest with 1856 vcpus and no more both with edk2 and seabios firmwares.
> >
> > About background, could I ask if there will be Host machines with so
> > much CPUs? What are the benefits of vCPUs that far exceed the number
> > of Host CPUs?
> 
> Yes HPE has SAP HANA host machines with large numbers of physical
> cores and memory. For example QEMU was tested on a system with 3840
> cores.

Thanks! For such large system, does the vCPU need the CPU affinity, or
just let them run free on the Host's physical cores?

> 
> >
> > Thanks,
> > Zhao
> >
> > > If an additional vcpu is added, that is with 1857 vcpus, edk2 currently fails
> > > with the following error messages:
> > >
> > > AllocatePages failed: No 0x400 Pages is available.
> > > There is only left 0x2BF pages memory resource to be allocated.
> > > ERROR: Out of aligned pages
> > > ASSERT /builddir/build/BUILD/edk2-ba91d0292e/MdeModulePkg/Core/DxeIplPeim/X64/VirtualMemory.c(814): BigPageAddress != 0
> > >
> > > This error exists only with edk2. Seabios currently can boot a linux guest
> > > fine with 4096 vcpus. Since the lowest common denominator for a working VM for
> > > both edk2 and seabios is 1856 vcpus, bump up the value max_cpus to 1856 for q35
> > > machines versions 9 and newer. Q35 machines versions 8.2 and older continue
> > > to support 1024 maximum vcpus as before for compatibility reasons.
> > >
> > > If KVM is not able to support the specified number of vcpus, QEMU would
> > > return the following error messages:
> > >
> > > $ ./qemu-system-x86_64 -cpu host -accel kvm -machine q35 -smp 1728

In practice, do users need to set the socket level topology and NUMA to
be consistent with Host for this large system?

NUMA settings are also related to topology, and it's better if NUMA is
also covered.

Thanks,
Zhao

> > > qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested (1728) exceeds the recommended cpus supported by KVM (12)
> > > qemu-system-x86_64: -accel kvm: warning: Number of hotpluggable cpus requested (1728) exceeds the recommended cpus supported by KVM (12)
> > > Number of SMP cpus requested (1728) exceeds the maximum cpus supported by KVM (1024)
> > >
> > > Cc: Daniel P. Berrangé <berrange@redhat.com>
> > > Cc: Igor Mammedov <imammedo@redhat.com>
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Julia Suvorova <jusual@redhat.com>
> > > Cc: kraxel@redhat.com
> > > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > > ---
> > >  hw/i386/pc_q35.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > Changelog:
> > > v2: bump up the vcpu number to 1856. Add failure messages from ekd2 in
> > > the commit description.
> > > See also RH Jira https://issues.redhat.com/browse/RHEL-22202
> > >
> > > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > > index f43d5142b8..f9c4b6594d 100644
> > > --- a/hw/i386/pc_q35.c
> > > +++ b/hw/i386/pc_q35.c
> > > @@ -375,7 +375,7 @@ static void pc_q35_machine_options(MachineClass *m)
> > >      m->default_nic = "e1000e";
> > >      m->default_kernel_irqchip_split = false;
> > >      m->no_floppy = 1;
> > > -    m->max_cpus = 1024;
> > > +    m->max_cpus = 1856;
> > >      m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
> > >      machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
> > >      machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
> > > @@ -396,6 +396,7 @@ static void pc_q35_8_2_machine_options(MachineClass *m)
> > >  {
> > >      pc_q35_9_0_machine_options(m);
> > >      m->alias = NULL;
> > > +    m->max_cpus = 1024;
> > >      compat_props_add(m->compat_props, hw_compat_8_2, hw_compat_8_2_len);
> > >      compat_props_add(m->compat_props, pc_compat_8_2, pc_compat_8_2_len);
> > >  }
> > > --
> > > 2.42.0
> > >
> > >
> >
> 
> 

