Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A4EC56203
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 01:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrmYF-00027U-KD; Wed, 05 Aug 2026 21:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wrmYB-00023g-4x
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 21:05:36 -0400
Received: from sonic302-20.consmr.mail.ne1.yahoo.com ([66.163.186.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wrmY4-0006Nt-9c
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 21:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1785978326; bh=WVED5z9X3DhNfWYWPsssganxjMal/mDmQeJ0RW0UVpo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=ZocemVWyPNNRVCWp7tcTVgsj+okAl85RtnTc32+vJJ5sadpkFdJjGYhONhinL4v0zs+y+IwypGr20hAbhYz82xNsU+5MJVf7NWpB5o2LFRUZfsHpCu93egs1ixYs3kNRLbF6W/XJpFIgY5RMP4y+r0XOiixz1/MzjFYhn8+ovaC8s6o/6KDB8NIgdig7PcGQ7FRHRzp06DRAljcH2flA8PplF1h9GAGo0Hn5AtcDov9pSdGA82sL0FvnWrXVL1/13gYiNN04kw3IL9UmqxeHQIiAoOVwU/yRrGiyfxnGxxDxyaw4P7K7SVDzEJXVLtM8g7aPR0p627Fzr11HxMQZCg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1785978326; bh=7iBAhNNuxjWjoR7/fE95Vs5pQIIIvyJSx7pSZDa7+RG=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=RNdXb/80spp6ENsUBxZI+42NUmGBdhNVnseX9RZtUI1LW2pzFeivMyNFP6yqM9RPGJ1/z6T/MCYOys8zdj5q9OyVwlpE0llOzSxclN62i+7AsrDqWaGxsLepTvuro9CuKjR0Tk4AXTut5OdGuwsoa7Ee8zqMICWW05o3BtGHirls/P+hzqk9yAOC19chNdfvrYuvMhnPUyKpr401hCLoSvaiLeJJjpKEIuj9+WC0wsJHe2bsscZtiy/eXR7NljIp2rbY1kLkSowLF7EsbeDS9JXSg2Q7MVY4Wsf0ka8tOzGEwm7TbUWtU6+9hh49QcvOR+DFaHdrFxxqINC2INxnxQ==
X-YMail-OSG: Bt9JW_UVM1lR7EDyBjBA4WITfblYAyVeX6sJfDcmO2E6TQejB0h7rMfn06k5CMk
 ePEHp0_1iFs3i4ESLe02aQZo6cc_EbOXlyVBMIOMSSWcZM2zSvHENUIru3gS5CRGqBBSd3.iZc2w
 whauvyh.OKTC26zl5Gcp13d1FeER4Ftf7qGC4PpsYV7MXAPiOYQS2jcGesa_xLvzfkvYggDcJ2rg
 bcLAJQhNHUa5g0B.YnoK29i_Qzko2SxW62S2_dk53np1yaifCh5Ig3i1rxQvkZ8uSRjcO3LFC7sL
 HOC6t_HjSQ4dNlUZA1bTrtSJhOAa2MEZDnt5vO9dMKWvM4jT0o2QsPEk_lLWiAzs8aWoKwrUeUiU
 XVbpI08AuJo28209ycuW8wrdi7hhy_rwEZFxSX4YyVG8lhhoMdjAObKBlsAA8hRxyqgOf8tjMA7O
 G5q9rv0_W2HJP151u6fvHOE49T4Unmv0mW_c0rqLFaayslmq1yHdq.biUChcDgkw98XXL62d0Apz
 2QF2.Pj_BSXWnLfUf.ok74zDZRuKDNaN.fTsFSlNQUWS8o7HiVBQD8Qj24XVjdFya_sqwrToDdOl
 Vk2Ly4STBXtMniRBxhDlVMcjkJbnmL1xMrQ9NBe31z.TrdUonhLd4HECLA.GUjwpVtp4oZv1Z8nC
 xkd3wXf9gGVdEDjJwQiSSbpp4mthgPFgvxIftnJwHhGjepewYjo4ne3tzUfflkx7xkmp80dhfKqy
 4NJrzbw2JlHaNmOY1W..oceP5arvKi7CfSb57feAZ9aPA3ZHSZn6o7rtU3pQfeAoG8K5LtmyPRs3
 _uPU4_E0suz0Yf1iq.Wg7x56A6cgtp9BpVRZF88qBGG8_XmNp_9Vaiu8sQcVYYqGK1.KadvCmFmR
 LUnfNL9KqUx_0REFtwJaV4WPWEd.1lmrb72pmQ6.5jjF3U5BCVHrjpqoJZAvqTvfEwCMPgBjaSiG
 VC5hK5kGcff7SfWcrMzfb8zW04Mc7Z72O3t3pYyU_L66Xp1mYvYuUlG.sh1kj6tSjAHASZiCMPvz
 6zpeqEKcp1OFQ5ExRUzN.GpQYEX8N5Rcu_pNjLis03ZFSafJp6_NWUI4GeBWvGBq1pBC.HS0WgXX
 zhezKvPUaFNpeT9jh1QQwiqooi8kY2lMxReIg5SxSamLG5FmctKmfG9BPizGeFwNBZTN16JLjSPp
 tpZ0afekS9_09yjLXSSiNwcX8SQhKYl0ZG5176fA4HdZRhALbaN7GuimYglTpPAoXfysHu6YeKKt
 JEGGbJVQp4gsB5daHu5YJfAn6NFNkV7MsxXvs.6cT64cI2SXkVEzLx8oCLEzB65MCsrlBMsPgoHP
 nD2JR5xNQTgKIfniy20WZBz7IZmJr10A_R0kNYhbGqyOvnPYZuReA3tC3hohLmjr2VsI4.hlW5No
 hoU.iaE8.0Ni4rC88p29TUS5rnlC469QdQAtsb0uKqA2yMRIA4.ajIirQZRLQ6TU2OQm11x5UyJY
 f6huFuXm6eSBRlvVTfsagdnxWoo6ICAUVzGIQzp45MI2U41eNyGJ8RUnFU5qiU42tL9NI5i3xdTz
 0L6be12TygPAfgiIDblB4zvby0K6SP_DBkP_RmkmotWWAEi2Ts3XrpYk8u1pekRTS33Bm.ko06wd
 soDlY9sAQYIEieX.7JU0cATWifWoLfcJS5O7EionM0m85RzoodGGZdlAKx7_8biI.GZJCL_qFmHj
 plIxPmwToxiPaOxC1tZ1wDUlJRwpUxEQ3kkrJkWCLjwhFEJ0CLdD7lvKXhHdQ_fMF1P2ZTSfrdvL
 qyPsuj0x.CDQMpggTsnfgKNdnGaMjqPWMGLJCuFnWvcK84UFfdJOJT89pALzbqDdU3bM6h_znBgU
 JXN0M6drr7GLt.aHUL7sCuD1snJEkznEzqEwFOUTmzYGzigQ9sizb6J3vuvCcyeQwETN9oMCw3J8
 3sZb.j4j0Lhe63EN.L8FqFTdJtbMYm7EFH1Rq4kev0eC_vDQzQptA_72ml7g_gLXkF4FVVC0aYdR
 73ulu5L7rRI.cn.q32eadpWxNvEi2VcMu7Q1d7mkEzn1q6b1rTob_1u52jDUxNmi8uoF.O5gG82h
 eQGgOQSK06ah8lTI6xYjO_2wE0uFrLinYUth33L8ND6Ey.Jx_lEtT7dEaBfPnXmpsEZBuoQU0FMW
 gpnwNHzWh1jiQaldlp5KQ6oRpSxjwYRqnlIzF.TZXQhXmOsIkECPQWnght4nZB2H1HMhJeeGrpcy
 60bgAaiL64O0UuyZHGa8cfiYNBIOkhahnYCGd
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 1c24a953-a693-4bad-a4c9-6097629114f1
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.ne1.yahoo.com with HTTP; Thu, 6 Aug 2026 01:05:26 +0000
Received: by hermes--production-bf1-54b5569bdc-xjdx5 (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 734f0c8329adecc00a98ec91cc943adb; 
 Thu, 06 Aug 2026 01:05:20 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Jan Beulich <jbeulich@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v5 6/6] xen/igd: use custom option ROM if provided
Date: Wed,  5 Aug 2026 21:04:56 -0400
Message-ID: <20260806010506.492490-7-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260806010506.492490-1-brchuckz@aol.com>
References: <20260806010506.492490-1-brchuckz@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.163.186.146; envelope-from=brchuckz@aol.com;
 helo=sonic302-20.consmr.mail.ne1.yahoo.com
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
Changes in v4:
  - v4 is the first version of the series that has this patch

Changes in v5:
  - Fix wrong whitespace in three places in a conditional block

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


