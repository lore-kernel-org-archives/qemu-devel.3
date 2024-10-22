Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E8CD2C57C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 23:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3OlK-0003bk-CO; Tue, 22 Oct 2024 19:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t3OlH-0003ao-QA; Tue, 22 Oct 2024 19:58:03 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t3OlF-00040m-Df; Tue, 22 Oct 2024 19:58:03 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XY8Gz1BSDz6K9By;
 Wed, 23 Oct 2024 07:56:59 +0800 (CST)
Received: from frapeml100005.china.huawei.com (unknown [7.182.85.132])
 by mail.maildlp.com (Postfix) with ESMTPS id 9F946140B35;
 Wed, 23 Oct 2024 07:57:55 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 01:57:55 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 23 Oct 2024 01:57:55 +0200
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
Subject: RE: [PATCH V1 3/4] hw/acpi: Reflect ACPI vCPU {present,enabled}
 states in ACPI _STA.{PRES,ENA} Bits
Thread-Topic: [PATCH V1 3/4] hw/acpi: Reflect ACPI vCPU {present,enabled}
 states in ACPI _STA.{PRES,ENA} Bits
Thread-Index: AQHbHm6XRQnHA1hqSkuTlA12W4mCybKMdIeAgAcJKtA=
Date: Tue, 22 Oct 2024 23:57:55 +0000
Message-ID: <a8f41af5e450446e8dd68ebf9b9305a6@huawei.com>
References: <20241014192205.253479-1-salil.mehta@huawei.com>
 <20241014192205.253479-4-salil.mehta@huawei.com>
 <20241018162437.782c12c1@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241018162437.782c12c1@imammedo.users.ipa.redhat.com>
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
>  Sent: Friday, October 18, 2024 3:25 PM
>  To: Salil Mehta <salil.mehta@huawei.com>
>  Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; mst@redhat.com;
>  maz@kernel.org; jean-philippe@linaro.org; Jonathan Cameron
>  <jonathan.cameron@huawei.com>; lpieralisi@kernel.org;
>  peter.maydell@linaro.org; richard.henderson@linaro.org;
>  andrew.jones@linux.dev; david@redhat.com; philmd@linaro.org;
>  eric.auger@redhat.com; will@kernel.org; ardb@kernel.org;
>  oliver.upton@linux.dev; pbonzini@redhat.com; gshan@redhat.com;
>  rafael@kernel.org; borntraeger@linux.ibm.com; alex.bennee@linaro.org;
>  npiggin@gmail.com; harshpb@linux.ibm.com; linux@armlinux.org.uk;
>  darren@os.amperecomputing.com; ilkka@os.amperecomputing.com;
>  vishnu@os.amperecomputing.com; karl.heubaum@oracle.com;
>  miguel.luis@oracle.com; salil.mehta@opnsrc.net; zhukeqian
>  <zhukeqian1@huawei.com>; wangxiongfeng (C)
>  <wangxiongfeng2@huawei.com>; wangyanan (Y)
>  <wangyanan55@huawei.com>; jiakernel2@gmail.com;
>  maobibo@loongson.cn; lixianglai@loongson.cn; shahuang@redhat.com;
>  zhao1.liu@intel.com; Linuxarm <linuxarm@huawei.com>;
>  gustavo.romero@linaro.org
>  Subject: Re: [PATCH V1 3/4] hw/acpi: Reflect ACPI vCPU {present,enabled}
>  states in ACPI _STA.{PRES,ENA} Bits
> =20
>  On Mon, 14 Oct 2024 20:22:04 +0100
>  Salil Mehta <salil.mehta@huawei.com> wrote:
> =20
>  > Reflect the ACPI CPU hotplug `is_{present, enabled}` states in the
>  > `_STA.PRES`
>  > (presence) and `_STA.ENA` (enabled) bits when the guest kernel
>  > evaluates the ACPI `_STA` method during initialization, as well as
>  > when vCPUs are hot-plugged or hot-unplugged. The presence of
>  unplugged
>  > vCPUs may need to be deliberately
>  > *simulated* at the ACPI level to maintain a *persistent* view of vCPUs
>  > for the guest kernel.
> =20
>  given questionable future of is_present/is_enabled fields, it probably
>  premature to review this part.


Sure, let us discuss the pain points.=20


>  The only thing, I have to say here is repeating spec/doc update patch
>  describing how it should work should come 1st, so that we could compare
>  this impl. with it.


From the user perspective, there should not be any change in how he
plug/unplugs the ARM vCPUs. This is a requirement, as we have to
assists folks who wants to migrate from x86 world to ARM world
seamlessly (without affecting performance parameters) and this
feature is one small part of that bigger effort.


