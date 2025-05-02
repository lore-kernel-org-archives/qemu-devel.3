Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B43C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 21:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAyFh-0006GA-0m; Fri, 02 May 2025 17:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAyFe-0006FY-IO
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:48:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAyFc-00043g-IM
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746222535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XVyqYA/UIpIwYSn5G6i8hJNaxT6gjdlb3GwIRIiPS00=;
 b=Q55MlnpI0VcPDO1aXFgzN8bbL7jdvjSzLMNdGiJb3jd59kp6bULiSjhbgNKuALD0k6WXCq
 fiJFXjbUpDAz4QucouShutxZJ9Ut+Uwk7JgTHDkvsEsFGr3GNzodASu4BkvZ1tY51MJv7T
 0N6GsPtc5VAHgGa5svjvWMB7lYrc5tg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-MaBeJFjhNqWDgoA-KlwnVA-1; Fri, 02 May 2025 17:48:54 -0400
X-MC-Unique: MaBeJFjhNqWDgoA-KlwnVA-1
X-Mimecast-MFC-AGG-ID: MaBeJFjhNqWDgoA-KlwnVA_1746222534
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3912e4e2033so727630f8f.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 14:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746222533; x=1746827333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XVyqYA/UIpIwYSn5G6i8hJNaxT6gjdlb3GwIRIiPS00=;
 b=ZFDE8aHt7xebVKtxdxLqGW1RQjjsD8995Nz6eVn6XtE+i0qBEFyP1rF3dCQzSA+4fB
 +uMnWGNuOif2JalnCLTUN8p/7rob+izOJMnHgEGeBhSLECTP6hngrcJEiRh9Y0CQpOHv
 TGCyiOf1EtUUT53N9at9CQQKCrIoa/ukEqrP4mX2Cwg4lAVBB0lRgw1l1Tmto4wLQCJk
 g6ZfjkNt8V+hB7o+Mr8QduQtA+ehXak+0kPmQzeoCXJU5TjQJbEsDoe11q0taswdzdN6
 QSY3Q1EQvROJQqQOjslAU4b/oBlroHVg89ifJs4cvQ5ubJoVwIFy16wU5qr5nrqytVcz
 Y7RQ==
X-Gm-Message-State: AOJu0YyXep4nRrjRuWlnS3YTh3XpDRVZSjCQCNQjNc/roGwXB3IBa9Wp
 HxEhElUsSLyGixoREZqNuqnIP2Dn+KyqQ4W2XlK9S4bRPWUkk9Ez+M2JafiB0cwIG1DgL3sO/7n
 zQXWqJFV/k35B0UH/UvLKsLPvu9vTxMw4qpBMMAWrEao1RMBrfLc0IaxxQ3sQteiYGjbUY4yThP
 TuqYh40sfuwO9/EQZ7DQjh7T5+sWK+PxDus4An
X-Gm-Gg: ASbGncsT/+ueS+ZCR0WswwTmym6QjmzwavVeY435bGn2wPsfVqaZHQDOHRS36ARg+Uu
 DeKdaCKneNAt5SkqDh3u2BmyNkftyLbi23s2SHOqO+aYbFaacTWMq+zIqOT0Ta+HZEQxfApewss
 1wad7/1RsV7NaCOhmSgDlWIpPVALqWac/WGpt1LNO/mAuLp7Ppm2MVPcdiYjU8rBm1RJVG5YEop
 0yd+NwuMMATMPhOGRP+ed8kQTdR9bvDW9q87RJ/cyOT+ZNPb0KqHgQdPiJTnLX59neC6vhmzJlh
 PDGrwqXE0jAiLPM=
X-Received: by 2002:a5d:5985:0:b0:3a0:8298:143d with SMTP id
 ffacd0b85a97d-3a099ad635cmr3060607f8f.13.1746222532824; 
 Fri, 02 May 2025 14:48:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcaat/r3rywmf7jb3o/qoAMn0lDrWiTlQ/IhJEXgQiTWoe8RHfis2jTz+bMau/dYO/jSdrzQ==
X-Received: by 2002:a5d:5985:0:b0:3a0:8298:143d with SMTP id
 ffacd0b85a97d-3a099ad635cmr3060598f8f.13.1746222532284; 
 Fri, 02 May 2025 14:48:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae7a35sm3079066f8f.43.2025.05.02.14.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 14:48:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org
Subject: [PATCH 4/4] target/i386: remove lflags
Date: Fri,  2 May 2025 23:48:41 +0200
Message-ID: <20250502214841.242584-5-pbonzini@redhat.com>
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

