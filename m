Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E657F417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbv5-0001VM-2L; Mon, 09 Mar 2026 10:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbv0-0001DV-8b
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuy-0005Ie-KS
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:13 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629Dr6CG4027528
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VS6lI+dtQyxlU9+70GYVQuAT8QSCeXND1txo5RBGI8I=; b=BBx1uZYbgcZy8dgq
 keu5kr3GhNjZ+D1ISiEtTujqWDyPt5srVM+T2yJhs7WwXqmPMasEKV6L2+Z4p97O
 3H3C3Jx95jY0R6Z7Ez7GiWUTHvW5GZ2DbE3HpLmakjSIS5bFDzhdV0MN5Ap0Zbgt
 MQHikiCu8/m8TVYDIozTBc3Au/TR+2W0yX1Uxxtsqcwd5zDoBgt7XkGMG7pP0bDQ
 KWHkRDOCr5KrN3iGIhglIUu/RpgCeHcbJGEoNSRTPmAzqHjWIYRrX7m8IoI1qgJl
 6tjXDtPQUBABOOfv5DlTT+RGcDOnFTcIGL7t/IJhLTADo3QMWUzdw8/i2sgIFIPK
 YTzh0Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyfy06ka-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:49:01 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2be47f2899aso47131046eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067740; x=1773672540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VS6lI+dtQyxlU9+70GYVQuAT8QSCeXND1txo5RBGI8I=;
 b=HtoZc5se34krMxd+XX7RXnZ0e5g0crNYj4ZtTQXOZiDPd23MpUI07Fw6hr3eCqXZfr
 GnsFuhygLEUaSj+mYyZgi8niYWgrtOdxAS4bmfgMieW39ttOPyLxgUHrGxEmwVGVTK8Q
 EWyGGypcQghJt11pJPf3q3PWYIM0KPVAYTDN6yGV1t4eaOGdVGNcD/V+nLupT6FmuemV
 r2++HfXlqnScCmbbLmkjHzUy/DuOOBNobbJrwe08hS2OgtNOLu3xRboUkZJpmqWvmHkU
 OgcBLJy4IaUzqvhgKF5beoTWswdhfbjZEy98E8uiumFzSG7hAuZ7qlar0/QWmdFtKOpm
 7UMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067740; x=1773672540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VS6lI+dtQyxlU9+70GYVQuAT8QSCeXND1txo5RBGI8I=;
 b=ElQhAhx0CZKQVMe0fzqqJNXZ5fCO7uAniqVoH/yeLIqQgmZjkoNhPE8o0b1bbGPV7L
 Nps64s266p84xMvRfIfPQO+9w+LTAgRfELxwEcILZ5XJv1AEq4+UK7Gd0nkkP4e2B9L3
 ENhE/xfmmFTXef06VFjFznWppH4WHq4YW8O/H5tOwORe/7oYUsIyaWCMwyM2pzPjqOie
 hxiE9UxjWyhq52yePT3YZaBdf2BdLtKaVsr6HAByZNoy7UKfJRaJrmTcRR6nKyfa/Yp6
 Lfxsxjno445B9FD1ERqUV6ECbrQNYfaJqwG7TfCMDpXCH+2nGJEgDOqiI9UGkYLD2lNL
 Y2gQ==
X-Gm-Message-State: AOJu0YxDtNzThBYTunTf9APbioWVg5R32c/2c19dNuK2zPyqr8ma1lpJ
 2gmGeKly6D5BENRKA1bDpIC0FWWzXToS8ymcivC+bO3w9fqwh75Aanf9Eo1VSVB+G707GZI6Rbo
 O2XwD1PqoxOn2F+M8UksNSdaW1dEHLgqpUEYRfKwKRU7rexKU0MTXl8jFptEOL1SVJg==
X-Gm-Gg: ATEYQzzXd4mI6SQNZSjmsLcn4alP8m7BdsEYcdJzwV2paGu49vOIwcrDoujlw8M2Qmv
 EKN1xmbU3HWhPp/PT3qdAxXjZXwM4d+qXOPdKwwAGGWOE7iLvGhkN/gN4wYFZMAu5OE+R3XaSWs
 R4AiB3cj+QB1cV1cNutOPZmzNd4+s9RqghmOdAfCkEEUtev0gtO+YWcmTd5miQ9/P4rtMndROff
 aJnexlGO5PQWF8W8qlPkgwERn2+FZIZTvGpJKGIsegxNXASSLB/e/q93DFkHIGkTs/Xkm+DzbYs
 hRD4t6Lt9rxdwRdGRtRHvaQa9RUfis0jlLdgwrteartpdorWmtN0a8JIHVEJm2xBE1/j2x6eTAK
 5GWHNn3imVLTQmpY/v6gz+0qOOUlMsX0h9/7AE/Xcno/BH8p1B7XoOrwzgbKMMQ3YBzXaJA==
X-Received: by 2002:a05:7300:cd8a:b0:2be:142f:d499 with SMTP id
 5a478bee46e88-2be4dfc61b1mr4622848eec.16.1773067740305; 
 Mon, 09 Mar 2026 07:49:00 -0700 (PDT)
