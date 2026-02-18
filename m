Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F64EE9A049
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 03:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsYDs-0007DG-Gw; Tue, 17 Feb 2026 22:27:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vsYDp-0007Cx-QY
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 22:27:29 -0500
Received: from p-east2-cluster3-host3-snip4-1.eps.apple.com ([57.103.77.152]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vsYDn-0008Cn-Ra
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 22:27:29 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPS id
 AF29C18000AE; Wed, 18 Feb 2026 03:27:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771385243; x=1773977243;
 bh=6lxW2QxVnJ0I+pJ+1tZmay5w04r1Gw5wiDbw3eQJhw8=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=QQIbTFjDvBoMMZa0DqK8hIOS34aDl/V4GKS4bcZLHHZ6KDMrfupzRL2F9ln+1RdRFivTqAg2ZRWS/eehO336fEyri2Aw2/4+2c7FsxvmmMGXn9twZbfVGQJb+wB487kilNOCXd8VkHRC7IzTwvFf1WuGba5oYb17zEBd//qFoob5jmyfuZtuLlvgHyieYsDL7ZHnYiftb37SUbVc+33q25pLFkqhGGmXHB23Ap4cEleaQm59+y1YwHVw5P4uUG23qOR8jPduEL2FE2dyp8cG3jTciPAQwcZ6gqNUNC9pV2lerBdfDVL+dLa74PGjwjGfnajZ0pSHvjsnFY63TCjXiw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPSA id
 90A6C18000BA; Wed, 18 Feb 2026 03:27:16 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 07/10] hw/nitro: Add nitro machine
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260218015151.4052-8-graf@amazon.com>
Date: Wed, 18 Feb 2026 04:27:04 +0100
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 alex.bennee@linaro.org, philmd@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, Cornelia Huck <cohuck@redhat.com>,
 mst@redhat.com, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Tyler Fanelli <tfanelli@redhat.com>,
 mknaust@amazon.com, nh-open-source@amazon.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D0E52BB9-72B7-4844-85D3-79A29F51AD17@unpredictable.fr>
References: <20260218015151.4052-1-graf@amazon.com>
 <20260218015151.4052-8-graf@amazon.com>
To: Alexander Graf <graf@amazon.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-ORIG-GUID: _WREuMzAXeOLSvGPLrUR9Ked3baTjSAF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDAyOSBTYWx0ZWRfXx1NjJrIMEPj0
 8HskdfX2XcqEDVssZSvHQqNyCrR2hlyTnXhS58M8UsuZ7Bryn4fXBfSGM6TjSxBHuBbfMm6f0tp
 YvwmCT7OSdEuh8PUXSwAdTIKPaL5aYxbH8BZbGD3lUAbLXrJlOTOEUDIwBCTSiqqSQNXyRhHr7k
 yH2vHOQ45kFyaid/DHXoaASUYHFnGaoxXMwTFOZsjyYjHqf3QAl55lZPmdmnDDTp52kHF1EXhtX
 xV1iJuAvYhZ/iC91thZxPb4k48U35lm1gz0rSCA3z2xpSfDG34WANjdlA6oVMU0zK0LMq/ksoXY
 GCCIjiK+RHnanJu6tROkNHTiGPw2S9z8YYFUrhvhD9RiKNO/f8M+Lc1j/ci4A4=
