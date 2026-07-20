Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684A0C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wls0k-0000CH-F8; Mon, 20 Jul 2026 13:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wlrzl-00089G-Rb
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:41:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wlrzi-0002zY-AP
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:41:37 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KHBrjH137364
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+JQO3gJq64K
 7yjfgP+3bGDs4aJPdFowBy20sViujbAw=; b=FQq/daqjLyAeOyrhn6/JgGW9P4S
 inDawB86Y0LXtyBtDtip4cxU4/lmwYYSStrhnaO7aOAzc43X47m9lswi9phDhIUl
 LfswS0sTL801qU1hHHD38GfZ1HAu2RXE7dFogTEk960zC8j2BvdQIFBnYZ0k7byY
 HcWfWHAg2QHyQMX8pnXzM5IszqhGiTBp7vqc34EVs1M16gJ00GD475CkarV7TLX7
 Y7bph6a/tv7GPdagargnYuWTmJQDnBAcCp1KmkY4oxbE3nHxpo3bYrFu//QuBEc7
 akCRJ2XFCYZEev0mlASNSXAnNlJdSQ2vi+iC2/KR11I2oBbIH/wIyWvDhRg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqv5r4ak-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:41:22 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb6dd278512so1447358a12.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 10:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784569282; x=1785174082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+JQO3gJq64K7yjfgP+3bGDs4aJPdFowBy20sViujbAw=;
 b=ZkKm2Q136vyY59qluTrZiOhYU6XLtZ8BgVZTgapDhB1gIChrgE1tMr4K+saRA//WeF
 NVP7blbV2jLYf8zqBdLMfI5gLbT8mAmzLqEvsO+Ayr5neW5V1XXtPUyh4nRs9GIR/44W
 LykM6skNxHoNkzAsI+eb+kPOAzQA+ARyaUkkpQoWvekyFh1fuqaALJb4SDOuHeZbGUtU
 FFPadrjWTBKKIKTWcL7WefDh8MShdj7noBSHGbnVhy2AaA+4IBMFhYFChgamlSZtGbwW
 CU05IXhc4/5VvGnt8e0bkg2YJoxw9ryklQKz/GNmXMbLscAyKYgNYib1PRQ1hl7P9m9Q
 pqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784569282; x=1785174082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+JQO3gJq64K7yjfgP+3bGDs4aJPdFowBy20sViujbAw=;
 b=OL7vy+ICHsrnOXprNneEe1HicEFM5Ti/hUZES9zW1weMVs6T7vaL1WMTyZSoQZfQ9q
 GeBYzUf/kSse6UmEgZDTWc7UlRjgJwjgs+5RibqdqsvVU6/t65ak1mK7zxlXfNIy3I7e
 a8/WQP6utB/N/LBywPqOIs1is8vU7tnv7eWBjozWssqUthAQ5WfYMnNrt+3axycssPvt
 9/wZDx1cHNe4wktKOB/9zay5ebwmdSAolXyj0HG+U3GvFqMoVaQVjTDSuK7BXEqJFOi4
 /03LNGCYYcxi7imlFC7ZcMytW651kBJeJD5NliHK6zNXCAlWL7YNOzvXVXPFIKEwu+Sw
 WSHw==
X-Gm-Message-State: AOJu0Yzk/mNfWiQgqArRJdsZQzM0pM5f9sNpcOyIREmb3godKng16+Pk
 P83HtOsRLasdBnKHAof8K53KqGAlEfdiyJCVRVN+P0BBMZJULsCRSCjXO5LKqOuxJNOVrIu6G+Z
 tcPZ226aqicJibjaddzrRHWgEnj7avrO4PC52qmnnfrwzOsWb8KrX8b9Bz6Ia1rIXyQ==
