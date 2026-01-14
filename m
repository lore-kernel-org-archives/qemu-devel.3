Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015E3D3901A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 20:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg7qP-0006aa-1b; Wed, 14 Jan 2026 15:51:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vg7qG-0006Vy-0U
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 15:51:49 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vg7qD-0007d0-TS
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 15:51:47 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47d1d8a49f5so1571255e9.3
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 12:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768423901; x=1769028701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dURWTwQjpi14GLALSao2JHKXBlPcptXhhohXVZcLBnM=;
 b=YGkXLS/HWxPXgZI0O8vviw/sBPXd4HXl7Evon00od0SkgJT6eZooRk5MLfxVQT/RQN
 6Ty14TVUHbgVzZxZBJimY1hA0oVOXzMaLMfScZWxSaG7c8RgrmhH/j5IcvqSaEM6gp5R
 2BTmi7YYrkv2RHVYlxQ0BYopHvGKuzTbmYrVl+Rd9bnP0KVVdV1sSzSNABDyZVPoUfsJ
 KgwVY6WmxMjj4JI9+dPQZVMPwBc7nxF12YbbZxqqDCzf7c2TrvN09w6h8mFwboHPDCG7
 Z3Vjb4JC6pJZv8SEiV2LT5Id0eCoMz85tXpNW0emL6+TQw7y6KLCakV/WJjQY9LJ4inB
 NjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768423901; x=1769028701;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dURWTwQjpi14GLALSao2JHKXBlPcptXhhohXVZcLBnM=;
 b=nzQJRp1gPAiprWUWSgEtY6uEZixQSYJppvW+IdxI29n3mz7mxxJVeUAZwORGmA0Uuv
 KLC6qg3/zWlm1MDEjQ2Dmps7Rqgh1B5hl/qGCE4mL9phobWC7gTymaldbdJ1yNSb7ZMF
 xReZQuCE3QgaIYxCERVxpzRvA3MpUvh8Q6bpAgA0KOgva8hQqZsaOumBncglSUHsxkf7
 nydbGXudSWJOUhV+90yTYhtK7IQ9e0++kevbaF6doDmKirNxFgvzv8uHYY1+TiOucd90
 RLx4piq9jfRIHmhzP4Lcgk2a+16erjoye92pwIZ8U1IP4ZwzOR8vy7QZvjUg5GJRjz+1
 KFGA==
X-Gm-Message-State: AOJu0YxgJgTQB8Twnyx7fs2mIupTWhgkSgyIBdlkpKynUsyMLwDYaowe
 dgA41ev4TTWLsl4lD9pXMXWWLPlAjFfsSK7t2q8yo2oJlufYwGxZP36cWHoSQQ==
X-Gm-Gg: AY/fxX7oSQVbyXC9K3oS0V5LVRWk7akhTSfKbh1VZTJyp+psYi8ORzu7pjUjwgbCfQe
 8YL+Y8rVnzbQ4OtadrVP8OY8+2uUXVNy96SlFvGDbf/11vIG4o7H44rsIvXOH0QG8NC+pU36WLn
 /6sdrnrU21kiUwe6i45GhHYAuAslJviu2ePy7Ppq4XwHaxSaUJqkxnQzIAIImvam8nxWiTNIa94
 jxdRKhaEc4Yy6WhB5Fx7w/HCE8OAyqAe51q7epK48Tdi05PU2g7TDRpD9A0O95R+b3qKAzML0wL
 eUNq6rUalFXj81q4mnLdQPFfmrr8qfxCdaxRAQ8slNIRkBbXyoRdQxJf9QFUuPMtJydANgbQcWr
 T40A+OGZ1w6ZfvVl5xVmfcmHf/6q2TRqLRFAhdTDN9jlj/C4Q3N2LTwMNmb2j78NCU4B15k6eGW
 AF2HWzXIpJfs189Xej0AjukPAv872u8FKT7gaQcCJgLClbV6lWyq/TH1CYq7dw9QT5kFgr0k8DX
 /YBxxYFOFLmg8okR6D+yxpqMvh8CTiW0Cw=
