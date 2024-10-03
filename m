Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FEBCF34D5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 23:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swVSi-0007Hu-6m; Thu, 03 Oct 2024 19:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swVSf-0007Gj-QQ
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:42:21 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swVSe-0003KB-AZ
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:42:21 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cae102702so12304275e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 16:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727998938; x=1728603738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Oi+Nd0fKgFyor+xTImivGQKXTHkB761wIWp1Jw+5YTQ=;
 b=R7OwxPxYjolpQqftGUAL2EMrChhRjFufowp6Z6AnvkkHmiHLPvj/lDw9FCaaYQ1Nv0
 oVqDMe+x11HzTiMBGJG2sTHkLWC6TZV/E/zKlN7M8HWwSaFAfsyDeT/QgU1C9nzHXK1p
 pG+PQgG9Yi511ymFGb69TrJMydxX8hWnCLkPdDcCJf0t0/Yzx08L7N99OE85lc36+IFQ
 iVLwkXqGeCablPOaVfADGFr0CIXYkDP2KwuW3PrThKkfpN3lHtHqCQU1n4wgY5BFUdU8
 yCDIFUtPd58UEMz9UZrotxR2glu2eC23PC0OPOMayNs3BYG4NTcQ5MDiPpa+cKF7Lul8
 922A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727998938; x=1728603738;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oi+Nd0fKgFyor+xTImivGQKXTHkB761wIWp1Jw+5YTQ=;
 b=RZskEdrV/8uFEtZO7H7ziL3wvm803L2Rjqen8sYHIhqeJ9/elJrU6Goh+DNZmCasRQ
 safoFGmHq/VlulmKFHbScriBxrxkzUCl/krQK+FctpI5n97V4qpuXDME93/62ScAghPh
 7mMohsXVOWZXgbdYTN6LCkEvZzQO5NcGS6YTDtzRG07wF9eXREuRfeDALlZPLCnh4vCy
 wUW2QSpXdS9K1yhZ0xzDDv70avAbcAERDDRtHQRTxuX53bneVw/Lsgp9zPIPxlieplbG
 JuHsrLvGw3nFaskb+fcE2NQ6bYdD+GQd4IYKK9CrHAJHQzJoRvmeMyrYDHqgthZCNpRV
 Yvfw==
X-Gm-Message-State: AOJu0YxqZHhBUSjoSZ84AoPoqXC4/16WJ8lNiFKlksSQ0oJL6x7kMsw/
 DYFhFKanNHIvyvrrqBszWQAGIfpIoJVZE0madvwiJRGkIhPKM0wx7lomkQqF5K/Ma9rZGxc7rlj
 yD0I=
X-Google-Smtp-Source: AGHT+IF7RXCj0eajhxQMCXEMmgztQYlVpAQZuia71eg609Enynbk7e/lVBzNP8zy+EsKiM+OA63l/A==
X-Received: by 2002:a05:600c:4f86:b0:42a:a6d2:3270 with SMTP id
 5b1f17b1804b1-42f85ac0c07mr3543565e9.21.1727998938003; 
 Thu, 03 Oct 2024 16:42:18 -0700 (PDT)
Received: from localhost.localdomain (45.red-88-29-191.dynamicip.rima-tde.net.
 [88.29.191.45]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a1f74fsm1320275e9.2.2024.10.03.16.42.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Oct 2024 16:42:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Song Gao <gaosong@loongson.cn>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 00/16] misc: Use explicit endian LD/ST API
Date: Fri,  4 Oct 2024 01:41:55 +0200
Message-ID: <20241003234211.53644-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

For targets (or HW) which are only built for a particular
endianness, the generic LD/ST helpers are defined as the
target endianness variant. For example, on big-endian
targets, stl_p() is equivalent of stl_be_p().

This series replaces in bulk these LD/ST calls.

This is helpful for the single binary project where we
want to build a single binary for multiple targets of
different endianness.

Philippe Mathieu-Daudé (16):
  qemu/bswap: Undefine CPU_CONVERT() once done
  exec/memop: Remove unused memop_big_endian() helper
  linux-user/i386: Use explicit little-endian LD/ST API
  hw/i386: Use explicit little-endian LD/ST API
  target/i386: Use explicit little-endian LD/ST API
  hw/m68k: Use explicit big-endian LD/ST API
  target/m68k: Use explicit big-endian LD/ST API
  hw/ppc/e500: Use explicit big-endian LD/ST API
  hw/s390x: Use explicit big-endian LD/ST API
  target/s390x: Use explicit big-endian LD/ST API
  hw/sparc: Use explicit big-endian LD/ST API
  target/sparc: Use explicit big-endian LD/ST API
  target/avr: Use explicit little-endian LD/ST API
  target/hppa: Use explicit big-endian LD/ST API
  target/loongarch: Use explicit little-endian LD/ST API
  target/tricore: Use explicit big-endian LD/ST API

 hw/m68k/bootinfo.h                   |  28 ++---
 include/exec/memop.h                 |   6 -
 include/qemu/bswap.h                 |   2 +
 hw/i386/multiboot.c                  |  36 +++---
 hw/i386/x86-common.c                 |  26 ++---
 hw/m68k/mcf5208.c                    |   2 +-
 hw/m68k/next-cube.c                  |   2 +-
 hw/m68k/q800.c                       |   4 +-
 hw/ppc/ppce500_spin.c                |  24 ++--
 hw/s390x/ipl.c                       |   4 +-
 hw/s390x/s390-pci-inst.c             | 166 +++++++++++++--------------
 hw/sparc/leon3.c                     |  42 +++----
 hw/sparc/sun4m.c                     |   6 +-
 hw/sparc64/sun4u.c                   |   6 +-
 linux-user/i386/signal.c             |   4 +-
 target/avr/gdbstub.c                 |   4 +-
 target/hppa/gdbstub.c                |   2 +-
 target/i386/gdbstub.c                |  26 ++---
 target/i386/tcg/sysemu/excp_helper.c |   4 +-
 target/i386/xsave_helper.c           |  32 +++---
 target/loongarch/gdbstub.c           |   8 +-
 target/m68k/gdbstub.c                |   2 +-
 target/m68k/helper.c                 |  10 +-
 target/s390x/gdbstub.c               |   4 +-
 target/s390x/ioinst.c                |   2 +-
 target/sparc/gdbstub.c               |   4 +-
 target/tricore/gdbstub.c             |   2 +-
 27 files changed, 227 insertions(+), 231 deletions(-)

-- 
2.45.2


