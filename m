Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA48F606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qM/HzqXv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUOSz-0002wq-JO; Fri, 20 Nov 2026 08:15:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andy0x48@linux.ibm.com>)
 id 1xUOSl-0002uu-Ew; Fri, 20 Nov 2026 08:15:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andy0x48@linux.ibm.com>)
 id 1xUOSg-00046t-JA; Fri, 20 Nov 2026 08:15:33 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKAuL5G1668991; Fri, 20 Nov 2026 13:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Wk6QtMNknFEaU2lZh
 brZK6PUOC65034QGN8Chz/f848=; b=qM/HzqXvFuM/ZqtsmCyeVTEouDcTxq/Eq
 KtC39lOZ3sNrkTn0MDjdIHpt4W3W12vfsnbTK5RGLdUIgLj+IJwwSafwF38rhEpU
 wQkPRkOVnRgI6sHw5SZzH18PNSp6CjK2I1x799iwY7QuDVWTngAk+T982NYdjpaO
 SMWKIh3KPlklD1cRuj/eZNIfVLl37HXFZRVglGWP3IAZPS2wkAcUNSMrdzLc5bET
 P5UcmGf82COoVDuQa2PIFMneutQP+pOzAUK1pPWh6TrH3cefE0s/CaUZwwK744N8
 QVaO4JvtrlTGU/uMQOzxiGRifzI4e3CTt6HuMHNsnuEx5Bzz7vf7Q==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105w850m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 13:15:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKAnvAf2162672; Fri, 20 Nov 2026 13:15:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1m3j29hf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 13:15:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AKDF8is14156182
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Nov 2026 13:15:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E71472005A;
 Fri, 20 Nov 2026 13:15:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 798532004D;
 Fri, 20 Nov 2026 13:15:07 +0000 (GMT)
Received: from work.ibm.com (unknown [9.111.34.217])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Nov 2026 13:15:07 +0000 (GMT)
From: Andrew Holden <andy0x48@linux.ibm.com>
To: qemu-devel@nongnu.org, iii@linux.ibm.com, freude@linux.ibm.com
Cc: qemu-s390x@nongnu.org, richard.henderson@linaro.org, david@kernel.org,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 Andrew Holden <andy0x48@linux.ibm.com>
Subject: [PATCH v2 2/3] target/s390x/tcg: update regs and IV/tweak per block
 in CPACF AES/PAES
Date: Fri, 20 Nov 2026 13:14:42 +0000
Message-ID: <20261120131443.61606-3-andy0x48@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120131443.61606-1-andy0x48@linux.ibm.com>
References: <20261120131443.61606-1-andy0x48@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S2GqVgMRIdJF3XkH-zG96q4iAXOrdXCX
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6b0047e0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=8kP0jNnc-mz-zY42ekAA:9
X-Proofpoint-ORIG-GUID: S2GqVgMRIdJF3XkH-zG96q4iAXOrdXCX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1MSBTYWx0ZWRfX7faP4KexJvwZ
 ysDOr+Yv6dkIHVDvQXsvLNGX+hJduiT5VDILZlKb6c3/bi395mThJgjy88cJq4P9QqHzXESsj/S
 pzbv1ewqJOyaXy+wc+xULNu6o75yo7E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1MSBTYWx0ZWRfXzzMU1P+2DMvR
 f2qX0pS1ZklDExCkkrsgwUA3sNbNQGedIihb1qCnzXTXqUDSNtWm9G5iTy8+x9H9gsDQKwHWckF
 +nr9cvd2h4CaegM/lWg4uXMpV4selwr5LrdugzLyYWTZ0oEU6EPc5xfyTZem6InOL9zNx+BXoGa
 XQAtUAPrVbllHMUhWVZ+PAYr5a9gt/1vPpv4IZGmmnTwTGkGvFU8AaA0fY8jX59dhVG1YNYFObC
 bgm0eOzWFiEih1g++9GV6IqM4pUKwtl/mnxwDFJ4k0gZP9XmLlTBwQuInLv+s+TmxpPd0UKq49p
 RXmwiQw5bWtTvxlceAD78TUDIzYFSLZppw/rW3IIxQ1FFuE19+CdiZOG9E909K4iwB5Lu86pIms
 fgJ8mXE8bvwlg4XxwPHHQEydki7nOIPJIxXV+4L2KzV7YV4pO4xLNqwrq+/mqmUoUEsIPFfUc+O
 5dlSqqujG3/0uwPkhsQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200051
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=andy0x48@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The CPACF AES and PAES helpers (ECB, CBC, CTR, and XTS) updated the guest
registers, and the CBC IV and XTS tweak, only after the whole block
loop. A guest fault unwinds out of the helper, so the registers kept
their start-of-instruction values, with the instruction having
restarted at the first block instead of resuming after the last
completed block, as expected regarding PoP. A block crossing a page
boundary could also be partly written before the fault.

