Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1F4C27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 09:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEmXa-0000iM-QX; Wed, 05 Jun 2024 05:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEmXY-0000hv-L0
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 05:02:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEmXW-0005lh-L5
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 05:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717578156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lvtzUrqViQnVa415iJWCgypL+zLlsW1PVD9sTk1VooM=;
 b=eI/FjRWhZVoUn2d+sau4ggNFVy3nRz7ONFDuDflRwLSv8NpCue9IpxJcx25wigBrKZv6/T
 YyqlsVUYkVgYLdmKysi9w80ZQqO8I3SB1ANKMaMunrSiYSl6OJG7bQJ/ZbkNM0m7rf8Z9r
 FaB3bCeZLakAglCPxkK/8t6o5IpSNZs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-f3PJB8xaN9uNt6gTAtQnOQ-1; Wed, 05 Jun 2024 05:02:35 -0400
X-MC-Unique: f3PJB8xaN9uNt6gTAtQnOQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6a4615420bso19879966b.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 02:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717578153; x=1718182953;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lvtzUrqViQnVa415iJWCgypL+zLlsW1PVD9sTk1VooM=;
 b=MITuKH8W/cvyo9j7bfA07kaGz16en82wPVeeicPoCoopSw4V5BdBAqKPqGMBWC7QKE
 BIPFEs9pYRJWUtUeTGF8DP+3z2MugT3IKDYofsAEHZPsUq44YgiIOfvrUaYYKvqGPEgk
 f6XYRUC1K5d+ugaUxmYZlS34NsPYvowyYTfQESw6xBxnPXwuszUSGZJmJJy2MQJYFwnG
 itlq1nB8swjxCT2lMVN0YvIExFI2UZfdTnX+j6lqeaiLPAFxprUhUxpZrjpwGYEw+A2Q
 XG9sXZmtdXlyLW9mJM2XguFciRIW5WT2GeG+kxpSY/8nRw3nio7CW0mJeDAwa59ndZ/C
 MD7Q==
X-Gm-Message-State: AOJu0YwrOOn+1OPWjuXPPGsVuyLrJolx5/ZDInzjnMnJISOqy2vWJhzD
 CGk7DLng//S0S5swwO1BkPnRm8K9tlYesekzLxxKPABFsf6aDT5gdIkZLfT7BdhYSmdwc/MTKev
 Xben9azx7T0ZJ+bO11in1uF2iFs3puDtE2tHrHx6iBTs/L67tIMsQAErgKimtIDjYG/mngL3bqn
 uBmVQonif+bo1GumQ74NWPI5LkonJei5l2hzsK
X-Received: by 2002:a17:906:3510:b0:a68:c672:b903 with SMTP id
 a640c23a62f3a-a699fe00edemr114137066b.53.1717578153251; 
 Wed, 05 Jun 2024 02:02:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0Syfrx8mMy/h2VLOevDOlw4vO6IeuTFHXQTRYE5eAXr4aQo+I3ms+9yuptIaJN2g1hsXTFw==
X-Received: by 2002:a17:906:3510:b0:a68:c672:b903 with SMTP id
 a640c23a62f3a-a699fe00edemr114135366b.53.1717578151915; 
 Wed, 05 Jun 2024 02:02:31 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68e6b5cdf8sm521491566b.81.2024.06.05.02.02.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 02:02:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/46] mostly i386 patches for 2024-06-04
Date: Wed,  5 Jun 2024 11:02:27 +0200
Message-ID: <20240605090229.1704300-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 3ab42e46acf867c45bc929fcc37693e327a35a24:

  Merge tag 'pull-ufs-20240603' of https://gitlab.com/jeuk20.kim/qemu into staging (2024-06-03 08:18:14 -0500)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to fc7a69e177e4ba26d11fcf47b853f85115b35a11:

  hw/i386: Add support for loading BIOS using guest_memfd (2024-06-04 16:44:23 +0200)

----------------------------------------------------------------
* virtio-blk: remove SCSI passthrough functionality
* require x86-64-v2 baseline ISA
* SEV-SNP host support
* fix xsave.flat with TCG
* fixes for CPUID checks done by TCG

----------------------------------------------------------------
Brijesh Singh (6):
      i386/sev: Introduce 'sev-snp-guest' object
      i386/sev: Add the SNP launch start context
      i386/sev: Add handling to encrypt/finalize guest launch data
      hw/i386/sev: Add function to get SEV metadata from OVMF header
      i386/sev: Add support for populating OVMF metadata pages
      hw/i386/sev: Add support to encrypt BIOS when SEV-SNP is enabled

Dov Murik (3):
      i386/sev: Extract build_kernel_loader_hashes
      i386/sev: Reorder struct declarations
      i386/sev: Allow measured direct kernel boot on SNP

Michael Roth (11):
      i386/sev: Introduce "sev-common" type to encapsulate common SEV state
      i386/sev: Add a sev_snp_enabled() helper
      i386/cpu: Set SEV-SNP CPUID bit when SNP enabled
      i386/sev: Don't return launch measurements for SEV-SNP guests
      i386/sev: Update query-sev QAPI format to handle SEV-SNP
      i386/sev: Set CPU state to protected once SNP guest payload is finalized
      i386/sev: Add support for SNP CPUID validation
      i386/kvm: Add KVM_EXIT_HYPERCALL handling for KVM_HC_MAP_GPA_RANGE
      i386/sev: Enable KVM_HC_MAP_GPA_RANGE hcall for SNP guests
      hw/i386/sev: Use guest_memfd for legacy ROMs
      hw/i386: Add support for loading BIOS using guest_memfd

