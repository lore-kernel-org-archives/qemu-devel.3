Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46EA3CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1H-0001Yd-AK; Mon, 01 Sep 2025 23:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1D-0001Qn-Dq
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1B-0004b2-Dv
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:15 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rtas015204
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7J3Jnl/i4FcDX0LBPe/gOgNshBK4R+Mu7Lz8M1msgiA=; b=iGH940U8n4KgnKKr
 b5s3KxqY+e+VhCjZcUrsqwRxaji1i+KwNcmQYLJTE2sCFmb8o97Zgj/npO9ALTsy
 WMKX5KY8I6MBlLeIMkDDS+9VVxBLYu7oeNo5sCQ8UcHR78BFbuNtyR+fivgUCUsR
 Mq19X/ZwAvEr5dQqEogEzrmzkUokHLP0E7uofSYzlmOS0ZRHZIVtI1ObXCqvyqRD
 WkGm3lC7x4uoQc7cGVq97CdDQ6P1wHPzQgBLcE3eJtMrgADOa3YQtRR/QjSYw7B7
 5augykwJyOhm7Z44lN+paZnypwq3+6e8GfuyixFGTUIR7SxLKe+YAWJe/iTkZLvX
 nvTodg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urvyxdj4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:02 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-329cb4c3f78so827681a91.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784941; x=1757389741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7J3Jnl/i4FcDX0LBPe/gOgNshBK4R+Mu7Lz8M1msgiA=;
 b=Fh6aDzd4NGmnEnoFv1dWliSo83dXUO3trGtQZg2TlPcuWcTAviIuy46SR239fDEM+J
 X1vZeI8amJY4L4ZkbmwI86ssKOZxUl48s5X33q8K7mQS0vSe47eA0fAvyeKkWw6FIK5P
 BSGsJ8N13QQhUzxgkoJNt3c1AF9MRkAfVF+4v8jK1IR67HWI717P738DrYvBSQjngfn0
 Q+IFqbJAlkw77r1rlChpTcC31TIe/2/ELQSAhSc3/PDL1SYIn+74xxh9BFpP8ljDHI5t
 Pdc/AXSmr2mhAJuhMzsfsgf70bRAIhjBScnSVu7eRezHyjEAIWdS2FrDi2Fk6CcA9Nb3
 HGgQ==
X-Gm-Message-State: AOJu0YxR1soWPVuvmEd5Xr5fixpx2FzUC0L8kJ8lPd+fHBwcbQ0ENM1w
 oelIsCGpXmfdNOk7coGl4cYYNthnhdF+wO7xQEXliAsdh+zy2Gh9ldLoti6RZK2qkVtKl9mIq2t
 +/LecUFq2rT2G56v4OXf0KsnnbS02eHH2INqvMnwckR4SFqO4vDII4vRQB8NTebQ7wwhf
X-Gm-Gg: ASbGncuLPwdkEUqV2sFizmSswFpqpQUg4k5mFTpv2AyLncFo9IloGPIGDt98THtQpCx
 w0pqK4rI1IF/CkCD3M9u4RalX+VMUXPegNG2IPqbOyWXTWJOUTtbpoo/bUQsl2QzmuQHa3nNWOi
 dRMaRGeYSv78/C8vZz41Y0nxFmDDflrH513s7E9p2iDMroeFuLzod43Lj0ic6yLN1ffpgqYJ7s+
 g2vBUcekbt5r8CeA7LxhZwd4cjDakV/KhSQr3xQYb2L7dVJHFGLRiIM8eTjy9AsQbYVXh/aVNXL
 NIjcZazcZnoSFzGvCojh0gL2msfvfcwK3K8tzoXFqjYcWlDRRyHcmAk9hbfUcIqaOYx7MrFFoAn
 XWfskGlEzw2zV
X-Received: by 2002:a17:90b:3f84:b0:329:d85b:d9ee with SMTP id
 98e67ed59e1d1-329d85bdae7mr2464397a91.23.1756784940945; 
 Mon, 01 Sep 2025 20:49:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwl2cRddA51uVVz9Jg0LsAYDC2N3vers3y4TGaU372jnga7vsG1PIJ1xDCkd1uTVnkAdhhfA==
X-Received: by 2002:a17:90b:3f84:b0:329:d85b:d9ee with SMTP id
 98e67ed59e1d1-329d85bdae7mr2464365a91.23.1756784940455; 
 Mon, 01 Sep 2025 20:49:00 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:00 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 07/39] target/hexagon: Implement wait helper
Date: Mon,  1 Sep 2025 20:48:15 -0700
Message-Id: <20250902034847.1948010-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: L_3bNXtOu9r0kRSfi5Mqqb5plWdRHVz6
X-Proofpoint-ORIG-GUID: L_3bNXtOu9r0kRSfi5Mqqb5plWdRHVz6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfXyHTWw5AmjU4X
 B2QHyiFAuCkwDhfjVOQ62Jqk94biY2J1Emfae3glpUMsax9YX0Xd34MqazfDupFTeNvVHtQghrj
 DktK/eh6p+gLNMF3khDq10TzXXseYkXEm5qDMHppVoGa2ASQPXhlmfs6EgDxR221SbB0D8Aqp8k
 FjrUGkKoyZCGjvPgJU0mfGjQ1h9e3U7myw6VuybKzXfVyifQanwwhjO6W8Ij0bTHvOVFI+eCV/K
 YsiCfwcnuVaapuxSCmYiXfuw0dOKLs4KEUH+BIWGTylc8Qx4mLhK65fdEgM00Y/99PmBqtbKX4O
 cDKyYd5FomXrBUx6KlbbF6Gx624Ll1s+41SNr6Tj+BMc2+NzaJvN4sB114/V0Cp5FPzdDUUei1Z
 xyIX2ZjP
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b6692e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=3pk8eyN9Md6IEAUW3xIA:9 a=z6jpoc7dHuyx4b7i:21 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027
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
 target/hexagon/cpu_helper.h | 1 +
 target/hexagon/op_helper.c  | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
index 95a0cc0788..e8d89d8526 100644
--- a/target/hexagon/cpu_helper.h
+++ b/target/hexagon/cpu_helper.h
@@ -20,6 +20,7 @@ void clear_wait_mode(CPUHexagonState *env);
 void hexagon_ssr_set_cause(CPUHexagonState *env, uint32_t cause);
 void hexagon_start_threads(CPUHexagonState *env, uint32_t mask);
 void hexagon_stop_thread(CPUHexagonState *env);
+void hexagon_wait_thread(CPUHexagonState *env, target_ulong PC);
 
 static inline void arch_set_thread_reg(CPUHexagonState *env, uint32_t reg,
                                        uint32_t val)
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 03e69421c7..a8b44a73bd 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1465,7 +1465,11 @@ void HELPER(stop)(CPUHexagonState *env)
 
 void HELPER(wait)(CPUHexagonState *env, target_ulong PC)
 {
-    g_assert_not_reached();
+    BQL_LOCK_GUARD();
+
+    if (!fIN_DEBUG_MODE(env->threadId)) {
+        hexagon_wait_thread(env, PC);
+    }
 }
 
 void HELPER(resume)(CPUHexagonState *env, uint32_t mask)
-- 
2.34.1