Probe the source, destination, and IV/tweak of each block with
access_prepare() before any data is written, then update the registers
last, a fault leaves the block untouched and a re-invocation would
redo this. aes_read_block() and aes_write_block() do all the copying
for each mode. Addresses are wrapped per block.

The IV/tweak write is probed first but it is not atomic with the data
write. It's unlikely a fault happens between the data store and
IV/tweak, but it could happen due to a specific thread unmapping, page
change, etc., and only matters when source and destination overlap.

Signed-off-by: Andrew Holden <andy0x48@linux.ibm.com>
---
 target/s390x/tcg/cpacf_aes.c | 380 ++++++++++++++++++++++++-----------
 1 file changed, 259 insertions(+), 121 deletions(-)

diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 92884c4120..117d43040b 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -12,6 +12,7 @@
 #include "tcg_s390x.h"
 #include "accel/tcg/cpu-ldst-common.h"
 #include "accel/tcg/cpu-mmu-index.h"
+#include "accel/tcg/helper-retaddr.h"
 #include "crypto/aes.h"
 #include "crypto/aes-helpers.h"
 #include "target/s390x/tcg/cpacf-arch.h"
@@ -19,23 +20,40 @@
 #include "target/s390x/tcg/crypto_helper.h"
 
 /*
- * read exactly one AES block from guest memory into a local buffer
+ * probe one AES block at guest address, which is wrapped according to current
+ * addressing mode, since access_prepare() only wraps second page.
  */
-static inline void aes_read_block(CPUS390XState *env, const int mmu_idx,
-                                  const uintptr_t ra, uint64_t guest_addr,
-                                  uint8_t *buf)
+static inline void aes_prepare_block(CPUS390XState *env, const int mmu_idx,
+                                     const uintptr_t ra, S390Access *acc,
+                                     uint64_t addr, MMUAccessType type)
 {
-    read_guest_wrap_u8(env, mmu_idx, ra, guest_addr, buf, AES_BLOCK_SIZE);
+    uint64_t waddr;
+    waddr = wrap_address(env, addr);
+    access_prepare(acc, env, waddr, AES_BLOCK_SIZE, type, mmu_idx, ra);
 }
 
 /*
- * write exactly one AES block from local buffer to guest memory
+ * read exactly one AES block from a prepared access into a local buffer.
  */
