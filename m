Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAD5606A31D
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e5grbRur
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKRM9-0001dU-K3; Fri, 23 Oct 2026 22:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xKRM8-0001dK-Ul
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 22:19:36 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xKRM5-0002fY-Kq
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 22:19:36 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-6768403e9bbso1583071d50.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 19:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792808372; x=1793413172; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UE2Frc2kqLcoawgb2wKSXr6MfkU9KQjspmswVI0apew=;
 b=e5grbRurj3PlsfB8XgBtu3Lrv5+lqo1+H0RkwMm4TeL1ekB4idDtSbaq+SxXMohmpb
 1MhKW/ULeVx9wn4vAsz3HcBk1L6Pj6D7wBDGXhB/KC/xf8NCiMzZua9yrRJAd8LHrj4C
 ZgtmqvScjSUcfg2Mk5opWwH2pW5zH+eALRPDKv0DyXB4PCp6692JpuNFj+lFGsEYlih7
 eWj2SXhsB2CW9XujsCsCUgnpQ6Q99JlPe9IqMg3lhFDjyNZWpUzKqlVRjWfPnTPMSE6f
 dYBeKWbPSq6AFEvSX3ADcshhgFUwFtgXLkzLpz0AKfK6IFoGKOmbXc91qVLHx4WIvaKt
 0QjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792808372; x=1793413172;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UE2Frc2kqLcoawgb2wKSXr6MfkU9KQjspmswVI0apew=;
 b=kMiktxKsyixGWkOD9EpsO+6g7Q01GCSNPrXr7MqALKTwdZZknbuaEDFT+7/dn/0Oxi
 xwJOL35VIfT8AzwX/uVQPWmXsdhGcjN5x1CpEiO3w+QcSEUGOk1lxaN9vRyWKMzMepTR
 78XH94bS0V7xq3N8YjZvjEHJgQxWQGC+2VBif7gzyU0mvCOypWOk1huLR9iq0AvUPQSU
 YF+pFzIrBtCEP+9O1kgiRLnTpFJhQDOBwUmDE4WuJR4pWyC07yuN02389FKnrBkI/7Lz
 la1xEGXs9b5MVsLN3sAaNM+FSqdmLnldxTQmoE9a+tY08uuOZ7zIGtcx+kT6XxZc0Qsr
 KKmQ==
X-Gm-Message-State: AFq9FYIhaoI9/71DTc7Bhw6F4rDJpX0JuiwwB93lwkc9SDejmeX3ZsAo
 Mk5kYHw5zJrP1jOq1X/sZ4J7s4r4JTihcKbpGDeLYaWjELZWyNaINUk7
X-Gm-Gg: AYBFou1fAt3LM683U+Hpjp6nqWeX2GemNrnfALf+EQ9QksY8lSzs7uOhKFobw1DTEoy
 Pf+tCyNYacg+kolb2UZ1KuQ/wnKYEvd/9RqIBEgYR0vhdCGrluvJsqEu3RkYVgG2PAEtn8g5gfx
 RbOrGJvtzZhi8N4MOov74//cPGNVSuX6qDzwWtgn3MRqs2YK1nEB9EBbri4UKf8mg43BlBTqdpF
 MI2fsXdVluhbEVjTt7ONAfESWYzwlQjmPUYdcq6ppTBQORTQ6f+0vXRAKTM+7jxCC6OZCLwSj6q
 DHD55/fAZz+yFY1X0iHBFOKaR7z3k/3GFd/DQ0Owfq+/0T9fnc2hzcTSQEmp6pl+rn/znx/9LAB
 86JdMFmqHWbV6ywu+P0J2BdBrOnDFU/kJMdAlccxxsBPaU09/6bFnRsE7/Cphj1gyoRhEcm3WSw
 HIFlR5TzsmDC68fIS/pCdKrHURtqpbtf4KvYBea2F5vvHJbZaLPQAZMbOtOEFV8dQjNKNZIVDtu
 cJZxJkZ6rfKg+igUaVdJh16Lc/GYBpA88sSPS108hIv/4v6+Un6lVN0k3gHyXcGSM+BXKf5Xt1c
 MvVaMsNOGkpK6Pi3Y9bihRI8edmee2wzc8GQSA==
X-Received: by 2002:a05:690e:4390:b0:677:c605:b736 with SMTP id
 956f58d0204a3-67a453d1aefmr609655d50.43.1792808372213; 
 Fri, 23 Oct 2026 19:19:32 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b166dcf529sm4872937b3.12.2026.10.23.19.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 19:19:30 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 23 Oct 2026 22:19:27 -0400
