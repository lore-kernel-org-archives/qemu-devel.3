Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E28C369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wcl-0006gz-5v; Wed, 23 Apr 2025 05:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wc8-0005HV-NY
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wc6-0008OS-Ow
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5t0D0WTFgFL6eXjyADFjpdY9F8zDaIDJzfYFsnNUC/Q=;
 b=ixpdjc4q74vxsD0bkXskZD9xjFo5Syt7TFszz235iMi0OpVK/3TM4oKnVlcHrhn5lXy2dK
 hJPtmMyGN0+KbzeXT2m1xsVbfRGmHWm0gQOOufvx0YsS6BebnjrCuhUY3m3A26DJYVTbZ0
 4EMqYJfjg795CY95pkrrUtarlr0J2OQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-cbaOr5dtPBC3Pn4XW9aaXw-1; Wed, 23 Apr 2025 05:41:52 -0400
X-MC-Unique: cbaOr5dtPBC3Pn4XW9aaXw-1
X-Mimecast-MFC-AGG-ID: cbaOr5dtPBC3Pn4XW9aaXw_1745401311
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-acbbb0009aeso173822466b.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401310; x=1746006110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5t0D0WTFgFL6eXjyADFjpdY9F8zDaIDJzfYFsnNUC/Q=;
 b=veW8gXfUKLRRo/LpBNnbU2f2lh9ElfMG4WLOpdiwHq+9QN+x+S2IX3LThtu1Tg9BEz
 WYOo4PRr9VWdwnT7JZsA4kbyBw8mqGfzYtgbp07k8BuGTiZG1FRoIRm29ziqqrRzK0kC
 utWiokhPbf6SlygkrPxUm1po+jYTuquGnalEyA/QqsEP18InTCg1ivCNGm/tCY0THyFh
 qyhDzCyxNhotL0MIVIXWPRZlQw42we6XVa5dYyGx8x2XGxx5ke7E07B+9WfF/b6NQ4hX
 7zKMZOazuWmljp0g6pXX5SF2/UQUtEqBhGwNf52LawcQeLnqvNGs94dBqyH/JrhGM99G
 g8CA==
X-Gm-Message-State: AOJu0YxNT2fWqsi9AKjuSO8ThHQdXMJOerqtCQT8r9ayzoRbkTEXILip
 GFJGebkCFxld/uLdEq7ynIv7zEhKLKRljMgCY1KCWjmOLVGBNFguMztr5Q5jEjetrUkSu+CoeAB
 pdWFraQkmYJr7wcz67rOYv36KWLqjbeOgJJuqyRLNBkILH53rLPE9X2pakBdMjJvc8pw44TxJNI
 4AP0Px9/rxzbRz85Qkl9L9AfXt8KGqLIGpd5qT
X-Gm-Gg: ASbGnctteSKMLEUHFtM/VLkGXu9mHmsuwDDzD/FzCGyBQ0ZQpkoGnj/BQypXUKnFVx3
 yT3+39C9sylfEsAmvSo22pSEb+Bxsi70cpzj9UHhFLJ7kP+OMtGNvTuNCFtCxnC1N9JpJtG5oYw
 FLCXDpUljF99kaprD1W3lkFYADdCN3x//EVDRP8ETNnDyC1kJcIdcvQuhYJ8VlEEQctu6wzHtzi
 VX+f2uVng7V3gRbM3ZczmdJ4q77Z0WGoAnlrnwRCwl9qtwAxHB7+AvVrAImcSptAv6G3WKmpP2N
 X3iREeDZUHqn44EB
X-Received: by 2002:a17:906:4fd5:b0:ac8:1efc:bf66 with SMTP id
 a640c23a62f3a-acb74ddb584mr1679806866b.50.1745401310447; 
 Wed, 23 Apr 2025 02:41:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAPXMc1pHs3w80/+Vj2gxnnEFLWbACaWRVySlCEL9bf54r4im/j7zzKhTgUHoZi6KTKV15lg==
X-Received: by 2002:a17:906:4fd5:b0:ac8:1efc:bf66 with SMTP id
 a640c23a62f3a-acb74ddb584mr1679804566b.50.1745401309873; 
 Wed, 23 Apr 2025 02:41:49 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb6efaa9c1sm774298466b.168.2025.04.23.02.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:41:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@linux.microsoft.com>
Subject: [PULL 20/34] target/i386: rename lazy flags field and its type
Date: Wed, 23 Apr 2025 11:40:50 +0200
Message-ID: <20250423094105.40692-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

