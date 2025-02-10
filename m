Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3403C021A2
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thQwi-0002PB-7z; Mon, 10 Feb 2025 05:23:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1thQwg-0002Ok-Jc
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:23:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1thQwf-0000N5-65
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739182996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=79wQisxmrG4uGvWqFVzBGJF7Meflxb2NnqvI+vXjWx4=;
 b=RMRRAGNEJMVLwD3Oy/ruJbGYMsyZRo8AhI+bcDHK1MY4RTmBRCfXfqLnLK/rATH3fWew8A
 XMgxvdNSYwf9YzfRXab683gN9PW3OUwoBHoR2UKWz9sui2Zs4xAg1ElXbZhGqZl7b9aEGK
 bcwGGmLLdCBrvah4hBpqLkzjmWGPRuo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-MPZhp_wmOFGnO9yN2j8ywg-1; Mon, 10 Feb 2025 05:23:12 -0500
X-MC-Unique: MPZhp_wmOFGnO9yN2j8ywg-1
X-Mimecast-MFC-AGG-ID: MPZhp_wmOFGnO9yN2j8ywg
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ab77dd2c243so420376066b.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:23:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739182991; x=1739787791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=79wQisxmrG4uGvWqFVzBGJF7Meflxb2NnqvI+vXjWx4=;
 b=WoAL0Y3GEJxH+iqrWi6lieeaT9rXORkzjUXCXpwTVurC33aRRSAM8FjgdSAgScMYEu
 BaPLdkeJXwJXiJz+mf3WiBQGSs+kSg4V1uF5NLS+ANBc/O0sElrWsD0C6xBwCge7DsJV
 oS8DVRALgR4IejwBhAoh9fLquskYR59w9DdSJ4eIESCKGT5Aa87l6FdqRxaEhT4rDFNC
 iHNElhOzwDTuFV/Mp0okroEamUMDFGMMt6wynaX2eLrX9bpUCVo5r9yCuZzFoiL3s2iJ
 n2sq53Ixgj9tPrRkuim+M7CDpgEFyKGrjiil1g3noHiGVuAqbWBDc5FJnQS1HQLd438N
 51VQ==
X-Gm-Message-State: AOJu0YxPhJ2PtHPgc4fsHjURxgmzRNTGr9MButzS6z6llP7ADS4dKdWC
 /jknziBYiW/wWRB1SQHiXCJT/0FCieYy+dchYcvkQGFYcsTWgkngcNMJSNNi7dy8ESUMSwKvayB
 sNuw/FItzEAxeAJJwi4cp6l2qj88qVULQmIbTimQK0LhcB7ajC3J47Twl0gGK6G8u/lIO7g6zdq
 dihf8ZLRYvCiwCDrOv3G74v/nf2Yubg0xB85TsHW8=
X-Gm-Gg: ASbGnculdpSjAIL0AOy6wSH9zSCWN5cFuboDdTxUnju52cdX4RK5McEOmSY2uuSWSEm
 FtR5BLSVICHpmvpiNnnZK1tl2rcy/EXHLTTnB+OPVGZO/c5Fl7v4yq1Slwfkbz0bS8KgwYIx3l/
 fuCBkdPPcugH4g6P/O5C+s7NMFNesebE/d1oIb5aAJl0ciH8f+i2ja7Tjck8ecV0mNVK3LDUicm
 dE1YetkAtIIR3TvKMM3tHlEBtSwRPV+II3u9MobImU23RRvsKts0QFmrpvXybbDn4E8mPVKM3Iu
 YcbZJA==
X-Received: by 2002:a05:6402:3907:b0:5dc:8fb1:d43e with SMTP id
 4fb4d7f45d1cf-5de4501882bmr13983998a12.12.1739182991224; 
 Mon, 10 Feb 2025 02:23:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnXapblXN6zG9dxVW9fDKQHoLxx7wjPdumnzuYNDxDW8D4aEQCO2N+dPprArBnTw1RddiBAg==
X-Received: by 2002:a05:6402:3907:b0:5dc:8fb1:d43e with SMTP id
 4fb4d7f45d1cf-5de4501882bmr13983979a12.12.1739182990673; 
 Mon, 10 Feb 2025 02:23:10 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcf9f6c1d6sm7520534a12.65.2025.02.10.02.23.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 02:23:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 7/9] tcg/optimize: optimize TSTNE using smask and zmask
Date: Mon, 10 Feb 2025 11:22:52 +0100
Message-ID: <20250210102255.2555097-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210102255.2555097-1-pbonzini@redhat.com>
References: <20250210102255.2555097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Generalize the existing optimization of "TSTNE x,sign" and "TSTNE x,-1".
This can be useful for example in the i386 frontend, which will generate
tests of zero-extended registers against 0xffffffff.

Ironically, on x86 hosts this is a very slight pessimization in the very
case it's meant to optimize because

 brcond_i64 cc_dst,$0xffffffff,tsteq,$L1

(test %ebx, %ebx) is 1 byte smaller than

 brcond_i64 cc_dst,$0x0,eq,$L1

(test %rbx, %rbx).  However, in general it is an improvement, especially
if it avoids placing a large immediate in the constant pool.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tcg/optimize.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 8c6303e3afa..bca11cc427b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -766,6 +766,7 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
                                      TCGArg *p1, TCGArg *p2, TCGArg *pcond)
 {
     TCGCond cond;
+    TempOptInfo *i1;
     bool swap;
     int r;
 
@@ -783,19 +784,21 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
         return -1;
     }
 
+    i1 = arg_info(*p1);
+
     /*
      * TSTNE x,x -> NE x,0
-     * TSTNE x,-1 -> NE x,0
+     * TSTNE x,i -> NE x,0 if i includes all nonzero bits of x
      */
-    if (args_are_copies(*p1, *p2) || arg_is_const_val(*p2, -1)) {
+    if (args_are_copies(*p1, *p2) ||
+        (arg_is_const(*p2) && (i1->z_mask & ~arg_info(*p2)->val) == 0)) {
         *p2 = arg_new_constant(ctx, 0);
         *pcond = tcg_tst_eqne_cond(cond);
         return -1;
     }
 
-    /* TSTNE x,sign -> LT x,0 */
-    if (arg_is_const_val(*p2, (ctx->type == TCG_TYPE_I32
-                               ? INT32_MIN : INT64_MIN))) {
+    /* TSTNE x,i -> LT x,0 if i only includes sign bit copies */
+    if (arg_is_const(*p2) && (arg_info(*p2)->val & ~i1->s_mask) == 0) {
         *p2 = arg_new_constant(ctx, 0);
         *pcond = tcg_tst_ltge_cond(cond);
         return -1;
-- 
2.48.1


