Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2069EC25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9w1-0004y2-U5; Thu, 23 May 2024 11:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9vy-0004lB-3p
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:00:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9vw-0004mg-BC
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q8r8fuXfNS1frrmgB4ao1Xxrb7dvTzd90fOiUxzWjNQ=;
 b=Z9H4KFgOlY/m0Of+pg8g+4RD681+wcqP2Ik6HvUOJ+JtH3NBtapI4VDA8ggjVmL7cjeMGQ
 1Lk16Lo3LJVlbTXisDXJ9dN0XDQ+SYS3QalCqw69V7QvEe4cNU1vOBqxKR3FnOAvRf8kuR
 neAV2nD3Uv2/A+q1h2L8VqdmKlDfsjM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-MDXRjKNbNwqnHOI1iR8wnw-1; Thu, 23 May 2024 11:00:41 -0400
X-MC-Unique: MDXRjKNbNwqnHOI1iR8wnw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52236a56aa1so1304008e87.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476439; x=1717081239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q8r8fuXfNS1frrmgB4ao1Xxrb7dvTzd90fOiUxzWjNQ=;
 b=FE7wOylChET5qK/2O9mALgdh7NpgO/OLC4M47QxGoa0tWBxZDhzrkTWMJNkx7do/fq
 VCgH3X5puSc4i6qmIwOhr3s8Vtdy4APBWUJB2U9WJsLlcDYpZpJt9rDi9W2Yt5rVJTdV
 BfkO9sPbJltBIRwxIT0WEcuC0yw9CuupCYzOgJ1rLN/gaynhHXB4UpA01vSbcEzwcwtH
 apR4JC8rrf4NhfWHgyFYJk/xQJzsfiJBfMViCiFIRc/1RSv5/Im3nESm9WICacQoIFJM
 S9pv0k3XJlUnjkC02/paMNEg+EdHgYiwdGoJXX/fpRGzObp+PO0I3+KNjNoYX1Fr5iDO
 ladg==
X-Gm-Message-State: AOJu0Yx91yw4RfS0kyG3Z3kVnPYMFWlCIiG8pdFNhnjtwuucDLepzAaV
 7FfJ+tfS5HEnWGQwUywiJ5tKejg9GVU6NaoRJMDKYKmhySzUQtKeAmWTEAtn233IbSbtwLTVq6g
 v/1zBkIFnYUFOXpvfexIaJx4Iu6Lpho+AQXoy90xOHQeFCC3RRlZnpbwyZ6U5zfuuV5vKK5RTW5
 rfCoBeaDx+vmidjMdHC2dWxOCozr2s6yokwRfv
X-Received: by 2002:a19:385c:0:b0:51e:25d2:453f with SMTP id
 2adb3069b0e04-526c15eb8admr2943940e87.68.1716476439637; 
 Thu, 23 May 2024 08:00:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4rX1SNUxqi/sea3OI+oD5NvncjNQHTmyAwiOyekA4TG0W6l9HONHCp7am9z4InagSjIuKeg==
X-Received: by 2002:a19:385c:0:b0:51e:25d2:453f with SMTP id
 2adb3069b0e04-526c15eb8admr2943898e87.68.1716476439095; 
 Thu, 23 May 2024 08:00:39 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5ce94e51basm1039266366b.103.2024.05.23.08.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:00:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/23] target/i386: generate simpler code for ROL/ROR with
 immediate count
Date: Thu, 23 May 2024 17:00:14 +0200
Message-ID: <20240523150036.1050011-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523150036.1050011-1-pbonzini@redhat.com>
References: <20240523150036.1050011-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

gen_rot_carry and gen_rot_overflow are meant to be called with count == NULL
if the count cannot be zero.  However this is not done in gen_ROL and gen_ROR,
and writing everywhere "can_be_zero ? count : NULL" is burdensome and less
readable.  Just pass can_be_zero as a separate argument.

