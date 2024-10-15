Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2814ED216AC
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iNQ-0006lv-Gz; Tue, 15 Oct 2024 10:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iNO-0006es-KK
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iNK-0003MU-51
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M7bWE37evjP4cJxkLTZ4bWpHLH1Ngj8aQ69w1j9ITto=;
 b=EQatC/t2Z0Jfc+2x+gCB1IxD8Xu3GDyNeLFWT37NwprNnc4Gf50fkMO3zpGBOTDmIhQ7AC
 Do5PqB2NAG733MP+rbl98+GBTZQsreKGchwk6zzo7kHaB7Vs9krffdCDMjr3NLKMQ4ha+r
 t34AWvTjOo47CtFHkHkKjZU46Aq02nI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-ZK_YPdgfOVKq7uxk-CLaPQ-1; Tue, 15 Oct 2024 10:18:12 -0400
X-MC-Unique: ZK_YPdgfOVKq7uxk-CLaPQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4312935010fso26086035e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001890; x=1729606690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M7bWE37evjP4cJxkLTZ4bWpHLH1Ngj8aQ69w1j9ITto=;
 b=vw2oovJhwOj6NrnK1wmxjHGis1mR4dbSFsW8A0UVb5ZPB2ZevpcMqdsw49jQBp2ylu
 JzAI9bBDlUaibW+YiIbU297zcODYJQJwtR6jdZ4SgV3GoWWlMHYCoAJA+ARNyOJ9+NAp
 nGzJ8xX7Zcd2y+//YoIlaFS8jh/gT4c2yjeOotsEBuQ3xYX2yx3SD9kD5POhK6oGUlqC
 gJYaRtjgvyrCbtrcHqTnCDPuHR7h08u2KpdJwo1sJGiSB+AGc5mHFUVFDgvN7EjcrggO
 rrsoSqV+17T1YlT10QGKJa1Y/44AjNnhYANXwHSH5a9ufzeOMSLulvr/JsMFNa4er7xt
 STRw==
X-Gm-Message-State: AOJu0YyK2Z2IlFKqc9BTyKogAiymKceW2JV9/c8+8SQuBHCtiBxBPB2d
 BfN2EpLMYFM4jP/gDY1lj1uU0QOrZ+3G9IJdf5JW8JOjMH6GtToVP5wO1++Q4SwbrkC2hHv9umY
 b/PEYBk8hpIhdJV75YPqRpgaH4vD26BF2MF33M3YLQaoM2CZwbmM4CGhjJq2Wg5yew7qomZ7ZiC
 SSCYHTmN+kOYWD7veQGG/IJBe9Us1grr+BtjvMFDM=
X-Received: by 2002:a05:600c:1c9c:b0:42c:a8cb:6a5a with SMTP id
 5b1f17b1804b1-431255df67amr125245365e9.15.1729001889853; 
 Tue, 15 Oct 2024 07:18:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjtwfVuuSzfY3SKJNLny3Hf9+mLKs7ULSQYUISDshIDd960U8Ac4lDU1HMjRXWUZr09+NmgQ==
X-Received: by 2002:a05:600c:1c9c:b0:42c:a8cb:6a5a with SMTP id
 5b1f17b1804b1-431255df67amr125244965e9.15.1729001889334; 
 Tue, 15 Oct 2024 07:18:09 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f6b1e77sm19644295e9.31.2024.10.15.07.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:18:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 16/25] target/i386: assert that cc_op* and pc_save are preserved
Date: Tue, 15 Oct 2024 16:17:02 +0200
Message-ID: <20241015141711.528342-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015141711.528342-1-pbonzini@redhat.com>
References: <20241015141711.528342-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Now all decoding has been done before any code generation.
There is no need anymore to save and restore cc_op* and
pc_save but, for the time being, assert that this is indeed
the case.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index f4bffef9e28..ef190416b49 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3700,15 +3700,9 @@ static void i386_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     case 2:
         /* Restore state that may affect the next instruction. */
         dc->pc = dc->base.pc_next;
-        /*
-         * TODO: These save/restore can be removed after the table-based
-         * decoder is complete; we will be decoding the insn completely
-         * before any code generation that might affect these variables.
-         */
-        dc->cc_op_dirty = orig_cc_op_dirty;
-        dc->cc_op = orig_cc_op;
-        dc->pc_save = orig_pc_save;
-        /* END TODO */
+        assert(dc->cc_op_dirty == orig_cc_op_dirty);
+        assert(dc->cc_op == orig_cc_op);
+        assert(dc->pc_save == orig_pc_save);
         dc->base.num_insns--;
         tcg_remove_ops_after(dc->prev_insn_end);
         dc->base.insn_start = dc->prev_insn_start;
-- 
2.46.2


