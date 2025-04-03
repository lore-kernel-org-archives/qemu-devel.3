Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7696BC3601A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 13:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0KSZ-0004q4-GG; Thu, 03 Apr 2025 09:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u0KSQ-0004no-Q7
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 09:18:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u0KSO-0008UT-3p
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 09:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743686285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yHiZ/CPo9s1cUfvy5QRHZU7zt6BGzo/qjHV3c/bc1fQ=;
 b=D9Sg7pyfbnUBVn7BBW/z0fxopowRby50BPh2QN24ELJ7IZr/q0GV05ouEhXlmtDf7elprF
 CovINjUKTRiZNh38hA+3AwK2UD0keX1D3VqizGOWxO2oCnDpJe2S/qRUMHTMOP0KU5NF1W
 dafAOfv6CLA7XLmnVvjCA2MXREfoobo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-6jzlw6CpNkOxTKrQ1PHo3w-1; Thu, 03 Apr 2025 09:18:04 -0400
X-MC-Unique: 6jzlw6CpNkOxTKrQ1PHo3w-1
X-Mimecast-MFC-AGG-ID: 6jzlw6CpNkOxTKrQ1PHo3w_1743686283
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5e6c14c0a95so787728a12.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 06:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743686282; x=1744291082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yHiZ/CPo9s1cUfvy5QRHZU7zt6BGzo/qjHV3c/bc1fQ=;
 b=KwkGyBUN6SGUNExKUKa+jNaVrbQwDJWFl3IwvKCgahBFbsdX2iv/8x7HKXmtnVKSCH
 UiBt1Yx/wvoTOqQj4ZBIsfgz57uBMESZBYd2wLy1aAYqq9pDRP7tefbfSjtgClNVYWW0
 QcywWld0UZu1EtSzoT9JtcOHoXjqiWLTcOKZUIPXnJfrL0fUUOtAFigTGrNEHeBsuABf
 wQVFGBLF3EaJcWyGgVxO3mWlq6qCuIYlIOq1NvufShHZCLOnE0IpZ1aPSBYLVKCBMYZY
 ht30Arsa+TJdeAMhlM27OX7hqr4ElIy+7sKMjyTQzHGGHhvN/eceCRnLT9T6JPSe642C
 kT7Q==
X-Gm-Message-State: AOJu0YwHwDmbLMX0JwoerT+KUea7KlJ4T64S4t6xQ8Rz4vnk/Mo141ap
 kvh5YPIZpJt9pReZLaNdJxblZfIUaNQ+6vxMgT3RbDUcaEPrLeUaVEawJ6/ztiq5/4wY8jxSJVW
 tbhuyy0yZOmg7PGP/oC1XUeJGN5UwtE20tsLWpbWhvpw/OVlSoWakvSr3pJOEL+tOhT8jl19j0m
 jxtjgCMr5JJSe9tBQ+vtin++ggqpHoNKFSZeSV
X-Gm-Gg: ASbGnctsE1tX52v8zRmHyH/UN20HT6AcoXMpz9FOdtTIF80t0WeqN9foMBe7/nUCnqg
 oSjs9bUkbXqVmQYobTbo3RCZYGD8OIX7EkKGo/Lptvs/jTBqAyuGeabSYX30/PWmLfiG8JHz1Wi
 sdKr5r+HsSPmOg4csjT6iRjOblp3/or/yPHYsf6HmH5a5M9091dOuIgmxAeBxGq5KTAmNux+7xP
 iOLsL/Z2G+BjqCpKaFw5mFaE7m3zTSn9g5tiL5WtPqUG4gXX6IrPc0gL1hPp6caX775rjavvKxY
 YE3X6ArOJMBvb02hIZKD
X-Received: by 2002:a05:6402:5210:b0:5ec:cda0:ff1f with SMTP id
 4fb4d7f45d1cf-5f0871efb0fmr2137894a12.21.1743686281805; 
 Thu, 03 Apr 2025 06:18:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGasFJbuJ3BkSSwR9xAiVfk5kGyhbCR0lADbX47+eKh1NkTPTNjsbpfAObKodnMjpH+4bkF2w==
