Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84032CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1J-0001mO-Dw; Mon, 01 Sep 2025 23:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1G-0001ZN-Cx
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1E-0004be-Oe
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:18 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822T6Yv032344
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mydiZdVQ5TcL/9AS6VMPvIGisZjZpmfmAQD6E/nNxvE=; b=Uqdx6IpfCs3YhPye
 PJbSDfkb+0sW4puwJbOVSNXw98tsbd/MtyC2FWSclE6Px6KdqUKWXaV04j5AWqlg
 OAKiMaN3jvicFNjLxYFyXdAbZPhvnsUUPdjH0Tn8I5kC9+HQG/CL7jFza9cPvhxv
 QgbDiL2Ks+fNPtqe4XIgcjef2NyVKP6lYNFJzLAWp1xduJqyWBcNNznKh4hOLA5Q
 IFMQtONIKjRpH1jMp3IYsNxhZGXKnyVlr6cfd+jbmZOx/3XvtrD46wi+JEusqiJn
 DocXOdiRPHhThZytWtJxmuiU6IFzCpflACd8TTNb3AxJOB0CY2lESl9uF9nB4I30
 ia2Mow==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8pc2e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:05 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7724bca103dso1787097b3a.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784944; x=1757389744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mydiZdVQ5TcL/9AS6VMPvIGisZjZpmfmAQD6E/nNxvE=;
 b=JAqaP8hcgLj9VKXW7j7FE1ccINaa4NG28qYlxNPwk1ni1ZSeIiTAr4L2ldtWwYkZhk
 r6MnetYutWp8nUC3vdIC52EOwlfneZzf5hhucgDLqDTKxxxnhqkvix0CHlGAVB3NkapE
 GOAiVJahVQwOMOGCDzz/3Wr+6nI+VdkQuKEPzb/XE3HOBqjQcC2O5CmwqK+fcWMhY1gM
 BndjGd0drZwcJHFXKXHIq5D7iZ3kYdeUDOTttOhikN61K3EoM/Z66oWSMZQEtKUeGF+R
 vEDGqn3aj+3M0TJZH6m0odPBxVF48eqUDkKiQOKJgMDdEUVqBrSfPlkbdiw5RArrDHJJ
 mihQ==
X-Gm-Message-State: AOJu0YyWnvZOPIJM2j1+l4U7nVR39zA+t773vOYOF1wQyp5cgsR3zKNB
 DttuJycb2mHopDkIG6c6P58+fc+vaknCxjXI8mxCSiTNRiO/+vTtw/Rr8kxuCLqQHwsX+DhzYlT
 5e/Miy2EG6NOrj3nQoGCOQS8o+gGYA7kOcu2nYU2UL8hgRCQKxJ9qp9l35L9eKX9jDiLl
X-Gm-Gg: ASbGnctKIKXnvfrExo5zc0HT7cZnfVP2C8k3ZAoK/zN0vtd8kjTtuqJ+VGU43TS6zpo
 cO3ldNUbfFjDvNNYF6r+MDx7gXez89+8zbnYT134d8IucQBfjfwQjuc09d2piGdduKHTeQ39kYK
 BDOOuhMo4Fr476VMKxoTbc26ztmkfHFy+jIBiWVNyh42YxUSl/h8f3lrIKORb9mx0xz1ChcHERV
 znKFTXpniEVVZXyDNtF167DDTZn0TJBcycSefh5Jsnn01x58DQepcWCNd+O7XmJlUdi8FYCHpbE
 K104Tj0Z43849p0wrQeZ3WEfGZcB/cKTzYC88WzwPmKd5V6uvlh9CCRAtaZuqmzPFf739wCmQji
 i2zuOXmmNmYXb
X-Received: by 2002:a05:6a20:c916:b0:243:f5ba:aa82 with SMTP id
 adf61e73a8af0-243f5bae85bmr4484092637.30.1756784944381; 
 Mon, 01 Sep 2025 20:49:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHeMqW1EeVLG2eYKteduOqGiRouIyfyIg6/56Bb1LB7I2UVXDLrLykCXwU7f08o5M/JACv8Q==
