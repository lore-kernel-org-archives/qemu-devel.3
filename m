Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6EEFB5186
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9wAg-0007V0-Qt; Mon, 06 Apr 2026 22:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAd-0007Te-VH
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:04 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAb-0006wZ-2B
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:02 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-358e3cc5e7eso2174716a91.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 19:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775528879; x=1776133679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTl6UdXPMq3a4SAQ816+q1nAoDgsRIfLxCudW7enz6A=;
 b=m+sd/FrIYi1tqVd3NMPqbwAh40Ugmw/l6sySEb67T9fH/ie3Dg+Dl25X0Sytz+lErB
 VRH6i6qcGXZQl3+TIu/c3wVhLi2HG9BPkjrhqUCHj5oh5ysXTrjGUBdfxY9Cl2z6zGxs
 n2QL5zs6C7kZEa9DjdPtVcYbuiONMBvTbuvJDOHA8nsM+rey5SZGZBpkRszPrqojc3ST
 OPWOzfe/2nVOXgRAsTJ9GPwhOAqKPRcgjaKJ17fhU9EnEAlwM7XzhOrOSoxERE0QNzRO
 6tvmxlDW8D3+Jl2p4HGtht+9EPtx3QNtwsHxaLCoM2YsVwYbwSEUiWiAVI6TlE4wZv4/
 eLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775528879; x=1776133679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eTl6UdXPMq3a4SAQ816+q1nAoDgsRIfLxCudW7enz6A=;
 b=kXD5TqwpETm7OqsMOlTlOJr95Mj3K7+JHI/HuW7RSN18w0AaE61gca+o1S5szg87Ta
 5h3DJQyHiXn0/jav1xzHIFAOcetV4lj9mRYMu6ntgC5dFl+qBwVtxgDJAL7vE6NIou51
 F9M/M2/AZLsFzzApqAHZu8/lLVk619jx9PIYkjnSPRii70/Is9OkA1jTUjuimfnJzi3e
 wVoe9RfrfctjHZEJcnbxqn3lRw92JxF9zXYq02De5qOaFT/kkSjMg7Blw6kcXfotcbb0
 mxY1LlRQvnil3CV48CMVEQ43Orx3wl5l5+xA9kdMpI/vWOVV5bOprizfAqUEjQ9/r21F
 jarg==
X-Gm-Message-State: AOJu0YylqQ7rUeCpbty6O3MmbVE3pvmnBPFbSihQ9buXXbHnAZ3ZE9Oy
 aT79g0EOh/EUsAMC1ajYrYrV7drXtMv6J9RyA3kmmPQxwfqji1pmmep7XkgVWE0A9icUtU+8Lm+
 Fu8VerMimVQ==
X-Gm-Gg: AeBDies2xzklZUpVVZ/mVyoSA3SvTMzynF0WpD+gKquIadDgC318rUt9UuSZzX1RApx
 XP58NKfqwa6cpsKk0Q0uGm0/uvZ0ZuiLGrekqKWeOJtWo0lWkMHKGeFI19d6cmwl/cXHstrIRtU
 LvoabaoPoFcnbh/3xbX7B1l8m9+RVfqNogR4izyToF7geD1olutfIz9T05zn0pxYNE/kwEgfJL8
 sl/pAKsYQkjWJu4WLp+Qrbwr4JeTJihG1504KL58cOlKtZUF25FcxhQ6QAi6RpQycsgdn9BwV/v
 e8F7BrvxNR32Ao+3cvkJGZwNI8DJHjxvEyH7FJjxpMOBXJfAIRJJY65g/psjkIHZrNAI5MZCfoU
 FWV1c0HZaclN7YOgl3MFZscpPYN2+IHWbvcUxPDrf5S0Kk3OzT8Cj4UAB4ViycMpXV1PTEZGNKt
 zlRhISqkeo6QhspCxBEtcmQiyxBNZTShL6wLlrpfWW6NUIt2vJSOx6FM4jDSwnwFTMGZEjbQ/W2
 SLL
X-Received: by 2002:a17:903:907:b0:2b0:af2f:b27a with SMTP id
 d9443c01a7336-2b281667455mr163936055ad.11.1775528879344; 
 Mon, 06 Apr 2026 19:27:59 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749794e8sm161423685ad.53.2026.04.06.19.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 19:27:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
Subject: [PATCH v9 03/20] target/arm/tcg/translate.h: remove tcg-op-gvec.h
 include
Date: Mon,  6 Apr 2026 19:27:31 -0700
Message-ID: <20260407022748.57629-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

Include tcg-op-gvec-common.h instead.
No target/arm code rely on target specifics for gvec ops.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 6d52606f9b7..e28eac54afb 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -3,7 +3,7 @@
 
 #include "cpu.h"
 #include "tcg/tcg-op-common.h"
-#include "tcg/tcg-op-gvec.h"
+#include "tcg/tcg-op-gvec-common.h"
 #include "exec/translator.h"
 #include "exec/translation-block.h"
 #include "helper.h"
-- 
2.47.3