Subject: [PATCH v3 1/3] target/alpha: Report invalid for an overflowing
 CVTTQ/SV in linux-user
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-alpha-fpcr-status-s-v3-1-7d11facb8a50@gmail.com>
References: <20261023-alpha-fpcr-status-s-v3-0-7d11facb8a50@gmail.com>
In-Reply-To: <20261023-alpha-fpcr-status-s-v3-0-7d11facb8a50@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=24994; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=/sav0xGkFvsk2IScISf7gfmqdnngL4ZH4R265MeD85Q=;
 b=kA0DAAoWrOspdAyaTpcByyZiAGrcFa6i4GVxA92EmYg0w0IVi5Ba79Y8TUxpgOL+bJTYMbrAX
 4jxBAAWCgCZFiEEXq8hBJqGuKVMyxv6rOspdAyaTpcFAmrcFa4bFIAAAAAABAAObWFudTIsMi41
 KzEuMTIsMiwyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9wZW5wZ3AuZmlmdGhob3J
 zZW1hbi5uZXQ1RUFGMjEwNDlBODZCOEE1NENDQjFCRkFBQ0VCMjk3NDBDOUE0RTk3AAoJEKzrKX
 QMmk6XsdwBALFvybAcVjRmheua6bNBMvcENGj0gzaR6tte3soZHWj5AQC+J9EymYXkoPirjQi+r
 MsJIwpAkZMGj/zojw+lpNfYBg==
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A CVTTQ whose result overflows sets IOV and INE in the FPCR. With /V
the IOV traps, and with /S the kernel completes the instruction in
software. Its emulation reports the overflow as an invalid operation,
so on hardware the program sees FE_INVALID. For example, (int64_t)0x1p63
compiled with gcc -mieee is a CVTTQ/SVC and raises FE_INVALID.

linux-user stands in for the kernel here, but it records the IOV
unchanged. glibc maps that to no FE_* flag, so the program sees no
exception.

