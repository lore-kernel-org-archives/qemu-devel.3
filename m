Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAB5606A326
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=anLwe6Od
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUOSh-0002tH-AO; Fri, 20 Nov 2026 08:15:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andy0x48@linux.ibm.com>)
 id 1xUOSf-0002rq-OW; Fri, 20 Nov 2026 08:15:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andy0x48@linux.ibm.com>)
 id 1xUOSd-00046a-TT; Fri, 20 Nov 2026 08:15:29 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKAu3Pc1243432; Fri, 20 Nov 2026 13:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=eW0n7pV18Hbn5BNnk
 iS+e3OOFJ5EiWvji5sVK3/2ZVE=; b=anLwe6OdykYbu+vdzPzmCkYuHIbr6Ev1z
 fna2am06UukF+Tnknh3trZylRjyOiWad0BXz5Pdkyotf7VX0X6tO2rvu/EtJkWIc
 9qyY6gghxLF6fOyd7lCTndd2n/Z0I4vnjSz5EQbTAyFO8V97BElCpKaFwKR1jR5g
 TrMg7q7oNTUGPTYPzzSetA3VLbGxW4zwLT4nJ93ayVjrCG126a7U/l6YDHdd6Vr7
 J10VNm425Tb8Dtamt7YuJvFQkzS15ZmSSC0udirSK4abYN3+1DaGDcZPjk/tdrj5
 P4o3xKClBQLDLUp3md2Isy0NZbrnSif2Sin/OP/03Uh9c2am39ggA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105s0j4x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 13:15:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKB4oYo355190; Fri, 20 Nov 2026 13:15:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j23dwdum7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 13:15:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AKDF7DO50397454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Nov 2026 13:15:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6943C20043;
 Fri, 20 Nov 2026 13:15:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01E992004B;
 Fri, 20 Nov 2026 13:15:07 +0000 (GMT)
Received: from work.ibm.com (unknown [9.111.34.217])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Nov 2026 13:15:06 +0000 (GMT)
From: Andrew Holden <andy0x48@linux.ibm.com>
To: qemu-devel@nongnu.org, iii@linux.ibm.com, freude@linux.ibm.com
Cc: qemu-s390x@nongnu.org, richard.henderson@linaro.org, david@kernel.org,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 Andrew Holden <andy0x48@linux.ibm.com>
Subject: [PATCH v2 1/3] target/s390x: export access_prepare() and byte
 accessors
Date: Fri, 20 Nov 2026 13:14:41 +0000
Message-ID: <20261120131443.61606-2-andy0x48@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120131443.61606-1-andy0x48@linux.ibm.com>
References: <20261120131443.61606-1-andy0x48@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TGtsEzm-snUrLmKJXtl9VG7V3tzDHubx
X-Authority-Analysis: v=2.4 cv=e8uT2qp/ c=1 sm=1 tr=0 ts=6b0047e0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=fzscAL0ofv0dPgwsyb0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1MSBTYWx0ZWRfXxG/obV17YwNT
 ILYMtwm1FD026N/ibluD5yAehp1rg0ySd1eYVzb/oqry3IdgbnB0Avuf/wGKhj49EXvu6TdfJ+a
 w6s4WHa/vHYBhkdeaEOXkYzigueKyy4=
X-Proofpoint-ORIG-GUID: TGtsEzm-snUrLmKJXtl9VG7V3tzDHubx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1MSBTYWx0ZWRfX3e3lKSg6TKQg
 R91lx285tOyn/Gk39KhsN1E822h7B2VPshtj94tDEa6a9uUDC4cdwlFd1ThzRgsAYmopnCKjFIX
 MVon1L7CRrP/HBz5X4vKplImEnlTLmxUSyOJq6gfQL41rRY5C41FWCd2uI/v+ZpyxUj3/pI+l+X
 95FM6c4LlfLP5NaNPl6PonpwKbBO3zDBAiuwWh3m3Zn23/F+qdu3y9r2ViC9ZDSJvtNnd+o4pEw
 Hqg/W/UVWEN50ssKc6yPjTHVq/V6r7mv2X+HvIYsfU5yfFdjn2IiTzH7TyryMMelk17ztYCLq4h
 fjjc3XjLiZiycVO402jjhEWPj71ulKE4KlO4JXoNExqpSqQpaqTrf4ggG9qE8P+QrJBAlzBrEf4
 7DdmhNaGtIu68PwDKxCofpmJa92ko615iBQ6BZBBvEm2KmJdM/WbqmgStHmC1D7Ff+Szi+yVING
 RvnRQJr2fGLNSOm2bBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200051
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=andy0x48@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

