Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B45F417E0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbuy-00013n-VR; Mon, 09 Mar 2026 10:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuq-0000yH-K7
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbun-0005IF-KM
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:04 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629EInZg890312
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ewhmSTRkwCwR961CB2gtgq7E8zNRdOdXdLFtvL7cDNs=; b=hBFWGs5jLfL/BZCx
 eUhdz2OjOgLaolrEp+L3fdJp0ga9BKgZoBNXuhnIZPgLt+NnOhYnd7wKb6iasH+Q
 Is2eIxzW+8Jc1GiKOwglBoYzVvKkgmSoVsuRG1wdhCiBA9MQZSXaRK1ejVuf/LQm
 2L+eb0VYuhHByr/wqHJuHaT8mOCOLcZfuAKkXITHqA4a908n/2QOW2dCRVU2QSGz
 Pl+r7L3I7oBwB1jzZSFVyY4DjiTelCYlQyeHZBbjwaWXvoQfuywNC6urFG29Zhgb
 6mJlNvLBcr7UfAp7/yt6dgT2BCLuRgy+OK92NNnGYl/VgHZNzYCJgdaOV7TP5WJl
 y7EPqQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyv183v7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:59 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2be21146933so10002488eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067738; x=1773672538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ewhmSTRkwCwR961CB2gtgq7E8zNRdOdXdLFtvL7cDNs=;
 b=SsQSVT66i8Zefikrjgvx6Z4SDqIdM0Z7NDW2srGTOztgfoM7nATHfh9joCDTWrh0DO
 pdlRLhynHPVT2/sK0ID2KMHaGZb09PFtslwutKiw/jKMDgsWKWnbxHdQRJVXNZKwoKko
 Re510Dfwm5qvJpRUbBfIruvqk8mDqzVVGE/rSkYW/7YP8PhaxFGWkvmmwZy3xxkBsX+K
 9xibMmqd3FC8+KFdD1/pYfZQZiN5INn1p2LejlAIc8MRyYg23tlK/aJQMtxQlIBLHNz1
 SmIxNAh1sNJaScN97AxhEocnvaGy/PJT80NhOhDNsphCV8AUE6UMli6GjfUtF105ILQI
 baPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067738; x=1773672538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ewhmSTRkwCwR961CB2gtgq7E8zNRdOdXdLFtvL7cDNs=;
 b=Ob8Abx/LMaSvWbswO65RkIkJ6fOXo85xGMpUUumRrhCZjC0TBJHtwrOFgjiGq6OFSV
 KSnFl4Q2YhO2m1VC7En+cIe0H8MhOfPnhdOMdKoPOt3Ww8eKGSMPmQU6C8R5FlocnZ/A
 8WvaExD59F+RiaFylSrtTexwb6EDDjfcjyAgb6VG1hi3WIHusg3rXmPwzJSY3D3tQ1iT
 /YvMZN2z807wywUAEvkHya6JsLCmGvZRoywWwDz+uITH6MfZN+AtZEHkWbVsTRU9OEKy
 QoHbNn7u6DXGcaMvAyPQ5N34Qx2Rkr0kCS4BGXV4XtV2kWlSWOropRuWIwZ2yGzk6Lym
 2ygg==
X-Gm-Message-State: AOJu0Yy/piZYRw4zlJueHOZ5aYEFT2FginzJPj7d6vAspItLWsus/668
 ntS3wbsA8KQx8t4Q4cC7lokbW2jWfjZaK6hJwB474SqKWiBYxFJvUfq30OSjg9K5Xuy+UROyjj8
 bbTM5tzCrdCc/HaW2Ep45Y3f1DF59S+8XC5KFbO4r37iD7gmwa/tx/A0iWwrL/EJnIA==
X-Gm-Gg: ATEYQzyW2t9lHaro5eaI5pqkKowcWYZDuSTFnMmcu213xSgEXbkcRPRrVnxPjmvH7zC
 P2wzcoBECKmlhlKqDM9IZMwqR1aU27RSyGZXPd4Zab6XKzajekcut8nO3BsV3AEewqb+pGSypFx
 M0dn1VPZHIyUVQ5xsVBYlQVDpjIkIJvNMKqABRxIyf6aMOISsaWFJBRkkP7qf4wMm0u6kaKT29p
 OpQJMRLkFLO79Y4oK7wseXxty8PtbEgFBozRe0ZSDZ4BGa2OpZ0JY57aOA0bwTdBcOYAj2rPeqx
 DXxYXzRp1TdtadPLZI6z/NnshUHV42RwpQMND2ebsPQvLAEm9QK+EuJeTnf/gy6WTvANbK0L7lf
 0PV9dH2NQD+5Tyi8QnbymfKdSgTGgkj966BugFTuePZEXbG7iQDTP9da/Qzm2yrXRujzZuA==
