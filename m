Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3911C38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 06:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRQps-0000OD-1d; Wed, 10 Jul 2024 02:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRQpp-0000Df-Fn
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:29:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRQpn-0000vF-Ng
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720592987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vEGqfwScZxwmUn4DuepxdsFQZ9X1/s8dk2WV3PWSmng=;
 b=Y/LVyNTj/sE3s12XXQkr/2Rg+cnjEokyera0hQyu9qxvi3F7rk1b2zsdlG5eVDcqFZVH9a
 wShrX/b+IQ+wy/Zt/aX2XpR/jMG8BW79z0S9LRuJWlP6TmLN3gwi12DxisJqHvgE3nbZJP
 fBMbLCW5aFXkZ8Tnxt3SS2ZPDLL8HDc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-aLYBiFpeMHCjyPsNotU8fg-1; Wed, 10 Jul 2024 02:29:44 -0400
X-MC-Unique: aLYBiFpeMHCjyPsNotU8fg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a77b2b1d344so401342466b.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 23:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720592982; x=1721197782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vEGqfwScZxwmUn4DuepxdsFQZ9X1/s8dk2WV3PWSmng=;
 b=N6EOvQMj02B0/u+7GdRGBiiWS4Fo27XpZ4jjwnIR8z/S/T5KKyuDsov8hrEk8UgRXF
 IKWIjqeV7RNigYpMotSD/b3rTrXayKI0M3qe0JzQCEKYxKCFm/Kn53Y8wspaytbP9/My
 KpC4NG3AgqizBtBZklnCUSLy3kA82ix6LzM76FvYQBKJHVmQGJtLNXVNEXqIzMo1iabv
 4iLPqumJdEa25MpZPVUOmbBpLfKeVnuECy4CDevHu0AgKd037vvFXhYRMkiXnptIMwVF
 RsZ9lp/vACUqHHjSEkN62kOkNeqY1MFfnxBFiFfE0yr9UYHUQaLnvazRQKTUV9P5RRPT
 FPeQ==
X-Gm-Message-State: AOJu0YwJCzzH2Dx1DumTvqKtakaeaPcJz/tHZrDS5LOa6lNqkhLnhet5
 hRB2VdzxOSQ37zbKCXOk2x4ikDoUD7B52+IHLxY3ic8Y1kP0YH9eQDG3G2OIGWjXpzhYbpJgx5t
 KJBV6EbtUss0vhjcm48OeS3ijRsKdgnOPfRlqQKaGDy8GLvFrCSKFHM8RV/Zg/c7Eex7Ay7BxKz
 tiQBUa+PQNVAtQepm2bbOF3b8Z8NOLf4Dqllcj
X-Received: by 2002:a17:906:3396:b0:a77:e2b2:8ef with SMTP id
 a640c23a62f3a-a780b89f41dmr253505666b.70.1720592982499; 
 Tue, 09 Jul 2024 23:29:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYLd9jG9VYw4d7gAqJJB7JZYu+1dtWyLQcl9kChBpcSsnVuiSbONFF+SXez1K/7lCm4vX4/w==
X-Received: by 2002:a17:906:3396:b0:a77:e2b2:8ef with SMTP id
 a640c23a62f3a-a780b89f41dmr253503766b.70.1720592982021; 
 Tue, 09 Jul 2024 23:29:42 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde89108sm4361663f8f.55.2024.07.09.23.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 23:29:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: rrh.henry@gmail.com,
	richard.henderson@linaro.org
Subject: [PATCH 07/10] target/i386/tcg: Use DPL-level accesses for interrupts
 and call gates
Date: Wed, 10 Jul 2024 08:29:17 +0200
Message-ID: <20240710062920.73063-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710062920.73063-1-pbonzini@redhat.com>
References: <20240710062920.73063-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

This fixes a bug wherein i386/tcg assumed an interrupt return using
the CALL or JMP instructions were always going from kernel or user mode to
kernel mode, when using a call gate. This assumption is violated if
the call gate has a DPL that is greater than 0.

In addition, the stack accesses should count as explicit, not implicit
("kernel" in QEMU code), so that SMAP is not applied if DPL=3.

Analyzed-by: Robert R. Henry <rrh.henry@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/249
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 07e3667639a..1430f477c43 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -678,7 +678,7 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
 
     sa.env = env;
     sa.ra = 0;
-    sa.mmu_index = cpu_mmu_index_kernel(env);
+    sa.mmu_index = x86_mmu_index_pl(env, dpl);
 
     if (type == 5) {
         /* task gate */
@@ -984,7 +984,7 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
 
     sa.env = env;
     sa.ra = 0;
-    sa.mmu_index = cpu_mmu_index_kernel(env);
+    sa.mmu_index = x86_mmu_index_pl(env, dpl);
     sa.sp_mask = -1;
     sa.ss_base = 0;
     if (dpl < cpl || ist != 0) {
@@ -1119,7 +1119,7 @@ static void do_interrupt_real(CPUX86State *env, int intno, int is_int,
     sa.sp = env->regs[R_ESP];
     sa.sp_mask = 0xffff;
     sa.ss_base = env->segs[R_SS].base;
-    sa.mmu_index = cpu_mmu_index_kernel(env);
+    sa.mmu_index = x86_mmu_index_pl(env, 0);
 
     if (is_int) {
         old_eip = next_eip;
@@ -1583,7 +1583,7 @@ void helper_lcall_real(CPUX86State *env, uint32_t new_cs, uint32_t new_eip,
     sa.sp = env->regs[R_ESP];
     sa.sp_mask = get_sp_mask(env->segs[R_SS].flags);
     sa.ss_base = env->segs[R_SS].base;
-    sa.mmu_index = cpu_mmu_index_kernel(env);
+    sa.mmu_index = x86_mmu_index_pl(env, 0);
 
     if (shift) {
         pushl(&sa, env->segs[R_CS].selector);
@@ -1619,17 +1619,17 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
         raise_exception_err_ra(env, EXCP0D_GPF, new_cs & 0xfffc, GETPC());
     }
     cpl = env->hflags & HF_CPL_MASK;
+    dpl = (e2 >> DESC_DPL_SHIFT) & 3;
     LOG_PCALL("desc=%08x:%08x\n", e1, e2);
 
     sa.env = env;
     sa.ra = GETPC();
-    sa.mmu_index = cpu_mmu_index_kernel(env);
+    sa.mmu_index = x86_mmu_index_pl(env, dpl);
 
     if (e2 & DESC_S_MASK) {
         if (!(e2 & DESC_CS_MASK)) {
             raise_exception_err_ra(env, EXCP0D_GPF, new_cs & 0xfffc, GETPC());
         }
-        dpl = (e2 >> DESC_DPL_SHIFT) & 3;
         if (e2 & DESC_C_MASK) {
             /* conforming code segment */
             if (dpl > cpl) {
@@ -1691,7 +1691,6 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
     } else {
         /* check gate type */
         type = (e2 >> DESC_TYPE_SHIFT) & 0x1f;
-        dpl = (e2 >> DESC_DPL_SHIFT) & 3;
         rpl = new_cs & 3;
 
 #ifdef TARGET_X86_64
-- 
2.45.2


