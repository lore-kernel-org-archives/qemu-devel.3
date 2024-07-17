Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EB7C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 05:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTwpv-0001zM-OH; Wed, 17 Jul 2024 01:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpo-0001mS-7D
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:04:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpm-00022W-Mv
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721192650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NHF1gm359CBBwWB+U+NepPClCcmLSyfmhAFVt5pGW6Y=;
 b=a+a6X/RBWIikZdpYHuwJ9eSSSS69Gr+ynK3x8MFDwS90+rG3W6DXty8oKvSCDPIAz8ZlXX
 vmhP1GRZ7ZGTGdLg8YZcJdECgB51vDE1BrTXFJCPQB6UGBy3nTYlWUPKycvFdTlupF5a8o
 fl/KxlO2RstQLOrdULHdAbNWw9inMpI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-5eqt7j0INRW4H9xh6ct6kA-1; Wed, 17 Jul 2024 01:04:07 -0400
X-MC-Unique: 5eqt7j0INRW4H9xh6ct6kA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-426724679f0so1650625e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 22:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721192645; x=1721797445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NHF1gm359CBBwWB+U+NepPClCcmLSyfmhAFVt5pGW6Y=;
 b=l/7/iuA4E05NIsOifZOcoozlGNl2j5dzAj4JfCbXmTI1oymo7EW60qKh1MufusJKfU
 DWwfrP5cCCAB2NJ3/eTI25PjrxAnKEtpsKrJyAu1RCJGlxFhYXDT90yYfswcwDIgGZod
 +O+hRZiGx959woJyd+3AA84XDmbOmti+tDmTSuF5OtoIY0J2LIa+lnxjuI5m+dzTRI/Q
 h7Gyf3s+lHTYN21bt11zwbPdTJp3GjcatzLvcaTIIYR7aD4sB+r+RmHvMhF2kXQa3ouP
 GOhXvn4gRttBG375INl0NSFgr1WGFEVAi3JiP0BkKDKSEgEZCkkwQBkhTXpegrvuG7RK
 9PnQ==
X-Gm-Message-State: AOJu0Yy1PuoFbI6bj/ZHZljzOwZFSdg8I9ZpyUujcQ9LLxHfmCPXgjjh
 hKlcKYr7Kd6+k1gYN6tW9JyCHzC6Z12EW5UVed5e2rL90jEF2GxXKL3md30WxANx4EfJaOzwd/h
 0KdgVPXpupQujC0aC4ViIL1jDD41vFbe8ce9A7qggKGPkjq4HnIcjNG1mn2taZFGMAxD1cMNxQ2
 JpOqY7y1OgtDWtgZKlm2XsPjrvar31Rj+2vzqW
X-Received: by 2002:a05:600c:3501:b0:426:6252:61d9 with SMTP id
 5b1f17b1804b1-427bb6c3468mr25812915e9.11.1721192645699; 
 Tue, 16 Jul 2024 22:04:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbxkbEvd4RtiGQkzRN+KjisgQ8KAV5NOWS34YQPAuPO7RBm6Pp8zYYZ3gfbsW5eTQmnyLgpQ==
X-Received: by 2002:a05:600c:3501:b0:426:6252:61d9 with SMTP id
 5b1f17b1804b1-427bb6c3468mr25812825e9.11.1721192645386; 
 Tue, 16 Jul 2024 22:04:05 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbe7csm10688685f8f.83.2024.07.16.22.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 22:04:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/20] target/i386/tcg: use PUSHL/PUSHW for error code
Date: Wed, 17 Jul 2024 07:03:24 +0200
Message-ID: <20240717050331.295371-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717050331.295371-1-pbonzini@redhat.com>
References: <20240717050331.295371-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Do not pre-decrement esp, let the macros subtract the appropriate
operand size.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 224e73e9ed0..b985382d704 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -670,22 +670,20 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
         }
         shift = switch_tss(env, intno * 8, e1, e2, SWITCH_TSS_CALL, old_eip);
         if (has_error_code) {
-            uint32_t mask;
-
             /* push the error code */
             if (env->segs[R_SS].flags & DESC_B_MASK) {
-                mask = 0xffffffff;
+                sp_mask = 0xffffffff;
             } else {
-                mask = 0xffff;
+                sp_mask = 0xffff;
             }
-            esp = (env->regs[R_ESP] - (2 << shift)) & mask;
-            ssp = env->segs[R_SS].base + esp;
+            esp = env->regs[R_ESP];
+            ssp = env->segs[R_SS].base;
             if (shift) {
-                cpu_stl_kernel(env, ssp, error_code);
+                PUSHL(ssp, esp, sp_mask, error_code);
             } else {
-                cpu_stw_kernel(env, ssp, error_code);
+                PUSHW(ssp, esp, sp_mask, error_code);
             }
-            SET_ESP(esp, mask);
+            SET_ESP(esp, sp_mask);
         }
         return;
     }
-- 
2.45.2


