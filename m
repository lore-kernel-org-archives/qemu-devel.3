Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D53FCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI19-00019j-Ti; Mon, 01 Sep 2025 23:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI16-0000tD-CD
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI11-0004au-D1
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:08 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SAKF022312
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PofTRSZsHvYFxUL9lMKfqRa5j8aqhnLoF4M4s+qnqCg=; b=YRW3Eh1BGNBx4VnH
 qzYxON3I95Prc+UVwgevOVLOBHGgl0IDDhxGOVpc1ct1BgwS+GV+ZzFCIVpbvnxM
 xg+jZAtCZ2T/ckXkqjXepxK/j2bPNiiFGRDf1Ky8suzEZR0VGM9FbbFq6EPPJ5tt
 Ks3h+bKyMQ3cq275B6TdEKGf18qCeyILy3md3HPPnUPv/4Ns3ovwuu97bBJk4zdK
 BxkahWRDZkQgL/mMbM6uz4NzhvYl1VQhEtdUhdN3NWchnFJoI1+ajDTIayvekVTp
 jN3i+hBdYD+VzresqPx1so4ULO5GGVrlSEYm9A5E1IpdVIaFqa/mA44kNr8qg5OX
 nxWtDQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnp6htj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-329e375d372so273464a91.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784940; x=1757389740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PofTRSZsHvYFxUL9lMKfqRa5j8aqhnLoF4M4s+qnqCg=;
 b=B6FPGmEWAyTtMPKKgKRT08GmxrIIdDbOmbY4fvYh2OdhvT/oOjgSboobB7vulezsId
 gKePZ+erhzvgF9iOcabtqWb8Kw7VDac5OM+3oOi8qeCW3SA71i+OrezbzakapC20dby4
 jibMIEE5oI2jfLA5gnXl+GObal1+PgKOm+hlsamiErF02MSwS05TXznZCnwHdV94d5M5
 zcGMRLoUO/ibAvAHAG/e3cSN8LgzMydcyYQ4oyeuT6JZZyiGJBLAQQoQ+zyb3Lixs3ON
 D8N3Ia/dIPhGOH5lLdcWhT9/IoradO/GOUX+WCZirjx1CK17IhxkBnAM+oZBtpuHUKyG
 iz4Q==
X-Gm-Message-State: AOJu0YwoJo9x14KQHwGvGvni6CtXSIvaje2cojdFR61SKMxqqcn5vlFd
 56r/2y6+sBNT2MokjUnQVSp753fI8/YsoZe5AapMLb2JFcMau6jSSEQZ79ZbzDQ6kqsuP3e5hc5
 wsg0AzcaoK2f81yhg1Av1vnLtjyP+Vxh/zHjSD9rzDzW0Z6/+N8BKpyPEuJm72DkGAiQk
X-Gm-Gg: ASbGncvgaYxtO6L2swpfbKt+X5RGzrxsSY2JMniPayiw8EjmD4hyN7L+lyfbXmKmAd3
 s9n2OaTM46bmJEr6S8S9H4dJcST6SnVInvxrG4Tmah7+ZZetZxiH8QQs0vV+GxaqsPJiwN0xhcV
 2x2MZwWAoy5CG3I5mbjbgJgZunTsAiUbcQirkPUTrdN4Nuhx+v0couyJNOx4FGOpPAm1W9RDspI
 uCZtw0G5x06/0IPk8LJFPX3xYEaKGur8xlMxAI3t8l2/BQuuy+av2qxtf5uLGS7gsn/RssRBKyV
 ntEh9ix796BoRMDzkBoMX15Er0NALQfb8VQriVdQkDQLoa34IKJ/pSTm0qrzWEIVwqdhROF+NS9
 4AP2MXu/F7Qow
