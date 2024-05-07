Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08B8C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IUO-0004W9-Cq; Tue, 07 May 2024 06:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUM-0004TW-KI
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUK-0002K3-MY
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715079360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fKbSH8kRpOPx4Gy5HcgM9terWCl4SkTItkgdxARkYTo=;
 b=OlJhm0P93I9u/YH6M/gQlkw2vB3piqG1wiGVkCzL0H2dxjplS0hlQoqzFdG2dBocnB5s0l
 2qxZ3Xr9zCryO3zVd4YZcd/7YyaDz8HC4FT04W4pB0b9NAscXLzqBSlFqU7znVfRCKnj/S
 2YJz7Bv0HAJ9Zd9BmUzbm3RwE5zBU4I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-6HVQ2nZfPEenso_LcSxs_Q-1; Tue, 07 May 2024 06:55:58 -0400
X-MC-Unique: 6HVQ2nZfPEenso_LcSxs_Q-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59a17f35c8so197006266b.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715079357; x=1715684157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fKbSH8kRpOPx4Gy5HcgM9terWCl4SkTItkgdxARkYTo=;
 b=kkSM9CKBaVv93Eahr9hfdfaohNGdDV/jFaBrOCLEIN25d3o9PcmOiouvCdlxOBT/32
 AHrnUbyzQZGMy+Mv7MP4AWtt22GxLR5/PIlLjKZM2PHULN2tx3LnWUO0drTLyqOkVpVZ
 ktTqUwNRkPCgeu2aIvNQGaptZiSxP3++zNBVheFeXFNGTMVQdC0cBK/ha0ooixfRY8Qr
 Jj3fhuYChhDTHAz7GDJIjAHOX1jUtC4GVS9j8mRi6q5mkUJTHksgrD4vyWmcbydvkErD
 kghYt9No2EVoyeEC2JZU8Yr79MFLDxe4XJWQzdscuRHezyfx4ubNhOXld0aCyHIMjhGK
 lUfg==
X-Gm-Message-State: AOJu0YxDhwNPp5EeGnJNE3SnTNyJ7rdaivfLaJHEQe7CsOKmKgnltMxv
 jN4YSabKJNFg0ESrEKVfWWApieESGCUXd1hvKiGQkJfu0JH0FFaG0MjzkqW6N3Odg266eBpYGQn
 kqwD1FBfwi843VLCsFNoIGvv4XMY4lXZetbiRF+VLHVio5jaSOqCK9Dy35vnvvd3551SKRLd0YJ
 r6594qhKTXS84wIWo74+27MqsT8S2RPj/9Y1+Y
X-Received: by 2002:a17:906:730d:b0:a59:bf27:c3a with SMTP id
 di13-20020a170906730d00b00a59bf270c3amr4983818ejc.71.1715079357152; 
 Tue, 07 May 2024 03:55:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX/nLBWJ3uXc1YrxMUcn4c4WK3VNQkthION/ztGQ11iZIFL7kRBMscUeoGOhRUmKpJHS+TCw==
X-Received: by 2002:a17:906:730d:b0:a59:bf27:c3a with SMTP id
 di13-20020a170906730d00b00a59bf270c3amr4983809ejc.71.1715079356854; 
 Tue, 07 May 2024 03:55:56 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a170906715500b00a599c8b6531sm4830975ejj.178.2024.05.07.03.55.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:55:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/26] target/i386: cleanup cc_op changes for REP/REPZ/REPNZ
Date: Tue,  7 May 2024 12:55:18 +0200
Message-ID: <20240507105538.180704-7-pbonzini@redhat.com>
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

gen_update_cc_op must be called before control flow splits.  Do it
where the jump on ECX!=0 is translated.

On the other hand, remove the call before gen_jcc1, which takes care of
it already, and explain why REPZ/REPNZ need not use CC_OP_DYNAMIC---the
translation block ends before any control-flow-dependent cc_op could
be observed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 3f1d2858fc9..466fee38c0e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1242,11 +1242,15 @@ static inline void gen_jcc1(DisasContext *s, int b, TCGLabel *l1)
 }
 
 /* XXX: does not work with gdbstub "ice" single step - not a
-   serious problem */
+   serious problem.  The caller can jump to the returned label
+   to stop the REP but, if the flags have changed, it has to call
+   gen_update_cc_op before doing so.  */
 static TCGLabel *gen_jz_ecx_string(DisasContext *s)
 {
     TCGLabel *l1 = gen_new_label();
     TCGLabel *l2 = gen_new_label();
+
+    gen_update_cc_op(s);
     gen_op_jnz_ecx(s, l1);
     gen_set_label(l2);
     gen_jmp_rel_csize(s, 0, 1);
@@ -1342,7 +1346,6 @@ static void gen_repz(DisasContext *s, MemOp ot,
                      void (*fn)(DisasContext *s, MemOp ot))
 {
     TCGLabel *l2;
-    gen_update_cc_op(s);
     l2 = gen_jz_ecx_string(s);
     fn(s, ot);
     gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
@@ -1364,15 +1367,18 @@ static void gen_repz2(DisasContext *s, MemOp ot, int nz,
                       void (*fn)(DisasContext *s, MemOp ot))
 {
     TCGLabel *l2;
-    gen_update_cc_op(s);
     l2 = gen_jz_ecx_string(s);
     fn(s, ot);
     gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
-    gen_update_cc_op(s);
     gen_jcc1(s, (JCC_Z << 1) | (nz ^ 1), l2);
     if (s->repz_opt) {
         gen_op_jz_ecx(s, l2);
     }
+    /*
+     * Only one iteration is done at a time, so the translation
+     * block ends unconditionally after this instruction and there
+     * is no control flow junction - no need to set CC_OP_DYNAMIC.
+     */
     gen_jmp_rel_csize(s, -cur_insn_len(s), 0);
 }
 
-- 
2.45.0


