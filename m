Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6400EC3DA42
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 11:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSx8A-0004XF-Ap; Sun, 14 Jul 2024 07:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sSx89-0004Vq-D4
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 07:11:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sSx86-00023k-L6
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 07:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720955458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GX5s7D3GnRktYpy0eRl8MIaqx1kf57JyUnrHen/Omzg=;
 b=CRoiTtzZXwbA9Ie31ojRgTopxvdcpQOtboIyX4HkV9bO59rz2avS5Bb7BjZ4HI3jKemgw8
 1yhKd41ZYtGBFTVLGDjPq83qlOkO85r5oFQOkrC9Ms/p6rh9WL1kRHvyoC5l11m4QpPiD2
 C+A2rYnspnix7ADsmESVZ3g1O3jOdRU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-fDWma3bOOuKVUxiemL12PQ-1; Sun, 14 Jul 2024 07:10:56 -0400
X-MC-Unique: fDWma3bOOuKVUxiemL12PQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3679ed08797so2247264f8f.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 04:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720955454; x=1721560254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GX5s7D3GnRktYpy0eRl8MIaqx1kf57JyUnrHen/Omzg=;
 b=rKE3ado4pXKBawE0hpYGpJVXbNEwE5Ddq7EciH8l7fXY5sqhKgZLSm1ryIM2IsGsk+
 XPlH2s9w20GJXVEpmy9zYvw2JiTawenoWqOevCgo/umsCV9FWvrVG9kwem4WuRA8WanX
 3Mghps8cF0mkqQVG8Jf13AWnkd4iohq6R7I/+hBjRtyBY2TGeTsXOo70rqCOD2lDwCmA
 loszEmkFJWX4wi4/OLExFncY6hCgdGUvZZ7lAqXL9y4+VzuWO1FIHUaG4W/qrDJlQ4NY
 ET0g2FFF0Hu02R7LMe/i0U8F1u26qyrWz7N2DU4+4hDm/f80hg+df/xHTai7Y6g3mhyO
 1Q6g==
X-Gm-Message-State: AOJu0YxgQtPw2fYrk3mPvYCd+jxD5ibYygx1nztP7AJmhlq3xLM2Hwk2
 Mbq0hWaawzeHV4Csx5X+jgc1IPbtMQcYURX14Mz3DGhE4XVjBaoVDDn25GMq7tcFAVDdkIrlh2W
 FjZ34oIfmT3MRQb6AQpd2efPgmrKhcE1LefbVtKE0XpCBe212fyrV06VSm8swjIfb4DGA50qer8
 ud85eOi+7/oZfmrQ7p2a+ps7Sn4zKjjLeEax1n
X-Received: by 2002:a5d:4445:0:b0:367:96bd:1277 with SMTP id
 ffacd0b85a97d-367ceac49a2mr10402784f8f.44.1720955454164; 
 Sun, 14 Jul 2024 04:10:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEli0xKWvsapGjFBW0z7G0RIf5GFlcrgiKNZ6QVwIlXlmjQyTVJYmERSJhK/TCD8iaTU3TqBA==
X-Received: by 2002:a5d:4445:0:b0:367:96bd:1277 with SMTP id
 ffacd0b85a97d-367ceac49a2mr10402775f8f.44.1720955453762; 
 Sun, 14 Jul 2024 04:10:53 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dab3e71sm3575599f8f.12.2024.07.14.04.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jul 2024 04:10:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Robert R . Henry" <rrh.henry@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/13] target/i386/tcg: Allow IRET from user mode to user mode
 with SMAP
Date: Sun, 14 Jul 2024 13:10:33 +0200
Message-ID: <20240714111043.14132-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240714111043.14132-1-pbonzini@redhat.com>
References: <20240714111043.14132-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
the IRET instruction was always returning from kernel mode to either
kernel mode or user mode. This assumption is violated when IRET is used
as a clever way to restore thread state, as for example in the dotnet
runtime. There, IRET returns from user mode to user mode.

This bug is that stack accesses from IRET and RETF, as well as accesses
to the parameters in a call gate, are normal data accesses using the
current CPL.  This manifested itself as a page fault in the guest Linux
kernel due to SMAP preventing the access.

This bug appears to have been in QEMU since the beginning.

Analyzed-by: Robert R. Henry <rrh.henry@gmail.com>
Co-developed-by: Robert R. Henry <rrh.henry@gmail.com>
Signed-off-by: Robert R. Henry <rrh.henry@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 19d6b41a589..224e73e9ed0 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -594,13 +594,13 @@ int exception_has_error_code(int intno)
 
 #define POPW_RA(ssp, sp, sp_mask, val, ra)                       \
     {                                                            \
-        val = cpu_lduw_kernel_ra(env, (ssp) + (sp & (sp_mask)), ra); \
+        val = cpu_lduw_data_ra(env, (ssp) + (sp & (sp_mask)), ra); \
         sp += 2;                                                 \
     }
 
 #define POPL_RA(ssp, sp, sp_mask, val, ra)                              \
     {                                                                   \
-        val = (uint32_t)cpu_ldl_kernel_ra(env, (ssp) + (sp & (sp_mask)), ra); \
+        val = (uint32_t)cpu_ldl_data_ra(env, (ssp) + (sp & (sp_mask)), ra); \
         sp += 4;                                                        \
     }
 
@@ -847,7 +847,7 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
 
 #define POPQ_RA(sp, val, ra)                    \
     {                                           \
-        val = cpu_ldq_kernel_ra(env, sp, ra);   \
+        val = cpu_ldq_data_ra(env, sp, ra);   \
         sp += 8;                                \
     }
 
@@ -1797,18 +1797,18 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
                 PUSHL_RA(ssp, sp, sp_mask, env->segs[R_SS].selector, GETPC());
                 PUSHL_RA(ssp, sp, sp_mask, env->regs[R_ESP], GETPC());
                 for (i = param_count - 1; i >= 0; i--) {
-                    val = cpu_ldl_kernel_ra(env, old_ssp +
-                                            ((env->regs[R_ESP] + i * 4) &
-                                             old_sp_mask), GETPC());
+                    val = cpu_ldl_data_ra(env,
+                                          old_ssp + ((env->regs[R_ESP] + i * 4) & old_sp_mask),
+                                          GETPC());
                     PUSHL_RA(ssp, sp, sp_mask, val, GETPC());
                 }
             } else {
                 PUSHW_RA(ssp, sp, sp_mask, env->segs[R_SS].selector, GETPC());
                 PUSHW_RA(ssp, sp, sp_mask, env->regs[R_ESP], GETPC());
                 for (i = param_count - 1; i >= 0; i--) {
-                    val = cpu_lduw_kernel_ra(env, old_ssp +
-                                             ((env->regs[R_ESP] + i * 2) &
-                                              old_sp_mask), GETPC());
+                    val = cpu_lduw_data_ra(env,
+                                           old_ssp + ((env->regs[R_ESP] + i * 2) & old_sp_mask),
+                                           GETPC());
                     PUSHW_RA(ssp, sp, sp_mask, val, GETPC());
                 }
             }
-- 
2.45.2


