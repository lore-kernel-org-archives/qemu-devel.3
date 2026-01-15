Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE41D46610
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSVb-000111-NG; Thu, 15 Jan 2026 13:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVN-0000hx-4l
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:39 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVE-0005vL-Gn
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:30 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so7868945e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503324; x=1769108124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hJ5/R4uOQVO1w2NUZ09BFRMj+Fv1ZzyqWV3/QgKZwZw=;
 b=Yc+7A8MC2GW9Ej3eAKMgTcP4WW0NB6Z3zyKk8rkQvKWprIaa/7qSasJnXSmcH5vAHh
 QFtSJNJ1cls9Kv4J+4G5GhlGhRQ5KiZm6byb/8nRa1cydPvr45M0eAfs9pFGgAql5qgj
 ZUYQDICX0CGwQG78Njfxq5aSHuEOs5shBudZquqn/JLHDpLsWdMRKkLCImLfZKwGrgUW
 d+UlRgsSlP6/rFB2Lumo60HItQtPgNeSqrhOvQyC7Z1xPOG1bX/bIyMxML04wfOE4Moy
 S+3NHJMRRnCC/68dJhA0HDP/umraudztCftqu/DLvanaKUgevO5s+/uDsJjbTBc2sr36
 W1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503324; x=1769108124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hJ5/R4uOQVO1w2NUZ09BFRMj+Fv1ZzyqWV3/QgKZwZw=;
 b=RWRmidHWisHsMMJR65HNTiZm3IQ4nAFIV8Se1hk7SE/8v4KSOZAwI2FWxoy/2UnDyu
 M6tRxc+95Q9EGfqrsCdpT83dcev3iYg70KudmMa4ijVgjQnMMMGvr8ixan2v9MvG7xOS
 6//eQuU/1yLgjxG8IRCpk0hP4VL5S1Ff42OhFdSDfehWi3i/y7wymQYpl146n2zBFfMn
 trKsMoveDR9fYSbb7bfZ6PVi8YPJgdmlf0tP2yPvUGHH6zvDD6pafGyISHF5KREYLURi
 cccxFTrUT+04tJn9oS9zATlvoukzMCka3exIDx4jgDOPmWqbKB8o4QPe+Ga0b+LOejvK
 6goA==
X-Gm-Message-State: AOJu0Yy9hOG8dRCeAXLpwyXuaJPM7n89eTN31nJmgPCrP4K9GdCchrYX
 PKlzogp3sj5KztYKt2gMB6GUF4K3a8jmu8kXacjkUkKmg0tFNyLV38En6zElfDIRSoKqlzJiWYq
 +3d9L
X-Gm-Gg: AY/fxX5J8tYhJdkOjgdgA46od6faB3Cunv0Jm4S0IMN80WUF4YIkjyLAYbWxFSX7zUN
 l4Z9PSitpkb+Mc/RXBlgZSibgOOI+5CLVY5FJhvjowM7t6L4RMd+3ija+AJa9pnT47H2C0SnBSw
 vv0QotdL21ruRCqfA+HFHV6m+m+ZS2qR4WZujfRxrtUu85b5UzX+QAwX3bzzfVSTY5grdg2P2iC
 TvklpJmyoIdRucsMR/BYLKUakDOAgX/wi6Wt9spNiiB7OynThZ+PZwQa4AUOlN4gKJ+O9//860a
 yQMWqFx7dt64DQqeUkeKowv2gFDkpxxm7e8PMrxBVKvpSmfGSc4dbWS1q/EHkAp5MmAQPlJoOJd
 2EIQD1MdJho6jNbFKpGp9fLUIVPn3YKPIgP+nK5EoxcMmOCrMv+E8HnRZpeyZjoQFRCunOs0KlX
 zILtbIgT+wY6d0ensvADpt3i63zd4c/5+vfUYBwVrEIv8jZLEEjrqFfbfEC2fyxoTWS5rr45r36
 2daZqSWznCe9tgOT15rsMFEstxn8hLzTI5Ki/j9oYWkD+N0FLwBSl6P
