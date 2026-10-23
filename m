Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2128F606A326
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oRjNBfLg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fIbVd+tr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI14-0001aF-8y; Fri, 23 Oct 2026 12:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI0f-0001Iv-2t
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:20:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI0c-0002y5-3P
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:20:48 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE63ML4064343
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xfl4AZhX7FLGzUTE81HFyoHl1mHyA1hx7sIiUGCbqOk=; b=oRjNBfLgryt+rKVy
 Wxyo6McbXWW7+GBFJiMcikfT9ZpdZW1LZaaIdEIZeXj9DeBnf0ZUY8cdIKLaghk9
 P+/PsoUKdL/G0C9dV91B4Krm1vH2Y5kOJ4FXNNaWo7U4I4XE10UWjEm4SUpbC1/T
 eNY2mz6Uwo/2FtT2Lo+2jRdrj0SgQLJ1np18N9Ig20nF2aYpvr51xd2UAaK2ztn/
 WVxLvC1k5HllBQ0svtpuKJNpUmdMC47RRySoRCyKutwVSj4dVJeIaxMltjnz3yQO
 Abfnnl4tyAzhptiutWGISynZgoG2vYBx9DHYpGvUf6Tf0iplxLgwS+iL3beULpxY
 ZgbGbg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmrch73-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:20:42 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93c5ab5c136so168569485a.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772441; x=1793377241; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xfl4AZhX7FLGzUTE81HFyoHl1mHyA1hx7sIiUGCbqOk=;
 b=fIbVd+tr4GRehWFe9HftvrRI6WPWd7hMyxIMCToFFmtkmPq16YkM1oJ31AhT04sO6z
 Zwno3/gqEgReuLuQSv4ayxspZm8YidRCMRs5Uu8a1/yLlfHabuvZR7T/no8OKomvWklz
 B3NtIswGg8v2G9VeTh4uuBAX+rE8BBtPKByO8/9jvQFVclH72RB4DlQGiPCL2ay+o8t1
 kM49dBXq6Y9R+2PucYFxDQjMjmfX6w8XXhSNONHscEBS+vTaiN2t2qr5x+gapKoJkBA3
 cfBU+cXdIGJoj2r3WP8p8/j3olB3cleqaMmH5eLd+CtC3iMKulHGyoXKqEMl9IPFgbXP
 /OJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772441; x=1793377241;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xfl4AZhX7FLGzUTE81HFyoHl1mHyA1hx7sIiUGCbqOk=;
 b=fZt5XDI0b05Iixn0evg+sj2Aigy3VRR/4SAR/3lDqYcTxmqArCl18Y+Cq0OqgTAt+E
 n+PwZt5hSQVRA18o31fMqLigSrt4ffJ4kpb6Xx6F0NrVI56Vq2N1pL8pDHr8FG7aMFd4
 tm1dvw403O72Kaf3xNO/9VA31p+XKv3uzwXbGxTvBhdUINnPfUY9QjzHbEXwybuFlJV1
 6tkzmTQ817SSbCQlWJeeo0KIhbl0KpLt7vBLSer62Xc4F0FlW9OuR6+ik7cPi2xX80n3
 I+SmCSwbWUeIqPgiGwJy2qKUA3Z/O79Ch7mprjvZ6RwKX5CRKzpX1zfUvbAgBC2Kt34X
 kWcw==
X-Gm-Message-State: AFq9FYK5hKlUTaxyQ3ATnwiSeGYrZHYEiEvKcW4xzhvDIQzmDNJOc8vv
 ZrmuYHaf3Z5adP+XqN9miGWOq0A31C8gMhEUqhNfb6yTbDhy/yMR2r7JBE4sijSdaidE++0CJdi
 U3aAHF5v1nBXlrXCBqV6QY/hFpgq3n+WxJiNnQoS7V5jaYyTya7qMU223EZsvXoSxYO1Q