X-Received: by 2002:a05:6402:5210:b0:5ec:cda0:ff1f with SMTP id
 4fb4d7f45d1cf-5f0871efb0fmr2137829a12.21.1743686281096; 
 Thu, 03 Apr 2025 06:18:01 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.230.224])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f0880850f2sm923817a12.59.2025.04.03.06.17.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 06:17:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] target/i386: tcg: use cout to commonize add/adc/sub/sbb
 cases
Date: Thu,  3 Apr 2025 15:17:53 +0200
Message-ID: <20250403131753.82072-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403131753.82072-1-pbonzini@redhat.com>
References: <20250403131753.82072-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use the carry-out vector as the basis to compute AF, CF and OF.  The cost
is pretty much the same, because the carry-out is just four boolean
operations, and the code is much smaller because add/adc/sub/sbb now
share most of it.

A similar algorithm to what is used in target/i386/emulate can also be
used for APX, in order to build the result of CCMP/CTEST with a new CC_OP_*.
CCMP needs to place into the flags from either a subtraction or a constant
value; CTEST likewise place into the flags either an AND or a constant
value.  The new CC_OP for CCMP and CTEST would store for a successful
predcate:

- in DST and SRC2, the result of the operation;

- in SRC, a carry-out vector for CCMP or zero for CTEST;

If the default flag value is used, DST/SRC/SRC2 can be filled with
constants:

- in DST the negated ZF;

- in SRC's top 2 bits, a value that results in the desired OF and CF;

- in SRC2 a suitable value (any of 0/1/~0/~1) that can be used
  instead of DST to compute the desired SF and PF.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h                        | 25 ++++++++
 target/i386/tcg/cc_helper_template.h.inc | 80 +++++++++---------------
 target/i386/hvf/x86_flags.c              | 25 --------
 3 files changed, 54 insertions(+), 76 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 76f24446a55..e3e266dc7c5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2843,4 +2843,29 @@ static inline bool ctl_has_irq(CPUX86State *env)
 # define TARGET_VSYSCALL_PAGE  (UINT64_C(-10) << 20)
 #endif
 
+/* majority(NOT a, b, c) = (a ^ b) ? b : c */
+#define MAJ_INV1(a, b, c)  ((((a) ^ (b)) & ((b) ^ (c))) ^ (c))
+
+/*
+ * ADD_COUT_VEC(x, y) = majority((x + y) ^ x ^ y, x, y)
+ *
+ * If two corresponding bits in x and y are the same, that's the carry
+ * independent of the value (x+y)^x^y.  Hence x^y can be replaced with
+ * 1 in (x+y)^x^y, resulting in majority(NOT (x+y), x, y)
+ */
+#define ADD_COUT_VEC(op1, op2, result) \
+   MAJ_INV1(result, op1, op2)
+
+/*
+ * SUB_COUT_VEC(x, y) = NOT majority(x, NOT y, (x - y) ^ x ^ NOT y)
+ *                    = majority(NOT x, y, (x - y) ^ x ^ y)
+ *
+ * Note that the carry out is actually a borrow, i.e. it is inverted.
+ * If two corresponding bits in x and y are different, the value that
+ * the bit has in (x-y)^x^y likewise does not Hence x^y can be replaced
+ * with 0 in (x-y)^x^y, resulting in majority(NOT x, y, x-y)
+ */
+#define SUB_COUT_VEC(op1, op2, result) \
+   MAJ_INV1(op1, op2, result)
+
 #endif /* I386_CPU_H */
diff --git a/target/i386/tcg/cc_helper_template.h.inc b/target/i386/tcg/cc_helper_template.h.inc
index b821e5bca3b..ee3957ac6a2 100644
--- a/target/i386/tcg/cc_helper_template.h.inc
+++ b/target/i386/tcg/cc_helper_template.h.inc
@@ -22,20 +22,24 @@
 #if DATA_BITS == 8
 #define SUFFIX b
 #define DATA_TYPE uint8_t
