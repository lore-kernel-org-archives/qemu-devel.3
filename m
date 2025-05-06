Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9D6C3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 20:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCPFK-0000lj-FT; Tue, 06 May 2025 16:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uCPFF-0000lF-3g
 for qemu-devel@nongnu.org; Tue, 06 May 2025 16:50:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uCPFC-0000Q1-OT
 for qemu-devel@nongnu.org; Tue, 06 May 2025 16:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746564625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8jd8PCgX8sR//GvZeqjasfe7QmEYtbm+ayeEYpi3Lvc=;
 b=h4kGTXm2GndivPRlxzMCIy4Bs4dfejvY+A3BD/N2ddOYogrYDJtEezTC2fIxbAkSMkwajq
 ERRPBpeRciyhB2iEkT/LIWQXCjRKY+F0/ZnVQ97iWaYQoosfTEjiCXHiqM2IwmVTG73sL5
 dgU5wunM3lEteE3yhThfxnR9uwqmIwc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-Y8cK3JIyODu_qxd-ECCH2w-1; Tue, 06 May 2025 16:50:23 -0400
X-MC-Unique: Y8cK3JIyODu_qxd-ECCH2w-1
X-Mimecast-MFC-AGG-ID: Y8cK3JIyODu_qxd-ECCH2w_1746564623
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-476900d10caso144290301cf.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 13:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746564623; x=1747169423;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8jd8PCgX8sR//GvZeqjasfe7QmEYtbm+ayeEYpi3Lvc=;
 b=e9WnPd7ZqRo36yLZLwIcElkqwh1fhMoBpdeVqvPEMx7welvP75TP4wckme/FdYm9Db
 ur1tsiWDPid4RkDUO/sUuWVxOZrbANTFm77gHrupemC7H7ntneOJPUR1WD4SNnxMFaKI
 UfnxAaikgDsC+4XIZal0ULx4EynEq+uv9sc5wFMMsqoeoHMrLswmqu9YqXGSQT2DsnUD
 woIffJDQORnfJE6PhTiSV//PAAbakLGaV+1CC+K1y/1gtZvBQ7iHg1acuD7Cw8wDrXod
 eBsMZDvNHQpj7bxcoQrF90LvfKhK0xdshsdb6bT0UBu7Gv4IOX4My4DRrSf17akK17Yr
 xUQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiJBKW689iD0U18Y6mJWN23VXCy0+yYa6ASVO9Akh8giOlZyx2x2k2KZJqXp432JkOTRBVPfji8vMi@nongnu.org
X-Gm-Message-State: AOJu0Yzz1Y8T7Zki/6wGAaAMcU/oEPCH8xCwkXwWZGZjVvDISXMyBc+Z
 nf2sDH/pO+q/unxNkf5yQAeeryJSFTzskhNYIxapushlwSXMJ70XOykzmYCc+HpDwMG7dDzxJXc
 dSKAtF/HoFpJM3WYWp1SSe2uJ3Kjqth0qQd0/rNhqW9OnGx2ty/Ud
X-Gm-Gg: ASbGnct2TLeUwlQiVjG70HuvT15peSwhmTcv0IU8drXmk31w1om97m9cG89Dc40KLeo
 WiYg1pcr+9jlL5/xqLBZm1xPlQVd7CFMYAIBSVZopN4StYYRjJy1Xq24jh+wm4NvtL+ZkBxwUut
 uvqums4tZlvW7RMF9xNr/L8VYXPZFkxYRPDQZFggIK1vt7TyR9ZZz3A9QWY6FR/CGE8dBRttBzO
 rfKaQtF0SuaBmK3jKASadySMFXGPYvf99YdtcsmSSBR++/PxqZdpC0NZGJOg23ZSSym2/M64FfN
 ChTD0EE4YgRT
X-Received: by 2002:a05:622a:5c98:b0:476:739a:5cf3 with SMTP id
 d75a77b69052e-492255613d3mr11190901cf.1.1746564622788; 
 Tue, 06 May 2025 13:50:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOOJj1XBqzJyIWL2TTNjCZPxW+acEXYR15HV96BKCfLkajJEEa0DmmhqyAv/IdTxs2EmKvzg==
X-Received: by 2002:a05:622a:5c98:b0:476:739a:5cf3 with SMTP id
 d75a77b69052e-492255613d3mr11190061cf.1.1746564622059; 
 Tue, 06 May 2025 13:50:22 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4922174cc55sm2483521cf.39.2025.05.06.13.50.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 13:50:21 -0700 (PDT)
