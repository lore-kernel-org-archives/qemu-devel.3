Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F373C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww4KN-0006Yj-O6; Mon, 17 Aug 2026 16:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4KE-0006Vm-8n
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:52:55 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4K9-0006eE-Hx
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:52:52 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso39085705e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786999967; x=1787604767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L+gW1wiFrC5AU2FvtCfTO+raYkF74Y7Owuy0sVGpL5Q=;
 b=Ij/PxbZ+BDcKuMmgAg9aBHAhWpLL8OTO7Gzlttcf52mNIi9hhOowv06SqpAx8blgsF
 157GHZAsCp3+A3xPkbSdC0hIJwiuCO1NDk9QRBF6oZSt6nu5SgDGmMi5+5U/CP/ebFZl
 0A28q/kP3SQlzXcrAFr5EnzC+YpbErrjpA/vs1BIMq0tmGwcD1cjqbe8fVcnIlKULYQ9
 DEQAWIWGLATLLYuDLgKylHa4h8wn2u5iU0SVYn9cgfDYC2ng/Dn7HYmvMzhtVMS/bmZ3
 s8YRCIVal/KeyXnIliQ7ppSPXDDBZA2mk48K14SiUiJvWj6x2p8YTeW8U0EjJ2ObuBy2
 DXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786999967; x=1787604767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=L+gW1wiFrC5AU2FvtCfTO+raYkF74Y7Owuy0sVGpL5Q=;
 b=hf6KkwX2ILSt0HqnVYDjMOSLrIAYRn9ze67w50VUmAdatREFtq1so0peJCCDHXeEet
 nFY3FnJTRAQ06Gc4niLlTYjwgUXBk29Q3NBmLQMfT0OQAgxLLMK1T4VUrj6YMdHZPrGo
 LwfHK8usD2h1wZo2TnfMo4bsAXRh+uiF7qW/0WZGmFt6uRzee8z3xrCj2g5C93XS7gOT
 wp1uDUpZvBIrosacBl8ny4tDF1aDdLk/VgMNNWy8UJujBFTpq68C5kbjAZMhPgKCiKwP
 zNPyqVMU+ZL3JhoZWMbT1zTQHPCV7oWwp8eq7TGdCVVLXMbjlY0L9U1bMAIROxnHkCAu
 CZug==
X-Gm-Message-State: AOJu0YwznlyeR0xRti9eIb6zWz3FtVvfF17RohDCZ6UBEyAZwjGUKR2n
 cdGrEuvZwLtPBzsw/QA3d3GXAeJk6UNne4NeIXPSqk8yBW5XHncc19KyWDpv6opG/SIN9HKH48b
 L5jUt
X-Gm-Gg: AR+sD13OCC51EvbAJTBjmQvIcM07HTtI8kIqCZNUSddhKNQCu1tkqaTcwyPEH+kj+GG
 x/riQVrnDzoNjXJS807mSb1VlGXjU1KVjI8M4MtmL6cJ0Dic2/xmz+8ttE7u7IaHqltn8o35fCq
 toZKech9nfE4ikYcaiVdHxmwz76V81kgVC6tjoJhh6HFej0IZved3qZ1Jor1t2+/TDhtRRK136n
 WrAr/zwf6mtattlVgZv4yjwEDztvVC62HweJbWieC0eb/1FClUPJ+WfR1hysEXjlpPVfaVdK9tN
 IONg2gBfbJ3ZlL5N9jRNwC2aZMYZYqzSaFf3Y2w6c7rft5E/scgbFz78s6Z5CPXNMZQqQJHdViA
 Fe92vWvmCKx3npHLEH6pbhiYPDunMoGF4v4HOffdpphrRRWxYClHdlrh1bMk01nK4KgvIB/nEUJ
 GGBDZEof2sLo0FeZA37x5GNraCkADy0mnjTomGmQUyTUVUBbMNcik=
X-Received: by 2002:a05:600c:3596:b0:499:8ed2:8234 with SMTP id
 5b1f17b1804b1-4998ed286c1mr336939505e9.0.1786999966993; 
 Mon, 17 Aug 2026 13:52:46 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499961098cdsm202573365e9.6.2026.08.17.13.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:52:45 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH 01/15] hw/ide: reject an unsupported CHS translation
Date: Mon, 17 Aug 2026 22:52:28 +0200
Message-ID: <20260817205242.1199851-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817205242.1199851-1-den@openvz.org>
References: <20260817205242.1199851-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=den@openvz.org; helo=mail-wm1-x330.google.com
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

From: Denis V. Lunev <den@openvz.org>

ide_set_sector() divides by (s->heads * s->sectors) when the drive is
addressed in CHS mode. Both come from the guest via INITIALIZE DEVICE
PARAMETERS, and cmd_specify() stored them without any check, so a guest
asking for zero sectors per logical track killed QEMU with SIGFPE on the
completion of the first CHS read or write. s->heads is safe, as the
command passes a heads-1 value.

The count has an upper bound as well. The legacy sector count register is
eight bits wide, but handle_cmd() takes the count from a 16 bit field of
the register FIS, so an AHCI guest can ask for up to 65535 sectors per
track, and the CHS branch of ide_get_sector() then overflows the int it
multiplies cylinder, heads and sectors in.

ATA-5 6.2 numbers CHS sectors from one and ATA-2 D.2.8 limits IDENTIFY
DEVICE word 56 to 1 through 255, so neither end is a translation a device
may accept. ATA-5 8.16.6 requires an unsupported one to be reported as an
aborted command: do that, leave the translation in effect alone, and
refuse the value rather than checking it at every use.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Fixes: 176e4961bb33 ("hw/ide/core.c: Implement ATA INITIALIZE_DEVICE_PARAMETERS command")
Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2399
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/core.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index fb9bf11b45..747fa71677 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -1655,14 +1655,21 @@ static bool cmd_check_power_mode(IDEState *s, uint8_t cmd)
 /* INITIALIZE DEVICE PARAMETERS */
 static bool cmd_specify(IDEState *s, uint8_t cmd)
 {
-    if (s->blk && s->drive_kind != IDE_CD) {
-        s->heads = (s->select & (ATA_DEV_HS)) + 1;
-        s->sectors = s->nsector;
-        ide_bus_set_irq(s->bus);
-    } else {
+    if (!s->blk || s->drive_kind == IDE_CD) {
+        ide_abort_command(s);
+        return true;
+    }
+
+    /* ATA-2 D.2.8 limits IDENTIFY DEVICE word 56, and the count, to 1..255 */
+    if (s->nsector == 0 || s->nsector > 255) {
         ide_abort_command(s);
+        return true;
     }
 
+    s->heads = (s->select & (ATA_DEV_HS)) + 1;
+    s->sectors = s->nsector;
+    ide_bus_set_irq(s->bus);
+
     return true;
 }
 
-- 
2.53.0


