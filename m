Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D52BC5516F
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 00:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpxQY-0004lc-SK; Fri, 31 Jul 2026 20:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wpxQG-0004jE-SH
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 20:18:02 -0400
Received: from sonic315-55.consmr.mail.gq1.yahoo.com ([98.137.65.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wpxQF-0001Zc-9a
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 20:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1785543468; bh=e+hFrPKjm/qktFvrEGDQAvmP2RXLyh9VDR7iL4Z1uvE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=YTkrELbZWKdR6MlF3on4FPg7soY/Dc92529AE8IAES+R9eHjMSTIQtUmJV53clCHzIxdW1PBg8jCqy/IkNylsIIMjLLgzJhXKYTzoaafStyZThLBKnOc8WILBxLgWjCp/Yqx0e9Fv4xFldUN+8xYuFOfh2zU1bVivDxgPZ5JkLm9Zv/pWJiw9TbHdqja/TFS0frXbaJbCmrYiJjfaw/R5PW+0Dr9aqLa38J3PvIslk6IFXq+f+nn8jR4MuSMj7sk3joDSqxLF9bUfgJjVV1qzCtugdHqfjN4PwxmLwBrEzhB7Wu4sJPL9HaQp+n2gCV29kv/W3J1uBsL8QGI4tSTfg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1785543468; bh=ND82rFy7/zOVwXsz/RHMs6SkJ7Wu+/qRU6xlDEOWfxF=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=snGXE5kMidyeL6q2BmQQrjYREoQyr3mCUngVDBAvmhtBzHxCg8kFonZhm82Ct97clMwTGmSdSCk+gEAGVsqcPMrctnZnyxtWgQgTKrrFod3gS5vorxHpY2xmQeldjcD2/CqycytY7jYZwnOCM8M7Rmlw3/W88L21/x9WfCVoT27gcHrDAWosXTZ9Ky1TILj3dAjt2/3u8bObwGIOcMfo4OhJUs5p3OrqLR4igQ+c80V7RbM89wZ9wa5mvGCpLLuverQbqMt+N8OYfCh91Jw5DhFnwWirfRNF1WUpVRwKH1/seKW2/2Fzl0A4HhvTVND08QGsWpa421eDO/eNCQYzSg==
X-YMail-OSG: DO9eCQQVM1kM2YtzD1yVaZ6ZUBpRnIAxSCKVSwdHs7_TF8pvf6vHY8nncsOK5c9
 nm7l2gzBy71iJPUHoF1UJEQXM2gAyrmK3.fVq0m19RSPW6i7ghwnotPYWE9oUMdTfqWA5w8sqLwu
 cS0MZD4zMSREe6ZnYmzXk3Z.wDo5bO0UIDHFD49VtrfHEh9m6a2d8DmVKOS2cSDXYC3LZnQa7B60
 OinNH4CJ68t8C9GpxeEMKsIOpdzlAl1wfVQa6elCfo9asebZobxeAtMHu9mjKhJ0g87jEago.KJd
 GliNj2g9WG02NHVie51Den6jKehkK616TYLPxc1qn7GPFw3ekwY81.mP61.UcXGmMT0S2bxOD0q1
 oGYt393F4hvoAlLWT1c4_h1PVxKq97radMKhEP7Eq8er.t3smg118OFQ2dhJGcqf3DyT780oMPsX
 3zYYqI2st3NoCgdBSvzN2BE7Kn9HRpDhdDewAFazL3Bpe3OfiQWIWsXiJINzRsd56KMyEfIUvS29
 cX08sTJrcliVQtPWBaoZAWzrqLl6MD5SqoiaQ6J4CmwRmWfJcNe8VTqiHsbcgfFjKTK5x7oZQOEw
 iULHNJ2UnfxfMVKrQoYl1OIcPKyQK8x11c4zml3WJ4SVHA2KuFCqfjo3ih9fbz8mNO8HJkVQugQ2
 iGztX0lwG_GuBAzZ99awjIIhcRLLddIgVnqec_sv3C2P.JN.kPS6cBl5nQK11q4t9XeWyLrTXVBp
 seO5KajhlyRZjSRzOQO3.Mz_xwbV0KOS2P6eSx1RAtcNSgD7.le8BLSgfGFb3dkP1ncMejQN7_Wi
 G0p_hBfUFLX0.tbduCD6ydK_Bs0bqyth0PLVEL1zPkPoHQzjekPWMHbQr3b0na47Yi70rf8kusla
 FpG9yJ619HS5uClZeIfL1hILR25jfeGDUBbB4F8.PmQmDIF5FqzD.vqDgS6zbnhipPbkAlO_aZPt
 g0YLm1vZDakTnMiADxiqhoq_edlWU19pHzidiHs6HhDKJNIxFefzXrRnPz_8TXvs.wOVSaJILEtV
 fwvZCPlbSLzr8AZKTenQu5eEy1BHjAT205yA0AD_DAbneHqOGUKPuzLHRsNJZkXI_LdC7.StCO7a
 G2XCP1JDcAH9YaYEsavjx_wFpwPVx.88DY9HE4u8kPN48l95p_yVRMRI_lwWZvjvsYgbuUD.kYY9
 vn4F6DNvmEfNKPVqBl0w..usKwaI6tsJgUylmkrGaohSyb23svwN3CtW8elWWsWRGjn_SErqNYWJ
 FmDoWts7FKkoLi7tapxrlY9ULZSftmFlIUQe_dQIi5C79QXHlMixwJRmTsae8_u0txkL5Au31Etj
 w3OBLOqW5KTTEPMhrNgNysVuS6t1wmcNCJpgxhjAYoehEBGWeHamfG96xYNlIfPF6KGO9TntH8oT
 _F3ErcVKpJpvKsAUn8rPNtpYaH25xQwbBXR8fF6tngzdt4woa43H2QzLww_Uejq_IdTYelviiQjE
 YAxn8FHweY53AiVuSAplB1Y3hF_c.hYntBQdeDkxnSt3ZLkdPa7jRz1e457jl4.Cqai4lIBwygfS
 LFV_vOa4ojrJCTt.gLdiCjNyetJgIGIYsGyAY0FtCUOiZYm6KuPrGA2hYx0_8fXCMczZc_aER.jv
 MxLRpzXq_ZSGZGcYa70fA8gyiIPFCdk2PBAprUAWWWjdBNSy8pMBHTjjQc7RjhKdZ.wBJQ7ZQrNy
 6wr9lEG331x_kBpL53uFTLpyZQeHXSuPDw6T6zfa5QOKNDlCLWlH7KQwwa3MPWTPJZdTnYc.eVnm
 pP21mfpuMizuG7gn9bSpkPGT7paL_bvbR9wpnq4ZUrMUOLcqelltsLL47gIkR9aklUNRvQP9QHR8
 3Inud10EKm1qS5AewB1nL7KgR0LPKtnQPV6Wp7lIkUlFrvzDwn4850jA_E3Rp5BMB1aM5ahXlURX
 yoZv1hv1UqKFhqV18f2KLSzP1uFWC1UfzycfhPkNrk6_uq27bBbcE4zrMKrXqeCICMqGFkVdZzOv
 RZiE_Wjwmux3REQgiXSqzwubTOixMLdlhrJgutvA_utRTRed6VZvTY08df0PauK4V4IiSLSmrf7.
 peCrAcEVTPs0TI9pwUfr4rBx0kiD2PVeEf_La2_810yj3yjJ7JV1k1Zr.UoD629GBTWokb7IIIZg
 LJ_qLeyMWKHtUdwM.kIzlX02aKzPpeJBPcBWML9iyo6oLAMBDCsmWGNL2_UUJhRQdHpB.j6fvYpq
 0050.U8NXXacnZfDFs3sVPNZ0QnTYgCPPQVLT7kl9xAMe99VpMQ--
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: e5ab0868-b2cf-4cbb-9ca7-34935d8b786d
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Sat, 1 Aug 2026 00:17:48 +0000
Received: by hermes--production-bf1-54b5569bdc-h5zdx (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 655a093bcead2c5289eeab02aa189b76; 
 Sat, 01 Aug 2026 00:17:42 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Jan Beulich <jbeulich@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v4 2/6] xen/igd: don't register rom bar twice
Date: Fri, 31 Jul 2026 20:17:26 -0400
Message-ID: <20260801001737.16509-3-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260801001737.16509-1-brchuckz@aol.com>
References: <20260801001737.16509-1-brchuckz@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=98.137.65.31; envelope-from=brchuckz@aol.com;
 helo=sonic315-55.consmr.mail.gq1.yahoo.com
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

This also fixes a failed assertion in pci [1] for Qemu
version 10 and higher when passing through an Intel
IGD with an option ROM to the guest.

[1] f6fc01c78666 ("hw/pci: Assert a bar is not registered multiple times")

Fixes: 881213f1b9c5 ("xen, gfx passthrough: retrieve VGA BIOS to work")
Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
---
Changes in v4:
  - Use 12 digits for commit hashes

 hw/xen/xen_pt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index c8f08b5..4d159a2 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -459,6 +459,7 @@ static int xen_pt_register_regions(XenPCIPassthroughState *s, uint16_t *cmd)
 {
     int i = 0;
     XenHostPCIDevice *d = &s->real_device;
+    const pcibus_t romsize = s->dev.io_regions[PCI_ROM_SLOT].size;
 
     /* Register PIO/MMIO BARs */
     for (i = 0; i < PCI_ROM_SLOT; i++) {
@@ -495,7 +496,7 @@ static int xen_pt_register_regions(XenPCIPassthroughState *s, uint16_t *cmd)
     }
 
     /* Register expansion ROM address */
-    if (d->rom.base_addr && d->rom.size) {
+    if (!romsize && d->rom.base_addr && d->rom.size) {
         uint32_t bar_data = 0;
 
         /* Re-set BAR reported by OS, otherwise ROM can't be read. */
-- 
2.52.0


