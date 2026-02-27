Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC66FD7F92
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 10:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvvJa-0003vY-Hk; Fri, 27 Feb 2026 05:43:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvvJZ-0003vQ-1T
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 05:43:21 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvvJX-0001ox-0V
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 05:43:20 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4398ebdf520so1866172f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 02:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772188997; x=1772793797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wGxAb9OgSpmTaoUpDgh4lvut+gdYlXgYnsqf0926Wjk=;
 b=bXGBaXilE/HXsZP3kGt3FDd+on0H4t5uUmUWjCwPGZ/+OCvxH6dyYZGqdy2RThFBKK
 uAb+DldFtN1vrkpf03v9DtzJN6wFde0aOsdjCOzyoD3X4RX20A9qgxsbRPqkbw3IhuP0
 a1XlHQGqvF1XAZYbXTdMRNgAERW+W4PyfgcjOWKgT2F94KS1lKRcsR/WyvoOChubnWnx
 Sdd0lb+94Ass5HyjHI97VAEYZpB9l+czdxlAEdgiOM1mlkvV2f8kalo4vO8RSTwj3O+7
 OuAGh/1H43rWNpJe+bCR4+HFC8XwyR6EDeWG2JKW1ciZafwSCwAuSlcBZ0I/AFCB9xL9
 vAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772188997; x=1772793797;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wGxAb9OgSpmTaoUpDgh4lvut+gdYlXgYnsqf0926Wjk=;
 b=Iss3uuzID6V1pCIq06FHhQmWUAH3uPrN4HkRtJTOHcTUYLV3v6XUmYw8fKq47F/9TC
 ecQ1VlsOfpe5NwS3XracFkgi4f5C+Ence9X7b98N07WUYrLJuoSayNjaHTJeIsbzRmH0
 ifal5i368PiEb+JoiY+4p/oN3mSSdaPyAehWMIwmKiS07GwcePboIeLj8r1fJFn9vfU+
 kP4B6Bjx4tvj6xb16BF6mJ8A9KQo0KEpJjsaToOYv9Q/vzIxQ/o7RSIp6hS756sT8OEP
 HsofBfGWwK4cMTddrF5LlNNEVy7q+lfwOa3cnFn0xOi8u8omfwk8NLFcewxj8FmoO4JA
 y1gA==
X-Gm-Message-State: AOJu0YwdtAIwdBwRQdqF3xqHwXpVjSBWJETFb9VDqFBTtADXgQXt9n57
 d+pM2yXB61qU3SXF7UnQnnrkQNzgyAFsg1YNgsqPoBG62/X0pTeoWq3yhF6dioNzhQr+DU18SFh
 d3oFkgbQ=
X-Gm-Gg: ATEYQzw47ricfu7aAQoe+nvRgSTCFjGCqPgV1/mmmNvCmDaevnXDl6y62lbZUVc9EA7
 xRg1vnk4QNRdpLHonmJ93YjvRd3eTvnfNhs5HQTA5OWL8HIvIIsmTHEkDh24bWwCcZSK/HzgRI1
 2Em5ZZgXXZ/ZWR0Ygk1uieCskUQpKw+U9o16z9iQNY2W7R/8bfUGVxKNtajPabyR248DPkTloqH
 zzNlST9pZpyqln6splUl5trTW7baaWoxpxlRxM/Mn4EPoO2mQjmBkrbrXn7ggD6rEymR0dYhIPv
 v3GPpJi62wye3doyMMrLsaF4MVH7Ecugy1wwbjJcl3VIMJKSUD2DOj0K8LrcD4yOFGUPo0lpKzZ
 oln5OtDe5xTSx6CjIebvoUMBpuuomASsFG4SXPSVv5Hx9pfoRZpJ8qN+zh1VOfic9kJVN0k3QfE
 v96F3SfM2NzoxGHYfsY6ZhbF9avV5MVOJ7HaVyphoypQZU63vy7bdLVdbu9JILhfMJLMzFzmYf
X-Received: by 2002:a5d:5f88:0:b0:439:85e3:c3f4 with SMTP id
 ffacd0b85a97d-4399d97f97amr3763262f8f.8.1772188996711; 
 Fri, 27 Feb 2026 02:43:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c76b48asm6450644f8f.37.2026.02.27.02.43.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Feb 2026 02:43:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 0/4] gdbstub: Generate a single gdbstub-xml.c /
 gdb_static_features[]
Date: Fri, 27 Feb 2026 11:43:10 +0100
Message-ID: <20260227104314.81038-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

v4: Move gdb-xml/ directory under gdbstub/
v3: Restrict meson to gdbstub/
v2: Check array length

