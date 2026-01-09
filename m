Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2070AD26D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFhe-0003uT-Qr; Fri, 09 Jan 2026 11:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFhZ-0003qK-0U
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:51:06 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFhW-0007Jm-3Z
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:51:04 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so34586075e9.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977460; x=1768582260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=78C1LLAN4fET5py2UkBPhyucbELmzRhuV8l/eYg2Oyc=;
 b=jYfBX379+O/J/Geh8nLZZVKZpnFW7fzMQXkbW/ANcpT2U6EZtjw8tYhEw3PpijC1tk
 r+HU2dBrd9ok7tVvWYKm1zPwfRkxNNYnGeDwNK9uV8M90DvWMdoUw/haaWsscmVQkGD2
 R0ELUw1gA0d2O+2OtPSRB8Gvdh5Mgo4vJmq9lLO/TeWbF0MqFovuOoExsov2FrffGCSQ
 gbLaAfuHjT+m84s61Kv/OYl8aq+H/19Lm83UhvNlnvEiA6x1578FQ32tYVaazg9xN7Sc
 77uHXI3K8RhaetD56WX6exazyWCTYvS0hDANBWofLUFxLZ7bOmO7+RcwU+6lqDiaYL7S
 Digg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977460; x=1768582260;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=78C1LLAN4fET5py2UkBPhyucbELmzRhuV8l/eYg2Oyc=;
 b=XOg9UQy8YOV/AD+i4CnuaqkAsvXsm5z5umr3AzYIFWrWzIvcKideeS8U4R71LznjlH
 fblroPpPxoN03c2NpsnbXtOdXcIH+h4d4WLoXtGWzJWWGiAZiz/nMEHkmvE3X7gjDZ4B
 xkF8hl76biPJlqJSwYw5wnP2Wpjg8twr44fbyOlo793MiXSvdGE/pxuZ2E19iddAIMMJ
 G0ZYxTpsb7ZTrxd47L/0WqAqIRmiaDdNHiz8OrescMBvqay/vOTLdoP0acV1a4nzn/h+
 VmzJ/5UyWbHgLKEiHcbu6q2Sh//Ilcjs0DAjki/rhg/uXvCN6wfFvaEQXEdJJgZQlDAe
 e/LA==
X-Gm-Message-State: AOJu0YzbvxJjKDJh/fiK/GSMQeJVOZKBBdT7408SFDx4T+6M7QW5SDZs
 atjhpNoTH7EDQqmKm/M1bimuTwHnXiYLSECk8lm1iLk4LmzFL29103VuP5U6Rqn1aeCdjnmFOxe
 ecIyPekg=
X-Gm-Gg: AY/fxX5FBwe3fuajTL/VRXL+U+N/eeLdVUooBNiwBO8qtB3InPEJBHAoyb+8C8VcRLr
 loc1TUCnhq6HgmFdG3S7wVqzpMRrruL5O1AvqoFMGhIVpb0wLcW7X3Tv3XzfB5zQwkDtToZ/crg
 U2orlDUMZ2/75m99r+8qi4rR2CZzBIwLUpYUfv3SVJCbs8zbTgJt+g7AD1/2xvwyrHVs+pLeMka
 egjD7iFejalZVXXZ8UBZypI8+mEVAMxwr0Ok9wZecc5EQrCKzGkV9mY3pHkTvAFovxVL0YNH+WA
 s6wyKL6LS3wuORnzF9Cpqd0bAZAvGJVcmQG4tzIVZR8XVJCoV6srq+8hBoRXp6Q1C7NdE709C6b
 qdWpzJC+wHPKHWRTF50PcJr7Z+u9PMPp3tNAdOwL3QQazxF1CXIOwdA5XIVa5xcyYZKv36o2iT0
 YxiH5RZWFei39fVNsGSq2bxEVGpu7cxlLV+vtrEC92goGy7Q7ftFA+wQqFLi0W