-static void aes_write_block(CPUS390XState *env, const int mmu_idx,
-                            const uintptr_t ra, uint64_t guest_addr,
-                            uint8_t *buf)
+static inline void aes_read_block(CPUS390XState *env, const uintptr_t ra,
+                                  S390Access *acc, uint8_t *buf)
 {
-    write_guest_wrap_u8(env, mmu_idx, ra, guest_addr, buf, AES_BLOCK_SIZE);
+    /* gather block */
+    for (int i = 0; i < AES_BLOCK_SIZE; i++) {
+        buf[i] = access_get_byte(env, acc, i, ra);
+    }
+}
+
+/*
+ * write exactly one AES block from a local buffer to a prepared access.
+ */
+static inline void aes_write_block(CPUS390XState *env, const uintptr_t ra,
+                                   S390Access *acc, uint8_t *buf)
+{
+    /* scatter block */
+    for (int i = 0; i < AES_BLOCK_SIZE; i++) {
+        access_set_byte(env, acc, i, buf[i], ra);
+    }
 }
 
 /*
@@ -62,8 +80,9 @@ int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
-    uint64_t len = *src_len_reg, done = 0;
     int i, keysize, addr_reg_size;
+    uint64_t len = *src_len_reg;
+    S390Access srca, dsta;
     uint8_t key[32];
     AES_KEY exkey;
 
@@ -116,23 +135,37 @@ int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     /* process up to MAX_BLOCKS_PER_RUN aes blocks */
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
-        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
+        /* probe source and destination access */
+        aes_prepare_block(env, mmu_idx, ra, &srca, *src_ptr_reg,
+                          MMU_DATA_LOAD);
+        aes_prepare_block(env, mmu_idx, ra, &dsta, *dst_ptr_reg,
+                          MMU_DATA_STORE);
+
+        /*
+         * linux-user: the accessors below use host pointers. Record ra so a
+         * fault from a racing unmap of the probed page is unwound correctly.
+         */
+        set_helper_retaddr(ra);
+
+        aes_read_block(env, ra, &srca, in);
         if (mod) {
             AES_decrypt(in, out, &exkey);
         } else {
             AES_encrypt(in, out, &exkey);
         }
-        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
+        aes_write_block(env, ra, &dsta, out);
+
+        clear_helper_retaddr();
+
+        /* update registers at end of each iteration */
+        *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
+                                 *src_ptr_reg + AES_BLOCK_SIZE);
+        *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
+                                 *dst_ptr_reg + AES_BLOCK_SIZE);
+        *src_len_reg -= AES_BLOCK_SIZE;
         len -= AES_BLOCK_SIZE;
-        done += AES_BLOCK_SIZE;
     }
 
-    *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
-                             *src_ptr_reg + done);
-    *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
-                             *dst_ptr_reg + done);
-    *src_len_reg -= done;
-
     return !len ? 0 : 3;
 }
 
@@ -143,9 +176,10 @@ int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
-    uint64_t len = *src_len_reg, done = 0;
     uint8_t key[32], iv[AES_BLOCK_SIZE];
     int i, keysize, addr_reg_size;
+    uint64_t len = *src_len_reg;
+    S390Access srca, dsta, iva;
     AES_KEY exkey;
 
     g_assert(type == S390_FEAT_TYPE_KMC);
@@ -202,7 +236,21 @@ int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     /* process up to MAX_BLOCKS_PER_RUN aes blocks */
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
-        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
+        /* probe source, destination, and iv access */
+        aes_prepare_block(env, mmu_idx, ra, &srca, *src_ptr_reg,
+                          MMU_DATA_LOAD);
+        aes_prepare_block(env, mmu_idx, ra, &dsta, *dst_ptr_reg,
+                          MMU_DATA_STORE);
+        aes_prepare_block(env, mmu_idx, ra, &iva, param_addr,
+                          MMU_DATA_STORE);
+
+        /*
+         * linux-user: the accessors below use host pointers. Record ra so a
+         * fault from a racing unmap of the probed page is unwound correctly.
+         */
+        set_helper_retaddr(ra);
+
+        aes_read_block(env, ra, &srca, in);
         if (mod) {
             /* decrypt in => out */
             AES_cbc_decrypt(in, out, iv, &exkey);
@@ -210,20 +258,22 @@ int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
             /* encrypt in => out */
             AES_cbc_encrypt(in, out, iv, &exkey);
         }
