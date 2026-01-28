Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D22D35683
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 06:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkzDI-0004gm-9F; Wed, 28 Jan 2026 01:39:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vkzD2-0004YL-0f
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 01:39:24 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vkzD0-0006Vv-JH
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 01:39:23 -0500
Received: by mail-pg1-x543.google.com with SMTP id
 41be03b00d2f7-c05d66dbab2so4364989a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 22:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769582360; x=1770187160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xlz7hyCztKb/ddjMOgK8ThA+NqW4yiGJ0YmFpHJkjZQ=;
 b=lRSpWw3iC73gRPLGzLAceIWH7BVAg5aT/bmeRJdRUjeQ7U++c5cX1mziHK4f8duPQC
 XjSBuyIvqj5ciJtWIk7QcHOLIPDy1I4A8FkNGCBK70rBYGHxBxCA3UV+oMT0Fe/xwdDt
 2rvCkNs8xKqxibJiukTNLw/q8Beg3pYVCB0tNZ4v74e1nKCKbW9Qsn3QRhMKlfbaRXw4
 fyLQIpn5ryDaEcpJjquTMKTjvJwyIhbyqzJ+sBF00e3DKQ/nFWuU8BAp7+dV4ezJ9UWE
 1wUgI30ztz84pW8K/9sdofAKzwG/c6dGro5wOg7A+vVlUeV6mEDG8AO51vIkbkm/n0xK
 K6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769582360; x=1770187160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xlz7hyCztKb/ddjMOgK8ThA+NqW4yiGJ0YmFpHJkjZQ=;
 b=NLy8k/jLNlw3I6+qs2U3hW3A4MWxW4EC1+cJVtq+z64n4OHHiGGUgGj01xeQ+wB3MI
 2YYjEN6Wv9tKHKgIF8N6dTTGq/0xiN5vHsOSFTbl/5Rt7qIQCCp+Y/mn9+vUke6rnmn4
 fcOk1HGCRouSh4XshMn4wffBrIBi80i5Giz21QVIEpeYUidpyqI/qI+b5pN5BBcXNUb7
 iti2E4LvswPQbx8C5dEmNJm8uyTbLjr8YH5Ce8TmAdLihIfKM+OyCsyQC21tsyHw6Eyc
 y0ciFl8r3GMwHQrmrYjxLdy/6Gf5IZ6by6OwgIkDRY6Sl6TYf+/uePEcGvxscSpg3lri
 SF5w==
X-Gm-Message-State: AOJu0YwTx6Emc5SShybxeF5O06xZja4OGi7HotdJlNsYef2H9+y+zXDB
 kHblkRLo0rmHdhBGCLNjPl43CUNCmd1lqTwkK5s9kKMvWT0m9wExoS81XEpGIgs77xAYeawPQHi
 Uh6yYZMcCAL6ccN8CAMS9oJVgWB0Ix48BwnbAKEpXuyjBwwHZlQKOEQcdaHe+eaEQRFZec4aJeM
 4MsXsKV/E7uBX5ALO9xbf+zdhZWAuB7f3VizYv/ga/
X-Gm-Gg: AZuq6aLD2mlcvsolAbzCEmg/Rdae2QuSMMeH1LHAnRKRqFYDeyF1FWbb1CAWKLw7RRR
 Npa9MEHLrNIJSh5iWkWHGXwQL3Try6ExR5AL8d7faDj0ruy91ER8Z92PTR6kalGzUTwydrErWE/
 ICpF9VlJqfM+yfTNwaYya9p3qJVIG0jWD7BCF+1wzj6CFvevHR0jMn3s5oVXogw7/MMUj2iYXy9
 n8NL5LhyIV5CEywy1EHf55pI8rye2Nl/LHZ4Du8yDJ+MC0in2sULf96k0L65fW4qyAOhzABvJqm
 HVAIEdzjSKxs1qevxgJnYfwNxYONLN5LCMyhrnHf0lw9iJMnCqfGiL4NscSK94Ejq6lgD8+AYiQ
 AdrhY/i7z3/lQCdi5O9HmpTI+ozE07OliANkUkYmQTKG60zWf9dthWXl8K5TON860IN77lJnMCE
 wpy3NDE06sqzODiINV3zePx3Uy/5bOrjJA
X-Received: by 2002:a05:6a20:918f:b0:34f:1623:2354 with SMTP id
 adf61e73a8af0-38ec6421854mr4092640637.42.1769582360388; 
 Tue, 27 Jan 2026 22:39:20 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c642487f1f5sm1244736a12.0.2026.01.27.22.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 22:39:20 -0800 (PST)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 2/2] system/physmem: Remove the assertion of page-aligned
 section number
Date: Wed, 28 Jan 2026 14:39:07 +0800
Message-ID: <20260128063907.2066100-3-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128063907.2066100-1-jim.shu@sifive.com>
References: <20260128063907.2066100-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=jim.shu@sifive.com; helo=mail-pg1-x543.google.com
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

The physical section number is no longer ORed into the IOTLB entries
together with a page-aligned pointer, so it no longer needs to be
page-aligned.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 system/physmem.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index d17596a77fb..2fb0c25c93b 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1323,12 +1323,6 @@ static subpage_t *subpage_init(FlatView *fv, hwaddr base);
 static uint16_t phys_section_add(PhysPageMap *map,
                                  MemoryRegionSection *section)
 {
-    /* The physical section number is ORed with a page-aligned
-     * pointer to produce the iotlb entries.  Thus it should
-     * never overflow into the page-aligned value.
-     */
-    assert(map->sections_nb < TARGET_PAGE_SIZE);
-
     if (map->sections_nb == map->sections_nb_alloc) {
         map->sections_nb_alloc = MAX(map->sections_nb_alloc * 2, 16);
         map->sections = g_renew(MemoryRegionSection, map->sections,
-- 
2.43.0


