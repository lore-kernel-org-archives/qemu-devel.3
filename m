Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379A7CF0423
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 21:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syHaQ-0000vh-Aw; Tue, 08 Oct 2024 17:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1syHaM-0000vW-TR
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 17:17:38 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1syHaK-0000I6-GI
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 17:17:38 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71e03be0d92so1944434b3a.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 14:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728422254; x=1729027054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RoVO35XpGhuwmq5Rh0/ZYmq3t67MUXbEzcQamdBgSmY=;
 b=RwSq/el5eD5/2W0LOfl/K72XtdHMQOnSqLeVbwuA1DYnrYJ2SgPZMBcKqTtHJ+w2Kz
 4YEqRt1wL0/gNNxvys1LjLd0f83He0+B5WkV9LBtemzOYoYlLKj9Ia4CsOSP7/n/G9gd
 GXJr+7KN+dSewXuRFIbThZqoh3QMZU46us9FJsiJRi2vK4NmP6N79V3WXLBCLNUnZUNI
 t8RZtwjtslS049ZxuCr2VjWoL3BiWlOVmTLomB8s0NTa91ZrwFzBdlzMEJ4FCkh2o86b
 BTxkpEgZXpcbAzrH9swgfLaIsW2/OsRPY5a+AVipscZDNLp6c4H+jHNNmqu7hXWuxWUV
 ajGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728422254; x=1729027054;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RoVO35XpGhuwmq5Rh0/ZYmq3t67MUXbEzcQamdBgSmY=;
 b=MqNbY45f3ky4ckvOq8e59QuFACVGSNl7IbiZYD0A449KiVUV1qEpI0UTAtUPB5ZC9L
 mcSOlIGdyxfRGj2hj6evailtQqZo43R8cSKnamjvX8kC+skInOB1IrD57XUUh+6m1wEf
 0QQgscIZqYn3tNjNFSfvVUvB5sX+OcfxnSc33hfS8uVRYKyPnSNwQBOxhzyxqvDI0fhQ
 7rFmbp5wfzgfGW47Dkcgw6PTMt/MCPoHVPifLwzKxqk/TXHXJjiFqVFkZJl45YghJ/wc
 3z4wfABb3mwxqpaepN+ZJcFitdb51l7loY0eA/F76sy11YYPKvfZxNLXe5sMp200O5g1
 VoJQ==
X-Gm-Message-State: AOJu0Yz+nvFl6q0fJa39aTEqR4PYXp5FQT7o7Ud+FfUJheVz7z1Ws55B
 jGVJAPlncRQhYdP372vUHcQmTiDNxvS3cYozMw/c1k1pT2SRdbkr1sHlQg==
X-Google-Smtp-Source: AGHT+IFWVGO6ie5fBl+TenlCQqEed6dgP9Qqq60eS5GY6EwhxjIVkD0EmOpa3dUMFPHDx322CWaLjQ==
X-Received: by 2002:a05:6a00:9294:b0:71e:3b8:666f with SMTP id
 d2e1a72fcca58-71e1db74ed4mr408925b3a.11.1728422254056; 
 Tue, 08 Oct 2024 14:17:34 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.151])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d6254dsm6549078b3a.153.2024.10.08.14.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 14:17:33 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v8 0/6] AWS Nitro Enclave emulation support
Date: Wed,  9 Oct 2024 03:17:21 +0600
Message-Id: <20241008211727.49088-1-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is v8 submission for AWS Nitro Enclave emulation in QEMU. From the QEMU side
the implementation for nitro enclaves is complete. v7 is at:
https://lore.kernel.org/qemu-devel/20240922094441.23802-1-dorjoychy111@gmail.com/T/#t

Changes in v8:
    - create_default_memdev related changes have been made into a separate commit
    - PCR states are now saved during migration
    - some changes in virtio-nsm.c for making the implementation similar to real
NSM in AWS which include returning the same error, ignoring unknown properties in
nested map etc. I got a chance to test real NSM in AWS and I prepared a script to
test various NSM operations and error conditions which I am maintaining a git repo
here: https://github.com/dorjoy03/nsm-api . The README has some details for testing.

Changes in v7:
    - rebased with master as the first 3 crypto patches got in master now
    - had to change some QCRYPTO_HASH_ALG refs to QCRYPTO_HASH_ALGO (with an 'O')
as that got changed in master
    - had to re-do the libvirt-ci update patch as I got a conflict from master
    - renamed handle_* functions in virtio-nsm.c to be not camel case

