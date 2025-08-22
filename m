Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455DDCA0EFF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 13:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upSDW-0005vD-FB; Fri, 22 Aug 2025 09:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cjchen@igel.co.jp>) id 1upO1D-0005U2-EU
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 05:25:07 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cjchen@igel.co.jp>) id 1upO1A-0006vm-EG
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 05:25:07 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b4717ba0d5dso1359485a12.1
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 02:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1755854701; x=1756459501;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e9eBitP7K4gzBbpURUzN39E/6vJxUXguw7XhNrGy6Qo=;
 b=KVz3g6wlTySl6gIybszKsqx7XD2PzelIr0orOjkxxC49HQrFKBkfKeqgt8uCcR0BEO
 i50Cq6dus6wmnQXvE8iAFhkmPZ/I4K9MFJ+/v9kg5nxFXuxbxQF2C37seY1PpOk4Oi08
 seA9ExxaDW8qoZwDq9EZBCFdCgMLaomHfu89OonPteEvgYvbX8vXi6onkFFX9ybKZ9wk
 /BWdHDe7/j192oB38UgbRgSffuAs8TWLknB2X7U3e1hEp2v6+sFYPjqEHYioc9joZ+hx
 MKJ0/89EdE8ozJp0mfPI+uvUxZSEWeuK89Kckrt232S9JkRvJbdC/dUQhlZ1aZriA4au
 j29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755854701; x=1756459501;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e9eBitP7K4gzBbpURUzN39E/6vJxUXguw7XhNrGy6Qo=;
 b=hcVYWcUGDu58ctJSh4aL1Tww2G4d5yCRgvRZxQAmf2ZFK6tYE6DaYA3PNf4uvMlTjg
 5z6h2WOyxygYV9kPKqWdQvysqiQOnb3uyrHiKX0feQmjlcW90cLJEMAsEDdfzvEcPprN
 HHyFVJmNn2k1NpNkX0gN28hYtT4/vg6+zOSUzF9buq8F3vZJ3fY196yyyU/1+wP5IyHk
 KETaP4uUj2GWJa2dzzWO79YAJKydH1mwPhOZJoRXohy2Kb+wJUyyCqkmgHFp9BySMk/I
 HHTLALMJOgGG2urzh0bYIMxmBYijvApw7sXhjEsYDmfSNC2FbE2nvZ06G0Xqz1ay5kRW
 rQlg==
X-Gm-Message-State: AOJu0Ywx8Ir7NT5Rsg8DeQjGooXsyzLwGMFvAxI2Zz43XNZo5VubCsUj
 AjBtuMkYS7J5hb+b64G4egd9oTRtXeW+SIJqrYYoLqd0vMrvOUp+bJ2vzMh3EtnugIFb1fWZDs6
 pedbO018=
X-Gm-Gg: ASbGncsK0N+T8rsmkcevUHDYmYzoywbWWRU+3ZR6067ZsARwmEys0LAEndNVVdm8Dvp
 q3aSylelZiH1RIAQ2qO6FEDEu/diI+Y6crrrpJ9UvuwinuJLUcTPIyAm2vxTXThD7ZRJinX0HUj
 4EHqOIv0//VuTgFzk33XCRVmcKlzk0Bzi/B8B1BzTXOWdQ1fCP3Fz6mbhxVBNiQnuFEeKkfg/TP
 AkJX7hPCz312x+IsRd40ixpNoFTACmWkvZzRZRN8ziAMW6mjd2Jm2+yuUy8KMGGD8934lyIa5qX
 zkHsO0kSBokkriwpzriiCNdFXznh6ghnz8jtm40P04+8ELdIIcI7+43ucKWhRJMp723wJQQaz/0
 lMJ1Z4aMsM81dxz64Hg8AZTuCB+o8QpkMUrsJrNb2L4fHmaUExYsL
