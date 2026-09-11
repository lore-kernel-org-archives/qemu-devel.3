Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A882C79FA1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4vdM-00088x-Eu; Fri, 11 Sep 2026 03:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1x4vdI-00087w-IY
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 03:25:13 -0400
Received: from sonic302-20.consmr.mail.gq1.yahoo.com ([98.137.68.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1x4vdF-0008Bb-89
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 03:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1789111507; bh=7fxAXafCgkhWXQ8Bsf9UiQyUsF3UYEGG0N1eLLgC4dY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=MY3bu1YIRCtta03Rlipjs9jUs1884+HtWo02dPwMqdNiXfGND5jbWoQQ73rVvmFAxfMh1rSKNCMmUuv0f3O3nJaF48sza9pov6e+l+5/jgrWX/pDVibkOPsfi8YIe/y/Pho4nZxTqjiYEEXkYQ7WTBu9rkKWm87rccHdDwVCWORazLPteYYxrU9xB8A1WWaALgrm/4WGLNNraisbgpawWT4yCiTwKRcRrUB5TrtBlF+L+XCD94/0oIWScWB/ITGti3+FA+DWEgJt/bbxP3uxArBWxuz8LXVFcbMm3e1FfLCVqskURWa6ycZ2qiubUAeiISzjx7yLDbKf/tpHsLRAtA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1789111507; bh=R67dZrL14KOXcf7Htx14zdMHg64juJit3yfZK6RHShP=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=AVymKrAS51hbwh2XQ86S1xqC2/S/pId39gT5gLi9EPmC71kvDOIoMtCHjmQ0PH4HOd+kd6qEJZU+yw/oy0ad+Qvtk702yzQybpE6w/IqgP1gLD6AXQobKic6oJhhJWIlVR17YeqUSBUR4CUm5lPlm/JIROPRDo8QGGTkGQiqgltSSOzirGDFTEsuQKYe2TuNRZ+mnjMLF3cr/7BWPkcCSdrM8kHBdMU5yBJd7NuTbIdU/nNsLL7hj5U+Tqb7Jw//ua2OA1oyDj71El72Kz7vwvadsgsTLd6HMj49tWedkm+wJti/4yyh/YTzmlckEeZt6J3UDL/ydHB33+3RVC3pnw==
X-YMail-OSG: TdyjS4QVM1mzgjCy7Bu9yrDGtN03HRem.ZApojprzrTauLRU_qRx8ZdHoeHoqCD
 GkHGfbcRZq.i8qBkyw4lCGycdR05XEXRvmdVNSsikGRGea0dTk88CSfUW3s6heH_3QZnzWXs6GdQ
 NLxGswdBbMVOpcUC0vkK.4lLgp4djlVgRM7gE7If6O_BznhDZL8DYK82Z6t7v66XAkw.4LDTvcrB
 UyZn_72P0P8pDfEwVEtEdoiRd2VPVDJvRh_iWfPl1M0O.KX6t.k6xxK8L0UrLd0W3f.2EJIAGT8c
 PCFqOgAOXkNQJ4teAXfcPmKUEk9Vuu3VSJ0Ko6hZSU2i2a3o2Y2fGlKGZkIqPJPW8_EABKXiOLb8
 o52MOFncWd.G9BSIQbykStHE3QBPT23Jdi0Zin3hCzJrV4IvXw9wnMmBTRZI2qYrtYuTCZh5vt81
 fVnRQxVU5vZBv8w8Sk6OBtsdtpurGw4xu.8gfzR1M3aEY30fZFSuNQQZKl4u8dc1G5bKBMYpVm7m
 zZC75fXyvAs4xHf6xJh3n5gtnAIMM9XHtueD7A_GrLqwnehfl0nnMa7VwKznvGZf_fLqKGW13ra4
 FU2dCPp0scZ17M6MY3JCqAOT4DbHMa666NEb5hkJZnfBbRd3_2bCcBBePQyXXglA2kvOhx843lBH
 hF9cWSSdsjjIyX6mgM8HNv2s6Yfk68MdkmFwjqx3Kzut0qgXaTkMGuuPr8b9q_P3jhnk6tOKUUeF
 l5PJaLsZAAvyEWHhqCJcaQVRtbwtVisxQycWSE_gw5dmVyoVYafo3MZy4HL4n_eaD3Ca5PX5rnJE
 11.iKSyc934Np0Fu1MFvYIr8ipjBclV8Oq11aOVcC1wFUuXudA_dIKetPC4Oy0cyVvB9NcvtBvYy
 LXrxxLMV10IxeaDWIYjVaHCf6rRam76iRnL6V08O7Gp_uawCbf39GOJOr6sa7ofFrETh5T9ttB.N
 uJR8Kq7PEll0Gg0B4imOv_7Po8xYPDUyCkZNmmYvQISjEiDFO0dq3CbT_vyc22973u.SmyxSyK.Y
 AuZInZx.1Gss1mk6_fUB.ND427nRqT2bskv9DllP8EgabRreNXPPxM9RHUxoQq0dEOJpE_jZwmPL
 s12KL78vGzXk63ykngyGvXt9nz_KXD_CvdXP1Q5N.fQfmJkBP7V21m7uEuZVepcIGe.D_V9bVAPn
 hY8EmtelGU38PLOJ8viOY7q1nX6wFcY_NTwwhEgc5xTA9zfWXA.g369HgX__btM.2EgvTGeJsga.
 YhzvES6ch1o_PDRnGF7Nd3txH4PVfLWr9v6A2GmkksZdmF3SqPkiaN3OGaUXiwuRgxIIZKQ2gby1
 IKwVOp5_NYW3RAQIpJOoiKA9fqSKUtRt.AOvfGqUnoCOmOoHnAnSjSblzDb2Qu9sl0m6A13Kp38e
 ztjcuZy4c9lZbrDnXDyFqPIPZu8urSM0r72k13r9C43BFI38dXYstM0JWb6j3fh55e0ToP6GGjV7
 qZYN42BpJkAMPZa6ZK.kzVP5yNx7pbka2tQY_RLuYySZrCaVjd5Fuu0HyzNg3RicioN4VReJ.LeR
 bUJIWcPZKnSXZ1EJrnTfoT5sTcnEvgq4MuND87Pqt8QeBwdwGQoQSFp8gvaCXK2XMqrtgImZ4eZE
 CaDNS1uJnrCU0q8e_GrAmRQW8wt5BDfuKx8xJzb3V4nwqh9T_prl2UWrtvwNpAnA4cmD7Vx_gXr4
 1cVONYmkDtZIw0SaBGjiTJqNkG2zhyrpQnsjjO_dP8G7bNm90ZR2z87ENT.GXNy956r.jdKm2fr0
 brGW4Vk4Xrl7oRDmVBVpLAMnW60JhPLNmlcb_sO8VjoyBWzN6knLDKJ0a_jlO0OGUSqxi9fszjib
 pwhfLZmjJpJritfFzDXpA3aXm8wiwj3PE1WfDf9dMAZG.qikmErSwUaYxuPFDXi4gVFiOzYAb.Bh
 UUKwEHw09TIosrYue9dS3SHIoKpfcM2Fbqvp7sTkmgpI8teKKcnSOa5BwYCoBFbQFZtNyzwgQB5B
 _W42OaX50UnCcZdluogrDALWQJzAjR3lA203vnwq9T0JwZzDO.bddyQror5LeqyjT_IGrJDcTQC9
 1fGMaMjgz4PWUZumDIC2X9V4PcVgrNPrt1mAwC70Bk.Ppm1pRnaYMotUDPPkYpFYrhKWMIW7W56K
 lZBvMm4hzUfzaA0L_VYTrYicIndZr9sCX0OJR6ftEi_V5c0QGrkfibd446UstF7V2WSQZydIxl89
 6EkOkHMCQuUFD7NxxzrvPohsIUxZLYMcorCrf
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 4e403500-ce38-485d-8ff9-5e41d4fcae22
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.gq1.yahoo.com with HTTP; Fri, 11 Sep 2026 07:25:07 +0000
Received: by hermes--production-bf1-54b5569bdc-fv65m (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID c4451c0cd4386c4b1051306e68eb9ea1; 
 Fri, 11 Sep 2026 07:25:02 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v6 4/7] xen/igd: enable guest creation when ROM read fails
Date: Fri, 11 Sep 2026 03:24:50 -0400
Message-ID: <20260911072453.46256-5-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911072453.46256-1-brchuckz@aol.com>
References: <20260911072453.46256-1-brchuckz@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=98.137.68.146; envelope-from=brchuckz@aol.com;
 helo=sonic302-20.consmr.mail.gq1.yahoo.com
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

For newer IGD devices, the host option ROM is not readable from sysfs
and this results in a call to error_fail() that causes Qemu to
exit(1) so guest creation fails with the current implementation for
many newer IGD devices. But this read failure need not be a fatal
error causing guest creation to fail because the guest does not need
the option ROM to successfully boot and run. The guest only needs the
option ROM for getting graphics output from the guest during early
boot before the guest OS loads the Intel IGD graphics drivers.

To fix this, allow guest creation to continue by avoiding setting errp
if the attempt to read the host ROM file from sysfs fails. In this case,
the memory for the guest option ROM has been allocated so free that
memory by calling object_unparent(OBJECT(&s->dev.rom)) before
continuing.

Replace the error_report() and error_printf() messages for this case
when the option ROM cannot be read via sysfs with a suitable
info_report() message.

In the case when the host option ROM cannot be read via the sysfs
interface, xen_pt_register_regions() will attempt to setup the option
ROM for the guest the same way it would for any other Xen passthrough
PCI device that has an option ROM.

Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
---
Changes in v6:
  - No changes to this patch in this version

Changes in v5:
  - Shorten info_report message to resolve checkpatch line length warning

Changes in v4:
  - v4 is the first version of the series that has this patch

This patch provides initial support for many newer Intel IGD devices
so, at least, guest creation will not fail if such newer Intel
IGD devices are passed through to a Xen HVM guest. But this patch
alone is not sufficient for proper operation of the Intel IGD
for many, if not all, of the newer Intel IGD devices when passed
through to a Xen HVM guest.

There are two main problems with more recent, modern devices:

1. The newer divices might require patches to the Intel OpRegion
   and also an extended video bios table (VBT). Without support
   for these aspects of the newer devices, the experience will
   not be great and in many cases the Intel IGD still will not
   function properly in the guest.

2. The newer devices only work with UEFI AFAICT, and the Ovmf*
   platforms provided by the upsream edk2 project do not provide
   support for the Intel IGD. It appears the problem is that the
   ekd2 project deems the fact that the hardware manufacturer does
   not provide the necessary firmware, the EFI graphics output
   protocol (GOP) driver, in the ordinary way by making the EFI
   GOP driver accessible in virtual environments via the option
   ROM of the real PCI device, to be a reason to reject patches
   that add support for the Intel IGD. This, however, is not a
   fatal problem since it only affects the guest during early boot
   when OVMF or the bootloader is running and the guest OS
   graphics drivers have not yet been loaded. Lack of support
   for the Intel IGD in OVMF does not seem to affect the experience
   negatively once the guest OS graphics drivers have been loaded.
   So efforts to address this problem are only important in cases
   when it is necessary to get graphics output from OVMF and/or
   the guest bootloader.

The last two patches in this patchset address these two problems.
Of those two patches, the first one is more necessary, and the
second of those two patches is only needed to provide graphics output
from the guest during early boot.

 hw/xen/xen_pt_graphics.c | 7 +++++++
 hw/xen/xen_pt_load_rom.c | 5 +----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index c5ab23e..c5c2d47 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -187,6 +187,13 @@ void xen_pt_setup_vga(XenPCIPassthroughState *s, XenHostPCIDevice *dev,
         return;
     }
 
+    /* Case when the host ROM file from sysfs could not be read */
+    if (!bios_size) {
+        object_unparent(OBJECT(&s->dev.rom));
+        bios = NULL;
+        return;
+    }
+
     if (bios_size < sizeof(struct rom_header)) {
         error_setg(errp, "VGA: VBIOS image corrupt (too small)");
         return;
diff --git a/hw/xen/xen_pt_load_rom.c b/hw/xen/xen_pt_load_rom.c
index 407b630..f136f13 100644
--- a/hw/xen/xen_pt_load_rom.c
+++ b/hw/xen/xen_pt_load_rom.c
@@ -77,10 +77,7 @@ void *pci_assign_dev_load_option_rom(PCIDevice *dev,
     memset(ptr, 0xff, dev->romsize);
 
     if (!fread(ptr, 1, st.st_size, fp)) {
-        error_report("pci-assign: Cannot read from host %s", rom_file);
-        error_printf("Device option ROM contents are probably invalid "
-                     "(check dmesg).\nSkip option ROM probe with rombar=0, "
-                     "or load from file with romfile=\n");
+        info_report("pci-assign: Can't read Option ROM %s from host", rom_file);
         goto close_rom;
     }
 
-- 
2.52.0


