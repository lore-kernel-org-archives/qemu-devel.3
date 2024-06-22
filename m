Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA46C27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 06:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKu3R-0000TF-DV; Sat, 22 Jun 2024 02:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu31-0000Bs-Ti
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu30-0006QZ-AJ
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719036985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9XXSgEZfF/mgmRYz0quvK+Q6GbqXkOMqVfYjFVsm7Z8=;
 b=hdzFnZ9wvj8Kh9i70wKnYNhxG149Wytni5kyL59qy9CBtLjoqhNCngaXF7eooC6wp7P1r0
 3pyuK0f0p59V8Vh1NqfI8TBaZWovq/Pw95QPTQL1OJdy89KRiOgJz+mz6pTkPn4+2I0q2U
 fO/P9b9e6DcrznH4R+hRuH/uKCg3+j8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-rM6oYL3mMFeSt8Vt1zVVPw-1; Sat, 22 Jun 2024 02:16:24 -0400
X-MC-Unique: rM6oYL3mMFeSt8Vt1zVVPw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57d172119a6so1082731a12.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 23:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719036981; x=1719641781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9XXSgEZfF/mgmRYz0quvK+Q6GbqXkOMqVfYjFVsm7Z8=;
 b=YsQf7cBRKARN0xmnLhvmepVJLZFDYRAYTIZZOjHcv34SYZZt5ug7Sa1ogtKOs0vBWK
 EWVn7mOMLkwq+QerWN5Z0uqbUVuoufpghS7AM/u1go3/a3cmHZCRbdSwMwxgQOduGm6y
 bX7dYrOAM8A/k9Vgfz7evmT7gdCigKYmRTGe8lsSfRZpFQbXj6O64J7WDoM9rMiQ9Rub
 v/FGzU7b655k8hOqr+e0s20ZYWEw0aZatyWEjK0CKh292EpR9JqxWAcKE2NCFaFbbOcn
 finAgSRwgDwSglkJj7CNj7o8iZoSOs97tJ/TbO4WZhSa+HfASfUwKrzRyj+leWndklLd
 9+Pg==
X-Gm-Message-State: AOJu0YyHJIU5HzXy3oYwHfbXBfA94FkCnRNt9qOLBmhM4zljd/Fl0q4L
 R+VnPZxstzG03KN3XRYmcsnkMQq9/Ot6wgSa3qufRK3vMkodyJqdTKMl90sv5nkFf6kcHa8ngqR
 YGPYEIfnWDe4ASSbBO+lXKO9EuoFkPkKLuUlXgzVaUnyxcp73kayQZfNeQE5P1XzF75JHiQMIux
 AfbGxdhTSVR7F7hq0p739IqXYqjTiycXkz1cV8
X-Received: by 2002:a05:6402:1744:b0:57d:105c:c40c with SMTP id
 4fb4d7f45d1cf-57d105cc49fmr5008897a12.24.1719036981374; 
 Fri, 21 Jun 2024 23:16:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwHbT0WoRt1AE863/AT8eK0gyJaEa+Z6La0dbvzJbpN6EMFIkmi7erNKhuVW9nHLZ50Nh/Tw==
X-Received: by 2002:a05:6402:1744:b0:57d:105c:c40c with SMTP id
 4fb4d7f45d1cf-57d105cc49fmr5008890a12.24.1719036980975; 
 Fri, 21 Jun 2024 23:16:20 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d30563026sm1862743a12.85.2024.06.21.23.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 23:16:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/23] target/i386: do not check PREFIX_LOCK in old-style
 decoder
