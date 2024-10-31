Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04775D767F4
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZLN-000727-BW; Thu, 31 Oct 2024 13:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLM-00071t-BH
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLK-000786-9O
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nnoBFxq4ul6ZLJtWdfMOp63DcaIrdUiLnTuwxjqUpjQ=;
 b=B+WaS4Tye2m1x1URPB/5Gpxf0IGZ5nCRJNXk2/K+nLk0VZduuw+TSUr4DPYd9/jaWqN4Lo
 TdwgPErlv9KyxveHO+ROqC0aKYGi7/r5yYnavfLRwMCd5aphLVCmHCBdb3CzhyGvP2631M
 nqmZhkml8TXfK8hG+K0jLvXOYH9Qbw4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-XH9rIqhpPSegVihmO7VKMw-1; Thu, 31 Oct 2024 13:52:18 -0400
X-MC-Unique: XH9rIqhpPSegVihmO7VKMw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d4922d8c7so570751f8f.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397136; x=1731001936;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nnoBFxq4ul6ZLJtWdfMOp63DcaIrdUiLnTuwxjqUpjQ=;
 b=LGdJHwSOlDMc0iNKt/yRlNvrjNfGx0c19Mk4in3nzfS51UvNpFKAGi9G1gAz99SrO1
 QDRoCBADcYdS12+2mBkqLfO/RNtUvQYxcas8GC4qxV2c7BgEUKCbR6SQC2Ra28lV5a4e
 4SRAPtBjyIqcNAs+ufCh0KVliVyHGQ6VKEoVGZPbJJZvHnusnV8XyR23kh78o33lcJ2Z
 qlVTXalb4D49ey2OqZcDcG+Q5M0aM1IGy72AkVWG81rXwLbqgU8plWRT6GjoS0Mg3vHc
 kdmLVBglmgAjOZcCKcCTYXeF5ha5EM1HVlAJIVIenEjzs2GuPFCdFpgmdCZxpfZcPOmh
 erSg==
X-Gm-Message-State: AOJu0Yzmf2JCfxe061cg3YJ1y1Wo4n7panwBQQZhRZa0HMa9tvNgcBRk
 2UvtuRquNj33oJpCiyeWI4pXoY1iuKFk2CxD49wl7aQ1TpdVlBJPD18QIDOASltkQDTlVG6dCqG
 A65P8w6sx874ZanGwUM3lQE7lV7/abQlg9GRCJIMXHs4+3E4f9TP6jz4nQuoVF9ARmQA88mRBkF
 gMG6ol19teoQEpLNbnzVdWb1D/vuJP6uKlpR1cjOo=
X-Received: by 2002:a5d:6d8e:0:b0:37c:babe:2c49 with SMTP id
 ffacd0b85a97d-381c7a4c7d7mr703813f8f.19.1730397135979; 
 Thu, 31 Oct 2024 10:52:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7bAmww16Y4BCJt3ADBmfVaQ4sbPH0ZGOyMGbID4Nu95+pPrX0JG6pVXmkAW4UCxvGa8X/Kw==
X-Received: by 2002:a5d:6d8e:0:b0:37c:babe:2c49 with SMTP id
 ffacd0b85a97d-381c7a4c7d7mr703795f8f.19.1730397135477; 
 Thu, 31 Oct 2024 10:52:15 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bb78b809sm76073465e9.1.2024.10.31.10.52.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:52:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/49] i386, qom, build changes for 2024-10-31
Date: Thu, 31 Oct 2024 18:51:24 +0100
Message-ID: <20241031175214.214455-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 58d49b5895f2e0b5cfe4b2901bf24f3320b74f29:

  Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2024-10-29 14:00:43 +0000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream-i386

for you to fetch changes up to 1a519388a882fbb352e49cbebb0ed8f62d05842d:

  target/i386: Introduce GraniteRapids-v2 model (2024-10-31 18:28:33 +0100)

----------------------------------------------------------------
* target/i386: new feature bits for AMD processors
* target/i386/tcg: improvements around flag handling
* target/i386: add AVX10 support
* target/i386: add GraniteRapids-v2 model
* dockerfiles: add libcbor
* New nitro-enclave machine type
* qom: cleanups to object_new
* configure: detect 64-bit MIPS for rust
* configure: deprecate 32-bit MIPS

----------------------------------------------------------------
Babu Moger (3):
      target/i386: Fix minor typo in NO_NESTED_DATA_BP feature bit
      target/i386: Expose bits related to SRSO vulnerability
      target/i386: Expose new feature bits in CPUID 8000_0021_EAX/EBX

