Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BA0C79FA1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4vjL-0003s8-JV; Fri, 11 Sep 2026 03:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1x4vjA-0003qt-BP
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 03:31:21 -0400
Received: from sonic311-23.consmr.mail.gq1.yahoo.com ([98.137.65.204])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1x4vj5-0000Sz-Pf
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 03:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1789111868; bh=oEF+IFkFwoafYiOJyTp5xRVvzljf8kYJMfjjfTEgYx8=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=uQyO/jnbFDn1KmlolUDK8qcfswHROsABC2yFuVRU8bzkitANFZLxTghrGonAvdrjXjkLItVLK/E6Ngy2TzyNX8PvZI+t6rzNnDWn7OBVHsoYnHj0SONu0STuk5DorETV+Cdr58J8qtHZoDkhGPVfADnMgqgfvDchRBPrBulmfP+x1c0TzAZps5MYRoQGvs1VnWEFiNFTq3s+iYqa1SEbVt5Dv+U5hpAXtlMiZ9fJPdlWg4zYyhmMb3jb+dGAVmkYSf7g/1Sdo/Kxkle4I2JVBCIhBaa9Ux+/V++VoOG7pVO9Esi0vt2TRqhnNTHbiFJ4BO/XDOBiZFjFaG7vmeFNMg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1789111868; bh=Imkblp6PdzvIL8+yX02ciwbI/w5m1cEMrfyThSPk6Tf=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=DwUXATuAHsmRLXv4gvas+2gGKXDrlUH1DaaK94OvJa3hiUWBtrhul/eoRYUd53sfmxubu+VbHpBSOX4Lu7FKVPinbBjKyy9GkuoUVXqaiXSwD7cO9D7biBu+YKZaPqh774u8QBKCn0t6nr+4vHM3BmpiJ39hKxIwnZZfXzvNDVWkDj8u87arLplqjqgtEzvN6LTNFDndg2GnRiaHG5LPd1IweDH34SN8cr0YVO9vUinJbNKBFXB0mZV+6z+0WYZhXjAVJJ5WGh9r8LAdaEEVz9nAj7Rh4vKv4DbgjV3rp0gO8Dq6PTO2knGREytYexuOECXtsAbQHUgnmO3d+fb8MA==
X-YMail-OSG: _hsesV8VM1nGiipDOsndukFlWUf3W1f1496y6RhLwLRX_6t_R7ZCgvp2qVc2JPS
 bBD.N1ARLeEhXCmfEN7642NHXoAiiWfLdHY2z_AAS7S3YIRk3DcnRp1wu5aU95kRf1rA3ZYfSea2
 Vn3fzG3O9vLAr3YmYRNgdytgckSZ7cFiTk0o59EkyATuXQ_QnNAHHzgHMpkzpIW12smnm7Xvn.PI
 RPZ0Tb3NacoMajfozP0JblHpOoyThe05SA2eoRJYvJU42r.5Q7F9onMBEr2dGa6XitSUnEeOgdMw
 7TpjRB.9ViDOrKJSOrUuAbWdotNrAdXWFwZ7U31ypryhdfjl5kcvBOBmfs7Q.8HtyE1Rbq86GVQA
 AVYHrvpW3bNypDs.c_ZZIqbHH0W7UtHqqhvN_U_7uhy6iNFPYpjwrRTwlFzBSuk5MaPI_VKLfueT
 Yty0BADVhnqOf3k.Myxtfd123b.O5V22PBtdPcyfS6xAaKzd.tEc8VrAOIMjDOupD9mvVfi4Ni3f
 1BrEwA86gU3o5_bvWOlon3ACpAp3ZD5tzaOEfT7RvrH9NGzZ0xP.E.VByJQ.eTXNUNVCtQRQa6uB
 jN0x2dMg4q4W5dHJ.n9QUrdBTnXvmfU.4pfF1H5J0Ly4gaqC59lG_tO8ArOANZYIV82LXGNhM2gn
 2.4MhYiVDB0Yj6bfHqrqTNE7cL8Yp_J6gfMhctj4MbERxX8ZSYfpySVYG2k2kSf6fVDrA0qgPYRK
 ZlsPkoVQZvU.o23hxeip8hAGGF.pzCDlOHSqf8DY6A_w_q41l9CCyYSd4jRkA1X1q0vpZ0ODYuCl
 pw.SwhPJ7rX0BpPAa56Kf.8ysKghrFw2G5eeGfwJEDZL1Dqksls9BlP81OpFEYorP8OEBfc8T916
 eYV0kjJg6gfxkm9.GL8SCrYeXHBLJ5no6Y7EJYSiLM5erZO7UxBQe3ey0h5wl0DCRqZfQSvHkJc_
 fnJZgtCmgTILJo5rlta50SDmw4i2bQzI8T3BQX9jwttBOqgxFDo5WG4qGT3.Xv9OGt1eWQTMeWjc
 MNHef.uxOw.B1mhUqw1lUoDWEHi9vg7FJkAj9c5vcis3VBQGip0xgy5vG4u6EMy4Rk6Gv5xEnKZX
 IMxhgtyubI5k0LhzjvgYQPCA6dG6IhawfMEqg7JGLL1m3OCB7a1g5q8hT8tlNQAdexIyK40qGMZ2
 jfBZCiemA4wIHahPTytz7jpdxJTQ3.uNiWuQzafZjkSTTmtMDMUEiDZsGZIPvuxS8Yhyc7Y8ttRC
 zIQnwLQSBNznVjk.Yk7CrAAXy8qUjmE2P26tII4OzF5mdPpAK9gfpJkFkymUcX0YXnoWFxWMPdSE
 7_JdGI89vV88mEeemnn7q6Y1M8XH2czRcqcpP9sfTbiHkhFeYhDvsOxeKECn94o6SeClgDUzpTrk
 np_Jt.tsfOr508omr8NGG6P.g6c.ezsoX2mPPjd5FBfl.XtO5upH0Ja9icXqHNmglsP6N8nwKvs3
 ED74BwOZgMUmW4ogQeg1oSTr8OmcHQ9a8uesJHKUoLyvlJiFsNIPNe6wB1r.avwWXIi_CcuI1kbI
 02RO03wqhUnoWEjMsx5NLCfn0IOtX26eJKcGVmA7o5YQuMFTrztbcFtOpLZxOFosaHywde6UrmF6
 k3YUNsZ0sb1E1wS7.ixAFdR2u8lswJ9NTNjtMK1gjtulh66jh09lQuYhdf58SwIMrpWVMWQVhIo9
 S6TsPzyKRFbOBIdg7kOpVpUW9H3oaLouaxhVanPs6q5_GH4FQG6quCbN1OSwHDIo1Rj7sdW0OUQL
 UiZACgzloD9CJhoZLzMva7E6BmS5sOJ7Z0uS8_iY8zyXWl71YH81O72m_u0uuKR_IuStiE3z8G3m
 4MJOceeKJejs9izJFPVmcgbPwje43788GVMkBcn65sL1McZtaQMEYkbzaDrpq2R5YwKgOWt54ysX
 NcrJgZokS.qSUgPPNsfCSLYhH4gwPkSpIf5E5kCX_PLR.mPpR2Pr3qXdkIz47tAqdaIt1E01vd2E
 AzfO4qsmlgnOBSCIAfrwoKtTxEFBxFL9i7HwpSVvQ5AnkP4QgGrBjT7cqKiCJumTd6PEM3Ske3i_
 xP7g4r6NZe5a6GoQnWvuqCScUSWLGNazmDx617DUmAzg1wvWGlH5P8TCznqzVjKE_1gECz5orJOO
 4lE1xj7qWs6DKx2cIhBi2x4lnIAEcmUKrlhZ1dEJ5DoMj3ynPptJZpvX8ZMPeCUQ7kprpYrEWRDG
 HyDcSaFVmc61j8nnRPS5Ci9FVpr2Nns0Ko5c41Q--
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: b036158c-adfc-485b-9f97-582b3a4c444c
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Fri, 11 Sep 2026 07:31:08 +0000
Received: by hermes--production-ne1-6dbcb84f44-gmhd4 (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 35c30668e815a5a8f301e7d03e7151e1; 
 Fri, 11 Sep 2026 07:31:05 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: xen-devel@lists.xenproject.org
Cc: qemu-devel@nongnu.org, Jan Beulich <jbeulich@suse.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>
Subject: [PATCH v3] tools/hvmloader: implement Intel IGD extended VBT support
Date: Fri, 11 Sep 2026 03:31:03 -0400
Message-ID: <20260911073103.46745-1-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260911073103.46745-1-brchuckz.ref@aol.com>
Received-SPF: pass client-ip=98.137.65.204; envelope-from=brchuckz@aol.com;
 helo=sonic311-23.consmr.mail.gq1.yahoo.com
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

Modern Intel IGD devices do not work well with the current implementation of
support for the Intel IGD in hvmloader because it lacks support for an
extended video bios table (VBT).

Code 43 errors in Windows guests and failure of the guest screen to light up
are some of the problems that occur with the current implementation.

To address this problem, this patch implements support for Intel IGD devices
with an extended VBT and OpRegion version 2+ which is required for most modern
Intel IGD devices, as noted in the Linux kernel vfio commits referenced in the
Link tags below. This patch ports support for devices with an extended VBT and
OpRegion 2+ which was added in those commits for KVM/vfio, but adapted for Xen
HVM guests with PCI passthrough.

This patch depends on compatible support in the device model. If hvmloader
detects the device model lacks such support, it will fall back to the
currently implemented protocol for configuring the OpRegion to provide
backward compatibiltiy for systems that lack a device model with support for
an extended VBT.

The primary reason the OpRegion needs to be patched in some cases is that with
the addition of the RVDA and RVDS fields to the OpRegion, the OpRegion is not
position-independent and may need to be patched if it is moved to a different
address in the guest. This means the current protocol of having the device
model directly map the unmodified host OpRegion to the guest is not compatible
with the requiremnts of the newer devices that in some cases require that the
OpRegion be modified for it to be compatible with the guest address space.

In this implementation, the device model has the responsibility to read the
host OpRegion and patch it as needed before exposing it to the guest. Since an
extended VBT means more pages are needed for the OpRegion, depending on the
size of the extended VBT, hvmloader has the responsibility to edit the E820
map to accomodate the additional pages needed to contain the OpRegion + VBT.

To implement this in hvmloader, use a variable, igd_opregion_e820_pages,
instead of the constant, IGD_OPREGION_PAGES, to represent the number of pages
to reserve in the E820 map for the OpRegion + VBT. Also, to remove the
confusion introduced by setting IGD_OPREGION_PAGES to 3 in an earlier patch
to account for the fact that the OpRegion is not guaranteed to be aligned on
a page boundary, reset IGD_OPREGION_PAGES to 2 so it matches the actual size
of the OpRegion.

Instead of only writing to the PCI_INTEL_OPREGION register, first read from it
to provide a way for both hvmloader and the device model to discover if both
components have support for an extended VBT and more than 3 pages reserved for
the OpRegion + VBT. The device model detects the read of the register before
the write to learn that hvmloader has support, and hvmoader detects that the
device model returns the number of pages to reserve for the OpRegion + VBT
instead of 0 when it first reads the register to learn that that the device
model has support. When this new protocol is supported by both hvmloader and
the device model, the device model will not expose the host OpRegion directly
to the guest via a direct mapping as the old protocol does but instead exposes
an emulated copy of the OpRegion and VBT using its ioreq server. This has the
added beneift of preventing extraneous host memory in the regions before or
after a non-page-aligned OpRegion that should be confidential to the host from
being exposed to the guest.

Testing reveals that when the device model exposes the OpRegion to the guest
by mapping it to the device model's ioreq server, the Windows Intel IGD
graphics dirvers are unable to access the OpRegion and report Code 43 errors
with the result being that the guest screen never lights up. So after the
device model exposes the OpRegion to the guest using its ioreq server, make a
copy of it and use a copy of the OpRegion and VBT which is backed by RAM
allocated to the guest instead of mapped via the ioreq server. This fixes the
Code 43 errors reported by the Windows IGD graphics drivers.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/vfio/pci/vfio_pci_igd.c?id=bab2c1990b78
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/vfio/pci/vfio_pci_igd.c?id=49ba1a2976c8
Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
---
The companion patchset for the device model (DM) is available here:

https://lore.kernel.org/qemu-devel/20260911072453.46256-7-brchuckz@aol.com/

Note that this patch uses an approach that is not compatible with earlier
versions of the patchset for the DM. The version of that patchset that is
compatible with this patch is v6.

Up-to-date specifications for the Intel IGD are not available to the public
but an older version is available from Intel here:

https://www.intel.com/content/www/us/en/docs/graphics-for-linux/developer-reference/1-0/opregion-specification.html

This patch derives the specifications for the OpRegion that are needed to
add support for an extended VBT from the patches to the Linux kernel vfio
driver. This mainly consists of the RVDA and RVDS fieds of the OpRegion which
store the address and size of the extended VBT, respectively. See the links
in the commit message which provide links to the vfio patches that added
support for this feature to KVM/VFIO guests for more details.

There is an undocumented setting that works in the xl.cfg(5) domain
configuration file, firmware_override, that makes it possible to use
a patched version of hvmloader alongside an installation of unpatched
upstream Xen or a version of Xen packaged by a distro. So one can
download the source for one's installed version of Xen, apply this
patch and build just hvmloader and then install the patched version of
hvmloader with a different filename, such as hvmloader-igd-testing, into
the same directory where hvmloader is installed (usually something like
/usr/libexec/xen/boot) and then one can configure a guest to use the patched
version of hvmloader with one's installed version of Xen by adding a line
like this to the domain xl.cfg file:

firmware_override = 'hvmloader-igd-testing'

The compatible patch for the DM is part of a larger patchset that fixes
many of the problems that currently affect the feature of Intel IGD
passthrough to Xen HVM guests. This patch should be considered as a companion
patch to that patchset for the DM. Do not try to test this patch with a real
Intel IGD device without also applying the patchset for the DM because without
those patches, the guest will most likely fail to start if an Intel IGD is
passed through to the guest.

Changes in v3:
  - The patch has been substantially re-worked. Most of the implementation
    of support for Intel IGD in v2 that could be implemented in the DM
    instead of in hvmloader has been moved to the DM. Specifically, the
    responsibility to read the OpRegion and patch it if necessary is done in
    the DM instead of in hvmloader. This change is in response to the
    comments that were made on v2 of this patch.

  - In contrast to both the current implementation and the implementation
    in v2, the host OpRegion is never directly exposed to the guest. Instead,
    the DM exposes an emulated copy of the OpRegion to the guest, patched
    appropriately for the guest, using the DM's ioreq server.

  - Hvmloader's main responsibility is to allocate enough pages in the E820
    map to accomodate both the OpRegion and the extended VBT. In v3, hvmloader
    relies on the DM to communicate the number of pages that are needed for
    the OpRegion + VBT, and this change means all the code in v2 related to
    discovering the size of the extended VBT has been removed from hvmloader
    in v3 and moved to the DM.

  - Backward compatibility with versions of the DM that do not support
    an extended VBT has been simplified. There is no need for a bitmask
    setting to indicate support for extended VBT and OpRegion 2 and higher.
    Instead, the DM learns that hvmloader has support by detecting a read of
    the OpRegion register before a write to it, and hvmloader learns that the
    DM has support if the DM returns a non-zero value, the number of pages
    needed for the OpRegion + VBT, in response to the first read by hvmloader.

  - It was necessary to retain the code that populates the pages allocated for
    the OpRegion and VBT with guest RAM and copying the OpRegion and VBT to
    that guest RAM because testing revealed that when the OpRegion and VBT are
    exposed to the guest by the DM's ioreq server, Windows graphics drivers
    are unable to access the OpRegion and VBT.

  - To remove the confusion with the value of IGD_OPREGION_PAGES that is
    currently set to 3 to account for the fact that the OpRegion is not always
    aligned on a page boundary, it has been changed in v3 to 2, the actual
    number of pages needed for the OpRegion (not including an extended VBT).

  - Added a check on the number of pages needed for the OpRegion + VBT to
    ensure the region does not take up an unreasonably large percentage of the
    reserved dynamic memory range.

I also provide the following table that hopefully helps illustrate how v3
of this patch differs from v2:

Resource/Description          Proposed in v2            Proposed in v3
------------------------------------------------------------------------------
OpRegion register             Emulated in DM            Emulated in DM
------------------------------------------------------------------------------
OpRegion                      Emulated (hvmloader       Emulated in DM (guest
                              makes a copy from direct  accesses emulated copy
                              mapped host OpRegion      provided by DM and
                              and from then on guest    from then on guest
                              accesses its own copy     accesses its own copy
                              stored in guest memory)   stored in guest memory)
------------------------------------------------------------------------------
Extended VBT                  Emulated (hvmloader       Emulated in DM (guest
                              makes a copy from direct  accesses emulated copy
                              mapped host VBT and       provided by DM and from
                              from then on guest        then on guest accesses
                              accesses its own copy     its own copy stored in
                              stored in guest memory)   guest memory)
------------------------------------------------------------------------------
E820 pages allocated          Depends on extended VBT   Depends on extended VBT
                              size if there is an       size if there is an
                              extended VBT              extended VBT
------------------------------------------------------------------------------
If OpRegion needs patching    hvmloader patches it      DM patches it
------------------------------------------------------------------------------
Setting the OpRegion          Done by DM after complex  Done by DM with hint
register                      communication protocol    from hvmloader which
                              with hvmloader completes  provides DM with page
                                                        base address of
                                                        OpRegion in guest
------------------------------------------------------------------------------

Changes in v2:
  - Correct the name of the new function in the commit message
    opregion_setup() -> intel_opregion_setup()

  - Add a link to the companion patchset for the device model

  - Describe how to use the firmware_override setting in xl.cfg(5)
    to simplify testing of this patch.

  - Correct a logical flaw that in case the size of the extended VBT
    is <= 2 pages, an extra, unnecessary page would be allocated in
    the memory hole. This correction is in the intel_opregion.c file.

    This code:

    /* Update the number of pages we need for the E820 map */
    igd_opregion_e820_pages = pages_needed;

    /*
     * So far we have allocated vbt_pages_needed
     * and we will likely need to allocate more
     * pages to fully contain OpRegion + VBT.
     */
    if ( pages_needed > vbt_pages_needed )
        igd_opregion_pgbase = mem_hole_alloc
                              (pages_needed - vbt_pages_needed);

    Is replaced with this code:

    /*
     * So far we have allocated igd_opregion_e820_pages
     * and we will likely need to allocate more
     * pages to fully contain OpRegion + VBT.
     */
    if ( pages_needed > igd_opregion_e820_pages )
        igd_opregion_pgbase = mem_hole_alloc
                              (pages_needed - igd_opregion_e820_pages);

    /* Update the number of pages we need for the E820 map */
    igd_opregion_e820_pages = pages_needed;

 tools/firmware/hvmloader/config.h |  6 +-
 tools/firmware/hvmloader/e820.c   |  4 +-
 tools/firmware/hvmloader/pci.c    | 96 ++++++++++++++++++++++++++++++-
 3 files changed, 100 insertions(+), 6 deletions(-)

diff --git a/tools/firmware/hvmloader/config.h b/tools/firmware/hvmloader/config.h
index c159db3..edc3a8d 100644
--- a/tools/firmware/hvmloader/config.h
+++ b/tools/firmware/hvmloader/config.h
@@ -8,7 +8,8 @@ enum virtual_vga { VGA_none, VGA_std, VGA_cirrus, VGA_pt };
 extern enum virtual_vga virtual_vga;
 
 extern unsigned long igd_opregion_pgbase;
-#define IGD_OPREGION_PAGES 3
+extern unsigned int igd_opregion_e820_pages;
+#define IGD_OPREGION_PAGES 2
 
 struct bios_config {
     const char *name;
@@ -75,6 +76,9 @@ extern bool acpi_enabled;
 #define ACPI_MEMORY_DYNAMIC_START     0xFC001000
 #define RESERVED_MEMORY_DYNAMIC_START 0xFC100000
 #define RESERVED_MEMORY_DYNAMIC_END   0xFE000000
+#define RESERVED_MEMORY_DYNAMIC_PAGES (RESERVED_MEMORY_DYNAMIC_END - \
+                                       RESERVED_MEMORY_DYNAMIC_START) >> \
+                                       PAGE_SHIFT
 /*
  * GUEST_RESERVED: Physical address space reserved for guest use.
  * This is not dynamically advertised to guests, so this range must *never*
diff --git a/tools/firmware/hvmloader/e820.c b/tools/firmware/hvmloader/e820.c
index 86d3954..97a234e 100644
--- a/tools/firmware/hvmloader/e820.c
+++ b/tools/firmware/hvmloader/e820.c
@@ -243,11 +243,11 @@ int build_e820_table(struct e820entry *e820,
         nr++;
 
         e820[nr].addr = igd_opregion_base;
-        e820[nr].size = IGD_OPREGION_PAGES * PAGE_SIZE;
+        e820[nr].size = igd_opregion_e820_pages * PAGE_SIZE;
         e820[nr].type = E820_NVS;
         nr++;
 
-        e820[nr].addr = igd_opregion_base + IGD_OPREGION_PAGES * PAGE_SIZE;
+        e820[nr].addr = igd_opregion_base + igd_opregion_e820_pages * PAGE_SIZE;
         e820[nr].size = (uint32_t)-e820[nr].addr;
         e820[nr].type = E820_RESERVED;
         nr++;
diff --git a/tools/firmware/hvmloader/pci.c b/tools/firmware/hvmloader/pci.c
index c41c8d9..efe6b68 100644
--- a/tools/firmware/hvmloader/pci.c
+++ b/tools/firmware/hvmloader/pci.c
@@ -44,6 +44,7 @@ uint64_t pci_hi_mem_start = 0, pci_hi_mem_end = 0;
 
 enum virtual_vga virtual_vga = VGA_none;
 unsigned long igd_opregion_pgbase = 0;
+unsigned int igd_opregion_e820_pages = 0;
 
 /* Check if the specified range conflicts with any reserved device memory. */
 static bool check_overlap_all(uint64_t start, uint64_t size)
@@ -93,6 +94,9 @@ void pci_setup(void)
     uint16_t class, vendor_id, device_id;
     unsigned int bar, pin, link, isa_irq;
     uint8_t pci_devfn_decode_type[256] = {};
+    uint32_t igd_opregion;
+    void *opregion_vbt_scratch;
+    bool opregion_is_direct_mapped;
 
     /* Resources assignable to PCI devices via BARs. */
     struct resource {
@@ -192,12 +196,98 @@ void pci_setup(void)
                 {
                     igd_opregion_pgbase = mem_hole_alloc(IGD_OPREGION_PAGES);
                     /*
-                     * Write the the OpRegion offset to give the opregion
-                     * address to the device model. The device model will trap 
-                     * and map the OpRegion at the give address.
+                     * To be compatible with this interface for programming the
+                     * the PCI_INTEL_OPREGION register, the device model must
+                     * check if the guest reads the register before it writes
+                     * to the register. To indicate to the device model that
+                     * we have support for an extended VBT, we read the
+                     * PCI_INTEL_OPREGION register before writing to it. If the
+                     * device model supports an extended VBT, it will return
+                     * the number of pages needed for the OpRegion + VBT. If
+                     * not, it will return 0 which indicates that it does not
+                     * implement this interface for supporting an extended VBT.
+                     */
+                    igd_opregion_e820_pages = pci_readl(vga_devfn,
+                                                        PCI_INTEL_OPREGION);
+                    if ( !igd_opregion_e820_pages )
+                    {
+                        /*
+                         * This case provides backward compatibility with
+                         * device model versions that lack support for an
+                         * extended VBT. In this case the device model
+                         * expects us to allocate an extra page in case the
+                         * OpRegion is not aligned on a page boundary. Also,
+                         * in this case, the host OpRegion is direct mapped
+                         * into the guest.
+                         */
+                        igd_opregion_pgbase = mem_hole_alloc(1);
+                        igd_opregion_e820_pages = IGD_OPREGION_PAGES + 1;
+                        opregion_is_direct_mapped = true;
+                    }
+                    else
+                    {
+                        /* Allocate extra pages for an extended VBT */
+                        if ( igd_opregion_e820_pages > IGD_OPREGION_PAGES )
+                        {
+                            igd_opregion_pgbase =
+                                mem_hole_alloc(igd_opregion_e820_pages -
+                                               IGD_OPREGION_PAGES);
+                        }
+                        opregion_is_direct_mapped = false;
+                    }
+                    /*
+                     * This ensures the OpRegion + VBT does not take up more
+                     * than 1/32 of the reserved region. Also, we must reject
+                     * a value of 1 for igd_opregion_e820_pages.
+                     */
+                    if ( igd_opregion_e820_pages >
+                        RESERVED_MEMORY_DYNAMIC_PAGES >> 5 ||
+                        igd_opregion_e820_pages == 1 )
+                    {
+                        printf("too many or too few pages (%u) for OpRegion\n",
+                               igd_opregion_e820_pages);
+                        BUG();
+                    }
+                    /*
+                     * Write the the OpRegion offset to give the OpRegion
+                     * address to the device model. The device model will trap
+                     * and make the OpRegion accessible at the given address.
+                     * The device model is also expected to verify that the
+                     * OpRegion is compatible with the guest address space and
+                     * patch it if necessary to make it compatible.
                      */
                     pci_writel(vga_devfn, PCI_INTEL_OPREGION,
                                igd_opregion_pgbase << PAGE_SHIFT);
+
+                    /* Don't use our own copy if OpRegion is direct mapped */
+                    if ( opregion_is_direct_mapped )
+                        break;
+
+                    /*
+                     * Windows IGD drivers do not work properly when the
+                     * OpRegion is exposed by the device model's ioreq server,
+                     * so make a copy of the OpRegion and use that copy which
+                     * will be backed by RAM allocated to the guest.
+                     */
+                    opregion_vbt_scratch =
+                        scratch_alloc(igd_opregion_e820_pages <<
+                                      PAGE_SHIFT, 0);
+                    memcpy(opregion_vbt_scratch,
+                           (void *)(igd_opregion_pgbase << PAGE_SHIFT),
+                           igd_opregion_e820_pages << PAGE_SHIFT);
+
+                    igd_opregion = pci_readl(vga_devfn, PCI_INTEL_OPREGION);
+                    /*
+                     * The device model will unmap the OpRegion from the ioreq
+                     * server so we can use our own copy of the OpRegion.
+                     */
+                    pci_writel(vga_devfn, PCI_INTEL_OPREGION, igd_opregion);
+
+                    mem_hole_populate_ram(igd_opregion_pgbase,
+                                          igd_opregion_e820_pages);
+                    memcpy((void *)(igd_opregion_pgbase << PAGE_SHIFT),
+                           opregion_vbt_scratch,
+                           igd_opregion_e820_pages << PAGE_SHIFT);
                 }
             }
             break;
-- 
2.52.0


