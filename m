Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EDEF45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 20:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBI7q-0002LA-NU; Fri, 10 Apr 2026 16:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBI7e-0002KX-Lq
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 16:06:34 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBI7c-0008Fu-Tv
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 16:06:34 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4887fd35e60so16825045e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 13:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775851590; x=1776456390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WBd1HkqPS1VYObp+P8AXvdu8NKJFWohNfYGWPAO6a0E=;
 b=MAphRg3ZRmGfP0jhOrJ07fMdUmZb6GAgGAcBQ6sZM1mlCCa5LOyoYvZSq0aBH27Bsz
 6j3Abv+1dvIx579AGllwMPzaP9pWpmaH450VuowezDQwyJKagsvyh7DOTgTKD9z75iIR
 4Oit6VlClCfdt5BQf35zSn9pgQNh9mo0bpqTRbEajX30sFqkoYYvk2dA6Ui0wwJV8+qN
 sAN6vUWoiT1yIw1a32R7cFNA0kLQLcSxqn+DfC0GFx1Xi4axU0A/FOd01yE17Qg3boGW
 kD4XDc4BIv6npjDqxDCflvCoN4RdE5eJS+GmVf3VMKTUt5fGK2O7dW4j61CQ0MSFlueb
 FARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775851590; x=1776456390;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WBd1HkqPS1VYObp+P8AXvdu8NKJFWohNfYGWPAO6a0E=;
 b=meLrwdPZ+2WRmbmTM5srrb74fVpmBphPafyxipvTVx4NPdYu/sL5IO/adij2keXDQc
 PHCf1wK/iwS4uFpUBuahgNFQiYt59BopJHTC8cBxHfjAPWwQySqu6+6MlQ66dUzpMwV0
 xobOnWzDzQjlLtkY4f3E/LLpjuyKZrOxO6nQ3lb/sU/uuooqE/eiuQZXJW538u9mejZV
 XHnfI3lyOZritQ7ct4qLjgWRnXrl0IrIKuoVzveyToeLEm1ktKw7PPgIcVdK8D+1TLBX
 W0PMeXxX8gDFPftHRifXKtYXnkXaFi2bhj9qX00/MQukWAD+S68hjpHScVVU2h15VJxO
 LUGQ==
X-Gm-Message-State: AOJu0Yw/iQaBhOoh3vJDjqt1Z6i9EdTS45tvaYIMCCVt4pIimcdZZDOx
 IqNhbGZYESvkc87v5DptYxVoRAgIjQvaHVfaOqPfB2xabm+nuyoAPi4bRiHrxyh5m8vEgdOiDCY
 2cyvvAT0=
X-Gm-Gg: AeBDieuCO5xRiZTq40T6d7osAa6+s6MQ/G4bVYXnlvCjVwQOChX9RTLp6Gxjb7fMB2M
 Ya2vYKglKeNzU4+ngYeJqT8S89+WXKeq2gijZ/LMRwZnzoe6BAFBMX3ZfjRlQWPi4tLvVNtXlqr
 HQ1nLsgBuKxAEAZ09JeTy4fjJJGGBrwfWe1s5XArSyDPt6w2lMxSNX1Z+62B5qZFRsethzDFai2
 yJPDyGe5HpoowIduPrNWjxDwxTMhe+c86hg/wnKbB3VN7agsbmP/iam/36RHduz7bHGhxt105fm
 3ycn/EpcZc1LtjFl6xOtidMRqcy15qvruFiblK5TwPFI0dmoyw8AODiMhg0Cis6sbpEK3aQYJhB
 xh3KNTU82gGMAx56mmzN57qQkY90qdvNW3RJ0u9EN+fQyqFgHwMpHHqMo/Envxeg/5uhtn2l6Sd
 oqE6EeI4qhK6uwuWCWfW3NWmAOu7RDRnMHkg8fN7OA0rQSDVz1zghBulK0mmyGatjG8IwcXdyJ
X-Received: by 2002:a05:600c:3546:b0:488:c085:22ad with SMTP id
 5b1f17b1804b1-488d68867ddmr60457095e9.29.1775851590444; 
 Fri, 10 Apr 2026 13:06:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d58a8445sm91579635e9.6.2026.04.10.13.06.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 13:06:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/9] target/arm: Remove MO_TE to compile MVE/M helpers once
Date: Fri, 10 Apr 2026 22:06:19 +0200
Message-ID: <20260410200628.19378-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Replace build-time MO_TE definition by runtime mo_endian()
helper, allowing to compile m_helper.c and mve_helper.c once.

Philippe Mathieu-Daudé (9):
  target/arm: Replace MO_TE -> MO_LE for Aarch64
  target/arm: Explode MO_TExx -> MO_TE | MO_xx
  target/arm: Conceal MO_TE within mve_advance_vpt()
  target/arm: Conceal MO_TE within MVE DO_VSTR() macro
  target/arm: Introduce mo_endian() helper
  target/arm: Replace MO_TE -> mo_endian() for MVE helpers
  target/arm: Compile mve_helper.c once
  target/arm: Replace MO_TE -> mo_endian() for Cortex-M helpers
  target/arm: Compile m_helper.c once

 target/arm/internals.h      |   3 ++
 target/arm/helper.c         |   8 +++
 target/arm/tcg/helper-a64.c |   2 +-
 target/arm/tcg/m_helper.c   |   8 +--
 target/arm/tcg/mve_helper.c | 102 +++++++++++++++++++++---------------
 target/arm/tcg/meson.build  |   6 ++-
 6 files changed, 80 insertions(+), 49 deletions(-)

-- 
2.53.0


