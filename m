Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07867CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 19:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCNIq-0000Y0-PJ; Fri, 24 Oct 2025 15:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNIp-0000X4-Ch
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:18:19 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNIl-0007di-Af
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:18:18 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so22728795e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 12:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761333493; x=1761938293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eonV+WiOoy0c5cnLGQ4V0dLnLYS1ykl3W8IL9D5DMDM=;
 b=Eg9Z6RCR381lYH3RFRzh0nsM4uEFQOHLd7QahSXGrQgtWLNPICygbry9BBjLEVyXrg
 9lXYdLS71xfMIF2FHB8jguu/LXmb+wj6ddebpKMLf/1VQBqY0cn9+IExc0JbIkTu6Ez5
 XrVdBp+XWip0TsjBc8fVS4H50BHDXdmvqlAXgtvvqknlRXNSxl5jb4kF5qd/m6ua0Jck
 orAtIigkC/TKRCtwORJrYlX3SyqWC4q7emofxghFboAI7+TWa8ji/6sRE3Nc6rkKLfm5
 qdmBT+wDYGJ86NM/U/rQD72OlNKOBBuvQfELjhWgtQ3TxZzntuG7sNmFTdDJi+8sEfKE
 RVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761333493; x=1761938293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eonV+WiOoy0c5cnLGQ4V0dLnLYS1ykl3W8IL9D5DMDM=;
 b=teVaP/RgEfO+DT1H24EJbOi6UCmvPyUVYdqKZN+m/t/x6m/PI+HVHfl++hdzRHsPCh
 E/YJIumMZRnCpgbSptfqf/edy2hN2XGlQ0ORxfD8cAr+scGSjx8OHyALWXkjpwf+PyJY
 GXr9VUCqzrusJfcyK4Mq8DHxA12NflPkfAUlfc+tdkkmTAMOYK3zdtmfVMhf6v9hu2d8
 CpAlpiyN7B3ObPiPBYsulS3X1REm5rSVYz5Y/3WM8e2jyWuL0CMq8oL39sRM6dm66cA9
 VMCuYb3whLBLW7jxvmke0S3ql5DuioXnSs1PcvxPJgTuYWh8AvA5PghWa9onJ202g02b
 HZUg==
X-Gm-Message-State: AOJu0YxvB/H4oWUZF29I59O8gzfY1i8IS3Xi6/O4d4DU9R2AQdWdhEI9
 md5m/QjpiPqGc9P3APtW5Ybc8XfgZXa8xZhUbx0Ej2CTWwYdLFfpY/mLj6yYNrSqE8LbfW4Vl+A
 vDJWWhV4=
X-Gm-Gg: ASbGnctH8mTV5uo0Bsm9kQrtIken8ZUc5CJaCSyLtsNlldcCLDnwSiFWsy9m5JEcUAn
 5TDMfYxJksYUEgrdsPFRkB/PwMOABrp4Aa2F8LdX/8DuXS/43U68fw9xIcnUjC+JmcAgSYSetBV
 dI01+FaLZWjTwE3e44ZnjXb4+HcE+tDuI19NGlgtfqjB2LHgEc8xWobf0H+hlAdUY6mIhAwKLFx
 hcfqD70sKVqqHsWwEzBfp7/cVM++3/PLKztM57OVmJM28ou+ALIC5qsb5yhhQ0VAcboImg7u4/a
 JuLeYOKpWKsF6Y7roFpsyOehMVoRRz5z46VhK0lY1L4C3QHBT/eb1UZE2w5vvvdRid64XohYNk3
 lA31MLuBx0XftTClbEuWLXNr2HPf3lTZ9R8oOjhclAvmie1O3nj7SBfMaaJuE04pXIhjwj8m7Dr
 EZOTfASoWxRsu/GiCpGzxn5WQj15rjpqvr4hCe/I1tsnUI4cPIpO6FQMCXHJ7X
X-Google-Smtp-Source: AGHT+IEcud/+cjk21SwGuCTletB6kgJFqvWqEu87ta5TJtJi9ymW2LHDBPjBLFEosDp0V0KQ8BtM8A==
X-Received: by 2002:a05:600c:8581:b0:46e:19f8:88d3 with SMTP id
 5b1f17b1804b1-471179123c6mr170701865e9.22.1761333493552; 
 Fri, 24 Oct 2025 12:18:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429897e763csm10698654f8f.6.2025.10.24.12.18.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Oct 2025 12:18:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/27] hw/platform-bus: Include missing 'system/memory.h'
 header
Date: Fri, 24 Oct 2025 21:03:56 +0200
Message-ID: <20251024190416.8803-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024190416.8803-1-philmd@linaro.org>
References: <20251024190416.8803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

"system/memory.h" header is indirectly pulled by "hw/sysbus.h".
Include it explicitly to avoid when refactoring the latter:

  In file included from ../../hw/core/platform-bus.c:23:
  include/hw/platform-bus.h:38:18: error: field has incomplete type 'MemoryRegion' (aka 'struct MemoryRegion')
     38 |     MemoryRegion mmio;
        |                  ^
  include/qemu/typedefs.h:68:16: note: forward declaration of 'struct MemoryRegion'
     68 | typedef struct MemoryRegion MemoryRegion;
        |                ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/platform-bus.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/platform-bus.h b/include/hw/platform-bus.h
index 44f30c5353f..8672ccc45ec 100644
--- a/include/hw/platform-bus.h
+++ b/include/hw/platform-bus.h
@@ -24,6 +24,7 @@
 
 #include "hw/sysbus.h"
 #include "qom/object.h"
+#include "system/memory.h"
 
 
 #define TYPE_PLATFORM_BUS_DEVICE "platform-bus-device"
-- 
2.51.0