When an IOV traps for software completion in linux-user, report INV as
the kernel does. Since Linux v7.3 the kernel also drops the INE that
the hardware recorded alongside the IOV, because its emulation does not
raise it (commit bcfe3187412e, "alpha: don't leak hardware-fabricated
FP exception bits to user space"), so drop it too. The IOV itself stays
in the FPCR, as it does on hardware. System mode is unchanged, since
there the guest kernel does the completion.

Update the float_convd and float_convs reference files, whose
out-of-range integer conversions now report INVALID. The new output
for those conversions matches an AlphaServer ES47 (EV7) running Linux
v7.3.

tests/tcg/alpha/test-cvttq expected IOV and INE for an overflowing
CVTTQ/SVIC, the bits the hardware records before the trap. On the
ES47 the program reads back IOV and INV, which is what it gets now.
Update its expectations.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 target/alpha/fpu_helper.c       |  10 ++
 tests/tcg/alpha/float_convd.ref | 256 ++++++++++++++++++++--------------------
 tests/tcg/alpha/float_convs.ref | 160 ++++++++++++-------------
 tests/tcg/alpha/test-cvttq.c    |   6 +-
 4 files changed, 221 insertions(+), 211 deletions(-)

diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index 529eadca9f..eb2bd51a66 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -88,6 +88,16 @@ void helper_fp_exc_raise_s(CPUAlphaState *env, uint32_t ignore, uint32_t regno)
 {
     uint32_t exc = env->error_code & ~ignore;
     if (exc) {
+#ifdef CONFIG_USER_ONLY
+        /*
+         * An integer overflow that is not ignored traps for software
+         * completion. The kernel's emulation reports it as invalid and
+         * drops the inexact that the hardware recorded with it.
+         */
+        if (exc & FPCR_IOV) {
+            exc = (exc & ~FPCR_INE) | FPCR_INV;
+        }
+#endif
         env->fpcr |= exc;
         exc &= env->fpcr_exc_enable;
         /*
diff --git a/tests/tcg/alpha/float_convd.ref b/tests/tcg/alpha/float_convd.ref
index 75c2139d60..437c08660c 100644
--- a/tests/tcg/alpha/float_convd.ref
+++ b/tests/tcg/alpha/float_convd.ref
@@ -19,34 +19,34 @@ from double: f64(-inf:0x00fff0000000000000)
   to uint64: 0 (INVALID)
 from double: f64(-0x1.fffffffffffff0000000p+1023:0x00ffefffffffffffff)
   to single: f32(-inf:0xff800000) (OVERFLOW )
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000)
   to single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000)
   to single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.1874b135ff6540000000p+103:0x00c661874b135ff654)
   to single: f32(-0x1.1874b200000000000000p+103:0xf30c3a59) (OK)
-   to int32: 0 ()
-   to int64: 5575456338684674048 ()
-  to uint32: 0 ()
-  to uint64: 5575456338684674048 ()
+   to int32: 0 (INVALID)
+   to int64: 5575456338684674048 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 5575456338684674048 (INVALID)
 from double: f64(-0x1.c0bab523323b90000000p+99:0x00c62c0bab523323b9)
   to single: f32(-0x1.c0bab600000000000000p+99:0xf1605d5b) (OK)
-   to int32: 0 ()
-   to int64: 7936327705845301248 ()
-  to uint32: 0 ()
-  to uint64: 7936327705845301248 ()
+   to int32: 0 (INVALID)
+   to int64: 7936327705845301248 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 7936327705845301248 (INVALID)
 from double: f64(-0x1.00000000000000000000p+1:0x00c000000000000000)
   to single: f32(-0x1.00000000000000000000p+1:0xc0000000) (OK)
    to int32: -2 (OK)
@@ -205,22 +205,22 @@ from double: f64(0x1.fffffffc000000000000p+30:0x0041dfffffffc00000)
   to uint64: 2147483647 (OK)
 from double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000)
   to single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000)
   to single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(0x1.fffffffffffff0000000p+1023:0x007fefffffffffffff)
   to single: f32(inf:0x7f800000) (OVERFLOW )
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(inf:0x007ff0000000000000)
   to single: f32(inf:0x7f800000) (OK)
    to int32: 0 (INVALID)
@@ -266,34 +266,34 @@ from double: f64(-inf:0x00fff0000000000000)
   to uint64: 0 (INVALID)
 from double: f64(-0x1.fffffffffffff0000000p+1023:0x00ffefffffffffffff)
   to single: f32(-inf:0xff800000) (OVERFLOW )
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000)
   to single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000)
   to single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.1874b135ff6540000000p+103:0x00c661874b135ff654)
   to single: f32(-0x1.1874b200000000000000p+103:0xf30c3a59) (OK)
-   to int32: 0 ()
-   to int64: 5575456338684674048 ()
-  to uint32: 0 ()
-  to uint64: 5575456338684674048 ()
+   to int32: 0 (INVALID)
+   to int64: 5575456338684674048 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 5575456338684674048 (INVALID)
 from double: f64(-0x1.c0bab523323b90000000p+99:0x00c62c0bab523323b9)
   to single: f32(-0x1.c0bab600000000000000p+99:0xf1605d5b) (OK)
-   to int32: 0 ()
-   to int64: 7936327705845301248 ()
-  to uint32: 0 ()
-  to uint64: 7936327705845301248 ()
+   to int32: 0 (INVALID)
+   to int64: 7936327705845301248 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 7936327705845301248 (INVALID)
 from double: f64(-0x1.00000000000000000000p+1:0x00c000000000000000)
   to single: f32(-0x1.00000000000000000000p+1:0xc0000000) (OK)
    to int32: -2 (OK)
@@ -452,22 +452,22 @@ from double: f64(0x1.fffffffc000000000000p+30:0x0041dfffffffc00000)
   to uint64: 2147483647 (OK)
 from double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000)
   to single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000)
   to single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(0x1.fffffffffffff0000000p+1023:0x007fefffffffffffff)
   to single: f32(inf:0x7f800000) (OVERFLOW )
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(inf:0x007ff0000000000000)
   to single: f32(inf:0x7f800000) (OK)
    to int32: 0 (INVALID)
@@ -513,34 +513,34 @@ from double: f64(-inf:0x00fff0000000000000)
   to uint64: 0 (INVALID)
 from double: f64(-0x1.fffffffffffff0000000p+1023:0x00ffefffffffffffff)
   to single: f32(-inf:0xff800000) (OVERFLOW )
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000)
   to single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000)
   to single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.1874b135ff6540000000p+103:0x00c661874b135ff654)
   to single: f32(-0x1.1874b200000000000000p+103:0xf30c3a59) (OK)
-   to int32: 0 ()
-   to int64: 5575456338684674048 ()
-  to uint32: 0 ()
-  to uint64: 5575456338684674048 ()
+   to int32: 0 (INVALID)
+   to int64: 5575456338684674048 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 5575456338684674048 (INVALID)
 from double: f64(-0x1.c0bab523323b90000000p+99:0x00c62c0bab523323b9)
   to single: f32(-0x1.c0bab600000000000000p+99:0xf1605d5b) (OK)
-   to int32: 0 ()
-   to int64: 7936327705845301248 ()
-  to uint32: 0 ()
-  to uint64: 7936327705845301248 ()
+   to int32: 0 (INVALID)
+   to int64: 7936327705845301248 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 7936327705845301248 (INVALID)
 from double: f64(-0x1.00000000000000000000p+1:0x00c000000000000000)
   to single: f32(-0x1.00000000000000000000p+1:0xc0000000) (OK)
    to int32: -2 (OK)
@@ -699,22 +699,22 @@ from double: f64(0x1.fffffffc000000000000p+30:0x0041dfffffffc00000)
   to uint64: 2147483647 (OK)
 from double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000)
   to single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000)
   to single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(0x1.fffffffffffff0000000p+1023:0x007fefffffffffffff)
   to single: f32(inf:0x7f800000) (OVERFLOW )
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(inf:0x007ff0000000000000)
   to single: f32(inf:0x7f800000) (OK)
    to int32: 0 (INVALID)
@@ -760,34 +760,34 @@ from double: f64(-inf:0x00fff0000000000000)
   to uint64: 0 (INVALID)
 from double: f64(-0x1.fffffffffffff0000000p+1023:0x00ffefffffffffffff)
   to single: f32(-inf:0xff800000) (OVERFLOW )
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000)
   to single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000)
   to single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.1874b135ff6540000000p+103:0x00c661874b135ff654)
   to single: f32(-0x1.1874b200000000000000p+103:0xf30c3a59) (OK)
-   to int32: 0 ()
-   to int64: 5575456338684674048 ()
-  to uint32: 0 ()
-  to uint64: 5575456338684674048 ()
+   to int32: 0 (INVALID)
+   to int64: 5575456338684674048 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 5575456338684674048 (INVALID)
 from double: f64(-0x1.c0bab523323b90000000p+99:0x00c62c0bab523323b9)
   to single: f32(-0x1.c0bab600000000000000p+99:0xf1605d5b) (OK)
-   to int32: 0 ()
-   to int64: 7936327705845301248 ()
-  to uint32: 0 ()
-  to uint64: 7936327705845301248 ()
+   to int32: 0 (INVALID)
+   to int64: 7936327705845301248 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 7936327705845301248 (INVALID)
 from double: f64(-0x1.00000000000000000000p+1:0x00c000000000000000)
   to single: f32(-0x1.00000000000000000000p+1:0xc0000000) (OK)
    to int32: -2 (OK)
@@ -946,22 +946,22 @@ from double: f64(0x1.fffffffc000000000000p+30:0x0041dfffffffc00000)
   to uint64: 2147483647 (OK)
 from double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000)
   to single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000)
   to single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(0x1.fffffffffffff0000000p+1023:0x007fefffffffffffff)
   to single: f32(inf:0x7f800000) (OVERFLOW )
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(inf:0x007ff0000000000000)
   to single: f32(inf:0x7f800000) (OK)
    to int32: 0 (INVALID)
diff --git a/tests/tcg/alpha/float_convs.ref b/tests/tcg/alpha/float_convs.ref
index 3c9f29faf9..aa8f7d7d20 100644
--- a/tests/tcg/alpha/float_convs.ref
+++ b/tests/tcg/alpha/float_convs.ref
@@ -19,22 +19,22 @@ from single: f32(-inf:0xff800000)
   to uint64: 0 (INVALID)
 from single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff)
   to double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.1874b200000000000000p+103:0xf30c3a59)
   to double: f64(-0x1.1874b200000000000000p+103:0x00c661874b20000000) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.c0bab600000000000000p+99:0xf1605d5b)
   to double: f64(-0x1.c0bab600000000000000p+99:0x00c62c0bab60000000) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.31f75000000000000000p-40:0xab98fba8)
   to double: f64(-0x1.31f75000000000000000p-40:0x00bd731f7500000000) (OK)
    to int32: 0 (OK)
@@ -157,16 +157,16 @@ from single: f32(0x1.ffc10000000000000000p+16:0x47ffe080)
   to uint64: 131009 (OK)
 from single: f32(0x1.c0bab600000000000000p+99:0x71605d5b)
   to double: f64(0x1.c0bab600000000000000p+99:0x00462c0bab60000000) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff)
   to double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(inf:0x7f800000)
   to double: f64(inf:0x007ff0000000000000) (OK)
    to int32: 0 (INVALID)
@@ -206,22 +206,22 @@ from single: f32(-inf:0xff800000)
   to uint64: 0 (INVALID)
 from single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff)
   to double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.1874b200000000000000p+103:0xf30c3a59)
   to double: f64(-0x1.1874b200000000000000p+103:0x00c661874b20000000) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.c0bab600000000000000p+99:0xf1605d5b)
   to double: f64(-0x1.c0bab600000000000000p+99:0x00c62c0bab60000000) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.31f75000000000000000p-40:0xab98fba8)
   to double: f64(-0x1.31f75000000000000000p-40:0x00bd731f7500000000) (OK)
    to int32: 0 (OK)
@@ -344,16 +344,16 @@ from single: f32(0x1.ffc10000000000000000p+16:0x47ffe080)
   to uint64: 131009 (OK)
 from single: f32(0x1.c0bab600000000000000p+99:0x71605d5b)
   to double: f64(0x1.c0bab600000000000000p+99:0x00462c0bab60000000) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff)
   to double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(inf:0x7f800000)
   to double: f64(inf:0x007ff0000000000000) (OK)
    to int32: 0 (INVALID)
@@ -393,22 +393,22 @@ from single: f32(-inf:0xff800000)
   to uint64: 0 (INVALID)
 from single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff)
   to double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.1874b200000000000000p+103:0xf30c3a59)
   to double: f64(-0x1.1874b200000000000000p+103:0x00c661874b20000000) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.c0bab600000000000000p+99:0xf1605d5b)
   to double: f64(-0x1.c0bab600000000000000p+99:0x00c62c0bab60000000) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.31f75000000000000000p-40:0xab98fba8)
   to double: f64(-0x1.31f75000000000000000p-40:0x00bd731f7500000000) (OK)
    to int32: 0 (OK)
@@ -531,16 +531,16 @@ from single: f32(0x1.ffc10000000000000000p+16:0x47ffe080)
   to uint64: 131009 (OK)
 from single: f32(0x1.c0bab600000000000000p+99:0x71605d5b)
   to double: f64(0x1.c0bab600000000000000p+99:0x00462c0bab60000000) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff)
   to double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(inf:0x7f800000)
   to double: f64(inf:0x007ff0000000000000) (OK)
    to int32: 0 (INVALID)
@@ -580,22 +580,22 @@ from single: f32(-inf:0xff800000)
   to uint64: 0 (INVALID)
 from single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff)
   to double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.1874b200000000000000p+103:0xf30c3a59)
   to double: f64(-0x1.1874b200000000000000p+103:0x00c661874b20000000) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.c0bab600000000000000p+99:0xf1605d5b)
   to double: f64(-0x1.c0bab600000000000000p+99:0x00c62c0bab60000000) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.31f75000000000000000p-40:0xab98fba8)
   to double: f64(-0x1.31f75000000000000000p-40:0x00bd731f7500000000) (OK)
    to int32: 0 (OK)
@@ -718,16 +718,16 @@ from single: f32(0x1.ffc10000000000000000p+16:0x47ffe080)
   to uint64: 131009 (OK)
 from single: f32(0x1.c0bab600000000000000p+99:0x71605d5b)
   to double: f64(0x1.c0bab600000000000000p+99:0x00462c0bab60000000) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff)
   to double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000) (OK)
-   to int32: 0 ()
-   to int64: 0 ()
-  to uint32: 0 ()
-  to uint64: 0 ()
+   to int32: 0 (INVALID)
+   to int64: 0 (INVALID)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(inf:0x7f800000)
   to double: f64(inf:0x007ff0000000000000) (OK)
    to int32: 0 (INVALID)
diff --git a/tests/tcg/alpha/test-cvttq.c b/tests/tcg/alpha/test-cvttq.c
index d1ad995312..1a75012205 100644
--- a/tests/tcg/alpha/test-cvttq.c
+++ b/tests/tcg/alpha/test-cvttq.c
@@ -56,9 +56,9 @@ int main (void)
         {  1.5,  1, FPCR_INE },
         {  0x1.0p32,   0x0000000100000000ul, 0 },
         { -0x1.0p63,   0x8000000000000000ul, 0 },
-        {  0x1.0p63,   0x8000000000000000ul, FPCR_IOV | FPCR_INE },
-        {  0x1.0p64,   0x0000000000000000ul, FPCR_IOV | FPCR_INE },
-        {  0x1.cccp64, 0xccc0000000000000ul, FPCR_IOV | FPCR_INE },
+        {  0x1.0p63,   0x8000000000000000ul, FPCR_IOV | FPCR_INV },
+        {  0x1.0p64,   0x0000000000000000ul, FPCR_IOV | FPCR_INV },
+        {  0x1.cccp64, 0xccc0000000000000ul, FPCR_IOV | FPCR_INV },
         { __builtin_inf(), 0, FPCR_INV },
         { __builtin_nan(""), 0, FPCR_INV },
     };

-- 
2.55.0


