Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D592FED3F2
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGMAT-0003O4-Sd; Fri, 24 Apr 2026 15:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGMAS-0003Mm-CT
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:26:24 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGMAQ-0001Uo-Qq
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:26:24 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso88216665e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777058781; x=1777663581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NXEtzcJHcnYiwNjj08kJVe9P/FzB1KZfM190AJWSxk8=;
 b=He0xgw+tEOis9bPK7ltns91vgQBv0fy3yhRyd6B6jm5j1QRP6JTu9YnL3qCnti8pF2
 uMwt0jIzM35YpACMNMGOdnjayo77wEsc/y8t2RVscgjF4ZlOG8BDDq9tPe2NXExxF0R8
 p7UMwTYfsoxwcUmTRkspuZ3IGZotus5HT8cRu2D/D3a35wO6hKmm9lOWnP4VRRnHph2k
 pFTIKLdYYWmYXP6yMAXsRuATO/VrC/1otnAYoBtFLPqVLo/36/yMG0dg2vk4CM9VmTOH
 6ap5wy4zcoEBAPWCpkiZt9dz8leWrDdK/0aA1KThHDqkxIPBXGz6d9O8IUYKCQt38N6n
 mH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777058781; x=1777663581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NXEtzcJHcnYiwNjj08kJVe9P/FzB1KZfM190AJWSxk8=;
 b=GskoKEyKHDDl6Yt2Da6EQkthpZdGxgEkoCxfAx0ZJOI9S08asf3HKv8DQx3QNHEt+b
 LypjwEIu02b0dMGkacxTPEy8iT/Cy8wEdrnEkkZ8QRdFqaKGKNLTLX2p65r0p0Wb3mgL
 qF9gDx8VHURiU66pJd3+7GqOR2/acez73C0/QPbuE/807VeQJHJpLo3T0nc+ylCx0KdL
 nrG95BHZ+DJpEWqfmNrVN4Ub/bJw0Ti/O0le3i7RAHKAvSJLUa1EehgJotbn8AA9AYv7
 EVF0o/mDSg15+3KZoskxKWQ/SOAirKwLx+P3zZagHrMpTmKl3vwxIMZCOV+7jhsjHvUl
 r4lw==
X-Gm-Message-State: AOJu0Yybt/hMrGLlzmBTw/qgE7h2fyzH11UKHqb399b4zp+ykqMAgZnv
 vUfq1J0WG+vLePXTviidrpa5bE4qhHBYdFk1Zr0ZI3JZqDCFfo5hoyntVaPC0709mQrTaoZzTRy
 cvfjhyjo=
X-Gm-Gg: AeBDieteD6n/Fu0w3BXIvWJJAk8EdbFCuWIgMMmUrUKW8y90Qad2Ve20TwOqq/KZqKE
 9v4ALPn68z32RnsqmGqSGmOnZMcbfJOvbmJwRLCSz2ck8xQTgTkk1D0FrGkLB9gwu0DuqsB7yPe
 IvA+EfLA2xWl265s2vt7nemPQKqhLTLTfnwZWvFyFRD9FkDEQN6PL9un3n4ugJq9mUIp2G9L/9g
 q0s19xu0EQVGEl0RJhAoOLLNAQ59zcbFpWhmIWOXkIw1LHZptAOk1QsLERpSrOsbO2MilsXmdzH
 v1jMY6PoFBOwGc+0vcTQEji23MSmpXy9gsLAkrKPUIC1jk8XzAYqOwNxeQVQ/g+JsMnjDmT9sQ9
 DWVQHqz8RCICyj2R+PhScqEzh76I/oNT04cq2dW789+JWsINnGOg1gKyGUsFhcuoR+vZ2iZocVp
 bVerTfO/DVr79dWHBPlstFAN6WLAIjIzHrvL9TSQnsKlhTedINCSRdLaV3s1F6+gqqCZPId5Jeu
 c/G3Z+Hzi4=
X-Received: by 2002:a05:600d:14:b0:488:bc6a:5285 with SMTP id
 5b1f17b1804b1-488fb7957efmr357857015e9.30.1777058779988; 
 Fri, 24 Apr 2026 12:26:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc18bccfsm552045225e9.8.2026.04.24.12.26.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Apr 2026 12:26:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v4 49/62] hw/arm/virt: Do not select Kconfig symbol PCI_EXPRESS
Date: Fri, 24 Apr 2026 21:25:37 +0200
Message-ID: <20260424192543.22614-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424192543.22614-1-philmd@linaro.org>
References: <20260424192543.22614-1-philmd@linaro.org>
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

The PCIe bus is not provided by the Virt machine but by
its GPEX host bridge (selected via PCI_EXPRESS_GENERIC_BRIDGE).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260423170229.64655-4-philmd@linaro.org>
---
 hw/arm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4e50fb1111f..41d5e968c86 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -15,7 +15,6 @@ config ARM_VIRT
     select GPIO_KEY
     select DEVICE_TREE
     select FW_CFG_DMA
-    select PCI_EXPRESS
     select PCI_EXPRESS_GENERIC_BRIDGE
     select PFLASH_CFI01
     select PL011 # UART
-- 
2.53.0


