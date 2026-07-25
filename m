Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9684FC531D0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 18:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnhGp-0005a4-SI; Sat, 25 Jul 2026 14:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dubdublan1987@gmail.com>)
 id 1wnfc3-0005Rh-Ds
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 12:52:35 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dubdublan1987@gmail.com>)
 id 1wnfc1-0006XV-T6
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 12:52:35 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cea3004256so16054235ad.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 09:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784998352; x=1785603152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tovyE2DbLb570DWkXurR66/dN/47WcWTHraH2RaG+7g=;
 b=DBMFCyQiecvVukp6O838O2cnt4RlM/5+qTGnQ9tgdqPoZ+Icp8i0YnEcdu2ObPP8vC
 pSsdA0HzFHJIGuAoiPnUQep4D1PCDIZaA10DhGDl3TIJt8M9EJRx9uFie6LPw6TdJ4n4
 qa2ek3Yni/97BZ4IkKPGbkTJUoBoSG1P/myMHpqUKyrb80uXlh3frrcv9Z4+dMLTED9O
 17bzXyeXylK0x0pRlUGQc26WAqe51iV3OMFv2lCwnDS0GdikNXAFRCfQJHGmlqg9Lz0G
 iodmMU3Izh+H3kr0ff8i+w3ygvNj84vSc8gmvrAHf5pArebbD0yvALH3HWqQWfqXN9MO
 n41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784998352; x=1785603152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tovyE2DbLb570DWkXurR66/dN/47WcWTHraH2RaG+7g=;
 b=L4aAe8Zs0mcAS6BsX8i7mNlgVP3+L+JzeFgK4Y2KX9pzaP7grLeH9gCAZP2IhQcZMh
 jmgmbiN4H7/bNxp/QK7Mv0xtUU1V8D1dnjdTGs/CjuQEE5OJzSfYBofB/RpGl4WUmM21
 gu0anyHyaYY4b3pv+Jxg02TREtyls2Us7xGy2HmHw/SePmof5SmsNlB17I/g4yopPZu6
 oviVQqiiq0Yyg5eTBFlnakLk7Y8BnhT/wEnxPu4uP0Or16Y8D7nbHKe8o+ZdWsQFma1l
 cyvWHoAh3ntseEIqUYJusqjgc2r18TKJT3WDkthRJtswteb/6/rJZCADX3Oxw6yTgdfI
 ck+w==
X-Gm-Message-State: AOJu0Ywqv4PMR6OinDjKk+rvTYpYGYA/Kmc5/tDbTdqU9QBi+96SOygd
 pVP7sAuO0RFz2jxihdwRwh9MmRssuuf/FS8Sm5Nd3U/EzyaKYsVRvKl+PtpRyesCngc=
X-Gm-Gg: AR+sD10zcRzoxjNBRzVjrq6dQsV1Np08Ma9sHeoPH09qCvqXbe9ZHsv0sdudOZNCl9X
 4GA/yUPovdT2OYXY9lqjOLQwLRGIY/GobmQzw97oedD9esR7jFcr1tC4ODfmQ1dY6pyrRAS+rTz
 ugCtpIYEKxLtPmfwvmfVd005c+NvHqpSIpwwI9lWnHzb1dzN5J/AzsfN7p9IWZmeBKzDViLItE9
 +vej5I4FIsXFizqSUUigqIplJKm2p8qJSr2tbIybIXNApigezDAR1WcBupqOxNrebM4e49dPXR2
 bWwVqWQcZcTYL6VOjCaVQ+To5ApEuiMvLJy0cGUIPBnWzM19rfv4QTRQAF7zHLELByhJMB3lVtx
 bwRgFwRIz33knN5AorrFIBHDxEqnNAdrr0EL49cQFqkngE9/m5sfdOgbcvxwVmhFi1bcXzoVI0V
 XCpmSpjFOeWRAxm+deMMiWj8aVq7hxMw==
X-Received: by 2002:a17:902:d4c5:b0:2cf:32bc:9722 with SMTP id
 d9443c01a7336-2cfde866d88mr24961355ad.34.1784998352488; 
 Sat, 25 Jul 2026 09:52:32 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([27.115.61.146])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde81d81csm11027105ad.80.2026.07.25.09.52.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 25 Jul 2026 09:52:32 -0700 (PDT)
From: lanxiaoyun <dubdublan1987@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com, palmer@dabbelt.com,
 lanxiaoyun1 <dubdublan1987@gmail.com>
Subject: [PATCH v1 1/1] hw/intc: resample level IRQ on PLIC completion
Date: Sun, 26 Jul 2026 00:51:18 +0800
Message-ID: <b946a6859040243e973622b7f038a19c2021db95.1784966571.git.dubdublan1987@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784966571.git.dubdublan1987@gmail.com>
References: <cover.1784966571.git.dubdublan1987@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dubdublan1987@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 25 Jul 2026 14:38:33 -0400
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

From: lanxiaoyun1 <dubdublan1987@gmail.com>

When an interrupt completion message is received, if the interrupt is
level-triggered and still asserted, forward a new interrupt request to
the PLIC core.

This updates the SiFive PLIC IRQ handling so completion rechecks the
current source level and reasserts pending state when the input remains
high, matching the RISC-V PLIC specification.

Signed-off-by: lanxiaoyun1 <dubdublan1987@gmail.com>
---
 hw/intc/sifive_plic.c         | 4 +++-
 include/hw/intc/sifive_plic.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index 9c84ff06a9..43f235e329 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -246,6 +246,7 @@ static void sifive_plic_write(void *opaque, hwaddr addr, uint64_t value,
         } else if (contextid == 4) {
             if (value < plic->num_sources) {
                 sifive_plic_set_claimed(plic, value, false);
+                sifive_plic_set_pending(plic, value, !!plic->source[value]);
                 sifive_plic_update(plic);
             }
         } else {
@@ -276,6 +277,7 @@ static void sifive_plic_reset(DeviceState *dev)
     int i;
 
     memset(s->source_priority, 0, sizeof(uint32_t) * s->num_sources);
+    memset(s->source, 0, sizeof(uint32_t) * s->num_sources);
     memset(s->target_priority, 0, sizeof(uint32_t) * s->num_addrs);
     memset(s->pending, 0, sizeof(uint32_t) * s->bitfield_words);
     memset(s->claimed, 0, sizeof(uint32_t) * s->bitfield_words);
@@ -353,7 +355,7 @@ static void parse_hart_config(SiFivePLICState *plic)
 static void sifive_plic_irq_request(void *opaque, int irq, int level)
 {
     SiFivePLICState *s = opaque;
-
+    s->source[irq] = !!level;
     if (level > 0) {
         sifive_plic_set_pending(s, irq, true);
         sifive_plic_update(s);
diff --git a/include/hw/intc/sifive_plic.h b/include/hw/intc/sifive_plic.h
index 32973dbf28..627a418ba1 100644
--- a/include/hw/intc/sifive_plic.h
+++ b/include/hw/intc/sifive_plic.h
@@ -54,6 +54,7 @@ struct SiFivePLICState {
     uint32_t num_enables;
     PLICAddr *addr_config;
     uint32_t *source_priority;
+    uint32_t *source;
     uint32_t *target_priority;
     uint32_t *pending;
     uint32_t *claimed;
-- 
2.43.0