X-Gm-Gg: AYBFou169ob0jY4KN3koltCg0YvmZe73ZOwNXcMSLhPHvnhKyHC1XT0ZEIurC/dg+5s
 ElNJItz4CHkJXhpxmkbXGsQYQOVZWmFn9J0QMhvKaf082l3GKXwwceU6IEqUjAvdvqb7fA4RXHr
 2bfWT3kFSXNbvOhX7GSsMlLiW/9NVf5AZgimuoH5oP0LWjVjVgSsfMkxGhT4Rdh9P3ZINvuhvG8
 AIIxdPax47Tr7wyvXhNY0NYC4pNaBpZmuVw7M6sgOwrH3qpTW5tT79H7FRz5TxDblS4+SEULTih
 uebocxdBTr21FQWpEGCiHI83+FcDvg6eQkZFzIl8jppgj3fzd9Jdg3zgzOwFvSMALuplWpx9jp6
 JxK38nhunnfRvxxhC28TPkFoirsWQ9Vbt6j9lOLQU
X-Received: by 2002:a05:620a:4394:b0:93f:38ee:68b9 with SMTP id
 af79cd13be357-93f6f657640mr507038585a.28.1792772441031; 
 Fri, 23 Oct 2026 09:20:41 -0700 (PDT)
X-Received: by 2002:a05:620a:4394:b0:93f:38ee:68b9 with SMTP id
 af79cd13be357-93f6f657640mr507032885a.28.1792772440361; 
 Fri, 23 Oct 2026 09:20:40 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2a92a42adsm16178325e9.3.2026.10.23.09.20.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:20:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 59/83] target/alpha: Determine tininess from the delivered
 result
Date: Fri, 23 Oct 2026 18:13:07 +0200
Message-ID: <20261023161332.60153-60-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MQ9fsinRrI_p38e1iDhFwLKRidIOWBwC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfXz4n8JD0X6zCs
 xq/aF8Rx7PSLRsL6iYebqmEFs7EkiMIJPqM+4EjGW/zIFFzLfHvTs1uhnDlJPZFtaLZyN4m2XET
 19UWho8flTHzRsSxzvNCkD4HlQ3TraI=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb895a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=z3b634WXv9LZD2Rr3gYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22 cc=bnc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX5/4OojrlZcWt
 jfXdkyJ2C/ZU6D2ToMFusIVsOuu6o5gvVQpk0jBjwNpwthI/4HfoWaetAd9mo+GaOBBkkbT43FI
 UG6FqFH3/CjOYYhKiKEEHEZf3b5RJ/zglp4yZPsbaxEUw8VM1vJ42sw5YEmBNKzb2OwyR8ZV73l
 t1Jn17uBI5IwSO7SacAEB2w38PxsjnXBShAaDVZsS2KtVC/daFpSKVhneJQsIq8gUHFt7tYfzgs
 B0ElGVPxp1g9Tf32x7wbZayMelLUs5eCkquGdN/XPS83R+0OCcWc6ZKnT0ONxuzhmhXhajyPeA9
 qIQJGQ+bbR5XR0e7v8nai1hLwXDx+EWivOqPGWq8MY1Q5TSAvUmhpmP0HIdFsJF1+zAnA3LrDgI
 OS7bROZsQLH4pdg1qD/SCdkWTcWMnAEnpEm6I7mDYJZ8q748t6rVkdokCQVGlzTFMjwjpha4Ezg
 FMHsMn/djNjskidpGKirjhYxJOZl9xn+ymczGTWo=
X-Proofpoint-ORIG-GUID: MQ9fsinRrI_p38e1iDhFwLKRidIOWBwC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc=bounce route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230064
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

From: Matt Turner <mattst88@gmail.com>

Alpha raises underflow only if the result it delivers is tiny.
softfloat implements IEEE 754 tininess after rounding, which rounds as
if the exponent range were unbounded.  The two disagree about a result
that rounds up to the smallest normal:

  0x4p-1024 / 0x1.0000000000001p+0 in FE_UPWARD = 0x4p-1024

