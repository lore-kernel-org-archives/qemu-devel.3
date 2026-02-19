Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38718E9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 04:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsvFL-0008U2-6I; Wed, 18 Feb 2026 23:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsvF6-0008OR-R4
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 23:02:20 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsvF3-0001EU-D4
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 23:02:20 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a963f49234so1761725ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 20:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771473736; x=1772078536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VA/qlQJvE8uq8B0wfP8QzURuC1Jx2blScgULUKFJUFo=;
 b=ysYNwZXvvUkAVLpk3NZdUulGXdczpr4CgAxgzvWik42ehTAoOXBFATpyXZjhHWEWAg
 bSLCPrf9F30qbTTrnGvi4VxzbxYzVDoRLuEvH2qbmxdfnc8H4Y818Bkl1J53XoN0hAhz
 Gj1xR9cG3Bd7R+UdgA86aVF2VQvHP7aDKe5wavLEdH6Q05AOaJvOONmu+YWyvwTKBpN+
 HBJbvCQzOT7bL9eQEsKPvGfmqe7B2TxHWWPNndyMTRQAUSlY5HmloDrQOMNgscBqSpQm
 z0x3gSQEv298tgUZBbKIo4WzlaWUZTwXfKFZYrm27/7IREUXtEY6V682QK1clqW0WXGG
 Ku1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771473736; x=1772078536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VA/qlQJvE8uq8B0wfP8QzURuC1Jx2blScgULUKFJUFo=;
 b=XR7VSQij8w/yaDu1kTJKaORcohvkPwffWCt03+4dlgL14nffhmP1uEch8LWfhQWqtD
 5uuAyRGoJhBOyzNgImmH5ngIPDV7SRhXCPC06DRL3LJTW6Iy+ryla4A89tUemkmEt0DD
 pI9/aJKYA5Fm92tNGKnp5qGbgVgc4fwUFEFndXM7gPT7ymd9YEGBag4TqGbSV8dfhFw8
 VtvpLYRWBiZ2c1i8XZBg8Z0hTJ+TR+hw3vSmlKDkP9vxfTj73pvI/tFp9qg2bJuUY1Fx
 NjK5alGjIuZk0hQgUcdfvJYinpkvn/HHbp+PgW3Am8/JXGlH3rZAhAeOJo68cIKocs/l
 j3gQ==
X-Gm-Message-State: AOJu0Yz7rRN2N0sZrGPmtwjcbDjUhVKXfIh5MBIJ+M3315bCrfyistat
 NIqWeERIYWQuteG7u8hzdPDmqlFF7aAsZunxjTO0gm/UOkHGUOkwVEXdJS6SVvdWIJbHVGio1k3
 T/YKL
X-Gm-Gg: AZuq6aL0T+LOv9eFgjcm64Lm6lbcDJRCueK7YtUO8q+UE0TGKDmRqil2TtLLgmJHwBD
 usL/0Ccb5VF3MSNwU+5ooqivjvYu/plR79tlJk0EwBA4BPLvFqtLNdEILjdtIx4JnVyVUL0fWMo
 KEc7wCaM/HDzGaQo4n4WR4enRj09DL3mVjxv9RtuLPKED0B6SC7zUFWhsV1tkHAFdCLCjYa2uPK
 g3C3LQ87aS3yFvR9M3zSwIrUE+qvhnV2ZzoIS523n9Fw1CkoCRGOdI8ksM4dVnUc3+3E4cr/R+m
 u98KtZdTcTSaM6a5icN31J8pjWNX2pCPK3NF7UKSu9e+/P+Q0yeZjUp4/6JHm0zhqD9wpR29AbS
 lpFtobfjm+KyBpP/aoXh3exh7Z7E9jdATYGRGpXGA03/dLZKQzds0+Q5aaEesSLtChLenoQB67f
 XTyc8IUcFS0OnsoVU+M75IfW4HUnPfKkXKFPdJZd6ILqS8qoAVspNyqlENaFxSIE5Ufi49bHPIJ
 RIz
X-Received: by 2002:a17:903:320e:b0:2a9:5c0b:e5f4 with SMTP id
 d9443c01a7336-2ab505c0e87mr162715635ad.28.1771473735974; 
 Wed, 18 Feb 2026 20:02:15 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a73200asm147636225ad.36.2026.02.18.20.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 20:02:15 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH v4 07/14] tcg: move tcg_use_softmmu to tcg/tcg-internal.h
Date: Wed, 18 Feb 2026 20:01:43 -0800
Message-ID: <20260219040150.2098396-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219040150.2098396-1-pierrick.bouvier@linaro.org>
References: <20260219040150.2098396-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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


