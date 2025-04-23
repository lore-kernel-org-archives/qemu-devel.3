Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E16C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wbu-0004iI-Gq; Wed, 23 Apr 2025 05:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wbe-0004Lp-RB
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wbd-0008LG-3G
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MbRAhfy8Au4a7AS3wclub6qPXCoZneXX7P8yh/nfffM=;
 b=Elnc1ii9vWfmCLqqgGDnU96xvBua8S1DThqavbT9C4zI3Ma8pVH4McRU509wbIiZVMvB6r
 Rs7gM6aU5uu7IsGtkMvlBzW0yWOk64JUadLoEtBLF4XEkpI3avjw4104ERUXEw/YTdAQEb
 uYDdrKGiH9A4ZC+qQCPigt/g/ndqahk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-ZAc-yaiaO8qakUMvsuMSlw-1; Wed, 23 Apr 2025 05:41:22 -0400
X-MC-Unique: ZAc-yaiaO8qakUMvsuMSlw-1
X-Mimecast-MFC-AGG-ID: ZAc-yaiaO8qakUMvsuMSlw_1745401281
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5f4d2e9cdbdso5115019a12.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401280; x=1746006080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MbRAhfy8Au4a7AS3wclub6qPXCoZneXX7P8yh/nfffM=;
 b=LYQe9wFxn4cDYpSC+dRmKjlj8GnUo2pR4QR6ZTCTPsmxfXhH8Fl2pSq2cPqaXh86Pk
 jHw76ma6Gd1WnsgociAzsT/Xo+3IMfBp6bm7iWLvwK4qM4d7pj2nuFPlt5K7YQRGGFYP
 IvgKZUeqA7XGWzw8X+cZnD4FqKroCwVx1XYIx4ylTe+2snkxtHigRS9/i6CSqLEveStw
 r9J56qrTKnv1Za6wCeS3tUrUzpEbXsUTLxJ/5YRJ1oxMMHeBGc/nFG4k14GCjgdUGuFO
 yAa68aWfajts8QMlIMTRhvuSCq21biSRDmZcphKE414kInADqA/taXmGlU+zXtaW3nbz
 k96w==
X-Gm-Message-State: AOJu0YyZS4+v41ZzUZlXSARwEnHHvuBwYOVX3g/98d7t/FT+KiTE8VTl
 CdOFCkRdTHn7bBF4V9Egd6sQoXCj3nC47giRiB7NT+qZ/3s7BrQJ9wbrScuUFETU5R0gOahPObQ
 MDcMa6J9+S28aAuVsxEjoJ/g43nryqGElyYDsWgfFKHmyheTPPCHXtrD6SVkVE4nx/badga9CdD
 LxLjH7tviNQiTu4hpjJ3s6sBkEHhSCLl2zh+bT
X-Gm-Gg: ASbGncubtjXOYC+hLTgczaRHFLBZq1uMp5GhNqvEYDUCTWJlDP741SejiaA91VfnqOm
 ZaTuvt0j/gZfx10U1WcS7L/lFIO/hzFq0UZNDpVIWsBrKTlsak8RbeD6tvSBkM3Vd/pxBbDd/l4
 aKi0n1Nsh35zisdu34fQBOf4CGujAsFrFOIExmv0ad7wAoUXImLjLlPk7zFV/f3jOJpfqbHGZD3
 aldYPiLbvaz04snQrnNQTxhhjHbYxwXPLSoyHj+spHa7jPSPLLqG8BHGCDuxpspXw+de9kBvLa5
 DvVzeAZwp8VUSPUz
X-Received: by 2002:a05:6402:2356:b0:5f6:21a4:61d5 with SMTP id
 4fb4d7f45d1cf-5f62857414dmr16255228a12.17.1745401279877; 
 Wed, 23 Apr 2025 02:41:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFErbe9HlZWRwR0AHK+s+YJc2lLbDGV9Rp9qty7WdmvY2JblRVs7TO+wkasSmZGmsezHHCq6g==
