Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E753C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 10:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGuE-0005pM-4k; Fri, 24 Jan 2025 05:27:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGuB-0005p7-Df
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 05:27:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGu9-000180-O0
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 05:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737714428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=L6M9+1mO2prFuonNAkKygGF6aqmKLUzZSktg2cRQ66U=;
 b=VR/FGnkZAkwGu4plkgfJkmHL6XqNOkelMkmVfolwUQ/Z0Ywm5fjGqK90EOu2TIm55/HngT
 jf7WWUhHx8bz3rbgOLF1xDmj09MjO1XsJrMOnmk2bB5c/aklj4Nu0BrvOgN7l3WmZ4pjDQ
 kVr9ILqgIRPe/h4FgK9ovxICojvCiWQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-LUD-XPW1OjGF2lLfM1HlRg-1; Fri, 24 Jan 2025 05:27:06 -0500
X-MC-Unique: LUD-XPW1OjGF2lLfM1HlRg-1
X-Mimecast-MFC-AGG-ID: LUD-XPW1OjGF2lLfM1HlRg
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43628594d34so10564105e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 02:27:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737714424; x=1738319224;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L6M9+1mO2prFuonNAkKygGF6aqmKLUzZSktg2cRQ66U=;
 b=tLgbtEaaEeMtsu1v+hOFZp224UXj6kK4FWZM8gXDFzz7NdCBld+vXu/AzBdhDgl639
 QXnPJN9G59lSV/ykQNFoT8kq1NXsta12ZBjzx8ex+gFRXkKxaojNh4OnonGP3O+ppB0Y
 fcmj20d+xpDLJmnXmX+W9XyW0beqsH32eYgtTwtGdkHvbuN9t+BUlyZAWCy6m8XHc7ve
 syMk33xJ6ZIPtMMb3dad6FBRpikhWue2Syyd1RQymoerD8KaQ6SmzGS1i7JWGEXzUPyU
 8pNH7xKnNcIhyOmgEVdu07imBdEYorCcSe+QYuu97/bLwLIQozPMg0OYMy9ohraBegNs
 i4OQ==
X-Gm-Message-State: AOJu0YxMZSJlxR5SSeJ1VcIP8H2+jzNNvZeKnRj+/0eu6E7xn8ElBwYh
 RzAVf15onp2D6ruqzeyo1G+Q9kFLFt8Tsu8sZ7ecuudXqz3idXBAOYsbJ/nQGkpqrYApSJu8ZIX
 XdM20OyIUJGGRBqdl5+kXL+qMPJNRJpZxAz5yHykOmYlGDCepExgoew9jeYd6S4DXywHX1Sj07q
 R7kwn0RALKXDbot0x/tYahBVN0RaSoFpVdx6LeAMg=
X-Gm-Gg: ASbGncvHkJwT5uaQ352krTpSbFWPr+2rLZwORy4it9D+DjJ+t7Qt1JRikjJ/NLRTWck
 3Kc0iaeDK7FoQjeDxBLa2XSswp+6ptaGc4pbLd2Nuxwrq8QxltbxXti+EOcxwQ5LWqxZB0gLa28
 8fYkBaeSkiOBn9o/W/4ytcHj1Gt4c2wF3qdrt3gMji3Bj4MO31rYxk9Wp9n56x4njQMmEIQH4TE
 xeF5Hr4NIMqB2EX28X/hek4CT1M+Oyb6lGDbldkFPg5iWBjwhE9KulakmKMBrI6x9CyZ/fn
X-Received: by 2002:a05:600c:4fc1:b0:437:c3a1:5fe7 with SMTP id
 5b1f17b1804b1-438914340a4mr244288075e9.20.1737714424209; 
 Fri, 24 Jan 2025 02:27:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPj8DKVCPV4seAiQQDq0hoLYJe2hprURwyWt500BtvcPBO7TATGgpLW2sVdb7yZaVkZnvvRA==
X-Received: by 2002:a05:600c:4fc1:b0:437:c3a1:5fe7 with SMTP id
 5b1f17b1804b1-438914340a4mr244287795e9.20.1737714423811; 
 Fri, 24 Jan 2025 02:27:03 -0800 (PST)
Received: from [192.168.10.3] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa57csm22147675e9.4.2025.01.24.02.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 02:27:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2] tcg/optimize: optimize TSTNE using smask and zmask
Date: Fri, 24 Jan 2025 11:27:01 +0100
Message-ID: <20250124102701.225307-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 tcg/optimize.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index c23f0d13929..a509acf53fe 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -112,6 +112,13 @@ static inline bool arg_is_const_val(TCGArg arg, uint64_t val)
     return ts_is_const_val(arg_temp(arg), val);
 }
 
+/* Calculate all the copies of the sign bit, both redundant and not. */
+static inline uint64_t all_sign_bit_copies(TCGType type, TempOptInfo *info)
+{
+    int64_t sign_bit = type == TCG_TYPE_I32 ? (int64_t)INT32_MIN : INT64_MIN;
+    return (info->s_mask >> 1) | sign_bit;
+}
+
 static inline bool ts_is_copy(TCGTemp *ts)
 {
     return ts_info(ts)->next_copy != ts;
@@ -765,6 +772,7 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
                                      TCGArg *p1, TCGArg *p2, TCGArg *pcond)
 {
     TCGCond cond;
+    TempOptInfo *i1;
     bool swap;
     int r;
 
@@ -782,19 +790,22 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
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
+    if (arg_is_const(*p2) &&
+        (arg_info(*p2)->val & ~all_sign_bit_copies(ctx->type, i1)) == 0) {
         *p2 = arg_new_constant(ctx, 0);
         *pcond = tcg_tst_ltge_cond(cond);
         return -1;
-- 
2.48.1


