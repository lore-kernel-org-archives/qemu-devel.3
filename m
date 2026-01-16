Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07339D47CD6
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghtR-0005un-Vo; Fri, 16 Jan 2026 06:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghtP-0005k5-VS
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:21:28 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghtO-0007N7-94
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:21:27 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-480142406b3so8870255e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562484; x=1769167284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AJ2C+J8W/PdiTCId1bKgsQdGDEMoeG3PAJYMq0CzxlY=;
 b=SBTe1RPYssJanDDyMgFnwKabv/SclOjIh6968RSajgRnGb+0xause2ulDkUEt+qUoa
 0ED3yYxYanLrtcbHwUv6tX5s//Q9rr/RksEV9R4+JOxJqJp1wLvhXOdCr3cblsufXnJ0
 OWchZ6ezBh0OJNkLQA2L2pwxVDWQUq/BrmyjV6FKXGNx5kdaHvMuCfWacqTRw4D+uDzX
 BYmab5KY/kLavA4XEsfwQ9tqfeGKMvacXRIFOeN92oy3fAhc36NaSIu6R8yZkemMuli5
 Hm0535pHjMLH9b//b2Z34qkQVSka4paKMYC0UunuRjEKJQ5SYQ72pgUTA5YPIFLwuyU1
 mbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562484; x=1769167284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AJ2C+J8W/PdiTCId1bKgsQdGDEMoeG3PAJYMq0CzxlY=;
 b=VK7xSPLncecDh16IQsZkEWAkPw+0jwsdJCvGz7hyFtyJAepqF0w1srilz4iRAzb0zG
 x67YJoYc10oe6zsU6qWQ+SpMweculwE+HvkiKMXPo/uLC6TCT13ioCGJbm10uyf/7YuH
 4J2LAl9M/QqL4CzqUkviHIgeNuQRIMTAgiTE07GHJDV2x9GbsJ/U/qOBrIzYp8DhT1MH
 w47ihunuxxmsssA5zKhuL+8hxGLqCPMiTRBX+32vJpS1ZMUCuvE36lLbf4Lc1cM3EAj6
 yij9SI48tEh01rfw4ODlnyvelG+XOEPUXSqrL1ybw7grytmHtgxG696xckV/vBnwm3Eo
 liZA==
X-Gm-Message-State: AOJu0YxXcnnRlwrzsrX7JvME7JzgNj8hsoUxh24eX7YdgTsPRPejh32N
 vQS56TDBH2K5MGRkexh7L99fTej7LEMLsf0qE0EqhmI1Bv6QVRv+mvY/FaW1xsvHvlumc0TwIpo
 oGwOnAAM=
X-Gm-Gg: AY/fxX68voSg+GxDFD1GEqwOletFpe8LSl+wbrBO7eMEKob73rFshOV9VutDWjN7l+P
 j821kUameCbLL8HWnaz0G/jcLD04OHnSuhcPMU68qNriBVTxRB6Lg7/36I+jeGbbeAmYcw6Ooke
 jlykFFLQ4r5tWw/NcYI///nSxnzIbXf0L4j5EXODKMd2hrmqcx5D+3in/ZI80VjVMqNJEXGzIVY
 MzdCksS7ITzPmoHJw1wkKKM/dH/a6Z80DOGBuAHZVw4Hogljr///Ta6dmfabgjPj8YHkCAFX7Cb
 SlfjvTf7a9PxlX/ZGMKioQ/fkJoHAy4YQh85O7mYhPOogJ3rqzez+b43vRSB1U5WCeEikjra5BZ
 JTOlhE4iJIbD/izPFMCJfQnO85NuX3RUW4tCWqAIw4jN3053FbyQatuPyHpHR7C34KiIUNykTCh
 RKz7wZsTTJTYAzc/HzZvXfVOC8teFN8e0yE0NsxjPBY/1Awyu6Mn/zBUu7bm9S
X-Received: by 2002:a05:600c:1986:b0:475:da1a:53f9 with SMTP id
 5b1f17b1804b1-4801e30ba86mr32955375e9.14.1768562484476; 
 Fri, 16 Jan 2026 03:21:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569926648sm4781082f8f.10.2026.01.16.03.21.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:21:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/30] target/i386/nvmm: Include missing ramlist.h header
Date: Fri, 16 Jan 2026 12:18:06 +0100
Message-ID: <20260116111807.36053-30-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Thomas Huth <thuth@redhat.com>

Compiling on NetBSD currently fails with:

 ../src/target/i386/nvmm/nvmm-all.c:1136:22: error: unknown type name 'RAMBlockNotifier'
  1136 | nvmm_ram_block_added(RAMBlockNotifier *n, void *host, size_t size,
       |                      ^~~~~~~~~~~~~~~~
 ../src/target/i386/nvmm/nvmm-all.c:1152:15: error: variable 'nvmm_ram_notifier' has initializer but incomplete type
  1152 | static struct RAMBlockNotifier nvmm_ram_notifier = {
       |               ^~~~~~~~~~~~~~~~
 ../src/target/i386/nvmm/nvmm-all.c:1153:6: error: 'struct RAMBlockNotifier' has no member named 'ram_block_added'
  1153 |     .ram_block_added = nvmm_ram_block_added
       |      ^~~~~~~~~~~~~~~
 ../src/target/i386/nvmm/nvmm-all.c:1153:24: error: 'nvmm_ram_block_added' undeclared here (not in a function)
  1153 |     .ram_block_added = nvmm_ram_block_added
       |                        ^~~~~~~~~~~~~~~~~~~~

Include the right header to get this fixed.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20260114083812.18496-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/nvmm/nvmm-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index f808828d492..8a1af35ed32 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -16,6 +16,7 @@
 #include "system/nvmm.h"
 #include "system/cpus.h"
 #include "system/memory.h"
+#include "system/ramlist.h"
 #include "system/runstate.h"
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
-- 
2.52.0


