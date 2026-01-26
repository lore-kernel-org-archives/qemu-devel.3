Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E255D1950F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQdA-0001fr-HA; Mon, 26 Jan 2026 12:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQd0-0001Vr-H2
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:54 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcz-0000Gr-2j
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:54 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42fb2314f52so2766756f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 09:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769449431; x=1770054231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wlscyxPY8xEICFQvh9NAzy5egnUtRHu9+/Su9mVanbI=;
 b=TJpz6NMXyAjDxSjdJOZpFlTVhfmvHIFsagDsvI46hDPLvMceA/AZAaRAdQNqSTQeVL
 1MRcpUtznLUEuvwQcnceMhoV8jnLCeLEhKhCxf1TZbTqY/V9Xmc0KeBA4Owh73cW0+27
 4cZjzZQ6OHzUJjKKkR6lF0H1zOvqJ+458nz8KrMq/Z2vmoLD391sRNhUuS2DLsxwvAwj
 CN9lj2hqYw0N0jpOxyemGcm7+5fnZEoVaOq8NEI2wzSBDE3wKrIqn2GYe70cGAboq/nY
 7CSVX3IC1G9WI23wMA/0G02xxfFc/otZMogNNbJ1ME2UzWuyvGx0oW9QgJZS/Kfik+kU
 YI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769449431; x=1770054231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wlscyxPY8xEICFQvh9NAzy5egnUtRHu9+/Su9mVanbI=;
 b=O0pOSCGxAcQoTVWmzFR27Bnroxg3EKv8gwVha8oZWdP2fZCKYSv/UpAUomA+sQVUSo
 gJayZiOxlUygcQIH/y2e0A5jqXVdKsv9ikf5Fc01P/YeQHeotW0WrAS9ry7ACa1W6EaV
 TdMq/S5MYv6XFUbddFU7H/VwZmQyul7JY34hkSxBzB1HgYqYdcHTrG3sfWuH1tgIpMGf
 KRRE25+YCCkkN3IR5utypEnWtWoMh48j/YBCbmRuTfLPQNk5UfpmGgw8wVtyAamDw4eO
 wkx4L0qKxRkp/SSACBIZEh+gdRZnR9tUWNaVHWEJdv55TuTG8xxJZ+eyDZnXNQHmVbq3
 fl2g==
X-Gm-Message-State: AOJu0Yxx00tHGgb5OmbsHQpSfXhhyyQfBPxGzO7riAqAwx8TnI7YhM+E
 VzCH1WWmFFgW/s55eJplAjDNqhp41B0tUZ4HAeVRLa5LYY6QfglLVZCY3fm0xbz5
X-Gm-Gg: AZuq6aJF3S6HJ2jdwBvP4QCED9lUYhHFfht9kinEsPyco1Qi9+hFe4r+SqRmo3UGd64
 4lgoSwbmEtOcMUHGpRgbTX7nWB6AGo6+AKX7U8F3Yf+fSoSdznCN478/6j2PCM8KZixXNX2/StV
 D4N5Rz59nnOSlCZvsKow2eRupIVF5snm0qExhoZbyIXyxR7DTm0Kg4kwFTLtkBJagjKAdw7Zzhr
 zjjxq9S6SDd6b8TwWUPrEDQbW4SeXNQ2frw9hTr2RWLR5WBbTVUWqhlFEoLGixjg7RUEX6PXXlD
 /jZt0QKMH9+F9sBVomSluYCE3FlfC99CfLfofPBY9PXe5gpYHdfZITjkGuVcQeX21TU4FdGJC4D
 ApTOACG3uE5SoluNN4NZM2OQgabjVDqaY0goUk6zPPl9lDnnB/M8FqwMtsSXS16FccjsRHl5Pi8
 rFmvtxm+jiiXTXj/Ios3Tr/Y3vwAWx0ccAX6tnZTjky7HOF+4xhEfmZuc9Ap/k5R4x
X-Received: by 2002:a5d:5850:0:b0:435:a258:76e with SMTP id
 ffacd0b85a97d-435ca3a93d0mr8805063f8f.60.1769449431352; 
 Mon, 26 Jan 2026 09:43:51 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-71-105.adsl.net.t-com.hr.
 [93.143.71.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71730sm34199603f8f.26.2026.01.26.09.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 09:43:51 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 27/27] system/memory: add QOM aliases for fdt support
Date: Mon, 26 Jan 2026 18:43:13 +0100
Message-ID: <20260126174313.1418150-28-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

The patch registers FDT compatibility handlers and
QOM aliases of memory subsystem, so that memory
regions can be created from a device tree model.

The alias 'qemu:system-memory' could be used to attach
subregion to root address space.

Also 'qemu-memory-region' types can be used to create
new memory regions.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 system/memory.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/system/memory.c b/system/memory.c
index 866c741973..867228922b 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -4077,3 +4077,27 @@ static void memory_register_types(void)
 }
 
 type_init(memory_register_types)
+
+static int sysmem_fdt_init(char *node_path, FDTMachineInfo *fdti,
+                           void *priv)
+{
+    fdt_init_set_opaque(fdti, node_path, OBJECT(get_system_memory()));
+    return 0;
+}
+
+fdt_register_compatibility(sysmem_fdt_init, "compatible:qemu:system-memory");
+
+static const TypeInfo fdt_qom_aliases[] = {
+    {   .name = "qemu-memory-region",       .parent = "memory-region"  },
+};
+
+static void fdt_memory_types(void)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(fdt_qom_aliases); ++i) {
+        type_register_static(&fdt_qom_aliases[i]);
+    }
+}
+
+type_init(fdt_memory_types)
-- 
2.43.0