Daniel P. Berrangé (2):
      tests: add 'rust' and 'bindgen' to CI package list
      ci: enable rust in the Fedora system build job

Dorjoy Chowdhury (6):
      tests/lcitool: Update libvirt-ci and add libcbor dependency
      device/virtio-nsm: Support for Nitro Secure Module device
      hw/core: Add Enclave Image Format (EIF) related helpers
      core/machine: Make create_default_memdev machine a virtual method
      machine/nitro-enclave: New machine type for AWS Nitro Enclaves
      docs/nitro-enclave: Documentation for nitro-enclave machine type

Paolo Bonzini (25):
      stubs: avoid duplicate symbols in libqemuutil.a
      target/i386: fix CPUID check for LFENCE and SFENCE
      configure: detect 64-bit MIPS
      configure, meson: deprecate 32-bit MIPS
      accel: remove dead statement and useless assertion
      qom: remove unused function
      qom: use object_new_with_class when possible
      qom: centralize module-loading functionality
      qom: let object_new use a module if the type is not present
      qom: allow user-creatable classes to be in modules
      target/i386/hvf: fix handling of XSAVE-related CPUID bits
      ci: always invoke meson through pyvenv
      target/i386: use tcg_gen_ext_tl when applicable
      target/i386: remove CC_OP_CLR
      target/i386: optimize computation of ZF from CC_OP_DYNAMIC
      target/i386: optimize TEST+Jxx sequences
      target/i386: add a few more trivial CCPrepare cases
      target/i386: add a note about gen_jcc1
      target/i386: make flag variables unsigned
      target/i386: use compiler builtin to compute PF
      target/i386: use higher-precision arithmetic to compute CF
      target/i386: use + to put flags together
      target/i386: cpu: set correct supported XCR0 features for TCG
      target/i386: do not rely on ExtSaveArea for accelerator-supported XCR0 bits
      target/i386: return bool from x86_cpu_filter_features

Pierrick Bouvier (1):
      scripts: remove erroneous file that breaks git clone on Windows

Richard Henderson (4):
      target/i386: Tidy cc_op_str usage
      target/i386: Rearrange CCOp
      target/i386: Introduce cc_op_size
      target/i386: Wrap cc_op_live with a validity check

Sandipan Das (1):
      target/i386: Add PerfMonV2 feature bit

Tao Su (5):
      target/i386: add AVX10 feature and AVX10 version property
      target/i386: add CPUID.24 features for AVX10
      target/i386: Add feature dependencies for AVX10
      target/i386: Add AVX512 state when AVX10 is supported
      target/i386: Introduce GraniteRapids-v2 model

Xiaoyao Li (1):
      i386/cpu: Drop the check of phys_bits in host_cpu_realizefn()

