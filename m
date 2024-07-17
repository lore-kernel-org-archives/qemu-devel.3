Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CB9C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 05:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTwqB-00030J-2j; Wed, 17 Jul 2024 01:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpm-0001ha-UO
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:04:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpj-00020b-8A
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721192645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zysmERLOD7LqFn2JG/XTo8hRSGrS1y0PB/cgSbGIed8=;
 b=FxTUQAjZNwVigzM7Vxu6NRxzxhHbwtl3CpiZJVrLg4xMUD84hGEoLClvHLd6CXJjauYezr
 Y6QdVD1dfmrdXrNuWy3TmZSoWvlF01KTSMMStWnr2pZG5ZGi63jAGWEroqBlZhiiyobiIj
 6pTldE5BEZ7IG/Vem9HaZH+heSAeQQg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-sZJdK71PNhGR5_K67R6Pbw-1; Wed, 17 Jul 2024 01:04:03 -0400
X-MC-Unique: sZJdK71PNhGR5_K67R6Pbw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-426d0bead0aso46484945e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 22:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721192642; x=1721797442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zysmERLOD7LqFn2JG/XTo8hRSGrS1y0PB/cgSbGIed8=;
 b=ghUCFQNlZUqxFbi7YQw1pEYT8KE0Kk7b5F1l6WepDjS4VGPSUMkRmu/pg9g74UzwVu
 GhQZNWe5ItV3B3YuIt58vv1xkt77oaTmq/U2v7JNftvkjFva2vQxDf5Fqmd8Lg5YhJJp
 gxcVJdwxQUBHZX370zaXHYjnnNBCXzC/oCEz5Foq99JrytvOcCaG1xFAjVDK+nRoRt1F
 E/0piJ/darAAKsgf8BqW1sBvPOtNoQ0Xy4NY/xLF1GRbwWajlUC7EVdJmrFNrq5WNSTg
 dSjCYMoXV0TAp22ZLtMH/QO9KtRvQsa+aOpXAcliZIXV2BkEHkOV0nQu2WPYqbjdcFm3
 Ko+A==
X-Gm-Message-State: AOJu0YzeBgCTKYqX5PSSgOWgrmTrpZfLp32NJfJ7nlCbkKW6+Rc8MWKk
 EHgmFuRYslJ/5+CphwS4NzfhCom+wVzdU7ouNYoorgDQFFD2urIFqaRPT5akbTmFsyMOrm8R0WW
 mNZhSbgjGJ6IorcAkQedpSnJQgPpmjyzzXA2AIpXoqzRPt8tXQRMBgSDrn5xHiVK2Q6YFtUSWKg
 Z4tHT88EW7Dabrkdys6rVArdF4++LkrK74onpC
X-Received: by 2002:a05:600c:b8e:b0:426:6edf:6597 with SMTP id
 5b1f17b1804b1-427c2cb563bmr2989595e9.19.1721192642354; 
 Tue, 16 Jul 2024 22:04:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8M2wlTqxVCxVolKnlhAe9gOdS0ZCl7n9PZPaMlm8ykk7/w7WhcFj4y4iCaR4irQpTJHZRgA==
X-Received: by 2002:a05:600c:b8e:b0:426:6edf:6597 with SMTP id
 5b1f17b1804b1-427c2cb563bmr2989395e9.19.1721192641979; 
 Tue, 16 Jul 2024 22:04:01 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427bb99a23dsm37140505e9.1.2024.07.16.22.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 22:04:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/20] target/i386/tcg: Remove SEG_ADDL
Date: Wed, 17 Jul 2024 07:03:22 +0200
Message-ID: <20240717050331.295371-13-pbonzini@redhat.com>
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

From: Richard Henderson <richard.henderson@linaro.org>

This truncation is now handled by MMU_*32_IDX.  The introduction of
MMU_*32_IDX in fact applied correct 32-bit wraparound to 16-bit accesses
with a high segment base (e.g.  big real mode or vm86 mode), which did
not use SEG_ADDL.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20240617161210.4639-3-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index aee3d19f29b..19d6b41a589 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -579,10 +579,6 @@ int exception_has_error_code(int intno)
     } while (0)
 #endif
 
-/* in 64-bit machines, this can overflow. So this segment addition macro
- * can be used to trim the value to 32-bit whenever needed */
-#define SEG_ADDL(ssp, sp, sp_mask) ((uint32_t)((ssp) + (sp & (sp_mask))))
-
 /* XXX: add a is_user flag to have proper security support */
 #define PUSHW_RA(ssp, sp, sp_mask, val, ra)                      \
     {                                                            \
@@ -593,7 +589,7 @@ int exception_has_error_code(int intno)
 #define PUSHL_RA(ssp, sp, sp_mask, val, ra)                             \
     {                                                                   \
         sp -= 4;                                                        \
-        cpu_stl_kernel_ra(env, SEG_ADDL(ssp, sp, sp_mask), (uint32_t)(val), ra); \
+        cpu_stl_kernel_ra(env, (ssp) + (sp & (sp_mask)), (val), ra); \
     }
 
 #define POPW_RA(ssp, sp, sp_mask, val, ra)                       \
@@ -604,7 +600,7 @@ int exception_has_error_code(int intno)
 
 #define POPL_RA(ssp, sp, sp_mask, val, ra)                              \
     {                                                                   \
-        val = (uint32_t)cpu_ldl_kernel_ra(env, SEG_ADDL(ssp, sp, sp_mask), ra); \
+        val = (uint32_t)cpu_ldl_kernel_ra(env, (ssp) + (sp & (sp_mask)), ra); \
         sp += 4;                                                        \
     }
 
-- 
2.45.2


