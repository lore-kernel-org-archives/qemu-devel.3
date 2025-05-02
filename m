Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CB2C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 21:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAyFe-0006FT-F4; Fri, 02 May 2025 17:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAyFc-0006Et-Jj
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:48:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAyFa-00043Q-7V
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746222533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hnUskYJpMJ4Bf2vuRU5NGK/G1S4X4LjpzkT666EILXE=;
 b=OwjgJl/+2uNQgWOsnh1ojQqZPjA0CObRgMdhPn9Dq2lbwwqR6ysok4E3LrR3qzC/soeSKT
 pFzV1YoZ8aT5lqUjDoNHSz1FyJYV3vXb8F1ShsWmNmEEe0f5l8gL8pkPp8y7kEYJhxjle2
 i8ZErzNKVwYCpjC9bN7QsJrx3XI0tgE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-QYw7DydJPTqkV4uS-RUD8Q-1; Fri, 02 May 2025 17:48:52 -0400
X-MC-Unique: QYw7DydJPTqkV4uS-RUD8Q-1
X-Mimecast-MFC-AGG-ID: QYw7DydJPTqkV4uS-RUD8Q_1746222531
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf5196c25so12333495e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 14:48:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746222530; x=1746827330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hnUskYJpMJ4Bf2vuRU5NGK/G1S4X4LjpzkT666EILXE=;
 b=uJG6oQ5/7xm/F8Q6UD1iSXtLuYmngm3UiZWp5szL8/X7uzrZf22Hhpx8pVtsZOiq7s
 zLz2hKAOIOiJ2IIocjPkOPEwe/m63KF5rX3xF3dPZptRDJItxvrwdlpcmZvq8cVGN1mQ
 4nYyHgy5zim3a63tXeWHI9dCbeyCVdmmZreljTGEML61JOsJ/cFjl8xaOv1sbwiCHWux
 4YHlokfD5S9YxZ6OJXUSUWXoRbHgbmCmIMyp5SJ9i6mM9MsKcJY63wHLIJjD0qmxfFMZ
 v14NM8IEYaL3EkcswuBZI7v8Vz5u43tehW4CYUiBCeF0qNkzxxd/UjD0Sf8MEpPsr3HI
 o/wg==
X-Gm-Message-State: AOJu0Yy+qTv16b7xyy0MfBbUqyeEsJd7oMH0KxJ2ujyqioJJq6Aq36mt
 Xnw94ltrFf0CNtK4+9Sbdj81b09GdxS8NV6079QYhHQOymw52Y+VpZxoshcwwFPMg/pAScE9Frm
 sWmnD2/fHkDjpU8moLTA0bennS1en/EGdUnAtJZLeSCfYH9MWomD6d+9YBmGAqhq0OcxzQG3nrD
 dGdi3RFMF1Onzj6SPI/inmsjoS1gHBelx9Ua8d
X-Gm-Gg: ASbGncsENsxbPdjqedsbq81UWTYd7ej1VwFxmmujfZbrGeCoI8MosMXBVgBfD1gC25m
 QFcFliupR1diXCPSMC1z2LqRrARO1Ck2A0fJA5awMK/IwSDgXaVA17mv1vtGujMreLZzQ6gnWj1
 vunVN4MQ1TTEAU518M4CFQIra/+fMgEiAb/rUorLIKXnH42be/uOfSFbQJ1dBR5gFVPf7V7oCKy
 S+RUODBssBYwJc35Bnpr2YjhVMMB+wqi7/aA/m5foMf04K8FK0+Mnk/ChQ66bguuMg6IesMqUhy
 DVyW5pQP/UDmeyA=
X-Received: by 2002:a5d:62c7:0:b0:3a0:99e9:bc98 with SMTP id
 ffacd0b85a97d-3a099e9c21bmr2537472f8f.8.1746222529786; 
 Fri, 02 May 2025 14:48:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKAyfooXxXAG+rZMSH15GRgAyIB4EB+ecKaPlpSp0jbfwhiUKTVWPLCtAtI7P7jOhag94f/Q==
X-Received: by 2002:a5d:62c7:0:b0:3a0:99e9:bc98 with SMTP id
 ffacd0b85a97d-3a099e9c21bmr2537457f8f.8.1746222529218; 
 Fri, 02 May 2025 14:48:49 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2aed5e8sm101090995e9.16.2025.05.02.14.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 14:48:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org
