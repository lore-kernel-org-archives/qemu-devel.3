Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1F3C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2024 16:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDRZh-0007GX-Oa; Sat, 01 Jun 2024 12:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sDRZf-0007G0-V7
 for qemu-devel@nongnu.org; Sat, 01 Jun 2024 12:27:20 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sDRZb-00087g-N9
 for qemu-devel@nongnu.org; Sat, 01 Jun 2024 12:27:19 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2c19e6dc3dcso2510244a91.3
 for <qemu-devel@nongnu.org>; Sat, 01 Jun 2024 09:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717259233; x=1717864033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xER6H6NzgHpq+OoBUqFWjmpCJjIEyZyHlES1+BdDmHY=;
 b=m3oVbLl0Y5xLyQTgl3XEzJ3Df2+zthRRE4T72LfUSxODA1OvOHp1r8RphKtzBjPVdU
 gC60HjiRXJ1QlucQSP2vgFLxwAYRR2qWLb0z2CEsxvzckir0Yce3/OsEN9pUf/M1W+lt
 d7erIQL8C/o4Mw7IVJHEdv4r344v7hzGZP97IW8xRrxXEYU0uzTcCjo4LtlG39mJCMIM
 X6ybwVAzYuURs6axjoKount4xujn9R3SARdeDMSRBFJiHnbAma/iGTsSpcB5fAd6JWJp
 vFjv2PFHXOpgQ9/bIQWOFuMdHMdM7F0tVfZeklxO7chvn5474gd1wqXG6IB/mF9ft3+I
 7AUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717259233; x=1717864033;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xER6H6NzgHpq+OoBUqFWjmpCJjIEyZyHlES1+BdDmHY=;
 b=NdX5mbgBsP3y2asHQMbRqow7Sker2vBs7AFXhAF239vSlD/DWa5oeXfNQ81qgSpjrp
 1fQoVLt49oxXMeIvKNiENqrKjqqkyg7pOtUNRAv8ATatnPSMqNQjpeyJ02eH5i3AH2Bd
 nSQ+oRrP3xiVChRvZK5Exan8CSFqAgvZ9x7hWqQvnEayn0iRzeR4RL1qVZaUylrPkD1E
 R5reeeKTbtJ+hARSUbyREVnoufMvR6FiCfqP8Br8wO5bbHYg+VefgoE8JYMhR1GaQHGh
 Vo8XlS22Jd+vjWqaXMkTLUMDCsBRqeqkFZvakttkvTtKp0Bw5ZIah1uGkEt6Eulq+UWx
 rUlw==
X-Gm-Message-State: AOJu0Yx1ES7MFPeVpHfTA3W5KKW9kNWFkiitSyAUIxS4FgNbflq16NwD
 j4Xho0io7PO62zhfA8zDTeyi/tkfEn3M7aY7HLO6gElgqeqXZVAndpFce9D0
X-Google-Smtp-Source: AGHT+IFu9BNEu5rTlIuHtCAF/5pqElB7lpkD62rImzlxMSZ1tEF79y4Qs3mtITK1nhuE+ILo5Gpjsg==
X-Received: by 2002:a17:90a:f2c3:b0:2bd:f968:da46 with SMTP id
 98e67ed59e1d1-2c1dc58eb3amr4045764a91.27.1717259232473; 
 Sat, 01 Jun 2024 09:27:12 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1c27ad3cesm3285036a91.7.2024.06.01.09.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Jun 2024 09:27:11 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v2 0/2] AWS Nitro Enclave emulation
Date: Sat,  1 Jun 2024 22:26:50 +0600
Message-Id: <20240601162652.55643-1-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pj1-x1034.google.com
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

This is v2 submission for AWS Nitro Enclave emulation in QEMU. v1 is at:
https://mail.gnu.org/archive/html/qemu-devel/2024-05/msg03524.html

Changes in v2:
    - moved eif.c and eif.h files from hw/i386 to hw/core

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
[4] https://github.com/aws/aws-nitro-enclaves-image-format
[5] https://github.com/aws/aws-nitro-enclaves-cli/blob/main/docs/ubuntu_20.04_how_to_install_nitro_cli_from_github_sources.md
[6] https://github.com/aws/aws-nitro-enclaves-cli/blob/main/examples/x86_64/hello/README.md

Dorjoy Chowdhury (2):
  machine/microvm: support for loading EIF image
  machine/nitro-enclave: new machine type for AWS nitro enclave

 MAINTAINERS                              |  10 +
 configs/devices/i386-softmmu/default.mak |   1 +
 docs/system/i386/nitro-enclave.rst       |  58 +++
 hw/core/eif.c                            | 486 +++++++++++++++++++++++
 hw/core/eif.h                            |  20 +
 hw/core/meson.build                      |   1 +
 hw/i386/Kconfig                          |   4 +
 hw/i386/meson.build                      |   1 +
 hw/i386/microvm.c                        | 141 ++++++-
 hw/i386/nitro_enclave.c                  | 134 +++++++
 include/hw/i386/nitro_enclave.h          |  38 ++
 11 files changed, 893 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/i386/nitro-enclave.rst
 create mode 100644 hw/core/eif.c
 create mode 100644 hw/core/eif.h
 create mode 100644 hw/i386/nitro_enclave.c
 create mode 100644 include/hw/i386/nitro_enclave.h

-- 
2.39.2