X-Authority-Info-Out: v=2.4 cv=PfjyRyhd c=1 sm=1 tr=0 ts=6995319a
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=vggBfdFIAAAA:8 a=q9NCTU0vm4Z_aoCdxZkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _WREuMzAXeOLSvGPLrUR9Ked3baTjSAF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_04,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 clxscore=1030 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602180029
X-JNJ: AAAAAAABexpT2ID+UbX+rbTJmX40g9e/fX9EUYGwcEv/wPY1NvnK0rsboI9VVmaxbwJPCm1nUEoobUq+IaKvgtRlfL8h/89MUfvDmS7k9AyfDqlCf6AmGaT45/P2fw+X4AJ139i1tyZ3BsTvEp5UB2bnP4RaIeDBgH0Cx3yidn+jMeoigDu59lEj10dFlErJZfyHOBaFKJfkm+yrnzxiCOmXnr0oImCiGg6MByo2G1GR8gRYLhiKuYCmNwBYx6S9RZp10t5lamUHXGN5IWuyHOIxHYFzAKWw2qDfcTbWGxSTqYaCq+VICj0qHG/ImFWF4SjEXSZmib4hSaQrWa1juQ8Hhj8WQhsyxZ1Vet1jMdCrsm/qyQ+0iynXjv06OUWUntfcqK+sW1zSoFCoGfy2t2FqBUGg1A0kJ0BI5j8AKtDRW3f9yfs9k3CXh8fc+hHUBEoW+SUGGIieZCQh8kHFWoPvL0ZllycFXuI5oGBQevBJhySyz/LZlTssj8/l07r0YlRFiIYTDOErldYgCNezFxjsX+IH9KaL6yan7wb35iiLBxPvezdsjaT49uFSN3f+Ko1AkVKtzZuip8T9Ybev1ZT30q4r4eU3IHYtK6w8ul8UeBZSI7JW3aHpS6jaJMQdtvJDzNIt5ZXfvwtcBlT1f/mFvEMg01iXZvuIoP2Wk0ygUZCPUQI0LkzSXs/fAZEWdA/9JZ03nl/kbdunRd2gp1K81GkBOQCDUTPdNC49H/dUV6IyAvIplzNxM1SOlqL6Ukwfoi2mpLSKl7N0VzJ/KmU=
Received-SPF: pass client-ip=57.103.77.152;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> On 18. Feb 2026, at 02:51, Alexander Graf <graf@amazon.com> wrote:
>=20
> Add a machine model to spawn a Nitro Enclave. Unlike the existing -M
> nitro-enclave, this machine model works exclusively with the -accel
> nitro accelerator to drive real Nitro Enclave creation. It supports
> memory allocation, number of CPU selection, both x86_64 as well as
> aarch64, implements the Enclave heartbeat logic and debug serial
> console.
>=20
> To use it, create an EIF file and run
>=20
>  $ qemu-system-x86_64 -accel nitro,debug-mode=3Don -M nitro -nographic =
\
>                       -kernel test.eif
>=20
> or
>=20
>  $ qemu-system-aarch64 -accel nitro,debug-mode=3Don -M nitro =
-nographic \
>                       -kernel test.eif
>=20
> Signed-off-by: Alexander Graf <graf@amazon.com>
Hi,

The separation between -M nitro and -M nitro-enclave looks potentially =
confusing
to users. Could it potentially make sense to share the name or is that =
an option not
on the cards?

 -M nitro as a name is a bit ambiguous both in the short and long run
