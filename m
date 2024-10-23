Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D82D2E010
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 03:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3S9A-00070U-6Z; Tue, 22 Oct 2024 23:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S94-0006zW-3r
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:50 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S90-0008Kh-FD
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:49 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2872134c806so2096494fac.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729654474; x=1730259274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qoeeRSbCIM2wELRtbBsRx7lh72W1XjEQDAZV/p2MgMk=;
 b=D0sLwsKjizNXOsVqk0bTHhYl/JBGastzjhMCj98aSKPA0Nki7tCsZG/tUu11rk53ds
 oTEwjq8yflLR0x0lOHVvlVbuauw2ZhIBYYn6VPdOcJ2dPGJc87vC7TVN67zXnuAymd1e
 tjZ0bl09tANL7W8PQIcgAEWLFuvhmVFvS1w9EgY4vciUf0DPgs7RK8bsstYlaMWmVLFn
 eLYyqnXOPtSFJO4pkYzdXp7IB3bdKdPtljlAXdIzNJtG9HhKUJFYq2zGFolhAQi70R0Y
 SDXfwRpaTrkw/8iBAIVNAnprcwquKY8IEzo5wAtganBVaY53Pv53XONLSblAQGEhQPSZ
 pEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729654474; x=1730259274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qoeeRSbCIM2wELRtbBsRx7lh72W1XjEQDAZV/p2MgMk=;
 b=JRhz5T9RVjxIyglHx/iTvwJvdWZ5gvJYxNjGWgscdsfzRHJnHKkXnfzl6FvBA1lAM+
 BxXpPUnmNnec01DqRBeipoQ9UJhXC+8NuHJQyn3F+DJI6mzkS0j8Xyde9d78YKgRm1og
 7z5tl1v1tXww1p0+rMOIAGIdXZePwfghrde8Q3gnlUDwNVKgTWkTFPw3vJZkdJKxN3VD
 UoErNCI2xyGqb5LTyba6AhvU1d8wDpWHH72vvOKgCH8A/zuTIx/jEeMUJuKuhwz7EXib
 NBHtYepbh/XsjGi+y5I5R7oZ7dP9dpxKqdaU/m+vpEhlwSgHyhUycUQtY9TwtndonzxR
 q+/g==
X-Gm-Message-State: AOJu0YwHcNJeRd9AVDko7F6E5HedqWCi+J8KTLoAF0vVzSj/va/LOyrH
 8MH/A2y7IfQ9vwQoFp7JGALNx5Vaaglh5ucaFV9a6pozqgbvHW0rhmOqOj1Y+ktWp99IhXysC3t
 f
X-Google-Smtp-Source: AGHT+IFfLxpx2601hztoL7SU0lnJAfvD0KkM7GwOapSpsmWqf+j2FEh/v4mic2wDu07j8+ctLRj+2w==
X-Received: by 2002:a05:6870:d1c7:b0:288:6c52:ffab with SMTP id
 586e51a60fabf-28ccb8323aemr1293896fac.24.1729654474510; 
 Tue, 22 Oct 2024 20:34:34 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d73b1sm5438338b3a.105.2024.10.22.20.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 20:34:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 01/24] tcg: Reset data_gen_ptr correctly
Date: Tue, 22 Oct 2024 20:34:09 -0700
Message-ID: <20241023033432.1353830-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023033432.1353830-1-richard.henderson@linaro.org>
References: <20241023033432.1353830-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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

This pointer needs to be reset after overflow just like
code_buf and code_ptr.

Cc: qemu-stable@nongnu.org
Fixes: 57a269469db ("tcg: Infrastructure for managing constant pools")
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 5decd83cf4..0babae1b88 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1399,7 +1399,6 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s)
         goto retry;
     }
     qatomic_set(&s->code_gen_ptr, next);
-    s->data_gen_ptr = NULL;
     return tb;
 }
 
@@ -6172,6 +6171,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
      */
     s->code_buf = tcg_splitwx_to_rw(tb->tc.ptr);
     s->code_ptr = s->code_buf;
+    s->data_gen_ptr = NULL;
 
 #ifdef TCG_TARGET_NEED_LDST_LABELS
     QSIMPLEQ_INIT(&s->ldst_labels);
-- 
2.43.0


