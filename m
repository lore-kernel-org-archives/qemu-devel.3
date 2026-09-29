Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BD0CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWdu-0004Kn-A4; Tue, 29 Sep 2026 08:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWdr-0004KR-6E
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:09:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWdp-0002EW-4n
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:09:02 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TAjAG23011311
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tBm/TcUhWtcLrJxa3nv5MzT9WCBk+41V2EDjg42P7aQ=; b=h0AXcejVbjz3oxYt
 TDFA2izF32xO6qfJAByUmXEYYJcTGiW3NJFmpo0VU8k/qwTPrxAcM9WjavTmrpxu
 EVZeSKp1tKfdI3B3Fr9VuR6m2oUfQJlDLnoZAUl6J6gvsMH0c3aKGsibcqCOzbAM
 C05dyG44osM9GYzyrQTDt0TLztxvGgZC6eg2Eesy/55e8ZGyPNRImz8B3HT80zbI
 SNz6xW87jL69WkUcMx9mnEEV1TsyHQfVwD0HJ8+qyvmZ5F0BXC9eNri7XsYiWbSb
 /RHfNOwDFYy8Mx9rDKQyS/X3d3HaDNcf3QkC+p9wxafD0wW6VKFnXG3tPYMfpCZZ
 tXHEwg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h02mnajs8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:08:58 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-97e9cc5ac86so378863241.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790683738; x=1791288538; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tBm/TcUhWtcLrJxa3nv5MzT9WCBk+41V2EDjg42P7aQ=;
 b=UeAcbPYFqmn+n2hJ8xOtfTwmusfNB/JlzjsjRNVXcs3EO0+cL5k1K+heogXj6rFg7V
 TEPM/AyraN7xwJDw/gW4mAZR0VUQNhXTXqW4Ko8bbDvJG1UC9aYYllnHNVPPZt+4FU8s
 iqqkbrFDO+r4KXhufCXrOrmAqvm26mfzzot/aU2ZPe2iaGzZWSJlXLFfBNtW3jGjI0TP
 7j4SlxlvQgcAUDOj9EtuHuBDW0EiFps2p6MKuC1uh2SdzIBLZ5GXMTl/4lLqCiS/0xb1
 FcjYQVlmlWyMVYIwz6KykjZVxttg5SNUSK3eaXVJSxVC91t7bcmPKUVXujOUVHEiJr+Q
 sf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790683738; x=1791288538;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tBm/TcUhWtcLrJxa3nv5MzT9WCBk+41V2EDjg42P7aQ=;
 b=D/veqjAb8OAVJBQtrPEe5Dl7+j1ubLdinfrNYGxzTyGZm+4ovx384FxpVGjfvvXQNb
 tvbdGhGvwP2N75GkqjTp6e+P7Qb7/C3x8/6akXFcprEML+iOhQF7cs0CjIr/1c3ap/Qo
 ISaGzhl+VJ3vvky/F0cZQz+rvoyo+6FweuMJbC5y505QBtpzZOoEKLgGitBSSdq484te
 Yq0Fis0eE8Jt/uvukuJpibAy2kihtPPzjEtVsUmcsZSW/yUG46YlIH/ft2QqgPTnfT72
 1XCURX/QPTSu/rYJvFGyeihNQPioiBhCybx40T32EUxDEQQBhxllGMk6BqHshXK7UY4q
 bRvg==
X-Gm-Message-State: AFq9FYJo59o7QZ1Sq/JgPfwzxyHXJ31dE7v9CG4orEkcfpqa2pEAcJI8
 sutA2sJ6nClI/vT1GTHvNLjnPsyxofEHRtrz874bPrE3uLiVqYl67zcZMSlmrsdIspZwIB5iaYJ
 axeypDt7SdnjsfADtGQr/stFr6+zFt7WpK55WCjTgBnwY4CvG42pwUkyd/TYdxt5VYQ==
X-Gm-Gg: AYBFou3FBV3YRH7aNRYv+QJgOsJaELTEFy1hHdRMHuBIQlkQ6K87AhesKBXGAz4sPuX
 S/NxGjfyCdWVsl2NhsIPZtU18Hqq9yfwVJfU5FgJir5UFLpSeAhrfVbxCFZ901+35lm0JiDixLC
 kS1ag+shSXrM0Jt1aGQ2A2AXwooOvGwXXlNqtY+/tOlzRTvcZ4e6M2f8J1+8vVgupNnpTYResJx
 d/EkkBNziPx8+PPugut7cNFSyIWv6mUSZBYfEDdO0YEcRfCHNKFk9+QN3gbVhsJ0GxzOGpAW6NA
 maaXayHbrYo0BblVXKhpDNxvM/rv0hfGUhxkmWiIzS9zo+aveGyHS8vj1mSlCrIcjeUvw4HHN5Y
 Qsd2Wmn6kjLNonFI1397tWiyEMP3bhQJH2tqmIjbS
