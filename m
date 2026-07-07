Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B30C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAOH-0008I7-A3; Tue, 07 Jul 2026 14:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAMn-0006lE-4B
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:17:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAMl-0006ad-7a
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:17:56 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FTBli018008
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0oS8TlNqmKKtwABU+p3EM/iq+UpHviGBYQRG289kxeU=; b=WskoHASzqoaaPtKq
 udKRne02Q93So8g2gUfhKNUgN8qN/SnT5xQaWA7a0vRcblHvBQ+urPG95W7f+Bck
 aScdLighMDS6AxlCUzg1sU983zkAP7iFoEEFsYl5DwCQut9UyoS8JvoIj7biSsO7
 0ysOIO3oJ5BezOKgaT+qIlNaZ+jU2SHh0EhSSlVvHfKYbmfLgWzNILnR0LDcGKHr
 Oc5IDf2OAEVHbn8dloynoHeyj9dn0KL3vBpJIMa/bS174+9yX37LDH1u3L/V/WUd
 uMnASNmsF8w4m6yYFRRXHZ53UZV4Hl2V0w+jPYMV/9uU8Ji+Tx8fMy/tBMHTvMO0
 CyDiVQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8wep2p4w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:17:53 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1d137a68so104317451cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783448272; x=1784053072; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0oS8TlNqmKKtwABU+p3EM/iq+UpHviGBYQRG289kxeU=;
 b=RT9F2XQY/iyYmR4EIZHR0DlqF+x8TouBDTGHupQMhR38VUvZoRtje0F8s62nMi13S+
 7hbQEh/wdSKPaMz53HjklqUHUQp1lVIFxvvBGJI+FCyIGj3IR/L6aEB08EyRcNnLsEMf
 qku1bImIaRzVszLC1hXFfi/OoUwO/LBXosFveMwss3TaL6uqqVweHbin2k3QX97yZW0b
 R9l8v0CYKqmVyBsh5gh1tV96B/XOSnadUjzmbValGH9HscLXoAGjlqx2yI6LBOB2B5RH
 k22oPRaY6X80r8ji7lBVGoFXEQ5ah14gNEBPpDjZJrZ2UF3f97YR/wAaykwdkfTKOSsd
 5vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448272; x=1784053072;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0oS8TlNqmKKtwABU+p3EM/iq+UpHviGBYQRG289kxeU=;
 b=Y0PKrhhXgKlFrilf9NzSMu92TzXL3VUP2MsKFosljFcrCOp8hYoyT+iV6ICJhnz8Af
 q5p7CThNUs55K+VS0pmzPHonyRt4nOhRfBuKRhsxsKNNhbwIDKp2aOB9Haxr4u9OPTL0
 4yaWpOJCPXCpUPDBtAFl8rCOqgjGTlATaIeP9O7sfQ3j7SjHrm9QD1L3sSA/LOcb59b9
 lLm6VtS6qtmQtghvBqNbixvAs/ANwdUSd8XJuTYZ2/0a/4RbX3NzC7W4XzxEFGpndEia
 sI1qQuAC3H0Fjd7NUhHB7qm3PzHhJeI4erd/mvB1qj2IiTlkul0T4JVFwMW55diYGfw3
 m+vA==
X-Gm-Message-State: AOJu0YyBetSYpPBY38sgM5aPiuSIgwfSX+L+F5CpmV3u7bsPF+yzF7F/
 Sk6yrg0aYXvXtEHWEez14RmCeZCKvV2S3mHRvqoGTRyFH0foLNWXa+jnH0XOL3CplaGKY2mRt+o
 YhjZaBdRoAf0uSYOJp5MliaiioSsl7P4l/rmYsnEu8IfT5kOgTe5I8gtsUHM6KjhMbA==
X-Gm-Gg: AfdE7cn69IcdPXozjLdKFRU3deE6dub2F/C2kgaiKvmp0o3elAwsqiYHmfM2pi//QvF
 wEnlpp0ntGtBQGBo23nwhpT2ixbctWm5MOydgsG6qcqAHTMDaYvXvmJVgwOa8rU3+Ml4PTuNlGG
 iUuXpmrozhkQl/+buBu/q2GUATxGgIG9KXe7wWYXAQAc4tYxA0tvNad0QhSqijFnXQC6iiQPGe6
 7RGQt0eIPE2c8jgEDSwA7DFNTklA+RSQ5qwZ2iPgAWqcCcPNmPuP+e7yCC7LQd4B+g8fmGY3y0f
 Sxh5kJq3+V/+KXGv8r4B05P/VmiEoPaTxat4URlumDH9P6h/dKqmHy3KME9ro4D3zGA7gkgS7kV
 GzCdmtaEwq64qFcWr/uro9bWvrpWbu6I6ARnIWzK57srU/A7Jese7oqGvR5RCOhx4AgGW
