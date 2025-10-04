Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF6DCCA472
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wSD-0003T1-Li; Sat, 04 Oct 2025 03:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wSD-0003Sk-0O
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:13:17 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wS8-0004rz-JR
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:13:16 -0400
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-3f44000626bso1835255f8f.3
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759561990; x=1760166790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=W01qdny4MY5IbBZwA2z0pOSCWsh0+a7JCMFgcrlOlGo=;
 b=B1LB+QiG81s+94Kf3jQoIvN7SooP8XMdiQkZu1TTYLv+ANylAZTUZ3OPSwK3rY7Utg
 hvNMU8090jrhznKDxR0STeeAVEH1lNRA7bS5vstjgMwX1C7E8nVOZ5qcUga70bMZUWmz
 34cw99gYKHluD4QurKmZvGe+3ln+MOoqBfSXaIpie5V2uHFAWKj5GPfs61GLWYv1Fn4N
 2t+gBkIYLVjSZhcl0Mi5Wz5AVxiKN5/dykO5TIYtyNe2qFPPqWtwS0Qe8nAlbQ5NUG7+
 aoPTBotlplsWaneAG7qfKUE2awc535iunQB9H2bZFw5gY22Ph0wZnwmT9WxVBGxJzeH3
 vXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759561990; x=1760166790;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W01qdny4MY5IbBZwA2z0pOSCWsh0+a7JCMFgcrlOlGo=;
 b=BITkarBdjHxX2cLsPuSvVDjl7fTmuTqr7sjrggvst/+IldboG7l8FdhUDDrwZhhgUd
 +CU6ejYYzhbp4OtPx7yaeFa8FG0MqpaLyz8BI7T9uECqbZ7Wg57nWjVuZwgYIbFrJnEP
 0X+Pi24ZcmxhSA7Z+Kytf9zZWqch2YN+3qskm82Fl540T8KU5Etm4UghscgxkSYevwIp
 UZzJBF4DMYEcjPSoCZz9JSS/DqKqH5A6GnPVZyAPLk9UL8wHdi6sSGgKZ8/tRPOhZ8YF
 awj3pCJ55egV992y8DlUdTrXddnGfc62EpOEx8ZT5fqMiVaqc2Ir4EbpA3LDyImLBPjb
 sU4Q==
X-Gm-Message-State: AOJu0YwWzzQCNeK4x9U08YRrwoysCo3XMhWTDM9C5duNmh1mU8bOaUFN
 W9W3hCR3TbqEu4t+G9nhyeanbuxoou6w2KgHTXpc5+U5j7QRcOWKAFAVnaklqQ1r2DMjT6SLd8z
 nnbZf7HXhpBig
X-Gm-Gg: ASbGncuU83gcI9LdNw9Mcas3XD7M2UB8umiWRgNbHyHxsA6DeoikAEfRYlVlLQvUSJz
 G4Ll9nvHg519Bv0vsgzg60QJOt/Hv0gxYfVbEAnD5R9FBbXAZgvHmeyrEH2i8mltVBonwB//xbd
 +yFWPfi2+I8JVI6HOwghk75gWEapwbu8Ut8qpVNILKBc3bFCOCieMpYbjAUpl+CzCLWhgYDaoBd
 RkUfSCEghef6bxpq/hMoFkZrTwnaczJYdr6uOQ+ySfljUseoNxWopryOHoodCrcsT61/ZUU5gyq
 XGHtPvDmkP/BIfxfLjUCDOglt2Tn8kQR9IGBwfA+qmyrYzB3B79r88TaQR0YwipMWSPP3iQmOrl
 6loymjqwpm2E5iRDCU0G3Zt+FoVCEEoTO4u/I3FM/+qIViWm5OcI5BMHSRWUNYmPVO4hyaVp4h3
 wOIdOD5dEI9E5AzZdlRX4eYAhBonm17cXGRSA=
X-Google-Smtp-Source: AGHT+IFOitx4OR1wqlMgvTiHvb4AgZBYaRvpVcS1zMW1CU8yPhyJQz2Ehb409zOwP1fO8AYRbZ0hqA==
X-Received: by 2002:a05:6000:2dc3:b0:425:58d0:483b with SMTP id
 ffacd0b85a97d-425671ab837mr3626865f8f.45.1759561989504; 
 Sat, 04 Oct 2025 00:13:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f02a8sm11194933f8f.39.2025.10.04.00.13.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:13:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/41] Memory patches for 2025-10-04
Date: Sat,  4 Oct 2025 09:12:26 +0200
Message-ID: <20251004071307.37521-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x444.google.com
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

The following changes since commit 81e3121bef89bcd3ccb261899e5a36246199065d:

  Merge tag 'pull-vfio-20251003' of https://github.com/legoater/qemu into staging (2025-10-03 04:57:58 -0700)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/physmem-20251004

for you to fetch changes up to 56824af2724f1b6c1e6bf6190bc63682be68e3ea:

  system/physmem: Extract API out of 'system/ram_addr.h' header (2025-10-03 22:48:31 +0200)

----------------------------------------------------------------
Memory patches

- Cleanups on RAMBlock API
- Cleanups on Physical Memory API
- Remove cpu_physical_memory_is_io()
- Remove cpu_physical_memory_rw()
- Legacy conversion [cpu_physical_memory -> address_space]_[un]map()

----------------------------------------------------------------