X-Google-Smtp-Source: AGHT+IHUjT25cL6Ye+/M0/xL7jrZC0CxZBcZW1JxH5z4bA9UDvkCc9HvscfT/H/a7OKRNzVEhfv+wQ==
X-Received: by 2002:a17:902:cec2:b0:244:9912:8353 with SMTP id
 d9443c01a7336-2463292c8a8mr32673245ad.6.1755854701081; 
 Fri, 22 Aug 2025 02:25:01 -0700 (PDT)
Received: from warg.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed4c6fb7sm78560215ad.89.2025.08.22.02.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 02:25:00 -0700 (PDT)
From: CJ Chen <cjchen@igel.co.jp>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Tomoyuki Hirose <hrstmyk811m@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, CJ Chen <cjchen@igel.co.jp>
Subject: [RFC PATCH v2 0/9] support unaligned access to xHCI Capability
Date: Fri, 22 Aug 2025 18:24:01 +0900
Message-Id: <20250822092410.25833-1-cjchen@igel.co.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=cjchen@igel.co.jp; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 22 Aug 2025 09:53:58 -0400
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

This patch set aims to support unaligned access to xHCI Capability
Registers.

To achieve this, we introduce the emulation of an unaligned access
through multiple aligned accesses. This patch set also adds a test
device and several tests using this device to verify that the
emulation functions correctly.

Using these changes, unaligned access to xHCI Capability Registers is
now supported.

During development, I required a lot of 'MemoryRegionOps' structs with
its own read/write functions for tests. In the QEMU project, a large
number of similar functions or structs are often written in '.inc'
files. I followed this approach for the test functions but would
appreciate feedback on whether this is appropriate.

---
v1 ... v2:
   - Fix the typo of ops size of big-l-valid.
   - Replaced the huge macro blocks with dynamic loops that fill in
     the `MemoryRegionOps` arrays at runtime.
   - Remove test cases valid.unaligned = false,impl.unaligned = true.
   - Modification to the memory document about the alignment issue.
   - Update the npcm7xx_fiu, mx_pic and risc-v-iommu configuration 
     to align with the unaligned-access policy.
   - Document memory.rst clarify that .valid=true,.impl=false causes
     split unaligned accesses (may have side effects); forbid 
	 .valid=false,.impl=true via assertion.

---
 CJ Chen (4):
  doc/devel/memory.rst: additional explanation for unaligned access
  hw/riscv: iommu-trap: remove .impl.unaligned = true
  hw: npcm7xx_fiu and mx_pic change .impl.unaligned = true
  system/memory: assert on invalid unaligned combo

Tomoyuki Hirose (5):
  hw/nvme/ctrl: specify the 'valid' field in MemoryRegionOps
  system/memory: support unaligned access
  hw/usb/hcd-xhci: allow unaligned access to Capability Registers
  hw/misc: add test device for memory access
  tests/qtest: add test for memory region access

 docs/devel/memory.rst               |  18 +
 hw/misc/Kconfig                     |   4 +
 hw/misc/memaccess-testdev.c         | 331 +++++++++++++++
 hw/misc/meson.build                 |   1 +
 hw/nvme/ctrl.c                      |   5 +
 hw/riscv/riscv-iommu.c              |   1 -
 hw/ssi/npcm7xx_fiu.c                |   3 +
 hw/usb/hcd-xhci.c                   |   4 +-
 hw/xtensa/mx_pic.c                  |   3 +
 include/hw/misc/memaccess-testdev.h | 104 +++++
 system/memory.c                     | 148 +++++--
 system/physmem.c                    |   8 -
 tests/qtest/memaccess-test.c        | 597 ++++++++++++++++++++++++++++
 tests/qtest/meson.build             |   9 +
 14 files changed, 1198 insertions(+), 38 deletions(-)
 create mode 100644 hw/misc/memaccess-testdev.c
 create mode 100644 include/hw/misc/memaccess-testdev.h
 create mode 100644 tests/qtest/memaccess-test.c

base-commit: 5836af0783213b9355a6bbf85d9e6bc4c9c9363f
-- 
2.25.1