-        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
+        /* scatter block to destination */
+        aes_write_block(env, ra, &dsta, out);
+        /* write back running iv */
+        aes_write_block(env, ra, &iva, iv);
+
+        clear_helper_retaddr();
+
+        /* update registers at end of each iteration */
+        *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
+                                 *src_ptr_reg + AES_BLOCK_SIZE);
+        *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
+                                 *dst_ptr_reg + AES_BLOCK_SIZE);
+        *src_len_reg -= AES_BLOCK_SIZE;
         len -= AES_BLOCK_SIZE;
-        done += AES_BLOCK_SIZE;
     }
 
-    /* update iv in param block */
-    write_guest_wrap_u8(env, mmu_idx, ra, param_addr, iv, AES_BLOCK_SIZE);
-
-    *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
-                             *src_ptr_reg + done);
-    *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
-                             *dst_ptr_reg + done);
-    *src_len_reg -= done;
-
     return !len ? 0 : 3;
 }
 
@@ -235,9 +285,10 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
-    uint64_t len = *src_len_reg, done = 0;
     uint8_t ctr[AES_BLOCK_SIZE], key[32];
     int i, keysize, addr_reg_size;
+    uint64_t len = *src_len_reg;
+    S390Access srca, dsta, ctra;
     AES_KEY exkey;
 
     g_assert(type == S390_FEAT_TYPE_KMCTR);
@@ -286,26 +337,39 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     /* process up to MAX_BLOCKS_PER_RUN aes blocks */
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
-        /* read in nonce/ctr => ctr */
-        aes_read_block(env, mmu_idx, ra, *ctr_ptr_reg + done, ctr);
-        /* read in one block of input data => in */
-        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
+        /* probe source, counter, and destination access */
+        aes_prepare_block(env, mmu_idx, ra, &srca, *src_ptr_reg,
+                          MMU_DATA_LOAD);
+        aes_prepare_block(env, mmu_idx, ra, &ctra, *ctr_ptr_reg,
+                          MMU_DATA_LOAD);
+        aes_prepare_block(env, mmu_idx, ra, &dsta, *dst_ptr_reg,
+                          MMU_DATA_STORE);
+
+        /*
+         * linux-user: the accessors below use host pointers. Record ra so a
+         * fault from a racing unmap of the probed page is unwound correctly.
+         */
+        set_helper_retaddr(ra);
+
+        aes_read_block(env, ra, &srca, in);
+        aes_read_block(env, ra, &ctra, ctr);
         /* encrypt ctr and xor with in => out */
         AES_ctr_encrypt(in, out, ctr, &exkey);
-        /* write out the processed block */
-        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
+        aes_write_block(env, ra, &dsta, out);
+
+        clear_helper_retaddr();
+
+        /* update registers at end of each iteration */
+        *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
+                                 *src_ptr_reg + AES_BLOCK_SIZE);
+        *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
+                                 *dst_ptr_reg + AES_BLOCK_SIZE);
+        *ctr_ptr_reg = deposit64(*ctr_ptr_reg, 0, addr_reg_size,
+                                 *ctr_ptr_reg + AES_BLOCK_SIZE);
+        *src_len_reg -= AES_BLOCK_SIZE;
         len -= AES_BLOCK_SIZE;
-        done += AES_BLOCK_SIZE;
     }
 
-    *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
-                             *src_ptr_reg + done);
-    *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
-                             *dst_ptr_reg + done);
-    *ctr_ptr_reg = deposit64(*ctr_ptr_reg, 0, addr_reg_size,
-                             *ctr_ptr_reg + done);
-    *src_len_reg -= done;
-
     return !len ? 0 : 3;
 }
 
@@ -369,9 +433,10 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
-    uint64_t len = *src_len_reg, done = 0;
     uint8_t key[32], tweak[AES_BLOCK_SIZE];
+    S390Access srca, dsta, tweaka;
     int i, keysize, addr_reg_size;
+    uint64_t len = *src_len_reg;
     AES_KEY exkey;
 
     g_assert(type == S390_FEAT_TYPE_KM);
