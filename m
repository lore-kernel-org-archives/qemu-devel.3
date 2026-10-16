Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67ABCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWNt-0002PT-S9; Thu, 15 Oct 2026 21:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWNS-0001df-A3
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:55 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWNP-0004Pg-DQ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:54 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2e8f2c3ad6bso26296475ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112690; x=1792717490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CPWVywykmMjhY28EXkEn+o4MKqXIZACMUINLYzr0uVQ=;
 b=oo/VdKLSxQMhZ7McdER9SQcsS8q/SJ2AOyUJvIkJaHob5mZx1IaG2cqmLKIsybrwbW
 KedDVHAhQqk1ic0I1tLa7BYW/2o/OHEOLATLuRYiPCpZ6rb87Pa0LXc0JB8JJJHEQEBz
 beFzLNUlrRtDyGYgkUrCi9J6BeyNDSf3sRheMkVS1nJwSM2ucnBHUkUDPlgM3GZmqU5F
 5DsHfaGG1cMVLRB+mJp9vRNeBXVBsicRS3ZkAIFdUVy7KixZkW0ZCR1xW+Qg301KsPh4
 OypODdv4QIp+Hha2aSFpbkvYA4F+ElLw4qWNtmDQcSryBQXIwm5fHHBXJ4MSLESDGegU
 6WsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112690; x=1792717490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CPWVywykmMjhY28EXkEn+o4MKqXIZACMUINLYzr0uVQ=;
 b=VFwu55PN98dcq+u+OqKHOc/NDvyeGwPP5FKedz229ylzHDv6cCy0J6UscdDavvg28E
 zK8BY9WZWL6p1znHbXJuZEuqCk9RqNb5WOtJu9Xd0nFlFmD+ML6Em0IzovrsXOPZx7q0
 1sxCOEbYRhWYqAa+Z6Oj+9Ys6hnkkhtByz0U0O9AEj3yVDhGI9IuO6oPJEDZ81D3SfQK
 iGDdter+fy56GjTCmOJp0MLxl1XnR4lR690DJEi0hG8Qw+7Z8kVHgkp2ayek9q+z4ZkT
 Ifj2AAytleCtUBfp9DztPZhuPgh/ltNyF16u0/QHftEmsSLR8dFOCjzGFiAhG9YlF1pV
 P6PQ==
X-Gm-Message-State: AFq9FYJCPc4R/vcDYcmnB+IRA31kjJvgac+fDRt9HGpuBiHm8XQxm7ll
 6SzSMjrDTXsFfev018Pi4wlnII2qjxCd3g8ihog1oHJBm1kJ/ZSp0DRGxnWkFw==
X-Gm-Gg: AYBFou0S8B8JdxBU6eltR9P7cl859Xrv6zWWe1HpJoVzWVCRqP274s3OYKXMooQF0T7
 Y+Q9FYxDuvSf8tpGfys3Nl11ix6IXAL2cBKb83AeABK6thQkEtRFy5m+WLvR3VuIeISuv3/5j+3
 INLwglqAPLra92Spvaa7TS463nYmpH0NmyRZDHS2pmMyceT6NE7DA3xssu8cnzwHXOp0H6FXErh
 5Nu7XY5Nwh1dJhE1lcliVWwjDqtqBaJDrvNJgSGM1VpBiwTix3EEcxsjsCve3cVmk9JfzVw3Wwm
 OzuQulPKB7aXokZx6lM/9x3nOrs/Wz0YbIdRYjgUDXkgrBTwzI5WmlF4bMMrIm+7J+1LxBMv6NV
 uOjic4EfFJS3EM1TCMaQ1UsjCtdJPCrJ4sBvgZT7UnpL5XCpTWJ7/yqSUYZAhJbUop18NBA6t9y
 EvlI6+tKQSeTVPKuePVBRycJwNBItnMfi/6I2XJZR/yvmmolMVBmYnykpPxrwokV/FKnWF3fmA3
 6012qoSMKajvMDP
X-Received: by 2002:a17:902:e94c:b0:2e2:fc90:11a4 with SMTP id
 d9443c01a7336-2e842d0262dmr174530625ad.48.1792112689982; 
 Thu, 15 Oct 2026 18:04:49 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:04:49 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Rick Richard <rick@sloservers.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 42/50] hw/riscv/virt-acpi-build: Fix the UART register width
 in SPCR
Date: Fri, 16 Oct 2026 11:02:29 +1000
Message-ID: <20261016010237.1102834-43-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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

From: Rick Richard <rick@sloservers.com>

The riscv virt board uses a 16550 UART with an 8-bit register stride,
but the SPCR table reports 32, which looks to have been copied from
arm virt, whose PL011 has a 32-bit stride.  Change it to the correct
stride for a 16550.

Fixes: 3e6f1e61b4 ("hw/riscv/virt-acpi-build.c: Generate SPCR table")
Signed-off-by: Rick Richard <rick@sloservers.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20261005104008.214588-3-rick@sloservers.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt-acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 8e516ec114..0475dcb5c6 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -246,7 +246,7 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, RISCVVirtState *s)
     AcpiSpcrData serial = {
         .interface_type = 0x12,       /* 16550 compatible */
         .base_addr.id = AML_AS_SYSTEM_MEMORY,
-        .base_addr.width = 32,
+        .base_addr.width = 8,
         .base_addr.offset = 0,
         .base_addr.size = 1,
         .base_addr.addr = s->memmap[VIRT_UART0].base,
-- 
2.55.0