Just use cc_dst and cc_src for the same purpose.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h               |  6 ----
 target/i386/emulate/x86_emu.c   |  4 +--
 target/i386/emulate/x86_flags.c | 55 ++++++++++++++++-----------------
 3 files changed, 29 insertions(+), 36 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 54bf9639f19..8e3323f96f8 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1809,11 +1809,6 @@ typedef struct CPUCaches {
         CPUCacheInfo *l3_cache;
 } CPUCaches;
 
-typedef struct X86LazyFlags {
-    target_ulong result;
-    target_ulong auxbits;
-} X86LazyFlags;
-
 typedef struct CPUArchState {
     /* standard registers */
     target_ulong regs[CPU_NB_REGS];
@@ -2106,7 +2101,6 @@ typedef struct CPUArchState {
     QemuMutex xen_timers_lock;
 #endif
 #if defined(CONFIG_HVF)
-    X86LazyFlags lflags;
     void *emu_mmio_buf;
 #endif
 
diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index 61bd5af5bb1..4890e0a4e5e 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -474,10 +474,10 @@ static inline void string_rep(CPUX86State *env, struct x86_decode *decode,
     while (rcx--) {
         func(env, decode);
         write_reg(env, R_ECX, rcx, decode->addressing_size);
-        if ((PREFIX_REP == rep) && !env->lflags.result) {
+        if ((PREFIX_REP == rep) && !env->cc_dst) {
             break;
         }
-        if ((PREFIX_REPN == rep) && env->lflags.result) {
+        if ((PREFIX_REPN == rep) && env->cc_dst) {
             break;
         }
     }
diff --git a/target/i386/emulate/x86_flags.c b/target/i386/emulate/x86_flags.c
index c347a951889..a4f7af8aacd 100644
--- a/target/i386/emulate/x86_flags.c
+++ b/target/i386/emulate/x86_flags.c
@@ -31,10 +31,10 @@
 
 /*
  * The algorithms here are similar to those in Bochs.  After an ALU
- * operation, RESULT can be used to compute ZF, SF and PF, whereas
- * AUXBITS is used to compute AF, CF and OF.  In reality, SF and PF are the
- * XOR of the value computed from RESULT and the value found in bits 7 and 2
- * of AUXBITS; this way the same logic can be used to compute the flags
+ * operation, CC_DST can be used to compute ZF, SF and PF, whereas
+ * CC_SRC is used to compute AF, CF and OF.  In reality, SF and PF are the
+ * XOR of the value computed from CC_DST and the value found in bits 7 and 2
+ * of CC_SRC; this way the same logic can be used to compute the flags
  * both before and after an ALU operation.
  *
  * Compared to the TCG CC_OP codes, this avoids conditionals when converting
@@ -65,14 +65,14 @@
  * place PO and CF in the top two bits.
  */
 #define SET_FLAGS_OSZAPC_SIZE(size, lf_carries, lf_result) { \
-    env->lflags.result = (target_ulong)(int##size##_t)(lf_result); \
+    env->cc_dst = (target_ulong)(int##size##_t)(lf_result); \
     target_ulong temp = (lf_carries); \
     if ((size) == TARGET_LONG_BITS) { \
         temp = temp & ~(LF_MASK_PD | LF_MASK_SD); \
     } else { \
         temp = (temp & LF_MASK_AF) | (temp << (TARGET_LONG_BITS - (size))); \
     } \
-    env->lflags.auxbits = temp; \
+    env->cc_src = temp; \
 }
 
 /* carries, result */
@@ -89,15 +89,15 @@
 /* same as setting OSZAPC, but preserve CF and flip PO if the old value of CF
  * did not match the high bit of lf_carries. */
 #define SET_FLAGS_OSZAP_SIZE(size, lf_carries, lf_result) { \
-    env->lflags.result = (target_ulong)(int##size##_t)(lf_result); \
+    env->cc_dst = (target_ulong)(int##size##_t)(lf_result); \
     target_ulong temp = (lf_carries); \
     if ((size) == TARGET_LONG_BITS) { \
         temp = (temp & ~(LF_MASK_PD | LF_MASK_SD)); \
     } else { \
         temp = (temp & LF_MASK_AF) | (temp << (TARGET_LONG_BITS - (size))); \
     } \
-    target_ulong cf_changed = ((target_long)(env->lflags.auxbits ^ temp)) < 0; \
-    env->lflags.auxbits = temp ^ (cf_changed * (LF_MASK_PO | LF_MASK_CF)); \
+    target_ulong cf_changed = ((target_long)(env->cc_src ^ temp)) < 0; \
+    env->cc_src = temp ^ (cf_changed * (LF_MASK_PO | LF_MASK_CF)); \
 }
 
 /* carries, result */
@@ -110,9 +110,9 @@
 
 void SET_FLAGS_OxxxxC(CPUX86State *env, bool new_of, bool new_cf)
 {
-    env->lflags.auxbits &= ~(LF_MASK_PO | LF_MASK_CF);
-    env->lflags.auxbits |= (-(target_ulong)new_cf << LF_BIT_PO);
-    env->lflags.auxbits ^= ((target_ulong)new_of << LF_BIT_PO);
+    env->cc_src &= ~(LF_MASK_PO | LF_MASK_CF);
+    env->cc_src |= (-(target_ulong)new_cf << LF_BIT_PO);
+    env->cc_src ^= ((target_ulong)new_of << LF_BIT_PO);
 }
 
 void SET_FLAGS_OSZAPC_SUB32(CPUX86State *env, uint32_t v1, uint32_t v2,
@@ -208,37 +208,36 @@ void SET_FLAGS_OSZAPC_LOGIC8(CPUX86State *env, uint8_t v1, uint8_t v2,
 
 static inline uint32_t get_PF(CPUX86State *env)
 {
-    uint8_t temp = env->lflags.result;
-    return ((parity8(temp) - 1) ^ env->lflags.auxbits) & CC_P;
+    return ((parity8(env->cc_dst) - 1) ^ env->cc_src) & CC_P;
 }
 
 static inline uint32_t get_OF(CPUX86State *env)
 {
-    return ((env->lflags.auxbits >> (LF_BIT_CF - 11)) + CC_O / 2) & CC_O;
+    return ((env->cc_src >> (LF_BIT_CF - 11)) + CC_O / 2) & CC_O;
 }
 
 bool get_CF(CPUX86State *env)
 {
-    return ((target_long)env->lflags.auxbits) < 0;
+    return ((target_long)env->cc_src) < 0;
 }
 
 void set_CF(CPUX86State *env, bool val)
 {
     /* If CF changes, flip PO and CF */
     target_ulong temp = -(target_ulong)val;
-    target_ulong cf_changed = ((target_long)(env->lflags.auxbits ^ temp)) < 0;
-    env->lflags.auxbits ^= cf_changed * (LF_MASK_PO | LF_MASK_CF);
+    target_ulong cf_changed = ((target_long)(env->cc_src ^ temp)) < 0;
+    env->cc_src ^= cf_changed * (LF_MASK_PO | LF_MASK_CF);
 }
 
 static inline uint32_t get_ZF(CPUX86State *env)
 {
-    return env->lflags.result ? 0 : CC_Z;
+    return env->cc_dst ? 0 : CC_Z;
 }
 
 static inline uint32_t get_SF(CPUX86State *env)
 {
-    return ((env->lflags.result >> (LF_SIGN_BIT - LF_BIT_SD)) ^
-            env->lflags.auxbits) & CC_S;
+    return ((env->cc_dst >> (LF_SIGN_BIT - LF_BIT_SD)) ^
+            env->cc_src) & CC_S;
 }
 
 void lflags_to_rflags(CPUX86State *env)
@@ -246,8 +245,8 @@ void lflags_to_rflags(CPUX86State *env)
     env->eflags &= ~(CC_C|CC_P|CC_A|CC_Z|CC_S|CC_O);
     /* rotate left by one to move carry-out bits into CF and AF */
     env->eflags |= (
-        (env->lflags.auxbits << 1) |
-        (env->lflags.auxbits >> (TARGET_LONG_BITS - 1))) & (CC_C | CC_A);
+        (env->cc_src << 1) |
+        (env->cc_src >> (TARGET_LONG_BITS - 1))) & (CC_C | CC_A);
     env->eflags |= get_SF(env);
     env->eflags |= get_PF(env);
     env->eflags |= get_ZF(env);
@@ -258,17 +257,17 @@ void rflags_to_lflags(CPUX86State *env)
 {
     target_ulong cf_xor_of;
 
-    env->lflags.auxbits = CC_P;
-    env->lflags.auxbits ^= env->eflags & (CC_S | CC_P);
+    env->cc_src = CC_P;
+    env->cc_src ^= env->eflags & (CC_S | CC_P);
 
     /* rotate right by one to move CF and AF into the carry-out positions */
-    env->lflags.auxbits |= (
+    env->cc_src |= (
         (env->eflags >> 1) |
         (env->eflags << (TARGET_LONG_BITS - 1))) & (CC_C | CC_A);
 
     cf_xor_of = (env->eflags & (CC_C | CC_O)) + (CC_O - CC_C);
-    env->lflags.auxbits |= -cf_xor_of & LF_MASK_PO;
+    env->cc_src |= -cf_xor_of & LF_MASK_PO;
 
     /* Leave the low byte zero so that parity is not affected.  */
-    env->lflags.result = !(env->eflags & CC_Z) << 8;
+    env->cc_dst = !(env->eflags & CC_Z) << 8;
 }
-- 
2.49.0


