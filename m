Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215D4C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogyF-0005Qw-4E; Tue, 28 Jul 2026 08:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyC-0005Oa-V3
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:40 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyB-00033s-11
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:40 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-495590dde14so42528305e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 05:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785241897; x=1785846697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=y8eybOLgVekjhh0BhhLyot67p4bQFbwkXFEXrdD0XnE=;
 b=FjPVS467j3nQeZfXhkTldHofLGhtraDE4bMJmLZ3lH7rZrJPDmYIDUVOLHOxMu/Mc3
 X0TUzRVutihgffQX+DyS9ta1sitCAFdFoHaCQzPPMsReyZWs0jQRDkbCVmUZU+3K4Pao
 MfPlxyIc/EXdOkoFSfPDRuykQRSCHLE5DUmQ+mn9nZl0CWU+s4Bzh6d1fRuIpf6VQp1R
 xtZOgEjeJ0vif8fx1NPcndVN18HCm5aO0B4UVOaI959ykztQ8Jz4s9A2+2rlO1tyPyof
 XKLp5KpNy7ZQXydOf8PnIq/DtNa3K7S2l/JCwvwSj3shdyRgU1wbtfasCyNC7pD/5J0u
 ryaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241897; x=1785846697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=y8eybOLgVekjhh0BhhLyot67p4bQFbwkXFEXrdD0XnE=;
 b=Jaj1u0afzfnUvWcfE5IoHAHHd7O5RQxsJA12WqFbwlMdSwKDzK4PnxkZYLQ7n6Qc8W
 z99VZJE3pCICLBzZXCEps8XAnNRz9lCqPCZCvnAGt5CzxYGZGRhy00qv64WB+fDRuhly
 gTTcjWjeWZlTNOpvUUyXpz7belavon1bAl1wpJJutfMAczN///xCTdRI9etxL+p+eCIh
 /U9WynkA6E2HO430rsWHo5ibAQB5h/A57FsChQJtSqLhknOI5IaRYL133pXc9bpS0FoZ
 x6BV8usDgMDGCKO3Ij9AhuHOpI8UiMZRdN0wPeai0bsiCDkzk7bdc208GuLmLv/SByUa
 qmHw==
X-Gm-Message-State: AOJu0YwT2yXhQwsk0sO7qdRe3GLE0O6Wkn+9TTmhi8JQp688x5wPbDem
 rcJx4YgdQhbs6ByLhGiKtVA7i3sKtxVBo0KVyVHkMWAmNKKRygVK0k4Kl6M3HAlx6DRkY87+q9O
 WBkjG
X-Gm-Gg: AR+sD13CUoqrCm94fsPoFAzwUZXt6uEKxcbVYnyJOfGr8AJex9ADF6wvIaDlBsX/qb8
 SaXz0Tjg9IFi5NIns4OD/ZkeRei/YvsQvvWvax1E8JbKdPjFD14WnMhUQut1+vTgcccAxYPh21u
 Nd+R6cVsywJpX4CP8rdsnJ2LwtdTQ87Lam8MDB1MAlEdHzm3yjAH22a6nJ/poyrSzlFNZFOZ3sr
 m1nnu1wPs3lJeu6uJZfVjEzf/xfwM0xMgrVTfeywgPf/vl7JBx2sl6uDTjfhZiPntgl6kyPSBGJ
 D2SQaVgYeKdQo2iXXZYauuu+NE8XaoDK5XyrTkqSewf9JwKoG+bFfbdwAHJLhGxKjzHA03OwbtI
 9rjnFTXV5/cytXJK+cfHfesna6SfieTbo4tFEZpb47xSaJ0ztKLTmr5gSVcAV5jGysbM50Sfsbu
 +DR4/9dgDWKvaFvYIH1GiHwKMsR8uAeXpYkn6H4q+gi0ks+aBXIIj4FDZ722jUV7W8MLeK5xGlY
 Zvn2DQ3CsM=
X-Received: by 2002:a05:600c:8b37:b0:495:5e86:4e59 with SMTP id
 5b1f17b1804b1-496c656e67emr24234875e9.22.1785241897485; 
 Tue, 28 Jul 2026 05:31:37 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6f076sm58499039f8f.34.2026.07.28.05.31.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:31:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/20] hw/net/can/flexcan: Fix mailbox index calculation in
 flexcan_mem_write()
Date: Tue, 28 Jul 2026 13:31:15 +0100
Message-ID: <20260728123127.1711653-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728123127.1711653-1-peter.maydell@linaro.org>
References: <20260728123127.1711653-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Calculate mailbox indices from the `mbs[]` array layout instead of the
oversized raw `mb[]` view. This prevents accessing mailbox entries beyond
the valid array range and fixes Coverity CID 1662974.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260723070059.6332-5-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/can/flexcan.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/net/can/flexcan.c b/hw/net/can/flexcan.c
index dd92a383373..651904fa379 100644
--- a/hw/net/can/flexcan.c
+++ b/hw/net/can/flexcan.c
@@ -1151,6 +1151,8 @@ static void flexcan_mem_write(void *opaque, hwaddr addr, uint64_t val,
                               unsigned size)
 {
     FlexcanState *s = opaque;
+    const int mbid = (addr - offsetof(FlexcanRegs, mbs)) /
+        sizeof(s->regs.mbs[0]);
     uint32_t write_mask = ((const uint32_t *)
         &flexcan_regs_write_mask)[addr / 4];
     uint32_t old_value = s->regs_raw[addr / 4];
@@ -1208,11 +1210,8 @@ static void flexcan_mem_write(void *opaque, hwaddr addr, uint64_t val,
     default:
         s->regs_raw[addr / 4] = (val & write_mask) | (old_value & ~write_mask);
 
-        if (addr >= offsetof(FlexcanRegs, mb) &&
-            addr < offsetof(FlexcanRegs, _reserved4)) {
+        if (0 <= mbid && mbid < ARRAY_SIZE(s->regs.mbs)) {
             /* access to mailbox */
-            int mbid = (addr - offsetof(FlexcanRegs, mb)) /
-                            sizeof(FlexcanRegsMessageBuffer);
 
             if (s->locked_mbidx == mbid) {
                 flexcan_mb_unlock(s);
-- 
2.43.0


