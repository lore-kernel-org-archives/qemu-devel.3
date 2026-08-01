Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832B8C55171
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 00:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpxQd-0004o0-Dj; Fri, 31 Jul 2026 20:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wpxQJ-0004jK-QJ
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 20:18:02 -0400
Received: from sonic303-25.consmr.mail.gq1.yahoo.com ([98.137.64.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wpxQH-0001at-RP
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 20:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1785543472; bh=dt4PNu6AZ8WmochcJSUTO58mxubi+byKBAAny8f1ZfI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=N9WwHxoB+cf3cO+Co06Yt+h8kaZi09MEcr8dsgrkRZjvSYks/E2U/RUsfSCMDCJ5EbQq8bFpRiSj4z8sM2XsEk7e/+RNQINe24YUDWi2aVVHHbCBz95r387g4xUXOW9Vlod5CgXmMmAAmzIgA96GbeEozdnNmXgfFrzINvsyQg5Y1bHhWxPhOTLXynFGFOZPcAFBSK6GhQrCzg1T/2kNDLCeAVfhr1Qpg3zGO7PPnXf6SYD+v972nBg/D/eeIDZTC7rK3hBX66P/ByxvhAMAkOCfjUbLCmZtG4fmLURSn5bCAtjIaOoVGQ4sHiNuF23oXREJBoLidNXBluGgN/ktgg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1785543472; bh=uijYDbf63QNZRyqSO+BcjNAdvkUvYboCyFEczonTTzC=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=r/iLX5neOxLm1Hizrb85XBD85w5EzXJZZ8eub5uQw6xuLCA59zaDclf6AFPv8uY8IoMeT0kvgb+jB6m0hxfYoGaNbrOoiAwhLZJ0WyWrGxsRlldsu2vqjT2iF7r5DMCgvVhmPwJrM7Aobh9xl5M7otYR4T19PQEiE5EmN5hsoD4ozilwGGCKcpqthlTeCRaaJmEJZwFM0NuL6Qq2WneLEkNl/luUHL/f807PPj5xpwPTItm4lS27aVlCnItQx9I9BmRZlXYZ4nh6a1DucfEZrpGdIwmkAp1nJuAyntHllEmCKok7+xSAD+XRNyv9M83FRQ9HZJw4gnnjj6aFZT0eQA==
X-YMail-OSG: OB._0IMVM1mru75Egk5pnS7mtmdxlDFp2MywWseBRLa7DWCM3r2ltqo3uqt6Lyd
 Rt6xkeJS27P0r8Cq9siuuneSs9DQEtjumqKQ7oSfJP8gBtQ5hHZpkRl_KbOsVhoDKSlom8eoCXk9
 JjHDjqTOSzaRqfLbPNESGpRwHWksXrNIHZlhkDUUmMFutW.2LZ8OCiNPEFln2gALzKvPxvqylyDN
 A64ZIaHkUfyEkQNxs1DM8flmn0ffPHLyPfkcl7eaOtOcUHbt0JlSuUklWSz5SZfUaDQQWOWNiUuf
 ydP9LfQ3xYGgYr7KwBqvU9X9IWpDYW9.WrGii5uPQ9HgcuS32UX0Az_t76hE_G2MCFiteoTBYqJ3
 gO2JhwkRLQtVvUeoBmd0dyjzON7NCN5VoqINBBwULMJh1.LRezBmCysQMlq_urADxbeYkRenKlSM
 VAim1BV3a7EDH_T2zCTvXrB2vvY2dSDCH61a7.QQNWUrXwlDWHzSQqVm5cOO5o4LdZ3ZzSnQWJk1
 zEyUHzw4h_M_7qtNpRNQUdhFxVZE5s8P4JsMiGwggyfL8Mp5Xn5G2ZK5JqJirNWSsXIwQrDomOqz
 MKRQT3JOHBlihZvTUurD0k0W1NzLdhlvWnIiKWtcPY.exoLeDU_H3jC_2TI.W1HWxWDYjU2EUk4Q
 qde8I9juKv7Bz3YJZTJSu0UBQK2gdk0IQ593t5_EKQCGicz7aQVoIlbUtj3fptqrYxQJwaJXndVl
 roGCqXppEdlq4ZOishAOVtEMklUj32gRPDhgVb5edvwlOtIZ.NJEb8u1vKJzgzZFDLjn2g.QPHtF
 7QMslpSYIrysjLpMVv9eQ3Fa2S.IP0.OPH3zSiUTZu6bPFdxLqmPmoMYc2rS_CY7IV4XkEwC7lZK
 xVPYDwytZphPJw5ZAi05DXHVtaqQZxNkDb3_5CYfloqCCpbPob2t0GATkhSY3U9LWMltNlcZ6U0Q
 4fBOVSINurtn11QitxYCFr4WHAVqhs2sSaOgTkKQXaMifuHyx7kbzMQauQvgNiSplzYD4ZGdFBBO
 .1VY8EBlvsSEDhGwBDDM5fkRFip6dmzegTzdVbmxNx3QdyoD0JDt0PpYXQ01F2Igehn9FDwp9QLB
 Bml8OdklLIxPkOOnWCetld7UM2.9WD_mdXZD8g8TBKhlRCrSg0Nql67T5AaWKEkjYhEZDZbxqBPO
 GgWKypu7Klzo3l_y6Q_HXpi7BI8vmJaA65nm8CCwB5axK7iD_7dyqGjheHasTKLSHkdIBeF4UCaH
 UkDLwuoAMbWNLb7fMUwFxv0DTdZX0CIw9K0ouP9WnXioFium_U1pjC3vqIhkkgNsQAqceziWFAiz
 etyzoFqTmd2nz81SrTVGIgGIc5_OTPKbW84Umg_mDLfddrDXjiCwkAZ8iw180wWjJ.apfEiLPdaT
 y.Xfgbp2blqyDCBpAEFcEVMRHnm1xR6Aiucqi4DpYtmnyhaEM_nycUDv4hT3fFpCjQICTx8.rrHA
 lbXBnhe8VIddi9bvxPoi7NRr7k6kYPn2sKOnSyv9f_A.ZCrMnqr2C9afaRzW47BMDk8BSXG2RgZU
 _LoUHFazGGVf3gT3j1Js5JGisHskglTYXC_FohCPrLg51G_KgIXOrptXU.W0fmkmw1NtfIGpSk5r
 N05d1xpYhlQMLuwN3_q0XhbFbnFpT1F0iGfdhdEQAwPl5yvCCTVI0HLl4baoxwRxs0TEo1eSJwqf
 DUpikmUktwPHd6DjjSW1dpfVkae_uWupiZvJbeJ22YCl0aeQFoW.l_70f3jwYBzdczzh73nOkzFl
 WvzGwkNbXpxvX6JrNrWb9AbpgqYvj.5kZI9poCc.c6FuO5n_vmdm1XhmtG2jczhbrYB.bHvr1z7w
 lRBEA.CUOHl9dH3TY8v36HscptEguga4ggzGTPM6I_obHCxUERH7KvqHLND8j0aquqZxcgh0r2It
 XI_95HG_RMDAxh95F6zw5nPkRLLR4FBY7qMHSSdPiG4DTLrIk0aJFaPkllXhhxKDn7INc60jIhbU
 JUsuuIZU1W2ZBLixsXeV583GXc7tJgfMwtLl4.nn6JLm5xi8NNei4bKIUHeY4XBlq8_dsahsEjyJ
 8BB9M9uVlNvlK31Nl9wNoNOArKQT_oNbPdxx7xTXuaM_WX5KU9WAoJjjEt5TdpO4GhrPE8lEbDb2
 O7qxsO9vYc.gBTyHmwg__.QdRz.fHIsn9AC.kop66w.LeJbK4vrF2AKivfAprBdQFk8UM3o8F20T
 r87KSJZ6c5tp3msZ2VRwI_fIpIYm1ujTHSmn4WTVtrSV512mc5A--
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 4ab60735-23cf-4f17-a1e3-b99ab0ce6955
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.gq1.yahoo.com with HTTP; Sat, 1 Aug 2026 00:17:52 +0000
Received: by hermes--production-bf1-54b5569bdc-h5zdx (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 655a093bcead2c5289eeab02aa189b76; 
 Sat, 01 Aug 2026 00:17:46 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Jan Beulich <jbeulich@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v4 4/6] xen/igd: enable guest creation when ROM read fails
Date: Fri, 31 Jul 2026 20:17:28 -0400
Message-ID: <20260801001737.16509-5-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260801001737.16509-1-brchuckz@aol.com>
References: <20260801001737.16509-1-brchuckz@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=98.137.64.206; envelope-from=brchuckz@aol.com;
 helo=sonic303-25.consmr.mail.gq1.yahoo.com
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

The next two patches in this patchset address these two problems.
Of those two patches, the first one is more necessary, and the
second of those two patches is only needed to provide graphics output
from the guest during early boot.

 hw/xen/xen_pt_graphics.c | 7 +++++++
 hw/xen/xen_pt_load_rom.c | 5 +----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index 0ae95cc..a124233 100644
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
index 407b630..eaf0ae1 100644
--- a/hw/xen/xen_pt_load_rom.c
+++ b/hw/xen/xen_pt_load_rom.c
@@ -77,10 +77,7 @@ void *pci_assign_dev_load_option_rom(PCIDevice *dev,
     memset(ptr, 0xff, dev->romsize);
 
     if (!fread(ptr, 1, st.st_size, fp)) {
-        error_report("pci-assign: Cannot read from host %s", rom_file);
-        error_printf("Device option ROM contents are probably invalid "
-                     "(check dmesg).\nSkip option ROM probe with rombar=0, "
-                     "or load from file with romfile=\n");
+        info_report("pci-assign: Cannot read Option ROM %s from host", rom_file);
         goto close_rom;
     }
 
-- 
2.52.0


