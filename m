Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A26606A32F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MHHKCgA4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJI6-0002JJ-IO; Tue, 17 Nov 2026 08:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTJI1-0002HI-Vb
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:32:03 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTJI0-0000m8-81
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:32:01 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-491846221ffso4247008f8f.3
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 05:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794922317; x=1795527117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6DvBl4prp1tbtnSVOBObXljk8K67ZY3zSXKpym1/XGA=;
 b=MHHKCgA4L4pQZyeuPbpyBLkNFja8rmy33xfICmYw8TVfGp9AvIfJcEAcBhMyFwqghK
 +ri13O71CIyafyDhxFIIIPTq8kaRohAARHA6OxxeNtrspGHGOGq0/i7W4IxzJB+pn26O
 nuQ/jsy8UK11zwwazcAhm5GXf+hD5li328U8gJDQvDS6+nb8IkF+Z8YGlf5Vq0V5kX7W
 KkRJkOenyyR1w93PCSROGZTj7gF1eaqCj4iPBfJrFjbd7evjWP+yc6H/KuRWimMhiqOo
 LONdzX0cckl+UIglrTXKbdpDOIGDBx05BxIdRAG5JBVaUPstbjKpUjR5DZn0XBUjSjVx
 OXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794922317; x=1795527117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6DvBl4prp1tbtnSVOBObXljk8K67ZY3zSXKpym1/XGA=;
 b=WTX22UA5KcoueO9op0TKAhr+oxj6j456vxRY25nDSJebA9oxLPBvN/JCmppWzhVpP3
 TaAjKpHQ3rmq4ySnigo99hy7Yw/lmJsaV1hK8wiE6O0g5SUO8zaIFb1+MILr4WTfm13G
 LpFYnwNZE05lQ8fYo+MxtEzHgmBCo6iS7rdxQjS+FerjRi28ADlITiILjUuIhDumtjrS
 n3IeiIMQmFI5Z8IH1vmOtXdYpsJ8nh+fGdb8IA3uK0IBgXVjd0uD0JIjoQCym7/P/Hzj
 37KUXi1bz3KxG68X48kR/F5PjbjHoDwCwjHvsEkzAtvUE6gVEtp3EEaQ0cwzjIc1qmF6
 WjsA==
X-Gm-Message-State: APuU4Z+jxJnbvUKZJGvEVpRWComo+jqtDp3W9zzt3cBSH6/T4MBqPhA1
 lEBjML3PQO84inQ+sDIGgfx7OMMx2HJKmj9aPRluDK14y4woBGnXcRrrvuUWBbRLv9gwrbLbtYV
 WPsPL4Qw=
X-Gm-Gg: AZFdTZculjlOhXuExeeGwS50zwuXQ8x9YQp0e5PyAk+UkNRAsn//u6a9YW7Sr4/FGy/
 XYkgdOWQPIVJwsX12RU9m3Zn8GNh7pb9kSmRg+2JQDCugr4ctC9kvY1Fi5Ez7zfgD2D+s+KMkph
 Lz8I/e76E/+uyfsiwlQPQ2rG7yayeETqrHsF5Bx2JSXZ4HrTWDgDliec24fUSLXxzskFXIWyek4
 WAaHlf+EQarlEz48RhgWD/dPwcRpFCcVmcnijAKMBnPfBjM61SCxCbJQJGLGy3BsNazLhoAyZ+f
 n9B/Lo/6PB1pLAhP2s9SEpaohhY5RnJnJTD3JCkJt8mRuXX9aa5PzUcP7aWKNUrHIRxSZEzr/2c
 j66JEgvsxmBbwt0VSM5CLwYaVSTl79yEeWVYVflt0nXTPngQRqgQ4UYc+7HrJCHhvJRVftEOcuL
 FnmQ7NMSIMrsZ0W2d57GHJkgecmCfTLQ6pN2SKv9jVgiawLzWab4wFP7/9ad4veNzfib7/6x82q
 7umHN3r6aCYMvThlyvmpkJ9b952OP2qBoQA4zjl8IijTFV3MKfjuKNv9GgsFxLMKCwUVgtgXbnp
 5s0GZ+f85d4YV/ENOLWzPeq9m3Gl7FT5AyInVt7Yex0VkmC8Br4rRFPo/C5xhNuNpVfDOHFdAzo
 DDeBTv/tjYrrRBGzpiN4rg8wgPteAmlYPJw==
X-Received: by 2002:a5d:584b:0:b0:491:f34b:49b4 with SMTP id
 ffacd0b85a97d-49c729bb9ffmr28737083f8f.44.1794922316894; 
 Tue, 17 Nov 2026 05:31:56 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c8a77sm28516886f8f.49.2026.11.17.05.31.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 05:31:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/8] target/arm: Fix barrier polarity of A32 LDA load-acquire
Date: Tue, 17 Nov 2026 13:31:47 +0000
Message-ID: <20261117133149.2108068-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117133149.2108068-1-peter.maydell@linaro.org>
References: <20261117133149.2108068-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

The A32 and T32 load-acquire instructions LDA, LDAB and LDAH must be
ordered before the memory accesses that follow them, so their
translator has to emit a trailing barrier.  op_lda() emits that barrier
with TCG_BAR_STRL instead of TCG_BAR_LDAQ, inverting the polarity:
TCG_BAR_STRL annotates a leading barrier ("previous ops will not be
delayed") and TCG_BAR_LDAQ a trailing one ("following ops will not come
forward"), as documented in include/tcg/tcg-mo.h.

The x86 and aarch64 backends only look at the TCG_MO_* bits, which the
wrong annotation does not affect, so the generated host code is
unchanged on those hosts.  The annotation is still wrong: it violates
the TCG barrier contract, it lets the optimizer's barrier merging in
fold_mb() combine the barriers of an "LDA; STL" pair into a weaker one
than the correctly annotated form (STRL|STRL stays STRL instead of
LDAQ|STRL = SC), and it diverges from every other load-acquire
translation in the target, which all use TCG_BAR_LDAQ.

Fix the polarity.

Cc: qemu-stable@nongnu.org
Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 20a58a24134..442c34ce84f 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -4458,7 +4458,7 @@ static bool op_lda(DisasContext *s, arg_LDA *a, MemOp mop)
     disas_set_da_iss(s, mop, a->rt | ISSIsAcqRel);
 
     store_reg(s, a->rt, tmp);
-    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
     return true;
 }
 
-- 
2.43.0


