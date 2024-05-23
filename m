Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5A9C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9w1-0004v0-13; Thu, 23 May 2024 11:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9vz-0004r3-OJ
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:00:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9vx-0004mu-VK
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PA8Yx9dDcVAjLfl4bPdHEZllpwb4CCTSG4hRdz+6q9M=;
 b=BLHx8wFK5TIeZogYYjx+3FWhmDKK/JP0b1taatHMDA3Yn22p6vSwox+blyPAK5c01UfPE+
 /8tUn2sGj7L4RrQhc40QHiU5Urdb8rSVlcCDgOJZ/xShK3VbrbbNhfsV3+6QDYtLY1WI9S
 bulp1i/k8hFFjpxBXIiVMepTL0HhqQs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-b6g3wj06MqmtCOwIjYYCpg-1; Thu, 23 May 2024 11:00:43 -0400
X-MC-Unique: b6g3wj06MqmtCOwIjYYCpg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a621c9a65f4so82658066b.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476442; x=1717081242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PA8Yx9dDcVAjLfl4bPdHEZllpwb4CCTSG4hRdz+6q9M=;
 b=jseq/oRqSgfFKHAFpoZV0HBY0UpOS6I1MmAWoUvBTx+PqDzqo9mlpfZi18q28ATc5W
 dNyLqLKaXw8dZppCFmnojunI9Jdt9vpGmZphs9cmYciMNMfKIkUjOZoPMkZ6VFsLYTfJ
 9mmB5N6jebIqXDAZJ5YEIV4D/znQfkjeUnZR4yZVNw30qR+yRfX7JDxQkawSIo7pdry3
 wufjU+B7CzkSCklvN5tLqlZ2WCMDbF4r+BFAcFZrPFEc+V/9m4VdOT4EdowqYWkotXyW
 xVMqUe2tfFAuqYwDMghf4EHaAm90rlnNGE4K3kPGzyip/KCyb6/fKc4axlpeM36E7/SW
 SvuQ==
X-Gm-Message-State: AOJu0YyB8VOsdOAD2pQTJ8HEcFsQkT22UAridZxUCopCggxC7r/Xt9ID
 OZwq9FkRTHsFbOMM23Mph+ewzOBIX/nFYHZsONKVry17w/DRvJsKrLSL7aWx3FmiOUjh9o5veb5
 867N2o6fQ7M+BXSHWiHODZEID/TkqNW2uLAHhUh5qRlk5eY24uJy6IlxwvIhRwPtNQj6kHk3pMX
 QIz+JdBw/Lnan/goW68FkckkTjshJWGmaUrdJK
X-Received: by 2002:a17:906:a0c9:b0:a59:9d4c:eb09 with SMTP id
 a640c23a62f3a-a6228069286mr362107366b.27.1716476442051; 
 Thu, 23 May 2024 08:00:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWQ0oj7QicNW+oP0A0wU0SLQE9fa7b8SN+jww+F0zv6DF6SPaCOrJu9nVkoPq/UmiASPKLsA==
X-Received: by 2002:a17:906:a0c9:b0:a59:9d4c:eb09 with SMTP id
 a640c23a62f3a-a6228069286mr362105866b.27.1716476441660; 
 Thu, 23 May 2024 08:00:41 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c823dsm1942307666b.100.2024.05.23.08.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:00:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/23] target/i386: clean up AAM/AAD
Date: Thu, 23 May 2024 17:00:15 +0200
Message-ID: <20240523150036.1050011-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523150036.1050011-1-pbonzini@redhat.com>
References: <20240523150036.1050011-1-pbonzini@redhat.com>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240522123912.608497-1-pbonzini@redhat.com>
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
index 33cb59e54b8..c78e35b1e28 100644
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


