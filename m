Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F402EC25B10
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 17:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s57al-0001jr-K3; Thu, 09 May 2024 13:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s57af-0001iB-MF
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:29:59 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s57ad-0003dj-E8
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:29:56 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-51f174e316eso1404533e87.0
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715275793; x=1715880593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Lu12U4WovTW3hf1eOudpLM8QHHuwL/cl/TS4TvBDsA=;
 b=gTHhFZAIvRCgkqnxnVNiKVOazw++i7bdtI4pBkBYWJNYQ+wZDKNAGjBwSjLfKj/o2K
 Ugb6kJOC6UxMze4IwZtqRzzE1arxSGW1+s5TDUDGU1/knxIwAJq1Dta5BcV9NqX6eRxd
 9SBrDckN6xy7SKNQj3610Rc4HbP22J+GGrUcISSQADzSAZ4FOjd9bxbvh9mtTZin5m1a
 kb2Xh8zw0SUdurqJzyerMkWjN8GQBuLv6Kc2Fvf2m21HENzqIETNctof4qaFx1e8T/2Q
 r98EcRcWAprJ/oBmfkR+rl+a6UQdYGlgQIbyyZDMFz7LrCbM2g8H+iHMUdppWJsBOh3P
 e0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715275793; x=1715880593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Lu12U4WovTW3hf1eOudpLM8QHHuwL/cl/TS4TvBDsA=;
 b=OGw1R5w3fGwH8Z8w43WmmDW3S0ROKAvG+4bkAq/Q+6AVu5A54+o7L/Xg4t3IrYbqxs
 CMQDsiPHZgQB4u4IGg5Q2OT/hSJrLMvbp0AXQNIhEk6E5wvQRKVUwhzWPaX/dJomiYig
 aHuexhHvyar4JqycSCeffXZO8fuJBmriBbiyvHLPDYlzQW7Vhu/VqdPCeWZWAeDFUn66
 tTZANe1dNCV1iq4v/A0S8u0bCXum72W6wD/jYwF70EkwCo6wesuQeR8xwtTBRY7nMmsu
 jdK44ISJbLJH02Wwgs59YnqzTx8/cyjAFc+xnIpwpmigWh1acmZ3soSGy/BCQrJsRib0
 XA5g==
X-Gm-Message-State: AOJu0YwD/NswbyjBPaVNlaSO9BOBVI9PiZ/X+uwamoCIZbWQm46t8cdk
 QiDmFpo4ir9+PzrcmmiT9CjOuK6WRDtLIcWnaRQt0bvEMc8oSX/kY5AMhunR
X-Google-Smtp-Source: AGHT+IFpUN2UJ5Y05+XgtMWXD1dZLnsMtTgxcLNFyRg8yefE+FmcaLhEFX2t+nfVa9EMZmhaMtK/gQ==
X-Received: by 2002:a05:6512:3494:b0:516:be80:178f with SMTP id
 2adb3069b0e04-5220fe7934bmr127564e87.43.1715275792802; 
 Thu, 09 May 2024 10:29:52 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-521f35ba80fsm374153e87.93.2024.05.09.10.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 10:29:51 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 4/8] softmmu: xen: Always pass offset + addr to
 xen_map_cache
Date: Fri,  3 May 2024 03:44:45 +0200
Message-Id: <20240503014449.1046238-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240503014449.1046238-1-edgar.iglesias@gmail.com>
References: <20240503014449.1046238-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Always pass address with offset to xen_map_cache().
This is in preparation for support for grant mappings.

Since this is within a block that checks for offset == 0,
this has no functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 system/physmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index 342b7a8fd4..5e6257ef65 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2230,7 +2230,8 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
          * In that case just map the requested area.
          */
         if (block->offset == 0) {
-            return xen_map_cache(block->mr, addr, len, lock, lock,
+            return xen_map_cache(block->mr, block->offset + addr,
+                                 len, lock, lock,
                                  is_write);
         }
 
-- 
2.40.1


