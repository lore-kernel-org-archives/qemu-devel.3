Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1F1C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 20:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb47j-00084N-HF; Mon, 05 Aug 2024 16:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1sb47i-00083O-2S; Mon, 05 Aug 2024 16:16:06 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1sb47b-00018I-Su; Mon, 05 Aug 2024 16:16:05 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fd90c2fc68so696805ad.1; 
 Mon, 05 Aug 2024 13:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722888955; x=1723493755; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5uFd3H/2etuEMgJ2K5AcTbykwF7NgINxrjosLK61YBY=;
 b=kF6dxGJI3F1suq9N9WSzMKeKKiIyzi56nFwggwxTbBlJ2vI1LVq14f9knImAQUUHqX
 rzB6Jxi7XC4vtBH7bEvEEazI1REWwsPdalHOYSIhnkhMiYRcSb/I8/1jVaDeWICmA2ok
 57edjPJUKva+XD9fdIarCdd8LP0U+4p93LrA9dSeiJhDw05cj1fIVanX8ULYErbng0/J
 2Lie53upLyIfgS+llez4k24MaOt10HkFV1KpaaWT/X9knbDi9YIE4PUmKAwaGn4NWD8W
 gJlKXsuQzZs1cK1oh9evqviV8jkTlkYog5vo5cJ3X8+z5c8yNvRoTACxJyGg8OgBBywW
 eVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722888955; x=1723493755;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5uFd3H/2etuEMgJ2K5AcTbykwF7NgINxrjosLK61YBY=;
 b=EgeUW1HsobNeNpIvltzXSdP3KPhbNe//YFp7XtypBRVmVyeYchkCXHVWxB339wY1Qj
 OAFZf1WM4wD/XytVD5PbJQ4ysASQkCmFX5dkBh+MjqSNLECSVPXuLbSxI/DK+z8D1z2+
 mbo//+7t2VFkiyx0HB4C1flB+nLMo0ngL2JuWtOJfVIEq9gBrGDJh66LaLy1e/7OdMqq
 OssSDoRTUzTe/s7HVGAZljd8sKQmmmUmsANnZhKQq5EHplIkA0HWW4qq74Cs+psBUSyg
 2XiUlQNu4a9tmU4G9Lf5EMCFGO30C2mwuQcn5pBkenzzFVuFEkl8jQkO6hRSPWBH5Zh9
 3bzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8WiG2Z7XCauEcr5xNpzXUyQPd7iMdmkKRNlVtL+hUQFdXsuNng2RZfciwUKzUkC1ean2nNH7kRvgBra/NvNsF4UbK5BE=
X-Gm-Message-State: AOJu0Yya5PreSpR1/zs5poa7bpnewwSX/3O6MqxtkJ4WluCuKwE8FfGO
 VLxWTKnGHlMt8UrNmzxptkZbU0kPIGcmp6aeSWN2ZU+/cOXSZtO6FWPM+7axLsTXSifDIJxobzE
 uFZjUv6dFHcNJ1RzaSiN/eZ+U71Q=
X-Google-Smtp-Source: AGHT+IF98t/kB3S3FZXlWxA8ep9e85e50ocjKwIlkvI5ifOqWnYbXKKKtpNLoSeuacuXY4I+VG/t+HDAxqwKAtmoudE=
X-Received: by 2002:a17:903:246:b0:1f4:620b:6a27 with SMTP id
 d9443c01a7336-1ff5723e5e9mr136731355ad.13.1722888955244; Mon, 05 Aug 2024
 13:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240726184324.597939-1-gregorhaas1997@gmail.com>
 <20240726184324.597939-2-gregorhaas1997@gmail.com>
 <14e06c43-ea79-4f2b-ab7b-a1b84f3eb7a0@ventanamicro.com>
In-Reply-To: <14e06c43-ea79-4f2b-ab7b-a1b84f3eb7a0@ventanamicro.com>
From: Gregor Haas <gregorhaas1997@gmail.com>
Date: Mon, 5 Aug 2024 13:15:18 -0700
Message-ID: <CAMqWt3qTzGFOfO1R8aAeYBMqZvsifcerB4W_wmzZfJ6Me9xE6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Add support for generating OpenSBI domains in the
 device tree
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, atishp@rivosinc.com, 
 alistair.francis@wdc.com
Content-Type: multipart/alternative; boundary="0000000000002a3c30061ef55865"
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=gregorhaas1997@gmail.com; helo=mail-pl1-x636.google.com
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

--0000000000002a3c30061ef55865
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Thanks for your review! I apologize for the incorrect command line -- the
"size"
parameter was indeed from my internal branch, building off of a patch
series [1]
submitted to OpenSBI. I will include a correct command line with my v3
patch.

For my v3 patch, I'll also make sure to specify sane defaults for all
properties
where it makes sense. I'll attach my patch implementing this on top of v2
to this
email to make review slightly easier, and submit a v3 patch to the list
momentarily.

[1] http://lists.infradead.org/pipermail/opensbi/2024-July/007173.html

From da45d5b9538427d0f33f7d9a2c7470095ceef4ae Mon Sep 17 00:00:00 2001
From: Gregor Haas <gregorhaas1997@gmail.com>
Date: Mon, 5 Aug 2024 12:59:51 -0700
Subject: [PATCH] Add default parameters to OpenSBI domain properties

Signed-off-by: Gregor Haas <gregorhaas1997@gmail.com>
---
 hw/riscv/opensbi_domain.c         | 145 ++++++++++++++++++++++++------
 include/hw/riscv/opensbi_domain.h |   3 +-
 2 files changed, 118 insertions(+), 30 deletions(-)

diff --git a/hw/riscv/opensbi_domain.c b/hw/riscv/opensbi_domain.c
index 397881676b..8670e7961e 100644
--- a/hw/riscv/opensbi_domain.c
+++ b/hw/riscv/opensbi_domain.c
@@ -1,5 +1,7 @@
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "hw/riscv/opensbi_domain.h"
+#include "hw/riscv/virt.h"
 #include "hw/boards.h"
 #include "sysemu/device_tree.h"
 #include "qapi/error.h"
