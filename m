Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2DDC624DA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28ey-0002dz-QS; Thu, 03 Sep 2026 10:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28eq-0002c6-BE
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:17 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28eo-0003y4-2l
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:16 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-482fc3327fdso1618250f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788446592; x=1789051392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AUPnthLnZv0HXOGLcjECWuJuRRQZL1kc6hOnrSo+zaA=;
 b=lDKeTulRFNCvNkz/xgMow6GJR6udW8wx8a+P+9wakASRdUNhXCdaQlI5YIR+uevsGu
 UGegSLKc7a2pcqx3MSKo/Ms2gyzSeHovN7REutOH3mLF7TpDllnk2omxzPUEz3s+T5zQ
 EDektBlr1SsKdw9jTQF39n0ZFp/ZisNxPsL6wCvk0OsF5HLDPXDT0qKMkcBt/M/cZJCX
 BG0oG8jdgu0iGIeGAlJUyVjGV/dPvh8hSQ8kcZQJrfH8LQZM1IcVKyaqpdMBE9dw0UqF
 iJD6tUv/q50fXdYtbzvLgV5ZZid8DvCY3hU88F2PJryXlvYWDP3h0shjimsopo+VOKnh
 OmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446592; x=1789051392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AUPnthLnZv0HXOGLcjECWuJuRRQZL1kc6hOnrSo+zaA=;
 b=CsnGOIrUSYKAM1q9jCG1UIdBRvQf13M7p1puRhs+qLDKG2XQ3qJv3BKclsTpmJGkL8
 Z7qcc4zOmZ9S1TA660kwr7XkZYccyrpo5CrEeCh3XqQ/PSrGIj4oPHTW6PrVGze89kJs
 bkTXkXPNrJy7NnaKhoizFPFKOckR0gxphSWQ/fLfWFL/8Psg9WI3IwPk8SbTrJa8xkyA
 18mlmjyLkOI98tZqO6A9AKJHgyNbNJN3yD2HteLQh+r3vAMyUfMmYo89LoTkwtUtqQ4K
 IuUGc2kK+nAJt8ox4eNsULzaR7Z+rZfLtda4PiFjfauznquBNcVDb42ES7WmpnrJaJq9
 n1Bg==
X-Gm-Message-State: AFuF++lN52EQp6NkAKYxHWtdEbD3b0iVbdeq2cnsMof/NrDPfaL/SOB4
 sSSPW48KlqlGZ5mzhbu91/prToSvSvZO76wx1wsKxZgmBNBWP9c3Vwe4PsNEDDymoUnQzj/3lJc
 0MSjB
X-Gm-Gg: AYBFou3weXuNofCPfd8sQXnlnjkZFOPfECjfkz2yDGlAvi6MgKYSGdScOdcFjM3w+TH
 3HMK/caMR2cGcNIWr6rsss8Uksh/r0w+ZbmYUAXFoU+lU1/Agw73sGHdvQ5rax01d0huLkHZ2QG
 GOJmMMJOMdQk0BLxUkQry0W+QB9vTT/Eh19pmtThvg1P/K0BIvvI6T09qNhfMiDUyLH7FVSIier
 b28ikkbEBx25PCbOTpa1dyfyrRlrGsg2ulAkjiSBABbZWifAML8mFrg38ChpIZo7QdEgHmH4Wh6
 S5bbdRfBBWWmFzo5/3UCKxkJQlwB03L4CZX6DmYbdK/UXUGQlaQIQmPmaTP3xlHalyvKRoYesfc
 5UeTg285eJtWT1AymIvlXvscBV+O1Q5wZt8NxTVl603zSTiGpeNV4vJbmFaDF+v80KBEescNJwq
 KqjgexA75Lv4pdEES4CH1vF9Z/j2dcVJBPYzVjupiko8NnzJYWGIVJm3rJ
X-Received: by 2002:a05:6000:2512:b0:47f:fb2e:f63d with SMTP id
 ffacd0b85a97d-48586069579mr1524464f8f.9.1788446591101; 
 Thu, 03 Sep 2026 07:43:11 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ee9cf7sm15165483f8f.25.2026.09.03.07.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:43:06 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PATCH v7 01/25] parallels: Set s->used_bmap to NULL in
 parallels_free_used_bitmap()
Date: Thu,  3 Sep 2026 16:41:19 +0200
Message-ID: <20260903144143.2328870-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144143.2328870-1-den@openvz.org>
References: <20260903144143.2328870-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=den@openvz.org; helo=mail-wr1-x430.google.com
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

From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

After used bitmap freeng s->used_bmap points to the freed memory. If we try
to free used bitmap one more time it leads to double free error.

Set s->used_bmap to NULL to exclude double free error.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/parallels.c b/block/parallels.c
index 50748d1415..94692275c9 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -254,6 +254,7 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
     BDRVParallelsState *s = bs->opaque;
     s->used_bmap_size = 0;
     g_free(s->used_bmap);
+    s->used_bmap = NULL;
 }
 
 static int64_t coroutine_fn GRAPH_RDLOCK
-- 
2.53.0


