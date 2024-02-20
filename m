Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE21C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLBN-0000uk-1I; Tue, 20 Feb 2024 03:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcLB7-000071-Ps
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:08:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcLB4-0000eF-Tl
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708416513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/khjPBHA3zyoAdbFKlzOsBWuijGKQwfv8ZgRU5hbra8=;
 b=XXKjH/uPS2sUAJrFZSpD8Ai8TE/f8XU/foTZocacmcGoRYHcCfbqSaxNX4rcjxJgX98mAT
 8SMRjrSTLCAmorQUckrl4x0wWOSXmwH/7cH8UK9AHW9WoHOzjIfs5TkGk6EWdIPGJ+7D9e
 Tgxn8tfv1F2tDrMrI0DbfPLK5BUIAk0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-Fipv6RhHPY2yZiuNRe1yKw-1; Tue, 20 Feb 2024 03:08:31 -0500
X-MC-Unique: Fipv6RhHPY2yZiuNRe1yKw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a3bdd99a243so488681666b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:08:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708416510; x=1709021310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/khjPBHA3zyoAdbFKlzOsBWuijGKQwfv8ZgRU5hbra8=;
 b=s8IoPJE2jFvYnGKGF45nARHG05YtIPqL81dgpr/yPAWPmT3gTKWkvHf58xFm8ggwj4
 jNJDryRq8z7VCeooOz94S5IPyO3u4msqUAL2o8CSbck4p093GgdlcxiA0TZ/VLdMTPH2
 uyzb2ElwfUCGLQeLUN2GQOLivqrsGAjiUwXefgcc+yLmpUkUeDjVmpRc3/mFPTqppMf6
 m+aztLI7A7aJpIm0g6J+zM+BL3G0dsrmLNlZf0ht6IJrP7ZzyxckvSHfIDqBs+bdvDui
 hUTuz3ScbfyENr9xTYCCVnKRL4DDVjc7RFoqM5fRsNP99zb/zQYlUos5d5M2NAfP3EVI
 Xckw==
X-Gm-Message-State: AOJu0YzPpt5oYwINVC8Usm1o+v2ZDdy1x/eWMnKd1fXiK1Gh/Rixfghp
 /uoFHPaKBSt34ihiaARAVUXrsv2WxANFff+2p4dRlwdDgSdRzSKUrq1nfMhlrnoOnlmFJ5ff0OD
 PIfLjqMHrct2ttr1hWg/lFJRhKCFPVVfWj8Xfl2rkcmTAYNdkaNlMO55TNT3iYRGw2acq7PN7EK
 omEY2kzr9zIHxWFUWFbg8EF15sDYChd5jVszP9
X-Received: by 2002:a17:906:280c:b0:a3c:2f68:54a9 with SMTP id
 r12-20020a170906280c00b00a3c2f6854a9mr13940809ejc.3.1708416510016; 
 Tue, 20 Feb 2024 00:08:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgOb7dhhDIi7sIWw1avptir0OdlD8gvNp+AQfxDn+jdB3tvD+oeL0cEhv3CDO0GiBWkzXJRA==
X-Received: by 2002:a17:906:280c:b0:a3c:2f68:54a9 with SMTP id
 r12-20020a170906280c00b00a3c2f6854a9mr13940789ejc.3.1708416509649; 
 Tue, 20 Feb 2024 00:08:29 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a170906770c00b00a3df13a4fe0sm3772781ejm.15.2024.02.20.00.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:08:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ziqiao Kong <ziqiaokong@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PULL 15/17] target/i386: Generate an illegal opcode exception on cmp
 instructions with lock prefix
Date: Tue, 20 Feb 2024 09:05:56 +0100
Message-ID: <20240220080558.365903-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220080558.365903-1-pbonzini@redhat.com>
References: <20240220080558.365903-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ziqiao Kong <ziqiaokong@gmail.com>

target/i386: As specified by Intel Manual Vol2 3-180, cmp instructions
are not allowed to have lock prefix and a `UD` should be raised. Without
this patch, s1->T0 will be uninitialized and used in the case OP_CMPL.

Signed-off-by: Ziqiao Kong <ziqiaokong@gmail.com>
Message-ID: <20240215095015.570748-2-ziqiaokong@gmail.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 10cba162566..07f642dc9e9 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1507,12 +1507,13 @@ static bool check_iopl(DisasContext *s)
 /* if d == OR_TMP0, it means memory operand (address in A0) */
 static void gen_op(DisasContext *s1, int op, MemOp ot, int d)
 {
+    /* Invalid lock prefix when destination is not memory or OP_CMPL. */
+    if ((d != OR_TMP0 || op == OP_CMPL) && s1->prefix & PREFIX_LOCK) {
+        gen_illegal_opcode(s1);
+        return;
+    }
+
     if (d != OR_TMP0) {
-        if (s1->prefix & PREFIX_LOCK) {
-            /* Lock prefix when destination is not memory.  */
-            gen_illegal_opcode(s1);
-            return;
-        }
         gen_op_mov_v_reg(s1, ot, s1->T0, d);
     } else if (!(s1->prefix & PREFIX_LOCK)) {
         gen_op_ld_v(s1, ot, s1->T0, s1->A0);
-- 
2.43.0