Zhao Liu (1):
      MAINTAINERS: Add myself as a reviewer of x86 general architecture support

 MAINTAINERS                                        |   21 +
 docs/about/build-platforms.rst                     |    2 +-
 docs/about/deprecated.rst                          |   12 +-
 docs/system/i386/nitro-enclave.rst                 |   78 +
 docs/system/target-i386.rst                        |    3 +-
 configure                                          |   10 +-
 configs/devices/i386-softmmu/default.mak           |    1 +
 meson.build                                        |   17 +
 host/include/i386/host/cpuinfo.h                   |    1 +
 hw/core/eif.h                                      |   22 +
 include/hw/boards.h                                |    2 +
 include/hw/i386/microvm.h                          |    2 +
 include/hw/i386/nitro_enclave.h                    |   62 +
 include/hw/virtio/cbor-helpers.h                   |   45 +
 include/hw/virtio/virtio-nsm.h                     |   49 +
 include/qemu/host-utils.h                          |    9 +
 include/qom/object.h                               |    8 -
 include/sysemu/hostmem.h                           |    2 +
 target/i386/cpu.h                                  |   76 +-
 target/i386/helper.h                               |    1 +
 target/i386/tcg/helper-tcg.h                       |    6 +-
 target/i386/tcg/cc_helper_template.h.inc           |  127 +-
 accel/accel-system.c                               |    4 +-
 backends/hostmem-memfd.c                           |    2 -
 hw/core/eif.c                                      |  719 ++++++++
 hw/core/machine.c                                  |   71 +-
 hw/core/qdev.c                                     |   21 +-
 hw/i386/microvm.c                                  |    6 +-
 hw/i386/nitro_enclave.c                            |  354 ++++
 hw/virtio/cbor-helpers.c                           |  321 ++++
 hw/virtio/virtio-nsm-pci.c                         |   73 +
 hw/virtio/virtio-nsm.c                             | 1732 ++++++++++++++++++++
 qom/object.c                                       |   80 +-
 qom/object_interfaces.c                            |    4 +-
 qom/qom-qmp-cmds.c                                 |    4 +-
 target/i386/cpu-dump.c                             |   18 +-
 target/i386/cpu.c                                  |  218 ++-
 target/i386/host-cpu.c                             |   16 +-
 target/i386/hvf/x86_cpuid.c                        |   56 +-
 target/i386/kvm/kvm-cpu.c                          |    4 -
 target/i386/kvm/kvm.c                              |    3 +-
 target/i386/tcg/cc_helper.c                        |   51 +-
 target/i386/tcg/int_helper.c                       |    4 +-
 target/i386/tcg/translate.c                        |  103 +-
 tests/qtest/libqtest.c                             |    3 +-
 util/cpuinfo-i386.c                                |    1 +
 target/i386/tcg/decode-new.c.inc                   |    6 +-
 target/i386/tcg/emit.c.inc                         |   24 +-
 .gitlab-ci.d/buildtest-template.yml                |    2 +-
 .gitlab-ci.d/buildtest.yml                         |    2 +-
 .gitlab-ci.d/cirrus/freebsd-14.vars                |    2 +-
 .gitlab-ci.d/cirrus/macos-14.vars                  |    2 +-
 .gitlab-ci.d/cirrus/macos-15.vars                  |    2 +-
 Kconfig.host                                       |    6 +
 hw/core/Kconfig                                    |    4 +
 hw/core/meson.build                                |    1 +
 hw/i386/Kconfig                                    |   10 +
 hw/i386/meson.build                                |    1 +
 hw/virtio/Kconfig                                  |    4 +
 hw/virtio/meson.build                              |    2 +
 meson_options.txt                                  |    2 +
 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml   |    3 +
 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml     |    3 +
 scripts/meson-buildoptions.                        |    0
 scripts/meson-buildoptions.sh                      |    3 +
 stubs/meson.build                                  |    7 +-
 tests/docker/dockerfiles/alpine.docker             |    3 +
 tests/docker/dockerfiles/centos9.docker            |    2 +
 tests/docker/dockerfiles/debian-amd64-cross.docker |    4 +
 tests/docker/dockerfiles/debian-arm64-cross.docker |    4 +
 tests/docker/dockerfiles/debian-armhf-cross.docker |    4 +
 tests/docker/dockerfiles/debian-i686-cross.docker  |    4 +
 .../dockerfiles/debian-mips64el-cross.docker       |    4 +
 .../docker/dockerfiles/debian-mipsel-cross.docker  |    4 +
 .../docker/dockerfiles/debian-ppc64el-cross.docker |    4 +
 tests/docker/dockerfiles/debian-s390x-cross.docker |    4 +
 tests/docker/dockerfiles/debian.docker             |    3 +
 .../docker/dockerfiles/fedora-rust-nightly.docker  |    3 +
 tests/docker/dockerfiles/fedora-win64-cross.docker |    2 +
 tests/docker/dockerfiles/fedora.docker             |    3 +
 tests/docker/dockerfiles/opensuse-leap.docker      |    3 +
 tests/docker/dockerfiles/ubuntu2204.docker         |    3 +
 tests/lcitool/projects/qemu.yml                    |    3 +
 tests/vm/generated/freebsd.json                    |    2 +
 84 files changed, 4219 insertions(+), 350 deletions(-)
 create mode 100644 docs/system/i386/nitro-enclave.rst
 create mode 100644 hw/core/eif.h
 create mode 100644 include/hw/i386/nitro_enclave.h
 create mode 100644 include/hw/virtio/cbor-helpers.h
 create mode 100644 include/hw/virtio/virtio-nsm.h
 create mode 100644 hw/core/eif.c
 create mode 100644 hw/i386/nitro_enclave.c
 create mode 100644 hw/virtio/cbor-helpers.c
 create mode 100644 hw/virtio/virtio-nsm-pci.c
 create mode 100644 hw/virtio/virtio-nsm.c
 delete mode 100644 scripts/meson-buildoptions.
-- 
2.47.0