X-Received: by 2002:a05:7300:3254:b0:2be:2ab9:b3ad with SMTP id
 5a478bee46e88-2be4e0ad262mr4213542eec.39.1773067738205; 
 Mon, 09 Mar 2026 07:48:58 -0700 (PDT)
X-Received: by 2002:a05:7300:3254:b0:2be:2ab9:b3ad with SMTP id
 5a478bee46e88-2be4e0ad262mr4213515eec.39.1773067737555; 
 Mon, 09 Mar 2026 07:48:57 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:57 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 28/35] target/hexagon: Add TCG overrides for rte, nmi
Date: Mon,  9 Mar 2026 07:48:15 -0700
Message-Id: <20260309144822.877695-29-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9U4-X1HByIRZ3A-kT8UEiAEKSyuRcPxo
X-Proofpoint-ORIG-GUID: 9U4-X1HByIRZ3A-kT8UEiAEKSyuRcPxo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfXzNx9YpSEf1LP
 hA0vBT6QAZhr0jiJqcuDbXaXhclHlEfDwTnhKe7566nw85U5z8qnu6RSZS1Ox2RDGmEcigK1aNV
 oYfzj/moXhtcGmJBVcHJLorp0DJ31YcwAzxEfv5K9ZKDEtNDCtmcXwHjP6PPb6vwSdaYonM2B8D
 0frS5E76pugjn9F8Cm99iC1ElwX3Bx6w2axBeOnxyRDehbDGIqWUKkQNqbRQWKfjBWEAenoeHST
 GIEZs9qY5q+NhJSNzt8b94cWvZ+5Z4O4/muQsR4LRZly3sTkAp6BLNp45Lg2jxR3LgtDpkQZqnk
 hmRq2sDu/8zYU9gWb3Elj9wK4PWzTtVjwHNs2SbqgmpHIVrKOCKCFrGXfd8hn7wluapNuIfyF60
 6m+iOY4CYhqA6zFbpyv8thC1WtjP0iaxRKhTIAT71CMNpq5DIDW86nacZuCTOVJ7EBFs0SHMXwO
 bdKEE60bOtbljORvB8w==
X-Authority-Analysis: v=2.4 cv=Cuays34D c=1 sm=1 tr=0 ts=69aedddb cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=zRxYJKy5J8nCns2dKEsA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Brian Cain <bcain@quicinc.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/gen_tcg_sys.h | 19 +++++++++++++++++++
 target/hexagon/helper.h      |  1 +
 target/hexagon/op_helper.c   |  4 ++++
 3 files changed, 24 insertions(+)

diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
index 0453e3bb2c4..282daf0c115 100644
--- a/target/hexagon/gen_tcg_sys.h
+++ b/target/hexagon/gen_tcg_sys.h
@@ -80,4 +80,23 @@
         gen_helper_stop(tcg_env); \
     } while (0)
 
+/*
+ * rte (return from exception)
+ *     Clear the EX bit in SSR
+ *     Jump to ELR
+ */
+#define fGEN_TCG_J2_rte(SHORTCODE) \
+    do { \
+        TCGv_i32 new_ssr = tcg_temp_new_i32(); \
+        tcg_gen_deposit_tl(new_ssr, hex_t_sreg[HEX_SREG_SSR], \
+                           tcg_constant_tl(0), \
+                           reg_field_info[SSR_EX].offset, \
+                           reg_field_info[SSR_EX].width); \
+        gen_log_sreg_write(ctx, HEX_SREG_SSR, new_ssr); \
+        gen_jumpr(ctx, hex_t_sreg[HEX_SREG_ELR]); \
+    } while (0)
+
+#define fGEN_TCG_Y4_nmi(SHORTCODE) \
+    gen_helper_nmi(tcg_env, RsV)
+
 #endif
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 682f0c6c26e..9ca87acfe63 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -127,4 +127,5 @@ DEF_HELPER_2(start, void, env, i32)
 DEF_HELPER_1(stop, void, env)
 DEF_HELPER_2(wait, void, env, i32)
 DEF_HELPER_2(resume, void, env, i32)
+DEF_HELPER_2(nmi, void, env, i32)
 #endif
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 69b41ef1196..cb60d3a2f9e 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1477,6 +1477,10 @@ void HELPER(setprio)(CPUHexagonState *env, uint32_t thread, uint32_t prio)
     g_assert_not_reached();
 }
 
+void HELPER(nmi)(CPUHexagonState *env, uint32_t thread_mask)
+{
+    g_assert_not_reached();
+}
 #endif
 
 
-- 
2.34.1


