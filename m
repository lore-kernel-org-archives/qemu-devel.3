Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F482C55174
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 01:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrmY7-0001vC-GX; Wed, 05 Aug 2026 21:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wrmXy-0001rh-Nn
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 21:05:24 -0400
Received: from sonic309-22.consmr.mail.ne1.yahoo.com ([66.163.184.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wrmXw-0006M6-GG
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 21:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1785978315; bh=fw4HdPaoace2t+OlFHdLFzcl2NiVn/+uZd1DSdtjjQY=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=lpBzXO54AeZhZwpm97O/lgjN4Gr3Th1LXKX3gA4R48w7vBd+g18FjKHkRd0fdDvcLAWQQt1M4AjVWvsyP6BdVPSnjhG0ZpTrKO79NEHR+40umq4YOxBPM2hPl16n/VaN/UBg7wpZHRMnr9+pg/y7lzh5UshtMT8kQ54jUxGMdyAvj8eiQA+I9lBurvIJ9cDH5xTcxmSulY7BztygsSkv6Dn1Z+phMQzopZdsboh5hh3aFmF1ZvWerS7K27hdlWKxOY2o5ZFqkM/lIojuz/8A+bvc37k2rv5XlrRDfHcavlwVAkCkxSI4UPpht2LPXbXcgl3MWl0itOli9MbKoU3w/A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1785978315; bh=OjKQGJpeXAI+iDr9u7zv+KwtGcuFJ0aLnWAIzROdy0U=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=N+9NBUvkHu3abSCTBrp8tHKMA4TKrNgF66gry3Gtg3Ib3RnFrqcPN7qL087GNup6l3y9v1daeeIvXuXdSD6Gt43quXGFs5qu3xohbdMxUQRL5fdZb7OcZBiu5DSiWoqo+Pxb5kXmQAES+t4g+3UNaHW+r8O5TmjKo8ffbCvIcqadVqQ/6RqDpJiB0AYKwZXT6M3EBvqMCD4kRwNaY3dB3CDlsyb9/OdK7Tca/d1Umz2fL6NOBndV3po0HLZ5le0mqVocLu0kjNWoGoaYA+U5NH2vxg2bAcGdnvQAzAjGEUu0T+JUi5KuuEEhM5DNMiljQZID17ZFDVywEXqtwXptVA==
X-YMail-OSG: xqNcuykVM1l1WTx5uLZ.F2HoxO_Ro_7aK7ZBCq6T3BHtDa0hl3bajy9x40Hd3V7
 3R27P7Ar41eEyBh.rxjGEJ4s0fPPIRRyYJmCaScZEnzpzl4mUq4UgYAatWujz1Q.oTbxzfV8Ilpk
 ZJMcWhMCP92LEYAmkoN8xESgFnSUQoL2Q1PVcqQ8bnE3TagICRy0L5velY4wHl4uiTpaZdniFcZt
 mniaRIxHNl7Slw8MIhQirWxy3y.19Oik2CcxMKiJGCJz1H_VLP.rKS1Or_nBvm3YlgZeE6WiGw.G
 LpuMw9GKgWHC9lY0v_nBpjC.1U9ZDSUY1Bos4LMjZWcblCXLH3kRAtGJOoRMV6Qg0UX3hAtlUBMr
 u3uMZfJaBDsypnj1qrQ9iYB5Kne5lWaRktG_c4dE3Kbdlsg4XS2ZJqNxiSw9ZpfcIcQqu6UEyZDj
 P2XGpWhsd3Q7H_TCL_VMYCA3pRthNaA9gOzOwQNjiU0EsCRB8eJzXtEyfA7wuJHzXf5XkPxeLLdD
 HhCyiKwOEJ3XdiRzlc8z6zBfl7olYAhs3QYTSGq5MDZnVrbVpkb7UHGlW_C23HFRLMmUDQ.GkQaU
 pI2_573A22uZvSuDaLmnMt6wyf23bujF722dBVa4a0w.6jE4O6UcQoyaJVIOfV7lY43GcypHUa8K
 25Z4KXbrUkpBgBIY.yUik08IvCW.PyCxBSQXaafOsQcE7Lw7mFEX8IhYz0qDp7j8aeVIsuu7h55_
 72BbVnheQ6LEZhs66CCH.lmeFWYbqgWzZaP42d7xkSlfmiLl4n.hsG9_yuX7PnEyg1H3hVgWdZKl
 mQTgh9JQXGScN4Uw_LBNix6ooT5i.lB2.FSIaf7HOprkRZ4xHGU589euI9i9Y8OviSkgqPTWJUCY
 eaR40UMJ_aqLXsjwbRlxmc.SzBVYAAW35gPAEV_xJmAOxiarYmLoWWohCbvv2hMxY4Gl88MgiSxJ
 0oxtsIlB1vaa1RVzI0SIVsgVhRviPqtYNZze4TSBirO2fPFpauitShrDYj6OPS3iIccyE.Ozbd.c
 V5dbLzCPCLsoOk6yu1W7fNvwtzqLSs5rFOnWjksHXMSm8AttaQZMVJoaMI0wXTmRmuF3bQEcLvSa
 hM8Kob_B5V8CkIwkzf1IK5n5PqTrrxzcuvz2tan0P8CSgtjZXGFm1gqOwg84GUqKW5n2THmaVfMz
 QYc1AurpEtVOcKdBKO.9X24mueXwylG5qSxRhd26vcuLckLhm0TAmZhyDM6CaQI_rA8aGY3.hiUr
 VNxBDAkE.kQ2zlUJp0m_EoKyzOcs3.xaxiT4BuQODnlx03ouSC2TGV5_MKnG0Nh0CGek670kgu7l
 QU2UNsm1MGQBM0bYD4nzoGOP2iN3_dqK5JIxrTz2aBi55trwYFwrKLA0jtALzoVon4_AIYldX9dr
 DiWI3N3cQwbybAyGC5rxTE39fNKoIPjCj93eyTd_8bBP8QnCh8TXN7J179zPHgmTG51hOVYbODZJ
 b7pqr.h9tjChP5sMzY0UhXb1ouZmYHlNkSQQIJxHX73WJsxS9T6nrfT71J0la.yzy_dYMGJZi761
 FZAekQc1S30uZIrR7bGPGa8pVRlPjaigduxBaTQ3lK9YOSM3g5glF5okEqgs.dFJeOduVH6cZ3bT
 xwWbruwzTiRHeICwVftaTXvha.GAIdEYzz_QZ3xLq8mkWEzAT1o9Djn7xYmCaBTO3qOUbv4oT2gN
 zmQm2OmG9ahAn7CThj6kfihDcxDBthLefJdB92T6db9JmON_deVN_viafdb8uXacN9Gw.nMJpquh
 VJX5DYGoKTA.lpuk631VGItzp6oRQSBWeMTxsPKtnC4FIexDlIGm4cepPxgRH8NUXfp7fYLXFjml
 _C8mbvq9Vduob3ri0XDsGa8jBJHGBAlma9iDOfLcpv1S7PD0NsrqKNoAsbw4DGqDJ2Us8zCJkjw5
 seIj4M.K8LWgQGOCMlEi1jJjHcY0o44PjVCPPcfiuxu13ag_zAe2b.ymWZFDGfPTMkc0aQhldouk
 BThRyoTDGsAngNqBRQcMOL4crTDHCqr2Ye2tHrIeM01Tbx3Rf7mGNRAfNxs5PgBgjTKwpfOKxTfC
 DyKMBf1auuSyXUDK5U08.uviVwwgkzXaE_P6KQTeNcHOR7gcLY.BdWY.N9jw5AmNRfG28IlOUUe5
 XD2_r12rpi9J3K.XNBSgzyjtOIp.XBP0vfPrnUbFGHaFVP3SICP9XjTSpcisPSeN4cIYz2jWZxDb
 gZJqvnp7R62iWwKbBsng1Exsdlmr9aNvU6SdPEw--
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: ee9741dd-5910-4e33-8451-29e3ab64a197
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 6 Aug 2026 01:05:15 +0000
Received: by hermes--production-bf1-54b5569bdc-xjdx5 (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 734f0c8329adecc00a98ec91cc943adb; 
 Thu, 06 Aug 2026 01:05:08 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Jan Beulich <jbeulich@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v5 0/6] xen/igd: fixes for Intel IGD passthrough
Date: Wed,  5 Aug 2026 21:04:50 -0400
Message-ID: <20260806010506.492490-1-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260806010506.492490-1-brchuckz.ref@aol.com>
Received-SPF: pass client-ip=66.163.184.148; envelope-from=brchuckz@aol.com;
 helo=sonic309-22.consmr.mail.ne1.yahoo.com
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

https://lore.kernel.org/qemu-devel/20260802050824.10554-1-brchuckz@aol.com/

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

Changes in v5:
  - fix style problems reported by checkpatch (see each patch for details)
  - update the link to the companion patch for Xen hvmloader

Chuck Zmudzinski (6):
  xen/igd: get PCH info from host sysfs
  xen/igd: don't register rom bar twice
  xen/igd: fixup device id before registering rom
  xen/igd: enable guest creation when ROM read fails
  xen/igd: implement support for extended VBT
  xen/igd: use custom option ROM if provided

 hw/xen/xen_pt.c          |  13 +-
 hw/xen/xen_pt_graphics.c | 282 +++++++++++++++++++++++++++++++++++++--
 hw/xen/xen_pt_load_rom.c |  64 ++++++---
 include/hw/xen/xen_igd.h |   3 +-
 4 files changed, 327 insertions(+), 35 deletions(-)

-- 
2.52.0