Message-ID: <e02e884b-0f3d-4426-8a67-2cbd23e80e8c@redhat.com>
Date: Tue, 6 May 2025 16:48:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum via <qemu-devel@nongnu.org>
Cc: qemu-arm@nongnu.org,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-2-shameerali.kolothum.thodi@huawei.com>
 <877c2ut0zk.fsf@pond.sub.org>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <877c2ut0zk.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/6/25 7:47 AM, Markus Armbruster wrote:
> Shameer Kolothum via <qemu-devel@nongnu.org> writes:
> 
>> Although this change does not affect functionality at present, it lays
>> the groundwork for enabling user-created SMMUv3 devices in
>> future patches
>>
>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>> ---
>>   hw/arm/smmuv3.c | 26 ++++++++++++++++++++++++++
>>   hw/arm/virt.c   |  3 ++-
>>   2 files changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index ab67972353..605de9b721 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -24,6 +24,7 @@
>>   #include "hw/qdev-properties.h"
>>   #include "hw/qdev-core.h"
>>   #include "hw/pci/pci.h"
>> +#include "hw/pci/pci_bridge.h"
>>   #include "cpu.h"
>>   #include "exec/target_page.h"
>>   #include "trace.h"
>> @@ -1874,6 +1875,25 @@ static void smmu_reset_exit(Object *obj, ResetType type)
>>       smmuv3_init_regs(s);
>>   }
>>   
>> +static int smmuv3_pcie_bus(Object *obj, void *opaque)
>> +{
>> +    DeviceState *d = opaque;
>> +    PCIBus *bus;
>> +
>> +    if (!object_dynamic_cast(obj, TYPE_PCI_HOST_BRIDGE)) {
>> +        return 0;
>> +    }
>> +
>> +    bus = PCI_HOST_BRIDGE(obj)->bus;
>> +    if (d->parent_bus && !strcmp(bus->qbus.name, d->parent_bus->name)) {
>> +        object_property_set_link(OBJECT(d), "primary-bus", OBJECT(bus),
>> +                                 &error_abort);
>> +        /* Return non-zero as we got the bus and don't need further iteration.*/
>> +        return 1;
>> +    }
>> +    return 0;
>> +}
>> +
>>   static void smmu_realize(DeviceState *d, Error **errp)
>>   {
>>       SMMUState *sys = ARM_SMMU(d);
>> @@ -1882,6 +1902,10 @@ static void smmu_realize(DeviceState *d, Error **errp)
>>       SysBusDevice *dev = SYS_BUS_DEVICE(d);
>>       Error *local_err = NULL;
>>   
>> +    if (!object_property_get_link(OBJECT(d), "primary-bus", &error_abort)) {
>> +        object_child_foreach_recursive(object_get_root(), smmuv3_pcie_bus, d);
>> +    }
>> +
>>       c->parent_realize(d, &local_err);
>>       if (local_err) {
>>           error_propagate(errp, local_err);
>> @@ -1996,6 +2020,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>>       device_class_set_parent_realize(dc, smmu_realize,
>>                                       &c->parent_realize);
>>       device_class_set_props(dc, smmuv3_properties);
>> +    dc->hotpluggable = false;
>> +    dc->bus_type = TYPE_PCIE_BUS;
> 
> This is very, very wrong.
> 
> The function serves as .class_init() for QOM type "arm-smmuv3", defined
> as:
> 
>     static const TypeInfo smmuv3_type_info = {
>         .name          = TYPE_ARM_SMMUV3,
>         .parent        = TYPE_ARM_SMMU,
> 
> Subtype of "arm-smmuv3".
> 
>         .instance_size = sizeof(SMMUv3State),
>         .instance_init = smmuv3_instance_init,
>         .class_size    = sizeof(SMMUv3Class),
>         .class_init    = smmuv3_class_init,
>     };
> 
> 
>      static const TypeInfo smmu_base_info = {
>          .name          = TYPE_ARM_SMMU,
>          .parent        = TYPE_SYS_BUS_DEVICE,
> 
> Subtype of "sys-bus-device".
> 
>          .instance_size = sizeof(SMMUState),
>          .class_data    = NULL,
>          .class_size    = sizeof(SMMUBaseClass),
>          .class_init    = smmu_base_class_init,
>          .abstract      = true,
>      };
> 
> Have a look at the instance struct:
> 
>     struct SMMUv3State {
>         SMMUState     smmu_state;
> 
> Starts with the supertype's instance struct, as is proper.
> 
>         uint32_t features;
>         [more ...]
>     };
> 
> Here's the supertype's instance struct:
> 
>     struct SMMUState {
>         /* <private> */
>         SysBusDevice  dev;
> 
> Again, starts with the supertype's instance struct.
> 
>         const char *mrtypename;
>         [more...]
>     };
> 
> This is a sysbus device, not a PCI device.  Monkey-patching dc->bus_type
> from TYPE_SYSTEM_BUS to TYPE_PCIE_BUS won't change that.  All it
> accomplishes is making the qdev core believe it plugs into a PCIE bus.
> This can only end in tears.
> 
> In fact, when I build with the entire series applied (so the device can
> actually be used with -device), the result dies within seconds of my ad
> hoc testing:
> 
>      $ qemu-system-aarch64 -nodefaults -S -display none -monitor stdio -M virt -device pxb-pcie,id=pcie.1,bus_nr=2 -device arm-smmuv3,bus=pcie.1
>      QEMU 10.0.50 monitor - type 'help' for more information
>      qemu-system-aarch64: -device arm-smmuv3,bus=pcie.1: warning: SMMUv3 device only supported with pcie.0 for DT
>      (qemu) info qtree
>      bus: main-system-bus
>        type System
>        dev: pxb-host, id ""
>          x-config-reg-migration-enabled = true
>          bypass-iommu = false
>          bus: pcie.1
>            type pxb-pcie-bus
>            dev: arm-smmuv3, id ""
>              gpio-out "sysbus-irq" 4
>              stage = "nested"
>              bus_num = 0 (0x0)
>      Segmentation fault (core dumped)
> 
> Backtrace:
> 
>      #0  0x00005555557d8521 in pcibus_dev_print
>          (mon=0x55555826d0e0, dev=0x5555590ad360, indent=8)
>          at ../hw/pci/pci-hmp-cmds.c:140
>      #1  0x0000555555eac0a0 in bus_print_dev
>          (bus=<optimized out>, mon=<optimized out>, dev=0x5555590ad360, indent=8)
>          at ../system/qdev-monitor.c:773
>      #2  qdev_print (mon=<optimized out>, dev=<optimized out>, indent=8)
>          at ../system/qdev-monitor.c:805
>      #3  qbus_print
>          (mon=mon@entry=0x55555826d0e0, bus=bus@entry=0x5555590ac4a0, indent=6,
>          indent@entry=4, details=details@entry=true) at ../system/qdev-monitor.c:821
>      #4  0x0000555555eabd92 in qbus_print
>          (mon=0x55555826d0e0, bus=<optimized out>, indent=2, details=true)
>          at ../system/qdev-monitor.c:824
>      #5  0x0000555555979789 in handle_hmp_command_exec
>          (cmd=<optimized out>, mon=0x55555826d0e0, qdict=0x55555907d8e0)
>          at ../monitor/hmp.c:1106
>      #6  handle_hmp_command_exec
>          (mon=0x55555826d0e0, cmd=0x55555769d220 <hmp_info_cmds+2560>, qdict=0x55555907d8e0) at ../monitor/hmp.c:1098
>      #7  handle_hmp_command (mon=mon@entry=0x55555826d0e0, cmdline=<optimized out>,
>          cmdline@entry=0x555558657490 "info qtree") at ../monitor/hmp.c:1158
>      #8  0x000055555597983c in monitor_command_cb
> 
> Crash line is
> 
>      int class = pci_get_word(d->config + PCI_CLASS_DEVICE);
> 
> Debugger shows that d->config is invalid.  This is hardly surprising!
> 
> The qdev core is trying to print information on the "arm_smmuv3" device
> here.  It's working with a DeviceState.  Your monkey-patching convinced
> it it's a PCIDevice, so it duly calls pcibus_dev_print() to print PCI
> device information.  pcibus_dev_print() casts the DeviceState * to
> PCIDevice *.  This assumes the device's instance actually starts with
> PCIDevice.  It actually starts with SysBusDevice.
> 
> Unsurprisingly, and "make check" also fails:
> 
>      >>> MESON_TEST_ITERATION=1 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 RUST_BACKTRACE=1 QTEST_QEMU_BINARY=./qemu-system-aarch64 QTEST_QEMU_IMG=./qemu-img G_TEST_DBUS_DAEMON=/work/armbru/qemu/tests/dbus-vmstate-daemon.sh ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 PYTHON=/work/armbru/qemu/bld-arm/pyvenv/bin/python3 UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 MALLOC_PERTURB_=22 /work/armbru/qemu/bld-arm/tests/qtest/test-hmp --tap -k
>      ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
>      stderr:
>      qemu-system-aarch64: ../hw/core/qdev.c:113: qdev_set_parent_bus: Assertion `dc->bus_type && object_dynamic_cast(OBJECT(bus), dc->bus_type)' failed.
>      Broken pipe
>      ../tests/qtest/libqtest.c:208: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
> 
> and
> 
>      >>> MESON_TEST_ITERATION=1 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 RUST_BACKTRACE=1 QTEST_QEMU_BINARY=./qemu-system-aarch64 MALLOC_PERTURB_=86 QTEST_QEMU_IMG=./qemu-img G_TEST_DBUS_DAEMON=/work/armbru/qemu/tests/dbus-vmstate-daemon.sh ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 PYTHON=/work/armbru/qemu/bld-arm/pyvenv/bin/python3 UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 /work/armbru/qemu/bld-arm/tests/qtest/qom-test --tap -k
>      ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
>      stderr:
>      qemu-system-aarch64: ../hw/core/qdev.c:113: qdev_set_parent_bus: Assertion `dc->bus_type && object_dynamic_cast(OBJECT(bus), dc->bus_type)' failed.
>      Broken pipe
>      ../tests/qtest/libqtest.c:208: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
> 
> Please make sure "make check" passes before posting patches for review.
> If you need help getting there, post them marked RFC and with the bad
> test results right in the cover letter.
> 
>>   }
>>   
>>   static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 177f3dd22c..3bae4e374f 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -56,6 +56,7 @@
>>   #include "qemu/cutils.h"
>>   #include "qemu/error-report.h"
>>   #include "qemu/module.h"
>> +#include "hw/pci/pci_bus.h"
>>   #include "hw/pci-host/gpex.h"
>>   #include "hw/virtio/virtio-pci.h"
>>   #include "hw/core/sysbus-fdt.h"
>> @@ -1442,7 +1443,7 @@ static void create_smmu(const VirtMachineState *vms,
>>       }
>>       object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
>>                                &error_abort);
>> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>> +    qdev_realize_and_unref(dev, &bus->qbus, &error_fatal);
>>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>>       for (i = 0; i < NUM_SMMU_IRQS; i++) {
>>           sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
> 
> What are you trying to accomplish?
> 
> I *guess* you're trying to change the "arm-smmuv3" device to be a PCI
> device.  Correct?
> 
> The only way to do that is making it a subtype of PCIDevice, i.e. change
> the parent chain from
> 
>     arm-smmuv3 -> arm-smmu -> sys-bus-device -> device -> object
> 
> to something like
> 
>     arm-smmuv3 ->    ...   -> pci-device -> device -> object
> 
> Note you cannot have different subtypes of the same supertype (say
> "arm-smmu") plug into different buses.  If you need a common device core
> to plug into different buses, things get more complicated.  Here's how
> the "serial-FOO" devices do it:
> 
> * "serial-mm", a subtype of "sys-bus-device", thus plugs into system bus
> * "serial-isa", a subtype of "isa-device", thus plugs into ISA bus
> * "serial-pci", a subtype of "pci-device", thus plugs into PCI bus
> 
> They all *contain* the core "serial" device, which is a subtype of
> "device", and thus does not plug into any bus.  "Contain" is "has a",
> not "subtype of".
> 
> [...]
> 
The serial-FOO analogy doesn't quite work for iommu/smmu's, because one is plugging a 'serial device' INTO a FOO-bus.

In this series, an iommu/smmu needs to be placed -BETWEEN- a sysbus and a PCIe-tree,
or step-wise, plug an smmuv3 into a sysbus, and a pcie tree/domain/RC into an SMMUv3.

So, an smmu needs to be associated with a bus (tree), i.e., pcie.0, pcie.1...
One could model it as a PCIe device, attached at the pcie-RC ... but that's not how it's modelled in ARM hw.
SMMU's are discovered via ACPI tables.

That leaves us back to the 'how to associate an SMMUv3 to a PCIe tree(RC)',
and that leads me to the other discussion & format I saw btwn Eric & Shameer:
  -device arm-smmv3,id=smmuv3.3
  -device xxxx,smmuv3= smmuv3.3
where one tags a (PCIe) device to an smmuv3(id), which is needed to build the (proper) IORT for (pcie-)device<->SMMUv3 associativity in a multi-SMMUv3 configuration.

We could keep the bus=pcie.X option for the -device arm-smmuv3 to indicate that all PCIe devices connected to the pcie.0 tree go through that smmuv3;
qdev would model/config as the smmuv3 is 'attached to pcie.0'... which it sorta is...  and I think the IORT build could associate all devices on pcie.0 to be associated
with the proper smmuv3.



  


