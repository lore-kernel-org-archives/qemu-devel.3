Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D456C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 11:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTgaO-0006gK-NC; Tue, 16 Jul 2024 07:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sTgaL-0006Wg-6m
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:43:10 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sTgaG-0006Up-NQ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:43:08 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WNcbs4n4Wz6JBDY;
 Tue, 16 Jul 2024 19:41:45 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (unknown [7.191.162.67])
 by mail.maildlp.com (Postfix) with ESMTPS id 1A4611400D9;
 Tue, 16 Jul 2024 19:43:01 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 12:43:00 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Tue, 16 Jul 2024 12:43:00 +0100
To: Igor Mammedov <imammedo@redhat.com>, Salil Mehta <salil.mehta@opnsrc.net>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "maz@kernel.org"
 <maz@kernel.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
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
 <karl.heubaum@oracle.com>, "miguel.luis@oracle.com" <miguel.luis@oracle.com>, 
 zhukeqian <zhukeqian1@huawei.com>, "wangxiongfeng (C)"
 <wangxiongfeng2@huawei.com>, "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "npiggin@gmail.com" <npiggin@gmail.com>, "harshpb@linux.ibm.com"
 <harshpb@linux.ibm.com>, Linuxarm <linuxarm@huawei.com>, "peterx@redhat.com"
 <peterx@redhat.com>
Subject: RE: [PATCH V15 0/7] Add architecture agnostic code to support vCPU
 Hotplug
Thread-Topic: [PATCH V15 0/7] Add architecture agnostic code to support vCPU
 Hotplug
Thread-Index: AQHa1VIYzbBqk8ub30G0ZXbYzNwFGLH3waYAgAASi1CAAAR3IP///pcAgADQmICAAGhoAIAAKp3A
Date: Tue, 16 Jul 2024 11:43:00 +0000
Message-ID: <b8ec039d53534d48b8389aedd1f959f6@huawei.com>
References: <20240713182516.1457-1-salil.mehta@huawei.com>
 <20240715155436.577d34c5@imammedo.users.ipa.redhat.com>
 <b93b570158794e28bf8c00a949afa8b4@huawei.com>
 <3848723ea2584b9b813c3d76e1e6dd59@huawei.com>
 <20240715171154.2667d187@imammedo.users.ipa.redhat.com>
 <4b829bf1-d31c-49eb-b18f-6d87e08c5c04@opnsrc.net>
 <20240716115210.08ca24ba@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240716115210.08ca24ba@imammedo.users.ipa.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.170.92]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Igor,

>  From: Igor Mammedov <imammedo@redhat.com>
>  Sent: Tuesday, July 16, 2024 10:52 AM
>  To: Salil Mehta <salil.mehta@opnsrc.net>
> =20
>  On Tue, 16 Jul 2024 03:38:29 +0000
>  Salil Mehta <salil.mehta@opnsrc.net> wrote:
> =20
>  > Hi Igor,
>  >
>  > On 15/07/2024 15:11, Igor Mammedov wrote:
>  > > On Mon, 15 Jul 2024 14:19:12 +0000
>  > > Salil Mehta <salil.mehta@huawei.com> wrote:
>  > >
>  > >>>   From: qemu-arm-bounces+salil.mehta=3Dhuawei.com@nongnu.org  <qem=
u-
>  > >>>   arm-bounces+salil.mehta=3Dhuawei.com@nongnu.org> On Behalf Of  S=
alil
>  > >>>   Mehta via
>  > >>>   Sent: Monday, July 15, 2024 3:14 PM
>  > >>>   To: Igor Mammedov <imammedo@redhat.com>
>  > >>>
>  > >>>   Hi Igor,
>  > >>>
>  > >>>   >  From: Igor Mammedov <imammedo@redhat.com>
>  > >>>   >  Sent: Monday, July 15, 2024 2:55 PM
>  > >>>   >  To: Salil Mehta <salil.mehta@huawei.com>
>  > >>>   >
>  > >>>   >  On Sat, 13 Jul 2024 19:25:09 +0100
>  > >>>   >  Salil Mehta <salil.mehta@huawei.com> wrote:
>  > >>>   >
>  > >>>   >  > [Note: References are present at the last after the revisio=
n
>  > >>>   > history]  >  > Virtual CPU hotplug support is being added acro=
ss
>  > >>>   > various architectures  [1][3].
>  > >>>   >  > This series adds various code bits common across all archit=
ectures:
>  > >>>   >  >
>  > >>>   >  > 1. vCPU creation and Parking code refactor [Patch 1] 2. Upd=
ate ACPI
>  > >>>   > > GED framework to support vCPU Hotplug [Patch 2,3] 3. ACPI CP=
Us AML
>  > >>>   > > code change [Patch 4,5] 4. Helper functions to support unrea=
lization
>  > >>>   > > of CPU objects [Patch 6,7]
>  > >>>   >
>  > >>>   >  with patch 1 and 3 fixed should be good to go.
>  > >>>   >
>  > >>>   >  Salil,
>  > >>>   >  Can you remind me what happened to migration part of this?
>  > >>>   >  Ideally it should be a part of of this series as it should be=
 common
