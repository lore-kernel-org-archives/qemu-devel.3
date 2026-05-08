Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16394CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMtC-0002fs-RC; Fri, 08 May 2026 11:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMt2-0002c8-DC
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:08 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMsz-0001cz-Sd
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:07 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dcd89701acso1908877a34.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253184; x=1778857984; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jn7Dc9BZ0EnH28GcvrrDxiPzdceXEJqh5RPV19BaFak=;
 b=PX8gE+2fJO6LlO0VPTYWXDoTAqU/kNQaLV2/LMq278y2vNZXzvpEJJJnQ1UZ1pxYv2
 QvTxMYC0rex2QkSqdwLJJ3iWq7ZgEkOMqLlQ8iIMDpzAOfo/ZMCGx5RsRZd/FtaE4ihh
 er1iLWkFUhgWgOwWzFlrlSZXlbjVTYTVRZdmN7pUr2ms1HHCUi9q9XjzUKcbnz9OpaCy
 tCZDAdkbVLL+dWheta3bx8zG4GoVfxS+Gw1JlM3CMxHpwYjOjy4kPVLsHFebCCn0dISA
 meg8pH2IWy+aMoORVLihjTYcIiG+1qdjA/iefnpLjB/1RhrBfV5/6rWNfHWlYWU2KVZq
 pGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253184; x=1778857984;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jn7Dc9BZ0EnH28GcvrrDxiPzdceXEJqh5RPV19BaFak=;
 b=W9WM5hF6JSIRIL9m6bySG3Hn8rMczYFKWTJMgbw/42XtaoeoqwltcyFczY+XmChvae
 omX2zgywxpQERU23150jfbn7S5mKs23fGRS9VQUYUEooLdwqt5yoph2fOg8A1iI0jDLH
 3Hk5aQIyLfYqvsEGsiRhxZJ+LupdBgVlkZiqhAxsRJ0rkcuASNgosM3JnAGIWzwqTZme
 7CZm0qO4CgYBfdDh8S63Qgw9lEXxtUDfgsKbs2ZgJxME8e6N2kY5xoIzo+1b48G1CHMq
 QIOvA7jGiw7O2IsJBkZ3RuqX5Tcny2fbkWLQMEVJzNhTqqTyX/VyEQ/T/ZySypjnZpZp
 v8FQ==
X-Gm-Message-State: AOJu0Yw/Gv8w0Svqf6OBC91NKW8b73F9VBUNC1ZPiA13Lawf8UNBC5dv
 LwKUyN+vaJwgDpdjuzh8+3ls5xPmCPMCDSnaldh3p+HLQ1QFj1SZzBnIVi+GJA==
X-Gm-Gg: AeBDiet8ebiC5YZUi77/8kzXP35QcNrTgP1rsU7LXF+7HPK09ASnqn3rb/Hk0cg/GEx
 gMou8f3l0kPE78QAc8l6BVMuZlFCjELPZviXZR7HvciWPP1P3J2uzNCtXmG2A17njl+Nhe8W24L
 3Ru5Cwkt+UsWMYF+2m8ohVHgpBPauxRXX+2U64XstPtDXVjH/HgTNnVLQVjy2hH9hU1o1twijpr
 rUF5PqMza3vP6ZF3ebN22mkkHgMChkLqYZszSEDPZPP92uPEWQd9sooOANSIm7nAN4vZU4uMBN0
 kiCysgh4tLGO/6fAakaj0rbTFZC5vWKOFnSgdgVAZdJbZoFG60VNFaLJ9TiPJN/WPsue+ZRUUAI
 LVc5/59FIkErDVH0ZHkSLz0COpsmd3dtxai1X93FZypYi40uB39aQtybPVLNZ3nK4gcuoZDHIpm
 X+joOBF7tWSuNH0za6XhAfy+rxDXPkB1T76CU64gduE38Gkqrm4ZkXVCGiaWOpzZ3o5Z0Hv1anr
 lyCGYlSqVq6KUuahtAOPM87OVwyBL6mgMiWoP63cGAOx9+bJWkZGB+Ma+8lCrvk2h/60ruY1fZD
 Pz9PKaCg9cMAS7b8rj0qQsm8cH9BhkNReOv5o5iLip/YwDFUaLrFl5u5ovL1AfY96ORrlUM=
X-Received: by 2002:a4a:ee04:0:b0:696:8e8b:20a6 with SMTP id
 006d021491bc7-69998cbcbd4mr7548754eaf.19.1778253184265; 
 Fri, 08 May 2026 08:13:04 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:13:03 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:06 -0600
Subject: [PATCH v3 06/32] target/mips: drop Octeon zero-register fast paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-6-bcbec96357d9@gmail.com>
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

EXTS, CINS, and POP route their destination writes through
gen_store_gpr(), which already discards writes to $zero. Remove the
remaining translator fast paths for destination $zero so these Octeon
instructions follow the same shape as BADDU/DMUL and the generic MIPS
translator helpers.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Remove the remaining destination $zero fast paths and let
    gen_store_gpr() discard writes to $zero.  (suggested by Richard
    Henderson)
---
 target/mips/tcg/octeon_translate.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index e69dd56c8e..1893bf359f 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -74,11 +74,6 @@ static bool trans_EXTS(DisasContext *ctx, arg_EXTS *a)
 {
     TCGv_i64 t0;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     tcg_gen_sextract_i64(t0, t0, a->p, a->lenm1 + 1);
@@ -90,11 +85,6 @@ static bool trans_CINS(DisasContext *ctx, arg_CINS *a)
 {
     TCGv_i64 t0;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     tcg_gen_deposit_z_i64(t0, t0, a->p, a->lenm1 + 1);
@@ -106,11 +96,6 @@ static bool trans_POP(DisasContext *ctx, arg_POP *a)
 {
     TCGv_i64 t0;
 
-    if (a->rd == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     if (!a->dw) {

-- 
2.54.0


