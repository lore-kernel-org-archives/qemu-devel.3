Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F19D3E770
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 21:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Qqe-0005ty-QO; Tue, 05 Nov 2024 16:12:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t8Qqd-0005tl-Ao
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 16:12:23 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t8Qqa-0007Wa-HX
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 16:12:23 -0500
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XjgvC4C7dzfcFx;
 Wed,  6 Nov 2024 05:09:27 +0800 (CST)
Received: from kwepemj200014.china.huawei.com (unknown [7.202.194.26])
 by mail.maildlp.com (Postfix) with ESMTPS id 2FEC9180105;
 Wed,  6 Nov 2024 05:12:04 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 kwepemj200014.china.huawei.com (7.202.194.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 Nov 2024 05:12:02 +0800
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 5 Nov 2024 22:12:00 +0100
To: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, "wangyanan
 (Y)" <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: RE: [PULL 60/65] hw/acpi: Update ACPI `_STA` method with QOM vCPU
 ACPI Hotplug states
Thread-Topic: [PULL 60/65] hw/acpi: Update ACPI `_STA` method with QOM vCPU
 ACPI Hotplug states
Thread-Index: AQHbLv3eehxTgACYUUePjaA2uWHyR7Kok8+AgACWyCA=
Date: Tue, 5 Nov 2024 21:12:00 +0000
Message-ID: <e9fcaf7a356b46b195294173a0dbd68d@huawei.com>
References: <cover.1730754238.git.mst@redhat.com>
 <bf1ecc8dad6061914730a2a2d57af6b37c3a4f8d.1730754238.git.mst@redhat.com>
 <20241105135023.703f1e84@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241105135023.703f1e84@imammedo.users.ipa.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.170.66]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=salil.mehta@huawei.com; helo=szxga02-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

