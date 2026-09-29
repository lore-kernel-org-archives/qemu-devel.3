Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3DCC9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 06:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBRnC-000621-JJ; Tue, 29 Sep 2026 02:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBRmu-0005yy-Gs
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 02:58:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBRms-0001dP-N1
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 02:58:04 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T47Hli2775020
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 06:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tBm/TcUhWtcLrJxa3nv5MzT9WCBk+41V2EDjg42P7aQ=; b=bVZ1q2xuq3WqHC62
 68cjbrELWk0yGh8oh4aeZqjxkgSzAQ0TdCizDnLAy3YaKb+HEzpTLWPQTP11BWDu
 7hxOIqqdj9J5jolitZTsn6g7Z8+eSlXB/7XS5cdy8ho2v08EgjMAOPa8J/vOoqLv
 ZjXGO7AhjsCY48LhFiT1kZJP9TE+yz/vb5qeiwsstytaOlBdywQ+u7/litCBRYdU
 6eZr65uK7GXRLf90gH2fs69QR0cKDqMGQf6YrYw9yWjVG9jRPLjIWO4yUnzEyJ9l
 dgA95HF7RGtGx7Hrcc/p+PDU57lRegO9WYpOm6wUC7nE2f5BX4Gm7cn+bQyQFjdR
 wE6eSA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyvw22pd5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 06:58:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93be1861d2dso652962385a.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 23:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790665080; x=1791269880; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tBm/TcUhWtcLrJxa3nv5MzT9WCBk+41V2EDjg42P7aQ=;
 b=asELbwJWqbyvFXTpj3c8L9QQCkTBkAw2VO1pJ6Etds8LA+J1q5IivfdSSr/tyOwbZC
 gx2lpnht9BCoDmfX4+FMy+H9l2RMBV4I1RpjdQJW4Y2ekXQMHdPQuaTWLRTTzC+IynqL
 sm4QjwTA7Uw9L8caHNLaRvQZgABFvEmBt2CKMv0DU+HRDK1vCj8VEgB0uW1xNmiSnkt5
 R7sBahExrCKk1+P0OtO2zomjWbbFYaFs8iAE1QIYOwfF0/g01gTIROMEN6TFqbyV/y0E
 G0MReNUmP4B+a++sEKD3T+s+be0STlmPkmy3PPXgjVcbH5kC2h6WWE25u3T6o+XRvbl+
 lGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790665080; x=1791269880;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tBm/TcUhWtcLrJxa3nv5MzT9WCBk+41V2EDjg42P7aQ=;
 b=n+uknTu8f50U6rRYdT3pP1VLFIRYg8/MoNkd6cbqL1lsOmsBejBc+TLVpEozy1fh4Y
 hDj4JFXaiBOljYVgOmU/jfla2aRqO3Crnwi9kLPGF+ibanDKcsDQvto3HQKR/L2IxR/i
 0MLFPvrxbGuS2ZSg+Lc5byfIA50OFaQFjcH/7pC9xsTAkGcIy1UzVWprzOmDAnnmdL5P
 t/jvRmcV97TQAZDS2QNtfxv0DxOY2MuHonbopTGdydQ88+ntPTluzdCL8mnKN5y8oWnt
 096RDDh934+dxg66ECxlaG6afnyYzgo1w3oedMzdDYArHpOmixPLVP2Z5pWSlP530dIE
 tmAw==
X-Gm-Message-State: AFuF++m3tuEOIy9J/ZcgwZQlqHICqW/gAZnkl24nCdDnWfkEvIv4Xdek
 iGKud6MPULav/+EVvI5dpa6phwbFh/70Lf/eR7JnR69q0GFvlnBC/dY07jmWD/vkgARHj9VlkYQ
 igg6vj8WkClG6o4BHly5sdy6nMeaZpZkHqlul27ytnsXck890Sh4q8bwvI4pjuD5WYA==
