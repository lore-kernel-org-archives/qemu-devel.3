Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76C9C41513
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 08:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8F72-00051G-Uj; Sat, 18 May 2024 04:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1s8F71-00050q-DD
 for qemu-devel@nongnu.org; Sat, 18 May 2024 04:08:15 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1s8F6z-0006nt-8C
 for qemu-devel@nongnu.org; Sat, 18 May 2024 04:08:15 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ee42b97b32so31092775ad.2
 for <qemu-devel@nongnu.org>; Sat, 18 May 2024 01:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716019690; x=1716624490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DzabKjTBLcOwFLGQDFDKXRilhFFVASVu97FXB1TxzNQ=;
 b=lTVy5fgfMjB2XSMxJHWFsGDtu2mLQdRJpa9kSsErsS1uyjTcSjPiH01S/92FZmeN4H
 ZtvQ0nxMdF5VgD5rgYeRFJSs+bLOWVsTCPaoDCGLwQGMRm74KNFCT32IeM+mdIHk7d7S
 ZrOgad/2kiYQaD3SgeZVAyJziSY7i5/wxT/Xcjb3fuKmB4Ic89moDo20QGGE4gIiGxjC
 bCD7FQAcBrsRpCGbA5R67cS5xEWy5AYms4Nwu8CEJ4uc+8ZpN0zPFVM9oru+PE71sRks
 LiImynjh22UWfnq/zTo2WgnxMHMhKEG+Z5636wH1cbQDoH4IBfRuX0Es0+tVLDd3yxB1
 cxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716019690; x=1716624490;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DzabKjTBLcOwFLGQDFDKXRilhFFVASVu97FXB1TxzNQ=;
 b=SFkEooJwBZb7DkvRj685acr6Ul6xIKSZLzeicvF04HvSFGUJLlaFEIJtIZMwHQktuV
 3wMNAJUKZKJGEhdGmVRsx+ha0ZUR3VpMAWT0m7VXePHz+s/yevuyDLLu6jV+RODQ4YBA
 O0hXa4pE9boK5CopCAQg6DlaLeaUYR4kikjF0UkotyXN8icJ9PhHxqcRRrhBGxv16rOB
 vULaot9YDk+DyJHDtKbSghgfaO72Cfm8lnyn6JIxa+sphwodocxZ9HCSVYVe4HZ9nSro
 T8tiisppwKELAk+Y8izj5tGPMV2ip9BjhWSh5/xJ7XMW6WUtFOaQhO/ooGuIZ5hSHIoC
 hSEw==
X-Gm-Message-State: AOJu0YzoZx+KCHfYoJOnf0BHyXRMjAOKOyaejtK1INvZBivFMR1UZZeX
 1X6g2E67iWtXFhg07t3FIka1EgUnWd1XW3Te56m/zEK28bJmkeLomMTTIWYw
X-Google-Smtp-Source: AGHT+IG4XfSR9/MSIUkk2a/pUlWeFnwvAUf66hob9SjAD7FyBKQrxv/EOU4Lr4V4oj3z+LihRV1U+g==
X-Received: by 2002:a17:902:cf01:b0:1ea:1d2:90bc with SMTP id
 d9443c01a7336-1ef43d184fdmr283921265ad.24.1716019689933; 
 Sat, 18 May 2024 01:08:09 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f0cb2141b0sm45247265ad.285.2024.05.18.01.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 01:08:09 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com
Subject: [PATCH v1 0/2] AWS Nitro Enclave emulation support
Date: Sat, 18 May 2024 14:07:51 +0600
Message-Id: <20240518080753.7083-1-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pl1-x62a.google.com
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

Hi,

Hope everyone is doing well. I am working on adding AWS Nitro Enclave[1]
emulation support in QEMU. Alexander Graf is mentoring me on this work. This is
a patch series adding, not yet complete, but useful emulation support of nitro
enclaves. I have a gitlab branch where you can view the patches in the gitlab
web UI for each commit:
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
as well. There is no official EIF specification apart from the github
aws-nitro-enclaves-image-format repository[4]. An EIF file contains the kernel,
cmdline and ramdisk(s) in different sections which are used to boot the enclave
VM. You can look at the structs in hw/i386/eif.c file for more details about
the EIF file format.

