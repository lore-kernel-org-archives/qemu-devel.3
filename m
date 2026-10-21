Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9569606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uuLIYUjd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXIy-0000yQ-R0; Wed, 21 Oct 2026 10:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGl-0006du-HX
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:24 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGj-0002Zg-Pl
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:19 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c418e215671so100491266b.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592776; x=1793197576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MZg0rrTPlRfzJyyh4cpo7GvKmDZpUGjhV+xLCp85z0c=;
 b=uuLIYUjdABCfGy+eaTyVsK3O/XiVa4eu0FKFk46oIcsDUvsYccR/i+B7QxlxS5b0Kk
 zfJ6I4ozNu4r0gT4PnVsUNrKVk5RIcy6Q69UT9dQyn/OWwNXttEvptkRI2DRPsmHO0x1
 1MYm51XB4whpAi8zt1H5zdtJoKqET69f5wxa/mTTv0jZUfsXCgjGOjP285DWnenIm6CJ
 H8kzLrNtyPgnjjLRg2NZ0LVR28L6Fl+QtDbw8aiq0GwXxYlYe/Q8OQ34/Ye4Va3W5zKM
 yyZbHSdqqaIbuq+wJyUNHa/ZDgu3juPZPGrUkE/0/VgjBEcRmO6YrJOlY/7L2Uae5GQr
 mjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592776; x=1793197576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MZg0rrTPlRfzJyyh4cpo7GvKmDZpUGjhV+xLCp85z0c=;
 b=rE1VpyunQVDNN6jKf6/ocpsJZoQSyqmy4Ms2yPpgDFzMahsJg+JsN4PPRa5g3yYTMy
 /XyJ3RhWXUecIF9p5xRLWzNwysCVz01PI0oDGbCwkMyuODR40vezwSg43hFPOkLF8y2m
 UV8roJHTqapyugV3WCIJd7prgf1GJ4JxG78BG8lMBRbDztuUAq5nOUvcoW4XHr/5bYqe
 zyaXqSEaY3c7jvKyOQtkEk45JF0mujjizA/ZePtFp53OdIArNSVmehB8jjVIb4Tq+nTn
 J2BLEi9CYGrOs6BgY/ma4HlcbFeUsgecws350D0SbjKBCi9FUAm+s6aGJmpYOvaBkzfm
 FgJA==
X-Gm-Message-State: AFq9FYKIfL+Ridqj1Z2jLOFrmZaHysUCLu+GHIRzJNOwENW/kp3clyK/
 PABPXJpoJz8cL4WQ6msEv9qeAw0PCWU349ipUcXJOiQLXSm5LQydgI+Sfa7We6pMnv2tLhyTLpq
 thYS2BkM=
X-Gm-Gg: AYBFou07PBJrQf+rvEvDAiD12YOHHgWunGZu2mcsneoRABXsOJXApMmrMHWh3H/4zpR
 lntcc1Oqsbz/cVPOqtNQ9UVP5LJ29TwBqmixle7ZOCJeDddx+JI2kmJghQuynqkE6cepPs/mkvt
 OHE46dE/mxyxMu4jyrfKHs2b5Pme1WlLk9o6qSIT7nxp0zLntdczY3cSAcXLbveQRnUmBrwQIj9
 +nHpzm3s9Wivx3oq81xFiX1OhgXgF6nv+/LwCN1FEyjbzMKA40nJZeZ8++8wpNQM38ZcEC3uCw/
 xmjbnyxud7YVfiYckDwvytfHv48lKKB0zkD4T2OIVE1YkDzP31SQLF8eI3APFDfELaJCBdoiSy6
 VTBvn3ZlIAYaD4QdYw4LxPzpMy4Pw7h3ygUIEzwh3j+ElMaH+BumG4/PEo3FNXb6DbuQ5uznFzp
 S77rl+ZoI4Ezr5Q5IEATLZOEoLqyG/+rFuCZ2MOb5tIIUry1PaAmzJp0m1ebBO1ChDjvJXZsVeo
 W0EWguXddu9ziEnqzrDxQ/J2/Ltso0cCJHDylT/JuHZercckxd3J0khYTFVhMiG0ZGtKJYLVDgs
 3qrs0/5qx3Tq433pzARzTk7jAQU=
