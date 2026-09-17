Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6D4C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73pG-0005q5-4B; Thu, 17 Sep 2026 00:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73ni-0001qv-Hx
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:48 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73ng-0007Ji-8d
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:45 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-395cf2535acso396811a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619562; x=1790224362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AlqQreYfm1p2NgbZMu8uKGWPbt4K8yjuaW2/8lFTj/Y=;
 b=Yel6itAzBtrxupsffYwVVGngiWiuo4RDvZhfcjC+fwZ3oI9kvvt/kbO+Pdo2h8sh8c
 d/s82E3oOMRs3UKDqcE0iTz0AIs8Igi9WAriyaTx6Lxr0a4OtBfkLXGjUPktN/enXBI6
 Bv6hCAlXogsy84d3j982S6j7Re8/qTeHbkbZMpr/6Bj+RUmKULN2Rept5/4Q7BWZlpth
 1C0m3dCc8v6ErQM8a/YlNsbVffPwMDfPjpUIq11rxbGEPN9oF4XKzJtiWnvDdqtOu9PQ
 XVMCAf3brrgf1CYcvot4yijISxRfcU4iKqPpqb5tbFcKoZPWnVLDs7gmG4BmyvNBWE1b
 XPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619562; x=1790224362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AlqQreYfm1p2NgbZMu8uKGWPbt4K8yjuaW2/8lFTj/Y=;
 b=O6WysNUgYY2ATK2Bkxy3MWYM0RGitl8sIxX2zpTeOBADTSS2qezhdb9bklipGkYYk2
 K8FmXDhE/sByCEio9bmWvJf6PZ9QUJAgS3Fl/stT+5wHpWlIVQKp9lcE7RQnEP8wMZEs
 hEcrQ/FKVQAyDPajHrafVIs1ytqC3Wb2bUepAEDKXXOMzFpBFzTXijnk9FoloPSEtw7M
 S7QTqu8diYlAlcoMAS+yMMQ2Qe8JCUVVeODl4zEOklZBLyqr9/oRQcp/nvu812ANyT2o
 aRGmD75/Lf4700RbsXLqQDWbcKzKq3BEhbVn3L6uyiXalDB2P7iNxqtS/FR6MSrtefd/
 ZN4g==
X-Gm-Message-State: AFuF++m3+i02PNmX5jE8LLN4n8dS7mc/lTJd0MJmv8IF/0BAal0+HgLw
 Dwa6nEC10ogAuN0HQjDUfiKElGYpkFFS2wroip+BElpO4Cy101kC8xpTqLMBmlHb4uLkdSMnVef
 Xh7viWbc=
X-Gm-Gg: AYBFou2MrhYsH673liDg3lN25I7G/21qwNUariIVI97QyCq1XCfnf81u7s3AOpfQ2u9
 7ivWF+j78okpTSHyOqixiY3gLZWS2gdebkN8wfhL6y3btXRvYql21A/NqN/EKR+8Pmohsg1xMAw
 XOHcnD2GCxO/RY8eoyyZZ7pcqmK6f0MT6qWp14gLNWQ0Cf8uBmxYwt/4KX0+/qP2nIHV4GAOs8C
 WC7gwb9wFK7QGQSmAuvNA9UtRuVuBS+zRLnYkjhVbs8dCW62E+eRUnVPPfxYnG+m6JVZRTQscxh
 3xKrnRRyqflQpeeGSIhRjbSaktPY9YiNNnnCeANOpdki/1H44vriGX6ywFbzLZMLeTMAwO7EouD
 vpIRWItEbMXSy6cnrQ0hhoWU882Gs7npjjzV86Hk5/rCgJWOt4xyhkVQ3kSo6zqOVvzfQFFonuB
 ocS0SU5Ey0vmLwI4cG9YbjGZGHp8WzgS/exDPAMhxuzq4FbkLuzPYv341vO2WvmbpEoraT/L48Z
 OARofZSijYWqM+QnA==
X-Received: by 2002:a17:90b:2b47:b0:39e:888:3841 with SMTP id
 98e67ed59e1d1-39e36106e9amr3407087a91.16.1789619561893; 
 Wed, 16 Sep 2026 21:32:41 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 072/101] tcg: Generic expansion of tcg_gen_ext16u_*
Date: Wed, 16 Sep 2026 18:27:54 -1000
Message-ID: <20260917042823.542588-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 8f4d1dd633c..3d01609810a 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -143,7 +143,6 @@ void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -185,7 +184,6 @@ void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, MemOp opc);
 void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index cb8436e3b39..dfad7288bb4 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -21,6 +21,7 @@ DEF3(divu, TCGV, TCGV, TCGV)
 DEF2(ext8s, TCGV, TCGV)
 DEF2(ext8u, TCGV, TCGV)
 DEF2(ext16s, TCGV, TCGV)
+DEF2(ext16u, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 15e0f697535..31122a5950d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -699,6 +699,11 @@ static void gen_ext16s(TCGType type, TCGTemp *dst, TCGTemp *src)
     gen_sextract(type, dst, src, 0, 16);
 }
 
+static void gen_ext16u(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    gen_extract(type, dst, src, 0, 16);
+}
+
 static void gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
                         unsigned int ofs, unsigned int len)
 {
@@ -1284,11 +1289,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i64(t1);
 }
 
-void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_extract_i32(ret, arg, 0, 16);
-}
-
 /*
  * Internal helper for bit and byte reversal.
  * Given a repeating matched block of 1's and 0's, swap the bits within
@@ -1580,11 +1580,6 @@ void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_sextract_i64(ret, arg, 0, 32);
 }
 
-void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_extract_i64(ret, arg, 0, 16);
-}
-
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_extract_i64(ret, arg, 0, 32);
-- 
2.53.0


