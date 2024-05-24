Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAFAC27C43
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 10:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sASWz-0006Y3-0f; Fri, 24 May 2024 06:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sASWt-0006TX-RM
 for qemu-devel@nongnu.org; Fri, 24 May 2024 06:52:09 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sASWr-0007eM-5N
 for qemu-devel@nongnu.org; Fri, 24 May 2024 06:52:06 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-529614b8c29so1052135e87.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 03:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716547923; x=1717152723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hr4mFL3kawAtq0YtjNZv8OoJ6UbTTaozHsbwpoCpDok=;
 b=G5+PFfsMP4LM0L76gD+BQ4UfrtzOr/eMoGSoC6+M5LBHsv6Y3qtAKnOrrwFRIVIG3B
 1edTEYuzHqqeyx2vqhWwVzvi5Mk5mnSRj33xawjxPINXeAKRGbHI0s9FwiKQOd/aD0x0
 8jsaUCPKUH10snDMRruWvj0Wt7BgcCo3c5X2qVAIGo1UbSvSEJaARmj58RdvCWAuML1Z
 hG0Kuc3SUIi+SCrd/H2XIthXrVek3YKpol4uLzTI+huhN/5dLaJlObpYpp1gOfFiUCnx
 6pZuKu/+caFHYVKK9TtCJYngEMfpz1TC2Nkk+bIbd78ZF+NQjQXDkIXIrwcfew86pX/7
 o9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716547923; x=1717152723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hr4mFL3kawAtq0YtjNZv8OoJ6UbTTaozHsbwpoCpDok=;
 b=hXAmRBq++Iyytq6Y/cBD8PvCklo4YBnbP3l2ArH+EeSA1rSj1I5OMP9P3arH4u8GV1
 KWA2z6OqlAF1bqI1f4Ua0bkEdlEnEr06I+/XLfIX0xtepIqTWFkqm8C93IDTilENfKQz
 e0oYFyVUd0+obbvJao3ClHaOh0E+AMrH03/lQkBrVgwL27xqKGnG/5usyWHYOhmFtNDt
 ioIiEGnyMmQ5KZcs+koAKGxGyJZN6doSO8gjslW3TJdXTB/k9nR4DV7uTCz/qyDYuBb6
 xRwVroBqT7s/O/+I6hRz3tsbanFjaBXMnDD9bTs79KO+g5tLBzEVZwgH/syktrBunGNN
 kv9Q==
X-Gm-Message-State: AOJu0Yza08ZjFjiFWQmuc8QYJ6Q8xnhiFEfGU6C9S1i098EdB6A5F11U
 8ifw8g5quxsPH1UZfNCdnxZKNW50k36u2LRhI/ASKq5ohDRTxi1Nrts/SMaW
X-Google-Smtp-Source: AGHT+IHg8fKa6vFYJhd6cNlWBuyv0qb20RQ/YQYX1jzD6kM5Lukf3RHBt5yzeodjussqdQuBewdlWQ==
X-Received: by 2002:ac2:46c9:0:b0:51c:3f4c:ef6c with SMTP id
 2adb3069b0e04-52966006183mr1448573e87.40.1716547922924; 
 Fri, 24 May 2024 03:52:02 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5296e886e42sm151898e87.46.2024.05.24.03.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 03:52:01 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 4/8] softmmu: xen: Always pass offset + addr to
 xen_map_cache
Date: Fri, 24 May 2024 12:51:48 +0200
Message-Id: <20240524105152.1301842-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240524105152.1301842-1-edgar.iglesias@gmail.com>
References: <20240524105152.1301842-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Always pass address with offset to xen_map_cache().
This is in preparation for support for grant mappings.

Since this is within a block that checks for offset == 0,
this has no functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
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