gen_RCL and gen_RCR use a conditional branch to skip the computation
if count is zero, so they can pass false unconditionally to gen_rot_overflow.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240522123914.608516-1-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 2dee33dd487..33cb59e54b8 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2901,14 +2901,15 @@ static bool gen_eflags_adcox(DisasContext *s, X86DecodedInsn *decode, bool want_
     return got_cf;
 }
 
-static void gen_rot_overflow(X86DecodedInsn *decode, TCGv result, TCGv old, TCGv count)
+static void gen_rot_overflow(X86DecodedInsn *decode, TCGv result, TCGv old,
+                             bool can_be_zero, TCGv count)
 {
     MemOp ot = decode->op[0].ot;
-    TCGv temp = count ? tcg_temp_new() : decode->cc_src2;
+    TCGv temp = can_be_zero ? tcg_temp_new() : decode->cc_src2;
 
     tcg_gen_xor_tl(temp, old, result);
     tcg_gen_extract_tl(temp, temp, (8 << ot) - 1, 1);
-    if (count) {
+    if (can_be_zero) {
         tcg_gen_movcond_tl(TCG_COND_EQ, decode->cc_src2, count, tcg_constant_tl(0),
                            decode->cc_src2, temp);
     }
@@ -3000,7 +3001,7 @@ static void gen_RCL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     /* Compute result and outgoing overflow */
     tcg_gen_mov_tl(decode->cc_src2, s->T0);
     tcg_gen_or_tl(s->T0, low, high);
-    gen_rot_overflow(decode, s->T0, decode->cc_src2, NULL);
+    gen_rot_overflow(decode, s->T0, decode->cc_src2, false, NULL);
 
     if (zero_label) {
         gen_set_label(zero_label);
@@ -3053,7 +3054,7 @@ static void gen_RCR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     /* Compute result and outgoing overflow */
     tcg_gen_mov_tl(decode->cc_src2, s->T0);
     tcg_gen_or_tl(s->T0, low, high);
-    gen_rot_overflow(decode, s->T0, decode->cc_src2, NULL);
+    gen_rot_overflow(decode, s->T0, decode->cc_src2, false, NULL);
 
     if (zero_label) {
         gen_set_label(zero_label);
@@ -3129,9 +3130,10 @@ static TCGv_i32 gen_rot_replicate(MemOp ot, TCGv in)
     }
 }
 
-static void gen_rot_carry(X86DecodedInsn *decode, TCGv result, TCGv count, int bit)
+static void gen_rot_carry(X86DecodedInsn *decode, TCGv result,
+                          bool can_be_zero, TCGv count, int bit)
 {
-    if (count == NULL) {
+    if (!can_be_zero) {
         tcg_gen_extract_tl(decode->cc_dst, result, bit, 1);
     } else {
         TCGv temp = tcg_temp_new();
@@ -3165,8 +3167,8 @@ static void gen_ROL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     } else {
         tcg_gen_rotl_tl(s->T0, s->T0, count);
     }
-    gen_rot_carry(decode, s->T0, count, 0);
-    gen_rot_overflow(decode, s->T0, old, count);
+    gen_rot_carry(decode, s->T0, can_be_zero, count, 0);
+    gen_rot_overflow(decode, s->T0, old, can_be_zero, count);
 }
 
 static void gen_ROR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
@@ -3190,12 +3192,12 @@ static void gen_ROR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
         tcg_gen_rotr_i32(temp32, temp32, count32);
         /* Zero extend to facilitate later optimization.  */
         tcg_gen_extu_i32_tl(s->T0, temp32);
-        gen_rot_carry(decode, s->T0, count, 31);
+        gen_rot_carry(decode, s->T0, can_be_zero, count, 31);
     } else {
         tcg_gen_rotr_tl(s->T0, s->T0, count);
-        gen_rot_carry(decode, s->T0, count, TARGET_LONG_BITS - 1);
+        gen_rot_carry(decode, s->T0, can_be_zero, count, TARGET_LONG_BITS - 1);
     }
-    gen_rot_overflow(decode, s->T0, old, count);
+    gen_rot_overflow(decode, s->T0, old, can_be_zero, count);
 }
 
 static void gen_RORX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
-- 
2.45.1


