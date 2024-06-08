Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EAAC25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrWv-0000T1-HO; Sat, 08 Jun 2024 04:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrWu-0000Sd-17
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:34:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrWs-0008FH-E7
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kSWUo4sCXjrNOR0yu+FmZCYBkQr0GiAN238dsmBJ6yo=;
 b=FYGavq9m3MdOzp8O/weLd+HnZN3rKnccpFbzCsKEdHh75e4iJc7Bg7xKHnXyCMpWxfEcgR
 Rp4VS/ZujcEtrFk8cJWS9zK1Tw5B/+R+nKDTT0XoKF6oP3hJ/hbKUjwlfRHOCQFcY6gcbt
 t/o5Pd38D53p4F5M7d24VmBrjLeTS8w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-LYpYqYWWPZKtM5wR-Njg1A-1; Sat, 08 Jun 2024 04:34:23 -0400
X-MC-Unique: LYpYqYWWPZKtM5wR-Njg1A-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57a52cb6d86so1724299a12.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835662; x=1718440462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kSWUo4sCXjrNOR0yu+FmZCYBkQr0GiAN238dsmBJ6yo=;
 b=FDc+JIIP+hN9yjJ8sTFwha3fqijWc/uiqw1jDqdjVQf5CwNOuV6nBE2J6ROl9ITK/7
 or6BAami9xqc0PjT7VMeulBG+54Jn3v4ce3hjw3dUX8HaR0TUsSLMdzY0Ivk6k9MFEkS
 BcKuoHJbWlr76K0jKJaSvRZGr2U0erCHFgf7GktW1yk73DSvsdlG3qBW9LhCcm6aim2l
 0MYToca+Vv2+5zzXx6IS0AGDkBHzrmGdjyq3bltdO6gY9EvUKGk2rPw+SIBPmeNu3MG6
 7vHXJ2XlRsRb3v9R5wAhn+hThj5XD/GrcHSX+4Dyrw/gT0xUe5gz9+/anrAeOuxKx/zU
 RdGA==
X-Gm-Message-State: AOJu0Yw+t7C4JEpkpek5aQWZKSZ0VayFj/4WgMri23Uu0w6EfA3VHIhG
 7w0W+VqMTs2R8dGaglH1ZQhzJrpshWMeAq7gxHhmoqPYogIl9SfqibW9xUVNG3CQj1UsFUfQxNo
 WVzESAyb1zEi/8a81vTxgnmemfcz9N/qbPvPAHuizQCfYOkeHxvA6R0iF5Q5ZADRflB1rqq7z08
 5Nex8e1m0PUXOnUArS27jCQsfDEgRrBrkNltER
X-Received: by 2002:a50:f619:0:b0:57c:5503:940b with SMTP id
 4fb4d7f45d1cf-57c6f45ffcfmr445844a12.15.1717835661946; 
 Sat, 08 Jun 2024 01:34:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOnkUwXAuR96ptCvBrFbsFxz/BDthb6XFmSRWHlrOSu4hdRQRnlTMGsTNDU6YwnwA4hAGQ4Q==
X-Received: by 2002:a50:f619:0:b0:57c:5503:940b with SMTP id
 4fb4d7f45d1cf-57c6f45ffcfmr445831a12.15.1717835661430; 
 Sat, 08 Jun 2024 01:34:21 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae0ffbf8sm3972416a12.39.2024.06.08.01.34.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:34:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/42] target/i386: fix pushed value of EFLAGS.RF
Date: Sat,  8 Jun 2024 10:33:34 +0200
Message-ID: <20240608083415.2769160-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
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

When preparing an exception stack frame for a fault exception, the value
pushed for RF is 1.  Take that into account.  The same should be true
of interrupts for repeated string instructions, but the situation there
is complicated.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 49 ++++++++++++++++++++++++++++++++----
 target/i386/tcg/translate.c  |  8 ++++++
 2 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 0301459004e..715db1f2326 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -526,6 +526,24 @@ static inline unsigned int get_sp_mask(unsigned int e2)
     }
 }
 
