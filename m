Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FE2C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2Rj-0007CV-T7; Tue, 11 Jun 2024 10:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2Ri-0007Bt-1b
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:25:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2Rg-00066u-EZ
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718115955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GKBj3BIae3wLKWizif0rfYzzEINy6nl8RdXecFWJYa8=;
 b=FXVp/BLMfUXUSycPTYoQEtWfCtZSKLSTwZE+hP8sCaW/YCzK6fN6WraS63Cu686f+MKpV5
 0XTNU7LPFH6saoEq4ae3mtdIbQCqetsgTQI0VY4Yuv0gfxBm/KpezSDTUrH06eUngLo5fH
 KrzKjdhQyKXhOzXSxvpMwKjPAx5LqsY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-kK6OmpU3NBGzS-KC2Pa4Yw-1; Tue, 11 Jun 2024 10:25:53 -0400
X-MC-Unique: kK6OmpU3NBGzS-KC2Pa4Yw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-57c738349baso901502a12.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718115952; x=1718720752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GKBj3BIae3wLKWizif0rfYzzEINy6nl8RdXecFWJYa8=;
 b=oFnjC6rSlpfTuabcShdQgrBqKf56bMIVcsagUPzsOHKHwo7p/Thw2bPMlIAlWwa2hb
 31ppFPNorn1FQaUwVpwm1l6JALFeULSGp4Ujftpl2GsreBKVYv7iLEmyaG08ExnGlLrz
 opfPN2ShtGmiqVkbW8jSFKj+30LX/S1azP0vzPEQ+Q2Ai85uESU5CvxckF3l8ZdOiI0L
 gUmYsw/LOCn5DJ+uwQhlGOtsyk5I9dMxe1vVlaQBuxtvd4D0ePRH+qZsGPxZXF/KNjFd
 4LE6s4IFCzthAEjvL2sgfHYpAMBzdNmKBJRIrFH7FjjDjPjMwoW0CAApmSQ1Nmkz0Aw/
 P4ZQ==
X-Gm-Message-State: AOJu0Yxylm9oSMA/Hb1IbJJ00ox0vE+kRgk/JW5AMB2SjtDehlx7gp6B
 AwczK0WfXSQU1VB5Q4TE2S2Ld79Z0dSWGWe0DF2KhxlIUg6yFzllThp2YZLkqJ4YPX/5LfmIcj/
 6Jz7AU/Ehe65Fdzu85lTAvvskFFiHEWVqWzgKs1frj/9EVy3MgyPVtK8UZ1d7mVsKOZbcuiaycR
 nHAPyhrfHfJmRzqf5LdMDDrXPq38/HlXhNb3qD
X-Received: by 2002:a17:906:d105:b0:a6f:132a:8212 with SMTP id
 a640c23a62f3a-a6f132a8616mr598655066b.35.1718115952072; 
 Tue, 11 Jun 2024 07:25:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWlXL4MeIoUowS48fBJRRQPzJNwP718kI2sH7I22WV2vEegTvvHmbrkbSrCwO1WDp5XCafdw==
X-Received: by 2002:a17:906:d105:b0:a6f:132a:8212 with SMTP id
 a640c23a62f3a-a6f132a8616mr598653466b.35.1718115951604; 
 Tue, 11 Jun 2024 07:25:51 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f127398c4sm371566066b.202.2024.06.11.07.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:25:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/25] target/i386: fix processing of intercept 0 (read CR0)
Date: Tue, 11 Jun 2024 16:25:10 +0200
Message-ID: <20240611142524.83762-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611142524.83762-1-pbonzini@redhat.com>
References: <20240611142524.83762-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


