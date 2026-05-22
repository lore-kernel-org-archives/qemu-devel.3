Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20037CD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDRE-0007Vh-1P; Thu, 21 May 2026 20:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDP0-0003WQ-80
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:06:11 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOx-0004t3-5U
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:06:08 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c80167f5716so3031897a12.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408365; x=1780013165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9bwpeumJ2izE97RkjbXjcgeqxl+uF8JYIPAf37QnAyk=;
 b=qx2F/vTfiPcfD6sQvksKB/icvDbkZys0EHuvr78isjQ34jttfITCnMzhzll1jiKh0s
 FvR56x6ZDR7W3C4dpHvzmPSF59TaA9Y/AUoy1KU6z7xkyn1D2sv6UWD0eGBRwT2IwnXK
 elo+7fStozo0kyPw7EesI2sYLbiRPRf6HlVWPAehdG5uUlIwRiQH4WO0/H3U/oSmbNXA
 G+iR757ng7G7pBoXV8KZjHDv6iJwSidh0sZgMNGG+R1uThqfz/FG2YFrizkbKwXI7294
 eYM8AtVgdsdrJrKxElMbGBeSkqx4iTdI/DYgiWzW3GYrAa++YjNes+1T7WcKR12WyAc2
 J0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408365; x=1780013165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9bwpeumJ2izE97RkjbXjcgeqxl+uF8JYIPAf37QnAyk=;
 b=WQFsbM4Ky29qQ+Kd647kweOqigjuS7QE/E/G0PME5GASE/eq6DJQDvuMvG5HbHUNE0
 9grod//MMdtaPQFqx1M5KnNMEHgVNE5Tww1V2cOf9Lgow+kRXuSoop92KMay79Gp+4GB
 QbI3vfVSCV9lIr9zhJVys0ZeqGm6OgIPVCM1YwVXmhb0gYL1Rz3t/Qv00hpKWCOYhJU7
 Cx6SCx0q8lQrS3NOidmRtJkEobF6+p5sPkQ2JOPD+bVAQJy8qONxaweaPc/+lwjLyOXr
 lqxqNH5jnnbaAtwV9PV9lg6zZBgvMHJRsMGszljUArItGOLt0eaO4GJtGaX1PGvrU5zZ
 3c3g==
X-Gm-Message-State: AOJu0YzY+R54Pti9Oy2QtoIkLwUhPOMLU6cuH5cQi4kkmoUMluPbm6cq
 nmHiWgFoXy5TQKPpuZrlfObs5mGcV8iIf6kgKyzuxaHRFtlrDcDv+YdyukHx+5n+
X-Gm-Gg: Acq92OGDcQsIR1QCf52Sl951nMAM4swbxOmj4ZHjIkrL09PxZfpU8ue3f2Y3jec7T/9
 xXs/tpukD9iUK8OCG52Mo5O/liHmurVZZIaj3ae1Rn9d+13APbUzgVdFe1CkhiQxLXx9rKW9XPt
 3ayP5GFcd3uT0S3gYWnFuEYiHmkqW9Hfbgqlk0BjkzDB+M68rtrCjZVqh83fcpFe+LcDyRqkmjz
 0do1ac/edl94rlx33mt4Y9x8yitEn2yhlUloiDH3HMdxd0MtgT/h5ESj0NO/7wBSZlTeXARRSKb
 STS32ZSo4cCUcqgHM6OxpjaL8a7oLwOOl7Huu3u2Yqob2WpNOtGAzIELtwgtrc3rQ7ZHq+ZoAIP
 VTaywzOhfX0JMM1t67/F+zSHCH8OoZzZw89ma+Fk6N7eJvV0lu2sWTRKi4qlF6Urz4/lWUVLZKT
 5wKmbjh9QZMaZxTzH9rUMKNU7ukxhmhGLP3LizQUQDag==
X-Received: by 2002:a17:903:1a2d:b0:2bd:5ddd:17ab with SMTP id
 d9443c01a7336-2beb080c8fdmr9167495ad.32.1779408364620; 
 Thu, 21 May 2026 17:06:04 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:06:03 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 46/48] hw/intc: riscv_imsic: Add reset API to IMSIC
Date: Fri, 22 May 2026 10:03:22 +1000
Message-ID: <20260522000324.23255-47-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Jim Shu <jim.shu@sifive.com>

Clearing IMSIC registers and qemu_irq in the reset function

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260428160103.3551125-4-jim.shu@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_imsic.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index 7c9a012033..ac59496c22 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -342,6 +342,23 @@ static const MemoryRegionOps riscv_imsic_ops = {
     }
 };
 
+static void riscv_imsic_reset_enter(Object *obj, ResetType type)
+{
+    RISCVIMSICState *imsic = RISCV_IMSIC(obj);
+    int i;
+
+    memset(imsic->eidelivery, 0, sizeof(uint32_t) * imsic->num_pages);
+    memset(imsic->eithreshold, 0, sizeof(uint32_t) * imsic->num_pages);
+
+    for (i = 0; i < imsic->num_eistate; i++) {
+        imsic->eistate[i] &= ~IMSIC_EISTATE_ENABLED;
+    }
+
+    for (i = 0; i < imsic->num_pages; i++) {
+        qemu_irq_lower(imsic->external_irqs[i]);
+    }
+}
+
 static void riscv_imsic_realize(DeviceState *dev, Error **errp)
 {
     RISCVIMSICState *imsic = RISCV_IMSIC(dev);
@@ -425,9 +442,11 @@ static const VMStateDescription vmstate_riscv_imsic = {
 static void riscv_imsic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     device_class_set_props(dc, riscv_imsic_properties);
     dc->realize = riscv_imsic_realize;
+    rc->phases.enter = riscv_imsic_reset_enter;
     dc->vmsd = &vmstate_riscv_imsic;
 }
 
-- 
2.53.0


