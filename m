Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C01606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XRJ8C3el;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W/Nc5axh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0ng-0001yU-QO; Thu, 22 Oct 2026 17:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nd-0001xF-MM
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nb-0000L4-So
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:13 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MKWoJO3413294
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=51uyD2X3Hep
 3I+d82qaj9PfMUCgI29NTswl9/CtA4XI=; b=XRJ8C3eljZth5EMhyhxFRyLhOaC
 TBqkjTqu6V0hllVnQpoKmiZdMK8aR+ZlKpi4dJIcdOSteBC+FIOdR9fA3TyD0SCq
 EAsXLXtMdqoStndXN1N2tAgCr26iP06v+rqLKISwYP26socGTZy5hKBgGzoVdwW/
 sO8H4ItaU/x600rMcE+FLLkShUJWYshD/ptr1ByHoCtFOk0RjRJhhBAROM84r3mD
 q1STsmws6Tr+8i64ly6TNNNWT23qw/ThE75VlDWAzzKiNF2QPA2I6gX9eQ9fxSM4
 IFAxQseo9GCX9kRiu0vyALGPOKVJ0EkfXnoL30fdtOFY/zBxLurN5DchLoA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmar8dx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:10 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ea63087d79so1754425ad.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706290; x=1793311090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=51uyD2X3Hep3I+d82qaj9PfMUCgI29NTswl9/CtA4XI=;
 b=W/Nc5axh02zqoiBmSr3VZMc+lrCHq16LpvlFY2ZzdQT85p6L+H/A8zv3DHvZBFgT/E
 2mGPbZwKhsQBvOZn50k1nR8l1NNPJSFiXNQ3V0SRJWZaPnx7OZtoV3ueQIx0zjgfvz4u
 HbwMdxKfIdeVVdtFko2CHlsTNmcMHHONcy1QGR7i3JRB2quWbk+B2v+U7fxnlwpZszlk
 VjZL6yZpCRGhH030WSiwBusKuiK0uygKd8JEtV91412UfFdy5tzMJWoduXUbm/2YzzYn
 zBQmYTlCrEH/Y1+Jul//81WHjgXTYnqoV5LgW6k+ddV/Z/xCeA3pP67rQPYU/Wkk17Y/
 6ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706290; x=1793311090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=51uyD2X3Hep3I+d82qaj9PfMUCgI29NTswl9/CtA4XI=;
 b=Z5fUft2BzzCjT00x6M5O+jgGTn/LQgT375wWaHdZEEIAqdGgvlmea8yKX4O7plQc+i
 Mo4eyovFmpFyqZog2bpiwCHuxmYTAolvXXMIBgPccRtZXnRb/8Y6BR+a2nSty2OLd/GC
 q/fLjjSG6XWzFt97S25JEeaZBesF9DubWR/2qPGi81l5PsIn1kgrKmPmrQKzI5C+dxI7
 JH3MDhfOLj5aoAKIjUwANyh+fSQagVlon2/wL+TbWyVIzLn6ZZ7Pt3RAJr124gtaJVFI
 bbkj+YNaSW/mppd/2KLwrae18GDWcBXa4n4kVGTeeONH+gcFKNesg/sIDGXbghrvqNyl
 9W5g==
X-Gm-Message-State: AFq9FYJGD+sFNHQWoYjQ7ceg7G6pegwBSevFSnPa+Jq2tp3hVR1q/bR/
 T8Crl56web+eAlm7imqQWdrjVZDrx9O7XiMIYAtXJJUA2q68LiVFecKpACb5L138gF0DOGJL4Dp
 ndhpw/LCk9cDQxq9iAR9F/p4dXp/Vm68mJ43xrpkZBrhXwRTZmB8h/wfMTSqM0ZyJFw==
X-Gm-Gg: AYBFou0PmrhUneulaNIt3DbsiZxtLBfuqT6KhlBS7k6aVmjDXOw0rm1vc+iliy6t7pe
 nhAOuiXRSQl6dUuG74uiTdYQZtb8FnwQgL0KO/cOV0P+A1WQiGie9pIiHRxcft+PgazKgf9KD05
 uVPKglVrvfKHXzXSbhIwy/Rx0unjFe0Yb3kgS59BjUsK/gV/1M2GL4rXOy6FEcaB8o4u8dGWwHo
 Cu4SksMAHm8/8gSENWpWBnWXQNfzqQrtywbfw1CfzWGsL61+Vb/zn0sM7pFYOz/AyEF9cnqZKiN
 aoJSAM8CwmN6EVc0ttshXx4t5b3o0N4/VM0lk4OgQ6D1yNQZ/q9b60S9mQuOqj12zUBbuDAEYXd
 /C5NOwvCNJ/QqVZPmCko8DLbc4DoPmL5ejpBttm96WL9+CC3oB5UmO00oNpFEMLc=
