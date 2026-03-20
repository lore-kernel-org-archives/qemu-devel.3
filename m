Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841EA1093180
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 07:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3UYg-0003DZ-DC; Fri, 20 Mar 2026 03:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3UYW-0003BC-RP
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 03:46:06 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3UYU-00032U-Gc
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 03:46:04 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43b467dcf0bso1787172f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 00:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773992759; x=1774597559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Jbk2Hh9PYXYfx3erXOE0qSmmubn/4qTN7uD9G/IX4wY=;
 b=vHSQolh9qgREVLJMtJ9vi4TzZ3cl5SAkkN7Dg3qiMkKPwX94Or4eEcsRtj8mc3Oumg
 b4xd0Or/0ozt698TjziFPV5JcRSMybzwCXQdfMBMVp/icAsuaPawrY06De7pYoGa/bT5
 gj4vMwna67bCR3np7UK4SmSjwtvzrSzub4nNoV76vJxNU3JQsoxD8ngpuZ3cp2/odyD0
 LSzrRuB2hQ5gEbknS8UqoYOsyk171I3ZTdngaaPa+Zl3DQuGsecdOjUnaLuw764rlbMu
 zimXGWPOjaMN+HGYPEcnfCsc7/DqBRmeex8t+UN96vxpXalyqA+kX2rpTeQWZwxwO3ae
 wPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773992759; x=1774597559;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jbk2Hh9PYXYfx3erXOE0qSmmubn/4qTN7uD9G/IX4wY=;
 b=iAIKcaCD7KPM7KVXbp6qmOsO+DEbW6lI+JJlWQbVqTaSu4ryjfLrF8qGo08hPxSlKh
 zZaMSht0NYtP1qiHIfqHZhF7PhrEx2Q4NtxYzKzhGCViZqJR/qMwaaNtoNbR9v6S8xzZ
 kWMk1hk36HrVCnnQhqgAtKOQyzYEwfusEsMC//mePckC1mdXNq1Thvb2M1FbVmYa8c/r
 4nzUyefGNydeDoTLt8e5F4IyfJxs7OzWJdrn3dAULSHVN9r+UT4ROIA/s2OcGZcQbfNy
 NhkwNOHuWnHiEdNPj0bSe/6dwoYotvOoWLjol/2ebuOwN0TlnakwZGP33/vGTtwWwJ/q
 aJrw==
X-Gm-Message-State: AOJu0YzgsFZICgDpfdlfuoRsGPsMpaTUnDBGHUbUwQRJOnral2/DOa8G
 X/mi9Nq8pvPGks/d/sp8wVUsiOQLGmqFBWzyNZMeXRrr/OPl+6mey+KWcpeLSbLFDZUcQ7GJXop
 XRJVwqN8=
X-Gm-Gg: ATEYQzwOC7atZEX7MuDLR1fu2ZAPkaCjEScVORUJGAjqWzWQEv3laqnpqzl2o6smX9s
 UGV1npoe3XFJpC3Ws7+glH00rc+AXLx2dw/wZPr59m99xpzW0JMal9XnszYEcQqO/PR5iit/UXQ
 agFqiZof/idNQKXFAuQDpXu9efnhMblMAfFpj5MkDwIoWjMsNSLifcRhnxAhPRn3MISAC4Pchbv
 PnPZ5YELjGmIMlk+g9kJfYjLSkU8a8B4OPOKGkhp9SKUEEkQK15qfSwuMlTNOX0vFlp4V/sK+Hu
 VaLJ8iM3K4LX3lC/RtAzpD0vnU9lj8w+Sv9YFBiRV7K+Pf4LG/l/Ox5Eb3YmRSiZGTLZV+SBT7D
 6AL5njm/vOBFsqFmMDr3Yl/ELupQ+P+uSlOy5+fif5LtY7RsshVkuh5Az4XQHuHuL2GnQLNN+Jf
 sL6imAMQbm7qi+0MO6cRT1nisav6yHPWbHB5SqSyPIdA==
X-Received: by 2002:a05:6000:2f84:b0:43b:4703:9dcf with SMTP id
 ffacd0b85a97d-43b642724b2mr3485384f8f.15.1773992759176; 
 Fri, 20 Mar 2026 00:45:59 -0700 (PDT)
Received: from localhost.localdomain ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644bce6esm5020478f8f.9.2026.03.20.00.45.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 00:45:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] accel/tcg: Remove non-explicit endian cpu_ld*_code()
 wrappers
Date: Fri, 20 Mar 2026 08:45:53 +0100
Message-ID: <20260320074555.33974-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Inline the last non-explicit endian cpu_ld*_code() use
in the MIPS target then finally remove the legacy wrappers
(updating the documentation).

Philippe Mathieu-Daudé (2):
  target/mips: Inline cpu_ld{uw,l}_code() calls in
    set_badinstr_registers
  accel/tcg: Remove non-explicit endian cpu_ld*_code() wrappers

 docs/devel/loads-stores.rst         | 21 ++++++++----------
 include/accel/tcg/cpu-ldst.h        | 33 ++---------------------------
 target/mips/tcg/system/tlb_helper.c | 18 +++++++++++-----
 3 files changed, 24 insertions(+), 48 deletions(-)

-- 
2.53.0


