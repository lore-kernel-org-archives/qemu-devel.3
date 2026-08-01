Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865B3C5516F
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 00:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpxQZ-0004li-CI; Fri, 31 Jul 2026 20:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wpxQM-0004jQ-OT
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 20:18:02 -0400
Received: from sonic313-20.consmr.mail.gq1.yahoo.com ([98.137.65.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wpxQI-0001b6-SU
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 20:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1785543472; bh=em0LfYUuUVS4dEN9yvrJ5cV2XhQB99q5Rt9+dzqOtV8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=doRUbXE9lp7Rw1ayMqIEmMaOq61ZZ18P651yd9qLvqvHwwgEheT9s29kPcvdAeSzqcBy6E8q64wx5G5tndqx9taq34l+lIRQwVh6qnZDj/lM4u9Ld0DtB4WOY/ECilS30+DLMbC7kWpPRX5oWH+pkwTiG6QxiZU4kJz/0S4nCa44WZ0GwmuXqUGIsboRXuSc02t1bkqmzaTrhVa6l5rS5560B6VgTwIlYLZy7F+jPmBT3AAZ9Xo+loKmx/aYQG4/yzHHiFt8scqNqhVbCTB9ag3jA98bEEZHFwTqpem7kSeb15QrFszZ3jhRCyT10JkxnR6DkHxC5pNSdORxBPOkwg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1785543472; bh=yestQipyg8w6O7Lx6tHhvERxFQ0+EPj6fbFiGqFivaC=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=DTmMbpPHouEZffyYD8i9ETwRQGkBBS3lYG+EYg4WLNsBbUmCKx7dDieFyKWDTVTv2ZQr7+BovBgUXBxANgLu6pCmhha7XO38MurgyOGerYQbngzK9BVo8dhW37UX4pRfnKeYcWww8c5YNZGzk3hctyE3ffiDS5DLKUYkt+VbuY22X3yAJ6bn6DAOo1vVE1Q5Bax+QzIuGHNCalgMdNHMyiwe4L1OkOEZ6NY5JeXS/5MDXQnCOhen6UwzcwQKoI2/abeGb3iU2EEGH0+iAgq2pf+ixr13WwMdPP8jJ53daEMJalERFLwhm3ftGOGlLWb5Ccgud9ccq/ObmL6UmyJ4Dg==
X-YMail-OSG: ZBJJFDUVM1lYaflSIDnAPpefQzBjC4MCmcdUwDWYRCTlsqVtBUN8I3KXRUt7uwI
 _o4JXcUdynTxGYpD0TiJttBaPsU_GzIRhTB1wLEe2QaVIxdAu9l9STMG2Z1IJ3TSDlROqk7kwN16
 JtKWp68X16juyC.0rrf1wsK8xzlRAgE_hCR_TQUTVY8pv_Efo4B6HRuv6kHabfUBbH8k3204IAHL
 Cj3oK2qEcz8FiooQeLJWzHtVS8l.anoCfh5ln6uKgp01GArbjTRSJzoQJJTUpNPVSB_wwpC3le_g
 eQ1GKRYu_uDTT5k_XSICpSVlF3I5a6u9q3BZSiRZgKk_.MTmpFj0GTPhAxcflKfrK3WiToTmHCzX
 B9bvu3HZYjMmAiigmEj2GADLKskO2NRxO5TWYMJiWgHpwX8URruzNCuMulKfqWYG.sK7tt4dg1JT
 fUDhQhoQ6Dvk.HRKKyzjSvY_ZiNtMX1B94oueWt9PK.hKcmXsxxx3a54LH_tDpiEXLhUIvNB7hQN
 8eypeFZDIzUk1ChUmNWKp69KNNaHOf7dnB21Nmocr8vq855JFf.qoZ7pwQhtIu1kArw4Wl39eiIq
 rU.YIsEOfUkX_FbqMy2Ms_FGXMrtea122Z4Nz31bXsWE7.uObJ9WfBYUQHMcbB5.fwLulmeN5aPL
 KC_3HWLYLIw3AkjB5v8WHiOwCG4vzPm4GGV3xb8WCTVsmqVdVh2tXs8P.RKrjdSTIyfEQ6iHqxvU
 RlDmAabVweD5RlyfudSK7Az7ScWSTQKyytzQknB0bEeZLo2lYVTFNO9s5Weqxzbxz.8moPuS8.GP
 nbWqfYo0f1cSAkFRFPEL7rQf61B.kblH.6emi0IABxaxgpLzY4zeWmHU6WS8ZzJuie2LI83U1g25
 HUpa68WQC1XKpFm4wJDkb8ZHYB1b.S7AdrJkmHBRqdyq4nyi60KnLYSsJvIFgTqZv9aE6kpa.HCG
 n8l0wX8m5Prsg6Ft6UARtQKwUSjUM7gl0X0qEhFxAbkWdsmNc9NQQSSOfF83FQytVvRf7xlj5WPm
 G_sMbnLvkec7xseQ3w_fx97BbAkjgUgB06BqdvJpnUevZjiKA3AsXJb.bC0ehYnIAUCJccp9JIVX
 fESuncfIaoqdox8NDaGuoN9JlAzaVPXyMzAf4zT2TEDOahj6nthRmV2sNU_gdywJOiBprSxtF93N
 PDkSpcfb71ejOuzoIsypf7j..31h48pv1yvIIRfXgxEm_uSgWUDK4q2Vtniav7jwzgBayXvVSzAE
 5FwBEJCbrXNso2uWlpzeqWKhM.xU83jX6d98QXQI2bXjzpxx7V3CbjOazm2BdHDus9nONyLikHQA
 _e.7ZP8QMdssc0y4PoPNQPrzvLw8pHtNqtupbjCRNd9aTw7l9oENEAa2cvKa93T8YCAt9AgGiF17
 31Qu8vRvkrE2wOsenoJWGaCfcgVGyGDM._HoxaE47A8QJurAImSBcpVzy_XaLBBjOF3z5TQwvBW0
 a6vLYSvD3jVk9M5D.GsThs3R3_Cxe2Wa4dqPUd4_3NxiArQi8apD7PZWd1MtxflBbd8vTLokKbYT
 LfM0EBzVcMEVh8hAMd88I0qF3VOGFmerdA6aAJlDX2zHtQK7jCknrgKxbnYkVoZf_mxyBUsmF9gf
 bVU7kyspB3vjjAggfIw6Uwrdx2zuWnWcwz7ro3PHV7lxO4kbF.UQ8lp3jyZ9kCUJrPN2DigiZxMO
 CM5XKGIehm2d6nPi8anaRc1lqvWNoHkL64PXXLJU8WKriO3VITE13CmsywIT6aoBiz_jQS1cZGAs
 eETHs997pF_RXMPNkHh73JYq749g7v_EZsskKlZhSbXYYBwzNyUyDQCNwenpSZcEdkXMnLKMKA8h
 IVn_lFBSvaGXEeSJXinIrBetw7PGjXfCvKn_fBC4ZWyOmnn5N.2fuH4PlttdNkzA89Ua6DQvfSOq
 WRD1q35q3kM7bjPqG3DxAt8_hGdflXBG8Mi7YeTjij14kzr7czxyCgjMc9mOkguEJ2Y4QVwJlDWG
 12uXZAR_0EMafDOYNTy.X.iWDC.mJD0jYcISkAHk12zPIXmBNF92n.91OsI_XnBW9CQoLcBiqSRO
 Hr92UI4itq08LYLbjah0vdv6v3zYndoXg1jMClUmCQM6Qef9RqnmXPLmXLiiHmNgkx5agREnPAPR
 pFmM4XOO4Ms0jS9U0uoR4qSJK3geka0zvQXsTocst6puucZLXoyWYBezv63Q.Ovu6Cgu8No2hTsj
 dqrp5z65dUz6QAisb5jkubRhabtev1kG2Bxun.bAAfP3vR75XZw--
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 66360c73-547b-4fd8-8909-7c15d88570af
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.gq1.yahoo.com with HTTP; Sat, 1 Aug 2026 00:17:52 +0000
Received: by hermes--production-bf1-54b5569bdc-h5zdx (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 655a093bcead2c5289eeab02aa189b76; 
 Sat, 01 Aug 2026 00:17:49 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Jan Beulich <jbeulich@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v4 6/6] xen/igd: use custom option ROM if provided
Date: Fri, 31 Jul 2026 20:17:30 -0400
Message-ID: <20260801001737.16509-7-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260801001737.16509-1-brchuckz@aol.com>
References: <20260801001737.16509-1-brchuckz@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=98.137.65.83; envelope-from=brchuckz@aol.com;
 helo=sonic313-20.consmr.mail.gq1.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since in some cases the option ROM is not readable from sysfs
on the host, provide the option to use a custom option ROM file
instead that, for example, could be extracted from BIOS or UEFI
firmware and modified as needed for use with a particular Intel
IGD device.

The file must be named "igd.rom" and be located in a directory
configured at build time as a Qemu firmware directory and its
size should be a power of two, and it must be compatible with
the particular Intel IGD device being passed through.

If provided, the "igd.rom" file will be used as the option ROM
instead of the option ROM file epxosed in the host sysfs.

If no "igd.rom" file is provided, this patch has no effect.

Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
---
Changes in v4:
  - v4 is the first version of the series that has this patch

Sorry for the length of these notes but there are many things
to say about this patch that are not obvious to persons without
some experience of actually trying to use the option ROM of an
Intel IGD when it is passed through to a Xen HVM guest.

This patch is primarily for providing a way to add Intel IGD
support for the OvmfXen platform to get graphics output during
early boot from modern Intel IGD devices that are only compatible
with UEFI for graphics output during early boot.

Note this patch is not necessary for successful operation of the
Intel IGD in the guest once the guest OS drivers have loaded. It
is only needed as part of the patchset necessary to provide
graphics output from the Intel IGD in the guest during early
boot when using newer devices that are only compatible with UEFI
for graphics output during early boot. Most older devices that are
compatible with legacy VGA BIOS will work with Seabios without
this patch, but they will need Patch 3 of this patchset to work
with Seabios.

Some notes on adding Intel IGD support for the OvmfXen platform:

It is necessary to provide an EFI graphics output protocol (GOP)
driver to the guest to get output from the Intel IGD before the
guest OS loads the graphics drivers when the guest uses UEFI.
This GOP driver is essentially the replacement of the VBIOS
driver that applied to older devices that use legacy bios, as
described here:

https://www.intel.com/content/www/us/en/support/articles/000005749/graphics.html

Unfortunately, with modern Intel IGD devices, the EFI GOP driver
is not provided to the guest in the usual way of providing firmware
for a PCI device in the option ROM of the real PCI device. So I
included this patch in this patchset to provide a way to expose
the EFI GOP driver to the guest. I was able to extract the
GOP driver for my device using the UEFI bios update file from
the motherboard manufacturer and the UEFITool available here:

https://github.com/longsoft/uefitool

That EFI driver can be wrapped into an option ROM using the
EfiRom bin wrapper that is part of the edk2 project:

https://github.com/tianocore/edk2/blob/master/BaseTools/BinWrappers/PosixLike/EfiRom

I tried setting the 'romfile' member of the PCIDevice struct that
is used by KVM/VFIO Qemu devices and emulated Qemu PCI devices, but
that did not work with Xen PCI passthrough devices. Neither Seabios
nor the OvmfXen platform could detect the option ROM in the guest
with that method of exposing an option ROM to the guest. So I
implemented this approach of substituting the 'rom' file exposed by
sysfs with an administrator-provided file instead of using 'romfile'.

In the commit message I mentioned the size of the rom file "should"
be a power of two. I mentioned this because the code in pci.c that
handles the 'romfile' setting for PCI devices enforces this
requirement strictly on the romfile that Qemu emulated or VFIO
devices use. However, I do not know for sure whether or not the rom 
file is strictly required to have a size of a power of two, so that
is why I say it should be a power of two. In my testing, I zero pad
the "igd.rom" file so it has a size of a power of two. I will accept
the suggestions of experts on this question about the appropriate size
of the option ROM file (I am not such an expert!).

As mentioned in the message accompanying Patch 4 of this patchset,
the official edk2 project does not provide support for the Intel
IGD, but some OVMF patches for Intel IGD support are available
online for KVM/VFIO guests, such as at the links below (they apply
to the OvmfPkgX64 platform):

https://github.com/cmd2001/build-edk2-gvtd
https://eci.intel.com/docs/3.3/components/kvm-hypervisor.html#build-ovmf-fd-for-kvm
https://github.com/LongQT-sea/intel-igpu-passthru

With such patches it is reported that the passed through Intel
IGD device lights up the display during early boot from OVMF
and the guest bootloader in KVM/VFIO guests provided that the
administrator provides the correct ROM file via the 'romfile'
setting for the passed thorugh Intel iGD device and applies
appropriate patches to the OvmfPkgX64 platform.

It should also be possible to add Intel IGD support for the OvmfXen
platform also but I have not seen any such patches online for OvmfXen
and if anyone knows of such patches online I would be interested to
be informed about them. I am also working on my own patches to
add Intel IGD support to the OvmfXen platform, in private for now.
If anyone is interested, I can make the work I have done so far
toward this goal avalable online.

 hw/xen/xen_pt_load_rom.c | 47 +++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/hw/xen/xen_pt_load_rom.c b/hw/xen/xen_pt_load_rom.c
index eaf0ae1..6c2aa8f 100644
--- a/hw/xen/xen_pt_load_rom.c
+++ b/hw/xen/xen_pt_load_rom.c
@@ -2,6 +2,7 @@
  * This is splited from hw/i386/kvm/pci-assign.c
  */
 #include "qemu/osdep.h"
+#include "qemu/datadir.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/pci/pci.h"
@@ -13,9 +14,9 @@
  * need to be modified.
  *
  * For such cases, use this function to get a pointer to the option ROM
- * from sysfs. Caller has the responsibility to edit the option ROM as
- * needed, call pci_register_bar to register the modified option ROM,
- * and set has_rom to true for the PCI device.
+ * from a user provided romfile or sysfs. Caller has the responsibility
+ * to edit the option ROM as needed, call pci_register_bar to register
+ * the modified option ROM, and set has_rom to true for the PCI device.
  *
  * This function must be called before xen_pt_register_regions is called
  * because if xen_pt_register_regions is called first, it will register
@@ -32,17 +33,27 @@ void *pci_assign_dev_load_option_rom(PCIDevice *dev,
     struct stat st;
     void *ptr = NULL;
     Object *owner = OBJECT(dev);
+    g_autofree const char *fname = g_strdup("igd.rom");
+    g_autofree const char *path = qemu_find_file(QEMU_FILE_TYPE_BIOS, fname);
+    bool sysfs = false;
 
     /* If loading ROM from file, pci handles it */
     if (dev->romfile || !dev->rom_bar) {
         return NULL;
     }
 
-    snprintf(rom_file, sizeof(rom_file),
-             "/sys/bus/pci/devices/%04x:%02x:%02x.%01x/rom",
-             domain, bus, slot, function);
+    if (path) {
+        snprintf(rom_file, sizeof(rom_file), "%s", path);
+        XEN_PT_LOG(dev, "Using Intel IGD romfile %s "
+                   "(administratior provided)\n", path);
+    } else {
+        snprintf(rom_file, sizeof(rom_file),
+                 "/sys/bus/pci/devices/%04x:%02x:%02x.%01x/rom",
+                 domain, bus, slot, function);
+        sysfs = true;
+        XEN_PT_LOG(dev, "Using Intel IGD romfile from host sysfs\n");
+    }
 
-    /* Write "1" to the ROM file to enable it */
     fp = fopen(rom_file, "r+");
     if (fp == NULL) {
         if (errno != ENOENT) {
@@ -55,10 +66,14 @@ void *pci_assign_dev_load_option_rom(PCIDevice *dev,
         goto close_rom;
     }
 
-    val = 1;
-    if (fwrite(&val, 1, 1, fp) != 1) {
-        goto close_rom;
+    /* Write "1" to the ROM file to enable it if using ROM from sysfs */
+    if (sysfs) {
+       val = 1;
+       if (fwrite(&val, 1, 1, fp) != 1) {
+           goto close_rom;
+       }
     }
+
     fseek(fp, 0, SEEK_SET);
 
     if (dev->romsize != UINT_MAX) {
@@ -83,11 +98,13 @@ void *pci_assign_dev_load_option_rom(PCIDevice *dev,
 
     *size = st.st_size;
 close_rom:
-    /* Write "0" to disable ROM */
-    fseek(fp, 0, SEEK_SET);
-    val = 0;
-    if (!fwrite(&val, 1, 1, fp)) {
-        XEN_PT_WARN(dev, "%s\n", "Failed to disable pci-sysfs rom file");
+    /* Write "0" to disable ROM if using ROM from sysfs */
+    if (sysfs) {
+        fseek(fp, 0, SEEK_SET);
+        val = 0;
+        if (!fwrite(&val, 1, 1, fp)) {
+            XEN_PT_WARN(dev, "%s\n", "Failed to disable pci-sysfs rom file");
+        }
     }
     fclose(fp);
 
-- 
2.52.0


