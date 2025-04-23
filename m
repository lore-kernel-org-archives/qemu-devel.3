Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA743C369D8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wcw-0007cS-0C; Wed, 23 Apr 2025 05:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wc4-00059O-Ld
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wc2-0008NU-7i
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k7XJMWWDWvSIPa+InJi/0rN9MTb+EzXLKE4LaJ3YTJw=;
 b=DlLwZfjcFLR1FZY5Kev9WW2Z+wJEsd0LhN7BClSj51JTWNssmlZmdoQHb3lmsRVjaA8f5u
 9CCHeP9VkqtTODAc30ZNVbfniTEC6GQMHMgU/GTOR/rMMV8HVqGbHBhp5AKBjfx+/JKHUX
 9ZwLXXO4qCiyWBrcriA0ShniAgdamAM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-W8QfvMI_NxK5nru9ZqDPTg-1; Wed, 23 Apr 2025 05:41:37 -0400
X-MC-Unique: W8QfvMI_NxK5nru9ZqDPTg-1
X-Mimecast-MFC-AGG-ID: W8QfvMI_NxK5nru9ZqDPTg_1745401293
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5f501ed492bso5599244a12.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401292; x=1746006092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k7XJMWWDWvSIPa+InJi/0rN9MTb+EzXLKE4LaJ3YTJw=;
 b=HvYBjWwPSJeeuM9+uREuGf90cAYx7N9wsNzqt1/Zaci75ApV5loQ8Go0/ekp1KH/72
 DnUag0Gch4FlHzusZETgRSOZwmQD5RvCVf8EFEKTAODGvK2RgiU3XoSp3yXVFbULpIWk
 1Lnq9aEjDLKPXYahwuKGQQ7imQ+fXV9FngcaWtkUi274xVA1N34d5S4B0+byQy9j4rnB
 ax9XVkCT9ZjxS7REslUALVzEXzt4G1LYpH6l1SFvzFyEM13FXfSM1Ju80ujFNIGS2DTe
 bBsPvN//LbNA6OjdosUIKK6uMDzkCmyCiNx9wWWpbinDDkZQPKE9Km/hk6EROc915zMQ
 /mzw==
X-Gm-Message-State: AOJu0YyXcU6AqsU0xcVOZMhlarb2ZalrGc1QULz51rjfzhv9w/RUjtT1
 ryTWcgFjUpDs2UGPQfhp5dUrUejZ+rQubBNjiX2iETChOXglhn3JtvhevMG4JxU6zXc1Yoc4Q/y
 jWk53VcsTYnFCn83KRJuFNYK/7hO88O5INeY4kOnjfinzo148bnj7dezn1450fRQlOsZFFis1ew
 o9pqtrVVEaRJ7uYZcnPD38Mmx0zoj8zJ+e0oaM
X-Gm-Gg: ASbGncthyNAOdWNRc2MAhe+L0IMFJ3oxsdZQajcX0g3X8PiTV5v9n/fmU62uWFIZp7m
 P0CBW0OKY5Cj8IA13pI+TOL+uvvp8kT9idaICFjoZSTQf0NECnt/mvS8ifsBf7yM0QpEYmwSk1e
 PhclrWX+x8yt2YdXXCkx8+JCgnGRkmqJ8s/rtQOpGE5Wuy+mIKh2kOfWAJpZbb8KIRiF3c5F7Iy
 nkH2dtV9M4giuj59oChkoMtIS8hqF+fAN7UZPJETRDsf/y1EaDPRvW0VD+C5d8QV28DjuhBb8K5
 KUr0zq/4DhxTTEVG
X-Received: by 2002:a05:6402:4404:b0:5f3:f04b:b5d7 with SMTP id
 4fb4d7f45d1cf-5f628578024mr17215096a12.18.1745401291698; 
 Wed, 23 Apr 2025 02:41:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7wUQBug12RPOhQ13aFEqqlFeSNGi/4y7rgvBPMbClGG1r2+1wqCcvOmaHRnymNSTpBxnyyA==
X-Received: by 2002:a05:6402:4404:b0:5f3:f04b:b5d7 with SMTP id
 4fb4d7f45d1cf-5f628578024mr17215062a12.18.1745401291019; 
 Wed, 23 Apr 2025 02:41:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f625a40344sm7153671a12.77.2025.04.23.02.41.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:41:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/34] target/i386: tcg: use cout to commonize add/adc/sub/sbb
 cases