@@ -425,8 +490,21 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     /* process up to MAX_BLOCKS_PER_RUN aes blocks */
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
-        /* fetch one AES block into in  */
-        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
+        /* probe source, destination, and tweak access */
+        aes_prepare_block(env, mmu_idx, ra, &srca, *src_ptr_reg,
+                          MMU_DATA_LOAD);
+        aes_prepare_block(env, mmu_idx, ra, &dsta, *dst_ptr_reg,
+                          MMU_DATA_STORE);
+        aes_prepare_block(env, mmu_idx, ra, &tweaka, param_addr + keysize,
+                          MMU_DATA_STORE);
+
+        /*
+         * linux-user: the accessors below use host pointers. Record ra so a
+         * fault from a racing unmap of the probed page is unwound correctly.
+         */
+        set_helper_retaddr(ra);
+
+        aes_read_block(env, ra, &srca, in);
         if (mod) {
             /* decrypt in => out */
             AES_xts_decrypt(in, out, tweak, &exkey);
@@ -436,22 +514,22 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
         }
         /* prep tweak for next round */
         AES_xts_prep_next_tweak(tweak);
-        /* write out this processed block from out */
-        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
+        /* scatter block to destination */
+        aes_write_block(env, ra, &dsta, out);
+        /* write back running tweak */
+        aes_write_block(env, ra, &tweaka, tweak);
+
+        clear_helper_retaddr();
+
+        /* update registers at end of each iteration */
+        *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
+                                 *src_ptr_reg + AES_BLOCK_SIZE);
+        *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
+                                 *dst_ptr_reg + AES_BLOCK_SIZE);
+        *src_len_reg -= AES_BLOCK_SIZE;
         len -= AES_BLOCK_SIZE;
-        done += AES_BLOCK_SIZE;
     }
 
-    /* update tweak in param block */
-    write_guest_wrap_u8(env, mmu_idx, ra,
-                        param_addr + keysize, tweak, AES_BLOCK_SIZE);
-
-    *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
-                             *src_ptr_reg + done);
-    *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
-                             *dst_ptr_reg + done);
-    *src_len_reg -= done;
-
     return !len ? 0 : 3;
 }
 
@@ -537,9 +615,10 @@ int cpacf_paes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
-    uint64_t len = *src_len_reg, done = 0;
     int i, keysize, addr_reg_size;
+    uint64_t len = *src_len_reg;
     uint8_t key[32], wkvp[32];
+    S390Access srca, dsta;
     AES_KEY exkey;
 
     g_assert(type == S390_FEAT_TYPE_KM);
@@ -602,23 +681,37 @@ int cpacf_paes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     /* process up to MAX_BLOCKS_PER_RUN aes blocks */
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
-        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
+        /* probe source and destination access */
+        aes_prepare_block(env, mmu_idx, ra, &srca, *src_ptr_reg,
+                          MMU_DATA_LOAD);
+        aes_prepare_block(env, mmu_idx, ra, &dsta, *dst_ptr_reg,
+                          MMU_DATA_STORE);
+
+        /*
+         * linux-user: the accessors below use host pointers. Record ra so a
+         * fault from a racing unmap of the probed page is unwound correctly.
+         */
+        set_helper_retaddr(ra);
+
+        aes_read_block(env, ra, &srca, in);
         if (mod) {
             AES_decrypt(in, out, &exkey);
         } else {
             AES_encrypt(in, out, &exkey);
         }
-        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
+        aes_write_block(env, ra, &dsta, out);
+
+        clear_helper_retaddr();
+
+        /* update registers at end of each iteration */
+        *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
+                                 *src_ptr_reg + AES_BLOCK_SIZE);
+        *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
+                                 *dst_ptr_reg + AES_BLOCK_SIZE);
+        *src_len_reg -= AES_BLOCK_SIZE;
         len -= AES_BLOCK_SIZE;
-        done += AES_BLOCK_SIZE;
     }
 
-    *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
-                             *src_ptr_reg + done);
-    *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
-                             *dst_ptr_reg + done);
-    *src_len_reg -= done;
-
     return !len ? 0 : 3;
 }
 
