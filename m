Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44256C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tQa-000370-CY; Mon, 06 May 2024 04:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQK-00032h-VZ
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQI-0002EL-KT
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714983010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AhoNqVKllU+cxk9CZCPzWu2TKd8lptUXlZZn/hLjrxs=;
 b=Py9JmBAL3DAiBOzO+hF2Q2by3wJMe0zXukmXPHvaRDxMUu5dkZm9HJs2eoDW3arpqr3X4V
 hZgsvlm7GTcRD8xx/5Kr0TMP1dWl1XqzHs4bUXNvcMAk45SePzUHpwB2Vo1jCRvHwJfMtd
 AeX3QCOqwXqar+7GZLgNpXCVNVHGqbM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-PxM1hNZ1PlOhm-5dwHRCww-1; Mon, 06 May 2024 04:10:08 -0400
X-MC-Unique: PxM1hNZ1PlOhm-5dwHRCww-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59ad486084so72646266b.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 01:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714983006; x=1715587806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AhoNqVKllU+cxk9CZCPzWu2TKd8lptUXlZZn/hLjrxs=;
 b=BUPUh3N60UQq9dYSsJVKXOha7ME0wKjwzDf6iHRKAmo7Sv9C7wKbv9whmtKXanjnH1
 ixsz3vyXiy7WaBubPspJgpQ3het5VpWBvr32ZJgaZAFaZUzdRAJQet0hnnkTrch3FhnS
 /6iKzvtapKYOK/KGt0qyU1kVqHT3N5Uel3ZIk++dsMVk56PU0J35QwdhxMv0t0U1s+za
 TmyswyBx87M7eV9vxeyuDNSzPx58As/rifm5cBuSj24Nzcm1Uz0coLBl9wC6JecxvCdx
 HuoEnpeSLPi9I36AUCwgLqoXJdIdHRPy3DgJw4oloaMjjXCyjJb232YbprPHgeyLoajQ
 u4KA==
X-Gm-Message-State: AOJu0YyrtL6Dk/1nOAl2p9FXE3hAz2qbGSzSEnSUQQLZsTfxySVwarGd
 YpoXgzCE0j28DuktCXsyGLx09QuucYBOuIqU1vOR/CveSXjse3Liel4Ds8VL9SB9+CFsI6ZHWys
 8tD4t71nWG7TO7ssWowAwjOS+0wO7J1hfyFKyNbBYvbLmQ9lNrqFfddIjnwE0FNOhKnOvPpv7Iz
 JcFseuO2L+BQofl6NPsu2x/VqCs0RQ5a+8/Z/P
X-Received: by 2002:a17:906:410d:b0:a59:a977:a156 with SMTP id
 j13-20020a170906410d00b00a59a977a156mr3607158ejk.64.1714983006120; 
 Mon, 06 May 2024 01:10:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6D7zF2z0ZwYhcHcFTojZCvfA/lWOfbjIkZ1l5vQoSpYq4z2BJKLyBtrW3774CSmMod1W/3w==
X-Received: by 2002:a17:906:410d:b0:a59:a977:a156 with SMTP id
 j13-20020a170906410d00b00a59a977a156mr3607137ejk.64.1714983005694; 
 Mon, 06 May 2024 01:10:05 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a170906084a00b00a59a2ec20e4sm3073469ejd.175.2024.05.06.01.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 01:10:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	zhao1.liu@intel.com
Subject: [PATCH v2 02/25] target/i386: use TSTEQ/TSTNE to check flags
Date: Mon,  6 May 2024 10:09:34 +0200
Message-ID: <20240506080957.10005-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506080957.10005-1-pbonzini@redhat.com>
References: <20240506080957.10005-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


