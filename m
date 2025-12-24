Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A29E776C1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRJ2-0006dV-GS; Wed, 24 Dec 2025 11:01:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRI7-0006Sd-Gp
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:00:53 -0500
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRI5-0005sb-MY
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:00:47 -0500
Received: by mail-ed1-x542.google.com with SMTP id
 4fb4d7f45d1cf-64d4d8b3ad7so4739220a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592043; x=1767196843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qrjTj8vMTBtS4de8NLbc8KbwO0kKj7h68/uZ+N7caWw=;
 b=bilZNIkYMXEgwO7yXkjlbtDXKe6ZMTp9TQ+XZFEPkW9yvSajz7UX5g/uJkptQ7dwCp
 XO7lzEudCVbnFmX87hgBKfyZ7VBBreXH6iwXN3/qND3qPUAGzan3e+lkhi7uuVY2ypiN
 51bA+FSeEBlToUr6kYtIFT9R8d7z/y1kMpRdYNJtuZX29I+wezhn5kjw/JeVU1otRXeh
 4wArv9NbV1GG40F8igG2+DkhgJnYUL04XKTvlBwn2GMC033Aair3piigKy2PnbHtNeJ1
 nGaaDQdx+WxjBxm8VLMReS73SVK045vx7gmVaq8pWSGJkvKUSr6IDAEGlaDOuvexyDrp
 Prgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592043; x=1767196843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qrjTj8vMTBtS4de8NLbc8KbwO0kKj7h68/uZ+N7caWw=;
 b=lmefqwigNp9te2DlgxXpqB5SvgqJnz2PwD0U3d7KwSwZqkur4uyNLseeJWAwNAiioh
 c+1YCgY1FQBc0XowIuiS8+YyrzPX1y7FVnBSoDNKcpflX8ZRIrpmiar4zGnDXyPiiiLI
 OSfjG+NlP75YQttUOrAyjHTfKqvr2g4RhyxWnMs6hRcihiucWMZGwATpBZgczKCHOGUh
 0Qr2gtkTH0Se00cUnvmCfxiWN1Ca/rlMx+yUpxBI3IURroXEUlr7nR7cSSP0MiqmIP4G
 qan2X1GRjbtTwVfPrfC+fe1QqCQRWH1/NqgGq1gNg3KwYZ/MQ8jBNuQO+jjS0/3fBBNJ
 2tEQ==
X-Gm-Message-State: AOJu0YwZ7QZvbUsmvPVHlC83s1Ld9OcYHlsaomZx9/mX8P1UOtV+guTe
 tZQ9+LE60H64nutCGH2H4Ij3Ug6Ze3NE7JZ/8mPNxl1Xj5eLwC3nPAGY30I/DaTkBbS80h49UHf
 zt3d8GSQ=
X-Gm-Gg: AY/fxX54nz6O4VecbpM2OKXJI9JFJhXtOh+Tw2C4VHnNgnjqtmiWUmW92u27Ih7g/Mk
 Xl9/bOCMvhWeP8BYhTsV2QbEzN8eZS+H+jlSB9TuF7X5CyrhAxoyOKKI1BntuwgSeqFwf3qX7Zg
 0cRszzLqM1HB9Y/u+jiP/83wraqdzaYJ5g7P4l8kHGD13VCqJubCQe/+WxEFDLXWi3d/CTFX3ws
 7btHv7od5TC2HhH22lIIDl8z94Rj6X+dIx9AxY/A7X7l+KSA5Tq/WI0rQuF0OGxrE7Zau8cFCra
 lcDzeTryPGSgCfQrPlkR3kDz1GlFg8XJs9cuuRbQ6E5ckyn86fQF4TLaJjhhh2g9MMHwmnL6OQq
 j4hA80eT7J9weUfkUz1mGk6z3Vwd4rEIw61l91PBO583QFYD40yhUZmIhSu7Mz9LMvW+Gk2jQWO
 bqhjjLb5zi/tgcm/4/BgQE3NL9kMOBLjwnFXwEHwPOeMj8VYMuX65i3sM=
X-Google-Smtp-Source: AGHT+IHql1qN6Cq95umf5RUcjRgrBS9Le1QbBdEToP6NZlME5nkh1N3WiRaAhxggBgaeXc9qHloeNw==
X-Received: by 2002:a05:6402:2712:b0:64d:accf:aae2 with SMTP id
 4fb4d7f45d1cf-64daccfadebmr5698005a12.27.1766592043520; 
 Wed, 24 Dec 2025 08:00:43 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b9159a6d0sm17240979a12.28.2025.12.24.08.00.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:00:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/6] target/alpha: Use explicit little-endian LD/ST API
Date: Wed, 24 Dec 2025 17:00:33 +0100
Message-ID: <20251224160040.88612-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x542.google.com
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

Alpha is little-endian. Use the explicit 'little'
endianness instead of the 'native' one.

Replace legacy ld/st_phys() calls. Forbid further
uses of legacy APIs.

tag: https://gitlab.com/philmd/qemu/-/tags/endian_alpha-v1
CI: https://gitlab.com/philmd/qemu/-/pipelines/2231223066

Philippe Mathieu-Daudé (6):
  hw/alpha: Use explicit little-endian LD/ST API
  target/alpha: Use explicit little-endian LD/ST API
  target/alpha: Inline cpu_ldl_code() call in do_unaligned_access()
  target/alpha: Inline translator_ldl()
  configs/targets: Forbid Alpha to use legacy native endianness APIs
  target/alpha: Replace legacy ld_phys() -> address_space_ld()

 configs/targets/alpha-linux-user.mak |  2 ++
 configs/targets/alpha-softmmu.mak    |  2 ++
 hw/alpha/dp264.c                     | 11 +++++------
 hw/alpha/typhoon.c                   |  4 ++--
 target/alpha/helper.c                | 28 +++++++++++++++++-----------
 target/alpha/mem_helper.c            |  4 +++-
 target/alpha/translate.c             |  4 ++--
 7 files changed, 33 insertions(+), 22 deletions(-)

-- 
2.52.0