X-Received: by 2002:a05:622a:15cf:b0:51b:ec6c:766c with SMTP id
 d75a77b69052e-51c747bb629mr72723151cf.12.1783448272075; 
 Tue, 07 Jul 2026 11:17:52 -0700 (PDT)
X-Received: by 2002:a05:622a:15cf:b0:51b:ec6c:766c with SMTP id
 d75a77b69052e-51c747bb629mr72722841cf.12.1783448271497; 
 Tue, 07 Jul 2026 11:17:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f2186bsm35237075f8f.36.2026.07.07.11.17.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 11:17:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/23] target/mips: add Octeon CvmCount RDHWR support
Date: Tue,  7 Jul 2026 20:15:25 +0200
Message-ID: <20260707181529.60191-21-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707181529.60191-1-philmd@oss.qualcomm.com>
References: <20260707181529.60191-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MkV2UoxO2jdBPZwq-Nq2gv4VOrCiV5u7
X-Proofpoint-ORIG-GUID: MkV2UoxO2jdBPZwq-Nq2gv4VOrCiV5u7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE4MCBTYWx0ZWRfXxNsWC9i6oopV
 6r4Fk+akgoma47IR/JyJ0ANbyLgpl4pn2sBEpFneYb00ggRhr/z5MkfHYYK2z6qRVXF14OxIHV2
 O2UekpaeaOzx79Pgezr2feVetmG9wQyycOIQQLLT0XGJmoNXqPpWN/AJ2SIdJ8rvQPso/DnM/bc
 L41rNU8HNcpnHnCItQ9iPHAOfX0xNg3oyadMIGZZxXnqfnY8jsl5IR+xFaEaYOE26FSJ/qFPRhl
 8Q9LtKRYHpJhdtUJHEBMiQi+KHSAYmoIFFNdmpywGFnxBm+bVQ/87cu54Nq4s6Vh1F3vUpAB9jZ
 4L3MJcZ3Ba4ni8PedcNV9ysSHXRzoxopRzOzzRnbG14A0zMWI8t5aGTxHCzIQH9Sqo+zjwwEMXZ
 7x4fhU6qJDGSXdpxa8MoH3lklNyzX1TPDxLKo9rSOHY7S1vEBwm2P3hBQ9LGXLkBaB2AD+bRi2M
 T231dbQr3EOyB8icx3A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE4MCBTYWx0ZWRfX00pCwxfJBac+
 dRFuSyKhVvX8MZFJhj8XQ0aCvkGu+2Q7h1G4bvESqxw60Z/9ItfsYHon+/HR1RsNP1fkUDYRKXQ
 2RNls/aU/TZ877XyljJYQVkGhF9aAQI=
X-Authority-Analysis: v=2.4 cv=atSCzyZV c=1 sm=1 tr=0 ts=6a4d42d1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=_IbzaBZH6cVti85KOtYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070180
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

From: James Hilliard <james.hilliard1@gmail.com>

Octeon exposes CvmCount through RDHWR register 31. Add the Octeon-only
decode path, enable the corresponding HWREna bit for linux-user, and use
an unsigned mask when checking HWREna so bit 31 is handled safely.

For user-mode emulation, return host ticks as a monotonic counter source
suitable for existing Octeon userspace code. In system mode, fall back to
the existing CP0 Count value.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Message-ID: <20260608-mips-octeon-missing-insns-v2-v16-20-daef7a0d8b04@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/helper.h                          |  1 +
 target/mips/cpu.c                             |  1 +
 target/mips/tcg/op_helper.c                   | 13 ++++++++++++-
 target/mips/tcg/translate.c                   | 11 +++++++++++
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 17 +++++++++++++++++
 5 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 141350e80ad..786117813ae 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -255,6 +255,7 @@ DEF_HELPER_1(rdhwr_ccres, tl, env)
 DEF_HELPER_1(rdhwr_performance, tl, env)
 DEF_HELPER_1(rdhwr_xnp, tl, env)
 DEF_HELPER_1(rdhwr_chord, tl, env)
