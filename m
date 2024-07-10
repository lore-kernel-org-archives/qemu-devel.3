Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E1FC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 06:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRQpt-0000Vu-45; Wed, 10 Jul 2024 02:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRQpq-0000KG-Ux
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRQpp-0000vM-JW
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720592989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8+uzj3RGp8F8f+unwaA1jvsqz4v1x4mS4inV4L7PkF0=;
 b=HCTgqwIaGFLtcOIDh9gCskI1JWVvJHlukNBkQ69XvN698B3clJaRJzeF6SQj8wooxHaCdX
 nKUwD1J5kwL9bQCjpdLe2J+rwmcgZRUT3RUZLw2FonQp8QEqANTe0iqAbM7E5Ip/lvhy/P
 ViBCyll0+xO7epCobjd/D/MOWbtpmb8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-GUkfe6KZOseVRCJ6P12jDg-1; Wed, 10 Jul 2024 02:29:46 -0400
X-MC-Unique: GUkfe6KZOseVRCJ6P12jDg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42671a6fb9dso9605625e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 23:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720592985; x=1721197785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8+uzj3RGp8F8f+unwaA1jvsqz4v1x4mS4inV4L7PkF0=;
 b=qerqICDIyxCxgRnzIyPlIVt/pPJ+qfj4olbUYh9ZvpnUAbyUDtTf2Ygp/hCUuYss3E
 O7o13ha3W2CYUms437ASW8sAji2E5jPrfl8hLlNEizmiOHV6+5uRKLF3dfCVEjFBcpW5
 8LQoo9a3mLNesJB59WwFu7JAkhAhZhjPhMVZuchEErt1BvYjDuqQbt2lFwReom78vB8A
 QUjz0UYzzZLTmiLMXTwBFw6+KCJU/eFyjKyqbHNEeqOe/OEzAo1g8nMwWx/7+mChnHdT
 ODJWVnh2kM87D7phgz+rYmqOpqpI8jwR05JMqSTeBrTLQAHYgNy74hF6D0y29QfUJ1uA
 EIBw==
X-Gm-Message-State: AOJu0Yw+3OZbpYtVWUgpVqwFgFjnlRGUTmq+YQQz85LvqaPwSqxcBbvK
 3ro66YtQ37ZRA016cvKAw7E1Ht2HHnpu2cNf9Ywjei6xrWIU8Kcmsbi10AsE6Q2H4hOD5oJtGt8
 hXOhsxpJBiySSDdDq5zmLZdKv/V8FNi/uzTBgPHKlB0q3r2rwNqpFqamNSvEra+JqAma7Q5qBPk
 zhpQ05+ZFqWWCiUyBCDSTal6TaZxjtq+Rv1Ms+
X-Received: by 2002:a05:600c:206:b0:426:5c36:207c with SMTP id
 5b1f17b1804b1-426708f1d6emr35744985e9.25.1720592985155; 
 Tue, 09 Jul 2024 23:29:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbX2XXQ6mm5vIvZT9TxC4xvapGezrW0Jpf6T36H7Ejbr/P5qLxKVM/1tTOSMG47P/yRQvbHg==
X-Received: by 2002:a05:600c:206:b0:426:5c36:207c with SMTP id
 5b1f17b1804b1-426708f1d6emr35744855e9.25.1720592984849; 
 Tue, 09 Jul 2024 23:29:44 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfb22aasm4373995f8f.117.2024.07.09.23.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 23:29:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: rrh.henry@gmail.com,
	richard.henderson@linaro.org
Subject: [PATCH 08/10] target/i386/tcg: check for correct busy state before
 switching to a new task
Date: Wed, 10 Jul 2024 08:29:18 +0200
Message-ID: <20240710062920.73063-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710062920.73063-1-pbonzini@redhat.com>
References: <20240710062920.73063-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 1430f477c43..25af9d4a4ec 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -306,6 +306,11 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
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


