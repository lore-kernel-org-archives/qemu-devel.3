Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13FED2CDF6
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 23:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3OCl-0003dE-SK; Tue, 22 Oct 2024 19:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t3OCg-0003cB-KS; Tue, 22 Oct 2024 19:22:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t3OCd-0000Pe-LI; Tue, 22 Oct 2024 19:22:18 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XY7PN1GW8z6LD7L;
 Wed, 23 Oct 2024 07:17:28 +0800 (CST)
Received: from frapeml100005.china.huawei.com (unknown [7.182.85.132])
 by mail.maildlp.com (Postfix) with ESMTPS id B03E3140123;
 Wed, 23 Oct 2024 07:22:07 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 01:22:07 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 23 Oct 2024 01:22:07 +0200
To: Igor Mammedov <imammedo@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "maz@kernel.org"
 <maz@kernel.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "andrew.jones@linux.dev"
 <andrew.jones@linux.dev>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "ardb@kernel.org" <ardb@kernel.org>, "oliver.upton@linux.dev"
 <oliver.upton@linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, 
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
 "shahuang@redhat.com" <shahuang@redhat.com>, "zhao1.liu@intel.com"
 <zhao1.liu@intel.com>, Linuxarm <linuxarm@huawei.com>,
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>
Subject: RE: [PATCH V1 4/4] hw/acpi: Populate vCPU Hotplug VMSD to migrate
 `is_{present,enabled}` states
Thread-Topic: [PATCH V1 4/4] hw/acpi: Populate vCPU Hotplug VMSD to migrate
 `is_{present,enabled}` states
Thread-Index: AQHbHm6jRVibU/CRT0CMF8d7nj4OsrKMdmUAgAb50vA=
Date: Tue, 22 Oct 2024 23:22:07 +0000
Message-ID: <089f9b396b35401a861f7adcaf21a717@huawei.com>
References: <20241014192205.253479-1-salil.mehta@huawei.com>
 <20241014192205.253479-5-salil.mehta@huawei.com>
 <20241018163118.0ae01a84@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241018163118.0ae01a84@imammedo.users.ipa.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.148.112]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Igor,