X-Received: by 2002:a67:e703:0:b0:7a5:c8c4:fe87 with SMTP id
 ada2fe7eead31-7af1cb9a2bdmr4610722137.9.1790683737548; 
 Tue, 29 Sep 2026 05:08:57 -0700 (PDT)
X-Received: by 2002:a67:e703:0:b0:7a5:c8c4:fe87 with SMTP id
 ada2fe7eead31-7af1cb9a2bdmr4610713137.9.1790683737038; 
 Tue, 29 Sep 2026 05:08:57 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af50513c7sm3613415f8f.16.2026.09.29.05.08.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Sep 2026 05:08:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 2/2] target/rx: Define exception vector constants
Date: Tue, 29 Sep 2026 14:08:38 +0200
Message-ID: <20260929120838.13583-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929120838.13583-1-philmd@oss.qualcomm.com>
References: <20260929120838.13583-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X9fHu2Te c=1 sm=1 tr=0 ts=6abbaa5a cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=KwDs--hy771jlAYoLH4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: YYvJTBm7Cy_I6sxk93QnUldn62tROQUU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX3Nx2kf16yEwx
 IwAaJ2d4uQnYWhH346ZMM1b0EnbxawP8MCdFS/XD+SIQlrUDnuvAcapIk5eillvX9motfSHZ8cq
 ncxL+8zedMSiBrvXKFtuCNSEpPB+aeA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfXzefWKrV/dPcu
 vow02AblYZJLel8n7ox7CpUAquvn+U1ESc5bpVWL6D5HMn3iOXrMBR7625TUPyR/EYYOUGGaAOu
 WscNOK3PVaj7ewI6FpLAnfTvDF2oiyCK91ENuca1m525zWm+GerHXr2lsCunxoSewBjQQ25XQKx
 oQ2W41jmvZ1KU8bukIi4lplPFFwomUhYgtEhMA7IsjXAg+NoVh4gxDiCpiebo3JEWOZHA36qk3n
 AJnCwp2sNqhu6rtlTHkP/49uJwJagxjrxtZNeTZs2IfvADtZl8VWvfu3eIp6tCEIE2encFAkyT3
 4hZJpacZN5jI4W7IUFNWh54nENBDrCAxwzktvQI3QUDNszHxBCYV+LdLbOoT6kyk//XYNNOD2o5
 WkieAip8O45H7mR3edE19cVlKGJSM8kbQpb9LMz05UzgQ7HK9mbGv3vO1Fac3USRcm5mAo8887D
 /YRQBilWuAj/Xr3RJJw==
X-Proofpoint-ORIG-GUID: YYvJTBm7Cy_I6sxk93QnUldn62tROQUU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290048
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Yonggang Luo <luoyonggang@gmail.com>

Name RX exception vectors and trap ranges, and use the
definitions throughout exception handling and exception
raising.

Assert that exception indexes remain within the defined
range before accessing their vector tables.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Co-developed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/rx/cpu.h       | 13 +++++++++++++
 target/rx/helper.c    | 21 +++++++++++----------
 target/rx/op_helper.c | 10 +++++-----
 target/rx/translate.c |  2 +-
 4 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 64ba48a7329..0d9f4898a26 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -71,6 +71,19 @@ enum {
     NUM_REGS = 16,
 };
 