Philippe Mathieu-Daudé (40):
  system/ramblock: Remove obsolete comment
  system/ramblock: Move ram_block_is_pmem() declaration
  system/ramblock: Move ram_block_discard_*_range() declarations
  system/ramblock: Rename @start -> @offset in ram_block_discard_range()
  system/ramblock: Move RAMBlock helpers out of "system/ram_addr.h"
  docs/devel/loads-stores: Stop mentioning
    cpu_physical_memory_write_rom()
  system/memory: Factor address_space_is_io() out
  target/i386/arch_memory_mapping: Use address_space_memory_is_io()
  hw/s390x/sclp: Use address_space_memory_is_io() in sclp_service_call()
  system/physmem: Remove cpu_physical_memory_is_io()
  system/physmem: Pass address space argument to
    cpu_flush_icache_range()
  hw/s390x/sclp: Replace [cpu_physical_memory -> address_space]_r/w()
  target/s390x/mmu: Replace [cpu_physical_memory -> address_space]_rw()
  target/i386/whpx: Replace legacy cpu_physical_memory_rw() call
  target/i386/kvm: Replace legacy cpu_physical_memory_rw() call
  target/i386/nvmm: Inline cpu_physical_memory_rw() in nvmm_mem_callback
  hw/xen/hvm: Inline cpu_physical_memory_rw() in rw_phys_req_item()
  system/physmem: Un-inline cpu_physical_memory_read/write()
  system/physmem: Avoid cpu_physical_memory_rw when is_write is constant
  system/physmem: Remove legacy cpu_physical_memory_rw()
  hw/virtio/vhost: Replace legacy cpu_physical_memory_*map() calls
  hw/virtio/virtio: Replace legacy cpu_physical_memory_map() call
  system/ram_addr: Remove unnecessary 'exec/cpu-common.h' header
  accel/kvm: Include missing 'exec/target_page.h' header
  hw/s390x/s390-stattrib: Include missing 'exec/target_page.h' header
  hw/vfio/listener: Include missing 'exec/target_page.h' header
  target/arm/tcg/mte: Include missing 'exec/target_page.h' header
  hw: Remove unnecessary 'system/ram_addr.h' header
  system/physmem: Un-inline cpu_physical_memory_get_dirty_flag()
  system/physmem: Un-inline cpu_physical_memory_is_clean()
  system/physmem: Un-inline cpu_physical_memory_range_includes_clean()
  system/physmem: Un-inline cpu_physical_memory_set_dirty_flag()
  system/physmem: Un-inline cpu_physical_memory_set_dirty_range()
  system/physmem: Remove _WIN32 #ifdef'ry
  system/physmem: Un-inline cpu_physical_memory_set_dirty_lebitmap()
  system/physmem: Un-inline cpu_physical_memory_dirty_bits_cleared()
  system/physmem: Reduce cpu_physical_memory_clear_dirty_range() scope
  system/physmem: Reduce cpu_physical_memory_sync_dirty_bitmap() scope
  system/physmem: Drop 'cpu_' prefix in Physical Memory API
  system/physmem: Extract API out of 'system/ram_addr.h' header

Richard Henderson (1):
  system/memory: Split address_space_write_rom_internal

 MAINTAINERS                               |   1 +
 docs/devel/loads-stores.rst               |   6 +-
 scripts/coccinelle/exec_rw_const.cocci    |  22 -
 include/exec/cpu-common.h                 |  21 +-
 include/system/memory.h                   |  11 +
 include/system/physmem.h                  |  54 +++
 include/system/ram_addr.h                 | 426 -------------------
 include/system/ramblock.h                 |  27 +-
 accel/kvm/kvm-all.c                       |   6 +-
 accel/tcg/cputlb.c                        |  13 +-
 hw/core/loader.c                          |   2 +-
 hw/hyperv/hv-balloon-our_range_memslots.c |   1 +
 hw/ppc/spapr.c                            |   1 -
 hw/ppc/spapr_caps.c                       |   1 -
 hw/ppc/spapr_pci.c                        |   1 -
 hw/remote/memory.c                        |   1 -
 hw/remote/proxy-memory-listener.c         |   1 -
 hw/s390x/s390-stattrib-kvm.c              |   2 +-
 hw/s390x/s390-stattrib.c                  |   2 +-
 hw/s390x/s390-virtio-ccw.c                |   1 -
 hw/s390x/sclp.c                           |  14 +-
 hw/vfio/container-legacy.c                |  10 +-
 hw/vfio/container.c                       |   5 +-
 hw/vfio/listener.c                        |   2 +-
 hw/vfio/spapr.c                           |   1 -
 hw/virtio/vhost.c                         |   7 +-
 hw/virtio/virtio-balloon.c                |   1 +
 hw/virtio/virtio-mem.c                    |   2 +-
 hw/virtio/virtio.c                        |  10 +-
 hw/xen/xen-hvm-common.c                   |   8 +-
 migration/ram.c                           |  81 +++-
 system/memory.c                           |   9 +-
 system/physmem.c                          | 475 +++++++++++++++++-----
 target/arm/tcg/mte_helper.c               |   5 +-
 target/i386/arch_memory_mapping.c         |  10 +-
 target/i386/kvm/xen-emu.c                 |   4 +-
 target/i386/nvmm/nvmm-all.c               |   5 +-
 target/i386/whpx/whpx-all.c               |   7 +-
 target/s390x/mmu_helper.c                 |   7 +-
 system/memory_ldst.c.inc                  |   2 +-
 tests/tsan/ignore.tsan                    |   4 +-
 41 files changed, 636 insertions(+), 633 deletions(-)
 create mode 100644 include/system/physmem.h

-- 
2.51.0


