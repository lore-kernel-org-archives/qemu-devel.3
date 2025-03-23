Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FE6C36002
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 22:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twU9u-00040G-0Q; Sun, 23 Mar 2025 18:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twU9r-0003xh-P0
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:51:07 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twU9q-0007Ex-33
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:51:07 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso25575705e9.1
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 15:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742770264; x=1743375064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0rA7H09Gy6oI0z35COjFJAyjrWGBYRErfci6Tvqs+Ck=;
 b=cTO5/bFbC/UDwtfE3Xp+Er2lvoGD7pLG2hTwe3TQB/XADZtfvaFMA2q05sRxiI8gTU
 i9OYsFQC9yg1d3Af6+hwHpKH6AM1T0bVqqIWKV1hSaY9YTUJNaw4gX0zVuFEcZgQu7b6
 uyaxFANmHgmnMvQyXqxH4sl4VWi7RUaiRv2ClET8NvH25d2DuZo5yM+o3CO2IIU7+l2B
 1N/Djl3aGN6dqOso7GrVJ/6GeWxgz4S2zLJnY4ikUBiHO7EhBu9kjEXjPovJs8VFzvXn
 GqLn61tlzIcZ7VnV9O61+6vHtZRFH+iSlTv+AgLJaVbe9xAgS/hET3l63eGsVg6NA8kj
 uDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742770264; x=1743375064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0rA7H09Gy6oI0z35COjFJAyjrWGBYRErfci6Tvqs+Ck=;
 b=WOqpKKSq21z9Djk/QbrWAtjcuK/4rZaXWD+Q6idTbswJ8LQsHg927pvFqtK8QKRuih
 ZGf8p6MaEnXvdAO9saUkDespuaVnPZWQbK+R8XehBgoEdnQFPlRYf6KObu3zoP5btkDK
 3EYshO4uVfvz9kpBF+6sqQgs3p24wAUF6k3wwUJUv2zpFZPasmBdxpJktPKJo63hIqiZ
 mL3O5dk2WFOAAtrbWzpiDOQL6R6X6tVVSO1RD84FLBDZe9/app7U1tH+rqgGUReDDmAn
 z6JrVCU2qpNWRzpRljA6nSmnAbCXiLSFRapEsIT1lqgT/dNHaAobhIjsukVHymdBt/Hc
 uxfA==
X-Gm-Message-State: AOJu0Yy6wfft5ycrCFtyB/tB23N7mAeF7ZtTBnKxZnPc7ieqDlVZkfcy
 ICj7FfHN+ixOpsJWZHG1cGeQGeChO75I+dUUBBjaWbdmsbbMcu0fifr4/YwZs/CUEOsxmhnOqCe
 J
X-Gm-Gg: ASbGncsr3sYQVDa4prbWX89oJ9uoueynhiS5cdgBUZEgzUM0iVUCuXCbIVFjlTwMkaO
 ZJcLHVkgctrNa4AsF2P12ThKtiTCcBGOq/O49jNw/jBSQOTo4Jdwv8zuDg9MxDdwfObGsdX23os
 417gCqy/f/a4BeVOYRvXwhKKs+HRcNzJztpn1uliumAD47XkbFGA8iqTtQI3f8qsPrYHrcNpe9H
 gIz0Dz9IKq9yIHOPAu1Vv1R/To1m93zHJdc5spJRruN3Fjvkpam9EeCCec2SwGzqG7rjSOvnrpQ
 gKS+7/bvtn5oBb440gY0C5HtGwNYi1O05OeZsyt3zE9IgaddYehFI2EUqL+aifdzNprc+d3qlbS
 vLlkTGKxW74HPj8+vKgshGkiG
X-Google-Smtp-Source: AGHT+IF5zB9Za1bCI/vDd0G023VeHdqCn23vHLmQ8gXN+/60xDRDXcp2PBCszITc4WdVpQ6qJaQV9w==
X-Received: by 2002:a05:600c:1ca4:b0:43d:b3:fb1 with SMTP id
 5b1f17b1804b1-43d50a3c12amr67724185e9.27.1742770264130; 
 Sun, 23 Mar 2025 15:51:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f43ecbsm150658885e9.10.2025.03.23.15.51.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 23 Mar 2025 15:51:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Peter Xu <peterx@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 3/3] migration/cpu: Remove qemu_{get,
 put}_[s]betl[s] macros
Date: Sun, 23 Mar 2025 23:50:47 +0100
Message-ID: <20250323225047.35419-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250323225047.35419-1-philmd@linaro.org>
References: <20250323225047.35419-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

The following macros:

 - qemu_put_betl()
 - qemu_get_betl()
 - qemu_put_betls()
 - qemu_get_betls()
 - qemu_put_sbetl()
 - qemu_get_sbetl()
 - qemu_put_sbetls()
 - qemu_get_sbetls()

are not used in the whole code base, remove them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/migration/cpu.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/include/migration/cpu.h b/include/migration/cpu.h
index 65abe3c8cc0..5066939d4c9 100644
--- a/include/migration/cpu.h
+++ b/include/migration/cpu.h
@@ -8,15 +8,6 @@
 #include "migration/vmstate.h"
 
 #if TARGET_LONG_BITS == 64
-#define qemu_put_betl qemu_put_be64
-#define qemu_get_betl qemu_get_be64
-#define qemu_put_betls qemu_put_be64s
-#define qemu_get_betls qemu_get_be64s
-#define qemu_put_sbetl qemu_put_sbe64
-#define qemu_get_sbetl qemu_get_sbe64
-#define qemu_put_sbetls qemu_put_sbe64s
-#define qemu_get_sbetls qemu_get_sbe64s
-
 #define VMSTATE_UINTTL_V(_f, _s, _v)                                  \
     VMSTATE_UINT64_V(_f, _s, _v)
 #define VMSTATE_UINTTL_EQUAL_V(_f, _s, _v)                            \
@@ -29,15 +20,6 @@
     VMSTATE_UINT64_TEST(_f, _s, _t)
 #define vmstate_info_uinttl vmstate_info_uint64
 #else
-#define qemu_put_betl qemu_put_be32
-#define qemu_get_betl qemu_get_be32
-#define qemu_put_betls qemu_put_be32s
-#define qemu_get_betls qemu_get_be32s
-#define qemu_put_sbetl qemu_put_sbe32
-#define qemu_get_sbetl qemu_get_sbe32
-#define qemu_put_sbetls qemu_put_sbe32s
-#define qemu_get_sbetls qemu_get_sbe32s
-
 #define VMSTATE_UINTTL_V(_f, _s, _v)                                  \
     VMSTATE_UINT32_V(_f, _s, _v)
 #define VMSTATE_UINTTL_EQUAL_V(_f, _s, _v)                            \
-- 
2.47.1


