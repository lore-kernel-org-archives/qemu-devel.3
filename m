Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54739606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pxIaz3PQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJX89-00035Z-8B; Wed, 21 Oct 2026 10:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX82-00035D-Uv
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:19 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX81-0001Uu-IM
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:17:18 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso6544225e9.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592235; x=1793197035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mWLSH4hvAFZr+CJ1x6xP/A9aE6De4F+kfmdpqJLXeto=;
 b=pxIaz3PQFXdAt1HgR38bRQ5LC70LXXnvc9GFqoEV/geerKvDuCKTjPrC2RHiyw7oFf
 FtvJ+DIhAQNM4B2PDKPV3rfImQZP59dAlROSyeCHr4oug/ozUBOB7QIqzy3+JnODg62B
 2B92sJfnQc6Z5H+1CpSw612EO0KI0fwiTUU3wgHD9lT2PPgltZz3q/kp823giNE8f1LN
 uX5wOtcxS5NhupqQFvIBP6OTRSO8SzFwMscIMON78rsS2lvnjcjLAGupKH4I1gtEurJ9
 XUNRdlEhf3ul79HjgVVXppNmQBaIeBfy2U6XI0w89ilsX/wcMY/lnluOhpau/WJmQ+Ma
 LqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592235; x=1793197035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mWLSH4hvAFZr+CJ1x6xP/A9aE6De4F+kfmdpqJLXeto=;
 b=0PV3vIZALKV+X9LOZcljyLyWLyPoG1EnKXPiG+PJN61W51ZM8wO97Zn0N6w/KXuFhX
 Dte1NQUdvGVF1WAnX78u4iAS8SbeyUysHuXeKQcSCPUmTsQEy+m9E7jFmLYB1PQFeGtI
 sBs24nybhG8UfkN1s9jXXqdhvFzIMlKEXpYlWNyTrYU9rYcmH0DzasTgCBZeQpbmGQSG
 eMUfxwPw2bM9Dqx/dREVUBNU8PysuRWGnQ0Mziyxa6Gom7SxBHY9xVWuCewv1sr89TDr
 226PbK49LLVshc7wc34i7GVgvMPIEHsNyhqCpOhCGYcyUU5VnXFiPgqGGjOydSrXmD7R
 WqaQ==
X-Gm-Message-State: AFq9FYILn0xVtEeT/H2RvF8U4qUGqwNebJWbgZyj4oTP7MJKSCNW6Oi5
 2DFtu6r0c/LdmiPEBY2cxqAYDSaNwl+KQbqGm5pDi+eBtEGT5NtRZzm0zwCw/wfTRL3SMqkD5aL
 6PgWKygs=
X-Gm-Gg: AYBFou0H0PJ3uupcKZfWVqs95lnFvQIZIBaqJYzW8APnSV9quI7MYoN0LDU1UYDZlZp
 QdGDVGgC5ygkxp08uVlwpc7yDITS0l40qa5MwOlMU2UvUbVMgZUcAv9R1o1fJpcWDwTXYNB/9Vm
 A4O3qd+eNKbK1B/gkA3xlX5mQJAaC9qfh/RjXVjZfYz6ZjYYfXV7aNmyRu8XTtf/liMvhA7+7Y5
 z6Gz6X+hWnXKnA+TJO/brcI0msQJYqJWEYLrwNag1Rlv4LIUDSu/K8V0dWJJBLoeJqaaec8P06h
 pZIjdo3wa8k4DlkXT8TEwNEptyK4DBGiebdlYaGKulc67mdgxL1efh0yBKz8C+zDeAtxd4IE23K
 61thbFVB6ElahQiojyI8Yx4LGPEmxeusj830GpbQAmGjgjtNt18H4S1eCX+YktATL6uZsukwd2f
 /mC1ODqPtK9Z9Oy2h2O/T7eFnWoVU0RSG+MvpDYwOh/Kf6vAI7edQwAzLvPWPWB+FQhGGhZLD5V
 8HoBxc32NeYGsfgtKeFhf43apurKvQ9p9hIAGuj44FmvfMr4f3P5udmUb6T54gUNI2OKwiuvRgK
 E4+3G22VhKBhcjebjlGymDT5ax0=
X-Received: by 2002:a05:600c:3ba0:b0:4a1:e11f:b2ec with SMTP id
 5b1f17b1804b1-4a1fd8a068fmr59642355e9.3.1792592235052; 
 Wed, 21 Oct 2026 07:17:15 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:17:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 006/100] tcg: Enforce sign-extension for TCG_TYPE_I32 in
 tcg_constant_internal
Date: Wed, 21 Oct 2026 16:15:18 +0200
Message-ID: <20261021141652.363109-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

Prepare for more direct uses of tcg_constant_internal, where
canonicalization of 32-bit constants is not already assured.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index c3fdcfbe68..1cd6d41d31 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2257,6 +2257,10 @@ TCGTemp *tcg_constant_internal(TCGType type, int64_t val)
         s->const_table[type] = h;
     }
 
+    if (type == TCG_TYPE_I32) {
+        val = (int32_t)val;
+    }
+
     ts = g_hash_table_lookup(h, &val);
     if (ts == NULL) {
         ts = tcg_temp_alloc(s);
-- 
2.53.0