From: Wei Liu <liuwe@linux.microsoft.com>

The same structure and code can be used by other accelerators. Drop
the hvf prefix in the type and field name.

No functional change.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
Link: https://lore.kernel.org/r/1741377325-28175-9-git-send-email-liuwe@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h           |  6 ++--
 target/i386/hvf/x86_flags.c | 56 ++++++++++++++++++-------------------
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 3c5c39ce3d3..119efc6c605 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1811,10 +1811,10 @@ typedef struct CPUCaches {
         CPUCacheInfo *l3_cache;
 } CPUCaches;
 
-typedef struct HVFX86LazyFlags {
+typedef struct X86LazyFlags {
     target_ulong result;
     target_ulong auxbits;
-} HVFX86LazyFlags;
+} X86LazyFlags;
 
 typedef struct CPUArchState {
     /* standard registers */
@@ -2108,7 +2108,7 @@ typedef struct CPUArchState {
     QemuMutex xen_timers_lock;
 #endif
 #if defined(CONFIG_HVF)
-    HVFX86LazyFlags hvf_lflags;
+    X86LazyFlags lflags;
     void *emu_mmio_buf;
 #endif
 
diff --git a/target/i386/hvf/x86_flags.c b/target/i386/hvf/x86_flags.c
index 0c75e0419c3..84e27364a03 100644
--- a/target/i386/hvf/x86_flags.c
+++ b/target/i386/hvf/x86_flags.c
@@ -53,7 +53,7 @@
 #define SET_FLAGS_OSZAPC_SIZE(size, lf_carries, lf_result) { \
     target_ulong temp = ((lf_carries) & (LF_MASK_AF)) | \
     (((lf_carries) >> (size - 2)) << LF_BIT_PO); \
-    env->hvf_lflags.result = (target_ulong)(int##size##_t)(lf_result); \
+    env->lflags.result = (target_ulong)(int##size##_t)(lf_result); \
     if ((size) == 32) { \
         temp = ((lf_carries) & ~(LF_MASK_PDB | LF_MASK_SD)); \
     } else if ((size) == 16) { \
@@ -63,7 +63,7 @@
     } else { \
         VM_PANIC("unimplemented");  \
     } \
-    env->hvf_lflags.auxbits = (target_ulong)(uint32_t)temp; \
+    env->lflags.auxbits = (target_ulong)(uint32_t)temp; \
 }
 
 /* carries, result */
@@ -90,10 +90,10 @@
     } else { \
         VM_PANIC("unimplemented");      \
     } \
-    env->hvf_lflags.result = (target_ulong)(int##size##_t)(lf_result); \
-    target_ulong delta_c = (env->hvf_lflags.auxbits ^ temp) & LF_MASK_CF; \
+    env->lflags.result = (target_ulong)(int##size##_t)(lf_result); \
+    target_ulong delta_c = (env->lflags.auxbits ^ temp) & LF_MASK_CF; \
     delta_c ^= (delta_c >> 1); \
-    env->hvf_lflags.auxbits = (target_ulong)(uint32_t)(temp ^ delta_c); \
+    env->lflags.auxbits = (target_ulong)(uint32_t)(temp ^ delta_c); \
 }
 
 /* carries, result */
@@ -107,8 +107,8 @@
 void SET_FLAGS_OxxxxC(CPUX86State *env, uint32_t new_of, uint32_t new_cf)
 {
     uint32_t temp_po = new_of ^ new_cf;
-    env->hvf_lflags.auxbits &= ~(LF_MASK_PO | LF_MASK_CF);
-    env->hvf_lflags.auxbits |= (temp_po << LF_BIT_PO) | (new_cf << LF_BIT_CF);
+    env->lflags.auxbits &= ~(LF_MASK_PO | LF_MASK_CF);
+    env->lflags.auxbits |= (temp_po << LF_BIT_PO) | (new_cf << LF_BIT_CF);
 }
 
 void SET_FLAGS_OSZAPC_SUB32(CPUX86State *env, uint32_t v1, uint32_t v2,
@@ -204,27 +204,27 @@ void SET_FLAGS_OSZAPC_LOGIC8(CPUX86State *env, uint8_t v1, uint8_t v2,
 
 bool get_PF(CPUX86State *env)
 {
-    uint32_t temp = (255 & env->hvf_lflags.result);
-    temp = temp ^ (255 & (env->hvf_lflags.auxbits >> LF_BIT_PDB));
+    uint32_t temp = (255 & env->lflags.result);
+    temp = temp ^ (255 & (env->lflags.auxbits >> LF_BIT_PDB));
     temp = (temp ^ (temp >> 4)) & 0x0F;
     return (0x9669U >> temp) & 1;
 }
 
 void set_PF(CPUX86State *env, bool val)
 {
-    uint32_t temp = (255 & env->hvf_lflags.result) ^ (!val);
-    env->hvf_lflags.auxbits &= ~(LF_MASK_PDB);
-    env->hvf_lflags.auxbits |= (temp << LF_BIT_PDB);
+    uint32_t temp = (255 & env->lflags.result) ^ (!val);
+    env->lflags.auxbits &= ~(LF_MASK_PDB);
+    env->lflags.auxbits |= (temp << LF_BIT_PDB);
 }
 
 bool get_OF(CPUX86State *env)
 {
-    return ((env->hvf_lflags.auxbits + (1U << LF_BIT_PO)) >> LF_BIT_CF) & 1;
+    return ((env->lflags.auxbits + (1U << LF_BIT_PO)) >> LF_BIT_CF) & 1;
 }
 
 bool get_CF(CPUX86State *env)
 {
-    return (env->hvf_lflags.auxbits >> LF_BIT_CF) & 1;
+    return (env->lflags.auxbits >> LF_BIT_CF) & 1;
 }
 
 void set_OF(CPUX86State *env, bool val)
@@ -241,45 +241,45 @@ void set_CF(CPUX86State *env, bool val)
 
 bool get_AF(CPUX86State *env)
 {
-    return (env->hvf_lflags.auxbits >> LF_BIT_AF) & 1;
+    return (env->lflags.auxbits >> LF_BIT_AF) & 1;
 }
 
 void set_AF(CPUX86State *env, bool val)
 {
-    env->hvf_lflags.auxbits &= ~(LF_MASK_AF);
-    env->hvf_lflags.auxbits |= val << LF_BIT_AF;
+    env->lflags.auxbits &= ~(LF_MASK_AF);
+    env->lflags.auxbits |= val << LF_BIT_AF;
 }
 
 bool get_ZF(CPUX86State *env)
 {
-    return !env->hvf_lflags.result;
+    return !env->lflags.result;
 }
 
 void set_ZF(CPUX86State *env, bool val)
 {
     if (val) {
-        env->hvf_lflags.auxbits ^=
-         (((env->hvf_lflags.result >> LF_SIGN_BIT) & 1) << LF_BIT_SD);
+        env->lflags.auxbits ^=
+         (((env->lflags.result >> LF_SIGN_BIT) & 1) << LF_BIT_SD);
         /* merge the parity bits into the Parity Delta Byte */
-        uint32_t temp_pdb = (255 & env->hvf_lflags.result);
-        env->hvf_lflags.auxbits ^= (temp_pdb << LF_BIT_PDB);
+        uint32_t temp_pdb = (255 & env->lflags.result);
+        env->lflags.auxbits ^= (temp_pdb << LF_BIT_PDB);
         /* now zero the .result value */
-        env->hvf_lflags.result = 0;
+        env->lflags.result = 0;
     } else {
-        env->hvf_lflags.result |= (1 << 8);
+        env->lflags.result |= (1 << 8);
     }
 }
 
 bool get_SF(CPUX86State *env)
 {
-    return ((env->hvf_lflags.result >> LF_SIGN_BIT) ^
-            (env->hvf_lflags.auxbits >> LF_BIT_SD)) & 1;
+    return ((env->lflags.result >> LF_SIGN_BIT) ^
+            (env->lflags.auxbits >> LF_BIT_SD)) & 1;
 }
 
 void set_SF(CPUX86State *env, bool val)
 {
     bool temp_sf = get_SF(env);
-    env->hvf_lflags.auxbits ^= (temp_sf ^ val) << LF_BIT_SD;
+    env->lflags.auxbits ^= (temp_sf ^ val) << LF_BIT_SD;
 }
 
 void lflags_to_rflags(CPUX86State *env)
@@ -295,7 +295,7 @@ void lflags_to_rflags(CPUX86State *env)
 
 void rflags_to_lflags(CPUX86State *env)
 {
-    env->hvf_lflags.auxbits = env->hvf_lflags.result = 0;
+    env->lflags.auxbits = env->lflags.result = 0;
     set_OF(env, env->eflags & CC_O);
     set_SF(env, env->eflags & CC_S);
     set_ZF(env, env->eflags & CC_Z);
-- 
2.49.0