>  From: Igor Mammedov <imammedo@redhat.com>
>  Sent: Friday, October 18, 2024 3:31 PM
>  To: Salil Mehta <salil.mehta@huawei.com>
> =20
>  On Mon, 14 Oct 2024 20:22:05 +0100
>  Salil Mehta <salil.mehta@huawei.com> wrote:
> =20
>  > The ACPI CPU hotplug states `is_{present, enabled}` must be migrated
>  > alongside other vCPU hotplug states to the destination VM. Therefore,
>  > they should be integrated into the existing CPU Hotplug VM State
>  Description (VMSD) table.
>  > Depending on the architecture and its implementation of CPU hotplug
>  > events (such as ACPI GED, etc.), the CPU hotplug states should be
>  > populated appropriately within their corresponding subsections of the
>  VMSD table.
>  >
>  >     "acpi-ged (16)": {
>  >         "ged_state": {
>  >             "sel": "0x00000000"
>  >         },
>  >         [...]
>  >         "acpi-ged/cpuhp": {
>  >             "cpuhp_state": {
>  >                 "selector": "0x00000005",
>  >                 "command": "0x00",
>  >                 "devs": [
>  >                     {
>  >                         "is_inserting": false,
>  >                         "is_removing": false,
>  >                         "is_present": true,
>  >                         "is_enabled": true,
>  >                         "ost_event": "0x00000000",
>  >                         "ost_status": "0x00000000"
>  >                     },
>  >                     {
>  >                         "is_inserting": false,
>  >                         "is_removing": false,
>  >                         "is_present": true,
>  >                         "is_enabled": true,
>  >                         "ost_event": "0x00000000",
>  >                         "ost_status": "0x00000000"
>  >                     },
>  >                     {
>  >                         "is_inserting": false,
>  >                         "is_removing": false,
>  >                         "is_present": true,
>  >                         "is_enabled": true,
>  >                         "ost_event": "0x00000000",
>  >                         "ost_status": "0x00000000"
>  >                     },
>  >                     {
>  >                         "is_inserting": false,
>  >                         "is_removing": false,
>  >                         "is_present": true,
>  >                         "is_enabled": true,
>  >                         "ost_event": "0x00000000",
>  >                         "ost_status": "0x00000000"
>  >                     },
>  >                     {
>  >                         "is_inserting": false,
>  >                         "is_removing": false,
>  >                         "is_present": true,
>  >                         "is_enabled": false,
>  >                         "ost_event": "0x00000000",
>  >                         "ost_status": "0x00000000"
>  >                     },
>  >                     {
>  >                         "is_inserting": false,
>  >                         "is_removing": false,
>  >                         "is_present": true,
>  >                         "is_enabled": false,
>  >                         "ost_event": "0x00000000",
>  >                         "ost_status": "0x00000000"
>  >                     }
>  >                 ]
>  >             }
>  >         }
>  >     },
>  >
>  > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>  > ---
>  >  hw/acpi/cpu.c                  |  2 ++
>  >  hw/acpi/generic_event_device.c | 11 +++++++++++
>  >  2 files changed, 13 insertions(+)
>  >
>  > diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c index
>  > 23ea2b9c70..d34c1e601e 100644
>  > --- a/hw/acpi/cpu.c
>  > +++ b/hw/acpi/cpu.c
>  > @@ -340,6 +340,8 @@ static const VMStateDescription
>  vmstate_cpuhp_sts =3D {
>  >      .fields =3D (const VMStateField[]) {
>  >          VMSTATE_BOOL(is_inserting, AcpiCpuStatus),
>  >          VMSTATE_BOOL(is_removing, AcpiCpuStatus),
>  > +        VMSTATE_BOOL(is_present, AcpiCpuStatus),
>  > +        VMSTATE_BOOL(is_enabled, AcpiCpuStatus),
> =20
>  that's likely will break x86 migration,


Point taken. It would helpful if you can elucidate further how that
might happen?


>  but before bothering peterx, maybe we won't need this hunk if is_enabled
>  is migrated as part of vCPU state.


Again. This entire argument hinges on the fact whether to keep all the
possible vCPUs realized or not. I think we need a thorough discussion
on that first so that pain of all the stakeholders can be addressed.



>  >          VMSTATE_UINT32(ost_event, AcpiCpuStatus),
>  >          VMSTATE_UINT32(ost_status, AcpiCpuStatus),
>  >          VMSTATE_END_OF_LIST()
>  > diff --git a/hw/acpi/generic_event_device.c
>  > b/hw/acpi/generic_event_device.c index 15b4c3ebbf..a4d78a534c 100644
>  > --- a/hw/acpi/generic_event_device.c
>  > +++ b/hw/acpi/generic_event_device.c
>  > @@ -331,6 +331,16 @@ static const VMStateDescription
>  vmstate_memhp_state =3D {
>  >      }
>  >  };
>  >
>  > +static const VMStateDescription vmstate_cpuhp_state =3D {
>  > +    .name =3D "acpi-ged/cpuhp",
>  > +    .version_id =3D 1,
>  > +    .minimum_version_id =3D 1,
>  > +    .fields      =3D (VMStateField[]) {
>  > +        VMSTATE_CPU_HOTPLUG(cpuhp_state, AcpiGedState),
>  > +        VMSTATE_END_OF_LIST()
>  > +    }
>  > +};
> =20
>  this subsection likely needs is_needed hook to avoid breaking case where
>  target doesn't have cpuhp support (older QEMU)


Sure. AFAICS by checking the usage of this in the other parts of the code
and please correct me if I'm wrong here,

#1. it is used at the source VM
#2. used to decide whether to include certain subsection in the state
       being migrated.

Q1: How does the source VM know what version is there at the
       destination VM? or is it managed by the administrator?
Q2: Or maybe the is_needed hooks provides a way for the administrator
       to configure that at the source?
    =20

> =20
>  > +
>  >  static const VMStateDescription vmstate_ged_state =3D {
>  >      .name =3D "acpi-ged-state",
>  >      .version_id =3D 1,
>  > @@ -379,6 +389,7 @@ static const VMStateDescription vmstate_acpi_ged
>  =3D {
>  >      },
>  >      .subsections =3D (const VMStateDescription * const []) {
>  >          &vmstate_memhp_state,
>  > +        &vmstate_cpuhp_state,
>  >          &vmstate_ghes_state,
>  >          NULL
>  >      }
> =20


