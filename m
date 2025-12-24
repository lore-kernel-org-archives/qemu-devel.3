Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1495E7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRL3-0000Nn-0h; Wed, 24 Dec 2025 11:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRKz-00005h-Bw
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:03:45 -0500
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRKv-0006oM-Vu
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:03:43 -0500
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-64b9cb94ff5so6616293a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592219; x=1767197019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yEFClUQnG51buyM+ju9uelB76RT0TfFm5HzdvjTTca0=;
 b=FpTwIC+3iY7CjuyA7w8DR2xbBxqc+0qYisHflOcdKKZcogLhjrX+f47yZLQzV22rFa
 avKRxLfYRM6DPLnO4p/PbIy9DFAG9VXyqqdlLk3B2QbRz0SGhoZ24tgNvqsTss/F2JRU
 ttWAyvn5UZkU+SBFz59wsXO6UIIBgtoWfDZWnfLVIU5yFwOlCSwz7pZhYoWLOI8CO3PG
 G/OE+/jIe5YhATciv8L2H5a7Y0zfNrcLZNunK9rEGpwptXKiBYOhhJ2/kkpZqupq1sBs
 eTE8QAX1qCUJXr4A+izqlUPpw8zi2MMUs8STZclt2VujGgutcmDBQhzA8yj2Y4nHiNuF
 8w5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592219; x=1767197019;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yEFClUQnG51buyM+ju9uelB76RT0TfFm5HzdvjTTca0=;
 b=TdZDgEVrWZlQtwZof67Qgefu9GHNutLjuR2anfrySjG5Ecv12Buiv0kT3SuqFegQCm
 luCAZzMgWOlIsRhljokGGPAUvXPtbNwoeoLYvPqfK0mfrx/K8iziuy4I++a+tNl5AD9t
 aiAQdQ4ztuFId9i6JxDBD8RvQ4MEOyNRjjeRAMszn2G6H7vUW4GVPjo0VIFa0K/HchiL
 +r/loSpHkFf4p7DYTZY2ITOnBR3oAziZeMWmZLK/o5F6o8pKd10UPRUt3WmoGnysqTJO
 UFvr6QaIt8lYTpSvUZBc+jIyvH6gD6Kw2ysDi+OHVk8Px7p8aPO7MAwHGpn6r2SqkyUd
 ggVA==
X-Gm-Message-State: AOJu0Yx2OI3f/wnOXdnA7cfC2n8MbdB/ELJQnOH6g5nu+UPlNjrp9Sot
 y+brUEJB75vOYalu2a1ngFsx04ROt1L56uI4KS6FPptIVEK89GE7nwwvRunpCCJ7hHKv/BjOGfY
 K3JjxmMM=
X-Gm-Gg: AY/fxX6lCpdkLKsobNGH4PRU6f8z9RetqmEdZU509Xy3rsG3ogNVE5QfTVxTOuef/Mx
 i4aGdwQg+YdKc40bOO61/tQqt3ipswiWvje8RchXdVjLfr0qrmTj5RSycrj5lfZ3Gd2IT0pKegM
 /O2Pulpi7EMssHm0kgpKCLEKX7KzjWtNr9iI4s0qhgWAihl3rZBarPdppJUqddRjPhEXoSl+PEB
 CLmFoLUxW6kt/gEKgV3Bh5/D/7IguD8CeYgK3Rb8SulqIsbbfzUzxrSTseZy5YNRO4JSOlxxdOq
 3wzM+vOj1GBvHHaMttPUf99As9HNB6CucSlFtAk77bOwNxqU4WQf9CyV4LxALFyzzbejvq4SwCk
 GoBtQW2xAyP35ykBqsJJD/IuRtmsbF+y+xCreLFnhOPwo5GqlEulo5Xx4/4H/CKFeZhH4O9+oyI
 kHHsbs72TqmF2b8uDnG32O7c7hzdKop194v0tuqwwYSAIdhoBx9FuWR28=
X-Google-Smtp-Source: AGHT+IHiTXXYpF0eQZ6taAGHw9YtKTW6r+jAyo3qO2EjeFtDPWxfLEW7eN/3baQHoX3ZekV1SXODwA==
X-Received: by 2002:a17:907:7f21:b0:b79:a827:4d47 with SMTP id
 a640c23a62f3a-b8036a8d6e4mr1793097466b.0.1766592219233; 
 Wed, 24 Dec 2025 08:03:39 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91494c03sm17293910a12.18.2025.12.24.08.03.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:03:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] target/avr: Use explicit little-endian LD/ST API
Date: Wed, 24 Dec 2025 17:03:32 +0100
Message-ID: <20251224160335.88861-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x544.google.com
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

AVR is little-endian. Use the explicit 'little'
endianness instead of the 'native' one.
Forbid further uses of legacy APIs.

tag: https://gitlab.com/philmd/qemu/-/tags/endian_avr-v1
CI: https://gitlab.com/philmd/qemu/-/pipelines/2231223066

Philippe Mathieu-Daudé (3):
  hw/avr: Mark AVR-specific peripherals as little-endian
  target/avr: Inline translator_lduw()
  configs/targets: Forbid AVR to use legacy native endianness API

 configs/targets/avr-softmmu.mak | 1 +
 hw/char/avr_usart.c             | 2 +-
 hw/misc/avr_power.c             | 2 +-
 hw/timer/avr_timer16.c          | 6 +++---
 target/avr/helper.c             | 4 ++--
 target/avr/translate.c          | 2 +-
 6 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.52.0


