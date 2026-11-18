Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB4B606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 07:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F0pZMECY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTZph-0005Tk-U2; Wed, 18 Nov 2026 02:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1xTZpb-0005T7-9J
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 02:11:48 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1xTZpZ-0002wi-A0
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 02:11:47 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3b3a42a4bcdso300022a91.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 23:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794985902; x=1795590702; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fmctHZ7Jj7ktlL9vSZnfLMyssc7iQAZ/d+O7EgKf6Iw=;
 b=F0pZMECYZTh6BRkl81LUKZJAH3ImY4m7bqmwQGkAtz2+1bzThAycIZAclSOQ8/2B3V
 ZjFQK8oLFEOiGV+h00lQ4EC0/1XKEvLPi827m+DxpKTNB7yR5CWEBpgh8QWd96BKrM3n
 k1OV5g+iPO8fw2bXDHR3y++lgoROcNrrKBnKkC9SF5TJgfaB4Xuy2rHff3z7uU6WDduA
 l+Herb0S4USq5Z25IXJbGiNUcbobF5z45kuN3HALIgYn4GPAOwGhpsK7Rzxw+qtGfDVq
 UEJX07gg4C/m27ZO1bbK/mC4zu6Psf0hFLrIKwwlYrZmL7vSGqIyMHPWS7/NppRAibTf
 eHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794985902; x=1795590702;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fmctHZ7Jj7ktlL9vSZnfLMyssc7iQAZ/d+O7EgKf6Iw=;
 b=wzgtgCFR5B33pyG8G/JgTJz/ZFztBmzz/W2NJokinuVMfFJb6cnLgPlq7vrgfUaNsA
 ShXeQUO/MHgp11PVYTlcX7Jwn5YF1DJE/CP61NcZboeGl/ar0XN+2xIKB6/0vQKcFqw/
 I/fATde78li/yCizR4Tlo3pCo9lkNhti22VdHqUvoaWJ5g2SK8ZA36IvbSqtcCGW1uQV
 Gat6h4cPKkgYa8Sdt+ATntTnRqAb1ds3xqdowIhx4abgPqVw2fiTcp9r8nQdQqoO9Th3
 PBnrVWl2PeO6E/5yBCp+1X0OxbT17Qu/IlawcfKfT5eFHWkR7vpc8urxIF6OJcNoU+sD
 duFw==
X-Gm-Message-State: APuU4Z9jX5j6nL7d/6QO9f+r4apS6MZ5qazTqzaJ/2MQhuDKLhornthE
 Eu4Pwb4nIeO2Q8f5OBiA1tvOsLhGtyX4yD7YcLlgoLa6KJ89PztKekoB
X-Gm-Gg: AZFdTZeEujqACRRizrljWmTYaRb7s6h2qGEuWHQNskO0kuDVCPnieGflMJiwtkfGSCE
 C/xlimYkVdHgoiUK+vJ8fBpzfiSKeX9vFjNIYt6p6H6XeCYJqiEcXkSWGS+WvHTGRe8OmgspmwQ
 shsmlbEMWUaDudpbMYXwAwVuzDG4qXjjJnEFJ3alk+eWRWaNpR6gL3T7NzDxYYNt9RV8tlkx5Xj
 H04Fpge03TdyhOoacSZxpg/1sxL7Lpjt+3uYjIBk8ymSY9hzB4XxJW1Kpt0SHqUPOXVtyI8ZjkJ
 zXzq3CdDgJzZ/eICah24Vc5HxTxvuACxAjehTefUuaSwSIj86jjt0Y8vKXjveac4hRfVn8rWyCx
 sO4/JOZnVgA4iru41CChnwddBQVicb/1t1jwwuzyOnJ4ylsEnBAYlUGJLdCzc/8kvBEecGL48Ho
 QVlv/Ix5tyST4lgHKe2ibsSK8Ll7E8vHiv0xRw/zILIm6f4fsXUf4iEeMeZXRa4PTYFHLQL5eHm
 7KGi/LeeQCWmlSqpZkGK+8hEI/B4/BomSUeHFTbzFaItNDwpvNhQs7CUIuf97PA1Frko8n464Nq
 GlbdSkL737HNsGAksoxNXcL0/6zLsVbn4qmxI+9Dvq3A9iPauB9f
X-Received: by 2002:a17:90a:d44b:b0:3ab:f38:2b43 with SMTP id
 98e67ed59e1d1-3b3d07c6166mr1465242a91.34.1794985902104; 
 Tue, 17 Nov 2026 23:11:42 -0800 (PST)
