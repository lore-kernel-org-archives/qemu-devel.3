Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E448CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1V-0002rt-EO; Mon, 01 Sep 2025 23:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1T-0002ih-1j
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1M-0004cT-JK
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:30 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SDqN030680
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cLWFkb3nl5Au3ZR8hgsFgnwErjVodt7BKXfOhc1PsQI=; b=kNq4Z96IQAQ/S68P
 ADr8ybgSpb1mxv6vZ5zFgwIJV1m2fDggyPARkHOHqMort8e/iaba1tRR7KP1hMQl
 0teKMGOgLtk3tOTxRjZ7stQ82XP0vG8FH4Cs7aSP3cSIPI4xg3s5TKaJkWKKTsiw
 hWvO4FRbNJRIQQKv+eatJ8fEBlNUNbRzlgWmrGiaQIBECwxSYsbS/ASG6vDLEdo3
 MRIKjwPtJPC8FN0GlC9gjM3dNoXEfeKYijQN4tVNqIlZPnk+KqlKHm72SqZBox4p
 TUiBpm4QTEphqjg2kHgBnulenk2s1ulxH7F9PLPnpQrKfMLDxK8LA2rX69WMLcS+
 kPspYQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8pc2t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:11 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-324e41e946eso8954264a91.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784949; x=1757389749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cLWFkb3nl5Au3ZR8hgsFgnwErjVodt7BKXfOhc1PsQI=;
 b=D0cqX8zxYCpYn95F0tggz1AggV2Wsea4n55FWkdoaMizogWHzfP5UE4ZJH5KHRtLOi
 OMp1wQbHThZ16vtt+ob6zhoFjiJJuElEMSvNSoGeFrXAQaFoIfYOYaP2Istgt1JrETt1
 80MNj2PO1QZ2gT3YRBTwZzpLSdb5+CqK5gHwZjYCvYutNfrUAVP6ODhpZg9cUxkUpHUf
 LPHph0JZ7D20KVXHpj/BuhuO6gJjJCDmBP7Zk1y4fgf2EieTqt6B0prs7S2kOBM1ICch
 ENe4nsfuC+89/oFFVgfihv8XBEgsExCGqeD133B42r1fwylIY2LJdTS2RkfHWX66KAtU
 TwvA==
X-Gm-Message-State: AOJu0YzNK7OM5/GYF8xx3u5dqgJYL6cpxOmf5NSDCykpiMzwACh7wMH8
 VjvX+/s3aGmPyKEBDOWV1eNPjvvK9AzvuxdQ0BFaXceqm74hTtSmbN2rEFnCIejhZDFI3CRtkaO
 yYD/tY7rX3yaPIX9JftqZ/T4y4r9yP5fSy2hUo8/3ezEpvmPS4bID49PJbuEtioRyJsvn
X-Gm-Gg: ASbGncvpWGQ8RmeqOhRaSvooc5fujsPrUrvNvETlJKlAVqrwPnmNucQOTUdphyxd9xz
 +VV3PQ4zzHsxsWvOTH3fjlQr46a4N0edH0I9v+7Kxs/JQeBx4aF8YemQHaAsntFyFX3vyFc2aYE
 5ZfT6lbkRoyjcnKPDtrJGVTPUv38/C46MVD84C0KcDI7H/A9rWWz0yks85mKlN8S43jOSPecKQ1
 VhEcxEgta30z6LVfFS9mzhg0hPtP0TdcabouLo4ESRE0ZzyCAVaeyf424BA1dYbsHip3xRodlFr
 AW/TSmQ17fNSxfPQciwKPKdVQfXBb+5xOc/WRDjaUeRjLB/PkGk/9y7zZOCDbC55LfYbG3SYYTD
 dD2InmEpfxGqU
X-Received: by 2002:a17:90b:5865:b0:328:a89:3dc8 with SMTP id
 98e67ed59e1d1-3281543cc5emr13077785a91.14.1756784949463; 
 Mon, 01 Sep 2025 20:49:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH43z12HDdLvSldUaH7FrdFrn1xJIwtrCn92F+JNZqHBKkK7pLOU+BtkN6QZTNfnxiRy5QSPw==
X-Received: by 2002:a17:90b:5865:b0:328:a89:3dc8 with SMTP id
 98e67ed59e1d1-3281543cc5emr13077746a91.14.1756784948881; 
 Mon, 01 Sep 2025 20:49:08 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:08 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 14/39] target/hexagon: Implement hex_tlb_entry_get_perm()
