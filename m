Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9545DC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wySiC-0005V8-Lb; Mon, 24 Aug 2026 07:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySi9-0005GJ-WA
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:19:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySi6-0005rQ-3N
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:19:29 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O99A8N2547845
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IZopBdEIfltoxSJ9HcEtNlFRgPrUC6DgWERd48LIieo=; b=nT9qiB8GP0bNGLfq
 Y4EkJfBtwBZS7Dzsiso37MzygfxMTd8szCt3zvvh9YgMpKDCun2yjn2TMqNnMHJD
 w1EMGUU/QwLy40jDKyLlEtxkBWyDuejEl5KHY+Y3Uzfz1OWpY4rgACrPy1ri+fWI
 9BL8tIUltfUQ1OLxOuF6awaYAqDc/lueHuYf2Briud4Qvto//N8uGzhVEm3GnyQ3
 MOobyNuqqTCnUZnYP37ym0jRZ2CyOrN/oL672K+S4Nm+6tRjGTqH6yjnasEMEGCn
 KO0i/0DCwxZY4VeMGESe8FMm5VkhH5oHsXvlf3+Y7l3zLt8/qC4q6nLHTVFYAlcp
 9gnUTQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g88k7jcyn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:19:14 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5276aa86d00so37062061cf.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 04:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787570353; x=1788175153; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IZopBdEIfltoxSJ9HcEtNlFRgPrUC6DgWERd48LIieo=;
 b=EM12bdi5GjjZh0771XvIqxeIx7/nl/xc2UUQJwsrhKclU+axG+wDz2U8W+MBSMVNAs
 tOnluNsCPB2gX4HgcKaTkd8EZuqF1+fInMq2jK47yJr4+tGIYJAqicK4n/jYClAaxknV
 Xs+midyYh9JXr5drwHB5i8xDQyboESMKuVbJYowJorp+0RYm1q4qoKpn+TvtcGLJD5c9
 0FQx2AqorxgU0Z/eIKE3BUVZcxvdbsX571D1w2MLoTzgzYmGfE7plSW7GGw8Lj+b8vmb
 6Uq0yw5CAp6T+I+VsLcjr2fGNuFjA7iLbAXiYrTJRhpoyQmZYPSw7Y2QTYcBoGnwpimY
 ulGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570353; x=1788175153;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IZopBdEIfltoxSJ9HcEtNlFRgPrUC6DgWERd48LIieo=;
 b=BjaDvVLsU+DrZIKcRpYqJpUmmjDWi/8yy35ptCidyAUXuamW6zjRIHBgcS4r6Q2mWS
 /b1Nx6Zr+a/p8WlRlvufYs95O0zFqqF4D6B8NMQfUhuEnOg7sOojNRI9SlpPF0HdCUCT
 EFGe8QxZWJTGHQQ0GZ4BFNXvmr5oniluvQZMhWRk4IvN3G9WsyJhrjUQNlbaEdYNcXqY
 gMllw9ED1RfqaXnWB0fK8vTHU8YvOlEQB7K0uflxF6T87AltxQ2uSZpMy2uHvjYsBeUS
 ZSE253HB0R5Xb9KXvJBMTz/J5Oc2dqQwKvvpK07gdYAMnxi9HvMl4Jfs21AQb6IM9RMi
 ApxA==
X-Gm-Message-State: AFuF++lfA8ANwgy7RU0qHMwGVjIqn98p4WI3Xq8J3xfUN/HCZBmeqHBL
 dX7ZIm961UZxdbqQgX/Km34wXBRswAsBOcpfo/lL2cnoGA+JdpV87pocihqiU9dRwDwZ0Hl1D1n
 9MsVzonsHj3uXzTxuK5XXL+b8icW+MxslbXkybUZFcZseY32ZNB4wiO9d2TyUGxD/zQ==
X-Gm-Gg: AR+sD11+MW+/HQ7hun6KPStt1H4oLZkA/pup3K1t+BWX6Y3Mmo1J3wO/OtKhQqE6H19
 DsgRYnmbcfdPFrjmnfdOBbdV4Zo2AAGsrjus+sikPr4bigYxOFjbLV0atxgHf/1xfRx20lOeKPY
 bDy5pfyNepnwuNLjr5WcPfOq84AsFuDZH9JcxQS0K6XkS9rBW5dpmd29wUv8gZNJANww/+Q16br
 jIsPxQtnybg4Ll6RFhgmqEuaCmkJhcbIn0J68HwZ2gDLGfWFHlUTqAd02mY8eGJLnqmdfeEeWXQ
 ToQDpy90ouVhmP9gvydcrrrlM/pdC/YDJmS9GYEsp80A4GxDSZ399qiLQjQBrCxAckSKWMDo7uW
 JRxYFS/qIoaleb121gO3UehuDgYSvP7GiP2RBcs5Hlre1JGU8Jw==
