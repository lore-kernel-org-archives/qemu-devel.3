Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFEDC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV6q-0002J6-Q6; Thu, 15 Feb 2024 01:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6m-0002Ht-Pe
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:32 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6l-0005Mt-2x
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:32 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d9b2400910so4240335ad.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978030; x=1708582830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=on46I2b8riCprdxQ1GrqNDsO17YyckywkPgL9RszReM=;
 b=oks/L9GrJ2CpPAMuCaYTWC7zE9nJVed3jyX4EV7asGzUGTOmU6vIjY+VVGrc40FrQU
 Rt59eRdkrXZt7Iu53MXeiJkN31JB2qnCXGNEy9lCrw70F0A7FYsDK/dUZTbAdTii73GL
 1VnM3wD7pn+pfJ7W5ZOUBNwAfeOYJFU5uLgUXyb3RAC6TPHOOEdWjeYQbVVG0g7HKO1n
 Gme5gL+dIVzGihRYfAzH584qO21Nsu7+NXFDNv3iYtpSsoyU9ZOJu7ADPap3Y5dX8YAr
 VtC1YhNckpUBl/P4mNYOGNMO/fn83V1juoiX5QT+ib/sB7ZrmxEhFih7rTX7HOHOfIEY
 aT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978030; x=1708582830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=on46I2b8riCprdxQ1GrqNDsO17YyckywkPgL9RszReM=;
 b=I2XdY6qaKERi232JiahYlbJI1930JIKeQRu54lUpOjqKFUdbDy2GVIBJ8GKSQv3aH1
 2fiAfKnMXzAZ02ZyQM4ltCAwUDGaFziMn5VUWHTBaS9CmcvhY7aNN+3eoeaEZyla5+Mv
 22k3JMbnYMutjoFIz2TwukS5wppJdq8JFSAevZZlasTLNgZY9h9EKGxoMGjPZ7DJZhL+
 ES8JRV9g30TH5Xsb5LAjyAuphfxibxyPpgfIINFOjQXphKGSYvc/5NmbQ99k3yuQQSyw
 x9A8rQcrJlF2xEnz31hi2wshh98fHe23SO50f3AqYHsRzOOA97Ol9+0qQyXQSRaHhZiR
 EVDA==
X-Gm-Message-State: AOJu0YxmpFiIPGkj9A54YBkVsTrkIkO7hXr/8vfIcdN63gsZ73tkr0r/
 V5wyH0M7/CUU18z/J5k4i/V+yDu52oEGvXYnru93apU4TDX9t1kdTwRtXfWGs/sCbD3frbr5ykC
 d
X-Google-Smtp-Source: AGHT+IG40zulwDY1MBQVHAVV6pGHYLhc1+lsT1wT0XKnVLjW6UhAeKSnnEzEhVnWUqUoa3yl1wFXfQ==
X-Received: by 2002:a17:902:ce8e:b0:1da:1fe7:cacf with SMTP id
 f14-20020a170902ce8e00b001da1fe7cacfmr1519807plg.25.1707978029794; 
 Wed, 14 Feb 2024 22:20:29 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:20:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v4 06/36] linux-user/nios2: Remove qemu_host_page_size from
 init_guest_commpage
Date: Wed, 14 Feb 2024 20:19:48 -1000
Message-Id: <20240215062018.795056-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
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
index 1893b3c192..a9f1077861 100644
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