@@ -630,8 +723,9 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
     uint8_t key[32], wkvp[32], iv[AES_BLOCK_SIZE];
-    uint64_t len = *src_len_reg, done = 0;
     int i, keysize, addr_reg_size;
+    uint64_t len = *src_len_reg;
+    S390Access srca, dsta, iva;
     AES_KEY exkey;
 
     g_assert(type == S390_FEAT_TYPE_KMC);
@@ -699,7 +793,21 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     /* process up to MAX_BLOCKS_PER_RUN aes blocks */
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
-        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
+        /* probe source, destination, and iv access */
+        aes_prepare_block(env, mmu_idx, ra, &srca, *src_ptr_reg,
+                          MMU_DATA_LOAD);
+        aes_prepare_block(env, mmu_idx, ra, &dsta, *dst_ptr_reg,
+                          MMU_DATA_STORE);
+        aes_prepare_block(env, mmu_idx, ra, &iva, param_addr,
+                          MMU_DATA_STORE);
+
+        /*
+         * linux-user: the accessors below use host pointers. Record ra so a
+         * fault from a racing unmap of the probed page is unwound correctly.
+         */
+        set_helper_retaddr(ra);
+
+        aes_read_block(env, ra, &srca, in);
         if (mod) {
             /* decrypt in => out */
             AES_cbc_decrypt(in, out, iv, &exkey);
@@ -707,20 +815,22 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
             /* encrypt in => out */
             AES_cbc_encrypt(in, out, iv, &exkey);
         }
-        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
+        /* scatter block to destination */
+        aes_write_block(env, ra, &dsta, out);
+        /* write back running iv */
+        aes_write_block(env, ra, &iva, iv);
+
+        clear_helper_retaddr();
+
+        /* update registers at end of each iteration */
+        *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
+                                 *src_ptr_reg + AES_BLOCK_SIZE);
+        *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
+                                 *dst_ptr_reg + AES_BLOCK_SIZE);
+        *src_len_reg -= AES_BLOCK_SIZE;
         len -= AES_BLOCK_SIZE;
-        done += AES_BLOCK_SIZE;
     }
 
-    /* update iv in param block */
-    write_guest_wrap_u8(env, mmu_idx, ra, param_addr, iv, AES_BLOCK_SIZE);
-
-    *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
-                             *src_ptr_reg + done);
-    *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
-                             *dst_ptr_reg + done);
-    *src_len_reg -= done;
-
     return !len ? 0 : 3;
 }
 
@@ -733,8 +843,9 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
     uint8_t ctr[AES_BLOCK_SIZE], key[32], wkvp[32];
-    uint64_t len = *src_len_reg, done = 0;
     int i, keysize, addr_reg_size;
+    uint64_t len = *src_len_reg;
+    S390Access srca, dsta, ctra;
     AES_KEY exkey;
 
     g_assert(type == S390_FEAT_TYPE_KMCTR);
@@ -793,26 +904,39 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     /* process up to MAX_BLOCKS_PER_RUN aes blocks */
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
-        /* read in nonce/ctr => ctr */
-        aes_read_block(env, mmu_idx, ra, *ctr_ptr_reg + done, ctr);
-        /* read in one block of input data => in */
-        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
+        /* probe source, counter, and destination access */
+        aes_prepare_block(env, mmu_idx, ra, &srca, *src_ptr_reg,
+                          MMU_DATA_LOAD);
+        aes_prepare_block(env, mmu_idx, ra, &ctra, *ctr_ptr_reg,
+                          MMU_DATA_LOAD);
+        aes_prepare_block(env, mmu_idx, ra, &dsta, *dst_ptr_reg,
+                          MMU_DATA_STORE);
+
+        /*
+         * linux-user: the accessors below use host pointers. Record ra so a
+         * fault from a racing unmap of the probed page is unwound correctly.
+         */
+        set_helper_retaddr(ra);
+
+        aes_read_block(env, ra, &srca, in);
+        aes_read_block(env, ra, &ctra, ctr);
         /* encrypt ctr and xor with in => out */
         AES_ctr_encrypt(in, out, ctr, &exkey);