Date: Mon,  1 Sep 2025 20:48:22 -0700
Message-Id: <20250902034847.1948010-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: EBvxuRwb8J0f-91zzYZ5k5QSOlSCkrWU
X-Proofpoint-GUID: EBvxuRwb8J0f-91zzYZ5k5QSOlSCkrWU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX/2vnmosje1rB
 Ufz5Ivn1CIRpkaqAxllvwv+qwnD1Sq1woL0ijlSiA4AlHKaav4BIw2zeWRabRmj4mxmeoA0DOgs
 xervxpHsXWudOIZdfj4XDI5eXqeWcOtMIdve8ciu8rRzV0/AIOOtyRxX+Tjft5ds2yWoFk9+/u8
 3FQ8DQ9HqbDXHzH0woPZ7a576EWnKUSocqlCNsIAiH5wT8RqqrKoBhLbRTDVjAIUymj8kIoWyQd
 FPUqFD40zCU4dgB/UBYEHzhycw7F0UT6SOmygHk21yy5g7QAKvrOWEMzr0fNaeMRVMabk/+7N8Q
 C0bHwJ9wHrAdgvxCgqYaUGZzrp0G4p1r2ISyIb2JyQeV062bKuA9MhF0MXSqC+g2Vtqp39SXt4E
 1Ioc0eDI
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b66937 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=iQLeoY74lB-_Jzq76T0A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Brian Cain <bcain@quicinc.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 linux-user/hexagon/cpu_loop.c |  7 +++++
 target/hexagon/hex_mmu.c      | 54 ++++++++++++++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index 28ad8073f6..7853819f77 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -63,6 +63,13 @@ void cpu_loop(CPUHexagonState *env)
             break;
         case HEX_EVENT_PRECISE:
             switch (env->cause_code) {
+            case HEX_CAUSE_FETCH_NO_UPAGE:
+            case HEX_CAUSE_PRIV_NO_UREAD:
+            case HEX_CAUSE_PRIV_NO_UWRITE:
+            force_sig_fault(TARGET_SIGSEGV, TARGET_SEGV_MAPERR,
+                    env->gpr[HEX_REG_PC]);
+
+            break;
             case HEX_CAUSE_PRIV_USER_NO_GINSN:
             case HEX_CAUSE_PRIV_USER_NO_SINSN:
             case HEX_CAUSE_INVALID_PACKET:
diff --git a/target/hexagon/hex_mmu.c b/target/hexagon/hex_mmu.c
index 332e7f4029..8f9f16158f 100644
--- a/target/hexagon/hex_mmu.c
+++ b/target/hexagon/hex_mmu.c
@@ -264,7 +264,59 @@ static inline void hex_tlb_entry_get_perm(CPUHexagonState *env, uint64_t entry,
                                           int mmu_idx, int *prot,
                                           int32_t *excp)
 {
-    g_assert_not_reached();
+    bool perm_x = GET_TLB_FIELD(entry, PTE_X);
+    bool perm_w = GET_TLB_FIELD(entry, PTE_W);
+    bool perm_r = GET_TLB_FIELD(entry, PTE_R);
+    bool perm_u = GET_TLB_FIELD(entry, PTE_U);
+    bool user_idx = mmu_idx == MMU_USER_IDX;
+
+    if (mmu_idx == MMU_KERNEL_IDX) {
+        *prot = PAGE_VALID | PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+        return;
+    }
+
+    *prot = PAGE_VALID;
+    switch (access_type) {
+    case MMU_INST_FETCH:
+        if (user_idx && !perm_u) {
+            *excp = HEX_EVENT_PRECISE;
+            env->cause_code = HEX_CAUSE_FETCH_NO_UPAGE;
+        } else if (!perm_x) {
+            *excp = HEX_EVENT_PRECISE;
+            env->cause_code = HEX_CAUSE_FETCH_NO_XPAGE;
+        }
+        break;
+    case MMU_DATA_LOAD:
+        if (user_idx && !perm_u) {
+            *excp = HEX_EVENT_PRECISE;
+            env->cause_code = HEX_CAUSE_PRIV_NO_UREAD;
+        } else if (!perm_r) {
+            *excp = HEX_EVENT_PRECISE;
+            env->cause_code = HEX_CAUSE_PRIV_NO_READ;
+        }
+        break;
+    case MMU_DATA_STORE:
+        if (user_idx && !perm_u) {
+            *excp = HEX_EVENT_PRECISE;
+            env->cause_code = HEX_CAUSE_PRIV_NO_UWRITE;
+        } else if (!perm_w) {
+            *excp = HEX_EVENT_PRECISE;
+            env->cause_code = HEX_CAUSE_PRIV_NO_WRITE;
+        }
+        break;
+    }
+
+    if (!user_idx || perm_u) {
+        if (perm_x) {
+            *prot |= PAGE_EXEC;
+        }
+        if (perm_r) {
+            *prot |= PAGE_READ;
+        }
+        if (perm_w) {
+            *prot |= PAGE_WRITE;
+        }
+    }
 }
 
 static inline bool hex_tlb_entry_match(CPUHexagonState *env, uint64_t entry,
-- 
2.34.1