> ---
> hw/nitro/Kconfig           |   7 ++
> hw/nitro/machine.c         | 180 +++++++++++++++++++++++++++++++++++++
> hw/nitro/meson.build       |   1 +
> include/hw/nitro/machine.h |  20 +++++
> 4 files changed, 208 insertions(+)
> create mode 100644 hw/nitro/machine.c
> create mode 100644 include/hw/nitro/machine.h
>=20
> diff --git a/hw/nitro/Kconfig b/hw/nitro/Kconfig
> index 6fe050d35d..910068c23c 100644
> --- a/hw/nitro/Kconfig
> +++ b/hw/nitro/Kconfig
> @@ -5,3 +5,10 @@ config NITRO_SERIAL_VSOCK
> config NITRO_HEARTBEAT
>     bool
>     depends on NITRO
> +
> +config NITRO_MACHINE
> +    bool
> +    default y
> +    depends on NITRO
> +    select NITRO_HEARTBEAT
> +    select NITRO_SERIAL_VSOCK
> diff --git a/hw/nitro/machine.c b/hw/nitro/machine.c
> new file mode 100644
> index 0000000000..197adfbdb5
> --- /dev/null
> +++ b/hw/nitro/machine.c
> @@ -0,0 +1,180 @@
> +/*
> + * Nitro Enclaves (accel) machine
> + *
> + * Copyright =C2=A9 2026 Amazon.com, Inc. or its affiliates. All =
Rights Reserved.
> + *
> + * Authors:
> + *   Alexander Graf <graf@amazon.com>
> + *
> + * Nitro Enclaves machine model for -accel nitro. This machine =
behaves
> + * like the nitro-enclave machine, but uses the real Nitro Enclaves
> + * backend to launch the virtual machine. It requires use of the =
-accel
> + * nitro.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "qom/object_interfaces.h"
> +#include "chardev/char.h"
> +#include "hw/core/boards.h"
> +#include "hw/core/cpu.h"
> +#include "hw/core/sysbus.h"
> +#include "hw/core/qdev-properties-system.h"
> +#include "hw/nitro/heartbeat.h"
> +#include "hw/nitro/machine.h"
> +#include "hw/nitro/serial-vsock.h"
> +#include "system/address-spaces.h"
> +#include "system/hostmem.h"
> +#include "system/system.h"
> +#include "system/nitro-accel.h"
> +#include "qemu/accel.h"
> +#include "hw/arm/machines-qom.h"
> +
> +#define EIF_LOAD_ADDR   (8 * 1024 * 1024)
> +
> +static void nitro_create_cpu(const char *cpu_type, int index)
> +{
> +    Object *obj =3D object_new(cpu_type);
> +
> +    /* x86 CPUs require an apic-id before realize */
> +    if (object_property_find(obj, "apic-id")) {
> +        object_property_set_int(obj, "apic-id", index, &error_fatal);
> +    }
> +
> +    qdev_realize(DEVICE(obj), NULL, &error_fatal);
> +}
> +
> +static void nitro_machine_init(MachineState *machine)
> +{
> +    const char *eif_path =3D machine->kernel_filename;
> +    const char *cpu_type =3D machine->cpu_type;
> +    g_autofree char *eif_data =3D NULL;
> +    gsize eif_size;
> +    int i;
> +
> +    if (!nitro_enabled()) {
> +        error_report("The 'nitro' machine requires -accel nitro");
> +        exit(1);
> +    }
> +
> +    if (!cpu_type) {
> +        ObjectClass *oc =3D cpu_class_by_name(target_cpu_type(), =
"host");
> +
> +        if (!oc) {
> +            error_report("nitro: no 'host' CPU available");
> +            exit(1);
> +        }
> +        cpu_type =3D object_class_get_name(oc);
> +    }
> +
> +    if (!eif_path) {
> +        error_report("nitro: -kernel <eif-file> is required");
> +        exit(1);
> +    }
> +
> +    /* Expose memory as normal QEMU RAM. Needs to be huge page =
backed. */
> +    memory_region_add_subregion(get_system_memory(), 0, =
machine->ram);
> +
> +    /*
> +     * Load EIF (-kernel) as raw blob at the EIF_LOAD_ADDR into guest =
RAM.
> +     * The Nitro Hypervisor will extract its contents and bootstrap =
the
> +     * Enclave from it.
> +     */
> +    if (!g_file_get_contents(eif_path, &eif_data, &eif_size, NULL)) {
> +        error_report("nitro: failed to read EIF '%s'", eif_path);
> +        exit(1);
> +    }
> +    address_space_write(&address_space_memory, EIF_LOAD_ADDR,
> +                        MEMTXATTRS_UNSPECIFIED, eif_data, eif_size);
> +
> +    /* Nitro Enclaves require a heartbeat device. Provide one. */
> +    =
sysbus_realize_and_unref(SYS_BUS_DEVICE(qdev_new(TYPE_NITRO_HEARTBEAT)),
> +                             &error_fatal);
> +
> +    /*
> +     * In debug mode, Nitro Enclaves expose the guest's serial output =
via
> +     * vsock. When the accel is in debug mode, wire the vsock serial =
to
> +     * the machine's serial port so that -nographic automatically =
works
> +     */
> +    if (object_property_get_bool(OBJECT(current_accel()), =
"debug-mode", NULL)) {
> +        Chardev *chr =3D serial_hd(0);
> +
> +        if (chr) {
> +            DeviceState *dev =3D qdev_new(TYPE_NITRO_SERIAL_VSOCK);
> +
> +            qdev_prop_set_chr(dev, "chardev", chr);
> +            sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), =
&error_fatal);
> +        }
> +    }
> +
> +    /*
> +     * Spawn vCPUs. While the real Nitro Enclaves CPUs are owned by =
the
> +     * underlying hypervisor, we still want to maintain a local view =
of
> +     * them to trigger VM creation when vCPU 0 starts and to give us =
an
> +     * object to interact with.
> +     */
> +    for (i =3D 0; i < machine->smp.cpus; i++) {
> +        nitro_create_cpu(cpu_type, i);
> +    }
> +}
> +
> +static bool nitro_create_memfd_backend(MachineState *ms, const char =
*path,
> +                                       Error **errp)
> +{
> +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> +    Object *root =3D object_get_objects_root();
> +    Object *obj;
> +    bool r =3D false;
> +
> +    obj =3D object_new(TYPE_MEMORY_BACKEND_MEMFD);
> +
> +    /* Nitro Enclaves require huge page backing */
> +    if (!object_property_set_int(obj, "size", ms->ram_size, errp) ||
> +        !object_property_set_bool(obj, "hugetlb", true, errp)) {
> +        goto out;
> +    }
> +
> +    object_property_add_child(root, mc->default_ram_id, obj);
> +
> +    if (!user_creatable_complete(USER_CREATABLE(obj), errp)) {
> +        goto out;
> +    }
> +    r =3D object_property_set_link(OBJECT(ms), "memory-backend", obj, =
errp);
> +
> +out:
> +    object_unref(obj);
> +    return r;
> +}
> +
> +static void nitro_machine_class_init(ObjectClass *oc, const void =
*data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
> +    mc->desc =3D "Nitro Enclave";
> +    mc->init =3D nitro_machine_init;
> +    mc->create_default_memdev =3D nitro_create_memfd_backend;
> +    mc->default_ram_id =3D "ram";
> +    mc->max_cpus =3D 4096;
> +}
> +
> +static const TypeInfo nitro_machine_info =3D {
> +    .name =3D TYPE_NITRO_MACHINE,
> +    .parent =3D TYPE_MACHINE,
> +    .instance_size =3D sizeof(NitroMachineState),
> +    .class_init =3D nitro_machine_class_init,
> +    .interfaces =3D (const InterfaceInfo[]) {
> +        /* x86_64 and aarch64 only */
> +        { TYPE_TARGET_AARCH64_MACHINE },
> +        { }
> +    },
> +};
> +
> +static void nitro_machine_register(void)
> +{
> +    type_register_static(&nitro_machine_info);
> +}
> +
> +type_init(nitro_machine_register);
> diff --git a/hw/nitro/meson.build b/hw/nitro/meson.build
> index b921da2b97..813f5a9c87 100644
> --- a/hw/nitro/meson.build
> +++ b/hw/nitro/meson.build
> @@ -1,2 +1,3 @@
> system_ss.add(when: 'CONFIG_NITRO_SERIAL_VSOCK', if_true: =
files('serial-vsock.c'))
> system_ss.add(when: 'CONFIG_NITRO_HEARTBEAT', if_true: =
files('heartbeat.c'))
> +system_ss.add(when: 'CONFIG_NITRO_MACHINE', if_true: =
files('machine.c'))
> diff --git a/include/hw/nitro/machine.h b/include/hw/nitro/machine.h
> new file mode 100644
> index 0000000000..d78ba7d6dc
> --- /dev/null
> +++ b/include/hw/nitro/machine.h
> @@ -0,0 +1,20 @@
> +/*
> + * Nitro Enclaves (accel) machine
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_NITRO_MACHINE_H
> +#define HW_NITRO_MACHINE_H
> +
> +#include "hw/core/boards.h"
> +#include "qom/object.h"
> +
> +#define TYPE_NITRO_MACHINE MACHINE_TYPE_NAME("nitro")
> +OBJECT_DECLARE_SIMPLE_TYPE(NitroMachineState, NITRO_MACHINE)
> +
> +struct NitroMachineState {
> +    MachineState parent;
> +};
> +
> +#endif /* HW_NITRO_MACHINE_H */
> --=20
> 2.47.1
>=20
>=20
>=20
>=20
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597


