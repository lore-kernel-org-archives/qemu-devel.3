Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8007DC54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfHrD-0004jU-VU; Wed, 28 Feb 2024 06:12:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfHrC-0004j0-Iv
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:12:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfHr9-0003xz-SU
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709118731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E4xniBqKVQ8epVCqI0n5qgziT3RjBUH01hHZILRtuQM=;
 b=YDB7MW142+6ShxEOQTQtfwdjTWs/Ti0u2C/NAmLlNAYnj4shUF6tifpXPa8tGy3cPBhyFh
 g5w96vezjDGp8vMSxk+pBXK/jIQBe5vSOzILfLLS+VEm2SjbictOl2AdqgJ63whdDhOohQ
 N3cq8AjUKD06XSvDzxCRvugfffo/81M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-BKDMruPXPjqS9qhOl-AnXw-1; Wed, 28 Feb 2024 06:12:09 -0500
X-MC-Unique: BKDMruPXPjqS9qhOl-AnXw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-56544b5af9dso3726982a12.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:12:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709118727; x=1709723527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E4xniBqKVQ8epVCqI0n5qgziT3RjBUH01hHZILRtuQM=;
 b=CzRbn2XUOY+cB3suVabE6fyfZpn/Bxq8NQGYwViCJrxL1PBur1QAB/QIWNe0zFumZ/
 o1f7u3Yw5LmUF3uugrUtxI1KJohS3dPk5NInRSxzlAvabx15/mwDKBzlV4gXzwsK11Sk
 EUc4eE/nUN2gaC+HYnPOdztk2/HUR9NHgNn449zzKrJHyuVeajOB7JQdXPZldeq/bYeE
 fra7+sVFBXE71XVSqWiK8Wy7Saq9JotQEApxT7qUj0jqDceaIsMSwDMnWpd2gQIUSLYh
 BdoZ2yy8UOH8BBU0LVk1Eym3BW1rrqAeZUFSPTM7xNiygaz5doCx1O7mKQtK6CjPF0s6
 fH8Q==
X-Gm-Message-State: AOJu0YwCYO/mEnqFQZOvmPdLGiaEe/b4aicCtj1co4AajQ8oWJbLruxF
 Z0z3XSXQO6hpMBJQVZ34bNUkL1ZzdW4ZUH0iAvL+mMSjt2ABHHhPN+zXZ0Gh0pymbgUrV9JaTii
 /W8Nfziuq/ORJEWfzzrUjS4i/0Ru4Z58wQ49qinbivMX6EfTINhUxfaEHmADji7Xag8a/kXCbCf
 JcRd+ogiJkM25IH26rDfkiIZz6Zp1KEVmLekRK
X-Received: by 2002:aa7:cd42:0:b0:566:de7:ac4a with SMTP id
 v2-20020aa7cd42000000b005660de7ac4amr4813361edw.6.1709118727204; 
 Wed, 28 Feb 2024 03:12:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEk1GerRv+EgQ3vF+yLX9DlBKU8itm9sxU7f9dGpIlfp6ddHG5/sAI8467S73xgq4MWcZJfWQ==
X-Received: by 2002:aa7:cd42:0:b0:566:de7:ac4a with SMTP id
 v2-20020aa7cd42000000b005660de7ac4amr4813348edw.6.1709118726889; 
 Wed, 28 Feb 2024 03:12:06 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 ew15-20020a056402538f00b005667a11b951sm201783edb.86.2024.02.28.03.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 03:12:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 4/4] tcg/optimize: optimize TSTNE using smask and zmask
Date: Wed, 28 Feb 2024 12:11:51 +0100
Message-ID: <20240228111151.287738-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228111151.287738-1-pbonzini@redhat.com>
References: <20240228111151.287738-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This can be useful in some cases when the i386 frontend creates opcodes
that test against 0xff or 0x80.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tcg/optimize.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 752cc5c56b6..ab976a5bbe7 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -793,6 +793,7 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
                                      TCGArg *p1, TCGArg *p2, TCGArg *pcond)
 {
     TCGCond cond;
+    TempOptInfo *i1;
     bool swap;
     int r;
 
@@ -810,19 +811,21 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
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
2.43.2


