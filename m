Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBA3C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyX4a-0005F2-H1; Mon, 24 Aug 2026 11:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4X-0005EJ-Qk
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4U-0001mm-4w
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:52 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OFn4hB3235077
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5Q3vSgaRBAr
 gnEpEaaVnRHY3RuijklXgIkOH4pqcrtk=; b=ePcsD1Vl73CrqndNzk3gn9OupDv
 DtPY5aT1CGKQfnElmoacHzP+OnoK2TZTOMhdcg4/juo1aaCfBHlZ1Yo7UEmSWykK
 fqWp/vNuAcDxOoDpBP9+sxUHOmdhPx1Uk97wF6B2wBCiQUuTu+NS0DLBUFUnsgKj
 ONfOj7cZYPH0klKdOTSFIgpjORnmkc6incomsHK4pAuwwJvnNjzMDVjuOJiQKpiG
 ztK9JLA1W2P5YC+QSpglGmJmXiivqvunwKVuSClUIKZ0UEXHrSo+Xm+aUYH6bBZW
 uVE9KYNKTUoiMRvtveWc2Nwu7Hlsz1jdsdnqZHVqrUXH2FmqBsVW7JE1JWg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8gqnab1g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:38 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-388b404eaa4so5723332a91.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787587118; x=1788191918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5Q3vSgaRBArgnEpEaaVnRHY3RuijklXgIkOH4pqcrtk=;
 b=RwOjJXMiAGFpHR8N3aR48YDZaF2cL+zY0RzyGnrfhXI5g3r+QDZvMSzqicX5hy9xHL
 /rR+GCn2mOTYCG9jpfygaIgGhMHtwPd6P0Kp/9AG20GTYcEnQ3UEpDGqv2wCYhvgPycG
 htI7YMrqjV2WT32WrT14Dmh2LjK2YJPjTegi3nlpbwn7AFPf1/X9paXnuaGVoDeam2Tf
 L1E07A5TDq3z5gWCg9yOZs0iVXbDPlIdpdhbkw8YxSP1lFeSrXAc04gMDfIbyov2HhCg
 1/LMCs48oGgtyg/uanWZkDbpIv9Y9cAMwnBQRwFEWtnSzoqczrZP6wXoqVNqGs056jTB
 SfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787587118; x=1788191918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5Q3vSgaRBArgnEpEaaVnRHY3RuijklXgIkOH4pqcrtk=;
 b=tSM5qqepKrSMa4DqzhThND/2K7wbt6Q6en1j8kd5ZIQ5Ha4BNgLJXza2WHksPhgCr1
 eqCf8EKRhrWtkM/8b5YOYdzns0Jr8rSHjDP+EK+yJeR2Z+jv4q4q60wd7HIpjFDXTxqW
 LQy2PTFXHiQEzColGNwoOPI/RZ+414jVtI5FgTHlrpH5htXZTKsxX8gS7vX+QoU9Lc3K
 REURYWdsp0Q6HaRYEj6gd3ypFyNMqvZJ80c51GKCXG99sv1bSXyfMbdMTAjluSYx6gQ0
 lO0gw6RirZ38Msw83NC9xrjpSrxpTKhusgCF4NkdmMlNqUKm+nE43TcTm63CPnbNgQgj
 Herw==
X-Gm-Message-State: AFuF++mE/4EsgyWrNujY4TlIvOFx9vtDK+EmtkSSTATmB2tPD3AWkq7y
 JTHxvSciOEcaOaDKssN5HxRWAYcimBdHFT2yJMXdkifwCkQlPPxyfzmZn10e280A2SCPtRDCLCR
 92AxjB6FHdlHp8+vYkbi8vIniEgCjOkka0RWROyn1uSICT9HD8ad1j4LYrFtFd8IgOAx7
