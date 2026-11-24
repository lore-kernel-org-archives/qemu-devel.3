Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C11D606A680
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256 header.s=a2048 header.b=BJRT6joD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW0Aw-0004zq-Ke; Tue, 24 Nov 2026 18:43:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.seker@aol.com>) id 1xW0Au-0004zA-9h
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:43:48 -0500
Received: from sonic311-25.consmr.mail.ne1.yahoo.com ([66.163.188.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <m.seker@aol.com>) id 1xW0As-0003WM-4y
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1795563822; bh=pdHiI/kLAcMhDk25SJ6172x6S6YekHKCD0TIhqG1oEw=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To:Content-Type;
 b=BJRT6joDL3fkANILSeyOiVz/xlatCYuaWhFUns67hj2ISz0S92RAcNaQZfLcGBoBR2lF7TZ9md8VYG+dlIE3xyGmoNozNR/v0QrJUkSgOyljx6CbE7ddgYgTldXfVubfhCJo03IDoDk/DDrEMGh/tH/a5nnPsm4zxNUmEXmnDGylARKRqn7tyathFFV4Y1GrxWSWfWDLZPW99rApra/EtPU/5kU9D1KlyfABL4QGrFlAG9/Q6ROrFQzV/A4Hu5UwR3w34pnLviUEjvnDMSM4Sq5oyubBAoqOwewOThNOUycKXv25K7rB269LBvYN13XL9q/WQtRpQ2Ut9nqjoUzVuQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1795563822; bh=/WHpSO1wXufh9PUU9rb/ew725QkRdlvWYCtUBm9BJgl=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=Fttt0/pCYXdsTPaJSzrt/vjLz7rK/w6riO6EL8GBLThGAK2uZmosCYDjCUSwLgUGlimrj9MXqvo0+mVq7PTbd0TztDp8+CvkslADhBfE6kes/s4w0K8JJR5Wv115CNn63hDqimWFE8qRIGel6qib4wyTNDGe8IKJKAM3weALacd/jd9+yE/iT6hIEMXt/4ZE/cuazRrWFJyQTVZ4yOMv976TfYyHAFjWHOzC3+jbvJsQjFMImFQMbruIJAY0BvR4XXOZ1HIZLbweCVlNQCZSp8trd99INz6Rwqrjo5m0GM2ghaxxWRzr1E6r8TsqcGIbAieY8QG0tE8YVJ2+pl71AQ==
X-YMail-OSG: RHEgiLYVM1lMk.pLwAE2d7oBIQs.aQvX1BDtu6di3jEfwORv9IY1uuKz5Iny7ZE
 97rw1cFYIq5GrNu1uoK.7.aDNBDYp7XyMZYNTVxo5OJs4t83B9fd_8x1k7qw3OScilIPZP13H08s
 b0RXDAC5lztYRNzuUrcu98G9GU80YEQH5PuiCC0td4n8VNginbU0a2EjU7vi9M1qzZWvW.g1ukN3
 45VCbuvgFE8YCsP2NM2udBWulUZ2ahcX_0aGn8kTax3cEAgbykHVmfLbMt_aV6wnVcf1NnPsRaJ0
 psHcfWLPqCKuSvee9NPZxMjCYDJMr7N7fpD4zz..G1jQROUeRH3UyvhDhDSesZc8x5LgJR5RA.qk
 dBgHaOL147k6FbEeJ.393HGPnmyJ6rcS0SDMtj82T0pYdoC7hMB2NoghrLgRVyoDbFIslFYp6I9P
 MG8aQhAnOIXOXkZ_GyLU1y06sfFRG0Do0YQLllHp2MVUt0uI4t.gfZds7dDIywa6HmghHIXwB_AC
 4tlKWBSBV3uMQXr4irSYj52gaQyPV3.z1Yu3Skxgq6BSfNJEu44vZPHKc1Kh0ENbY78n3rUOxr7S
 .u._X_eg9bBFChrwG8cYDmNFYL6y6zj8fi.UAVdTTMc2T3JknHQgGvDpZ05unIJeXNLXHCp876te
 poz4JJKyLgWjvLVa.fMq7QqAB0vieOjg7dwXW17kom8p7L_bTv43LDy0NEYlhXmXXX1luanpmUsS
 zD13uSP5qc0yAbDH022tc59TZCs6yAExptIO1Dbg7Pmw6XZkmoMt_vG_AsvukasBe28CdNO8h1EF
 IT1Kv7Sh6WGDIfvzsvr3Kf.jRUnw1IOkm9wmzenzpMz8QFA6i0p6i_1DcjAkdC9UXB.anIyfnOdq
 5vPXioxUKt2pl8oARYWZw0d2O2oJlMij5OZ8PbcL6Mwoa9Or_LyjcRIN_wQeNklSlUJPJrhQDbCp
 96Mk_3hlBTbm7Y4fyz_FOBNjRyA28OIVM9QZWhsq6r7enrjRD.z70CNiYfEypytbekrEi3uNodVT
 fdJkLdDp4Bqmhvxblgyg1AZjEpAavgb95qdaAZKvsVJIXa1RClFljyhpYDgCqSFKw8ZFWwuxUfbQ
 W5HKZkdx1YVAHidUN9q8YiKnCg9lWquDAM8LyB3Bgq02wHtC5hhX3BgrAtuZwP.1aYxWCye1eyJe
 zBydtaIfm77i.e44_D7XUSI1MqzdqofQjZsMr978JBBxtW1vdraWG1xO5faMxUw_nR4mTT8t4lWo
 mEqKf5p9JXnLCKFBhPlOoZWYdk9X3v5QSHqXs8KFRs.lANUF4079gyk1.lon5Xn.se4deZOH.c62
 n_xhXja4qn_y6ioH.5ORSlf5zhCF.0yjR8jQolMWiGY1VIH8IpZkURDvqatYIMaj.vVAmvFFlq3a
 JYItX1OsSU_yVpgr95esNorzVvoPmNb8_Zn4diVhm_aymOY0rm5bQUXKQRiAla8lPoFzSSi0wRVb
 o6JfCEy3AiPYmnrPSihhEsy4dZHNFOIo_FRpKyp2ef8i2UXYZFpoOc4TL61mAn8wvsVGmkx2v0vg
 sFgH5hGGtZmeIDMsdkZ552G8SroieXEOTg8cqns0DdYxWSKe4zrMjA3RtjAjloUpf3Dz_IZslVMT
 1FGn69tTq7XHeS0PTOs384eJcpkpAVQ0JQoeKBnGduz1zFytrkvEXinwVIcujCFbr19yzVkoPkaz
 HIZjsBAejr2f2DCEWajEsj5BtdERMvNuvq6DHzwwNCQFFTTp5TGKsG38AZcdmt_MtdjZAzyhIUSD
 1fFON2y10ldrQRvsPfT9_ImYW73HucV7KiPzdrtlJvemd1L3wTpJT8igGA4CBkR8hQKoPmeIhZ.T
 mKRcVgfTsq17zAa.vkvXW04Z0wYXDX2WxWgILkWqyhRxFchgVUI62clgF_E8kX.wwh4mkxC6Pk17
 Sw7TqiSnDMCBJVGUZ3avx4yEtCFBaNXu_GktVDQzCXgtHU2HSwEQyVY41hK2m9S9RydLDQXbYZ4m
 5sD2xCzUEjut7JQX5hxkwIkKARYwxPlP.zeu5KY1ULXM_2Zs_4CssPKSrvMJigP8cVT7Rqjs.0el
 r2q1vsP48IfhzsdmEYdKkHFmR6GOWuL9SwGzYcz2lGQuWB2vTpp8ed9TzC9JQjIWWK456rrvJtqt
 wNMqc0bDlsDegNog0xMJviqGZameGnht5bUKZDB6Ydgkh29_ngm0RFNh8IIJcuMQXZYi1zdCNUxu
 9BHViPq41yTxbb7bnePTiciP6h3bl1mJGmOtX2bA8QuaYT7TBTBBTuFBravw-
X-Sonic-MF: <m.seker@aol.com>
X-Sonic-ID: 17ab4107-ea1a-4f4f-8da2-9ab3f2a88c21
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Nov 2026 23:43:42 +0000
Received: by hermes--production-ir2-7c4859dc89-5jcb7 (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 3b8f81a9f960c94d9317978dc48cbc1f; 
 Tue, 24 Nov 2026 23:43:38 +0000 (UTC)
From: Murat Seker <m.seker@aol.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2] accel/tcg: Skip clean MMU modes when resetting TLB dirty
 flags
Date: Tue, 24 Nov 2026 23:43:29 +0000
Message-ID: <20261124234329.20579-1-m.seker@aol.com>
X-Mailer: git-send-email 2.53.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20261124234329.20579-1-m.seker.ref@aol.com>
Received-SPF: pass client-ip=66.163.188.206; envelope-from=m.seker@aol.com;
 helo=sonic311-25.consmr.mail.ne1.yahoo.com
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

tlb_reset_dirty() is called for every vCPU from
tlb_reset_dirty_range_all() whenever a RAM dirty range is cleared
(e.g. for migration, display updates and code page tracking). It
walks the main and victim TLBs of all NB_MMU_MODES, even modes that
are known to be empty, and does so while holding the TLB lock.

cpu->neg.tlb.c.dirty already tracks which MMU modes may hold entries:
the bit for a mode is set in tlb_set_page_full() before an entry is
installed, and is only cleared in tlb_flush_by_mmuidx_async_work()
when that mode is flushed. A clear bit therefore guarantees that the
mode's TLBs contain no valid entries, so there is nothing to reset.

Skip MMU modes whose bit is clear in c.dirty. A plain bit test is
used rather than iterating with ctz32(), so hosts without a native
count-trailing-zeros instruction do not pay for it; the per-mode
check is negligible next to the TLB walk it avoids.

Signed-off-by: Murat Seker <m.seker@aol.com>
---
v2:
- Use a plain bit test on c.dirty instead of iterating the set bits
  with ctz32(), which avoids the cost on hosts without a ctz
  instruction (e.g. riscv without Zbb) (Richard)
- Expand the commit message to explain why a clean bit implies an
  empty TLB
- Timing, edk2 boot on aarch64 virt -cpu max (TCG), total time in
  tlb_reset_dirty() per boot, base -> v2: 10.2 ms -> 0.53 ms at
  -smp 4, 261 ms -> 1.6 ms at -smp 100, 1.56 s -> 6.6 ms at -smp 512
  (parked secondaries, so best case; details in reply to v1)

v1: https://lore.kernel.org/qemu-devel/20261102022732.2418106-1-muratseker@meta.com/

 accel/tcg/cputlb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d79eae58df..5b10eb0175 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -883,15 +883,25 @@ static inline void copy_tlb_helper_locked(CPUTLBEntry *d, const CPUTLBEntry *s)
  */
 void tlb_reset_dirty(CPUState *cpu, uintptr_t start, uintptr_t length)
 {
+    MMUIdxMap dirty;
     int mmu_idx;
 
     qemu_spin_lock(&cpu->neg.tlb.c.lock);
+    dirty = cpu->neg.tlb.c.dirty;
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
         CPUTLBDescFast *fast = cpu_tlb_fast(cpu, mmu_idx);
         unsigned int n = tlb_n_entries(fast);
         unsigned int i;
 
+        /*
+         * An mmu_idx that is clean in c.dirty has been flushed since it
+         * last had an entry installed, so there is nothing to reset.
+         */
+        if (!(dirty & (1 << mmu_idx))) {
+            continue;
+        }
+
         for (i = 0; i < n; i++) {
             tlb_reset_dirty_range_locked(&desc->fulltlb[i], &fast->table[i],
                                          start, length);
-- 
2.53.1-Meta


