Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E980C27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrdx-0001aG-Fs; Sat, 08 Jun 2024 04:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrdw-0001Zv-OM
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:41:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrdv-0001PK-5F
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717836102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fmgaGjuxT+Z57Hwfs56i25kjDBhaRWZGViu+jJkHY1Q=;
 b=IjxExIvILZACOgVEIn5QvPbHMI6/X5KmEUdI/ppeH6JoOVD9OolXyNh8Aay53aOCg7L2Im
 mFbNwcuRDpWYUhCNv6hUG/kyNiQHzVkRotL2vJw+EF4aB3rtekkfMhm+tPmkLxvixBODF3
 Z2ZaYEkqaQu/6egeyH8uhG8V0KEunko=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-CSEiywRIPvafn6J45I0g_w-1; Sat, 08 Jun 2024 04:41:40 -0400
X-MC-Unique: CSEiywRIPvafn6J45I0g_w-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57a941a787dso1704786a12.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717836098; x=1718440898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fmgaGjuxT+Z57Hwfs56i25kjDBhaRWZGViu+jJkHY1Q=;
 b=pyvxGNbXH/ADlwgtVLWoBLMA/EmyT422U551PQiCKYGLLh1vogDc8rEgn5bfYE0XHT
 HJmXQr+ADZT7T/fD1lFFVi7T1WX+0/ka1jf8I9kFK35Y0/tgj7u3yrHrMcqAAvNtxtWZ
 fwbd10sZKT651WYz/bzWnbQHSxyB8bsafz+jidTNUsg3qvL87zpeHUMa952uhEPm5vBs
 WgkAc5in5ux2qLOc36tpF6GBIHiB4pcyI6RmbWhz9PtsBrtH99X+hhKFzl9vOLCigfsJ
 D0NO8BhWUcCGVmpoL0p+jje+0nUYoWhXDP04GetWETNzksLSZDwUR3KYYLHgOBzwCvgP
 84Qw==
X-Gm-Message-State: AOJu0YwM4rC0iy6A/NsiqwjhGIysWZ+cwKiV2I0Gu2AvyB4lfFpkG1ww
 cFmFk9Zf+OAQn6WRGQYDQMUcMviMWLaOr6rBaeZlzhlZQAnH5i+t9KrDis0DermRPRhE4tb+eSA
 mcurMk4+PrKyiIxltt/HKHJq9RxJJpX/6smNAJAH3O0o+SsNgOidGmLKnA5rB3dpKE+kGt0+ps7
 IbVx3PdXVmXSXbCnJPzioP7QNngotwFKsOPmH/
X-Received: by 2002:a50:999d:0:b0:57c:6ae2:abda with SMTP id
 4fb4d7f45d1cf-57c6ae2ac5emr958752a12.5.1717836098568; 
 Sat, 08 Jun 2024 01:41:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtPBRVPIVg1VplbYgGKRR7OWdY7gPae0j4Jklq5Qqnkg6NVMximxER/voEp98RguNYPvgdJA==
X-Received: by 2002:a50:999d:0:b0:57c:6ae2:abda with SMTP id
 4fb4d7f45d1cf-57c6ae2ac5emr958744a12.5.1717836098193; 
 Sat, 08 Jun 2024 01:41:38 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aadf9ea35sm3933883a12.15.2024.06.08.01.41.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:41:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/25] target/i386: replace NoSeg special with NoLoadEA
Date: Sat,  8 Jun 2024 10:40:54 +0200
Message-ID: <20240608084113.2770363-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608084113.2770363-1-pbonzini@redhat.com>
References: <20240608084113.2770363-1-pbonzini@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is a bit more generic, as it can be applied to MPX as well.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     |  5 +++--
 target/i386/tcg/decode-new.c.inc | 12 ++++--------
 target/i386/tcg/emit.c.inc       |  3 ++-
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index f704698575f..46a96b220d0 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -170,8 +170,9 @@ typedef enum X86InsnSpecial {
     /* Always locked if it has a memory operand (XCHG) */
     X86_SPECIAL_Locked,
 
-    /* Do not apply segment base to effective address */
-    X86_SPECIAL_NoSeg,
+    /* Do not load effective address in s->A0 */
+    X86_SPECIAL_NoLoadEA,
+
     /*
      * Rd/Mb or Rd/Mw in the manual: register operand 0 is treated as 32 bits
      * (and writeback zero-extends it to 64 bits if applicable).  PREFIX_DATA
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index d41002e2f5c..4f5fcdb88dd 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -193,7 +193,7 @@
     X86_OP_ENTRY3(op, None, None, None, None, None, None, ## __VA_ARGS__)
 
 #define cpuid(feat) .cpuid = X86_FEAT_##feat,
-#define noseg .special = X86_SPECIAL_NoSeg,
+#define nolea .special = X86_SPECIAL_NoLoadEA,
 #define xchg .special = X86_SPECIAL_Locked,
 #define lock .special = X86_SPECIAL_HasLock,
 #define mmx .special = X86_SPECIAL_MMX,
@@ -1592,7 +1592,7 @@ static const X86OpEntry opcodes_root[256] = {
     [0x8B] = X86_OP_ENTRYwr(MOV, G,v, E,v),
      /* Missing in Table A-2: memory destination is always 16-bit.  */
     [0x8C] = X86_OP_ENTRYwr(MOV, E,v, S,w, op0_Mw),
-    [0x8D] = X86_OP_ENTRYwr(LEA, G,v, M,v, noseg),
+    [0x8D] = X86_OP_ENTRYwr(LEA, G,v, M,v, nolea),
     [0x8E] = X86_OP_ENTRYwr(MOV, S,w, E,w),
     [0x8F] = X86_OP_GROUPw(group1A, E,v),
 
@@ -2524,11 +2524,6 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         assert(decode.op[1].unit == X86_OP_INT);
         break;
 
-    case X86_SPECIAL_NoSeg:
-        decode.mem.def_seg = -1;
-        s->override = -1;
-        break;
-
     case X86_SPECIAL_Op0_Mw:
         assert(decode.op[0].unit == X86_OP_INT);
         if (decode.op[0].has_ea) {
@@ -2585,7 +2580,8 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
         gen_helper_enter_mmx(tcg_env);
     }
 
-    if (decode.op[0].has_ea || decode.op[1].has_ea || decode.op[2].has_ea) {
+    if (decode.e.special != X86_SPECIAL_NoLoadEA &&
+        (decode.op[0].has_ea || decode.op[1].has_ea || decode.op[2].has_ea)) {
         gen_load_ea(s, &decode.mem, decode.e.vex_class == 12);
     }
     if (s->prefix & PREFIX_LOCK) {
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 78d89db57cd..e6521632edd 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1970,7 +1970,8 @@ static void gen_LDS(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_LEA(DisasContext *s, X86DecodedInsn *decode)
 {
-    tcg_gen_mov_tl(s->T0, s->A0);
+    TCGv ea = gen_lea_modrm_1(s, decode->mem, false);
+    gen_lea_v_seg_dest(s, s->aflag, s->T0, ea, -1, -1);
 }
 
 static void gen_LEAVE(DisasContext *s, X86DecodedInsn *decode)
-- 
2.45.1


