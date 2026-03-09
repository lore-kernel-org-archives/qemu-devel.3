Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A48F417EE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbyG-00051N-1F; Mon, 09 Mar 2026 10:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbwV-0003jX-H2
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:50:50 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbwT-0005ge-LY
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:50:47 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso95417395e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773067844; x=1773672644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9IQmVwB2igYY3QUbm8smw1vlxDB9vgMK4ANQ4xk3vr0=;
 b=U6XCnyWqly/ZBEeqoIA9g//naPnC+pJ2lUhQa+kpbRby+1RNqpBn7IYw34nCRpuEq7
 0D6s5MOlstDdX7Qxovp54AMxvPSQkOylef4ueLqQDS56yi3hYNRyOcFOGFs8KRTdHm8A
 EvKaM5MzoTGeNuXCJF/vAP829IWm47Rm4pW1i5BphqBBPeNH3b8yWsg1jNsvqHjgx11K
 HpTxZE9kT/JFRXsYAXOVSp6vCtJtCrdL/yQVGrOS+1Nl5CrpbXrCGF/SZHAVQnyPVj7V
 lHWmyJ2G21GdgqOOoNAuItLtYJaabZi6/qte97BnZ7AgSuOHMg483C+trZiOBvD439VG
 jmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067844; x=1773672644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9IQmVwB2igYY3QUbm8smw1vlxDB9vgMK4ANQ4xk3vr0=;
 b=OjnO1z7mQ2/32TqfgZIexn/Ljb0NWzGjbCyrXpGd4rPBjl3ME7fNmVR4k+KsuGBlsG
 A4mhrHzqYKWUERoH2nlunT7SDeuiUWSjA5MG+F88SMbq3uJdTOGfQ2Q/NSFYruzrWPZj
 RE9O8nOZRFf2Vic3vwxAP1cmdXjwwlQ60p8KbLKjW6jL2GiqCel8SLpN/DGebD6qiO+F
 hlZsQzm98gp+Blk1B59/BXg4J7Q5/PlPFrhlLg+P3BjycUXNAoL1t/JQDVqHwrBamGCI
 SgBbYJR/BWTh+1eGH73/01z/4RyDI62OvEmEAcoTHlRfL4fpRCmzDD6H0erAdlqDxlwr
 zWrg==
X-Gm-Message-State: AOJu0YyIYL5CL9/lBOfQdIgsbcO3aRSuR7D76FNeFfjWRFua7uBCIea8
 oh+d4v66PEti81zRMx/CD0u3oAXLQmc2MM40GafLgtanc2Jw52lY14Aufesl3JKB3QgMWTHqp/v
 6kWTV8po=
X-Gm-Gg: ATEYQzybK3yKyvH99n7eMGk7MciwPntdRbDazVdOziH0pPEStnGl8ZPw57hu5b3U6OC
 kY1RSVD0YJNSV/5t1kRTOM6DckQmLFZp9xQ4CRmlSqVvM7PCpTrNHPKWxtbqFOi9S37pbp+/7No
 sp0haSPQxoN6FFgYtccHw7KSPWfZD/hDr7eX8kF9RF7Z3Sgz/pt6dapzIMZ626+GJoTazEM5vcP
 rFL/FBeFNeK2URVmywJThmnCAURu+hDjv3QDhp9fCh0qu0cMMwYk1hCspRKYqy7zeNm0/SmGygY
 cvwDemmXiWO0mxf//s2GXSms8p1h3kiIZDhR7QhMuamqxcwA94s8TUfCVaz1tcx8ydG1/rCopoG
 61FRQNPjMjQQkhRQT1bpQzCpwdzOxO16A/V/hHDliYBFsWhpqJW1771w8HPtxZGGmwUqyTgv2IA
 9NK9fTk1sVN7Nv52uC/5RezqitrSQd3dsA2r0hcb4hBDanXkqAIYuHOQZg08M4lkAG67qHyXmUk
 quDKg==
X-Received: by 2002:a05:600c:b95:b0:483:7980:4687 with SMTP id
 5b1f17b1804b1-48526951b71mr201450145e9.17.1773067843736; 
 Mon, 09 Mar 2026 07:50:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fae00absm344874895e9.4.2026.03.09.07.50.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 07:50:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Corey Minyard <cminyard@mvista.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v2 04/10] hw/core/boards: Remove
 MachineClass::smbus_no_migration_support field
Date: Mon,  9 Mar 2026 15:50:06 +0100
Message-ID: <20260309145013.44327-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309145013.44327-1-philmd@linaro.org>
References: <20260309145013.44327-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

The MachineClass::smbus_no_migration_support boolean was only used
by the pc-q35-3.1 and pc-i440fx-3.1 machines, which got removed.
Remove it, along with pm_smbus_vmstate_needed().

