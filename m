Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275CBC02192
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 01:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfqkY-0005Op-0T; Wed, 05 Feb 2025 20:32:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <36xCkZwgKCuAYWJCQVUJIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--wuhaotsh.bounces.google.com>)
 id 1tfqk0-0005Dp-U1
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 20:31:41 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <36xCkZwgKCuAYWJCQVUJIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--wuhaotsh.bounces.google.com>)
 id 1tfqjw-0006uV-Jl
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 20:31:39 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2f2a9f056a8so657745a91.2
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 17:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1738805484; x=1739410284; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=WsWjAnQoV5+dN/1tZPcvZ/fh72rcfhDuImjC7M+anmE=;
 b=d1rsxkn6q1Z5tiN0ZwtM+AHC4Wk1LcHHvH4Akimwqov6Trm5S8CKB5X8G6+TZs5afI
 XByRkexghuBTvwAXKaFjZH+Axf02GOQM52rI86RJM3yw9qwI6Fn8w+E/4wvYTfqMR7ta
 qB5sFfc/+kJH0wskuXsrTpvf9rerNCxv0urRX+4+RqeI5X85Mz19klMk6tdk4ZlnDDa9
 kO5kKfn92hEZJ2gDnR/i6ji9DN6+AyLItEkwFyqecEOzh3qySJw3qjZ/xwKTOcVgTFQu
 KG+NAQXUUKcjXY1EKWXh53L9Ox9XSRhcvntw/QQMldI4wSe1MLwv4/0N8NS2bdBHY9Y4
 4GUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738805484; x=1739410284;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WsWjAnQoV5+dN/1tZPcvZ/fh72rcfhDuImjC7M+anmE=;
 b=PCEhSB3wqkKdmSjEUIThi6kvqqFtojwLf8JfxbfsPdC2A1+lQYQ6LWmcm4QB7uRr6l
 uFz7Oy7qDiwEk7TcXG1fFUK/z571L23rEOoFq0T9jf7kAc1Mm+WxfJAkg9gg/399EWGw
 bos7MOD/mXxx5zgj50PLEH/xjGuZwA042ik2LBzHB6dCQIaeiNzc8e93PSgQOYveKJ7N
 NW0y72eSZUhpJvh+cXMqysj1u0zsotqqzlHC0slfn6PcfqgwaJ0HmDfs+8P7UsC2EqVF
 2Y4S583BDhBLz8JlIiSbG/Q5FsEyYxiA1IHvsT9fql4wtFWWoNHQNKZR+OoW4KmKv4jq
 L9hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtPkiRrsg9Zjn7rzKFEz4w36AlS7ge1BNHI2pBKilgZMAdn/K54HFzjV5tcH0nyEgiIPxCniha10EB@nongnu.org
X-Gm-Message-State: AOJu0YxskcDeEQFC/5gkKbkf1esAPbB2Mc3YYefEw5HFVbI5LfOI2pfl
 fk8gTNk1soSJ1yroBnCL3a1RWn2yd9jeHJUnEr0w7+UYUTu3/at6oQNR47L5gWJ6XOCjqT+1U7s
 ji9CkhC+A+A==
X-Google-Smtp-Source: AGHT+IE3JrWgyTVbckQq0hMNi1jmsWz/wY+jAobwtSL5uDJhfUiCh+CzNgoq/gb0uqb5Wfu5JMWxKJz2t36b+w==
X-Received: from pjbsj1.prod.google.com ([2002:a17:90b:2d81:b0:2d3:d4ca:5fb0])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:52d0:b0:2f8:4a3f:dd37 with SMTP id
 98e67ed59e1d1-2f9e077dceamr8823596a91.16.1738805483756; 
 Wed, 05 Feb 2025 17:31:23 -0800 (PST)
Date: Wed,  5 Feb 2025 17:30:56 -0800
In-Reply-To: <20250206013105.3228344-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20250206013105.3228344-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250206013105.3228344-9-wuhaotsh@google.com>
Subject: [PATCH v3 08/17] hw/misc: Store DRAM size in NPCM8XX GCR Module
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=36xCkZwgKCuAYWJCQVUJIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--wuhaotsh.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