+static int exception_is_fault(int intno)
+{
+    switch (intno) {
+        /*
+         * #DB can be both fault- and trap-like, but it never sets RF=1
+         * in the RFLAGS value pushed on the stack.
+         */
+    case EXCP01_DB:
+    case EXCP03_INT3:
+    case EXCP04_INTO:
+    case EXCP08_DBLE:
+    case EXCP12_MCHK:
+        return 0;
+    }
+    /* Everything else including reserved exception is a fault.  */
+    return 1;
+}
+
 int exception_has_error_code(int intno)
 {
     switch (intno) {
@@ -605,8 +623,9 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
     int type, dpl, selector, ss_dpl, cpl;
     int has_error_code, new_stack, shift;
     uint32_t e1, e2, offset, ss = 0, esp, ss_e1 = 0, ss_e2 = 0;
-    uint32_t old_eip, sp_mask;
+    uint32_t old_eip, sp_mask, eflags;
     int vm86 = env->eflags & VM_MASK;
+    bool set_rf;
 
     has_error_code = 0;
     if (!is_int && !is_hw) {
@@ -614,8 +633,10 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
     }
     if (is_int) {
         old_eip = next_eip;
+        set_rf = false;
     } else {
         old_eip = env->eip;
+        set_rf = exception_is_fault(intno);
     }
 
     dt = &env->idt;
@@ -748,6 +769,15 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
     }
     push_size <<= shift;
 #endif
+    eflags = cpu_compute_eflags(env);
+    /*
+     * AMD states that code breakpoint #DBs clear RF=0, Intel leaves it
+     * as is.  AMD behavior could be implemented in check_hw_breakpoints().
+     */
+    if (set_rf) {
+        eflags |= RF_MASK;
+    }
+
     if (shift == 1) {
         if (new_stack) {
             if (vm86) {
@@ -759,7 +789,7 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
             PUSHL(ssp, esp, sp_mask, env->segs[R_SS].selector);
             PUSHL(ssp, esp, sp_mask, env->regs[R_ESP]);
         }
-        PUSHL(ssp, esp, sp_mask, cpu_compute_eflags(env));
+        PUSHL(ssp, esp, sp_mask, eflags);
         PUSHL(ssp, esp, sp_mask, env->segs[R_CS].selector);
         PUSHL(ssp, esp, sp_mask, old_eip);
         if (has_error_code) {
@@ -776,7 +806,7 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
             PUSHW(ssp, esp, sp_mask, env->segs[R_SS].selector);
             PUSHW(ssp, esp, sp_mask, env->regs[R_ESP]);
         }
-        PUSHW(ssp, esp, sp_mask, cpu_compute_eflags(env));
+        PUSHW(ssp, esp, sp_mask, eflags);
         PUSHW(ssp, esp, sp_mask, env->segs[R_CS].selector);
         PUSHW(ssp, esp, sp_mask, old_eip);
         if (has_error_code) {
@@ -868,8 +898,9 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
     target_ulong ptr;
     int type, dpl, selector, cpl, ist;
     int has_error_code, new_stack;
-    uint32_t e1, e2, e3, ss;
+    uint32_t e1, e2, e3, ss, eflags;
     target_ulong old_eip, esp, offset;
+    bool set_rf;
 
     has_error_code = 0;
     if (!is_int && !is_hw) {
@@ -877,8 +908,10 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
     }
     if (is_int) {
         old_eip = next_eip;
+        set_rf = false;
     } else {
         old_eip = env->eip;
+        set_rf = exception_is_fault(intno);
     }
 
     dt = &env->idt;
@@ -950,9 +983,15 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
     }
     esp &= ~0xfLL; /* align stack */
 
+    /* See do_interrupt_protected.  */
+    eflags = cpu_compute_eflags(env);
+    if (set_rf) {
+        eflags |= RF_MASK;
+    }
+
     PUSHQ(esp, env->segs[R_SS].selector);
     PUSHQ(esp, env->regs[R_ESP]);
-    PUSHQ(esp, cpu_compute_eflags(env));
+    PUSHQ(esp, eflags);
     PUSHQ(esp, env->segs[R_CS].selector);
     PUSHQ(esp, old_eip);
     if (has_error_code) {
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 0486ab69112..d438f8f76f7 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -4630,6 +4630,14 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
      * If jmp_opt, we want to handle each string instruction individually.
      * For icount also disable repz optimization so that each iteration
      * is accounted separately.
+     *
+     * FIXME: this is messy; it makes REP string instructions a lot less
+     * efficient than they should be and it gets in the way of correct
+     * handling of RF (interrupts or traps arriving after any iteration
+     * of a repeated string instruction but the last should set RF to 1).
+     * Perhaps it would be more efficient if REP string instructions were
+     * always at the beginning of the TB, or even their own TB?  That
+     * would even allow accounting up to 64k iterations at once for icount.
      */
     dc->repz_opt = !dc->jmp_opt && !(cflags & CF_USE_ICOUNT);
 
-- 
2.45.1