X-Received: by 2002:a05:622a:1485:b0:52d:c1a:797a with SMTP id
 d75a77b69052e-52df56e48f6mr266151011cf.8.1787570353300; 
 Mon, 24 Aug 2026 04:19:13 -0700 (PDT)
X-Received: by 2002:a05:622a:1485:b0:52d:c1a:797a with SMTP id
 d75a77b69052e-52df56e48f6mr266150251cf.8.1787570352715; 
 Mon, 24 Aug 2026 04:19:12 -0700 (PDT)
Received: from localhost.localdomain (44.170.88.92.rev.sfr.net. [92.88.170.44])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f6b48sm1236666666b.33.2026.08.24.04.19.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Aug 2026 04:19:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v4 11/20] target/loongarch: Constify CPULoongArchState for
 various tlb_*() getters
Date: Mon, 24 Aug 2026 13:17:00 +0200
Message-ID: <20260824111711.26297-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824111711.26297-1-philmd@oss.qualcomm.com>
References: <20260824111711.26297-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=b4iCJNGx c=1 sm=1 tr=0 ts=6a8c28b2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=s1NLoHz9uzatdv2VNqxUSg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=L0vIak-SsUda2jp7rVUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfXxTwn+9TykMtt
 ByLz59q4IV+s2VMlQLGpNzW0FS1BM+scAL61Pv8jhDzZpSc4gzq8Vv1BGNOtz9N72oP8ArfT6MD
 THI00VDNqc1iMciKyZm4MhcnDL632+8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX51ddiT2P/buz
 aJkpJX4HonGa49RBa8ZAfy+khV8tcpeiFFY8YH3UBDcKujuBUmgmsuANmKi6kKRksCgaCurv2lN
 CA+hgwUc3ieDL3fWC+1NBq8WEipRgLk1uP12rln5E1RADVzw3gn/gQOy3ovAuUdMoet5npxlZen
 UuvK9Hz/DtfDphVbvm+ix06bMeHh5fLySQiJLEPR42Yw8dokNNmOFuoM+GsW+hhYUZJFMq5E4N6
 Ln+quTVx8otVFNe6uz/y1yteFco6uCNQoPVVwe9XffNSuiwRz6S0Kgg9dS7pYcNWc/l+iJBlnqt
 4VA0eQUq7FoIjGa+tObxTY881pVO5tw/wS85boasWdwS7eviEaFm+jstP0YT9xqnH/QT2GlL+3E
 g3S1PuHNA1wKHBQXJBdRxPaUJJun2ELQ92/OR9BQ7mwzwSVTPejrGZeK00GPcphW3oXbm0pEoAj
 jtgW6OnkATwjGL552jA==
X-Proofpoint-ORIG-GUID: E8tjBHcaArdu9AlLpBop6G0E_lQwBu0R
X-Proofpoint-GUID: E8tjBHcaArdu9AlLpBop6G0E_lQwBu0R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240094
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Add the const qualifier to CPULoongArchState when
the argument is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/loongarch/cpu-mmu.h           | 20 ++++++++++----------
 target/loongarch/tcg/tcg_loongarch.h |  2 +-
 target/loongarch/cpu_helper.c        | 20 ++++++++++----------
 target/loongarch/tcg/tlb_helper.c    | 26 +++++++++++++-------------
 4 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 54fb732d62d..61b59f3d3f3 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -30,14 +30,14 @@ typedef struct MMUContext {
     uint64_t      pte_buddy[2];
 } MMUContext;
 
-static inline bool cpu_has_ptw(CPULoongArchState *env)
+static inline bool cpu_has_ptw(const CPULoongArchState *env)
 {
-    CPUSysState *sys = env_sys(env);
+    const CPUSysState *sys = env_sys(env);
 
     return !!FIELD_EX64(sys->CSR_PWCH, CSR_PWCH, HPTW_EN);
 }
 
