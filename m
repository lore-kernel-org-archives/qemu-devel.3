Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCB2F94CDC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFSZg-0005En-Ob; Wed, 22 Apr 2026 04:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFSZY-0005D8-Dy
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:04:39 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFSZX-0001Av-2x
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:04:36 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso26311205e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776845073; x=1777449873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8p/jGLIiic2gzIRXR0cmhO4Gh7Cyi9AskwrdzW7vuw=;
 b=KygchgYbZdWu5tWGmT36E8VjlxTeFGbHTtBFIWOs75uJsSkTg54BqnibhcIgjpqmIl
 pneawJkQtNeeX3dLiDdXUcJ82BNU8tNckA1PaPq0oucxPJRM8gl9N3rRM6WUIgnZ+lVW
 906oSFDSWAID0+8nvpUrKmzvQFQTf4T1F8VV8W7ryJhNFOQ8VKlr6Ggq9685YzRMxvYI
 2hfbE0jT4ye8AgrIXRgmUtPEmaHwo+HFIz5g+lC5ZmllFCGDkGgprrsBEcWGL72XfgxG
 5KyA8pzYTbAFmgZjWBzxMeRor6PxwFKnqKorXgmB/ymZC/sP4t/XiPAhPUns1mqaGpBj
 6I1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776845073; x=1777449873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C8p/jGLIiic2gzIRXR0cmhO4Gh7Cyi9AskwrdzW7vuw=;
 b=M+HwObcCfWxxM7WgXCBZ7C7wGN89gQfTM+FNssEZLntqIWGQaHOL4+oiIBLLaaEb18
 gPtO39bck3JLzj+Q63u1UOc4YovS7AtTM/eIU92D+lJxAb8Z1JidiGScy5cO2BOBrDSQ
 0/YFgHOXY8phzIfIHhKAw7wdonI7QCgoNz+F8OAMzbodGSbjyaFSR/p9SCaLmyWpZzUV
 1+pOpr2O2eJrqS5oE41o1EX95jp5bo0Yups+THzxFHYGfKn5rDOqBcGwhX/0H7RaaQf3
 PBCAcA590CH8Vh8WJ0FuL0ZoJWLLauMGm6OmfUZJlcIPZEb8rkAvxzxQDToqW7S7N6j8
 iYCQ==
X-Gm-Message-State: AOJu0Ywne3o4SGaDTGwdRoRrx9att64jN20Yc5Rp09It05fpuXu09IUI
 H1XsL8wTzj6ZY4APa+VgvqxkljbUbp0rCe9vbKUJIxfyLJDT1tI3l7KLLJscsv23PEFYtkZSaH5
 vz4xBGr4=
X-Gm-Gg: AeBDieunWiUfO2cwYg7xGlXFc27xrRZrfSdwLEF4LKcElhmY73gc5AQaAJF4kxyOaZ8
 elsJ6PYhK1KS47t7BdBEv3Y9M3cvm2z29CuxU9MZ6GIHOTSYY9KibXlMk4jHDBizEwFk0THMhnl
 9M1bV6JXlpWturQZ3TxDUEuBno5jcM2CPY5U8y5rgOe2C6zb4Cpc+uip/1513YD7ASfZMDxADrt
 Ju2pb60cGFqgcW9aIrC+HhCNNZqgd5FazUy5mpTS27kdZID4upQT1MT/LQqREwjEuHC5nuRHhV5
 QdqgqjK+79uWM+Mwpt53BhTkKpbgatkVz/d7E+krF18SpR6uw9YW7b+GZXRvvVf1GOzGNHSn0Zp
 MI+fZKix62zKrgSsNTc5i5LIGkGvKpEpa/8F6YSKlMXarqyRjup09gzzOzYMRGhnu/ZXJOjgcT8
 JSmNTVeavG7ETelk9pixxQdXd7UewDtGfg0krsdiKDvJ+sikRUf/RNYjsvYWejLWUdSv2aWgVRV
 IL83f3icYmvOSWDQJ4Elw==
X-Received: by 2002:a05:600c:3b11:b0:48a:525b:e148 with SMTP id
 5b1f17b1804b1-48a525be2f8mr120235995e9.4.1776845072637; 
 Wed, 22 Apr 2026 01:04:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1393f5sm402714605e9.9.2026.04.22.01.04.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 01:04:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 03/10] MAINTAINERS: Maintain MIPS Boston
Date: Wed, 22 Apr 2026 10:03:58 +0200
Message-ID: <20260422080406.62638-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422080406.62638-1-philmd@linaro.org>
References: <20260422080406.62638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Maintain the Boston board as just another MIPS board.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ecd236f818d..520b92826a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1495,6 +1495,7 @@ F: include/hw/intc/loongson_liointc.h
 F: tests/functional/mips64el/test_loongson3v.py
 
 Boston
+M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Aleksandar Rikalo <arikalo@gmail.com>
 S: Odd Fixes
 F: hw/core/loader-fit.c
-- 
2.53.0


