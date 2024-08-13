Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F91DC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 17:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sduye-0006xH-RY; Tue, 13 Aug 2024 13:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sduyY-0006Vx-9o
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 13:06:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sduyP-00038B-79
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 13:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723568776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HtuZZEJtTULFZZPJE3He16hpHtco94gG0U5/hl5SQmY=;
 b=a0ntNwS9faLIx2z/MIvyq3wOGOUiupeb9pUvukWVl6ssV6DN7VM4qFTJZVj/zTnfbc/zut
 wBouWMhWoUYu0/VQeNRMgQWU2Je6huYiXejZ/o1aTfVnYp9HADf5vWJihioeGDvlsCJJE9
 b7lOB/7zLcLH5EvLNK6tM8BQdEy3aA4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-4qC13e5zPDeOYU7MPEU9yA-1; Tue, 13 Aug 2024 13:06:15 -0400
X-MC-Unique: 4qC13e5zPDeOYU7MPEU9yA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5a766a51b0dso4662124a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 10:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723568772; x=1724173572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HtuZZEJtTULFZZPJE3He16hpHtco94gG0U5/hl5SQmY=;
 b=WDutkj29O/9tJ27c1Z52eEW8wb/1bKDXpY5LoafaW2YiMuhBRPxHzDNrLyA2E2jDO4
 jJT8PdYZQa+tJjOkVZpy/H+HaVq2ETE7oL2wFQpzOiV2PYh7IXhwZzDgGQJ7rNNGCPLZ
 luWr8CcMoUoBX0PHlXtgwhX5YP6MSWE1cJuhTsorUTxEsR+8fQedKA1HE+UR5hj4uZAb
 HoeBTqPAPUq/uWL+fXGWCxiM0goXTDrR5/qeqWtct3oCbrTdVcgFhpxAHmJPrw3Md2gD
 r/2SX1aqYrTBGNqEKu/ZKpvvpp5rcc0TZzy+QT/z+hhU0Soigpd65yB1WnTOYLDqBfFh
 U+cw==
X-Gm-Message-State: AOJu0YzMBIKf1CGCH8ogbxmsBT8pI3poZD87tJSz4kH5zBse/koNYTJl
 /iX8NW+e1ZM6ukQqGTSM645xZ2HYGGHNIIAeuvNkSs5lkj1ICrzQUFG22CO0XFvk2BMrM7C7SBO
 tQ9CqD7/4ASeBY/tF7lewiWWFuc8tehVZv9igYeJ29bQykiyV81Gk5V4wSfds3/SpcGyUALbmJO
 N4eREB4lP9qiiAzrrIBo7jBdlnQS31lo14vrgy
X-Received: by 2002:a05:6402:42d1:b0:5a3:5218:3f91 with SMTP id
 4fb4d7f45d1cf-5bea1cadcf2mr142082a12.24.1723568772236; 
 Tue, 13 Aug 2024 10:06:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWEI+p9XKYUaVzRx7R4YDk8Ris67+PTxP6sFpaocDfGTlPRq7Jdzaj4RDuATDXjQGvuM4Onw==
X-Received: by 2002:a05:6402:42d1:b0:5a3:5218:3f91 with SMTP id
 4fb4d7f45d1cf-5bea1cadcf2mr142033a12.24.1723568771511; 
 Tue, 13 Aug 2024 10:06:11 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bd1a5e04e1sm3036790a12.77.2024.08.13.10.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 10:06:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/6] target/i386: Assert MMX and XMM registers in range
Date: Tue, 13 Aug 2024 19:05:53 +0200
Message-ID: <20240813170556.104193-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813170556.104193-1-pbonzini@redhat.com>
References: <20240813170556.104193-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

The mmx assert would fire without the fix for #2495.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20240812025844.58956-4-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 016dce81464..22a06897fb7 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -33,8 +33,13 @@
 #define TCG_TARGET_extract_tl_valid     TCG_TARGET_extract_i32_valid
 #endif
 
+#define MMX_OFFSET(reg)                        \
+  ({ assert((reg) >= 0 && (reg) <= 7);         \
+     offsetof(CPUX86State, fpregs[reg].mmx); })
 
-#define ZMM_OFFSET(reg) offsetof(CPUX86State, xmm_regs[reg])
+#define ZMM_OFFSET(reg)                        \
+  ({ assert((reg) >= 0 && (reg) <= 15);        \
+     offsetof(CPUX86State, xmm_regs[reg]); })
 
 typedef void (*SSEFunc_i_ep)(TCGv_i32 val, TCGv_ptr env, TCGv_ptr reg);
 typedef void (*SSEFunc_l_ep)(TCGv_i64 val, TCGv_ptr env, TCGv_ptr reg);
@@ -168,7 +173,7 @@ static int vector_elem_offset(X86DecodedOp *op, MemOp ot, int n)
 static void compute_mmx_offset(X86DecodedOp *op)
 {
     if (!op->has_ea) {
-        op->offset = offsetof(CPUX86State, fpregs[op->n].mmx) + mmx_offset(op->ot);
+        op->offset = MMX_OFFSET(op->n) + mmx_offset(op->ot);
     } else {
         op->offset = offsetof(CPUX86State, mmx_t0) + mmx_offset(op->ot);
     }
-- 
2.46.0