-static inline bool pte_present(CPULoongArchState *env, uint64_t entry)
+static inline bool pte_present(const CPULoongArchState *env, uint64_t entry)
 {
     uint8_t present;
 
@@ -50,7 +50,7 @@ static inline bool pte_present(CPULoongArchState *env, uint64_t entry)
     return !!present;
 }
 
-static inline bool pte_write(CPULoongArchState *env, uint64_t entry)
+static inline bool pte_write(const CPULoongArchState *env, uint64_t entry)
 {
     uint8_t writable;
 
@@ -89,17 +89,17 @@ static inline bool pte_dirty(uint64_t entry)
     return !!FIELD_EX64(entry, TLBENTRY, D);
 }
 
-bool check_ps(CPULoongArchState *ent, uint8_t ps);
-TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
+bool check_ps(const CPULoongArchState *ent, uint8_t ps);
+TLBRet loongarch_check_pte(const CPULoongArchState *env, MMUContext *context,
                            MMUAccessType access_type, int mmu_idx);
-TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
+TLBRet get_physical_address(const CPULoongArchState *env, MMUContext *context,
                             MMUAccessType access_type, int mmu_idx,
                             int is_debug);
-TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
+TLBRet loongarch_ptw(const CPULoongArchState *env, MMUContext *context,
                      int access_type, int mmu_idx, int debug);
-void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
+void get_dir_base_width(const CPULoongArchState *env, uint64_t *dir_base,
                         uint64_t *dir_width, unsigned int level);
 hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
-uint64_t loongarch_palen_mask(CPULoongArchState *env);
+uint64_t loongarch_palen_mask(const CPULoongArchState *env);
 
 #endif  /* LOONGARCH_CPU_MMU_H */
diff --git a/target/loongarch/tcg/tcg_loongarch.h b/target/loongarch/tcg/tcg_loongarch.h
index 7fb627f2d63..0f20c60d73d 100644
--- a/target/loongarch/tcg/tcg_loongarch.h
+++ b/target/loongarch/tcg/tcg_loongarch.h
@@ -16,7 +16,7 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                             MMUAccessType access_type, int mmu_idx,
                             bool probe, uintptr_t retaddr);
 
-TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env,
+TLBRet loongarch_get_addr_from_tlb(const CPULoongArchState *env,
                                    MMUContext *context,
                                    MMUAccessType access_type, int mmu_idx);
 
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 123cad3d930..3401e7ed727 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -18,10 +18,10 @@
 #include "cpu-mmu.h"
 #include "tcg/tcg_loongarch.h"
 
-void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
+void get_dir_base_width(const CPULoongArchState *env, uint64_t *dir_base,
                         uint64_t *dir_width, unsigned int level)
 {
-    CPUSysState *sys = env_sys(env);
+    const CPUSysState *sys = env_sys(env);
 
     switch (level) {
     case 1:
@@ -48,7 +48,7 @@ void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
     }
 }
 
-TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
+TLBRet loongarch_check_pte(const CPULoongArchState *env, MMUContext *context,
                            MMUAccessType access_type, int mmu_idx)
 {
     uint64_t plv = mmu_idx;
@@ -111,7 +111,7 @@ TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
     return TLBRET_MATCH;
 }
 
