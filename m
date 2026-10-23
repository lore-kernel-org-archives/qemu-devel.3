Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AEA606A32E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HOi2/T9v;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cmF7obuq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHyz-0006eP-BL; Fri, 23 Oct 2026 12:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHyv-00069M-Hz
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:19:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHys-0002ds-W0
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:19:01 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5vcd4072850
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AlE49BvQBS8lcAh5ZK+SkMfuBNmF3tbOuB/a4zz3eG0=; b=HOi2/T9vd0+wD8IL
 MDkktuHOjCnb3HqyNhIEp6eqhWcTZSuQB4SZd9rR1Bgs+lV0gvpm0V78lLYrVr2Q
 CF8GV10NtBdCZJlKkJepFRgTaAZcVvRiZ/9qtFAxeAY1ZLOgSsQtNItloBw3ym17
 0vZWFaZ/RLLtL4Vt7UASUSfLBCfW0op87PVAZCflPXt5njgtV3qM6Js46QLbaMI3
 OURikvOe+TybxxvAMnHL+xprk2hMds3xytqPD2hnzz9MbJU/J5rXv657H6SBXCNZ
 wdLrzeEKktMoWqFj+bbn7dQ4jYThbTKGiq55eigoVOWciqkGKaA33ifDy5uwNQRl
 54xvUw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7bw0xaw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:18:55 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f26dd2165so355206585a.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772334; x=1793377134; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AlE49BvQBS8lcAh5ZK+SkMfuBNmF3tbOuB/a4zz3eG0=;
 b=cmF7obuqGLD0B/TDwpJf4cA++Svqy8Nz7tRlp8ZLzBMxw+T5W+jabsXDo33Vuyeb5L
 DmxOdLgOdW1Q/Qyh749GfzdbtdpyXxc10fch0BWfCTtm43TzUKpMdpeRewv1NBcH8Z2F
 HtGrZeubKjSWbN5rBmWloqYC7BcZRK0PEwfE9ISijQscSwEmZxyO8Q0X/BhX6ro7TIC3
 OC/ezda6fN8bUXztt2qfzXNcc5VlfmgCzyu36Qn8V8KyahE1m+S0aohuT/kZ40/ZaDhh
 rV++01bScw1pZfSfXtcCsSE+u6wMMMXX5qJJKfUSSOwvryHVFbcknqOrkDkFMtJZP5RC
 PItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772334; x=1793377134;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AlE49BvQBS8lcAh5ZK+SkMfuBNmF3tbOuB/a4zz3eG0=;
 b=OhzfVaobwwN5BQ8Rh96IBsCwFtYQSYwdt9TMez5LQFjkX265Uy25aNvicDzy2qPksv
 uY6pGIq+0BpYIiUHCb+yGN0uoYCE1xae/IZSMYD3khb0Ki9SeWf+14XfAGpcl13dks32
 rVpefuaubygNPxtqLntSb+bXVhcfAENKANEXz56lJ+P2QYNK2jEhLEEvvoMlzcXUD6pU
 Ol+jYg6RQT2O0UsVwPYrsa2xI4dPWwUbhO2IpXoxrBU5Pi46mcnVZraTppnUO12WIIJL
 m+OrwofYYdFy9L+0WGxyUu8RxXyRQ2A5Xu4YdLZ7qDnTNWt9QXpcuNbTVIGzN5m9jRQV
 QTiQ==
X-Gm-Message-State: AFq9FYIf2LGUEmwxg2Dn4n1W5MqOfLNjzPXAY2EsZJFcM9PEvFhoDAxB
 4CGeln9tD+80VZlTmhY4WKKqyxAcWcDwnXsppC4ZyBmHbV8NXaBEvDOt3nge0wNRyPh7DSF1mqV
 jxxPMkmjh9NcC+VAnneKE3mvOAyKZWwtFJV57NkdARGh2ClbGay3ZQUwWfOeSmpwPW4SN
