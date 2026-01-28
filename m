Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC33D3F074
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 15:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl7PH-0000y7-6i; Wed, 28 Jan 2026 10:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vl7Oq-0000hj-Ip
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:24:12 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vl7On-0003UP-Qs
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:24:07 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-823075fed75so661008b3a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 07:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769613843; x=1770218643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xlz7hyCztKb/ddjMOgK8ThA+NqW4yiGJ0YmFpHJkjZQ=;
 b=GP3l18a4Y1nQWZC3AbqwtYMTb2q5iSuZH96fITEH4pm6N+EeDIiGOX9dgTCYFzSdSB
 mvHOu//8JBUk5cQjwjPFawb55kWJsEeKnC0SbPdolmK4xGYsSxwblUaMuza+AHfBAW3R
 EK6nZgvEVU+ljmurcF3++D6RAJzrVSlixQpYxBsLKgYUdEo6MwHLTqJluTe+SJb6edGC
 IVsOVO5ZVT65zMNx4s/sJTdfBz8fHiKTQaJvBefEQXDULdL2YDenoRA0tsG4/ISpsLH4
 mT+VB3aUw4RxdTnAYfkjA5SVYjRRvYOhnvvOGPw4TstQGbA62k8mU8uvL1FTSS8qg2Yi
 yq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769613843; x=1770218643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xlz7hyCztKb/ddjMOgK8ThA+NqW4yiGJ0YmFpHJkjZQ=;
 b=vLXFg50gPDZo3fnEMDjVngY26nYemzoS4Lzj+xWp9qQvcIH4Rim+AutslxzNbxPVvp
 rL7WMw7D9sVEMcpWpuGSwuJTv3ooK2+iASvKM9V4epOFqb5YUTd7xTdUeK8qFFbLZB+l
 1qQ2Tjw0hR5CGXRJWjTNvZR+rPkAPDAzLjsnBHYU4NZcnmDHgOfwXp5DYva57/N5H8G5
 TpcmFstInNrDYsgBgZyuhLuRKpCdLe3+UHJmn+BjswlZHMOHwcjYzUc1y08YCvT16J9n
 JLYw0hWhLZvlA8SxCblsKyeBZ+c0ZWORz1pA6Xu06E5B1Vo76+6JEbglSkqeffMZVHG4
 TdQg==
X-Gm-Message-State: AOJu0YyFEgdl++36Yre1QLhJ3W15hriEF80dDMdJ1jJZYl6swwxaNK0F
 swSUyRxlKJodjWzMWmX9sHFvd5U7mV2kGhbqAh2q0UGCAS9+EwE5PtDLYy/ulpORX7ICGaxuyEA
 vTKmKzCtovuXLhuvES8YrkT4Fj8fN5NW5f86GlSuiFpZekAzBWDKI2Ff3g+qkmx5UJMf2hMJNIi
 C+YYIAcmAAxS1bGIq6qH/a9hwt1g37Njs/PQJQMO+M
X-Gm-Gg: AZuq6aJ2h/0i3+cfRRgwk6RL9fLn75wnJTNt9ZmSJNBRGcHFTg0bFWcDHy+c+/wtWM8
 mgX4rVLBx1FNdQ3y6qlJJsGbCvKgt0oTRhg8hXufOIToBEVqUyJBdlCAWixZdXrqM1LHRoq+Maj
 NHSeuFatEcAEaGpF4rqZEPPGNIkHwmY2xBxGdGywuvl9ae750dx8za1+nKmqg7uEVC4eMj9UMYd
 28YeSRsz0mibk3J7U40HBBL32etTMNyBJGNSllq6EerzniQ4E4CmJ4dRkueUTHA5UMJCT7Xllff
 gCfieCWRzR1ezKvrGGTUwNz96Jq73FdxnVstCSz6xTX+F6sh/tuEE0Z4HafbD8FUO6IM44d8v6w
 tnedk7LHUTOxNpGbsnjvqkkK4fzwwkgoKdtJ9erYq7B20tzWgQqbBDNqwB456e3ovJyfOxA8Zw7
 tUCJwIT5F5bGj5nB/LhnmZp1jl8mQK9Od2
X-Received: by 2002:a05:6a00:92a4:b0:81f:4708:b46e with SMTP id
 d2e1a72fcca58-8236a38b7efmr4151608b3a.20.1769613842532; 
 Wed, 28 Jan 2026 07:24:02 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379c1eeebsm3021304b3a.45.2026.01.28.07.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 07:24:02 -0800 (PST)
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
Subject: [PATCH v2 3/3] system/physmem: Remove the assertion of page-aligned
 section number
Date: Wed, 28 Jan 2026 23:23:48 +0800
Message-ID: <20260128152348.2095427-4-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128152348.2095427-1-jim.shu@sifive.com>
References: <20260128152348.2095427-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x442.google.com
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


