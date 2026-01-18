Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FE2C9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 19:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhYYR-0004vL-Gg; Sun, 18 Jan 2026 14:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYYO-0004mT-Sd
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:35:16 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYYN-0006d7-26
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:35:16 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4801c1ad878so25059605e9.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 11:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768764911; x=1769369711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nMgiWyUDUOdG6oaxZYP55DFYfWYeLUmeEbvA/za/UiI=;
 b=BwawXdJJ1lr6fcPRA9a5CEsxFqlH/vPYIdPQ2l2baHKVlx0d63pIZyZm2yqyFYB1Sw
 66RsJk4mVrbZoXIpKmTCozmk46zhUiwS+ugaSNme7UDyHJdvwKehoJ/IAhBfBGyfFwOy
 700bZxN9D8PlUGiEARKg6ZpSkA7A+oAIZecS4uqN01VWiY3zF3f32TTMXd/MGUOpnZJt
 /Ycn7Q6V/cnVfBwrQyykt8UYMhJRXqlRLrpOXL9HFS4R6qjiIr5OcPQrP3bEV/0h3xrW
 xBcL3JhKqbd+r9LT5MHwEIT9xR2qQTl2cySADoSbGyL7c83NQXl/5E0pzs1FN1p9+WTq
 y5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768764911; x=1769369711;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nMgiWyUDUOdG6oaxZYP55DFYfWYeLUmeEbvA/za/UiI=;
 b=SiVQUtz0J7A96ADmbbX3SLKBGBA32C1IWI8RS9kelgi4U/kS/t23nSX2iflXpHvP2a
 npjQDGRpLNn3OJX4Fw34cMyYJzUx8Iuv18W0xcPGiZjhGLTyBNQpkoDNeeyIxn/cXHlU
 hjOhYE/A64u4JIicjB+aDfXLZHWRyRNSQAYkKsSp64WPqYfONlDh/wu+Z/iUa7t5GGR2
 h0cEKDv2q49yFDzTrR/guelWmWG6xAyFUyYe2JQI7SG/QPDjdsnySBAfj++X5DA4jveK
 wEMgjyFuR33vsgQoVEWPaq7roCIFK3h7h2tDs+GyQuNKBx/+jLt9L3oWe9aMM/kbcfHX
 t/gA==
X-Gm-Message-State: AOJu0YwIxy4wOxMkYvat1nI268+uupqZkSGaLMnWCLnKPflbGV19LoLV
 LGX26TnAOj7EjIekxX3Dw4pbeZclbz5fK8ivmrARuDM3M05ibHDKChcGoYXfuRCW+AYMFwlpu17
 zOE37x7M=
X-Gm-Gg: AY/fxX7m6EFnqxT18UEyUA6xMP2KVa43Uz4gXYfL/cn1GiTZPTPpRDVO2m/pms/ZWiN
 ErniXPh30FCAZpSIOTIXK4GrF7zxvSpozpIUnDzVDXVeq7+UO7sRcfLFVr9FrtUiMhYVD5cvdWa
 EWwdjraa7v+lpBChMfIZnyFJ9l0QnSKb+vO/OB2ipsE/Fhm643r5UJc4MtgOqqhKFABehUefOFC
 A/UZAtec6kBvfmiCtSjs/yYfc/edqIMTzHlU0Y3Lb8fvq82RWN1b+kMUPnHqdsTPIbNPYRItNGX
 EeUT/RZC8SJ1c4Ld+yCdTfxITMvgrwnNKax9JpYUtnK/VXHjr1JQkEioYW5dM7C6sh5ufGP/jq+
 SSQL0c8As+Wc6bYNbF/wEk9S0HXk39j+LUY8WMRvWjXnKlEXf47l7ZzkrVB+6gZZV5yuO51uQ1i
 njWFd61BlJPRJEj4aJTYhTJie8yJb6nGMed2XVQAhLeIb66BLQsjbZcWUVv2lJebvH7INA+6g=
X-Received: by 2002:a05:600c:3114:b0:46e:4a30:2b0f with SMTP id
 5b1f17b1804b1-4801e348326mr114701965e9.29.1768764911379; 
 Sun, 18 Jan 2026 11:35:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569926ff1sm18290453f8f.13.2026.01.18.11.35.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Jan 2026 11:35:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 00/18] system/memory: Clean ups around address_space_ldst()
 endian variants
