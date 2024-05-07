Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69270C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IUj-0004ha-82; Tue, 07 May 2024 06:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUY-0004dL-Gf
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUV-0002Xf-R4
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715079371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TTSDWefey4CNpvKA0pRT8RJu6RRmn0k32TgSNXrXSrE=;
 b=SBWrwwMvmS8SaCHHNSOSquPPTFQ0lu/qRIglbvqC1Gon+8/4AOU342+YKLKQXnWOLmjaZ/
 DDvvHY1OgFOLx22OrQrADHNho/HK6kS7XKECD/kW1cgkwfT3iGTsddsrdoRL9Ksg8MM/Hm
 ct4pIaCFJyhSfCZVRUZ76qWhK4QIamk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-wzeK0iS-PFqg17ajfZ-G_w-1; Tue, 07 May 2024 06:56:09 -0400
X-MC-Unique: wzeK0iS-PFqg17ajfZ-G_w-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a59a1fe7396so192736166b.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715079367; x=1715684167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TTSDWefey4CNpvKA0pRT8RJu6RRmn0k32TgSNXrXSrE=;
 b=wh9qURmH7ZA7VKdOIzGPL6XsYfCj2vvsfo+jR0an+ZXC5krVBJT6tYFA/e7XTPQ3NI
 BCOnCpyeDGPhE2+R5Gj2fdYXkv0fJntJN9r7+T0P18wqveeO/djwuohPncNxKK4Pwgwf
 rrFAh0V8C5luz+4hERcJ4uyLr5KYSVBA07sVhfcquRjlWjd8zSjX/6mOyJNOsCRegFbQ
 8lHa2CeqgKPZv3ttz2X/eacJCwvA0nNclxQr+K1JxhS/G+uzLvaoGDwFLeM03j+lCjdk
 KukrlgLkYVu5FufoNz4nvdQtv4iHTODbXXg/EV1g5R0ceu0FxANw7t098VMX8EnFd9Wo
 vJww==
X-Gm-Message-State: AOJu0Yyr/A8JD9sBkKBIcNPO6BwiYWutc8qT7trkTWIDMYmLOgfsd7j6
 mlptVnGPIshhRVWSny1IbnuL4hs4lPD61FlYs+Ha5b+ynEKSnzQx6rL/kbI2E0GtlCRwY1ERr/d
 qW3RXPhKjjqbcEqvuvpFKKDGh8n61V/X2HjMsRPJ7JaSbzJJbCgNl1r2ZizzydojaE32Lx5rkUA
 og7u6cAiwfsmLT6g00u0BhrhX96yLfC6avtLsB
X-Received: by 2002:a17:907:7203:b0:a59:c9ce:338a with SMTP id
 dr3-20020a170907720300b00a59c9ce338amr4376522ejc.2.1715079367777; 
 Tue, 07 May 2024 03:56:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVA8CFEe5rZfrrCQT6cu+kRvR32cvE7Id4380iswLr5k/P1O+NljgIWYVY9grhxsPWgtCEYw==
X-Received: by 2002:a17:907:7203:b0:a59:c9ce:338a with SMTP id
 dr3-20020a170907720300b00a59c9ce338amr4376514ejc.2.1715079367404; 
 Tue, 07 May 2024 03:56:07 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 ap5-20020a17090735c500b00a59cd3d20dfsm2388678ejc.190.2024.05.07.03.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:56:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 10/26] target/i386: clarify the "reg" argument of functions
 returning CCPrepare
Date: Tue,  7 May 2024 12:55:22 +0200
Message-ID: <20240507105538.180704-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240507105538.180704-1-pbonzini@redhat.com>
References: <20240507105538.180704-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index dae9553fcaa..8e0289ca414 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -937,7 +937,7 @@ static CCPrepare gen_prepare_sign_nz(TCGv src, MemOp size)
     }
 }
 
-/* compute eflags.C to reg */
+/* compute eflags.C, trying to store it in reg if not NULL */
 static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 {
     MemOp size;
@@ -1008,7 +1008,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
     }
 }
 
-/* compute eflags.P to reg */
+/* compute eflags.P, trying to store it in reg if not NULL */
 static CCPrepare gen_prepare_eflags_p(DisasContext *s, TCGv reg)
 {
     gen_compute_eflags(s);
@@ -1016,7 +1016,7 @@ static CCPrepare gen_prepare_eflags_p(DisasContext *s, TCGv reg)
                          .imm = CC_P };
 }
 
-/* compute eflags.S to reg */
+/* compute eflags.S, trying to store it in reg if not NULL */
 static CCPrepare gen_prepare_eflags_s(DisasContext *s, TCGv reg)
 {
     switch (s->cc_op) {
@@ -1040,7 +1040,7 @@ static CCPrepare gen_prepare_eflags_s(DisasContext *s, TCGv reg)
     }
 }
 
-/* compute eflags.O to reg */
+/* compute eflags.O, trying to store it in reg if not NULL */
 static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
 {
     switch (s->cc_op) {
@@ -1060,7 +1060,7 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
     }
 }
 
-/* compute eflags.Z to reg */
+/* compute eflags.Z, trying to store it in reg if not NULL */
 static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
 {
     switch (s->cc_op) {
@@ -1090,8 +1090,9 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
     }
 }
 
-/* perform a conditional store into register 'reg' according to jump opcode
-   value 'b'. In the fast case, T0 is guaranteed not to be used. */
+/* return how to compute jump opcode 'b'.  'reg' can be clobbered
+ * if needed; it may be used for CCPrepare.reg if that will
+ * provide more freedom in the translation of a subsequent setcond. */
 static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
 {
     int inv, jcc_op, cond;
-- 
2.45.0