X-Received: by 2002:a05:600c:1986:b0:475:dcbb:7903 with SMTP id
 5b1f17b1804b1-4801eac2e37mr2059185e9.9.1768503324031; 
 Thu, 15 Jan 2026 10:55:24 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/25] hw/arm/omap1: Remove omap_badwidth_* implementations
Date: Thu, 15 Jan 2026 18:54:58 +0000
Message-ID: <20260115185508.786428-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
References: <20260115185508.786428-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Now there are no callsites for the omap_badwidth_* family
of functions we can remove their implementations.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/omap1.c        | 59 -------------------------------------------
 include/hw/arm/omap.h | 10 --------
 2 files changed, 69 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index b28fbd64fd..47d0f0d736 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -45,65 +45,6 @@
 #include "target/arm/cpu-qom.h"
 #include "trace.h"
 
-static inline void omap_log_badwidth(const char *funcname, hwaddr addr, int sz)
-{
-    qemu_log_mask(LOG_GUEST_ERROR, "%s: %d-bit register %#08" HWADDR_PRIx "\n",
-                  funcname, 8 * sz, addr);
-}
-
-/* Should signal the TCMI/GPMC */
-uint32_t omap_badwidth_read8(void *opaque, hwaddr addr)
-{
-    uint8_t ret;
-
-    omap_log_badwidth(__func__, addr, 1);
-    cpu_physical_memory_read(addr, &ret, 1);
-    return ret;
-}
-
-void omap_badwidth_write8(void *opaque, hwaddr addr,
-                uint32_t value)
-{
-    uint8_t val8 = value;
-
-    omap_log_badwidth(__func__, addr, 1);
-    cpu_physical_memory_write(addr, &val8, 1);
-}
-
-uint32_t omap_badwidth_read16(void *opaque, hwaddr addr)
-{
-    uint16_t ret;
-
-    omap_log_badwidth(__func__, addr, 2);
-    cpu_physical_memory_read(addr, &ret, 2);
-    return ret;
-}
-
-void omap_badwidth_write16(void *opaque, hwaddr addr,
-                uint32_t value)
-{
-    uint16_t val16 = value;
-
-    omap_log_badwidth(__func__, addr, 2);
-    cpu_physical_memory_write(addr, &val16, 2);
-}
-
-uint32_t omap_badwidth_read32(void *opaque, hwaddr addr)
-{
-    uint32_t ret;
-
-    omap_log_badwidth(__func__, addr, 4);
-    cpu_physical_memory_read(addr, &ret, 4);
-    return ret;
-}
-
-void omap_badwidth_write32(void *opaque, hwaddr addr,
-                uint32_t value)
-{
-    omap_log_badwidth(__func__, addr, 4);
-    cpu_physical_memory_write(addr, &value, 4);
-}
-
 /* MPU OS timers */
 struct omap_mpu_timer_s {
     MemoryRegion iomem;
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index bdb2e887e4..66a435a3d7 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -673,16 +673,6 @@ struct omap_mpu_state_s {
 struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *sdram,
                 const char *core);
 
-uint32_t omap_badwidth_read8(void *opaque, hwaddr addr);
-void omap_badwidth_write8(void *opaque, hwaddr addr,
-                uint32_t value);
-uint32_t omap_badwidth_read16(void *opaque, hwaddr addr);
-void omap_badwidth_write16(void *opaque, hwaddr addr,
-                uint32_t value);
-uint32_t omap_badwidth_read32(void *opaque, hwaddr addr);
-void omap_badwidth_write32(void *opaque, hwaddr addr,
-                uint32_t value);
-
 void omap_mpu_wakeup(void *opaque, int irq, int req);
 
 #define OMAP_BAD_REG(paddr)        \
-- 
2.47.3


