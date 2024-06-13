Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE599C27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 14:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHlIQ-0000Be-1w; Thu, 13 Jun 2024 10:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sHlIN-0000AY-VW
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 10:19:19 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sHlIK-0003b4-OZ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 10:19:19 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f7274a453bso10271615ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 07:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718288354; x=1718893154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XrZJcuVby9mT0DspCd70zcrTTL6fcP3HwPrTAjjGrrA=;
 b=bQeUNg32bN3t/HCsd9ZZ9QHNCwyBU14zqG3gCMxXVPPuj4bYxiFxv2eOv1oIAzNLVQ
 kO1vGe7OtWE5RkuYhaoTTq6OLJQaMlDmJgPpy0skOoDADsO7PtDERHNpUNGFaxvBVmz0
 Dph6gENXjOLkcmuekhPvLdbCzl98WUwQMWE4M31DwPvoY1nDQSBzo0FVlKqhFbgrCt24
 zFWruwPoJfs5I9WFy8IbGPpiFB1aq4kL0mqadP9PsSY2WS8f/NsVxOoARs6U9HYbrnoT
 KkidOyp0B6uZVtPOOdanVFw+sq0VRmUDQ+pRCgsbkXKbUsI+IphEsaf8d+LZI8piXJSt
 PeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718288354; x=1718893154;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XrZJcuVby9mT0DspCd70zcrTTL6fcP3HwPrTAjjGrrA=;
 b=sqpxw6G6V+MHWEwltHqatO5gPdsJDYvBXwQ9LN9es0P1ZN3jk0lLnlU0vXd13F473P
 gh843okN+OOq/b67OLW4fHcrgC0wAXbNAAVpWNL0NJERiRJm0W30mtT73peeZYkRdPrY
 8zkpCHuvVFLDYII9fC4/w0QTLWtVzxuhQ4zoLmp2/hlgB1GRCpDG8LUyrvc8yQoix/6z
 0V3UjF2YkKqOXmZRLKNfP9sa2WuBYliZtdI8/I8mIhM1ZXX+lZbvIM+F/LGQlNtzEdK6
 GqU/d0qie3zUKjJ931jVpMOjMMyEt281unUlMJmQ9zYybxhwyEZOjWSJLa9HNuzK6/yO
 fT7w==
X-Gm-Message-State: AOJu0YxQFlMM1xh+ojaSVrKZU1EgPlplVtVnf1GZVzoK+GLTqReUjXTn
 +idqALOkPajsPWnEwaW5ozmxrN4V7M4J0a4QCM34S3cDkze7kDAPdbmf82o2qfcGFjzILckao9w
 MBxB6/YSfv0AuZGb2q/1eds4aCs4dGzKLZCEWpuq8pStcMCziGR5W4HEF/cj7WuNK+7NE87ZX7H
 Owfr59gkgN51F+2vkZGBSure1TlQugW7R4/anvKQ==
X-Google-Smtp-Source: AGHT+IHmek3dvMtghxVxYjEbluB9HmKsk4BPUpK1jo+rGPEQ9smi9h4Zt+DzdaJSgRnKOhSL1n3ohg==
X-Received: by 2002:a17:902:db11:b0:1f7:3042:9727 with SMTP id
 d9443c01a7336-1f83b522f7emr54417625ad.4.1718288354010; 
 Thu, 13 Jun 2024 07:19:14 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855f2fe6dsm14386975ad.257.2024.06.13.07.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 07:19:13 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH v3 0/5] Improve the performance of RISC-V vector
 unit-stride/whole register ld/st instructions
Date: Thu, 13 Jun 2024 22:19:01 +0800
Message-Id: <20240613141906.1276105-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi,

This RFC patch set tries to fix the issue of
https://gitlab.com/qemu-project/qemu/-/issues/2137.

In this new version, we added patches that
1. Provide a fast path to direct access the host ram for some vector
   load/store instructions (e.g. unmasked vector unit-stride load/store
   instructions) and perform virtual address resolution once for the
   entire vector at beginning of helper function. (Thanks for Richard
   Henderson's suggestion)
2. Replace the group elements load/store TCG ops by the group element
   load/store flow in helper functions with some assumption (e.g. no
   masking, continuous memory load/store, the endian of host and guest
   architecture are the same). (Thanks for Richard Henderson's
   suggestion)
3. Try inline the vector load/store related functions that corresponding
   most of the execution time.

This version can improve the performance of the test case provided in
https://gitlab.com/qemu-project/qemu/-/issues/2137#note_1757501369
- QEMU user mode (vlen=512): from ~51.8 sec. to ~4.5 sec.
- QEMU system mode (vlen=512): from ~125.6 sec to ~6.6 sec.

Series based on riscv-to-apply.next branch (commit d82f37f).

Changes from v2:
- Drop v2 patches 1/4/5/6
- patch 2
    - Provide direct access host ram flow for vector unit-stride ld/st
- patch 3
    - Provide direct access host ram flow for vector whole reg ld/st
- patch 4
    - Provide group element load/store flow for vector continuous ld/st
- patch 5
    - Extend v2 patch 3 to more vector ld/st functions

Previous version:
- v1: https://lore.kernel.org/all/20240215192823.729209-1-max.chou@sifive.com/
- v2: https://lore.kernel.org/all/20240531174504.281461-1-max.chou@sifive.com/

Max Chou (5):
  accel/tcg: Avoid unnecessary call overhead from
    qemu_plugin_vcpu_mem_cb
  target/riscv: rvv: Provide a fast path using direct access to host ram
    for unmasked unit-stride load/store
  target/riscv: rvv: Provide a fast path using direct access to host ram
    for unit-stride whole register load/store
  target/riscv: rvv: Provide group continuous ld/st flow for unit-stride
    ld/st instructions
  target/riscv: Inline unit-stride ld/st and corresponding functions for
    performance

 accel/tcg/ldst_common.c.inc             |   8 +-
 target/riscv/insn_trans/trans_rvv.c.inc |   3 +
 target/riscv/vector_helper.c            | 847 +++++++++++++++++++-----
 target/riscv/vector_internals.h         |  48 ++
 4 files changed, 738 insertions(+), 168 deletions(-)

-- 
2.34.1


