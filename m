Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A34C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 18:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXPmZ-0005K8-4p; Fri, 26 Jul 2024 14:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1sXPmW-0005Hb-FV; Fri, 26 Jul 2024 14:35:09 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1sXPmR-0001H0-D6; Fri, 26 Jul 2024 14:35:08 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fed72d23a7so8279045ad.1; 
 Fri, 26 Jul 2024 11:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722018901; x=1722623701; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q5j0D/6nv+nfxUVKBjpOluIhJypL/MPunxWJ1jb5nPI=;
 b=GNUu1HdYuetzO1NHF7aLmftUZ7EWRWu/iDe3JlAE8OJKqNJ2QhQPqYJzvTTqw2Szu0
 NlNPWJaHI8TV8RXTlqwCjsowOxXp72b2wVkmeW5Djc65grAhABFdZLA2wZOkPtApsXYk
 akm15oIpCKhwRa1ReMoKOlPrvmQ3PWF3eiDGdzYBwHpQzsi/Fc349BLLT5Hfg8ORcWhe
 1RcPmxMWc1+DV/pyTfw4MxzOkZOF8RgkkG9FzNOHKuEajsYallh6Sqctf5veO/dt7Ygg
 90jct/EZYcQvpRGYvfBChd9qrnaZK+Cb7CKk/zt+9hTbaeS4zfqx4LFtaWmRAIwNjm8g
 9afA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722018901; x=1722623701;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q5j0D/6nv+nfxUVKBjpOluIhJypL/MPunxWJ1jb5nPI=;
 b=rvTOve5YBHdAEjDS6eaIl3wjQkHI+bLNhTm8bNZm0L7z4cYUhYd4FZx6f4A1iu8Xtg
 qzHYuucS3tzj31yPN/FVuHNkRD6J6+aIUE5Kulpx+cyHxAK0ha1wnX13VoWMuSQ6DpXL
 UcmEtM2r/VwRuQjxyGLeuKNSEEBh9p3hLCa6/0kCJ6bcdpwjXSdrH879SmnpatXvo7lF
 d1TeSmOkaSy6fiAiZBxkzfOn2dOMRcf8gEgRPoHUkHb9SJRxXPRGa1CE64OG4G3nzRIK
 0nSewmmdX9vtFgIGbUMIL/aw9X5ufSvfi1vSIzL121e6a7irXDZX87iABqcTO+jlzQPx
 hxjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrHSyIo62iAG6Qd3qMf4H55pDW1gs/opoHDLRtiSDSfoOEUkVCFEXAKc6xRfDuOlR41ufU5TvhNhkuhVkD0PxgWEueuTE=
X-Gm-Message-State: AOJu0YyzpX0VGWjzrDEKCDJ6B+B+dz2w7K4eBAoHiJsJYQJGF+563468
 NXDnhNafxDis3PY+FP9nBk5ERG8uumcwII5phoKow2cZjcYoAVWF79xPN8Gvvm+BzGNr9dcWVLH
 T6oaK+8menFURxzSgyCxf6wzYkcpf5Whkz40=
X-Google-Smtp-Source: AGHT+IFhvlrNCxQjNhoWJp+BpVG8Vl/tDuiBH9Ypvblm6AB7ayGuzHwaRfs7jx/cZ8oVc+1GBCubWE0BhBcbp6+ks9w=
X-Received: by 2002:a17:903:228b:b0:1fc:f65:cd8a with SMTP id
 d9443c01a7336-1ff04810fe7mr6105325ad.18.1722018901092; Fri, 26 Jul 2024
 11:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240726001416.1498769-1-gregorhaas1997@gmail.com>
 <41d3e591-6bc7-45bb-b21d-0a748162fba4@ventanamicro.com>
In-Reply-To: <41d3e591-6bc7-45bb-b21d-0a748162fba4@ventanamicro.com>
From: Gregor Haas <gregorhaas1997@gmail.com>
Date: Fri, 26 Jul 2024 11:34:24 -0700
Message-ID: <CAMqWt3rqtb=a1Te2QdnA-3FAVJRfJYj2X0crhmyQs=Vua-1XTA@mail.gmail.com>
Subject: Re: [PATCH] Add support for generating OpenSBI domains in the device
 tree
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, atishp@rivosinc.com, 
 alistair.francis@wdc.com
Content-Type: multipart/alternative; boundary="000000000000e5707d061e2ac46b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=gregorhaas1997@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000e5707d061e2ac46b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Oops! Sorry about the build failure - slightly embarrassing on my part!

> +RISC-V OpenSBI domain support
> > +M: Gregor Haas <gregorhaas1997@gmail.com>
> > +L: qemu-riscv@nongnu.org
> > +S: Maintained
> > +F: hw/riscv/domain.c
> > +F: include/hw/riscv/domain.h
>
> I suggest 'opensbi_domain.c' and 'opensbi_domain.h' as file names to be
> clearer
> about what the file contents is about.


Agreed!

