Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ACA606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yy+aMhKb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmTP-0003Oj-CS; Fri, 30 Oct 2026 09:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSi-0002YX-HC
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:06 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSd-0005UZ-AB
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:02 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6f8a519e215so648046eaf.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793366157; x=1793970957; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FQtSYNQ9FYu489GYjbt0/q1hC/7cQF6o3qMq6jMUhtw=;
 b=yy+aMhKb1C78GmN2/HMM6p9dJTOpgJNsewp7PSg33wQVS92ZVx3mahZkFi2bwNc+EC
 zHP+/dCcracz6fgVtEfI2gQioRdZ+2Vo09+i0F6gT6OUYRS9adpMkxBgd+2N83llL7TA
 V9V422DylfX93KCFosElbbwGGWSgPT+czlfxkJJEKrlmXNzSqrB3yi0j4sVFlpN7/K/h
 DhQdu0ic/vmsksq1JETXw0w5dwhj0SafeAb5QeCiTYxvh4SZgmUjllyX1fvjK8E/EizY
 am9RfiiQ2Ky2QNrs6TUj+jqhRTVUIelsLRbfnuPcz5/gZVDmrMuyzngncyOi/8aX5tGq
 G/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793366157; x=1793970957;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FQtSYNQ9FYu489GYjbt0/q1hC/7cQF6o3qMq6jMUhtw=;
 b=1sNxa+GVa6nGqBTyUxWEjxpSBJ0nDEr/tTXvCDvBJ6C72/N25bNpzvGMkZMWcBtGp4
 e3HMScufjx3wmWwpjgVf87YxK/k7BGwgVgINg6j3I6rUZeij8ecWikTjSe2Q2OehSZDM
 5wKaXYy+3RVQQMfQ1TIxzULNFYw/RYAKq2BfQzoQ4tfThxAgamllIbb0V77na9rbE+W+
 bAnPvd1XtrsLl/ib7ATMji6XG0s7yLJWOmA3/dBGraS0085XFUDW597v/eqnGIuMnJTD
 vIXzCTImMZzdrHc/HqLw7aEok0THMXh9LBrJj411Q6ueWgqPWYghqLPbe1r0np11r0OO
 j9ww==
X-Gm-Message-State: AFq9FYIqEa/x08TMrPcF0kQXU3nhg1pW77Aih6XIQdWJxo8w10H7/k7Y
 2rOchIxDw4cqZ+YmeT7zqpk3V/6Au/xHG1laexE1aJoxjz8HFXG11/3HIKwJjd2XvsW6Rb7TF9r
 CME0C
X-Gm-Gg: AYBFou1og8HJMwmimGAsgETCTBpokZ6h/Yf8t5/ff43nAbkhApX9GQWRB0JwjFfEQn5
 S4NVsleI5ZJ8IW6dJlKlmz6CYdtnaTornzlrm8135KcT7lJAmdzWXxrYnPjD5qWsc+lcmkew7o7
 8Rfq6ERDScqhE6lz+MoTruXVkqsrzfko2F75uSeEhVmxZvjxE4Qj5UU5Ao1IRc5//L5DOFC2K5A
 ZczUsGG1bHFVCZK2IiClaXx+Xma0XWTG8p8w3U9+1B7kniocWFtp/eEEgfrIez8exIxo5SIBWig
 UoWA8jV9hdVVVY1j/e1hIPCapquBACmMODdbJOp9tLdI2viZz8V0OO2tq5HxbPwDJZVvhW1vjYE
 CZScmNPS9VXEDxuOzm70cf8SO8ybe9YBHQgTn6XylxtaSP5XZ191xSt+ch2OZNOYdT5AdIS8mfd
 XtPT7I4KhINBMhAXzLamisfzI8Ej5IkdPokvfd0WL3KQ3xT65fOgQxJzxeru3jCxZLUAIbexU6u
 lpp8i2TpH5SywNQ5AjqEiJJOmBUyNAhs68XUgTAEAhV4Z8NHwaW4A3UoSNHhaZQ88WVhg/MtmL7
 4q0AB/EUZdFoMJRxgBtC714wxfL6dA==
X-Received: by 2002:a05:6820:308a:b0:6d8:462d:2755 with SMTP id
 006d021491bc7-714ddf3c652mr2982990eaf.37.1793366156856; 
 Fri, 30 Oct 2026 06:15:56 -0700 (PDT)
Received: from stoup ([50.233.235.3]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4e6bcsm1796812fac.3.2026.10.30.06.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:15:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 01/19] tcg: Adjust NONNULL annotation on *_diff functions
Date: Fri, 30 Oct 2026 08:15:36 -0500
Message-ID: <20261030131554.41208-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030131554.41208-1-richard.henderson@linaro.org>
References: <20261030131554.41208-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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

In tcg/sparc64 we use tcg_tbrel_diff with NULL as a negative
addend in a relocation.

Fixes: b0b6701a4018 ("tcg: Annotate functions in tcg.h with QEMU_*_NONNULL")
Reported-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/tcg/tcg.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 8f409b23b7..3dc26b919d 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -881,7 +881,6 @@ static inline TCGLabel *arg_label(TCGArg i)
  * This version relies on GCC's void pointer arithmetic to get the
  * correct result.
  */
-QEMU_ARG_NONNULL
 static inline ptrdiff_t tcg_ptr_byte_diff(const void *a, const void *b)
 {
     return a - b;
@@ -895,7 +894,7 @@ static inline ptrdiff_t tcg_ptr_byte_diff(const void *a, const void *b)
  * Produce a pc-relative difference, from the current code_ptr
  * to the destination address.
  */
-QEMU_ARG_NONNULL
+QEMU_ARG_LIST_NONNULL(1)
 static inline ptrdiff_t tcg_pcrel_diff(TCGContext *s, const void *target)
 {
     return tcg_ptr_byte_diff(target, tcg_splitwx_to_rx(s->code_ptr));
@@ -909,7 +908,7 @@ static inline ptrdiff_t tcg_pcrel_diff(TCGContext *s, const void *target)
  * Produce a difference, from the beginning of the current TB code
  * to the destination address.
  */
-QEMU_ARG_NONNULL
+QEMU_ARG_LIST_NONNULL(1)
 static inline ptrdiff_t tcg_tbrel_diff(TCGContext *s, const void *target)
 {
     return tcg_ptr_byte_diff(target, tcg_splitwx_to_rx(s->code_buf));
-- 
2.53.0


