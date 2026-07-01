Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9044C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes2B-0001yG-2o; Wed, 01 Jul 2026 06:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes29-0001oA-6g
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:09 -0400
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes27-0004kb-DZ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:08 -0400
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-13b305a5301so874371c88.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901146; x=1783505946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zWiuZ1ROl8XvRd9iWZjFamFITqnRfpLZSXc5osvB/KM=;
 b=Q/dA33IZUk0rLScVbP5L0rgOr7p9ud8kncmMlX6VSl5ulb8SalXaaV41BOASw52YOn
 ajl6AtI4CF+BPSCe6/7wcqlYyh0zp/J3Xp2f2AxFE5XctP7ppsWGTBXmOMpols0i5VhJ
 PkwjHHODqY6SCc5XEgH5de9zXkElTzqu36vx3/IRhdPSWbGsvglcuLpkVhQj804eNci7
 BY961XTSyMMpEatwSgmiCVdfBQiubTapwPH9yLjQP1YSVJHlPfOUihrU6hRmPKc0psgB
 II9WzjgUId7cpxPP6ZcjW9Wz14yPqOfLt1Nt3OYhraUvJOCmb8VrOyDH4CPaTrFBO6xF
 AZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901146; x=1783505946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zWiuZ1ROl8XvRd9iWZjFamFITqnRfpLZSXc5osvB/KM=;
 b=Vx2JIB2wAmo/tIrViFv7O5uTf7FWMFtRBmHqxMKI9hjSnI0D7nCsOmK9ykUW8g8L4K
 HbxLIVhfql98FXB4TG0iBmMBkoW7Y7zwBungK7xRwF3L4k+loWF/klQBFR4wm7APxtsY
 uOC0qkAKEll+JaYW/VHBLo/fE0K9iIGsx73Gum3TMg2262hj4AFdrIX9Dweqm6s+bB5h
 6VRYAECoClgGA2unoAzv3PyO5k95C8ESFU88SIlNfu9NzSWFQdOEcXKm0/3GQNsHo7pG
 iOzAhLKHmNBIfhWfofFIVxabmr+UQOGnZ4b3S8HiL0M35ZywXvxAk9Vq68NJAScGw7Tu
 6s5Q==
X-Gm-Message-State: AOJu0YygNUYqdztjlIYkClqmrvcXm6QIbED8YkAFSkJi8X8yYSQamoMe
 fG5yofbvE/4HNHQFjQ/Ev5QPLbXTwedg3TJ1IbwAqrUigsEdRAjSOjrsJOmVxA==
X-Gm-Gg: AfdE7clhMhCIzwu0GU7cCzCC0RHC9pBxwOsI6B9IungMrV6/53EVoa2Ce8jl84bjkTw
 gNIktsZfkNtrEt3XYUOboG+5Jj6wD4vURw+CBoeAn2JE0oBn10ABPlpt1OFJBWYZ1rW1lsQ3Tdy
 B135YUWbfBElcql0mWS0JTsFrSkVkHiZcMyEGVXdMUvwrqViEFwq/y3WxQtQyk0tOiSP7VZDXUF
 ZVnoSNZ/FOOoMfvNyqsTIk/Nm6dfbmlkR+4eWmRF8dBE+yVlZ5DZW8o12TBEyA0OIbYyv5ii8bs
 xJfFFzGBABk9ST44GuUdAHEsgyMP6gwqHCz74NxdZMT6XTe5MtQ3W6Dyr6cOmfwU8j/wcXZrQbi
 ni9qB+Zt454QOjX6kpmmsUESIqefSFR8SIPBPqJjHAPEx1gz0D8R2mhkLxC1sUJhzXRqOKUUCA5
 ghmMNtgKUwH4PjThE/Ue2RQxR3kwyK9LU=
X-Received: by 2002:a05:7022:629e:b0:139:8172:76a6 with SMTP id
 a92af1059eb24-13b36d6d365mr1026606c88.1.1782901145942; 
 Wed, 01 Jul 2026 03:19:05 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:19:05 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 19/39] hw/riscv/riscv-iommu.c: make FCTL.BE read only 0
Date: Wed,  1 Jul 2026 20:17:32 +1000
Message-ID: <20260701101752.2522962-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1233;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x1233.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We do not support FCTL.BE equal to 1 hence do not allow this bit to be
set by software.

While we're at it: the riscv-iommu spec allows FCTL.GXL to be set freely
and we do not have hardcoded restrictions on it, so make it writable.

Fixes: 0c54acb824 ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3576
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260625210833.3294437-3-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 30f16b999c..c9687e01a8 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2609,9 +2609,11 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
 
     /* Set power-on register state */
     stq_le_p(&s->regs[RISCV_IOMMU_REG_CAP], s->cap);
+
     stq_le_p(&s->regs[RISCV_IOMMU_REG_FCTL], 0);
     stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_FCTL],
-             ~(RISCV_IOMMU_FCTL_BE | RISCV_IOMMU_FCTL_WSI));
+             ~(RISCV_IOMMU_FCTL_GXL | RISCV_IOMMU_FCTL_WSI));
+
     stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_DDTP],
         ~(RISCV_IOMMU_DDTP_PPN | RISCV_IOMMU_DDTP_MODE));
     stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQB],
-- 
2.54.0