Adding nitro enclave emulation support in QEMU will make the life of AWS Nitro
Enclave users easier as they will be able to test their EIF images locally
without having to run real nitro enclaves which can be difficult for debugging
due to its roots in security. This will also make quick prototyping easier.

In QEMU, the new nitro-enclave machine type is implemented based on the microvm
machine type similar to how AWS Nitro Enclaves are based on Firecracker microvm.
The vhost-vsock device support is already part of this patch series so that the
enclave VM can communicate to CID 3 using vsock. A mandatory 'guest-cid'
machine type option is needed which becomes the CID of the enclave VM. Some
documentation for the new 'nitro-enclave' machine type has also been added. The
NSM device support will be added in the future.

The plan is to eventually make the nitro enclave emulation in QEMU standalone
i.e., without needing to run another VM with CID 3 with proper vsock
communication support. For this to work, one approach could be to teach the
vhost-vsock driver in kernel to forward CID 3 messages to another CID
(set to CID 2 for host) so that users of the nitro-enclave machine type can
run the necessary vsock server/clients in the host machine (some defaults can
be implemented in QEMU as well, for example, sending a reply to the heartbeat)
which will rid them of the cumbersome way of running another whole VM with CID
3. This way, users of nitro-enclave machine in QEMU, could potentially also run
multiple enclaves with their messages for CID 3 forwarded to different CIDs
which, in QEMU side, could then be specified using a new machine type option
(parent-cid) if implemented. I will be posting an email to the linux
virtualization mailing list about this approach asking for feedback and
suggestions soon.

For local testing you need to generate a hello.eif image by first building
nitro-cli locally[5]. Then you can use nitro-cli to build a hello.eif image[6].

You need to build qemu-system-x86_64 after applying the patches and then you
can run the following command to boot a hello.eif image using the new
'nitro-enclave' machine type option in QEMU:

sudo ./qemu-system-x86_64 -M nitro-enclave,guest-cid=8 -kernel path/to/hello.eif -nographic -m 4G --enable-kvm -cpu host

The command needs to be run as sudo because for the vhost-vsock device to work
QEMU needs to be able to open vhost device in host.

Right now, if you just run the nitro-enclave machine, the kernel panics because
the init process exits abnormally because it cannot connect to port 9000 to CID
3 to send its heartbeat message (the connection times out), so another VM with
CID 3 with proper vsock communication support must be run for it to be useful.
But this restriction can be lifted once the approach about forwarding CID 3
messages is implemented if it gets accepted.

Thanks.

Regards,
Dorjoy

[1] https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html
[2] https://aws.amazon.com/ec2/
[3] https://docs.aws.amazon.com/enclaves/latest/user/getting-started.html
[4] https://docs.aws.amazon.com/enclaves/latest/user/getting-started.html
[5] https://github.com/aws/aws-nitro-enclaves-cli/blob/main/docs/ubuntu_20.04_how_to_install_nitro_cli_from_github_sources.md
[6] https://github.com/aws/aws-nitro-enclaves-cli/blob/main/examples/x86_64/hello/README.md

Dorjoy Chowdhury (2):
  machine/microvm: support for loading EIF image
  machine/nitro-enclave: new machine type for AWS nitro enclave

 MAINTAINERS                              |  10 +
 configs/devices/i386-softmmu/default.mak |   1 +
 docs/system/i386/nitro-enclave.rst       |  58 +++
 hw/i386/Kconfig                          |   4 +
 hw/i386/eif.c                            | 486 +++++++++++++++++++++++
 hw/i386/eif.h                            |  20 +
 hw/i386/meson.build                      |   3 +-
 hw/i386/microvm.c                        | 141 ++++++-
 hw/i386/nitro_enclave.c                  | 134 +++++++
 include/hw/i386/nitro_enclave.h          |  38 ++
 10 files changed, 893 insertions(+), 2 deletions(-)
 create mode 100644 docs/system/i386/nitro-enclave.rst
 create mode 100644 hw/i386/eif.c
 create mode 100644 hw/i386/eif.h
 create mode 100644 hw/i386/nitro_enclave.c
 create mode 100644 include/hw/i386/nitro_enclave.h

-- 
2.39.2


