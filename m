Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD438F99367
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqxA-0003T2-Au; Thu, 23 Apr 2026 06:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFqwv-0003MU-Hn
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:06:23 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFqwq-0003le-OM
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:06:21 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43d74086e5bso6310581f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938775; x=1777543575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4KCW4PAqclUcY/yBQHqr1U4r1+WZvTTcJ53C6nU/lIs=;
 b=l3d5utM4/YcRzSdZHaCgOAVwZXVgJsEyiLifRMO3jP04G9iE4Sxhjo9td9s1yIzWl1
 seSO73U9BA3m2xBJiRwLXKYMf+2bE1RhPLgY1mj4F/Kqq6T4+IHhwSLOZeR7sgfj/MAz
 b5dPRXEYJXIVmu7brK7FJstzqvLAmE3lPb3PxrxJudhIikFH6jxsP361KxE6q0+RE278
 yAi25NLL/T9xpQw58yyr0X+ru3E+WOOhpKwUyWni63DAFcNvqF/PKTq58zgbzXGJ8EmW
 aK5OlcJ1gyOBpkojJP1G/PI5hwikCks+cMX6kW6fZ60x1SFChVW9eEcIMD5nzHviKEhd
 IaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938775; x=1777543575;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4KCW4PAqclUcY/yBQHqr1U4r1+WZvTTcJ53C6nU/lIs=;
 b=rOutLH/AK8jP4FqaceVPVOfpuB2yeeqhKZraI6pfTbV3RWcOLO3FbGh/W4dDZ0rfr9
 NT4fhJ8oCGsaR2CTIWdNCqlw0FdAqAMtEYHBfay5yH+zLJ9d/8/ysrffxgreoEnYaDaa
 zOQKBZypUvifRUApVkY0YtGMZ1PC8IgaURorAc7MVFOEHD0vy8FO1qhB6GN+MciOGwKP
 MUYWPOJwnB+Cgj6uiyjW6FKRq14XzBTG3Eakr2Gwxd1tDBZsWeRS7qJzqzWzm4Afki2y
 N7LSvb7crrfmKyDegiWSftPthWvGAimqp64Pk930SIUtEka38gUzUQm4UfDzZJS/QvfN
 lPbg==
X-Gm-Message-State: AOJu0Yzis7WXHQXezLNxFzDAJJ0du67P+c+/yR+nvfVuZTYuslJza8iH
 VU6EWO/xl+Yc+kB0MdKR861c+jq1JUyFgGQNsQ8fYve927Teeho2Q64yYwz645bvpYoWXqvDcbK
 lVxnNlIg=
X-Gm-Gg: AeBDieuYJA++ljVm5cYIZIH5hk5u2CUxx1AhDbZAxl6c6bWr+QwMLU8rsQToYGHpg2p
 obV70yWd07GGxRa9362kAYgr8d34Ad08ho7x8vxbdI6PgIoTutBlW0f5/o8iN8p+0W77TfUXJ2Q
 WoHPyA2SGdeOtxEmAtrdV4YlMx2YfHgyFe44OivCxhQ1pQJOvOMMkN4nR30ERK4stysdJ4LLdue
 ohLCQYSmiWTkQf+9A3o/fX+Pc+HmI4VCosotSpaUTXNeY/nlwgyADQcaui72vMYy55/xRszvs5H
 /y8D+mraPe17CFqZGGXqRge95Q1vZKZ+9dMjvHa7mJkz+7K9AFfCNHUpTHb2aaeanWCHONpA2C6
 Wsnf+4uuOjwoAe6mK/ctVYo4JwE/8l644EtUCFUiBuykoS6QNPT+w8KIvyCwPSi669XkeRqcvhl
 TkG8eyT2PrYBGW1Gry2ym0w0q4a1bAPbDPafTx+0nRRWONR1OwVZz5hCo+H0CSfPCEZLU13tM3o
 tMYD1vC49Y=
X-Received: by 2002:a05:6000:2dc3:b0:439:b1c3:84c8 with SMTP id
 ffacd0b85a97d-43fe3de2bf5mr39765994f8f.21.1776938774625; 
 Thu, 23 Apr 2026 03:06:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d5b1sm55999273f8f.30.2026.04.23.03.06.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 03:06:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/9] target/microblaze: Compile it once
Date: Thu, 23 Apr 2026 12:06:03 +0200
Message-ID: <20260423100612.27278-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Compiling target/microblaze/ is now almost trivial.

The first 2 patches should be backported to the stable release IMO.

Philippe Mathieu-Daudé (9):
  tcg: Include missing 'tcg/tcg-op-common.h' header in 'tcg-op-mem.h'
  target/microblaze: Fix endianness used to disassemble
  target/microblaze: Replace translator_ldl_swap() ->
    translator_ldl_end()
  target/microblaze: Introduce common system/user meson source set
  target/microblaze: Compile helper.c as common unit
  target/microblaze: Compile op_helper.c as common unit
  target/microblaze: Compile cpu.c as common unit
  target/microblaze: Include missing cpu-mmu-index.h header in
    translate.c
  target/microblaze: Compile translate.c as common unit

 include/tcg/tcg-op-mem.h      |  2 ++
 target/microblaze/cpu.h       |  7 -------
 target/microblaze/cpu.c       |  6 +++---
 target/microblaze/op_helper.c |  2 +-
 target/microblaze/translate.c | 11 +++++++----
 target/microblaze/meson.build | 12 ++++++------
 6 files changed, 19 insertions(+), 21 deletions(-)

-- 
2.53.0