The binade below DBL_MIN has a finer spacing than the denormals, so
with an unbounded exponent the quotient rounds to a value below
DBL_MIN and softfloat raises underflow.  Alpha does not.  glibc marks
math/test-float32x-float64-div as XFAIL on Alpha because of this
(glibc commit a32db99a38), and under qemu that test unexpectedly
passes.

Every result that is tiny by Alpha's rule is also tiny by the IEEE
one, so there is no need for another tininess mode in softfloat.  Pass
soft_to_fpcr_exc whether the delivered result is normal, and drop
underflow when it is.  Only the S and T format add, sub, mul, div and
cvtts helpers can underflow; the rest pass false.

An insn with a denormal operand is different.  Unless DNZ is set it
traps for software completion and the kernel computes the result, and
the kernel's emulation raises underflow in the same situation:

  0x3.ffffffffffffcp-1024 / 0x1.fffffffffffffp-1 in FE_UPWARD
    = 0x4p-1024, FPCR_UNF set

That result is tiny whether tininess is detected before rounding, as
math-emu does, or after rounding, as softfloat does.  linux-user
computes these results in the helper instead of trapping, so keep
softfloat's underflow when float_flag_input_denormal_used is set.  That
check is for CONFIG_USER_ONLY only: in system mode gen_ieee_input raises
the trap before the helper runs, and with DNZ set the operand is flushed
rather than used.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261016-alpha-fpcr-status-s-v2-2-4719bec02b3b@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/alpha/fpu_helper.c | 60 ++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index 643ce641e83..e91e907c215 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -38,7 +38,11 @@ void helper_setflushzero(CPUAlphaState *env, uint32_t val)
 #define CONVERT_BIT(X, SRC, DST) \
     (SRC > DST ? (X) / (SRC / DST) & (DST) : ((X) & SRC) * (DST / SRC))
 
-static uint32_t soft_to_fpcr_exc(CPUAlphaState *env)
+/*
+ * NORMAL is whether the delivered result is normal.  Operations that
+ * cannot underflow pass false.
+ */
+static uint32_t soft_to_fpcr_exc(CPUAlphaState *env, bool normal)
 {
     FloatExceptionFlags exc = get_float_exception_flags(&FP_STATUS);
     uint32_t ret = 0;
@@ -48,8 +52,24 @@ static uint32_t soft_to_fpcr_exc(CPUAlphaState *env)
         ret |= CONVERT_BIT(exc, float_flag_invalid, FPCR_INV);
         ret |= CONVERT_BIT(exc, float_flag_divbyzero, FPCR_DZE);
         ret |= CONVERT_BIT(exc, float_flag_overflow, FPCR_OVF);
-        ret |= CONVERT_BIT(exc, float_flag_underflow, FPCR_UNF);
         ret |= CONVERT_BIT(exc, float_flag_inexact, FPCR_INE);
+
+        /*
+         * Alpha raises no underflow when the delivered result is normal.
+         * softfloat does when that result was rounded up to the smallest
+         * normal, so drop it.  In user mode, a denormal operand means the
+         * result is the one the kernel's software completion would compute,
+         * and that does raise underflow.
+         */
+        if (exc & float_flag_underflow) {
+            bool tiny = !normal;
+#ifdef CONFIG_USER_ONLY
+            tiny |= exc & float_flag_input_denormal_used;
+#endif
+            if (tiny) {
+                ret |= FPCR_UNF;
+            }
+        }
     }
 
     return ret;
@@ -227,7 +247,7 @@ uint64_t helper_adds(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = s_to_float32(a);
     fb = s_to_float32(b);
     fr = float32_add(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float32_is_normal(fr));
 
     return float32_to_s(fr);
 }
@@ -239,7 +259,7 @@ uint64_t helper_subs(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = s_to_float32(a);
     fb = s_to_float32(b);
     fr = float32_sub(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float32_is_normal(fr));
 
     return float32_to_s(fr);
 }
@@ -251,7 +271,7 @@ uint64_t helper_muls(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = s_to_float32(a);
     fb = s_to_float32(b);
     fr = float32_mul(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float32_is_normal(fr));
 
     return float32_to_s(fr);
 }
