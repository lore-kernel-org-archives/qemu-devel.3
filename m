Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5909CC38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 06:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRQpk-0008IX-TB; Wed, 10 Jul 2024 02:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRQpe-0008Ck-TN
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:29:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRQpd-0000uH-JJ
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720592975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zBopGb3I4tvZn2JXrJrqL6k5ycPUsXCyJFN5LtfkPpk=;
 b=SKpHaBSMFM1/cVYvFPQVE4KilrkV6KRX3Q+s2Zwsu08Dfjkn0NXsvrnDH/WqwmH7RFTrwV
 N2J+8JefasQOYoHxL1P7lypqJzQZfYJyn6hQlc37D2yiB5fDX7pYpD1O957WeMfqSvLcRX
 6ECftZM45NK6OR/1iDoKp/pYRjNRF6s=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-_KavTdJJNj2KBBVnNmUIAg-1; Wed, 10 Jul 2024 02:29:33 -0400
X-MC-Unique: _KavTdJJNj2KBBVnNmUIAg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52e98c1a9d2so4737300e87.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 23:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720592971; x=1721197771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zBopGb3I4tvZn2JXrJrqL6k5ycPUsXCyJFN5LtfkPpk=;
 b=E0WK295omD22whFJJkYb9s4aUPSsFBMmD5XaUxx9YBULDhf5r/IzqB0Wzh+W3tyXtX
 ZJmtqFgxNOYPYh12arNMnihxnzxtTfh4zhNy0lVqV1Th0xXajK10ezgj0DOh/0giJHPG
 FKsSL8RUoAydlevw38dxs4x9OsDd+QLeet6PYgrCfZacgsITU3Fufe27AGBa8QZQV1rK
 fTZR2gWVGtjKNx/bsOjuImbB77P7rM9J7RWiB82U4+WdJoWVYuoHJ85KsFZURpNi1xxN
 wzUgvFW+9bWKFS2upVkwQTyvRcN5ZbxhSixdRL7e4hJeNC60ANOBvJzSkzUuL7ub0izP
 Fa5g==
X-Gm-Message-State: AOJu0YyVGljlw/oPkpGE/FQCT+xorqgni39OcMzrxEQTvitoql8PU0Cm
 QFYTGfm5IFU9bSfC3expBIvbViyV212Qm96bdJp8kZAIHAHXxnZiA7HcXDm53XrZqjV+GTG5bfW
 Lc8P5WT2ndx0tECeJh8046Y8u2GlUrRs3E6CPomSvd93+AwF2vNH4NHHfgeFZAXojr893wMxcDt
 sIPBKxZvVngoXDbT1TyVRexMhVrjqcD4MFG80U
X-Received: by 2002:a19:8c05:0:b0:52c:d9f8:b033 with SMTP id
 2adb3069b0e04-52eb9991345mr2292209e87.3.1720592971078; 
 Tue, 09 Jul 2024 23:29:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLiFVy8ngJbKuOXsc/arS/wjhOAhc/TxReXVbh7N3dFsEbiVyyVT2M57apZNpoD32KrtYF8w==
X-Received: by 2002:a19:8c05:0:b0:52c:d9f8:b033 with SMTP id
 2adb3069b0e04-52eb9991345mr2292198e87.3.1720592970638; 
 Tue, 09 Jul 2024 23:29:30 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266e6478d7sm86316955e9.31.2024.07.09.23.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 23:29:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: rrh.henry@gmail.com,
	richard.henderson@linaro.org
Subject: [PATCH 03/10] target/i386/tcg: use PUSHL/PUSHW for error code
Date: Wed, 10 Jul 2024 08:29:13 +0200
Message-ID: <20240710062920.73063-4-pbonzini@redhat.com>
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

Do not pre-decrement esp, let the macros subtract the appropriate
operand size.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 4977a5f5b3a..0653bc10936 100644
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


