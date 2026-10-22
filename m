Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84FB606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xmw3xkdS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eoNP6Bfy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0k3-0003ph-7a; Thu, 22 Oct 2026 17:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0k0-0003hX-5Q
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:54:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0jy-0007lT-B3
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:54:27 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIH1gn1509604
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:54:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sSEy/zV1vSGWM8tSEkQ09OgTFOceEnOpAw1aDiPB/jI=; b=Xmw3xkdSiUbf+X64
 kLk3C+qFaX2umgNH3JpQ56ZVf+f1CQ+7Ya8nOVlPMWhCeH3eLpL/rjlvJxekKvEA
 8wVLnP/7jgzaKRDbSdXBKKtOAzvNlCHEhhUSRf/WTWYPlg9IkkUZy/bbd4hr+ynC
 YLiIgkEXMBFOvUtJ33YcUmJhLJkF1NtBNuh84+6dOtgTDM1GRWCZXj2gcftUlZUp
 rj+AomLJkh/iWHientTFh/yAisI0Fb3/Iepg7fy/IztHH45H3FczHn0PMexK0mFN
 aVWaWYDnylcrsR95PTQS86MHD6Vj7YcOKQtyZCCkcfFcUh3s9P4aq1F/ltKaT8iM
 T8ZDuA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmp8qpm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:54:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb71b1443so51074785a.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706064; x=1793310864; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sSEy/zV1vSGWM8tSEkQ09OgTFOceEnOpAw1aDiPB/jI=;
 b=eoNP6BfyaRVtygKp0d2nau0zc7a1ZlC7kOV5m76WmTuLyjgI7c42eLmAF7S78ktIPH
 jUWaas4TJIpZCVoIIph5XOE8chgLbz/HHOMd4lOboi3UTk/0JP1TAMIrVZ2+Eo6hx9ui
 5RmzLfH4PUZuALZjGUu5BPkm++7CT5lEIwg83N5kaowJm5oqJVzrdEpQgnQMVkm+RExe
 HIe3QqIUEGLWuVXGen3F7JNdB5DDMnA2HcNgC4bkurIYPAe47FaL9iXxWN8Je/QX/61O
 NAJzhsnCxxAIcs/H0X+aKP0acKUlvMzDWWScMvrnGCWL/BgIcvJxVIN+nPrBbuo7mQoM
 TMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706064; x=1793310864;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sSEy/zV1vSGWM8tSEkQ09OgTFOceEnOpAw1aDiPB/jI=;
 b=ZUwHQ2XNuoTIVkGzbEhl+sLpPYyECEydEmR0a3DWu6Fjfi7za3BytIZQat+qhCmT6H
 b5+YXlfvi0WwuHATcKUsne0PdW3jmkGbGCXB4wQNX5xkIFWXnYAVq7ZWtx1gQ3a1bJc1
 aipOIgLp6dVHBm9psLaVLZTRid+tbE01h5c8D5ycTO6yh4ybfwcAJ2E2I7H4C9caVkYt
 efba0dcfAReYAjAHu71zLRvYB62y3c3BefV0v6MUqTdLOnFIb/LeIqV/i7NL18ZbkBJI
 NOa+QjEOxTnbhTf6bNY8W9+ujg2g0nYIW3bxu90Kg3i7gAQZb6kg0MlsKVY8s204V4gD
 2ElQ==
X-Gm-Message-State: AFq9FYLdtNmaWK4uoqCnLSMERuiDHPJDpusLIFMNE18Kbcnca52I5xua
 mRyrg8yEkbQwOO9I1tcCl905MZ/RyEaTAvxRHnermlwPcpSDiA6Ksn02X+CdrHWcOhr+GXGSLoU
 kgAtAkV41yw13AqQ131v4S9hl3XoDr3jo94DgWsOFNwt2a0D2FvghboCWVnb5cIpGdg==
X-Gm-Gg: AYBFou1ulK25d45uWgp5tOazLyNhDEvlefEX8lUu7bOZEy0HJKcVnzsh3bBhMgiFym8
 dABv/L+W3v+nJAK90E46RGxJC1sCx3ncS7gjJDdWiEmm8euJGEF14Exi3jmhAyzk4vkPyxpV8ND
 Qbsonq+1UcEusaZ0W3E1T0G0enPmotNwodZnVc2x8EuWUbmefYXpTau9FuWf53NpQOtJjfYJa6X
 fhftNshkjHYslo7Fl3mFf1NfrceAh6zBEUp1qfwCEFlaIOTxWlHoZ9QnlmiNPY+XVitHZdoKBEH
 uQxuW1ghzNim3gl3kiMW5sTtQXEL8fSiUla96tFfWtGQzP9eWXCagtRvafQI3jiuBIMKwaAfQDa
 qz1RAVPq+f3t8yGIzMR0M7klmt6VsTqshF1VwoYff
X-Received: by 2002:a05:620a:6188:b0:93e:a8c5:132f with SMTP id
 af79cd13be357-93f6f788f5cmr149112985a.29.1792706063768; 
 Thu, 22 Oct 2026 14:54:23 -0700 (PDT)
X-Received: by 2002:a05:620a:6188:b0:93e:a8c5:132f with SMTP id
 af79cd13be357-93f6f788f5cmr149110685a.29.1792706063266; 
 Thu, 22 Oct 2026 14:54:23 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e37edfb3fsm833889f8f.8.2026.10.22.14.54.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:54:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH v3 25/33] target/rx: Define exception vector constants
Date: Thu, 22 Oct 2026 23:51:05 +0200
Message-ID: <20261022215115.19680-26-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX7EPrwbT+3V88
 HGNOx8R5Xdw8HYFNYjCzBUCFlzjLGh5M9vDhajy3k1/0J8lcY35WGqsrneKvMcRF0wDM9AtXZAM
 du2tw9opXTGxzsAOl4U3cQKKGRg70cw=
X-Proofpoint-GUID: RzApq42aC4ltIDX1rbtLqM8vEI1-yy1s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX13XWXeZtDwch
 KYpeKRIMazcMyBZb4QiPw89l511ymdit0L3TqwzH3yCDUa/nOXNTnCbOglzp/3sAHLk7ggu54zs
 ZvPJDAkkM5owhRtXEAKGwBFisEBJq1KcISdgdv33Wa8gPYO7I/Oa6ZDeZveouPV1MShgOxGi5AB
 rt/0NvZHOBwuDIsTPmfb3tm17SlIW2+PSaS2ANWyhUBFeTZYiSNMVvBT1l9j4KoRfcRBlJLu2ES
 1tyGAKoBDFXF9MKmRApzbFSZIhwVI7YNJYhkV1UBn2Oq89G7Whn/TV3RZuVzOiV7eWYHvLl1GUF
 +Bj94pSxut61sW7+lJ3VHT/V8uF+lQ9z8uBrr/a1A0kvd5XoouPba9y1GjcAffxgW0e1d0Xce5l
 xjUYLqkVULxTKIvrnWwab9UcQKO44TMxbHeZTMz+iVwAqYh80xSsGPCIOFkAgGbvKK8Cu9tAzGT
 xo/lMCzLl8h20fEVJXw==
X-Proofpoint-ORIG-GUID: RzApq42aC4ltIDX1rbtLqM8vEI1-yy1s
X-Authority-Analysis: v=2.4 cv=BdBNQbt2 c=1 sm=1 tr=0 ts=6ada8610 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=YEB5RgzmAAAA:8
 a=BYMmWKsKsDm6Gxpir0kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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


