Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9C1FDEE58
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 00:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG4d0-0004Y2-7d; Thu, 23 Apr 2026 20:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neotheuser@gmail.com>)
 id 1wG26S-0005iD-Gv
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:00:56 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neotheuser@gmail.com>)
 id 1wG26Q-0005o0-TD
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:00:56 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-36132967e9bso1221921a91.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 15:00:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776981653; cv=none;
 d=google.com; s=arc-20240605;
 b=En57Cqut96Gdskg+8rZr6dbG1JnYJuh9WUuWq1W6jRUpQ6xXKDdUx6qUlMlCC7UyFD
 OGKksKaXt/N1LsZk7NVwQT015djdHLmKKQfHeNLX/giuxgGihTzZQZn8zGP4I380m1HN
 IkJyLGXaEdJ3spzXM4WRSNUe9Vg4XQXSZYJEKTA907EQtnPav36KJcAt4rooU9AWfAlW
 GzLhzQZy4t1najmpIM3SofKh72fshEJK4AbFr6hUha12XHFtpYTXrO/xxNZMdyt1jqcX
 RrjmMG7k60gO+8ETzTC7qwT2u3wS0yQg7ncOCBaM2L2/k+jWnIimdO3MiKV5sbMuH3mn
 jIRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=Z7bFIlilCKOglFdrvcs4Fkch43S2BM/m8esG/K4Mqis=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=fPzbUOCikmK3M2CXHr/1SHrdM+gEpaqleC2UTkSpFehF6Q1yskbKxK55zibjXXuFX8
 aj2R27NgMWgnD0xQZP3VeC3Z5sq5ZKyrfyaQblx+3Xv3uag1If8z7eq4U/qiyGhFLL2T
 8+eUfxuF6vWz0Wbycz2yG83/KF8bhO90o243OsETcL+ilnxLDDoiytEesUlGofuQQrVz
 i3Ufb8LkEWFuTytkDbXIVriTu599iA5jqsBVXR9nrIx8WqVoknc9jKq9x5aFE7XB1cB3
 Go3vIhRTydja6/QqB/rNUR6LCP1xSAJITqtBWhVIS16eoJ7ZhsP63CZcARbHignHh3Y1
 PeMQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776981653; x=1777586453; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Z7bFIlilCKOglFdrvcs4Fkch43S2BM/m8esG/K4Mqis=;
 b=FOqfyCfuvQU2uKPPGf/xrUVRx05zlsGPz8qBnq0toBa90+aPaEs1xB+p1I9g4YeteA
 dQH9gHBtnvnSguAKl2scqp/A+d64rfhJzCh8kMO9LddweMOyHGaWHq9XTIvHgGIprwT0
 hn897HCEtZXcmio+YgIe7wXCiMsidUJuvulYyOqk3DgMwSAxJeqed1IKZpCMMU76DUsd
 bq9tmlu1jwXVg8LOFStphkXXXc0bZo1/ODw5fvBENRnO5ESDnpbMYyP6FfvA2dQQYbf5
 ywAQ53XHfnwtog4pxJyIWOGL180h8v2rZ/0abQqwUd1WHiRebNPA0nzxQSLYAo+XvCOJ
 o09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776981653; x=1777586453;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z7bFIlilCKOglFdrvcs4Fkch43S2BM/m8esG/K4Mqis=;
 b=cLjZxvrZKZ3KadYN+hyJSHLyS1cVSDG6bH/ni/9WZ5iJ9GuT5cOqUKoavolrijsSzr
 LT62K7jLWrUKiwlXISm6D6PI06yUc4NVSBPEVDK0qMpO+25KEhp8NEv7ahgH8ZeDLqxs
 9SM9KJpIxb9gV3x2WeSaY++ZEvYc3QmAnQbOnp63oxwRJz8GKlxeBI2YXpLfVguPuN0i
 zK8r3kqGTbAmB6Ss9BKlUJsvwGrlXNrfP04M4lUG4t/THc1wWwOR9/BrUt8pyxytqTlq
 PbPe3D2X0oYmXuEh9elc355NJu9x4yBMdH3id8Wwzrr0/i/30vXm495ZNg8TTnFpKEi3
 wL+A==
X-Gm-Message-State: AOJu0YxbOsXBcS3skbxbi3lTW2pI4Q7+kRETaG/yi9eWfatY4sImh8m7
 mlTT7TaRSr/JlJrLBR9r0ig8LvmXEh2nnz5bGdBibHpnz2c4JwXskbz0aLD5R+qEtd6cZfTK3RM
 NlLIhXYTdg9KCqQya2sO9Lg6G4oxga07ndT08
X-Gm-Gg: AeBDietKjhEhhNO7IA4NA+NEgKP5cVrkGdCOtidhiFDz1Q+1SSPuxZqNEVXNXgdolgi
 Jlk6BG63hxj7fHED5Vh+9fvh+UavZE1od8+MZNHa0Q4k7AMuSNSqp45k347k0RWK0fASGEpcjNu
 NCnhbpElheMA1KFy3qwRKrzwTF8YakLIuMhFr7N7GUiAyeC8d3WJeNkXlwmFL0+ZEYpcpA2KtzH
 8LmA4l4rIg0SkVn5PdV8glAmmqNH43/TjJWmkrF/eWNop9LlcnBTdp2b2iAMUTvKMYDvROjr5b8
 zC3QK+d9NALB4y8=
X-Received: by 2002:a17:902:d60d:b0:2b0:4d17:4d6e with SMTP id
 d9443c01a7336-2b5f9f2d4aemr155824425ad.3.1776981652480; Thu, 23 Apr 2026
 15:00:52 -0700 (PDT)
MIME-Version: 1.0
From: Alec Ari <neotheuser@gmail.com>
Date: Thu, 23 Apr 2026 17:00:40 -0500
X-Gm-Features: AQROBzDQjfdFPfUC4orUIIZKOSoPZS1SUM0sEcnV0tYvemJ0xcf6ctera3ASrbs
Message-ID: <CAM5Ud7OgnsygAHxjGEO-qo5+3zYiAQFN85D2bx1Wb62vK2hzRw@mail.gmail.com>
Subject: [PATCH v2 1/1] raspi4b: Disable L2 cache
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=neotheuser@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Apr 2026 20:42:33 -0400
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

From c5eabff997cf2231326c532c2cbc51fa1334fb9b Mon Sep 17 00:00:00 2001
From: Alec Ari <neotheuser@ymail.com>
Date: Thu, 23 Apr 2026 16:42:06 -0500
Subject: raspi4b: Disable L2 cache

L2 cache is not implemented yet, this patch requires
`clk_ignore_unused` to be set in the kernel cli.

Now able to boot a 7.0 mainline kernel.

Signed-off-by: Alec Ari <neotheuser@ymail.com>
---
 hw/arm/raspi4b.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 3eeb8f4..9580711 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -68,6 +68,7 @@ static void raspi4_modify_dtb(const struct
arm_boot_info *info, void *fdt)
         "brcm,bcm2711-rng200",
         "brcm,bcm2711-thermal",
         "brcm,bcm2711-genet-v5",
+        "brcm,bcm2711-l2-intc",
     };

     for (int i = 0; i < ARRAY_SIZE(nodes_to_remove); i++) {
-- 
2.53.0

