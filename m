Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E11CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOLR-0008QA-8H; Wed, 07 Oct 2026 05:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOFS-0000Gv-Ew
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:47:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOFN-0000pB-Vt
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:47:39 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jg7B2969763
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9WLCvrMMmrY64p3hdQsyS0ecJy5N4N5pGP2XK92bKf4=; b=IuxU/8C/c5H/Gpkc
 HvEqYJpjvMujEG6EMIfPplzv3C9z8KENKBFEMI6KlYyzAGOsBRbtfK23tRhJ17mF
 75gcNW6spgbl07RFtbCH7ckPEm6q2CTqXMZef9e1/2gMqbulrS+4MB/s6PMiIjp2
 M45ZX3/xkRhi9mrWKu2VeU9nE/CoU8NxzId5zCsbj/7EptjmG/BQDK3J6P2CRyvG
 F9GVYRjqCJpfLkr+2II5oD7KqtsEJXkCgxEJMV97dwyfamdWDc3unh4s/p5N7b6v
 7j5BVW0cmAAI4IEAi6OvH2z/HUEbdwWB9J1T0KD+GkXdMoxg9vPb+bYDZKDGC+tj
 FHfidw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c679h07-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:47:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a3f673221so1024832285a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366456; x=1791971256; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9WLCvrMMmrY64p3hdQsyS0ecJy5N4N5pGP2XK92bKf4=;
 b=EKj07cC0DjRF4MQsETD7M68mgzCafmLmucaConqnT157wHphsVmGHgjcxi4JaiXkRF
 6HdqAGtbR+s5mz+QPXg80l0VaRjjx/LPRC2pBRbGdxAkPB31qfozUXAroGw/mxwKcZcU
 XG+P6+iIqkIot36EGzrRT/5QdnQSDUI+t4oiAifxCNcvji6nI3FYYFMX7cVszlkQuB2z
 Mm1WzwOVtNQuJoMcRiSMUSniU6XkCxtvlEfHGHA3IZogTSf5ADXF1vk2ysBZ8JkjjVD3
 3/lbU51cDE34l/eRtNTpmoJiwndQkZVLSW7c93NWItRTjQ9Hmo5zcYYg8l8J4VLSiyzZ
 igfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366456; x=1791971256;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9WLCvrMMmrY64p3hdQsyS0ecJy5N4N5pGP2XK92bKf4=;
 b=p+DnyKIV7uQ0u7ZQci4wIMYG6IDXDumkxqg9x1f+ZITwP8jI5mPEmkqLVwysYcOO/g
 MWomREotNMSyjVtJuOAhw9Ks14P/nbb0zuz4GDscz4fKZg3QRlfW3T/FhfLKNW+Gr1Qz
 qNKt9SF1Z1Fow3PTHR9MPdcrMkhwHc+seIc/D2M+HGbxDpy6rt5IixpFPUl37rw2yZ5c
 neca7+MQwHtPCIEoqwMS/q+0qofo+sck9msiTx3T8h6BCqRS3Zf+ZywadO7D4yxwBtLm
 b8qX+NNoqinQF1oSRT+n63MUj85Y9rFJ2I5OnpxiBt4A1gzgF7xPPEeQphnoq4NdBMQc
 e23w==
X-Gm-Message-State: AFuF++nabwrKgB5+PqOaHKokvyg5HLuv/jyfGP0xW8d2CDuJh93VZVx/
 RT0DO3CNlXcVgBeHP0PJEL5h36SKBpHUklGI+kE9lZddwYblQlWB8cJx9PlqQvDt4bGsgOMvPpZ
 INlkYqVI0TohBd556C2cQ3mgS068Ov0+7m1uakI4t8hw/6cxORq5HzUd1P1p5l5ItSoC9
X-Gm-Gg: AYBFou2AocE1XP3BKFTMeKY2deGOE71ItrUiSL9XoDSFy7KXPMI9ekuRFlPRhw9yAXV
 s0xymbHJc5+LJ68whFpyZRubKSbd2IoXKqMdXsn1hg60hB54Rn1C4QPywq0Va+vI+5hpyxKHTUT
 y7CQGqy7iHBYaPo2DJZdVQNMIl0sQcNxYrd1BkRZOsuhnf1fOZidMFmZ8dg5RtAR0hBPWKBeaXK
 ITi7wqCv8P81CjEZdZBoy1noci6goJA1JBeJ388Hgbz4p/ABhnw5xelO3ujtNjkR98J9+Y9e/SY
 HrWzq1VVtud49od4q70wOIvPbUYsQde6jsdiuMbOZkrRM5Iz19xc1rLm0fSVitXTCfl3b6sGr66
 vOWEf9ShrPkBUZUmn6KHEE1/5G6eQlsfF4GI/IQML
X-Received: by 2002:a05:620a:45aa:b0:93e:4c1e:cbbd with SMTP id
 af79cd13be357-93e9b7e0836mr312111085a.53.1791366456101; 
 Wed, 07 Oct 2026 02:47:36 -0700 (PDT)
X-Received: by 2002:a05:620a:45aa:b0:93e:4c1e:cbbd with SMTP id
 af79cd13be357-93e9b7e0836mr312107285a.53.1791366455474; 
 Wed, 07 Oct 2026 02:47:35 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178c33091sm138899805e9.4.2026.10.07.02.47.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:47:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH 19/27] target/rx: Define exception vector constants
Date: Wed,  7 Oct 2026 11:45:07 +0200
Message-ID: <20261007094516.75732-20-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX0RP+N4iyDkpU
 8A+Q2wQsTsJGFjklz3HouDIL0xpO0Om2DC5GoJCAKTIcwyVQr/x0wzyu73kMV85/+oKz4EWOL3R
 TbueY7MzoH/MPSqVrteyLrRngY/g090=
X-Proofpoint-ORIG-GUID: yxp69vDFwPyrim_-NuSVjINIy51is6c9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX4hSxwQVKyKEr
 BXIw9dbBnUqYFTekYvOcoHIGWNf1O7fXx2okEwxpdILXelzEVE82COFtsKmvIIvpdj/MT+CyPnf
 5+7QVe7LZROprpgHRbLIxlzgXmQ8Z3VFGOBfBR4TdT0gS7BJsp8dE6jMXS/kEXGlFvBLnuZDgKT
 yy6zWt8luYnPUc7rl9J95xShReWAPXZMJ4DURGhqoR8xsHzzpqMjLuxduFTILoJ911fXHV9lEfD
 SCRiHkWzM2AVvfAuRptcFAvwZeK31MlFP4CA6M81aJ5zyclzk5UGp5gHzkKLXeRcOiXaXS9gs2A
 5RFYRLP+0u+3lkXQt+hOs5jw4vWmz5OeCESfxp+77SCrm+ktugFH0NG3GdNAAHYeT6uhnzugudP
 jppxtEBculH8qftlxoiraQk7NCcRnVVWW9vjTxwhZRCl24Gf/obyhORsITZPqKnKQOSVgQMD12b
 ROsgzccgXvvP/dd7KmA==
X-Authority-Analysis: v=2.4 cv=OfcNnRTY c=1 sm=1 tr=0 ts=6ac61538 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=YEB5RgzmAAAA:8
 a=BYMmWKsKsDm6Gxpir0kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: yxp69vDFwPyrim_-NuSVjINIy51is6c9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070038
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
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
2.55.0


