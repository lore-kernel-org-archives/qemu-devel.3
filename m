Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B61C36007
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 18:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuFJS-00050m-VU; Mon, 17 Mar 2025 14:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuFJ2-0004fv-Ar
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:35:21 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuFIU-0006BO-9t
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:35:15 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22423adf751so80104185ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 11:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742236475; x=1742841275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PfpTTedni4gUGfvRcfnvXw4xTvY7JO0pNjOjXTZ7pI8=;
 b=jKWcnob/q6MXIT6ilZI6A6gSIRTncTy//ATt2lz9fwHOcDX2zHHegOBEgW17U53lY0
 Ofpij44oRTdDUdCkAT0bfl/xWaRxS0lexeRBr59WAkhGmZQc9q9X5NsLdPgjzI7G1SEb
 q0wW7svIwwjl0AthgWNwRBZgwpvdwMkbSSbWsUPyViBcpQiCldhvCMipg6LhKaE5BD0r
 NhE5fZPL79M/R2ju5DiamKuYxkVjPEd42dZK/Mj3M4z3o4Kzpf4oMgcLBAXGum7UvxaV
 sl0r3pHVtIu92kI4xzxS7s0abDY2lJHl+Iz5/EUYQaDTDvtxfgJjG+T/Ycb3k1LyUvZI
 +tVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742236475; x=1742841275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PfpTTedni4gUGfvRcfnvXw4xTvY7JO0pNjOjXTZ7pI8=;
 b=wKv77fUWwMxBZb5M7t+86HsEL97yWkwWxhtUKW0FSoJQQmJY/yrYOaHdT/L2AOAJ/w
 7XB4dRfJm253oBcJ7GmthudGkaEIC40NdT9n8Kl9gORUGhRdIoxJi9JSiyJzdhULOaL/
 xMlh0urAmU++2GR6UOMNTVUuCRg3ApTW1kcZMwMpibYeS0ssfLZ+uSo4/JQrW1hqJtIB
 3N4qkRckesZR0Kl1/WBK6HhyknAMj3XXALDMJb+UNiwB2uqWBbpHaFWZqM3uBj1QDekI
 go1pHI/cYVxxjrVbmSqAlLbAhGofEQIZHA6jz6ZFCJ+Ea8bdqop6cugrz98/+0q4b1mr
 zm1g==
X-Gm-Message-State: AOJu0YxZoi3TlgRPF01aTScqOK6zl7hj3XX8OX5wx4fjpnOXIp+tz4Ay
 qI4nLoAPc+NYaPu4ULzSCXihqeDrZfMP0uMVm3a5g2wSTlFABHs7xJCuYPnU85OBa57+Kf1yaFJ
 j
X-Gm-Gg: ASbGnct4FJ5PwAdAjhLcKl9vgUf1xbAY8MH7mndcdBlNuAVgPj0h+ALPsfaOpdzZKHH
 Ot9zMAD2En07/wBFLL2BdnbF21Q9M2sDJX6JbqLIPQvUDmm8ZVd8syZf2AqogqnwO2i/ZvfVOXa
 Gs+MGsttS/kM3RZ3mGZEGUX3oaLnPg8iHW1ZTKS7lvE7/SFkedouAbuY7tPjTo1/3Mry1SvYv2Z
 +Ranem5u0IPLMvfFqQwmxa34nkwOtynSLc4sTy9NanrI281wY+ZQsrvuxHShPJ6ZQdByT7qeZRH
 yhtKktYDBYskLxhuUukZhLzoRmXjbNyWPzztQxXdDOeP
X-Google-Smtp-Source: AGHT+IHhIUK7t53+vTI188pQaTMyR7EJzQqReYcVMpj4OefpwS1cjUKc4hsfvFYLapAGzkczRRlDcg==
X-Received: by 2002:a05:6a00:2196:b0:736:a6e0:e66d with SMTP id
 d2e1a72fcca58-7372238f773mr15973995b3a.6.1742236475108; 
 Mon, 17 Mar 2025 11:34:35 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711695a2esm8188770b3a.144.2025.03.17.11.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 11:34:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 manos.pitsidianakis@linaro.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, kvm@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Xu <peterx@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Anthony PERARD <anthony@xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 09/18] exec/ram_addr: remove dependency on cpu.h
Date: Mon, 17 Mar 2025 11:34:08 -0700
Message-Id: <20250317183417.285700-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
References: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Needed so compilation units including it can be common.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/ram_addr.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index e4c28fbec9b..f5d574261a3 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -20,13 +20,14 @@
 #define RAM_ADDR_H
 
 #ifndef CONFIG_USER_ONLY
-#include "cpu.h"
 #include "system/xen.h"
 #include "system/tcg.h"
 #include "exec/cputlb.h"
 #include "exec/ramlist.h"
 #include "exec/ramblock.h"
 #include "exec/exec-all.h"
+#include "exec/memory.h"
+#include "exec/target_page.h"
 #include "qemu/rcu.h"
 
 #include "exec/hwaddr.h"
-- 
2.39.5


