Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3296FC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whrSc-0005b7-I8; Thu, 09 Jul 2026 12:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1whrSb-0005aW-C0
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:18:49 -0400
Received: from sonic317-20.consmr.mail.gq1.yahoo.com ([98.137.66.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1whrSY-0008I5-0G
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1783613923; bh=6TRFJxdSJpCb8eK0SYeXC8suh+qMlPVnpIC7E7OSPbk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=Nxo4i02hiG/SFTXenFtczYu1QXSOPQlHK4NzODxoaLX8JDMXXcaRN2Aj/6XriWpghNwGUYZE30//ARuxY2ZidxfQByZF/grGIbLTVV/rro/xgFZpg9X4eumsjsMhl464XcRMF3vmoWRHgLUcu5kmiwWWnaN0Q/wuMQ+ViCXN4GoXHJ1IQMBVGPXwjhwYCHIPGDEAufejc+14RGEf1RTF2ZyKMmmqW6XIRF1E2RNTCwyCdENo89fIiY9aOvbRiAfg+vjCNnJL21oIxRl/2mWcDzff7pJfrrWIiUNuA9jyiirJ2zMhKJ+Crmex2C3OTuoK2yY2GZJeDC378gJKYfK5Vg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1783613923; bh=hMCCyBEbqP+T+xxDKbF1RjdxccH3SVHwoVrdLhSo9U2=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=VdnItzd5C1mHvLbaDJXcKCtCxpdE1dRyTe7tAmQD1cUq1siCJHtaB6a7rkWIn0a6nIsg5BFsWQf5kQiTb7uaBxMfyyikU2Tm/+ggrNiOy5/NveL5686IdPBbDJMMXhxwMvs7ed5ZFHci4hRZiEsBSMqwqW0jxtrGxWPLSaWISlpyCZTuKkamavfUXpAb4qKant8OFtzsXyDKb3Kzh/TUDdaX11I4trkYfCDjlLqy5uoqSNg9TgMh4mNazXTgTLwAEhVNUSY6g6/0PA9z27OfmKX/vmX2iYxC6Wz3P6zs7xGmB25qtjNt1g5uYjFV+Sq3YZX40SleWQlfygJf9bhCcg==
X-YMail-OSG: ayEQUawVM1ndHij9dm4UoZG4ICQktaDTj3yE.VyQyBlyBNE1OHkNCsSIFr4wLNO
 YfdZRDFZPogd_pMxi7TYMm7hORCJCBwBtRDVDfYERi_kFA8Sa3PZHHmfDr8eEW_wvxqrkaYFv5Xf
 xg1F9VP1eQgnnfX86aat6jYx2qgkrzhfwGiYdR9We3ifMIMdcgCzFmLkqU5MdUu4XPzBumAPNT_1
 z2zJollycpoVj5ZwkOpe1cnYWapS.KAuJKpJ1WNMA_kdHQyZZ3od.xTuqSSwuCgw3Bl4g_d9Ft9X
 mbzQ5mBOrouGH2xSlnkTbS3JMcx63IDtCD6JTDfuD8gLAbc4UIxRqQB4HZKZggCJembLtcV.0H6D
 baBqtdMJTPUXtsFEwoQOEmpJoW2S5F058izlDTqXUN63AoX0P53HrBhCNep14Y9tWi6c_TUa.Szc
 mmRE4w_YC3g1_AJdnEsSTZJHnA0DUKGfKXFqMuM.0LXyniUNRkJcAIcsv8GKymA4ydUUhLIkncxe
 QHUrzqgfpKU9dvHQHsoowcst1pgA_pGgwnQw5GqQhVbVJ4A.4ajBiQP168tyxoNEmTJQefZmrmNw
 kBHE.WQQ2NGjr49cNphvntbBrgNuflQEQ2kt_Ito4hK7RKmdzDzhY3fLGyLPtfGCpvwL2_XiXj7r
 tQjneKN6YXHMWm2Be4CWBXAbFC7mBgV1mEhBvhy6CmbbSedMU1.1ylbRgmY9sENKKTsezrHanpyk
 icJ58Qb3HR1.9y9V1Sg0tHUxpESw_K6OQCgpPULYyPm02dRQ2M1YSh8yL9WvxVdFanAB7cHgH.TO
 MejoD2I1gVoeZ3kD7FQ1fH8yYDh.6cJ84zk2nJYMRTNBMGrb__N28wtYjTcg9JHSLhNk4qiYD3Je
 0sAXWNYTWERSX8uyIIT.iBDjaxB4Jbg3ggh33cRQDC2GhoDjliVoTcTRXRF0Z.DilFi0gFFISWx0
 yjwqt0PPqZ41q13DTOM98gRIPf7OiX2iyk.VlmPgJDxysD1KYG6fd2icUMhRx5SAoOzFItyg2WY_
 7kmpJd8adPKXUdZSXsKMhkFi2rf2gCwN93rjvG6USbQCS7whjxw2hmrKxlGLLW3tgrf2xR7LQRnD
 .Phg5ahqi507Gs4_Zk4kXHVOK50_.mpW9WQ.xtaRpE8Q4YZt.S8plDnmK7cSTj4gIjEL.xYx.pK1
 wfH7QIhKxSyfs5jCZYhJA97bhrDlKqFkcN2hyAwLIUZdz.mlfT8pqxDZNA.l2K0pZ78iiFP4w0q_
 1XitSrZ0MRkZQRnCuzj7PSf1VHed9ZgENdXIVi7TJVpv.llut9Dv044go29ml8otaYNOPpND4D2h
 Jbf4Q1pxCMQeUH.yURyjqmDZAAm3qFywxGciXBXzGg5hiBq0UOd54oWzEO.1uTRCT2QCUPEsY8Ew
 ufSBU.NHtknkb5EJxx18Tncc6JyKuED4HLxB6VN86nZr19RedPsJQLZNDDfu85itBZpA_j09CwuA
 yTjG4d05vDWraYbALz_dQMKmbWhoPTeXa08Yn2.KfnFzOMXfHLYZCivR5op9_a45uQTFAm8Gcm_8
 uVlj5SSw5qQ1mL45s3aaszxQvNU3xNH8JSpfOPg0pPhMDsWvqbmvO_7IjXKYzq9PK.yqa7Dpqbn7
 mZRqrSgwVoiA2xL8TTgkroK8tphZvgmwqqVgzuVDUO4NzJhaEUKQPEuc5ULmMFSnI3uV7kA157eB
 96.YZfMYPitRP4Tot1QL5H9KDLyZfQmDwpBXBPBCJkamshU2lm4Rrtmp4Up.eiITQHkplKpHF.nP
 PRne4lWrPoHGamB2qzwlEasZdobAAUrg9hefXukQaAoS4D9akaDtDL31BVGIZ1vxV_MPnzySZ7o.
 cAwiw5lvyZmSjasNVFkitth.GN_QAVUyNFNRnKgZusOq6rRguohC8EjJ7njPG86F4BIkE1xLnKge
 U_yOEIgN1vuMhhHz5C3WEnPCDVqtljwf7YxNq5Nr3qE5blfOT2Ck8iyeis4fj5ZDd9N.dI5VrvlT
 0V03hH3LVb3e1GWcqM3uKCweZcGXBOZwWzHwWA9Oc2ocIfl1ZyWj9LLE5UozT5Zh9Jk.DXD1TItG
 AABQj0vh5LgpESep2ebRKI9sZCNa.WVo9WzDzCKK4_lAaF08e6nvDISqvaKyr5j5VXwtYZduw.Wp
 SsVbRKyXziTAVU7A7OBTN80o_PSOb0x1XL57hpzmFxafYl8eGm9JD1VCE2GTN63mT4XitEccCd92
 FW5vwrSgs2WxpDJAUKiExJJVB4VoZAXFC4c_RUyWt
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 140ad6a4-b874-48a0-97f0-3f602f31e683
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic317.consmr.mail.gq1.yahoo.com with HTTP; Thu, 9 Jul 2026 16:18:43 +0000
Received: by hermes--production-ne1-7568ccb994-pgg8z (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID e91c25460b5bcef5e32390743f7fb9e1; 
 Thu, 09 Jul 2026 16:18:37 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v2 2/3] xen/igd: don't register rom bar twice
Date: Thu,  9 Jul 2026 12:18:30 -0400
Message-ID: <20260709161831.17753-3-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709161831.17753-1-brchuckz@aol.com>
References: <20260709161831.17753-1-brchuckz@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=98.137.66.146; envelope-from=brchuckz@aol.com;
 helo=sonic317-20.consmr.mail.gq1.yahoo.com
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
Changes in v2:
  - get 'pcibus_t romsize' instead of 'PCIIORegion region'
  - move definition of romsize to the top of the function
    and make it constant
  - add stable to Cc list

 hw/xen/xen_pt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 474606e..8b30b61 100644
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