X-Google-Smtp-Source: AGHT+IHY+9uEbzVPbNVpf4EhM3Yh1Ru4TBdp1E2O9Q5XdzDY9pKTXmvLUM92lXTmPh9w5Xpgq1M5fw==
X-Received: by 2002:a05:600c:4fc6:b0:477:7b9a:bb0a with SMTP id
 5b1f17b1804b1-47d84b54c52mr120354305e9.21.1767977459940; 
 Fri, 09 Jan 2026 08:50:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f653cd6sm228587875e9.9.2026.01.09.08.50.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:50:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v5 00/22] system/memory: Clean ups around address_space_ldst()
 endian variants
Date: Fri,  9 Jan 2026 17:50:36 +0100
Message-ID: <20260109165058.59144-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Missing review: 2, 12, 20

Since v4:
- No change (RESEND)

Since v3:
- Assign device_endian enums (Richard)
- Add/use ldm_p() and stm_p() helpers (Paolo)

Since v2:
- Changed opt-out to opt-in approach (Pierrick)
- Split big patches in smaller ones
- Mark ioport little-endian

Philippe Mathieu-Daudé (22):
  MAINTAINERS: Cover 'system/memory_ldst*.h.inc' files
  util: Introduce ldm_p() and stm_p() load/store helpers
  system/physmem: Inline and remove leul_to_cpu()
  system/physmem: Convert DEBUG_SUBPAGE printf() to trace events
  system/memory: Split MemoryRegionCache API to 'memory_cached.h'
  system/memory: Inline address_space_stq_internal()
  system/memory: Define address_space_ldst[W] endian variants via
    template
  system/memory: Define address_space_ldst[L] endian variants via
    template
  system/memory: Define address_space_ldst[Q] endian variants via
    template
  system/memory: Factor address_space_ldst[M]_internal() helper out
  system/memory: Pass device_endian argument as MemOp bit
  system/memory: Use ldm_p() and stm_p() helpers
  system/memory: Directly call address_space_ldst[M]_internal() helper
  system: Allow restricting the legacy ld/st_phys() 'native-endian' API
  system: Allow restricting legacy address_space_ldst() native-endian
    API
  system: Allow restricting the legacy cpu_ld/st() 'native-endian' API
  system: Allow restricting the legacy translator_ld() 'native-endian'
    API
  system: Allow restricting the legacy tswap() 'native-endian' API
  system: Allow restricting the legacy MO_TE* 'native-endian'
    definitions
  system: Allow restricting the legacy DEVICE_NATIVE_ENDIAN definition
  system/ioport: Declare x86-specific I/O port in little-endian order
  system/ioport: Do not open-code address_space_ld/st_le() methods

 MAINTAINERS                                  |   4 +
 include/accel/tcg/cpu-ldst.h                 |   2 +
 include/exec/memop.h                         |   4 +
 include/exec/translator.h                    |   5 +-
 include/exec/tswap.h                         |   3 +
 include/hw/virtio/virtio-access.h            |   1 +
 include/qemu/bswap.h                         |  11 -
 include/qemu/ldst_unaligned.h                |  25 ++
 include/system/memory.h                      | 193 +-------
 include/system/memory_cached.h               | 212 +++++++++
 system/memory-internal.h                     |   2 +
 include/system/memory_ldst.h.inc             |  52 +--
 include/system/memory_ldst_endian.h.inc      |  33 ++
 include/system/memory_ldst_phys.h.inc        | 113 +----
 include/system/memory_ldst_phys_endian.h.inc |  57 +++
 system/ioport.c                              |  34 +-
 system/physmem.c                             |  35 +-
 tests/qtest/endianness-test.c                |  10 +-
 tests/qtest/libqtest.c                       |  13 +-
 util/ldst.c                                  |  69 +++
 system/memory_ldst.c.inc                     | 449 ++-----------------
 system/memory_ldst_endian.c.inc              |  70 +++
 scripts/make-config-poison.sh                |   1 +
 system/trace-events                          |   6 +
 util/meson.build                             |   1 +
 25 files changed, 599 insertions(+), 806 deletions(-)
 create mode 100644 include/system/memory_cached.h
 create mode 100644 include/system/memory_ldst_endian.h.inc
 create mode 100644 include/system/memory_ldst_phys_endian.h.inc
 create mode 100644 util/ldst.c
 create mode 100644 system/memory_ldst_endian.c.inc

-- 
2.52.0