X-Gm-Gg: AfdE7clPvDALjxWXghE0BW27WK1v1OZzigYTa0RFBoN6FEM1IoSg1JRonZLQtYLZsdy
 U+7HvqbsVdkGJMOSp1/iOnv6ZtgHR9n62xrz8f73q5rNez3HXpzHShwo3F5Ro+lq9TWxIhUjE4m
 lHzxqSnrwFU9iDiO3bBDrBKmrqA5HHec/V38bC9z2DupUbhpEMoX6kmQW+5kZQZ2YfO96KMYMFV
 wyuhJ0KsSjcM/E5xAnpAz4hDkqINgAm80dS+b/e+7ZSxRMJNnsL0JYiDtQaVXu1ruvqsoQkgPVU
 8cIYBr1gKqkKTC09Zzow0V4m0qJQ1KlU7jEZFcZ5tyWNf/N3JLsckDNCvt7rMunVX5UAYbBaXLs
 MIHRGQZ3dsYCQyRtdL5KI3UJFSlB2I5pXSVeKddazUwqHZut2fpLUeT1JobmO4z4=
X-Received: by 2002:a05:6a21:9206:b0:3bf:c28f:8afc with SMTP id
 adf61e73a8af0-3c3ad3bad5cmr15437656637.0.1784569281918; 
 Mon, 20 Jul 2026 10:41:21 -0700 (PDT)
X-Received: by 2002:a05:6a21:9206:b0:3bf:c28f:8afc with SMTP id
 adf61e73a8af0-3c3ad3bad5cmr15437632637.0.1784569281443; 
 Mon, 20 Jul 2026 10:41:21 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1dde81sm66281257eec.21.2026.07.20.10.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 10:41:20 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v3 10/13] target/hexagon: add COREDUMP semihosting operation
Date: Mon, 20 Jul 2026 10:41:06 -0700
Message-Id: <9ac447d68310b348423a416a7aeb1490e2cccc5d.1784568922.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1784568922.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: crUOOec6ejZTn1RXXFqeUbpW_-pimR1J
X-Proofpoint-ORIG-GUID: crUOOec6ejZTn1RXXFqeUbpW_-pimR1J
X-Authority-Analysis: v=2.4 cv=e+U2j6p/ c=1 sm=1 tr=0 ts=6a5e5dc2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=BE4lvaXKYeXNScGiURoA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MyBTYWx0ZWRfX8bHd1gldO0Bc
 3Z9ZluXm+sktlNME38WGovmkQYX4x/sGf4tfgUCSGOvKRsxiXokCchue2a0JtCc22ytfGdB9HkL
 SHOJkc1OaEA78vGrlndsmFe9MXWZOLY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MyBTYWx0ZWRfX33qgEkob3TO3
 17dh83dZ+h1zPWFGk7TWbxTSRJIvXwNIcuXnUlYpjBDAz3B2ctBydeOBA/MonVbTPkJqYBZ288s
 E6paJWaBsmsfe4Ahom0Swrf7zCmFkVF7Yb+AJ/TU/d5OKIhB2NhtfbaHzND+A7AlX23ppvUdkon
 FVoWxQke2XyfuZWw/86H/iZ4+PuWCmwQg+qX7JfhHMkzRSdilNv/jPByA7epRL9NMjoj1pja05+
 nrKk69rlHBP34gfL4k5X0un++LzUYusjtQcVrDBKp07q4ZnXeyAFf9+9bshdK5eVRAp/sL7Xhj3
 sDdResqEbl6Jr1Dgo1ujRiipY2UO+oXZ/k5jwb8ouDbsc+2f9dC6cGric9/z9aXFc9+Cy116gYr
 kJnaf9fyB1AysMsALB3ImBzbGgLZdZqsEEG86sl3k54ZToaxMqFtwVkQ6EtemIM6JVZ26piVuJd
 BrSNTg0vlokfDyDWNxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200193
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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
 target/hexagon/internal.h |   1 +
 target/hexagon/cpu.c      |   2 +-
 target/hexagon/hexswi.c   | 143 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