X-Received: by 2002:a05:6402:2356:b0:5f6:21a4:61d5 with SMTP id
 4fb4d7f45d1cf-5f62857414dmr16255192a12.17.1745401279058; 
 Wed, 23 Apr 2025 02:41:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f625578307sm7100058a12.30.2025.04.23.02.41.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:41:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/34] target/i386: tcg: remove tmp0 and tmp4 from SHLD/SHRD
Date: Wed, 23 Apr 2025 11:40:36 +0200
Message-ID: <20250423094105.40692-7-pbonzini@redhat.com>
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

Apply some of the simplifications used for RCL and RCR.  tmp4 is not
used anywhere else, so remove it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 51 +++++++++++++++++++++----------------
 target/i386/tcg/emit.c.inc  |  6 ++---
 2 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index aee33428989..5529327680d 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -135,7 +135,6 @@ typedef struct DisasContext {
 
     /* TCG local register indexes (only used inside old micro ops) */
     TCGv tmp0;
-    TCGv tmp4;
     TCGv_i32 tmp2_i32;
     TCGv_i32 tmp3_i32;
     TCGv_i64 tmp1_i64;
@@ -1580,10 +1579,13 @@ static bool check_cpl0(DisasContext *s)
 }
 
 /* XXX: add faster immediate case */
