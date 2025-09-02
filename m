Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C62CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1f-0003nM-DT; Mon, 01 Sep 2025 23:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1Z-0003F6-EK
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1X-0004eG-2X
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:36 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SkBj026392
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CEjTdeNUHCIqt2tlaUwa6vl9vloIiDWBPkdv12Uh/m4=; b=RaIXuI+F3/OqvpPP
 P3dqxcpz0LbWiTzkZ/eFKimQnRa46bGpcth2dUkUr/qn9XXtn9LlmqNNIkPec5fK
 ORDCNrsZd30wHFyCRJ+ISQ3qvtjp1uiNQITvjHFxxY0P7CbALIaDgKQSudZ3Vvqg
 fMu1D0U9XdfX51MGW+hBPMV26lMOxZSe++C2qeDhM6gbb5kvm8j2eypm4LgLBc/p
 L/TMpW/rcs5HZdgBdMqUjTaue1/azEojWY5VpAfgsi3sbb/r6w9IO1luCSgjVNdo
 WjLbnCkRrtGGWcbz8HS3TUHyba0gUWMjlrCqwb9/A2krCPFkibaPOAuzecuqRK+6
 j+/97Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuxeb2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:24 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-325ce108e16so7459462a91.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784963; x=1757389763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CEjTdeNUHCIqt2tlaUwa6vl9vloIiDWBPkdv12Uh/m4=;
 b=Vjaa9zTx03kFRjqvBk+3g3zjJ3WYC7dG4JhanQbN3pNF1xaUQhJnHZ8lcDM9cJbEZ5
 UrMddqi0L76f3PwGNdkTh9aZaDcEZIrIrPtlHqwKl4CPdmQlNp0juEtyLtq3j28T7RJC
 CFTi2Y6yPWZ1EfzRWumeHwE5PAtpfzRwnxlpammY9IXJ9/ApOuStBh0YWJI7eEUId43r
 X1EjD434/DB9TBu7cGgRpZhbW4kkD4n9e/pLBfJgE2fxqTGhpemd77DWiy94xo6UFB25
 cRicbLA2ZU7xQ/Gf17dXF0FUtceBGDVyuhBMaOQdTheMJG1axZSUUX+/uG+KT2OKkatz
 7O8w==
X-Gm-Message-State: AOJu0Yz7ACx099FfwfLAdmn7gepVxvLttG4k2HNZ6WgxNPhjUE1NJpvx
 3eF5y4NfeL8DrIHl5l67Bo5nAFRPhHUwudcVwzS/VuxGFUl7S5n4RquTrEJ4aGJ3ZaTM5HXkm14
 kNJs4S9ZdbajcFA1Cgxg86AMOa5i/R33e+1jd/oxbs5s2cP3fkk2CjPVkXbDMNtklJFj/
X-Gm-Gg: ASbGncuF9IGd4vspX9l79SdOwbPd6YGQPjZ32nnSR3sRxS7mxXJFSQ+GmIcO+gvgXEE
 Pe5knCTy02IHb0osaYO+3ArVD2+I/MHt6edJc/xEwoKHYhKyAo15YxYPI0g+ON28i0few4AX8rK
 8jLqcC1Vbz6E6quz6dZ+BTf8NEW7RcURvij4JXBaNvlmMU5nJFi60nMsSk/aknce4U4dnTpmvaX
 jk7CJAbnXI37MZfUtVBcXh3MyWU8zQ9VVoAozgal/jkSpjiUZr5sVvgoWea/W3kGc3X3CwFWzWT
 hdt87N9Vly+pQq5SfW5ZUxFHc5AtCC1BOBbI8909jGjsoTMepVEOw/C4O835GQMDMgujK47IU08
 j3aBQL/HDuLcR
X-Received: by 2002:a17:90b:2245:b0:329:e1ce:dc81 with SMTP id
 98e67ed59e1d1-329e1cee6abmr1605435a91.10.1756784962752; 
 Mon, 01 Sep 2025 20:49:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvQfNcmw7oShCnyOvWQ2pN6InJt89RcCo8amjzD/nTcyEpe7Q9Y9jhOoL7TY7U0zItn6xyLQ==
X-Received: by 2002:a17:90b:2245:b0:329:e1ce:dc81 with SMTP id
 98e67ed59e1d1-329e1cee6abmr1605395a91.10.1756784962187; 
 Mon, 01 Sep 2025 20:49:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:21 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 25/39] target/hexagon: extend hexagon_cpu_mmu_index() for
 sysemu
Date: Mon,  1 Sep 2025 20:48:33 -0700
Message-Id: <20250902034847.1948010-26-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfXzyDGEMtzzusN
 NvQn2iGQ5dThEzYDLHT7mpiUCrE8K/lHmhusVoRRZnPsNI8WjPEIcbSb22nYzyJQdBHoWSN9DV5
 Mx5ojHFWi3RfruUJn8+rEACIl7G3ZT/XNgeCyVUE1GttvZV5AD1VbdulMoANmPhW/hR3bDYL1st
 W1coeSqsiuGRmIJnsPS2Iiri1z5DvO7hl6ncxxSFzkfFWU2r4Rd2pILspKJoawZcGA7oZvP18Jq
 S6r8V/PsSz/r9uZYXb838c7vTw0hXPCJ6Yw/iGKe0ai29Y+eTjprjYCTRgitsybBXWzqUGKyY8k
 3rpRDxrXH0dxLRl3Rj99vFtIs2HRKvds6M+EhcIvw6T+nzrk6M3oh6seT4mEYnNLWq8hK82IfZS
 DE7F+jP9
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b66944 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=kXroxUfw0iMe_INEunMA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: eikOmmsO8vifxtTuq2lr-cA-VPnhYhVq
X-Proofpoint-GUID: eikOmmsO8vifxtTuq2lr-cA-VPnhYhVq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031
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
 target/hexagon/cpu_helper.h |  1 +
 target/hexagon/cpu.c        | 26 ++++++++++++++++++-----
 target/hexagon/cpu_helper.c | 41 +++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
