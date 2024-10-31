Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7F9D767F2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 18:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZNN-0003Wo-0L; Thu, 31 Oct 2024 13:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMY-00028M-B7
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMV-0007QE-Gn
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCxW4W5Jr1whcDjfSn3rolloamsZ3/WYsYQyEHJANZY=;
 b=iyBiINmEFHZu9/MVvDQorw2Aflbv6fRe59b4YJBdSWwGvqf5vy2598xvFh88OfJGkga2M9
 L4XCfoqSds18mqbyglNNjZKjkdXzP1hD9giT0jLCK07LeTCcZk9uK9213OzO8t00h1/dLU
 Z68KcXDqr3lbqA+EyAXjZChj5Uid0gw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-abDQmpooPq-1pwKj56_WQg-1; Thu, 31 Oct 2024 13:53:33 -0400
X-MC-Unique: abDQmpooPq-1pwKj56_WQg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4316e2dde9eso9861075e9.2
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397212; x=1731002012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dCxW4W5Jr1whcDjfSn3rolloamsZ3/WYsYQyEHJANZY=;
 b=gAyCzfvGAMrcz7cDSfZRaAII+vfBhAZDhZl5CvtRXIJlR+48YtPAlR4OuTOvHqG3xV
 C9xQ5wl5JnqyLCcxfQp1eE9hrRM+4udxMO+g1bd6HcY5QJwY1w7vlAGVV2o6qPFv2RUc
 uC7ViDA+V+BY/XaZTMdkQ8Qonku2R5WVogsASTrtddKJSisjbmDLcLrOd7Lgww9sWHfJ
 e1amwbtDSrgvn9iq1RUQEVRdmJxv6qAnfq2ZQPPJbTSncxH70c7iGK1SPfP3H//A2YtV
 D2PO0u/WFYyzvkVWsTFfEOiPrGe8IluOcl3LaVi0kvsNscY7mEsbKWBQvdDaYzLa8Gl8
 lN9w==
X-Gm-Message-State: AOJu0YwF+TQWYhsnOiVRjE3C21OIs3GeOpFAVgoSSKthaIXwPI/EZo/E
 tgNuK7GmaLf6cR5CZv2rLrC6gI5RM3L5Xts/kWx9DBuTDKGZNsDLfiE6i+wI6+hmYPgp+Fg5h0J
 0YkvmeCmAdrO4Enwhg4D05MXjfuLmyASxsfOG8SrF7dWHP8RSGTIUVBzqs6xscdlKaN6/RidBC1
 7VRlBNM+3LteNrr0j1t8RGtB6R90Etf7FYM+pBeDw=
X-Received: by 2002:a05:600c:5486:b0:431:52cc:877a with SMTP id
 5b1f17b1804b1-43283296066mr7632895e9.34.1730397211725; 
 Thu, 31 Oct 2024 10:53:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqrpwzcx3gkkpPpMS/SnHS97MrWCb9p8LuQiSkWxIfxN1vyrsCJdNewjJdZXH9k9hnmoWoDw==
X-Received: by 2002:a05:600c:5486:b0:431:52cc:877a with SMTP id
 5b1f17b1804b1-43283296066mr7632665e9.34.1730397211236; 
 Thu, 31 Oct 2024 10:53:31 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d6852d9sm33714085e9.37.2024.10.31.10.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:53:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 34/49] target/i386: optimize computation of ZF from
 CC_OP_DYNAMIC
Date: Thu, 31 Oct 2024 18:51:58 +0100
Message-ID: <20241031175214.214455-35-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Most uses of CC_OP_DYNAMIC are for CMP/JB/JE or similar sequences.
We can optimize many of them to avoid computation of the flags.
This eliminates both TCG ops to set up the new cc_op, and helper
instructions because evaluating just ZF is much cheaper.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/helper.h        |  1 +
 target/i386/tcg/cc_helper.c | 13 +++++++++++++
 target/i386/tcg/translate.c | 10 +++++++---
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/target/i386/helper.h b/target/i386/helper.h
index eeb8df56eaa..3f67098f11f 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -1,5 +1,6 @@
 DEF_HELPER_FLAGS_4(cc_compute_all, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl, int)
 DEF_HELPER_FLAGS_4(cc_compute_c, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl, int)
+DEF_HELPER_FLAGS_3(cc_compute_nz, TCG_CALL_NO_RWG_SE, tl, tl, tl, int)
 
 DEF_HELPER_3(write_eflags, void, env, tl, i32)
 DEF_HELPER_1(read_eflags, tl, env)
diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
index 40583c04cf9..1b83775a914 100644
--- a/target/i386/tcg/cc_helper.c
+++ b/target/i386/tcg/cc_helper.c
@@ -95,6 +95,19 @@ static target_ulong compute_all_adcox(target_ulong dst, target_ulong src1,
     return (src1 & ~(CC_C | CC_O)) | (dst * CC_C) | (src2 * CC_O);
 }
 
+target_ulong helper_cc_compute_nz(target_ulong dst, target_ulong src1,
+                                  int op)
+{
+    if (CC_OP_HAS_EFLAGS(op)) {
+        return ~src1 & CC_Z;
+    } else {
+        MemOp size = cc_op_size(op);
+        target_ulong mask = MAKE_64BIT_MASK(0, 8 << size);
+
+        return dst & mask;
+    }
+}
+
 target_ulong helper_cc_compute_all(target_ulong dst, target_ulong src1,
                                    target_ulong src2, int op)
 {
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 1a9a2fe709e..5e326ab1aff 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1008,15 +1008,19 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
 static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
 {
     switch (s->cc_op) {
-    case CC_OP_DYNAMIC:
-        gen_compute_eflags(s);
-        /* FALLTHRU */
     case CC_OP_EFLAGS:
     case CC_OP_ADCX:
     case CC_OP_ADOX:
     case CC_OP_ADCOX:
         return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = cpu_cc_src,
                              .imm = CC_Z };
+    case CC_OP_DYNAMIC:
+        gen_update_cc_op(s);
+        if (!reg) {
+            reg = tcg_temp_new();
+        }
+        gen_helper_cc_compute_nz(reg, cpu_cc_dst, cpu_cc_src, cpu_cc_op);
+        return (CCPrepare) { .cond = TCG_COND_EQ, .reg = reg, .imm = 0 };
     default:
         {
             MemOp size = cc_op_size(s->cc_op);
-- 
2.47.0


