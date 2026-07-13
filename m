Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8BCC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjMwT-0005kp-5v; Mon, 13 Jul 2026 16:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMwS-0005kK-1j
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMwQ-0006SD-4q
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:51 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9NuS2256630
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Yy8dOIOB+33
 6SIHq6eUNR+XTxPZtumtAG2yz21hK1Sg=; b=T8fDh57Tf0TOwp6DL66RmmPIhIS
 xSxZpbIJfLgIbBHzQcc2h6dTHSbcn48FHsjWUIqxNfw2Ev+Fx5T96M0qHuwQWA+6
 fsIThOigRzqZHZyha8rFoyHab4yuCbFfk4kr+s2/KUbBmcllVT/7gFmq9MibWCkW
 smKm3XdHdhnfaFUK6IZxu5L5yMQg0tkY3NtM22MlM2FUaF9XxyY6b0HzumP77Uw0
 F/dC+hO86RAs9VfR3MrsLaFLJTgHZ/++IwZRyIQfdVDvI3JePnIAzn/pCt1CSgCD
 ginFaYwx9vWcrdmRZMqsF+Zf/1/iR0/u0aBmTNd9xbgtTAfDpASFbLvMA1Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk9tdx2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:39 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cab041eced3so3458866a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 13:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783973258; x=1784578058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yy8dOIOB+336SIHq6eUNR+XTxPZtumtAG2yz21hK1Sg=;
 b=a+WCgull6kh47nW0tiRr45kXDWEhEGfqtAloJsMz+sBaQBWtn8KTcnd26rCbXZ3JAf
 w2dLQBRN32LDPKqjMV0Vg0eoGx1q/M11tt3hdpKMBiVIivzeKJJW1NRRaq692075eL9f
 oVT77Pgi+QM6jrbsPrTBN48FTjM6csU4YA5RWrZ+0kqyrTYBNpPt1uTnfTxvsc+mYBCk
 8iqff8lyQy6C7vVpUjgQhjRp0FsC6LoqrMkcNbqUN9ZiWu3W/wEFOr6MFP2Pa8zDVKMG
 y5SZ226qSaufi0jTExyW5ToQOYbYumGXl04RFsAChmoh1mD4g/tGP6dvlzbBmE2ytSBJ
 Wo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783973258; x=1784578058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yy8dOIOB+336SIHq6eUNR+XTxPZtumtAG2yz21hK1Sg=;
 b=QAJhoK0bUt6u199PaZbX+/z9So5VpAwj0v+g3CR4XsaEDU432pCFkQlLBW5cNFGeXt
 P10dPu1G0SXHAcIouxk3vgmJaTAJIh3iH/D3zLq0cuUexAhy3o5zg++kBVge8qOg8+eh
 mzWc/eQLC+ZpL01VpRqDBRp1VVEfwmhHNuNWLDI5TVETcpwfFg3YOKxcf/vVR01Pko9E
 37wRE7MiC0h8mRUP7VuJAmQfTi57SHPS7ylwBQb4pDdosXrfYB5EwTT6yyYp/TY0EgVh
 e1/jbtqXkMKgZr+F3NchvZtIxO4TD8VmA3O6wiCPuJ4OUsGcSd7LicYG3SQfkBAXDSGN
 bTTQ==
X-Gm-Message-State: AOJu0YwGCavGqmuolCOUF1FCGSykDTXArel5k5F0CY1DfMrwn4v/ho2r
 gxqdbtOXs6g0EIugBfswy6eUfS+qTXuooADccKqScZwRf021G1gvC3PRkOzgDO8QOkJRrpPPj1V
 sCqVGlGRGyvVYdku7DnKCZAMdhD63r+LlWLw6w3az9tYDD8tWiCB9M//Sl6bU4N1XnCX9
