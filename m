Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8E5C88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4vdU-0008B2-V6; Fri, 11 Sep 2026 03:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1x4vdM-00088y-1e
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 03:25:16 -0400
Received: from sonic304-23.consmr.mail.gq1.yahoo.com ([98.137.68.204])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1x4vdJ-0008CM-N4
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 03:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1789111511; bh=/3QUpHGBKJbXOgu22YsrlVzjiLJDOg/MMxR0FeGG6pI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=QzLynmg1rRqy0YClCOWLrr8VWVC6sWeJSBGxWL6YF6ByqXU4gz3UFrDSBn7pY7HyldKC8tF24T1ERoXKLQsPTB0RNpWn+TwECHyowTJjRRLU6+Dax1G8FtcEd7Kwbhp2kG5k2icMHwbs2zwanyYHazp5LNqj668XirOZ7gxIn1FWwcm4L4DwDqgUpaw9xs1FlETWVJzvnw/cYCIPxBR4XuNNtHGcFyr2rRtDjxlAltEC7KZcvX79YCbwUzuIgPzymlsBdSOL6pM3yWfjwOdPhP+ywLdwHyl3Cw5Fo6DSYxy7aJg/9vwNB4OcWAgXkS4AYsB8/o/9xAvzqyd6yVNF3A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1789111511; bh=I/ssSFpkQARF6S3fHwCeJAKASsjOH/PQdGIY+FxDhMt=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=fGeWUDeT/Dl0luu+OzhPIKUY2cctSYE2PH0khHZp3jKrzF2MITJLQd12UiAOwzFE7G7GOLufQaoeYBSJrbKcHdl+MZhHPOfiCpoSrl4UdT+bNVC0vGmV2CVxbjunxe5mR5kXM9BtDOhk3OFZ7PB4ovLbH1TK7Jb7VbZt8FIOJUyJ4fWroJpFHN6CxcYiZpnbH2WkLm0JzSYVJoburY1jkT3FKfOnh72EzDjWLyv6rx+z9n8RX1HyI+GYi8KOj8KXtvb4hHoLzqfhi/XNeOLYYIxgrVZ6etHo1Ek3HYpWZR7Vrcoz9x1dPNae9nxoBQlQLicW6nR7/99j5AktpLLeHA==
X-YMail-OSG: 3ceA1NIVM1lx65qhP6Zop48W1CPeK8he9I_xCzv.80GxYfw0Dfz_nsufQwxudhy
 zTEZi9MkHkbiBFnXI3fOl2tw_GVcCO3uJTOKSEylFd8XGL8fXmyvJSvcknA.kvy_sm6Ghfvj54Nx
 zpo68YIzYaSwxcxPpLxai4kcgJwHRvspGgdoffPz5fLwSFRB_axL9c2.neIjoDyKgx7GY4praZi0
 jG.4ZD0JChGLGYwGAc8Bax3vX79SblGLoDX49wenKNqfOxV8DRNKBRZ7NpxRw_F7MCFAQ30tPhc.
 OTA.In6HLCUfRve5Rpom5fQjsr6z3ZWnp_E59pIctu8rPn1pAQDWHq.FHeH3jVI7aZl4rc9FObVx
 yYRoUDRlUza32VlGgHvnzuDh9ATM1DAf5LLbak50OtrAcjSpnWpB1QVu6UF5ikVFHqK03KL5Aur0
 Gm79tSZ9Uuai1tDPnCTTDku8f9ehJW6H_5rro0qPZrBg8kPOJwABhEBLlG9Tgjfyc_Bi8v_YWOhN
 ggBG.NEGjNT3QSpzD4oO2.ztqe4.CRy1j.N7j5gJt8h3bJ06cezAVS.ILZ56iphLih3lXySGGtSe
 zeHTZYbP4ItkUUavstg_yZ.KJLN318LCouSNb0_BFqnbdgB5I4bAC5nVrbOHm9TKkGyVgkeYEkll
 pKysm.4dFGwqZvW.t.d07az5iUyw8xHyc99rXCrSM3w0uN4ZScmSNM4e24WFLwWy5ReBTiaPiFgO
 sWqg799kqxwXIWEC7aBA.aYTNhv._pKXMr1gHDFcWUXF01Ec95JAuHqtN5mYWHf780BHjtbao0ix
 tXfQlGEani0_XJSO5ifj1O4wvtFgIYgKkiDKTEDB8Qc7N3.3RLRyNoDyNevDvSavVVoP0qLiZNf3
 MXQKTTzyII0pW9UwAKvcVFFJRjz8A0TB325ov0czg3DCYh7.sIz9REEFuEXSS5dFJ4rcsVv6irMQ
 eJwvwDhbIaSMtotqA5I0JlruX6rouxo_PAiYbk.Sldn4GsJCgG2FbbYgBy6bcBRmZAO9yC0lseUX
 pvPZSBU7GU7e1aUUBGrUu6Y0x_znGTczo5PlhAlVsHz9w_B4jHzspxR8CmJsf_bqrej3Amwa3DMV
 AKD2apFGZaS8JCH16slc7Awsh9KYiIedQajsWmHkpvl.tuYeg6fNxsHAEn7TifDYlFnHfvNPd4yN
 DNyQmA85icJjAfETk.Y5uTKqimnfa0cydm4G1OBoZwyuwfIIBFUKM.OiJCAF0cfsYVEcH6aya0Am
 .advDQbWEI41RYP8LFCUw0.pTcFJpd4oczm5qc_HqFBb7PdsDjB3D1bbew4I2kDLy0zyJbi1SHaw
 Bp8MPNUT08HYGW.r4zWSUIzon.2xjnlCEsBkOTiGsH6D_oVLvbFiu4a9J0GX5uSb4mpid.LDLexs
 9r9AOvB3F5C.7RHpGmlfXqNo4KcAlY14wsYA1Oc2gjWWM1k8fk6jt3012uulM.Wlt7iQOEsRvQvu
 ffEPxHGt5peIDve_Ngn4XPJ22AgUaBSFSiDvaHHcdNW_Ls_Epfx9dJP22RzGAtKTjO289hNWWfSj
 jXATt5Zx9VWnnPkpBzOEsuB1ThkySY4DLfofOh9pDBNMlxQCBelddd5AJwfPV1D.ogUEauarhvbz
 ZUr0R_QjX6EAoEaJ9o5mZJsP4j7WglWvxi7byKLJ1_APzEOC7kcamaoShdi.NaM7Y9yDxR6yv7Fi
 HpFQoa6YU6AjDf7UlCb81gkLLOECXL.VWXcK699HH98uMkdwhIYwHUw04OSRJcuqNS47KwPbDhVA
 rUcND9SS9YKR9jpzcLRjVdjHfiq8J13rd9BCq0OwoU8kwSpnpp9ZMT5y5EWmikAOq97CBZGSt9jM
 _FpFF5SXIPZ57U74UZ4PsPAGDaFPZmo5E6eYkscFnf6c0qZ4cOwpsypR3WYbWbQzsnnkPCawjNwc
 ckZC6Qhv_k3L5o9v8hW6I_mKOLcGqE94o3w9pFsH1R04OrbYhL2E4nZvTyxzvh6SOS7SWTpyR9Lb
 e_fd36IK.ICTB8XxPRhZI_aO3klCqffAbmvw1MtspGD7HPAURRTdIC1Ymrzig8FFZqlQeysiUex6
 NAO17PvGdsPm9ZdDw_N5x33.ay63SipsSCmt7kQ4btMb83HnggaR.1yd31vjKmKOXNfAIj_yPvwf
 M5VPQ19qF8fqwJrOiFKAZhzj.OAlUYU86.ndcP5QYkIL2yUpbww1D2T8EunkDkBCLUe6ClOjioYa
 s4UnnCDsC2GNsHdAneIkjmFSNYFTxP.Z6PEx4aA--
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 325b1927-76c2-4939-b9b7-27b409399d56
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Fri, 11 Sep 2026 07:25:11 +0000
Received: by hermes--production-bf1-54b5569bdc-fv65m (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID c4451c0cd4386c4b1051306e68eb9ea1; 
 Fri, 11 Sep 2026 07:25:07 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v6 7/7] xen/igd: use custom option ROM if provided
Date: Fri, 11 Sep 2026 03:24:53 -0400
Message-ID: <20260911072453.46256-8-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911072453.46256-1-brchuckz@aol.com>
References: <20260911072453.46256-1-brchuckz@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=98.137.68.204; envelope-from=brchuckz@aol.com;
 helo=sonic304-23.consmr.mail.gq1.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
Changes in v6:
  - Added a link to Tomita's edk2 patches for the OvmfX64 platform
    for KVM/VFIO guests in this additional notes section

Changes in v5:
  - Fix wrong whitespace in three places in a conditional block

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

https://github.com/tomitamoeko/VfioIgdPkg
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
index f136f13..ab448f4 100644
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
+        val = 1;
+        if (fwrite(&val, 1, 1, fp) != 1) {
+            goto close_rom;
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