Philippe Mathieu-Daudé (4):
  meson: Restrict gdbstub to user/system builds
  gdbstub: Remove 'gdb-xml/' directory prefix in TARGET_XML_FILES
  gdbstub: Move gdb-xml/ within gdbstub/
  gdbstub: Generate a single gdbstub-xml.c / gdb_static_features[]

 MAINTAINERS                                   | 19 ++++++++---------
 docs/devel/codebase.rst                       |  2 --
 configs/targets/aarch64-bsd-user.mak          |  2 +-
 configs/targets/aarch64-linux-user.mak        |  2 +-
 configs/targets/aarch64-softmmu.mak           |  2 +-
 configs/targets/aarch64_be-linux-user.mak     |  2 +-
 configs/targets/alpha-linux-user.mak          |  2 +-
 configs/targets/alpha-softmmu.mak             |  2 +-
 configs/targets/arm-bsd-user.mak              |  2 +-
 configs/targets/arm-linux-user.mak            |  2 +-
 configs/targets/arm-softmmu.mak               |  2 +-
 configs/targets/armeb-linux-user.mak          |  2 +-
 configs/targets/avr-softmmu.mak               |  2 +-
 configs/targets/hexagon-linux-user.mak        |  2 +-
 configs/targets/i386-bsd-user.mak             |  2 +-
 configs/targets/i386-linux-user.mak           |  2 +-
 configs/targets/i386-softmmu.mak              |  2 +-
 configs/targets/loongarch64-linux-user.mak    |  2 +-
 configs/targets/loongarch64-softmmu.mak       |  2 +-
 configs/targets/m68k-linux-user.mak           |  2 +-
 configs/targets/m68k-softmmu.mak              |  2 +-
 configs/targets/microblaze-linux-user.mak     |  2 +-
 configs/targets/microblaze-softmmu.mak        |  2 +-
 configs/targets/microblazeel-linux-user.mak   |  2 +-
 configs/targets/microblazeel-softmmu.mak      |  2 +-
 configs/targets/or1k-linux-user.mak           |  2 +-
 configs/targets/or1k-softmmu.mak              |  2 +-
 configs/targets/ppc-linux-user.mak            |  2 +-
 configs/targets/ppc-softmmu.mak               |  2 +-
 configs/targets/ppc64-linux-user.mak          |  2 +-
 configs/targets/ppc64-softmmu.mak             |  2 +-
 configs/targets/ppc64le-linux-user.mak        |  2 +-
 configs/targets/riscv32-linux-user.mak        |  2 +-
 configs/targets/riscv32-softmmu.mak           |  2 +-
 configs/targets/riscv64-bsd-user.mak          |  2 +-
 configs/targets/riscv64-linux-user.mak        |  2 +-
 configs/targets/riscv64-softmmu.mak           |  2 +-
 configs/targets/rx-softmmu.mak                |  2 +-
 configs/targets/s390x-linux-user.mak          |  2 +-
 configs/targets/s390x-softmmu.mak             |  2 +-
 configs/targets/sparc-linux-user.mak          |  2 +-
 configs/targets/sparc-softmmu.mak             |  2 +-
 configs/targets/sparc32plus-linux-user.mak    |  2 +-
 configs/targets/sparc64-linux-user.mak        |  2 +-
 configs/targets/sparc64-softmmu.mak           |  2 +-
 configs/targets/x86_64-bsd-user.mak           |  2 +-
 configs/targets/x86_64-linux-user.mak         |  2 +-
 configs/targets/x86_64-softmmu.mak            |  2 +-
 meson.build                                   | 12 +----------
 stubs/gdbstub.c => gdbstub/gdb-xml-stub.c     |  0
 {gdb-xml => gdbstub/gdb-xml}/aarch64-core.xml |  0
 {gdb-xml => gdbstub/gdb-xml}/aarch64-fpu.xml  |  0
 {gdb-xml => gdbstub/gdb-xml}/aarch64-mte.xml  |  0
 .../gdb-xml}/aarch64-pauth.xml                |  0
 {gdb-xml => gdbstub/gdb-xml}/aarch64-sme2.xml |  0
 {gdb-xml => gdbstub/gdb-xml}/alpha-core.xml   |  0
 {gdb-xml => gdbstub/gdb-xml}/arm-core.xml     |  0
 .../gdb-xml}/arm-m-profile-mve.xml            |  0
 .../gdb-xml}/arm-m-profile.xml                |  0
 {gdb-xml => gdbstub/gdb-xml}/arm-neon.xml     |  0
 .../gdb-xml}/arm-vfp-sysregs.xml              |  0
 {gdb-xml => gdbstub/gdb-xml}/arm-vfp.xml      |  0
 {gdb-xml => gdbstub/gdb-xml}/arm-vfp3.xml     |  0
 {gdb-xml => gdbstub/gdb-xml}/avr-cpu.xml      |  0
 {gdb-xml => gdbstub/gdb-xml}/cf-core.xml      |  0
 {gdb-xml => gdbstub/gdb-xml}/cf-fp.xml        |  0
 {gdb-xml => gdbstub/gdb-xml}/hexagon-core.xml |  0
 {gdb-xml => gdbstub/gdb-xml}/hexagon-hvx.xml  |  0
 .../gdb-xml}/i386-32bit-linux.xml             |  0
 {gdb-xml => gdbstub/gdb-xml}/i386-32bit.xml   |  0
 .../gdb-xml}/i386-64bit-apx.xml               |  0
 .../gdb-xml}/i386-64bit-linux.xml             |  0
 {gdb-xml => gdbstub/gdb-xml}/i386-64bit.xml   |  0
 .../gdb-xml}/loongarch-base32.xml             |  0
 .../gdb-xml}/loongarch-base64.xml             |  0
 .../gdb-xml}/loongarch-fpu.xml                |  0
 .../gdb-xml}/loongarch-lasx.xml               |  0
 .../gdb-xml}/loongarch-lsx.xml                |  0
 {gdb-xml => gdbstub/gdb-xml}/m68k-core.xml    |  0
 {gdb-xml => gdbstub/gdb-xml}/m68k-fp.xml      |  0
 .../gdb-xml}/microblaze-core.xml              |  0
 .../gdb-xml}/microblaze-stack-protect.xml     |  0
 {gdb-xml => gdbstub/gdb-xml}/or1k-core.xml    |  0
 .../gdb-xml}/power-altivec.xml                |  0
 {gdb-xml => gdbstub/gdb-xml}/power-core.xml   |  0
 {gdb-xml => gdbstub/gdb-xml}/power-fpu.xml    |  0
 {gdb-xml => gdbstub/gdb-xml}/power-spe.xml    |  0
 {gdb-xml => gdbstub/gdb-xml}/power-vsx.xml    |  0
 {gdb-xml => gdbstub/gdb-xml}/power64-core.xml |  0
 .../gdb-xml}/riscv-32bit-cpu.xml              |  0
 .../gdb-xml}/riscv-32bit-fpu.xml              |  0
 .../gdb-xml}/riscv-32bit-virtual.xml          |  0
 .../gdb-xml}/riscv-64bit-cpu.xml              |  0
 .../gdb-xml}/riscv-64bit-fpu.xml              |  0
 .../gdb-xml}/riscv-64bit-virtual.xml          |  0
 {gdb-xml => gdbstub/gdb-xml}/rx-core.xml      |  0
 {gdb-xml => gdbstub/gdb-xml}/s390-acr.xml     |  0
 {gdb-xml => gdbstub/gdb-xml}/s390-cr.xml      |  0
 {gdb-xml => gdbstub/gdb-xml}/s390-fpr.xml     |  0
 {gdb-xml => gdbstub/gdb-xml}/s390-gs.xml      |  0
 .../gdb-xml}/s390-virt-kvm.xml                |  0
 {gdb-xml => gdbstub/gdb-xml}/s390-virt.xml    |  0
 {gdb-xml => gdbstub/gdb-xml}/s390-vx.xml      |  0
 {gdb-xml => gdbstub/gdb-xml}/s390x-core64.xml |  0
 {gdb-xml => gdbstub/gdb-xml}/sparc32-cp0.xml  |  0
 {gdb-xml => gdbstub/gdb-xml}/sparc32-cpu.xml  |  0
 {gdb-xml => gdbstub/gdb-xml}/sparc32-fpu.xml  |  0
 {gdb-xml => gdbstub/gdb-xml}/sparc64-cp0.xml  |  0
 {gdb-xml => gdbstub/gdb-xml}/sparc64-cpu.xml  |  0
 {gdb-xml => gdbstub/gdb-xml}/sparc64-fpu.xml  |  0
 gdbstub/meson.build                           | 21 +++++++++++++++++++
 stubs/meson.build                             |  2 --
 112 files changed, 77 insertions(+), 71 deletions(-)
 rename stubs/gdbstub.c => gdbstub/gdb-xml-stub.c (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/aarch64-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/aarch64-fpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/aarch64-mte.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/aarch64-pauth.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/aarch64-sme2.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/alpha-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-m-profile-mve.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-m-profile.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-neon.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-vfp-sysregs.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-vfp.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/arm-vfp3.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/avr-cpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/cf-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/cf-fp.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/hexagon-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/hexagon-hvx.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/i386-32bit-linux.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/i386-32bit.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/i386-64bit-apx.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/i386-64bit-linux.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/i386-64bit.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/loongarch-base32.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/loongarch-base64.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/loongarch-fpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/loongarch-lasx.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/loongarch-lsx.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/m68k-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/m68k-fp.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/microblaze-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/microblaze-stack-protect.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/or1k-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/power-altivec.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/power-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/power-fpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/power-spe.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/power-vsx.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/power64-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/riscv-32bit-cpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/riscv-32bit-fpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/riscv-32bit-virtual.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/riscv-64bit-cpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/riscv-64bit-fpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/riscv-64bit-virtual.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/rx-core.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-acr.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-cr.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-fpr.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-gs.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-virt-kvm.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-virt.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390-vx.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/s390x-core64.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/sparc32-cp0.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/sparc32-cpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/sparc32-fpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/sparc64-cp0.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/sparc64-cpu.xml (100%)
 rename {gdb-xml => gdbstub/gdb-xml}/sparc64-fpu.xml (100%)

-- 
2.52.0