index 00b37aea7af..05d1129916e 100644
--- a/target/hexagon/internal.h
+++ b/target/hexagon/internal.h
@@ -28,6 +28,7 @@ int hexagon_hvx_gdb_write_register(CPUState *env, uint8_t *mem_buf, int n);
 void hexagon_debug_vreg(CPUHexagonState *env, int regnum);
 void hexagon_debug_qreg(CPUHexagonState *env, int regnum);
 void hexagon_debug(CPUHexagonState *env);
+void hexagon_dump(CPUHexagonState *env, FILE *f, int flags);
 
 extern const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS];
 #ifndef CONFIG_USER_ONLY
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index e6b2ac1939d..06c378c5e02 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -232,7 +232,7 @@ void hexagon_debug_qreg(CPUHexagonState *env, int regnum)
     print_qreg(stdout, env, regnum, false);
 }
 
-static void hexagon_dump(CPUHexagonState *env, FILE *f, int flags)
+void hexagon_dump(CPUHexagonState *env, FILE *f, int flags)
 {
     HexagonCPU *cpu = env_archcpu(env);
 
diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
index 6efc00fedf9..564a11e557a 100644
--- a/target/hexagon/hexswi.c
+++ b/target/hexagon/hexswi.c
@@ -162,6 +162,145 @@ static void common_semi_ftell_cb(CPUState *cs, uint64_t ret, int err)
     common_semi_cb(cs, ret, err);
 }
 
+static void coredump(CPUHexagonState *env)
+{
+    uint32_t ssr = arch_get_system_reg(env, HEX_SREG_SSR);
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
+                HEX_CAUSE_MISALIGNED_LOAD,
+                arch_get_system_reg(env, HEX_SREG_BADVA));
+        break;
+    case HEX_CAUSE_MISALIGNED_STORE:
+        fprintf(f, "0x%x, Misaligned Store @ 0x%" PRIx32,
+                HEX_CAUSE_MISALIGNED_STORE,
+                arch_get_system_reg(env, HEX_SREG_BADVA));
+        break;
+    case HEX_CAUSE_PRIV_NO_READ:
+        fprintf(f, "0x%x, Privilege violation: "
+                "user/guest read permission @ 0x%" PRIx32,
+                HEX_CAUSE_PRIV_NO_READ,
+                arch_get_system_reg(env, HEX_SREG_BADVA));
+        break;
+    case HEX_CAUSE_PRIV_NO_WRITE:
+        fprintf(f, "0x%x, Privilege violation: "
+                "user/guest write permission @ 0x%" PRIx32,
+                HEX_CAUSE_PRIV_NO_WRITE,
+                arch_get_system_reg(env, HEX_SREG_BADVA));
+        break;
+    case HEX_CAUSE_PRIV_NO_UREAD:
+        fprintf(f, "0x%x, Privilege violation:"
+                " user read permission @ 0x%" PRIx32,
+                HEX_CAUSE_PRIV_NO_UREAD,
+                arch_get_system_reg(env, HEX_SREG_BADVA));
+        break;
+    case HEX_CAUSE_PRIV_NO_UWRITE:
+        fprintf(f, "0x%x, Privilege violation:"
+                " user write permission @ 0x%" PRIx32,
+                HEX_CAUSE_PRIV_NO_UWRITE,
+                arch_get_system_reg(env, HEX_SREG_BADVA));
+        break;
+    case HEX_CAUSE_COPROC_LDST:
+        fprintf(f, "0x%x, Coprocessor VMEM address error @ 0x%" PRIx32,
+                HEX_CAUSE_COPROC_LDST,
+                arch_get_system_reg(env, HEX_SREG_BADVA));
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
@@ -437,6 +576,10 @@ static void sim_handle_trap0(CPUHexagonState *env)
     }
     break;
 
+    case HEX_SYS_COREDUMP:
+        coredump(env);
+        break;
+
     case HEX_SYS_FTELL:
     {
         int fd;
-- 
2.37.2


