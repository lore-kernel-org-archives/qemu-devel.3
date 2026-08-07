Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05A1C5AC80
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 11:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsIjG-0005Dx-Ck; Fri, 07 Aug 2026 07:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@ecloud.org>) id 1wsIjC-0005Di-93
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 07:27:06 -0400
Received: from shrimp.cherry.relay.mailchannels.net ([23.83.223.164])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@ecloud.org>) id 1wsIj8-0001TA-GM
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 07:27:04 -0400
X-Sender-Id: dreamhost|x-authsender|lists@ecloud.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 0DFB2401471
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 11:26:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com
 (trex-green-2.trex.outbound.svc.cluster.local [100.106.248.237])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 4395D402382
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 11:26:53 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|lists@ecloud.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|lists@ecloud.org
X-MailChannels-Auth-Id: dreamhost
X-Power-Celery: 756ec47a572fb9db_1786102017623_8293822
X-MC-Loop-Signature: 1786102017623:1420389044
X-MC-Ingress-Time: 1786102017623
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.106.248.237 (trex/8.0.2); Fri, 07 Aug 2026 11:26:57 +0000
Received: from smtpclient.apple (unknown [46.109.74.206])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: lists@ecloud.org)
 by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4hGhgc5QB3zND
 for <qemu-devel@nongnu.org>; Fri,  7 Aug 2026 04:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ecloud.org;
 s=dreamhost; t=1786102013;
 bh=RCZvtt55etTeZPGjd3pEnXdq3h1r1wUZ0rHvJNU9mCE=;
 h=Content-Type:Content-Transfer-Encoding:From:Subject:Date:To;
 b=YY+UELVAoQ3ReRFdOGP17HFxINIcg6N8adKukFsURv4Lz7ZrjvWFkReE/8ZAK4uoc
 NnqjI1V1uuDArib3qd+pzX10WSGHakHhIp1y6jYDj1d08CPbZe9r9I1wlST9sgiIIJ
 njv7mOuNr/FnbAQ1XSDJA24XA4H98/olpiH2p0syjCS3tqiGuIA+9ySduHF93ljpYO
 NLv90M7r0CJ87uPO5yACi17cVNC+poZQ87rRmwn4u93/y8Qv0GwsH6cxjFna2uZ2IQ
 MQAYF+28MP/Dv56By7bpEPxU8XDhGJorVu+sbAqawbKrFXUtT0lJAkeZkxE6wgu9oC
 hKWuo7BRj2YgQ==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: lists <lists@ecloud.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] hw/riscv/virt: add dram-base machine property
Date: Fri, 7 Aug 2026 14:26:39 +0300
Message-Id: <EB2AEA1E-D748-4448-8824-722A91099AA5@ecloud.org>
References: <amscWwQvYUftUYW8@zen>
In-Reply-To: <amscWwQvYUftUYW8@zen>
To: qemu-devel@nongnu.org
X-Mailer: iPhone Mail (23G71)
Received-SPF: pass client-ip=23.83.223.164; envelope-from=lists@ecloud.org;
 helo=shrimp.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ping.

Do you have a different solution to emulate memory layouts of actual boards?=


For me this is necessary for the Plan 9 porting work: a Banana Pi F3 has a d=
ifferent base address than one of the K3 boards, and both different than the=
 QEMU default.

