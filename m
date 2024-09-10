Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E5DECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 11:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snycj-0006IA-ID; Tue, 10 Sep 2024 07:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1snycf-0006Dg-91; Tue, 10 Sep 2024 07:01:25 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1snycc-0007zB-CG; Tue, 10 Sep 2024 07:01:24 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X30yb1Bwkz6K9BJ;
 Tue, 10 Sep 2024 18:57:11 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
 by mail.maildlp.com (Postfix) with ESMTPS id 6980E140A36;
 Tue, 10 Sep 2024 19:01:06 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 13:01:06 +0200
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Tue, 10 Sep 2024 12:01:05 +0100
To: Zhao Liu <zhao1.liu@intel.com>
CC: Gavin Shan <gshan@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
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
Subject: RE: [PATCH RFC V3 01/29] arm/virt,target/arm: Add new ARMCPU
 {socket,cluster,core,thread}-id property
Thread-Topic: [PATCH RFC V3 01/29] arm/virt,target/arm: Add new ARMCPU
 {socket,cluster,core,thread}-id property
Thread-Index: AQHaverDPpQr1lKFK0SrrcqBF6W41rIjVaUAgAuCoZCAGUx/gIAAE3TggAfVAICAAA0+UA==
Date: Tue, 10 Sep 2024 11:01:05 +0000
Message-ID: <cff9b8f407044deb8ed4b1aa5acea5f4@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-2-salil.mehta@huawei.com>
 <11e627ef-d75e-4114-9b93-14d80ec0526b@redhat.com>
 <c889781d3eb048d19bae4ceff8646a4e@huawei.com> <Zthx3dQInrcgly6+@intel.com>
 <9376341923d94a2bbd8d24f4f6844585@huawei.com> <Zt8UGd9YRANnBPVT@intel.com>
In-Reply-To: <Zt8UGd9YRANnBPVT@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.149.160]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

HI Zhao,