Date: Wed, 23 Apr 2025 11:40:42 +0200
Message-ID: <20250423094105.40692-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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
 target/i386/tcg/cc_helper_template.h.inc | 80 ++++++++----------------
 target/i386/hvf/x86_flags.c              | 25 --------
 3 files changed, 52 insertions(+), 78 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 76f24446a55..7a8d695bdb1 100644
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
+ * If two corresponding bits in x and y are different, the value of the
+ * bit in (x-y)^x^y likewise does not matter.  Hence, x^y can be replaced
+ * with 0 in (x-y)^x^y, resulting in majority(NOT x, y, x-y)
+ */
+#define SUB_COUT_VEC(op1, op2, result) \
+   MAJ_INV1(op1, op2, result)
+
 #endif /* I386_CPU_H */
diff --git a/target/i386/tcg/cc_helper_template.h.inc b/target/i386/tcg/cc_helper_template.h.inc
index b821e5bca3b..d8fd976ca15 100644
--- a/target/i386/tcg/cc_helper_template.h.inc
+++ b/target/i386/tcg/cc_helper_template.h.inc
@@ -44,18 +44,32 @@
 
 /* dynamic flags computation */
 
-static uint32_t glue(compute_all_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_all_cout, SUFFIX)(DATA_TYPE dst, DATA_TYPE carries)
 {
-    uint32_t cf, pf, af, zf, sf, of;
-    DATA_TYPE src2 = dst - src1;
+    uint32_t af_cf, pf, zf, sf, of;
 
-    cf = dst < src1;
+    /* PF, ZF, SF computed from result.  */
     pf = compute_pf(dst);
-    af = (dst ^ src1 ^ src2) & CC_A;
     zf = (dst == 0) * CC_Z;
     sf = lshift(dst, 8 - DATA_BITS) & CC_S;
-    of = lshift((src1 ^ src2 ^ -1) & (src1 ^ dst), 12 - DATA_BITS) & CC_O;
-    return cf + pf + af + zf + sf + of;
+
+    /*
+     * AF, CF, OF computed from carry out vector.  To compute AF and CF, rotate it
+     * left by one so cout(DATA_BITS - 1) is in bit 0 and cout(3) in bit 4.
+     *
+     * To compute OF, place the highest two carry bits into OF and the bit
+     * immediately to the right of it; then, adding CC_O / 2 XORs them.
+     */
+    af_cf = ((carries << 1) | (carries >> (DATA_BITS - 1))) & (CC_A | CC_C);
+    of = (lshift(carries, 12 - DATA_BITS) + CC_O / 2) & CC_O;
+    return pf + zf + sf + af_cf + of;
+}
+
+static uint32_t glue(compute_all_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+{
+    DATA_TYPE src2 = dst - src1;
+    DATA_TYPE carries = ADD_COUT_VEC(src1, src2, dst);
+    return glue(compute_all_cout, SUFFIX)(dst, carries);
 }
 
 static int glue(compute_c_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
@@ -66,25 +80,9 @@ static int glue(compute_c_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
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
+    DATA_TYPE carries = ADD_COUT_VEC(src1, src2, dst);
+    return glue(compute_all_cout, SUFFIX)(dst, carries);
 }
 
 static int glue(compute_c_adc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1,
@@ -101,16 +99,9 @@ static int glue(compute_c_adc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1,
 
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
+    DATA_TYPE carries = SUB_COUT_VEC(src1, src2, dst);
+    return glue(compute_all_cout, SUFFIX)(dst, carries);
 }
 
 static int glue(compute_c_sub, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2)
@@ -123,25 +114,9 @@ static int glue(compute_c_sub, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2)
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
+    DATA_TYPE carries = SUB_COUT_VEC(src1, src2, dst);
+    return glue(compute_all_cout, SUFFIX)(dst, carries);
 }
 
 static int glue(compute_c_sbb, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2,
@@ -286,6 +261,5 @@ static int glue(compute_c_blsi, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 #undef DATA_BITS
 #undef SIGN_MASK
 #undef DATA_TYPE
-#undef DATA_MASK
 #undef SUFFIX
 #undef WIDER_TYPE
diff --git a/target/i386/hvf/x86_flags.c b/target/i386/hvf/x86_flags.c
index 60ab4f01a20..0c75e0419c3 100644
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
- * If two corresponding bits in x and y are different, the value of the
- * bit in (x-y)^x^y likewise does not matter.  Hence, x^y can be replaced
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


