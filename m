Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A64C56203
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 01:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrmYE-00025s-CC; Wed, 05 Aug 2026 21:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wrmY1-0001rq-1u
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 21:05:27 -0400
Received: from sonic311-15.consmr.mail.bf2.yahoo.com ([74.6.131.125])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wrmXx-0006MT-5x
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 21:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1785978319; bh=h5QyMZ5Ty9ooeK2ctmMp9atdh7YP6qYwvti8uYhWKKM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=WXNAtiY9RChQYvCGuuLGy7KGeXy4O9j6SP/y0MMsyyqqenPnDbYnoFLGfDrF5fVHHb1gmmsRPzK1Lz9Af4qI1Loal/uC6jTdtVsCA+EHctj2FC8sTzWwRl8SgPNv/NJMOWF4DKuiguWQY3hlwwZu+3tA4feJB5saI1xkQxHCdu4ySoClKu8vr8YvVrEWw2B23fEdFpL+ggpAoglcPwvLuOBjVlHpaRO4S84b6Fk+ITC/npzOSdIVqKCERgRM+HeH3yVSqw/T5SBa+8q6QjRbZULn4eDUOqZ1wGv4Qq5HH3+75yv0Bz9kWyU102qR2pquN8JiME/3ZU0ZicdruySTmA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1785978319; bh=HtHedw0HjklR4Bxd03Z/oktcnxIu5kpeFcKt5A5jUx9=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=sci23NeLeQW7/83wPOO2xYxrJrnIzvA1nCne+qp01PehatgfHclk9IQBzehCg/x9lN7XF1Xhwg89pyZLdxTctgs9u1D3DIYJrBb0lCA3MYiQHi97zp6MdBfZYh1Ia7wh14EmS0KZi061RkXmAqOAC46QwFtIdGwdUJZNjqX5ODGJAVEvgmDUOujEQ8tw6ubB2K3KltLYZeyY0rUJYW2E1xuAYuyl8ts4/pWr5swcrhgHHDh/9I2+ZbR588UKIu/DHoIFFMrxzd9wWhcyYrBBWniH/oLZZZodThbnFKnYVgCvNWqm4LP4vLSP/SrE7FzckSaghPTcbWUGAlffpHWPCQ==
X-YMail-OSG: NjVK234VM1lD9.mUG.YoQ1naz2l046QG0gja2Xq3fbevJ7ptMpnQ.3EcZS3oYyn
 NhwfjfzgkSM7ZkTtioAD9keWSwSCStzoJAxvYag7LL.5zN51nW4NJyYOKgh6A_Po5i4KsrN86u6P
 pZqUoSBIr_SsMXRRc49x5tjkTKiaVc1T7uB940mTZrmGcEPSWibZrf482SnBnOtuPv8p.NdTEUQi
 ZtLT9c6IcJWwgCAAIwr4pUYIKnq28ozHaqd4l3MdriQrRRLGu79Vfu7bt6nlCRoykDfNgq95p80c
 XQoiuVbNB8KnrPrlAUgnZe9Xr0nrKWTyHRNhEteUjsvxn4bK2XvEJT.Mw3gb7dsPk8GxpjfydzyJ
 lPlacR4Oly.TtnsZmUUUym.4XrqCJdhk.7nySdVeqywdoAu3vAETdcJhjbhtHBrbyAU61hk7g6ZW
 mCKfXSeagiSrGBtX8M_t_8JHiRxVbO7yhx0d3iSPglkqm3XUzEY6TIPO5FqBI9FM6iADU90EQmkr
 CxBDDEFFBST4kOa5oPj7FR3hdiOOxxHjW0rOO0EFJGRq2kGXKfz7uit7ASoM5UKf_tIxKjGVaVjf
 u4lsJKgFWBttSL1tCvxIaMI83QfS_WzS074zbhymysSx4n5NZkFnFfeOQHvvwKFEgl5CrskUYE5E
 HIqdg9OOGb1oUCe4Qmm3lQI_unMugQP55LYYtAaDzBBfiwIyhjxKrstXAAqPB_YMTH4.TM9tlzHO
 JByQPb5Nlpx2B.xSMQfEckVgvOQIjBXY.sSeVhjt.so6Pk_8mDnZ4Bsvsj9MAJzmcVr0lDkIqcP8
 fvGYjqiAyT2GELjU5PNae4djk4ZphG4hrnnKsHA7.Hb6ysoo9GELD4mtYt3debFIn0.xz8w6hVvC
 xcpc3ZWrptF29SKGUaQwAijwVJUSCueLE1BD9Fc2e39UF08TTcYRw4iHCLqWsr0.LjenWlD9.yGP
 c9KmoarKCFGAGV0ioLtksq2rAR6el_04YYGq1sSse4pNrG94.rbhem1NJcdpEKSgrf3KNIMAxG9Y
 T7DFotuHgwUCdxmo7spfxdmJ7DXIX7JWYuYYdKeyIiHa2VPwbRubXvyTkhkHposzL7w1ucCHloHr
 _Gk1z41Mic6aoC6bSyKZ8vt4s.qsz7AVl2YRO5sJDlYNaJEA1Th53gRShg.bnJUXvXZrdOmo3Fr8
 kM7t75B1srS4Qh6AgYpkGg45kl85pePrRBqW5XfB_8v9P7D_LOz9UySUcR0n..APL5OAh164QtLM
 jqKiPnKDSPuD6YXjE3QXO45N0ukzjQ5jzAA3iBGnm_qgeuQyDRDM4S7ZEOR4SIs0YiQ0N.VKAFcq
 IfDXALKaQK9ZRKX_b0DJ7GRm5K6v3MvZwCDvTYK3VxJVpqIIb93fQuv8G80bK_hgkgNhBlR7qHaW
 8dEQ50f2.PHapsTahNTchVhHVwph76zvUPF8uUzlfpuBh41snPpWf_FcwRYDizghVEYYl6AN0hcX
 efd_Tq9goGIMJGg7eVT.CHLop8VblyT59azRqBtIvrXqqKAVhcW_O60iB_NTzAzbg47M2taBg1jj
 3ZtZH9ykhUOdgq8lBLPbQbHDKTFUIgDbzAreNhd56.atJ5SGdATudlourGtr6GaVBYKEGm489kwi
 tNUfKscmt5bilcr.7bjnWOcP3DCUM_Asxv8OwLyZPGe.PmmTJvzL4FRYpYqRKWUFNXGzF7Ydzxv7
 yiihKuTJ7ifon0_PEskGgGwyAAgFllt2E29nviS5xdba.Hk7Xogx6hu0OSHiSbON13mZ_nMqaO.X
 1KMjMA0vewPIFeVVRxc6bPs23aoJNPldQwwrxFXy5HF6p9EcuyYFfuUxAydYz4KflpQQiSEHxx4E
 X9O54dy1Ln7sf0X6ctLLJfHWS61dREG._tczC_CXwGmckDZgyOWPJPuHVhRoJlO23C31_nDjRf2A
 6cmXuoMxeGXd5P_r2EupZqCj_VNlh03j0MK6EpNAxOXqD.eW7_aD8YFpYXIHojh4NGeLNMsv.vvq
 4MTPisFmRRxCR9EDOGW60Zq0hWwH3Jpsa8ZBe_4CaG4.XH7A0eELt9DMjNUDCr21I_RPrDSJlg0w
 pfaeuzGNC4Boe69QUvMpU9jyvIxL.gENusIDMyvYGXeyhK4Ajr8j47btyu2lRIUGLzwJCTaiEKsj
 ITGG5.7L5LyWfXrpxHM0poUOaP.OPwpFDvHXjFp4XJypdJo9R_fZ0kJjJ.qeLNICSNzE5aM3IqTx
 OAw_.0S752jcQsBRsRfsXMqV1G8BHpg.7rQE95A--
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 2529bb1c-5623-4262-a178-66bc47244aad
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.bf2.yahoo.com with HTTP; Thu, 6 Aug 2026 01:05:19 +0000
Received: by hermes--production-bf1-54b5569bdc-xjdx5 (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 734f0c8329adecc00a98ec91cc943adb; 
 Thu, 06 Aug 2026 01:05:12 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Jan Beulich <jbeulich@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v5 2/6] xen/igd: don't register rom bar twice
Date: Wed,  5 Aug 2026 21:04:52 -0400
Message-ID: <20260806010506.492490-3-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260806010506.492490-1-brchuckz@aol.com>
References: <20260806010506.492490-1-brchuckz@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=74.6.131.125; envelope-from=brchuckz@aol.com;
 helo=sonic311-15.consmr.mail.bf2.yahoo.com
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

Changes in v5:
  - No changes to this patch

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


