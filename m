Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E58C5516F
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 00:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpxQU-0004jc-8n; Fri, 31 Jul 2026 20:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wpxQC-0004in-3T
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 20:17:48 -0400
Received: from sonic313-20.consmr.mail.gq1.yahoo.com ([98.137.65.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wpxQ9-0001Ya-UQ
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 20:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1785543462; bh=HIdr9C+lQ6Jo7WCNlxAtCo2E+oJ9NtzQ6wQnEjmdA0c=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=HJyFvByv/JaHrQ8YDyLQg80tGhOCl+wqOV2V/fp5Rp13BcrSKyY4seukQgb7gjr8GKUf2vOyfArtokuWAa9w3xBLT1o2klLyJ+ww0Hl2lk5cc1stBxr7t1XKYhBsiI4V2mV+Uax96Kyl4ilSS4gmWHZh258zNkPzd48vVypwoZr/WUSc+hHyUtpR1HskiqZJcQ2Zc70T4YVFGHuQGwG6i5xlIM9mXGvihloc/Jhf6ax+QYmLdyScDH1Q9dUPYH3h6ptGxvkQIl3dxJSmpHex0tOvrKrTDjnzlbzAwdF4WM3N+SUUMmrGR6HYZVbawRQ4/K86uCG1TBKaiIms8C3mjQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1785543462; bh=y3QEujPX9kE448RVtEETa7Ed9ZNYf7OrJSkBxZtAVNF=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=A1oMkOHopeoIOr1bQdvA/KSB64iT2kiPxX/YdvrXBQ2R3hkwxyoEVbCKZPxHf4JKlwt2BzCny+furZZlYEUzD5uECZY1BFs3nOlaMn+il98pu2TdryHXn99NrOJP+a328b9jd35Fmyl1RaPdGtq+pM+ELPr7gSyprQNKkZ9Wkf4ULgFz7gz9A/javO6KMkCPl2DiTjAOc+PJDeqlhfO2Zj4fcIBjZXXCBTcWl0a1DxxtG5Zl+1aSmD52hajQXi0DUH9XydMaAprtxTmRMvtiPtAsWPMCWCREeRfTM2bHgPQrgouaL5Wt94okqHI032dzQN7+tPQXwajJzFu5zuxeSg==
X-YMail-OSG: ne4VrocVM1lH1iDmo0cvieuzMkAyBDUp_2QC5WjVPFKC7wyOU4sJPUOTcIIAxxg
 338sot0z0Y1Fof4BGUYmZna9OAzYkZRPFVpoLX5AiPjhv_H6ecp_SsW2w9LRtjszqkt59Y801rtX
 1.0fFCoUqluAOLY76W80DXouX36JeJtCo51Lf6R3jBHk79e6J_ErzFxZcQGumxa85BPx8YJ1sYG5
 jsdf4UFrSFjey9BAWK2pslNofS0SOzeno_9cqVIoID86ME1ZTvsR8RFDFid.bSNnQmXnz_SaioG5
 9OZ1k0OhvXrQ7kzP0SsIC4s19xSNB8kBCIOOPWBl4By.nkEMDueI54AEgQD1I.m8toj1Rl_8cVFV
 AOALx_1FaWC.ieOBLhVrogDqChUOMwXLPzVh.bs2anRs34RIXNQ6mPSLW5csIit5ghl.hisUIjU2
 F4VTL.QKKJ8yg4aw1FAM1doE8ir52C9BpyXDZbNmqSC14cu26j5OUubcb2ja8w7WBK9GT9UB9tgL
 QFUrJ2YQp2oifXsum90lODu30FXTy0VvUg.pm64_E2RN1rIWq4TzHcNDF.QlNB_IdmP8t247phAK
 SdRbfwjA9SYYnZqzoKnQRuJVyp3ersT1WvLod8jH6D5OuWLNh1bwLiDLBK69yS3uWaocO9DGeNGc
 ELXH16cz4lsH.PCR.VCMHyR2vJklTaQ5c0u1MFStg2rd5N.EYDU4V2vi1zyQ_NBb1BpwqxLmx448
 B7M5e1RvhZSB2GflTlRsd6lc3vkX6vWTvXBXRGzHi5JKdbzrTDflcMEma_PEekVbHDntiURYg2Dv
 pAK1YbWGMJpbiEfe.7SiGNlO_wyNtFwG.McndWCDRvFcgp2kIHoAaqEiowLTL3ExQ3IMti0hD4HB
 p896PSUFQDHgVDbzp5DDppVpEkm04pYKMxCpSA_tPYFayUO5TjX9txo0OQs4CJZypSFgwEAS5faN
 g2exS44QG7NZLAo7TFklWpjcpr86UY6cqYN.mw1fRkDyUMSjtOjR1J2Qplraxaf._kzL7v1RBC8Y
 ewsZ0QywF_beCnK7RmYoGMeABYmVcYj_3Li6oExpiMbG3N3at9Fn0BnFxefy4rawWrUfD2bGPK.I
 scr3zbtEYLm6gGJHNIccKPltdC4.qJNbRVIAypA0SZVYmKjUVE.tQeDTfHqoPQH6OSB1Upb9lLYL
 5AQwNWAOg7.n8YXsmo3dhIuppfT5UsQMTt5i3qwYowebrmZtkDI19lLQrHM89N54125QxPXlGq.Z
 lM_5Bu3K7iV47EUTp2JH1B0tixmq.RQo_18lxQ4I957jGa3uZCXHrTkHMfj7ayLsTf838DrW04Eu
 Zb72det6Zc8zxuY2rr9Fm69wTnkxfsBQtskbhiYdZHyLDVvHj_6o8dIp8.9VgJrizVzN.IYVTLvN
 g4z0PuLREHE0mTQlqppajrZON2Bv64eUAAJiQm7CMnFKNPQu07GcHkgnWGbuTaEnkyLO5AkrmJ9q
 Nzo7lhRKrvyLDLTX9KgNsTyq1wCo0ZAhXHmAK58jZK79fJif.hbOtOd66YknW5QsOEIiU7wrpEgX
 6y7cF4uGOV.jtpzDJYiANr2016YbkO9jmlEKKDL23Fz4wXVZjZpz6vey2AJAxMO3vhqO65bQqz13
 w9Lg6KuBTRovKMEva_di1epZIczKriME3M9viLOCw0NMu57RsGXmfZpT7OPFHuPtYywScFxVjkAB
 FQIBAwjnO5U2W.rKUrVxoTCd33ATdH.3gIFcw_ZpXXG_gS8DbowKZwEba75TGLe5M5vrLiN2bfAH
 cxMKRE0AcG08MN1Z7T6DAqimA81PIDqrdspqP0lIbLP8ha1HeyxgDf26mZ5jQiNnntMCntRu0TkH
 drqZw0yHNPGOP4uNGh8AIaoWypfA0tCe.ejSeK8GleGy7I5WEqX29OPsWRG2g3YHO9Pj40S4KHlN
 vZZAbkaT0D_kcfIHF2cS60lK2kZ4UUhr5efiKBw3TTSIA8or8fn7.OyI7JwmmSb8llc1SuSfhtJA
 kV5Glli_h69vrhDq2uaFzkZA.UNA6YP8o6781GfUStYSgH0XK.HgKV3AAMH_ntEMDW3H8sYXB2kW
 YcWj9LHGlrKd0UFgoY3ktHkXl0xOaHvpEvHmS_MlaeaHb1INzoqBQzI.obXpwnl0CqanjI86eb_k
 2fM44zyewmB2U5BZUg617YFFJs70yWOc_jr_RFBPIH0IpPwQyeIhequLxFS7oa4qfoiGxmesdIrE
 61Wx.Q74lD5vkJPJJwS1Rj4cC7B_QQkALde94XHiFmpK.pA--
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 32995032-351f-4f3d-b1f3-2db34182d857
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.gq1.yahoo.com with HTTP; Sat, 1 Aug 2026 00:17:42 +0000
Received: by hermes--production-bf1-54b5569bdc-h5zdx (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 655a093bcead2c5289eeab02aa189b76; 
 Sat, 01 Aug 2026 00:17:38 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Jan Beulich <jbeulich@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v4 0/6] xen/igd: fixes for Intel IGD passthrough
Date: Fri, 31 Jul 2026 20:17:24 -0400
Message-ID: <20260801001737.16509-1-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260801001737.16509-1-brchuckz.ref@aol.com>
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

Please note that Patch 5 of this series also requires a patch
to hvmloader of Xen for the new support to take effect that
is available here:

https://lore.kernel.org/qemu-devel/20260801000354.16446-1-brchuckz@aol.com/

This patch series aims to fix long-standing bugs that need
to be backported to all currently supported stable versions
in order to support passthrough of both older and modern
Intel IGD devices to Xen HVM guests. Note that previous
versions of this patch series only fixed the bugs
affecting older devices and the patches needed for newer
devices were not included, so this is the first version
of this patch series that is suitable for use and testing
with newer devices that, for example, are designed by the
manufacturer to only work with UEFI firmware.

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

With the fourth through sixth patches applied, it is possible to
use/test with newer devices since, with those patches applied, the
bugs that prevent guest creation from succeeding with many newer
devices are fixed. All six patches have been tested on both the
older Intel NUC7i5BNK mentioned above and a newer 14th Gen i5-14500
Raptor Lake processor in an ASRock board that, as far as I can
tell, is not compatible with legacy VGA BIOS and Seabios, which
means that, although one can successfully create a guest with
Seabios for the guest with the newer device, there will be no
graphics output from the guest until the guest OS loads the
graphics drivers when using the newer device with Seabios.

The sixth patch is provided for use with newer devices that require
an EFI graphics output protocol (GOP) driver for graphics output
during early boot. For more details, read the commit message and
the accompanying notes in Patch 6.

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

Changes in v2:
  - close open files before setting errp
  - improvements to readability and style
  - small corrections to the commit messages
  - add stable to Cc list

Changes in v3:
  - whitespace fix in first patch
  - fix Cc address for qemu-stable

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

Chuck Zmudzinski (6):
  xen/igd: get PCH info from host sysfs
  xen/igd: don't register rom bar twice
  xen/igd: fixup device id before registering rom
  xen/igd: enable guest creation when ROM read fails
  xen/igd: implement support for extended VBT
  xen/igd: use custom option ROM if provided

 hw/xen/xen_pt.c          |  13 +-
 hw/xen/xen_pt_graphics.c | 280 +++++++++++++++++++++++++++++++++++++--
 hw/xen/xen_pt_load_rom.c |  64 ++++++---
 include/hw/xen/xen_igd.h |   3 +-
 4 files changed, 325 insertions(+), 35 deletions(-)

-- 
2.52.0


