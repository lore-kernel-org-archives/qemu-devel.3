Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EA0CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnsC-0000xd-9k; Mon, 05 Oct 2026 14:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqr-0007lB-Kp
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqp-0005ou-MW
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:53 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HLPun2909523
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H9VCPeevzC7/ATSLky8oHmnq+dcHQ+Rd+nnvvm7M9sA=; b=dBKSMuy4zBXvWm3F
 qbHRfT+R3/VD8KY6yJfbGUOTJUNL2PjMvDYnSKGK0VChYRTBBovFwoQWSqhL0dJG
 soEQ1lZmT7rquC7ksbXzGkfxEnemanaO2XQGIgngkq4Kc4H63AoQheA6MsCAY4tC
 VPOsWmyz5igZGe1y1gpI+AjA/Sb8Ml05JEvOPRGZVkvyu7PhcRZuuyCa6hh7sDKo
 hRy7NZasuLy4r/hUf1jEEU9BiBlTq5wDxojsbujcXdIvPkpUUwdMgEmiu3+zvIhG
 hhoWaPeC23UcsL7tdcL78FhuSV7C6N1ZR4Vncrc4dgObX+FEOfb6R1co8dsB6EEs
 /UJSaA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4bhg1py4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:55:40 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33baaba6371so5521028eec.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791226540; x=1791831340; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H9VCPeevzC7/ATSLky8oHmnq+dcHQ+Rd+nnvvm7M9sA=;
 b=dH8njW9tSUqTbRTntrTSPkiIa4V+HFQCgMGncT3WmK9rNYGd5abMuj/XFwdEuGG39m
 pIaUpz85xBBHJgZpJ0S/lfHo7ZEpgPG1Scq8zfnvo3XUhjovmWoNpa6wSGX2/53eNghX
 Jg8NJ3NQUBGWgBEx0EIulJfGGd3FWWeB339W6ggwdaAz24YWrar4vpjwkcofKAtFsJJG
 Gr2vbC6YOMpJueyc2MQIuc7TOKr8RfRWeqQoKzhddAdN1eoXMS5Fxm33Yy8asgy64scO
 9mQ2cF5J0JlMHpH7QPSGd2ORS2++NXY4eFb1KZn3CZyuMtMvh5kX1m/8jfnVH0Lyijkx
 HWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791226540; x=1791831340;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H9VCPeevzC7/ATSLky8oHmnq+dcHQ+Rd+nnvvm7M9sA=;
 b=YuzvbiKiYtaRFiQAgXEZwoHjstQr6MJJ2qhT2zOGMGL7cA5eL3drgBtIlJh+cLHmqZ
 TSVRiZPLiLeOuakg9sL2ybEdo1EabrJRGRH0tXpmjakvzzmJp3qTn8bht+LQGZXTDmAO
 67dnBxUX5DtonZ0Fretw3+tNBin1XBXa0JFj5flFaKFfnOFToeplgVpdFpjkHT2L3YYj
 N0HlecoIBmJjklU5XQySM2OmkanixXl1GNFu0q6f8ulIbGVPvl24rPlwpy+qchKIbTzH
 8UH2ubT2ZTjLoRGj0fPuvfxxOsLnhdeRxEaNIpwpPy6eScgkILd6PmpoBO2GwsjMKb6E
 fomA==
X-Gm-Message-State: AFuF++n2SChwJe+esEbcoEOX2aXMMeGmsD5VCzHLQgVDe8MnFcegdDej
 mptH+JZH2sN3BtGx3RB86/wQ9YjLoxKvJf73OFamenyV+6rCqdY/WZ3ghjc8gDnN5idmnN73ois
 fWeFKoPYa3blc8W4zGpIy/jZ9MhlIMdUhPWVfbSIeqibLPy/JYZpYTE+m/hgtmqc2Rg==
