Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3AFCD128A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 16:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruEa6-0000d3-NH; Tue, 09 Apr 2024 12:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEZk-0000Pz-TW
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEZT-00080z-Qv
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712681014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VUAOjPBKa8O8uU5nsfNDvHxk44hxE+Dv6mb+elp+vLc=;
 b=KZkMhJvaOGqozbAsWrqT5Ica9yt2wjkh2Ro3VsuSR4lRYlU1UDMd1EZBIBIahOhJ3NpK0R
 za5Q/GLXMAcL4OLDxD6gsJ6hB64JrfNQmSDMEvIOmYsGh8cf+eVGoh118LLCQGZoD+SGqT
 ovDiS0DNnxpk7OH49VlZeXH2puJk3DY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-Muu7uMFRPaeC3xwZVPq8lg-1; Tue, 09 Apr 2024 12:43:33 -0400
X-MC-Unique: Muu7uMFRPaeC3xwZVPq8lg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-343bc1e4ef3so3629334f8f.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 09:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712681011; x=1713285811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VUAOjPBKa8O8uU5nsfNDvHxk44hxE+Dv6mb+elp+vLc=;
 b=IPrUldA0diFfLV+1M7PkMlA4dB9AjjrCT/KDQqPag0uuBAsWj3H9WJas45QoADI6F0
 Qe75iH4UXVltnFhPYt4jn4sWoEmhwoU559iM+4wLHrv+vRgP+XHUhP4unz4duSylMqzV
 g3h/EcNsh16iwvinB0kmhOMzOaI4y1ArPnD5ZxoaBSTElaBbfEJMProA2u7XxWvMdeqn
 QJs3ZZVPonRb1Gy1A0CSr5krKKwO9VG5/YSxz8hUoReinB+Eo/aN+ldTjdS/b16d9ZQZ
 psXCEpyfT8AxifZ07ko3gy3pxjVI+NOgzT+DRRpyIzxjzYsbs/6UPGSUaDakG+ck0baW
 ipEA==
X-Gm-Message-State: AOJu0YyamUpX3bQf4ZuPn0y7/L8P4xLz1pbiUsZZpdqsd7lVKQpM60xU
 uoCGtGVQpXtylzYbu3wPaRpJjnG0NWtqYZ8p78Rth7WyI+FKM719DdN3aVTIWF2DSiR8xCjZvE3
 dHTrm2lYmVaZmD+52UH+eBpz6b9VWg7bsFwBmHhf9ig9tSsSnFawGvsnpIbhuXdqffJxTpePOPd
 rz0lHxMWRdv6sI65oCwYHxL2dr1goJOENWyayW
X-Received: by 2002:adf:fc46:0:b0:33e:cf4d:c583 with SMTP id
 e6-20020adffc46000000b0033ecf4dc583mr206671wrs.16.1712681010934; 
 Tue, 09 Apr 2024 09:43:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/pgzA3H9Rq0+p40nLDAF5Vw1QXkQeADKzyaB8VIOxV/ldBlYXZoCBuxQB+vSIVX5OgIXbDw==
X-Received: by 2002:adf:fc46:0:b0:33e:cf4d:c583 with SMTP id
 e6-20020adffc46000000b0033ecf4dc583mr206654wrs.16.1712681010571; 
 Tue, 09 Apr 2024 09:43:30 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 l10-20020adfe58a000000b003434f526cb5sm11737856wrm.95.2024.04.09.09.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 09:43:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH for-9.1 02/19] target/i386: use TSTEQ/TSTNE to check flags
Date: Tue,  9 Apr 2024 18:43:06 +0200
Message-ID: <20240409164323.776660-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409164323.776660-1-pbonzini@redhat.com>
References: <20240409164323.776660-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
index b7117393961..4de5090846a 100644
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
2.44.0


