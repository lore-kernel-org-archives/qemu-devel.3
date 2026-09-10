Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE2CC88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 01:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ppd-0007u3-1h; Thu, 10 Sep 2026 21:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPe-0001hp-PY
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:42:54 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPc-0007BJ-Eh
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:42:38 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49b392ccaacso5554425e9.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 16:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789083754; x=1789688554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AUPnthLnZv0HXOGLcjECWuJuRRQZL1kc6hOnrSo+zaA=;
 b=Bz75DDYLLY5+ZUI6lp8zWGeitd1OvcZdhU/7bGbx3+4bbOTwqg1btgrS+r92swKDRm
 xh6rQXwjkwwtuNhWBLbIyOtgB5kkkHS2O8EWJ8L5XwSf5CuHC29uxVncT39+mjpeSQKI
 fZfLZsZFLXK1HqB7/7Ydts/ZfLjVAHddG9831l6ODu0NtIFvONiYkEqNvg7nQZxIFiVE
 RigvuY5vgbNag1cmVX99w3rfaS/5+8EZyBN41jXZRq39IRcyVynH6YSWAkJyNGOpcdzq
 TnvyJZ23dCowIiUJQLzFBeVJuD3lIwEVgWIpnr4Wy8+J5o96gFDh5cou9gzlhHENtJHx
 wtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789083754; x=1789688554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AUPnthLnZv0HXOGLcjECWuJuRRQZL1kc6hOnrSo+zaA=;
 b=ULLyT9jvW+fV7Utmlsc10ePRObrgxSWKKvTwsY5AEHr11+D3nrDpGS5mwntbyYNHGM
 w7O5YmzYSfs7Ovl2irfOk7vLy6aaBdAtTEpyslHNkDfqr5NiS3X2r/wYzlU4auYbIjtC
 caliy5iGArI52Y9FXOp1EoPdX/1g0eWEwe6pSoG/qgkqR4kWSPmn/3/ebFyHl8+Izj2p
 gbgzh+Bgg3mfXGnAgBgCtoa2yYFob1Pnc/aqjSaoH5/vBkd7Di4p9x4ul57Cqz9XktNt
 gPRe0cu9DkS6F4kOwUJv5v3qdWhayd1VQY96RamtaT+DELI3B+6iKWi/oVfOwAtcEXHb
 uN1A==
X-Gm-Message-State: AFuF++l/cynyTMUHgVkwaB7dT5JHGwgtxGsAPJB1DzszEpOMVDb9z0Ip
 0BOOX0hh3H+csiF+tonJMCRrI70ay6O44eFUE++X0L4hQmJej1amODLmAzNFY+Z7mXo=
X-Gm-Gg: AYBFou2BOyG+lOi6bifeM7hYZMeD3L03bzLBV9M8m4ePXII7RbvJnldmFMb0EMy+zd6
 j6smWJ/Qqn9RF4+6W56Hv/OoXdDVRcqOP2cVL8YSE9jklpjGsO8dzUvsuoS01m9LHrwo6BJ5S5t
 ykHREO99v6NNMOMg4BXuk0OagRK9qRzBqBOMxplHNYNN0htcGCfuzN1sGe6BwB+qXKs9aG4T9gs
 j4uzGPka00kzhJb24X6vGhZn3Q/5Ypf0X6FLziOZCM4G1lmSd5JzxKE/RzonM+fuYjSR87IvoeH
 3lgBSTKV4zlwUyHuHlNWg/y4kR5JtvthAcdXLEv3X6LVcUgCxtGVUhjcHm9XDNpo4BG8oTlLvDl
 qHgJ3puhe6eqfKnXK6MgV2u9CjEdl9rg7OFInw8zsKVlQT/a8oGUuK3XVWGjQ5uoEC36FlFmMT6
 37DQs3Db6TNIz9J2ms0LRahjEjLP65MOEm0MLEJbrcm6M3ruGpofc+5/eQOCBXrjREUm2YEmqHt
 SjILvs=
X-Received: by 2002:a05:600c:358c:b0:49c:cee0:f383 with SMTP id
 5b1f17b1804b1-49e619bb961mr17700545e9.16.1789083754077; 
 Thu, 10 Sep 2026 16:42:34 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:54f3:cc87:964b:3604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm7726775e9.4.2026.09.10.16.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 16:42:32 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PULL 08/29] parallels: Set s->used_bmap to NULL in
 parallels_free_used_bitmap()
Date: Fri, 11 Sep 2026 01:42:01 +0200
Message-ID: <20260910234222.3039975-9-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910234222.3039975-1-den@openvz.org>
References: <20260910234222.3039975-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=den@openvz.org; helo=mail-wm1-x333.google.com
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