X-Gm-Gg: AfdE7ckura4+wsz76mGNb53Ms7KL0DUppYlvyuYXi/+2A9s/OxOtELaznBpZiQaxkU3
 7UV0sSwVw95n+juutzyE3n/LsazfPXByNVJZIvRkdVgJo1o3J7eHU2s8ScTpqYwCsWOd3xKjTAs
 JSdLw2WJ4yhDyJwWJojieqUcP1tbPzBMUbgXMQymRF8/RNPUarBzz/D84ws/KC/1lcP6jJkWIXg
 KYbsXpmEf2Vv+5wu7yjWhgA9oT5BMAhY8TDEr3tTRb/EPn7Mn4GX9cpuhHkXtwgbL3HHvRvgB3Y
 3ck+btqy7MIe3VLPVO3xzcDwKkNLT+qYJ/1pwP2kpV2pY4MaTkac7OeD4rKAgDlggWNFzNahwyQ
 qew8v7DZK9MbUSSU59/UB8TWvolD4I0Q3178A+0+0T6xrCcMCfk2elZO5DYzyi/iyyuO60UQSoQ
 ==
X-Received: by 2002:a17:90b:3903:b0:381:e73:3c2e with SMTP id
 98e67ed59e1d1-38dc7758d29mr10010013a91.24.1783973258222; 
 Mon, 13 Jul 2026 13:07:38 -0700 (PDT)
X-Received: by 2002:a17:90b:3903:b0:381:e73:3c2e with SMTP id
 98e67ed59e1d1-38dc7758d29mr10009979a91.24.1783973257780; 
 Mon, 13 Jul 2026 13:07:37 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313cb804197sm24106543eec.13.2026.07.13.13.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 13:07:37 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Subject: [PATCH 10/14] target/hexagon: add COREDUMP semihosting operation
Date: Mon, 13 Jul 2026 13:07:18 -0700
Message-Id: <a2e686ac0ba95d33760e6f83dae711ca30a0914f.1783973054.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfX/kHee7AO5qMu
 MLJGJVYc/iFD2d/nc4klOTuex1O1fUMT+oog0NQZVKTI9l5wImT8EYPGJszxdcvI0FQ6T3aza9I
 25gA2m6C/jiaQLWiWVMC380Z9GXwCRr6H8PJ1UzWKkigHCtmlTaJYuD1t5RXulpS+xv7jc30YLx
 PTbGRzHGu3SFhQjXDodblX3yrrbrWNpkwxfEqqVW/3k4tcTBrHJ0h8K/YPZeyxEoOAjedZqifm0
 CdPCqbvMk3pVc9mFK6Web054ugxisP27ZprTw6T7E+JToqOVwm8u5xg/TOJjKT272Pi4O2NukN/
 LvugAJ9gbYqJVeI8zhYHdcHNYLpwx6CJhnPz5wrOfgvkJBydEawnCXnARNtPKaQuVCXPN3WjTV9
 eUY2zvoFPw4nRuRGwUv132CwAOQfZCWLRLWdlnysBLQrydxF6tk/sT9Ckorhtxr5QVcwkJ0DiO7
 RU4lik/0dI+FzYQVEsQ==
X-Proofpoint-ORIG-GUID: QNrQ7jBGpvuperOUj_xQRg2OhsjHiL2v
X-Authority-Analysis: v=2.4 cv=UMHt2ify c=1 sm=1 tr=0 ts=6a55458b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=BE4lvaXKYeXNScGiURoA:9 a=bFCP_H2QrGi7Okbo017w:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: QNrQ7jBGpvuperOUj_xQRg2OhsjHiL2v
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfXxNXBtApU5Rcb
 hYw6fJbgcgfANlyAZ2BB7rs88igYpdGWpOZWXlFx7H0KeeRDGcQd0P9gmVlTsHB3UJDTiHnATdm
 lVQSQFZkZJahIyw2YZIPlkD4RgxkRUQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130208
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

From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>

Baremetal Hexagon programs invoke SYS_COREDUMP (0xCD)
through semihosting to dump CPU state on a fatal exception.
Implement the handler to decode the SSR cause field and
print the full register file, matching hexagon-sim behavior.

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
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
index 028cfe9edde..8be4097ecdb 100644
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
index 2c60e4d9e9f..7efd33d3533 100644
--- a/target/hexagon/hexswi.c
+++ b/target/hexagon/hexswi.c
@@ -127,6 +127,145 @@ static void common_semi_ftell_cb(CPUState *cs, uint64_t ret, int err)
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
@@ -427,6 +566,10 @@ static void sim_handle_trap0(CPUHexagonState *env)
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