-static MemTxResult loongarch_cmpxchg_phys(CPUState *cs, hwaddr phys,
+static MemTxResult loongarch_cmpxchg_phys(const CPUState *cs, hwaddr phys,
                                           uint64_t old, uint64_t new)
 {
     hwaddr addr1, l = 8;
@@ -146,11 +146,11 @@ static MemTxResult loongarch_cmpxchg_phys(CPUState *cs, hwaddr phys,
     return ret;
 }
 
-TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
+TLBRet loongarch_ptw(const CPULoongArchState *env, MMUContext *context,
                      int access_type, int mmu_idx, int debug)
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
-    CPUState *cs = env_cpu(env);
+    const CPUState *cs = env_cpu(env);
     hwaddr index = 0, phys = 0;
     uint64_t palen_mask = loongarch_palen_mask(env);
     uint64_t dir_base, dir_width;
@@ -273,7 +273,7 @@ restart:
     return ret;
 }
 
-static TLBRet loongarch_map_address(CPULoongArchState *env,
+static TLBRet loongarch_map_address(const CPULoongArchState *env,
                                     MMUContext *context,
                                     MMUAccessType access_type, int mmu_idx,
                                     int is_debug)
@@ -299,7 +299,7 @@ static TLBRet loongarch_map_address(CPULoongArchState *env,
     return TLBRET_NOMATCH;
 }
 
-static hwaddr dmw_va2pa(CPULoongArchState *env, vaddr va, uint64_t dmw)
+static hwaddr dmw_va2pa(const CPULoongArchState *env, vaddr va, uint64_t dmw)
 {
     if (is_la64(env)) {
         return va & TARGET_VIRT_MASK;
@@ -310,7 +310,7 @@ static hwaddr dmw_va2pa(CPULoongArchState *env, vaddr va, uint64_t dmw)
     }
 }
 
-TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
+TLBRet get_physical_address(const CPULoongArchState *env, MMUContext *context,
                             MMUAccessType access_type, int mmu_idx,
                             int is_debug)
 {
@@ -376,7 +376,7 @@ hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
     return context.physical;
 }
 
-uint64_t loongarch_palen_mask(CPULoongArchState *env)
+uint64_t loongarch_palen_mask(const CPULoongArchState *env)
 {
     /* PALEN stores physical address bits - 1 */
     uint64_t phys_bits = FIELD_EX32(env->cpucfg[1], CPUCFG1, PALEN) + 1;
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index a4b90beca65..6194b976c36 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -35,9 +35,9 @@ static bool tlb_match_asid(bool global, int asid, int tlb_asid)
     return !global && tlb_asid == asid;
 }
 
-bool check_ps(CPULoongArchState *env, uint8_t tlb_ps)
+bool check_ps(const CPULoongArchState *env, uint8_t tlb_ps)
 {
-    CPUSysState *sys = env_sys(env);
+    const CPUSysState *sys = env_sys(env);
 
     if (tlb_ps >= 64) {
         return false;
@@ -238,11 +238,11 @@ static uint32_t get_random_tlb(uint32_t low, uint32_t high)
  * field in tlb entry contains bit[47:13], so need adjust.
  * virt_vpn = vaddr[47:13]
  */
-static LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
-                                             vaddr vaddr, int csr_asid,
-                                             tlb_match func)
+static const LoongArchTLB *
+loongarch_tlb_search_cb(const CPULoongArchState *env, vaddr vaddr,
+                        int csr_asid, tlb_match func)
 {
-    LoongArchTLB *tlb;
+    const LoongArchTLB *tlb;
     uint16_t tlb_asid, stlb_idx;
     uint8_t tlb_e, tlb_ps, stlb_ps;
     bool tlb_g;
@@ -291,12 +291,12 @@ static LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
     return NULL;
 }
 
-static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
+static bool loongarch_tlb_search(const CPULoongArchState *env, vaddr vaddr,
                                  int *index)
 {
     int csr_asid;
     tlb_match func;
-    LoongArchTLB *tlb;
+    const LoongArchTLB *tlb;
     CPUSysState *sys = env_sys(env);
 
     func = tlb_match_any;
@@ -594,7 +594,7 @@ void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
                              target_ulong addr)
 {
     int asid = info & 0x3ff;
-    LoongArchTLB *tlb;
+    const LoongArchTLB *tlb;
     tlb_match func;
 
     func = tlb_match_asid;
@@ -608,7 +608,7 @@ void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
                                   target_ulong info, target_ulong addr)
 {
     int asid = info & 0x3ff;
-    LoongArchTLB *tlb;
+    const LoongArchTLB *tlb;
     tlb_match func;
 
     func = tlb_match_any;
@@ -837,12 +837,12 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
     sys->CSR_TLBREHI = FIELD_DP64(sys->CSR_TLBREHI, CSR_TLBREHI, PS, ps);
 }
 
-static TLBRet loongarch_map_tlb_entry(CPULoongArchState *env,
+static TLBRet loongarch_map_tlb_entry(const CPULoongArchState *env,
                                       MMUContext *context,
                                       MMUAccessType access_type, int index,
                                       int mmu_idx)
 {
-    LoongArchTLB *tlb = &env->tlb[index];
+    const LoongArchTLB *tlb = &env->tlb[index];
     uint8_t tlb_ps, n;
 
     tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
@@ -853,7 +853,7 @@ static TLBRet loongarch_map_tlb_entry(CPULoongArchState *env,
     return loongarch_check_pte(env, context, access_type, mmu_idx);
 }
 
-TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env,
+TLBRet loongarch_get_addr_from_tlb(const CPULoongArchState *env,
                                    MMUContext *context,
                                    MMUAccessType access_type, int mmu_idx)
 {
-- 
2.53.0


