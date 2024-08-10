Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAA9C3DA7F
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2024 16:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scpDU-0004Lz-Lj; Sat, 10 Aug 2024 12:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1scpDT-0004LT-3l
 for qemu-devel@nongnu.org; Sat, 10 Aug 2024 12:45:19 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1scpDR-0003lC-0h
 for qemu-devel@nongnu.org; Sat, 10 Aug 2024 12:45:18 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70d18112b60so1958396b3a.1
 for <qemu-devel@nongnu.org>; Sat, 10 Aug 2024 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723308315; x=1723913115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8fvBmOJX3zHZSI4slS1PNXb/71vC+lzPSxCGI+ROXjo=;
 b=ZPjeueIR+lSklJhUZhHp0Svf9N7yPvUMY9NuGfEREKKucdtZCyjTm/m2mKRxKudYWa
 9Q3c0mRQ7YFjidrvU9e0IuWxifQvRBePUiKTOi2tNmvpD77DEUAKQBufoEPf/f91Jw7s
 Cmx6kQCm729FeHHRfVWk/SY70S0rjEPWW07WRttZ2KPJ7lVPvnk/jQ6jLnhss3vqmSC8
 FhOrnPcWU7v8aG6vEPlYfzgr29OM9TswwScx2Rw6i0hkp7X3z5jngr746gDxPtZczcf8
 BwGwvYSZY60CMuSPgcklyeRDw6avn+9fKJKhFUr+RlrgmZwxdT27rxoyhpE1L/Xt6eRM
 0QIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723308315; x=1723913115;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8fvBmOJX3zHZSI4slS1PNXb/71vC+lzPSxCGI+ROXjo=;
 b=qalLzJ//8OPKYwett5cpbFAAHd/KLG30WQ+ilUYbP0yYxMELz82FmUgD0I2xfZFU47
 vAXTwxJP0Bfn0VjaQ2VIhJD2I2D8Y3PkSE30higiQUfuJiLS6oHTNTZiwIkdy5GYCI8F
 CtO/dEwnfY7RZCCf2qvjHEnIVf7dVGCYn6d71Bs9OCgOEXhsPwsfpUh6goThupOgBI8N
 1XgqhEyXWkd9JLBop3pdRavFIqqd/PN/Rvem+eaTeUgNtBbHGtFLMIaZ65IXQoBr/ChB
 jHDoCiwnH0j08BGqC/8xrP/mNFjcqhlUx7xzSMOLMan7btBvIWUbVubL5KxEeytACjFb
 j0Iw==
X-Gm-Message-State: AOJu0YxORT7E83xl/4JQAK3F2mjLyvmbzz23FmrWhSf0GUmr16LJlov0
 r2saGKyPyd5MCFLgZbbHdatGJGVZTrkMqbEoRG1G1nkxHJ+WCyNOqo3vYHrc
X-Google-Smtp-Source: AGHT+IEyZVRVLJ5bhUAYw+tRRr7+3BEeWZPi7JahRFzIS6f98OmBC6eywcN5ZRNMxZBSLSpg3WPHZQ==
X-Received: by 2002:a05:6a00:8201:b0:706:1bb3:fb1d with SMTP id
 d2e1a72fcca58-710cc81f609mr11883449b3a.7.1723308314904; 
 Sat, 10 Aug 2024 09:45:14 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e58735e2sm1424397b3a.30.2024.08.10.09.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 09:45:14 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v3 0/5] AWS Nitro Enclave emulation support
Date: Sat, 10 Aug 2024 22:44:57 +0600
Message-Id: <20240810164502.19693-1-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pf1-x42c.google.com
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

This is v3 submission for AWS Nitro Enclave emulation in QEMU. From the QEMU side
the implementation for nitro enclaves is complete. A lot of changes from v2 so all
the patches need to be reviewed. v2 is at:
https://mail.gnu.org/archive/html/qemu-devel/2024-06/msg00012.html

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
domain socket) to the host machine in vhost-device-vsock which I will be posting
a PR to the rust-vmm repo. This will allow users to run the necessary parent VM
applications in the host machine instead of a separate VM with CID 3. Once that
work is done, I will update the documentation in docs/system/i386/nitro-enclave.rst
accordingly.

A new device virtio-nsm support has been added to QEMU. This device is built-into
the nitro-enclave VM. The virtio-nsm spec can be found here[6].

For local testing you need to generate a hello.eif image by first building
nitro-cli locally[7]. Then you can use nitro-cli to build a hello.eif image[8].
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
[6] https://lists.oasis-open.org/archives/virtio-comment/202310/msg00387.html
[7] https://github.com/aws/aws-nitro-enclaves-cli/blob/main/docs/ubuntu_20.04_how_to_install_nitro_cli_from_github_sources.md
[8] https://github.com/aws/aws-nitro-enclaves-cli/blob/main/examples/x86_64/hello/README.md

Dorjoy Chowdhury (5):
  machine/nitro-enclave: New machine type for AWS Nitro Enclaves
  machine/nitro-enclave: Add vhost-user-vsock device
  device/virtio-nsm: Support for Nitro Secure Module device
  machine/nitro-enclave: Add built-in Nitro Secure Module device
  docs/nitro-enclave: Documentation for nitro-enclave machine type

 MAINTAINERS                              |   17 +
 backends/hostmem-memfd.c                 |    2 -
 configs/devices/i386-softmmu/default.mak |    1 +
 docs/system/i386/nitro-enclave.rst       |   80 +
 hw/core/eif.c                            |  707 ++++++++
 hw/core/eif.h                            |   22 +
 hw/core/machine.c                        |   71 +-
 hw/core/meson.build                      |    3 +
 hw/i386/Kconfig                          |    6 +
 hw/i386/meson.build                      |    1 +
 hw/i386/microvm.c                        |    6 +-
 hw/i386/nitro_enclave.c                  |  299 ++++
 hw/virtio/Kconfig                        |    5 +
 hw/virtio/meson.build                    |    4 +
 hw/virtio/virtio-nsm-pci.c               |   73 +
 hw/virtio/virtio-nsm.c                   | 1929 ++++++++++++++++++++++
 include/hw/boards.h                      |    2 +
 include/hw/i386/microvm.h                |    2 +
 include/hw/i386/nitro_enclave.h          |   56 +
 include/hw/virtio/virtio-nsm.h           |   59 +
 include/sysemu/hostmem.h                 |    2 +
 21 files changed, 3311 insertions(+), 36 deletions(-)
 create mode 100644 docs/system/i386/nitro-enclave.rst
 create mode 100644 hw/core/eif.c
 create mode 100644 hw/core/eif.h
 create mode 100644 hw/i386/nitro_enclave.c
 create mode 100644 hw/virtio/virtio-nsm-pci.c
 create mode 100644 hw/virtio/virtio-nsm.c
 create mode 100644 include/hw/i386/nitro_enclave.h
 create mode 100644 include/hw/virtio/virtio-nsm.h

-- 
2.39.2


