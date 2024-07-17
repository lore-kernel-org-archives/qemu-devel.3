Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730E5C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 05:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTwpz-00027Y-Cb; Wed, 17 Jul 2024 01:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpm-0001e6-35
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:04:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpj-00021f-Vi
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721192647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GX5s7D3GnRktYpy0eRl8MIaqx1kf57JyUnrHen/Omzg=;
 b=CIx52k2oCrS3r52uudJ+aaFP+TpyDZPz70TvEyFlYK16jfqPnX+l78YPk1lN04eYhWsLYk
 Mq+2jBo9YSLn5+x6E/GhyAj04nhhh3JGKJs/x3pn5DgfAwDglafo3SGMYJfE8ADT7KomjQ
 QaR9kOyr7VH2dnw5amhQg+fi4Y0D3lo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-5wznoTtOOySEvflGssw6Wg-1; Wed, 17 Jul 2024 01:04:05 -0400
X-MC-Unique: 5wznoTtOOySEvflGssw6Wg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42490ae735dso59278175e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 22:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721192644; x=1721797444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GX5s7D3GnRktYpy0eRl8MIaqx1kf57JyUnrHen/Omzg=;
 b=DgAkjMeV4qeNJesCgzMbStULMcZCIXn9UC3UlKoADCmOiZjV2gdRg4diy18fRdx2Il
 nbUxGWiLjwoCNO48Tz0PwotLgZa00tzQtqXrNfy/l1ZOWmaV+e3VAUZWBs7pIjOVVg9Z
 vN16LyM3fnoujL0M0rDXLygVdJSdfDk4tWU/QJCdyvgBvPnS6Fj4EioFf7Jky3Hg6zkx
 8Pjpagq6MULdgpPwpEjK/CVuiZS1w+X6Oj4DP9zC9j/quMc6rFoujTV9AUn3/Rd+C8FR
 FnvbomPU3DxENdzaAzpTzViuiE+6Wrmow6bjr/HA26RiCcSF75cjMsgDsAkgSBWrFBbx
 BbAg==
X-Gm-Message-State: AOJu0YzRe2Vp+sF2pSmLheIR5ZlpOTBbTUuaQoACVcYecH1reFwhoceQ
 KTO8uQyiZNrFyNie7JNorXmBAA68Shz76GeZTpWGAg+7edtGcp4W3EKzFKCLJIQKElLfp4di+4S
 TCCjvMK7T89PL7cEGQ9xi/t5FffOIPAo+d91uhY6MrcqKUHqJDC5TbwnK1WUW77BC2u+vaCMSfT
 oZaNFBitWQFpGBzTtczRCUKSzrQlXFj65ob7KY
X-Received: by 2002:a05:600c:1d20:b0:426:6ed5:fcb with SMTP id
 5b1f17b1804b1-427c2cad3c2mr4127345e9.4.1721192643737; 
 Tue, 16 Jul 2024 22:04:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBneeN4Xl3hCfzOthJMiVTLnL0lOX5y+PHTBpnSrSZd0JkW0Nlg+W5wuB3v758h+2MSjUQZQ==
X-Received: by 2002:a05:600c:1d20:b0:426:6ed5:fcb with SMTP id
 5b1f17b1804b1-427c2cad3c2mr4127225e9.4.1721192643400; 
 Tue, 16 Jul 2024 22:04:03 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f239883sm191011495e9.10.2024.07.16.22.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 22:04:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Robert R . Henry" <rrh.henry@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/20] target/i386/tcg: Allow IRET from user mode to user mode
 with SMAP
Date: Wed, 17 Jul 2024 07:03:23 +0200
Message-ID: <20240717050331.295371-14-pbonzini@redhat.com>
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


