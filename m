Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF3AC7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSeng-0006UK-DE; Fri, 20 Jun 2025 12:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSenf-0006U0-4j
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSend-0000EP-GF
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750437668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aN7xXBZj4Ftx1dfcGboeMP703/cTHxafXoXtiLZOCMM=;
 b=euvtBywRWLfNOPZfz317V1ZRRGCwNhbxNxJX5YsJoHAJwZVAudmNvcqZ+B90X4jwqUqiWe
 V8CHAQ9t9GjMSLwATNGQ9ggCgP+jBvvETgUGHgBcAw4Ddmw0rpQiqnnYrN1dByqEfBCx4v
 zN1SCXcWsn+zumyv0nZFERFzbIst61A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-AR6twZNIMkixfzurSRktig-1; Fri, 20 Jun 2025 12:41:02 -0400
X-MC-Unique: AR6twZNIMkixfzurSRktig-1
X-Mimecast-MFC-AGG-ID: AR6twZNIMkixfzurSRktig_1750437661
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-606f504f228so1769228a12.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750437661; x=1751042461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aN7xXBZj4Ftx1dfcGboeMP703/cTHxafXoXtiLZOCMM=;
 b=cpeLWP6B7croz1avIEySROKNwqX93zH2889BQJlMUIhyygbnpEibtrGxeGIvPtSbfU
 1cMY4pAfO/I4fB/WsUXDQgD5x6vtKAwfVXG9tYXNbItXFGj+z3isDPiLoqNvbSH2VN/9
 wwH4HqWr2+R8FQxDeKR1hYxP5b4QEW7CUbCrFqZRDIfTklR5Ctwpc8Bdj7zT3t0nqAk8
 3rdW0v/GegTLBmxRLJXzbsLzSMrtRzPQnyrwTkxlXcxeOjoCuGvw/smAYA323KET5Xrk
 KIT7955VubNoFjaa8fBOKuz0O4l2P4nOva3byAevUQJIz42KVnNeU0rpWoyTpJIxGNoo
 N/kw==
X-Gm-Message-State: AOJu0YwpSSap0R/z/38QXkCiad9BmF6CoGs1BM9SVL1dgNIgHjAUmQxp
 PHIflWToSw3pXumf57wXvto2S2YWqVu70Q1mLAk6iz3TEU7KsBmOrRxeZiGwE6FEQZNZHxcW6Gf
 VPAMAtd3szKKg7sJafB4xGSje4ozoNWS/kS10w/fPIIJNYTyWpXaKzefOB9wZpBSnQc1TD9sxAg
 cxQ0N8AgFNGVephrB7x3B+QJZJ4oXPaAICc4yGAo/v
X-Gm-Gg: ASbGncsiQHn+nmtNBk1k+271txyqo8Wj2lRww6f2p3+Lu+SRPtY436aWdpH5gcrge4s
 Puiw4llwFOJqv+2kWxNn0bxW3FbEeWAgZmrVBlxXx52oGTLJ0YJTmxWCK+HAvuIfu4HU8sOL77h
 7x5XWJbgPhg1JQzIx6/Z9SIYa4R6zx0uiZDuzwm4SYBb+oIVRjCHqq29IZVnWsNH5EK1OHAzslR
 mBQrToMZ/L67k11B7JnA0oVaCn7fAD6i9yv4yQqFEqt0zeRmkqfdWE1GSFE44h5mH5KnbnGwoaV
 9vsf+AMjc/H5gsqy1fOi7/2VTg==
X-Received: by 2002:a05:6402:34cc:b0:607:35d8:4cf8 with SMTP id
 4fb4d7f45d1cf-60a1ccbc846mr3361886a12.11.1750437660551; 
 Fri, 20 Jun 2025 09:41:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3JFuqE+dcd5fdcKUjRpgdDxKTjtijkxVvb+SPO11XtYAxXv/TItUZ6edJWO0hoyAyQlOheA==
X-Received: by 2002:a05:6402:34cc:b0:607:35d8:4cf8 with SMTP id
 4fb4d7f45d1cf-60a1ccbc846mr3361853a12.11.1750437659917; 
 Fri, 20 Jun 2025 09:40:59 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60a185797bbsm1629935a12.35.2025.06.20.09.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:40:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 02/24] target/i386: fix TB exit logic in gen_movl_seg() when
 writing to SS
Date: Fri, 20 Jun 2025 18:40:30 +0200
Message-ID: <20250620164053.579416-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620164053.579416-1-pbonzini@redhat.com>
References: <20250620164053.579416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Before commit e54ef98c8a ("target/i386: do not trigger IRQ shadow for LSS"), any
write to SS in gen_movl_seg() would cause a TB exit. The changes introduced by
this commit were intended to restrict the DISAS_EOB_INHIBIT_IRQ exit to the case
where inhibit_irq is true, but missed that a DISAS_EOB_NEXT exit can still be
required when writing to SS and inhibit_irq is false.

Comparing the PE(s) && !VM86(s) section with the logic in x86_update_hflags(), we
can see that the DISAS_EOB_NEXT exit is still required for the !CODE32 case when
writing to SS in gen_movl_seg() because any change to the SS flags can affect
hflags. Similarly we can see that the existing CODE32 case is still correct since
a change to any of DS, ES and SS can affect hflags. Finally for the
gen_op_movl_seg_real() case an explicit TB exit is not needed because the segment
register selector does not affect hflags.

Update the logic in gen_movl_seg() so that a write to SS with inhibit_irq set to
false where PE(s) && !VM86(s) will generate a DISAS_EOB_NEXT exit along with the
inline comment. This has the effect of allowing Win98SE to boot in QEMU once
again.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Fixes: e54ef98c8a ("target/i386: do not trigger IRQ shadow for LSS")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2987
Link: https://lore.kernel.org/r/20250611130315.383151-1-mark.cave-ayland@ilande.co.uk
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 0fcddc2ec08..0cb87d02012 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2033,8 +2033,11 @@ static void gen_movl_seg(DisasContext *s, X86Seg seg_reg, TCGv src, bool inhibit
         tcg_gen_trunc_tl_i32(sel, src);
         gen_helper_load_seg(tcg_env, tcg_constant_i32(seg_reg), sel);
 
-        /* For move to DS/ES/SS, the addseg or ss32 flags may change.  */
-        if (CODE32(s) && seg_reg < R_FS) {
+        /*
+         * For moves to SS, the SS32 flag may change. For CODE32 only, changes
+         * to SS, DS and ES may change the ADDSEG flags.
+         */
+        if (seg_reg == R_SS || (CODE32(s) && seg_reg < R_FS)) {
             s->base.is_jmp = DISAS_EOB_NEXT;
         }
     } else {
-- 
2.49.0