Date: Sat, 22 Jun 2024 08:15:43 +0200
Message-ID: <20240622061558.530543-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622061558.530543-1-pbonzini@redhat.com>
References: <20240622061558.530543-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It is already checked before getting there.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index c60f18c7482..501a1ef9313 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2878,7 +2878,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
         switch ((modrm >> 3) & 7) {
         case 7:
             if (mod != 3 ||
-                (s->prefix & (PREFIX_LOCK | PREFIX_REPNZ))) {
+                (s->prefix & PREFIX_REPNZ)) {
                 goto illegal_op;
             }
             if (s->prefix & PREFIX_REPZ) {
@@ -2898,7 +2898,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
 
         case 6: /* RDRAND */
             if (mod != 3 ||
-                (s->prefix & (PREFIX_LOCK | PREFIX_REPZ | PREFIX_REPNZ)) ||
+                (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) ||
                 !(s->cpuid_ext_features & CPUID_EXT_RDRAND)) {
                 goto illegal_op;
             }
@@ -3058,8 +3058,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
 
         case 0xd0: /* xgetbv */
             if ((s->cpuid_ext_features & CPUID_EXT_XSAVE) == 0
-                || (s->prefix & (PREFIX_LOCK | PREFIX_DATA
-                                 | PREFIX_REPZ | PREFIX_REPNZ))) {
+                || (s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
                 goto illegal_op;
             }
             tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
@@ -3069,8 +3068,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
 
         case 0xd1: /* xsetbv */
             if ((s->cpuid_ext_features & CPUID_EXT_XSAVE) == 0
-                || (s->prefix & (PREFIX_LOCK | PREFIX_DATA
-                                 | PREFIX_REPZ | PREFIX_REPNZ))) {
+                || (s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
                 goto illegal_op;
             }
             gen_svm_check_intercept(s, SVM_EXIT_XSETBV);
@@ -3237,8 +3235,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             gen_st_modrm(s, decode, ot);
             break;
         case 0xee: /* rdpkru */
-            if (s->prefix & (PREFIX_LOCK | PREFIX_DATA
-                             | PREFIX_REPZ | PREFIX_REPNZ)) {
+            if (s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ)) {
                 goto illegal_op;
             }
             tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
@@ -3246,8 +3243,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             tcg_gen_extr_i64_tl(cpu_regs[R_EAX], cpu_regs[R_EDX], s->tmp1_i64);
             break;
         case 0xef: /* wrpkru */
-            if (s->prefix & (PREFIX_LOCK | PREFIX_DATA
-                             | PREFIX_REPZ | PREFIX_REPNZ)) {
+            if (s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ)) {
                 goto illegal_op;
             }
             tcg_gen_concat_tl_i64(s->tmp1_i64, cpu_regs[R_EAX],
@@ -3323,7 +3319,6 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             if (prefixes & PREFIX_REPZ) {
                 /* bndcl */
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
@@ -3331,7 +3326,6 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             } else if (prefixes & PREFIX_REPNZ) {
                 /* bndcu */
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
@@ -3345,7 +3339,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
                 }
                 if (mod == 3) {
                     int reg2 = (modrm & 7) | REX_B(s);
-                    if (reg2 >= 4 || (prefixes & PREFIX_LOCK)) {
+                    if (reg2 >= 4) {
                         goto illegal_op;
                     }
                     if (s->flags & HF_MPX_IU_MASK) {
@@ -3374,7 +3368,6 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
                 /* bndldx */
                 AddressParts a = decode->mem;
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16
                     || a.base < -1) {
                     goto illegal_op;
@@ -3410,7 +3403,6 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             if (mod != 3 && (prefixes & PREFIX_REPZ)) {
                 /* bndmk */
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
@@ -3438,7 +3430,6 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
             } else if (prefixes & PREFIX_REPNZ) {
                 /* bndcn */
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
@@ -3450,7 +3441,7 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
                 }
                 if (mod == 3) {
                     int reg2 = (modrm & 7) | REX_B(s);
-                    if (reg2 >= 4 || (prefixes & PREFIX_LOCK)) {
+                    if (reg2 >= 4) {
                         goto illegal_op;
                     }
                     if (s->flags & HF_MPX_IU_MASK) {
@@ -3477,7 +3468,6 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
                 /* bndstx */
                 AddressParts a = decode->mem;
                 if (reg >= 4
-                    || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16
                     || a.base < -1) {
                     goto illegal_op;
-- 
2.45.2