>  > >>>   > for  everything that uses GED and should be a conditional part=
 of
>  > >>>   > GED's  VMSTATE.
>  > >>>   >
>  > >>>   >  If this series is just a common base and no actual hotplug on=
 top of
>  > >>>   > it is  merged in this release (provided patch 13 is fixed), I'=
m fine
>  > >>>   > with migration  bits being a separate series on top.
>  > >>>   >
>  > >>>   >  However if some machine would be introducing cpu hotplug in t=
he same
>  > >>>   > release, then the migration part should be merged before it or=
 be a
>  > >>>   > part  that cpu hotplug series.
>  > >>>
>  > >>>   We have tested Live/Pseudo Migration and it seem to work with th=
e
>  > >>>   changes part of the architecture specific patch-set.
>  > >
>  > > have you tested, migration from new QEMU to an older one (that doesn=
't have cpuhotplug builtin)?
>  >
>  >
>  > Just curious, how can we detect at source Qemu what version of the
>  > Qemu destination is running. We require some sort of compatibility
>  > check but then this is a problem not specific to CPU Hotplug?
> =20
>  it's usually managed by version machine types + compat settings for
>  machine/device.

Ok. it looks to be a static checking at the source. I'm sure there must be
a way to dynamically do the same by negotiating the features i.e. only
enabling the common subset at the destination. I quickly skimmed the
migration code and I cannot find any thing like this being done as of now.
And this problem looks to be a pandoras box to me.=20

> =20
>  > We  are not initializing CPU Hotplug VMSD in this patch-set. I was
>  > wondering then how can a new machine attempt to migrate VMSD state
>  > from new Qemu to older Qemu.
> =20
>  If I'm not mistaken without VMSD it shouldn't explode, since CPUHP code
>  shouldn't create memory-regions that are migrated.
>  (If I recall correctly, mmio regions aren't going into migration stream)

Correct.

> =20
>  > ARM vCPU Hotplug patches will be on top of this later in next Qemu cyc=
le.
>  then it's fine to introduce VMSD later on, just make sure others who add=
ing
>  cpu hotplug elsewhere also aware of it and pickup the same patch.


Yes, thanks.


>  > >>>
>  > >>>   Ampere: https://lore.kernel.org/all/e17e28ac-28c7-496f-b212-
>  > >>>   2c9b552dbf63@amperemail.onmicrosoft.com/
>  > >>>   Oracle: https://lore.kernel.org/all/46D74D30-EE54-4AD2-8F0E-
>  > >>>   BA5627FAA63E@oracle.com/
>  > >>>
>  > >>>
>  > >>>   For ARM, please check below patch part of RFC V3 for changes rel=
ated to
>  > >>>   migration:
>  > >>>   https://lore.kernel.org/qemu-devel/20240613233639.202896-15-
>  > >>>   salil.mehta@huawei.com/
>  > >>
>  > >>
>  > >> Do you wish to move below change into this path-set and make it
>  > >> common to all instead?
>  > >
>  > > it would be the best to include this with here.
>  > >
>  > >>
>  > >>
>  > >> diff --git a/hw/acpi/generic_event_device.c
>  > >> b/hw/acpi/generic_event_device.c index 63226b0040..e92ce07955
>  > >> 100644
>  > >> --- a/hw/acpi/generic_event_device.c
>  > >> +++ b/hw/acpi/generic_event_device.c
>  > >> @@ -333,6 +333,16 @@ static const VMStateDescription
>  vmstate_memhp_state =3D {
>  > >>       }
>  > >>   };
>  > >>
>  > >> +static const VMStateDescription vmstate_cpuhp_state =3D {
>  > >> +    .name =3D "acpi-ged/cpuhp",
>  > >> +    .version_id =3D 1,
>  > >> +    .minimum_version_id =3D 1,
>  > >> +    .fields      =3D (VMStateField[]) {
>  > >> +        VMSTATE_CPU_HOTPLUG(cpuhp_state, AcpiGedState),
>  > >> +        VMSTATE_END_OF_LIST()
>  > >> +    }
>  > >> +};
>  > >> +
>  > >>   static const VMStateDescription vmstate_ged_state =3D {
>  > >>       .name =3D "acpi-ged-state",
>  > >>       .version_id =3D 1,
>  > >> @@ -381,6 +391,7 @@ static const VMStateDescription
>  vmstate_acpi_ged =3D {
>  > >>       },
>  > >>       .subsections =3D (const VMStateDescription * const []) {
>  > >>           &vmstate_memhp_state,
>  > >> +        &vmstate_cpuhp_state,
>  > >
>  > > I'm not migration guru but I believe this should be conditional to
>  > > avoid breaking cross-version migration.
>  > > See 679dd1a957d '.needed =3D vmstate_test_use_cpuhp. part
>  >
>  >
>  > Sure, thanks for this. As I can see, the needed() function is used at
>  > the source to decide if the state corresponding to a particular device
>  > can be forwarded to the destination QEMU/VM. But how can this be used
>  > to check for cross-version migration?
> =20
>  what I'd do is to make sure that older machine types to not have cpu
>  hotplug enabled in supported events, and only machine that has full
>  support for hotplug enabled the bit. And then machine_init depending on
>  that would manage actual 'ged-event'
>  property.
> =20
>  Then later VMSD.needed would check ged-event to decide if section should
>  be used or omitted.

I understand this part, as discussed above this is not relevant to this pat=
ch-set
as we are not adding CPU Hotplug specific VMSD. But yes, I take your point =
and
will add above suggested change in the following patches in the next Qemu C=
ycle.


>  > BTW, I've prepared V16. May I request a quick peek at:
>  >
>  > https://github.com/salil-mehta/qemu/commits/virt-cpuhp-armv8/rfc-
>  v3.ar
>  > ch.agnostic.v16/
> =20
>  looked at
>     hw/acpi: Update ACPI GED framework to support vCPU Hotplug
> =20
>  I get that ged_event loop in realize was copy-pasted from _EVT handler, =
but
>  that looks a bit complicated (though I won't object, it's matter of tast=
e)

Yes, I did that intentionally to increase the code reuse which usually is e=
ncouraged.
This reduces the amount of re-testing required. But yes, there is a con sid=
e as
well to this approach if not done properly i.e. any issues in the older cod=
e also
get propagated in the newer code.

Generally we bank upon FFS function to get the next bit and use bit shiftin=
g to
deal with this kind of logic efficiently.=20

> =20
>  I'd prefer simpler condition than for() {} loop, and just use simpler 'i=
f'
> =20
>  if (enabled_events & ACPI_GED_CPU_HOTPLUG_EVT) {
>      init cpu hp code
>  }
> =20
>  PS:
>  if you keep for loop, I'd replace  error_report() + abort() with 'error_=
abort'

Maybe I should have looked a this earlier. I've  missed to address this in =
V16.
Do you mean error_setg(&error_abort,....) kind of logic? it has been discou=
raged
in favor of assert() I think?

Can we live with this for now or do you want me to send V17 for this change=
?


Thanks
Salil.

