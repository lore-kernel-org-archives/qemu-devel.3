Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD41C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribeR-0003as-Hd; Fri, 08 Mar 2024 09:56:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ribe8-0003LT-IS
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:56:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ribe4-0005ZL-Di
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709909781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GZeJTi1a4ei23fONx1W+yvOU8wtWevhrI6ZjoG75Hhc=;
 b=UROqXSCUBjhPg6baGechAeM6ou7Cp6/RgQ91jui2wJIRDDBv9ftO8rnm0LbH8nT4p++fYO
 rExNN6ti7/CBukBkOYUJoey65vQloy7CDDGhPgp2li8HJQnShV2BtwVt/O8nhrTjt1DPy/
 87ShR5y9ry5Zi6+WYalI6/mlxDFW0zY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-LOfjeD8xNqOQ7WvnONkj2w-1; Fri, 08 Mar 2024 09:56:19 -0500
X-MC-Unique: LOfjeD8xNqOQ7WvnONkj2w-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a45acc7f07cso135483366b.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 06:56:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709909777; x=1710514577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GZeJTi1a4ei23fONx1W+yvOU8wtWevhrI6ZjoG75Hhc=;
 b=X4zAB8sMpIbFbP3EvGnI3K6MzdIM3yX7TiWzb+bTarH1JUqQLokbNZmt6cwrcXQHNb
 6lotdWhnDJprNbZixhOvz+L7KJ8yCxsHLGZ8sql66NeibX34e70VcCrgZNgQyOa1SmLC
 /71CDXdvBiq6YmX2rrgjETz2w5N4mLH6mknob1EFMuIMxrF0bMF6b9iKfK4796LHre3p
 jWaeDl8hZjrkMEkb7TZlvU9tRQeiZOyvdtstZTNM53CxCrxEyank6V3Hnb7AIlKli/bn
 guW/UtwuyZc5Vf+4EHqYKK9pRy6+KFJ40xIUi0ofsxmY7NEid6NQepVkrwkEWpF9Mkj3
 8W6g==
X-Gm-Message-State: AOJu0YxZJo0zm7gMDE/3gGGNZ4PpCSPw80rHbPRvxz6g2Zbr+yUY8xPy
 sPK/UgvCnEfPSA1tw1Te2TbvxfNkXtjOBxEIcsBU10DY1OrzYhleDNWHOHzHm3oFo3K26UVeFbZ
 YUBz5rpTRW3TyvkkI3+PbiZavZbTqLAJk7UIQxtNK0FJfdZg5SaGoW2pHIPQ0KyYoJV18h9DCkf
 sEy+zV7If4nZmdfsrRDLA77AYIarFHI7aKeQaF
X-Received: by 2002:a17:906:3c58:b0:a45:547a:49e1 with SMTP id
 i24-20020a1709063c5800b00a45547a49e1mr9974789ejg.3.1709909777277; 
 Fri, 08 Mar 2024 06:56:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGo75h8RaSXUkUeetEEr17DUbDy/cQJVlaztv0fKIX53UTTxTp4pk/RN9DDlAgb5dzAMPgevA==
X-Received: by 2002:a17:906:3c58:b0:a45:547a:49e1 with SMTP id
 i24-20020a1709063c5800b00a45547a49e1mr9974780ejg.3.1709909776925; 
 Fri, 08 Mar 2024 06:56:16 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 le6-20020a170906ae0600b00a449b4f4aefsm8196522ejb.178.2024.03.08.06.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 06:56:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/12] target/i386: use TSTEQ/TSTNE to check flags
Date: Fri,  8 Mar 2024 15:55:51 +0100
Message-ID: <20240308145554.599614-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308145554.599614-1-pbonzini@redhat.com>
References: <20240308145554.599614-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
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