X-Gm-Gg: AR+sD133Ua0+6L4q/d1xTgnAm1fX+ZLb8VePQBULpRizoYHCHvJZMgajmOELxc2crBn
 PNaiGb+IsfX/iH+zpK5/bzR1ge4E839nCv5tJtIOQmnmZ1aqa6d8VL6r8kusA+J/TRYJn97L0GA
 /a1SkMGrBqtSfvwamOEPdodHVKNU5xJGkkGf57OtYXucFXjka1g84q6jqQRvJDacK+J8KBoabh5
 SgTjiw22odizYovAS//e8tmVqBuNAK7hbQF01nyeVPjalHLI6zRG3j00hMavIQLWAWEAuQbYiAs
 8xWvtY5F4XaQigL+96s1FNUHZQbnZJerhB4y3KyL5iuR3yFuiqaHzj+1X5xtCNjVIH0jBIfHz4S
 7z7bcd6jemdqFbIg00ff+MYQcT/RAl3GMaiXlUtOG44qo9AJ6dYWBWIkXhki7xMY=
X-Received: by 2002:a17:90b:3911:b0:38e:2860:253f with SMTP id
 98e67ed59e1d1-395df2926d9mr33657376a91.12.1787587117925; 
 Mon, 24 Aug 2026 08:58:37 -0700 (PDT)
X-Received: by 2002:a17:90b:3911:b0:38e:2860:253f with SMTP id
 98e67ed59e1d1-395df2926d9mr33657262a91.12.1787587117423; 
 Mon, 24 Aug 2026 08:58:37 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14186183c0esm41152935c88.12.2026.08.24.08.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:58:36 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, anjo@rev.ng, brian.cain@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH v4 11/14] target/hexagon: add COREDUMP semihosting operation
Date: Mon, 24 Aug 2026 08:58:20 -0700
Message-Id: <0664a4a5a9f85a4d61a03f5159f0a76bd2c9e0f3.1787586642.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfX2B3F15iBcQjJ
 8DeTuKXPP7WcGmxX2lA/XuAOQnMRKxuPkVR/98rUcjUnGMbOSNL1Ks9jth7RKcXMLURWCgiO6fK
 2PQlWQU6EImxLmoSxAAzBospLdfB54I=
X-Proofpoint-GUID: K7ISaOc_vWkH1vrpcwroAWbj_kjyCrI0
X-Authority-Analysis: v=2.4 cv=fqXsol4f c=1 sm=1 tr=0 ts=6a8c6a2e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=BE4lvaXKYeXNScGiURoA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfX/VU6Q+KAVgI6
 MhG6l471eKXhAAR9Uxhd+bOalY+VwtSt++Smw3YBGKSCJTiEadQAsQ9Q8juabq89TEmQscP9dwK
 3+JvLrn9sT256x/FAPFPq6uNuIyc2/8/PhcnFfJ+U9XZeIbwc9jb60Us2Cvb3JpifU6v/zQ3Rna
 eHfy7mm9kTBBFMLaA1FNKFt1CwlJLi8iEc7ZTBt8MNmvbofpwb9XMYg11noQMM+2H4VhZBvmMAJ
 avBcW34suBrtyqNfEqHvLd4VpSOVXkcM47jcc8HF2VYR2/9kwY7o4xnqg7CJJeorfMx2Asc2Ue4
 X1sUMLcZV7YWjQgRoTauaSsbwz8qTvhFeD6Ab346n5sMTXLeirtN8gi4kSXyUL+KFCSKjG8KW9m
 SQbRbTy2WGCKrwqSR9aC0ZyJmcNNM4V4BvAWOb+yyme7SCRNkSs6qsl1uwG3eyLUBAx+5ifMjfp
 vXvj/UNI3ENudR6nA/A==
X-Proofpoint-ORIG-GUID: K7ISaOc_vWkH1vrpcwroAWbj_kjyCrI0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240134
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

Baremetal Hexagon programs invoke SYS_COREDUMP (0xCD)
through semihosting to dump CPU state on a fatal exception.
Implement the handler to decode the SSR cause field and
print the full register file, matching hexagon-sim behavior.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/cpu.c      |   2 +-
 target/hexagon/hexswi.c   | 136 ++++++++++++++++++++++++++++++++++++++
 target/hexagon/internal.h |   1 +
 3 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 134fbb2cfa..acb1715a4d 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -235,7 +235,7 @@ void hexagon_debug_qreg(CPUHexagonState *env, int regnum)
     print_qreg(stdout, env, regnum, false);
 }
 