+#define SDATA_TYPE int8_t
 #define WIDER_TYPE uint32_t
 #elif DATA_BITS == 16
 #define SUFFIX w
 #define DATA_TYPE uint16_t
+#define SDATA_TYPE int16_t
 #define WIDER_TYPE uint32_t
 #elif DATA_BITS == 32
 #define SUFFIX l
 #define DATA_TYPE uint32_t
+#define SDATA_TYPE int32_t
 #if HOST_LONG_BITS >= 64
 #define WIDER_TYPE uint64_t
 #endif
 #elif DATA_BITS == 64
 #define SUFFIX q
 #define DATA_TYPE uint64_t
+#define SDATA_TYPE int64_t
 #else
 #error unhandled operand size
 #endif
@@ -44,20 +48,33 @@
 
 /* dynamic flags computation */
 
-static uint32_t glue(compute_all_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_all_cout, SUFFIX)(DATA_TYPE dst, SDATA_TYPE carries)
 {
     uint32_t cf, pf, af, zf, sf, of;
-    DATA_TYPE src2 = dst - src1;
 
-    cf = dst < src1;
+    /* PF, ZF, SF computed from result.  */
     pf = compute_pf(dst);
-    af = (dst ^ src1 ^ src2) & CC_A;
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
-    of = lshift((src1 ^ src2 ^ -1) & (src1 ^ dst), 12 - DATA_BITS) & CC_O;
+
+    /*
+     * AF, CF, OF computed from carry out vector.  To compute OF put the highest
+     * two carry bits in OF and the bit immediately to the right; adding CC_O / 2
+     * XORs them.
+     */
+    af = (carries << 1) & CC_A;
+    cf = carries < 0;
+    of = (lshift(carries, 12 - DATA_BITS) + CC_O / 2) & CC_O;
     return cf + pf + af + zf + sf + of;
 }
 