X-Gm-Gg: AYBFou11CJE3Ra7SLU+TKjV7LipKk1M3Nyd5me5TBrTiJQSJh9dX1xWxGdYzGF/eV0C
 4o4cJkuhWucUrFxuVQnOUr3ckQ+qh+NJnCMnmbBUYD9NOUMZ+K+VDBLAVF4cDrDigAyi6idOFfD
 GDKekPCG48QAu3dFXBwSP/F/kFVkdAj0vJ4XlqZQHBvpbCB197/ve2M/WRux0Rg9ojrkt34UOEw
 DbvTXo594qo/XQFQD5lan61Nf+KPQUZ4wC6+cUgxGgPHzyXGyAlNTunHS/hEzaAaQcvL8YOMW8/
 roe/ekVu1QovDZuIjDQFmEMLVIJXrY/k+/HWrbzj5n4hTtyk7vNdWpsv6lc6VmZYYLm0cgT8tLs
 B8TkeUU/wg2cUOFjUgEj1VeOpZMCa/2ZpYubWV7DhdGObRRYC0oBXDg2Wb6/w
X-Received: by 2002:a05:7022:ed07:b0:143:3617:c5ae with SMTP id
 a92af1059eb24-14f58de4ca6mr13524656c88.2.1791226539471; 
 Mon, 05 Oct 2026 11:55:39 -0700 (PDT)
X-Received: by 2002:a05:7022:ed07:b0:143:3617:c5ae with SMTP id
 a92af1059eb24-14f58de4ca6mr13524621c88.2.1791226538698; 
 Mon, 05 Oct 2026 11:55:38 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d7234c2a2sm602092c88.0.2026.10.05.11.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:55:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 20/22] target/or1k: prefix symbols conflicting with other arch
Date: Mon,  5 Oct 2026 11:54:56 -0700
Message-ID: <20261005185458.405929-21-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: l9mkZCiVsGvmQA1YTC1VWs6VrVbpgInu
X-Authority-Analysis: v=2.4 cv=GMGdgeNK c=1 sm=1 tr=0 ts=6ac3f2ac cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=AdNZe4pZF3z2CvZGRDoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX9+0KKMnHVcw2
 Dok68ngJFQEzwI9EQtIvBKzFaB+1kLV4H7aLx5jAyrh4xwaCdbKe4I1DTErSDN/FVIiVo/D8WHy
 ZzNzkcCda9BoCzLqia0gA8YGfsYsMs4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX1MhhhSU7kB0p
 2/cfee+BqV1T2nYp2+wMo+zcXhf072miHKEcKfdFXwed+DTcltNKFW+hLUQd+pw+M6LtGZUKor/
 nO1bd3LseDeDqk1SwdybpgpIlcKYo2GsZVtmynnaS+T2mwgYOWizM9VJUiguFWdRKjIsU5LHlEH
 cFynfNG6DYUyCmpb/36AbKNuI4f5VQJFI6+L6qJ5tL1jV7oP6tRBc9wuRiT2cP45yh06TIPq0Ja
 Pca4K4X6Qa3YkRGtKX1Me9WhWKBL49gaeiPQLkFUabojVJRLL+7zcfg1PmMP6ouPq3wiZ+hWTks
 BWMmreX21ih6PEza0N1jKoaCVxvw8NdlP/KYWgb843Q4dNArync4dO3U7rhwVdbxo7ya5W1E4Bo
 Xs7RyTVbQcH8ROJ/4HEqbpcXkWKWO/PqdMuFHVSe74zrw20QqJ2p3qUref5skCPVyhnvyDluG2o
 bYYJXs7uVGMCS7v3rQg==
X-Proofpoint-GUID: l9mkZCiVsGvmQA1YTC1VWs6VrVbpgInu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050074
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260930020108.217892-21-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/or1k/exception.c        | 2 +-
 target/or1k/exception.h        | 2 +-
 target/or1k/exception_helper.c | 2 +-
 target/or1k/helper.h           | 2 +-
 target/or1k/interrupt_helper.c | 2 +-
 target/or1k/sys_helper.c       | 6 +++---
 target/or1k/translate.c        | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/or1k/exception.c b/target/or1k/exception.c
index 0479a069592..785181ef2ed 100644
--- a/target/or1k/exception.c
+++ b/target/or1k/exception.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "exception.h"
 
