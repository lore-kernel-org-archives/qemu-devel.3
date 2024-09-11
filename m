Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A96EE4995
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 11:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soLdH-0004PE-EO; Wed, 11 Sep 2024 07:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1soLdC-00048k-Jb; Wed, 11 Sep 2024 07:35:30 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1soLd7-000271-4V; Wed, 11 Sep 2024 07:35:30 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X3dgq6XQSz6L7Fb;
 Wed, 11 Sep 2024 19:31:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id E5B6A1400C9;
 Wed, 11 Sep 2024 19:35:12 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Sep
 2024 13:35:11 +0200
Date: Wed, 11 Sep 2024 12:35:10 +0100
To: Salil Mehta <salil.mehta@huawei.com>
CC: Zhao Liu <zhao1.liu@intel.com>, Gavin Shan <gshan@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "maz@kernel.org"
 <maz@kernel.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>, "miguel.luis@oracle.com"
 <miguel.luis@oracle.com>, "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng (C)"
 <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "shahuang@redhat.com" <shahuang@redhat.com>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH RFC V3 01/29] arm/virt,target/arm: Add new ARMCPU
 {socket,cluster,core,thread}-id property
Message-ID: <20240911123510.00004557@Huawei.com>
In-Reply-To: <cff9b8f407044deb8ed4b1aa5acea5f4@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-2-salil.mehta@huawei.com>
 <11e627ef-d75e-4114-9b93-14d80ec0526b@redhat.com>
 <c889781d3eb048d19bae4ceff8646a4e@huawei.com>
 <Zthx3dQInrcgly6+@intel.com>
 <9376341923d94a2bbd8d24f4f6844585@huawei.com>
 <Zt8UGd9YRANnBPVT@intel.com>
 <cff9b8f407044deb8ed4b1aa5acea5f4@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 10 Sep 2024 12:01:05 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> HI Zhao,

A few trivial comments inline.

> 
> >  From: Zhao Liu <zhao1.liu@intel.com>
> >  Sent: Monday, September 9, 2024 4:28 PM
> >  To: Salil Mehta <salil.mehta@huawei.com>
> >  
> >  On Wed, Sep 04, 2024 at 05:37:21PM +0000, Salil Mehta wrote:  
> >  > Date: Wed, 4 Sep 2024 17:37:21 +0000
> >  > From: Salil Mehta <salil.mehta@huawei.com>
> >  > Subject: RE: [PATCH RFC V3 01/29] arm/virt,target/arm: Add new ARMCPU
> >  > {socket,cluster,core,thread}-id property
> >  >
> >  > Hi Zhao,
> >  >  
> >  > >  From: zhao1.liu@intel.com <zhao1.liu@intel.com>
> >  > >  Sent: Wednesday, September 4, 2024 3:43 PM
> >  > >  To: Salil Mehta <salil.mehta@huawei.com>
> >  > >
> >  > >  Hi Salil,
> >  > >
> >  > >  On Mon, Aug 19, 2024 at 11:53:52AM +0000, Salil Mehta wrote:  
> >  > >  > Date: Mon, 19 Aug 2024 11:53:52 +0000  > From: Salil Mehta  
> >  > > <salil.mehta@huawei.com>  > Subject: RE: [PATCH RFC V3 01/29]
> >  > > arm/virt,target/arm: Add new ARMCPU  >
> >  > > {socket,cluster,core,thread}-id property
> >  > >
> >  > >  [snip]
> >  > >  
> >  > >  > >  > NULL); @@ -2708,6 +2716,7 @@ static const CPUArchIdList  > >  
> >  > > *virt_possible_cpu_arch_ids(MachineState *ms)  
> >  > >  > >  >   {
> >  > >  > >  >       int n;
> >  > >  > >  >       unsigned int max_cpus = ms->smp.max_cpus;
> >  > >  > >  > +    unsigned int smp_threads = ms->smp.threads;
> >  > >  > >  >       VirtMachineState *vms = VIRT_MACHINE(ms);
> >  > >  > >  >       MachineClass *mc = MACHINE_GET_CLASS(vms);
> >  > >  > >  >
> >  > >  > >  > @@ -2721,6 +2730,7 @@ static const CPUArchIdList  > >  
> >  > > *virt_possible_cpu_arch_ids(MachineState *ms)  
> >  > >  > >  >       ms->possible_cpus->len = max_cpus;
> >  > >  > >  >       for (n = 0; n < ms->possible_cpus->len; n++) {
> >  > >  > >  >           ms->possible_cpus->cpus[n].type = ms->cpu_type;
> >  > >  > >  > +        ms->possible_cpus->cpus[n].vcpus_count = smp_threads;
> >  > >  > >  >           ms->possible_cpus->cpus[n].arch_id =
> >  > >  > >  >               virt_cpu_mp_affinity(vms, n);
> >  > >  > >  >  
> >  > >  > >
> >  > >  > >  Why @vcpus_count is initialized to @smp_threads? it needs to  
> >  > > be  > > documented in the commit log.  
> >  > >  >
> >  > >  >
> >  > >  > Because every thread internally amounts to a vCPU in QOM and  
> >  > > which is  > in 1:1 relationship with KVM vCPU. AFAIK, QOM does not
> >  > > strictly  > follows any architecture. Once you start to get into
> >  > > details of  > threads there are many aspects of shared resources one
> >  > > will have to  > consider and these can vary across different
> >  > > implementations of  architecture.
> >  > >
> >  > >  For SPAPR CPU, the granularity of >possible_cpus->cpus[] is "core",
> >  > > and for  x86, it's "thread" granularity.  
> >  >
> >  >
> >  > We have threads per-core at microarchitecture level in ARM as well.
> >  > But each thread appears like a vCPU to OS and AFAICS there are no
> >  > special attributes attached to it. SMT can be enabled/disabled at
> >  > firmware and should get reflected in the configuration accordingly
> >  > i.e. value of *threads-per-core* changes between 1 and 'N'.  This
> >  > means 'vcpus_count' has to reflect the correct configuration. But I
> >  > think threads lack proper representation in Qemu QOM.  
> >  
> >  In topology related part, SMT (of x86) usually represents the logical
> >  processor level. And thread has the same meaning.  
> 
> 
> Agreed. It is same in ARM as well. The difference could be in how hardware
> threads are implemented at microarchitecture level.  Nevertheless, we do
> have such virtual configurations, and the meaning of *threads* as-in QOM
> topology (socket,cluster,core,thread) is virtualized similar to the hardware
> threads in host. And One should be able to configure threads support in the
> virtual environment,  regardless whether or not underlying hardware
> supports threads. That's my take.
> 
> Other aspect is how we then expose these threads to the guest. The guest
> kernel (just like host kernel) should gather topology information using
> ACPI PPTT Table (This is ARM specific?). 

Not ARM specific, but not used by x86 in practice (I believe some risc-v boards
use it).
https://lore.kernel.org/linux-riscv/20240617131425.7526-3-cuiyunhui@bytedance.com/

> Later is populated by the Qemu
> (just like by firmware for the host kernel) by making use of the virtual
> topology. ARM guest kernel, in absence of PPTT support can detect
> presence of hardware threads by reading MT Bit within the MPIDR_EL1
> register.

Sadly no it can't.  Lots of CPUs cores that are single thread set that
bit anyway (so it's garbage and PPTT / DT is the only source of truth)
https://lore.kernel.org/all/CAFfO_h7vUEhqV15epf+_zVrbDhc3JrejkkOVsHzHgCXNk+nDdg@mail.gmail.com/T/

Jonathan