Changes in v6:
    - updated MAINTAINERS in the commit that introduced eif.c, eif.h files
    - used iov_to_buf and iov_from_buf in virtio-nsm.c handle_input
    - used g_new0 for iovec_list instead of g_malloc
    - updated documentation as now the vsock backend work[6] has been merged in
rust-vmm's vhost-device-vsock

Changes in v5:
    - bunch of use of glib utilities like g_autofree, g_memdup2, GList etc
    - updated libvirt-ci and added libcbor dependency
    - files in this patch are built under libcbor and gnutls dependency check now and
libcbor dependency has been moved to root meson.build file
    - separated and re-ordered commits as suggested
    - user_data and nonce are added as null to attestation when empty and payload_map_size is fixed
    - variables in eif.c have been shortened for readability

Changes in v4:
    - fixed error_setv assertion failed. I could not reproduce this but I think
this was happening because I did not set Error *err = NULL in x86_load_eif
    - qemu_cbor.. helpers moved to a separate file now
    - libcbor version requirement reduced from 0.8.0 to 0.7.0
    - replaced GChecksum uses with qcrypto apis
    - timestamp multiplied by 1000 in virtio-nsm
    - user_data and nonce are now included in attestation even when they are empty
    - added x509-utils in crypto
    - added G_CHECKSUM_SHA384 support in hash-glib.c
    - PCR3 and PCR4 can be set from nitro-enclave machine options. I did not add
the options for virtio-nsm device though. I think the PCR states are set by
machines so it made sense to add the options for machine only.

Changes in v3:
    - Support for virtio-nsm device
    - The EIF related logic has been removed from microvm.c i.e., the logic is
contained in enclave related code
    - For vsock emulation in nitro-enclave, now vhost-user-vsock is being used
instead of vhost-vsock (more details in the cover-letter below)
    - updated documentation accordingly

Changes in v2:
    - moved eif.c and eif.h files from hw/i386 to hw/core

Hi,

Hope everyone is doing well. This is a patch series adding AWS Nitro Enclave[1]
emulation support in QEMU. Alexander Graf is mentoring me on this work. I have
a gitlab branch where you can view the patches in the gitlab web UI for each commit:
https://gitlab.com/dorjoy03/qemu/-/tree/nitro-enclave-emulation

AWS nitro enclaves is an Amazon EC2[2] feature that allows creating isolated
execution environments, called enclaves, from Amazon EC2 instances, which are
used for processing highly sensitive data. Enclaves have no persistent storage
and no external networking. The enclave VMs are based on Firecracker microvm
and have a vhost-vsock device for communication with the parent EC2 instance
that spawned it and a Nitro Secure Module (NSM) device for cryptographic
attestation. The parent instance VM always has CID 3 while the enclave VM gets
a dynamic CID. The enclave VMs can communicate with the parent instance over
various ports to CID 3, for example, the init process inside an enclave sends a
heartbeat to port 9000 upon boot, expecting a heartbeat reply, letting the
parent instance know that the enclave VM has successfully booted.

From inside an EC2 instance, nitro-cli[3] is used to spawn an enclave VM using
an EIF (Enclave Image Format)[4] file. EIF files can be built using nitro-cli
as well. The EIF specification can be found in the README of the github
aws-nitro-enclaves-image-format repository[4]. An EIF file contains the kernel,
cmdline and ramdisk(s) in different sections which are used to boot the enclave
VM.

Adding nitro enclave emulation support in QEMU will make the life of AWS Nitro
Enclave users easier as they will be able to test their EIF images locally
without having to run real nitro enclaves which can be difficult for debugging
due to its roots in security. This will also make quick prototyping easier.

In QEMU, the new nitro-enclave machine type is implemented based on the microvm
machine type similar to how AWS Nitro Enclaves are based on Firecracker microvm.

The vsock emulation support is added using vhost-user-vsock device. This is
needed as nitro VMs always talk to parent VM (CID 3) but there is no support for
sibling VM communication in vhost-vsock. So to run nitro-enclave, a process that
does vsock emulation in user-space like vhost-device-vsock[5] from rust-vmm must
be run. I am working on adding proxying using vsock (right now it uses unix
domain socket) to the host machine in vhost-device-vsock which I have already
posted a PR[6] in rust-vmm repo. This will allow users to run the necessary parent
VM applications in the host machine instead of a separate VM with CID 3. Update:
this has been merged now.

A new device virtio-nsm support has been added to QEMU. This device is built-into
the nitro-enclave VM. The virtio-nsm spec can be found here[7].

For local testing you need to generate a hello.eif image by first building
nitro-cli locally[8]. Then you can use nitro-cli to build a hello.eif image[9].
More details about testing can be found in the docs/system/i386/nitro-enclave.rst
file.

Thanks.

