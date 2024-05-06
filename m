Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4100EC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 09:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3udV-0005rZ-Pc; Mon, 06 May 2024 05:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s3udL-0005qF-Fp; Mon, 06 May 2024 05:27:44 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s3udC-0000iH-PJ; Mon, 06 May 2024 05:27:38 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VXwwG4sNnz6K5tD;
 Mon,  6 May 2024 17:24:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 80F6E1400DB;
 Mon,  6 May 2024 17:27:29 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 6 May 2024 10:27:29 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Mon, 6 May 2024 10:27:29 +0100
To: Zhao Liu <zhao1.liu@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "oliver.upton@linux.dev"
 <oliver.upton@linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
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
 Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH V8 3/8] hw/acpi: Update ACPI GED framework to support vCPU
 Hotplug
Thread-Topic: [PATCH V8 3/8] hw/acpi: Update ACPI GED framework to support
 vCPU Hotplug
Thread-Index: AQHadCE2/9My+8CRgUW+VfhEC8BhG7E1MwcAgFEMEICAA/EUgIAAFh/A
Date: Mon, 6 May 2024 09:27:29 +0000
Message-ID: <9fb53b83fa9e43c5a10eacce2108f7b6@huawei.com>
References: <20240312020000.12992-1-salil.mehta@huawei.com>
 <20240312020000.12992-4-salil.mehta@huawei.com> <ZfFEKgpRiEOZo9xd@intel.com>
 <6acc5b10128d431ca8bfa26ec45ae0f6@huawei.com> <ZjidcX8p1ERW276J@intel.com>
In-Reply-To: <ZjidcX8p1ERW276J@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.159.236]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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


>  From: Zhao Liu <zhao1.liu@intel.com>
>  Sent: Monday, May 6, 2024 10:06 AM
> =20
>  Hi Salil,
> =20
>  On Fri, May 03, 2024 at 07:59:32PM +0000, Salil Mehta wrote:
>  > Date: Fri, 3 May 2024 19:59:32 +0000
>  > From: Salil Mehta <salil.mehta@huawei.com>
>  > Subject: RE: [PATCH V8 3/8] hw/acpi: Update ACPI GED framework to
>  > support  vCPU Hotplug
>  >
>  > Hello,
>  >
>  > Sorry, I missed this earlier.
>  >
>  > >  From: Zhao Liu <zhao1.liu@intel.com>
>  > >  Sent: Wednesday, March 13, 2024 6:14 AM
>  > >  To: Salil Mehta <salil.mehta@huawei.com>
>  > >
>  > >  Hi Salil,
>  > >
>  > >  It seems my comment [1] in v7 was missed, but I still hit the same
>  > > issue. Pls  let me paste the previous comment here again.
>  > >
>  > >  [1]: https://lore.kernel.org/qemu- devel/ZXCqp32ggIFvUweu@intel.com=
/
>  >
>  > Yes, I have this in my mind.
>  >
>  > >
>  > >  [snip]
>  > >
>  > >  > @@ -400,6 +411,12 @@ static void acpi_ged_initfn(Object *obj)
>  > >  >      memory_region_init_io(&ged_st->regs, obj, &ged_regs_ops,  ge=
d_st,
>  > >  >                            TYPE_ACPI_GED "-regs", ACPI_GED_REG_CO=
UNT);
>  > >  >      sysbus_init_mmio(sbd, &ged_st->regs);
>  > >  > +
>  > >  > +    memory_region_init(&s->container_cpuhp, OBJECT(dev), "cpuhp
>  > >  container",
>  > >  > +                       ACPI_CPU_HOTPLUG_REG_LEN);
>  > >  > +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->container_cpuhp);
>  > >  > +    cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
>  > >  > +                        &s->cpuhp_state, 0);
>  > >  >  }
>  > >  >
>  > >
>  > >  I find this cpu_hotplug_hw_init() can still cause qtest errors (for
>  > > v8) on x86  platforms as you mentioned in v6:
>  > >  https://lore.kernel.org/qemu-devel/15e70616-6abb-63a4-17d0-820f4a25=
4607@opnsrc.net/T/#m108f102b2fe92b7dd7218f2f942f7b233a9d6af3
>  > >
>  > >  IIUC, microvm machine has its own 'possible_cpus_arch_ids' and that
>  > > is  inherited from its parent x86 machine.
>  > >
>  > >  The above error is because device-introspect-test sets the none-mac=
hine:
>  > >
>  > >  # starting QEMU: exec ./qemu-system-i386 -qtest unix:/tmp/qtest-
>  > > 3094820.sock -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-
>  > >  3094820.qmp,id=3Dchar0 -mon chardev=3Dchar0,mode=3Dcontrol -display=
 none
>  > > -  audio none -nodefaults -machine none -accel qtest
>  > >
>  > >  So what about just checking mc->possible_cpu_arch_ids instead of an
>  > > assert in cpu_hotplug_hw_init()?
>  > >
>  > >  diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c index
>  > > 4b24a2500361..303f1f1f57bc 100644
>  > >  --- a/hw/acpi/cpu.c
>  > >  +++ b/hw/acpi/cpu.c
>  > >  @@ -221,7 +221,10 @@ void cpu_hotplug_hw_init(MemoryRegion *as,
>  > > Object *owner,
>  > >       const CPUArchIdList *id_list;
>  > >       int i;
>  > >
>  > >  -    assert(mc->possible_cpu_arch_ids);
>  > >  +    if (!mc->possible_cpu_arch_ids) {
>  > >  +        return;
>  > >  +    }
>  > >  +
>  >
>  >
>  > Yes, we can do this with some debug print or trace maybe.
> =20
>  Here it is just to return early without touching mc->possible_cpu_arch_i=
ds().
>  If you adopt this workaround, then in the meantime I suggest adding a
>  comment to this "if" to clarify that it is for compatibility with certai=
n
>  machines that do not implement mc->possible_cpu_arch_ids().


sure.


> =20
>  > >       id_list =3D mc->possible_cpu_arch_ids(machine);
>  > >       state->dev_count =3D id_list->len;
>  > >       state->devs =3D g_new0(typeof(*state->devs), state->dev_count)=
;
>  > >
>  > >  This check seems to be acceptable in the general code path? Not all
>  > > machines have possible_cpu_arch_ids, after all.
>  >
>  > True. BTW, have you tested this with Qtest?
> =20
>  Yes, by "make check" on x86 platform. This workaround can help us pass t=
he
>  x86 tests.

thanks.

Best
Salil.



