Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25DFC27C65
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrXX-0000fL-BQ; Sat, 08 Jun 2024 04:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXV-0000dn-7b
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXT-0008L0-3m
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D3wocNIsZztn55fnPvzel1bjkhSOP21BqV81NIpu6ZI=;
 b=cJ4KRmncEIzPQR7muKV/r+Nx3U4tKkXuQyL/vBBgsRj2eXuuprde7JZ9ph4XyFgEmFfCRC
 4/AYwm59pxt8EoiOJ57WRclZ3iirGc2Vn0L8L4H4K/thAehJRSPpZ7j0KHPUMqoUFGaICV
 hiZxv6vm+oyiczx8UXHCuWSnBVplXmE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-G2cx1xdxNkiXpEedJI4HdQ-1; Sat, 08 Jun 2024 04:35:00 -0400
X-MC-Unique: G2cx1xdxNkiXpEedJI4HdQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6efe58a1aeso25611066b.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835699; x=1718440499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D3wocNIsZztn55fnPvzel1bjkhSOP21BqV81NIpu6ZI=;
 b=R3wLvzBef5ztV/XpbMcFxaceuCCBrLWxSG8OABHkp7QEQYCZ41BZfIC6rD1pKy9v7J
 uFeFXsHp/vxZto+ZhW3UqI7qNVmCEt1omcYJLqsdAMaMJafLBoQbElRDsYtPV2LxzxDy
 rNiSScQ9zE/4t+0EzG7hYnEpuLxdaJvndhtOb05tDJvxIeRqLAwovbiTgL7O076bwZl8
 2KJHMz2ivTkt2DO02TTX406CwmJAkjZjrpwJgKP1JyfJKx79Ekja8Tj6wSUK+41Rf95h
 7mpGt8bx9/iTI8Q/ppU2W1ax23h3UiRXHlEPNIjnvIsh7rBqMUzPTCFyndENcdRMJT7M
 S7ug==
X-Gm-Message-State: AOJu0YwGe2UhdxH+uCjHNQOTFfoYnTb17YEEXR5Mna3QColFX22GAfcp
 K3iJPgJ/WuMpzKdROc6AMStiThIJQT/Hf/vcmEVIgX77wYkLw8yzSijJ9Vq9gQzAuGpP3kAA8a6
 CjGi4H4xTDRBFtJ+Na4R49U7ffWyEi4LkKmgdaUh8lM0y08pV9TisvBoF+4zSdARUDrdYdXJlWz
 Bsl/MdwZ1XXxNonF5mM86g4rbAvS5PP6JUiSGQ
X-Received: by 2002:a17:906:44c:b0:a6a:f9cc:ff9c with SMTP id
 a640c23a62f3a-a6cd665cc31mr289443466b.27.1717835698855; 
 Sat, 08 Jun 2024 01:34:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWsFnYQbzotusO6tl/mXRmtZLfyhAWB8Vlbp3K6cdRYmB6pW/DfdaLSrvlSrX9J8TgCm2zKw==
X-Received: by 2002:a17:906:44c:b0:a6a:f9cc:ff9c with SMTP id
 a640c23a62f3a-a6cd665cc31mr289442666b.27.1717835698489; 
 Sat, 08 Jun 2024 01:34:58 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6ef6a512f0sm125034866b.198.2024.06.08.01.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:34:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-stable@nongnu.org
Subject: [PULL 15/42] target/i386: fix size of EBP writeback in gen_enter()
Date: Sat,  8 Jun 2024 10:33:48 +0200
Message-ID: <20240608083415.2769160-16-pbonzini@redhat.com>
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The calculation of FrameTemp is done using the size indicated by mo_pushpop()
before being written back to EBP, but the final writeback to EBP is done using
the size indicated by mo_stacksize().

In the case where mo_pushpop() is MO_32 and mo_stacksize() is MO_16 then the
final writeback to EBP is done using MO_16 which can leave junk in the top
16-bits of EBP after executing ENTER.

Change the writeback of EBP to use the same size indicated by mo_pushpop() to
ensure that the full value is written back.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2198
Message-ID: <20240606095319.229650-5-mark.cave-ayland@ilande.co.uk>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 2b6f67be40b..fcba9c155f9 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2138,7 +2138,7 @@ static void gen_enter(DisasContext *s, int esp_addend, int level)
     }
 
     /* Copy the FrameTemp value to EBP.  */
-    gen_op_mov_reg_v(s, a_ot, R_EBP, s->T1);
+    gen_op_mov_reg_v(s, d_ot, R_EBP, s->T1);
 
     /* Compute the final value of ESP.  */
     tcg_gen_subi_tl(s->T1, s->T1, esp_addend + size * level);
-- 
2.45.1


