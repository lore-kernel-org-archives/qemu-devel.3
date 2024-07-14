Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC0DC3DA42
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 11:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSx8F-0004rI-K1; Sun, 14 Jul 2024 07:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sSx8D-0004jn-NK
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 07:11:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sSx8B-00024t-Rh
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 07:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720955463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NHF1gm359CBBwWB+U+NepPClCcmLSyfmhAFVt5pGW6Y=;
 b=dS8rlbBJbYCJhAJlpDc7AAtgHW9B9pgHYCe5Hnd79nj8/cW64UlT6x81kdHTRDhuWCk/mu
 wNOmEkf490xu+cyUqUZSvwoXcw5JMUssVcn5GtagZhL68X5OYMDIh1Xas8Lx/MS1VhEgYM
 N4rGvdOr5pOKG/SecZI0y4vvmHBRz8g=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-lg_RJDVZOYyfO76hrS54ew-1; Sun, 14 Jul 2024 07:10:59 -0400
X-MC-Unique: lg_RJDVZOYyfO76hrS54ew-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52e9557e312so2846254e87.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 04:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720955457; x=1721560257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NHF1gm359CBBwWB+U+NepPClCcmLSyfmhAFVt5pGW6Y=;
 b=TJHbtaek/tpWHGs8ZjoZxH4iERHz/vR7miMPKK+Fz3FS5bNmaEA/SWlA3u4f96CBSc
 /ZOVMiRhRPoXB4EYYKkvZXB6KjZ3a/5VlkLKAlseuQXFlP5+lqlkdJ9ybr06vUtgMWtA
 vnFaU78ogj6KhkSX6pjh7X4UzcBtKKbWZYHfY7B5AEDpSd0K+/+MxrI+tBhsv8BYchnh
 PUFrqh8B7lFJKII9m4LjZqFZWhLLQBFHW69wN2PU14uCV/pFKInyzA4wSj0KNnUH6pbO
 oWenwdJji9fcUBlNUdXm1xVJTFD1eWxRAh/M5ogWbLpZCgFCYZQtIZisdZf31hMMKWec
 xF3g==
X-Gm-Message-State: AOJu0YwacTc6dijg/Gmh4UZPuG9ubwvyp7WcA+tKUzgAtq/Zbqh5xijG
 DtIV2Y5MzdCpM6cBY4njbJQ7jqcFm2B9S2I32bcakOOgRYhCHE1KXAmH4+jElnT0FBSb0Umxbmm
 olUVxCruYFU/hQYxhuxihMDEwUTRvqFJ/7UEyOu77MgM+ohUelVz5oPsIAi5churWqT9XbGT+7i
 uWfNwore6zegef4MLqMjpVlH5qxMZ+v8ME269W
X-Received: by 2002:a05:6512:3190:b0:52e:9d2c:1c86 with SMTP id
 2adb3069b0e04-52eb99919d4mr11654869e87.14.1720955457076; 
 Sun, 14 Jul 2024 04:10:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAC2FrOfxaBWqMfb++97pDakzVdKoq5QQeZCMbChpJdD8Y5lHH0b6WxGktj2Tqooz+BmUc1A==
X-Received: by 2002:a05:6512:3190:b0:52e:9d2c:1c86 with SMTP id
 2adb3069b0e04-52eb99919d4mr11654854e87.14.1720955456434; 
 Sun, 14 Jul 2024 04:10:56 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5e8e2ecsm48502945e9.21.2024.07.14.04.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jul 2024 04:10:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/13] target/i386/tcg: use PUSHL/PUSHW for error code
Date: Sun, 14 Jul 2024 13:10:34 +0200
Message-ID: <20240714111043.14132-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240714111043.14132-1-pbonzini@redhat.com>
References: <20240714111043.14132-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