Date: Sun, 18 Jan 2026 20:34:50 +0100
Message-ID: <20260118193509.42923-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Missing review: 1-4

Since v5:
- No pointer arithmetic in ld/st[M] (Richard)
- Inline (Paolo)

Since v4:
- No change (RESEND)

Since v3:
- Assign device_endian enums (Richard)
- Add/use ldm_p() and stm_p() helpers (Paolo)

Since v2:
- Changed opt-out to opt-in approach (Pierrick)
- Split big patches in smaller ones
- Mark ioport little-endian

Philippe Mathieu-Daudé (18):
  bswap: Include missing 'qemu/bswap.h' header
  bswap: Use 'qemu/bswap.h' instead of 'qemu/host-utils.h'
  bswap: Remove unnecessary 'qemu/bswap.h'
  system/memory: Introduce ldm_p() and stm_p() load/store helpers
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

 MAINTAINERS                                  |   1 +
 block/qcow2.h                                |   1 +
 include/accel/tcg/cpu-ldst.h                 |   2 +
 include/exec/memop.h                         |   4 +
 include/exec/translator.h                    |   5 +-
 include/exec/tswap.h                         |   3 +
 include/qemu/bswap.h                         |  72 +++
 include/qemu/host-utils.h                    |   1 -
 include/qemu/int128.h                        |   2 -
 include/system/memory.h                      |   8 +-
 include/system/memory_cached.h               |   2 +
 system/memory-internal.h                     |   2 +
 include/system/memory_ldst.h.inc             |  52 +--
 include/system/memory_ldst_endian.h.inc      |  33 ++
 include/system/memory_ldst_phys.h.inc        | 113 +----
 include/system/memory_ldst_phys_endian.h.inc |  57 +++
 audio/audio.c                                |   1 +
 block/blklogwrites.c                         |   1 +
 block/export/vduse-blk.c                     |   1 +
 block/export/vhost-user-blk-server.c         |   1 +
 block/export/virtio-blk-handler.c            |   1 +
 block/parallels-ext.c                        |   1 +
 hw/9pfs/9p-local.c                           |   1 +
 hw/block/cdrom.c                             |   1 +
 hw/block/hd-geometry.c                       |   1 +
 hw/net/can/ctucan_core.c                     |   1 +
 hw/nvram/xlnx-efuse.c                        |   1 +
 hw/scsi/scsi-generic.c                       |   1 +
 hw/sd/sd.c                                   |   1 +
 hw/sd/ssi-sd.c                               |   1 +
 net/l2tpv3.c                                 |   1 +
 qga/commands-linux.c                         |   1 +
 scsi/pr-manager-helper.c                     |   1 +
 target/arm/tcg/arith_helper.c                |   1 +
 tests/qtest/acpi-utils.c                     |   1 +
 tests/qtest/ahci-test.c                      |   2 +-
 tests/qtest/aspeed-hace-utils.c              |   1 +
 tests/qtest/bios-tables-test.c               |   1 +
 tests/qtest/libqos/ahci.c                    |   2 +-
 tests/qtest/libqos/generic-pcihost.c         |   2 +-
 tests/qtest/libqos/igb.c                     |   1 +
 tests/qtest/libqos/pci-spapr.c               |   2 +-
 tests/qtest/libqos/virtio-9p-client.c        |   1 +
 tests/qtest/migration/framework.c            |   1 +
 tests/qtest/npcm7xx_emc-test.c               |   1 +
 tests/qtest/tpm-emu.c                        |   1 +
 tests/qtest/ufs-test.c                       |   1 +
 tests/qtest/vmgenid-test.c                   |   1 +
 tests/unit/test-hbitmap.c                    |   1 +
 util/bitmap.c                                |   1 +
 util/hbitmap.c                               |   2 +-
 system/memory_ldst.c.inc                     | 449 ++-----------------
 system/memory_ldst_endian.c.inc              |  70 +++
 scripts/make-config-poison.sh                |   1 +
 54 files changed, 354 insertions(+), 564 deletions(-)
 create mode 100644 include/system/memory_ldst_endian.h.inc
 create mode 100644 include/system/memory_ldst_phys_endian.h.inc
 create mode 100644 system/memory_ldst_endian.c.inc

-- 
2.52.0


