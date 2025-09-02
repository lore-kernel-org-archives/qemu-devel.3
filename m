Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7723ECA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1Q-0002Tk-Qk; Mon, 01 Sep 2025 23:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1O-0002Cm-AT
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1M-0004cc-AB
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:26 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S2eF013176
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CJuOupbgdsqA+pi78Xi2O5QXXxVvLH3IJDFEIz0DsJ0=; b=J+NY3mcto9Oer37x
 dU0fJ/91GiFo27mooJolt4HNuQwL1RRpzg3bF1r6U7LrLpAEkHi9tTtNQN2RXC/2
 SiJ3CuXfZXP5jcofP09EqNmjS4uJQt3JxE+dtZN7uQxP/jtEviS9B8+ZfPTkOHmt
 8zLFEm557eXO+E9urzpHAG6kfuRN7ySMVujyIweXcg3xwBcDGcpZ+k0lPmPUKxdS
 +XbbD8N/FcFdZcLXD/xOs0CjxTlPDBTeG0CvZW+xMIrZEmgd0vV6S/X/5NeydWFT
 CMOoyZB7vPAurm56jqVziu4tcaqXph8yFUwU7yA5a1FaHdBfQMAIX9UhDG/rDFab
 DFxnVQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fea4y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:11 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-329745d6b89so4038122a91.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784951; x=1757389751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CJuOupbgdsqA+pi78Xi2O5QXXxVvLH3IJDFEIz0DsJ0=;
 b=df9OyZrKVoG8Tfi1evPYk/xjcUZtvdOuNEJqfkPgp9I2uxRorgb04mEhS6wOIQBy/f
 KDEuoD3oC3+sVO5HqEXhY+l2l32Hc8AarmjKjgFW0VIbQjlKHaUCP9+C60x5pr1iwvRw
 tbg0AzAcZWeLmjQalfhfER8zU2QWFIibhH8Jx6FVhsJic4uAMtqkvkAdLU5t3gwdJxx6
 Q3WW0CBHWwXy0E0CW3jMys3Oy9JEKy/0EHZKK42vzWlj1/dovXgIBlz4ceuJU/pgTa95
 e8l1ODrAOB3LcElvmNOQHZW5JXxSfLJX2XpK9tHJc/Y2z+MFQMpydl8MOE8W9P+GBch7
 6kpw==
X-Gm-Message-State: AOJu0YzcG9OzfTjmRRnLbZ0H9xua6rpdwSQWBK5CAc1Y/R4gLu+pugUo
 AqcIy/0L6wolihiLpa911iGgOR4ateNDL5Laim8SfQNnfBYS8AtIl+73TbSTpgIeyL+NVUCRBiv
 6CVzvD13eoEiTIQWFMVLag6ePyjNfL1g+uB0M31n2VTwzuaZlPOhoWjoA3RMd2QPWiUkP
X-Gm-Gg: ASbGncsyp+EnnH833fMRBwlOl3u6ib0Wt4dKrzXWsCdopAshhzRx04TgYEwfRMNTYL9
 vhGrSn7NMbPjrK63iLw0rCSg/DHdqZYxblUzMKk/R1HoSRXVf/XkIABlZVBZghbS+GCuNp3HinL
 jGm5t5sW/dgo1xkIpuECpaqQUpwf7AN57lasiNPsVzTybuIQw/FBK6DbG474C1YmH8eNFQHMpKz
 yHvcbEkCscEhTri+UCPTbscaNmABQH2HvWV8CZ6xYnHIEeP4PUPjj8eJoqLMu3BSm/ZR9NPECNg
 cy4+In8g0ybYz/XennFogTYiGzQHOh+uKRFBha5zQZ7mQnYBF5A1Zuo6b/kenIf/6twYqjBcXVx
 vamCoaCMLxH+u
X-Received: by 2002:a17:90b:3ec8:b0:327:9b36:87cf with SMTP id
 98e67ed59e1d1-328156e38cemr13183361a91.30.1756784950514; 
 Mon, 01 Sep 2025 20:49:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1szhJRPBpoXy65D3PDut5Rc9ySbqb/19Gxw416p87KaCnVDMZl5nAPR3apZrpCbYkD+tJPw==
