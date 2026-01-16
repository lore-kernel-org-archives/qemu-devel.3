Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4CFD4A5F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgacg-00031T-5W; Thu, 15 Jan 2026 22:35:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgace-0002vs-Vc
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:41 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgacd-0006Ot-EV
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:40 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-81df6a302b1so1443126b3a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534538; x=1769139338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1nYgK0g6eEdhcQX8r1Op2+JuLhyO76+gPoRJlKgReBU=;
 b=K30XdxEW14xKWdYz/tlCzpMopWm7ZU6n34WOgrYYxN6mK91D39ujh9j+owotDzaIc/
 GF5q5nSChUyJiDbL0BmrM9beGcwCX7mJeQkojDGMDaVRx1BwwSxRNkCWZiCofdVV9Rbi
 +i7CrdGzDz6QOGm5ql3V7nqxT3Yzn/RqNRpnzycVS0VK72+nRVsEO3oKOsVYqteFtdZP
 fUpzg83d/620zj0RMYie/fWiaoBamVu6T3kUAdduJrUOtkpgsZSqu6z52JrVH6eFCqq6
 sPsMrLasfukwmewf0gaqc3An+tuNgPCzVAm5UHrscqyzu6hHTcO5ZmMoc95SS2VAYUdo
 BVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534538; x=1769139338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1nYgK0g6eEdhcQX8r1Op2+JuLhyO76+gPoRJlKgReBU=;
 b=bg0GJCVoSkZuD4SKngSQn/0CaCMdHpSO2svT0c2I30Iu/Gf4668XZ/0dEAEAoPphlk
 JDqcKSTNYVKbuuvabOQztU2yceuk5CQn9NkZDYOx1cnbO0tliyFwHdbL5yoIxfLjSLx/
 0vnAfw6AL5HqXEFaMPkPsCb94jio9MjoVqGN1iMoMT2mV22MJb56fbFHVpvtBiXySlc4
 3FwWMwnTGjaZ9yRwdn3o1TpkFTO9VS7jUXbXlgA/ROPho5d8qboG5cP5zAx52W3uDXaI
 spmvYz3P060goVnPxlGhExHRWSNk4qOC6KeUPk1CXOkmGuDG+380IY8isIc5LoCg4kBB
 ZkIA==
X-Gm-Message-State: AOJu0Yzw7Glvjgf+YXK3TArtq0AjrFYWibaDnhRli/VSxmkhVL0zSWcQ
 UC6jNzZG4wZOEzGAOISj1upqeKCx6Qyw6DcBdZUq/I7ABPb2W7ESP4/YdubDOOyynQjsEPs3yVM
 OgvVe2oX0hQ==
X-Gm-Gg: AY/fxX71lyVQrjp2SxzC+Kxlr/B0BY16+gpnzGVbWmTK3emkpfQxSP1uj7UNV0+gces
 19H4HZVimsiARamWy7+V6/7xgWckTu7ZtJ/ht3srZtQJd/Jzis+HfWN5vexA3N1siJUJFZAapwm
 /RIABNQlsHJ0an46+1Z19TiXRuMkVc+ndu3zesJvz7QxvtdFvxbDfo1ov4HOTnvbnkq8Ru5/NjK
 DklII2Xwy7Y3Hy8qviU3wSapRlAPGOwTHyNrZ2CeZCkSgIKCrA6yZjuTd8QzEQvU9FyHzXRLqRt
 pEPRyw+1Es4k3AKnp7bv/iGnzXuJkHe4bchLkiRBf0RjrslXafXPdH9TID9SYmQFv8MZc+DmkHs
 KDVoj7q7kMcXf46OtRHIx3p4CZ0FyxG12gPeFjPaXUWxAnexKPm28chhzaNXLUEU9rQoJMs0FGb
 9bknOqp8gAlOJnA563bA==
X-Received: by 2002:a05:6a00:1ad2:b0:81f:3b74:5812 with SMTP id
 d2e1a72fcca58-81fa17bedd4mr1110502b3a.31.1768534537823; 
 Thu, 15 Jan 2026 19:35:37 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:35:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 37/58] tcg: Drop TCG_TARGET_REG_BITS test in tcg-has.h
Date: Fri, 16 Jan 2026 14:32:43 +1100
Message-ID: <20260116033305.51162-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-has.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 2fc0e50d20..27771dc7f0 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -9,11 +9,6 @@
 
 #include "tcg-target-has.h"
 
-#if TCG_TARGET_REG_BITS == 32
-/* Turn some undef macros into false macros.  */
-#define TCG_TARGET_HAS_extr_i64_i32     0
-#endif
-
 #if !defined(TCG_TARGET_HAS_v64) \
     && !defined(TCG_TARGET_HAS_v128) \
     && !defined(TCG_TARGET_HAS_v256)
-- 
2.43.0


