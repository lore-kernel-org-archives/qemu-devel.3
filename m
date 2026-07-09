Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31EEC44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 05:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whh0o-0006kn-JZ; Thu, 09 Jul 2026 01:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1whh0m-0006jy-By
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 01:09:24 -0400
Received: from sonic312-25.consmr.mail.gq1.yahoo.com ([98.137.69.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1whh0k-0005m8-V6
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 01:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1783573760; bh=m2Glp8wi3kwkb5QhxQq01xhDsLdInXw/WE9Th4YGj7w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=FbvF4Bxmi4Ci6Hv5xb+vV9U71ad2my3dCMUodg1CzrUK0YkET7hCIqlBDdPU3pkDG/Iv5g/VussMG/VmAbVqCIcGPZC+JMvayAiXf5WDNJb2h4zgoM/ntZkK5O/AWYppIJPchITFOucd54cmEi/Cj1G//islK+0s/X4Yx3tlWLc41VdrCA4KBPDRm861hn4PzNOjPHkVxMrmTctlVAc0BDGtrdtbn42TrfQjiB6lsdiPT1cphgWH2kNQkhR3FKNMJPddS7h4ZxF+QRVVwaQJbiVk6vNpjf279ikqwrI7c5rKjVi7exCMIdurlvauzbBKDgjbs+xYMeBj7xf4IOEAUw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1783573760; bh=OHOrD+3w7dGTNtdsk72dzU4E9ANMJiTyFgbcK/ru5tX=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=OHuxLpznchqCXBF6RtQMf2NIwJ19nUIsa3CGjThqzYm7nPRJcYXYFpA2Z6KWU3kQpwuakhUlxS/ah/CzYWT4Tyg4SwFjQACG2RDnlk3Qw2DcqZbJtDSdE30RTGxP6Buymn/tP+LKDIb7g01Ky7moCG2WMtYeJWOljhtuykzlMqdg1navdJF1ewiHNGxRPfCc/ir7PKJJmKPUEYwVpg+MxR+wjcQZy+xgJCVv+QaRbZbdMliJfebMskt+c3ZYmi+wMkh1RHZuvWm/WH9e/4fNE5O+6hc99gbNErHv6okok+kl12ZVtr7C1+HmdzRvl1cRcb8dErMBmGrXesL19oXPSg==
X-YMail-OSG: L5_GXkAVM1nr5wX1RW1uU2hcTkTL5jxrxlRzDHwzSHFq5_HwNoSPzHMb8STgzcV
 Yyd_gnqlenOiF1AY_3yYVjoQWQoZ_uNHJaR.nKgmQj.C19VGRrFcPDa5o1N3i3B_.KqzUYh2mHtX
 sAzhM03LHWV4aJ4vAnyR6ujvYXhSzrrFAFUuxt2cx_WFC05Okt49awJxOPfN_wazg.AdP94d8seO
 8RSMVM7YJTLmfsr40dbLkpHx_D.tKNat5.SyWKckIuWn_umVtnfBrYERURZtzD.N0XdzH8sYwYzf
 sWhbMUIs7bWczklFk_UmC7.kpxhnlpabdrFkZHuHK5jMz8y5cgILVPzy9vtuK9lisoBCBlTjKGfn
 Gvi2WTQcVALyD_ptbvc3BMAOPgqmCqHadwN.Lbr7LMnkqja4jTAaWO5xNh9g7el.MjVBdWepBYo8
 gZRrWcBo_vIPjqUNtiJZ_EbmSi0qQwCsw6m62TOwAETg12oJN9ZSXr9pqzg6TKmjR_Z6y92ihN6V
 Ss9C.8XDLdv3p44a4gJLlWi7TCgV1vsbhaK2RGIh9HR1UNIN1TF94zWyMtgmeCKHjiRA6AEWkS8n
 QGaVwWN9uMd.kI29ZRFjxK216DRYLX_Qw.zj0a3shDbTjF.gxsTnOQ8H0Xe8BJGdmuCad6N_t9pG
 DF6l7ypmnCE3emzN9AVnLbbX.zv9dtEsGxiIFwcSlV8TduaFKooso8MG.qvKhX4J2JEO2JKsnfwa
 jLJfobfyjHgs7fXmlvYV5RDSXZJojuhaOU7iGejpk7ClVExPE8dXuBMnjuDwq.ysmSlV7qEWsOeH
 ok7YRUeItqjtjoCEeIo5nK8W4Nw1TvNpYil8.dyGCF0v14BeRQRdZkwguTWtmdIZLZp7jAgHgF9f
 pQCfEqeCxKBzfduyoJi8cnwdKX_LXspB_FpGmqaHfTKWFqy1K9MwedNzzQXY5Gd0ZQa_5AZsUrCt
 e7TcXGUEXSZORJiDctmy5mu3iLb33mY0N2t5e7t3Yo2yiYkbcTtJPXY7pHkMBnCFwRUW3JYdHvfQ
 SGz_JMwYSqXv_I5RbYcTU6XPP4IPLwfjkPVcKrQSnmWmR47JlUhgdLKaTgyfBc_IgIIWRbgHAW6J
 8qFSy.w.HS5n.7QGSxFaVtj9aoVxQUEkG42H36aeetCAnuXi1Nk8YaOxDze6PJvQJSL38pNgXxJu
 nkKdjrxwU5ylYAY5fw6HghbfBdEIESP1KcwuDarYYDasevuC_FJHJDZHHEDblaBc1m9BQN1wpLuT
 UjgJ61wLo9IjPodH7i2rREGENSSwTLDECAaV9HAdzSlk3pf1doOKxvuzvybj5_16zKGHc1wGg.03
 2qezvglC5gqQvS7HYl0AVSfeHOUptynWmRiZNO0R5GmpQEMxEd3LhCWDNR1PCnu64yYbUcfrkXD8
 1rorrNdnIAGCj19eXyv01Pn0AqvoIkC7nTGc5zHlTx08LLs.rdeaqmWjmkq7QyJ5Y2PMVPbioXcb
 uE8BP7d.j3CJTCy6OVl1_oVjUfxSTNw9ByU_lRyOw_e_xVczdvCo48fv6Z4sbDxO2MDPafp_bOxP
 PiPvA5vcBxwt4IkBzs6E_IS.8nE8ng5qnegOTvGcUMFxKCDelcZCMWsrVWe2qyYVCgfA8OShayj4
 Lo_ms74hnzfofMLExuISnkcgTNpx7zArfeW8OumP16QT3325IXZ_UNXn0uU00ZVeJAfcei3LfTnP
 FaoV01zWVo_gdalXvsaJSVqoBVYGLAkuMmt6oNNlYzL31LGIM.o8Zliipn1_iWa8HD3zKS16EV6i
 Dk8ZMiJ.xSSdmVfY_j4YiURA3dO6u1enbkCdLlEAcwmK3bikBCdPTR97g0slJZfUevKLKTbUgY5e
 UWfaib2qa7p527R55cJ38hyjumN0KmViOGCek.s.8zNEIuZLvydXERedbQYYvA7u.abodpj.suYJ
 i22rgC0UQuO5W3sRaG__zjNtXkn1_vYvLI.9y5ENh12ySOqChsm1ApNRtokTUkGllqCJN0d3t0vw
 _XBF5Nz13Tfpby4u9UzO._q.Sp2ZH2HZCenixsqk0J_9N4sBhKSiZZdOUHMdWsrdmoRu28PpbUT.
 RxeXlXLOzTwn0hZGd7oCNO7bEVquusAPQ.CG_Yt5lhOA9Ms5w2.FNaccbpyTo5DP48J1rKSc_XSz
 pugRh8c2xQVdH6JSkAo6HpLvL2hnk2J9HXNT9bMcVD7HssN7KF4FxsIE_bLQeHV9D6HLoj8fwbxb
 icQFb6VHbn_uTiy74g3kcy5Hmb7L0QydR
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: ed7a79c6-6a0d-46f1-b36a-b1ea89bd3ebf
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic312.consmr.mail.gq1.yahoo.com with HTTP; Thu, 9 Jul 2026 05:09:20 +0000
Received: by hermes--production-ne1-7568ccb994-mqdhs (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID da73cafa7d25cff72b3b6899257e7b9a; 
 Thu, 09 Jul 2026 05:09:15 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 2/3] xen/igd: don't register rom bar twice
Date: Thu,  9 Jul 2026 01:09:09 -0400
Message-ID: <20260709050910.8217-3-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709050910.8217-1-brchuckz@aol.com>
References: <20260709050910.8217-1-brchuckz@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=98.137.69.206; envelope-from=brchuckz@aol.com;
 helo=sonic312-25.consmr.mail.gq1.yahoo.com
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

This also fixes a failed assertion in pci [1] for Qemu
version 10 and higher when passing through an Intel
IGD with an option ROM to the guest.

[1] f6fc01c ("hw/pci: Assert a bar is not registered multiple times")

Fixes: 881213f ("xen, gfx passthrough: retrieve VGA BIOS to work")
Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
---
 hw/xen/xen_pt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 474606e..c3b6c1e 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -495,7 +495,8 @@ static int xen_pt_register_regions(XenPCIPassthroughState *s, uint16_t *cmd)
     }
 
     /* Register expansion ROM address */
-    if (d->rom.base_addr && d->rom.size) {
+    PCIIORegion region = s->dev.io_regions[PCI_ROM_SLOT];
+    if (!region.size && d->rom.base_addr && d->rom.size) {
         uint32_t bar_data = 0;
 
         /* Re-set BAR reported by OS, otherwise ROM can't be read. */
-- 
2.52.0


