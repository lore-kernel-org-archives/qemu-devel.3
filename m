Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D8EC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 05:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTwq7-0002nn-Vd; Wed, 17 Jul 2024 01:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpw-00023o-Sw
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpv-00023A-F9
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721192658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MemgVytbS+CGobXmYk8UiKu3v/T5gfVxuzswj90V1FQ=;
 b=afW28lMM0vW/eKiKyAwo9yPkz5ykNcij9d034UD6w4VoQwYqsotKr+wSl89HD+xZQ/gOzH
 FzpyX11abUkCXW6smamAMc4QNULLffQGr0yh2TuTo7vv8meM6ww9IePSBT7cZ7o3Mu1LZW
 Buk5Em2lhOmfGagRsveaXH8M7zIyKjs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-f3ScbaGgNEWP15LMXIty1A-1; Wed, 17 Jul 2024 01:04:17 -0400
X-MC-Unique: f3ScbaGgNEWP15LMXIty1A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-426d0bead0aso46486545e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 22:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721192655; x=1721797455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MemgVytbS+CGobXmYk8UiKu3v/T5gfVxuzswj90V1FQ=;
 b=RBgBqllgToC0l0GVyrbQ+sh0idUKm8wltSt4zkC7eD+MzyM/YiK0zdBuWUwNNKbOEl
 JygI2piKTvWwl3GwjoTR68Ck0dFUD5Re5QqxePcdOotWs+vBs01B3e0X25MZl9glT/Ak
 muRqYPLcwk/8R6CHUxnPERiBWWBrGP0W3yB2i1dkOou0loBbfcaOpNDlyUkl3edNjNL8
 4+SwRu3wImfDXryU2KhoBM8pTM61Y5Ywk+5a0MB7PU+DL38737+F8nIc8ay3lAOXhn8U
 8OnwQ5QX43Q6MLs24nbNNr1GqzstuufIxgPFt/mIbC2e0aj1RQ6jkuveF8r08fijSeIq
 +bnw==
X-Gm-Message-State: AOJu0Yz9EPxyHJZ+e5oeC4vTbt1+JhQhLa6fguJ9k779b6xI2z4qur/f
 blUvwzlp77lZYFx3IieTfR/rqiOTEqkatC4davAKr1XAHNC62/Os3FgqLLaD83vzKBdHGdxMS//
 oHVpbBf+bR4TDV98W9qGgcuKxrL5GEt9cIsusPbtHzprf0nfVnofJzESJ+tlVyJnLTAjT6d3Qvb
 zpODUEITS46bZfopZI0TqX0kjmz9Ox30u+gvo4
X-Received: by 2002:a05:6000:1802:b0:367:9abc:3c70 with SMTP id
 ffacd0b85a97d-36831600e15mr424880f8f.17.1721192655603; 
 Tue, 16 Jul 2024 22:04:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYhZqLsorCNzfvwBD/6DDPi939BmVcjAjXEp7lJ49SXvXKp7PuCWcIMmjaT+4rul+nSaPkvA==
X-Received: by 2002:a05:6000:1802:b0:367:9abc:3c70 with SMTP id
 ffacd0b85a97d-36831600e15mr424862f8f.17.1721192655305; 
 Tue, 16 Jul 2024 22:04:15 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680db038dbsm10558680f8f.95.2024.07.16.22.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 22:04:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 18/20] target/i386/tcg: check for correct busy state before
 switching to a new task
Date: Wed, 17 Jul 2024 07:03:28 +0200
Message-ID: <20240717050331.295371-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717050331.295371-1-pbonzini@redhat.com>
References: <20240717050331.295371-1-pbonzini@redhat.com>
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

This step is listed in the Intel manual: "Checks that the new task is available
(call, jump, exception, or interrupt) or busy (IRET return)".

The AMD manual lists the same operation under the "Preventing recursion"
paragraph of "12.3.4 Nesting Tasks", though it is not clear if the processor
checks the busy bit in the IRET case.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 8a6d92b3583..a5d5ce61f59 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -369,6 +369,11 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
         old_tss_limit_max = 43;
     }
 
+    /* new TSS must be busy iff the source is an IRET instruction  */
+    if (!!(e2 & DESC_TSS_BUSY_MASK) != (source == SWITCH_TSS_IRET)) {
+        raise_exception_err_ra(env, EXCP0A_TSS, tss_selector & 0xfffc, retaddr);
+    }
+
     /* read all the registers from the new TSS */
     if (type & 8) {
         /* 32 bit */
-- 
2.45.2


