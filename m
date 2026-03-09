Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A152F417F1
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbut-000117-Kg; Mon, 09 Mar 2026 10:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuW-0000qn-Lk
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuU-0005FN-OZ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:43 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6298WEiP3773310
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aWRD+KrLQiGVCgdEaoUtXoeKRU4l4yLdoes59zq7v/Y=; b=AumCFKOaTD0JTudG
 zESrpYKen+qiWfhSpi/bAfaE2tzXbvxOJX/coXPfkeioFoTic7TkKxlQFHDsT9vW
 CqtKrst+c86bmaa6XtLQYTFt8vH0BTt1Ehbz75KxqjtTWvZbIWCk9TIcm6wUfkvo
 Avn5F8fw5aWrCXqY4AqrCQtk6xVLCrQzHgxRv66SImaKVtGpi2yamth+zoJhO8kd
 ghrsDzrgiEC5xUizopBgjSZ7SB23ZoFi2ZaETiBcnKUm+uLgxypFvLYxRze+usWP
 fS5ZIiWIf/MsCcKhZ8T8gBRfpRMbYPl5759ruv4ThoybPaBYNYAWkPxnkSl6Qvl6
 NmLtzA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cstsa98e1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:41 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ba9a744f7dso12978782eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067721; x=1773672521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aWRD+KrLQiGVCgdEaoUtXoeKRU4l4yLdoes59zq7v/Y=;
 b=bK2iGXPyOyxnYsSWJ83M549v2lV2uPFcKPKTooUqBkMTekrb7PZENd0ugvvvE92Uvh
 e/9sKHzfm9E2moQyAw/lwDnf8SoLK8N6w2cXr0EZtAKxUiS7lV94d8KF/GotWHJlmp69
 YHU9j3rDmdm3QP3+aeR9aXFp23d/GsGwPU+tfkhKvkCpvI56a/yvk0bZ98sq+QnuNQ5y
 op6c0pA+q8ur3BBVDhYPi/HiB3G5XsU0SPIHvqnBtcWQTk92GycuXioN2TROSB85aba2
 OlhvkPWDCAWoPrrxF9f+UNy1e9cdBNrpDs0KrWRm82VRw5sMdswl8utanDgiF3VBqkTd
 mj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067721; x=1773672521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aWRD+KrLQiGVCgdEaoUtXoeKRU4l4yLdoes59zq7v/Y=;
 b=th98kBMtCnNoxFyLU09wZDSCmub8yBnAzOTCsqnSUYI2hjjLF4VR41E4jcmkidEs7m
 hQNR9grXdIjlQLTT6jZRA6mbIuAHzJDMBSrjEXTRy57HgRxXwacBHyA/ocS3kzBKmii2
 Rkiapss4Rybdjshk4/GTjhObxnYLiw7bNUpHivfNebsyzMnwlSE5DH+jSYBGhXbNOwFa
 6P//BHxxorWxiNtl9mQb8QwkRByAxuZMvTltPxLwOd5AizeAxX7Z/lUzLmeZI46nXPqQ
 mKqPY8ap5MikVB+E1ULZSHauIiSXrF07NAcVGx8jXr/Q0BwWk3clZ5N2tssxa61tNern
 YvMA==
X-Gm-Message-State: AOJu0Yw6ZWuHkYRx+8M19TOmTfSb9cUBS/p89YsevODGjbkkuTTB7Eky
 IcvDz0fTDACWLe++KFJ9+cuHrA40HfTT8MlF2V3t3pWHxCLUnhxKfG9fnJ2GOIK7zwBu0S+9eqS
 OCpMrNhmv3/4ofAMDU5wSaYDiIejkWkrZyh+ydaSGzv4sE9bqd7CwiDqhO83W0xmBXQ==
