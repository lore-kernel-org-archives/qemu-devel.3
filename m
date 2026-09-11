Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFE6C79FA1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4vdV-0008BH-1F; Fri, 11 Sep 2026 03:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1x4vdL-00088n-0Q
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 03:25:16 -0400
Received: from sonic308-54.consmr.mail.gq1.yahoo.com ([98.137.68.30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1x4vdF-0008Bq-RM
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 03:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1789111508; bh=DeHWtm/4lazeyWTmPQN/A4L8FgKiSJ5/rJS30RCGUio=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=Jb7KTCTUxUSCZGuTZ+5vpdZaXU06xDRRrhILVWrEN0jPCXsWA8pBJa/v5/zApM2cCjoD9ovYrmCgVLcn7DLThZPgyrMTB4QvwA0vbTPcXw36KQyf9YfL27R0VMDCtzXJNx006L9c0Yqx3vmM3bNDChyGnnQ0M3+AUPtyPSn46qRdSaiIKipQYAMZjW2/eobDB16t9QEohMab0Bd8VwE1YyAVvCZJNaO/jjk8REtinLgYpzCy4hJZHeEIQpwhu0WhF4fKJMYNCV201FpW9njGNQfJK+HoZp+cgVKX9ipbzHMUcykTHQKMwtOqZaOIFUXHCiAtaz31h/hWTFHSt32H6Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1789111508; bh=XDUvK9dnrR6LWxdmuI8cqstojs0dq6l/sUU74yykL4R=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=R8/7T6s2jmdskd+WpLwBRmEIHoy7lTd7NvV6soh7068hB5LpdmUVw4UevbkxWQXrnT3RodPIY8e21iu0C9FvrfY/0to7cz9/i1HuGTptfqAd1yW/a9LSpTKGvBdhdCnIOCs7VS56NmONijlTX1BJYQ7yL4VutOuvLfcXRNnImrUvIsO8/8FUAEt4mvoONnhqO14dSBQdUxk23cgv5hpRCpwxmnDKwwjvLwkKXJ8Y6VpMn4Et1gMx2Qowy9qbPWzVIfMstHLjg76z5NCUZxZD8atK1eshCXtbj2q8XWWrwqnkNaHTXG+t0XCqlBLhx8nlTcaKVIbgu4tpz+CxIF+sow==
X-YMail-OSG: Z7iXECgVM1kh.PBsb9xU6VBSCWRl0Z.FykmxECXqYgL8N3_qv60M7XLD.tfdt_1
 DSOfNx2YmBFVV_0zguET9QI.6TbtBCAogZXOuma.hHLQODnROXpEXKIqJXxt52.tI9LYCd6vA5Us
 BXRnxf.ogSX0KjOScs9OqLPl8LLC4DwwC0_eelM1hnVd7WokECt6DpqzDSw0KGML.8eBbNfjTWhC
 GQbJFdC60cUCdeEzLhaYBd8ngMpN8ABWowENgs_zg4T8bhdCeC90J4jIgFeZgZT_NqmxtvMe2vrD
 an5lZe3xzMCG21VfJDkMxCGfpSGimAASnPIkxcu7iXtXV7xH0AMCYAhMQjJWDGRAeCZOdHhu.2d3
 SskuwusqBjzdDaLkh7uq23xS52OxaUhRI3nDJ9cJbOGVtjTNCBpAUHZ9be746CX6VFEH.NeV8eVM
 Drg3E5ghnuexAJPP9BWitaoXtUH_HS72JsWWam4FTN5Dm3r9DOKvvc7DNEW7A7ICLXlf36vltUvk
 t8BsUNIIEjVZ0HxM9zt9WWEyMDkwWqkV_Kn9iKFNF14uu1Ur5XQ0haMG_3WpSXonnmV.8A6uoNzy
 PRg.QSImPiWusYu6Su3g1yLkSRAAbUKHAZMqJonvyZIeSCp0r0fyKTTWRfP1DdzI6zq7BLBUMHHb
 CMyuXq72XHzhHXtDAFCOxRRwk7vh5KKZvT10UEbhajMC9FmUQ3bzgj7VGmiu293k5VV8xUYPglbo
 4c2KbOdG9p0eg0Zc95CY3WwQhv3qBJRAbAF5p1_wLFXfksE1s9f4tm8543zGZxxZtIj8kp8WwQAA
 4MO7Mf400P4rzop7m6GuNZw2MCqbKhqxGQvNPe3yKSLJUGqOCaXuG5wJiOQHWzG5vPxT_mCFot7N
 vb1DZ38rt7QzlWPwn3esbsmKjoSNgNAQoNPmEe.HFUgfcikSYtCisqCRrEd78rRD9m7nsweGbm7R
 LY40C8Xk2HmqA6x4lA3qmEZPh3zySQsDHB5CTB_AJBOI1pasFYgHkn54YKX2JG1ZjQXNoNyecMN_
 vW.qvy1LcVKk_fZyZjAObF3XQuonwv_tkl.c0KhSLL9inNmubYAH8vFVb1cWrm7FSCfcJ.EWu4hg
 BywvFKin5y7ecgwqg4byGrbRZqwPmxgidNGk_baC9c2UUYzRT_8FxqH3.9YPse9q0ZLzJNUJmDI1
 YyoXZ1cVP2Phs3SxtiFIdVuuiVYTEbYowFPfhHCGkJPYuD5p301cCLQKal38iBIEQO3ghuvOjKvt
 XjE15DxbpTqdcyQRiIWhgCDOfxR_oMz1EkvP6Ac5oFkBbZNRuhT.AViiWSQvclN_HYwPeDO61xLQ
 qiDP69W4_DOczpFG4a2g7pmb7uZsLvlkKjpxIZ3DhJuZcAN31PpoKQvdHR12vSkuQZsPoVB8ngg7
 vpi14Ob2CKM.BmISz4gshTFqpHQ5.0Bmmdp0d9jodRjTDMMH9WAgcIwJOxJJkeHpua9Ex5vEsS2m
 QoJGKHoZ.ndNNSaIL1NfLkxJRZhEp9ol65ADtg_Pm4wK7q2dVYeyPW_S1ydSxfKbulhu0sKIyd59
 tGkt6iSb2kDbB3PBdF0Tchzh88_Td5myRXvMjETUA.K.PF4iCF6mGNpJSnurRkRiJ8EwfVV8GO4N
 TzYGTz5Z9Oosh6F3XUqIFwHDDzWlHhxMnbncCJM7GSpeiubhXw7szvIeUUVisk0.XjAxI3A5bMq6
 oBncDBtvymv19EvoyLdZyjOZCT3Szc8WJv0yPo22iiQZlqx2H0ev1BYAJkWsIZYOnLONLpQ3J99n
 6.fmpen7rf1BHQV64PVRdmdV.DICd1X1nwnDyGZZ_3KuDn26fX90sy5RD5xEkjKHNwYTKv91i4h1
 lShNSKKUYXl.iZ43ytbQUfhezEbDfq1nV3bhxh.33k7f8GJtr_IvviIMpP5vIAptvSZrNe2wXCKg
 tYuL5DmwR0HJCaU3MdmZn.H3NlIP6tDfXRYzAvWY0EAUOKBm0rO16drr_AdhgBXWPk0DBpgV6MjA
 NfL182rb2xzq0XoDrK_ONABB_Ku23aXuDgF6XkMyX._gbwO4Zz.SBELNrc4DXvWZWHC_3WovjBrA
 8nG3sdNiJHVlhFpfZnU5z38462dxPpPIDlQLatMdfAbYsVL1c1BJk22WI1QYFKut8hcmWMYLgikn
 OS2wd.dG.K8tNMP5s4XzNInIIb70uF6mqTdn1JlTOHXj69k6zk_MplSJx3mikL1fxPKtBGaJk5HL
 hmop9D3rB2HxUTN.XRHW9iR5EhAFH7msxGnbqjw--
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 1fa54d50-63c0-4570-a09f-9e5053848e1e
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.gq1.yahoo.com with HTTP; Fri, 11 Sep 2026 07:25:08 +0000
Received: by hermes--production-bf1-54b5569bdc-fv65m (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID c4451c0cd4386c4b1051306e68eb9ea1; 
 Fri, 11 Sep 2026 07:25:05 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v6 6/7] xen/igd: implement support for extended VBT
Date: Fri, 11 Sep 2026 03:24:52 -0400
Message-ID: <20260911072453.46256-7-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911072453.46256-1-brchuckz@aol.com>
References: <20260911072453.46256-1-brchuckz@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=98.137.68.30; envelope-from=brchuckz@aol.com;
 helo=sonic308-54.consmr.mail.gq1.yahoo.com
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

The current implementation of support for Intel IGD passthrough to a Xen HVM
guest relies on directly mapping the host OpRegion to the guest, and although
the OpRegion is 2 pages in size, it is not always page-aligned so an extra
page needs to be mapped to fully map it to the guest. This results in an extra
page of host memory mapped into the guest that should remain confidential to
the host. This is also why XEN_PCI_IGD_OPREGION_PAGES is currently set to 3
even though the size of the OpRegion is only 2 pages. So in this new
implementation avoid this confusion by redefining XEN_PCI_IGD_OPREGION_PAGES
to 2, the actual size of the OpRegion.

The current implementation also does not foresee the possibility that the
video bios table (VBT) might not be embedded as part of the 2-page OpRegion
but instead added on as an extended region beyond the 2 pages of the OpRegion.
In such cases, the 3 pages that are mapped in the current implementation are
not enough to hold both the OpRegion and the extended VBT.

The current implementation of support for Intel IGD passthrough to a Xen HVM
guest also relies on a position-independent OpRegion so the unmodified host
OpRegion can be mapped to a different address in the guest. However, as
indicated in the Link tags below referencing support for the Intel IGD in the
Linux kernel vfio driver, since the addition of devices with an extended VBT
the OpRegion is not always position-independent. That is, when the OpRegion
for such a device is mapped in the guest at a different address, it will not
work correctly in the guest. This position-dependent behavior arises from the
fact that the the address of an extended VBT is stored in the OpRegion in the
RVDA field of the OpRegion and in some cases that address is an absolute
address, not an address relative to the OpRegion base address, and in other
cases the extended VBT is not contiguous after the OpRegion in the host so in
such cases even a relative RVDA address would need to be adjusted for the
OpRegion to be compatible with the desired memory map in the guest where the
extended VBT would be contiguous with the OpRegion.

To overcome these problems, this new implementation exposes an emulated
OpRegion and VBT to the guest instead of directly mapping the host OpRegion to
the guest and also implements a protocol for communication between hvmloader
and Qemu so both the device model and hvmloader agree on the number of pages
to reserve for the OpRegion and VBT which varies depending on the size of
the extended VBT instead of being the constant value of 3 as in the current
implementation. In this new implemetation, Qemu reads the host OpRegion to
determine if there is an extended VBT and if so, how large it is and how many
pages are needed in the guest E820 map to accomodate both the OpRegion and
extended VBT. Also, in this new implementation, Qemu zero-pads the extraneous
memory in the areas before or after a non-page-aligned OpRegion or VBT to
avoid exposing memory to the guest that should be confidential to the host.

This implementation depends on compatible support in hvmloader and also
provides for backward compatibility and fallback to the old protocol when
either hvmloader or Qemu cannot fulfill the requirements of this new protocol.

This new protocol begins as follows: Before writing a value to the register
that stores the address of the OpRegion that Intel has defined as the ASLS
register and is identified in Qemu code as XEN_PCI_IGD_OPREGION, hvmloader
reads from the ASLS register and Qemu, in the case when Qemu detects a read
of the ASLS register before a write to the ASLS register, returns the number
of pages that hvmloader needs to reserve for the OpRegion and VBT in the guest
E820 map. With that information, hvmloader computes the address of the page
base of the OpRegion in the guest and writes that value to the ASLS register.
Then Qemu responds to this write to the ASLS register by computing the correct
value for the ASLS register so that future reads of the ASLS register return
that value to the guest. Qemu also responds to this write by constructing the
OpRegion and VBT for the guest, patching the RVDA value in the OpRegion if
necessary, and making the OpRegion and VBT a single continuous region
accessible to the guest at the address stored in the ASLS register using
Qemu's ioreq server.

If for any reason Qemu is unable to access the host OpRegion and is also
therefore unable to determine if there is an extended VBT and also unable to
compute how many pages are needed for the OpRegion and extended VBT, Qemu
falls back to the old protocol and direct maps the 3 pages from the host to
the guest that are needed to fully map a non-page-aligned host OpRegion. In
this case Qemu also returns 0 instead of the number of pages to reserve in the
E820 map which communicates to hvmloader that hvmloader should fall back to
the old protocol and assume 3 pages for the OpRegion and expect Qemu to
directly map the host OpRegion rather than expose an emulated OpRegion and VBT
using Qemu's ioreq server.

Qemu can fail to access the host OpRegion because Qemu's access to the host
OpRegion depends on Linux kernel support for this. Typically the Linux kernel
exposes device IO regions in the Linux sysfs filesystem, but in the case of
the OpRegion and VBT, these regions are only exposed in the Linux debugfs and
then only when the Intel IGD is bound to the i915 driver. This means that Qemu
does not have access to the OpRegion and VBT via the debugfs when the Intel
IGD is bound to the xen-pciback driver. So it is necessary that the OpRegion
and VBT be placed into the host filesystem where Qemu can access them when
the Intel IGD is bound to the xen-pciback driver. In this implementation,
the OpRegion and VBT files are searched for in files named "intel-opregion"
and "intel-vbt" in the directories configured by Qemu as firmware directories.
These files can be automatically placed into a suitable location in the host
filesystem when the Intel IGD is made assignable to a Xen guest with a
suitable patch to libxl or they can be manually placed into the host
filesystem by copying them from the debugfs to the "intel-opregion" and
"intel-vbt" files located in an appropriate Qemu firmware directory when the
Intel IGD is bound to the Linux kernel i915 driver. Assuming the Intel IGD is
at dri0 when bound to the Linux kernel i915 driver, the files in the debugfs
where the OpRegion and VBT are exposed on the host can be found at

/sys/kernel/debug/dri/0/i915_opregion

and

/sys/kernel/debug/dri/0/i915_vbt, respectively.

Another case that can occur is when hvmloader lacks support for this new
protocol. Qemu detects this case when hvmloader writes to the ASLS register
before the guest reads the register. In this case Qemu assumes hvmloader lacks
support for allocating more than 3 pages for the OpRegion so Qemu in this case
falls back to the old protocol of direct mapping the 3 host pages to the guest
that are needed to fully map a non-page-aligned host OpRegion to the guest.

This new protocol also requires that after Qemu makes the OpRegion and VBT
accessible to the guest via its ioreq server, hvmloader makes a copy of the
OpRegion and VBT and writes the address of the OpRegion back to the ASLS
register. Qemu responds to this second write of the OpRegion address to the
ASLS register by unmapping the pages containing the OpRegion and VBT from the
ioreq server. This makes it possible for hvmloader to back the pages that
store the OpRegion and VBT with RAM allocated to the guest. This last part of
the protocol is required to support Windows guests because testing indicates
the Windows graphics drivers are unable to access the OpRegion and VBT when
the OpRegion and VBT are exposed to the guest via Qemu's ioreq server, while
the Windows graphics drivers are able to access the OpRegion and VBT when the
pages that store them are backed by RAM allocated to the guest. After the
second write to the ASLS register which causes Qemu to unmap the OpRegion and
VBT from the ioreq server, Qemu ignores all subsequent writes to the ASLS
register from the guest. In this way the Windows IGD graphics drivers work
as expected.

Also ensure that in xen_pt_unregister_vga_regions the call to unmap the
OpRegion is only made in cases when we fall back to direct mapping of the
host OpRegion. We could keep the constant 3 for the number of pages to unnap
there since the number of pages to unmap will always be 3, but instead we use
the value of opregion_vbt_pages there which also will always be 3 when we fall
back to direct mapping of the host OpRegion to the guest.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/vfio/pci/vfio_pci_igd.c?id=bab2c1990b78
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/vfio/pci/vfio_pci_igd.c?id=49ba1a2976c8
Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
---
The comapnion patch to hvmloader will be posted to the xen-devel and qemu-devel
mailing lists shortly after this patch is posted. It is v3 of the patch
"tools/hvmloader: implement Intel IGD extended VBT support". Please note that
previous versions of that patch to hvmloader are not compatible with this
patch.

Changes in v6:
  - After considering comments on v2 of the companion patch to hvmloader, this
    patch has been totally re-worked. The work of reading the OpRegion,
    discovering if there is an extended VBT and how many pages of memory are
    needed to accomodate it, and patching the OpRegion if necessary, has been
    moved from hvmloader to Qemu since v5. There are some simplifications,
    such as the bitmask to communicate if extended VBT and OpRegion 2+ is
    supported has been replaced with a simpler protocol that involves Qemu
    noticing if the guest reads the OpRegion register before writing to it
    and hvmloader noticing if Qemu returns 0 or the number of pages needed for
    the OpRegion and VBT if hvmloader reads the OpRegion register before
    writing to it. Another simplification is that the complicated
    communication protocol with four extra writes to the OpRegion register
    has been mostly removed and replaced with ontly two writes, with the
    reason for the second write explained below.

  - All the code that involves reading the OpRegion, discovering if there is
    a VBT, how many pages are needed for the OpRegion + VBT, and patching the
    OpRegion if necessary has been moved from hvmloader to Qemu.

  - In contrast to v5 and the current implementation, the host OpRegion is
    never directly exposed to the guest. Instead, an emulated copy, patched if
    necessary, is exposed to the guest using Qemu's ioreq server.

  - Because Windows IGD drivers cannot access the OpRegion and VBT when it is
    exposed to the guest by the ioreq server, a second write to the OpRegion
    register from hvmloader is processed by Qemu to indicate to Qemu that the
    OpRegion and VBT must be unmapped from the ioreq server which allows
    hvmloader to configure the guest to use its own copy of the OpRegion + VBT
    that is backed by guest RAM. With this configuration in place, both
    Windows and Linux guests are able to access the OpRegion and VBT and work
    as expected.

Changes in v5:
  - fix style by adding braces to two if blocks and not initializing
    two static boolean variables to false
  - update the link to the companion patch for Xen hvmloader

Changes in v4:
  - v4 is the first version of the series that has this patch

 hw/xen/xen_pt_graphics.c | 266 +++++++++++++++++++++++++++++++++++++--
 include/hw/xen/xen_igd.h |   2 +-
 2 files changed, 257 insertions(+), 11 deletions(-)

diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index be71989..7136669 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -4,13 +4,27 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qemu/datadir.h"
 #include "hw/xen/xen_pt.h"
 #include "hw/xen/xen_igd.h"
+#include "hw/xen/xen-hvm-common.h"
 #include "xen-host-pci-device.h"
 #include "system/physmem.h"
 
 static unsigned long igd_guest_opregion;
 static unsigned long igd_host_opregion;
+static uint8_t *opregion_vbt; /* pointer to OpRegion + VBT */
+/*
+ * If there is an extended VBT or if the OpRegion is not aligned on a page
+ * boundary, we will need extra pages for the OpRegion + VBT.
+ */
+static unsigned int extra_opregion_pages;
+static unsigned long opregion_vbt_pages; /* # of pages for OpRegion + VBT */
+static uint16_t version; /* OpRegion version */
+static uint32_t rvds; /* VBT size */
+static unsigned long rvda_host; /* VBT address in host */
+static bool opregion_is_direct_mapped;
+MemoryRegion mr_opregion;
 
 typedef struct VGARegion {
     int type;           /* Memory or port I/O */
@@ -115,12 +129,11 @@ int xen_pt_unregister_vga_regions(XenHostPCIDevice *dev)
         }
     }
 
-    if (igd_guest_opregion) {
+    if (opregion_is_direct_mapped && igd_guest_opregion) {
         ret = xc_domain_memory_mapping(xen_xc, xen_domid,
                 (unsigned long)(igd_guest_opregion >> XC_PAGE_SHIFT),
                 (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
-                3,
-                DPCI_REMOVE_MAPPING);
+                opregion_vbt_pages, DPCI_REMOVE_MAPPING);
         if (ret) {
             return ret;
         }
@@ -237,8 +250,158 @@ void xen_pt_setup_vga(XenPCIPassthroughState *s, XenHostPCIDevice *dev,
 
 uint32_t igd_read_opregion(XenPCIPassthroughState *s)
 {
+    char opregion_file[64], vbt_file[64];
+    FILE *fp = NULL;
+    struct stat st;
+    uint8_t *opregion = NULL, *vbt = NULL;
+    void *ptr = NULL;
     uint32_t val = 0;
 
+    if (!igd_host_opregion) {
+        /* We just work with LE. */
+        xen_host_pci_get_block(&s->real_device, XEN_PCI_IGD_OPREGION,
+                               (uint8_t *)&igd_host_opregion, 4);
+
+        g_autofree const char *fname1 = g_strdup("intel-opregion");
+        g_autofree const char *path1 = qemu_find_file(QEMU_FILE_TYPE_BIOS,
+                                                      fname1);
+        /*
+         * If getting the OpRegion or VBT from the host filesystem fails,
+         * fallback to direct mapping of the host OpRegion to the guest.
+         */
+        if (!path1) {
+            XEN_PT_WARN(&s->dev, "OpRegion host file \"%s\" not found\n",
+                        fname1);
+            goto fallback;
+        }
+        snprintf(opregion_file, sizeof(opregion_file), "%s", path1);
+        fp = fopen(opregion_file, "r");
+        if (fp == NULL) {
+            if (errno != ENOENT) {
+                XEN_PT_WARN(&s->dev, "Cannot open %s: %s\n",
+                            opregion_file, strerror(errno));
+            }
+            goto fallback;
+        }
+        if (fstat(fileno(fp), &st) == -1) {
+            XEN_PT_WARN(&s->dev, "Cannot stat %s: %s\n",
+                        opregion_file, strerror(errno));
+            goto fallback;
+        }
+        if (st.st_size != XEN_PCI_IGD_OPREGION_PAGES << XC_PAGE_SHIFT) {
+            XEN_PT_WARN(&s->dev, "Invalid OpRegion size (%u)\n", st.st_size);
+            goto fallback;
+        }
+        opregion = g_new0(uint8_t, st.st_size);
+        ptr = (void *)opregion;
+        if (fread(ptr, 1, st.st_size, fp) != st.st_size) {
+            XEN_PT_WARN(&s->dev, "Can't read host OpRegion %s\n",
+                        opregion_file);
+            goto fallback;
+        }
+        if (memcmp(ptr, XEN_PCI_IGD_OPREGION_SIGNATURE, 16)) {
+            XEN_PT_WARN(&s->dev, "Invalid OpRegion signature\n");
+            goto fallback;
+        }
+        fclose(fp);
+
+        version = *(uint16_t *)(opregion +
+                                XEN_PCI_IGD_OPREGION_VERSION);
+        XEN_PT_LOG(&s->dev, "OpRegion version: 0x%x\n", version);
+        if (version >= 0x0200) {
+            rvda_host = *(unsigned long *)(opregion +
+                                           XEN_PCI_IGD_OPREGION_RVDA);
+            /* It is convenient to make rvda_host absolute */
+            if (version > 0x0200) {
+                rvda_host += igd_host_opregion;
+            }
+            XEN_PT_LOG(&s->dev, "host VBT address: 0x%lx\n", rvda_host);
+            rvds = *(uint32_t *)(opregion +
+                                 XEN_PCI_IGD_OPREGION_RVDS);
+            XEN_PT_LOG(&s->dev, "VBT size: 0x%x\n", rvds);
+        }
+
+        if (rvds && rvda_host) {
+            g_autofree const char *fname2 = g_strdup("intel-vbt");
+            g_autofree const char *path2 = qemu_find_file(QEMU_FILE_TYPE_BIOS,
+                                                          fname2);
+            if (!path2) {
+                XEN_PT_WARN(&s->dev, "VBT host file \"%s\" not found\n",
+                            fname2);
+            goto fallback;
+            }
+            snprintf(vbt_file, sizeof(vbt_file), "%s", path2);
+            fp = fopen(vbt_file, "r");
+            if (fp == NULL) {
+                if (errno != ENOENT) {
+                    XEN_PT_WARN(&s->dev, "Cannot open %s: %s\n",
+                                vbt_file, strerror(errno));
+                }
+                goto fallback;
+            }
+            if (fstat(fileno(fp), &st) == -1) {
+                XEN_PT_WARN(&s->dev, "Cannot stat %s: %s\n",
+                            vbt_file, strerror(errno));
+                goto fallback;
+            }
+            if (st.st_size != rvds) {
+                XEN_PT_WARN(&s->dev, "Invalid VBT size (%u)\n", st.st_size);
+                goto fallback;
+            }
+            vbt = g_new0(uint8_t, st.st_size);
+            ptr = (void *)vbt;
+            if (fread(ptr, 1, st.st_size, fp) != st.st_size) {
+                XEN_PT_WARN(&s->dev, "Can't read host VBT %s\n",
+                            vbt_file);
+                goto fallback;
+            }
+            if (memcmp(ptr, XEN_PCI_IGD_VBT_SIGNATURE, 4)) {
+                XEN_PT_WARN(&s->dev, "Invalid VBT signature\n");
+                goto fallback;
+            }
+            fclose(fp);
+            extra_opregion_pages = rvds >> XC_PAGE_SHIFT;
+            if (rvds & XEN_PCI_IGD_OPREGION_MASK) {
+                extra_opregion_pages++;
+            }
+            if (((igd_host_opregion & XEN_PCI_IGD_OPREGION_MASK) +
+                (rvds & XEN_PCI_IGD_OPREGION_MASK)) >
+                (1 << XC_PAGE_SHIFT)) {
+                extra_opregion_pages++;
+            }
+        } else {
+            rvda_host = 0;
+            rvds = 0;
+            if (igd_host_opregion & XEN_PCI_IGD_OPREGION_MASK) {
+                extra_opregion_pages = 1;
+            }
+        }
+
+        opregion_vbt_pages = XEN_PCI_IGD_OPREGION_PAGES +
+                             extra_opregion_pages;
+        opregion_vbt = g_new0(uint8_t,
+                              opregion_vbt_pages << XC_PAGE_SHIFT);
+        ptr = (void *)(opregion_vbt +
+                       (igd_host_opregion & XEN_PCI_IGD_OPREGION_MASK));
+        memcpy(ptr, (void *)opregion,
+               XEN_PCI_IGD_OPREGION_PAGES << XC_PAGE_SHIFT);
+        if (rvds) {
+            ptr += (XEN_PCI_IGD_OPREGION_PAGES << XC_PAGE_SHIFT);
+            memcpy(ptr, (void *)vbt, rvds);
+        }
+        g_free(opregion);
+        g_free(vbt);
+        /*
+         * By returning the size of the OpRegion + VBT here instead of 0, we
+         * indicate to hvmloader that we support an extended VBT and we give
+         * hvmloader the information it needs to place the OpRegion + VBT in
+         * the E820 map. Also, in this case the guest read the OpRegion
+         * register before writing to it, which means the guest supports
+         * an extended VBT.
+         */
+        return opregion_vbt_pages;
+    }
+
     if (!igd_guest_opregion) {
         return val;
     }
@@ -247,11 +410,38 @@ uint32_t igd_read_opregion(XenPCIPassthroughState *s)
 
     XEN_PT_LOG(&s->dev, "Read opregion val=%x\n", val);
     return val;
+
+fallback:
+    XEN_PT_LOG(&s->dev, "Fallback to host OpRegion mapping\n");
+    opregion_is_direct_mapped = true;
+    if (fp) {
+        fclose(fp);
+    }
+    g_free(opregion);
+    g_free(vbt);
+    return val;
 }
 
 void igd_write_opregion(XenPCIPassthroughState *s, uint32_t val)
 {
     int ret;
+    static bool opregion_is_ioreq_mapped;
+    static unsigned long igd_guest_opregion_pgbase;
+
+    if (opregion_is_ioreq_mapped && (val == igd_guest_opregion)) {
+        /*
+         * To support Windows IGD drivers that don't work with the OpRegion
+         * and VBT when they are mapped to an ioreq server, hvmloader writes
+         * the value of igd_guest_opregion a second time to signal it is time
+         * to unmap the OpRegion from the ioreq server. Hvmloader has made
+         * a copy of the OpRegion and will configure the guest to use its
+         * copy. In this way, the Windows IGD drivers work as expected.
+         */
+        memory_region_del_subregion(get_system_memory(), &mr_opregion);
+        object_unparent(OBJECT(&mr_opregion));
+        opregion_is_ioreq_mapped = false;
+        XEN_PT_LOG(&s->dev, "Successfully configured emulated OpRegion\n");
+    }
 
     if (igd_guest_opregion) {
         XEN_PT_LOG(&s->dev, "opregion register already been set, ignoring %x\n",
@@ -259,16 +449,73 @@ void igd_write_opregion(XenPCIPassthroughState *s, uint32_t val)
         return;
     }
 
-    /* We just work with LE. */
-    xen_host_pci_get_block(&s->real_device, XEN_PCI_IGD_OPREGION,
-            (uint8_t *)&igd_host_opregion, 4);
+    if (!igd_host_opregion) {
+        /* We just work with LE. */
+        xen_host_pci_get_block(&s->real_device, XEN_PCI_IGD_OPREGION,
+                               (uint8_t *)&igd_host_opregion, 4);
+        opregion_is_direct_mapped = true;
+    }
     igd_guest_opregion = (unsigned long)(val & ~XEN_PCI_IGD_OPREGION_MASK)
                             | (igd_host_opregion & XEN_PCI_IGD_OPREGION_MASK);
+    igd_guest_opregion_pgbase = igd_guest_opregion &
+                                ~XEN_PCI_IGD_OPREGION_MASK;
+
+    if (opregion_is_direct_mapped) {
+        XEN_PT_LOG(&s->dev, "hvmloader lacks extended VBT support, "
+                   "continuing with legacy support only\n");
+        /*
+         * In this case we need to direct map the OpRegion because either we
+         * failed to get a copy of the OpRegion from the host filesystem or
+         * the guest does not support an extended VBT. In this case we also
+         * assume we need an extra page because the OpRegion is not always
+         * aligned on a page boundary.
+         */
+        extra_opregion_pages = 1;
+        opregion_vbt_pages = XEN_PCI_IGD_OPREGION_PAGES +
+                             extra_opregion_pages;
+        goto map;
+    } else {
+        Object *owner = OBJECT(&s->dev);
+        unsigned long rvda_guest = 0; /* VBT address in guest */
+
+        /* Compute rvda value for the guest */
+        if (rvds && (version > 0x0200)) {
+            if (version == 0x0200) {
+                rvda_guest = igd_guest_opregion +
+                             (XEN_PCI_IGD_OPREGION_PAGES << XC_PAGE_SHIFT);
+            } else {
+                /* Convert to relative address */
+                rvda_guest = XEN_PCI_IGD_OPREGION_PAGES << XC_PAGE_SHIFT;
+                rvda_host -= igd_host_opregion;
+            }
+        }
+
+        /* Patch the OpRegion with the correct rvda value for the guest */
+        if (rvds && (rvda_guest != rvda_host)) {
+            *(unsigned long *)(opregion_vbt + (igd_guest_opregion &
+                               XEN_PCI_IGD_OPREGION_MASK) +
+                               XEN_PCI_IGD_OPREGION_RVDA) = rvda_guest;
+            XEN_PT_LOG(&s->dev, "Patched OpRegion with guest rvda = 0x%lx\n",
+                       rvda_guest);
+        }
+
+        /* Configure ioreq server for the emulated OpRegion */
+        memory_region_init_ram(&mr_opregion, owner, "xen.intel.opregion",
+                               opregion_vbt_pages << XC_PAGE_SHIFT,
+                               &error_fatal);
+        memory_region_add_subregion(get_system_memory(),
+                                    igd_guest_opregion_pgbase, &mr_opregion);
+        void *ptr = memory_region_get_ram_ptr(&mr_opregion);
+        memcpy(ptr, (void *)opregion_vbt, opregion_vbt_pages << XC_PAGE_SHIFT);
+        g_free(opregion_vbt);
+        opregion_is_ioreq_mapped = true;
+        return;
+    }
 
+map:
     ret = xc_domain_iomem_permission(xen_xc, xen_domid,
             (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
-            XEN_PCI_IGD_OPREGION_PAGES,
-            XEN_PCI_IGD_OPREGION_ENABLE_ACCESSED);
+            opregion_vbt_pages, XEN_PCI_IGD_OPREGION_ENABLE_ACCESSED);
 
     if (ret) {
         XEN_PT_ERR(&s->dev, "[%d]:Can't enable to access IGD host opregion:"
@@ -281,8 +528,7 @@ void igd_write_opregion(XenPCIPassthroughState *s, uint32_t val)
     ret = xc_domain_memory_mapping(xen_xc, xen_domid,
             (unsigned long)(igd_guest_opregion >> XC_PAGE_SHIFT),
             (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
-            XEN_PCI_IGD_OPREGION_PAGES,
-            DPCI_ADD_MAPPING);
+            opregion_vbt_pages, DPCI_ADD_MAPPING);
 
     if (ret) {
         XEN_PT_ERR(&s->dev, "[%d]:Can't map IGD host opregion:0x%lx to"
diff --git a/include/hw/xen/xen_igd.h b/include/hw/xen/xen_igd.h
index 469171c..e66b3a3 100644
--- a/include/hw/xen/xen_igd.h
+++ b/include/hw/xen/xen_igd.h
@@ -13,7 +13,7 @@
 
 #define XEN_PCI_IGD_OPREGION 0xfc
 #define XEN_PCI_IGD_OPREGION_MASK 0xfff
-#define XEN_PCI_IGD_OPREGION_PAGES 0x3
+#define XEN_PCI_IGD_OPREGION_PAGES 0x2
 #define XEN_PCI_IGD_OPREGION_ENABLE_ACCESSED 0x1
 #define XEN_PCI_IGD_OPREGION_SIGNATURE "IntelGraphicsMem"
 #define XEN_PCI_IGD_VBT_SIGNATURE "$VBT"
-- 
2.52.0


