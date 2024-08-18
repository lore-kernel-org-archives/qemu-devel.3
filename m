Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6737C52D7C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2024 11:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfeJd-0002ft-Vt; Sun, 18 Aug 2024 07:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sfeJa-0002fO-1a
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 07:43:18 -0400
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sfeJV-0001aH-Tj
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 07:43:17 -0400
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-81f921c40a0so130551639f.0
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 04:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723981391; x=1724586191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BV8QSSP2M5BOgIXQ+9RLO6WwKCAhojP48v4uki4JwNo=;
 b=bV8jDHQ7EeHoApO7/tu4dYzoUMhSx3pTSp87XwO5fJANKcF9yLOoxrA6tw58aHdtv4
 k/wnzVXnXT9LuFZ81zU3U2qQKA52ggBbMCbXoflsl0+gq66l2foILTnnCNRQP/yHHG6p
 g4xehrgRo/dLTFm4/eyGNPdf3C8VE1RQZiWZZQmmpUgcPZFLUmm0mnVR9EsP/En78o/G
 BCUBB3ltK6PcxoZ97Q2imRVePipxRJ1D/W60i9JuTQHF74ApewE4njZfq8KcJftxKxFo
 vORNssxtXekkhugjVILqlp4WxtT0DYPpQNlb5SKUkSwc3EysgdjD1tU9sHgukLQKA6IY
 aJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723981391; x=1724586191;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BV8QSSP2M5BOgIXQ+9RLO6WwKCAhojP48v4uki4JwNo=;
 b=e9fJoTErxq3XToxsLrjS5X/6OLO6ErKLO3kbIla+NXH+MgnvxtoFExkytDHD5ViFtW
 YOuuVerXZ672DnPKjzErTOaXfoQzxhJ4t58VEvst9BfhW5l0FXjZQu49DgfJQ9Pu75QS
 C9vHqFLNvRHtUOludins1Nb9DXDfqVqQL3z89ub3aQgbGjKfL3qBKyHBVASIRgG1342C
 yUilAPKnEsdUeNQtNSGODA5o7IfouoY/keQem5Z/7PW20stBujPfkHNfz9je7SfRA1fr
 tkisbmSRewPfPmFqS779Yo6Pc7+2h4cJ1YSrR9tgB39JQyMTUfQmaxlFSfvV0TU+6QYW
 1Wjw==
X-Gm-Message-State: AOJu0YwaTncNeCN5yHlhs4BaaXUOlVyE+VpCfSvIaoFs+R7xi6vcsJyr
 1kN9CNLxfkN7DAtJ9iCwrBDPifUmw4w5RKwcWNLSoPdruat3fkEeQ9xPoA==
X-Google-Smtp-Source: AGHT+IE3P+E+LOPIAAWJ44d9EY9QeyOOFFnQVYVeOSFyZ/5a4IjylubAkBjvl7vFhsDsB/qVyfJgBg==
X-Received: by 2002:a05:6602:6402:b0:7eb:7f2e:5b3a with SMTP id
 ca18e2360f4ac-824f25e4a59mr839323639f.2.1723981390677; 
 Sun, 18 Aug 2024 04:43:10 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.174])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3e2c61fe4sm5303617a91.4.2024.08.18.04.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Aug 2024 04:43:10 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v4 0/6] AWS Nitro Enclave emulation support
Date: Sun, 18 Aug 2024 17:42:51 +0600
Message-Id: <20240818114257.21456-1-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2e;
 envelope-from=dorjoychy111@gmail.com; helo=mail-io1-xd2e.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This is v4 submission for AWS Nitro Enclave emulation in QEMU. From the QEMU side
the implementation for nitro enclaves is complete. v3 is at:
https://mail.gnu.org/archive/html/qemu-devel/2024-08/msg01594.html

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
VM applications in the host machine instead of a separate VM with CID 3.

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
  machine/nitro-enclave: New machine type for AWS Nitro Enclaves
  machine/nitro-enclave: Add vhost-user-vsock device
  device/virtio-nsm: Support for Nitro Secure Module device
  machine/nitro-enclave: Add built-in Nitro Secure Module device
  crypto: Support SHA384 hash when using glib
  docs/nitro-enclave: Documentation for nitro-enclave machine type

 MAINTAINERS                              |   19 +
 backends/hostmem-memfd.c                 |    2 -
 configs/devices/i386-softmmu/default.mak |    1 +
 crypto/hash-glib.c                       |    2 +-
 crypto/meson.build                       |    2 +-
 crypto/x509-utils.c                      |   73 +
 docs/system/i386/nitro-enclave.rst       |   82 ++
 hw/core/eif.c                            |  707 ++++++++++
 hw/core/eif.h                            |   22 +
 hw/core/machine.c                        |   71 +-
 hw/core/meson.build                      |    3 +
 hw/i386/Kconfig                          |    6 +
 hw/i386/meson.build                      |    1 +
 hw/i386/microvm.c                        |    6 +-
 hw/i386/nitro_enclave.c                  |  355 +++++
 hw/virtio/Kconfig                        |    5 +
 hw/virtio/cbor-helpers.c                 |  292 ++++
 hw/virtio/meson.build                    |    4 +
 hw/virtio/virtio-nsm-pci.c               |   73 +
 hw/virtio/virtio-nsm.c                   | 1648 ++++++++++++++++++++++
 include/crypto/x509-utils.h              |   22 +
 include/hw/boards.h                      |    2 +
 include/hw/i386/microvm.h                |    2 +
 include/hw/i386/nitro_enclave.h          |   63 +
 include/hw/virtio/cbor-helpers.h         |   43 +
 include/hw/virtio/virtio-nsm.h           |   59 +
 include/sysemu/hostmem.h                 |    2 +
 27 files changed, 3529 insertions(+), 38 deletions(-)
 create mode 100644 crypto/x509-utils.c
 create mode 100644 docs/system/i386/nitro-enclave.rst
 create mode 100644 hw/core/eif.c
 create mode 100644 hw/core/eif.h
 create mode 100644 hw/i386/nitro_enclave.c
 create mode 100644 hw/virtio/cbor-helpers.c
 create mode 100644 hw/virtio/virtio-nsm-pci.c
 create mode 100644 hw/virtio/virtio-nsm.c
 create mode 100644 include/crypto/x509-utils.h
 create mode 100644 include/hw/i386/nitro_enclave.h
 create mode 100644 include/hw/virtio/cbor-helpers.h
 create mode 100644 include/hw/virtio/virtio-nsm.h

-- 
2.39.2


