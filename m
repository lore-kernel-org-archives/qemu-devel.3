Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71415CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZAW-00079l-NA; Tue, 16 Jun 2026 15:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8S-0004iD-NF
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:49 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8L-00012q-49
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:41 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490b7866869so50207435e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636842; x=1782241642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fPpiudd5fPqHqruORX0t6CTsOwaDw0XajqAXoTO5iOk=;
 b=G7eNjsgp53lDwJPVzNLOb0kOJkFh4GeWM5oD5u2QMjRByffWHoX7i0wKPnbk6NUSAL
 jfKEOyQOdAD7IOEyHrVbwlIPh8re9HpMyC7VL46mdbrfobxvOk1lsvVSHjAWvfkW2RkZ
 ZOd6H2fEF3x6iuliAONIN3cinT/S6c27sta4woVHtn4Qldib9WYVRJwso/kdt6hupKxn
 hGCngnetyN+QljW2uAl30If5uJdl3GGXoyoGsKUVAig2M6XPY8QX3n6Ki+2SRlB0U3X1
 5Fmjlp2pjJMuEDjs28vPHs4xlxCZLIvy6fw2pkVONUSjGiabRyhorcZQillT94boS8WN
 iXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636842; x=1782241642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fPpiudd5fPqHqruORX0t6CTsOwaDw0XajqAXoTO5iOk=;
 b=a2EZ38BDk9tExZH0euFRM/dIaexgxU4b+tchN0f5te9A0uzMjGD6xCCCdbBRMthqRr
 EfULj+BqH6KrlTkdtBp6Vja9eCdVzGe1OrGUoNOecd/n9I5g7kGeZqyVCW08z/M7SW+u
 9vSHWjL1o8zip5r4+pGcBbJRmayeiWbVB3xEvOgfdzW5RLeYjMX/MxpfV3ykfch9WvYE
 agFS5DjShLMzE3iuSvj285T/ifrhu45TCePGbSW0Kcsfdeuxf/qsCIxjytruxVMpdnwj
 7aY2IipzWE7W/lASivKBu54UkwknexhsXCyirAkvNdEz63XcA0IUMJRN0L/0F1A3GTOh
 sceg==
X-Gm-Message-State: AOJu0YzmMZ0axTWqCmU/gwSoydsvNEdnUBTrBYZ3Kd5oIypFBiywSrnc
 UswYytUuvg58U4HDJawh5LIHpO7Uwcq/sS7lv1IFd6JZD5pShDveAI/s9hgKaBGOPvqM3vwVthR
 r4lEq
X-Gm-Gg: Acq92OHSQXWzHt41gezMOIrsQ+kdx4Ooa7hUsny/5ksEm7JKZ0PboCepEmbIqfK1AP2
 iHnhO1zNn3MM5W2CtVR5HfZlIyysuiV/X+IebfCB+N8zZHU1ymUOIAJi8E9vfqLY2joYi3X2cNY
 i6HVm2qrqstE7o95nh7HXftpGufcmSx1rjIPffx8K3+rfXghvYE/Bt5QKdP0LOeOOKFgG6uulTS
 9Vo1eYFb8jo/f7HhkFIVlPDC6JNtbVE6vpaAx83e3YB5i18CCWBpgBayIsCcGpZv0Pwk8W8ERcv
 sJTRRFSDiPUwUvwBTjJNUZyncSa4KYhD3TwdPYO6FOq/5i92pwWms1zefHvn6L0Q+0CtnqAZCEe
 xejRlLPCYzH39su1l8pEnOnMZtm5vweOlZbpfr9lyQRN8mX3L4vcsWyUrip7q4xvBm87xlHehG1
 svcLGMmdNbpsZui5hVgF97xVxCSFXzuQkD4PbME7Fh8JNngyV+O5KM8Q/UJ6Us9D2ozbSC6IHWc
 ku8Dk1SMUV2+7tJU1XBX6A2G4gaoIOq
X-Received: by 2002:a05:600c:4747:b0:492:1e36:bafc with SMTP id
 5b1f17b1804b1-492333df104mr11337985e9.36.1781636842267; 
 Tue, 16 Jun 2026 12:07:22 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/61] hw/arm/smmuv3: Add per-device identifier property
Date: Tue, 16 Jun 2026 20:06:13 +0100
Message-ID: <20260616190639.3462006-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