@@ -263,7 +283,7 @@ uint64_t helper_alpha_divs(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = s_to_float32(a);
     fb = s_to_float32(b);
     fr = float32_div(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float32_is_normal(fr));
 
     return float32_to_s(fr);
 }
@@ -274,7 +294,7 @@ uint64_t helper_sqrts(CPUAlphaState *env, uint64_t a)
 
     fa = s_to_float32(a);
     fr = float32_sqrt(fa, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
 
     return float32_to_s(fr);
 }
@@ -304,7 +324,7 @@ uint64_t helper_addt(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = t_to_float64(a);
     fb = t_to_float64(b);
     fr = float64_add(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float64_is_normal(fr));
 
     return float64_to_t(fr);
 }
@@ -316,7 +336,7 @@ uint64_t helper_subt(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = t_to_float64(a);
     fb = t_to_float64(b);
     fr = float64_sub(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float64_is_normal(fr));
 
     return float64_to_t(fr);
 }
@@ -328,7 +348,7 @@ uint64_t helper_mult(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = t_to_float64(a);
     fb = t_to_float64(b);
     fr = float64_mul(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float64_is_normal(fr));
 
     return float64_to_t(fr);
 }
@@ -340,7 +360,7 @@ uint64_t helper_divt(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = t_to_float64(a);
     fb = t_to_float64(b);
     fr = float64_div(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float64_is_normal(fr));
 
     return float64_to_t(fr);
 }
@@ -351,7 +371,7 @@ uint64_t helper_sqrtt(CPUAlphaState *env, uint64_t a)
 
     fa = t_to_float64(a);
     fr = float64_sqrt(fa, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
 
     return float64_to_t(fr);
 }
@@ -368,7 +388,7 @@ uint64_t helper_cmptun(CPUAlphaState *env, uint64_t a, uint64_t b)
     if (float64_unordered_quiet(fa, fb, &FP_STATUS)) {
         ret = 0x4000000000000000ULL;
     }
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
 
     return ret;
 }
@@ -384,7 +404,7 @@ uint64_t helper_cmpteq(CPUAlphaState *env, uint64_t a, uint64_t b)
     if (float64_eq_quiet(fa, fb, &FP_STATUS)) {
         ret = 0x4000000000000000ULL;
     }
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
 
     return ret;
 }
@@ -400,7 +420,7 @@ uint64_t helper_cmptle(CPUAlphaState *env, uint64_t a, uint64_t b)
     if (float64_le(fa, fb, &FP_STATUS)) {
         ret = 0x4000000000000000ULL;
     }
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
 
     return ret;
 }
@@ -416,7 +436,7 @@ uint64_t helper_cmptlt(CPUAlphaState *env, uint64_t a, uint64_t b)
     if (float64_lt(fa, fb, &FP_STATUS)) {
         ret = 0x4000000000000000ULL;
     }
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
 
     return ret;
 }
@@ -429,7 +449,7 @@ uint64_t helper_cvtts(CPUAlphaState *env, uint64_t a)
 
     fa = t_to_float64(a);
     fr = float64_to_float32(fa, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, float32_is_normal(fr));
 
     return float32_to_s(fr);
 }
@@ -441,7 +461,7 @@ uint64_t helper_cvtst(CPUAlphaState *env, uint64_t a)
 
     fa = s_to_float32(a);
     fr = float32_to_float64(fa, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
 
     return float64_to_t(fr);
 }
@@ -449,7 +469,7 @@ uint64_t helper_cvtst(CPUAlphaState *env, uint64_t a)
 uint64_t helper_cvtqs(CPUAlphaState *env, uint64_t a)
 {
     float32 fr = int64_to_float32(a, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
 
     return float32_to_s(fr);
 }
@@ -504,7 +524,7 @@ uint64_t helper_cvttq_c(CPUAlphaState *env, uint64_t a)
 uint64_t helper_cvtqt(CPUAlphaState *env, uint64_t a)
 {
     float64 fr = int64_to_float64(a, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc(env, false);
     return float64_to_t(fr);
 }
 
-- 
2.55.0


