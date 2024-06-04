Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8782DC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEORx-0003Tz-7y; Tue, 04 Jun 2024 03:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEORs-0003Jn-AL
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEORq-0005ed-Tf
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717485550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7QRT7KodLZb3R6daWVQofmOuNLtzn1249htY3GzAkRw=;
 b=CMYvL3kH736vf2LqhENjLcck/BvwaFLixNiBOd3o26AWEKtMVlCnF4pBS48eMkokpEaltp
 YtXaiHtFyXqVD9xHDF8hihiCUIZOCu5ab25hWvdi7oBbZxghBy86zaQSuuSoDm0aG9WqnK
 lMfIaaP3HhJLp/thrNNZi96O5hTVa6o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-O9t0rNKEPI2U-nDgKXyVGg-1; Tue, 04 Jun 2024 03:19:03 -0400
X-MC-Unique: O9t0rNKEPI2U-nDgKXyVGg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5785176c796so2529924a12.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 00:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717485541; x=1718090341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7QRT7KodLZb3R6daWVQofmOuNLtzn1249htY3GzAkRw=;
 b=DcVYmMUDds0viAnRdk7ILq6qhtDn0CSZUi18cGgcIf5RwFP1Nk0S6VJurNDZ1puYzj
 iLIWq5mkvUNFYmHOxuqREqcGPz2Uz/eJr+0OsSa+aoqbVqfXNYeA9VhRiCHfoLwYwPfk
 Xm+3QHG7dcw5/Od+l4gumaJZJiS28aBHqnbkRitHn6HOwCwUvlRFBrJwbpYRC0yBI2F4
 2RnY6T7MiELs6t6jj0qj9fqz+WVjwGA38Jmfut24XgM6fB1bG+xpmH1BxNAwUPkdhIGy
 lADYrpqVfuK9NSm8b9VNQZccO4JWLDyDw0rImlKLBytFXRjgZGDM5KgSni0n/DnK1Jxu
 CNzg==
X-Gm-Message-State: AOJu0YwblkOMbkvNRGr0+UVMhBxrQRP6SHqbYu8bvlX2CODR8VHBdMMW
 yMH23fdRX8DbxyP9Wbs2AR2m9uTsmZzh+WWptVzatq3upiqiOSMg2kkNw1yMofaMf9PzVqPQxts
 zT3nEVRlHgdAVyivAhxlAwuBv5QFpKwKW5hJ6DODziq72Xs6Pbbxqjv7K4nDFl+S1th4Bbs/+Go
 Gbalvp6xw2zWCCEuGd9iUDNSYahTjINXvhFvp9
X-Received: by 2002:a50:bac4:0:b0:57a:4af2:fcf5 with SMTP id
 4fb4d7f45d1cf-57a4af301e7mr5552127a12.2.1717485541844; 
 Tue, 04 Jun 2024 00:19:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhle3APIdal4Bk/OucXEarJ/czXHdsdM6YxIQkHqBU3g2Eie1cm8u0xHfzyTcpyo9qYd2Whw==
X-Received: by 2002:a50:bac4:0:b0:57a:4af2:fcf5 with SMTP id
 4fb4d7f45d1cf-57a4af301e7mr5552115a12.2.1717485541494; 
 Tue, 04 Jun 2024 00:19:01 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31c9c0b8sm6920580a12.86.2024.06.04.00.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 00:19:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 08/11] target/i386: fix INHIBIT_IRQ/TF/RF handling for PAUSE
Date: Tue,  4 Jun 2024 09:18:30 +0200
Message-ID: <20240604071833.962574-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604071833.962574-1-pbonzini@redhat.com>
References: <20240604071833.962574-1-pbonzini@redhat.com>
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