X-Received: by 2002:a17:90b:56c6:b0:3a7:bb1d:3688 with SMTP id
 98e67ed59e1d1-3adce0031d3mr181478a91.27.1792706289826; 
 Thu, 22 Oct 2026 14:58:09 -0700 (PDT)
X-Received: by 2002:a17:90b:56c6:b0:3a7:bb1d:3688 with SMTP id
 98e67ed59e1d1-3adce0031d3mr181459a91.27.1792706289338; 
 Thu, 22 Oct 2026 14:58:09 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:58:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 22/27] target/arm: rename qmp_query_cpu_model_expansion to
 qmp_query_arm_cpu_model_expansion
Date: Thu, 22 Oct 2026 14:57:41 -0700
Message-ID: <20261022215747.2479440-23-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6ada86f2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=7UvLiwb0lT3xj6fr-RYA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX8w4oy+tE87BJ
 OarPZYrZ5QU3AW5cdjRRSzKPdYy8XE+p5xX4nhrKt84TEgrH9EOoOqCXXecgsHz1xwdOo2fCCxG
 rcP8WxA6a8uRrDbToJJ4u3bt8zaSSoE=
X-Proofpoint-GUID: Um8TPNMs7-omG8OaKLMkNxutyzfEqwLe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXxd0hwdOS+oJt
 AqA5Z62X9XXb7/oa01qT3hdDcN+WlMMrz8JkkvVIvwJI+6IyzxVAevgAG5C2THEMm7FFrIawzTc
 g7ZibOI+m8YEZSyV5z2iqA/FV0nQJItg9d2jOBNWrQq8sAHIW2Iyqzq/2sBLM3p/9//H1cwp8t7
 27+Kw6MOET5HoJ7Ou3wm9csKv3rbSpMqjdmHRg4twkcAJ5fU2JljUG3zKQipyiu7L/JHNaA7tvI
 SHaweak1267y9a9lrWVDNvHC2Xovo0ydL/3xKWQurXkvynDmpR2B97NlWZDeOimuRYogiq5Lvaj
 8AJzdGsYD+/TTciP9rQmdb6DDpGZjyVQgXXicthjlejMHPL56eKHYS4GhncqJiaboYwP6LKRfjD
 dD9ihA0f31Ks5aPbCk6MWqo5sT4kXa45bkP+GQ/NU/Pj6xCMDg8h0nuaRNncciwnAtfewGnA6Ph
 MH/VCCPbWEKXr+u1KyQ==
X-Proofpoint-ORIG-GUID: Um8TPNMs7-omG8OaKLMkNxutyzfEqwLe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In a future commit, a single target-agnostic qmp_query_cpu_model_expansion()
will dispatch call to the per-architecture implementations based on
target_arch(). Rename the arm implementation.

We keep the existing qmp_query_cpu_model_expansion() function to not break
the build.

Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Link: https://lore.kernel.org/qemu-devel/20261016162509.24854-2-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/system/qmp-cpu.h  |  5 +++++
 target/arm/arm-qmp-cmds.c | 15 ++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/system/qmp-cpu.h b/include/system/qmp-cpu.h
index f0e0d427e3b..d2e7c76ca25 100644
--- a/include/system/qmp-cpu.h
+++ b/include/system/qmp-cpu.h
@@ -17,4 +17,9 @@ CpuDefinitionInfoList *qmp_query_ppc_cpu_definitions(Error **errp);
 CpuDefinitionInfoList *qmp_query_riscv_cpu_definitions(Error **errp);
 CpuDefinitionInfoList *qmp_query_s390x_cpu_definitions(Error **errp);
 
+CpuModelExpansionInfo *
+qmp_query_arm_cpu_model_expansion(CpuModelExpansionType type,
+                                  CpuModelInfo *model,
+                                  Error **errp);
+
 #endif
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index cef0c27db65..2614aea258f 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -80,9 +80,10 @@ static const char *cpu_model_advertised_features[] = {
     NULL
 };
 
-CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                                                     CpuModelInfo *model,
-                                                     Error **errp)
+CpuModelExpansionInfo *
+qmp_query_arm_cpu_model_expansion(CpuModelExpansionType type,
+                                  CpuModelInfo *model,
+                                  Error **errp)
 {
     CpuModelExpansionInfo *expansion_info;
     const QDict *qdict_in;
@@ -202,6 +203,14 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     return expansion_info;
 }
 
+CpuModelExpansionInfo *
+qmp_query_cpu_model_expansion(CpuModelExpansionType type,
+                              CpuModelInfo *model,
+                              Error **errp)
+{
+    return qmp_query_arm_cpu_model_expansion(type, model, errp);
+}
+
 static void arm_cpu_add_definition(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
-- 
2.47.3


