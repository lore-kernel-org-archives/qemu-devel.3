Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712C1EB3649
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 01:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxEFi-0000Dt-D8; Mon, 02 Mar 2026 20:08:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vxEFg-0000CQ-0b
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:08:44 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vxEFe-00070x-GY
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:08:43 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-8274936d2c0so4959548b3a.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 17:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772500121; x=1773104921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eHJ/eVj2wNNCKYeA+lB5DwgkkKexFySSKIuwu8LcZP4=;
 b=vZAQHzk8f4HaXsfFm0AfurPdaV/rVibz4BAh6yLgmNrIiqJ2SqPdFUSnjNiS1BEse3
 p3n1Px0kcCXczgugHS147o6+LFkcEzz9sTUmVaHFFzpYV1WRvrRdsTllgAwBn/tZep/x
 yB1Jd2uQ2f5T5ZA+E4dYbb1T+yOAGucTZ/vkog2A821Q1/FW43AbXLI4wnV27XliMBYT
 XSUOKLA8cg8YLRVtdRYG1B2iFXU3r3j3bVKxLEgMMINsXWAkaCpc+5YM1OLtQQ2VT2cz
 NjtDEt0z9H4dO9r5ruW0JI4IqY8ll5VzJtqNLSOmt+iHFFAL+5SOJ+Zbl+V7fhh1Yp5t
 gg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772500121; x=1773104921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eHJ/eVj2wNNCKYeA+lB5DwgkkKexFySSKIuwu8LcZP4=;
 b=N/IltUaPv6+aV/bpMz9Cxxpm0X/7vkwP1DX0p058LvZxY+0s2u/ou1GIqR507m3qVb
 iM8dLW0A2EZr7PyvSb5T/fMJm+vKoATDoTyUT5ysUZraVQijvv1lRfgEm4Dl2DR+EOJu
 QFNGPR2j9nFe0V9Vp5CuJ3Wm3cK6vbwmCFfTLYVKYlgDBTT+haTImAUbzgx9uGX7tzVY
 rLgcqTDb4arYNFcjPL4abFU7luanJ5fZ51DVvJfSjC4AsAl6T54OsHkqleXfflGs6dIx
 ykvGxQzdI5//r4ZoCLXFknbRtFVYtovb8LX9qDtwa4wTn0HwXdRaJy7Ar5EdmINMKobB
 MsCw==
X-Gm-Message-State: AOJu0YwFawxApMdJtqSE+pCYeuj7kw8O77zxhjAJS7+c3aARJrF2sPEB
 yIVXzLFs1vVYtMUzW+zASemfLpLp9JmEUPaoKq1KG6sqFsHXZcmRXL1EhvBdigQSwr0l/HWkGQW
 HQzL6z5U=
X-Gm-Gg: ATEYQzwFdc+QeRnCQIJ36lITlfMswUTWHMrYl25i6OxUWhr7Vxg1wN/fV2aygKWtLZP
 XiGp9ZFRhwEn8bPdfCJohHpR5yI44y9IixWvYvNn9h5GUJXVOipdHsERLXhkCjiAzwxYO/+2vLP
 Yj3Y+6GuRaQkvRpfqZIONNJ5se9XYtrw+Qm7tnv+qw12tXJ9djn4uip6BtcOG04kJt0an1fjueP
 aRfsBxelCKgS9vjHEBIL1zfDUto3kA9VR0+HQFw2GA4GKEr3bmmjeAJ4ZuRFf1jPXw5dOrRiueN
 ZWabf1OWooYw11grFxS2NmkagV/xyqH5UFpW3ZNjF3A5aJmLjlUkfWZZMF96prVyimGdtQeWBcn
 ihlMYbDPAoJZUq8fCw3k58LVUQkIK4LYj0BrlJ6ShIf9gyvsHL6ZNYC048DMTMjKVpL9VUTYHIB
 B7r8/hjKFlVmeyrO0AKCZyHoAoL1sDcg==
X-Received: by 2002:a05:6a00:ad86:b0:81f:9bc0:e45e with SMTP id
 d2e1a72fcca58-8274da23639mr11134212b3a.65.1772500120776; 
 Mon, 02 Mar 2026 17:08:40 -0800 (PST)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739d94de6sm14484988b3a.24.2026.03.02.17.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 17:08:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	jim.macarthur@linaro.org
Subject: [PATCH v3 1/7] tcg: Drop extract+shl expansions in tcg_gen_deposit_z_*
Date: Tue,  3 Mar 2026 12:08:26 +1100
Message-ID: <20260303010833.1115741-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303010833.1115741-1-richard.henderson@linaro.org>
References: <20260303010833.1115741-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

The extract+shl expansion is handled in tcg_gen_andi_*
by preferring supported extract.

The shl+extract expansion is simply removed for now; it was
only present for slightly smaller code generation on x86.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8d67acc4fc..b95b07efb5 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -937,21 +937,6 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
         TCGv_i32 zero = tcg_constant_i32(0);
         tcg_gen_op5ii_i32(INDEX_op_deposit, ret, zero, arg, ofs, len);
     } else {
-        /*
-         * To help two-operand hosts we prefer to zero-extend first,
-         * which allows ARG to stay live.
-         */
-        if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, len)) {
-            tcg_gen_extract_i32(ret, arg, 0, len);
-            tcg_gen_shli_i32(ret, ret, ofs);
-            return;
-        }
-        /* Otherwise prefer zero-extension over AND for code size.  */
-        if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, ofs + len)) {
-            tcg_gen_shli_i32(ret, arg, ofs);
-            tcg_gen_extract_i32(ret, ret, 0, ofs + len);
-            return;
-        }
         tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
         tcg_gen_shli_i32(ret, ret, ofs);
     }
@@ -2210,21 +2195,6 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
         TCGv_i64 zero = tcg_constant_i64(0);
         tcg_gen_op5ii_i64(INDEX_op_deposit, ret, zero, arg, ofs, len);
     } else {
-        /*
-         * To help two-operand hosts we prefer to zero-extend first,
-         * which allows ARG to stay live.
-         */
-        if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, len)) {
-            tcg_gen_extract_i64(ret, arg, 0, len);
-            tcg_gen_shli_i64(ret, ret, ofs);
-            return;
-        }
-        /* Otherwise prefer zero-extension over AND for code size.  */
-        if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, ofs + len)) {
-            tcg_gen_shli_i64(ret, arg, ofs);
-            tcg_gen_extract_i64(ret, ret, 0, ofs + len);
-            return;
-        }
         tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
         tcg_gen_shli_i64(ret, ret, ofs);
     }
-- 
2.43.0


