Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA63CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1B-0001C8-EF; Mon, 01 Sep 2025 23:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI14-0000nw-7b
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0y-0004ae-CY
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:05 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S1Fd022183
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 O1UzNssB7s6NicRpvV0+mHUnNkmSr8ufwagEpGbRzd4=; b=p2I5qRmm0Tts3dtF
 Ly9m3ZCncSV6H7hpa+JVmETwFEp6/yOR4f5fkH6n73LNbfg9HU0nIgEq3FBndQw7
 j1us/EeVp4VxV6K7QF3ra7f/zW5VLu7+ovgsLrOYSHk+itcHWD8yNGYuv57qTB6l
 8BSAeDMA/bxvNLgMKVPXUzFNSt2gsFt11DKv2it7pAp038OJm8rMFSSHV8QMO60P
 c105ST1+utB3pMwhKuG5bzA0ku5IW/vt9kGL8WbvGG2QaQ7kdAWdYCFX4zblwGA8
 qtHcOcxC0S65Y/k3sFmIoQ5brhdEcIhSXQ4JC89ozxSUHtmu0b8qNVUJWU5xq4KY
 0Mx8NQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnp6htb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:48:55 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-32993d924ddso2352773a91.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784934; x=1757389734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O1UzNssB7s6NicRpvV0+mHUnNkmSr8ufwagEpGbRzd4=;
 b=s7y37KY4dFd4QlahRpHuhuWEiS622nYbwDMGwykf8r/A+U8Z2l8B4uQLm9UIrLQbqg
 BmU/7bMWOCIsXM+FH1DFG2xGkxFBgOEr2iMfM9fSoPHPD4n5XyN/KyT4AVkMOKdyzJ+4
 2/QfWhH/ZLJ81GVolbQSmY8PPEs9oAXcwcnomsUyxqfs0YpSoHdDnFwUt3cfEi5nEmG+
 RvsZXzf+rfWqCbIS0YdyMmlRAk55OR+oJ1tv38Az4tOIxTY1eJT0Ramf0MZTYDWf1zsT
 3gqw+UnCh3rRzopKi0h17a67GlC9GNjgWu2oyxr1SlTPf1v8C/vFNIKOt4+R03+yFX/D
 jgeA==
X-Gm-Message-State: AOJu0Yyx6Syavp6GePhgI+gBrQqF8yltw0F9xj2xIC+vZrbiALoGzpc5
 iFvp7+0gv5xPflpbl9FCKMWg0CtRTUcXeD9mXLW/LTgyxpuoG/nQ68SJGoh2/z3p1zQgcBQ9p2Q
 DBeR0adUcvZFXlYWb1ge6D1riD5Y20eph1qGocuq/ojIEFWDFNHzYGlNOrhqKmNi29Y3C
X-Gm-Gg: ASbGncv+xBONwmBqyu/jFIkpYduksLJ2ji7jqicFMiMDEZ0R4XoVdPRZGdvZgzvoba2
 M700tmemM/rC5JRarUojIVsYfUokyo8Yt419j0EfGyb8fPpPhUTond9F97J1wIY2naGPi1nUfS1
 nyOadelfZQOncpclG66iWNxCZ3WHr1fZqTdLiNoNmwKY60Cs717U805u/crywa706jm22pVBW5f
 g2FOdZ/hqZykZDGzc8RCcnSMq2DKtpp98uvzIXItstQK1CNLqVZaMZyboIcyVmxAqSpMMTARjF6
 HvgPJbOEtmXii1uU9Seru5QNp0wB4iNq2R5NsL3CDNg5Gd1D5c5oTQEfqwKEIk8GzCfoG2AdLY0
 g3qdGx+MpA4m5
X-Received: by 2002:a17:90b:3e8b:b0:329:d50e:2f10 with SMTP id
 98e67ed59e1d1-329d51d739emr2510441a91.22.1756784934268; 
 Mon, 01 Sep 2025 20:48:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZc4gmHzBH5eRJe0dCYApeyLBYkIMx99Kr1745pCi4mfNF3cKiID/FUt46KOkjk1XteJpLEA==
X-Received: by 2002:a17:90b:3e8b:b0:329:d50e:2f10 with SMTP id
 98e67ed59e1d1-329d51d739emr2510399a91.22.1756784933608; 
 Mon, 01 Sep 2025 20:48:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:48:53 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 01/39] target/hexagon: Implement ciad helper