X-Received: by 2002:a17:90b:3fc3:b0:325:1548:f0f with SMTP id
 98e67ed59e1d1-32815452baamr12839616a91.14.1756784939679; 
 Mon, 01 Sep 2025 20:48:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEciG8lttR7Il0oSCn1L/jgPvAKZ663luZVy3KngvTS4I7+GaqcechRLIerFzFM+mI092inFQ==
X-Received: by 2002:a17:90b:3fc3:b0:325:1548:f0f with SMTP id
 98e67ed59e1d1-32815452baamr12839582a91.14.1756784939227; 
 Mon, 01 Sep 2025 20:48:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:48:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 06/39] target/hexagon: Implement {g,s}etimask helpers
Date: Mon,  1 Sep 2025 20:48:14 -0700
Message-Id: <20250902034847.1948010-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: H6qXL5iOZklMkw08sQeFQcymVXbNJP3T
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b6692d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=bsmiAFf9rkHB8dj5RqkA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: H6qXL5iOZklMkw08sQeFQcymVXbNJP3T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX4T4Kng6A+Jwq
 dHY4tiszbwSjQJmG77tqeChO4Jl+k3faaaiPv1bMHAcrTf55HkUs0hQijWgQOJPULehcObdwrl+
 axLwI6vlt2dtYhnyfvhI+Xv0GA1cy/8k+FTxHUxzTVAJ53GwvZoQYamSgD2Hikp9L1z7nItiT7Q
 V8lMXM9IKMQlm1ateouKB5/k7f8M974LyX+PYr+bXORNQyvoV2edJILs2hyXZOSvVnR54Kv8KAQ
 bMXp0sD/EqN06tDad1G8vVuAmzmXRNdDo0DGcR4EKZ8YIGH5whq+Liz5At0jP1TJGd1k9eFw32H
 YEi8xpnYuDi+VJWctKxvSn2TdiJ36XegF4Bki7slAEBgTKFiSDXt02kJP/IBksOtcBRRc6040uG
 En5+/scx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001
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

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/op_helper.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 4b1fc23a15..03e69421c7 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1475,12 +1475,41 @@ void HELPER(resume)(CPUHexagonState *env, uint32_t mask)
 
 uint32_t HELPER(getimask)(CPUHexagonState *env, uint32_t tid)
 {
-    g_assert_not_reached();
+    CPUState *cs;
+    CPU_FOREACH(cs) {
+        HexagonCPU *found_cpu = HEXAGON_CPU(cs);
+        CPUHexagonState *found_env = &found_cpu->env;
+        if (found_env->threadId == tid) {
+            target_ulong imask = arch_get_system_reg(found_env, HEX_SREG_IMASK);
+            qemu_log_mask(CPU_LOG_INT, "%s: tid %d imask = 0x%x\n",
+                          __func__, env->threadId,
+                          (unsigned)GET_FIELD(IMASK_MASK, imask));
+            return GET_FIELD(IMASK_MASK, imask);
+        }
+    }
+    return 0;
 }
 
 void HELPER(setimask)(CPUHexagonState *env, uint32_t pred, uint32_t imask)
 {
-    g_assert_not_reached();
+    CPUState *cs;
+
+    BQL_LOCK_GUARD();
+    CPU_FOREACH(cs) {
+        HexagonCPU *found_cpu = HEXAGON_CPU(cs);
+        CPUHexagonState *found_env = &found_cpu->env;
+
+        if (pred == found_env->threadId) {
+            SET_SYSTEM_FIELD(found_env, HEX_SREG_IMASK, IMASK_MASK, imask);
+            qemu_log_mask(CPU_LOG_INT, "%s: tid %d imask 0x%x\n",
+                          __func__, found_env->threadId, imask);
+            hex_interrupt_update(env);
+            return;
+        }
+    }
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "setimask used with an invalid predicate near PC: 0x%x\n",
+                  env->next_PC);
 }
 
 static bool handle_pmu_sreg_write(CPUHexagonState *env, uint32_t reg,
-- 
2.34.1


