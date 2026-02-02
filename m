Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DBBE7FDDA
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn14J-00061W-TG; Mon, 02 Feb 2026 16:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn13w-00038C-BW
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:02:24 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn13s-0004ak-7V
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:02:23 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-432d2c7dd52so5185632f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770066138; x=1770670938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K8NJiyEmeAxQSeoThjdv3cQkOH7fI1FQaJXKBiKTl8o=;
 b=Xpjr7VsuZioW+JGWd4YAgVvQ4pXPE3g4j3+keQQlkfJWh6IFVx77L/hzfxsXZkLcM4
 upEOPisOj1WG8cEPKzdTUQbwCBQ8TjbXwODBg7d9SzyN6oc3B57kUKOSYqcdfXRa0fDU
 0lKjgTSOGzwHdJu0wgBwBBNEBAINBf1dGijjf0+nnDtyDvguvsZYUAYgH5j/DWwuU1r4
 lTZVxhT/tpwrr0dDR8W2MmTKxwmPk1xuapZnpUQGwYqDeBxohpmc5o2qhF3lWEAO9BvF
 d+4kB0BsXGYtrFGWD7zyRgs3tO8LkfVwSwwRcA9qTa+opajJGUFhrbkUJUfLij0WrsjW
 0+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770066138; x=1770670938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K8NJiyEmeAxQSeoThjdv3cQkOH7fI1FQaJXKBiKTl8o=;
 b=CiuOrKYH2gARVbG9MvXeauazq/pVslzZgVQmDsI2m6O6UXGpkfaI6RbOU3sbEp27Ps
 WlPBOOHiEk2AU62Rp727mniV9cxBezExaP6Ufzi4CQ4wTIetSx4RY8/1d2bo1nSm46dF
 ieC9Dg+mRzMRGoGOK22oi8vYiLlU4C3/UOPjaf9RE8BB/MB2LqyFhMDFV5w5wv+9Xkfi
 wYKWcYhzq6lPLTxiPkdogVn6WAN61/xynHs7veXU/5E2ZuAT7nBz7jJjN+BCK8DDfk5C
 lviEYOE7sjwWZpMvHUaey6sN8n9phZjLpjhpkgf0p82OucKUe0N4ktO0nxDUbT5ws4jl
 x7Ng==
X-Gm-Message-State: AOJu0YwoOwDg/MWYwKnQBWkrzcH0cP4HpuVXPbaWcg9usJ3E4h5yo/r4
 fPeFU4ZsTqn2OlN5EHDZm5RbwuFUnZNhMMUk/LH2soLHzHGTz1nTjZIX0ijrRsKjO/FLwDQavyg
 CVAr1aqs=
X-Gm-Gg: AZuq6aLIC+zKM5vDcV3nVqzePfoGZrTk3CPdMX3KMigVHWOciDnaamQx83zIjF/1rw9
 0Gos1UZqV2XqSeyflwSeGOSqmw9vjFi6SnDAL6dT8YMzlew2T2BV+tq+A2EiEonmulD74lZzEBx
 8aBT8zBqmKORM7rw6oPEvhNaHBbJQLaDta/ag6m+xLfGU4Ii8BtdlkJlNadU13LiuIJBhLCmdk1
 EJCb+eHX9H/u/K9Fz/AwWyaU6mZKf1zITA+LhUT+nPdYTlGjJQbovDVSAxq69iMhuZJMcBmqIT0
 ohjahjz15arX1Y2wwESZuMcvDIbsKOfU1fY6hRpuVkr9vLwsYwzEta6RiuRG0EtacPt09Fds51p
 dXsQGwulWzgiYSDoTqDQfKM2ulJK8fmWpVt7N87js2iO/2ldCmAajNl0P19aWKE/ZL7wYnHjtzS
 esWXmwZy6RVTSWtiosM3/30kCGF572B94La7SLI2uVtqJct4PrGw5/aVS1oTo/
X-Received: by 2002:a05:6000:2087:b0:431:1d4:3a71 with SMTP id
 ffacd0b85a97d-435f3a9c028mr20770604f8f.27.1770066137589; 
 Mon, 02 Feb 2026 13:02:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1322dc7sm46801119f8f.37.2026.02.02.13.02.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:02:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 10/11] target/ppc: Check endianness at runtime in
 ppc_data_endian_env()
Date: Mon,  2 Feb 2026 22:01:04 +0100
Message-ID: <20260202210106.93257-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202210106.93257-1-philmd@linaro.org>
References: <20260202210106.93257-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Rather a runtime endianness check via env MSR over
a build-time one.

Now CPU can change endianness at runtime.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 target/ppc/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index e6e60de95a4..dda23b66096 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -37,7 +37,7 @@ static inline bool ppc_env_is_little_endian(const CPUPPCState *env)
  */
 static inline MemOp ppc_data_endian_env(const CPUPPCState *env)
 {
-    return MO_TE;
+    return ppc_env_is_little_endian(env) ? MO_LE : MO_BE;
 }
 
 /* PM instructions */
-- 
2.52.0