@@ -10,14 +12,13 @@ static void
create_fdt_domain_possible_harts(MachineState *ms,
                                              OpenSBIDomainState *s,
                                              char *path) {
     unsigned long i, cpu;
-    int num_cpus;
+    unsigned long num_cpus;

-    num_cpus =3D ctpop64(s->possible_harts);
+    num_cpus =3D s->last_possible_hart - s->first_possible_hart + 1;
     if (num_cpus) {
         g_autofree uint32_t *phandles =3D g_malloc0_n(num_cpus,
sizeof(uint32_t));

-        for (i =3D 0, cpu =3D -1; i < num_cpus; i++) {
-            cpu =3D find_next_bit(&s->possible_harts, BITS_PER_LONG, cpu +
1);
+        for (i =3D 0, cpu =3D s->first_possible_hart; i < num_cpus; i++,
cpu++) {
             g_autofree char *cpu_name =3D g_strdup_printf("/cpus/cpu@%li",
cpu);
             phandles[i] =3D cpu_to_fdt32(qemu_fdt_get_phandle(
                     ms->fdt, cpu_name));
@@ -88,20 +89,30 @@ static void create_fdt_one_domain(MachineState *ms,
OpenSBIDomainState *s)
     create_fdt_domain_regions(ms, s, path);

     /* Assign boot hart to this domain */
-    cpu_name =3D g_strdup_printf("/cpus/cpu@%i", s->boot_hart);
-    qemu_fdt_setprop_cell(ms->fdt, path, "boot-hart",
-                          qemu_fdt_get_phandle(ms->fdt, cpu_name));
-    if (s->assign) {
-        qemu_fdt_setprop_cell(ms->fdt, cpu_name, "opensbi-domain",
-                              qemu_fdt_get_phandle(ms->fdt, path));
+    if (s->boot_hart !=3D -1) {
+        cpu_name =3D g_strdup_printf("/cpus/cpu@%i", s->boot_hart);
+        qemu_fdt_setprop_cell(ms->fdt, path, "boot-hart",
+                              qemu_fdt_get_phandle(ms->fdt, cpu_name));
+        if (s->assign) {
+            qemu_fdt_setprop_cell(ms->fdt, cpu_name, "opensbi-domain",
+                                    qemu_fdt_get_phandle(ms->fdt, path));
+        }
     }

-    qemu_fdt_setprop_cells(ms->fdt, path, "next-arg1",
-                           (uint64_t) s->next_arg1 >> 32, s->next_arg1);
-    qemu_fdt_setprop_cells(ms->fdt, path, "next-addr",
-                           (uint64_t) s->next_addr >> 32, s->next_addr);
-    qemu_fdt_setprop_cell(ms->fdt, path, "next-mode",
-                          s->next_mode);
+    if (s->next_arg1 !=3D -1) {
+        qemu_fdt_setprop_cells(ms->fdt, path, "next-arg1",
+                             (uint64_t) s->next_arg1 >> 32, s->next_arg1);
+    }
+
+    if (s->next_addr !=3D -1) {
+        qemu_fdt_setprop_cells(ms->fdt, path, "next-addr",
+                             (uint64_t) s->next_addr >> 32, s->next_addr);
+    }
+
+    if (s->next_mode !=3D -1) {
+        qemu_fdt_setprop_cell(ms->fdt, path, "next-mode",
+                            s->next_mode);
+    }

     if (s->system_reset_allowed) {
         qemu_fdt_setprop(ms->fdt, path, "system-reset-allowed", NULL, 0);
@@ -244,18 +255,21 @@ static void opensbi_memregion_instance_init(Object
*obj)
     int i;
     OpenSBIMemregionState *s =3D OPENSBI_MEMREGION(obj);

+    s->base =3D -1;
     object_property_add_uint64_ptr(obj, "base", &s->base,
                                    OBJ_PROP_FLAG_WRITE);
     object_property_set_description(obj, "base",
                                     "The base address of the domain memory
region. If \"order\" is also specified, "
                                     "this property should be a 2 ^ order
aligned 64 bit address");

+    s->order =3D -1;
     object_property_add_uint32_ptr(obj, "order", &s->order,
                                    OBJ_PROP_FLAG_WRITE);
     object_property_set_description(obj, "order",
                                     "The order of the domain memory
region. This property should have a 32 bit value "
                                     "(i.e. one DT cell) in the range 3 <=
=3D
order <=3D __riscv_xlen.");

+    s->mmio =3D false;
     object_property_add_bool(obj, "mmio", NULL, set_mmio);
     object_property_set_description(obj, "mmio",
                                     "A boolean flag representing whether
the domain memory region is a "
@@ -282,25 +296,25 @@ static void opensbi_memregion_realize(DeviceState
*ds, Error **errp)

     OpenSBIMemregionState *s =3D OPENSBI_MEMREGION(ds);

-    if (!s->base) {
-        error_setg(errp, "Must specify base");
+    if (s->base =3D=3D -1) {
+        error_setg(errp, "must specify base");
         return;
     }

-    /* Check order bounds */
-    if (s->order < 3) {
-        error_setg(errp, "Order too small");
+    if (s->order =3D=3D -1) {
+        error_setg(errp, "must specify order");
         return;
     }

-    if (s->order > xlen) {
-        error_setg(errp, "Order too big");
+    /* Check order bounds */
+    if (s->order < 3 || s->order > xlen) {
+        error_setg(errp, "order must be between 3 and %d", xlen);
         return;
     }

     /* Check base alignment */
     if (s->order < xlen && (s->base & (BIT(s->order) - 1))) {
-        error_setg(errp, "Base not aligned to order");
+        error_setg(errp, "base not aligned to order");
         return;
     }
 }
@@ -339,47 +353,85 @@ static void set_assign(Object *obj, bool val, Error
**err)
     s->assign =3D val;
 }

+static void set_possible_harts(Object *obj, const char *str, Error **err)
+{
+    OpenSBIDomainState *s =3D OPENSBI_DOMAIN(obj);
+    const char *firstcpu,  *firstcpu_end, *lastcpu;
+
+    firstcpu =3D str;
+    if (qemu_strtoul(firstcpu, &firstcpu_end, 0,
+                     &s->first_possible_hart) < 0) {
+        error_setg(err, "could not convert firstcpu");
+        return;
+    }
+
+    lastcpu =3D qemu_strchrnul(str, '-');
+    if (*lastcpu) {
+        if (lastcpu !=3D firstcpu_end) {
+            error_setg(err, "could not separate firstcpu and lastcpu");
+            return;
+        }
+
+        lastcpu++;
+        if (qemu_strtoul(lastcpu, NULL, 0,
+                         &s->last_possible_hart) < 0) {
+            error_setg(err, "could not convert lastcpu");
+            return;
+        }
+    } else {
+        s->last_possible_hart =3D s->first_possible_hart;
+    }
+}
+
 static void opensbi_domain_instance_init(Object *obj)
 {
     int i;
     OpenSBIDomainState *s =3D OPENSBI_DOMAIN(obj);

+    s->boot_hart =3D VIRT_CPUS_MAX;
     object_property_add_uint32_ptr(obj, "boot-hart", &s->boot_hart,
                                    OBJ_PROP_FLAG_WRITE);
     object_property_set_description(obj, "boot-hart",
                                     "The HART booting the domain
instance.");

-    object_property_add_uint64_ptr(obj, "possible-harts",
&s->possible_harts,
-                                   OBJ_PROP_FLAG_WRITE);
+    s->first_possible_hart =3D -1;
+    s->last_possible_hart =3D -1;
+    object_property_add_str(obj, "possible-harts", NULL,
set_possible_harts);
     object_property_set_description(obj, "possible-harts",
-                                    "The list of CPUs for the domain
instance, encoded as a bitmask");
+                                    "The contiguous list of CPUs for the
domain instance, specified as firstcpu[-lastcpu]");

+    s->next_arg1 =3D -1;
     object_property_add_uint64_ptr(obj, "next-arg1", &s->next_arg1,
                                    OBJ_PROP_FLAG_WRITE);
     object_property_set_description(obj, "next-arg1",
                                     "The 64 bit next booting stage arg1
for the domain instance.");

+    s->next_addr =3D -1;
     object_property_add_uint64_ptr(obj, "next-addr", &s->next_addr,
                                    OBJ_PROP_FLAG_WRITE);
     object_property_set_description(obj, "next-addr",
                                     "The 64 bit next booting stage address
for the domain instance.");

+    s->next_mode =3D -1;
     object_property_add_uint32_ptr(obj, "next-mode", &s->next_mode,
                                    OBJ_PROP_FLAG_WRITE);
     object_property_set_description(obj, "next-mode",
                                     "The 32 bit next booting stage mode
for the domain instance.");

+    s->system_reset_allowed =3D false;
     object_property_add_bool(obj, "system-reset-allowed", NULL,
                              set_sysreset_allowed);
     object_property_set_description(obj, "system-reset-allowed",
                                     "Whether the domain instance is
allowed to do system reset.");

+    s->system_suspend_allowed =3D false;
     object_property_add_bool(obj, "system-suspend-allowed", NULL,
                              set_suspend_allowed);
     object_property_set_description(obj, "system-suspend-allowed",
                                     "Whether the domain instance is
allowed to do system suspend.");

     for (i =3D 0; i < OPENSBI_DOMAIN_MEMREGIONS_MAX; i++) {
+        s->regions[i] =3D NULL;
         g_autofree char *reg_propname =3D g_strdup_printf("region%i", i);
         object_property_add_link(obj, reg_propname, TYPE_OPENSBI_MEMREGION=
,
                                  (Object **) &s->regions[i],
@@ -390,6 +442,7 @@ static void opensbi_domain_instance_init(Object *obj)
                 i, OPENSBI_DOMAIN_MEMREGIONS_MAX);
         object_property_set_description(obj, reg_propname,
reg_description);

+        s->region_perms[i] =3D 0;
         g_autofree char *perm_propname =3D g_strdup_printf("perms%i", i);
         object_property_add_uint32_ptr(obj, perm_propname,
&s->region_perms[i],
                                        OBJ_PROP_FLAG_WRITE);
@@ -406,7 +459,43 @@ static void opensbi_domain_instance_init(Object *obj)

 static void opensbi_domain_realize(DeviceState *ds, Error **errp)
 {
-    /* Nothing to do */
+    OpenSBIDomainState *s =3D OPENSBI_DOMAIN(ds);
+
+    if (s->boot_hart >=3D VIRT_CPUS_MAX) {
+        error_setg(errp, "boot hart larger than maximum number of CPUs
(%d)",
+                 VIRT_CPUS_MAX);
+        return;
+    }
+
+    if (s->first_possible_hart =3D=3D -1) {
+        if (s->last_possible_hart !=3D -1) {
+            error_setg(errp,
+                     "last possible hart set when first possible hart
unset");
+            return;
+        }
+    } else {
+        if (s->first_possible_hart >=3D VIRT_CPUS_MAX) {
+            error_setg(errp,
+                     "first possible hart larger than maximum number of
CPUs (%d)",
+                     VIRT_CPUS_MAX);
+            return;
+        }
+
+        if (s->last_possible_hart !=3D -1) {
+            if (s->last_possible_hart < s->first_possible_hart) {
+                error_setg(errp,
+                         "last possible hart larger than first possible
hart");
+                return;
+            }
+
+            if (s->last_possible_hart >=3D VIRT_CPUS_MAX) {
+                error_setg(errp,
+                         "last possible hart larger than maximum number of
CPUS (%d)",
+                         VIRT_CPUS_MAX);
+                return;
+            }
+        }
+    }
 }

 static void opensbi_domain_class_init(ObjectClass *oc, void *opaque)
diff --git a/include/hw/riscv/opensbi_domain.h
b/include/hw/riscv/opensbi_domain.h
index 61bcf1a296..bcce16a609 100644
--- a/include/hw/riscv/opensbi_domain.h
+++ b/include/hw/riscv/opensbi_domain.h
@@ -34,8 +34,7 @@ struct OpenSBIDomainState {
     /* private */
     OpenSBIMemregionState *regions[OPENSBI_DOMAIN_MEMREGIONS_MAX];
     unsigned int region_perms[OPENSBI_DOMAIN_MEMREGIONS_MAX];
-
-    unsigned long possible_harts;
+    unsigned long first_possible_hart, last_possible_hart;
     unsigned int boot_hart;
     uint64_t next_arg1;
     uint64_t next_addr;
--=20
2.45.2



On Sun, Aug 4, 2024 at 12:04=E2=80=AFPM Daniel Henrique Barboza <
dbarboza@ventanamicro.com> wrote:

>
>
> On 7/26/24 3:43 PM, Gregor Haas wrote:
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
>
> When I tried this example the following error is shown:
>
> qemu-system-riscv64 -M virt (...)
>      -device
> opensbi-memregion,id=3Dmem,base=3D0x178000000,size=3D0x4000000,mmio=3Dfal=
se
>      -device
> opensbi-domain,possible-harts=3D0x2,boot-hart=3D0x1,next-addr=3D0x1780000=
00,next-mode=3D1,region0=3Dmem,perms0=3D0x3f
> qemu-system-riscv64: -device
> opensbi-memregion,id=3Dmem,base=3D0x178000000,size=3D0x4000000,mmio=3Dfal=
se:
> Property 'opensbi-memregion.size' not found
>
> And in fact we don't have a 'size' property declared in
> opensbi_memregion_instance_init().
> We also don't have a 'size' field in OpenSBIMemregionState. I guess that
> this might be
> a reminiscent of a previous prototype that had this field.
>
> If I remove this prop from the command line I have now this error:
>
> qemu-system-riscv64 -M virt (...)
>      -device opensbi-memregion,id=3Dmem,base=3D0x178000000,mmio=3Dfalse
>      -device
> opensbi-domain,possible-harts=3D0x2,boot-hart=3D0x1,next-addr=3D0x1780000=
00,next-mode=3D1,region0=3Dmem,perms0=3D0x3f
> qemu-system-riscv64: -device
> opensbi-memregion,id=3Dmem,base=3D0x178000000,mmio=3Dfalse: Order too sma=
ll
>
>
> Checking how 'order' works, it must be 3 <=3D order <=3D __riscv_xlen. I =
didn't
> set 'order' and it said "Order too small" because there's no code to chec=
k
> if order' was user set.
>
> I suggest setting a sane default for the field and, in case the user set
> the
> wrong value, display an error message like "order must be between 3 and %=
d"
> where %d would be the xlen used at the time. By 'sane' default I mean a
> value that will be used in most common situations.
>
> In fact I suggest taking a second look at all the other properties to
> choose
> good defaults, especially for the opensbi-domain device since it has a lo=
t
> of
> mandatory attributes. For example 'next-addr' can be set by default to th=
e
> 'base' of its associated opensbi-memregion, IIUC.
>
>
> Thanks,
>
> Daniel
>
>
>
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
> >   MAINTAINERS                       |   7 +
> >   hw/riscv/Kconfig                  |   4 +
> >   hw/riscv/meson.build              |   1 +
> >   hw/riscv/opensbi_domain.c         | 428 +++++++++++++++++++++++++++++=
+
> >   hw/riscv/virt.c                   |   3 +
> >   include/hw/riscv/opensbi_domain.h |  51 ++++
> >   6 files changed, 494 insertions(+)
> >   create mode 100644 hw/riscv/opensbi_domain.c
> >   create mode 100644 include/hw/riscv/opensbi_domain.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 98eddf7ae1..796c023a7b 100644
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
> > +F: hw/riscv/opensbi_domain.c
> > +F: include/hw/riscv/opensbi_domain.h
> > +
> >   RENESAS RX CPUs
> >   R: Yoshinori Sato <ysato@users.sourceforge.jp>
> >   S: Orphan
> > diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> > index a2030e3a6f..db3a4d77ad 100644
> > --- a/hw/riscv/Kconfig
> > +++ b/hw/riscv/Kconfig
> > @@ -1,6 +1,9 @@
> >   config RISCV_NUMA
> >       bool
> >
> > +config RISCV_OPENSBI_DOMAIN
> > +    bool
> > +
> >   config IBEX
> >       bool
> >
> > @@ -40,6 +43,7 @@ config RISCV_VIRT
> >       imply TPM_TIS_SYSBUS
> >       select DEVICE_TREE
> >       select RISCV_NUMA
> > +    select RISCV_OPENSBI_DOMAIN
> >       select GOLDFISH_RTC
> >       select PCI
> >       select PCI_EXPRESS_GENERIC_BRIDGE
> > diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> > index f872674093..f47626c164 100644
> > --- a/hw/riscv/meson.build
> > +++ b/hw/riscv/meson.build
> > @@ -1,6 +1,7 @@
> >   riscv_ss =3D ss.source_set()
> >   riscv_ss.add(files('boot.c'))
> >   riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
> > +riscv_ss.add(when: 'CONFIG_RISCV_OPENSBI_DOMAIN', if_true:
> files('opensbi_domain.c'))
> >   riscv_ss.add(files('riscv_hart.c'))
> >   riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
> >   riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
> > diff --git a/hw/riscv/opensbi_domain.c b/hw/riscv/opensbi_domain.c
> > new file mode 100644
> > index 0000000000..418ebe1e56
> > --- /dev/null
> > +++ b/hw/riscv/opensbi_domain.c
> > @@ -0,0 +1,428 @@
> > +#include "qemu/osdep.h"
> > +#include "hw/riscv/opensbi_domain.h"
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
> > +
> > +    num_cpus =3D ctpop64(s->possible_harts);
> > +    if (num_cpus) {
> > +        g_autofree uint32_t *phandles =3D g_malloc0_n(num_cpus,
> sizeof(uint32_t));
> > +
> > +        for (i =3D 0, cpu =3D -1; i < num_cpus; i++) {
> > +            cpu =3D find_next_bit(&s->possible_harts, BITS_PER_LONG, c=
pu
> + 1);
> > +            g_autofree char *cpu_name =3D g_strdup_printf("/cpus/cpu@%=
li",
> cpu);
> > +            phandles[i] =3D cpu_to_fdt32(qemu_fdt_get_phandle(
> > +                    ms->fdt, cpu_name));
> > +        }
> > +
> > +        qemu_fdt_setprop(ms->fdt, path, "possible-harts",
> > +                         phandles, num_cpus * 4);
> > +    }
> > +}
> > +
> > +static void create_fdt_domain_regions(MachineState *ms,
> > +                                      OpenSBIDomainState *s,
> > +                                      char *path) {
> > +    unsigned long i;
> > +    int num_regions =3D 0;
> > +    DeviceState *ds;
> > +
> > +    for (i =3D 0; i < OPENSBI_DOMAIN_MEMREGIONS_MAX; i++) {
> > +        if (s->regions[i]) {
> > +            num_regions++;
> > +        }
> > +    }
> > +
> > +    if (num_regions) {
> > +        g_autofree uint32_t *regions =3D
> > +                 g_malloc0_n(num_regions, 2 * sizeof(uint32_t));
> > +        for (i =3D 0; i < OPENSBI_DOMAIN_MEMREGIONS_MAX; i++) {
> > +            if (s->regions[i]) {
> > +                ds =3D DEVICE(s->regions[i]);
> > +                g_autofree char *region_name =3D g_strdup_printf(
> > +                       "/chosen/opensbi-domains/%s", ds->id);
> > +                regions[2 * i] =3D cpu_to_fdt32(qemu_fdt_get_phandle
> > +                        (ms->fdt, region_name));
> > +                regions[2 * i + 1] =3D cpu_to_fdt32(s->region_perms[i]=
);
> > +            }
> > +        }
> > +
> > +        qemu_fdt_setprop(ms->fdt, path, "regions",
> > +                         regions, num_regions * 8);
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
> > +    g_autofree char *path, *cpu_name;
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
> > +    if (s->assign) {
> > +        qemu_fdt_setprop_cell(ms->fdt, cpu_name, "opensbi-domain",
> > +                              qemu_fdt_get_phandle(ms->fdt, path));
> > +    }
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
> > +}
> > +
> > +static void create_fdt_one_memregion(MachineState *ms,
> > +                                     OpenSBIMemregionState *s)
> > +{
> > +    g_autofree char *path;
> > +    int i, dev, num_devices;
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
> > +        g_autofree uint32_t *devices =3D
> > +                g_malloc0_n(num_devices, sizeof(uint32_t));
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
> > +    }
> > +
> > +    qemu_fdt_setprop_cells(ms->fdt, path, "phandle",
> > +                           qemu_fdt_alloc_phandle(ms->fdt));
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
> > +        g_autofree char *propname =3D g_strdup_printf("device%i", i);
> > +        object_property_add_str(obj, propname, NULL, set_device);
> > +
> > +        g_autofree char *description =3D g_strdup_printf(
> > +                "Device %i (out of %i) for this memregion. This
> property should be a device tree path to the device.",
> > +                i, OPENSBI_DOMAIN_MEMREGIONS_MAX);
> > +        object_property_set_description(obj, propname, description);
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
> > +static void set_assign(Object *obj, bool val, Error **err)
> > +{
> > +    OpenSBIDomainState *s =3D OPENSBI_DOMAIN(obj);
> > +    s->assign =3D val;
> > +}
> > +
> > +static void opensbi_domain_instance_init(Object *obj)
> > +{
> > +    int i;
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
> > +        g_autofree char *reg_propname =3D g_strdup_printf("region%i", =
i);
> > +        object_property_add_link(obj, reg_propname,
> TYPE_OPENSBI_MEMREGION,
> > +                                 (Object **) &s->regions[i],
> > +
>  qdev_prop_allow_set_link_before_realize, 0);
> > +
> > +        g_autofree char *reg_description =3D g_strdup_printf(
> > +                "Region %i (out of %i) for this domain.",
> > +                i, OPENSBI_DOMAIN_MEMREGIONS_MAX);
> > +        object_property_set_description(obj, reg_propname,
> reg_description);
> > +
> > +        g_autofree char *perm_propname =3D g_strdup_printf("perms%i", =
i);
> > +        object_property_add_uint32_ptr(obj, perm_propname,
> &s->region_perms[i],
> > +                                       OBJ_PROP_FLAG_WRITE);
> > +
> > +        g_autofree char *perm_description =3D g_strdup_printf(
> > +                "Permissions for region %i for this domain.", i);
> > +        object_property_set_description(obj, perm_propname,
> perm_description);
> > +    }
> > +
> > +    object_property_add_bool(obj, "assign", NULL, set_assign);
> > +    object_property_set_description(obj, "assign",
> > +                                    "Whether to assign this domain to
> its boot hart.");
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
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index 9981e0f6c9..bb4bf3ce5b 100644
> > --- a/hw/riscv/virt.c
> > +++ b/hw/riscv/virt.c
> > @@ -55,6 +55,7 @@
> >   #include "hw/acpi/aml-build.h"
> >   #include "qapi/qapi-visit-common.h"
> >   #include "hw/virtio/virtio-iommu.h"
> > +#include "hw/riscv/opensbi_domain.h"
> >
> >   /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by
> QEMU. */
> >   static bool virt_use_kvm_aia(RISCVVirtState *s)
> > @@ -1051,6 +1052,8 @@ static void finalize_fdt(RISCVVirtState *s)
> >       create_fdt_uart(s, virt_memmap, irq_mmio_phandle);
> >
> >       create_fdt_rtc(s, virt_memmap, irq_mmio_phandle);
> > +
> > +    create_fdt_opensbi_domains(MACHINE(s));
> >   }
> >
> >   static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
> > diff --git a/include/hw/riscv/opensbi_domain.h
> b/include/hw/riscv/opensbi_domain.h
> > new file mode 100644
> > index 0000000000..61bcf1a296
> > --- /dev/null
> > +++ b/include/hw/riscv/opensbi_domain.h
> > @@ -0,0 +1,51 @@
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
> > +
> > +    bool assign;
> > +};
> > +
> > +void create_fdt_opensbi_domains(MachineState *s);
> > +
> > +#endif /* RISCV_DOMAIN_H */
>

--0000000000002a3c30061ef55865
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Daniel,</div><div><br></div><div>Thanks for your r=
eview! I apologize for the incorrect command line -- the &quot;size&quot;<b=
r>parameter was indeed from my internal branch, building off of a patch ser=
ies [1]<br>submitted to OpenSBI. I will include a correct command line with=
 my v3 patch.<br><br>For my v3 patch, I&#39;ll also make sure to specify sa=
ne defaults for all properties<br>where it makes sense. I&#39;ll attach my =
patch implementing this on top of v2 to this<br>email to make review slight=
ly easier, and submit a v3 patch to the list momentarily.<br><br>[1] <a hre=
f=3D"http://lists.infradead.org/pipermail/opensbi/2024-July/007173.html" ta=
rget=3D"_blank">http://lists.infradead.org/pipermail/opensbi/2024-July/0071=
73.html</a></div><div><br></div><div>From da45d5b9538427d0f33f7d9a2c7470095=
ceef4ae Mon Sep 17 00:00:00 2001<br>From: Gregor Haas &lt;<a href=3D"mailto=
:gregorhaas1997@gmail.com" target=3D"_blank">gregorhaas1997@gmail.com</a>&g=
t;<br>Date: Mon, 5 Aug 2024 12:59:51 -0700<br>Subject: [PATCH] Add default =
parameters to OpenSBI domain properties<br><br>Signed-off-by: Gregor Haas &=
lt;<a href=3D"mailto:gregorhaas1997@gmail.com" target=3D"_blank">gregorhaas=
1997@gmail.com</a>&gt;<br>---<br>=C2=A0hw/riscv/opensbi_domain.c =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 145 ++++++++++++++++++++++++------<br>=C2=A0include/hw/=
riscv/opensbi_domain.h | =C2=A0 3 +-<br>=C2=A02 files changed, 118 insertio=
ns(+), 30 deletions(-)<br><br>diff --git a/hw/riscv/opensbi_domain.c b/hw/r=
iscv/opensbi_domain.c<br>index 397881676b..8670e7961e 100644<br>--- a/hw/ri=
scv/opensbi_domain.c<br>+++ b/hw/riscv/opensbi_domain.c<br>@@ -1,5 +1,7 @@<=
br>=C2=A0#include &quot;qemu/osdep.h&quot;<br>+#include &quot;qemu/cutils.h=
&quot;<br>=C2=A0#include &quot;hw/riscv/opensbi_domain.h&quot;<br>+#include=
 &quot;hw/riscv/virt.h&quot;<br>=C2=A0#include &quot;hw/boards.h&quot;<br>=
=C2=A0#include &quot;sysemu/device_tree.h&quot;<br>=C2=A0#include &quot;qap=
i/error.h&quot;<br>@@ -10,14 +12,13 @@ static void create_fdt_domain_possib=
le_harts(MachineState *ms,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OpenSBIDomainState *s,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 char *path) {<br>=C2=A0 =C2=A0 =C2=A0unsigned long i, cpu;<br>- =C2=
=A0 =C2=A0int num_cpus;<br>+ =C2=A0 =C2=A0unsigned long num_cpus;<br>=C2=A0=
<br>- =C2=A0 =C2=A0num_cpus =3D ctpop64(s-&gt;possible_harts);<br>+ =C2=A0 =
=C2=A0num_cpus =3D s-&gt;last_possible_hart - s-&gt;first_possible_hart + 1=
;<br>=C2=A0 =C2=A0 =C2=A0if (num_cpus) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0g_autofree uint32_t *phandles =3D g_malloc0_n(num_cpus, sizeof(uint32_t)=
);<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0, cpu =3D -1; i &l=
t; num_cpus; i++) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu =3D f=
ind_next_bit(&amp;s-&gt;possible_harts, BITS_PER_LONG, cpu + 1);<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0, cpu =3D s-&gt;first_possible_hart; i =
&lt; num_cpus; i++, cpu++) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0g_autofree char *cpu_name =3D g_strdup_printf(&quot;/cpus/cpu@%li&quo=
t;, cpu);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0phandles[i] =
=3D cpu_to_fdt32(qemu_fdt_get_phandle(<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ms-&gt;fdt, cpu_name));<br>@@ =
-88,20 +89,30 @@ static void create_fdt_one_domain(MachineState *ms, OpenSB=
IDomainState *s)<br>=C2=A0 =C2=A0 =C2=A0create_fdt_domain_regions(ms, s, pa=
th);<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0/* Assign boot hart to this domain */=
<br>- =C2=A0 =C2=A0cpu_name =3D g_strdup_printf(&quot;/cpus/cpu@%i&quot;, s=
-&gt;boot_hart);<br>- =C2=A0 =C2=A0qemu_fdt_setprop_cell(ms-&gt;fdt, path, =
&quot;boot-hart&quot;,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_fdt_get_phandle(ms-&gt;fd=
t, cpu_name));<br>- =C2=A0 =C2=A0if (s-&gt;assign) {<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0qemu_fdt_setprop_cell(ms-&gt;fdt, cpu_name, &quot;opensbi-domain&=
quot;,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_fdt_get_phandle(ms-&gt;fdt, p=
ath));<br>+ =C2=A0 =C2=A0if (s-&gt;boot_hart !=3D -1) {<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0cpu_name =3D g_strdup_printf(&quot;/cpus/cpu@%i&quot;, s-&gt;b=
oot_hart);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_fdt_setprop_cell(ms-&gt;fdt=
, path, &quot;boot-hart&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_fdt_=
get_phandle(ms-&gt;fdt, cpu_name));<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&=
gt;assign) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_fdt_setprop=
_cell(ms-&gt;fdt, cpu_name, &quot;opensbi-domain&quot;,<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_fdt_get_phandle(ms-&gt;fdt, path=
));<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br=
>- =C2=A0 =C2=A0qemu_fdt_setprop_cells(ms-&gt;fdt, path, &quot;next-arg1&qu=
ot;,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (uint64_t) s-&gt;next_arg1 &gt;&gt; 32, s-&gt;n=
ext_arg1);<br>- =C2=A0 =C2=A0qemu_fdt_setprop_cells(ms-&gt;fdt, path, &quot=
;next-addr&quot;,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (uint64_t) s-&gt;next_addr &gt;&gt; =
32, s-&gt;next_addr);<br>- =C2=A0 =C2=A0qemu_fdt_setprop_cell(ms-&gt;fdt, p=
ath, &quot;next-mode&quot;,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;next_mode);<br>+ =C2=
=A0 =C2=A0if (s-&gt;next_arg1 !=3D -1) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0qe=
mu_fdt_setprop_cells(ms-&gt;fdt, path, &quot;next-arg1&quot;,<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (uint64_t) s-&gt;next_arg1 &gt;&gt; 32, s-&gt;next_arg1);=
<br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0if (s-&gt;next_addr !=3D -1) {<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_fdt_setprop_cells(ms-&gt;fdt, path, &q=
uot;next-addr&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (uint64_t) s-&gt;next_addr=
 &gt;&gt; 32, s-&gt;next_addr);<br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0=
if (s-&gt;next_mode !=3D -1) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_fdt_set=
prop_cell(ms-&gt;fdt, path, &quot;next-mode&quot;,<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0s-&gt;next_mode);<br>+ =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=
=A0if (s-&gt;system_reset_allowed) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0q=
emu_fdt_setprop(ms-&gt;fdt, path, &quot;system-reset-allowed&quot;, NULL, 0=
);<br>@@ -244,18 +255,21 @@ static void opensbi_memregion_instance_init(Obj=
ect *obj)<br>=C2=A0 =C2=A0 =C2=A0int i;<br>=C2=A0 =C2=A0 =C2=A0OpenSBIMemre=
gionState *s =3D OPENSBI_MEMREGION(obj);<br>=C2=A0<br>+ =C2=A0 =C2=A0s-&gt;=
base =3D -1;<br>=C2=A0 =C2=A0 =C2=A0object_property_add_uint64_ptr(obj, &qu=
ot;base&quot;, &amp;s-&gt;base,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 OBJ_PROP_FLAG_WRITE);<br>=C2=A0 =C2=A0 =C2=A0object_property_=
set_description(obj, &quot;base&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;The base address of the domain memory regi=
on. If \&quot;order\&quot; is also specified, &quot;<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;this property should be a 2 =
^ order aligned 64 bit address&quot;);<br>=C2=A0<br>+ =C2=A0 =C2=A0s-&gt;or=
der =3D -1;<br>=C2=A0 =C2=A0 =C2=A0object_property_add_uint32_ptr(obj, &quo=
t;order&quot;, &amp;s-&gt;order,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 OBJ_PROP_FLAG_WRITE);<br>=C2=A0 =C2=A0 =C2=A0object_property_=
set_description(obj, &quot;order&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;The order of the domain memory region. Thi=
s property should have a 32 bit value &quot;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;(i.e. one DT cell) in the range 3 &lt;=
=3D order &lt;=3D __riscv_xlen.&quot;);<br>=C2=A0<br>+ =C2=A0 =C2=A0s-&gt;m=
mio =3D false;<br>=C2=A0 =C2=A0 =C2=A0object_property_add_bool(obj, &quot;m=
mio&quot;, NULL, set_mmio);<br>=C2=A0 =C2=A0 =C2=A0object_property_set_desc=
ription(obj, &quot;mmio&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;A boolean flag representing whether the domain memor=
y region is a &quot;<br>@@ -282,25 +296,25 @@ static void opensbi_memregion=
_realize(DeviceState *ds, Error **errp)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0Op=
enSBIMemregionState *s =3D OPENSBI_MEMREGION(ds);<br>=C2=A0<br>- =C2=A0 =C2=
=A0if (!s-&gt;base) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quo=
t;Must specify base&quot;);<br>+ =C2=A0 =C2=A0if (s-&gt;base =3D=3D -1) {<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;must specify base&quo=
t;);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0 =C2=A0 =C2=A0}<=
br>=C2=A0<br>- =C2=A0 =C2=A0/* Check order bounds */<br>- =C2=A0 =C2=A0if (=
s-&gt;order &lt; 3) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quo=
t;Order too small&quot;);<br>+ =C2=A0 =C2=A0if (s-&gt;order =3D=3D -1) {<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;must specify order&quo=
t;);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0 =C2=A0 =C2=A0}<=
br>=C2=A0<br>- =C2=A0 =C2=A0if (s-&gt;order &gt; xlen) {<br>- =C2=A0 =C2=A0=
 =C2=A0 =C2=A0error_setg(errp, &quot;Order too big&quot;);<br>+ =C2=A0 =C2=
=A0/* Check order bounds */<br>+ =C2=A0 =C2=A0if (s-&gt;order &lt; 3 || s-&=
gt;order &gt; xlen) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quo=
t;order must be between 3 and %d&quot;, xlen);<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return;<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=
=A0/* Check base alignment */<br>=C2=A0 =C2=A0 =C2=A0if (s-&gt;order &lt; x=
len &amp;&amp; (s-&gt;base &amp; (BIT(s-&gt;order) - 1))) {<br>- =C2=A0 =C2=
=A0 =C2=A0 =C2=A0error_setg(errp, &quot;Base not aligned to order&quot;);<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;base not aligned to o=
rder&quot;);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0 =C2=A0 =
=C2=A0}<br>=C2=A0}<br>@@ -339,47 +353,85 @@ static void set_assign(Object *=
obj, bool val, Error **err)<br>=C2=A0 =C2=A0 =C2=A0s-&gt;assign =3D val;<br=
>=C2=A0}<br>=C2=A0<br>+static void set_possible_harts(Object *obj, const ch=
ar *str, Error **err)<br>+{<br>+ =C2=A0 =C2=A0OpenSBIDomainState *s =3D OPE=
NSBI_DOMAIN(obj);<br>+ =C2=A0 =C2=A0const char *firstcpu, =C2=A0*firstcpu_e=
nd, *lastcpu;<br>+<br>+ =C2=A0 =C2=A0firstcpu =3D str;<br>+ =C2=A0 =C2=A0if=
 (qemu_strtoul(firstcpu, &amp;firstcpu_end, 0,<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;s-&gt;first_possible_=
hart) &lt; 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(err, &quot;could=
 not convert firstcpu&quot;);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>+ =
=C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0lastcpu =3D qemu_strchrnul(str, &#39;=
-&#39;);<br>+ =C2=A0 =C2=A0if (*lastcpu) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
if (lastcpu !=3D firstcpu_end) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0error_setg(err, &quot;could not separate firstcpu and lastcpu&quot;);=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0lastcpu++;<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (qemu_strtoul(lastcpu, NULL, 0,<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;=
s-&gt;last_possible_hart) &lt; 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0error_setg(err, &quot;could not convert lastcpu&quot;);<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}=
<br>+ =C2=A0 =C2=A0} else {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;last_poss=
ible_hart =3D s-&gt;first_possible_hart;<br>+ =C2=A0 =C2=A0}<br>+}<br>+<br>=
=C2=A0static void opensbi_domain_instance_init(Object *obj)<br>=C2=A0{<br>=
=C2=A0 =C2=A0 =C2=A0int i;<br>=C2=A0 =C2=A0 =C2=A0OpenSBIDomainState *s =3D=
 OPENSBI_DOMAIN(obj);<br>=C2=A0<br>+ =C2=A0 =C2=A0s-&gt;boot_hart =3D VIRT_=
CPUS_MAX;<br>=C2=A0 =C2=A0 =C2=A0object_property_add_uint32_ptr(obj, &quot;=
boot-hart&quot;, &amp;s-&gt;boot_hart,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 OBJ_PROP_FLAG_WRITE);<br>=C2=A0 =C2=A0 =C2=A0object_pr=
operty_set_description(obj, &quot;boot-hart&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;The HART booting the domain ins=
tance.&quot;);<br>=C2=A0<br>- =C2=A0 =C2=A0object_property_add_uint64_ptr(o=
bj, &quot;possible-harts&quot;, &amp;s-&gt;possible_harts,<br>- =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OBJ_PROP_FLAG_WRITE);<br>+ =C2=A0 =C2=A0=
s-&gt;first_possible_hart =3D -1;<br>+ =C2=A0 =C2=A0s-&gt;last_possible_har=
t =3D -1;<br>+ =C2=A0 =C2=A0object_property_add_str(obj, &quot;possible-har=
ts&quot;, NULL, set_possible_harts);<br>=C2=A0 =C2=A0 =C2=A0object_property=
_set_description(obj, &quot;possible-harts&quot;,<br>- =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;The list of CPUs for the domain instan=
ce, encoded as a bitmask&quot;);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;The contiguous list of CPUs for the domain instance,=
 specified as firstcpu[-lastcpu]&quot;);<br>=C2=A0<br>+ =C2=A0 =C2=A0s-&gt;=
next_arg1 =3D -1;<br>=C2=A0 =C2=A0 =C2=A0object_property_add_uint64_ptr(obj=
, &quot;next-arg1&quot;, &amp;s-&gt;next_arg1,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 OBJ_PROP_FLAG_WRITE);<br>=C2=A0 =C2=A0 =C2=A0ob=
ject_property_set_description(obj, &quot;next-arg1&quot;,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;The 64 bit next booting =
stage arg1 for the domain instance.&quot;);<br>=C2=A0<br>+ =C2=A0 =C2=A0s-&=
gt;next_addr =3D -1;<br>=C2=A0 =C2=A0 =C2=A0object_property_add_uint64_ptr(=
obj, &quot;next-addr&quot;, &amp;s-&gt;next_addr,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OBJ_PROP_FLAG_WRITE);<br>=C2=A0 =C2=A0 =C2=
=A0object_property_set_description(obj, &quot;next-addr&quot;,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;The 64 bit next b=
ooting stage address for the domain instance.&quot;);<br>=C2=A0<br>+ =C2=A0=
 =C2=A0s-&gt;next_mode =3D -1;<br>=C2=A0 =C2=A0 =C2=A0object_property_add_u=
int32_ptr(obj, &quot;next-mode&quot;, &amp;s-&gt;next_mode,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OBJ_PROP_FLAG_WRITE);<br>=C2=A0 =
=C2=A0 =C2=A0object_property_set_description(obj, &quot;next-mode&quot;,<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;The 32 bit=
 next booting stage mode for the domain instance.&quot;);<br>=C2=A0<br>+ =
=C2=A0 =C2=A0s-&gt;system_reset_allowed =3D false;<br>=C2=A0 =C2=A0 =C2=A0o=
bject_property_add_bool(obj, &quot;system-reset-allowed&quot;, NULL,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_sysreset_allowed);<br>=C2=A0 =C2=A0 =C2=A0o=
bject_property_set_description(obj, &quot;system-reset-allowed&quot;,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Whether th=
e domain instance is allowed to do system reset.&quot;);<br>=C2=A0<br>+ =C2=
=A0 =C2=A0s-&gt;system_suspend_allowed =3D false;<br>=C2=A0 =C2=A0 =C2=A0ob=
ject_property_add_bool(obj, &quot;system-suspend-allowed&quot;, NULL,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_suspend_allowed);<br>=C2=A0 =C2=A0 =C2=
=A0object_property_set_description(obj, &quot;system-suspend-allowed&quot;,=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Whether=
 the domain instance is allowed to do system suspend.&quot;);<br>=C2=A0<br>=
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; OPENSBI_DOMAIN_MEMREGIONS_MAX; i++=
) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;regions[i] =3D NULL;<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0g_autofree char *reg_propname =3D g_strdup_print=
f(&quot;region%i&quot;, i);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_pro=
perty_add_link(obj, reg_propname, TYPE_OPENSBI_MEMREGION,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (Object **) &amp;s-&gt;regions[i],<br>@@ -3=
90,6 +442,7 @@ static void opensbi_domain_instance_init(Object *obj)<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i, OPENSBI_DOMAI=
N_MEMREGIONS_MAX);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_set=
_description(obj, reg_propname, reg_description);<br>=C2=A0<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;region_perms[i] =3D 0;<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0g_autofree char *perm_propname =3D g_strdup_printf(&quot;perms%i&=
quot;, i);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_add_uint32_=
ptr(obj, perm_propname, &amp;s-&gt;region_perms[i],<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OBJ_PROP_FLAG_WRITE);<br>@@ -=
406,7 +459,43 @@ static void opensbi_domain_instance_init(Object *obj)<br>=
=C2=A0<br>=C2=A0static void opensbi_domain_realize(DeviceState *ds, Error *=
*errp)<br>=C2=A0{<br>- =C2=A0 =C2=A0/* Nothing to do */<br>+ =C2=A0 =C2=A0O=
penSBIDomainState *s =3D OPENSBI_DOMAIN(ds);<br>+<br>+ =C2=A0 =C2=A0if (s-&=
gt;boot_hart &gt;=3D VIRT_CPUS_MAX) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0error=
_setg(errp, &quot;boot hart larger than maximum number of CPUs (%d)&quot;,<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VIRT_CPUS_MAX)=
;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=
=A0 =C2=A0if (s-&gt;first_possible_hart =3D=3D -1) {<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (s-&gt;last_possible_hart !=3D -1) {<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0error_setg(errp,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;last possible hart set when fi=
rst possible hart unset&quot;);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0} else {<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;first_possible_hart &gt;=3D VIRT_CPU=
S_MAX) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp,<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &qu=
ot;first possible hart larger than maximum number of CPUs (%d)&quot;,<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VIRT_=
CPUS_MAX);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;la=
st_possible_hart !=3D -1) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
f (s-&gt;last_possible_hart &lt; s-&gt;first_possible_hart) {<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp,<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;last possible hart larger than first possible hart&quot;);<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (s-&gt;last_possible_hart &gt;=3D VIRT_CPUS_MAX) {<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp,<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &quot;last possible hart larger than maximum number of CPUS (=
%d)&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 VIRT_CPUS_MAX);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0}<br>=C2=A0}<br=
>=C2=A0<br>=C2=A0static void opensbi_domain_class_init(ObjectClass *oc, voi=
d *opaque)<br>diff --git a/include/hw/riscv/opensbi_domain.h b/include/hw/r=
iscv/opensbi_domain.h<br>index 61bcf1a296..bcce16a609 100644<br>--- a/inclu=
de/hw/riscv/opensbi_domain.h<br>+++ b/include/hw/riscv/opensbi_domain.h<br>=
@@ -34,8 +34,7 @@ struct OpenSBIDomainState {<br>=C2=A0 =C2=A0 =C2=A0/* pri=
vate */<br>=C2=A0 =C2=A0 =C2=A0OpenSBIMemregionState *regions[OPENSBI_DOMAI=
N_MEMREGIONS_MAX];<br>=C2=A0 =C2=A0 =C2=A0unsigned int region_perms[OPENSBI=
_DOMAIN_MEMREGIONS_MAX];<br>-<br>- =C2=A0 =C2=A0unsigned long possible_hart=
s;<br>+ =C2=A0 =C2=A0unsigned long first_possible_hart, last_possible_hart;=
<br>=C2=A0 =C2=A0 =C2=A0unsigned int boot_hart;<br>=C2=A0 =C2=A0 =C2=A0uint=
64_t next_arg1;<br>=C2=A0 =C2=A0 =C2=A0uint64_t next_addr;<br>-- <br>2.45.2=
<br><br><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Sun, Aug 4, 2024 at 12:04=E2=80=AFPM Daniel Henrique B=
arboza &lt;<a href=3D"mailto:dbarboza@ventanamicro.com" target=3D"_blank">d=
barboza@ventanamicro.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex"><br>
<br>
On 7/26/24 3:43 PM, Gregor Haas wrote:<br>
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
<br>
When I tried this example the following error is shown:<br>
<br>
qemu-system-riscv64 -M virt (...)<br>
=C2=A0 =C2=A0 =C2=A0-device opensbi-memregion,id=3Dmem,base=3D0x178000000,s=
ize=3D0x4000000,mmio=3Dfalse<br>
=C2=A0 =C2=A0 =C2=A0-device opensbi-domain,possible-harts=3D0x2,boot-hart=
=3D0x1,next-addr=3D0x178000000,next-mode=3D1,region0=3Dmem,perms0=3D0x3f<br=
>
qemu-system-riscv64: -device opensbi-memregion,id=3Dmem,base=3D0x178000000,=
size=3D0x4000000,mmio=3Dfalse: Property &#39;opensbi-memregion.size&#39; no=
t found<br>
<br>
And in fact we don&#39;t have a &#39;size&#39; property declared in opensbi=
_memregion_instance_init().<br>
We also don&#39;t have a &#39;size&#39; field in OpenSBIMemregionState. I g=
uess that this might be<br>
a reminiscent of a previous prototype that had this field.<br>
<br>
If I remove this prop from the command line I have now this error:<br>
<br>
qemu-system-riscv64 -M virt (...)<br>
=C2=A0 =C2=A0 =C2=A0-device opensbi-memregion,id=3Dmem,base=3D0x178000000,m=
mio=3Dfalse<br>
=C2=A0 =C2=A0 =C2=A0-device opensbi-domain,possible-harts=3D0x2,boot-hart=
=3D0x1,next-addr=3D0x178000000,next-mode=3D1,region0=3Dmem,perms0=3D0x3f<br=
>
qemu-system-riscv64: -device opensbi-memregion,id=3Dmem,base=3D0x178000000,=
mmio=3Dfalse: Order too small<br>
<br>
<br>
Checking how &#39;order&#39; works, it must be 3 &lt;=3D order &lt;=3D __ri=
scv_xlen. I didn&#39;t<br>
set &#39;order&#39; and it said &quot;Order too small&quot; because there&#=
39;s no code to check<br>
if order&#39; was user set.<br>
<br>
I suggest setting a sane default for the field and, in case the user set th=
e<br>
wrong value, display an error message like &quot;order must be between 3 an=
d %d&quot;<br>
where %d would be the xlen used at the time. By &#39;sane&#39; default I me=
an a<br>
value that will be used in most common situations.<br>
<br>
In fact I suggest taking a second look at all the other properties to choos=
e<br>
good defaults, especially for the opensbi-domain device since it has a lot =
of<br>
mandatory attributes. For example &#39;next-addr&#39; can be set by default=
 to the<br>
&#39;base&#39; of its associated opensbi-memregion, IIUC.<br>
<br>
<br>
Thanks,<br>
<br>
Daniel<br>
<br>
<br>
<br>
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
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0hw/riscv/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 =C2=A0hw/riscv/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/riscv/opensbi_domain.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 428 ++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/riscv/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 =C2=A0include/hw/riscv/opensbi_domain.h |=C2=A0 51 ++++<br>
&gt;=C2=A0 =C2=A06 files changed, 494 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/riscv/opensbi_domain.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/riscv/opensbi_domain.h<br>
&gt; <br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index 98eddf7ae1..796c023a7b 100644<br>
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
&gt; +F: hw/riscv/opensbi_domain.c<br>
&gt; +F: include/hw/riscv/opensbi_domain.h<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0RENESAS RX CPUs<br>
&gt;=C2=A0 =C2=A0R: Yoshinori Sato &lt;<a href=3D"mailto:ysato@users.source=
forge.jp" target=3D"_blank">ysato@users.sourceforge.jp</a>&gt;<br>
&gt;=C2=A0 =C2=A0S: Orphan<br>
&gt; diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig<br>
&gt; index a2030e3a6f..db3a4d77ad 100644<br>
&gt; --- a/hw/riscv/Kconfig<br>
&gt; +++ b/hw/riscv/Kconfig<br>
&gt; @@ -1,6 +1,9 @@<br>
&gt;=C2=A0 =C2=A0config RISCV_NUMA<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +config RISCV_OPENSBI_DOMAIN<br>
&gt; +=C2=A0 =C2=A0 bool<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0config IBEX<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -40,6 +43,7 @@ config RISCV_VIRT<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0imply TPM_TIS_SYSBUS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select DEVICE_TREE<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select RISCV_NUMA<br>
&gt; +=C2=A0 =C2=A0 select RISCV_OPENSBI_DOMAIN<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select GOLDFISH_RTC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select PCI<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select PCI_EXPRESS_GENERIC_BRIDGE<br>
&gt; diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build<br>
&gt; index f872674093..f47626c164 100644<br>
&gt; --- a/hw/riscv/meson.build<br>
&gt; +++ b/hw/riscv/meson.build<br>
&gt; @@ -1,6 +1,7 @@<br>
&gt;=C2=A0 =C2=A0riscv_ss =3D ss.source_set()<br>
&gt;=C2=A0 =C2=A0riscv_ss.add(files(&#39;boot.c&#39;))<br>
&gt;=C2=A0 =C2=A0riscv_ss.add(when: &#39;CONFIG_RISCV_NUMA&#39;, if_true: f=
iles(&#39;numa.c&#39;))<br>
&gt; +riscv_ss.add(when: &#39;CONFIG_RISCV_OPENSBI_DOMAIN&#39;, if_true: fi=
les(&#39;opensbi_domain.c&#39;))<br>
&gt;=C2=A0 =C2=A0riscv_ss.add(files(&#39;riscv_hart.c&#39;))<br>
&gt;=C2=A0 =C2=A0riscv_ss.add(when: &#39;CONFIG_OPENTITAN&#39;, if_true: fi=
les(&#39;opentitan.c&#39;))<br>
&gt;=C2=A0 =C2=A0riscv_ss.add(when: &#39;CONFIG_RISCV_VIRT&#39;, if_true: f=
iles(&#39;virt.c&#39;))<br>
&gt; diff --git a/hw/riscv/opensbi_domain.c b/hw/riscv/opensbi_domain.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..418ebe1e56<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/riscv/opensbi_domain.c<br>
&gt; @@ -0,0 +1,428 @@<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;hw/riscv/opensbi_domain.h&quot;<br>
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
&gt; +<br>
&gt; +=C2=A0 =C2=A0 num_cpus =3D ctpop64(s-&gt;possible_harts);<br>
&gt; +=C2=A0 =C2=A0 if (num_cpus) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree uint32_t *phandles =3D g_mallo=
c0_n(num_cpus, sizeof(uint32_t));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0, cpu =3D -1; i &lt; num_cpus=
; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu =3D find_next_bit(&amp;=
s-&gt;possible_harts, BITS_PER_LONG, cpu + 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *cpu_name =
=3D g_strdup_printf(&quot;/cpus/cpu@%li&quot;, cpu);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 phandles[i] =3D cpu_to_fdt3=
2(qemu_fdt_get_phandle(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 ms-&gt;fdt, cpu_name));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_setprop(ms-&gt;fdt, path, &quot;=
possible-harts&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0phandles, num_cpus * 4);<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree uint32_t *regions =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_mallo=
c0_n(num_regions, 2 * sizeof(uint32_t));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; OPENSBI_DOMAIN_MEMRE=
GIONS_MAX; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;regions[i]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ds =3D DEVICE=
(s-&gt;regions[i]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree ch=
ar *region_name =3D g_strdup_printf(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0&quot;/chosen/opensbi-domains/%s&quot;, ds-&gt;id);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regions[2 * i=
] =3D cpu_to_fdt32(qemu_fdt_get_phandle<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 (ms-&gt;fdt, region_name));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regions[2 * i=
 + 1] =3D cpu_to_fdt32(s-&gt;region_perms[i]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_setprop(ms-&gt;fdt, path, &quot;=
regions&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0regions, num_regions * 8);<br>
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
&gt; +=C2=A0 =C2=A0 g_autofree char *path, *cpu_name;<br>
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
&gt; +=C2=A0 =C2=A0 if (s-&gt;assign) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_setprop_cell(ms-&gt;fdt, cpu_nam=
e, &quot;opensbi-domain&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_get_phandle(ms-&gt;fdt, path))=
;<br>
&gt; +=C2=A0 =C2=A0 }<br>
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
&gt; +}<br>
&gt; +<br>
&gt; +static void create_fdt_one_memregion(MachineState *ms,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OpenSBIMemre=
gionState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 g_autofree char *path;<br>
&gt; +=C2=A0 =C2=A0 int i, dev, num_devices;<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree uint32_t *devices =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_malloc0_n(n=
um_devices, sizeof(uint32_t));<br>
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
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_fdt_setprop_cells(ms-&gt;fdt, path, &quot;phandle&=
quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_fdt_alloc_phandle(ms-&gt;fdt));<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *propname =3D g_strdup_pr=
intf(&quot;device%i&quot;, i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_add_str(obj, propname, NU=
LL, set_device);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *description =3D g_strdup=
_printf(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Device =
%i (out of %i) for this memregion. This property should be a device tree pa=
th to the device.&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i, OPENSBI_DO=
MAIN_MEMREGIONS_MAX);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_description(obj, prop=
name, description);<br>
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
&gt; +static void set_assign(Object *obj, bool val, Error **err)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 OpenSBIDomainState *s =3D OPENSBI_DOMAIN(obj);<br>
&gt; +=C2=A0 =C2=A0 s-&gt;assign =3D val;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void opensbi_domain_instance_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *reg_propname =3D g_strdu=
p_printf(&quot;region%i&quot;, i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_add_link(obj, reg_propnam=
e, TYPE_OPENSBI_MEMREGION,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(Object **) &amp;s-&gt;reg=
ions[i],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_prop_allow_set_link_b=
efore_realize, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *reg_description =3D g_st=
rdup_printf(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Region =
%i (out of %i) for this domain.&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i, OPENSBI_DO=
MAIN_MEMREGIONS_MAX);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_description(obj, reg_=
propname, reg_description);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *perm_propname =3D g_strd=
up_printf(&quot;perms%i&quot;, i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_add_uint32_ptr(obj, perm_=
propname, &amp;s-&gt;region_perms[i],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OBJ_P=
ROP_FLAG_WRITE);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *perm_description =3D g_s=
trdup_printf(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Permiss=
ions for region %i for this domain.&quot;, i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_description(obj, perm=
_propname, perm_description);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 object_property_add_bool(obj, &quot;assign&quot;, NULL,=
 set_assign);<br>
&gt; +=C2=A0 =C2=A0 object_property_set_description(obj, &quot;assign&quot;=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Whether to a=
ssign this domain to its boot hart.&quot;);<br>
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
&gt; diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c<br>
&gt; index 9981e0f6c9..bb4bf3ce5b 100644<br>
&gt; --- a/hw/riscv/virt.c<br>
&gt; +++ b/hw/riscv/virt.c<br>
&gt; @@ -55,6 +55,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/acpi/aml-build.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;qapi/qapi-visit-common.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/virtio/virtio-iommu.h&quot;<br>
&gt; +#include &quot;hw/riscv/opensbi_domain.h&quot;<br>
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
&gt; +=C2=A0 =C2=A0 create_fdt_opensbi_domains(MACHINE(s));<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void create_fdt(RISCVVirtState *s, const MemMapEntr=
y *memmap)<br>
&gt; diff --git a/include/hw/riscv/opensbi_domain.h b/include/hw/riscv/open=
sbi_domain.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..61bcf1a296<br>
&gt; --- /dev/null<br>
&gt; +++ b/include/hw/riscv/opensbi_domain.h<br>
&gt; @@ -0,0 +1,51 @@<br>
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
&gt; +<br>
&gt; +=C2=A0 =C2=A0 bool assign;<br>
&gt; +};<br>
&gt; +<br>
&gt; +void create_fdt_opensbi_domains(MachineState *s);<br>
&gt; +<br>
&gt; +#endif /* RISCV_DOMAIN_H */<br>
</blockquote></div>

--0000000000002a3c30061ef55865--