+#define RX_EXCP_TRAP_COUNT          0x100
+
+enum {
+    RX_EXCP_PRIVILEGE_VIOLATION     = 20,
+    RX_EXCP_ACCESS                  = 21,
+    RX_EXCP_ILLEGAL_INSTRUCTION     = 23,
+    RX_EXCP_FPU                     = 25,
+    RX_EXCP_NMI                     = 30,
+    RX_EXCP_TRAP_BASE               = 0x100, /* Up to RX_EXCP_TRAP_COUNT */
+};
+
+#define RX_EXCP_COUNT   (RX_EXCP_TRAP_BASE + RX_EXCP_TRAP_COUNT)
+
 typedef struct CPUArchState {
     /* CPU registers */
     uint32_t regs[NUM_REGS];    /* general registers */
diff --git a/target/rx/helper.c b/target/rx/helper.c
index 0f99279bbaa..bc76dd28ab3 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -86,13 +86,14 @@ void rx_cpu_do_interrupt(CPUState *cs)
         env->isp -= 4;
         cpu_stl_le_data(env, env->isp, env->pc);
 
-        if (vec < 0x100) {
-            env->pc = cpu_ldl_le_data(env, 0xffffff80 + vec * 4);
-        } else {
+        assert(vec < RX_EXCP_COUNT);
+        if (vec >= RX_EXCP_TRAP_BASE) {
             env->pc = cpu_ldl_le_data(env, env->intb + (vec & 0xff) * 4);
+        } else {
+            env->pc = cpu_ldl_le_data(env, 0xffffff80 + vec * 4);
         }
 
-        if (vec == 30) {
+        if (vec == RX_EXCP_NMI) {
             /* Non-maskable interrupt */
             qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
         } else {
@@ -100,22 +101,22 @@ void rx_cpu_do_interrupt(CPUState *cs)
         }
 
         switch (vec) {
-        case 20:
+        case RX_EXCP_PRIVILEGE_VIOLATION:
             expname = "privilege violation";
             break;
-        case 21:
+        case RX_EXCP_ACCESS:
             expname = "access exception";
             break;
-        case 23:
+        case RX_EXCP_ILLEGAL_INSTRUCTION:
             expname = "illegal instruction";
             break;
-        case 25:
+        case RX_EXCP_FPU:
             expname = "fpu exception";
             break;
-        case 30:
+        case RX_EXCP_NMI:
             expname = "non-maskable interrupt";
             break;
-        case 0x100 ... 0x1ff:
+        case RX_EXCP_TRAP_BASE ... RX_EXCP_TRAP_BASE + RX_EXCP_TRAP_COUNT - 1:
             expname = "unconditional trap";
         }
         qemu_log_mask(CPU_LOG_INT, "exception 0x%02x [%s] raised\n",
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 6782912247e..d4e9ac2f192 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -115,7 +115,7 @@ static void update_fpsw(CPURXState *env, float32 ret, uintptr_t retaddr)
         enable = FIELD_EX32(env->fpsw, FPSW, ENABLE);
         enable |= 1 << 5; /* CE always enabled */
         if (cause & enable) {
-            raise_exception(env, 21, retaddr);
+            raise_exception(env, RX_EXCP_ACCESS, retaddr);
         }
     }
 }
@@ -432,17 +432,17 @@ void raise_exception(CPURXState *env, int index,
 
 G_NORETURN void helper_raise_privilege_violation(CPURXState *env)
 {
-    raise_exception(env, 20, GETPC());
+    raise_exception(env, RX_EXCP_PRIVILEGE_VIOLATION, GETPC());
 }
 
 G_NORETURN void helper_raise_access_fault(CPURXState *env)
 {
-    raise_exception(env, 21, GETPC());
+    raise_exception(env, RX_EXCP_ACCESS, GETPC());
 }
 
 G_NORETURN void helper_raise_illegal_instruction(CPURXState *env)
 {
-    raise_exception(env, 23, GETPC());
+    raise_exception(env, RX_EXCP_ILLEGAL_INSTRUCTION, GETPC());
 }
 
 G_NORETURN void helper_wait(CPURXState *env)
@@ -457,5 +457,5 @@ G_NORETURN void helper_wait(CPURXState *env)
 
 G_NORETURN void helper_trap(CPURXState *env, uint32_t vec)
 {
-    raise_exception(env, 0x100 + vec, 0);
+    raise_exception(env, RX_EXCP_TRAP_BASE + vec, 0);
 }
diff --git a/target/rx/translate.c b/target/rx/translate.c
index d0910fbf8e7..1bacc7adf92 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2187,7 +2187,7 @@ static bool trans_BRK(DisasContext *ctx, arg_BRK *a)
 /* int #imm */
 static bool trans_INT(DisasContext *ctx, arg_INT *a)
 {
-    tcg_debug_assert(a->imm < 0x100);
+    tcg_debug_assert(a->imm < RX_EXCP_TRAP_COUNT);
     return do_trap(ctx, a->imm);
 }
 
-- 
2.53.0


