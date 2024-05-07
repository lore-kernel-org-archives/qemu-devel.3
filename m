Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECB0C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IUG-0004Po-Sd; Tue, 07 May 2024 06:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUF-0004PE-Jq
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:55:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUE-00021A-2U
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715079353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AhoNqVKllU+cxk9CZCPzWu2TKd8lptUXlZZn/hLjrxs=;
 b=BSMU1aqZGsW9PutRNrwC0VEhIy1AR7qWhD6sVR0w3MdAPJer9V9UV2SEO88nVerij6rrig
 SMSJ8QcGEHJDv9uFdiU5M73dtsHODjb+VehcOvEc3IFoX0QeHFW8btjr8F1dsX6k7WnGcz
 lA6t3+i+BZ4m/8q5KJQ9AT7OW7HtxZA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-3yQJtW51PkukjPc7q5eHng-1; Tue, 07 May 2024 06:55:51 -0400
X-MC-Unique: 3yQJtW51PkukjPc7q5eHng-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59a5b06802so193156866b.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715079349; x=1715684149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AhoNqVKllU+cxk9CZCPzWu2TKd8lptUXlZZn/hLjrxs=;
 b=bBAskO9plJKq8NnkeNCb3YvzDp0T9J5pnsu43FaU+qVkUcDgYHMu1xX23qNN4UOhzG
 1l5uou/olDxyH9U+s/GVu+fgh9XC3Ke2tfAlR9lVwSvIrA5gFuBbbibWIuZ8S8NPA8Nj
 Z9dnGUbL+IRSsZQQJ+sCR1rgzdWqhyPw1CXxof7qTk+cdwdOWzT1NpmmWOzzfWzZH+uB
 OdQr292My0DTYG+jkknvllXw7YHE+B8l627YXNSKII7uibfD6wUwJgyxyN2ABtkVfqXG
 X0gB4+7WABYAso/PBeeoxf8NLFiOUS8cOR06UH56yfIg7i2lxOdF8/B0Le/Kvnzsg1Oq
 vowA==
X-Gm-Message-State: AOJu0YyQPdqgAXOOfT+SUWp3G4r3CRPIkLVmtDJykSNo9fVNl9/8p8DF
 VKowYDSESBD+Pk0kSQAZAKW2AUJnx9mMsL5PEL7G5p2Rpku4OpzSZx809ZOEGQxW7TeaUvjO2zh
 83ap7DDXJ7dX/ClBgY87dtlEpaArjGbxWt7Z7duZUOZXSk4cIZQmvtu5RVRAjimqCy2VlOEQ+H4
 xpok6BuDu1rB6cFMOvFKU4xSaApvbgc221BHs9
X-Received: by 2002:a17:906:5614:b0:a59:beb2:62cc with SMTP id
 f20-20020a170906561400b00a59beb262ccmr4461583ejq.61.1715079349601; 
 Tue, 07 May 2024 03:55:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsSJJjbDYIPqo90Nz/PZTX600XtajMkvCIJUAD/USNjm/VpPh7i2SzwfxTzgH378q1cI9B3g==
X-Received: by 2002:a17:906:5614:b0:a59:beb2:62cc with SMTP id
 f20-20020a170906561400b00a59beb262ccmr4461575ejq.61.1715079349287; 
 Tue, 07 May 2024 03:55:49 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 ww1-20020a170907084100b00a59cb8c93f3sm2553537ejb.58.2024.05.07.03.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:55:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/26] target/i386: use TSTEQ/TSTNE to check flags
Date: Tue,  7 May 2024 12:55:15 +0200
Message-ID: <20240507105538.180704-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240507105538.180704-1-pbonzini@redhat.com>
References: <20240507105538.180704-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

The new conditions obviously come in handy when testing individual bits
of EFLAGS, and they make it possible to remove the .mask field of
CCPrepare.

Lowering to shift+and is done by the optimizer if necessary.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 4735f084d40..62ba21c1d74 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -996,8 +996,8 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
     case CC_OP_EFLAGS:
     case CC_OP_SARB ... CC_OP_SARQ:
         /* CC_SRC & 1 */
-        return (CCPrepare) { .cond = TCG_COND_NE,
-                             .reg = cpu_cc_src, .mask = CC_C };
+        return (CCPrepare) { .cond = TCG_COND_TSTNE,
+                             .reg = cpu_cc_src, .mask = -1, .imm = CC_C };
 
     default:
        /* The need to compute only C from CC_OP_DYNAMIC is important
@@ -1014,8 +1014,8 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 static CCPrepare gen_prepare_eflags_p(DisasContext *s, TCGv reg)
 {
     gen_compute_eflags(s);
-    return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src,
-                         .mask = CC_P };
+    return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = cpu_cc_src,
+                         .mask = -1, .imm = CC_P };
 }
 
 /* compute eflags.S to reg */
@@ -1029,8 +1029,8 @@ static CCPrepare gen_prepare_eflags_s(DisasContext *s, TCGv reg)
     case CC_OP_ADCX:
     case CC_OP_ADOX:
     case CC_OP_ADCOX:
-        return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src,
-                             .mask = CC_S };
+        return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = cpu_cc_src,
+                             .mask = -1, .imm = CC_S };
     case CC_OP_CLR:
     case CC_OP_POPCNT:
         return (CCPrepare) { .cond = TCG_COND_NEVER, .mask = -1 };
@@ -1058,8 +1058,8 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
                              .reg = cpu_cc_src, .mask = -1 };
     default:
         gen_compute_eflags(s);
-        return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src,
-                             .mask = CC_O };
+        return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = cpu_cc_src,
+                             .mask = -1, .imm = CC_O };
     }
 }
 
@@ -1074,8 +1074,8 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
     case CC_OP_ADCX:
     case CC_OP_ADOX:
     case CC_OP_ADCOX:
-        return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src,
-                             .mask = CC_Z };
+        return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = cpu_cc_src,
+                             .mask = -1, .imm = CC_Z };
     case CC_OP_CLR:
         return (CCPrepare) { .cond = TCG_COND_ALWAYS, .mask = -1 };
     case CC_OP_POPCNT:
@@ -1153,8 +1153,8 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
             break;
         case JCC_BE:
             gen_compute_eflags(s);
-            cc = (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src,
-                               .mask = CC_Z | CC_C };
+            cc = (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = cpu_cc_src,
+                               .mask = -1, .imm = CC_Z | CC_C };
             break;
         case JCC_S:
             cc = gen_prepare_eflags_s(s, reg);
@@ -1168,8 +1168,8 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
                 reg = s->tmp0;
             }
             tcg_gen_addi_tl(reg, cpu_cc_src, CC_O - CC_S);
-            cc = (CCPrepare) { .cond = TCG_COND_NE, .reg = reg,
-                               .mask = CC_O };
+            cc = (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = reg,
+                               .mask = -1, .imm = CC_O };
             break;
         default:
         case JCC_LE:
@@ -1178,8 +1178,8 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
                 reg = s->tmp0;
             }
             tcg_gen_addi_tl(reg, cpu_cc_src, CC_O - CC_S);
-            cc = (CCPrepare) { .cond = TCG_COND_NE, .reg = reg,
-                               .mask = CC_O | CC_Z };
+            cc = (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = reg,
+                               .mask = -1, .imm = CC_O | CC_Z };
             break;
         }
         break;
-- 
2.45.0