index c8b0a37b7f..9f2eb27e63 100644
--- a/target/hexagon/cpu_helper.h
+++ b/target/hexagon/cpu_helper.h
@@ -15,6 +15,7 @@ void hexagon_set_sys_pcycle_count(CPUHexagonState *env, uint64_t);
 void hexagon_set_sys_pcycle_count_low(CPUHexagonState *env, uint32_t);
 void hexagon_set_sys_pcycle_count_high(CPUHexagonState *env, uint32_t);
 void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t old);
+int get_cpu_mode(CPUHexagonState *env);
 int get_exe_mode(CPUHexagonState *env);
 void clear_wait_mode(CPUHexagonState *env);
 void hexagon_ssr_set_cause(CPUHexagonState *env, uint32_t cause);
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 8afa7e55e6..6d2013ce89 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -329,20 +329,16 @@ bool hexagon_thread_is_enabled(CPUHexagonState *env)
 
     return E_bit;
 }
-#endif
 
 static bool hexagon_cpu_has_work(CPUState *cs)
 {
-#ifndef CONFIG_USER_ONLY
     CPUHexagonState *env = cpu_env(cs);
 
     return hexagon_thread_is_enabled(env) &&
         (cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_SWI
             | CPU_INTERRUPT_K0_UNLOCK | CPU_INTERRUPT_TLB_UNLOCK));
-#else
-    return true;
-#endif
 }
+#endif
 
 static void hexagon_restore_state_to_opc(CPUState *cs,
                                          const TranslationBlock *tb,
@@ -463,6 +459,26 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
 
 static int hexagon_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
+#ifndef CONFIG_USER_ONLY
+    BQL_LOCK_GUARD();
+    CPUHexagonState *env = cpu_env(cs);
+    HexagonCPU *cpu = HEXAGON_CPU(cs);
+    if (cpu->globalregs) {
+        uint32_t syscfg = arch_get_system_reg(env, HEX_SREG_SYSCFG);
+        uint8_t mmuen = GET_SYSCFG_FIELD(SYSCFG_MMUEN, syscfg);
+        if (!mmuen) {
+            return MMU_KERNEL_IDX;
+        }
+    }
+
+    int cpu_mode = get_cpu_mode(env);
+    if (cpu_mode == HEX_CPU_MODE_MONITOR) {
+        return MMU_KERNEL_IDX;
+    } else if (cpu_mode == HEX_CPU_MODE_GUEST) {
+        return MMU_GUEST_IDX;
+    }
+#endif
+
     return MMU_USER_IDX;
 }
 
diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
index 18c929bf5f..5d0ba23d02 100644
--- a/target/hexagon/cpu_helper.c
+++ b/target/hexagon/cpu_helper.c
@@ -389,4 +389,45 @@ void hexagon_stop_thread(CPUHexagonState *env)
     }
 }
 
+static int sys_in_monitor_mode_ssr(uint32_t ssr)
+{
+    if ((GET_SSR_FIELD(SSR_EX, ssr) != 0) ||
+       ((GET_SSR_FIELD(SSR_EX, ssr) == 0) && (GET_SSR_FIELD(SSR_UM, ssr) == 0)))
+        return 1;
+    return 0;
+}
+
+static int sys_in_guest_mode_ssr(uint32_t ssr)
+{
+    if ((GET_SSR_FIELD(SSR_EX, ssr) == 0) &&
+        (GET_SSR_FIELD(SSR_UM, ssr) != 0) &&
+        (GET_SSR_FIELD(SSR_GM, ssr) != 0))
+        return 1;
+    return 0;
+}
+
+static int sys_in_user_mode_ssr(uint32_t ssr)
+{
+    if ((GET_SSR_FIELD(SSR_EX, ssr) == 0) &&
+        (GET_SSR_FIELD(SSR_UM, ssr) != 0) &&
+        (GET_SSR_FIELD(SSR_GM, ssr) == 0))
+        return 1;
+   return 0;
+}
+
+int get_cpu_mode(CPUHexagonState *env)
+
+{
+    uint32_t ssr = arch_get_system_reg(env, HEX_SREG_SSR);
+
+    if (sys_in_monitor_mode_ssr(ssr)) {
+        return HEX_CPU_MODE_MONITOR;
+    } else if (sys_in_guest_mode_ssr(ssr)) {
+        return HEX_CPU_MODE_GUEST;
+    } else if (sys_in_user_mode_ssr(ssr)) {
+        return HEX_CPU_MODE_USER;
+    }
+    return HEX_CPU_MODE_MONITOR;
+}
+
 #endif
-- 
2.34.1


