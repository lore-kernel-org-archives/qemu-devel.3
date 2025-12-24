Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90816E776C3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRhR-0007Uu-KY; Wed, 24 Dec 2025 11:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRhL-0007TA-Fk
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:26:53 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRhH-0003Tv-W9
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:26:49 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-477b198f4bcso39592335e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593606; x=1767198406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r3EuDzyAeJcBsf61kG69KDd1jgme/KZVH1SRq6Y6/48=;
 b=ltK0otQemfiTCyWfuHPG15Zmuo6HuUJAuIlhRbJSdfpi/eHwuThozD6HWhoETmSlen
 M5DS/dA9hDedeFkiijcf92TsdVykMjSsxT3QSDt0Bx018OnRa/vnUfRMxLi90NsWWHuD
 npFley9yRBjHwhH6zqoU5Wg7J43eThhDCKasLaZZsywnLuhyZDUjgZHpAk185BU70PMs
 wsKyYeLywiI5yn+849HX9DLSO8xwIrQ3wNmBHEHN2uWcLgBVPn1KZB8mb6K1o02UGt0E
 8r5iAEhFgK6+KuhD3X9bpn2GbtQARD1WQMHpqo62B53jNmORlpzV5athi2NcSlsQO+Zm
 qseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593606; x=1767198406;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r3EuDzyAeJcBsf61kG69KDd1jgme/KZVH1SRq6Y6/48=;
 b=f9opviwxvHYNwlEQ6T/2YlLdOtvlYxCnA0rHUo/j46yAgH7rc8nx8sHMA6PrasFIqs
 Txjl2ajWyz+B3lUEj/YEWcOmMebkIeE8OvlNtLO+76KcznUxDPklPq0RyYxbIaqPmiFW
 Or9wOHPXn3tAltLs/aQoIseQAaiWyDBFV/48e86rCzKpNweDAkN1xKr7KWun1HQzh6d7
 NXed0YitgKAFe6N4KQwlnDg4D1Io1DRT451w4hmykJKA1Gl7zrglnqb5kzfkNxnyc/kp
 bKxrhsq5Xq1ZIo4vATz++v6yRsHfzDSbKYGUR8zrmXceZK6D95vXRTcX2cRfdRSTKGBj
 tM9Q==
X-Gm-Message-State: AOJu0YyJm/jYuoDNtul6/R7yECWfTV89JcJ2J/WkKn+Xe2dPPyBOQ4z5
 0GoCg76AsJ0RnBjsVTEf/VjJeJkoukqLPlHWfljXP59m7+feSQBfkYXw+w/gLQErgKwMYqK0NSK
 YBwJdmyk=
X-Gm-Gg: AY/fxX72WeRykq8sZ9hG7DLR2Hlvz92WaTfNtCJQp06r7BxpZ/GR38uQ+p6chjQZ2vZ
 JRlsLCHms0WcE0J2Sidx8ZPNCDjYxxongKdceziDk1/fOjXH1mEd5s74zMiYNkr1B0jefVTGvAB
 VqLI5E5P7rYm07feb85mVTh4OCWwj9aEw7apqrReQavRODJ3RvoxFFORnRQOo5eYtZ87eDGb5Ap
 PewaxaaXQPbxobax3RqggSBhh6q8MXA+FtVFOxdyCJGNYaeV2z7uC8Fd7tVN/5dj/JduoZf9YDa
 5EnKQK2BlKvHtjjK3gJe+S5HY1AVmevSbx6Nkn0KHF2ubDtCF5+/MSsw84tt6fAu3RUhaMoz//z
 9nXba0xpPOgb+gNU6zrBP2XBaLuDLxOM0w2t/26/Wk95nvaTIfHyWbA8TrYQTRHWqOVIAE3EHlB
 FR/0cNQ+xr4Ls5SPxaHRy/8b7VKOGhPryBqNbYFaR1VuiPTkYJgUyRgpY=
X-Google-Smtp-Source: AGHT+IG+XAU2NZB9NdR7wSF/1j+nsAd9+xwuzEVLT656xqEcVjAl2JIyP+w5UNXfpz64iOgJ2jX/Ig==
X-Received: by 2002:a05:600c:1991:b0:477:7a78:3016 with SMTP id
 5b1f17b1804b1-47d1953318bmr177515125e9.8.1766593605708; 
 Wed, 24 Dec 2025 08:26:45 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be279c5f8sm338015735e9.9.2025.12.24.08.26.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:26:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/9] target/sparc: Use explicit big-endian LD/ST API
Date: Wed, 24 Dec 2025 17:26:32 +0100
Message-ID: <20251224162642.90857-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

SPARC is big-endian. Use the explicit 'big'
endianness instead of the 'native' one.
Forbid further uses of legacy APIs.

tag: https://gitlab.com/philmd/qemu/-/tags/endian_sparc-v3
CI: https://gitlab.com/philmd/qemu/-/pipelines/2231223066

Philippe Mathieu-Daudé (9):
  hw/sparc: Mark SPARC-specific peripherals as big-endian
  hw/sparc: Use explicit big-endian LD/ST API
  target/sparc: Replace MO_TE -> MO_BE
  target/sparc: Use explicit big-endian LD/ST API
  target/sparc: Use big-endian variant of cpu_ld/st_data*()
  target/sparc: Inline translator_ldl()
  target/sparc: Inline cpu_ldl_code() call in cpu_do_interrupt()
  target/sparc: Simplify gdbstub sparc_cpu_gdb_write_register()
  configs/targets: Forbid SPARC to use legacy native endianness APIs

 configs/targets/sparc-linux-user.mak       |  1 +
 configs/targets/sparc-softmmu.mak          |  1 +
 configs/targets/sparc32plus-linux-user.mak |  1 +
 configs/targets/sparc64-linux-user.mak     |  1 +
 configs/targets/sparc64-softmmu.mak        |  1 +
 hw/audio/cs4231.c                          |  2 +-
 hw/char/grlib_apbuart.c                    |  2 +-
 hw/display/cg3.c                           |  2 +-
 hw/display/tcx.c                           | 14 ++---
 hw/dma/sparc32_dma.c                       |  2 +-
 hw/intc/grlib_irqmp.c                      |  2 +-
 hw/intc/slavio_intctl.c                    |  4 +-
 hw/misc/eccmemctl.c                        |  2 +-
 hw/misc/slavio_misc.c                      | 16 +++---
 hw/rtc/sun4v-rtc.c                         |  2 +-
 hw/sparc/leon3.c                           | 42 +++++++--------
 hw/sparc/sun4m.c                           |  6 +--
 hw/sparc64/sun4u.c                         |  6 +--
 hw/timer/grlib_gptimer.c                   |  2 +-
 hw/timer/slavio_timer.c                    |  2 +-
 target/sparc/gdbstub.c                     | 12 +----
 target/sparc/int32_helper.c                |  4 +-
 target/sparc/ldst_helper.c                 | 48 ++++++++---------
 target/sparc/mmu_helper.c                  | 32 ++++++------
 target/sparc/translate.c                   | 60 +++++++++++-----------
 25 files changed, 134 insertions(+), 133 deletions(-)

-- 
2.52.0


