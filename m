Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8527C44524
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmnRR-00020e-JQ; Thu, 23 Jul 2026 03:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmnRG-0001xO-69
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:01:57 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmnRE-00042p-FX
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:01:49 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493f75f7172so2552395e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 00:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784790107; x=1785394907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EM3hMp/KfUSEwl/8SCDaWLH0SWyyv+tEDVdwL/ZkQ2c=;
 b=rO1fh2OT1ZCvZtzYfhBd8VonM4p8dcxN8ne/zxdvwFj/XT/cFctDXfvNk3GOZ/VDkq
 5yTAdoOB/GV0bNlOJez2Naja8T7UXM/t97vltPou3dDUtWS/lxXWoxbRUPq94IF5AY+g
 3cygZsHl5ixbEbfTSEM5NSKUpGWIS1jSOR0ZRBTQu+3T+0pnHHN3akDJ2g5RYVqFsA3m
 o1rKXL7kGF69jcX94lsUKOiRjKZ90X1Wn/6s5MybXv3VnEonr2eFxTqfbi+tFUm0grrK
 rCuWavfDoQEQYYAXeehpQa/7TJxMIyEZexaB7QRiLPm+1oIGK2aD0FA0U9rTo/lGzX7a
 Ir7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784790107; x=1785394907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EM3hMp/KfUSEwl/8SCDaWLH0SWyyv+tEDVdwL/ZkQ2c=;
 b=UCl+ZRC7PH7KmT8fatHhVgvg12JWpV5a3oI91rvGSX9YdJhsSObjvuM6+d2+AZUGOo
 5S37u4tWHO/+AnInZLEzv/Nqhi6L5i4Pa5NsHKgpmtfojJKBUdmpAupsNejBqOzim7B2
 QFNUf7RAF4wQCA+6Wb/ltFSn0t79D4pd442GxuWS6YqOzK7U/ENU5t2qruTSHdTg0iUS
 V5mq9qbTYDWXXHdD5sKVdqr1IYFOMkWrDrgj4kaXanqPxwZrCELO7L4GpFq2SkeZdWmh
 FTDSZwUVXZhv+CDvI6IfE7pSa4ND9FxpcJmAhvASih6DfO05nhXEQ9SKPKYAo+kCfcgK
 /HyA==
X-Gm-Message-State: AOJu0Yyrd+BrvMuvvS+UIRGv6OhWb3vvAMmNgkuZTGcB5mumLsgzGbyd
 CEhHw6pvUE2c6xPY/ksR8wOwQYG31xqSexZMhd+wVbvflMm060rt9StwsmW3DQ==
X-Gm-Gg: AR+sD13x1IIwPt0H94azf3Wm9voOdMzp6Y0tLAV2nZSW0qqeY9EEYLsXnU9N2zj8m0+
 BMnYnDwZ34WsFrnG5giDjdRjhHBu9UW0C6cRZxOwChoRtCFuUOieQsseMY0xAHZ9OCLUrV/FNnz
 z5Im2r3E7m98/BCeRpIZk5Zxjz2cptxyybJ+viwlqfKuXfz8AoE4A60aGimUKnt9Zrv7V31XgYr
 TatMZtDTMb9Ir13+bKrr2ti3BQ6KRkduTVaccqFoLouUhLit0eJNp5Hwkxd7MCMFMFJO37mDneV
 EaA5ZI1/g2BcqcOAZPwq3q9LBPtk+pymrWiUFC9IOI30lpg4jjcd9Aa9aVi5X6nLn7xMPkyzCvN
 LQxFq/50F/4nN5iZz4uUoyMGsiovqNzaojJsczuW/PsoP6RuK38GALmSZ9Tv1aAf77oVLOePk/4
 I/zpN6WO63rpisxXfYXx1so7g5Z0t2ma+6LdynuECH7zJNenA1w05COHhfLcUNaf51v58ITipKf
 Rl+LDxpg8favXgo6OKqPS3kNg==
X-Received: by 2002:a05:600c:6610:b0:495:6a2a:951f with SMTP id
 5b1f17b1804b1-49573cd02fdmr19339135e9.17.1784790106711; 
 Thu, 23 Jul 2026 00:01:46 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-29ed-6000-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:29ed:6000:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6dc25sm13293923f8f.33.2026.07.23.00.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 00:01:46 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Matyas Bobek <matyas.bobek@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 4/9] hw/net/can/flexcan: Fix mailbox index calculation in
 flexcan_mem_write()
Date: Thu, 23 Jul 2026 09:00:54 +0200
Message-ID: <20260723070059.6332-5-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723070059.6332-1-shentey@gmail.com>
References: <20260723070059.6332-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32d.google.com
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

Calculate mailbox indices from the `mbs[]` array layout instead of the
oversized raw `mb[]` view. This prevents accessing mailbox entries beyond
the valid array range and fixes Coverity CID 1662974.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/net/can/flexcan.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/net/can/flexcan.c b/hw/net/can/flexcan.c
index dd92a38337..651904fa37 100644
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
2.55.0