Received: from [127.0.1.1] ([2406:da18:1fb5:4a00:cefc:405f:ac3f:318f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3d1ace00fsm2794375a91.13.2026.11.17.23.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 23:11:41 -0800 (PST)
From: WX Chen <wxchen0913@gmail.com>
Date: Wed, 18 Nov 2026 15:09:34 +0800
Subject: [PATCH RFC] tcg: Support maxsz=4 in GVEC descriptors
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261118-bug-issue-rvv-vlen32-gvec-v1-1-c15cf05de6bc@gmail.com>
X-B4-Tracking: v=1; b=H4sIAC1P/WoC/x2MQQrDIBAAvxL23AWNJppeC31Ar6WH1ayJUGxRI
 oWQv9f2OAMzOxTOkQucux0y11jiKzWQpw78SmlhjHNj6EU/Siktum3BWMrGmGvF+uSkelwqexT
 aqskay0MQ0Pp35hA///cdbtcLPJp0VBhdpuTX31ZrZYLwhoNSimgy5IeZnXHTQDwHZQxpI2mE4
 /gCzomSCqsAAAA=
X-Change-ID: 20261118-bug-issue-rvv-vlen32-gvec-04839878e5f0
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Tao Tang <tangtao1634@phytium.com.cn>, WX Chen <wxchen0913@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794985893; l=7171;
 i=wxchen0913@gmail.com; s=20260725; h=from:subject:message-id;
 bh=sCXNB06TbSSVZleLEJgAhOJtw177eK0ubLnJdo8pHis=;
 b=O+ZSj6/Q7qBJCu09E+G5DUiqZUtgWMWS9ZrRMVOmnlRiVyR9efkdGsVK9a+UiMhhteqDuXY0O
 BOlXIzAehV7DxNbGPbWaL831PhUPyZD+oak2M/EHDJJIEu7r7E5gjEh
X-Developer-Key: i=wxchen0913@gmail.com; a=ed25519;
 pk=FX63IRxmtz1BCNzHxOOWDPTo8L/D0YUxlIKc1WKi7wo=
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=wxchen0913@gmail.com; helo=mail-pj1-x1030.google.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch adds support for oprsz = maxsz = 4 in GVEC descriptors.

The MAXSZ field currently encodes and decodes sizes as follows:

    encoded_maxsz = maxsz / 8 - 1
    maxsz = (encoded_maxsz + 1) * 8

Field value 2 would represent 24 bytes. However, maxsz values of
16 bytes or more must be multiples of 16, so this field value is
unused by valid descriptors.

In this patch, we reuse MAXSZ field value 2 to represent 4 bytes.
As for oprsz, OPRSZ field value 2 already means "use MAXSZ", allowing
oprsz to follow maxsz without changing the OPRSZ decoding logic.

All existing valid descriptor encodings are preserved. The size
and alignment requirements for generic GVEC operation expansion
remain unchanged.

Suggested-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: WX Chen <wxchen0913@gmail.com>
---
This patch adds support for oprsz = maxsz = 4 to the shared GVEC descriptor 
format. Feedback on extending the common format for this RISC-V use case 
would be appreciated.

Currently, the GVEC descriptor only supports the following `maxsz` values:
if maxsz < 16
     maxsz should be 8-byte aligned
else
     maxsz should be 16-byte aligned
     
maxsz = 8, 16, 32, 48, 64, ..., 2048

That is, maxsz = 4 is currently not supported. This will
cause some issues when VLEN = 32.
Here is an example issue. First, enable the `Zve32x` extension, which
allows a minimum VLEN of 32. Build qemu-system-riscv64 with
--enable-debug-tcg on. Then, we set:

-cpu rv64,v=false,zve32x=true,vlen=32,elen=32

Then, we run a program through TCG that contains the following
code segment:
vsetivli zero, 1, e32, m1, tu, mu   # SEW = 32, LMUL = 1, vl = 1
vredsum.vs v3, v2, v1

Rather than running the program successfully, QEMU triggers the following
assertion:
qemu-system-riscv64: ../tcg/tcg-op-gvec.c:56: check_size_align: 
Assertion `(maxsz & max_align) == 0' failed.
The call chain leading to this assertion is:
trans_vredsum_vs
     → opivv_trans
     → tcg_gen_gvec_4_ptr
     → simd_desc(oprsz=4, maxsz=4, data)
     → check_size_align
     → assertion failure
     
This is because the current GVEC descriptor does not support maxsz = 4.
In addition, a GVEC descriptor is often constructed before a
gen_helper_* call. For RVV instruction helper call, the maxsz will often
be treated as the length of physical vector register, which is 4 in our
issue. Since maxsz = 4 is not supported for descriptor construction, the
assertion is triggered. This can happen on most RVV helpers, not only
vredsum.vs. Floating-point instructions provided by Zve32f can also trigger
similar assertions.

By adding 4-byte size support to the descriptor, we can not only fix the
assertion discussed above, but also unblock many RVV helper call paths
when VLEN = 32, which they should be accessible. Most RVV helpers already 
handle variable vector register sizes. Adding 4-byte descriptor support 
enables these existing implementations to run with VLEN=32 without requiring 
changes to their computation logic.

Here is a detailed analysis about the cause of the issue: 

English version
https://zhenbaii.github.io/%E8%99%9A%E6%8B%9F%E5%8C%96/2026/11/17/riscv-zve32x-gvec-en/

This initial patch adds 4-byte descriptor support, but does not
address all issues related to VLEN=32. For example:
- alignment assumptions in mask helpers
- GDB reading the vector registers

All previously valid descriptor encodings are preserved, and
encoding and decoding behavior is unchanged for existing valid
sizes of 8 bytes and above. Runtime testing so far has been
limited to RISC-V.
---
 include/tcg/tcg-gvec-desc.h | 12 +++++++++---
 tcg/tcg-op-gvec.c           | 31 ++++++++++++++++++-------------
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/include/tcg/tcg-gvec-desc.h b/include/tcg/tcg-gvec-desc.h
index 94c7d14b2643e960d58cf66c6355c769f39c2905..5e1cd1e5c4e314240a460e0c8ac76ebf1f2117d6 100644
--- a/include/tcg/tcg-gvec-desc.h
+++ b/include/tcg/tcg-gvec-desc.h
@@ -23,8 +23,11 @@
 #include "qemu/bitops.h"
 
 /*
- * This configuration allows MAXSZ to represent 2048 bytes, and
- * OPRSZ to match MAXSZ, or represent the smaller values 8, 16, or 32.
+ * MAXSZ represents 4 bytes with field value 2, or otherwise represents
+ * (field value + 1) * 8 bytes, up to 2048 bytes.  Field value 2 would
+ * otherwise represent 24 bytes, which is not a supported maximum size.
+ *
+ * OPRSZ can match MAXSZ, or represent the smaller values 8, 16, or 32.
  *
  * Encode this with:
  *   0, 1, 3 -> 8, 16, 32
@@ -34,6 +37,7 @@
  */
 #define SIMD_MAXSZ_SHIFT   0
 #define SIMD_MAXSZ_BITS    8
+#define SIMD_MAXSZ_4_CODE  2
 
 #define SIMD_OPRSZ_SHIFT   (SIMD_MAXSZ_SHIFT + SIMD_MAXSZ_BITS)
 #define SIMD_OPRSZ_BITS    2
@@ -47,7 +51,9 @@ uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int32_t data);
 /* Extract the max vector size from a descriptor.  */
 static inline intptr_t simd_maxsz(uint32_t desc)
 {
-    return extract32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS) * 8 + 8;
+    uint32_t f = extract32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS);
+
+    return f == SIMD_MAXSZ_4_CODE ? 4 : f * 8 + 8;
 }
 
 /* Extract the operation size from a descriptor.  */
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index bc323e250091984ea8307c6d39cd796e96da1a35..99b976ca1635eb2d93f036a2b45b331c36b2778c 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -97,7 +97,24 @@ uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int32_t data)
 {
     uint32_t desc = 0;
 
-    check_size_align(oprsz, maxsz, 0);
+    if (maxsz == 4) {
+        tcg_debug_assert(oprsz == 4);
+        oprsz = 2;
+        maxsz = SIMD_MAXSZ_4_CODE;
+    } else {
+        check_size_align(oprsz, maxsz, 0);
+
+        oprsz = (oprsz / 8) - 1;
+        maxsz = (maxsz / 8) - 1;
+
+        /*
+         * OPRSZ is {8,16,32} or matches MAXSZ.  Encode the final case
+         * with '2', as that would otherwise map to 24.
+         */
+        if (oprsz == maxsz) {
+            oprsz = 2;
+        }
+    }
 
     /*
      * We want to check that 'data' will fit into SIMD_DATA_BITS.
@@ -113,18 +130,6 @@ uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int32_t data)
     tcg_debug_assert(data == sextract32(data, 0, SIMD_DATA_BITS) ||
                      data == extract32(data, 0, SIMD_DATA_BITS));
 
-    oprsz = (oprsz / 8) - 1;
-    maxsz = (maxsz / 8) - 1;
-
-    /*
-     * We have just asserted in check_size_align that either
-     * oprsz is {8,16,32} or matches maxsz.  Encode the final
-     * case with '2', as that would otherwise map to 24.
-     */
-    if (oprsz == maxsz) {
-        oprsz = 2;
-    }
-
     desc = deposit32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_BITS, oprsz);
     desc = deposit32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS, maxsz);
     desc = deposit32(desc, SIMD_DATA_SHIFT, SIMD_DATA_BITS, data);

---
base-commit: 4437f0c7ef333aa97ac5deb7b95aedf377a471a6
change-id: 20261118-bug-issue-rvv-vlen32-gvec-04839878e5f0

Best regards,
-- 
WX Chen <wxchen0913@gmail.com>


