Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB4B606A32C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=G3HEMelu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6aL-0006Xh-Rv; Wed, 28 Oct 2026 12:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6aJ-0006WH-Fq
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:33:07 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6aH-0007Ya-Tw
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:33:07 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-8446af403b5so743588a34.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793205184; x=1793809984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H0Ao7p/a7WKXmlH0esmjLg7gkf9IP99/2gTCNFOdk/U=;
 b=G3HEMeluaOJ/FGK4pO7IP1Yu3GCluOfk57y2OsgpKlZpmQljEaRKJ11XyaJDuVSKNb
 KfORSHbiuE6x6b4Qq0ic39mRxI54qdU0PM+oKQxu90CQWlZ2XOx6WnJVp55VuGt0iYH5
 F+9PAFYxmSqlkbvWFcfT4rwt8odXLQ7f0C884ozzgICwNaKrYqNlbzqp1NjFOM3aised
 501gQ7lEP3ZbVdT+sU+d/No9Qb03xIptK53l0NDUJdZ15vzLyxvkBn3F9NchWEEgPGF1
 6UJHxjM2R5TYjF6yEe+lykrE2mZQyAoTj1S8mY9F3lEnCSfr+I2pz6klcjTCJQUeCRvH
 rKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205184; x=1793809984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H0Ao7p/a7WKXmlH0esmjLg7gkf9IP99/2gTCNFOdk/U=;
 b=gsR+XR6TLXEnkh1a14eBUtSEXvrrWyYvs2tK9QatbxGmpDS+SGEMstxtKIbeKjG6VF
 sMoihxhYdVgWdMh3tZkKibXLsxqiIBWR3waFawHHTWEkuXSYia8hRvo/9xwRYVarQhJ6
 wmYa0zvoFApLycGUFGwqdHCi3yNqJmfxPUr9j3GC3AurXfq9ksiF8SMpephYsh8TdC+x
 AZHGL1RFOrz+7QXZoL6y1I1FA2gVwaliJ7wjgEKbHpqbk8NLat9LlrFrZT2nkusffvKA
 8LSgF/2i323U6x4vm4aRIBJr4G2wJkRNJ7OsP8o7bu/s8y28tqvHcgrKP1qvjgBVjQdY
 k9+w==
X-Gm-Message-State: AFq9FYJfsxXZmgIsJxFkIdfV9It6t4L+ZVGbjmfCt0PSuNFItwaMacx4
 gpHI+WHwBIll8mgMCwPYxYtDZ1TQ6jXUpLsVAt9+/1luNziEhI4G/bzbkIJ4Y/MCfBHgAFDoEx7
 LF5r3
X-Gm-Gg: AYBFou3kL5iItS+Qh1FZc8OjpcWHX081ZTPXXaDkZf9DrkLE97zhehhhhBAuNljZfTG
 k5R2kt6Dztqsi40H9DAyinWI0Uh0b6oGSDGJhJO4AlOVyaLwtAyV2f9bHQVDMDrN4w2c9XPLckY
 8hxYBwICRqtQNLQqRuJ7TEJzOHG+KyPvag5EzAfgmkqOxEqSqu1HZpIOedU1SR+oj9aHvKWPv7X
 BjYRk1Drm4/H5kNCzMDSw5ceKGPt2BsjJIxo0GaAx5efnwPbRhVw5SEjgYKgCLclY/8eR7n/s4c
 COjkXNse9xsa1+O/pT7xpdDRI+ffGlwhXL9WnfPs1CnquwIPRrXbDDoMq2x/Oejs5ZA3s65Vwpb
 4zb7G58AxvrIujXyAYfizvUXIo0R4CZHMg802OS9DU8VkoZc9fIHT7XaXtS2BIYD7cq9eziNFn9
 1ia81y/I0hLsdwtwwiDAnU1o6F9nsIk9tssF/hMVf1hZTdpayuUPXCVoWnMmN0gkqNdixMO2c7w
 VPQIm2YDlCJZ9KXrep7vAEG7a+1Q33YmyvvENtUr9TCBv6tw5f/MW+jMVLqvazIs8OJ4XxPxSfP
 aBUh9dU/RSRzUY36jO+8n5eokDX6nkoMRQ==
X-Received: by 2002:a05:6830:2e01:b0:81e:bb3a:7ebc with SMTP id
 46e09a7af769-85ab83d6f5cmr2753029a34.26.1793205184542; 
 Wed, 28 Oct 2026 09:33:04 -0700 (PDT)
Received: from stoup ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1f4368f3sm2538965a34.7.2026.10.28.09.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:33:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v3 14/16] tcg/aarch64: Implement INDEX_op_lea
Date: Wed, 28 Oct 2026 11:32:43 -0500
Message-ID: <20261028163245.1031673-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028163245.1031673-1-richard.henderson@linaro.org>
References: <20261028163245.1031673-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-has.h | 4 ++--
 tcg/aarch64/tcg-target.c.inc | 9 ++++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 86672b2eab..9420a7bc73 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -57,7 +57,7 @@
 #define TCG_TARGET_sextract_valid(type, ofs, len)  1
 #define TCG_TARGET_deposit_valid(type, ofs, len)   1
 
-#define TCG_TARGET_lea_sh_valid(type, sh)          0
-#define TCG_TARGET_lea_imm_valid(type, imm)        0
+#define TCG_TARGET_lea_sh_valid(type, sh)      ((sh) < tcg_type_size(type) * 8)
+#define TCG_TARGET_lea_imm_valid(type, imm)    ((imm) == 0)
 
 #endif
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index b601b19c7f..5c186156c0 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -3081,8 +3081,15 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static void tgen_lea(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                     TCGReg a2, unsigned sh, tcg_target_long imm)
+{
+    tcg_out_insn(s, addsub_realshift, ADD_LSL, type, a0, a1, a2, sh);
+}
+
 static const TCGOutOpLea outop_lea = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out = tgen_lea,
 };
 
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
-- 
2.53.0