+DEF_HELPER_1(rdhwr_cvmcount, tl, env)
 DEF_HELPER_2(pmon, void, env, int)
 DEF_HELPER_1(wait, void, env)
 
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index b223b767c9c..d72044aef61 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -320,6 +320,7 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
     env->CP0_HWREna |= 0x0000000F;
     if (env->insn_flags & INSN_OCTEON) {
         env->CP0_HWREna |= 0x40000000u;
+        env->CP0_HWREna |= 0x80000000u;
     }
     if (env->CP0_Config1 & (1 << CP0C1_FP)) {
         env->CP0_Status |= (1 << CP0St_CU1);
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index 3e586e3049e..df1b5c37347 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -25,6 +25,7 @@
 #include "exec/memop.h"
 #include "fpu_helper.h"
 #include "qemu/crc32c.h"
+#include "qemu/timer.h"
 #include <zlib.h>
 
 static inline target_ulong bitswap(target_ulong v)
@@ -209,7 +210,7 @@ target_ulong helper_yield(CPUMIPSState *env, target_ulong arg)
 
 static inline void check_hwrena(CPUMIPSState *env, int reg, uintptr_t pc)
 {
-    if ((env->hflags & MIPS_HFLAG_CP0) || (env->CP0_HWREna & (1 << reg))) {
+    if ((env->hflags & MIPS_HFLAG_CP0) || (env->CP0_HWREna & (1u << reg))) {
         return;
     }
     do_raise_exception(env, EXCP_RI, pc);
@@ -261,6 +262,16 @@ target_ulong helper_rdhwr_chord(CPUMIPSState *env)
     return env->octeon_crypto.chord;
 }
 
+target_ulong helper_rdhwr_cvmcount(CPUMIPSState *env)
+{
+    check_hwrena(env, 31, GETPC());
+#ifdef CONFIG_USER_ONLY
+    return cpu_get_host_ticks();
+#else
+    return (uint32_t)cpu_mips_get_count(env);
+#endif
+}
+
 void helper_pmon(CPUMIPSState *env, int function)
 {
     function /= 2;
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 1f449328825..e3467d15251 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -10933,6 +10933,17 @@ void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
         gen_helper_rdhwr_chord(t0, tcg_env);
         gen_store_gpr(t0, rt);
         break;
+    case 31:
+        if (!(ctx->insn_flags & INSN_OCTEON)) {
+            gen_reserved_instruction(ctx);
+            break;
+        }
+        translator_io_start(&ctx->base);
+        gen_helper_rdhwr_cvmcount(t0, tcg_env);
+        gen_store_gpr(t0, rt);
+        gen_save_pc(ctx->base.pc_next + 4);
+        ctx->base.is_jmp = DISAS_EXIT;
+        break;
     default:            /* Invalid */
         MIPS_INVAL("rdhwr");
         gen_reserved_instruction(ctx);
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index f3c52d7829e..6480c8532a1 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -330,6 +330,22 @@ static uint64_t octeon_cop2_gfm_mul_reflect_readback(uint64_t value)
     return rd;
 }
 
+static uint64_t octeon_rdhwr31_non_decreasing(void)
+{
+    uint64_t first, second;
+
+    asm volatile(
+        ".word 0x7c08f83b\n\t" /* rdhwr $8, $31 */
+        ".word 0x7c09f83b\n\t" /* rdhwr $9, $31 */
+        "move %[first], $8\n\t"
+        "move %[second], $9\n\t"
+        : [first] "=r" (first), [second] "=r" (second)
+        :
+        : "$8", "$9");
+
+    return second >= first;
+}
+
 int main(void)
 {
     assert(octeon_baddu(0x123, 0x0f0) == 0x13);
@@ -358,6 +374,7 @@ int main(void)
                0x0123456789abcdefULL) == 0xf7b3d591e6a2c480ULL);
     assert(octeon_cop2_gfm_mul_reflect_readback(
                0xfedcba9876543210ULL) == 0x084c2a6e195d3b7fULL);
+    assert(octeon_rdhwr31_non_decreasing());
 
     return 0;
 }
-- 
2.53.0