-static void gen_shiftd_rm_T1(DisasContext *s, MemOp ot,
+static TCGv gen_shiftd_rm_T1(DisasContext *s, MemOp ot,
                              bool is_right, TCGv count)
 {
     target_ulong mask = (ot == MO_64 ? 63 : 31);
+    TCGv cc_src = tcg_temp_new();
+    TCGv tmp = tcg_temp_new();
+    TCGv hishift;
 
     switch (ot) {
     case MO_16:
@@ -1591,9 +1593,9 @@ static void gen_shiftd_rm_T1(DisasContext *s, MemOp ot,
            This means "shrdw C, B, A" shifts A:B:A >> C.  Build the B:A
            portion by constructing it as a 32-bit value.  */
         if (is_right) {
-            tcg_gen_deposit_tl(s->tmp0, s->T0, s->T1, 16, 16);
+            tcg_gen_deposit_tl(tmp, s->T0, s->T1, 16, 16);
             tcg_gen_mov_tl(s->T1, s->T0);
-            tcg_gen_mov_tl(s->T0, s->tmp0);
+            tcg_gen_mov_tl(s->T0, tmp);
         } else {
             tcg_gen_deposit_tl(s->T1, s->T0, s->T1, 16, 16);
         }
@@ -1604,47 +1606,53 @@ static void gen_shiftd_rm_T1(DisasContext *s, MemOp ot,
     case MO_32:
 #ifdef TARGET_X86_64
         /* Concatenate the two 32-bit values and use a 64-bit shift.  */
-        tcg_gen_subi_tl(s->tmp0, count, 1);
+        tcg_gen_subi_tl(tmp, count, 1);
         if (is_right) {
             tcg_gen_concat_tl_i64(s->T0, s->T0, s->T1);
-            tcg_gen_shr_i64(s->tmp0, s->T0, s->tmp0);
+            tcg_gen_shr_i64(cc_src, s->T0, tmp);
             tcg_gen_shr_i64(s->T0, s->T0, count);
         } else {
             tcg_gen_concat_tl_i64(s->T0, s->T1, s->T0);
-            tcg_gen_shl_i64(s->tmp0, s->T0, s->tmp0);
+            tcg_gen_shl_i64(cc_src, s->T0, tmp);
             tcg_gen_shl_i64(s->T0, s->T0, count);
-            tcg_gen_shri_i64(s->tmp0, s->tmp0, 32);
+            tcg_gen_shri_i64(cc_src, cc_src, 32);
             tcg_gen_shri_i64(s->T0, s->T0, 32);
         }
         break;
 #endif
     default:
-        tcg_gen_subi_tl(s->tmp0, count, 1);
+        hishift = tcg_temp_new();
+        tcg_gen_subi_tl(tmp, count, 1);
         if (is_right) {
-            tcg_gen_shr_tl(s->tmp0, s->T0, s->tmp0);
+            tcg_gen_shr_tl(cc_src, s->T0, tmp);
 
-            tcg_gen_subfi_tl(s->tmp4, mask + 1, count);
+            /* mask + 1 - count = mask - tmp = mask ^ tmp */
+            tcg_gen_xori_tl(hishift, tmp, mask);
             tcg_gen_shr_tl(s->T0, s->T0, count);
-            tcg_gen_shl_tl(s->T1, s->T1, s->tmp4);
+            tcg_gen_shl_tl(s->T1, s->T1, hishift);
         } else {
-            tcg_gen_shl_tl(s->tmp0, s->T0, s->tmp0);
+            tcg_gen_shl_tl(cc_src, s->T0, tmp);
+
             if (ot == MO_16) {
                 /* Only needed if count > 16, for Intel behaviour.  */
-                tcg_gen_subfi_tl(s->tmp4, 33, count);
-                tcg_gen_shr_tl(s->tmp4, s->T1, s->tmp4);
-                tcg_gen_or_tl(s->tmp0, s->tmp0, s->tmp4);
+                tcg_gen_subfi_tl(tmp, 33, count);
+                tcg_gen_shr_tl(tmp, s->T1, tmp);
+                tcg_gen_or_tl(cc_src, cc_src, tmp);
             }
 
-            tcg_gen_subfi_tl(s->tmp4, mask + 1, count);
+            /* mask + 1 - count = mask - tmp = mask ^ tmp */
+            tcg_gen_xori_tl(hishift, tmp, mask);
             tcg_gen_shl_tl(s->T0, s->T0, count);
-            tcg_gen_shr_tl(s->T1, s->T1, s->tmp4);
+            tcg_gen_shr_tl(s->T1, s->T1, hishift);
         }
-        tcg_gen_movi_tl(s->tmp4, 0);
-        tcg_gen_movcond_tl(TCG_COND_EQ, s->T1, count, s->tmp4,
-                           s->tmp4, s->T1);
+        tcg_gen_movcond_tl(TCG_COND_EQ, s->T1,
+                           count, tcg_constant_tl(0),
+                           tcg_constant_tl(0), s->T1);
         tcg_gen_or_tl(s->T0, s->T0, s->T1);
         break;
     }
+
+    return cc_src;
 }
 
 #define X86_MAX_INSN_LENGTH 15
@@ -3768,7 +3776,6 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->tmp1_i64 = tcg_temp_new_i64();
     dc->tmp2_i32 = tcg_temp_new_i32();
     dc->tmp3_i32 = tcg_temp_new_i32();
-    dc->tmp4 = tcg_temp_new();
     dc->cc_srcT = tcg_temp_new();
 }
 
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index f477a2da992..a41afb7fe46 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -4015,8 +4015,7 @@ static void gen_SHLD(DisasContext *s, X86DecodedInsn *decode)
     }
 
     decode->cc_dst = s->T0;
-    decode->cc_src = s->tmp0;
-    gen_shiftd_rm_T1(s, ot, false, count);
+    decode->cc_src = gen_shiftd_rm_T1(s, ot, false, count);
     if (can_be_zero) {
         gen_shift_dynamic_flags(s, decode, count, CC_OP_SHLB + ot);
     } else {
@@ -4068,8 +4067,7 @@ static void gen_SHRD(DisasContext *s, X86DecodedInsn *decode)
     }
 
     decode->cc_dst = s->T0;
-    decode->cc_src = s->tmp0;
-    gen_shiftd_rm_T1(s, ot, true, count);
+    decode->cc_src = gen_shiftd_rm_T1(s, ot, true, count);
     if (can_be_zero) {
         gen_shift_dynamic_flags(s, decode, count, CC_OP_SARB + ot);
     } else {
-- 
2.49.0


