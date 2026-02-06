Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B702AEE6B49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQRF-0007R3-Iq; Fri, 06 Feb 2026 13:20:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voQRD-0007PQ-Q4
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:20:15 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voQRC-0004nc-8K
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:20:15 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43629377370so1120466f8f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770402012; x=1771006812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UimlxoJjON/bhMTscr34JsqLf8392tVb5tXpZcah2yY=;
 b=EiDnOZDJC/CwGqpWtC0NLNZJ2gOTpcf4QfWaKiwCMB9Cvs7hMiQcDawKSRYq3PJCcN
 66OYSqEXfA4Elb3kT/8MYzH55FAbOA/Hg8kcld5rXd/c78YGNvohP7ce0HuwG1G14YzP
 fXilY5pyGhdVpR4v5P6ImbG8+VLqLnpg5EFUKLOyXuOk1jefoLR9vpxu8TVSJD7wJEAq
 UVL6mnBsRtptdcM8PAMCC97KebgQVvmKXgrH8T2sduVwxy8QAfuRuv9UFnX5kudVQ9Ei
 uSs2e94UmmgwV0G//p8HgRaZDd1gA+iXTQhJP3XKP+tYNY6A7VgMIg1Im8QSKHp9rYCL
 Ciqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770402012; x=1771006812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UimlxoJjON/bhMTscr34JsqLf8392tVb5tXpZcah2yY=;
 b=KFREZPyfJlaqvXdlLFSVvRwCNHxJbKxFbVo8Z+SweOmg4GYWpwPNxsuN51PX1w1y7f
 aZ8TnHjMvg7WUmhyFGTAavswH0W4YLjIPvI0HBXEbtI+e13KeKd7GIejy+l/t5vYQQS6
 QyzC9aBTQdABwniZG/hAVXcsLZYtz7fqcC8cMPN8iWTXYoRRukkknQY1XyncRUY1dZ5V
 WlAg64h7B9qpShokX253RxH8KrPDKbPLsyMEKMkiCpY+GZuRLZyyP53nejMUzYfHf0io
 pLHFRPHB3RUAay21FK1qczePhd/sv8L457Aoe8APYGzDqE/ziFEt7iVQUuT1NhhgvRvh
 hXaA==
X-Gm-Message-State: AOJu0Yy15y+r6QiHesW3ls1N9f7cZwoQfQo+6SieVSo1xkmbFJUJ8OuB
 e1RquwcSW5THBTwTyLmeXZIT1VOx8WP91SAwund0N/KLuWikpXnY2gRZu/yUntJrl7JN9XOLdjO
 uIvNSk7s=
X-Gm-Gg: AZuq6aIalVAU4iPXaisamUbjQ/Ngv2vlGwT/uaFGZ3c9r8p9xj3ChvmG93pnywSUMim
 nIlOAtK8Mnj21/4TpNFfst41oBiBWGJRaAqgkrnQ4/LHC1mHvhJbwfO+EkzfzvRU6ZTVpee3aNL
 C35P0MFqBbXiT4qIffghCMUZLNTrrdHIaAeQhPLPcD8/q6nFtADkac8Wvonq+5I/xxlMbK+UvoZ
 iQUHusId+FSzxkx4+t+/FPdE7YVhHjPkN97SOcsah4dI+IHnXP365FcDfiXPei2EJ5POthFNE9X
 zzvyRLZ4opHuyj0bfgvBw/zce9SFwiY7XMO8b1IiQoA4M6UppfHKf8XuKCjOWve/RJR2ZLzY01y
 au6MwDpZUFBVq5wrscOkxTyZMiEISjdKnMV8ShubkUm+QNyAnkba1K3OJjAh9Dy7LUJIDNz61o0
 qtrlPVSyYFk0AuZAP+5xd5ywMWWJth2tOTEXCUnrF3BLTrOmqNpdaSmalrWBwr
X-Received: by 2002:a05:6000:2311:b0:436:18e5:48 with SMTP id
 ffacd0b85a97d-43629341c55mr5755737f8f.15.1770402011684; 
 Fri, 06 Feb 2026 10:20:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362974b176sm7022248f8f.37.2026.02.06.10.20.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 10:20:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 02/10] target/s390x: Rename get_phys_page_debug() @vaddr
 argument as @v_addr
Date: Fri,  6 Feb 2026 19:19:45 +0100
Message-ID: <20260206181953.18683-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206181953.18683-1-philmd@linaro.org>
References: <20260206181953.18683-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

In order to use the %vaddr type in s390_cpu_get_phys_page_debug()
in the next commit, rename the argument @vaddr -> @v_addr.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index a6c89ed0af3..d0c36d4a537 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -68,14 +68,14 @@ hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr vaddr)
     return raddr;
 }
 
-hwaddr s390_cpu_get_phys_addr_debug(CPUState *cs, vaddr vaddr)
+hwaddr s390_cpu_get_phys_addr_debug(CPUState *cs, vaddr v_addr)
 {
     hwaddr phys_addr;
     target_ulong page;
 
-    page = vaddr & TARGET_PAGE_MASK;
+    page = v_addr & TARGET_PAGE_MASK;
     phys_addr = cpu_get_phys_page_debug(cs, page);
-    phys_addr += (vaddr & ~TARGET_PAGE_MASK);
+    phys_addr += (v_addr & ~TARGET_PAGE_MASK);
 
     return phys_addr;
 }
-- 
2.52.0