X-Gm-Gg: ATEYQzx2sO7obPiv0JOOvS5OQCcrjB/gA6SxVVIi3O3+hTpaCY8xNyIlwunNBqnLro2
 xfydmJXAeRKccbZkZ45UgdPjgF4vLSvU9mSajEEhpHaCpZ35jXo6Dj4FhcAZp4+DCv0t4zTwqd7
 GYVM2ETAj0npkUZdTwWaWNAX9r68Z2E742WhimHvHiWTBL2snkfKuRJvUelNUJ3BSgGCqZ5GIpk
 XmpEgPvh9Qiesnr7YcOcr+j/v5bkqoVNs0kEf4lgp/61GNKdxKjURLrHKx8N/U3Q8Lg/Y0IiglG
 GSDFC6hgx0yJWWXejG8a7Otg4w74GMmf4kH+Mtm4Z/y+PEh0ovkayLAXxFoMAQ7I/7bj1OGT8xW
 mOqsuIv4dRvROxlEpROgJs2rIdPKF4LIbcKuudL7kk43UsEJblwAOBbHhPVDPCyPau3EzmQ==
X-Received: by 2002:a05:7301:5795:b0:2ba:7617:eeb1 with SMTP id
 5a478bee46e88-2be4deaedcdmr3878597eec.12.1773067720610; 
 Mon, 09 Mar 2026 07:48:40 -0700 (PDT)
X-Received: by 2002:a05:7301:5795:b0:2ba:7617:eeb1 with SMTP id
 5a478bee46e88-2be4deaedcdmr3878586eec.12.1773067719980; 
 Mon, 09 Mar 2026 07:48:39 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:39 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 12/35] target/hexagon: Add guest, system reg number state
Date: Mon,  9 Mar 2026 07:47:59 -0700
Message-Id: <20260309144822.877695-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AlMtn0_PB1xebgQi9JFvUIKaO-KitXtT
X-Authority-Analysis: v=2.4 cv=I+Vohdgg c=1 sm=1 tr=0 ts=69aeddc9 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ikZfMmNF8Hme0_TNbpMA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfXyTxXUzt5jxvT
 sS24QTHkXxCEc2hvN2ls+JmJ30foASIzsK06d0ze5B1qCM7fR4ZAkXzRoPxUOB0oq2rrda7tp7u
 i8cHn+ZH+WW2z0+KV9JBhx3tjrI1JPGmSsfv08jQO1PV91pBDZE2bOH68pgmNlp5j3Rnid5z8AM
 P8DdCmlwbqQuHEyU9pkHTAz888m76x/ZBXPuRT3fyRdF38gfEBeQeEb6x6WZ5pPcpgsi92WtZW1
 luHTNPk3ZCEEk+cxPvRl/hXsHyOxF3rs6SyIX9QTu1ryuyz2iEZEvO9tI58IsCoqyyqtwhImDsh
 wxSQU8b2CWS2EvF0y1r7l9Xj46lj0NKGYRaAgFVodvXBGXDORgN+2CDWiFc5oRHVDhhN3wl2z5m
 pKR3aVNYEgDjKC8J6bZFLlk2+O2Qv+5fIirHRGEsg1xcaztSkyOtiw0vJhe4nwEdGS06eV9E8sV
 GYYeEPGYWoAOWp+jEsg==
X-Proofpoint-ORIG-GUID: AlMtn0_PB1xebgQi9JFvUIKaO-KitXtT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
 target/hexagon/cpu.h | 11 +++++++++++
 target/hexagon/cpu.c |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 3825de43ee7..3562965c88a 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -99,6 +99,17 @@ typedef struct CPUArchState {
     target_ulong stack_start;
 
     uint8_t slot_cancelled;
+
+#ifndef CONFIG_USER_ONLY
+    /* Some system registers are per thread and some are global. */
+    uint32_t t_sreg[NUM_SREGS];
+
+    uint32_t greg[NUM_GREGS];
+    uint32_t wait_next_pc;
+
+    /* This alias of CPUState.cpu_index is used by imported sources: */
+    uint32_t threadId;
+#endif
     target_ulong new_value_usr;
 
     MemLog mem_log_stores[STORES_MAX];
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 1f172404608..6fabfaad6d2 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -306,6 +306,11 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
     set_float_detect_tininess(float_tininess_before_rounding, &env->fp_status);
     /* Default NaN value: sign bit set, all frac bits set */
     set_float_default_nan_pattern(0b11111111, &env->fp_status);
+#ifndef CONFIG_USER_ONLY
+    memset(env->t_sreg, 0, sizeof(uint32_t) * NUM_SREGS);
+    memset(env->greg, 0, sizeof(uint32_t) * NUM_GREGS);
+    env->wait_next_pc = 0;
+#endif
     env->cause_code = HEX_EVENT_NONE;
 }
 
-- 
2.34.1


