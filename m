Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DECC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 11:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IUR-0004Y7-KD; Tue, 07 May 2024 06:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUP-0004WF-7Y
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUN-0002Kn-9Q
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715079362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gpm22Ugye1O7VXn9KZgvuT4kSCO+qP9oafJZ8q2VGXU=;
 b=JBAc+eZIoTJzACJh8CMMW0MSq4AJFJC+slnhM20HZJ93xJm8SlOa+1PuDF5wvuuM+0sjDS
 ZaD9VcrM7nHLlLoOs6WY1Mc2dYB/YpsriQ0FBmJ2ljI0TCf2gTyO8kOXts6lNJmc8B+yUa
 KqDPpRn5KpDzwXPmdnxczAEH3Rd6lI0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-tLyd75EQPD-nCWl94w60iQ-1; Tue, 07 May 2024 06:56:01 -0400
X-MC-Unique: tLyd75EQPD-nCWl94w60iQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59a17f35c8so197009166b.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715079359; x=1715684159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gpm22Ugye1O7VXn9KZgvuT4kSCO+qP9oafJZ8q2VGXU=;
 b=WT7T/zdasboIcIFO877/5G85PdxoxDepRJrZzm4KJjPlA7Kf9ltbqDrgwfBjgd+2pu
 yZcjFmnb+RWI1Z1pNhe+rGhgQaUaqp/GQtzL0TJaPSgA11dnInT6ilkSJGyZItI4jGLQ
 +96HHop1hZfGGluzMljs/TSsMUKKzNAFYNQWMf5QDA5SHtPNluAl3ve2vMS+pf7IKJHY
 BUgQIwGA7wvY8Z0qreZVrYe9JukjydM4FcfwoxPPW5LJqyc7CRsrfXtvl0C3a96/Pi1B
 N58QvzfBDYGbb3COteilEO37VdPZV+iJ4WZYTXCoyrRPKPQE0Yw5HhvoIxcbrGkQxBJx
 0wiw==
X-Gm-Message-State: AOJu0YwNZiTVhbsz56zzifgr+6nv583mb5VizQodclXpaHht35Z8Z/SG
 dVxT2qjsECJfoA59UKwnS0azLynsXiwR6fKm7CmkgUs3mVjNxdKmJcg+0mLa93QkKprd95ong0g
 lQFOc19G8ELMxnZPlQFyFmIsFX4KSPRdGPFMnNwPi8dWNDR1dMTbjxx232QHF6VB6CE5lu7flp1
 GpNQq4F5rbSf4Bg3kZF63bwfdGjpjP1p/kBCh2
X-Received: by 2002:a17:906:5614:b0:a59:beb2:62cc with SMTP id
 f20-20020a170906561400b00a59beb262ccmr4461901ejq.61.1715079359367; 
 Tue, 07 May 2024 03:55:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlfS+UswdilWfJwX4pjBpgMzyGMMA8yxpZfKJk4v4E9gAYMjV2abP3gEG9LMJ39rOn7wsoRQ==
X-Received: by 2002:a17:906:5614:b0:a59:beb2:62cc with SMTP id
 f20-20020a170906561400b00a59beb262ccmr4461889ejq.61.1715079359007; 
 Tue, 07 May 2024 03:55:59 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 f14-20020a1709062c4e00b00a599a437294sm4943086ejh.129.2024.05.07.03.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:55:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/26] target/i386: pull cc_op update to callers of
 gen_jmp_rel{, _csize}
Date: Tue,  7 May 2024 12:55:19 +0200
Message-ID: <20240507105538.180704-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240507105538.180704-1-pbonzini@redhat.com>
References: <20240507105538.180704-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

gen_update_cc_op must be called before control flow splits.  Doing it
in gen_jmp_rel{,_csize} may hide bugs, instead assert that cc_op is
clean---even if that means a few more calls to gen_update_cc_op().

With this new invariant, setting cc_op to CC_OP_DYNAMIC is unnecessary
since the caller should have done it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 466fee38c0e..024da6d88eb 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2853,6 +2853,8 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
     target_ulong new_pc = s->pc + diff;
     target_ulong new_eip = new_pc - s->cs_base;
 
+    assert(!s->cc_op_dirty);
+
     /* In 64-bit mode, operand size is fixed at 64 bits. */
     if (!CODE64(s)) {
         if (ot == MO_16) {
@@ -2866,9 +2868,6 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
     }
     new_eip &= mask;
 
-    gen_update_cc_op(s);
-    set_cc_op(s, CC_OP_DYNAMIC);
-
     if (tb_cflags(s->base.tb) & CF_PCREL) {
         tcg_gen_addi_tl(cpu_eip, cpu_eip, new_pc - s->pc_save);
         /*
@@ -5146,6 +5145,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
                         : (int16_t)insn_get(env, s, MO_16));
             gen_push_v(s, eip_next_tl(s));
             gen_bnd_jmp(s);
+            gen_update_cc_op(s);
             gen_jmp_rel(s, dflag, diff, 0);
         }
         break;
@@ -5169,6 +5169,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
                         ? (int32_t)insn_get(env, s, MO_32)
                         : (int16_t)insn_get(env, s, MO_16));
             gen_bnd_jmp(s);
+            gen_update_cc_op(s);
             gen_jmp_rel(s, dflag, diff, 0);
         }
         break;
@@ -5189,6 +5190,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
     case 0xeb: /* jmp Jb */
         {
             int diff = (int8_t)insn_get(env, s, MO_8);
+            gen_update_cc_op(s);
             gen_jmp_rel(s, dflag, diff, 0);
         }
         break;
-- 
2.45.0


