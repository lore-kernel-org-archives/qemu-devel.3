Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1346D0D171
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 20:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vda6Z-0003XH-3T; Wed, 07 Jan 2026 15:26:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vda6U-0003UZ-9j
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:26:02 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vda6S-0006O3-LX
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:26:02 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4327555464cso1409816f8f.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 12:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767817559; x=1768422359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gYkOj1BTckr7p3pOcaUU3NpqaxWkJOhhW8W+fz+D8aw=;
 b=uQAhmjWSklo2j4eapodzuHito0+syIAHrj+yRJgKiPgEoR5IK9qvYOgA9jIt8Qre7G
 s/Ps2tuDXRxq+G7wVBuprZ5chFo8XKkXXEbltBMnaZqsfnyRgw8HeI582fjdpxwzNn6i
 tltZ64tRi5OO2C+JCGCy9z8ZpWhWCUXS+KrrU7sRbmJmpP6Qo7BMMs/xihF8IsignXRr
 UdA+obyx38vFx8zhVFBdE1M1Kl5oD85+lv3AgIjVEy5gEnKUD98ExbStEDrB7rhh5Ukp
 4PRVEdgkH/uHme814rYHgeDpKAFemjO1j6NVH23NDr2Etnoq/k22hOgSwWjW5jBMWgQW
 SEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767817559; x=1768422359;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gYkOj1BTckr7p3pOcaUU3NpqaxWkJOhhW8W+fz+D8aw=;
 b=oCxDyatGe8a35eevAI0LRw6VqKCG9Zpk0AynESQbCDHYxwEAzP2bd+sTdV/BRZnAy0
 uerMZ7LQVa14sovYCDmVMtykoCCucpCF7xEgHaeWu5GFGiQoydUpQUeDGGJvHO10UJzw
 rPevVL5zY2YCaoDC6MeNyD5RkdTqS10fStvccDlRz1w+uarP66V6RgIyla7vYaIoh2Ws
 aLSwpJzfbbDZ8uzDJJAIxlPMq+nP3Il5md81Q7t3/k59hdCRxeHF00tF9m0od/sFg+z0
 0Joj+qomgJnLjZ7Y6/l0Nl1K/HELty6RsxfRmz7qdJ8qQ2dif3RLiMzhHs+2aLsI4nrx
 Hq2A==
X-Gm-Message-State: AOJu0Yy1VvloK1oK+PeNQz39SVeo/BwMXXx68n90MhB3pHEOPhHQNQl4
 5EyW4NBl3huTgB1Z12UYrm8YSEZFN694xM3Ni+GpwemNDtuA9Sx/XnBK0n4k/x6EXYYEHd4C+NN
 /uH5jaM0=
X-Gm-Gg: AY/fxX4evJiJ2A5Ts0YAlpHtJV96kRrhhWy4NHo2mgkW/14LMlzunHHfF2a24iTZkaT
 IH+YOXOBYg6yb5RRVjrhLz0u1cZlZdV8OqU9/a91+XdvZN4U639iM/xrdeVYIR5QfFRGYNXw+Hc
 G+kOE9zkW1kSelFeW7pFOrOKPYej4Te6U7FLso+8A8u6VM6fveJOa1KbrWhjjCgai6J/RxP/0f1
 2olncJ0cZwOIVLsV1mIQF6Y/9r9kPIZktw7AxGSLBFe8xa+Wg2UKGyLw2PSn3G4iKpIvu3nAeiL
 X1JxHUREKyC8Sujum01D8IB3bTVccgUNtkGDYULok3cLdD4UqfDsIhN6vc2IKFKGSEhx9hyOukA
 X05jucvkhWo9iN3VlHeZQdV2MMbGwKX2CbflCjoxdTn/IK/auwwvPypOCJUCr9v81obLM/A/jw/
 rpE7ZB+FMcErTrUuYF+DhVtRAoZ57LvAAEaAPZ3oEWlGE2nDe2PPU9LyEYHdSl
X-Google-Smtp-Source: AGHT+IFhTSfz5FVlC4IYMpmKS0aVwzSQVOEAzNW0SRbZ0ZSQALxScclf7KePZQEz7gQw3xraXPu2Uw==
X-Received: by 2002:a05:6000:40dc:b0:432:5bf9:cf2e with SMTP id
 ffacd0b85a97d-432c377298amr5323914f8f.13.1767817558218; 
 Wed, 07 Jan 2026 12:25:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dacd1sm12190963f8f.4.2026.01.07.12.25.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 12:25:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/7] target/xtensa: Build system units in common source set
Date: Wed,  7 Jan 2026 21:25:49 +0100
Message-ID: <20260107202556.55787-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Build all Xtensa system units as common objects.

Based-on: <20260106235333.22752-2-philmd@linaro.org>
  "meson: Allow system binaries to not have target-specific units"

Philippe Mathieu-Daudé (7):
  target/xtensa: Convert XTENSA_DEFAULT_CPU_MODEL to runtime helper
    (MMU)
  target/xtensa: Convert XTENSA_DEFAULT_CPU_MODEL to runtime (no MMU)
  target/xtensa: Replace TARGET_BIG_ENDIAN -> target_big_endian()
  target/xtensa: Build system units in common source set
  target/xtensa: Build 'xtensa-isa.c' in common source set
  hw/xtensa: Replace TARGET_BIG_ENDIAN -> target_big_endian()
  hw/xtensa: Build hw models in common source set

 target/xtensa/cpu-qom.h     |  3 +++
 target/xtensa/cpu.h         | 12 ----------
 hw/xtensa/sim.c             | 13 +++++++---
 hw/xtensa/virt.c            | 11 +++++++--
 hw/xtensa/xtfpga.c          | 48 +++++++++++++++++++++----------------
 linux-user/xtensa/elfload.c |  4 ++--
 target/xtensa/cpu.c         | 10 ++++++++
 target/xtensa/translate.c   |  5 ++--
 hw/xtensa/meson.build       |  2 +-
 target/xtensa/meson.build   |  7 +++++-
 10 files changed, 71 insertions(+), 44 deletions(-)

-- 
2.52.0


