Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15255C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrXJ-0000ZV-Dn; Sat, 08 Jun 2024 04:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXG-0000Yf-Hi
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:34:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXE-0008JC-Ve
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7QRT7KodLZb3R6daWVQofmOuNLtzn1249htY3GzAkRw=;
 b=VlA+k3oGEoBSa9ezrWKoi4K/O1tCwnOANXShE5QD28Q4kgtJw5k9pbJPT2uIAhgJm7OoO1
 tkwlNpnipGQQmBuUFihxfPs3Qig/pKTpfb3kF+fodcvXfC3zxcnqjWd3VxsZi/UoLKJStk
 qP6A9GSfynwjGWytDWjqZ7q2N8h6otY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-19gZZLT0Mtmwl_X_BbxmbA-1; Sat, 08 Jun 2024 04:34:43 -0400
X-MC-Unique: 19gZZLT0Mtmwl_X_BbxmbA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a68e0faf0e6so155734566b.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835681; x=1718440481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7QRT7KodLZb3R6daWVQofmOuNLtzn1249htY3GzAkRw=;
 b=MO16e/6P1HgXr7Aus+5qP+mmUfGce8h5xCF9sMPX20C9+CUm5wNvTeIslcEMBWWgf/
 IOLncD+WGzNCMLazdx8iusyyLODMf8nAovbVWBvRB1J1W2ry4FI7Ietdvi6WggUIQrsE
 H0mkn9e4T0DDWEeJd2pGRtC11XyOq0409aeiXccp2pWFVzqP7LKywCJktxhpXDADygX/
 q0ryKDj4MRPFOx4N/Tpwp0BjN1wplvZP4+89iEZ4GNtybgRcrPzLQuOKoDV8RM/bSRqt
 hQkGKyzRIYQwHIHa9XQo1rhRSvuAph8pznYxqRFznyYKbEnL02J5uxabLt3mFCls7rHt
 JKnA==
X-Gm-Message-State: AOJu0YyJ8gsaBJigSQ7WV/rcpRLaFPzPpGh5qVM/BtJ+7P4R9sv+PiZg
 EAt1R45exc4m7rYxUY1g0RlcW0aHQGZ0CUgY9IBj6BRP+KNRMnTA8ZUpRVtwHtkLv+0yA+T93wB
 hJLpDx/IX9VnmPK8XMSEM98XFMHgMZPqC/uYWZielhB8sWuoTmMzBT0B8CEMOuU7nTcBr8WCjGh
 sQM8ZAKFYZZiuXh+/vJGs0CESg0lC552T1qIDb
X-Received: by 2002:a17:906:f80c:b0:a62:2cae:c02 with SMTP id
 a640c23a62f3a-a6cdacfeda4mr259062266b.61.1717835681551; 
 Sat, 08 Jun 2024 01:34:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2lCXgoJZK38vpiGsgHiKgizCtuUfWY163cD5BIrCmnKgrDyXfI04MFo7Odf81SKSsJmKqMw==
X-Received: by 2002:a17:906:f80c:b0:a62:2cae:c02 with SMTP id
 a640c23a62f3a-a6cdacfeda4mr259061166b.61.1717835681124; 
 Sat, 08 Jun 2024 01:34:41 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6efacd2958sm93215966b.106.2024.06.08.01.34.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:34:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/42] target/i386: fix INHIBIT_IRQ/TF/RF handling for PAUSE
Date: Sat,  8 Jun 2024 10:33:41 +0200
Message-ID: <20240608083415.2769160-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

PAUSE uses DISAS_NORETURN because the corresponding helper
calls cpu_loop_exit().  However, while HLT clear HF_INHIBIT_IRQ_MASK
to correctly handle "STI; HLT", the same is missing from PAUSE.
And also gen_eob() clears HF_RF_MASK and synthesizes a #DB exception
if single-step is active; none of this is done by HLT and PAUSE.
Start fixing PAUSE, HLT will follow.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/misc_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/tcg/misc_helper.c b/target/i386/tcg/misc_helper.c
index 8316d42ffcd..ed4cda8001e 100644
--- a/target/i386/tcg/misc_helper.c
+++ b/target/i386/tcg/misc_helper.c
@@ -92,6 +92,10 @@ G_NORETURN void helper_pause(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
 
+    /* Do gen_eob() tasks before going back to the main loop.  */
+    do_end_instruction(env);
+    helper_rechecking_single_step(env);
+
     /* Just let another CPU run.  */
     cs->exception_index = EXCP_INTERRUPT;
     cpu_loop_exit(cs);
-- 
2.45.1