The helpers are needed by CPACF AES for a partial completion fix. There
is no functional change with this modification.

Signed-off-by: Andrew Holden <andy0x48@linux.ibm.com>
---
 target/s390x/s390x-internal.h | 25 +++++++++++++++++++++++++
 target/s390x/tcg/mem_helper.c | 33 ++++++++-------------------------
 2 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index da60b2b1fd..c97d399c99 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -368,6 +368,31 @@ void ioinst_handle_sal(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
 
 
 /* mem_helper.c */
+
+/* An access covers at most 4096 bytes and therefore at most two pages. */
+typedef struct S390Access {
+    vaddr vaddr1;
+    vaddr vaddr2;
+    void *haddr1;
+    void *haddr2;
+    uint16_t size1;
+    uint16_t size2;
+    /*
+     * If we can't access the host page directly, we'll have to do I/O access
+     * via ld/st helpers. These are internal details, so we store the
+     * mmu idx to do the access here instead of passing it around in the
+     * helpers.
+     */
+    int mmu_idx;
+} S390Access;
+
+void access_prepare(S390Access *ret, CPUS390XState *env, vaddr vaddr,
+                    int size, MMUAccessType access_type, int mmu_idx,
+                    uintptr_t ra);
+uint8_t access_get_byte(CPUS390XState *env, S390Access *access, int offset,
+                        uintptr_t ra);
+void access_set_byte(CPUS390XState *env, S390Access *access, int offset,
+                     uint8_t byte, uintptr_t ra);
 void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
                         uintptr_t ra);
 
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 414e6838c8..5144f036ad 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -126,23 +126,6 @@ static inline void cpu_stsize_data_ra(CPUS390XState *env, uint64_t addr,
     }
 }
 
-/* An access covers at most 4096 bytes and therefore at most two pages. */
-typedef struct S390Access {
-    vaddr vaddr1;
-    vaddr vaddr2;
-    void *haddr1;
-    void *haddr2;
-    uint16_t size1;
-    uint16_t size2;
-    /*
-     * If we can't access the host page directly, we'll have to do I/O access
-     * via ld/st helpers. These are internal details, so we store the
-     * mmu idx to do the access here instead of passing it around in the
-     * helpers.
-     */
-    int mmu_idx;
-} S390Access;
-
 /*
  * With nonfault=1, return the PGM_ exception that would have been injected
  * into the guest; return 0 if no exception was detected.
@@ -219,10 +202,10 @@ static int access_prepare_nf(S390Access *access, CPUS390XState *env,
     return 0;
 }
 
-static inline void access_prepare(S390Access *ret, CPUS390XState *env,
-                                  vaddr vaddr, int size,
-                                  MMUAccessType access_type, int mmu_idx,
-                                  uintptr_t ra)
+void access_prepare(S390Access *ret, CPUS390XState *env,
+                    vaddr vaddr, int size,
+                    MMUAccessType access_type, int mmu_idx,
+                    uintptr_t ra)
 {
     int exc = access_prepare_nf(ret, env, false, vaddr, size,
                                 access_type, mmu_idx, ra);
@@ -257,8 +240,8 @@ static void access_memset(CPUS390XState *env, S390Access *desta,
     clear_helper_retaddr();
 }
 
-static uint8_t access_get_byte(CPUS390XState *env, S390Access *access,
-                               int offset, uintptr_t ra)
+uint8_t access_get_byte(CPUS390XState *env, S390Access *access,
+                        int offset, uintptr_t ra)
 {
     vaddr vaddr = access->vaddr1;
     void *haddr = access->haddr1;
@@ -277,8 +260,8 @@ static uint8_t access_get_byte(CPUS390XState *env, S390Access *access,
     }
 }
 
-static void access_set_byte(CPUS390XState *env, S390Access *access,
-                            int offset, uint8_t byte, uintptr_t ra)
+void access_set_byte(CPUS390XState *env, S390Access *access,
+                     int offset, uint8_t byte, uintptr_t ra)
 {
     vaddr vaddr = access->vaddr1;
     void *haddr = access->haddr1;
-- 
2.56.0


