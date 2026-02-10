Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FE7EB2700
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 20:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpu9N-0007x7-Sr; Tue, 10 Feb 2026 15:15:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpu9J-0007mz-B2
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:15:53 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpu9H-0008AJ-9F
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:15:52 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2aaf43014d0so16733015ad.2
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 12:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770754550; x=1771359350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VA/qlQJvE8uq8B0wfP8QzURuC1Jx2blScgULUKFJUFo=;
 b=bwHLPgjFbLltWCVfHlygRpU26Pl2NHNSNW3RUNP+7kxYT6wDSyGYsIKB1Z+KuavnT2
 7za3doF9F8xYsSb5aE0B0MLuBQWtcQ3dVEbNlbCi/3RHJiaq4sr/xQCPL1t4Y0xu2V6T
 LHd/TDfATieVn3tQKG2i5Z3SRwCBJRctAdUyi/5zm5DysqwQhlIs7w5TAjCWu4w1dzJR
 6Yq46XqTCP7s61qLfytlM289WXa5hq9sYbGvYg3g7E0ENRDHaqJu/zX9By7cEOIbwT2Z
 DtM7J9BcJox2oOmCUobv0egbwoIq5rS2fBUCg4Rb2wwS4nZaO5THyskYzT0Z171ym9ky
 AWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770754550; x=1771359350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VA/qlQJvE8uq8B0wfP8QzURuC1Jx2blScgULUKFJUFo=;
 b=Ku6E6pPXl87u+ys9kUAeyQRtSQBB92/3h1fCSEDb7/s8xsFafZnsHBjqtGqdMbXP28
 +NQvGUvewGEmvl/74UUdPfrkG641szq2jqWAnEsGyAGKlSZR1ucZfGkgjsgHi+AbuCAf
 9Q2PETtomjIY8chO4FE9Oh/4WRcP2HBajXYbi5Wh2IxOUqIe8hTzJpwbI7ij1JuznsCS
 DnaQEgpatrk2Xs4t1tEOSktl0vnbImArYHck7e6tSGZrr42JFqO4RxkRboZv5hct3C8W
 xBnHCM3tunTlMTB6PgMmRZiC8ezmKPFZZqrwu02KCNbMXF8v6ZpFexeCOgPteqm/II+t
 N93Q==
X-Gm-Message-State: AOJu0YyQow5l61jf+X9qvL7S8B+QEkUJEy0H/pLZsZ8Oh3KkaaOpp9Qt
 k37mu5zH8jHcntyO72iMqjVfU93PWQ6UPo2qE04lwzm+Ru++ezyv5iLkKf5qG92nz1ds/jkOms/
 LiJPI
X-Gm-Gg: AZuq6aI2jKEmxItylDP5KfuqUFOzYPmpSi8zlcUuDxVEQC+r59CeD8TcnHsHLBlCiUu
 G48HXCf6wsa5kpoEz3ffJAtvNGce3FC+sL4/3kKWHWOdu6IbX58zGQaiujONcVGPKkQJg471VZX
 D5tU3KvZntEUu/AkpuysLkrRg3Y0ws3FIHe8mSxEhYSa4MydhWiTEJTHLitLve5X0xpnCiApzEm
 B72ZrlwTRuALKPVoupeyAXOgo1TlbWjEsqLs0tYW/ZWf9ebt/8UxmaLYXuO4ExP3o+++eXO+8sK
 LvexOQjErvZdbNNYLEUPSMfUpPy1MnjsZl+5n5GbTDeqpKSL8ZgcC1FaNY6Pzz4zuypbJur1mc6
 FUamT27DD5GMWlM1qi3/6l2l3zAR10/6dhElak7yUJjng0qmwECRGN3KjbDMr24zfuYV5JuL5HK
 2j2eN/TGnb2afSUw7R1Gm/evgE5KV07W6rAtqY1/cuUxZe/Y8/X98ZZuKANhFy8s9Fl9TXSoxZs
 0uT8S982Vs5M1Y=
X-Received: by 2002:a17:902:f601:b0:2a7:5751:5b30 with SMTP id
 d9443c01a7336-2ab10549744mr34280145ad.12.1770754549501; 
 Tue, 10 Feb 2026 12:15:49 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab0b392cb5sm38523225ad.70.2026.02.10.12.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 12:15:49 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Jim MacArthur <jim.macarthur@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 05/12] tcg: move tcg_use_softmmu to tcg/tcg-internal.h
Date: Tue, 10 Feb 2026 12:15:33 -0800
Message-ID: <20260210201540.1405424-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210201540.1405424-1-pierrick.bouvier@linaro.org>
References: <20260210201540.1405424-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

In next commit, we'll apply same helper pattern for base helpers
remaining.

Our new helper pattern always include helper-*-common.h, which ends up
including include/tcg/tcg.h, which contains one occurrence of
CONFIG_USER_ONLY.
Thus, common files not being duplicated between system and target
relying on helpers will fail to compile. Existing occurrences are:
- target/arm/tcg/arith_helper.c
- target/arm/tcg/crypto_helper.c

This occurrence of CONFIG_USER_ONLY is for defining variable
tcg_use_softmmu, and we rely on dead code elimination with it in various
tcg-target.c.inc.

Thus, move its definition to tcg/tcg-internal.h, so helpers can be
included by common files. Also, change it to a define, as it has fixed
values for now.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/tcg/tcg.h  | 6 ------
 tcg/tcg-internal.h | 6 ++++++
 tcg/tcg.c          | 4 ----
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 60942ce05c2..45c7e118c3d 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -445,12 +445,6 @@ static inline bool temp_readonly(TCGTemp *ts)
     return ts->kind >= TEMP_FIXED;
 }
 
-#ifdef CONFIG_USER_ONLY
-extern bool tcg_use_softmmu;
-#else
-#define tcg_use_softmmu  true
-#endif
-
 extern __thread TCGContext *tcg_ctx;
 extern const void *tcg_code_gen_epilogue;
 extern uintptr_t tcg_splitwx_diff;
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 2cbfb5d5caa..26156846120 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -34,6 +34,12 @@ extern TCGContext **tcg_ctxs;
 extern unsigned int tcg_cur_ctxs;
 extern unsigned int tcg_max_ctxs;
 
+#ifdef CONFIG_USER_ONLY
+#define tcg_use_softmmu false
+#else
+#define tcg_use_softmmu true
+#endif
+
 void tcg_region_init(size_t tb_size, int splitwx, unsigned max_threads);
 bool tcg_region_alloc(TCGContext *s);
 void tcg_region_initial_alloc(TCGContext *s);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index e7bf4dad4ee..3111e1f4265 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -236,10 +236,6 @@ static TCGAtomAlign atom_and_align_for_opc(TCGContext *s, MemOp opc,
                                            MemOp host_atom, bool allow_two_ops)
     __attribute__((unused));
 
-#ifdef CONFIG_USER_ONLY
-bool tcg_use_softmmu;
-#endif
-
 TCGContext tcg_init_ctx;
 __thread TCGContext *tcg_ctx;
 
-- 
2.47.3


