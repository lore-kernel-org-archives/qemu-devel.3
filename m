Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C39D2C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 18:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuFJO-0004vP-BY; Mon, 17 Mar 2025 14:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuFIn-0004V4-Fh
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:35:09 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuFIU-0006Ah-3b
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:35:01 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22359001f1aso41894355ad.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 11:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742236473; x=1742841273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bYYGOsy+zcSjxVOnigwMonGaAhWbZB7W76ZyOX5Jlgc=;
 b=loTKUbk6UnZS9c0hxYPRqlmFC9nK3iJVBgX5D0URgS3aaImozZPomkhvITgw3A3p98
 gR0iqj2ISl1fH0wuL6ak6JSOpKJ0U8YFPW3Ul8KxDEdugJmf5H/x3KyJoLP26T3CGa1X
 qQ5oriPcK7xvVbu9Vt5Mw9BQ7DMRvcp/IFHJe/Qie1BpMRMI60mmWqJBfsr5/ZmoJuYS
 8ovhzcxHG/tyK2/ILWtGBobr3DbamKUzRlIz0eI9WjuBYB+B/a7XD4/3pufY4rqIEP80
 pHUu9dFtb7fFX8nsARN770uS0rOuCkJJEhIynXCN/1GyYVUzZqBJRobZ+FYiiq0bMVIs
 xzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742236473; x=1742841273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bYYGOsy+zcSjxVOnigwMonGaAhWbZB7W76ZyOX5Jlgc=;
 b=wSb/oGaiFcXnbmBnXTSkmN6038aILJkQNHGtFTiLS8h6gec4gFnHnZGEqBeR1omZ9W
 lrj8U9dknRd1ahv7osMYcnmyUO9TQRHTjADIQ/GS1c1koemYMMBKUhcJ9hHsB7YLc2Uf
 8VkjmEhxEY/s1fi84hMeKwyGhtweI+r0+Y3COmDburLPhnihrrGpwFcrYunzYLNBWOGF
 zyVppTU87bqnHBNKtEgTSMgXDVju1wI9Rkvvw4c/TR+2e6wxMBdFPp8JgpdQgZ7ZjH6j
 4B++qzNAxYbO1mh1VJUsSUQJa/7OJHUNPIgp3kcmnYnxVD5anpb1i1FDQSnTt7IjuRPQ
 Gigg==
X-Gm-Message-State: AOJu0YxpTf2ss7orTUkyUCSC6odp9aGtTP9M14yJ6U0qPt5l4qG6xnVY
 8qEL0iQeagnFhijEoWKruKc7l+4TjTKnFVmvlf8saSD6I3ZpzbqqIlCmGGXKAR5lp22NDOjjnqh
 r
X-Gm-Gg: ASbGncuyxKAsw9c/A0uXQXn0jofiJx8/k6kPjez85XX6c1/JUSaIt+SoFLP7h9BnND8
 ebnP+B5GwVy6+2rZC0jYhhcwsnldnqJBIrgaQP6+PvYAsefnvWhB6yr4ecjrATL5t/3NnOej14s
 z8SrkhUDCxwpChfOrbB7o2Z2VkLTszVeJZJAXwdGtpCLUIskuM9+QcHs7mCCSg+rn+93igAiUdL
 hEBV2DPHW7broTFqaYrq67fJniTtcXcXb3fKFKWISN/MjA2KfXrzZ1dMbXZ9r6pDpHqGKDdc56e
 m0JS+/tkqXpzi9MF7dK8B6x/ix8xQzPCRpOpMreoMA12
X-Google-Smtp-Source: AGHT+IFV6DhukzDJTQhxKL2T76dlm4rDEmTDcVzAIQ6vxy9qm1/fBJU2mGtWaSFzbonBb3tr3G7FIw==
X-Received: by 2002:a05:6a20:a11b:b0:1ee:efa5:6573 with SMTP id
 adf61e73a8af0-1fa43cbf794mr1071010637.8.1742236472852; 
 Mon, 17 Mar 2025 11:34:32 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711695a2esm8188770b3a.144.2025.03.17.11.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 11:34:32 -0700 (PDT)
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
Subject: [PATCH v6 07/18] exec/exec-all: remove dependency on cpu.h
Date: Mon, 17 Mar 2025 11:34:06 -0700
Message-Id: <20250317183417.285700-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
References: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Previous commit changed files relying transitively on it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/exec-all.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index dd5c40f2233..19b0eda44a7 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -20,7 +20,6 @@
 #ifndef EXEC_ALL_H
 #define EXEC_ALL_H
 
-#include "cpu.h"
 #if defined(CONFIG_USER_ONLY)
 #include "exec/cpu_ldst.h"
 #endif
-- 
2.39.5


