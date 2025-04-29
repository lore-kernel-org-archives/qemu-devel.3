Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD5EC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ldY-0000Uz-BB; Tue, 29 Apr 2025 10:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9ldV-0000SD-Ql
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:08:37 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9ldQ-0006Cz-L2
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:08:36 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so5129347f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745935708; x=1746540508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NMgrt7qf+mTz64mF0k2M3faZPOSBMHHUP2XX6y47RqQ=;
 b=FlNZCKM4YJMoLfE8u2VqZMxB5jHci28Aot1dOvOnGcwONi8xsDq10wWFcAJU8prBhg
 OhgR9UP7GVefnBUOUTk3JCuqWKcuvIjKtG31xqKJhAqJfYr4PYkPGp3nWcVtTWDr4SJx
 wXFigRKIMrmRQ4p1sJvT7SfPt+oFvrSQR16yKssqHWQdY4O2ShsuZz+qlH4/vLjYFj1Z
 q361+4jaV5JaatBGZSjwuawFq0G0d/xzCXA0AkzZTZ9ENTilIwKVJK4sblp6nbNZKfkk
 /2EHuIMwSs5mOVYj9k2SNfPcC1Tm+bMJOMULsXD7ASXGp/xcPLgv/ud2SYRrkGuQPQ5r
 o9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745935708; x=1746540508;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NMgrt7qf+mTz64mF0k2M3faZPOSBMHHUP2XX6y47RqQ=;
 b=kxdF+M4XHmNG3HG5EttxOiY37VfNNByelnsYy6bvEieDerg2jy3bGfMro/+VIlGVhX
 6+i8S3cSreo6TC2GGwIsR995seZE8ZRf1NqsqdszjKJ22JZxSU/JXJROIttXVU24C/Us
 zpkiwEP6DF+63nrSova6FXm1tMI+1EX3Eba2M05ONScL39IYRjA4RWu75+6XCkhnKvIB
 t9M8bRnXKb27DCLG2fErf1/8ii0Z5nokfWewm1I90l45+wHv5SHQpO19kUO4FBWsWsqo
 RxjJzM1JHH/4P8C0zXlC6F0Zi+YpbgStujER56/Knx/ccvamsYjNUfm56qEb27Jj3SkA
 estg==
X-Gm-Message-State: AOJu0YyQSTc6OQ8C3/Ai4sg2gM6eyDhR31Hf7u5ADtVxhYoCGRnl3H/p
 omufL5/udPPUrJEXQ0HYjrx/No9Ed38TeikPi8yJZ2qfwrJHcjCQmA2IY1kUMaDt7UIeg5uNeRu
 T
X-Gm-Gg: ASbGnctcjDt60VMZLlUwq4hm47cX6KDE6BaZxMbvNqIa2Rr8LHci75M4xq/zEf88ohX
 Ybm2cj8y15nRKuh4mxQtcaWpeYR9o5a5aAlQIfzyW8nUHLFvAI2/I5BkmzaEF82VFmPDuPCndz3
 48B+jLNpwo2yGcJuNzIeD56QObOuDbASy1ZkjddzBgNsd7jUvyLezp9h7UUuJFM3f21b34V83Vu
 Dac3GCmJOmloXQIBuh7eAOdn4w3mmixQ3KhXMG8xawUoL782DbI5TvomY43bBsF9X7x2obYjw6G
 MTJ+D92CQdka3YQko6ybyspAGRQ1EItNFB9iA9+XMh5QfQ9p1q/PQav0hlHbnw5CsYBIE4BDcdR
 07MaaVUGyMoagN9EI9GF7
X-Google-Smtp-Source: AGHT+IGFxs2sNSTZWoAGkRVMH9rfTVUt9x3dhynKDN5f1B1Rn83B5lo9q0j6p8VTYTfiTc7cBUFLVA==
X-Received: by 2002:a5d:5f4e:0:b0:3a0:7139:d16d with SMTP id
 ffacd0b85a97d-3a08ad3d188mr2225091f8f.23.1745935707474; 
 Tue, 29 Apr 2025 07:08:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e47307sm14195619f8f.65.2025.04.29.07.08.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 07:08:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/19] hw/i386/pc: Remove deprecated 2.4 and 2.5 PC machines
Date: Tue, 29 Apr 2025 16:08:06 +0200
Message-ID: <20250429140825.25964-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
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

Since v1:
- Fixed issues noticed by Thomas

The versioned 'pc' and 'q35' machines up to 2.12 been marked
as deprecated two releases ago, and are older than 6 years,
so according to our support policy we can remove them.

This series only includes the 2.4 and 2.5 machines removal,
as it is a big enough number of LoC removed. Rest will
follow. Highlight is the legacy fw_cfg API removal :)

Philippe Mathieu-Daudé (19):
  hw/i386/pc: Remove deprecated pc-q35-2.4 and pc-i440fx-2.4 machines
  hw/i386/pc: Remove PCMachineClass::broken_reserved_end field
  hw/i386/pc: Remove pc_compat_2_4[] array
  target/i386/cpu: Remove X86CPU::check_cpuid field
  hw/core/machine: Remove hw_compat_2_4[] array
  hw/net/e1000: Remove unused E1000_FLAG_MAC flag
  hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_MIGRATE_EXTRA definition
  hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_DISABLE_PCIE definition
  hw/i386/pc: Remove deprecated pc-q35-2.5 and pc-i440fx-2.5 machines
  hw/i386/x86: Remove X86MachineClass::save_tsc_khz field
  hw/nvram/fw_cfg: Remove legacy FW_CFG_ORDER_OVERRIDE
  hw/core/machine: Remove hw_compat_2_5[] array
  hw/block/fdc-isa: Remove 'fallback' property
  hw/scsi/vmw_pvscsi: Remove PVSCSI_COMPAT_OLD_PCI_CONFIGURATION
    definition
  hw/scsi/vmw_pvscsi: Remove PVSCSI_COMPAT_DISABLE_PCIE_BIT definition
  hw/scsi/vmw_pvscsi: Convert DeviceRealize -> InstanceInit
  hw/net/vmxnet3: Remove VMXNET3_COMPAT_FLAG_OLD_MSI_OFFSETS definition
  hw/net/vmxnet3: Remove VMXNET3_COMPAT_FLAG_DISABLE_PCIE definition
  hw/net/vmxnet3: Merge DeviceRealize in InstanceInit

 include/hw/boards.h            |   9 +--
 include/hw/i386/pc.h           |   7 ---
 include/hw/i386/x86.h          |   5 --
 include/hw/loader.h            |   2 -
 include/hw/nvram/fw_cfg.h      |  10 ---
 include/hw/virtio/virtio-pci.h |   8 ---
 target/i386/cpu.h              |   1 -
 hw/block/fdc-isa.c             |   4 +-
 hw/core/loader.c               |  14 -----
 hw/core/machine.c              |  18 ------
 hw/i386/pc.c                   |  42 ++-----------
 hw/i386/pc_piix.c              |  26 --------
 hw/i386/pc_q35.c               |  26 --------
 hw/i386/x86.c                  |   1 -
 hw/net/e1000.c                 |  72 +++++-----------------
 hw/net/vmxnet3.c               |  44 +++----------
 hw/nvram/fw_cfg.c              | 109 +++------------------------------
 hw/scsi/vmw_pvscsi.c           |  67 +++-----------------
 hw/virtio/virtio-pci.c         |  11 +---
 system/vl.c                    |   5 --
 target/i386/cpu.c              |   3 +-
 target/i386/machine.c          |   5 +-
 22 files changed, 51 insertions(+), 438 deletions(-)

-- 
2.47.1