>  From: Igor Mammedov <imammedo@redhat.com>
>  Sent: Tuesday, November 5, 2024 12:50 PM
>  To: Michael S. Tsirkin <mst@redhat.com>
>  Cc: qemu-devel@nongnu.org; Peter Maydell <peter.maydell@linaro.org>;
>  Salil Mehta <salil.mehta@huawei.com>; Ani Sinha <anisinha@redhat.com>;
>  Eduardo Habkost <eduardo@habkost.net>; Marcel Apfelbaum
>  <marcel.apfelbaum@gmail.com>; Philippe Mathieu-Daud=E9
>  <philmd@linaro.org>; wangyanan (Y) <wangyanan55@huawei.com>; Zhao
>  Liu <zhao1.liu@intel.com>
>  Subject: Re: [PULL 60/65] hw/acpi: Update ACPI `_STA` method with QOM
>  vCPU ACPI Hotplug states
> =20
>  On Mon, 4 Nov 2024 16:09:26 -0500
>  "Michael S. Tsirkin" <mst@redhat.com> wrote:
> =20
>  > From: Salil Mehta <salil.mehta@huawei.com>
>  >
>  > Reflect the QOM vCPUs ACPI CPU hotplug states in the `_STA.Present`
>  > and and `_STA.Enabled` bits when the guest kernel evaluates the ACPI
>  > `_STA` method during initialization, as well as when vCPUs are
>  > hot-plugged or hot-unplugged. If the CPU is present then the its
>  > `enabled` status can be fetched using architecture-specific code [1].
>  >
>  > Reference:
>  > [1] Example implementation of architecture-specific hook to fetch CPU
>  >     `enabled status
>  >     Link:
>  > https://github.com/salil-
>  mehta/qemu/commit/c0b416b11e5af6505e558866f0e
>  > b6c9f3709173e
>  >
>  > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>  > Message-Id: <20241103102419.202225-4-salil.mehta@huawei.com>
>  > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>  > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>  > ---
>  >  include/hw/core/cpu.h |  1 +
>  >  hw/acpi/cpu.c         | 38 ++++++++++++++++++++++++++++++++++----
>  >  2 files changed, 35 insertions(+), 4 deletions(-)
>  >
>  > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h index
>  > e7de77dc6d..db8a6fbc6e 100644
>  > --- a/include/hw/core/cpu.h
>  > +++ b/include/hw/core/cpu.h
>  > @@ -159,6 +159,7 @@ struct CPUClass {
>  >      void (*query_cpu_fast)(CPUState *cpu, CpuInfoFast *value);
>  >      int64_t (*get_arch_id)(CPUState *cpu);
>  >      bool (*cpu_persistent_status)(CPUState *cpu);
>  > +    bool (*cpu_enabled_status)(CPUState *cpu);
>  >      void (*set_pc)(CPUState *cpu, vaddr value);
>  >      vaddr (*get_pc)(CPUState *cpu);
>  >      int (*gdb_read_register)(CPUState *cpu, GByteArray *buf, int
>  > reg); diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c index
>  > 9b03b4292e..23443f09a5 100644
>  > --- a/hw/acpi/cpu.c
>  > +++ b/hw/acpi/cpu.c
>  > @@ -50,6 +50,18 @@ void acpi_cpu_ospm_status(CPUHotplugState
>  *cpu_st, ACPIOSTInfoList ***list)
>  >      }
>  >  }
>  >
>  > +static bool check_cpu_enabled_status(DeviceState *dev) {
>  > +    CPUClass *k =3D dev ? CPU_GET_CLASS(dev) : NULL;
>  > +    CPUState *cpu =3D CPU(dev);
>  > +
>  > +    if (cpu && (!k->cpu_enabled_status || k->cpu_enabled_status(cpu))=
)
>  {
>  > +        return true;
>  > +    }
>  > +
>  > +    return false;
>  > +}
>  > +
>  >  static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr, unsigned
>  > size)  {
>  >      uint64_t val =3D 0;
>  > @@ -63,10 +75,11 @@ static uint64_t cpu_hotplug_rd(void *opaque,
>  hwaddr addr, unsigned size)
>  >      cdev =3D &cpu_st->devs[cpu_st->selector];
>  >      switch (addr) {
>  >      case ACPI_CPU_FLAGS_OFFSET_RW: /* pack and return is_* fields */
>  > -        val |=3D cdev->cpu ? 1 : 0;
>  > +        val |=3D check_cpu_enabled_status(DEVICE(cdev->cpu)) ? 1 : 0;
>  >          val |=3D cdev->is_inserting ? 2 : 0;
>  >          val |=3D cdev->is_removing  ? 4 : 0;
>  >          val |=3D cdev->fw_remove  ? 16 : 0;
>  > +        val |=3D cdev->cpu ? 32 : 0;
>  >          trace_cpuhp_acpi_read_flags(cpu_st->selector, val);
>  >          break;
>  >      case ACPI_CPU_CMD_DATA_OFFSET_RW:
>  > @@ -349,6 +362,7 @@ const VMStateDescription vmstate_cpu_hotplug =3D
>  {
>  > #define CPU_REMOVE_EVENT  "CRMV"
>  >  #define CPU_EJECT_EVENT   "CEJ0"
>  >  #define CPU_FW_EJECT_EVENT "CEJF"
>  > +#define CPU_PRESENT       "CPRS"
>  >
>  >  void build_cpus_aml(Aml *table, MachineState *machine,
>  CPUHotplugFeatures opts,
>  >                      build_madt_cpu_fn build_madt_cpu, hwaddr
>  > base_addr, @@ -409,7 +423,9 @@ void build_cpus_aml(Aml *table,
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
>  > @@ -439,6 +455,7 @@ void build_cpus_aml(Aml *table, MachineState
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
>  > CPU_INSERT_EVENT); @@ -467,13 +484,26 @@ void build_cpus_aml(Aml
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
> =20
>  very likely this will break hotplug on after migration to older QEMU.


The above are local variables and are not being migrated. These are not the=
 same
as the earlier comment you provided here. I've removed those `is_present,en=
abled`
states to address your earlier concerns:
https://lore.kernel.org/qemu-devel/20241018163118.0ae01a84@imammedo.users.i=
pa.redhat.com/

State-1: Possible State of ACPI _STA (without patches)

_STA.Present =3D 0
_STA.Enabled =3D 0

_STA.Present =3D 1
_STA.Enabled =3D 1

State-2: Possible State of ACPI _STA (with patches)

_STA.Present =3D 0
_STA.Enabled =3D 0

_STA.Present =3D 1
_STA.Enabled =3D 1

_STA.Present =3D 1
_STA.Enabled =3D 0  [New return state which should not affect x86]


State-1 is subset of State-2. If vCPU HP feature is off on the
newer Qemu then, State-1 becomes proper subset of State-2.
Later is also the state of the older Qemu?


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