X-Received: by 2002:a05:7300:cd8a:b0:2be:142f:d499 with SMTP id
 5a478bee46e88-2be4dfc61b1mr4622815eec.16.1773067739541; 
 Mon, 09 Mar 2026 07:48:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 30/35] target/hexagon: Add locks, id, next_PC to state
Date: Mon,  9 Mar 2026 07:48:17 -0700
Message-Id: <20260309144822.877695-31-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfX4PORUb+t+YPN
 0tReaSnnhwzDGXyGr64oBdBer1kUZbj2OYJX96DJByY0QBXGIlnvPZ8+6gMp/BJnLh8vAeV9F85
 TKn1eLX+YNO3k3RwfdJEjNrOdbklkwPwUA2vRsTIj2xORrK45alp4xQ36SU9VQ6uJCtNtMe3DM0
 pK+K4dWBs8jbntc3nRCJv7Rj7G8+Myh8stF4zGVfipiEAcfCbq48q8qRScvx43NkJdE2sgxhsK+
 jGm4ClZZcBibWrxRKBV/71TMHC7JttkIzyneaeQrX1aVyvPj7rc8ycq0TFHj/k/ZFsK8pcvAdyT
 eX5czqv/7ArjI6uzHSX7HIvPzLakJyWcTqhbP3uzqXqJKuVeLHU42fSbJei7kBaQete5EB0hCwm
 fZqB1Pcim6lTmCRbBhYrS1Bi5fe18oN5dhue5mRxyZ102Sc/YPzDGDrH9u6N/RVTAtdl2oIzhhv
 mteOzxyKKtoUVvNRSvQ==
X-Authority-Analysis: v=2.4 cv=OcmVzxTY c=1 sm=1 tr=0 ts=69aedddd cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=oBxUhWXf0H1URd_o1GcA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: y8_qTXz6d14fos6wgzG1i7CBru5KXtJW
X-Proofpoint-ORIG-GUID: y8_qTXz6d14fos6wgzG1i7CBru5KXtJW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
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
 target/hexagon/cpu.h | 33 ++++++++++++++++++++++++++++++++-
 target/hexagon/cpu.c |  5 +++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 3562965c88a..b40a1c96eae 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -48,8 +48,34 @@
 #define VSTORES_MAX 2
 
 #define CPU_RESOLVING_TYPE TYPE_HEXAGON_CPU
+#ifndef CONFIG_USER_ONLY
+#define CPU_INTERRUPT_SWI      CPU_INTERRUPT_TGT_INT_0
+#define CPU_INTERRUPT_K0_UNLOCK CPU_INTERRUPT_TGT_INT_1
+#define CPU_INTERRUPT_TLB_UNLOCK CPU_INTERRUPT_TGT_INT_2
+
+#define HEX_CPU_MODE_USER    1
+#define HEX_CPU_MODE_GUEST   2
+#define HEX_CPU_MODE_MONITOR 3
+
+#define HEX_EXE_MODE_OFF     1
+#define HEX_EXE_MODE_RUN     2
+#define HEX_EXE_MODE_WAIT    3
+#define HEX_EXE_MODE_DEBUG   4
+#endif
+
+#define MMU_USER_IDX         0
+#ifndef CONFIG_USER_ONLY
+#define MMU_GUEST_IDX        1
+#define MMU_KERNEL_IDX       2
+
+typedef enum {
+    HEX_LOCK_UNLOCKED       = 0,
+    HEX_LOCK_WAITING        = 1,
+    HEX_LOCK_OWNER          = 2,
+    HEX_LOCK_QUEUED        = 3
+} hex_lock_state_t;
+#endif
 
-#define MMU_USER_IDX 0
 
 #define HEXAGON_CPU_IRQ_0 0
 #define HEXAGON_CPU_IRQ_1 1
@@ -109,7 +135,12 @@ typedef struct CPUArchState {
 
     /* This alias of CPUState.cpu_index is used by imported sources: */
     uint32_t threadId;
+    hex_lock_state_t tlb_lock_state;
+    hex_lock_state_t k0_lock_state;
+    uint32_t tlb_lock_count;
+    uint32_t k0_lock_count;
 #endif
+    uint32_t next_PC;
     target_ulong new_value_usr;
 
     MemLog mem_log_stores[STORES_MAX];
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index dc3bd82bc05..2a061d70540 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -310,6 +310,11 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
     memset(env->t_sreg, 0, sizeof(uint32_t) * NUM_SREGS);
     memset(env->greg, 0, sizeof(uint32_t) * NUM_GREGS);
     env->wait_next_pc = 0;
+    env->tlb_lock_state = HEX_LOCK_UNLOCKED;
+    env->k0_lock_state = HEX_LOCK_UNLOCKED;
+    env->tlb_lock_count = 0;
+    env->k0_lock_count = 0;
+    env->next_PC = 0;
 #endif
     env->cause_code = HEX_EVENT_NONE;
 }
-- 
2.34.1


