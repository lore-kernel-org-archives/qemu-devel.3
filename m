Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9F5E776F0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRnY-0005JX-7A; Wed, 24 Dec 2025 11:33:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRnV-00058L-FG
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:33:13 -0500
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRnT-0005Bc-NP
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:33:13 -0500
Received: by mail-ej1-x643.google.com with SMTP id
 a640c23a62f3a-b804646c718so552157866b.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593989; x=1767198789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4+N4IzWD7RFC6HCn0hPB4lVzwstmmFO8EWchBElZYE4=;
 b=TGdW/Wkp4hYLEGRdfld/GBoMTbGfj3Voz/uYHphjEdE49BovrekAJLQoLgvHap17iw
 k84RkgjhrWJ2TNazrGbVIWDPfxlWI1fwl15IG4Udq2Okutpe4l/I1JWOT7NMTvprYYmy
 f6xPY2SN0iAj75WWmOIKDT/RtsOxYCa+Q0HfPW3Y3uXcyvFpMPxITC7BkFMPOdmQlKwa
 tZ78Gs/u02N1y0C/emQnZ2Hl3ZUW6y4JfBQzrZMDWgzZo+gepDsJ/S0ZEh42bAas78NP
 Mipzvn8N/iXSiofD3ii980s2RdsDGtExTS8B5fIC7o5wWRVqxT3v0MuMcVP/Gj6mKhI1
 2Uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593989; x=1767198789;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+N4IzWD7RFC6HCn0hPB4lVzwstmmFO8EWchBElZYE4=;
 b=lLrc8JPZlmz9LPYdjvrqfYN2FRpXVRwA5J694Y7+jGo1yej5QkWeTpn/Bvt9H/6PED
 5d+DfASgrF5l8wXirslDHdFkF7gRkyPQkefe3NPhT9p2tHVy0U9w9szzl59/Q88lxJ9c
 IkY9efO/19bXf8B2CxEH01mrzk5DreR7WVTp6IvDOMKlQO7+Ed9TKspGHqFpqksuos2j
 nVNkh8Bd6QxhqABp4uKV10LmA3UDQyIfbkNX2VRhojDGe2t3mPzP5587bcsryEtmCvC+
 jOo8daoTG5oc3pgG2ENCHT3EjmctgOKnYXHKy6cN4Utu6rg+jqXlnAPUcP9PY7QMPfNv
 fsYA==
X-Gm-Message-State: AOJu0YzDInVEZliKmxInDRaWwpVTPAaftu//IaRnWDiI44S4570ZuDQk
 tQbkcGW4BDibk3h4RhOo2KuSku8MqDpNnemYyKjWQurWE45KEPElNGu82nKWdjz+bIvg2Ii1zBt
 OLJZxkCc=
X-Gm-Gg: AY/fxX7gWG5Is1x/9m3oB67rjH8Qnqq3hlP24fUvVzcPY6wdqkwoL3K/0gWN2E/h3qt
 eVdc1uRVWHnflkee215BvWT5yyLo4QLSbv9zhsPgUVt7CGtM7hWq6g3afBhwgaR8qFVYtL7/uVP
 9CBImtiZgSc+CKSLf+6KyUV/aH3qn0rbY7Zejur74/p6Vps0jfQoEOl5ylrwLe4bPSxIoEna/rP
 C4GbOH+ZP81guakXsk48tkoiuXHSqxrdFOqoPKGCUnm6nWIfVLzIolk1kfiNR6Z7X5pUtluo7eL
 zVLHaY15cJR/XRIr+TipkAx7cc6OLp7JfHETtE9oFPnp6skD/nQ1YPn1NRd6xnKF69Z5Rr36tbg
 XSxPbeRNHaRjG24nyBYdKtDYvNeElXmeRMc8H/XnS9X2HzqvEk8/J9zrA+bgwEFdDxcqKupL0L/
 OBpRt1VnRUEnOqpVRRKLPv4B/wgTs2nWiOJjWteMtEyNXuVILfaU4bO4g=
X-Google-Smtp-Source: AGHT+IFLqxyWTz0HYHxGQzjzcqJUq7INO8fBWhSwV6LAPcR1FKZ/bkQsRnyadyLs6dT8jMc0luobfw==
X-Received: by 2002:a17:907:97c7:b0:b76:8164:88b5 with SMTP id
 a640c23a62f3a-b803719d432mr2085703366b.46.1766593989022; 
 Wed, 24 Dec 2025 08:33:09 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037de0b38sm1787550266b.32.2025.12.24.08.33.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:33:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] target/rx: Use explicit little-endian LD/ST API
Date: Wed, 24 Dec 2025 17:33:00 +0100
Message-ID: <20251224163304.91384-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x643.google.com
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

Renesas RX is little-endian. Use the explicit 'little'
endianness instead of the 'native' one.
Remove some target_ulong uses. Forbid further uses of
legacy APIs.

tag: https://gitlab.com/philmd/qemu/-/tags/endian_rx-v1
CI: https://gitlab.com/philmd/qemu/-/pipelines/2231223066

Philippe Mathieu-Daudé (4):
  target/rx: Use little-endian variant of cpu_ld/st_data*()
  target/rx: Use explicit little-endian LD/ST API
  target/rx: Inline translator_lduw() and translator_ldl()
  configs/targets: Forbid Renesas RX to use legacy native endianness API

 configs/targets/rx-softmmu.mak |  1 +
 target/rx/cpu.c                |  2 +-
 target/rx/gdbstub.c            | 24 ++++++++++++------------
 target/rx/helper.c             | 14 +++++++-------
 target/rx/op_helper.c          |  6 +++---
 target/rx/translate.c          |  9 +++++----
 6 files changed, 29 insertions(+), 27 deletions(-)

-- 
2.52.0