+static uint32_t glue(compute_all_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+{
+    DATA_TYPE src2 = dst - src1;
+    target_long carries = ADD_COUT_VEC(src1, src2, dst);
+    return glue(compute_all_cout, SUFFIX)(dst, carries);
+}
+
 static int glue(compute_c_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
     return dst < src1;
@@ -66,25 +83,9 @@ static int glue(compute_c_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 static uint32_t glue(compute_all_adc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1,
                                          DATA_TYPE src3)
 {
-    uint32_t cf, pf, af, zf, sf, of;
-
-#ifdef WIDER_TYPE
-    WIDER_TYPE src13 = (WIDER_TYPE) src1 + (WIDER_TYPE) src3;
-    DATA_TYPE src2 = dst - src13;
-
-    cf = dst < src13;
-#else
     DATA_TYPE src2 = dst - src1 - src3;
-
-    cf = (src3 ? dst <= src1 : dst < src1);
-#endif
-
-    pf = compute_pf(dst);
-    af = (dst ^ src1 ^ src2) & 0x10;
-    zf = (dst == 0) << 6;
-    sf = lshift(dst, 8 - DATA_BITS) & 0x80;
-    of = lshift((src1 ^ src2 ^ -1) & (src1 ^ dst), 12 - DATA_BITS) & CC_O;
-    return cf + pf + af + zf + sf + of;
+    target_long carries = ADD_COUT_VEC(src1, src2, dst);
+    return glue(compute_all_cout, SUFFIX)(dst, carries);
 }
 
 static int glue(compute_c_adc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1,
@@ -101,16 +102,9 @@ static int glue(compute_c_adc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1,
 
 static uint32_t glue(compute_all_sub, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2)
 {
-    uint32_t cf, pf, af, zf, sf, of;
     DATA_TYPE src1 = dst + src2;
-
-    cf = src1 < src2;
-    pf = compute_pf(dst);
-    af = (dst ^ src1 ^ src2) & CC_A;
-    zf = (dst == 0) * CC_Z;
-    sf = lshift(dst, 8 - DATA_BITS) & CC_S;
-    of = lshift((src1 ^ src2) & (src1 ^ dst), 12 - DATA_BITS) & CC_O;
-    return cf + pf + af + zf + sf + of;
+    target_long carries = SUB_COUT_VEC(src1, src2, dst);
+    return glue(compute_all_cout, SUFFIX)(dst, carries);
 }
 
 static int glue(compute_c_sub, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2)
@@ -123,25 +117,9 @@ static int glue(compute_c_sub, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2)
 static uint32_t glue(compute_all_sbb, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2,
                                          DATA_TYPE src3)
 {
-    uint32_t cf, pf, af, zf, sf, of;
-
-#ifdef WIDER_TYPE
-    WIDER_TYPE src23 = (WIDER_TYPE) src2 + (WIDER_TYPE) src3;
-    DATA_TYPE src1 = dst + src23;
-
-    cf = src1 < src23;
-#else
     DATA_TYPE src1 = dst + src2 + src3;
-
-    cf = (src3 ? src1 <= src2 : src1 < src2);
-#endif
-
-    pf = compute_pf(dst);
-    af = (dst ^ src1 ^ src2) & 0x10;
-    zf = (dst == 0) << 6;
-    sf = lshift(dst, 8 - DATA_BITS) & 0x80;
-    of = lshift((src1 ^ src2) & (src1 ^ dst), 12 - DATA_BITS) & CC_O;
-    return cf + pf + af + zf + sf + of;
+    target_long carries = SUB_COUT_VEC(src1, src2, dst);
+    return glue(compute_all_cout, SUFFIX)(dst, carries);
 }
 
 static int glue(compute_c_sbb, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2,
@@ -286,6 +264,6 @@ static int glue(compute_c_blsi, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 #undef DATA_BITS
 #undef SIGN_MASK
 #undef DATA_TYPE
-#undef DATA_MASK
+#undef SDATA_TYPE
 #undef SUFFIX
 #undef WIDER_TYPE
diff --git a/target/i386/hvf/x86_flags.c b/target/i386/hvf/x86_flags.c
index 25553bd55fd..32772c359e9 100644
--- a/target/i386/hvf/x86_flags.c
+++ b/target/i386/hvf/x86_flags.c
@@ -45,31 +45,6 @@
 #define LF_MASK_CF     (0x01 << LF_BIT_CF)
 #define LF_MASK_PO     (0x01 << LF_BIT_PO)
 
-/* majority(NOT a, b, c) = (a ^ b) ? b : c */
-#define MAJ_INV1(a, b, c)  ((((a) ^ (b)) & ((b) ^ (c))) ^ (c))
-
-/*
- * ADD_COUT_VEC(x, y) = majority((x + y) ^ x ^ y, x, y)
- *
- * If two corresponding bits in x and y are the same, that's the carry
- * independent of the value (x+y)^x^y.  Hence x^y can be replaced with
- * 1 in (x+y)^x^y, resulting in majority(NOT (x+y), x, y)
- */
-#define ADD_COUT_VEC(op1, op2, result) \
-   MAJ_INV1(result, op1, op2)
-
-/*
- * SUB_COUT_VEC(x, y) = NOT majority(x, NOT y, (x - y) ^ x ^ NOT y)
- *                    = majority(NOT x, y, (x - y) ^ x ^ y)
- *
- * Note that the carry out is actually a borrow, i.e. it is inverted.
- * If two corresponding bits in x and y are different, the value that
- * the bit has in (x-y)^x^y likewise does not Hence x^y can be replaced
- * with 0 in (x-y)^x^y, resulting in majority(NOT x, y, x-y)
- */
-#define SUB_COUT_VEC(op1, op2, result) \
-   MAJ_INV1(op1, op2, result)
-
 /* ******************* */
 /* OSZAPC */
 /* ******************* */
-- 
2.49.0


