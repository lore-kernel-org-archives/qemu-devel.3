Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E1BC25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IUH-0004QI-K8; Tue, 07 May 2024 06:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUF-0004Oc-2x
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:55:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUB-0001vu-SP
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715079350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=evwl5j1BmZeJ11djwzgHn7uufVfECtY7gGvF4FJX3es=;
 b=U8RRje18k1ymZ66RrcOB1fRttnrIbsqlkru20KEpN40cuIUULEe3u0aw3p8W6Tumar3hSH
 yMkTJRnjdVzYe5YjrLLioaBX64ewsLUgW4kEKw6AgKaqKr6inpqdQdy3bEVxWgVa59FCbf
 +pY+1iQlPSzr/UvvqtePQ9IeAYewtwU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-pbqMYRixPaSaAzrMhxuScw-1; Tue, 07 May 2024 06:55:48 -0400
X-MC-Unique: pbqMYRixPaSaAzrMhxuScw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59efa9f108so30991966b.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715079346; x=1715684146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=evwl5j1BmZeJ11djwzgHn7uufVfECtY7gGvF4FJX3es=;
 b=AI2AS4x85hI40zzxemanSiiW3+lEwjrH/adbgv8oHjB5M7stVlCwfs7NlFRFd4gR9X
 JGb67ayxk+nRzkM0hxO3dBh46fF6gdp8Pf0X0B8A6kWgrEo6SbaEjCoZZfTuxmx6D6BX
 Eyj7ghrRHy3/S1hZSVFnKZJlAXooCABx4l0LGfyH8PA6Ne1F9wFbQmp9361X+YZKdJa+
 kY6wWDoPqIVuqcBmxY5Sf1nMnDQZozy6X3l6qfTQ+mdLkRv8/4vOb+xgJV6/veoqKBfg
 XAwaSRVUpI1x0eFnE3Xp7TvlC9ycRLejgOSFUsHuRZeky4ygd1a9zwI3uwWh/p0IBzQW
 IDLw==
X-Gm-Message-State: AOJu0YzDXunHvQkrzzQMqReXi1+jg3YMgKYPxDx5/R5FHoZhxXPnkMEn
 PzZ10v2JCwJKNIdquGC0xWIo6TlQvLboTBEm2oaNzC6iosHPe80aF3M1KvqDRxh1bvmC45aT1Wt
 wRP4jjv+MCQb2lCw5Rzph/rPfQd4NiHoShuhmsGTGlEkRwtd8xAB2iO0xi5JZLbeYJDJdFJr/uk
 lbKts+0wzf6YTxhsWXyqd3nJYLWcgC705qJNaP
X-Received: by 2002:a17:906:26d7:b0:a59:7ed4:fad5 with SMTP id
 u23-20020a17090626d700b00a597ed4fad5mr7179171ejc.54.1715079346347; 
 Tue, 07 May 2024 03:55:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1Yq8Mhv7yQkelCzOUxRtlB2I30AnwMBRw6obpx/3gNCg7p+TmxHbhT8fpz9X5yZs0iUigkQ==
X-Received: by 2002:a17:906:26d7:b0:a59:7ed4:fad5 with SMTP id
 u23-20020a17090626d700b00a597ed4fad5mr7179156ejc.54.1715079345859; 
 Tue, 07 May 2024 03:55:45 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170906125200b00a59c9c927e5sm2683334eja.57.2024.05.07.03.55.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:55:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/26] target/i386: use TSTEQ/TSTNE to test low bits
Date: Tue,  7 May 2024 12:55:14 +0200
Message-ID: <20240507105538.180704-3-pbonzini@redhat.com>
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

When testing the sign bit or equality to zero of a partial register, it
is useful to use a single TSTEQ or TSTNE operation.  It can also be used
to test the parity flag, using bit 0 of the population count.

Do not do this for target_ulong-sized values however; the optimizer would
produce a comparison against zero anyway, and it avoids shifts by 64
which are undefined behavior.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 28 ++++++++++++++++++++--------
 target/i386/tcg/emit.c.inc  |  5 ++---
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 051ffb5e1fd..4735f084d40 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -928,11 +928,21 @@ typedef struct CCPrepare {
     bool no_setcond;
 } CCPrepare;
 
+static CCPrepare gen_prepare_sign_nz(TCGv src, MemOp size)
+{
+    if (size == MO_TL) {
+        return (CCPrepare) { .cond = TCG_COND_LT, .reg = src, .mask = -1 };
+    } else {
+        return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = src, .mask = -1,
+                             .imm = 1ull << ((8 << size) - 1) };
+    }
+}
+
 /* compute eflags.C to reg */
 static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 {
     TCGv t0, t1;
-    int size, shift;
+    MemOp size;
 
     switch (s->cc_op) {
     case CC_OP_SUBB ... CC_OP_SUBQ:
@@ -967,9 +977,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
     case CC_OP_SHLB ... CC_OP_SHLQ:
         /* (CC_SRC >> (DATA_BITS - 1)) & 1 */
         size = s->cc_op - CC_OP_SHLB;
-        shift = (8 << size) - 1;
-        return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src,
-                             .mask = (target_ulong)1 << shift };
+        return gen_prepare_sign_nz(cpu_cc_src, size);
 
     case CC_OP_MULB ... CC_OP_MULQ:
         return (CCPrepare) { .cond = TCG_COND_NE,
@@ -1029,8 +1037,7 @@ static CCPrepare gen_prepare_eflags_s(DisasContext *s, TCGv reg)
     default:
         {
             MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
-            TCGv t0 = gen_ext_tl(reg, cpu_cc_dst, size, true);
-            return (CCPrepare) { .cond = TCG_COND_LT, .reg = t0, .mask = -1 };
+            return gen_prepare_sign_nz(cpu_cc_dst, size);
         }
     }
 }
@@ -1077,8 +1084,13 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
     default:
         {
             MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
-            TCGv t0 = gen_ext_tl(reg, cpu_cc_dst, size, false);
-            return (CCPrepare) { .cond = TCG_COND_EQ, .reg = t0, .mask = -1 };
+            if (size == MO_TL) {
+                return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_dst,
+                                     .mask = -1 };
+            } else {
+                return (CCPrepare) { .cond = TCG_COND_TSTEQ, .reg = cpu_cc_dst,
+                                     .mask = -1, .imm = (1ull << (8 << size)) - 1 };
+            }
         }
     }
 }
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 6bcf88ecd71..0e00f6635dd 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1209,7 +1209,7 @@ static void gen_CMPccXADD(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
         [JCC_Z] = TCG_COND_EQ,
         [JCC_BE] = TCG_COND_LEU,
         [JCC_S] = TCG_COND_LT,  /* test sign bit by comparing against 0 */
-        [JCC_P] = TCG_COND_EQ,  /* even parity - tests low bit of popcount */
+        [JCC_P] = TCG_COND_TSTEQ,  /* even parity - tests low bit of popcount */
         [JCC_L] = TCG_COND_LT,
         [JCC_LE] = TCG_COND_LE,
     };
@@ -1260,8 +1260,7 @@ static void gen_CMPccXADD(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     case JCC_P:
         tcg_gen_ext8u_tl(s->tmp0, s->T0);
         tcg_gen_ctpop_tl(s->tmp0, s->tmp0);
-        tcg_gen_andi_tl(s->tmp0, s->tmp0, 1);
-        cmp_lhs = s->tmp0, cmp_rhs = tcg_constant_tl(0);
+        cmp_lhs = s->tmp0, cmp_rhs = tcg_constant_tl(1);
         break;
 
     case JCC_S:
-- 
2.45.0


