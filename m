Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B367CC3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 21:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUCWY-00080k-Jr; Wed, 17 Jul 2024 17:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCWV-0007ei-EO
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:49:20 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCWT-0002S8-RR
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:49:19 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4257d5fc9b7so1149565e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 14:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721252956; x=1721857756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b63oTaOp3REQziAQ8nukVjNE16sAzixcuu6r9oQJNfs=;
 b=AOdEzIOv8HPnvdhOSYbHy6uHv1fmszwlnH8PPNwqHhl3OgdWsjScz9nNAhKwUXzo1Q
 RlGqhp6PEenNWF8+96e0gY/3p7VhidA6Y7wth+gTEib3t02+9+ulzy1ca2w1NMX3vmAn
 KR07a9cLtuDePLga8AE43DUWMVe+m1UNYTIYl8JCA3F5Zi4s0zWFa0fR6SbAZLvujwz2
 DUVu5ABlEBbPj3HahZjrMQxI2skSX9MJkOO0Bj8lDpEHHhtEVZM9IjUpXNsrTu+J6P62
 VpVE/uq/eo04djfL4fRag+v2hjo/wobWlTvvjnE+EwkPGhrdRaRd7kEVJfMz/TEfQQo1
 CBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721252956; x=1721857756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b63oTaOp3REQziAQ8nukVjNE16sAzixcuu6r9oQJNfs=;
 b=pZ1H2XEiSN6eh2cOlzpiGmrDoXuVTD0GDutLdxHGUz7fiBVueMdZTi5TkPLzBarMTC
 nFHkuwecgGIfiXAcOIpTeIh9xtko6anV7rXeS89wRbpGAE1jETP07pPwS7SMRtPtxMEc
 zbeffoTvh+F4EjrFSnMgkc+py2b4ZA26d/n3Eigp3b3zMzeqY48XdqhMZj+uJ9TJOody
 0BkeqYDk9J8oiYnVmC1Sl43d8mo07W9H7DB6tskSzTYCzDf21efkQx8zvsbpuFjQH7l3
 ycZjJ6XE2G69tBsJ4aZ7n3orCwUzmjYmdiqyIydiSNjxgDwMeLJU1LaUWM/dwc8JrUD8
 POgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2Hc42WmsmY4PI1Cgxn7eVtqoQVLQMgorOpthuhrFziuVPpFZVmlgi0QUHmXzMAuCnXGwbTI+/Q2a/WcDiORxwPuukaks=
X-Gm-Message-State: AOJu0YylyxqP0zKRaNHs8EfxjZaR3/TAhtsuIXffB7KyfyDC8tQEDVvv
 6XWIGnKObXwI8wNR3Zrp+45wJwv/tufUQ5F9AIHV2JkppupxhODadH91VCpDQ4c=
X-Google-Smtp-Source: AGHT+IFW34rtx4rjqsSq3YSmP0Jo41E0XLqdF6pzf2WopqDI08NHn6On57tYgSbBs8LFGhZC5RzJjQ==
X-Received: by 2002:a05:600c:3411:b0:427:9dae:2768 with SMTP id
 5b1f17b1804b1-427c2d119d7mr25250505e9.38.1721252956487; 
 Wed, 17 Jul 2024 14:49:16 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427c779847asm11834755e9.8.2024.07.17.14.49.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jul 2024 14:49:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH v3 17/17] hw/intc/loongson_ipi: Remove unused headers
Date: Wed, 17 Jul 2024 23:47:08 +0200
Message-ID: <20240717214708.78403-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240717214708.78403-1-philmd@linaro.org>
References: <20240717214708.78403-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/loongson_ipi.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 61375d89ff..6dd08aa9cb 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -6,18 +6,9 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/boards.h"
-#include "hw/sysbus.h"
 #include "hw/intc/loongson_ipi.h"
-#include "hw/irq.h"
-#include "hw/qdev-properties.h"
 #include "qapi/error.h"
-#include "qemu/log.h"
-#include "exec/address-spaces.h"
-#include "exec/memory.h"
-#include "migration/vmstate.h"
 #include "target/mips/cpu.h"
-#include "trace.h"
 
 static AddressSpace *get_iocsr_as(CPUState *cpu)
 {
-- 
2.41.0


