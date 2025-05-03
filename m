Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF1BC369D9
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 08:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uB7mh-0008AY-0M; Sat, 03 May 2025 03:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7mf-0008A0-Lu
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7md-0006hi-8c
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746259176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mq+ksrrzmRU5e3CQiDfdSG+3l9vDGDH9VPK5MruBMrk=;
 b=GlvJ+nBQYwA3OW0JDHRnm8CQfO9ER4iDmnU5iDHYMYhIMXnyy4UtcKe0CXKXMa2HdpA9Uw
 jTe+BZw8n42JcZJq4U0yH6pect1MOC0fGLpMnJWcRDqGXc1BovLFaDl+JQ0zfEiquwxeeL
 LkwrF0+WdkhDsL1ChiGeBGIqlZsJ4CM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-rblvyGGXO1Gr1Zl7Qf7Cvw-1; Sat, 03 May 2025 03:59:34 -0400
X-MC-Unique: rblvyGGXO1Gr1Zl7Qf7Cvw-1
X-Mimecast-MFC-AGG-ID: rblvyGGXO1Gr1Zl7Qf7Cvw_1746259169
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-391492acb59so1355023f8f.3
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 00:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746259167; x=1746863967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mq+ksrrzmRU5e3CQiDfdSG+3l9vDGDH9VPK5MruBMrk=;
 b=UzIybRWAZN79FqtjmbswN3pUiy/EVmDKY0iBmaVAp3K9iQrMjJ7DNI94CePMnm7i+c
 uAQ9Y7WRzw8NMjxz0QpvNE8BoWt8FOHzQR9o4IB2C4/m7H8GcJwzy5cy+x2pC2XiIHMY
 zxqNZyL/yZlnyShfN331Q3qoRi3ZyKo4Nl455tFMJb3IAotX3vtRtTrNfA0/mMWbaXBH
 k+A0gC0ob/3VBdswbrCDsai3XEa3NnLcMjTksB0m9in7Utul1FoyDQ4EunMmHUBuDv3F
 eTm9DaysvMA4Nnx9y8nZqAITUYWvNTjHcumThKW82W+NO875Y15/rdlO40HbJ+Qv5uic
 3zUQ==
X-Gm-Message-State: AOJu0YyQZ38WPOr0S2+hy8elAbxIDru3F46lDBpAoeXiXUMX1gR4nP0R
 zcE34bq+RDlB7QvrKJyCRd7JYOi/oEA03rDlkTSJV/UhjaZWPeOBhlwJ3unipFzo9nA2+knf/d6
 bR57aNpPJsRYpjO+PM0i0+ts3v608XuPrsp6uDIdPcE8kusFtE/NR6Cuhcp12zJye0k9pJi9IXK
 GZ7+ouayL/PmdDvp4puN1wsf+mjt3JfPvGyCst
X-Gm-Gg: ASbGncu48gsaD/xJnmMKh/+5Q9z+fQCPurNrUQIMUB1U0Hekp8N3kAgycEyVtNCW5YE
 ZcGYQpnUjwbuAwyxfI2aSFSe0+VZabeYfCDhIvxoMEauL/E1RnWPzP6zrjFSYzChaxdcgFXSPNc
 +pTIbutYK8stJ72tP03bWdRLh9zjPi8BnedQOWjx6LqxBhYgTAXRFemQyaOojiMogxRxJWerJxm
 rBJyQFF4CADEhOuUzj7JGQc7/bfZid2NnK1PGEM6yx0GG96FAMi0iVKFJdTlJ4VByxKRDg6GlRS
 uj9++AneLnM438I=
X-Received: by 2002:a05:6000:290a:b0:391:ba6:c069 with SMTP id
 ffacd0b85a97d-3a09fde480fmr260791f8f.44.1746259167376; 
 Sat, 03 May 2025 00:59:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1sFtvKCqzZS9aZeWAkok5WILy7L+lUxmba8LWiHlQdnF9xgnQyAaSrA1XjEYqEdVkL1KUhQ==
X-Received: by 2002:a05:6000:290a:b0:391:ba6:c069 with SMTP id
 ffacd0b85a97d-3a09fde480fmr260778f8f.44.1746259166966; 
 Sat, 03 May 2025 00:59:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b1702dsm4087901f8f.88.2025.05.03.00.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 00:59:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 10/13] target/i386: do not block singlestep for STI
Date: Sat,  3 May 2025 09:58:55 +0200
Message-ID: <20250503075858.277375-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503075858.277375-1-pbonzini@redhat.com>
References: <20250503075858.277375-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

STI will trigger a singlestep exception even if it has inhibit-IRQ
behavior.  Do not suppress single-step for all IRQ-inhibiting
instructions, instead special case MOV SS and POP SS.

Cc: qemu-stable@nongnu.org
Fixes: f0f0136abba ("target/i386: no single-step exception after MOV or POP SS", 2024-05-25)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index a4e935b043b..ed43c95c1d9 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2047,11 +2047,15 @@ static void gen_movl_seg(DisasContext *s, X86Seg seg_reg, TCGv src, bool inhibit
      * stop as a special handling must be done to disable hardware
      * interrupts for the next instruction.
      *
+     * This is the last instruction, so it's okay to overwrite
+     * HF_TF_MASK; the next TB will start with the flag set.
+     *
      * DISAS_EOB_INHIBIT_IRQ is a superset of DISAS_EOB_NEXT which
      * might have been set above.
      */
     if (inhibit_irq) {
         s->base.is_jmp = DISAS_EOB_INHIBIT_IRQ;
+        s->flags &= ~HF_TF_MASK;
     }
 }
 
@@ -2302,7 +2306,7 @@ gen_eob(DisasContext *s, int mode)
     if (mode == DISAS_EOB_RECHECK_TF) {
         gen_helper_rechecking_single_step(tcg_env);
         tcg_gen_exit_tb(NULL, 0);
-    } else if ((s->flags & HF_TF_MASK) && mode != DISAS_EOB_INHIBIT_IRQ) {
+    } else if (s->flags & HF_TF_MASK) {
         gen_helper_single_step(tcg_env);
     } else if (mode == DISAS_JUMP &&
                /* give irqs a chance to happen */
-- 
2.49.0