-static void hexagon_dump(CPUHexagonState *env, FILE *f, int flags)
+void hexagon_dump(CPUHexagonState *env, FILE *f, int flags)
 {
     HexagonCPU *cpu = env_archcpu(env);
 
diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
index fe588d9489..5e7f655a41 100644
--- a/target/hexagon/hexswi.c
+++ b/target/hexagon/hexswi.c
@@ -162,6 +162,138 @@ static void common_semi_ftell_cb(CPUState *cs, uint64_t ret, int err)
     common_semi_cb(cs, ret, err);
 }
 
+static void coredump(CPUHexagonState *env)
+{
+    uint32_t ssr = env->t_sreg[HEX_SREG_SSR];
+    FILE *f = qemu_log_trylock();
+
+    if (!f) {
+        return;
+    }
+
+    fprintf(f, "CRASH!\n");
+    fprintf(f, "I think the exception was: ");
+    switch (GET_SSR_FIELD(SSR_CAUSE, ssr)) {
+    case 0x43:
+        fprintf(f, "0x43, NMI");
+        break;
+    case 0x42:
+        fprintf(f, "0x42, Data abort");
+        break;
+    case 0x44:
+        fprintf(f, "0x44, Multi TLB match");
+        break;
+    case HEX_CAUSE_BIU_PRECISE:
+        fprintf(f, "0x%x, Bus Error (Precise BIU error)",
+                HEX_CAUSE_BIU_PRECISE);
+        break;
+    case HEX_CAUSE_DOUBLE_EXCEPT:
+        fprintf(f, "0x%x, Exception observed when EX = 1"
+                " (double exception)",
+                HEX_CAUSE_DOUBLE_EXCEPT);
+        break;
+    case HEX_CAUSE_FETCH_NO_XPAGE:
+        fprintf(f, "0x%x, Privilege violation: User/Guest mode execute"
+                " to page with no execute permissions",
+                HEX_CAUSE_FETCH_NO_XPAGE);
+        break;
+    case HEX_CAUSE_FETCH_NO_UPAGE:
+        fprintf(f, "0x%x, Privilege violation: "
+                "User mode execute to page with no user permissions",
+                HEX_CAUSE_FETCH_NO_UPAGE);
+        break;
+    case HEX_CAUSE_INVALID_PACKET:
+        fprintf(f, "0x%x, Invalid packet",
+                HEX_CAUSE_INVALID_PACKET);
+        break;
+    case HEX_CAUSE_PRIV_USER_NO_GINSN:
+        fprintf(f, "0x%x, Privilege violation:"
+                " guest mode insn in user mode",
+                HEX_CAUSE_PRIV_USER_NO_GINSN);
+        break;
+    case HEX_CAUSE_PRIV_USER_NO_SINSN:
+        fprintf(f, "0x%x, Privilege violation: "
+                "monitor mode insn in user/guest mode",
+                HEX_CAUSE_PRIV_USER_NO_SINSN);
+        break;
+    case HEX_CAUSE_REG_WRITE_CONFLICT:
+        fprintf(f, "0x%x, Multiple writes to same register",
+                HEX_CAUSE_REG_WRITE_CONFLICT);
+        break;
+    case HEX_CAUSE_PC_NOT_ALIGNED:
+        fprintf(f, "0x%x, PC not aligned",
+                HEX_CAUSE_PC_NOT_ALIGNED);
+        break;
+    case HEX_CAUSE_MISALIGNED_LOAD:
+        fprintf(f, "0x%x, Misaligned Load @ 0x%" PRIx32,
+                HEX_CAUSE_MISALIGNED_LOAD, env->t_sreg[HEX_SREG_BADVA]);
+        break;
+    case HEX_CAUSE_MISALIGNED_STORE:
+        fprintf(f, "0x%x, Misaligned Store @ 0x%" PRIx32,
+                HEX_CAUSE_MISALIGNED_STORE, env->t_sreg[HEX_SREG_BADVA]);
+        break;
+    case HEX_CAUSE_PRIV_NO_READ:
+        fprintf(f, "0x%x, Privilege violation: "
+                "user/guest read permission @ 0x%" PRIx32,
+                HEX_CAUSE_PRIV_NO_READ, env->t_sreg[HEX_SREG_BADVA]);
+        break;
+    case HEX_CAUSE_PRIV_NO_WRITE:
+        fprintf(f, "0x%x, Privilege violation: "
+                "user/guest write permission @ 0x%" PRIx32,
+                HEX_CAUSE_PRIV_NO_WRITE, env->t_sreg[HEX_SREG_BADVA]);
+        break;
+    case HEX_CAUSE_PRIV_NO_UREAD:
+        fprintf(f, "0x%x, Privilege violation:"
+                " user read permission @ 0x%" PRIx32,
+                HEX_CAUSE_PRIV_NO_UREAD, env->t_sreg[HEX_SREG_BADVA]);
+        break;
+    case HEX_CAUSE_PRIV_NO_UWRITE:
+        fprintf(f, "0x%x, Privilege violation:"
+                " user write permission @ 0x%" PRIx32,
+                HEX_CAUSE_PRIV_NO_UWRITE, env->t_sreg[HEX_SREG_BADVA]);
+        break;
+    case HEX_CAUSE_COPROC_LDST:
+        fprintf(f, "0x%x, Coprocessor VMEM address error @ 0x%" PRIx32,
+                HEX_CAUSE_COPROC_LDST, env->t_sreg[HEX_SREG_BADVA]);
+        break;
+    case HEX_CAUSE_STACK_LIMIT:
+        fprintf(f, "0x%x, Stack limit check error",
+                HEX_CAUSE_STACK_LIMIT);
+        break;
+    case HEX_CAUSE_FPTRAP_CAUSE_BADFLOAT:
+        fprintf(f, "0x%x, Floating-Point: Execution of Floating-Point "
+                "instruction resulted in exception",
+                HEX_CAUSE_FPTRAP_CAUSE_BADFLOAT);
+        break;
+    case HEX_CAUSE_NO_COPROC_ENABLE:
+        fprintf(f, "0x%x, Illegal Execution of Coprocessor Instruction",
+                HEX_CAUSE_NO_COPROC_ENABLE);
+        break;
+    case HEX_CAUSE_NO_COPROC2_ENABLE:
+        fprintf(f, "0x%x, Illegal Execution of Secondary"
+                " Coprocessor Instruction",
+                HEX_CAUSE_NO_COPROC2_ENABLE);
+        break;
+    case HEX_CAUSE_UNSUPPORTED_HVX_64B:
+        fprintf(f, "0x%x, Unsupported Execution of"
+                " Coprocessor Instruction with 64bits Mode On",
+                HEX_CAUSE_UNSUPPORTED_HVX_64B);
+        break;
+    case HEX_CAUSE_VWCTRL_WINDOW_MISS:
+        fprintf(f, "0x%x, Thread accessing a region"
+                " outside VWCTRL window",
+                HEX_CAUSE_VWCTRL_WINDOW_MISS);
+        break;
+    default:
+        fprintf(f, "unknown cause 0x%" PRIx32,
+                GET_SSR_FIELD(SSR_CAUSE, ssr));
+        break;
+    }
+    fprintf(f, "\nRegister Dump:\n");
+    hexagon_dump(env, f, 0);
+    qemu_log_unlock(f);
+}
+
 static void sim_handle_trap0(CPUHexagonState *env)
 {
     target_ulong what_swi, swi_info;
@@ -431,6 +563,10 @@ static void sim_handle_trap0(CPUHexagonState *env)
     }
     break;
 
+    case HEX_SYS_COREDUMP:
+        coredump(env);
+        break;
+
     case HEX_SYS_FTELL:
     {
         int fd;
diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
index 00b37aea7a..05d1129916 100644
--- a/target/hexagon/internal.h
+++ b/target/hexagon/internal.h
@@ -28,6 +28,7 @@ int hexagon_hvx_gdb_write_register(CPUState *env, uint8_t *mem_buf, int n);
 void hexagon_debug_vreg(CPUHexagonState *env, int regnum);
 void hexagon_debug_qreg(CPUHexagonState *env, int regnum);
 void hexagon_debug(CPUHexagonState *env);
+void hexagon_dump(CPUHexagonState *env, FILE *f, int flags);
 
 extern const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS];
 #ifndef CONFIG_USER_ONLY
-- 
2.37.2


