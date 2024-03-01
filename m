Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A93C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgByS-0005ww-8Q; Fri, 01 Mar 2024 18:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBy2-00056U-Ks
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:03 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxw-0004H3-JZ
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:02 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dcafff3c50so23001815ad.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334414; x=1709939214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQmGR5cKuPmbKwlAdgNxFbsG53EvNXJRjqMWG5g8T5M=;
 b=jhZfhj8Vl7XpCYWRyQN+Vyj8HNJBO+FmjWM2rVYUXLFmVreSjxgGCe4J9Pg2l2BD0a
 1JibQPHgl2BR64s4OcnwHXsu+A5AgiW6Us6e9ijibDXHYjGieq3jjnLtQ7bMJ8g96lNl
 9w5zGdrt1XBRMjoj9qy0e2Ab7kQrlQ5yzl1XFYqsD3EgRBQv0lGokFM+Ao47JN1l0zya
 Wq66Xe3KPIR3a5CcIBjebtp7JeI7N/RNH+ET19MZb5UFErEIdnvxWipWOwDACOK6v3hq
 1u5ovDrED7XRvu0IG9F3gf0cWpaa6QwWuMbK5A6rfaC88Xd5rs/h31Vh6XNt2zX7R8+d
 lZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334414; x=1709939214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQmGR5cKuPmbKwlAdgNxFbsG53EvNXJRjqMWG5g8T5M=;
 b=Bw/qTezrTn9YiauzE3/nEV5jTlui1xV+O8FavgMBrC1mdyLBi6KSevjSS/i/c2bPKv
 u5pLoYIYH5iLolChQoCgMfvklOPC01muBiVuDBPB8IedYUCGo5SCf88buGCxP4UHswzn
 vwgg1iNvkNiEPanH12IYHG7gQ5w0f+WIWAoNErwJ8oSX5xj7sX0xa+SeIWvRF00Abozf
 4GoJpMI8664vYMa5VqGJRMihQvyhueAeIkUqSdi1JTBB3YCIk5VjdIuvxs5JQHZR4qOz
 JIRP9lLBnX63IYzsOJtU8FCpFSEHvpWHm02/NEBQnd4hSTKNDqGl3eOkXqO4LSwS3VjH
 kQCA==
X-Gm-Message-State: AOJu0Yywqa1eqUfVNPZbNLDUySexzZcTq2TsBTa8z35pC7gbOvKy46Uf
 h3GIENc36EYyp9LRO7iS7Lvixn6tTX4GPhyTF+eQED9+LydZdrvyy0eQuhocHf6W97zjMk7Stw1
 a
X-Google-Smtp-Source: AGHT+IHw2rumO2VeEpwcnUtKvQO3TfWgtQPMCN67oMqNFoFUuYX3+/I43AziW8q9K6cGWnsAyC9JMg==
X-Received: by 2002:a17:903:98b:b0:1db:fa84:9be3 with SMTP id
 mb11-20020a170903098b00b001dbfa849be3mr3697635plb.8.1709334413896; 
 Fri, 01 Mar 2024 15:06:53 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:06:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 23/60] linux-user/nios2: Remove qemu_host_page_size from
 init_guest_commpage
Date: Fri,  1 Mar 2024 13:05:42 -1000
Message-Id: <20240301230619.661008-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use qemu_real_host_page_size.
If !reserved_va, use MAP_FIXED_NOREPLACE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-7-richard.henderson@linaro.org>
---
 linux-user/elfload.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 53b61aac77..479acb4e7b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1532,10 +1532,14 @@ static bool init_guest_commpage(void)
                  0x3a, 0x68, 0x3b, 0x00,  /* trap 0 */
     };
 
-    void *want = g2h_untagged(LO_COMMPAGE & -qemu_host_page_size);
-    void *addr = mmap(want, qemu_host_page_size, PROT_READ | PROT_WRITE,
-                      MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+    int host_page_size = qemu_real_host_page_size();
+    void *want, *addr;
 
+    want = g2h_untagged(LO_COMMPAGE & -host_page_size);
+    addr = mmap(want, host_page_size, PROT_READ | PROT_WRITE,
+                MAP_ANONYMOUS | MAP_PRIVATE |
+                (reserved_va ? MAP_FIXED : MAP_FIXED_NOREPLACE),
+                -1, 0);
     if (addr == MAP_FAILED) {
         perror("Allocating guest commpage");
         exit(EXIT_FAILURE);
@@ -1544,9 +1548,9 @@ static bool init_guest_commpage(void)
         return false;
     }
 
-    memcpy(addr, kuser_page, sizeof(kuser_page));
+    memcpy(g2h_untagged(LO_COMMPAGE), kuser_page, sizeof(kuser_page));
 
-    if (mprotect(addr, qemu_host_page_size, PROT_READ)) {
+    if (mprotect(addr, host_page_size, PROT_READ)) {
         perror("Protecting guest commpage");
         exit(EXIT_FAILURE);
     }
-- 
2.34.1


