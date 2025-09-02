Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE488CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI0e-0007m2-7O; Mon, 01 Sep 2025 23:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0L-00077j-Py
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0J-0004XR-Ep
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:21 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RkQY016270
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LFevgomVHhazQisSDJeMUisDflSSItQWekFlyCxE6l8=; b=ap3duOomI6cfT3Lw
 SqYERGHq/RXIdhvzIokrVwI4OffM9sRMrR3ugyWIznGzRNX1ph4KOU4Qkxu6Mn2/
 cBAyHaQ56NReLSaQg6RtmKODv0TgDi0BHTJJ50TvKNaEA9vrUqoos3RSTv5mtXOj
 H4p2yBfwweT+onVm1gQ5nP/u1MexSeL0qqvRxmTovO+P6xMwHETVP8J+KyFFNkcI
 flXXSwKDqPfzrWHsTCMRtUtE1brFhv7mBHIdaIX5g2qiJMhmiKtw1IIKw4kiFTXl
 2UhTvY13hdVnAaYhAJMEAFjb59RKbeGIRdLq4NQVAI+T3hU7p8pFDQQ8gHvDA3y1
 YY86OQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk8x87a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:48:08 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-77260b29516so2234347b3a.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784887; x=1757389687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LFevgomVHhazQisSDJeMUisDflSSItQWekFlyCxE6l8=;
 b=IXjoESZSpQiXTdQtZIfrM/KpYlefAJtd+QJSeaYijtBc15kyB4V2hFqKR1LuyFhfq1
 11anoTBV+WdcqslvEEZ/LiHIKr0rK+PCvH3bmWes6sLfUeSN5Bo8bkPsi4bcQA6TYCla
 VEOwov5fTACiNHqrEZkFpWuOeSy5uzH9KGp1CZvGfNCJDLe7GwD+2lFqJ5+MB5gQBY/F
 YIncxPoiGScRoGbr4o0VwINEoh8E3w2+bNcU6R1+TIWAMuDlsdwEPNNO1MhcToFMlL/n
 ZLwnOrLyhdBA/NP11T4ZY4ginLMl3Qze0c2sTaCilvj/tkj9kBstvsWTrWbZ1LMC804k
 eZzQ==
X-Gm-Message-State: AOJu0YzO8ylYwVFLWtO950T4h6eDrhBIk5w5aUPlk6dekAVcIS9/UmZR
 UZnm1nmEr0V6+k0yP4LnkaHwQ/MOcBrgAk9F486o7BNc4ugrNKEM73WK2V5F4/sH9ri+PIdikmU
 R+OQEDYEkxZi3pZlYYkFVFjDQzkzojkB6rPfXDAM+eSD3/hjem6QWtPm8kso0IpnamFBY
X-Gm-Gg: ASbGncsT+nlqlZLFY5F10+Ef+505KYMgfiSgAknLrv6YAbc6YrtSk0QzQEsN0LmEW/E
 hJUuD8H/tO1yZtiiktcZmoZ/rA/vgAdy8I6B6MaH6D/OJZ4aGM8W9FpGeG+Eo8ltl1VV5RBr8GC
 OMeLrhn8U4nlolRTylDyRyzeJtH87L9dIGbIs2p2UwqTcyaMS17qrOlSzS6CByNplE4ylzTeJBn
 0LJ4tDZZcxzNluO7YhifC8syMU/E8aYCAcjBV55rmpYhSfArXHEJWwY4U54cu5WxqbLMv7n7HHH
 Z9ypMONMrsaD2LZjqppbrzIO4zTbJw/ZkIr4I1Dd8U1bTCKYpz8KF7x/y8vQMmjLz+3R2jn04T8
 9JO7mSo++l3VE
X-Received: by 2002:a05:6a21:3396:b0:243:15b9:7655 with SMTP id
 adf61e73a8af0-243d6f40f0dmr12302839637.47.1756784886982; 
 Mon, 01 Sep 2025 20:48:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj+4e/bnGKgkVNkAIAqtd8kutBW1XXRftZIOe+POPnpVZWXXAfcvWT9GDY53T4cngdyd2Cgw==
X-Received: by 2002:a05:6a21:3396:b0:243:15b9:7655 with SMTP id
 adf61e73a8af0-243d6f40f0dmr12302797637.47.1756784886523; 
 Mon, 01 Sep 2025 20:48:06 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:48:06 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 38/40] target/hexagon: Add clear_wait_mode() definition
Date: Mon,  1 Sep 2025 20:47:13 -0700
Message-Id: <20250902034715.1947718-39-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LKm0eJ2p5ZvkfSN-L1Zt6E20X9Z3XogX
X-Proofpoint-ORIG-GUID: LKm0eJ2p5ZvkfSN-L1Zt6E20X9Z3XogX
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b668f8 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=InO9qlFFT13rIqmD9gwA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX0gpf1VT20Jex
 wfZV2ycqrTPNzGzNL0+cALiks6aZFNORLhpAus9DSvwz4kPVcaxWVDnegq5CgkhqohJWdy/vTlD
 QPGDozSha0FlwjuTYYvKPgYYxw8C2fqF5LMHXW6qRFHJTM4uOdAWgUwcYM7MQ6Tx1U4hrHKmjzO
 jSMu+DhwZ9dFUnRqnl+PlJc0hfIoAnbZNAGYQoEgEB5hborerPDTTwESD11nToAHATeyZ3fu3SC
 VuCz3llim2LZzcoBcJpsKvT9BJt5O+Iee1bWnme6eSuiNx5uCWBa1pOsGKZiQhG3ifu2HiMyKc0
 4upBbznTngXQAOOphrzPrPZ4kfpgOQ0NVfGJAk69xyU5aMx8NItjmHX6AxlZJILgxZZYA4U3AcT
 3mk4e0ru
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042
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
 target/hexagon/cpu_helper.h |  1 +
 target/hexagon/cpu_helper.c | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
index e0c0c037a6..6f0c6697ad 100644
--- a/target/hexagon/cpu_helper.h
+++ b/target/hexagon/cpu_helper.h
@@ -16,6 +16,7 @@ void hexagon_set_sys_pcycle_count_low(CPUHexagonState *env, uint32_t);
 void hexagon_set_sys_pcycle_count_high(CPUHexagonState *env, uint32_t);
 void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t old);
 int get_exe_mode(CPUHexagonState *env);
+void clear_wait_mode(CPUHexagonState *env);
 
 static inline void arch_set_thread_reg(CPUHexagonState *env, uint32_t reg,
                                        uint32_t val)
diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
index bc51714406..00f47e5a07 100644
--- a/target/hexagon/cpu_helper.c
+++ b/target/hexagon/cpu_helper.c
@@ -76,6 +76,19 @@ void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t old)
     g_assert_not_reached();
 }
 
+void clear_wait_mode(CPUHexagonState *env)
+{
+    g_assert(bql_locked());
+
+    HexagonCPU *cpu = env_archcpu(env);
+    if (cpu->globalregs) {
+        const uint32_t modectl = arch_get_system_reg(env, HEX_SREG_MODECTL);
+        uint32_t thread_wait_mask = GET_FIELD(MODECTL_W, modectl);
+        thread_wait_mask &= ~(0x1 << env->threadId);
+        SET_SYSTEM_FIELD(env, HEX_SREG_MODECTL, MODECTL_W, thread_wait_mask);
+    }
+}
+
 int get_exe_mode(CPUHexagonState *env)
 {
     g_assert_not_reached();
-- 
2.34.1


