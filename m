Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6447BC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 12:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9lFc-0000lX-Ui; Wed, 22 May 2024 08:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s9lFb-0000l3-4Z
 for qemu-devel@nongnu.org; Wed, 22 May 2024 08:39:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s9lFZ-0007Fo-1y
 for qemu-devel@nongnu.org; Wed, 22 May 2024 08:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716381559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jFScHE6hZHlVnvNL1+BD5sWhTqPzziiku1DySIAgFrw=;
 b=F+tIVuUDqOT4e5Txd3Qo2LVfkx2uR8w1126A71H8yYAfd3EUr3N5lgb4Cx/7pJvPJEujt+
 P/uCbn5IhvHep7Wn4to2juMB6g9RgIHLMYqXYVJGvie/AzCXXixhGrpv+5cvUczsxPeTRM
 FIRWuQUEQsMoavmpqffyMGSZij0PkOQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-HOH-6200NZWN7SuUVW9eAw-1; Wed, 22 May 2024 08:39:17 -0400
X-MC-Unique: HOH-6200NZWN7SuUVW9eAw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-57830839b4fso306706a12.1
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 05:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716381556; x=1716986356;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jFScHE6hZHlVnvNL1+BD5sWhTqPzziiku1DySIAgFrw=;
 b=k9v4rTpO54GVwHwQ3PdX8R4O4BjLPpkxE8Ri3FDFWN27v4mGW0aEDt+71wONGcIK7R
 wqMBPJABpNKjG2qgtePyxMF2THOscntCF0bygfZwaRcg2/LNXB1/vTFReBX8aSJCgmO9
 WbsD5t8Ur6RsYSIPJlEJoSbSfoML9yMCn96DBSVLmOS4wuZicYKOWDoX9LkCnzzUAaJ7
 juUWsBIy5dwPmMmnXJnERUMn2XuOt+p5vFpbdvx74zcghniJ/cHnnQB4zpeSrF5J7fvo
 /AmAovixbU6WRICCTQCCpBoR4PjQnB4rfwHNPitggpYnpFyEpROiiymgHVAiMJg4jrNQ
 mXSQ==
X-Gm-Message-State: AOJu0Yy0uTV2Y5EMg/50C0tlMXrRLmkRC/f72i381Z2uXXeMmM3t4c4O
 w8ss33JRU327uEMz/vvTsHTM6KbVXWwVEqTJ6TNR35rSCsSSpeowsJkA1VNopZTXRm6pQVb2CUU
 CDi6OfxqNwyLuVNzugZC6kVZOuGyqQYr3TMPC9n8uZNXI9R0qr25Fu6qfM+seDbUW92u6C2FT2k
 95NrhisOBNg8bNciO8Sa3LSSaw1nhR+XQDIeUd
X-Received: by 2002:a50:8e17:0:b0:573:55cc:2f50 with SMTP id
 4fb4d7f45d1cf-57832c585c5mr1576636a12.37.1716381555668; 
 Wed, 22 May 2024 05:39:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf2eZ4bs3kaSj6kzXf9qUdjD7zQikHbTWY/J2OUvxTxtdaZPqAxuzMmnLjqRxl4YPCkJ+S7g==
X-Received: by 2002:a50:8e17:0:b0:573:55cc:2f50 with SMTP id
 4fb4d7f45d1cf-57832c585c5mr1576572a12.37.1716381554394; 
 Wed, 22 May 2024 05:39:14 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17891f6esm1777552766b.54.2024.05.22.05.39.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 05:39:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: clean up AAM/AAD
Date: Wed, 22 May 2024 14:39:12 +0200
Message-ID: <20240522123912.608497-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

The 32-bit AAM/AAD opcodes are using helpers that read and write flags and
env->regs[R_EAX].  Clean them up so that the table correctly includes AX
as a 16-bit input and output.

No real reason to do it to be honest, but they are nice one-output helpers
and it removes the masking of env->regs[R_EAX] that generic load/writeback
code already does.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/helper.h             |  4 ++--
 target/i386/tcg/int_helper.c     | 19 ++++++++-----------
 target/i386/tcg/decode-new.c.inc |  4 ++--
 target/i386/tcg/emit.c.inc       |  8 ++++----
 4 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/target/i386/helper.h b/target/i386/helper.h