Date: Mon,  1 Sep 2025 20:48:09 -0700
Message-Id: <20250902034847.1948010-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -HNG2sakdxj8ownBxasfruFr0iiWipU9
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b66927 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=IbxGixEGliZFhfbZcJgA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: -HNG2sakdxj8ownBxasfruFr0iiWipU9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfXxUBZG9ZAs/Ga
 +kKghNjkTm9Q3o7VZr3Fhv0PJzdoeaunPiwPhDksuDQxKq8rgTNERbL6eFs9cYv9KJ8RJ9T5ilO
 OhZ8sZXt+v3148bTGWtb8eZL9oardmMFe3OyhPzMZTwfZLufQMX1Lav7keiojEb5GurXEaCBiJk
 7eRew65Kar3PYPTMCDi3fDr16xR3bRVC4R7IK6QD/PtEl+hNtG88+iu9Z39lwJsU/1e7zl3A1jT
 kCuSP58PiESzb4tUs8LNotEyFCPieYq+kcGTANxwvM4XnnJcgtJwF3WF2QQpVc7YEPFTVnimjdh
 hs4BDoqt03YihYz2Uyy4XRb8iz6DLaYgzovoEhvTn0uaovUO+EEwy6b9a1gPDF6sv7c70qSCqOE
 fQ6aES6b
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

ciad is the clear interrupt auto disable instruction.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/op_helper.c | 45 +++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index a03fd078be..c38107d5a8 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -34,6 +34,12 @@
 #include "op_helper.h"
 #include "cpu_helper.h"
 #include "translate.h"
+#ifndef CONFIG_USER_ONLY
+#include "hw/hexagon/hexagon_globalreg.h"
+#include "hex_mmu.h"
+#include "hw/intc/l2vic.h"
+#include "hex_interrupts.h"
+#endif
 
 #define SF_BIAS        127
 #define SF_MANTBITS    23
@@ -1338,9 +1344,41 @@ void HELPER(vwhist128qm)(CPUHexagonState *env, int32_t uiV)
 }
 
 #ifndef CONFIG_USER_ONLY
+static void hexagon_set_vid(CPUHexagonState *env, uint32_t offset, uint32_t val)
+{
+    g_assert((offset == L2VIC_VID_0) || (offset == L2VIC_VID_1));
+    CPUState *cs = env_cpu(env);
+    HexagonCPU *cpu = HEXAGON_CPU(cs);
+    const hwaddr pend_mem = cpu->l2vic_base_addr + offset;
+    cpu_physical_memory_write(pend_mem, &val, sizeof(val));
+}
+
+static void hexagon_clear_last_irq(CPUHexagonState *env, uint32_t offset)
+{
+    hexagon_set_vid(env, offset, L2VIC_CIAD_INSTRUCTION);
+}
+
+/*
+ * ciad - clear interrupt auto disable
+ *  - When taking an interrupt the hardware will set ipend.iad to
+ *    prevent another thread from servicing the interrupt.  At the completion
+ *    of service software uses ciad to clear the bit indicating the
+ *    interrupt can be accepted again.
+ *  - ciad also handshakes with the l2vic allowing a new vid on the vector
+ *    port.
+ */
 void HELPER(ciad)(CPUHexagonState *env, uint32_t mask)
 {
-    g_assert_not_reached();
+    uint32_t ipendad;
+    uint32_t iad;
+
+    BQL_LOCK_GUARD();
+    ipendad = READ_SREG(HEX_SREG_IPENDAD);
+    iad = fGET_FIELD(ipendad, IPENDAD_IAD);
+    fSET_FIELD(ipendad, IPENDAD_IAD, iad & ~(mask));
+    arch_set_system_reg(env, HEX_SREG_IPENDAD, ipendad);
+    hexagon_clear_last_irq(env, L2VIC_VID_0);
+    hex_interrupt_update(env);
 }
 
 void HELPER(siad)(CPUHexagonState *env, uint32_t mask)
@@ -1416,11 +1454,6 @@ static void modify_syscfg(CPUHexagonState *env, uint32_t val)
     g_assert_not_reached();
 }
 
-static void hexagon_set_vid(CPUHexagonState *env, uint32_t offset, int val)
-{
-    g_assert_not_reached();
-}
-
 static uint32_t hexagon_find_last_irq(CPUHexagonState *env, uint32_t vid)
 {
     g_assert_not_reached();
-- 
2.34.1