>  > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>  > ---
>  >  hw/acpi/cpu.c | 26 ++++++++++++++++++++++----
>  >  1 file changed, 22 insertions(+), 4 deletions(-)
>  >
>  > diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c index
>  > 700aa855e9..23ea2b9c70 100644
>  > --- a/hw/acpi/cpu.c
>  > +++ b/hw/acpi/cpu.c
>  > @@ -63,10 +63,11 @@ static uint64_t cpu_hotplug_rd(void *opaque,
>  hwaddr addr, unsigned size)
>  >      cdev =3D &cpu_st->devs[cpu_st->selector];
>  >      switch (addr) {
>  >      case ACPI_CPU_FLAGS_OFFSET_RW: /* pack and return is_* fields */
>  > -        val |=3D cdev->cpu ? 1 : 0;
>  > +        val |=3D cdev->is_enabled ? 1 : 0;
>  >          val |=3D cdev->is_inserting ? 2 : 0;
>  >          val |=3D cdev->is_removing  ? 4 : 0;
>  >          val |=3D cdev->fw_remove  ? 16 : 0;
>  > +        val |=3D cdev->is_present ? 32 : 0;
>  >          trace_cpuhp_acpi_read_flags(cpu_st->selector, val);
>  >          break;
>  >      case ACPI_CPU_CMD_DATA_OFFSET_RW:
>  > @@ -376,6 +377,7 @@ const VMStateDescription vmstate_cpu_hotplug =3D
>  {
>  > #define CPU_REMOVE_EVENT  "CRMV"
>  >  #define CPU_EJECT_EVENT   "CEJ0"
>  >  #define CPU_FW_EJECT_EVENT "CEJF"
>  > +#define CPU_PRESENT       "CPRS"
>  >
>  >  void build_cpus_aml(Aml *table, MachineState *machine,
>  CPUHotplugFeatures opts,
>  >                      build_madt_cpu_fn build_madt_cpu, hwaddr
>  > base_addr, @@ -436,7 +438,9 @@ void build_cpus_aml(Aml *table,
>  MachineState *machine, CPUHotplugFeatures opts,
>  >          aml_append(field, aml_named_field(CPU_EJECT_EVENT, 1));
>  >          /* tell firmware to do device eject, write only */
>  >          aml_append(field, aml_named_field(CPU_FW_EJECT_EVENT, 1));
>  > -        aml_append(field, aml_reserved_field(3));
>  > +        /* 1 if present, read only */
>  > +        aml_append(field, aml_named_field(CPU_PRESENT, 1));
>  > +        aml_append(field, aml_reserved_field(2));
>  >          aml_append(field, aml_named_field(CPU_COMMAND, 8));
>  >          aml_append(cpu_ctrl_dev, field);
>  >
>  > @@ -466,6 +470,7 @@ void build_cpus_aml(Aml *table, MachineState
>  *machine, CPUHotplugFeatures opts,
>  >          Aml *ctrl_lock =3D aml_name("%s.%s", cphp_res_path, CPU_LOCK)=
;
>  >          Aml *cpu_selector =3D aml_name("%s.%s", cphp_res_path,
>  CPU_SELECTOR);
>  >          Aml *is_enabled =3D aml_name("%s.%s", cphp_res_path,
>  > CPU_ENABLED);
>  > +        Aml *is_present =3D aml_name("%s.%s", cphp_res_path,
>  > + CPU_PRESENT);
>  >          Aml *cpu_cmd =3D aml_name("%s.%s", cphp_res_path,
>  CPU_COMMAND);
>  >          Aml *cpu_data =3D aml_name("%s.%s", cphp_res_path, CPU_DATA);
>  >          Aml *ins_evt =3D aml_name("%s.%s", cphp_res_path,
>  > CPU_INSERT_EVENT); @@ -494,13 +499,26 @@ void build_cpus_aml(Aml
>  *table, MachineState *machine, CPUHotplugFeatures opts,
>  >          {
>  >              Aml *idx =3D aml_arg(0);
>  >              Aml *sta =3D aml_local(0);
>  > +            Aml *ifctx2;
>  > +            Aml *else_ctx;
>  >
>  >              aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
>  >              aml_append(method, aml_store(idx, cpu_selector));
>  >              aml_append(method, aml_store(zero, sta));
>  > -            ifctx =3D aml_if(aml_equal(is_enabled, one));
>  > +            ifctx =3D aml_if(aml_equal(is_present, one));
>  >              {
>  > -                aml_append(ifctx, aml_store(aml_int(0xF), sta));
>  > +                ifctx2 =3D aml_if(aml_equal(is_enabled, one));
>  > +                {
>  > +                    /* cpu is present and enabled */
>  > +                    aml_append(ifctx2, aml_store(aml_int(0xF), sta));
>  > +                }
>  > +                aml_append(ifctx, ifctx2);
>  > +                else_ctx =3D aml_else();
>  > +                {
>  > +                    /* cpu is present but disabled */
>  > +                    aml_append(else_ctx, aml_store(aml_int(0xD), sta)=
);
>  > +                }
>  > +                aml_append(ifctx, else_ctx);
>  >              }
>  >              aml_append(method, ifctx);
>  >              aml_append(method, aml_release(ctrl_lock));
> =20


