Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55020C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tR0-0003f0-FV; Mon, 06 May 2024 04:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQT-000358-5p
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQR-0002Ff-Ge
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714983018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JZt3//LtU7c7afN4tIMJeOU+3GiW/awBgXe2na4P58Q=;
 b=PcdEDhyqVUI3bNmyA2gn2ApE1SEnMgXpX75a0RPN15linmpOMGC88V4cWrQnz9Z4m94oH5
 /NwxO6FUhrVboj7pJBh1VbLNTdVc9+hwHG3yqfopcfyD9RTSR+hqCSh4bwIUALzjT1oCqG
 cs/ia72soYHj/O4vKV4sXl9pDqiyqJI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-DoI0OxLgPZOVCN_u4Q3fSA-1; Mon, 06 May 2024 04:10:17 -0400
X-MC-Unique: DoI0OxLgPZOVCN_u4Q3fSA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-572b993d8ffso459762a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 01:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714983015; x=1715587815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JZt3//LtU7c7afN4tIMJeOU+3GiW/awBgXe2na4P58Q=;
 b=VDmvuFYiBwQ5c16c79KRMxe4Q/+0g/8YGnztLH9MJnBM8xhWPoKMOdx4fpbQcDjSyp
 7rcRRwgxJY3EmGRBtF+WT0WiLbdVsHBUWrIDr70U4rEH/70VAmAk8XRcFvoa6XXWoJyC
 YDSVjC8C2gl0xf8R6b1bPv1U9aYBOfULmToqy3w2NBkb1hj2bmH9/+VH1sndNPj4GjMb
 CWXWqSYG2iyyLJXH1FtuJKCwi7u+dKzhjE7kBPoJQp4cqrKJAkdAHAcRDwx1fSXvdRTm
 DVtS1zV5LKQ1Tni/LFCfS1UTmgifoLt2yHTMCRP7eUlsPItSsV+Tao2/eXN+Nh49SwqI
 BeMg==
X-Gm-Message-State: AOJu0Yx6kD+bpbrhy433eWEsp585uPSQaH4XQqIlU51DCSNpEk8sMy53
 mBhyrlnvYcWxcl247Hmzy+z7HxZ3wUjULVL8BPu0gUkD3sqbknBkJaG+/LiTIj+LqrIGsvxqpmB
 7nwO5JakxIYudRLndz0bJM80S5h8FBcFk8u2BUKx/j66EMqkBL2/WkSNaBO2h9IudwXV4eCClrY
 kZn2E6OGBIaYzgmequnbOV0ZlPFFZS4y5vtO0E
X-Received: by 2002:a05:6402:22d7:b0:570:35e:9a09 with SMTP id
 dm23-20020a05640222d700b00570035e9a09mr7551970edb.7.1714983015532; 
 Mon, 06 May 2024 01:10:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi66YCxYNICimuK2yAkJIW/sfeF6+WLeqpWv9m71Kbd0RmmrPg+n6BsB+UhmD3YL48U2c+Jw==
X-Received: by 2002:a05:6402:22d7:b0:570:35e:9a09 with SMTP id
 dm23-20020a05640222d700b00570035e9a09mr7551947edb.7.1714983015032; 
 Mon, 06 May 2024 01:10:15 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 c21-20020aa7df15000000b005727bdb1eafsm4822864edy.40.2024.05.06.01.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 01:10:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	zhao1.liu@intel.com
Subject: [PATCH v2 05/25] target/i386: cleanup cc_op changes for REP/REPZ/REPNZ
Date: Mon,  6 May 2024 10:09:37 +0200
Message-ID: <20240506080957.10005-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506080957.10005-1-pbonzini@redhat.com>
References: <20240506080957.10005-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
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

gen_update_cc_op must be called before control flow splits.  Do it
where the jump on ECX!=0 is translated.

On the other hand, remove the call before gen_jcc1, which takes care of
it already, and explain why REPZ/REPNZ need not use CC_OP_DYNAMIC---the
translation block ends before any control-flow-dependent cc_op could
be observed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 3f1d2858fc9..6b766f5dd3f 100644
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
@@ -1364,11 +1367,13 @@ static void gen_repz2(DisasContext *s, MemOp ot, int nz,
                       void (*fn)(DisasContext *s, MemOp ot))
 {
     TCGLabel *l2;
-    gen_update_cc_op(s);
     l2 = gen_jz_ecx_string(s);
+    /*
+     * Only one iteration is done at a time, so there is
+     * no control flow junction here and cc_op is never dynamic.
+     */
     fn(s, ot);
     gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
-    gen_update_cc_op(s);
     gen_jcc1(s, (JCC_Z << 1) | (nz ^ 1), l2);
     if (s->repz_opt) {
         gen_op_jz_ecx(s, l2);
-- 
2.45.0


