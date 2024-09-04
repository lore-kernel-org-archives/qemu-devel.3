Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC47CD4857
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 17:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sltwi-0004xL-2l; Wed, 04 Sep 2024 13:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sltwe-0004u9-SC; Wed, 04 Sep 2024 13:37:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sltwc-0004VH-Eo; Wed, 04 Sep 2024 13:37:28 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WzV2s6M5Nz6K5l6;
 Thu,  5 Sep 2024 01:33:41 +0800 (CST)
Received: from lhrpeml500002.china.huawei.com (unknown [7.191.160.78])
 by mail.maildlp.com (Postfix) with ESMTPS id 93BC01400CA;
 Thu,  5 Sep 2024 01:37:21 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 18:37:21 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Wed, 4 Sep 2024 18:37:21 +0100
To: "zhao1.liu@intel.com" <zhao1.liu@intel.com>
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
Thread-Index: AQHaverDPpQr1lKFK0SrrcqBF6W41rIjVaUAgAuCoZCAGUx/gIAAE3Tg
Date: Wed, 4 Sep 2024 17:37:21 +0000
Message-ID: <9376341923d94a2bbd8d24f4f6844585@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-2-salil.mehta@huawei.com>
 <11e627ef-d75e-4114-9b93-14d80ec0526b@redhat.com>
 <c889781d3eb048d19bae4ceff8646a4e@huawei.com> <Zthx3dQInrcgly6+@intel.com>
In-Reply-To: <Zthx3dQInrcgly6+@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.171.6]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhao,

>  From: zhao1.liu@intel.com <zhao1.liu@intel.com>
>  Sent: Wednesday, September 4, 2024 3:43 PM
>  To: Salil Mehta <salil.mehta@huawei.com>
> =20
>  Hi Salil,
> =20
>  On Mon, Aug 19, 2024 at 11:53:52AM +0000, Salil Mehta wrote:
>  > Date: Mon, 19 Aug 2024 11:53:52 +0000
>  > From: Salil Mehta <salil.mehta@huawei.com>
>  > Subject: RE: [PATCH RFC V3 01/29] arm/virt,target/arm: Add new ARMCPU
>  > {socket,cluster,core,thread}-id property
> =20
>  [snip]
> =20
>  > >  > NULL); @@ -2708,6 +2716,7 @@ static const CPUArchIdList
>  > > *virt_possible_cpu_arch_ids(MachineState *ms)
>  > >  >   {
>  > >  >       int n;
>  > >  >       unsigned int max_cpus =3D ms->smp.max_cpus;
>  > >  > +    unsigned int smp_threads =3D ms->smp.threads;
>  > >  >       VirtMachineState *vms =3D VIRT_MACHINE(ms);
>  > >  >       MachineClass *mc =3D MACHINE_GET_CLASS(vms);
>  > >  >
>  > >  > @@ -2721,6 +2730,7 @@ static const CPUArchIdList
>  > > *virt_possible_cpu_arch_ids(MachineState *ms)
>  > >  >       ms->possible_cpus->len =3D max_cpus;
>  > >  >       for (n =3D 0; n < ms->possible_cpus->len; n++) {
>  > >  >           ms->possible_cpus->cpus[n].type =3D ms->cpu_type;
>  > >  > +        ms->possible_cpus->cpus[n].vcpus_count =3D smp_threads;
>  > >  >           ms->possible_cpus->cpus[n].arch_id =3D
>  > >  >               virt_cpu_mp_affinity(vms, n);
>  > >  >
>  > >
>  > >  Why @vcpus_count is initialized to @smp_threads? it needs to be
>  > > documented in the commit log.
>  >
>  >
>  > Because every thread internally amounts to a vCPU in QOM and which is
>  > in 1:1 relationship with KVM vCPU. AFAIK, QOM does not strictly
>  > follows any architecture. Once you start to get into details of
>  > threads there are many aspects of shared resources one will have to
>  > consider and these can vary across different implementations of
>  architecture.
> =20
>  For SPAPR CPU, the granularity of >possible_cpus->cpus[] is "core", and =
for
>  x86, it's "thread" granularity.


We have threads per-core at microarchitecture level in ARM as well. But eac=
h
thread appears like a vCPU to OS and AFAICS there are no special attributes
attached to it. SMT can be enabled/disabled at firmware and should get
reflected in the configuration accordingly i.e. value of *threads-per-core*=
=20
changes between 1 and 'N'.  This means 'vcpus_count' has to reflect the
correct configuration. But I think threads lack proper representation
in Qemu QOM.

In Qemu, each vCPU reflects an execution context (which gets uniquely mappe=
d
to KVM vCPU). AFAICS, we only have *CPUState* (Struct ArchCPU) as a placeho=
lder
for this execution context and there is no *ThreadState* (derived out of
Struct CPUState). Hence, we've  to map all the threads as QOM vCPUs. This m=
eans
the array of present or possible CPUs represented by 'struct CPUArchIdList'=
 contains
all execution contexts which actually might be vCPU or a thread. Hence, usa=
ge of
*vcpus_count* seems quite superficial to me frankly.

Also, AFAICS, KVM does not have the concept of the threads and only has
KVM vCPUs, but you are still allowed to specify the topology with sockets, =
dies,
clusters, cores, threads in most architectures. =20


> =20
>  And smp.threads means how many threads in one core, so for x86, the
>  vcpus_count of a "thread" is 1, and for spapr, the vcpus_count of a "cor=
e"
>  equals to smp.threads.


Sure, but does the KVM specifies this? and how does these threads map to th=
e QOM
vCPU objects or execution context? AFAICS there is nothing but 'CPUState'
which will be made part of the  possible vCPU list 'struct CPUArchIdList'.



> =20
>  IIUC, your granularity is still "thread", so that this filed should be 1=
.


Well, again we need more discussion on this. I've stated my concerns agains=
t
doing this. User should be allowed to create virtual topology which will
include 'threads' as one of the parameter.


> =20
>  -Zhao
> =20
>  > It is a bigger problem than you think, which I've touched at very
>  > nascent stages while doing POC of vCPU hotplug but tried to avoid till=
 now.
>  >
>  >
>  > But I would like to hear other community members views on this.
>  >
>  > Hi Igor/Peter,
>  >
>  > What is your take on this?
>  >
>  > Thanks
>  > Salil.


