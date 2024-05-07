Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBD5C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IVB-0005mP-57; Tue, 07 May 2024 06:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUw-00052y-Ka
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUv-0002tp-3x
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715079396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Gh4ObM+jx4Fq+FBU9GVILaKVEgzJpFA3P4BFJazzNo=;
 b=ZEzK/uGfhh6Wio2yawPuPlGow3iz+46AfUzema1Lm7520rxQlXKPtTtrSCL/tGmDDKtVXj
 ec3jLiGzMcFYoo6mdavwE8X3AXelKNcWKliSldNcKK1VM/kCIwiXRghMTPu+6NIE1COMRH
 BqasjwS6jua5fMZLqN5vqn2VQM1ChOI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-mMwYVV-GO82UhGgeVeOzmg-1; Tue, 07 May 2024 06:56:34 -0400
X-MC-Unique: mMwYVV-GO82UhGgeVeOzmg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59a63a1f78so175293666b.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715079393; x=1715684193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Gh4ObM+jx4Fq+FBU9GVILaKVEgzJpFA3P4BFJazzNo=;
 b=AHRHTItWZ7g2KSkcaspEasqcw8JMlNzIfSfs1NCJESl65Se1G1TfepfcK1K2Zin5pl
 WNiesq3ysdeMEMAKq085wxwGyHNSsMuc9sVkaFVnYzZih7Qep5ctBAGXNzW/a4hkRyYQ
 JlLCY6vOD4DOKRosWHKMiTUP/p2T2jtseP6o8kyp+ZtM0JstJ9ctGRY4SWceOneEPSHS
 nkKAH3WIA5vbE8mFckk6etJCze+2ClOFdIgKJnCRW/7viN7rRg2t9gB/Ae0U2z7euL3k
 A02ECpY+S51ddSsdc7Lh/Sgqxy6ns1/zk0W28a8hamvwrrQ3gD7nOhdBTTZN/fur7wQP
 wCQg==
X-Gm-Message-State: AOJu0YwwbX0/a9HQ297zv0ALfqnwWwyyoLVD8vPHIHClSfh58ueaTHcl
 bOlhncdcnJ7xuLKIYT5W57H8BrECk/333GCrKTrCAFiGUi3vq11vMCJx4XdYuBMdT2xmVZpohoC
 Zio0zyOlPl0turERo2GbCG3CDo+N8nNw6zIx0o8U51bmOlhPSH+zkkh6zIO5VL9UNeSjKFrwq7E
 1+fcNqXRJcQznbTpoD78F8X1s7NXylJQkKQ0bb
X-Received: by 2002:a17:907:1c28:b0:a59:bb1f:6ffc with SMTP id
 nc40-20020a1709071c2800b00a59bb1f6ffcmr5448073ejc.8.1715079392992; 
 Tue, 07 May 2024 03:56:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0O7BMUJKPYng9NLYdms7DDmyzzNgJka+V7pUJT3xpX8OqptwOx8JTiQjqu617wl47WE2c2Q==
X-Received: by 2002:a17:907:1c28:b0:a59:bb1f:6ffc with SMTP id
 nc40-20020a1709071c2800b00a59bb1f6ffcmr5448065ejc.8.1715079392733; 
 Tue, 07 May 2024 03:56:32 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a170906c30a00b00a59a08c722fsm4519422ejz.184.2024.05.07.03.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:56:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 19/26] target/i386: merge and enlarge a few ranges for call to
 disas_insn_new
Date: Tue,  7 May 2024 12:55:31 +0200
Message-ID: <20240507105538.180704-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240507105538.180704-1-pbonzini@redhat.com>
References: <20240507105538.180704-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

Since new opcodes are not going to be added in translate.c, round the
case labels that call to disas_insn_new(), including whole sets of
eight opcodes when possible.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index f83204bd1ed..3060fdbee94 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -6869,9 +6869,8 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0x10e ... 0x117:
     case 0x128 ... 0x12f:
-    case 0x138 ... 0x13a:
-    case 0x150 ... 0x179:
-    case 0x17c ... 0x17f:
+    case 0x138 ... 0x13f:
+    case 0x150 ... 0x17f:
     case 0x1c2:
     case 0x1c4 ... 0x1c6:
     case 0x1d0 ... 0x1fe:
-- 
2.45.0