Pankaj Gupta (7):
      linux-headers: Update to current kvm/next
      i386/sev: Replace error_report with error_setg
      i386/sev: Move sev_launch_update to separate class method
      i386/sev: Move sev_launch_finish to separate class method
      i386/sev: Add sev_kvm_init() override for SEV class
      i386/sev: Add snp_kvm_init() override for SNP class
      i386/sev: Invoke launch_updata_data() for SNP class

Paolo Bonzini (15):
      docs, tests: do not specify scsi=off
      virtio-blk: remove SCSI passthrough functionality
      host/i386: nothing looks at CPUINFO_SSE4
      meson: assume x86-64-v2 baseline ISA
      host/i386: assume presence of CMOV
      host/i386: assume presence of SSE2
      host/i386: assume presence of SSSE3
      host/i386: assume presence of POPCNT
      target/i386: fix xsave.flat from kvm-unit-tests
      update-linux-headers: fix forwarding to asm-generic headers
      update-linux-headers: move pvpanic.h to correct directory
      update-linux-headers: import linux/kvm_para.h header
      machine: allow early use of machine_require_guest_memfd
      i386/sev: Add a class method to determine KVM VM type for SNP guests
      i386/sev: Invoke launch_updata_data() for SEV class

Xiaoyao Li (1):
      memory: Introduce memory_region_init_ram_guest_memfd()

Xinyu Li (2):
      target/i386: fix SSE and SSE2 feature check
      target/i386: fix memory opsize for Mov to/from Seg

Zhao Liu (1):
      target/i386/tcg: Fix RDPID feature check

 docs/about/deprecated.rst                          |   10 -
 docs/about/removed-features.rst                    |    8 +
 docs/pci_expander_bridge.txt                       |    2 +-
 docs/specs/tpm.rst                                 |    2 +-
 docs/system/i386/amd-memory-encryption.rst         |   70 +-
 meson.build                                        |   10 +-
 qapi/misc-target.json                              |   72 +-
 qapi/qom.json                                      |   98 +-
 host/include/i386/host/cpuinfo.h                   |    4 -
 include/exec/confidential-guest-support.h          |    5 +
 include/exec/memory.h                              |    6 +
 include/hw/boards.h                                |    1 -
 include/hw/i386/pc.h                               |   28 +
 include/hw/i386/x86.h                              |    2 +-
 include/standard-headers/linux/kvm_para.h          |   38 +
 include/standard-headers/{linux => misc}/pvpanic.h |    0
 linux-headers/asm-loongarch/kvm.h                  |    4 +
 linux-headers/asm-riscv/kvm.h                      |    1 +
 linux-headers/asm-x86/kvm.h                        |   52 +-
 linux-headers/asm-x86/kvm_para.h                   |    1 +
 linux-headers/linux/kvm_para.h                     |    2 +
 linux-headers/linux/vhost.h                        |   15 +-
 target/i386/kvm/kvm_i386.h                         |    1 +
 target/i386/sev.h                                  |   13 +-
 target/i386/tcg/decode-new.h                       |    3 +
 tcg/i386/tcg-target.h                              |    5 +-
 hw/block/virtio-blk.c                              |  166 +-
 hw/core/machine.c                                  |    4 +-
 hw/i386/pc.c                                       |   14 +-
 hw/i386/pc_sysfw.c                                 |   35 +-
 hw/i386/x86-common.c                               |   19 +-
 hw/misc/pvpanic-isa.c                              |    2 +-
 hw/misc/pvpanic-pci.c                              |    2 +-
 hw/misc/pvpanic.c                                  |    2 +-
 system/memory.c                                    |   24 +
 target/i386/cpu.c                                  |    1 +
 target/i386/kvm/kvm.c                              |   56 +
 target/i386/sev-sysemu-stub.c                      |    6 +-
 target/i386/sev.c                                  | 1581 +++++++++++++++-----
 target/i386/tcg/fpu_helper.c                       |    5 +
 target/i386/tcg/translate.c                        |    2 +-
 util/bufferiszero.c                                |    4 +-
 util/cpuinfo-i386.c                                |    8 +-
 target/i386/tcg/decode-new.c.inc                   |   17 +-
 tcg/i386/tcg-target.c.inc                          |   15 +-
 scripts/update-linux-headers.sh                    |   37 +-
 target/i386/kvm/trace-events                       |    1 +
 target/i386/trace-events                           |    3 +
 tests/avocado/intel_iommu.py                       |    2 +-
 tests/avocado/smmu.py                              |    2 +-
 tests/avocado/tuxrun_baselines.py                  |    2 +-
 51 files changed, 1849 insertions(+), 614 deletions(-)
 create mode 100644 include/standard-headers/linux/kvm_para.h
 rename include/standard-headers/{linux => misc}/pvpanic.h (100%)
 create mode 100644 linux-headers/asm-x86/kvm_para.h
 create mode 100644 linux-headers/linux/kvm_para.h
-- 
2.45.1


