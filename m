Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E57C88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4vdB-0007sa-3m; Fri, 11 Sep 2026 03:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1x4vd9-0007rm-BQ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 03:25:03 -0400
Received: from sonic302-20.consmr.mail.gq1.yahoo.com ([98.137.68.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1x4vd7-0007yV-2E
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 03:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1789111497; bh=en0biDtErIDPX8Wy4OEtT0eKAnvLP1ybw8oQxmME/08=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=laak+G0vWbOik+u36BuweJGPG0wcd4JF4bJPee99r9l/nDc5lEPnNL8m5qSuh6+lQ5v7p3xubs+Ncz+weeFAmkdVHg5rLHDp9M1Qg8Zb89NXr2xYbcVQs1ToDeOiuvXKrN6ZByU7Mw/NE8ZL4gHjSkrfGtAjB6EkBNuK2Cuq5wU8ToXCLR6Sulg/k7HZmBikYEyLA6Vwmnf4Nd/4H5tFLuJyzKnlMPjwhKDmUZrBceX/+CivCrJHbFDFJN4MgOwAlFc1d/lXCblFmKY73fe6PW+vFUIvYIl7pBU6ASk9Ao/E85EmD26/HYAbuRpaArKMYl3JXNEEOrzL8dNfE4rupg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1789111497; bh=m/ERkDdEk+T4YnfpCna6g0mZv+xiWufY6rwsf2afODF=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=IgEnuBz0CV9X3w9UNvXidtV0ZwXWZ26E4Q/UMDTPLfzlC4qJwK15uFxk50ln/WcLstkXZ7KGACkHUQlEJJCkhoEcDSa9e+gwyJczTOvkB9TntgTyIaTcwfaf83zmBOFANOc8fBLjPiC/1HTzV57DEt+8opigivEptEmGwKNZm1x7rCaOi4LBbDPFqGyYdC5itZbVpm2rMUC6e05HyX9IUcQYJM9GeB6D3D5e/RprRlE5l+7oZ5+mim+V1KtAupmz0HV8eFp/i9CCSMYeKmLo3dAo6udgWIRd/bGzwGnaby36mMf6SM2iAmxJZj5JM38dXj9OIHNVLXalutCRmVDchw==
X-YMail-OSG: 0EFgvdUVM1nTA_43UU_dkhx.RMQF9.A4zr8vZPXj1UprNjjQRWLMTFDc8Qfkbzi
 jj7oxWgOFXKqbrX6rfdz_YcuG9KNRtg8Wo7NSUkaPE.MTcR4H8JMnYc_il85gVA_0I4HZWvObdg6
 kz6t4TgtE69jkQsh1ITX1eI1kZ8qB.5WP9Aa5XeHHeXc7WHMBacjuXqhQbMeEt1R0xPnQP0f3LXx
 .ULAn.918HWdNr3eajcx0p7xgn1FoR.HUbiA3mN8Hz8lZODi_OKPO9HOOCmGGKmyZSokF2LHQmGw
 I82Q4z.4vTGVR0ZVHLlMQs2NVoVBvsTkfdZD1Mh2pLBh22Q7Yb_ZZTkuerGlV4bexWdrggUVVzBb
 MEOxCplRixUEXAwO96UIv7HDuoYaOPnPPs6faTTralBDWQ0GDwa0Y7yCNITyo.S4vuDr26ZHipW4
 GFW2lS8Jzf7wPs1mLGV._UWZGvWGOhHfmtyI.6xerzuP.dXj1p5_Ra_sVNANBdSirJIwWBL7M0Zw
 uFjoCWuMzE7rF.Z8Cmwf3.VehGn302OQAfbxgsReAL4zgXCI6CUnE55Vwsh7tn5yu2Rzt2myjW.k
 k8u83hyt_1x52jwaipYtmpNS5AXxx9eAFP8g4SxUMnZkxrscrgwYjvxFOfRLuOUheuwtqxqPLgbc
 Ny.WBiFLfCEDGPjWCGM3AkG0IF8WyEA8C1PTRlcACwDItC3mjwMZwExVampamYzITnI7Jd2hrrGN
 tqgHbwIfivGtpuLh7dASJU8thNdvVY7cODg4p0Wc.6sz2UdwhOSAguxlmW91asoUx1LP8dEMDLnC
 KZy9Iz9GEs7UnPVMSypKHSjLof7B7QAKGMlprPT5t_TPL7rVDltifQNeCElRSCVyTP.Vz2caZjMK
 3lcKt6FrOarImMjdecde51UclYbLxfDutRjvk2b_.0suEONhdF6zdG3oHpmJflzQnOWuHWi8_tN1
 sevN2axosa3erbYz1F..UnQOLH0OYD2DmRA0mPGS1O_K6OMfuEVncxmEzynfiazCBz1etNwU7E_Y
 NiFaLQsVQARMsZY6.mxS2bsN6Z3faU2XdjHRy_nlpydUEh00V2IJ6V8Fx2r1Gi8hwIWB1HzU6gg3
 PrpOZidJLEv0HfycnFMwU.2TpF9FN7Bd00aFyqktD1F0JOgm5Pu3r08QmkegQTc6VV2eTOccfDgM
 38TJeBFfCTfqAAmRKMh7UKHhnKtXCNsjvu8zJyF3WnwV8KOFmLR9TGwBd1T8i1V1DohC8oK4veaO
 g4nihugWtY6Lt7F.EmczJSMr8_lxa3BVvddMVmf22cJr7mfcrJqcMKiGhFey83vIOsYoGtveaBva
 _1bdaJk5KBZTPX590bTjaLCGVLrY4XKLYu9G4wi4C.OzzeKtQyNptUedDzfoLQCdIxLz2.Vq4AhR
 mCQbgOFP.L9W_bAbRc1P5FGSFucCwFsKA27zovnLS5o.YKeBGY_yYEXWNteJtAoAxW3GfKBiagwT
 iTuoLk7WvJejLOOeoJClKXWbtKUvtJsZ4imBSjJxYXKVW8JJ8B4NSbpEpqfQoAxcZmgp1hzfYcP4
 inBelBoyeuReNp6iKXlXuOO19iVsIc9tGREQybAa0xXkSQ4YkFlsQKRpeVVm33nn.aRiRjwRickW
 d_OGwd1pXRDjErSfTiJbGH78u.547GL3C2Sqqve8P4TabaZF5vKPNVafZ3bPkeTm6Ttw9DLuYiwO
 PlWLPt.8J_PQsYWv1oDt5f0dDKaePBdVUW_GGj84BjXm5b5lDFKcnM4He5w7ABAr7vHr8CqrdC7v
 reNbIQqAZ5aLi.tgY_MS7pF1y2c3EmTDCabGsYik7yXka7mOZHh1gjzUtpvSFv5azsuXx8x0Sx1P
 4d7FHevzwWezqjdbGtXg_FRl5nLmKXhpJeT7f.jdGUAl4f_yRQeDZM3jmLABURfmCSFA5UWOZE1v
 Z8lUjeV2z1bKCkw5GdI10C7ZIftqrGaJg35db2zdMhInb6ACvpaBwze2bSzftWIlKnjC2Eiwzs17
 MIifqbx0vstvzbarTBsU2XWw.Q1dRe9yHYrn7SOuP2NTVnQnNAcECmMAOz.xlqAX6_G5Xi9XafVh
 luPD1aZC7uDyjYZVRnDaSui.R7srO_YgdCYdqfj0pbcgItB7kjEsLa0OTdZMtEwnsoI4ggnA3EO_
 L7oFk.cuoQh__56gnu8sO3KOEsXTJx.Unk2MUnrFN12fxLDlvcdWUSFf3c1Ka_IDiyvd6UxzSQji
 3wVc3biZg9Es1j33FN8C9cltc
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: d05bd7e6-d197-4edf-9dd5-7cb81c3707fe
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.gq1.yahoo.com with HTTP; Fri, 11 Sep 2026 07:24:57 +0000
Received: by hermes--production-bf1-54b5569bdc-fv65m (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID c4451c0cd4386c4b1051306e68eb9ea1; 
 Fri, 11 Sep 2026 07:24:55 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v6 0/7] xen/igd: fixes for Intel IGD passthrough
Date: Fri, 11 Sep 2026 03:24:46 -0400
Message-ID: <20260911072453.46256-1-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260911072453.46256-1-brchuckz.ref@aol.com>
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

Please note that Patch 6 of this series requires a patch to hvmloader of
Xen for the new support to take effect. Also please note that earlier
versions of the patch to hvmloader are not compatible with this version
of Patch 6. Please look for v3 of the "tools/hvmloader: implement Intel IGD
extended VBT support" patch that will be posted shortly to both the xen-devel
and qemu-devel mailing lists.

This patch series aims to fix long-standing bugs that need to be backported
to all currently supported stable versions in order to support passthrough of
both older and modern Intel IGD devices to Xen HVM guests. This patch series
also provides a patch (Patch 6) that adds support for newer devices that have
an extended video bios table (VBT).

These patches fix several bugs that cause problems
ranging from a dark screen in the guest until the guest OS
graphics are loaded to an assert failure or other failures
in newer devices that in many cases prevent guest creation
from succeeding or cause other problems such as code 43
errors in Windows guests.

To test the the third patch and verify it fixes the bug of
no video output from Seabios, it is necessary to test
with older Intel IGD devices that have support for legacy
VGA bios (Seabios) because the newer devices, as far as I
can tell, are not compatible with legacy VGA BIOS.

The first three patches have been tested using Xen 4.21 and
Seabios 1.17 on Fedora 44 using an older Intel NUC7i5BNK with
an i5-7260U processor and have been verified to fix the bugs
described in the individual patches. This device is compatible
with legacy VGA BIOS and Seabios.

With the fourth through seventh patches applied, it is possible to
use/test with newer devices since, with those patches applied, the
bugs that prevent guest creation from succeeding with many newer
devices are fixed. All seven patches have been tested on both the
older Intel NUC7i5BNK mentioned above and a newer 14th Gen i5-14500
Raptor Lake processor in an ASRock board that, as far as I can
tell, is not compatible with legacy VGA BIOS and Seabios, which
means that, although one can successfully create a guest with
Seabios for the guest with the newer device, there will be no
graphics output from the guest until the guest OS loads the
graphics drivers when using the newer device with Seabios.

The seventh patch is provided for use with newer devices that require
an EFI graphics output protocol (GOP) driver for graphics output
during early boot. For more details, read the commit message and
the accompanying notes in Patch 7.

Two hints to help configuring Xen HVM guests with Intel IGD passthrough:

  - Increase the value of mmio_hole from its default value of
    256 to at least 512 using the mmio_hole setting in the guest
    config. The value of 512 works well when the stolen memory is
    256 MiB. If more stolen memory is used, the mmio_hole may need
    to be increased even more.

  - If there are rdm conflicts, lower the rdm_mem_boundary setting
    in the guest config from its default value of 2048 to a
    value at which all rdm conflicts are resolved. I have discovered
    that lowering it in 128 MiB increments works well. With the older
    device I needed to lower it to 1792 and with the newer one I
    needed to lower it to 1664. See the description of the rdm_mem_boundary
    setting in the xl.cfg(5) man page for more details.

Changes in v6:
  - Added Patch 5 to make better use of the xen_igd.h header file
  - Patch 6 (Patch 5 in v5) has been totally re-worked after considering
    comments made on v2 of the companion patch to hvmloader. See Patch 6
    for more details.
  - With the addition of Patch 5, Patch 6 in v5 is bumped to Patch 7 in v6

Changes in v5:
  - fix style problems reported by checkpatch (see each patch for details)
  - update the link to the companion patch for Xen hvmloader

Changes in v4:
  - add three patches to provide support for newer Intel IGD devices
  - edit the commit messages for better consistency of style
  - use 12 digits instead of 7 when referencing commit hashes
  - re-write xen_pt_get_host_pch_info() in patch 1 using the
    functions declared in xen-host-pci-device.h
  - handle errors in patch 1 that in previous versions of that
    patch were not handled
  - add a Fixes tag to the third patch
  - add two hints in the cover letter to help those who are trying
    to configure Xen HVM guests with an Intel IGD passed through

Changes in v3:
  - whitespace fix in first patch
  - fix Cc address for qemu-stable

Changes in v2:
  - close open files before setting errp
  - improvements to readability and style
  - small corrections to the commit messages
  - add stable to Cc list

Chuck Zmudzinski (7):
  xen/igd: get PCH info from host sysfs
  xen/igd: don't register rom bar twice
  xen/igd: fixup device id before registering rom
  xen/igd: enable guest creation when ROM read fails
  xen/igd: use igd header for IGD related definitions
  xen/igd: implement support for extended VBT
  xen/igd: use custom option ROM if provided

 hw/xen/xen_pt.c             |  13 +-
 hw/xen/xen_pt.h             |   9 -
 hw/xen/xen_pt_config_init.c |   8 +-
 hw/xen/xen_pt_graphics.c    | 323 ++++++++++++++++++++++++++++++++++--
 hw/xen/xen_pt_load_rom.c    |  64 ++++---
 include/hw/xen/xen_igd.h    |  19 ++-
 6 files changed, 380 insertions(+), 56 deletions(-)

-- 
2.52.0