> On Jul 30, 2026, at 12:42, Shawn Rutledge <lists@ecloud.org> wrote:
>=20
> =EF=BB=BFThe 'virt' RISC-V machine hardcodes its DRAM base to 0x80000000.
> Real-world RISC-V SoCs put DRAM elsewhere (SpacemiT K1 at 0x40000000,
> SpacemiT K3 at 0x100000000, etc.), which forces ports that target
> those boards to build separate kernels for QEMU testing.
>=20
> Add a 'dram-base' string property that lets users move VIRT_DRAM up
> without rebuilding QEMU.  Values must be 2 MiB-aligned and at or
> above the default 0x80000000 to avoid colliding with statically-
> placed MMIO regions (PCIE_MMIO ends at 0x80000000).  Lower bases
> would also require moving PCIE_MMIO/IMSIC/etc. and are rejected with
> an explicit error pointing at the cause.
>=20
> Example:
>  qemu-system-riscv64 -machine virt,dram-base=3D0x100000000 -m 6G ...
> runs OpenSBI at firmware base 0x100000000, matching K3 memory layout.
>=20
> Signed-off-by: Shawn Rutledge <s@ecloud.org>
> ---
> hw/riscv/virt.c         | 59 ++++++++++++++++++++++++++++++++++++++++-
> include/hw/riscv/virt.h |  2 ++
> 2 files changed, 60 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 51bac47a91..6ccc98842f 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -20,6 +20,7 @@
>=20
> #include "qemu/osdep.h"
> #include "qemu/units.h"
> +#include "qemu/cutils.h"
> #include "qemu/error-report.h"
> #include "qemu/guest-random.h"
> #include "qapi/error.h"
> @@ -1307,7 +1308,13 @@ static void virt_machine_init(MachineState *machine=
)
>     int i, base_hartid, hart_count;
>     int socket_count =3D riscv_socket_count(machine);
>=20
> -    s->memmap =3D virt_memmap;
> +    if (s->dram_base) {
> +        s->memmap_storage =3D g_memdup2(virt_memmap, sizeof(virt_memmap))=
;
> +        s->memmap_storage[VIRT_DRAM].base =3D s->dram_base;
> +        s->memmap =3D s->memmap_storage;
> +    } else {
> +        s->memmap =3D virt_memmap;
> +    }
>=20
>     /* Check socket count limit */
>     if (VIRT_SOCKETS_MAX < socket_count) {
> @@ -1545,6 +1552,7 @@ static void virt_machine_instance_finalize(Object *o=
bj)
>     }
>     g_free(s->oem_id);
>     g_free(s->oem_table_id);
> +    g_free(s->memmap_storage);
> }
>=20
> static void virt_machine_instance_init(Object *obj)
> @@ -1616,6 +1624,46 @@ static void virt_set_aia(Object *obj, const char *v=
al, Error **errp)
>     }
> }
>=20
> +static char *virt_get_dram_base(Object *obj, Error **errp)
> +{
> +    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> +    uint64_t val =3D s->dram_base ? s->dram_base : virt_memmap[VIRT_DRAM]=
.base;
> +
> +    return g_strdup_printf("0x%" PRIx64, val);
> +}
> +
> +static void virt_set_dram_base(Object *obj, const char *val, Error **errp=
)
> +{
> +    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> +    const char *endptr;
> +    uint64_t base;
> +
> +    if (qemu_strtou64(val, &endptr, 0, &base) < 0 || *endptr !=3D '\0') {=

> +        error_setg(errp, "Invalid dram-base value '%s'", val);
> +        return;
> +    }
> +    /*
> +     * DRAM must clear all statically-placed MMIO regions in virt_memmap[=
]
> +     * (PCIE_MMIO ends at 0x80000000) and be 2 MiB-aligned so a standard
> +     * OpenSBI + kernel layout (firmware at base, kernel at base+0x200000=
)
> +     * fits.  Values below the default base would collide with on-board
> +     * MMIO and are rejected.
> +     */
> +    if (base < virt_memmap[VIRT_DRAM].base) {
> +        error_setg(errp,
> +                   "dram-base 0x%" PRIx64 " is below default 0x%" PRIx64
> +                   "; would collide with static MMIO regions",
> +                   base, (uint64_t)virt_memmap[VIRT_DRAM].base);
> +        return;
> +    }
> +    if (base & (2 * MiB - 1)) {
> +        error_setg(errp, "dram-base 0x%" PRIx64 " must be 2 MiB-aligned",=

> +                   base);
> +        return;
> +    }
> +    s->dram_base =3D base;
> +}
> +
> static bool virt_get_aclint(Object *obj, Error **errp)
> {
>     RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
> @@ -1744,6 +1792,15 @@ static void virt_machine_class_init(ObjectClass *oc=
, const void *data)
>     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
> #endif
>=20
> +    object_class_property_add_str(oc, "dram-base", virt_get_dram_base,
> +                                  virt_set_dram_base);
> +    object_class_property_set_description(oc, "dram-base",
> +                                          "Base physical address of DRAM "=

> +                                          "(default 0x80000000). Must be "=

> +                                          "2 MiB-aligned and at or above "=

> +                                          "the default to avoid colliding=
 "
> +                                          "with statically-placed MMIO.")=
;
> +
>     object_class_property_add_bool(oc, "aclint", virt_get_aclint,
>                                    virt_set_aclint);
>     object_class_property_set_description(oc, "aclint",
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 36a2def410..be8a4ac049 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -61,6 +61,8 @@ struct RISCVVirtState {
>     char *oem_table_id;
>     OnOffAuto acpi;
>     const MemMapEntry *memmap;
> +    MemMapEntry *memmap_storage; /* g_malloc'd copy when dram-base overri=
de is set */
> +    uint64_t dram_base;          /* 0 =3D use compiled-in default (0x8000=
0000) */
>     struct GPEXHost *gpex_host;
>     OnOffAuto iommu_sys;
>     uint16_t pci_iommu_bdf;
> --
> 2.55.0
>=20

