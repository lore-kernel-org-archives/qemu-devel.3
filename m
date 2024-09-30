Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9E3CEB2CA
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 22:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svOcp-0002xM-OJ; Mon, 30 Sep 2024 18:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svOcn-0002u6-C4
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 18:12:13 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svOcl-0002c0-Ld
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 18:12:13 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c5cf26b95aso5611916a12.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 15:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727734330; x=1728339130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LRXyg4ZMLe6rL1P5aLv2+vxkqHAdzQV7DbZ6DSez1v4=;
 b=qYRx65+3vGtfRSLb85H70gg4rNMrSsNFzts7HuM8yx1kdTqfo3dytGZT8h+wsN5ML2
 1VeYiQX+gaboj42F3I+HZcFu9u34wZmq3m4Iy/l6P9IoCb+/PCWnynb896X66fpQaRlL
 7lHJVrdaXpzBa2UhOhkRkunYDgvLabKVjyGSxLloFGVgSgz+QQq4Aw1nj9SSWgjVdOuR
 +7HMOIR/y5t0BXK35nEiFZCs0Ar8VlnIjUrcC82rnGWVhJBdDDXM2Gx0lqYKojNaYzJT
 NimohG9atsc2Y31tFuTZVe5Mh4yRLbeJAjtyx3zSXrZB36MAa7kdV6HUFtjbrnGyaZ/K
 Gbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727734330; x=1728339130;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LRXyg4ZMLe6rL1P5aLv2+vxkqHAdzQV7DbZ6DSez1v4=;
 b=O81YxwEi/vcFREHCVoEEW/r5e/BnkGzoq8jTpdiWL89jwHYSxAiZGysWuVzOPl71p0
 MlZROwHZLvEARDxUFSOk7fYFLSV28BtNJUGniWCgnggcsryAQgP/jhNNZiA9WyFE4JgR
 C8YDafk3xOaupNFt0vV5O1XH4mtgNdzOLSRicDmXWJpu+oraaLBJuKNy6lkEQJFkP+WO
 yMCqUNeRDG8lxcZoLDANU+HR3WKkwyH72w/u7DPzZgq3gu7tV/2/yJ9NDODJJyll/rXJ
 XhWqZ4Isn5A1T7bCcWSYvO7jf2us34SZRFYFDjXA9SiuhMk9zoTnDoPxnWy2nZ/y7dwg
 pu6w==
X-Gm-Message-State: AOJu0YxGsFLgP9fa/FHzHzIuOjfYAzcFsWBhJ2DDwDL5OSydyAvZH1Jz
 3sc+IRM8zMNtHUKRL5OfP63J0dNJOL+BFQICbQWabVsACMZqn9zAwCb/OaPGAPaHfkc1UgLE6CM
 oFLM=
X-Google-Smtp-Source: AGHT+IH0I+gBUuj81D9VRfNnlAXpizYfZCt1V1vO8T0ipZQ3yMXQw6ifP57Fb3QLILETiVH+imRkmg==
X-Received: by 2002:a05:6402:3508:b0:5c8:9f81:446c with SMTP id
 4fb4d7f45d1cf-5c89f8144bbmr1469099a12.3.1727734329731; 
 Mon, 30 Sep 2024 15:12:09 -0700 (PDT)
Received: from localhost.localdomain (46.170.88.92.rev.sfr.net. [92.88.170.46])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c882495335sm5056696a12.95.2024.09.30.15.12.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 15:12:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, Laurent Vivier <laurent@vivier.eu>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>, Tyrone Ting <kfting@nuvoton.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 0/3] hw/arm: Replace tswap32() by stl_endian_p()
Date: Tue,  1 Oct 2024 00:12:01 +0200
Message-ID: <20240930221205.59101-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

- Expose arm_cpu_code_is_big_endian()
- pass ARMCPU argument to arm_write_bootloader() so we can call
  arm_cpu_code_is_big_endian() on it,
- Replace target specific tswap32() by target agnostic stl_endian_p()

Tested on little & big endian hosts.

Philippe Mathieu-Daudé (3):
  target/arm: Expose arm_cpu_code_is_big_endian() prototype in 'cpu.h'
  hw/arm: Have arm_write_bootloader() take a ARMCPU argument
  hw/arm: Replace tswap32() calls by target agnostic stl_endian_p()

 include/hw/arm/boot.h         |  9 ++++++---
 target/arm/cpu.h              |  7 +++++++
 hw/arm/aspeed.c               |  3 +--
 hw/arm/boot.c                 | 17 ++++++++++-------
 hw/arm/exynos4210.c           |  7 +++----
 hw/arm/npcm7xx.c              |  6 ++++--
 hw/arm/raspi.c                |  4 ++--
 hw/arm/xilinx_zynq.c          |  5 +++--
 linux-user/aarch64/cpu_loop.c |  4 ++--
 linux-user/arm/cpu_loop.c     |  4 ++--
 target/arm/cpu.c              |  6 ++----
 11 files changed, 42 insertions(+), 30 deletions(-)

-- 
2.45.2


