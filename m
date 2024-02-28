Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A664FC54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfHr8-0004gO-4Z; Wed, 28 Feb 2024 06:12:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfHr6-0004fr-K0
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:12:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfHr2-0003nA-6G
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:12:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709118723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vdiqFmI9WNRUmhfY3Qso6ESXzjkal8TeG/51RyozoDo=;
 b=Hosfy6p4Hgu0VVeOLydxeVfNU6NffZHYFbhkcpbR5DNJw3Tv0bpUnd+qi+8QIUWD4euCEq
 gQFFOqDMdlpt3xns3mMd6aFhK4mpaiCb+lhzY3knWdmnnQ5kaikzuBtEqlypnTNbaguSu+
 MbIv1+f/nBIrtqd9SNSY7NmZtHXCINU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-GZAi8HvsOviYFxewEttv8w-1; Wed, 28 Feb 2024 06:12:01 -0500
X-MC-Unique: GZAi8HvsOviYFxewEttv8w-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a3ede65e32bso177711766b.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:12:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709118719; x=1709723519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vdiqFmI9WNRUmhfY3Qso6ESXzjkal8TeG/51RyozoDo=;
 b=vfoop8y5LJYaY+VdfZfgOz4dAi99HcDYsYru3M3rOUhA50SKxCR2xUNaN5R/Oj9dj3
 kJUp0RHCwRxI1l4gmyNLOsXHfEwgvY57LaZXn2UtMmt/g+oFRFG6J4iirfQE2F0X0iio
 Khasb2/2wLa+5BQY2T6QQq9ky7yc7y5KUmB/QsjhU6H70LqQcNkhZPxJwWMVvHqX2CoP
 9aGvKE294ZApapGdhVV9hXgBt6RDKJQSDwGKX/Lvwr/PHG1BFjflkLcF1Hojb/fiEcFg
 kGSeQxfTjShIcTo9AvyhPOeCdRZahTpsJQGpW8weWOUSbQCusvbRmQ+mtZ9KMrp5wh8U
 0h2g==
X-Gm-Message-State: AOJu0YyCJSzGg1ZCGpavL9TsfsJ0MMnRjNBvhcIP15+awowNQkYO3FCx
 jdCtshQLldqOgi/4dq5j7IeOwx9Jt0biVZxrqxSpq97i94ZO1cg+T7NBthOrRN2gwCPv2arXtA+
 7uAeeLt2bwI06LgUWpS4ArPmonn+Y1JFmw27O3Ev7yy9Jb8bzhemNuWdgoXjLKSSCGhrnI27Y5n
 pCAwezmsFcEHV35rhv/Ou+uWSTodb5phujQDn/
X-Received: by 2002:a17:906:15c1:b0:a43:72d6:f1fe with SMTP id
 l1-20020a17090615c100b00a4372d6f1femr4926838ejd.77.1709118719481; 
 Wed, 28 Feb 2024 03:11:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3334Lqps0/8fvkQjUrC8JcdfSZxB2qb3b3g/NXmrIQD8iajx6xxgMykBn5JJV+Z3YBBLdBA==
X-Received: by 2002:a17:906:15c1:b0:a43:72d6:f1fe with SMTP id
 l1-20020a17090615c100b00a4372d6f1femr4926821ejd.77.1709118719096; 
 Wed, 28 Feb 2024 03:11:59 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 qo12-20020a170907874c00b00a43c51efb11sm1264669ejc.3.2024.02.28.03.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 03:11:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 2/4] target/i386: use TSTEQ/TSTNE to check flags
Date: Wed, 28 Feb 2024 12:11:49 +0100
Message-ID: <20240228111151.287738-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228111151.287738-1-pbonzini@redhat.com>
References: <20240228111151.287738-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

The new condition obviously come in handy when testing individual bits
of EFLAGS, and they make it possible to remove the .mask field of
CCPrepare.

Lowering to shift+and is done by the optimizer if necessary.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index fe9021833e3..63d520e0cba 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -995,8 +995,8 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
     case CC_OP_EFLAGS:
     case CC_OP_SARB ... CC_OP_SARQ:
         /* CC_SRC & 1 */
-        return (CCPrepare) { .cond = TCG_COND_NE,
-                             .reg = cpu_cc_src, .mask = CC_C };
+        return (CCPrepare) { .cond = TCG_COND_TSTNE,
+                             .reg = cpu_cc_src, .mask = -1, .imm = CC_C };
 
     default:
        /* The need to compute only C from CC_OP_DYNAMIC is important
@@ -1013,8 +1013,8 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 static CCPrepare gen_prepare_eflags_p(DisasContext *s, TCGv reg)
 {
     gen_compute_eflags(s);
-    return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src,
-                         .mask = CC_P };
+    return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = cpu_cc_src,
+                         .mask = -1, .imm = CC_P };
 }
 
 /* compute eflags.S to reg */
@@ -1028,8 +1028,8 @@ static CCPrepare gen_prepare_eflags_s(DisasContext *s, TCGv reg)
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
@@ -1057,8 +1057,8 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
                              .reg = cpu_cc_src, .mask = -1 };
     default:
         gen_compute_eflags(s);
-        return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src,
-                             .mask = CC_O };
+        return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = cpu_cc_src,
+                             .mask = -1, .imm = CC_O };
     }
 }
 
@@ -1073,8 +1073,8 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
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
@@ -1152,8 +1152,8 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
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
@@ -1167,8 +1167,8 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
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
@@ -1177,8 +1177,8 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
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
2.43.2