index 3c207ac62d6..a52a1bf0f21 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -22,8 +22,8 @@ DEF_HELPER_FLAGS_5(bndstx32, TCG_CALL_NO_WG, void, env, tl, tl, i64, i64)
 DEF_HELPER_FLAGS_5(bndstx64, TCG_CALL_NO_WG, void, env, tl, tl, i64, i64)
 DEF_HELPER_1(bnd_jmp, void, env)
 
-DEF_HELPER_2(aam, void, env, int)
-DEF_HELPER_2(aad, void, env, int)
+DEF_HELPER_FLAGS_2(aam, TCG_CALL_NO_RWG_SE, tl, tl, tl)
+DEF_HELPER_FLAGS_2(aad, TCG_CALL_NO_RWG_SE, tl, tl, tl)
 DEF_HELPER_1(aaa, void, env)
 DEF_HELPER_1(aas, void, env)
 DEF_HELPER_1(daa, void, env)
diff --git a/target/i386/tcg/int_helper.c b/target/i386/tcg/int_helper.c
index df16130f5df..4cc59f15203 100644
--- a/target/i386/tcg/int_helper.c
+++ b/target/i386/tcg/int_helper.c
@@ -145,27 +145,24 @@ void helper_idivl_EAX(CPUX86State *env, target_ulong t0)
 
 /* bcd */
 
-/* XXX: exception */
-void helper_aam(CPUX86State *env, int base)
+target_ulong helper_aam(target_ulong al, target_ulong base)
 {
-    int al, ah;
+    int ah;
 
-    al = env->regs[R_EAX] & 0xff;
+    al &= 0xff;
     ah = al / base;
     al = al % base;
-    env->regs[R_EAX] = (env->regs[R_EAX] & ~0xffff) | al | (ah << 8);
-    CC_DST = al;
+    return al | (ah << 8);
 }
 
-void helper_aad(CPUX86State *env, int base)
+target_ulong helper_aad(target_ulong ax, target_ulong base)
 {
     int al, ah;
 
-    al = env->regs[R_EAX] & 0xff;
-    ah = (env->regs[R_EAX] >> 8) & 0xff;
+    al = ax & 0xff;
+    ah = (ax >> 8) & 0xff;
     al = ((ah * base) + al) & 0xff;
-    env->regs[R_EAX] = (env->regs[R_EAX] & ~0xffff) | al;
-    CC_DST = al;
+    return al;
 }
 
 void helper_aaa(CPUX86State *env)
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 141ab2bc560..27dc1bb146b 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1480,8 +1480,8 @@ static const X86OpEntry opcodes_root[256] = {
     [0xD1] = X86_OP_GROUP1(group2, E,v),
     [0xD2] = X86_OP_GROUP2(group2, E,b, 1,b), /* CL */
     [0xD3] = X86_OP_GROUP2(group2, E,v, 1,b), /* CL */
-    [0xD4] = X86_OP_ENTRYr(AAM, I,b),
-    [0xD5] = X86_OP_ENTRYr(AAD, I,b),
+    [0xD4] = X86_OP_ENTRY2(AAM, 0,w, I,b),
+    [0xD5] = X86_OP_ENTRY2(AAD, 0,w, I,b),
     [0xD6] = X86_OP_ENTRYw(SALC, 0,b),
     [0xD7] = X86_OP_ENTRY1(XLAT, 0,b, zextT0), /* AL read/written */
 
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 2dee33dd487..ecfdeb1e668 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1084,8 +1084,8 @@ static void gen_AAA(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 
 static void gen_AAD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
-    gen_helper_aad(tcg_env, tcg_constant_i32(decode->immediate));
-    set_cc_op(s, CC_OP_LOGICB);
+    gen_helper_aad(s->T0, s->T0, s->T1);
+    prepare_update1_cc(decode, s, CC_OP_LOGICB);
 }
 
 static void gen_AAM(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
@@ -1093,8 +1093,8 @@ static void gen_AAM(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     if (decode->immediate == 0) {
         gen_exception(s, EXCP00_DIVZ);
     } else {
-        gen_helper_aam(tcg_env, tcg_constant_i32(decode->immediate));
-        set_cc_op(s, CC_OP_LOGICB);
+        gen_helper_aam(s->T0, s->T0, s->T1);
+        prepare_update1_cc(decode, s, CC_OP_LOGICB);
     }
 }
 
-- 
2.45.1