X-Received: by 2002:a05:600c:c3cb:20b0:47e:e946:3a59 with SMTP id
 5b1f17b1804b1-47ee9463c5fmr17569605e9.34.1768423901338; 
 Wed, 14 Jan 2026 12:51:41 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-24fe-2800-f91d-651c-a220-693b.310.pool.telefonica.de.
 [2a02:3100:24fe:2800:f91d:651c:a220:693b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4b2755absm11868855e9.15.2026.01.14.12.51.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 12:51:40 -0800 (PST)
Date: Wed, 14 Jan 2026 20:51:38 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 mohamed@unpredictable.fr
CC: qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>
Subject: Re: [PATCH v14 07/26] hw: arm: virt: rework MSI-X configuration
In-Reply-To: <20260114134143.26198-8-mohamed@unpredictable.fr>
References: <20260114134143.26198-1-mohamed@unpredictable.fr>
 <20260114134143.26198-8-mohamed@unpredictable.fr>
Message-ID: <05EEED6C-5A59-4DCB-9836-942E5C6505AD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 14=2E Januar 2026 13:41:24 UTC schrieb Mohamed Mediouni <mohamed@unpred=
ictable=2Efr>:
>Introduce a -M msi=3D argument to be able to control MSI-X support indepe=
ndently
>from ITS, as part of supporting GICv3 + GICv2m platforms=2E
>
>Remove vms->its as it's no longer needed after that change=2E
>
>Signed-off-by: Mohamed Mediouni <mohamed@unpredictable=2Efr>
>---
> hw/arm/virt-acpi-build=2Ec |  24 ++++++---
> hw/arm/virt=2Ec            | 108 +++++++++++++++++++++++++++++++--------
> include/hw/arm/virt=2Eh    |   4 +-
> 3 files changed, 108 insertions(+), 28 deletions(-)
>
>diff --git a/hw/arm/virt-acpi-build=2Ec b/hw/arm/virt-acpi-build=2Ec
>index 86024a1a73=2E=2E187dd4e272 100644
>--- a/hw/arm/virt-acpi-build=2Ec
>+++ b/hw/arm/virt-acpi-build=2Ec
>@@ -440,6 +440,17 @@ static void create_rc_its_idmaps(GArray *its_idmaps,=
 GArray *smmuv3_devs)
>     }
> }
>=20
>+/*
>+ * In the prior Qemu ACPI table handling, GICv2 configurations
>+ * had vms->its=3D1=2E=2E=2E That's broken=2E
>+ *
>+ * Match that assumption to match the existing ACPI tables that
>+ * have been shipping for quite a while=2E
>+ */
>+static int is_gicv2_acpi_workaround_needed(VirtMachineState *vms) {
>+    return vms->gic_version =3D=3D 2;
>+}
>+
> /*
>  * Input Output Remapping Table (IORT)
>  * Conforms to "IO Remapping Table System Software on ARM Platforms",
>@@ -473,7 +484,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
>         nb_nodes =3D num_smmus + 1; /* RC and SMMUv3 */
>         rc_mapping_count =3D rc_smmu_idmaps_len;
>=20
>-        if (virt_is_its_enabled(vms)) {
>+        if (virt_is_its_enabled(vms) || is_gicv2_acpi_workaround_needed(=
vms)) {
>             /*
>              * Knowing the ID ranges from the RC to the SMMU, it's possi=
ble to
>              * determine the ID ranges from RC that go directly to ITS=
=2E
>@@ -484,7 +495,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
>             rc_mapping_count +=3D rc_its_idmaps->len;
>         }
>     } else {
>-        if (virt_is_its_enabled(vms)) {
>+        if (virt_is_its_enabled(vms) || is_gicv2_acpi_workaround_needed(=
vms)) {
>             nb_nodes =3D 2; /* RC and ITS */
>             rc_mapping_count =3D 1; /* Direct map to ITS */
>         } else {
>@@ -499,7 +510,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
>     build_append_int_noprefix(table_data, IORT_NODE_OFFSET, 4);
>     build_append_int_noprefix(table_data, 0, 4); /* Reserved */
>=20
>-    if (virt_is_its_enabled(vms)) {
>+    if (virt_is_its_enabled(vms) || is_gicv2_acpi_workaround_needed(vms)=
) {
>         /* Table 12 ITS Group Format */
>         build_append_int_noprefix(table_data, 0 /* ITS Group */, 1); /* =
Type */
>         node_size =3D  20 /* fixed header size */ + 4 /* 1 GIC ITS Ident=
ifier */;
>@@ -518,7 +529,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
>         int smmu_mapping_count, offset_to_id_array;
>         int irq =3D sdev->irq;
>=20
>-        if (virt_is_its_enabled(vms)) {
>+        if (virt_is_its_enabled(vms) || is_gicv2_acpi_workaround_needed(=
vms)) {
>             smmu_mapping_count =3D 1; /* ITS Group node */
>             offset_to_id_array =3D SMMU_V3_ENTRY_SIZE; /* Just after the=
 header */
>         } else {
>@@ -611,7 +622,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
>             }
>         }
>=20
>-        if (virt_is_its_enabled(vms)) {
>+        if (virt_is_its_enabled(vms) || is_gicv2_acpi_workaround_needed(=
vms)) {
>             /*
>              * Map bypassed (don't go through the SMMU) RIDs (input) to
>              * ITS Group node directly: RC -> ITS=2E
>@@ -962,8 +973,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
>         }
>     }
>=20
>-    if (!(vms->gic_version !=3D VIRT_GIC_VERSION_2 && virt_is_its_enable=
d(vms))
>-     && !vms->no_gicv3_with_gicv2m) {
>+    if (virt_is_gicv2m_enabled(vms)) {
>         const uint16_t spi_base =3D vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_=
BASE;
>=20
>         /* 5=2E2=2E12=2E16 GIC MSI Frame Structure */
>diff --git a/hw/arm/virt=2Ec b/hw/arm/virt=2Ec
>index 553c7f62cc=2E=2E0e84ccd82c 100644
>--- a/hw/arm/virt=2Ec
>+++ b/hw/arm/virt=2Ec
>@@ -966,12 +966,12 @@ static void create_gic(VirtMachineState *vms, Memor=
yRegion *mem)
>=20
>     fdt_add_gic_node(vms);
>=20
>-    if (vms->gic_version !=3D VIRT_GIC_VERSION_2 && virt_is_its_enabled(=
vms)) {
>+    if (virt_is_its_enabled(vms)) {
>         create_its(vms);
>-    } else if (vms->gic_version !=3D VIRT_GIC_VERSION_2 && !vms->no_gicv=
3_with_gicv2m) {
>-        create_v2m(vms);
>-    } else if (vms->gic_version =3D=3D VIRT_GIC_VERSION_2) {
>+    } else if (virt_is_gicv2m_enabled(vms)) {
>         create_v2m(vms);
>+    } else {
>+        vms->msi_controller =3D VIRT_MSI_CTRL_NONE;
>     }
> }
>=20
>@@ -2710,32 +2710,93 @@ static void virt_set_highmem_mmio_size(Object *ob=
j, Visitor *v,
>=20
> bool virt_is_its_enabled(VirtMachineState *vms)
> {
>-    if (vms->its =3D=3D ON_OFF_AUTO_OFF) {
>+    switch (vms->msi_controller) {
>+    case VIRT_MSI_CTRL_NONE:
>         return false;
>-    }
>-    if (vms->its =3D=3D ON_OFF_AUTO_AUTO) {
>-        if (whpx_enabled()) {
>+    case VIRT_MSI_CTRL_ITS:
>+        return true;
>+    case VIRT_MSI_CTRL_GICV2M:
>+        return false;
>+    case VIRT_MSI_CTRL_AUTO:
>+        if (whpx_enabled() && whpx_irqchip_in_kernel()) {
>+            return false;
>+        }
>+        if (vms->gic_version =3D=3D VIRT_GIC_VERSION_2) {
>             return false;
>         }
>+        return true;
>     }
>-    return true;

With the last return statement removed, I get a spurious warning from MSYS=
2/x86_64 GCC 15=2E2: "control reaches end of non-void function"=2E

> }
>=20
>-static void virt_get_its(Object *obj, Visitor *v, const char *name,
>-                          void *opaque, Error **errp)
>+bool virt_is_gicv2m_enabled(VirtMachineState *vms)
>+{
>+    switch (vms->msi_controller) {
>+    case VIRT_MSI_CTRL_NONE:
>+        return false;
>+    default:
>+        return !virt_is_its_enabled(vms);
>+    }
>+}
>+
>+static char *virt_get_msi(Object *obj, Error **errp)
>+{
>+    VirtMachineState *vms =3D VIRT_MACHINE(obj);
>+    const char *val;
>+
>+    switch (vms->msi_controller) {
>+    case VIRT_MSI_CTRL_NONE:
>+        val =3D "off";
>+        break;
>+    case VIRT_MSI_CTRL_ITS:
>+        val =3D "its";
>+        break;
>+    case VIRT_MSI_CTRL_GICV2M:
>+        val =3D "gicv2m";
>+        break;
>+    case VIRT_MSI_CTRL_AUTO:
>+        val =3D "auto";
>+        break;
>+    }

Similar to the above I get a spurious warning: "'val' may be used uninitia=
lized in this function"=2E

Apparently the compiler doesn't notice that both switch statements handle =
all enums=2E I wonder why it can figure that out in other cases=2E=2E=2E

Other than that the series works for me!

Best regards,
Bernhard

>+    return g_strdup(val);
>+}
>+
>+static void virt_set_msi(Object *obj, const char *value, Error **errp)
> {
>+    ERRP_GUARD();
>     VirtMachineState *vms =3D VIRT_MACHINE(obj);
>-    OnOffAuto its =3D vms->its;
>=20
>-    visit_type_OnOffAuto(v, name, &its, errp);
>+    if (!strcmp(value, "auto")) {
>+        vms->msi_controller =3D VIRT_MSI_CTRL_AUTO; /* Will be overriden=
 later */
>+    } else if (!strcmp(value, "its")) {
>+        vms->msi_controller =3D VIRT_MSI_CTRL_ITS;
>+    } else if (!strcmp(value, "gicv2m")) {
>+        vms->msi_controller =3D VIRT_MSI_CTRL_GICV2M;
>+    } else if (!strcmp(value, "none")) {
>+        vms->msi_controller =3D VIRT_MSI_CTRL_NONE;
>+    } else {
>+        error_setg(errp, "Invalid msi value");
>+        error_append_hint(errp, "Valid values are auto, gicv2m, its, off=
\n");
>+    }
> }
>=20
>-static void virt_set_its(Object *obj, Visitor *v, const char *name,
>-                          void *opaque, Error **errp)
>+static bool virt_get_its(Object *obj, Error **errp)
> {
>     VirtMachineState *vms =3D VIRT_MACHINE(obj);
>=20
>-    visit_type_OnOffAuto(v, name, &vms->its, errp);
>+    return virt_is_its_enabled(vms);
>+}
>+
>+static void virt_set_its(Object *obj, bool value, Error **errp)
>+{
>+    VirtMachineState *vms =3D VIRT_MACHINE(obj);
>+
>+    if (value) {
>+        vms->msi_controller =3D VIRT_MSI_CTRL_ITS;
>+    } else if (vms->no_gicv3_with_gicv2m) {
>+        vms->msi_controller =3D VIRT_MSI_CTRL_NONE;
>+    } else {
>+        vms->msi_controller =3D VIRT_MSI_CTRL_GICV2M;
>+    }
> }
>=20
> static bool virt_get_dtb_randomness(Object *obj, Error **errp)
>@@ -3062,6 +3123,8 @@ static void virt_machine_device_pre_plug_cb(Hotplug=
Handler *hotplug_dev,
>             db_start =3D base_memmap[VIRT_GIC_V2M]=2Ebase;
>             db_end =3D db_start + base_memmap[VIRT_GIC_V2M]=2Esize - 1;
>             break;
>+        case VIRT_MSI_CTRL_AUTO:
>+            g_assert_not_reached();
>         }
>         resv_prop_str =3D g_strdup_printf("0x%"PRIx64":0x%"PRIx64":%u",
>                                         db_start, db_end,
>@@ -3452,13 +3515,18 @@ static void virt_machine_class_init(ObjectClass *=
oc, const void *data)
>                                           "guest CPU which implements th=
e ARM "
>                                           "Memory Tagging Extension");
>=20
>-    object_class_property_add(oc, "its", "OnOffAuto",
>-        virt_get_its, virt_set_its,
>-        NULL, NULL);
>+    object_class_property_add_bool(oc, "its", virt_get_its,
>+                                   virt_set_its);
>     object_class_property_set_description(oc, "its",
>                                           "Set on/off to enable/disable =
"
>                                           "ITS instantiation");
>=20
>+    object_class_property_add_str(oc, "msi", virt_get_msi,
>+                                  virt_set_msi);
>+    object_class_property_set_description(oc, "msi",
>+                                          "Set MSI settings=2E "
>+                                          "Valid values are auto/gicv2m/=
its/off");
>+
>     object_class_property_add_bool(oc, "dtb-randomness",
>                                    virt_get_dtb_randomness,
>                                    virt_set_dtb_randomness);
>@@ -3515,7 +3583,7 @@ static void virt_instance_init(Object *obj)
>     vms->highmem_redists =3D true;
>=20
>     /* Default allows ITS instantiation if available */
>-    vms->its =3D ON_OFF_AUTO_AUTO;
>+    vms->msi_controller =3D VIRT_MSI_CTRL_AUTO;
>     /* Allow ITS emulation if the machine version supports it */
>     vms->tcg_its =3D !vmc->no_tcg_its;
>     vms->no_gicv3_with_gicv2m =3D false;
>diff --git a/include/hw/arm/virt=2Eh b/include/hw/arm/virt=2Eh
>index 394b70c62e=2E=2Eff43bcb739 100644
>--- a/include/hw/arm/virt=2Eh
>+++ b/include/hw/arm/virt=2Eh
>@@ -101,6 +101,8 @@ typedef enum VirtIOMMUType {
>=20
> typedef enum VirtMSIControllerType {
>     VIRT_MSI_CTRL_NONE,
>+    /* This value is overriden at runtime=2E*/
>+    VIRT_MSI_CTRL_AUTO,
>     VIRT_MSI_CTRL_GICV2M,
>     VIRT_MSI_CTRL_ITS,
> } VirtMSIControllerType;
>@@ -147,7 +149,6 @@ struct VirtMachineState {
>     bool highmem_ecam;
>     bool highmem_mmio;
>     bool highmem_redists;
>-    OnOffAuto its;
>     bool tcg_its;
>     bool virt;
>     bool ras;
>@@ -217,5 +218,6 @@ static inline int virt_gicv3_redist_region_count(Virt=
MachineState *vms)
> }
>=20
> bool virt_is_its_enabled(VirtMachineState *vms);
>+bool virt_is_gicv2m_enabled(VirtMachineState *vms);
>=20
> #endif /* QEMU_ARM_VIRT_H */

