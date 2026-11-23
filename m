Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2D6606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256 header.s=a2048 header.b=Ds8o/hJh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVTbC-0003Ys-AT; Mon, 23 Nov 2026 07:56:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.seker@aol.com>) id 1xVKYe-0001hX-PP
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 22:17:35 -0500
Received: from sonic316-21.consmr.mail.ne1.yahoo.com ([66.163.187.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <m.seker@aol.com>) id 1xVKYc-0008W1-Ue
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 22:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1795403847; bh=ioeCGEWsdYRgH8TdFTRsfjwOZCwLQdwJi10RD6mXFVk=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To:Content-Type;
 b=Ds8o/hJhN7BJIPGg0H81k3qKFnmpzHYj49CpTPGVLpP2PosM1Qms0Sa+zF/jyUyeWuCOGtyIgcHD7bhZDVIoUb8fMdWAtR0xuWpv6htzqSsso49nuccIp2ZItctMcLWBRm0itov/CMofNemjGkbmFMVAkx50ynJtRWqbVgAhPkArO0Ym7BktAsf0P3vji+gDt/Z0/xv0b/XQCN3nL5nGvIx7nunTguV/N7fbsmSuHxbsWY0b3rVXRaVdBfDrDIGOp/YGvImWnSsbJeqyvysWmgavO3biPRkey1gEmllCHTNICyWeMIaoN2Lw1Xu+NDU5Ct0oGOj2XM2uLiEbQxUICQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1795403847; bh=HdxsiB9hXp/mKEZr9h+CqMAK+78qux2owvocuWlMJj/=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=aYOs60h/E6i9xshRGdibPLBYeSROVEdys63MNPh110yWmZAbAQxnC4qvvnE2zI5uEQyjEstJaGCRrW5yHpBnk8tNjYyHTEAtCT3hj1K81TvOH2esB7r3egdtHVqkiJq6bo8nXcSTS83VRtvFKISPcROqBQI1T61wINh+dRffGA6jHCG4L4KWJIPxb4tyclfmh5IiCXJKzVMLxmkZx1N2bx7H5RwVGX99zUUonDgGN2FboIhoeKJ/JgMaTrVaNqSEkpLNPXO4NB4pptrrN1OExnkSK8a/pycjR+aUrjHWKZEOia9Il3AVxP5LLR9Ndvpn8/9Zp5ZHT28yHQXibiG8Lw==
X-YMail-OSG: Q8694LAVM1lxWHLwHAUHjW7KOhBLVp7mOVPlazcjE0S1ffUeA6otETnU4PxA_Ik
 FbVgDp6FXWjsyYOS9NwmMO7tjdf0T4C6D.wjq0r34i0u2S5YWo.ZmguBn948eP8FzPo.xpeBXjKe
 fGnhJCGefNsDQLP3GZLEC4GcG4Au5soYKKDlV6lEFWpNnbG7kF5aYYdnpTvze8FuczMd.GAS_Vzn
 qvQtmxsUFyagiM_VXSl6TiGJGRo3Bd2fGPFb1tJe_7zDDmaOxf1vf1F36pl_gTavsfkAwaqAI5kb
 7oNhUUCUet1_VrEvReua_fzM5S7bvUyqH28QmD.iDEqH8Xyruo.aG9jZwhECfHxeZLD1fC21p1kZ
 N8aMTz3q5cQnBdOGRV.YoWks5n74WujHu6Ao0VxgCu_8.3CZBBF1A_pRCr_uUFYXGoBe5tJN9GU9
 dJ_QcVYVhtjxMlV9u2xMqWMDgBLvFo5cTMJQuwPbUvANG3P2mv6r.m2if7KQLMHlT6IRSzCkfVGI
 Flh.k6CQcIDTZ.ucDih72zpBCje7w0tYhFC.HOuB.Kimzgvd3_jewAm3SVEvT4dvPE5XOUNPgoaP
 n8tT.qeKuwBwRgwZafEXOn4JLR1VT81tb8a5VSv18IhwQJDQ50ZdrwgbGjK_jbqdVs3XErcBiFBt
 7bRMGrHaMZHUMnYdvznCaR._AYBB9C4XFvxpHjRH6gLG9zgYPwHjQHfSlGubYrAghRm91zbwqTKE
 v5cVURvZK4cVRKbRvg2SAmQKk4ldbiNV1rH4IePMeOH6Iyf4fpUmEkuJaDtcsDwiSTm4MeKFerEi
 xVmC_K6AT.GWWhdXXyDxOtVBo1sds6lyhJXZkwNpA4dYruYLFvaJYp2i9PTvHN9j.uCDoJGDDR8C
 17bHWyhqKrAHQVosoy2MwY3iMCXZlsNI_vvEuORDI5qplxZseL6LjOru9ewWnoN407HuIooTGMFV
 Y5y7EjpxezlxF3J5AE_x2TQGesv3X9STTfBgu3aeVKUSqZNy2doRDpJHi7i5ZziC7My7WjGO8ceN
 En44SIF.hLp1U5IPBZT8EqjP1ljegK5S3ZXwfiu.18vkl7iSMRwEHk0khNNGhYqBmIFAp9YlvkSn
 r8OSKYefCINtZJSCbLNRHEKxKHeZSgvcMdIce51e1gNGO0SsMoa8s619xuyjaGS4EykMquVz.xj4
 O8iEC9uAcsylrdJfeFOJ3KZ89Gwx6eSH.fkp16o7tA2d9XYpSL8veDR1JMK5ZAWbK49kFCTy_YF_
 TR6EZkm1I6TeWBJneEQ5jcR5Pp1E4lxbV3CF2UtJdZhqFD9.dMpCTsuAZBduzbABHIM9ClD1ScaS
 b0XphYGFEOXMXzoG.6KN_yASOxTD0R7UdZGCFJ98Fq4VdcSMtjTTW4KF2AY4dpPUgKkZZ_2tnWGC
 0DL9BXXmkFrauDNBVDHoj7vEiCg7rG2AWpJc7CLYnajC9eo1a.QiGMkaWMJK2DN.O7di9Hu7os6r
 _lotv09Klqc5p.srH4H1VgQl.bqPOEl3zFlDeUp76gukbelpoP7d4LJpa4o4tr6eLYs.24ZXzpI1
 j0bcH5aIH9OHyaGWfEC_wdho650M6g0TPmPfkQv00mEx7mHhaBrxawufzLVRkoAc6EHcTsiymYib
 OCUrasfnt.62w.24zxsxioqwG_pchww7ZNNNrP3bFBT04BuYUntO3YKwtv_.2gEqn0SDzRT5s3lX
 jsWXeKx9.WqEW56r.MlNmIFw4mmcOHMoJ2.AaWjxAHgS3QOl7fMiGmxAmXLpMLOs4ErmuIGaW1AO
 Q06uk0cuJinP16sRBcwef4qPfob6GXqFMgjz8fOvnqyg2GsU6Sj4dD7xcNcl8_Stt7ZsV_nKqAo.
 2.bQS_HJjhQbG8oI0L7FrCosGm6VqmL2fDvNxavC1EPr_c5XODvAK5WKBnLwZbmYbImRRZwMU6yT
 3bIgKmUrbaxNrhcG6iJLmz9RslQaXP_QsdtDVnLZ5c4HlSn6CBSr7h34ghhlegSdu_J9ZjyFwSt4
 sBns9M2pkhkox3iNu4ufauLhyhYAda2OBoVw90veld7bMcUlybnUaw4eFyEdyyYrt2GPzI53A_97
 2NOIfTiePisItqwIS0MZCb4a_bDqTGVfcoiXKyPbTA2cs7SWk.iBCdCvOcxJo8PenJq1fxSnDbSt
 Dk6ZhqqRJa9W0M4NIIUnIB8IzzPO.aafqfjbGSJ91QhmHuCEjE62W0N71PPv7HHyetfAgda7nB7p
 p1l87wqTA5msTfet.oHRdiHle6w8clc3e7Gt2HrVLTdZujr8nzEROiA--
X-Sonic-MF: <m.seker@aol.com>
X-Sonic-ID: f611c530-b215-42ad-a030-3a9303d66d48
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic316.consmr.mail.ne1.yahoo.com with HTTP; Mon, 23 Nov 2026 03:17:27 +0000
Received: by hermes--production-ir2-7c4859dc89-9kgzz (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID c4ddd8ad7a2ef96ba5841ca29cb0d1e1; 
 Mon, 23 Nov 2026 03:17:21 +0000 (UTC)
From: Murat Seker <m.seker@aol.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] accel/tcg: Skip clean MMU modes when resetting TLB dirty flags
Date: Mon, 23 Nov 2026 03:17:14 +0000
Message-ID: <20261123031714.13166-1-m.seker@aol.com>
X-Mailer: git-send-email 2.53.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20261123031714.13166-1-m.seker.ref@aol.com>
Received-SPF: pass client-ip=66.163.187.147; envelope-from=m.seker@aol.com;
 helo=sonic316-21.consmr.mail.ne1.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 23 Nov 2026 07:56:42 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

tlb_reset_dirty() scans every MMU mode, including modes whose TLBs
contain no entries. These scans waste work while holding the TLB lock.

Use the dirty MMU bitmap to scan only modes that may contain entries.
A clear bit indicates an empty TLB, so skipping those modes preserves
the dirty flag reset behavior and reduces time spent under the lock.

Signed-off-by: Murat Seker <m.seker@aol.com>
---
 accel/tcg/cputlb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d79eae58df..2ad8983151 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -883,10 +883,15 @@ static inline void copy_tlb_helper_locked(CPUTLBEntry *d, const CPUTLBEntry *s)
  */
 void tlb_reset_dirty(CPUState *cpu, uintptr_t start, uintptr_t length)
 {
-    int mmu_idx;
+    MMUIdxMap work;
 
     qemu_spin_lock(&cpu->neg.tlb.c.lock);
-    for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
+    /*
+     * An mmu_idx that is clean in c.dirty has been flushed and holds no
+     * entries, so only the dirty ones need scanning.
+     */
+    for (work = cpu->neg.tlb.c.dirty; work != 0; work &= work - 1) {
+        int mmu_idx = ctz32(work);
         CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
         CPUTLBDescFast *fast = cpu_tlb_fast(cpu, mmu_idx);
         unsigned int n = tlb_n_entries(fast);
-- 
2.53.1-Meta