> +static void create_fdt_domain_possible_harts(MachineState *ms,
> > +                                             OpenSBIDomainState *s,
> > +                                             char *path) {
> > +    unsigned long i, cpu;
> > +    int num_cpus;
> > +    uint32_t *phandles;
> > +    char *cpu_name;
>
> For these variables I recommend using g_autofree to avoid the need for
> g_free()
> calls. This will call g_free() automatically when the variable scope ends=
.
> It
> also help to avoid mem leaks when moving code around and leaving a
> g_free() behind
> by accident.


Also agreed! I was unsure the best way to use g_autofree for the variables
which I
allocate multiple times (such as cpu_name). I was not sure if g_autofree
would free
pointers that were overwritten with a new allocation, so I handled this
manually. However,
I really like your solution of declaring these variables in the body of the
loop itself. I'll
make these changes in a PATCH v2 shorty.

Thanks for the review,
Gregor


On Fri, Jul 26, 2024 at 10:46=E2=80=AFAM Daniel Henrique Barboza <
dbarboza@ventanamicro.com> wrote:

> Hi Gregor,
>
>
> This patch doesn't build in my env. Here's the error:
>
> ./hw/riscv/virt.c
> ../hw/riscv/virt.c: In function =E2=80=98finalize_fdt=E2=80=99:
> ../hw/riscv/virt.c:1056:32: error: =E2=80=98ms=E2=80=99 undeclared (first=
 use in this
> function); did you mean =E2=80=98s=E2=80=99?
>   1056 |     create_fdt_opensbi_domains(ms);
>        |                                ^~
>
>
> I believe that at that point you'll want to use MACHINE(s) instead of
> 'ms'.
>
> Other comments below:
>
> On 7/25/24 9:14 PM, Gregor Haas wrote:
> > OpenSBI has support for domains, which are partitions of CPUs and memor=
y
> into
> > isolated compartments. Domains can be specified in the device tree
> according to
> > a standardized format [1], which OpenSBI parses at boot time to
> initialize all
> > system domains. This patch enables simply specifying domains (and their
> > associated memory regions) on the QEMU command line, from which these
> are then
> > rendered into the machine's device tree. A simple example of what this
> looks
> > like is below:
> >
> > qemu-system-riscv64 -machine virt -bios fw_jump.bin -cpu max -smp 2 -m
> 4G \
> >       -device
> opensbi-memregion,id=3Dmem,base=3D0x178000000,size=3D0x4000000,mmio=3Dfal=
se \
> >       -device
> opensbi-domain,possible-harts=3D0x2,boot-hart=3D0x1,next-addr=3D0x1780000=
00,next-mode=3D1,region0=3Dmem,perms0=3D0x3f
> >
> > At machine initialization time, a new create_fdt_opensbi_domains()
> function
> > walks the peripherals/peripherals-anon containers, identifies all
> domains and
> > memregions, and parses them into the relevant device tree structures.
> >
> > [1]
> https://github.com/riscv-software-src/opensbi/blob/master/docs/domain_sup=
port.md
> >
> > Signed-off-by: Gregor Haas <gregorhaas1997@gmail.com>
> > ---
> >   MAINTAINERS               |   7 +
> >   hw/riscv/Kconfig          |   4 +
> >   hw/riscv/domain.c         | 435 +++++++++++++++++++++++++++++++++++++=
+
> >   hw/riscv/meson.build      |   1 +
> >   hw/riscv/virt.c           |   3 +
> >   include/hw/riscv/domain.h |  49 +++++
> >   6 files changed, 499 insertions(+)
> >   create mode 100644 hw/riscv/domain.c
> >   create mode 100644 include/hw/riscv/domain.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 98eddf7ae1..85ad6e0227 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -355,6 +355,13 @@ F: target/riscv/XVentanaCondOps.decode
> >   F: target/riscv/insn_trans/trans_xventanacondops.c.inc
> >   F: disas/riscv-xventana*
> >
> > +RISC-V OpenSBI domain support
> > +M: Gregor Haas <gregorhaas1997@gmail.com>
> > +L: qemu-riscv@nongnu.org
> > +S: Maintained
> > +F: hw/riscv/domain.c
> > +F: include/hw/riscv/domain.h
>
> I suggest 'opensbi_domain.c' and 'opensbi_domain.h' as file names to be
> clearer
> about what the file contents is about.
>
> > +
> >   RENESAS RX CPUs
> >   R: Yoshinori Sato <ysato@users.sourceforge.jp>
> >   S: Orphan
> > diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> > index a2030e3a6f..14a3a7d09e 100644
> > --- a/hw/riscv/Kconfig
> > +++ b/hw/riscv/Kconfig
> > @@ -1,6 +1,9 @@
> >   config RISCV_NUMA
> >       bool
> >
> > +config RISCV_DOMAIN
> > +    bool
> > +
> >   config IBEX
> >       bool
> >
> > @@ -40,6 +43,7 @@ config RISCV_VIRT
> >       imply TPM_TIS_SYSBUS
> >       select DEVICE_TREE
> >       select RISCV_NUMA
> > +    select RISCV_DOMAIN
> >       select GOLDFISH_RTC
> >       select PCI
> >       select PCI_EXPRESS_GENERIC_BRIDGE
> > diff --git a/hw/riscv/domain.c b/hw/riscv/domain.c
> > new file mode 100644
> > index 0000000000..11b3aff453
> > --- /dev/null
> > +++ b/hw/riscv/domain.c
> > @@ -0,0 +1,435 @@
> > +#include "qemu/osdep.h"
> > +#include "hw/riscv/domain.h"
> > +#include "hw/boards.h"
> > +#include "sysemu/device_tree.h"
> > +#include "qapi/error.h"
> > +
> > +#include <libfdt.h>
> > +
> > +static void create_fdt_domain_possible_harts(MachineState *ms,
> > +                                             OpenSBIDomainState *s,
> > +                                             char *path) {
> > +    unsigned long i, cpu;
> > +    int num_cpus;
> > +    uint32_t *phandles;
> > +    char *cpu_name;
>
> For these variables I recommend using g_autofree to avoid the need for
> g_free()
> calls. This will call g_free() automatically when the variable scope ends=
.
> It
> also help to avoid mem leaks when moving code around and leaving a
> g_free() behind
> by accident.
>
> For example:
>
> > +
> > +    num_cpus =3D ctpop64(s->possible_harts);
> > +    if (num_cpus) {
> > +        phandles =3D g_malloc0_n(num_cpus, sizeof(uint32_t));
>
>            g_autofree uint32_t *phandles =3D  g_malloc0_n(num_cpus,
> sizeof(uint32_t));
>
> > +
> > +        for (i =3D 0, cpu =3D -1; i < num_cpus; i++) {
>
> > +            cpu =3D find_next_bit(&s->possible_harts, BITS_PER_LONG, c=
pu
> + 1);
>                 g_autofree char *cpu_name =3D
> find_next_bit(&s->possible_harts, BITS_PER_LONG, cpu + 1);
>
> > +            cpu_name =3D g_strdup_printf("/cpus/cpu@%li", cpu);
> > +            phandles[i++] =3D cpu_to_fdt32(qemu_fdt_get_phandle(
> > +                    ms->fdt, cpu_name));
> > +            g_free(cpu_name);
>
> Remove this g_free().
>
> > +        }
> > +
> > +        qemu_fdt_setprop(ms->fdt, path, "possible-harts",
> > +                         phandles, num_cpus * 4);
> > +        g_free(phandles);
>
> Remove this g_free().
>
>
> This 'g_autofree' usage can be applied to most functions in the patch.
>
>
> Thanks,
>
> Daniel
>
>
> > +    }
> > +}
> > +
> > +static void create_fdt_domain_regions(MachineState *ms,
> > +                                      OpenSBIDomainState *s,
> > +                                      char *path) {
> > +    unsigned long i;
> > +    int num_regions =3D 0;
> > +    uint32_t *regions;
> > +    char *region_name;
> > +    DeviceState *ds;
> > +
> > +    for (i =3D 0; i < OPENSBI_DOMAIN_MEMREGIONS_MAX; i++) {
> > +        if (s->regions[i]) {
> > +            num_regions++;
> > +        }
> > +    }
> > +
> > +    if (num_regions) {
> > +        regions =3D g_malloc0_n(num_regions, 2 * sizeof(uint32_t));
> > +        for (i =3D 0; i < OPENSBI_DOMAIN_MEMREGIONS_MAX; i++) {
> > +            if (s->regions[i]) {
> > +                ds =3D DEVICE(s->regions[i]);
> > +                region_name =3D
> g_strdup_printf("/chosen/opensbi-domains/%s",
> > +                                              ds->id);
> > +                regions[2 * i] =3D cpu_to_fdt32(qemu_fdt_get_phandle
> > +                        (ms->fdt, region_name));
> > +                regions[2 * i + 1] =3D cpu_to_fdt32(s->region_perms[i]=
);
> > +                g_free(region_name);
> > +            }
> > +        }
> > +
> > +        qemu_fdt_setprop(ms->fdt, path, "regions",
> > +                         regions, num_regions * 8);
> > +        g_free(regions);
> > +    }
> > +}
> > +
> > +struct DomainFDTState {
> > +    MachineState *ms;
> > +    bool regions;
> > +};
> > +
> > +static void create_fdt_one_domain(MachineState *ms, OpenSBIDomainState
> *s)
> > +{
> > +    DeviceState *ds =3D DEVICE(s);
> > +    char *path, *cpu_name;
> > +
> > +    if (ds->id) {
> > +        path =3D g_strdup_printf("/chosen/opensbi-domains/%s",
> > +                               ds->id);
> > +    } else {
> > +        path =3D g_strdup_printf("/chosen/opensbi-domains/domain@%lx",
> > +                               s->next_addr);
> > +    }
> > +
> > +    qemu_fdt_add_subnode(ms->fdt, path);
> > +    qemu_fdt_setprop_string(ms->fdt, path, "compatible",
> > +                            "opensbi,domain,instance");
> > +    qemu_fdt_setprop_cells(ms->fdt, path, "phandle",
> > +                           qemu_fdt_alloc_phandle(ms->fdt));
> > +
> > +    create_fdt_domain_possible_harts(ms, s, path);
> > +    create_fdt_domain_regions(ms, s, path);
> > +
> > +    /* Assign boot hart to this domain */
> > +    cpu_name =3D g_strdup_printf("/cpus/cpu@%i", s->boot_hart);
> > +    qemu_fdt_setprop_cell(ms->fdt, path, "boot-hart",
> > +                          qemu_fdt_get_phandle(ms->fdt, cpu_name));
> > +    qemu_fdt_setprop_cell(ms->fdt, cpu_name, "opensbi-domain",
> > +                          qemu_fdt_get_phandle(ms->fdt, path));
> > +    g_free(cpu_name);
> > +
> > +    qemu_fdt_setprop_cells(ms->fdt, path, "next-arg1",
> > +                           (uint64_t) s->next_arg1 >> 32, s->next_arg1=
);
> > +    qemu_fdt_setprop_cells(ms->fdt, path, "next-addr",
> > +                           (uint64_t) s->next_addr >> 32, s->next_addr=
);
> > +    qemu_fdt_setprop_cell(ms->fdt, path, "next-mode",
> > +                          s->next_mode);
> > +
> > +    if (s->system_reset_allowed) {
> > +        qemu_fdt_setprop(ms->fdt, path, "system-reset-allowed", NULL,
> 0);
> > +    }
> > +
> > +    if (s->system_suspend_allowed) {
> > +        qemu_fdt_setprop(ms->fdt, path, "system-suspend-allowed", NULL=
,
> 0);
> > +    }
> > +
> > +    g_free(path);
> > +}
> > +
> > +static void create_fdt_one_memregion(MachineState *ms,
> > +                                     OpenSBIMemregionState *s)
> > +{
> > +    char *path;
> > +    int i, dev, num_devices;
> > +    uint32_t *devices;
> > +    DeviceState *ds =3D DEVICE(s);
> > +
> > +    path =3D g_strdup_printf("/chosen/opensbi-domains/%s", ds->id);
> > +    qemu_fdt_add_subnode(ms->fdt, path);
> > +    qemu_fdt_setprop_string(ms->fdt, path, "compatible",
> > +                            "opensbi,domain,memregion");
> > +    qemu_fdt_setprop_cells(ms->fdt, path, "base",
> > +                           (uint64_t) s->base >> 32, s->base);
> > +
> > +    qemu_fdt_setprop_cell(ms->fdt, path, "order",
> > +                          (uint32_t) s->order);
> > +
> > +    if (s->mmio) {
> > +        qemu_fdt_setprop(ms->fdt, path, "mmio", NULL, 0);
> > +
> > +        /* Get all phandles for related devices */
> > +        num_devices =3D 0;
> > +        for (i =3D 0; i < OPENSBI_MEMREGION_DEVICES_MAX; i++) {
> > +            if (s->devices[i]) {
> > +                num_devices++;
> > +            }
> > +        }
> > +
> > +        devices =3D g_malloc0_n(num_devices, sizeof(uint32_t));
> > +        for (i =3D 0, dev =3D 0; i < OPENSBI_MEMREGION_DEVICES_MAX; i+=
+) {
> > +            if (s->devices[i]) {
> > +                devices[dev++] =3D cpu_to_fdt32(
> > +                        qemu_fdt_get_phandle(ms->fdt, s->devices[i]));
> > +            }
> > +        }
> > +
> > +        qemu_fdt_setprop(ms->fdt, path, "devices", devices, num_device=
s
> * 4);
> > +        g_free(devices);
> > +    }
> > +
> > +    qemu_fdt_setprop_cells(ms->fdt, path, "phandle",
> > +                           qemu_fdt_alloc_phandle(ms->fdt));
> > +    g_free(path);
> > +}
> > +
> > +static int create_fdt_domains(Object *obj, void *opaque)
> > +{
> > +    struct DomainFDTState *dfs =3D opaque;
> > +    OpenSBIDomainState *osds;
> > +    OpenSBIMemregionState *osms;
> > +
> > +    osds =3D (OpenSBIDomainState *)
> > +            object_dynamic_cast(obj, TYPE_OPENSBI_DOMAIN);
> > +    osms =3D (OpenSBIMemregionState *)
> > +            object_dynamic_cast(obj, TYPE_OPENSBI_MEMREGION);
> > +
> > +    if (dfs->regions) {
> > +        if (osms) {
> > +            create_fdt_one_memregion(dfs->ms, osms);
> > +        }
> > +    } else {
> > +        if (osds) {
> > +            create_fdt_one_domain(dfs->ms, osds);
> > +        }
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static const char *containers[] =3D {
> > +        "/peripheral", "/peripheral-anon"
> > +};
> > +
> > +void create_fdt_opensbi_domains(MachineState *s)
> > +{
> > +    int i;
> > +    MachineState *ms =3D MACHINE(s);
> > +    Object *container;
> > +
> > +    struct DomainFDTState check =3D {
> > +            .ms =3D ms,
> > +            .regions =3D true
> > +    };
> > +
> > +    /* Make sure that top-level node exists */
> > +    qemu_fdt_add_subnode(ms->fdt, "/chosen/opensbi-domains");
> > +    qemu_fdt_setprop_string(ms->fdt, "/chosen/opensbi-domains",
> > +                            "compatible", "opensbi,domain,config");
> > +
> > +    /* Do a scan through regions first */
> > +    for (i =3D 0; i < ARRAY_SIZE(containers); i++) {
> > +        container =3D container_get(OBJECT(s), containers[i]);
> > +        object_child_foreach(container, create_fdt_domains, &check);
> > +    }
> > +
> > +    /* Then scan through domains */
> > +    check.regions =3D false;
> > +    for (i =3D 0; i < ARRAY_SIZE(containers); i++) {
> > +        container =3D container_get(OBJECT(s), containers[i]);
> > +        object_child_foreach(container, create_fdt_domains, &check);
> > +    }
> > +}
> > +
> > +/* OpenSBI Memregions */
> > +
> > +static void set_mmio(Object *obj, bool val, Error **err)
> > +{
> > +    OpenSBIMemregionState *s =3D OPENSBI_MEMREGION(obj);
> > +    s->mmio =3D val;
> > +}
> > +
> > +static void set_device(Object *obj, const char *val, Error **err)
> > +{
> > +    int i;
> > +    OpenSBIMemregionState *s =3D OPENSBI_MEMREGION(obj);
> > +
> > +    for (i =3D 0; i < OPENSBI_DOMAIN_MEMREGIONS_MAX; i++) {
> > +        if (!s->devices[i]) {
> > +            s->devices[i] =3D g_strdup(val);
> > +            break;
> > +        }
> > +    }
> > +}
> > +
> > +static void opensbi_memregion_instance_init(Object *obj)
> > +{
> > +    int i;
> > +    char *propname, *description;
> > +    OpenSBIMemregionState *s =3D OPENSBI_MEMREGION(obj);
> > +
> > +    object_property_add_uint64_ptr(obj, "base", &s->base,
> > +                                   OBJ_PROP_FLAG_WRITE);
> > +    object_property_set_description(obj, "base",
> > +                                    "The base address of the domain
> memory region. If \"order\" is also specified, "
> > +                                    "this property should be a 2 ^
> order aligned 64 bit address");
> > +
> > +    object_property_add_uint32_ptr(obj, "order", &s->order,
> > +                                   OBJ_PROP_FLAG_WRITE);
> > +    object_property_set_description(obj, "order",
> > +                                    "The order of the domain memory
> region. This property should have a 32 bit value "
> > +                                    "(i.e. one DT cell) in the range 3
> <=3D order <=3D __riscv_xlen.");
> > +
> > +    object_property_add_bool(obj, "mmio", NULL, set_mmio);
> > +    object_property_set_description(obj, "mmio",
> > +                                    "A boolean flag representing
> whether the domain memory region is a "
> > +                                    "memory-mapped I/O (MMIO) region."=
);
> > +
> > +    for (i =3D 0; i < OPENSBI_DOMAIN_MEMREGIONS_MAX; i++) {
> > +        propname =3D g_strdup_printf("device%i", i);
> > +        object_property_add_str(obj, propname, NULL, set_device);
> > +
> > +        description =3D g_strdup_printf(
> > +                "Device %i (out of %i) for this memregion. This
> property should be a device tree path to the device.",
> > +                i, OPENSBI_DOMAIN_MEMREGIONS_MAX);
> > +        object_property_set_description(obj, propname, description);
> > +        g_free(description);
> > +        g_free(propname);
> > +    }
> > +}
> > +
> > +static void opensbi_memregion_realize(DeviceState *ds, Error **errp)
> > +{
> > +    #if defined(TARGET_RISCV32)
> > +    int xlen =3D 32;
> > +    #elif defined(TARGET_RISCV64)
> > +    int xlen =3D 64;
> > +    #endif
> > +
> > +    OpenSBIMemregionState *s =3D OPENSBI_MEMREGION(ds);
> > +
> > +    if (!s->base) {
> > +        error_setg(errp, "Must specify base");
> > +        return;
> > +    }
> > +
> > +    /* Check order bounds */
> > +    if (s->order < 3) {
> > +        error_setg(errp, "Order too small");
> > +        return;
> > +    }
> > +
> > +    if (s->order > xlen) {
> > +        error_setg(errp, "Order too big");
> > +        return;
> > +    }
> > +
> > +    /* Check base alignment */
> > +    if (s->order < xlen && (s->base & (BIT(s->order) - 1))) {
> > +        error_setg(errp, "Base not aligned to order");
> > +        return;
> > +    }
> > +}
> > +
> > +static void opensbi_memregion_class_init(ObjectClass *oc, void *opaque=
)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> > +    dc->realize =3D opensbi_memregion_realize;
> > +}
> > +
> > +static const TypeInfo opensbi_memregion_info =3D {
> > +        .name =3D TYPE_OPENSBI_MEMREGION,
> > +        .parent =3D TYPE_DEVICE,
> > +        .instance_init =3D opensbi_memregion_instance_init,
> > +        .instance_size =3D sizeof(OpenSBIDomainState),
> > +        .class_init =3D opensbi_memregion_class_init
> > +};
> > +
> > +/* OpenSBI Domains */
> > +
> > +static void set_sysreset_allowed(Object *obj, bool val, Error **err)
> > +{
> > +    OpenSBIDomainState *s =3D OPENSBI_DOMAIN(obj);
> > +    s->system_reset_allowed =3D val;
> > +}
> > +
> > +static void set_suspend_allowed(Object *obj, bool val, Error **err)
> > +{
> > +    OpenSBIDomainState *s =3D OPENSBI_DOMAIN(obj);
> > +    s->system_suspend_allowed =3D val;
> > +}
> > +
> > +static void opensbi_domain_instance_init(Object *obj)
> > +{
> > +    int i;
> > +    char *propname, *description;
> > +    OpenSBIDomainState *s =3D OPENSBI_DOMAIN(obj);
> > +
> > +    object_property_add_uint32_ptr(obj, "boot-hart", &s->boot_hart,
> > +                                   OBJ_PROP_FLAG_WRITE);
> > +    object_property_set_description(obj, "boot-hart",
> > +                                    "The HART booting the domain
> instance.");
> > +
> > +    object_property_add_uint64_ptr(obj, "possible-harts",
> &s->possible_harts,
> > +                                   OBJ_PROP_FLAG_WRITE);
> > +    object_property_set_description(obj, "possible-harts",
> > +                                    "The list of CPUs for the domain
> instance, encoded as a bitmask");
> > +
> > +    object_property_add_uint64_ptr(obj, "next-arg1", &s->next_arg1,
> > +                                   OBJ_PROP_FLAG_WRITE);
> > +    object_property_set_description(obj, "next-arg1",
> > +                                    "The 64 bit next booting stage arg=
1
> for the domain instance.");
> > +
> > +    object_property_add_uint64_ptr(obj, "next-addr", &s->next_addr,
> > +                                   OBJ_PROP_FLAG_WRITE);
> > +    object_property_set_description(obj, "next-addr",
> > +                                    "The 64 bit next booting stage
> address for the domain instance.");
> > +
> > +    object_property_add_uint32_ptr(obj, "next-mode", &s->next_mode,
> > +                                   OBJ_PROP_FLAG_WRITE);
> > +    object_property_set_description(obj, "next-mode",
> > +                                    "The 32 bit next booting stage mod=
e
> for the domain instance.");
> > +
> > +    object_property_add_bool(obj, "system-reset-allowed", NULL,
> > +                             set_sysreset_allowed);
> > +    object_property_set_description(obj, "system-reset-allowed",
> > +                                    "Whether the domain instance is
> allowed to do system reset.");
> > +
> > +    object_property_add_bool(obj, "system-suspend-allowed", NULL,
> > +                             set_suspend_allowed);
> > +    object_property_set_description(obj, "system-suspend-allowed",
> > +                                    "Whether the domain instance is
> allowed to do system suspend.");
> > +
> > +    for (i =3D 0; i < OPENSBI_DOMAIN_MEMREGIONS_MAX; i++) {
> > +        propname =3D g_strdup_printf("region%i", i);
> > +        object_property_add_link(obj, propname, TYPE_OPENSBI_MEMREGION=
,
> > +                                 (Object **) &s->regions[i],
> > +
>  qdev_prop_allow_set_link_before_realize, 0);
> > +
> > +        description =3D g_strdup_printf(
> > +                "Region %i (out of %i) for this domain.",
> > +                i, OPENSBI_DOMAIN_MEMREGIONS_MAX);
> > +        object_property_set_description(obj, propname, description);
> > +        g_free(description);
> > +        g_free(propname);
> > +
> > +        propname =3D g_strdup_printf("perms%i", i);
> > +        description =3D g_strdup_printf(
> > +                "Permissions for region %i for this domain.", i);
> > +        object_property_add_uint32_ptr(obj, propname,
> &s->region_perms[i],
> > +                                       OBJ_PROP_FLAG_WRITE);
> > +        object_property_set_description(obj, propname, description);
> > +        g_free(description);
> > +        g_free(propname);
> > +    }
> > +}
> > +
> > +static void opensbi_domain_realize(DeviceState *ds, Error **errp)
> > +{
> > +    /* Nothing to do */
> > +}
> > +
> > +static void opensbi_domain_class_init(ObjectClass *oc, void *opaque)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> > +    dc->realize =3D opensbi_domain_realize;
> > +}
> > +
> > +static const TypeInfo opensbi_domain_info =3D {
> > +        .name =3D TYPE_OPENSBI_DOMAIN,
> > +        .parent =3D TYPE_DEVICE,
> > +        .instance_init =3D opensbi_domain_instance_init,
> > +        .instance_size =3D sizeof(OpenSBIDomainState),
> > +        .class_init =3D opensbi_domain_class_init
> > +};
> > +
> > +static void opensbi_register_types(void)
> > +{
> > +    type_register_static(&opensbi_domain_info);
> > +    type_register_static(&opensbi_memregion_info);
> > +}
> > +
> > +type_init(opensbi_register_types)
> > diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> > index f872674093..6189660014 100644
> > --- a/hw/riscv/meson.build
> > +++ b/hw/riscv/meson.build
> > @@ -1,6 +1,7 @@
> >   riscv_ss =3D ss.source_set()
> >   riscv_ss.add(files('boot.c'))
> >   riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
> > +riscv_ss.add(when: 'CONFIG_RISCV_DOMAIN', if_true: files('domain.c'))
> >   riscv_ss.add(files('riscv_hart.c'))
> >   riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
> >   riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index 9981e0f6c9..49e72b793b 100644
> > --- a/hw/riscv/virt.c
> > +++ b/hw/riscv/virt.c
> > @@ -55,6 +55,7 @@
> >   #include "hw/acpi/aml-build.h"
> >   #include "qapi/qapi-visit-common.h"
> >   #include "hw/virtio/virtio-iommu.h"
> > +#include "hw/riscv/domain.h"
> >
> >   /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by
> QEMU. */
> >   static bool virt_use_kvm_aia(RISCVVirtState *s)
> > @@ -1051,6 +1052,8 @@ static void finalize_fdt(RISCVVirtState *s)
> >       create_fdt_uart(s, virt_memmap, irq_mmio_phandle);
> >
> >       create_fdt_rtc(s, virt_memmap, irq_mmio_phandle);
> > +
> > +    create_fdt_opensbi_domains(ms);
> >   }
> >
> >   static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
> > diff --git a/include/hw/riscv/domain.h b/include/hw/riscv/domain.h
> > new file mode 100644
> > index 0000000000..95c0382d23
> > --- /dev/null
> > +++ b/include/hw/riscv/domain.h
> > @@ -0,0 +1,49 @@
> > +
> > +#ifndef RISCV_DOMAIN_H
> > +#define RISCV_DOMAIN_H
> > +
> > +#include "hw/sysbus.h"
> > +#include "qom/object.h"
> > +#include "cpu.h"
> > +
> > +#define TYPE_OPENSBI_MEMREGION "opensbi-memregion"
> > +OBJECT_DECLARE_SIMPLE_TYPE(OpenSBIMemregionState, OPENSBI_MEMREGION)
> > +
> > +#define OPENSBI_MEMREGION_DEVICES_MAX   16
> > +
> > +struct OpenSBIMemregionState {
> > +    /* public */
> > +    DeviceState parent_obj;
> > +
> > +    /* private */
> > +    uint64_t base;
> > +    uint32_t order;
> > +    bool mmio;
> > +    char *devices[OPENSBI_MEMREGION_DEVICES_MAX];
> > +};
> > +
> > +#define TYPE_OPENSBI_DOMAIN "opensbi-domain"
> > +OBJECT_DECLARE_SIMPLE_TYPE(OpenSBIDomainState, OPENSBI_DOMAIN)
> > +
> > +#define OPENSBI_DOMAIN_MEMREGIONS_MAX   16
> > +
> > +struct OpenSBIDomainState {
> > +    /* public */
> > +    DeviceState parent_obj;
> > +
> > +    /* private */
> > +    OpenSBIMemregionState *regions[OPENSBI_DOMAIN_MEMREGIONS_MAX];
> > +    unsigned int region_perms[OPENSBI_DOMAIN_MEMREGIONS_MAX];
> > +
> > +    unsigned long possible_harts;
> > +    unsigned int boot_hart;
> > +    uint64_t next_arg1;
> > +    uint64_t next_addr;
> > +    uint32_t next_mode;
> > +    bool system_reset_allowed;
> > +    bool system_suspend_allowed;
> > +};
> > +
> > +void create_fdt_opensbi_domains(MachineState *s);
> > +
> > +#endif /* RISCV_DOMAIN_H */
>

--000000000000e5707d061e2ac46b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Daniel,<br><br>Oops! Sorry about the build failure - sl=
ightly embarrassing on my part!<br><div><br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><div><div class=3D"gmail-im">&gt; +RISC-V OpenSBI =
domain support<br>
&gt; +M: Gregor Haas &lt;<a href=3D"mailto:gregorhaas1997@gmail.com" target=
=3D"_blank">gregorhaas1997@gmail.com</a>&gt;<br>
&gt; +L: <a href=3D"mailto:qemu-riscv@nongnu.org" target=3D"_blank">qemu-ri=
scv@nongnu.org</a><br>
&gt; +S: Maintained<br>
&gt; +F: hw/riscv/domain.c<br>
&gt; +F: include/hw/riscv/domain.h<br>
<br></div></div>
I suggest &#39;opensbi_domain.c&#39; and &#39;opensbi_domain.h&#39; as file=
 names to be clearer<br>
about what the file contents is about.</blockquote><div><br></div><div>Agre=
ed!</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div><div class=3D"gmail-im">&gt; +static void create_fdt_domain_possible_ha=
rts(MachineState *ms,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0OpenSBIDomainState *s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0char *path) {<br>
&gt; +=C2=A0 =C2=A0 unsigned long i, cpu;<br>
&gt; +=C2=A0 =C2=A0 int num_cpus;<br>
&gt; +=C2=A0 =C2=A0 uint32_t *phandles;<br>
&gt; +=C2=A0 =C2=A0 char *cpu_name;<br>
<br></div></div>
For these variables I recommend using g_autofree to avoid the need for g_fr=
ee()<br>
calls. This will call g_free() automatically when the variable scope ends. =
It<br>
also help to avoid mem leaks when moving code around and leaving a g_free()=
 behind<br>
by accident.</blockquote><div><br></div><div>Also agreed! I was unsure the =
best way to use g_autofree for the variables which I</div><div>allocate mul=
tiple times (such as cpu_name). I was not sure if g_autofree would free</di=
v><div>pointers that were overwritten with a new allocation, so I handled t=
his manually. However,</div><div>I really like your solution of declaring t=
hese variables in the body of the loop itself. I&#39;ll</div><div>make thes=
e changes in a PATCH v2 shorty.</div><div><br></div><div>Thanks for the rev=
iew,</div><div>Gregor<br></div></div><br><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 26, 2024 at 10:46=E2=80=AFAM=
 Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@ventanamicro.com">d=
barboza@ventanamicro.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">Hi Gregor,<br>
<br>
<br>
This patch doesn&#39;t build in my env. Here&#39;s the error:<br>
<br>
./hw/riscv/virt.c<br>
../hw/riscv/virt.c: In function =E2=80=98finalize_fdt=E2=80=99:<br>
../hw/riscv/virt.c:1056:32: error: =E2=80=98ms=E2=80=99 undeclared (first u=
se in this function); did you mean =E2=80=98s=E2=80=99?<br>
=C2=A0 1056 |=C2=A0 =C2=A0 =C2=A0create_fdt_opensbi_domains(ms);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~<br>
<br>
<br>
I believe that at that point you&#39;ll want to use MACHINE(s) instead of<b=
r>
&#39;ms&#39;.<br>
<br>
Other comments below:<br>
<br>
On 7/25/24 9:14 PM, Gregor Haas wrote:<br>
&gt; OpenSBI has support for domains, which are partitions of CPUs and memo=
ry into<br>
&gt; isolated compartments. Domains can be specified in the device tree acc=
ording to<br>
&gt; a standardized format [1], which OpenSBI parses at boot time to initia=
lize all<br>
&gt; system domains. This patch enables simply specifying domains (and thei=
r<br>
&gt; associated memory regions) on the QEMU command line, from which these =
are then<br>
&gt; rendered into the machine&#39;s device tree. A simple example of what =
this looks<br>
&gt; like is below:<br>
&gt; <br>
&gt; qemu-system-riscv64 -machine virt -bios fw_jump.bin -cpu max -smp 2 -m=
 4G \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-device opensbi-memregion,id=3Dmem,base=3D0x=
178000000,size=3D0x4000000,mmio=3Dfalse \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-device opensbi-domain,possible-harts=3D0x2,=
boot-hart=3D0x1,next-addr=3D0x178000000,next-mode=3D1,region0=3Dmem,perms0=
=3D0x3f<br>
&gt; <br>
&gt; At machine initialization time, a new create_fdt_opensbi_domains() fun=
ction<br>
&gt; walks the peripherals/peripherals-anon containers, identifies all doma=
ins and<br>
&gt; memregions, and parses them into the relevant device tree structures.<=
br>
&gt; <br>
&gt; [1] <a href=3D"https://github.com/riscv-software-src/opensbi/blob/mast=
er/docs/domain_support.md" rel=3D"noreferrer" target=3D"_blank">https://git=
hub.com/riscv-software-src/opensbi/blob/master/docs/domain_support.md</a><b=
r>
&gt; <br>
&gt; Signed-off-by: Gregor Haas &lt;<a href=3D"mailto:gregorhaas1997@gmail.=
com" target=3D"_blank">gregorhaas1997@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0hw/riscv/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 =C2=A04 +<br>
&gt;=C2=A0 =C2=A0hw/riscv/domain.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 435 +=
+++++++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/riscv/meson.build=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +=
<br>
&gt;=C2=A0 =C2=A0hw/riscv/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 =C2=A0include/hw/riscv/domain.h |=C2=A0 49 +++++<br>
&gt;=C2=A0 =C2=A06 files changed, 499 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/riscv/domain.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/riscv/domain.h<br>
&gt; <br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index 98eddf7ae1..85ad6e0227 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -355,6 +355,13 @@ F: target/riscv/XVentanaCondOps.decode<br>
&gt;=C2=A0 =C2=A0F: target/riscv/insn_trans/trans_xventanacondops.c.inc<br>
&gt;=C2=A0 =C2=A0F: disas/riscv-xventana*<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +RISC-V OpenSBI domain support<br>
&gt; +M: Gregor Haas &lt;<a href=3D"mailto:gregorhaas1997@gmail.com" target=
=3D"_blank">gregorhaas1997@gmail.com</a>&gt;<br>
&gt; +L: <a href=3D"mailto:qemu-riscv@nongnu.org" target=3D"_blank">qemu-ri=
scv@nongnu.org</a><br>
&gt; +S: Maintained<br>
&gt; +F: hw/riscv/domain.c<br>
&gt; +F: include/hw/riscv/domain.h<br>
<br>
I suggest &#39;opensbi_domain.c&#39; and &#39;opensbi_domain.h&#39; as file=
 names to be clearer<br>
about what the file contents is about.<br>
<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0RENESAS RX CPUs<br>
&gt;=C2=A0 =C2=A0R: Yoshinori Sato &lt;<a href=3D"mailto:ysato@users.source=
forge.jp" target=3D"_blank">ysato@users.sourceforge.jp</a>&gt;<br>
&gt;=C2=A0 =C2=A0S: Orphan<br>
&gt; diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig<br>
&gt; index a2030e3a6f..14a3a7d09e 100644<br>
&gt; --- a/hw/riscv/Kconfig<br>
&gt; +++ b/hw/riscv/Kconfig<br>
&gt; @@ -1,6 +1,9 @@<br>
&gt;=C2=A0 =C2=A0config RISCV_NUMA<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +config RISCV_DOMAIN<br>
&gt; +=C2=A0 =C2=A0 bool<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0config IBEX<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -40,6 +43,7 @@ config RISCV_VIRT<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0imply TPM_TIS_SYSBUS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select DEVICE_TREE<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select RISCV_NUMA<br>
&gt; +=C2=A0 =C2=A0 select RISCV_DOMAIN<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select GOLDFISH_RTC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select PCI<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select PCI_EXPRESS_GENERIC_BRIDGE<br>
&gt; diff --git a/hw/riscv/domain.c b/hw/riscv/domain.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..11b3aff453<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/riscv/domain.c<br>
&gt; @@ -0,0 +1,435 @@<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;hw/riscv/domain.h&quot;<br>
&gt; +#include &quot;hw/boards.h&quot;<br>
&gt; +#include &quot;sysemu/device_tree.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +<br>
&gt; +#include &lt;libfdt.h&gt;<br>
&gt; +<br>
&gt; +static void create_fdt_domain_possible_harts(MachineState *ms,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0OpenSBIDomainState *s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0char *path) {<br>
&gt; +=C2=A0 =C2=A0 unsigned long i, cpu;<br>
&gt; +=C2=A0 =C2=A0 int num_cpus;<br>
&gt; +=C2=A0 =C2=A0 uint32_t *phandles;<br>
&gt; +=C2=A0 =C2=A0 char *cpu_name;<br>
<br>
For these variables I recommend using g_autofree to avoid the need for g_fr=
ee()<br>
calls. This will call g_free() automatically when the variable scope ends. =
It<br>
also help to avoid mem leaks when moving code around and leaving a g_free()=
 behind<br>
by accident.<br>
<br>
For example:<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 num_cpus =3D ctpop64(s-&gt;possible_harts);<br>
&gt; +=C2=A0 =C2=A0 if (num_cpus) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 phandles =3D g_malloc0_n(num_cpus, sizeof=
(uint32_t));<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_autofree uint32_t *phandles =3D=
=C2=A0 g_malloc0_n(num_cpus, sizeof(uint32_t));<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0, cpu =3D -1; i &lt; num_cpus=
; i++) {<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu =3D find_next_bit(&amp;=
s-&gt;possible_harts, BITS_PER_LONG, cpu + 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *cp=
u_name =3D find_next_bit(&amp;s-&gt;possible_harts, BITS_PER_LONG, cpu + 1)=
;<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_name =3D g_strdup_print=
f(&quot;/cpus/cpu@%li&quot;, cpu);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 phandles[i++] =3D cpu_to_fd=
t32(qemu_fdt_get_phandle(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 ms-&gt;fdt, cpu_name));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(cpu_name);<br>
<br>
Remove this g_free().<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_setprop(ms-&gt;fdt, path, &quot;=
possible-harts&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0phandles, num_cpus * 4);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(phandles);<br>
<br>
Remove this g_free().<br>
<br>
<br>
This &#39;g_autofree&#39; usage can be applied to most functions in the pat=
ch.<br>
<br>
<br>
Thanks,<br>
<br>
Daniel<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void create_fdt_domain_regions(MachineState *ms,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OpenSBIDoma=
inState *s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *path)=
 {<br>
&gt; +=C2=A0 =C2=A0 unsigned long i;<br>
&gt; +=C2=A0 =C2=A0 int num_regions =3D 0;<br>
&gt; +=C2=A0 =C2=A0 uint32_t *regions;<br>
&gt; +=C2=A0 =C2=A0 char *region_name;<br>
&gt; +=C2=A0 =C2=A0 DeviceState *ds;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; OPENSBI_DOMAIN_MEMREGIONS_MAX; i++=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;regions[i]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 num_regions++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (num_regions) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 regions =3D g_malloc0_n(num_regions, 2 * =
sizeof(uint32_t));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; OPENSBI_DOMAIN_MEMRE=
GIONS_MAX; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;regions[i]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ds =3D DEVICE=
(s-&gt;regions[i]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 region_name =
=3D g_strdup_printf(&quot;/chosen/opensbi-domains/%s&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ds-&gt;id);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regions[2 * i=
] =3D cpu_to_fdt32(qemu_fdt_get_phandle<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 (ms-&gt;fdt, region_name));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regions[2 * i=
 + 1] =3D cpu_to_fdt32(s-&gt;region_perms[i]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(region=
_name);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_setprop(ms-&gt;fdt, path, &quot;=
regions&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0regions, num_regions * 8);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(regions);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +struct DomainFDTState {<br>
&gt; +=C2=A0 =C2=A0 MachineState *ms;<br>
&gt; +=C2=A0 =C2=A0 bool regions;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void create_fdt_one_domain(MachineState *ms, OpenSBIDomainStat=
e *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceState *ds =3D DEVICE(s);<br>
&gt; +=C2=A0 =C2=A0 char *path, *cpu_name;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (ds-&gt;id) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D g_strdup_printf(&quot;/chosen/op=
ensbi-domains/%s&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ds-&gt;id);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 path =3D g_strdup_printf(&quot;/chosen/op=
ensbi-domains/domain@%lx&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;next_addr);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_fdt_add_subnode(ms-&gt;fdt, path);<br>
&gt; +=C2=A0 =C2=A0 qemu_fdt_setprop_string(ms-&gt;fdt, path, &quot;compati=
ble&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;opensbi,domain,instance&quot;);<br>
&gt; +=C2=A0 =C2=A0 qemu_fdt_setprop_cells(ms-&gt;fdt, path, &quot;phandle&=
quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_fdt_alloc_phandle(ms-&gt;fdt));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 create_fdt_domain_possible_harts(ms, s, path);<br>
&gt; +=C2=A0 =C2=A0 create_fdt_domain_regions(ms, s, path);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Assign boot hart to this domain */<br>
&gt; +=C2=A0 =C2=A0 cpu_name =3D g_strdup_printf(&quot;/cpus/cpu@%i&quot;, =
s-&gt;boot_hart);<br>
&gt; +=C2=A0 =C2=A0 qemu_fdt_setprop_cell(ms-&gt;fdt, path, &quot;boot-hart=
&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_get_phandle(ms-&gt;fdt, cpu_name));<br>
&gt; +=C2=A0 =C2=A0 qemu_fdt_setprop_cell(ms-&gt;fdt, cpu_name, &quot;opens=
bi-domain&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_get_phandle(ms-&gt;fdt, path));<br>
&gt; +=C2=A0 =C2=A0 g_free(cpu_name);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_fdt_setprop_cells(ms-&gt;fdt, path, &quot;next-arg=
1&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t) s-&gt;next_arg1 &gt;&gt; 32, s-&gt;n=
ext_arg1);<br>
&gt; +=C2=A0 =C2=A0 qemu_fdt_setprop_cells(ms-&gt;fdt, path, &quot;next-add=
r&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t) s-&gt;next_addr &gt;&gt; 32, s-&gt;n=
ext_addr);<br>
&gt; +=C2=A0 =C2=A0 qemu_fdt_setprop_cell(ms-&gt;fdt, path, &quot;next-mode=
&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 s-&gt;next_mode);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;system_reset_allowed) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_setprop(ms-&gt;fdt, path, &quot;=
system-reset-allowed&quot;, NULL, 0);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;system_suspend_allowed) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_setprop(ms-&gt;fdt, path, &quot;=
system-suspend-allowed&quot;, NULL, 0);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 g_free(path);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void create_fdt_one_memregion(MachineState *ms,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OpenSBIMemre=
gionState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 char *path;<br>
&gt; +=C2=A0 =C2=A0 int i, dev, num_devices;<br>
&gt; +=C2=A0 =C2=A0 uint32_t *devices;<br>
&gt; +=C2=A0 =C2=A0 DeviceState *ds =3D DEVICE(s);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 path =3D g_strdup_printf(&quot;/chosen/opensbi-domains/=
%s&quot;, ds-&gt;id);<br>
&gt; +=C2=A0 =C2=A0 qemu_fdt_add_subnode(ms-&gt;fdt, path);<br>
&gt; +=C2=A0 =C2=A0 qemu_fdt_setprop_string(ms-&gt;fdt, path, &quot;compati=
ble&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;opensbi,domain,memregion&quot;);<br>
&gt; +=C2=A0 =C2=A0 qemu_fdt_setprop_cells(ms-&gt;fdt, path, &quot;base&quo=
t;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t) s-&gt;base &gt;&gt; 32, s-&gt;base);=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_fdt_setprop_cell(ms-&gt;fdt, path, &quot;order&quo=
t;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 (uint32_t) s-&gt;order);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;mmio) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_setprop(ms-&gt;fdt, path, &quot;=
mmio&quot;, NULL, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Get all phandles for related devices *=
/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 num_devices =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; OPENSBI_MEMREGION_DE=
VICES_MAX; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;devices[i]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 num_devices++=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 devices =3D g_malloc0_n(num_devices, size=
of(uint32_t));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0, dev =3D 0; i &lt; OPENSBI_M=
EMREGION_DEVICES_MAX; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;devices[i]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devices[dev++=
] =3D cpu_to_fdt32(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 qemu_fdt_get_phandle(ms-&gt;fdt, s-&gt;devices[i]));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_setprop(ms-&gt;fdt, path, &quot;=
devices&quot;, devices, num_devices * 4);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(devices);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_fdt_setprop_cells(ms-&gt;fdt, path, &quot;phandle&=
quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_fdt_alloc_phandle(ms-&gt;fdt));<br>
&gt; +=C2=A0 =C2=A0 g_free(path);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int create_fdt_domains(Object *obj, void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct DomainFDTState *dfs =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 OpenSBIDomainState *osds;<br>
&gt; +=C2=A0 =C2=A0 OpenSBIMemregionState *osms;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 osds =3D (OpenSBIDomainState *)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 object_dynamic_cast(obj, TY=
PE_OPENSBI_DOMAIN);<br>
&gt; +=C2=A0 =C2=A0 osms =3D (OpenSBIMemregionState *)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 object_dynamic_cast(obj, TY=
PE_OPENSBI_MEMREGION);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (dfs-&gt;regions) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (osms) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 create_fdt_one_memregion(df=
s-&gt;ms, osms);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (osds) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 create_fdt_one_domain(dfs-&=
gt;ms, osds);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const char *containers[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;/peripheral&quot;, &quot;/periphera=
l-anon&quot;<br>
&gt; +};<br>
&gt; +<br>
&gt; +void create_fdt_opensbi_domains(MachineState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +=C2=A0 =C2=A0 MachineState *ms =3D MACHINE(s);<br>
&gt; +=C2=A0 =C2=A0 Object *container;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 struct DomainFDTState check =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .ms =3D ms,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .regions =3D true<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Make sure that top-level node exists */<br>
&gt; +=C2=A0 =C2=A0 qemu_fdt_add_subnode(ms-&gt;fdt, &quot;/chosen/opensbi-=
domains&quot;);<br>
&gt; +=C2=A0 =C2=A0 qemu_fdt_setprop_string(ms-&gt;fdt, &quot;/chosen/opens=
bi-domains&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;compatible&quot;, &quot;opensbi,domain,c=
onfig&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Do a scan through regions first */<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(containers); i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 container =3D container_get(OBJECT(s), co=
ntainers[i]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_child_foreach(container, create_fd=
t_domains, &amp;check);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Then scan through domains */<br>
&gt; +=C2=A0 =C2=A0 check.regions =3D false;<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(containers); i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 container =3D container_get(OBJECT(s), co=
ntainers[i]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_child_foreach(container, create_fd=
t_domains, &amp;check);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* OpenSBI Memregions */<br>
&gt; +<br>
&gt; +static void set_mmio(Object *obj, bool val, Error **err)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 OpenSBIMemregionState *s =3D OPENSBI_MEMREGION(obj);<br=
>
&gt; +=C2=A0 =C2=A0 s-&gt;mmio =3D val;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void set_device(Object *obj, const char *val, Error **err)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +=C2=A0 =C2=A0 OpenSBIMemregionState *s =3D OPENSBI_MEMREGION(obj);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; OPENSBI_DOMAIN_MEMREGIONS_MAX; i++=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!s-&gt;devices[i]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;devices[i] =3D g_strd=
up(val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void opensbi_memregion_instance_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +=C2=A0 =C2=A0 char *propname, *description;<br>
&gt; +=C2=A0 =C2=A0 OpenSBIMemregionState *s =3D OPENSBI_MEMREGION(obj);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 object_property_add_uint64_ptr(obj, &quot;base&quot;, &=
amp;s-&gt;base,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OBJ_PROP_FLAG_WRITE=
);<br>
&gt; +=C2=A0 =C2=A0 object_property_set_description(obj, &quot;base&quot;,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;The base add=
ress of the domain memory region. If \&quot;order\&quot; is also specified,=
 &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;this propert=
y should be a 2 ^ order aligned 64 bit address&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 object_property_add_uint32_ptr(obj, &quot;order&quot;, =
&amp;s-&gt;order,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OBJ_PROP_FLAG_WRITE=
);<br>
&gt; +=C2=A0 =C2=A0 object_property_set_description(obj, &quot;order&quot;,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;The order of=
 the domain memory region. This property should have a 32 bit value &quot;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;(i.e. one DT=
 cell) in the range 3 &lt;=3D order &lt;=3D __riscv_xlen.&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 object_property_add_bool(obj, &quot;mmio&quot;, NULL, s=
et_mmio);<br>
&gt; +=C2=A0 =C2=A0 object_property_set_description(obj, &quot;mmio&quot;,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;A boolean fl=
ag representing whether the domain memory region is a &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;memory-mappe=
d I/O (MMIO) region.&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; OPENSBI_DOMAIN_MEMREGIONS_MAX; i++=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 propname =3D g_strdup_printf(&quot;device=
%i&quot;, i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_add_str(obj, propname, NU=
LL, set_device);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 description =3D g_strdup_printf(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Device =
%i (out of %i) for this memregion. This property should be a device tree pa=
th to the device.&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i, OPENSBI_DO=
MAIN_MEMREGIONS_MAX);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_description(obj, prop=
name, description);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(description);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(propname);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void opensbi_memregion_realize(DeviceState *ds, Error **errp)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 #if defined(TARGET_RISCV32)<br>
&gt; +=C2=A0 =C2=A0 int xlen =3D 32;<br>
&gt; +=C2=A0 =C2=A0 #elif defined(TARGET_RISCV64)<br>
&gt; +=C2=A0 =C2=A0 int xlen =3D 64;<br>
&gt; +=C2=A0 =C2=A0 #endif<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 OpenSBIMemregionState *s =3D OPENSBI_MEMREGION(ds);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!s-&gt;base) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Must specify base&=
quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Check order bounds */<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;order &lt; 3) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Order too small&qu=
ot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;order &gt; xlen) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Order too big&quot=
;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Check base alignment */<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;order &lt; xlen &amp;&amp; (s-&gt;base &amp; =
(BIT(s-&gt;order) - 1))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Base not aligned t=
o order&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void opensbi_memregion_class_init(ObjectClass *oc, void *opaqu=
e)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(oc);<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;realize =3D opensbi_memregion_realize;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo opensbi_memregion_info =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D TYPE_OPENSBI_MEMREGION,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent =3D TYPE_DEVICE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_init =3D opensbi_memregion_inst=
ance_init,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_size =3D sizeof(OpenSBIDomainSt=
ate),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init =3D opensbi_memregion_class_i=
nit<br>
&gt; +};<br>
&gt; +<br>
&gt; +/* OpenSBI Domains */<br>
&gt; +<br>
&gt; +static void set_sysreset_allowed(Object *obj, bool val, Error **err)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 OpenSBIDomainState *s =3D OPENSBI_DOMAIN(obj);<br>
&gt; +=C2=A0 =C2=A0 s-&gt;system_reset_allowed =3D val;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void set_suspend_allowed(Object *obj, bool val, Error **err)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 OpenSBIDomainState *s =3D OPENSBI_DOMAIN(obj);<br>
&gt; +=C2=A0 =C2=A0 s-&gt;system_suspend_allowed =3D val;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void opensbi_domain_instance_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +=C2=A0 =C2=A0 char *propname, *description;<br>
&gt; +=C2=A0 =C2=A0 OpenSBIDomainState *s =3D OPENSBI_DOMAIN(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 object_property_add_uint32_ptr(obj, &quot;boot-hart&quo=
t;, &amp;s-&gt;boot_hart,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OBJ_PROP_FLAG_WRITE=
);<br>
&gt; +=C2=A0 =C2=A0 object_property_set_description(obj, &quot;boot-hart&qu=
ot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;The HART boo=
ting the domain instance.&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 object_property_add_uint64_ptr(obj, &quot;possible-hart=
s&quot;, &amp;s-&gt;possible_harts,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OBJ_PROP_FLAG_WRITE=
);<br>
&gt; +=C2=A0 =C2=A0 object_property_set_description(obj, &quot;possible-har=
ts&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;The list of =
CPUs for the domain instance, encoded as a bitmask&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 object_property_add_uint64_ptr(obj, &quot;next-arg1&quo=
t;, &amp;s-&gt;next_arg1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OBJ_PROP_FLAG_WRITE=
);<br>
&gt; +=C2=A0 =C2=A0 object_property_set_description(obj, &quot;next-arg1&qu=
ot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;The 64 bit n=
ext booting stage arg1 for the domain instance.&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 object_property_add_uint64_ptr(obj, &quot;next-addr&quo=
t;, &amp;s-&gt;next_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OBJ_PROP_FLAG_WRITE=
);<br>
&gt; +=C2=A0 =C2=A0 object_property_set_description(obj, &quot;next-addr&qu=
ot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;The 64 bit n=
ext booting stage address for the domain instance.&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 object_property_add_uint32_ptr(obj, &quot;next-mode&quo=
t;, &amp;s-&gt;next_mode,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OBJ_PROP_FLAG_WRITE=
);<br>
&gt; +=C2=A0 =C2=A0 object_property_set_description(obj, &quot;next-mode&qu=
ot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;The 32 bit n=
ext booting stage mode for the domain instance.&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 object_property_add_bool(obj, &quot;system-reset-allowe=
d&quot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_sysreset_allowed);<br>
&gt; +=C2=A0 =C2=A0 object_property_set_description(obj, &quot;system-reset=
-allowed&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Whether the =
domain instance is allowed to do system reset.&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 object_property_add_bool(obj, &quot;system-suspend-allo=
wed&quot;, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_suspend_allowed);<br>
&gt; +=C2=A0 =C2=A0 object_property_set_description(obj, &quot;system-suspe=
nd-allowed&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Whether the =
domain instance is allowed to do system suspend.&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; OPENSBI_DOMAIN_MEMREGIONS_MAX; i++=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 propname =3D g_strdup_printf(&quot;region=
%i&quot;, i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_add_link(obj, propname, T=
YPE_OPENSBI_MEMREGION,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(Object **) &amp;s-&gt;reg=
ions[i],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_prop_allow_set_link_b=
efore_realize, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 description =3D g_strdup_printf(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Region =
%i (out of %i) for this domain.&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i, OPENSBI_DO=
MAIN_MEMREGIONS_MAX);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_description(obj, prop=
name, description);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(description);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(propname);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 propname =3D g_strdup_printf(&quot;perms%=
i&quot;, i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 description =3D g_strdup_printf(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Permiss=
ions for region %i for this domain.&quot;, i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_add_uint32_ptr(obj, propn=
ame, &amp;s-&gt;region_perms[i],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OBJ_P=
ROP_FLAG_WRITE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_description(obj, prop=
name, description);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(description);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(propname);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void opensbi_domain_realize(DeviceState *ds, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /* Nothing to do */<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void opensbi_domain_class_init(ObjectClass *oc, void *opaque)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(oc);<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;realize =3D opensbi_domain_realize;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo opensbi_domain_info =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D TYPE_OPENSBI_DOMAIN,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent =3D TYPE_DEVICE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_init =3D opensbi_domain_instanc=
e_init,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_size =3D sizeof(OpenSBIDomainSt=
ate),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init =3D opensbi_domain_class_init=
<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void opensbi_register_types(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;opensbi_domain_info);<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;opensbi_memregion_info);<br>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(opensbi_register_types)<br>
&gt; diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build<br>
&gt; index f872674093..6189660014 100644<br>
&gt; --- a/hw/riscv/meson.build<br>
&gt; +++ b/hw/riscv/meson.build<br>
&gt; @@ -1,6 +1,7 @@<br>
&gt;=C2=A0 =C2=A0riscv_ss =3D ss.source_set()<br>
&gt;=C2=A0 =C2=A0riscv_ss.add(files(&#39;boot.c&#39;))<br>
&gt;=C2=A0 =C2=A0riscv_ss.add(when: &#39;CONFIG_RISCV_NUMA&#39;, if_true: f=
iles(&#39;numa.c&#39;))<br>
&gt; +riscv_ss.add(when: &#39;CONFIG_RISCV_DOMAIN&#39;, if_true: files(&#39=
;domain.c&#39;))<br>
&gt;=C2=A0 =C2=A0riscv_ss.add(files(&#39;riscv_hart.c&#39;))<br>
&gt;=C2=A0 =C2=A0riscv_ss.add(when: &#39;CONFIG_OPENTITAN&#39;, if_true: fi=
les(&#39;opentitan.c&#39;))<br>
&gt;=C2=A0 =C2=A0riscv_ss.add(when: &#39;CONFIG_RISCV_VIRT&#39;, if_true: f=
iles(&#39;virt.c&#39;))<br>
&gt; diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c<br>
&gt; index 9981e0f6c9..49e72b793b 100644<br>
&gt; --- a/hw/riscv/virt.c<br>
&gt; +++ b/hw/riscv/virt.c<br>
&gt; @@ -55,6 +55,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/acpi/aml-build.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;qapi/qapi-visit-common.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/virtio/virtio-iommu.h&quot;<br>
&gt; +#include &quot;hw/riscv/domain.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/* KVM AIA only supports APLIC MSI. APLIC Wired is always =
emulated by QEMU. */<br>
&gt;=C2=A0 =C2=A0static bool virt_use_kvm_aia(RISCVVirtState *s)<br>
&gt; @@ -1051,6 +1052,8 @@ static void finalize_fdt(RISCVVirtState *s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create_fdt_uart(s, virt_memmap, irq_mmio_pha=
ndle);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create_fdt_rtc(s, virt_memmap, irq_mmio_phan=
dle);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 create_fdt_opensbi_domains(ms);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void create_fdt(RISCVVirtState *s, const MemMapEntr=
y *memmap)<br>
&gt; diff --git a/include/hw/riscv/domain.h b/include/hw/riscv/domain.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..95c0382d23<br>
&gt; --- /dev/null<br>
&gt; +++ b/include/hw/riscv/domain.h<br>
&gt; @@ -0,0 +1,49 @@<br>
&gt; +<br>
&gt; +#ifndef RISCV_DOMAIN_H<br>
&gt; +#define RISCV_DOMAIN_H<br>
&gt; +<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +#include &quot;qom/object.h&quot;<br>
&gt; +#include &quot;cpu.h&quot;<br>
&gt; +<br>
&gt; +#define TYPE_OPENSBI_MEMREGION &quot;opensbi-memregion&quot;<br>
&gt; +OBJECT_DECLARE_SIMPLE_TYPE(OpenSBIMemregionState, OPENSBI_MEMREGION)<=
br>
&gt; +<br>
&gt; +#define OPENSBI_MEMREGION_DEVICES_MAX=C2=A0 =C2=A016<br>
&gt; +<br>
&gt; +struct OpenSBIMemregionState {<br>
&gt; +=C2=A0 =C2=A0 /* public */<br>
&gt; +=C2=A0 =C2=A0 DeviceState parent_obj;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* private */<br>
&gt; +=C2=A0 =C2=A0 uint64_t base;<br>
&gt; +=C2=A0 =C2=A0 uint32_t order;<br>
&gt; +=C2=A0 =C2=A0 bool mmio;<br>
&gt; +=C2=A0 =C2=A0 char *devices[OPENSBI_MEMREGION_DEVICES_MAX];<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define TYPE_OPENSBI_DOMAIN &quot;opensbi-domain&quot;<br>
&gt; +OBJECT_DECLARE_SIMPLE_TYPE(OpenSBIDomainState, OPENSBI_DOMAIN)<br>
&gt; +<br>
&gt; +#define OPENSBI_DOMAIN_MEMREGIONS_MAX=C2=A0 =C2=A016<br>
&gt; +<br>
&gt; +struct OpenSBIDomainState {<br>
&gt; +=C2=A0 =C2=A0 /* public */<br>
&gt; +=C2=A0 =C2=A0 DeviceState parent_obj;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* private */<br>
&gt; +=C2=A0 =C2=A0 OpenSBIMemregionState *regions[OPENSBI_DOMAIN_MEMREGION=
S_MAX];<br>
&gt; +=C2=A0 =C2=A0 unsigned int region_perms[OPENSBI_DOMAIN_MEMREGIONS_MAX=
];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 unsigned long possible_harts;<br>
&gt; +=C2=A0 =C2=A0 unsigned int boot_hart;<br>
&gt; +=C2=A0 =C2=A0 uint64_t next_arg1;<br>
&gt; +=C2=A0 =C2=A0 uint64_t next_addr;<br>
&gt; +=C2=A0 =C2=A0 uint32_t next_mode;<br>
&gt; +=C2=A0 =C2=A0 bool system_reset_allowed;<br>
&gt; +=C2=A0 =C2=A0 bool system_suspend_allowed;<br>
&gt; +};<br>
&gt; +<br>
&gt; +void create_fdt_opensbi_domains(MachineState *s);<br>
&gt; +<br>
&gt; +#endif /* RISCV_DOMAIN_H */<br>
</blockquote></div>

--000000000000e5707d061e2ac46b--

