Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26E8C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tQz-0003Zf-Q1; Mon, 06 May 2024 04:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQb-00037f-2T
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQY-0002K0-CI
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714983025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sMIpGq47NzUApNOh+nUXBtgT2brN5VudQhysyxraGNk=;
 b=QH46Q0oiUF4IsFDzIxftipsnEHb5MMVT7nUYQLiC+bXpRrsarvW2tiZh9hJE6mqRHjFevl
 eiKU6QWnuM8PI/LvMY3gTRGoTVhEcTbSm3Q8fM9BP8TNguw+KYGpjUpd0hz+K9yrsbQ0ZM
 +ZGH47nqkAb/EH/pIRu16hU+w6eVe0I=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-J8moF4V0NMmRjH5UEdD_1w-1; Mon, 06 May 2024 04:10:23 -0400
X-MC-Unique: J8moF4V0NMmRjH5UEdD_1w-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59a0014904so102169566b.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 01:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714983021; x=1715587821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sMIpGq47NzUApNOh+nUXBtgT2brN5VudQhysyxraGNk=;
 b=oFJHtiqJpGTpXq7Dt+SUV1Md8hvoSozUSlrTLpnVVTfGO4tY/TBr2YRwCohW9/WDyn
 APoIePQCg39r1lECgUwbFcr/WaBIY8sBUM45t1Wq2lUQaYt8dNUQsQk/FatuvNwBDHR+
 pn5UuBL7fjTWGtuyeheezQY578mrcjtgq0mQNtAIG4636so5W2/jJodBo7n6YQsfs05g
 F2/wTkslWyoKyd7lzfcqVzUjyffkukQZNp9HS+hSLkStxCKKVt1t9MxOh+cM2mwqWB1f
 NvQerbwFh/e3ihmui2OJ/I8gmT4Bld/qAP9UR7CGDxL1KO/+qNqbGaBYEWkqUuDB/Ep3
 Sp5Q==
X-Gm-Message-State: AOJu0YwYIUHQ/YxgRUz3PWqtFfhB85GKTynBdEc04Z5ti41i62nF2Gq5
 PdxsFchBH7L8eIs90ZhUTeC6m3hW3QBzR+GB0saEknlm/spfTblNGwiXTDLu/WTh3GUP+fQPl6r
 di3oI8gd/3pkOLHD6FSdkRG/sNYyK6KP+oiOQUr+nESKqkp8UzSZsuXxp2wPocv+oi8v+4SqX6/
 wmRlG/gJp2avHoiGvTBgqZJF6luBIFKUfTrYBZ
X-Received: by 2002:a17:906:b212:b0:a59:a83b:d440 with SMTP id
 p18-20020a170906b21200b00a59a83bd440mr3791044ejz.31.1714983021370; 
 Mon, 06 May 2024 01:10:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/Sdldg2x5NJ300Qa6lJA60NBXBKNcKINxIqg+OjqbZ5lC7FqVTRvkiFKa1SiIKm1jRXQOZQ==
X-Received: by 2002:a17:906:b212:b0:a59:a83b:d440 with SMTP id
 p18-20020a170906b21200b00a59a83bd440mr3791031ejz.31.1714983021055; 
 Mon, 06 May 2024 01:10:21 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a170906528300b00a4e5866448bsm4897440ejm.155.2024.05.06.01.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 01:10:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	zhao1.liu@intel.com
Subject: [PATCH v2 07/25] target/i386: extend cc_* when using them to compute
 flags
Date: Mon,  6 May 2024 10:09:39 +0200
Message-ID: <20240506080957.10005-8-pbonzini@redhat.com>
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