X-Gm-Gg: AYBFou32ijZUkkSXnqn67KO1+W+1M6xJiwuA/Ggh6FyXLGbyhxH1jgZA0hEdBhI5VNW
 QzdLI+wTr6U4esqewJJGIzzWiuSq2XWnXYyUH7buCw0v+Y8DjapqjhllunxLCtI//D3KluZg3m0
 5DpX0s08S5OPOivZg1tIgj5JO32MNLJpwh2bdFESp/37kIa80AefeLcPilVEYU26HK+6QECrsul
 FLlvXyOiXqW6Xm14MAk2MqHjgURGseV5BE0SZnSNpYGvOKg5C7PpLWU/NrMe1sGPjOf1ZSOA6c/
 0oMoM85KabBciAWrZasTv+YknZM2qa7uSExUVhYglkZZCLvfOXXQpcAYw6ystNinJ9cTo6HDcvN
 nmAbFENwP36QXfYaevG00S0NMmxvTk/kvo6soR/1E
X-Received: by 2002:a05:620a:271d:b0:939:7fc4:fb1a with SMTP id
 af79cd13be357-93c43bf2684mr2257592685a.27.1790665080334; 
 Mon, 28 Sep 2026 23:58:00 -0700 (PDT)
X-Received: by 2002:a05:620a:271d:b0:939:7fc4:fb1a with SMTP id
 af79cd13be357-93c43bf2684mr2257589185a.27.1790665079802; 
 Mon, 28 Sep 2026 23:57:59 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af508bb41sm1691686f8f.28.2026.09.28.23.57.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 23:57:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 2/2] target/rx: Define exception vector constants
Date: Tue, 29 Sep 2026 08:57:50 +0200
Message-ID: <20260929065750.9550-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929065750.9550-1-philmd@oss.qualcomm.com>
References: <CAE2XoE9VC6YfqsOQBM_KLrdaKpU-=bD9CscCDGi63EsQt-EhFg@mail.gmail.com>
 <20260929065750.9550-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=N6i8hG9B c=1 sm=1 tr=0 ts=6abb6179 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=KwDs--hy771jlAYoLH4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: K1f_blbL0KMealA3_vaROq0XKwQ4VJLe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyNyBTYWx0ZWRfX94zKx69aLdvO
 AceBRGp/IiWMCrvRUlBtoDxovyDh2EJL2UbxyZ501R3m464bCY/MJgM9E29xr84TEBTOvHkSlaQ
 2m/9DTsO3I8o7ax0JROOnW7Kgp/14l7eds6wCFJb/oAbfEP3Gt+Rtvi7G7N1HrVKcVBOC4DuUz0
 MxvS3t4m315f+t4p0Qj0bMEmKZo3uM7rcdA+EeKptpII32PHeILYTQ+mBycN+IafMEb5L38SqXp
 TLOhzXdHV/Xjd8Evb/kCFS88kfPniHcB59Fs0FLLZdS67dglyrDIxPeKSc4TUZoF6sE7xIF0OHZ
 KKeZ9FAFZj0oqwx7Z+fP14kGCsBLBsNMk/qzzGboeWxz1h808ZpQD7Pz8bhTRslZwe+xpo2ECOI
 ZXy3GzlmKwZ/p5WwfDR4WA3GzwxcK0d96RiB34vbfUaqC+HSRl7NiffqYn3w2b5vPW4c3R6DjRf
 7kUUIFPZxK+KsCQE7ew==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyNyBTYWx0ZWRfX0DRnzv76l/rk
 KxTyF0T6U4mZrI4WApeDg8kbdLBicroXgx/yyGobb3lF2U56vh/jVoD8xa1f2q1xCi7krJaP6Yp
 MUG9hUA5BxtFSmIEELx2/u8jX9522h8=
X-Proofpoint-GUID: K1f_blbL0KMealA3_vaROq0XKwQ4VJLe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290027
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


