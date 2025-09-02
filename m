Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C36BCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI0R-0007He-Kd; Mon, 01 Sep 2025 23:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0G-000746-Vt
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0C-0004WC-GS
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:15 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RqSO017322
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ez9CPisJo+6c6MuYDInXx9ZMS/0b1em92YuMNu0aV8I=; b=XoyJxBdZnWeNJWWD
 SkoNK0/+YaSczXLXU9RTdZEHidak8pBIaXy5gjlSqt1MEO3BCWNMlcW1eFyV9AwA
 WTGdMZEohGoalMnrRhZUFvVkq29wdXlVe4EzCpYlNZzeMmlX7uFakqAbPy2ObLaD
 3U9wVnNp59S0HBUZFLB6zu1a24KPQfsNOIE2UXV4xh8OWrGIEhIYU9bg3S3v9BV+
 UMl4Kh9G6cBgY2BaDXCARVuMF6Pgm6CselBmQew9QvG9A5mSOikAZTxJAOtesrrR
 6ToPxI5NC1GU5gQS8S8C5h/yWvM2qzeFzKUOwHLp/LWLyvIxFc0K9n+3MTRHPxcJ
 UvxWUQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk8x86v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:48:01 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b47253319b8so3865290a12.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784880; x=1757389680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ez9CPisJo+6c6MuYDInXx9ZMS/0b1em92YuMNu0aV8I=;
 b=d2vIbe7Ac5gl9JjzgTYk8+KR900iULxzU7nMYaqXqodFZYkFLZXPXeVcWyEK+HmcAh
 m2sN7MfnARg1yDEV0t3jLufE7cJo0tNMa4gwCRufSbOCNX7FyrmHaK2alsWnm3LUAQly
 yU4qBytMMpzV1nIX5nByNcMbAEykY+1fwjwyOf655cjN+lOdyGQM0o7Jv54e3fmgeY1J
 l/5n8XgrZ0aw5b0WL+pid7vH8LvmBP48lbxybwNG/SNoj0IEVjQ5+DXCrPfruHwXmfG5
 NFCCu0gRKDa72zCgG6PWdVW32QfR5cNrniam09TKh+wUQcCAEaKo8d9Z1JdtauIdlmGa
 hjeA==
X-Gm-Message-State: AOJu0Yyl8sszqgsH60EQ8mHDBwZY/hBEoJQSjgLpylPAYRasvfrK4v3+
 IgKpR5wOjidN9+6SOfgHfhoG/Wsvked0gg/oqHXxZEIS2YvPiRh2v2RcTrYiNv46OLkH0A4HvE6
 pnea/CCZttbitBDJ+h+ugjO4jNbLsBBnsos8z83q8chJ7jmk72KOnCK7Kd6u9PLVAqJrJ
X-Gm-Gg: ASbGncsQsnZyb75YdYtC7a88dYtEIkAbSJKzgYIx/ufVNaoTjVQ81P0HoelLxJJIAep
 wKYtMdtls2CbDU850791fMQHW0CZZwP3UgBwBcODtZOIEoxqFX9EiCb+EFlrj6VTrPL0AO/yMTm
 x/16zqoRgLuOAqKGuk9h8pkq5rxLoajIcqvg2EZgbPpOF8eEl5+uwh1FO9cA+rOFShtkotVdoav
 f6iBvWp1QKTNu0Y9RF1KD9QuwnhGFjUZ3MTNqWdtI8Ien0w7vKhzOmeOaTPDaJ03mNsiII+LRe4
 zFIFGeiqxNz9PmcXGYoks+W8y/SM6/JTxsB5KymWIpZFHZ66O8IhYdt7IeyqDt+iuEDhKa6bkoq
 xLScmykTHtoyn
X-Received: by 2002:a05:6a20:3ca3:b0:240:101c:4417 with SMTP id
 adf61e73a8af0-243d6dc809bmr13877375637.4.1756784880143; 
 Mon, 01 Sep 2025 20:48:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+SamdyP0nffsEJy9XA/iGX7YcrGqz6IlT/ncyV/yNss2vHeYwYP+9/Sg2C3kUV9EHUMq1PQ==