NPCM8XX boot block stores the DRAM size in SCRPAD_B register in GCR
module. Since we don't simulate a detailed memory controller, we
need to store this information directly similar to the NPCM7XX's
INCTR3 register.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 hw/misc/npcm_gcr.c         | 24 ++++++++++++++++++++++++
 include/hw/misc/npcm_gcr.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/hw/misc/npcm_gcr.c b/hw/misc/npcm_gcr.c
index 19a4b2cd17..820b730606 100644
--- a/hw/misc/npcm_gcr.c
+++ b/hw/misc/npcm_gcr.c
@@ -281,6 +281,19 @@ static void npcm7xx_gcr_enter_reset(Object *obj, ResetType type)
     s->regs[NPCM7XX_GCR_INTCR3] = s->reset_intcr3;
 }
 
+static void npcm8xx_gcr_enter_reset(Object *obj, ResetType type)
+{
+    NPCMGCRState *s = NPCM_GCR(obj);
+    NPCMGCRClass *c = NPCM_GCR_GET_CLASS(obj);
+
+    memcpy(s->regs, c->cold_reset_values, c->nr_regs * sizeof(uint32_t));
+    /* These 3 registers are at the same location in both 7xx and 8xx. */
+    s->regs[NPCM8XX_GCR_PWRON] = s->reset_pwron;
+    s->regs[NPCM8XX_GCR_MDLR] = s->reset_mdlr;
+    s->regs[NPCM8XX_GCR_INTCR3] = s->reset_intcr3;
+    s->regs[NPCM8XX_GCR_SCRPAD_B] = s->reset_scrpad_b;
+}
+
 static void npcm_gcr_realize(DeviceState *dev, Error **errp)
 {
     ERRP_GUARD();
@@ -324,6 +337,14 @@ static void npcm_gcr_realize(DeviceState *dev, Error **errp)
      * https://github.com/Nuvoton-Israel/u-boot/blob/2aef993bd2aafeb5408dbaad0f3ce099ee40c4aa/board/nuvoton/poleg/poleg.c#L244
      */
     s->reset_intcr3 |= ctz64(dram_size / NPCM7XX_GCR_MIN_DRAM_SIZE) << 8;
+
+    /*
+     * The boot block starting from 0.0.6 for NPCM8xx SoCs stores the DRAM size
+     * in the SCRPAD2 registers. We need to set this field correctly since
+     * the initialization is skipped as we mentioned above.
+     * https://github.com/Nuvoton-Israel/u-boot/blob/npcm8mnx-v2019.01_tmp/board/nuvoton/arbel/arbel.c#L737
+     */
+    s->reset_scrpad_b = dram_size;
 }
 
 static void npcm_gcr_init(Object *obj)
@@ -373,18 +394,21 @@ static void npcm7xx_gcr_class_init(ObjectClass *klass, void *data)
 
     c->nr_regs = NPCM7XX_GCR_NR_REGS;
     c->cold_reset_values = npcm7xx_cold_reset_values;
+    rc->phases.enter = npcm7xx_gcr_enter_reset;
 }
 
 static void npcm8xx_gcr_class_init(ObjectClass *klass, void *data)
 {
     NPCMGCRClass *c = NPCM_GCR_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     QEMU_BUILD_BUG_ON(NPCM8XX_GCR_REGS_END > NPCM_GCR_MAX_NR_REGS);
     QEMU_BUILD_BUG_ON(NPCM8XX_GCR_REGS_END != NPCM8XX_GCR_NR_REGS);
     dc->desc = "NPCM8xx System Global Control Registers";
     c->nr_regs = NPCM8XX_GCR_NR_REGS;
     c->cold_reset_values = npcm8xx_cold_reset_values;
+    rc->phases.enter = npcm8xx_gcr_enter_reset;
 }
 
 static const TypeInfo npcm_gcr_info[] = {
diff --git a/include/hw/misc/npcm_gcr.h b/include/hw/misc/npcm_gcr.h
index 9ac76ca9ab..d81bb9afb2 100644
--- a/include/hw/misc/npcm_gcr.h
+++ b/include/hw/misc/npcm_gcr.h
@@ -68,6 +68,7 @@ typedef struct NPCMGCRState {
     uint32_t reset_pwron;
     uint32_t reset_mdlr;
     uint32_t reset_intcr3;
+    uint32_t reset_scrpad_b;
 } NPCMGCRState;
 
 typedef struct NPCMGCRClass {
-- 
2.48.1.362.g079036d154-goog