Use the unconditional VMSTATE_BOOL() and VMSTATE_STRUCT() macros.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260307152635.83893-5-philmd@linaro.org>
---
 include/hw/core/boards.h  |  1 -
 include/hw/i2c/pm_smbus.h |  7 -------
 hw/acpi/piix4.c           |  8 +-------
 hw/i2c/pm_smbus.c         |  7 -------
 hw/i2c/smbus_eeprom.c     |  4 +---
 hw/i2c/smbus_ich9.c       | 10 ++--------
 6 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index 9ad2a7d5c97..e15dbcea83b 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -314,7 +314,6 @@ struct MachineClass {
     bool auto_enable_numa_with_memhp;
     bool auto_enable_numa_with_memdev;
     bool ignore_boot_device_suffixes;
-    bool smbus_no_migration_support;
     bool nvdimm_supported;
     bool numa_mem_supported;
     bool auto_enable_numa;
diff --git a/include/hw/i2c/pm_smbus.h b/include/hw/i2c/pm_smbus.h
index dafe0df4f69..62bbd45e803 100644
--- a/include/hw/i2c/pm_smbus.h
+++ b/include/hw/i2c/pm_smbus.h
@@ -44,13 +44,6 @@ typedef struct PMSMBus {
 
 void pm_smbus_init(DeviceState *parent, PMSMBus *smb, bool force_aux_blk);
 
-/*
- * For backwards compatibility on migration, older versions don't have
- * working migration for pm_smbus, this lets us ignore the migrations
- * for older machine versions.
- */
-bool pm_smbus_vmstate_needed(void);
-
 extern const VMStateDescription pmsmb_vmstate;
 
 #endif /* PM_SMBUS_H */
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 138ac3d3940..43860d12278 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -205,11 +205,6 @@ static const VMStateDescription vmstate_cpuhp_state = {
     }
 };
 
-static bool piix4_vmstate_need_smbus(void *opaque, int version_id)
-{
-    return pm_smbus_vmstate_needed();
-}
-
 /*
  * This is a fudge to turn off the acpi_index field,
  * whose test was always broken on piix4 with 6.2 and older machine types.
@@ -238,8 +233,7 @@ static const VMStateDescription vmstate_acpi = {
         VMSTATE_UINT16(ar.pm1.evt.en, PIIX4PMState),
         VMSTATE_UINT16(ar.pm1.cnt.cnt, PIIX4PMState),
         VMSTATE_STRUCT(apm, PIIX4PMState, 0, vmstate_apm, APMState),
-        VMSTATE_STRUCT_TEST(smb, PIIX4PMState, piix4_vmstate_need_smbus, 3,
-                            pmsmb_vmstate, PMSMBus),
+        VMSTATE_STRUCT(smb, PIIX4PMState, 3, pmsmb_vmstate, PMSMBus),
         VMSTATE_TIMER_PTR(ar.tmr.timer, PIIX4PMState),
         VMSTATE_INT64(ar.tmr.overflow_time, PIIX4PMState),
         VMSTATE_STRUCT(ar.gpe, PIIX4PMState, 2, vmstate_gpe, ACPIGPE),
diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index ead53d2724d..5654d516382 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -443,13 +443,6 @@ static const MemoryRegionOps pm_smbus_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-bool pm_smbus_vmstate_needed(void)
-{
-    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
-
-    return !mc->smbus_no_migration_support;
-}
-
 const VMStateDescription pmsmb_vmstate = {
     .name = "pmsmb",
     .version_id = 1,
diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index d9ac556a0ab..693d4762205 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -88,11 +88,9 @@ static int eeprom_write_data(SMBusDevice *dev, uint8_t *buf, uint8_t len)
 
 static bool smbus_eeprom_vmstate_needed(void *opaque)
 {
-    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
     SMBusEEPROMDevice *eeprom = opaque;
 
-    return (eeprom->accessed || smbus_vmstate_needed(&eeprom->smbusdev)) &&
-        !mc->smbus_no_migration_support;
+    return eeprom->accessed || smbus_vmstate_needed(&eeprom->smbusdev);
 }
 
 static const VMStateDescription vmstate_smbus_eeprom = {
diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
index 956c9b59bbc..51513e73fde 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -41,20 +41,14 @@ struct ICH9SMBState {
     PMSMBus smb;
 };
 
-static bool ich9_vmstate_need_smbus(void *opaque, int version_id)
-{
-    return pm_smbus_vmstate_needed();
-}
-
 static const VMStateDescription vmstate_ich9_smbus = {
     .name = "ich9_smb",
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, ICH9SMBState),
-        VMSTATE_BOOL_TEST(irq_enabled, ICH9SMBState, ich9_vmstate_need_smbus),
-        VMSTATE_STRUCT_TEST(smb, ICH9SMBState, ich9_vmstate_need_smbus, 1,
-                            pmsmb_vmstate, PMSMBus),
+        VMSTATE_BOOL(irq_enabled, ICH9SMBState),
+        VMSTATE_STRUCT(smb, ICH9SMBState, 1, pmsmb_vmstate, PMSMBus),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.53.0