X-Received: by 2002:a17:90b:3ec8:b0:327:9b36:87cf with SMTP id
 98e67ed59e1d1-328156e38cemr13183331a91.30.1756784950012; 
 Mon, 01 Sep 2025 20:49:10 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:09 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 15/39] target/hexagon: Implement hex_tlb_lookup_by_asid()
Date: Mon,  1 Sep 2025 20:48:23 -0700
Message-Id: <20250902034847.1948010-16-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfXy6pvLfngpKQ6
 Ygj60ty4SgW05NHLh1IWYGbqd16ypAYLS1pk2Y4xXSAjJAitzvqRpKi6gVIYsitmitlUy0i/Jo0
 NRYnDbRrclSAE3+dNNqwMEFjcP/vbubBtJ1ZN7IBm5FL1Dj5hh/Opl9hp6/mIsfCC1HkgeY8hLF
 x+24NOIrohBjPJRKOovqJawPk8yDINqZLaJ/v5i5RhFuxqUjtYQ5C9kdhgfz90HEOe5d7EcjYa0
 B5dqZGGpz2a22kZ/IUHEZbzTDayuqX9gwm7xpyq1GGUrkbIpKEhYqWDnOhj3BIGVpMrgw3IfgNr
 wW4awwrJVv3J530fTLbxXc7Esvg1RdPqouhI/IO2jJYKtvO6picU7Qn6H1I8+K+8n0AYm9W44ED
 CXjEUNBd
X-Proofpoint-ORIG-GUID: En4Chdkop4fT68LFpoUQGWlWocIpYndi
X-Proofpoint-GUID: En4Chdkop4fT68LFpoUQGWlWocIpYndi
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b66937 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=RILK8-s9AHSsMlXh9a0A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
 target/hexagon/hex_mmu.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/hex_mmu.c b/target/hexagon/hex_mmu.c
index 8f9f16158f..476796265b 100644
--- a/target/hexagon/hex_mmu.c
+++ b/target/hexagon/hex_mmu.c
@@ -359,7 +359,32 @@ bool hex_tlb_find_match(CPUHexagonState *env, target_ulong VA,
 static uint32_t hex_tlb_lookup_by_asid(CPUHexagonState *env, uint32_t asid,
                                        uint32_t VA)
 {
-    g_assert_not_reached();
+    uint32_t not_found = 0x80000000;
+    uint32_t idx = not_found;
+    int i;
+
+    HexagonCPU *cpu = env_archcpu(env);
+    for (i = 0; i < cpu->num_tlbs; i++) {
+        uint64_t entry = env->hex_tlb->entries[i];
+        if (hex_tlb_entry_match_noperm(entry, asid, VA)) {
+            if (idx != not_found) {
+                env->cause_code = HEX_CAUSE_IMPRECISE_MULTI_TLB_MATCH;
+                break;
+            }
+            idx = i;
+        }
+    }
+
+    if (idx == not_found) {
+        qemu_log_mask(CPU_LOG_MMU,
+                      "%s: 0x%" PRIx32 ", 0x%08" PRIx32 " => NOT FOUND\n",
+                      __func__, asid, VA);
+    } else {
+        qemu_log_mask(CPU_LOG_MMU, "%s: 0x%" PRIx32 ", 0x%08" PRIx32 " => %d\n",
+                      __func__, asid, VA, idx);
+    }
+
+    return idx;
 }
 
 /* Called from tlbp instruction */
@@ -461,7 +486,8 @@ static inline void print_thread_states(const char *str)
 
 void hex_tlb_lock(CPUHexagonState *env)
 {
-    qemu_log_mask(CPU_LOG_MMU, "hex_tlb_lock: %d\n", env->threadId);
+    qemu_log_mask(CPU_LOG_MMU, "hex_tlb_lock: " TARGET_FMT_ld "\n",
+                  env->threadId);
     BQL_LOCK_GUARD();
     g_assert((env->tlb_lock_count == 0) || (env->tlb_lock_count == 1));
 
-- 
2.34.1