X-Received: by 2002:a05:6a20:c916:b0:243:f5ba:aa82 with SMTP id
 adf61e73a8af0-243f5bae85bmr4484062637.30.1756784943951; 
 Mon, 01 Sep 2025 20:49:03 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:03 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 10/39] target/hexagon: Implement arch_{s, g}et_{thread,
 system}_reg()
Date: Mon,  1 Sep 2025 20:48:18 -0700
Message-Id: <20250902034847.1948010-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZZxnp_WcgvKIDJfYNpALB1YTMblRLEQ1
X-Proofpoint-GUID: ZZxnp_WcgvKIDJfYNpALB1YTMblRLEQ1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX2fkcxM9YJbqh
 nyQg0lgkqzwUDb/2IVF/TXeQkpWdI7SKUBruRsYVysbu+SyWW5e+JjAX0WC9a56O13uitnwtNaa
 9L2WbFPoQnT6xZ4QF4/3/BgEUUSbX/wyMf2ULfpQmnPEcRbcicfstEQDvRlBSMtzAhUpKYkhQN5
 t0DcuUZxlu4V93AC01/BQ9xFGPSSCO5hAJqpzXtYOXKM9hfex1iIE0ixFexTniuQO3y38ZNc9uG
 0sk0fNg0lvSt4IHm/0hbkjL+JshF2gb3S6Kac/edcrCnKOLyI+O+N7+G3IYgJbbI1RjvWM/pGyy
 PNU1a++JQXx+4e4Skep1wMGX/rfvX7JIwhqqPsHR65qXJL72WhtxWfTANWorzoGTsPNyuaJskZ+
 KpOO5k2q
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b66931 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=HDd5vYzWQR-3ZBpyivcA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=TjNXssC_j7lpFel5tvFf:22
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
Reply-to:  Brian Cain <brian.cain@oss.qualcomm.com>
From:  Brian Cain via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Brian Cain <bcain@quicinc.com>

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu_helper.h | 15 ++++++++-------
 target/hexagon/cpu_helper.c | 16 ++++++++++++++++
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
index e8d89d8526..f7400031ef 100644
--- a/target/hexagon/cpu_helper.h
+++ b/target/hexagon/cpu_helper.h
@@ -26,20 +26,21 @@ static inline void arch_set_thread_reg(CPUHexagonState *env, uint32_t reg,
                                        uint32_t val)
 {
     g_assert(reg < TOTAL_PER_THREAD_REGS);
-    g_assert_not_reached();
+    env->gpr[reg] = val;
 }
 
 static inline uint32_t arch_get_thread_reg(CPUHexagonState *env, uint32_t reg)
 {
     g_assert(reg < TOTAL_PER_THREAD_REGS);
-    g_assert_not_reached();
+    return env->gpr[reg];
 }
 
-static inline void arch_set_system_reg(CPUHexagonState *env, uint32_t reg,
-                                       uint32_t val)
-{
-    g_assert_not_reached();
-}
+#ifndef CONFIG_USER_ONLY
+void arch_set_system_reg(CPUHexagonState *env, uint32_t reg,
+                        uint32_t val);
+void arch_set_system_reg_masked(CPUHexagonState *env, uint32_t reg,
+                                uint32_t val);
+#endif
 
 uint32_t arch_get_system_reg(CPUHexagonState *env, uint32_t reg);
 
diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
index 4732a698b4..fc49fe7883 100644
--- a/target/hexagon/cpu_helper.c
+++ b/target/hexagon/cpu_helper.c
@@ -73,6 +73,22 @@ void arch_set_system_reg(CPUHexagonState *env, uint32_t reg, uint32_t val)
     }
 }
 
+void arch_set_system_reg_masked(CPUHexagonState *env, uint32_t reg,
+                                 uint32_t val)
+{
+    g_assert(reg < NUM_SREGS);
+    if (reg < HEX_SREG_GLB_START) {
+        env->t_sreg[reg] = val;
+    } else {
+#ifndef CONFIG_USER_ONLY
+        HexagonCPU *cpu = env_archcpu(env);
+        if (cpu->globalregs) {
+            hexagon_globalreg_write_masked(cpu, reg, val);
+        }
+#endif
+    }
+}
+
 uint64_t hexagon_get_sys_pcycle_count(CPUHexagonState *env)
 {
     g_assert_not_reached();
-- 
2.34.1


