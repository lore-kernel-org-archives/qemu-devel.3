Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10092C3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 03:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRO0W-0000hg-A2; Tue, 09 Jul 2024 23:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRO0U-0000ax-Sf
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 23:28:38 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRO0J-0003nW-Qf
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 23:28:38 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3d92aa6b62bso1981106b6e.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 20:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720582106; x=1721186906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GQAO0KTgjbZehDr4himFsvAKyM+WWXiQ7FDysfKIpGc=;
 b=f2TsoLXlnDKs/MybgMNR9+aWPfJiRBZJ/cH+fB8CoAwZGzaiAho67LLPsPwLp1fUYL
 J7m7P3ZfPdEDAt0Nrpzuq0Z5tI5rKvGdLkRkccfgd42Va7ebhoD/ls7gXpTZxsNoCG8Q
 qZNMA4yurnB7edptnenOmBU4QGgMFtt3sw7IXdsSDqkQOViviP+ppXGtNz5vbs1c68TH
 zu0QD57qPDUuchR7p3m0V+Rvod+c8doZJVtLnW58dL56ZkE8Z+neeSxDZ0h9u9kG/bju
 PtVkum0v00zAftLaygpJLjybUANjYlOoMgWRsow5kLORa5uiH5bNRJXu1LdwV2x0iC4r
 +Ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720582106; x=1721186906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GQAO0KTgjbZehDr4himFsvAKyM+WWXiQ7FDysfKIpGc=;
 b=AqXYKiTPvrV0KP0MUyyDzVUI05XPSW0YooZ6h0N/lNe7TEo7O9RVVQF/I4NmOkhV7r
 OgcPi4lunQHOiKhAtlGfAMbYvvgw2kvU3Wv4mJ6ATcbx/v9c9xC7bHppIQGn7MvRj3R1
 9JwM4IuOPKhiGbfLGbTdizl/19m2AQfaf6Ld1ET5tH88b/OBldKohRAcfKwvWCtizdMf
 ndQBtQcYFGOmc+aR4gyhcxDnseTA3s5gAXzXjfovNtZp8YXiYo70iUoWE4eAQdBLqJDZ
 uV7hvWqAHkXYowEg9bm6ABlmBxpLJqKKImxpbfHu+UeVnvoK2FxnYkXh2QkTgr8B8FkQ
 yFJA==
X-Gm-Message-State: AOJu0YyedpzY/E5cODIPeFOxztQWNMKvwRno5/rMURaq6KtIuiagoQvq
 wq1uzVmhT9U82rRkcPlO26pKbm+L6h/A/xxS77lG8Kmituw8FpyUXl44/0yXBOiWyc9o8dfIOOB
 VJDo=
X-Google-Smtp-Source: AGHT+IEBhMf3zm6ncmXIx+1ziq6zYu3fqQWHYUqPCmiU5m1ym4nZtOJN3gg5SXbgw4efJkvRXnoXqQ==
X-Received: by 2002:a05:6808:148b:b0:3d9:26d6:c70f with SMTP id
 5614622812f47-3d93bee9516mr5121280b6e.7.1720582105753; 
 Tue, 09 Jul 2024 20:28:25 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438f5679sm2687280b3a.90.2024.07.09.20.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 20:28:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, balaton@eik.bme.hu, max.chou@sifive.com
Subject: [PATCH v2 10/13] target/s390x: Use user_or_likely in do_access_memset
Date: Tue,  9 Jul 2024 20:28:11 -0700
Message-ID: <20240710032814.104643-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710032814.104643-1-richard.henderson@linaro.org>
References: <20240710032814.104643-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Eliminate the ifdef by using a predicate that is
always true with CONFIG_USER_ONLY.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/mem_helper.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 6cdbc34178..5311a15a09 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -225,10 +225,7 @@ static void do_access_memset(CPUS390XState *env, vaddr vaddr, char *haddr,
                              uint8_t byte, uint16_t size, int mmu_idx,
                              uintptr_t ra)
 {
-#ifdef CONFIG_USER_ONLY
-    memset(haddr, byte, size);
-#else
-    if (likely(haddr)) {
+    if (user_or_likely(haddr)) {
         memset(haddr, byte, size);
     } else {
         MemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
@@ -236,7 +233,6 @@ static void do_access_memset(CPUS390XState *env, vaddr vaddr, char *haddr,
             cpu_stb_mmu(env, vaddr + i, byte, oi, ra);
         }
     }
-#endif
 }
 
 static void access_memset(CPUS390XState *env, S390Access *desta,
-- 
2.43.0


