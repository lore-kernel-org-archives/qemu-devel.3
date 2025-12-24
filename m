Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A47BE776C1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRJ3-0006h9-MZ; Wed, 24 Dec 2025 11:01:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRIP-0006Tt-F4
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:01:17 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRIM-0006AM-Vl
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:01:04 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-64b5ed53d0aso8683494a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592061; x=1767196861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XXKguHOd+ctmSd1zEyzRjZGeIuzMCy1ZsflVpDcJ4q8=;
 b=RJhF2VG3jqqkmFiQAuYMOrMQF5skP+CloAC14HW0/0qk3GnqvZ5/AeiRL58L0Lgxih
 f8Ot1rapdhaYQJITDO+tVWWIe5QGDHQyAYuBNCPTjDkAGzih/W5TbmkcJ+85Yo9MZNNJ
 Mz+NA4e/449S+jPm4SdbFuKroGSDfYN/wpxRc5AIHcIQ4mWEcpTz0rpqYk9o8+Zk9cBO
 q8M/a/ZxiHxlpVAmFLAdR/BywZyt3GYeEyKQrQP/ypIiH/5ciby8TA+2Iv3iWRWB6WBr
 2nGyfX0Y7x1dp70RwF/kh1K7LYx4xQERrnOlXdG77YbLhhq7KGUF1wO/dZji25vDb+88
 3y+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592061; x=1767196861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XXKguHOd+ctmSd1zEyzRjZGeIuzMCy1ZsflVpDcJ4q8=;
 b=Ssq7e78H47CGG4PKpZGZM1GcvXezfzFuSUpa1wkOSSMt/nOFqX5ApFaAiYdXYcrKQ9
 /fGBq4Ffi5s6xc4JoaibUcXLMgXrb+pyPUpo1NdK/Y9J6aieFJ4gDglK7XpHJgvVO42m
 bnN8fGV9xnlQy7FQ5PXYF7dm39C59O74GLMAcB8lCXrkQLPmiwrRzO4cZ7BSp9nELthw
 2Sai6GRRqFlHc/Jj4UCWjcx6N5MUjx0bQiQFsXQZYvcSPB4T+rVvHXaTMomb4vvCy1eZ
 HJBNXjyAc2wz2HHxV3snW5el2CC1UZB1sVz4m+tiNRqXnd7dR580xQ34v0ABJ6J2Mr8E
 XX7w==
X-Gm-Message-State: AOJu0YxHuYT8WwGzY/pmwsXq3zkO3+h1WrJcxlAYFrnldp/S4hYSK+AJ
 EXZdpJ8CQNWREKR+2hGfifVUSVJQjalJLCPz3oD07TZVtdr/JzaJRx5OI4WPukEoWKJpnT1OH+R
 x6jocQk4=
X-Gm-Gg: AY/fxX6Yvs/fgq23IhLt+VVsikE+WNuxfEMTM7uKMJqVrpMH4NS+qGsco1m9LC41goI
 FtNMPNZTdQk4eWCydRwAsx67kdHOHpfrlzxZoKU/bHthZSVOyBCw4UsKBiLq0Lp9ea822/q/J2L
 lUugRihWFfbmyY/3B4EMqUUPFiHYE6FAC02xiUffnNwH9Suy7Gp2tEIuQWn9fJ7v3UPlVnbPWhA
 2qKlRVqvVTC7nmqjKavtE22iOh8knHzxUIxKa3s5bfVu2ud2Ba60VNmAuVrh6FRqk8FJNYZmfdX
 4/cF+iFHRhCv2eTm12urAh9Jy2rEKCQmPi02e7HNHmSD+NJSWxJ9cufBMmUVKRlZeVc2q6DcDaD
 6HKlhxLu/jl3EBtVKKPPDhgCZfnwjVBUXICdDLg9snTsL43j5JPVWFL2lM6mQXUjAPWt/jk6qJo
 yVD1jUWHSjZ89/Lmuk/vjupap9z+kvJCgZFOpXZWf9JBdD66KvEI3mq04=
X-Google-Smtp-Source: AGHT+IEoNYQuJKch0T4HelQjnVNjp99xZFdzxgUUNfst+116Tm888TGCKRCRE422C1d9F31i7z5KRQ==
X-Received: by 2002:a17:907:720f:b0:b73:8639:cd96 with SMTP id
 a640c23a62f3a-b8036f3a367mr1837345466b.24.1766592060522; 
 Wed, 24 Dec 2025 08:01:00 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037ad806asm1801266466b.23.2025.12.24.08.00.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:01:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/6] target/alpha: Use explicit little-endian LD/ST API
Date: Wed, 24 Dec 2025 17:00:35 +0100
Message-ID: <20251224160040.88612-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224160040.88612-1-philmd@linaro.org>
References: <20251224160040.88612-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

The Alpha architecture uses little endianness. Directly
use the little-endian LD/ST API.

Mechanical change running:

  $ for a in uw w l q; do \
      sed -i -e "s/ld${a}_p(/ld${a}_le_p(/" \
        $(git grep -wlE '(ld|st)u?[wlq]_p' target/alpha/);
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/helper.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index a9af52a928f..80542cb0665 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -214,17 +214,18 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
 
     pt = env->ptbr;
 
-    /* TODO: rather than using ldq_phys() to read the page table we should
+    /*
+     * TODO: rather than using ldq_phys_le() to read the page table we should
      * use address_space_ldq() so that we can handle the case when
      * the page table read gives a bus fault, rather than ignoring it.
-     * For the existing code the zero data that ldq_phys will return for
+     * For the existing code the zero data that ldq_phys_le will return for
      * an access to invalid memory will result in our treating the page
      * table as invalid, which may even be the right behaviour.
      */
 
     /* L1 page table read.  */
     index = (addr >> (TARGET_PAGE_BITS + 20)) & 0x3ff;
-    L1pte = ldq_phys(cs->as, pt + index*8);
+    L1pte = ldq_phys_le(cs->as, pt + index * 8);
 
     if (unlikely((L1pte & PTE_VALID) == 0)) {
         ret = MM_K_TNV;
@@ -237,7 +238,7 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
 
     /* L2 page table read.  */
     index = (addr >> (TARGET_PAGE_BITS + 10)) & 0x3ff;
-    L2pte = ldq_phys(cs->as, pt + index*8);
+    L2pte = ldq_phys_le(cs->as, pt + index * 8);
 
     if (unlikely((L2pte & PTE_VALID) == 0)) {
         ret = MM_K_TNV;
@@ -250,7 +251,7 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
 
     /* L3 page table read.  */
     index = (addr >> TARGET_PAGE_BITS) & 0x3ff;
-    L3pte = ldq_phys(cs->as, pt + index*8);
+    L3pte = ldq_phys_le(cs->as, pt + index * 8);
 
     phys = L3pte >> 32 << TARGET_PAGE_BITS;
     if (unlikely((L3pte & PTE_VALID) == 0)) {
-- 
2.52.0