-        /* write out the processed block */
-        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
+        aes_write_block(env, ra, &dsta, out);
+
+        clear_helper_retaddr();
+
+        /* update registers at end of each iteration */
+        *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
+                                 *src_ptr_reg + AES_BLOCK_SIZE);
+        *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
+                                 *dst_ptr_reg + AES_BLOCK_SIZE);
+        *ctr_ptr_reg = deposit64(*ctr_ptr_reg, 0, addr_reg_size,
+                                 *ctr_ptr_reg + AES_BLOCK_SIZE);
+        *src_len_reg -= AES_BLOCK_SIZE;
         len -= AES_BLOCK_SIZE;
-        done += AES_BLOCK_SIZE;
     }
 
-    *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
-                             *src_ptr_reg + done);
-    *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
-                             *dst_ptr_reg + done);
-    *ctr_ptr_reg = deposit64(*ctr_ptr_reg, 0, addr_reg_size,
-                             *ctr_ptr_reg + done);
-    *src_len_reg -= done;
-
     return !len ? 0 : 3;
 }
 
@@ -888,8 +1012,9 @@ int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
     uint8_t key[32], wkvp[32], tweak[AES_BLOCK_SIZE];
-    uint64_t len = *src_len_reg, done = 0;
+    S390Access srca, dsta, tweaka;
     int i, keysize, addr_reg_size;
+    uint64_t len = *src_len_reg;
     AES_KEY exkey;
 
     g_assert(type == S390_FEAT_TYPE_KM);
@@ -954,8 +1079,22 @@ int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     /* process up to MAX_BLOCKS_PER_RUN aes blocks */
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
-        /* fetch one AES block into in */
-        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
+        /* probe source, destination, and tweak access */
+        aes_prepare_block(env, mmu_idx, ra, &srca, *src_ptr_reg,
+                          MMU_DATA_LOAD);
+        aes_prepare_block(env, mmu_idx, ra, &dsta, *dst_ptr_reg,
+                          MMU_DATA_STORE);
+        aes_prepare_block(env, mmu_idx, ra, &tweaka,
+                          param_addr + keysize + sizeof(wkvp),
+                          MMU_DATA_STORE);
+
+        /*
+         * linux-user: the accessors below use host pointers. Record ra so a
+         * fault from a racing unmap of the probed page is unwound correctly.
+         */
+        set_helper_retaddr(ra);
+
+        aes_read_block(env, ra, &srca, in);
         if (mod) {
             /* decrypt in => out */
             AES_xts_decrypt(in, out, tweak, &exkey);
@@ -965,22 +1104,21 @@ int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
         }
         /* prep tweak for next round */
         AES_xts_prep_next_tweak(tweak);
-        /* write out this processed block from out */
-        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
+        /* scatter block to destination */
+        aes_write_block(env, ra, &dsta, out);
+        /* write back running tweak */
+        aes_write_block(env, ra, &tweaka, tweak);
+
+        clear_helper_retaddr();
+
+        /* update registers at end of each iteration */
+        *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
+                                 *src_ptr_reg + AES_BLOCK_SIZE);
+        *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
+                                 *dst_ptr_reg + AES_BLOCK_SIZE);
+        *src_len_reg -= AES_BLOCK_SIZE;
         len -= AES_BLOCK_SIZE;
-        done += AES_BLOCK_SIZE;
     }
 
-    /* update tweak in param block */
-    write_guest_wrap_u8(env, mmu_idx, ra,
-                        param_addr + keysize + sizeof(wkvp),
-                        tweak, AES_BLOCK_SIZE);
-
-    *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
-                             *src_ptr_reg + done);
-    *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
-                             *dst_ptr_reg + done);
-    *src_len_reg -= done;
-
     return !len ? 0 : 3;
 }
-- 
2.56.0