Add an "identifier" property to the SMMUv3 device and use it when
building the ACPI IORT SMMUv3 node Identifier field.

This avoids relying on device enumeration order and provides a stable
per-device identifier. A subsequent patch will use the same identifier
when generating the DSDT description for Tegra241 CMDQV, ensuring that
the IORT and DSDT entries refer to the same SMMUv3 instance.

The identifier is assigned at pre-plug time, accounting for the ITS Group
node that build_iort() places before SMMUv3 nodes in the IORT table, so
that identifiers are globally unique across all IORT nodes.

No functional change: IORT blob content for bios-tables qtest is identical
to before.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260609112552.378999-27-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c          |  2 ++
 hw/arm/virt-acpi-build.c |  5 ++++-
 hw/arm/virt.c            | 12 ++++++++++++
 include/hw/arm/smmuv3.h  |  1 +
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 83fa6468fd..a8fb10e531 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2126,6 +2126,8 @@ static const Property smmuv3_properties[] = {
      * Defaults to stage 1
      */
     DEFINE_PROP_STRING("stage", SMMUv3State, stage),
+    /* Identifier used for ACPI IORT SMMUv3 (and DSDT for CMDQV) generation */
+    DEFINE_PROP_UINT8("identifier", SMMUv3State, identifier, 0),
     DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
     /* GPA of MSI doorbell, for SMMUv3 accel use. */
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index b00f3477ca..9d05982137 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -349,6 +349,7 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
 typedef struct AcpiIortSMMUv3Dev {
     int irq;
     hwaddr base;
+    uint8_t id;
     GArray *rc_smmu_idmaps;
     /* Offset of the SMMUv3 IORT Node relative to the start of the IORT */
     size_t offset;
@@ -411,6 +412,7 @@ static int populate_smmuv3_dev(VirtMachineState *vms, GArray *sdev_blob)
                                                &error_abort));
         sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
         sdev.ats = smmuv3_ats_enabled(ARM_SMMUV3(obj));
+        sdev.id = object_property_get_uint(obj, "identifier", &error_abort);
         pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
         sbdev = SYS_BUS_DEVICE(obj);
         sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
@@ -637,7 +639,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                      (ID_MAPPING_ENTRY_SIZE * smmu_mapping_count);
         build_append_int_noprefix(table_data, node_size, 2); /* Length */
         build_append_int_noprefix(table_data, 4, 1); /* Revision */
-        build_append_int_noprefix(table_data, id++, 4); /* Identifier */
+        build_append_int_noprefix(table_data, sdev->id, 4); /* Identifier */
+        id++;  /* advance shared counter for RC/RMR node uniqueness */
         /* Number of ID mappings */
         build_append_int_noprefix(table_data, smmu_mapping_count, 4);
         /* Reference to ID Array */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 2add7401a1..d8d27f2ef6 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -254,6 +254,9 @@ static MemMapEntry extended_memmap[] = {
     /* Any CXL Fixed memory windows come here */
 };
 
+/* Counts SMMUv3 devices plugged; used to assign stable IORT identifiers */
+static uint8_t smmuv3_dev_id;
+
 static const int a15irqmap[] = {
     [VIRT_UART0] = 1,
     [VIRT_RTC] = 2,
@@ -3830,6 +3833,15 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                      OBJECT(vms->sysmem), NULL);
             object_property_set_link(OBJECT(dev), "secure-memory",
                                      OBJECT(vms->secure_sysmem), NULL);
+            /*
+             * In build_iort(), the ITS node(id=0) precedes SMMUv3 nodes
+             * when present. Account for it so this SMMUv3's identifier
+             * is globally unique across all IORT nodes.
+             */
+            uint8_t its_offset = (vms->msi_controller == VIRT_MSI_CTRL_ITS)
+                                  ? 1 : 0;
+            object_property_set_uint(OBJECT(dev), "identifier",
+                                     its_offset + smmuv3_dev_id++, NULL);
         }
         if (object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
             hwaddr db_start = 0;
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 34d0f65eaa..d39fe8850b 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -65,6 +65,7 @@ struct SMMUv3State {
     qemu_irq     irq[4];
     QemuMutex mutex;
     char *stage;
+    uint8_t identifier;
 
     /* SMMU has HW accelerator support for nested S1 + s2 */
     bool accel;
-- 
2.43.0