X-Gm-Gg: AYBFou1uMXW5TYcni4tDFxrzYyI22utZVwvOwap36MeFMKoNJOQTVbxEf0lHOUxrhnQ
 4Ot2GP/e1ZxamvxlHtA/1OJRkM1iDfpFHbKpiY13BoNIEmopsdD6m54Umw/ik7ZrTSCAytlBCKm
 BtfR4sgRtzcdaxkZxC3CWxVRD5aUBIjNlMYffSvhUiklAZo/1NiVGII85B8Y/E8BxgmFye/zjs4
 9hrkZF+QYaHX1RNQAEw8OxLzt21pT8U91irS59GSKQg1+/wtGo/hDnAOXnlS8HkoQpOHXMPdNz/
 p/UkFx3NwaV2r5h3b3t4dxBGM+Rgu5WxkSCa5Yo458LPaNwpZlsV/ghw6vMszoiPzmdvkZvMmjj
 qQFjkeUzINCu+mz6zxWpkqAudypG4950/pNiIdVjf
X-Received: by 2002:a05:620a:6009:b0:93c:b721:b10d with SMTP id
 af79cd13be357-93f6f79df64mr466958385a.8.1792772334092; 
 Fri, 23 Oct 2026 09:18:54 -0700 (PDT)
X-Received: by 2002:a05:620a:6009:b0:93c:b721:b10d with SMTP id
 af79cd13be357-93f6f79df64mr466953685a.8.1792772333438; 
 Fri, 23 Oct 2026 09:18:53 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d410708sm729357f8f.38.2026.10.23.09.18.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:18:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 44/83] target/rx: Define exception vector constants
Date: Fri, 23 Oct 2026 18:12:52 +0200
Message-ID: <20261023161332.60153-45-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SbfPpq-m_17BhGLnVZ2Vo1sLcpdvmPi6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX4TM0BLery9BV
 HZWRa6s6gNhfn5XET73aJoQIAXv2TauCewSkA9TvgpDLA7BlQKpVreu7xByEI8jLdOK/hSI9ZVd
 qkIvXmcdmjTexREWnVI+ZLPbYzi2Upw=
X-Authority-Analysis: v=2.4 cv=QdTzLcbv c=1 sm=1 tr=0 ts=6adb88ef cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=YEB5RgzmAAAA:8
 a=BYMmWKsKsDm6Gxpir0kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: SbfPpq-m_17BhGLnVZ2Vo1sLcpdvmPi6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfXyjATQibtidBW
 VtGEk/WCehk93+oMdWGv1bMRZ4uzcGqbyC/HBEKu3AFaDOxSR6u93bD62FjaQCcFpSg5VvPVwkg
 u4oA7V8uuEkjjhMLn0oCwQuta/BTBx3fxdi7qyzpVsOqq1TxHPbxJ90Ih5RjbOpcXl3FoPE/p0f
 H4ifljNJR0Flj06sIw6bTkfdInT9JBnhw0yyGmz3QD16GY7wfrsLi6AILo8jHTyzea6PO4SozXZ
 37i5pm06WN6MRtwbaRbact0tQVRVl2NkC7m7WRP0a8L7EAHcxZRJq+8Qfdg/zgbgxAXJ5SyocKX
 c1mhdv7nUXmsqEaaRjBIAJb/NFxU+LuO7Mp0BVFy97aYswLrUX9ZjPbhSb7S3tzR11o+5MHfymB
 6aju/F3idPPov6tC2j0Cvfkwm7dUn/hzcQXhgDfbljjE4IwE5XJrNAXaz+74w0rjv1zDmatAo42
 NHmUjGhHXJH5Ose0pkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230063
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

From: Yonggang Luo <luoyonggang@gmail.com>

Name RX exception vectors and trap ranges, and use the
definitions throughout exception handling and exception
raising.

Assert that exception indexes remain within the defined
range before accessing their vector tables.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Co-developed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
Message-ID: <20261022215115.19680-26-philmd@oss.qualcomm.com>
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
index fb1fa4ffa69..06841088ac0 100644
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
index 0672c5c5653..a350f6b4d26 100644
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
2.55.0