X-Received: by 2002:a17:906:7956:b0:c2e:317e:d711 with SMTP id
 a640c23a62f3a-c46796a35e9mr201235366b.27.1792592776158; 
 Wed, 21 Oct 2026 07:26:16 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828cd1sm5710878f8f.22.2026.10.21.07.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:26:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 095/100] tcg: Generic expansion of tcg_gen_dup_*
Date: Wed, 21 Oct 2026 16:16:47 +0200
Message-ID: <20261021141652.363109-96-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  6 ------
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op-gvec.c            | 41 ------------------------------------
 tcg/tcg-op.c                 | 16 ++++++++++++++
 4 files changed, 17 insertions(+), 47 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1fe791d5f5..75194c1906 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -137,9 +137,6 @@ void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
-/* Replicate a value of size @vece from @in to all the lanes in @out */
-void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
-
 /* 64 bit ops */
 
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
@@ -153,9 +150,6 @@ void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 
-/* Replicate a value of size @vece from @in to all the lanes in @out */
-void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in);
-
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index f9dab50a91..556f7470cd 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -23,6 +23,7 @@ DEF4(deposit_z, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
+DEF3(dup, unsigned, TCGV, TCGV)
 DEF3(ext, TCGV, TCGV, MemOp)
 DEF2(ext8s, TCGV, TCGV)
 DEF2(ext8u, TCGV, TCGV)
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 0d649cc13b..72abb0a08e 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -434,47 +434,6 @@ uint64_t (dup_const)(unsigned vece, uint64_t c)
     }
 }
 
-/* Duplicate IN into OUT as per VECE.  */
-void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in)
-{
-    switch (vece) {
-    case MO_8:
-        tcg_gen_ext8u_i32(out, in);
-        tcg_gen_muli_i32(out, out, 0x01010101);
-        break;
-    case MO_16:
-        tcg_gen_deposit_i32(out, in, in, 16, 16);
-        break;
-    case MO_32:
-        tcg_gen_mov_i32(out, in);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
-void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in)
-{
-    switch (vece) {
-    case MO_8:
-        tcg_gen_ext8u_i64(out, in);
-        tcg_gen_muli_i64(out, out, 0x0101010101010101ull);
-        break;
-    case MO_16:
-        tcg_gen_ext16u_i64(out, in);
-        tcg_gen_muli_i64(out, out, 0x0001000100010001ull);
-        break;
-    case MO_32:
-        tcg_gen_deposit_i64(out, in, in, 32, 32);
-        break;
-    case MO_64:
-        tcg_gen_mov_i64(out, in);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 /* Select a supported vector type for implementing an operation on SIZE
  * bytes.  If OP is 0, assume that the real operation to be performed is
  * required by all backends.  Otherwise, make sure than OP can be performed
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0162817d5d..df769dd975 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -659,6 +659,22 @@ void tcg_gen_divu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_dup(TCGType type, unsigned vece, TCGTemp *dst, TCGTemp *src)
+{
+    unsigned t_width = tcg_type_bits(type);
+    unsigned e_width = memop_size(vece) * 8;
+
+    tcg_debug_assert(e_width <= t_width);
+    if (t_width == e_width) {
+        tcg_gen_mov(type, dst, src);
+    } else if (t_width == e_width * 2) {
+        tcg_gen_deposit(type, dst, src, src, e_width, e_width);
+    } else {
+        tcg_gen_extract(type, dst, src, 0, e_width);
+        tcg_gen_muli(type, dst, dst, dup_const(vece, 1));
+    }
+}
+
 void tcg_gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_eqv, type, 0)) {
-- 
2.53.0


