Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED39C27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFre3-0001bn-4U; Sat, 08 Jun 2024 04:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFre1-0001bR-B4
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:41:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrdz-0001Pf-Vh
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717836107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tmei8Ud98thhW3S+3Sbrm0GZGeeq0Z4E37bpCj2oG9w=;
 b=YZK4duIvqqhgdWs9KsimiDIXyYEY3stjbSHIi9DqxP3OnKgcOjSG4UfegqPuEI98DtYXA+
 f67fpBsa61NKoy6DEncEYuXSEYvjU469maoLe2sbPug7jd3qP/BLal4qUZSWozbq/U0l/7
 6uG6y6iR/Uv5FlqSvsvLjwy1GSfmHcE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-H8K5jnjdNPaNFWMp2eM8vA-1; Sat, 08 Jun 2024 04:41:43 -0400
X-MC-Unique: H8K5jnjdNPaNFWMp2eM8vA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6ef7afd90aso38131166b.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717836101; x=1718440901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tmei8Ud98thhW3S+3Sbrm0GZGeeq0Z4E37bpCj2oG9w=;
 b=K1/ymJh9onTSBOjo6hSeZRwjINXD3N93H33/qptDW7A16vAZBs8b+8VDxYQ5oefTqA
 UyT439rWTbWLF046Bb7TupbarTXYNyRgXfjI0x50JID7sTswsh7Cn1PQEEa3WcmamNJ6
 sO8wte0bdDZi/cFFdQSayuK+o9gidYTkfRSiQlTKXHjJRiZRsrzCN8bUXrf8QMtyYLTF
 azZFJaHcNJS5Ax53TPASs9oSFXT4Y0IRqeEnyVdiX0bZY7s61ZW5U6h213wRMrG6tBA8
 BHNVuf4wxQr0LTT5bvu+NpwzGu8GURTQWA20n7daMN2IGVdLtBXoPy7FzOcD6zW04/KJ
 0Y7g==
X-Gm-Message-State: AOJu0YxD0bcYFg4cKiJpj07ZDCnPJlnqMYOST7ANsnZg/K1VJN1mw2LN
 JJcxGgJjblhR1SxUFXkra+8wwdYeC4HOA4rPOQ40T2d/lgjGpMBI70h2fYmIgQq1Lzrz/DxE82V
 1RU/Vo5WZ/rUTLiO4AzB3gJSMlwNgExe+meunWRWNuvNz1bI1Dl2hsZ9lEdSh7LqwOoQn7q+HEB
 tgW0fe6Ydue4jSfrTbuP0iH76VFp5M0Zae6upu
X-Received: by 2002:a17:906:ca59:b0:a5c:df6b:a9b5 with SMTP id
 a640c23a62f3a-a6cdaa0f720mr312370966b.59.1717836101707; 
 Sat, 08 Jun 2024 01:41:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3eZMLGu62byei2ER2J7juCPPkdqdDpUMuCXTiqE+uyOTmdpGXkBAzzgx9VWA16CrDi4SYFg==
X-Received: by 2002:a17:906:ca59:b0:a5c:df6b:a9b5 with SMTP id
 a640c23a62f3a-a6cdaa0f720mr312370366b.59.1717836101351; 
 Sat, 08 Jun 2024 01:41:41 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6e2e1d4cb8sm181511766b.5.2024.06.08.01.41.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:41:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/25] target/i386: fix processing of intercept 0 (read CR0)
Date: Sat,  8 Jun 2024 10:40:55 +0200
Message-ID: <20240608084113.2770363-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608084113.2770363-1-pbonzini@redhat.com>
References: <20240608084113.2770363-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     | 1 +
 target/i386/tcg/decode-new.c.inc | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 46a96b220d0..8465717ea21 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -272,6 +272,7 @@ struct X86OpEntry {
     unsigned     valid_prefix:16;
     unsigned     check:16;
     unsigned     intercept:8;
+    bool         has_intercept:1;
     bool         is_decode:1;
 };
 
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 4f5fcdb88dd..cd925fe3589 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -221,7 +221,7 @@
 #define vex13 .vex_class = 13,
 
 #define chk(a) .check = X86_CHECK_##a,
-#define svm(a) .intercept = SVM_EXIT_##a,
+#define svm(a) .intercept = SVM_EXIT_##a, .has_intercept = true,
 
 #define avx2_256 .vex_special = X86_VEX_AVX2_256,
 
@@ -2559,7 +2559,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
             goto gp_fault;
         }
     }
-    if (decode.e.intercept && unlikely(GUEST(s))) {
+    if (decode.e.has_intercept && unlikely(GUEST(s))) {
         gen_helper_svm_check_intercept(tcg_env,
                                        tcg_constant_i32(decode.e.intercept));
     }
-- 
2.45.1


