Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5588DC44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQUs-0000xn-IH; Thu, 16 Jul 2026 14:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUr-0000xY-Jj
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUp-0001Yd-R8
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:45 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGSsoW3172066
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4Mr7n6ERCtk
 KjQ2xuTE3MOYcIX25sDzieNBvejt9lcw=; b=VviWtcbKGI477Nl3kSxOiYZS8Fd
 BOgUytOi0u+ig0sjcnq2V8otCuzD+vj8yU5J+Zs7bamzVWVkjjHsIgTi9210rH6f
 GJz9fmhP4upC7RC+XfqquxPSzJUOt/X2mpTGiVJs1W8MqBWTZfs+9DGscgAORtZS
 ult4/Loax+m1DJKxOvRDVsVHHKlfB066oiEevRYckIz0rr96JGctc0cnZezGjUQW
 EOeShvsHZix7+jMlxUgaqrll0zfF+h9Ed0VpxeClJF1QREbZT9DbM417OEjXn6+M
 sESLGq1xiaa1GXBxNTCM6rMn0lgSpT/BrLsJ+rljrfM56fT34cCSkIXZ4uw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fevkv2bge-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:42 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c889d1eedcdso10674249a12.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 11:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784225262; x=1784830062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4Mr7n6ERCtkKjQ2xuTE3MOYcIX25sDzieNBvejt9lcw=;
 b=CEW7roU2YH8K2OHFFZVEONFos4sYed5NtWC3LNdi3rAexgUISFry0sOwezdjhWrrJM
 Li6j1QRdm+A4Vs80Etmpq5i0wNZxuDeYUjamDmOCpOC4lvH8imTay0Ym1w4T0Zek7yAq
 X+OjLYPLNMBNEuGys9IzX/G980YWJfI21cxxP+vmK78OTPgigPp/ChLJtP0y8dbBbLWs
 PGuZ4kaUzpw9v5Qtr69oGKrEgkElb1folJ/el8WiqXaymih9+lJKoSF3RCM4flL9T1Jl
 tNYJ7g54DL14MKIBAF4+p8FKjRjCKJUvUeegGT57ZWR6IHjKcv24cTRSyRDmcCYxkK5t
 Xn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784225262; x=1784830062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4Mr7n6ERCtkKjQ2xuTE3MOYcIX25sDzieNBvejt9lcw=;
 b=YLOQZ2kcY5Pq04fFSwkedUL9PT8dZSfc/BPOPcZM8fxWh0xlvPywrnfob0+241NBMs
 fMNHxETYQwc9MCoMBuhLwLCAbgFL9FvsJ8YLlWR+Fb3/zhY9SdxSyM+QHSPyeETkZeAM
 62RVDmpphLqIBJQzHAmzuyvK/TF2t3psEhZjkloOMiWxymvUITzPKHg9ENpqqJxnBDpc
 ytB/wSTt7ZObglHak0A2Q+t7K762FMLooJMH0K8tq6EvcbwfZGiI2YvYWQTx3s7A5E0a
 I1/nEeuS722lIV33JBAYvL457uiO3+us/d6RrQQflpYxjAWGH5Wyk3mx85G6oKGGKVm0
 I85w==
X-Gm-Message-State: AOJu0YxUs25SamjolvmYL30a9kQEVTr2WKwBbZlaLoPzqyGKlQ2hR/Lc
 +7ioaPbIgIxDgsnBg01PgTgpl72wOxyymH8uQxQdjFCGDQ8E1YGdp/IKiFmfAqcJaP+um/NAu8H
 CWUCRdsq1Zj42aSKaqwIRLQo6zmGDmMenK34smjC5QeNgZvvXgvzDGHHpASYFH1j/Pw==
X-Gm-Gg: AfdE7ckMwRmo4I/kUEP25Ff671OxSEwYGeXzy2UPUixGmEvfqf/tRUdYdjBkGqAgpf/
 ObmZsj7M2DePfVMWuI54KDqQ/iDEkasW4kPruhRkYkpTkrgDKz4c/giVCUV/CvyHIeqgjSGWpBI
 4Uqkh1eCsEDK2pV0QB+/DfM6VK+BG1/4ewLe7UbG92lnJvdIHc2clakuKUr8ClNwfw+57XjheBZ
 MTgO2C6/fp55tRZGYsl/i+86BGbzU+2v/mbz2G3PydLiYcipn5F2Uf2MouO5LLXey4D17RQiOS7
 jRdfDttJm06PP0VT5Ux9c8PfoOQkZm1WapzJKmkQvAFfSxT5m/jPGe+su3sZSQOdwKxMOTQjlVH
 75/SXsgGc/ijs+JW5GYCT/jh0AoeOz6f2gKTVBq/NUrlrBmk3IzmZdMOtJWuYtWM=
X-Received: by 2002:a05:6a20:20c3:b0:3c3:859b:c20c with SMTP id
 adf61e73a8af0-3c3859be277mr4965259637.15.1784225261806; 
 Thu, 16 Jul 2026 11:07:41 -0700 (PDT)
X-Received: by 2002:a05:6a20:20c3:b0:3c3:859b:c20c with SMTP id
 adf61e73a8af0-3c3859be277mr4965208637.15.1784225261171; 
 Thu, 16 Jul 2026 11:07:41 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm17131184eec.11.2026.07.16.11.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 11:07:40 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v2 11/14] target/hexagon: add COREDUMP semihosting operation
Date: Thu, 16 Jul 2026 11:06:55 -0700
Message-Id: <7fd1831acb4aef0f552d8ecf005576d2d5aa7c96.1784225209.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfX+wvj4H+dgNP4
 qfahaGsLUg/e1JiNeC8jV4R+Ll8gEN3fwEesEcmyCxEnfoPI6ONJvpXuU7IcX/sKkcHyOTxEa6B
 V10SvgVbI3Lh9pNBV8QLZIrLTbQtLt7+4lBcVVi8LFvbIE6Bckz/dRucSw9GE1DaVTnNCCnieER
 7B6qNOr+dDTN4FpdAYb+YQZbQQlV/Uh3KVsdFC+DgNO7Pp/hsbEUceLvmiCex0HgUKpbLT2Fa5+
 RUQ5Zt12yCCnXI+mj+QM2ES9saHD5te0g2bYmZLbk16ngf89tRr376c9CBgmQyuekSQ9Ylq8kyE
 taG+CbLj34oq5PwUp8RtTcJIRvxuZMD6gLvzZQmke+y0v50saVKVjGWokxNc4Cl7j3bma/hz2pv
 fwbRe7+yakgy8UH4Z7k4zuLAp8qMV3WcabJPS9nsobf5KIB/8Y4qf2dih4lXqzujTzKKFK5orpy
 1qX/uXiufVY5JpI4fOQ==
X-Authority-Analysis: v=2.4 cv=WrEb99fv c=1 sm=1 tr=0 ts=6a591dee cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=BE4lvaXKYeXNScGiURoA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: xrfVawQ2ZPUPslcceIvfOre2Wu-seA78
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfXzGdFrilyUJaL
 kFfe3b3ZS/GfNpyjq/TRy0Jg/7ZPiQ1miLEslDgaMdHNwThxZ6yj9Jy52SNVMjjMKckM1HsYmwX
 Niw8ZoZQNsUmbFBGgmf2fPZiO4IXsck=
X-Proofpoint-ORIG-GUID: xrfVawQ2ZPUPslcceIvfOre2Wu-seA78
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160185
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

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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
index 73a799da877..26baf28b607 100644
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


