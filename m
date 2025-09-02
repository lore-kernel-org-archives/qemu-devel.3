Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6F7CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1K-0001qD-1H; Mon, 01 Sep 2025 23:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1F-0001WO-Cv
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1D-0004bN-Qn
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:17 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rq7q029973
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wA36y1pseHZ/mbWOg5X+MZTqAkmXjAje6zJZzeVXNLw=; b=P+9a4PZrvZxC2UJC
 FvXPmS3cJOJ9Z3mPzlSlzjOZW8xxtHaE30OO9MejXauFv2ZmKCBfI9pLRpjQtJup
 j8cLgGSlVAckwG8z9UYGStSFV7GgHK4u6C14a4BUk2e6InB9OAXEP7Vs8vSH0SPm
 HvR8xYgl6gpXXqETNNyVNYHx4590WUzp0c+28s3JaAgaORuFaJv8ltX//buhM27p
 QMhTX3bK7tOUyvO2SEp5zTpgGgI539aaZvlNpHEGU4MNLZ/G/zdBB7z5fbZozSaF
 8lJxZubY6+LgFXXJPh4GSRBMZZRuLha95WdilgBleTHyksWZ7rKFHDB6uA1fkyby
 /hZD8w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy26rx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:04 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-325ce108e45so4742978a91.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784943; x=1757389743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wA36y1pseHZ/mbWOg5X+MZTqAkmXjAje6zJZzeVXNLw=;
 b=N47/aPyL4DSHJy8X1Ct6EUlUyN5wEHqbJc63ltIjSxfv5hdZX4M8sn0vtzJUTi+8WG
 G+we3zP+uOLoe5CpM2i1Bzfzo/z/hmCnYlp+zBhu9daBrXi41377u3bcENO/wxsvKkYH
 cVkmBFZdCCN+FJ/1sGlVYBJsWXfcocg8BymVjc3FFgaCkbAxdugECt7R61OP17h7gPZB
 HkUlb6BYVSlubBD7SK6WrDznHT9hDP6X9NY/+XZJ7UwvYm1IyITyYXXmauzY7AjeCBy4
 gHQcNIrFW5isj6rgDAQJ8F0WmMMbba8qhVwLcUW0iyBhNDaYKuDIwUpMh+bVZDC6E7dY
 s1Gg==
X-Gm-Message-State: AOJu0YwfbQLc2cJv8hNA0jp/0a7bqcUy+lFFpsY3dpctNovNN/T7ueLd
 XJ0S1ByqSAYjA3d/a/aPrxLt4TlU3IDMUaKaPPKFavTVRW1SIa1feh8KR1RmnS3xH0tDeRIyczQ
 9pz1X26QBZtznU2YqS0Cq5fG1nusXiEoACIQ9Loo1T1plkGz/rW328XLPmPMsYyTBAKVe
X-Gm-Gg: ASbGncv5kpanWWY6htSftKRWG/mrC9yt2iSMo8mB5LIUT0+8RhQ+dM1RXTNjX3JFUQW
 CcW5q37jQsQfe1D8xWkfsVE/L+hbRAStY5rmCWnhSpyJjFwLOKYPS9hG6GqtXcz1B7C+6VYFCM5
 YpDVcnI/A5Tjtv8mruMHg6JIgvjUe9Ky9epvo0iKsa56bRd4p66q80+7AXAobN/Y+WHQiygdwfp
 Ij5gv/LNcpyUcSS9hppBQ1HnLswLoqAB8XkrLdigHhjjrlVS7HRYP87sCU31HgakSRx80hoxj3t
 f19AclezdGXOtEq7NplmLUqWCamIdKW/3xAy1/Jq5eSYlT9+f1i71CRFliMpfJRQO5qCOWFETsu
 osmvhNzXDtvoS
X-Received: by 2002:a17:90b:3844:b0:321:82a0:fe50 with SMTP id
 98e67ed59e1d1-3280d2d9b63mr14329986a91.5.1756784943325; 
 Mon, 01 Sep 2025 20:49:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ2G1b3nSl6kHHrxqlypdVwZ7W168+7idVPNFRhW4dWwdgYiH+V4Ud4886AvkYsesSwxnI2Q==
X-Received: by 2002:a17:90b:3844:b0:321:82a0:fe50 with SMTP id
 98e67ed59e1d1-3280d2d9b63mr14329953a91.5.1756784942866; 
 Mon, 01 Sep 2025 20:49:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:02 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 09/39] target/hexagon: Implement arch_get_system_reg()
Date: Mon,  1 Sep 2025 20:48:17 -0700
Message-Id: <20250902034847.1948010-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b66930 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=HSKE6JCKznaEU2TF9tAA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: fPZhD9x9yzgmaTIWyn3cGkr03mF7fq4Z
X-Proofpoint-ORIG-GUID: fPZhD9x9yzgmaTIWyn3cGkr03mF7fq4Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX3kJ2arSX33Uq
 ZJZWRcjw76LpMKcwZk8SOL46bNhbFqidaO4wX1IAB98tg5gr2kJ7wsE3GNyWD0yOVwyBxlRkbNK
 yI3aCDsKj5qRhuSiOLAetRNktxLE9uwe8ABo0qaUvn0Qn0Bz7ldCNsDyyPQ+LvJp8qsFI3Qgj2u
 pEvLuAy6rYlxrCjI1cDPirqbkmRelymUWEe/dI2JRl1iIKsLp58mqFPv5zA90lZz6XPnsvX2m9a
 MzCWQCNDCFQ9+8HnDqacq+hHh3YPJ/9tvOGk5OD9QQzoleyZn6jv75wPcZ0pU1dIeOBsFPNy2wQ
 MRgOrL5uvIll0VIsdXJlaTb69zNGllH17hryvjNaBXajJAre7cOrmCcPtgE9o+x35r/ze6LddGZ
 2HY4MfWq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101
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
 target/hexagon/cpu_helper.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
index 1a1520214e..4732a698b4 100644
--- a/target/hexagon/cpu_helper.c
+++ b/target/hexagon/cpu_helper.c
@@ -39,7 +39,38 @@ uint32_t hexagon_get_pmu_counter(CPUHexagonState *cur_env, int index)
 
 uint32_t arch_get_system_reg(CPUHexagonState *env, uint32_t reg)
 {
-    g_assert_not_reached();
+    if (reg == HEX_SREG_PCYCLELO) {
+        return hexagon_get_sys_pcycle_count_low(env);
+    } else if (reg == HEX_SREG_PCYCLEHI) {
+        return hexagon_get_sys_pcycle_count_high(env);
+    }
+
+    g_assert(reg < NUM_SREGS);
+    if (reg < HEX_SREG_GLB_START) {
+        return env->t_sreg[reg];
+    } else {
+#ifndef CONFIG_USER_ONLY
+        HexagonCPU *cpu = env_archcpu(env);
+        return cpu->globalregs ? hexagon_globalreg_read(cpu, reg) : 0;
+#else
+        return 0;
+#endif
+    }
+}
+
+void arch_set_system_reg(CPUHexagonState *env, uint32_t reg, uint32_t val)
+{
+    g_assert(reg < NUM_SREGS);
+    if (reg < HEX_SREG_GLB_START) {
+        env->t_sreg[reg] = val;
+    } else {
+#ifndef CONFIG_USER_ONLY
+        HexagonCPU *cpu = env_archcpu(env);
+        if (cpu->globalregs) {
+            hexagon_globalreg_write(cpu, reg, val);
+        }
+#endif
+    }
 }
 
 uint64_t hexagon_get_sys_pcycle_count(CPUHexagonState *env)
-- 
2.34.1


