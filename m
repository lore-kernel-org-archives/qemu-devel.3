Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E73CDD0FF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 23:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Nu2-0000Uj-Ep; Tue, 22 Oct 2024 19:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t3Nu0-0000UE-EO; Tue, 22 Oct 2024 19:03:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t3Ntx-0006t9-IK; Tue, 22 Oct 2024 19:02:59 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XY6yw4m7pz6LD9d;
 Wed, 23 Oct 2024 06:58:00 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
 by mail.maildlp.com (Postfix) with ESMTPS id 2E7E01400F4;
 Wed, 23 Oct 2024 07:02:40 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 01:02:39 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 23 Oct 2024 01:02:39 +0200
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
Subject: RE: [PATCH V1 2/4] hw/acpi: Update ACPI CPU Status `is_{present,
 enabled}` during vCPU hot(un)plug
Thread-Topic: [PATCH V1 2/4] hw/acpi: Update ACPI CPU Status `is_{present,
 enabled}` during vCPU hot(un)plug
Thread-Index: AQHbHm6LVfm++ex4ak2XyzXHJrqBZLKMcruAgAb57AA=
Date: Tue, 22 Oct 2024 23:02:39 +0000
Message-ID: <b31151bc8f4e48ccafb9707543363db3@huawei.com>
References: <20241014192205.253479-1-salil.mehta@huawei.com>
 <20241014192205.253479-3-salil.mehta@huawei.com>
 <20241018161811.4a88c7b7@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241018161811.4a88c7b7@imammedo.users.ipa.redhat.com>
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
>  Sent: Friday, October 18, 2024 3:18 PM
>  To: Salil Mehta <salil.mehta@huawei.com>
> =20
>  On Mon, 14 Oct 2024 20:22:03 +0100
>  Salil Mehta <salil.mehta@huawei.com> wrote:
> =20
>  > Update the `AcpiCpuStatus` for `is_enabled` and `is_present`
>  > accordingly when vCPUs are hot-plugged or hot-unplugged, taking into
>  > account the *persistence* of the vCPUs.
>  >
>  > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>  > ---
>  >  hw/acpi/cpu.c | 7 +++++++
>  >  1 file changed, 7 insertions(+)
>  >
>  > diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c index
>  > 083c4010c2..700aa855e9 100644
>  > --- a/hw/acpi/cpu.c
>  > +++ b/hw/acpi/cpu.c
>  > @@ -291,6 +291,8 @@ void acpi_cpu_plug_cb(HotplugHandler
>  *hotplug_dev,
>  >      }
>  >
>  >      cdev->cpu =3D CPU(dev);
>  > +    cdev->is_present =3D true;
>  > +    cdev->is_enabled =3D true;
> =20
>  hmm, if cpu is always present, then these fields are redundant since
>    (!cdev->cpu) =3D=3D present
>  and
>    then is_enabled could be fetched from cdev->cpu directly


I believe you are assuming, that all the QOM possible vCPUs objects will
exists (and hence realized) for the entire life time of the VM? If yes, the=
n
we need to first debate on that as we cannot let presence of all the possib=
le
vCPUs affect  the boot time. This is one of the key requirement from this
feature.


> =20
>  >      if (dev->hotplugged) {
>  >          cdev->is_inserting =3D true;
>  >          acpi_send_event(DEVICE(hotplug_dev),
>  > ACPI_CPU_HOTPLUG_STATUS); @@ -322,6 +324,11 @@ void
>  acpi_cpu_unplug_cb(CPUHotplugState *cpu_st,
>  >          return;
>  >      }
>  >
>  > +    cdev->is_enabled =3D false;
>  > +    if (!acpi_persistent_cpu(CPU(dev))) {
>  > +        cdev->is_present =3D false;
>  > +    }
> =20
>  and other way around works as well.
> =20
>  then we don't have to carry around extra state and making sure that it's=
 in
>  sync/migrated.
> =20
>  > +
>  >      cdev->cpu =3D NULL;
>  >  }
>  >
> =20