>  From: Zhao Liu <zhao1.liu@intel.com>
>  Sent: Monday, September 9, 2024 4:28 PM
>  To: Salil Mehta <salil.mehta@huawei.com>
> =20
>  On Wed, Sep 04, 2024 at 05:37:21PM +0000, Salil Mehta wrote:
>  > Date: Wed, 4 Sep 2024 17:37:21 +0000
>  > From: Salil Mehta <salil.mehta@huawei.com>
>  > Subject: RE: [PATCH RFC V3 01/29] arm/virt,target/arm: Add new ARMCPU
>  > {socket,cluster,core,thread}-id property
>  >
>  > Hi Zhao,
>  >
>  > >  From: zhao1.liu@intel.com <zhao1.liu@intel.com>
>  > >  Sent: Wednesday, September 4, 2024 3:43 PM
>  > >  To: Salil Mehta <salil.mehta@huawei.com>
>  > >
>  > >  Hi Salil,
>  > >
>  > >  On Mon, Aug 19, 2024 at 11:53:52AM +0000, Salil Mehta wrote:
>  > >  > Date: Mon, 19 Aug 2024 11:53:52 +0000  > From: Salil Mehta
>  > > <salil.mehta@huawei.com>  > Subject: RE: [PATCH RFC V3 01/29]
>  > > arm/virt,target/arm: Add new ARMCPU  >
>  > > {socket,cluster,core,thread}-id property
>  > >
>  > >  [snip]
>  > >
>  > >  > >  > NULL); @@ -2708,6 +2716,7 @@ static const CPUArchIdList  > >
>  > > *virt_possible_cpu_arch_ids(MachineState *ms)
>  > >  > >  >   {
>  > >  > >  >       int n;
>  > >  > >  >       unsigned int max_cpus =3D ms->smp.max_cpus;
>  > >  > >  > +    unsigned int smp_threads =3D ms->smp.threads;
>  > >  > >  >       VirtMachineState *vms =3D VIRT_MACHINE(ms);
>  > >  > >  >       MachineClass *mc =3D MACHINE_GET_CLASS(vms);
>  > >  > >  >
>  > >  > >  > @@ -2721,6 +2730,7 @@ static const CPUArchIdList  > >
>  > > *virt_possible_cpu_arch_ids(MachineState *ms)
>  > >  > >  >       ms->possible_cpus->len =3D max_cpus;
>  > >  > >  >       for (n =3D 0; n < ms->possible_cpus->len; n++) {
>  > >  > >  >           ms->possible_cpus->cpus[n].type =3D ms->cpu_type;
>  > >  > >  > +        ms->possible_cpus->cpus[n].vcpus_count =3D smp_thre=
ads;
>  > >  > >  >           ms->possible_cpus->cpus[n].arch_id =3D
>  > >  > >  >               virt_cpu_mp_affinity(vms, n);
>  > >  > >  >
>  > >  > >
>  > >  > >  Why @vcpus_count is initialized to @smp_threads? it needs to
>  > > be  > > documented in the commit log.
>  > >  >
>  > >  >
>  > >  > Because every thread internally amounts to a vCPU in QOM and
>  > > which is  > in 1:1 relationship with KVM vCPU. AFAIK, QOM does not
>  > > strictly  > follows any architecture. Once you start to get into
>  > > details of  > threads there are many aspects of shared resources one
>  > > will have to  > consider and these can vary across different
>  > > implementations of  architecture.
>  > >
>  > >  For SPAPR CPU, the granularity of >possible_cpus->cpus[] is "core",
>  > > and for  x86, it's "thread" granularity.
>  >
>  >
>  > We have threads per-core at microarchitecture level in ARM as well.
>  > But each thread appears like a vCPU to OS and AFAICS there are no
>  > special attributes attached to it. SMT can be enabled/disabled at
>  > firmware and should get reflected in the configuration accordingly
>  > i.e. value of *threads-per-core* changes between 1 and 'N'.  This
>  > means 'vcpus_count' has to reflect the correct configuration. But I
>  > think threads lack proper representation in Qemu QOM.
> =20
>  In topology related part, SMT (of x86) usually represents the logical
>  processor level. And thread has the same meaning.


Agreed. It is same in ARM as well. The difference could be in how hardware
threads are implemented at microarchitecture level.  Nevertheless, we do
have such virtual configurations, and the meaning of *threads* as-in QOM
topology (socket,cluster,core,thread) is virtualized similar to the hardwar=
e
threads in host. And One should be able to configure threads support in the
virtual environment,  regardless whether or not underlying hardware
supports threads. That's my take.

Other aspect is how we then expose these threads to the guest. The guest
kernel (just like host kernel) should gather topology information using
ACPI PPTT Table (This is ARM specific?). Later is populated by the Qemu
(just like by firmware for the host kernel) by making use of the virtual
topology. ARM guest kernel, in absence of PPTT support can detect
presence of hardware threads by reading MT Bit within the MPIDR_EL1
register.

Every property in 'ms->possible_cpus->cpus[n].props should be exactly
same as finalized and part of the MachineState::CpuTopology.
Hence, number of threads-per-core 'vcpus_count'  should not be treated
differently.=20

But there is  a catch! (I explained that earlier)


 To change these
>  meanings is also possible, but I think it should be based on the actual =
use
>  case. we can consider the complexity of the implementation when there is=
 a
>  need.


Agreed. There is no ambiguity in the meaning of hardware threads or the=20
virtualized MachineState::CpuTopology. Properties of all the possible vCPUs
should exactly be same as part of MachineState. This includes the number
of threads-per-core.

You mentioned 'vcpus_count' should be 1 but does that mean user can never
specify threads > 1 in virtual configuration for x86?


> =20
>  > In Qemu, each vCPU reflects an execution context (which gets uniquely
>  > mapped to KVM vCPU). AFAICS, we only have *CPUState* (Struct
>  ArchCPU)
>  > as a placeholder for this execution context and there is no
>  > *ThreadState* (derived out of Struct CPUState). Hence, we've  to map
>  > all the threads as QOM vCPUs. This means the array of present or
>  > possible CPUs represented by 'struct CPUArchIdList' contains all
>  > execution contexts which actually might be vCPU or a thread. Hence,
>  > usage of
>  > *vcpus_count* seems quite superficial to me frankly.
>  >
>  > Also, AFAICS, KVM does not have the concept of the threads and only
>  > has KVM vCPUs, but you are still allowed to specify the topology with
>  > sockets, dies, clusters, cores, threads in most architectures.
> =20
>  There are some uses for topology, such as it affects scheduling behavior=
,
>  and it affects feature emulation, etc.


True. And we should be flexible at the VMM level. We should let Admin of
the VMM control how he creates the virtual topology which best fits
on the underlying hardware features of the host. This includes, NUMA,
sub-NUMA, cores, hardware, threads, cache topology etc.=20


> =20
>  > >  And smp.threads means how many threads in one core, so for x86, the
>  > > vcpus_count of a "thread" is 1, and for spapr, the vcpus_count of a
>  "core" equals to smp.threads.
>  >
>  >
>  > Sure, but does the KVM specifies this?
> =20
>  At least as you said, KVM (for x86) doesn't consider higher-level topolo=
gies
>  at the moment, but that's not to say that it won't in the future, as cer=
tain
>  registers do have topology dependencies.


sure. so you mean for x86 virtual topology, smp.threads =3D 1 always?


> =20
>  > and how does these threads map to the QOM vCPU objects or execution
>  context?
> =20
>  Each CPU object will create a (software) thread, you can refer the funct=
ion
>  "kvm_start_vcpu_thread(CPUState *cpu)", which will be called when CPU
>  object realizes.


Yes, sure, and each such QOM vCPU thread and 'struct CPUState' is mapped to
the lowest granularity of execution specified within the QOM virtual topolo=
gy.
It could be a 'thread' or a 'core'. And all these will run as a KVM vCPU sc=
heduled
on some hardware core and maybe hardware thread (if enabled).

So there is no difference across architectures regarding this part. I was t=
rying
to point that in QOM, even the threads will have their own 'struct CPUState=
'
and each one will be part of the "CPUArchIdList *possible_cpus" maintained
at the MachineState. At this level we loose the relationship information of
the cores and their corresponding threads (given by 'vcpus_count').


>  > AFAICS there is nothing but 'CPUState'
>  > which will be made part of the  possible vCPU list 'struct CPUArchIdLi=
st'.
> =20
>  As I said, an example is spapr ("spapr_possible_cpu_arch_ids()"), which
>  maps possible_cpu to core object. However, this is a very specific examp=
le,
>  and like Igor's slides said, I understand it's an architectural requirem=
ent.


I'm sure there must have been some. I'm trying to understand it. Can you
share the slides?


> =20
>  > >
>  > >  IIUC, your granularity is still "thread", so that this filed should=
 be 1.
>  >
>  >
>  > Well, again we need more discussion on this. I've stated my concerns
>  > against doing this. User should be allowed to create virtual topology
>  > which will include 'threads' as one of the parameter.
>  >
> =20
>  I don't seem to understand...There is a "threads" parameter in -smp, doe=
s
>  this not satisfy your use case?

It certainly does. But this is what should get reflected in the 'vcpus_coun=
t' as well?=20


Best regards
Salil

> =20
>  Regards,
>  Zhao
> =20