Regards,
Dorjoy

[1] https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html
[2] https://aws.amazon.com/ec2/
[3] https://docs.aws.amazon.com/enclaves/latest/user/getting-started.html
[4] https://github.com/aws/aws-nitro-enclaves-image-format?tab=readme-ov-file#enclave-image-file-eif-specification
[5] https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock
[6] https://github.com/rust-vmm/vhost-device/pull/706
[7] https://lists.oasis-open.org/archives/virtio-comment/202310/msg00387.html
[8] https://github.com/aws/aws-nitro-enclaves-cli/blob/main/docs/ubuntu_20.04_how_to_install_nitro_cli_from_github_sources.md
[9] https://github.com/aws/aws-nitro-enclaves-cli/blob/main/examples/x86_64/hello/README.md

Dorjoy Chowdhury (6):
  tests/lcitool: Update libvirt-ci and add libcbor dependency
  device/virtio-nsm: Support for Nitro Secure Module device
  hw/core: Add Enclave Image Format (EIF) related helpers
  core/machine: Make create_default_memdev machine class property
  machine/nitro-enclave: New machine type for AWS Nitro Enclaves
  docs/nitro-enclave: Documentation for nitro-enclave machine type

 .gitlab-ci.d/cirrus/macos-14.vars             |    2 +-
 .gitlab-ci.d/cirrus/macos-15.vars             |    2 +-
 MAINTAINERS                                   |   20 +
 backends/hostmem-memfd.c                      |    2 -
 configs/devices/i386-softmmu/default.mak      |    1 +
 docs/system/i386/nitro-enclave.rst            |   78 +
 hw/core/eif.c                                 |  719 +++++++
 hw/core/eif.h                                 |   22 +
 hw/core/machine.c                             |   71 +-
 hw/core/meson.build                           |    3 +
 hw/i386/Kconfig                               |    6 +
 hw/i386/meson.build                           |    3 +
 hw/i386/microvm.c                             |    6 +-
 hw/i386/nitro_enclave.c                       |  354 ++++
 hw/virtio/Kconfig                             |    5 +
 hw/virtio/cbor-helpers.c                      |  321 +++
 hw/virtio/meson.build                         |    6 +
 hw/virtio/virtio-nsm-pci.c                    |   73 +
 hw/virtio/virtio-nsm.c                        | 1732 +++++++++++++++++
 include/hw/boards.h                           |    2 +
 include/hw/i386/microvm.h                     |    2 +
 include/hw/i386/nitro_enclave.h               |   62 +
 include/hw/virtio/cbor-helpers.h              |   45 +
 include/hw/virtio/virtio-nsm.h                |   49 +
 include/sysemu/hostmem.h                      |    2 +
 meson.build                                   |    2 +
 .../ci/setup/ubuntu/ubuntu-2204-aarch64.yaml  |    1 +
 .../ci/setup/ubuntu/ubuntu-2204-s390x.yaml    |    1 +
 tests/docker/dockerfiles/alpine.docker        |    1 +
 .../dockerfiles/debian-amd64-cross.docker     |    1 +
 .../dockerfiles/debian-arm64-cross.docker     |    1 +
 .../dockerfiles/debian-armhf-cross.docker     |    1 +
 .../dockerfiles/debian-i686-cross.docker      |    1 +
 .../dockerfiles/debian-mips64el-cross.docker  |    1 +
 .../dockerfiles/debian-mipsel-cross.docker    |    1 +
 .../dockerfiles/debian-ppc64el-cross.docker   |    1 +
 .../dockerfiles/debian-s390x-cross.docker     |    1 +
 tests/docker/dockerfiles/debian.docker        |    1 +
 tests/docker/dockerfiles/fedora.docker        |    1 +
 tests/docker/dockerfiles/opensuse-leap.docker |    1 +
 tests/docker/dockerfiles/ubuntu2204.docker    |    1 +
 tests/lcitool/projects/qemu.yml               |    1 +
 42 files changed, 3568 insertions(+), 38 deletions(-)
 create mode 100644 docs/system/i386/nitro-enclave.rst
 create mode 100644 hw/core/eif.c
 create mode 100644 hw/core/eif.h
 create mode 100644 hw/i386/nitro_enclave.c
 create mode 100644 hw/virtio/cbor-helpers.c
 create mode 100644 hw/virtio/virtio-nsm-pci.c
 create mode 100644 hw/virtio/virtio-nsm.c
 create mode 100644 include/hw/i386/nitro_enclave.h
 create mode 100644 include/hw/virtio/cbor-helpers.h
 create mode 100644 include/hw/virtio/virtio-nsm.h

-- 
2.39.5


