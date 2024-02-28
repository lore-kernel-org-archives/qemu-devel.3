Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294E3C54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfHr5-0004fH-9P; Wed, 28 Feb 2024 06:12:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfHr2-0004e9-GZ
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:12:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfHqz-0003mv-3u
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:12:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709118720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2lITc8wdXp+om+78er1UP4KPqGeYdYRVhMnXnbWICmk=;
 b=Ud8oic6JxBGShA6leySCYGvUjnhJ73b6SPkVIoDHPGHraPTSZ7FPUDi12tQMTc7h53DS8p
 D5A6Nq4L1Z1wv2q9Pj79IxH7n8WPbKGMLpejx1WBmFCvE9MiOzNCjTFV3aWukbXFON3Qlt
 d2fshituR57UQX96S91SlVFx2EjmlkQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-lGthTntBNvGcFddv4V28oQ-1; Wed, 28 Feb 2024 06:11:58 -0500
X-MC-Unique: lGthTntBNvGcFddv4V28oQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a3ee69976dfso218031566b.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:11:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709118716; x=1709723516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2lITc8wdXp+om+78er1UP4KPqGeYdYRVhMnXnbWICmk=;
 b=FdB4fixDqBrYjih9TSaa00LnlFOKuDI992zwe9sUiVI2WFn7T+s/tj7aJR4c3DCRIM
 gecMguMoHnQyCZIvsj9jfM9QvGgLi/7zSATcoS+OKIlcJT5HT2fp7+SJGvJ6eQ2EdNMw
 FFFKPiOBW/4e5o7PgP0OFRI7yUTOQ96u3ukjNHmkBVlEGBmbH0gGLoWMTykheqXh+Gg7
 u29+8G0L3m8c8AVAvkdIq7qNmcQ6TPn5vBslZ2SK22WoAn7JZRaAz0wBxV8pZ1tBcjLw
 tJDuWWwx2I8/ndflF6LdUIzp8djWYrnRRJhUL1UNRtDvnW9aB9nQqdvSvebHiSdXbX5F
 dnlQ==
X-Gm-Message-State: AOJu0YwtWzk3NDN6TQmm0+xPYL0hlIFm4g8W3GwmDbUMPogKuvduRAho
 SQ00CTekLXbi96pUigtT1yZpFlqDp9In6Khi5Zv9O734HKYQqRoYEtqw7GxqwDirg+q1g7FQEYi
 AMVHB5qVUIvJu11+pFNAQ/lEC97PrhxCEgUfD0tnYXHOnt3gKdfLkDbNgAdOdSz25TMFl9Ifft7
 oKkR8wtwN3s1I6E7e6wRNInkLHrwtKVkS4678B
X-Received: by 2002:a17:906:7b50:b0:a43:ef3d:e42e with SMTP id
 n16-20020a1709067b5000b00a43ef3de42emr1070680ejo.18.1709118716268; 
 Wed, 28 Feb 2024 03:11:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGd6l3IV++Garq8LNTghNvXUWGaaYs3683iYhinNRSy6U/kgbKGUANq0V+iXD9qpPe6gJ0HWQ==
X-Received: by 2002:a17:906:7b50:b0:a43:ef3d:e42e with SMTP id
 n16-20020a1709067b5000b00a43ef3de42emr1070660ejo.18.1709118715685; 
 Wed, 28 Feb 2024 03:11:55 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a1709062a0300b00a3e799969aesm1718568eje.119.2024.02.28.03.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 03:11:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 1/4] target/i386: use TSTEQ/TSTNE to test low bits
Date: Wed, 28 Feb 2024 12:11:48 +0100
Message-ID: <20240228111151.287738-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228111151.287738-1-pbonzini@redhat.com>
References: <20240228111151.287738-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Do not do this for 32- and 64-bit values however, to avoid
large immediates.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 28 ++++++++++++++++++++--------
 target/i386/tcg/emit.c.inc  |  5 ++---
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 07f642dc9e9..fe9021833e3 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -927,11 +927,21 @@ typedef struct CCPrepare {
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
@@ -966,9 +976,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
     case CC_OP_SHLB ... CC_OP_SHLQ:
         /* (CC_SRC >> (DATA_BITS - 1)) & 1 */
         size = s->cc_op - CC_OP_SHLB;
-        shift = (8 << size) - 1;
-        return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src,
-                             .mask = (target_ulong)1 << shift };
+        return gen_prepare_sign_nz(cpu_cc_src, size);
 
     case CC_OP_MULB ... CC_OP_MULQ:
         return (CCPrepare) { .cond = TCG_COND_NE,
@@ -1028,8 +1036,7 @@ static CCPrepare gen_prepare_eflags_s(DisasContext *s, TCGv reg)
     default:
         {
             MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
-            TCGv t0 = gen_ext_tl(reg, cpu_cc_dst, size, true);
-            return (CCPrepare) { .cond = TCG_COND_LT, .reg = t0, .mask = -1 };
+            return gen_prepare_sign_nz(cpu_cc_dst, size);
         }
     }
 }
@@ -1076,8 +1083,13 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
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
2.43.2