-G_NORETURN void raise_exception(OpenRISCCPU *cpu, uint32_t excp)
+G_NORETURN void or1k_raise_exception(OpenRISCCPU *cpu, uint32_t excp)
 {
     CPUState *cs = CPU(cpu);
 
diff --git a/target/or1k/exception.h b/target/or1k/exception.h
index f62fc314c1f..ff42f91d2a1 100644
--- a/target/or1k/exception.h
+++ b/target/or1k/exception.h
@@ -22,6 +22,6 @@
 
 #include "cpu.h"
 
-G_NORETURN void raise_exception(OpenRISCCPU *cpu, uint32_t excp);
+G_NORETURN void or1k_raise_exception(OpenRISCCPU *cpu, uint32_t excp);
 
 #endif /* TARGET_OPENRISC_EXCEPTION_H */
diff --git a/target/or1k/exception_helper.c b/target/or1k/exception_helper.c
index 3bd82b29719..a5c21d1b65d 100644
--- a/target/or1k/exception_helper.c
+++ b/target/or1k/exception_helper.c
@@ -27,7 +27,7 @@ void HELPER(exception)(CPUOpenRISCState *env, uint32_t excp)
 {
     OpenRISCCPU *cpu = env_archcpu(env);
 
-    raise_exception(cpu, excp);
+    or1k_raise_exception(cpu, excp);
 }
 
 static G_NORETURN
diff --git a/target/or1k/helper.h b/target/or1k/helper.h
index e0a8d402271..9f74bed93af 100644
--- a/target/or1k/helper.h
+++ b/target/or1k/helper.h
@@ -59,7 +59,7 @@ FOP_CMP(ult)
 #undef FOP_CMP
 
 /* interrupt */
-DEF_HELPER_FLAGS_1(rfe, 0, void, env)
+DEF_HELPER_FLAGS_1(or1k_rfe, 0, void, env)
 
 /* sys */
 DEF_HELPER_FLAGS_3(mtspr, 0, void, env, i32, i32)
diff --git a/target/or1k/interrupt_helper.c b/target/or1k/interrupt_helper.c
index 1553ebc71b0..91dd2227442 100644
--- a/target/or1k/interrupt_helper.c
+++ b/target/or1k/interrupt_helper.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 
-void HELPER(rfe)(CPUOpenRISCState *env)
+void HELPER(or1k_rfe)(CPUOpenRISCState *env)
 {
     env->pc = env->epcr;
     env->lock_addr = -1;
diff --git a/target/or1k/sys_helper.c b/target/or1k/sys_helper.c
index 8ffa31b84fd..ee0cc434675 100644
--- a/target/or1k/sys_helper.c
+++ b/target/or1k/sys_helper.c
@@ -58,7 +58,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, uint32_t spr, uint32_t rb)
     }
 
     if (is_user(env)) {
-        raise_exception(cpu, EXCP_ILLEGAL);
+        or1k_raise_exception(cpu, EXCP_ILLEGAL);
     }
 
 #ifndef CONFIG_USER_ONLY
@@ -157,7 +157,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, uint32_t spr, uint32_t rb)
             cpu_restore_state(cs, GETPC());
             env->pc += 4;
             cs->halted = 1;
-            raise_exception(cpu, EXCP_HALTED);
+            or1k_raise_exception(cpu, EXCP_HALTED);
         }
         break;
     case TO_SPR(9, 0):  /* PICMR */
@@ -231,7 +231,7 @@ uint32_t HELPER(mfspr)(CPUOpenRISCState *env, uint32_t rd, uint32_t spr)
     }
 
     if (is_user(env)) {
-        raise_exception(cpu, EXCP_ILLEGAL);
+        or1k_raise_exception(cpu, EXCP_ILLEGAL);
     }
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/or1k/translate.c b/target/or1k/translate.c
index e00ef45b9b7..6972dc7d630 100644
--- a/target/or1k/translate.c
+++ b/target/or1k/translate.c
@@ -1110,7 +1110,7 @@ static bool trans_l_rfe(DisasContext *dc, arg_l_rfe *a)
     if (is_user(dc)) {
         gen_illegal_exception(dc);
     } else {
-        gen_helper_rfe(tcg_env);
+        gen_helper_or1k_rfe(tcg_env);
         dc->base.is_jmp = DISAS_EXIT;
     }
     return true;
-- 
2.47.3


