Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C8FD0BB43
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 22:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3jig-0004uH-IP; Wed, 23 Oct 2024 18:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3jia-0004tL-8e
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 18:20:40 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3jiY-00060z-9S
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 18:20:39 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20c7ee8fe6bso1686065ad.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 15:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729722036; x=1730326836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r5913GPkL4WEYCP3Y6kC6MHAYq2/hchSUBRFU1ZK8b4=;
 b=ZbSMBF892lB0U16ItLKEJA0lgZnezkp6C2ZlH2mCg/EkMLXvjBqWALPhMqNJcvB3P4
 PvVi9Da86Kl3xUMqJErpQsf0zmhGKbHfe6XwKgfHN1UMa0S79ckl2xPPNiM+dU/2WhO5
 PnVaTdQBSq4Ab8+J6ddaic7S34+qz6EzMHjjRRwrCsgBaqejUrTbaBS01bmnpIAXSxEk
 ouczT6gzQ2TDjU3Fzz4IwCas6Q5I4jD14Lo3swluviuqaRJxHmEBV7Cj4IT7u/yBcaxj
 hyFT4R3CHxwcfz+AN7XXAOv0dQaCoVUI5m+S/H4QBKLqrSnP3Mkdo4X+WUTq8e14ecUR
 qsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729722036; x=1730326836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r5913GPkL4WEYCP3Y6kC6MHAYq2/hchSUBRFU1ZK8b4=;
 b=cFMQootD3aXuXhCY6Y0Mdr6k4a1cWN1a1PDJ2mON3rmzszD5bGfOggQLKKRSMiQ/0i
 W3bpGOVrOcdZqOILuCyAF++UEpXfP+2LNwPmnWIvQPFtmx/mE+9Jy0f1hJIvXFrsnBTG
 7SmbwTLwEiLWqVU2hbfuOc1VJqJq0U+lbZ0VqQ5jGDz9ObaBcXeYdzup95OxSJg3miUp
 XpRMX8zz3caDezax4wn9n0EX4CfHy9OSChjxvzxwYpI1MPuHogXU3qY7BhQ8ypJeKoBL
 02cEhE65oNg8g6zJ1L28FQLCw8HoLXmqYVfIupqks+ubGqNjgbu1VUCa5jiKkTFQFVl5
 EdTA==
X-Gm-Message-State: AOJu0YxOGIxEjslhjbo61N8aEbRmVg5sD+ZsEWAq4W7n4eRFzaNIyaU4
 rvmAt7wnn9jlA0iD/rSZ12B+bHNFh6HzFrOK6g+eUt4zOoh+egaABirBIPsEUNOF1bwpy/f4Ggq
 Z0YGopg==
X-Google-Smtp-Source: AGHT+IFRU02hf1CdHs6BsxAYVxEcWf6PkpcLKHbCfxrNwDoQuZFMQ0mixa2RRwtK/RPms2yBHc3K6A==
X-Received: by 2002:a17:903:2287:b0:20c:bcd8:5ccb with SMTP id
 d9443c01a7336-20fa9e61d41mr55996825ad.30.1729722036389; 
 Wed, 23 Oct 2024 15:20:36 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0dba36sm61897395ad.215.2024.10.23.15.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 15:20:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 1/2] target/i386: fix hang when using slow path for ptw_setl
Date: Wed, 23 Oct 2024 15:20:25 -0700
Message-Id: <20241023222026.1430014-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023222026.1430014-1-pierrick.bouvier@linaro.org>
References: <20241023222026.1430014-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

When instrumenting memory accesses for plugin, we force memory accesses
to use the slow path for mmu. [1]
This create a situation where we end up calling ptw_setl_slow.

Since this function gets called during a cpu_exec, start_exclusive then
hangs. This exclusive section was introduced initially for security
reasons [2].

I suspect this code path was never triggered, because ptw_setl_slow
would always be called transitively from cpu_exec, resulting in a hang.

[1] https://gitlab.com/qemu-project/qemu/-/commit/6d03226b42247b68ab2f0b3663e0f624335a4055
[2] https://gitlab.com/qemu-project/qemu/-/issues/279

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2566
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/i386/tcg/sysemu/excp_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 8fb05b1f531..f30102b5362 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -108,6 +108,9 @@ static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
 {
     uint32_t cmp;
 
+    /* We are in cpu_exec, and start_exclusive can't be called directly.*/
+    g_assert(current_cpu && current_cpu->running);
+    cpu_exec_end(current_cpu);
     /* Does x86 really perform a rmw cycle on mmio for ptw? */
     start_exclusive();
     cmp = cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
@@ -115,6 +118,7 @@ static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
         cpu_stl_mmuidx_ra(in->env, in->gaddr, new, in->ptw_idx, 0);
     }
     end_exclusive();
+    cpu_exec_start(current_cpu);
     return cmp == old;
 }
 
-- 
2.39.5


