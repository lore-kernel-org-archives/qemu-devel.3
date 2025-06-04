Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FCCC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 10:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMlq3-0002sM-Fy; Wed, 04 Jun 2025 06:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uMlq0-0002rb-54; Wed, 04 Jun 2025 06:59:16 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uMlpw-0000tm-5a; Wed, 04 Jun 2025 06:59:15 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bC4M71BPpz6K92t;
 Wed,  4 Jun 2025 18:58:43 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 3193D1402CB;
 Wed,  4 Jun 2025 18:58:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Jun 2025 12:58:55 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 4 Jun 2025 12:58:55 +0200
To: Cornelia Huck <cohuck@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "maz@kernel.org"
 <maz@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "sebott@redhat.com" <sebott@redhat.com>, "armbru@redhat.com"
 <armbru@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>, "jdenemar@redhat.com"
 <jdenemar@redhat.com>
CC: "agraf@csgraf.de" <agraf@csgraf.de>, "shahuang@redhat.com"
 <shahuang@redhat.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Subject: RE: [PATCH v3 00/10] kvm/arm: Introduce a customizable aarch64 KVM
 host model
Thread-Topic: [PATCH v3 00/10] kvm/arm: Introduce a customizable aarch64 KVM
 host model
Thread-Index: AQHbrVvRKlWe4qTsaku+jGkyYZoxlrPgb1/QgASMGwCAAWZvgIALVkAAgAFowxA=
Date: Wed, 4 Jun 2025 10:58:55 +0000
Message-ID: <f11e5fbddf634bbc88ba4c07bafe3f26@huawei.com>
References: <20250414163849.321857-1-cohuck@redhat.com>
 <de7db6bc22ad4f0a8ac1fac718c810a1@huawei.com> <87bjrfbkyz.fsf@redhat.com>
 <878qmibc5a.fsf@redhat.com> <87tt4wamcp.fsf@redhat.com>
In-Reply-To: <87tt4wamcp.fsf@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.203.177.241]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
From:  Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Tuesday, June 3, 2025 4:15 PM
> To: Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; eric.auger.pro@gmail.com;
> eric.auger@redhat.com; qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> kvmarm@lists.linux.dev; peter.maydell@linaro.org;
> richard.henderson@linaro.org; alex.bennee@linaro.org; maz@kernel.org;
> oliver.upton@linux.dev; sebott@redhat.com; armbru@redhat.com;
> berrange@redhat.com; abologna@redhat.com; jdenemar@redhat.com
> Cc: agraf@csgraf.de; shahuang@redhat.com; mark.rutland@arm.com;
> philmd@linaro.org; pbonzini@redhat.com
> Subject: RE: [PATCH v3 00/10] kvm/arm: Introduce a customizable aarch64
> KVM host model
>=20
> On Tue, May 27 2025, Cornelia Huck <cohuck@redhat.com> wrote:
>=20
> > On Mon, May 26 2025, Cornelia Huck <cohuck@redhat.com> wrote:
> >
> >> On Fri, May 23 2025, Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com> wrote:
> >>
> >>> Hi,
> >>>
> >>>> -----Original Message-----
> >>>> From: Cornelia Huck <cohuck@redhat.com>
> >>>> Sent: Monday, April 14, 2025 5:39 PM
> >>>> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
> >>>> devel@nongnu.org; qemu-arm@nongnu.org; kvmarm@lists.linux.dev;
> >>>> peter.maydell@linaro.org; richard.henderson@linaro.org;
> >>>> alex.bennee@linaro.org; maz@kernel.org; oliver.upton@linux.dev;
> >>>> sebott@redhat.com; Shameerali Kolothum Thodi
> >>>> <shameerali.kolothum.thodi@huawei.com>; armbru@redhat.com;
> >>>> berrange@redhat.com; abologna@redhat.com;
> jdenemar@redhat.com
> >>>> Cc: agraf@csgraf.de; shahuang@redhat.com; mark.rutland@arm.com;
> >>>> philmd@linaro.org; pbonzini@redhat.com; Cornelia Huck
> >>>> <cohuck@redhat.com>
> >>>> Subject: [PATCH v3 00/10] kvm/arm: Introduce a customizable aarch64
> >>>> KVM host model
> >>>
> >>> [..]
> >>>
> >>> )
> >>>>
> >>>> Code also available at
> >>>> https://gitlab.com/cohuck/qemu/-/tree/arm-cpu-model-
> >>>> rfcv3?ref_type=3Dheads
> >>>
> >>> I had a spin with the above branch, but Qemu boot fails,
> >>>
> >>> ERROR:../target/arm/cpu64.c:57:get_sysreg_idx: code should not be
> >>> reached Bail out! ERROR:../target/arm/cpu64.c:57:get_sysreg_idx:
> >>> code should not be reached
> >>>
> >>> From a quick debug, it looks like the below path results in an invali=
d ID
> idx.
> >>>
> >>> kvm_arm_expose_idreg_properties()
> >>>  kvm_idx_to_idregs_idx(0)
> >>>   get_sysreg_idx(0xc000)  --> id_register seems to start at 0xc008
> >>>
> >>> Haven't debugged further.
> >>>
> >>> I am running against a 6.15-rc1 kernel after updating the Qemu
> >>> branch by, ./update-aarch64-sysreg-code.sh  path_to_6.15-rc1
> >>>
> >>> Not sure I am  missing anything. Please check and let me know.
> >>
> >> Thanks for trying this out; I'll try to re-create this here.
> >> (I think I've messed up those conversion functions often enough...)
> >
> > The conversion functions are not at fault here, but we're missing
> > registers. If we have MIDR and friends writable, they show up in the
> > masks returned by the kernel, but they are not present in the kernel's
> > sysreg file where we generate our definitions from, and
> > kvm_idx_to_idregs_idx() asserts instead of returning an error, which
> > is kind of suboptimal...
> >
> > So I see two possible ways to fix this:
> > - add MIDR and friends to the kernel's sysreg file
> > - add MIDR and friends in QEMU's cpu-sysregs.h.inc file, and only appen=
d
> >   generated definitions there
> >
> > First option means one more round trip, second options has more
> > potential for messing things up if we keep stuff local to QEMU.
>=20
> With the patch below, things work for me with a 6.15+ kernel. It's a bit

Yes works for me too now. Thanks.

> messy, though, and raises questions (how do we want to handle those regs
> across accelerators, for example, or how we can make sure that the code i=
s
> more robust when registers are added.)
>=20
> My biggest question, however, is how this interacts with the framework to
> provide lists of MIDR/REVIDR/AIDR for errata management. The hack below
> adds properties to configure those regs, I guess we'd want to suppress
> adding the props in order to avoid conflicts.

Not sure how this impacts the errata management though. My initial take on
this was, user will provide a list of target CPU ids through command line a=
nd
that will be used to set the target CPUs for errata management(if kernel
supports it).

Eg:
-machine virt,.., x-target-impl-cpus=3D0xMIDR1:0xREVIDR1-0xMIDR2:REVIDR2

And these will be stored in,

#define MAX_TARGET_IMPL_CPUS    4
typedef struct TargetImplCpu {
     uint32_t midr;
     uint32_t revidr;
} TargetImplCpu;


Please see the initial (a hack for testing kernel) implementation here,
https://github.com/hisilicon/qemu/commit/a393c1180274c73d34f32eaab66764a874=
a9ad31

Please let me know if there is a better/preferred way of obtaining this
target CPU list from user.

Thanks,
Shameer


