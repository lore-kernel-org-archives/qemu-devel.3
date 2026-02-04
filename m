Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0BEEA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 18:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnhbP-0002c1-RO; Wed, 04 Feb 2026 13:27:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnhbN-0002bM-Oj
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:27:45 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnhbK-00014P-4o
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:27:43 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4806dffc64cso872245e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 10:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770229660; x=1770834460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Kt3MaIKigPezWwUjh9ifQEhTMOdqMF6Sn8DTtDUVGU=;
 b=r6vuV0Y8XB+euD9bExb+Wo9nwcyLPGVR6OltY7ScCnCmM7CQr7oHjaf6W99sIROOUP
 ihp3aHd/sWx1JU7WPiMNbWrsxLkMAMOP9jbNVJotFk96y1NtxMc++VDKp0wQqBdANbMV
 qBXwLI/fHM+vl5IIHfrybrjC1R1LyLVpXtlYQpng3gwFaxfMrZ91h2EyH0LEKE6hhavg
 yBOY8tOjR/3E5OZVIsKc/O9jaxsnfPzF8pSv6RKjw9Ytx5Z9UNzvEh9LDgZZBj2gq6Iy
 n2cI53zOeTYhXHv+WY16ktZZOrWiCIPOhYfowrQACLj5cL9vA6oO5BKhZ4IV0/7D9Q3w
 x28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770229660; x=1770834460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7Kt3MaIKigPezWwUjh9ifQEhTMOdqMF6Sn8DTtDUVGU=;
 b=QKFq7BI0BIY7g8XYV3xZ4NqR3o7WKDvGE7XPMbivqubomH9XigPkoS6LCaiIAZ80PK
 M/KyHziRCHBqb/IXahuFu2I+rt+SpypgundmuA0FThxWcV3iP5nvKTDiW8d92A6k4gFP
 76AJCRgTmgvFwXwm855ee7xdpkWCd6Q1dCBWRsHChRoFST+hu+1pN41GSrxEALtMxSvl
 ZTTxBs+OnqcUoOEvOe8a6Vdumk+g0lFQ/76qkNlxGewld5Txt0x+7wyIr1sNJW9dqCuw
 utoJ/6xjT/IxfKk+9SYTuXHJhUxJ7tkDo/jan9zEQiauzO+hc1UKVH7MDrumw82KsPNV
 O87g==
X-Gm-Message-State: AOJu0YxK10AiHYPnonFHwywX7pz0GVvUR+fGPNmWjpK22m081u2MQIMN
 CckF2f3mJ16/yiabVf3mXF9zIeRJf9plim/WyRwhmHgiSFbOW6wwJZuVFOudOLo6/4PrkziBL9y
 vk4uNzV4=
X-Gm-Gg: AZuq6aIkyzMWiZDV6jPeZ6IevA4mJa9beCzB1gjQHKLsD4Xc7zy0xiG+ce8nk3hF9kO
 1CXIRd3DIFfHoUlrDFPIs5Ts9NfXyG3YHVkX8rilxpUmJJTRVazcKa6ROKE3NIjzyks/rFMAo9k
 h5CEM74D+qxFvsWd1tEGACyTR/v7shSbUFTM59/foPVDufG2SZ8d2zSH+MvSLkqlRRojBwehAVI
 /wEOpwkhdLEhxENksLzoHMWE5pAQg7JLKG7w5bXRNVLxB7X28oXPPEQJ56s1XVf0OnIFdj6Nwv+
 vAhhQ9u074dpPS2UvN1atAN9YXJ8Mg3h6TFLD5KTWQTsPzdTiPg0zK+XXqUQF3E4Ie4ENKfcCdH
 SACm71Dag48CM1uch/6KV/12Zad6LBdn8IcrLG9Jiqb9O19s1KQeB2OTC8OYvwDapsZeq3HhnbE
 gWJ+1UoO1xyonLjUF2xph5hnO+lYHoVT82F5ruTJ+YgV96391nHJZSurWSmn+U
X-Received: by 2002:a05:600c:608e:b0:480:3ad0:93bf with SMTP id
 5b1f17b1804b1-4830e96d1e3mr59900965e9.24.1770229659715; 
 Wed, 04 Feb 2026 10:27:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43618057f9esm6884478f8f.28.2026.02.04.10.27.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Feb 2026 10:27:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/9] target/s390x: Rename get_phys_page_debug() @vaddr
 argument as @v_addr
Date: Wed,  4 Feb 2026 19:27:15 +0100
Message-ID: <20260204182722.44062-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204182722.44062-1-philmd@linaro.org>
References: <20260204182722.44062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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


