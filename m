Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C562DC38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 06:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRQpj-0008Da-Kh; Wed, 10 Jul 2024 02:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRQpb-0008AH-VB
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:29:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRQpZ-0000u4-15
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720592972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rFvMD5cnSal8ruX6+HzjgtU1Y4z0l5Rzbe0xMDe3yYs=;
 b=f1OHI/n+7hy3LMdwo542+6h5ZbXSdwwGQI982QzHecsImEijf+HpDrfE/uNesf5sRtZmvs
 tFCxdAQYZl9G3+Tvgb2vmm0Z764xJji6b56WVfKtH5mYkcZDZkH3PM03kBk6WQFw9dwOkC
 SrcKhYNCA6ydUgC6i+FIVrL1bbLQoJI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-uYbNLWZ7P_KWDNilT74CBQ-1; Wed, 10 Jul 2024 02:29:30 -0400
X-MC-Unique: uYbNLWZ7P_KWDNilT74CBQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42796140873so910255e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 23:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720592968; x=1721197768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rFvMD5cnSal8ruX6+HzjgtU1Y4z0l5Rzbe0xMDe3yYs=;
 b=H9HFKjX4HyAZW5iJt3s3MZKIdp/SsBBSRB+txM2xGEHghU08sD1dvD63d9Qhq+e/Rg
 tE1GalGFMoolKSPpW8lSrnoEPUZeWlfyr07SaWUs/rRpaIOID90zmaSbvY3Or2PJqc7s
 MEK8A8Mxy4ZXZLZXJE5M2rK8438a54cM0CKF8z99zqzgyRkIhGtUyWKX95oasMJLEYfB
 fv8R8nqzkYWXomXfU7kIt8imf1gbcyc3mn8byyzoyYlq8LYfFN3jZQU/w235YlVoFqsT
 cWUqmbzRul+8eqB1ZqnW7apTbSSS+l2kCChxLaF4mBF+D8UUqyAYrGVQzVXodkRBjmvi
 tvqA==
X-Gm-Message-State: AOJu0YzuQqRQ6//mMEotlYySoX4AxAgjA7wdpFKEs4yu2CB9VNQ7GbZ1
 8vnsnfz9BkWt7ckIw4fxCRhFUcqq8AVAPp431nOyw6j8RpiOQem/8kWmLzA8k/mAaWvQRmAK/LY
 9P0yNbcclJIgXxXoXt/TGjApoKbPZ/ugyWqoVtNlctZQSS+YpZ9v2vc2lIz0qCMQk0Sq0Ij+QCs
 1VkWfJr7wTnXHf03teWVCD6iTx33MBCw//Xv9K
X-Received: by 2002:a05:600c:42ca:b0:426:549c:294c with SMTP id
 5b1f17b1804b1-426708fa7d0mr34482505e9.35.1720592968356; 
 Tue, 09 Jul 2024 23:29:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE8k1DQhRvtpZmIhZmJOrkKBCfnvvy0HKySRt3RhkqvTxuaybqE+sr2u9sJ2RPWe+vBuGrRQ==
X-Received: by 2002:a05:600c:42ca:b0:426:549c:294c with SMTP id
 5b1f17b1804b1-426708fa7d0mr34482375e9.35.1720592968095; 
 Tue, 09 Jul 2024 23:29:28 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4267255858asm39484535e9.0.2024.07.09.23.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 23:29:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: rrh.henry@gmail.com,
	richard.henderson@linaro.org
Subject: [PATCH 02/10] target/i386/tcg: Allow IRET from user mode to user mode
 with SMAP
Date: Wed, 10 Jul 2024 08:29:12 +0200
Message-ID: <20240710062920.73063-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710062920.73063-1-pbonzini@redhat.com>
References: <20240710062920.73063-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 19d6b41a589..4977a5f5b3a 100644
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
+					  old_ssp + ((env->regs[R_ESP] + i * 4) & old_sp_mask),
+					  GETPC());
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
+					   old_ssp + ((env->regs[R_ESP] + i * 2) & old_sp_mask),
+					   GETPC());
                     PUSHW_RA(ssp, sp, sp_mask, val, GETPC());
                 }
             }
-- 
2.45.2


