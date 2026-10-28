Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27C2606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=q07uxmdT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6aN-0006Yh-P7; Wed, 28 Oct 2026 12:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6aL-0006XM-93
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:33:09 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6aJ-0007Z2-PU
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:33:09 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-854b6e2e41fso584910a34.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793205186; x=1793809986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IQ45TU92KrE3ygg0OK53jApJZRB54/B3zPueBnzjfQ4=;
 b=q07uxmdTUOrokrjHtfPJ96iNrY3+K+sZMrWsqHO0/klBBZXilGtiCq9gsXcxz2LU47
 qlVUF2kLTFABNOzOfyH0b6/oliMmpxblZty8cqZrPupo0Y04R5pyifPKna3YKx7Yz1yY
 V2HNecgtbwrMPQBjWqRGtiqCOwxFMQnfVdbb2gRWET+LTdMq9XkFDYWf3R4sxlPgYa3i
 jQKlu2NR/e+cXBEVOEUYjXspdJfS42c0+D/LEY3I4BVUgGAUkubjHp20NORR1wBcM52e
 7lwdIEg/hgfof5VU4fHxKTvqAYyBrppDLBMy+78aQ6aC0SzQrkGXhVsZ+f3mnW76YAfG
 Eyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205186; x=1793809986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IQ45TU92KrE3ygg0OK53jApJZRB54/B3zPueBnzjfQ4=;
 b=OWN3eLW5L31AwxjgHDbAh9gSBAAQDuRc+3ViMs4nJukTWnxbmOj2CsXYBtFiaxR1R6
 g+VUp0WcEAmvB8FpQgmh+xJ1mMjCzNlndyg7psx/7mZVSEu/0liEFX0myQnxzKPu0CbM
 eWIetC+lBUpydRiISCoTqA6QZLMfkaQThpvXQDnT1ZuKjXRxanmUlD3dnHaOm4hxXG7n
 iLEL3pxUEaAExARaka8U7IVM4mqhamW7HSt5MsaFv9gO0Q3WC3ovr6n3OPK3SQOYqKSB
 XeEv325tIBYBpj+9z06L+Kwmz1dGeWzsmehf9+hFlEdGjusgSO0p1oaF6tVwwC5ZJnDs
 I22Q==
X-Gm-Message-State: AFq9FYLKv40MDJtj93S6dz/qYXlGhSioJGOPUfRC6gtZaUjY/JHRcfe+
 93fzlgAYeblVKPwxEMOrsT5SldAJCHFRZm2ILdI2WHz9kCJm+hcKULGl63U2kDuZscAEYafeZ2t
 UxdVZ
X-Gm-Gg: AYBFou3kpMt5Z2ngefQ8AjN+0IbcwJpNhzn3CNM3PczUP0T+gGD9w2Qr3RCqcDWLIIc
 80Zsf5W6zS28qxz29XAGdoikmmmTHkloCr1sIyhl0mEQTn9o2zXXPx9sxycUobrucnAicNP3Ag+
 o2HQqD4bRQgUQXvGk9iMojglHnrJMw/rr+/ggyy7IE4T5ujd6oTRie03ksYqHhjVH6YabA9fXMh
 1aMfTRSlqiSOvIl0hVPbqsxYBuC11BBd21830VXHr25NJ6mfKAtUfxk7JeTmhNGQMjDGwWAeWtG
 CziA1Yv9vTOB+ymCURHd13u64TL2HP+7ph+QQUjzxdnP8WYFRxKdzfefLV3SQEfSu+5PDj8JRQe
 1ad0geZsuaVbvantycqzIjySiIQCQPW3mi0e87A3/YVn2vtiJGzz1yKiLvJY8X0S47WRdVkVByQ
 u9e2hWB4TFNhAXkxywBSNarwvwDX6aGuz1fSvm1vGO6eQ8SgoS+17U/FEWftuVNRxn87vLToX2n
 db/IVTVjHdQTSTwWyl0XMBosEe1S5XiTlCAr6hiZHtMjqRJvJqXQzhCrwHhhEbL++ybJ89xb4ET
 hcBTx+rmL5SDRy9de8lix0KMWmXrrqZpPg==
X-Received: by 2002:a05:6830:34a6:b0:80c:d30f:975 with SMTP id
 46e09a7af769-85abe5cc267mr2842141a34.22.1793205186458; 
 Wed, 28 Oct 2026 09:33:06 -0700 (PDT)
Received: from stoup ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1f4368f3sm2538965a34.7.2026.10.28.09.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:33:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v3 16/16] tcg/s390x: Implement INDEX_op_lea
Date: Wed, 28 Oct 2026 11:32:45 -0500
Message-ID: <20261028163245.1031673-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028163245.1031673-1-richard.henderson@linaro.org>
References: <20261028163245.1031673-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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
 tcg/s390x/tcg-target-has.h |  5 +++--
 tcg/s390x/tcg-target.c.inc | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 58e3afe526..33a3b72318 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -77,7 +77,8 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
 
-#define TCG_TARGET_lea_sh_valid(type, sh)          0
-#define TCG_TARGET_lea_imm_valid(type, imm)        0
+#define TCG_TARGET_lea_sh_valid(type, sh)          ((sh) == 0)
+#define TCG_TARGET_lea_imm_valid(type, imm)        \
+    ((imm) >= -0x80000 && (imm) < 0x80000)
 
 #endif
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 2fd7012d04..db3b2fc3c9 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3187,8 +3187,19 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static void tgen_lea(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                     TCGReg a2, unsigned sh, tcg_target_long imm)
+{
+    if (imm >= 0 && imm < 0x1000) {
+        tcg_out_insn(s, RX, LA, a0, a1, a2, imm);
+    } else {
+        tcg_out_insn(s, RXY, LAY, a0, a1, a2, imm);
+    }
+}
+
 static const TCGOutOpLea outop_lea = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out = tgen_lea,
 };
 
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
-- 
2.53.0