X-Received: by 2002:a05:6a20:3ca3:b0:240:101c:4417 with SMTP id
 adf61e73a8af0-243d6dc809bmr13877338637.4.1756784879627; 
 Mon, 01 Sep 2025 20:47:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 32/40] target/hexagon: Add locks, id, next_PC to state
Date: Mon,  1 Sep 2025 20:47:07 -0700
Message-Id: <20250902034715.1947718-33-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iyD_Xw6lyt_4s9HylYciulDRDC4nCt3W
X-Proofpoint-ORIG-GUID: iyD_Xw6lyt_4s9HylYciulDRDC4nCt3W
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b668f1 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=3yPDquGOu9_QmsYTTv0A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfXygo7d9Hxryb2
 QdljtGxYu0aeD2B2ywByWgSlcCrmLITOSGTUIMXjkjcLI/AUr3U3TnlXTwoNd7YDqJWNQFfjlea
 NcFSrHrlPADvHZlfmWDOVyayzgPwLSG75JlPehAH+XXH9ioaEVUdlAQoe4wxiuplxqwnfeRE3Qj
 Mxu70ZYX3b/EPQnuR/EIN3tca7lFa1+rLA6SgUPMBfPYO4TSitNPylHx9JksvTp7BAwCF0SKeZ3
 cF/ebG0Z7/mZsXX31FCOElLzaLz4uctWQAV3I0bvOdv/rB1xceP2OHsApO+TfsQ8m5PytNt2i61
 ok7qSjRceWzZfBhm6XaHhZhqA2AEIuraEIeV4mZbrE79vFID5NOLlOOJsnMFrubA8m4iHfnShu8
 QF2QSh7d
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
 target/hexagon/cpu.h     | 34 +++++++++++++++++++++++++++++++++-
 target/hexagon/cpu.c     |  4 ++++
 target/hexagon/machine.c |  4 ++++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 42b877a04c..fc6552e64c 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -46,8 +46,34 @@
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
@@ -103,7 +129,13 @@ typedef struct CPUArchState {
     target_ulong t_sreg[NUM_SREGS];
 
     target_ulong greg[NUM_GREGS];
+
+    /* This alias of CPUState.cpu_index is used by imported sources: */
+    target_ulong threadId;
+    hex_lock_state_t tlb_lock_state;
+    hex_lock_state_t k0_lock_state;
 #endif
+    target_ulong next_PC;
     target_ulong new_value_usr;
 
     MemLog mem_log_stores[STORES_MAX];
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index bdc9d18395..a508f27fe4 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -301,6 +301,10 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
 #ifndef CONFIG_USER_ONLY
     memset(env->t_sreg, 0, sizeof(target_ulong) * NUM_SREGS);
     memset(env->greg, 0, sizeof(target_ulong) * NUM_GREGS);
+    env->threadId = cs->cpu_index;
+    env->tlb_lock_state = HEX_LOCK_UNLOCKED;
+    env->k0_lock_state = HEX_LOCK_UNLOCKED;
+    env->next_PC = 0;
 #endif
     env->cause_code = HEX_EVENT_NONE;
 }
diff --git a/target/hexagon/machine.c b/target/hexagon/machine.c
index 988ede06e9..18c3f87188 100644
--- a/target/hexagon/machine.c
+++ b/target/hexagon/machine.c
@@ -19,6 +19,10 @@ const VMStateDescription vmstate_hexagon_cpu = {
         VMSTATE_UINTTL_ARRAY(env.pred, HexagonCPU, NUM_PREGS),
         VMSTATE_UINTTL_ARRAY(env.t_sreg, HexagonCPU, NUM_SREGS),
         VMSTATE_UINTTL_ARRAY(env.greg, HexagonCPU, NUM_GREGS),
+        VMSTATE_UINTTL(env.next_PC, HexagonCPU),
+        VMSTATE_UINTTL(env.tlb_lock_state, HexagonCPU),
+        VMSTATE_UINTTL(env.k0_lock_state, HexagonCPU),
+        VMSTATE_UINTTL(env.threadId, HexagonCPU),
         VMSTATE_END_OF_LIST()
     },
 };
-- 
2.34.1