Subject: [PATCH 3/4] target/i386/emulate: mostly rewrite flags handling
Date: Fri,  2 May 2025 23:48:40 +0200
Message-ID: <20250502214841.242584-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502214841.242584-1-pbonzini@redhat.com>
References: <20250502214841.242584-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

While Bochs's algorithms are pretty solid, there are small opportunities
to improve them or to make their logic more similar to TCG's handling
of condition codes.

- use a single bit for the difference between bits 0..7 of result and PF.
This is useful because "set only ZF" is not a common case.

- place SD in the same place as SF

- move CF and PO at bits 62 and 63 when target_ulong is 64-bits wide,
  so that 64-bit ALU operations need fewer shifts

- use rotates to move CF and AF from auxbits to their eflags position

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_flags.h |  12 +-
 target/i386/emulate/x86_emu.c   |   4 +-
 target/i386/emulate/x86_flags.c | 197 ++++++++++++++------------------
 3 files changed, 86 insertions(+), 127 deletions(-)

diff --git a/target/i386/emulate/x86_flags.h b/target/i386/emulate/x86_flags.h
index 6c175007b57..28b008e5771 100644
--- a/target/i386/emulate/x86_flags.h
+++ b/target/i386/emulate/x86_flags.h
@@ -28,20 +28,10 @@
 void lflags_to_rflags(CPUX86State *env);
 void rflags_to_lflags(CPUX86State *env);
 
-bool get_PF(CPUX86State *env);
-void set_PF(CPUX86State *env, bool val);
 bool get_CF(CPUX86State *env);
 void set_CF(CPUX86State *env, bool val);
-bool get_AF(CPUX86State *env);
-void set_AF(CPUX86State *env, bool val);
-bool get_ZF(CPUX86State *env);
-void set_ZF(CPUX86State *env, bool val);
-bool get_SF(CPUX86State *env);
-void set_SF(CPUX86State *env, bool val);
-bool get_OF(CPUX86State *env);
-void set_OF(CPUX86State *env, bool val);
 
-void SET_FLAGS_OxxxxC(CPUX86State *env, uint32_t new_of, uint32_t new_cf);
+void SET_FLAGS_OxxxxC(CPUX86State *env, bool new_of, bool new_cf);
 
 void SET_FLAGS_OSZAPC_SUB32(CPUX86State *env, uint32_t v1, uint32_t v2,
                             uint32_t diff);
diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index 4c07f08942e..61bd5af5bb1 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -474,10 +474,10 @@ static inline void string_rep(CPUX86State *env, struct x86_decode *decode,
     while (rcx--) {
         func(env, decode);
         write_reg(env, R_ECX, rcx, decode->addressing_size);
-        if ((PREFIX_REP == rep) && !get_ZF(env)) {
+        if ((PREFIX_REP == rep) && !env->lflags.result) {
             break;
         }
-        if ((PREFIX_REPN == rep) && get_ZF(env)) {
+        if ((PREFIX_REPN == rep) && env->lflags.result) {
             break;
         }
     }
diff --git a/target/i386/emulate/x86_flags.c b/target/i386/emulate/x86_flags.c
index 84e27364a03..c347a951889 100644
--- a/target/i386/emulate/x86_flags.c
+++ b/target/i386/emulate/x86_flags.c
@@ -29,41 +29,50 @@
 #include "x86.h"
 
 
-/* this is basically bocsh code */
+/*
+ * The algorithms here are similar to those in Bochs.  After an ALU
+ * operation, RESULT can be used to compute ZF, SF and PF, whereas
+ * AUXBITS is used to compute AF, CF and OF.  In reality, SF and PF are the
+ * XOR of the value computed from RESULT and the value found in bits 7 and 2
+ * of AUXBITS; this way the same logic can be used to compute the flags
+ * both before and after an ALU operation.
+ *
+ * Compared to the TCG CC_OP codes, this avoids conditionals when converting
+ * to and from the RFLAGS representation.
+ */
 
-#define LF_SIGN_BIT     31
+#define LF_SIGN_BIT    (TARGET_LONG_BITS - 1)
 
-#define LF_BIT_SD      (0)          /* lazy Sign Flag Delta            */
-#define LF_BIT_AF      (3)          /* lazy Adjust flag                */
-#define LF_BIT_PDB     (8)          /* lazy Parity Delta Byte (8 bits) */
-#define LF_BIT_CF      (31)         /* lazy Carry Flag                 */
-#define LF_BIT_PO      (30)         /* lazy Partial Overflow = CF ^ OF */
+#define LF_BIT_PD      (2)          /* lazy Parity Delta, same bit as PF */
+#define LF_BIT_AF      (3)          /* lazy Adjust flag */
+#define LF_BIT_SD      (7)          /* lazy Sign Flag Delta, same bit as SF */
+#define LF_BIT_CF      (TARGET_LONG_BITS - 1) /* lazy Carry Flag */
+#define LF_BIT_PO      (TARGET_LONG_BITS - 2) /* lazy Partial Overflow = CF ^ OF */
 
-#define LF_MASK_SD     (0x01 << LF_BIT_SD)
-#define LF_MASK_AF     (0x01 << LF_BIT_AF)
-#define LF_MASK_PDB    (0xFF << LF_BIT_PDB)
-#define LF_MASK_CF     (0x01 << LF_BIT_CF)
-#define LF_MASK_PO     (0x01 << LF_BIT_PO)
+#define LF_MASK_PD     ((target_ulong)0x01 << LF_BIT_PD)
+#define LF_MASK_AF     ((target_ulong)0x01 << LF_BIT_AF)
+#define LF_MASK_SD     ((target_ulong)0x01 << LF_BIT_SD)
+#define LF_MASK_CF     ((target_ulong)0x01 << LF_BIT_CF)
+#define LF_MASK_PO     ((target_ulong)0x01 << LF_BIT_PO)
 
 /* ******************* */
 /* OSZAPC */
 /* ******************* */
 
-/* size, carries, result */
+/* use carries to fill in AF, PO and CF, while ensuring PD and SD are clear.
+ * for full-word operations just clear PD and SD; for smaller operand
+ * sizes only keep AF in the low byte and shift the carries left to
+ * place PO and CF in the top two bits.
+ */
 #define SET_FLAGS_OSZAPC_SIZE(size, lf_carries, lf_result) { \
-    target_ulong temp = ((lf_carries) & (LF_MASK_AF)) | \
-    (((lf_carries) >> (size - 2)) << LF_BIT_PO); \
     env->lflags.result = (target_ulong)(int##size##_t)(lf_result); \
-    if ((size) == 32) { \
-        temp = ((lf_carries) & ~(LF_MASK_PDB | LF_MASK_SD)); \
-    } else if ((size) == 16) { \
-        temp = ((lf_carries) & (LF_MASK_AF)) | ((lf_carries) << 16); \
-    } else if ((size) == 8)  { \
-        temp = ((lf_carries) & (LF_MASK_AF)) | ((lf_carries) << 24); \
+    target_ulong temp = (lf_carries); \
+    if ((size) == TARGET_LONG_BITS) { \
+        temp = temp & ~(LF_MASK_PD | LF_MASK_SD); \
     } else { \
-        VM_PANIC("unimplemented");  \
+        temp = (temp & LF_MASK_AF) | (temp << (TARGET_LONG_BITS - (size))); \
     } \
-    env->lflags.auxbits = (target_ulong)(uint32_t)temp; \
+    env->lflags.auxbits = temp; \
 }
 
 /* carries, result */
@@ -77,23 +86,18 @@
 /* ******************* */
 /* OSZAP */
 /* ******************* */
-/* size, carries, result */
+/* same as setting OSZAPC, but preserve CF and flip PO if the old value of CF
+ * did not match the high bit of lf_carries. */
 #define SET_FLAGS_OSZAP_SIZE(size, lf_carries, lf_result) { \
-    target_ulong temp = ((lf_carries) & (LF_MASK_AF)) | \
-    (((lf_carries) >> (size - 2)) << LF_BIT_PO); \
-    if ((size) == 32) { \
-        temp = ((lf_carries) & ~(LF_MASK_PDB | LF_MASK_SD)); \
-    } else if ((size) == 16) { \
-        temp = ((lf_carries) & (LF_MASK_AF)) | ((lf_carries) << 16); \
-    } else if ((size) == 8) { \
-        temp = ((lf_carries) & (LF_MASK_AF)) | ((lf_carries) << 24); \
-    } else { \
-        VM_PANIC("unimplemented");      \
-    } \
     env->lflags.result = (target_ulong)(int##size##_t)(lf_result); \
-    target_ulong delta_c = (env->lflags.auxbits ^ temp) & LF_MASK_CF; \
-    delta_c ^= (delta_c >> 1); \
-    env->lflags.auxbits = (target_ulong)(uint32_t)(temp ^ delta_c); \
+    target_ulong temp = (lf_carries); \
+    if ((size) == TARGET_LONG_BITS) { \
+        temp = (temp & ~(LF_MASK_PD | LF_MASK_SD)); \
+    } else { \
+        temp = (temp & LF_MASK_AF) | (temp << (TARGET_LONG_BITS - (size))); \
+    } \
+    target_ulong cf_changed = ((target_long)(env->lflags.auxbits ^ temp)) < 0; \
+    env->lflags.auxbits = temp ^ (cf_changed * (LF_MASK_PO | LF_MASK_CF)); \
 }
 
 /* carries, result */
@@ -104,11 +108,11 @@
 #define SET_FLAGS_OSZAP_32(carries, result) \
     SET_FLAGS_OSZAP_SIZE(32, carries, result)
 
-void SET_FLAGS_OxxxxC(CPUX86State *env, uint32_t new_of, uint32_t new_cf)
+void SET_FLAGS_OxxxxC(CPUX86State *env, bool new_of, bool new_cf)
 {
-    uint32_t temp_po = new_of ^ new_cf;
     env->lflags.auxbits &= ~(LF_MASK_PO | LF_MASK_CF);
-    env->lflags.auxbits |= (temp_po << LF_BIT_PO) | (new_cf << LF_BIT_CF);
+    env->lflags.auxbits |= (-(target_ulong)new_cf << LF_BIT_PO);
+    env->lflags.auxbits ^= ((target_ulong)new_of << LF_BIT_PO);
 }
 
 void SET_FLAGS_OSZAPC_SUB32(CPUX86State *env, uint32_t v1, uint32_t v2,
@@ -202,104 +206,69 @@ void SET_FLAGS_OSZAPC_LOGIC8(CPUX86State *env, uint8_t v1, uint8_t v2,
     SET_FLAGS_OSZAPC_8(0, diff);
 }
 
-bool get_PF(CPUX86State *env)
+static inline uint32_t get_PF(CPUX86State *env)
 {
-    uint32_t temp = (255 & env->lflags.result);
-    temp = temp ^ (255 & (env->lflags.auxbits >> LF_BIT_PDB));
-    temp = (temp ^ (temp >> 4)) & 0x0F;
-    return (0x9669U >> temp) & 1;
+    uint8_t temp = env->lflags.result;
+    return ((parity8(temp) - 1) ^ env->lflags.auxbits) & CC_P;
 }
 
-void set_PF(CPUX86State *env, bool val)
+static inline uint32_t get_OF(CPUX86State *env)
 {
-    uint32_t temp = (255 & env->lflags.result) ^ (!val);
-    env->lflags.auxbits &= ~(LF_MASK_PDB);
-    env->lflags.auxbits |= (temp << LF_BIT_PDB);
-}
-
-bool get_OF(CPUX86State *env)
-{
-    return ((env->lflags.auxbits + (1U << LF_BIT_PO)) >> LF_BIT_CF) & 1;
+    return ((env->lflags.auxbits >> (LF_BIT_CF - 11)) + CC_O / 2) & CC_O;
 }
 
 bool get_CF(CPUX86State *env)
 {
-    return (env->lflags.auxbits >> LF_BIT_CF) & 1;
-}
-
-void set_OF(CPUX86State *env, bool val)
-{
-    bool old_cf = get_CF(env);
-    SET_FLAGS_OxxxxC(env, val, old_cf);
+    return ((target_long)env->lflags.auxbits) < 0;
 }
 
 void set_CF(CPUX86State *env, bool val)
 {
-    bool old_of = get_OF(env);
-    SET_FLAGS_OxxxxC(env, old_of, val);
+    /* If CF changes, flip PO and CF */
+    target_ulong temp = -(target_ulong)val;
+    target_ulong cf_changed = ((target_long)(env->lflags.auxbits ^ temp)) < 0;
+    env->lflags.auxbits ^= cf_changed * (LF_MASK_PO | LF_MASK_CF);
 }
 
-bool get_AF(CPUX86State *env)
+static inline uint32_t get_ZF(CPUX86State *env)
 {
-    return (env->lflags.auxbits >> LF_BIT_AF) & 1;
+    return env->lflags.result ? 0 : CC_Z;
 }
 
-void set_AF(CPUX86State *env, bool val)
+static inline uint32_t get_SF(CPUX86State *env)
 {
-    env->lflags.auxbits &= ~(LF_MASK_AF);
-    env->lflags.auxbits |= val << LF_BIT_AF;
-}
-
-bool get_ZF(CPUX86State *env)
-{
-    return !env->lflags.result;
-}
-
-void set_ZF(CPUX86State *env, bool val)
-{
-    if (val) {
-        env->lflags.auxbits ^=
-         (((env->lflags.result >> LF_SIGN_BIT) & 1) << LF_BIT_SD);
-        /* merge the parity bits into the Parity Delta Byte */
-        uint32_t temp_pdb = (255 & env->lflags.result);
-        env->lflags.auxbits ^= (temp_pdb << LF_BIT_PDB);
-        /* now zero the .result value */
-        env->lflags.result = 0;
-    } else {
-        env->lflags.result |= (1 << 8);
-    }
-}
-
-bool get_SF(CPUX86State *env)
-{
-    return ((env->lflags.result >> LF_SIGN_BIT) ^
-            (env->lflags.auxbits >> LF_BIT_SD)) & 1;
-}
-
-void set_SF(CPUX86State *env, bool val)
-{
-    bool temp_sf = get_SF(env);
-    env->lflags.auxbits ^= (temp_sf ^ val) << LF_BIT_SD;
+    return ((env->lflags.result >> (LF_SIGN_BIT - LF_BIT_SD)) ^
+            env->lflags.auxbits) & CC_S;
 }
 
 void lflags_to_rflags(CPUX86State *env)
 {
     env->eflags &= ~(CC_C|CC_P|CC_A|CC_Z|CC_S|CC_O);
-    env->eflags |= get_CF(env) ? CC_C : 0;
-    env->eflags |= get_PF(env) ? CC_P : 0;
-    env->eflags |= get_AF(env) ? CC_A : 0;
-    env->eflags |= get_ZF(env) ? CC_Z : 0;
-    env->eflags |= get_SF(env) ? CC_S : 0;
-    env->eflags |= get_OF(env) ? CC_O : 0;
+    /* rotate left by one to move carry-out bits into CF and AF */
+    env->eflags |= (
+        (env->lflags.auxbits << 1) |
+        (env->lflags.auxbits >> (TARGET_LONG_BITS - 1))) & (CC_C | CC_A);
+    env->eflags |= get_SF(env);
+    env->eflags |= get_PF(env);
+    env->eflags |= get_ZF(env);
+    env->eflags |= get_OF(env);
 }
 
 void rflags_to_lflags(CPUX86State *env)
 {
-    env->lflags.auxbits = env->lflags.result = 0;
-    set_OF(env, env->eflags & CC_O);
-    set_SF(env, env->eflags & CC_S);
-    set_ZF(env, env->eflags & CC_Z);
-    set_AF(env, env->eflags & CC_A);
-    set_PF(env, env->eflags & CC_P);
-    set_CF(env, env->eflags & CC_C);
+    target_ulong cf_xor_of;
+
+    env->lflags.auxbits = CC_P;
+    env->lflags.auxbits ^= env->eflags & (CC_S | CC_P);
+
+    /* rotate right by one to move CF and AF into the carry-out positions */
+    env->lflags.auxbits |= (
+        (env->eflags >> 1) |
+        (env->eflags << (TARGET_LONG_BITS - 1))) & (CC_C | CC_A);
+
+    cf_xor_of = (env->eflags & (CC_C | CC_O)) + (CC_O - CC_C);
+    env->lflags.auxbits |= -cf_xor_of & LF_MASK_PO;
+
+    /* Leave the low byte zero so that parity is not affected.  */
+    env->lflags.result = !(env->eflags & CC_Z) << 8;
 }
-- 
2.49.0


