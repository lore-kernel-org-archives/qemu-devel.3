Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10022C25B7A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 11:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sApez-0002L7-Q3; Sat, 25 May 2024 07:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApey-0002Kw-RQ
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApep-0003zY-4N
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716636830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yYmuT/t9cN1cwGnGDJ6cJrCwsqnHZePl9S+Nn7OVFJw=;
 b=JXFpftHyfGEo8jjqOh63eCB2UGxW4zqfEA7TZFHl242r/xVln8rKr5bF98ticCynRb+r+N
 KIFVVdmcFYqB96oH4f6FXyJd+Ra79svdf0dBPgnJqblMASJleN7tgF6PHbttgSAILUS2Pg
 5Ud4gH6HQfhN7WvG6Xc+eBoAZdrHT38=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-pGI4U2_AMSKKBHj6273kzg-1; Sat, 25 May 2024 07:33:48 -0400
X-MC-Unique: pGI4U2_AMSKKBHj6273kzg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57860e2b596so301917a12.3
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 04:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716636826; x=1717241626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yYmuT/t9cN1cwGnGDJ6cJrCwsqnHZePl9S+Nn7OVFJw=;
 b=QloZAZk53aUaKs7nSI7kOzCs4bfV3nU1bdiGmmk6dcn9HuHwVngGOzHPX8PXNiiw3d
 y5uL498VDnzYCx/mZsmi9BOsUWLvLpyX8L/c6WHZeZ29/6w5wQ+eMEYbSzsRKRN3AI+3
 u3oD5CGC/TZdKFaILlHxUVeZJbFihUq2KaSMhX31vwDsQjuDo2KjYmpxvZSiUVl70vhg
 LDtn69jAGVDjw/tN7IlpFAPweEVcpLlVdpxB8Q8E0elpdQr6H6wvp/fyAFx8aWz2d7GH
 tcI+0Q4JE9QqDrnyj8BZNx5vl9QPOwtl8Y/9C2VZvqKNx0OYD7bWtyTrbGDwzO1oHFWX
 jEEg==
X-Gm-Message-State: AOJu0YytdtkCugik09IvV739yssKUNIclUDtSnfD/B6q4+rnAv6A4+cg
 bd5FbEascmodJiH9bzzkVvUUdsDCDa6ylkNwRhR6o8GDn0/qjouTrpNNYFpQ72rLb/oWx1c2OP5
 omhxH9hOCzIa7TM2+7qVE63UvdSHlT+zoUQ60tA11oyHdzJRcbpJOf7825U18GOWcIr2sDs8RbG
 whipPSOgjFZEuARaaNdEgJeDkXfenDve0YqQ4f
X-Received: by 2002:a50:c35d:0:b0:578:57b9:8e13 with SMTP id
 4fb4d7f45d1cf-57861d60208mr2893489a12.10.1716636826285; 
 Sat, 25 May 2024 04:33:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNZ9IZkByHD4OZPSTyYCD8KOw3oDOQ3SWyx+lvQ1l0FtqhCDL1eskCm+y994fOMjTWtLUPxw==
X-Received: by 2002:a50:c35d:0:b0:578:57b9:8e13 with SMTP id
 4fb4d7f45d1cf-57861d60208mr2893479a12.10.1716636825873; 
 Sat, 25 May 2024 04:33:45 -0700 (PDT)
Received: from [192.168.10.117] ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57852339fc4sm3014419a12.15.2024.05.25.04.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 04:33:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 03/24] target/i386: no single-step exception after MOV or POP SS
Date: Sat, 25 May 2024 13:33:11 +0200
Message-ID: <20240525113332.1404158-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525113332.1404158-1-pbonzini@redhat.com>
References: <20240525113332.1404158-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Intel SDM 18.3.1.4 "If an occurrence of the MOV or POP instruction
loads the SS register executes with EFLAGS.TF = 1, no single-step debug
exception occurs following the MOV or POP instruction."

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index ebcff8766cf..9782250b20b 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2273,7 +2273,7 @@ gen_eob_worker(DisasContext *s, bool inhibit, bool recheck_tf, bool jr)
     if (recheck_tf) {
         gen_helper_rechecking_single_step(tcg_env);
         tcg_gen_exit_tb(NULL, 0);
-    } else if (s->flags & HF_TF_MASK) {
+    } else if ((s->flags & HF_TF_MASK) && !inhibit) {
         gen_helper_single_step(tcg_env);
     } else if (jr &&
                /* give irqs a chance to happen */
-- 
2.45.1