Instead of using s->tmp0 or s->tmp4 as the result, just extend the cc_*
registers in place.  It is harmless and, if multiple setcc instructions
are used, the optimizer will be able to remove the redundant ones.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 44 +++++++++++++++----------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 17bf85da0ce..d76f72c1b96 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -940,28 +940,24 @@ static CCPrepare gen_prepare_sign_nz(TCGv src, MemOp size)
 /* compute eflags.C to reg */
 static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 {
-    TCGv t0, t1;
     MemOp size;
 
     switch (s->cc_op) {
     case CC_OP_SUBB ... CC_OP_SUBQ:
         /* (DATA_TYPE)CC_SRCT < (DATA_TYPE)CC_SRC */
         size = s->cc_op - CC_OP_SUBB;
-        t1 = gen_ext_tl(s->tmp0, cpu_cc_src, size, false);
-        /* If no temporary was used, be careful not to alias t1 and t0.  */
-        t0 = t1 == cpu_cc_src ? s->tmp0 : reg;
-        tcg_gen_mov_tl(t0, s->cc_srcT);
-        gen_extu(size, t0);
-        goto add_sub;
+        gen_ext_tl(s->cc_srcT, s->cc_srcT, size, false);
+        gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
+        return (CCPrepare) { .cond = TCG_COND_LTU, .reg = s->cc_srcT,
+                             .reg2 = cpu_cc_src, .use_reg2 = true };
 
     case CC_OP_ADDB ... CC_OP_ADDQ:
         /* (DATA_TYPE)CC_DST < (DATA_TYPE)CC_SRC */
         size = s->cc_op - CC_OP_ADDB;
-        t1 = gen_ext_tl(s->tmp0, cpu_cc_src, size, false);
-        t0 = gen_ext_tl(reg, cpu_cc_dst, size, false);
-    add_sub:
-        return (CCPrepare) { .cond = TCG_COND_LTU, .reg = t0,
-                             .reg2 = t1, .use_reg2 = true };
+        gen_ext_tl(cpu_cc_dst, cpu_cc_dst, size, false);
+        gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
+        return (CCPrepare) { .cond = TCG_COND_LTU, .reg = cpu_cc_dst,
+                             .reg2 = cpu_cc_src, .use_reg2 = true };
 
     case CC_OP_LOGICB ... CC_OP_LOGICQ:
     case CC_OP_CLR:
@@ -984,8 +980,8 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 
     case CC_OP_BMILGB ... CC_OP_BMILGQ:
         size = s->cc_op - CC_OP_BMILGB;
-        t0 = gen_ext_tl(reg, cpu_cc_src, size, false);
-        return (CCPrepare) { .cond = TCG_COND_EQ, .reg = t0 };
+        gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
+        return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_src };
 
     case CC_OP_ADCX:
     case CC_OP_ADCOX:
@@ -1098,7 +1094,6 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
     int inv, jcc_op, cond;
     MemOp size;
     CCPrepare cc;
-    TCGv t0;
 
     inv = b & 1;
     jcc_op = (b >> 1) & 7;
@@ -1109,24 +1104,21 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         size = s->cc_op - CC_OP_SUBB;
         switch (jcc_op) {
         case JCC_BE:
-            tcg_gen_mov_tl(s->tmp4, s->cc_srcT);
-            gen_extu(size, s->tmp4);
-            t0 = gen_ext_tl(s->tmp0, cpu_cc_src, size, false);
-            cc = (CCPrepare) { .cond = TCG_COND_LEU, .reg = s->tmp4,
-                               .reg2 = t0, .use_reg2 = true };
+            gen_ext_tl(s->cc_srcT, s->cc_srcT, size, false);
+            gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
+            cc = (CCPrepare) { .cond = TCG_COND_LEU, .reg = s->cc_srcT,
+                               .reg2 = cpu_cc_src, .use_reg2 = true };
             break;
-
         case JCC_L:
             cond = TCG_COND_LT;
             goto fast_jcc_l;
         case JCC_LE:
             cond = TCG_COND_LE;
         fast_jcc_l:
-            tcg_gen_mov_tl(s->tmp4, s->cc_srcT);
-            gen_exts(size, s->tmp4);
-            t0 = gen_ext_tl(s->tmp0, cpu_cc_src, size, true);
-            cc = (CCPrepare) { .cond = cond, .reg = s->tmp4,
-                               .reg2 = t0, .use_reg2 = true };
+            gen_ext_tl(s->cc_srcT, s->cc_srcT, size, true);
+            gen_ext_tl(cpu_cc_src, cpu_cc_src, size, true);
+            cc = (CCPrepare) { .cond = cond, .reg = s->cc_srcT,
+                               .reg2 = cpu_cc_src, .use_reg2 = true };
             break;
 
         default:
-- 
2.45.0


