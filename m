Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11B2CE7A91
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 19:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smIcw-0001O9-BZ; Thu, 05 Sep 2024 15:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1smIcs-000158-Sb
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:58:45 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1smIcY-0005SK-8c
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:58:39 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-205722ba00cso11931815ad.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 12:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725566301; x=1726171101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M3KKZe7ThyewA7ti6iiemriVuoI4xdMRGufcUwn0J3E=;
 b=JSEligg0JNn6qMH70u1JlyUiuI/pNWe2nLpMQLtpbDgLXSVG4yk/A7yQerYmFBsxPq
 lJnr2L5wO4w5Hkh5boEws9SMOK6IK2baw/5sjaJt55y5mPiF6iAniRL478d0ocHw9RTG
 9nt7sFnyKDMGZAXZVXdp4U8FzIb7RHxNdqT0KMjxFdV+LIhRiK8pOPESzqjfKwFxV3yo
 /hXPW9D+4E6LZYcbJy28ALkNQ4YLW7+1PdLsb+hyxwBWVNkyA+9M8e+oZkvsqMmy7cBi
 KOAExX3QrXtnpXcbLqdBF6kes5GsItZl8hBeRCB6QK9ln89j1aNzHXXwAiZpIqW/cvKZ
 +X5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725566301; x=1726171101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M3KKZe7ThyewA7ti6iiemriVuoI4xdMRGufcUwn0J3E=;
 b=vjqUurABc/ySU5Ypy8pzXWS7DgVKuGhSdxbleKwjsMyNbjBeiR2U0PIj7sSYBgaMD/
 6qT/sAkLBLCRYK+ipwFJJxeo0Bbuj7Hl3xRspvQ0Sl1y81GAy++vQlNttfY/MY6J3p91
 /VmUZCn7VscxlmFk1GVF2p+jJkPLaXII5AExfWLYBAZ5EmWuA0XqR9T+uQS3Kww2qWMR
 aIxDrMX5QC/6rVpw+jzyoREjKaDq1rXmTVXC2BivgVZJ06+3s9Dt8f04eSg1a0YxAw7h
 Hgo5ARMtcCWQpJ+irXfU1FxpNQKt0cd4Zl2rEF93XR3YemakTF/pM4i3js6UusMK6l2H
 V1Lg==
X-Gm-Message-State: AOJu0YzCjv9Y4bGGNIiJTbNY+XIOa698jwD5HJyjjgh9bn0ZHlu9Kep5
 dGYP4XVCv/POlmLMQwoU8y8hX0JkdtMSw+OCAQ1Ib3dOzhcpbS6yZgZKgQ==
X-Google-Smtp-Source: AGHT+IFasMPIN4ZSMTOJwjkpop5vykF0XcYdbJJC8Dk3d0up5xLEtCXVd+DYOgCXOxndS/BIcmt6gw==
X-Received: by 2002:a17:902:ea08:b0:202:43fa:52de with SMTP id
 d9443c01a7336-206f04f18f1mr2002485ad.13.1725566300686; 
 Thu, 05 Sep 2024 12:58:20 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.145])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206aea5554dsm32031355ad.235.2024.09.05.12.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 12:58:20 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v6 8/8] docs/nitro-enclave: Documentation for nitro-enclave
 machine type
Date: Fri,  6 Sep 2024 01:57:35 +0600
Message-Id: <20240905195735.16911-9-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240905195735.16911-1-dorjoychy111@gmail.com>
References: <20240905195735.16911-1-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pl1-x632.google.com
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

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 MAINTAINERS                        |  1 +
 docs/system/i386/nitro-enclave.rst | 78 ++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 docs/system/i386/nitro-enclave.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index e06aa4a5d7..7bce4979b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1887,6 +1887,7 @@ F: hw/core/eif.c
 F: hw/core/eif.h
 F: hw/i386/nitro_enclave.c
 F: include/hw/i386/nitro_enclave.h
+F: docs/system/i386/nitro-enclave.rst
 
 Machine core
 M: Eduardo Habkost <eduardo@habkost.net>
diff --git a/docs/system/i386/nitro-enclave.rst b/docs/system/i386/nitro-enclave.rst
new file mode 100644
index 0000000000..3fb9e06893
--- /dev/null
+++ b/docs/system/i386/nitro-enclave.rst
@@ -0,0 +1,78 @@
+'nitro-enclave' virtual machine (``nitro-enclave``)
+===================================================
+
+``nitro-enclave`` is a machine type which emulates an ``AWS nitro enclave``
+virtual machine. `AWS nitro enclaves`_ is an `Amazon EC2`_ feature that allows
+creating isolated execution environments, called enclaves, from Amazon EC2
+instances which are used for processing highly sensitive data. Enclaves have
+no persistent storage and no external networking. The enclave VMs are based
+on Firecracker microvm with a vhost-vsock device for communication with the
+parent EC2 instance that spawned it and a Nitro Secure Module (NSM) device
+for cryptographic attestation. The parent instance VM always has CID 3 while
+the enclave VM gets a dynamic CID. Enclaves use an EIF (`Enclave Image Format`_)
+file which contains the necessary kernel, cmdline and ramdisk(s) to boot.
+
+In QEMU, ``nitro-enclave`` is a machine type based on ``microvm`` similar to how
+``AWS nitro enclaves`` are based on ``Firecracker`` microvm. This is useful for
+local testing of EIF files using QEMU instead of running real AWS Nitro Enclaves
+which can be difficult for debugging due to its roots in security. The vsock
+device emulation is done using vhost-user-vsock which means another process that
+can do the userspace emulation, like `vhost-device-vsock`_ from rust-vmm crate,
+must be run alongside nitro-enclave for the vsock communication to work.
+
+``libcbor`` and ``gnutls`` are required dependencies for nitro-enclave machine
+support to be added when building QEMU from source.
+
+.. _AWS nitro enlaves: https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html
+.. _Amazon EC2: https://aws.amazon.com/ec2/
+.. _Enclave Image Format: https://github.com/aws/aws-nitro-enclaves-image-format
+.. _vhost-device-vsock: https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock
+
+Using the nitro-enclave machine type
+------------------------------
+
+Machine-specific options
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+It supports the following machine-specific options:
+
+- nitro-enclave.vsock=string (required) (Id of the chardev from '-chardev' option that vhost-user-vsock device will use)
+- nitro-enclave.id=string (optional) (Set enclave identifier)
+- nitro-enclave.parent-role=string (optional) (Set parent instance IAM role ARN)
+- nitro-enclave.parent-id=string (optional) (Set parent instance identifier)
+
+
+Running a nitro-enclave VM
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+First, run `vhost-device-vsock`_ (or a similar tool that supports vhost-user-vsock).
+The forward-cid option below with value 1 forwards all connections from the enclave
+VM to the host machine and the forward-listen (port numbers separated by '+') is used
+for forwarding connections from the host machine to the enclave VM.
+
+  $ vhost-device-vsock \
+     --vm guest-cid=4,forward-cid=1,forward-listen=9001+9002,socket=/tmp/vhost4.socket
+
+Now run the necessary applications on the host machine so that the nitro-enclave VM
+applications' vsock communication works. For example, the nitro-enclave VM's init
+process connects to CID 3 and sends a single byte hello heartbeat (0xB7) to let the
+parent VM know that it booted expecting a heartbeat (0xB7) response. So you must run
+a AF_VSOCK server on the host machine that listens on port 9000 and sends the heartbeat
+after it receives the heartbeat for enclave VM to boot successfully. You should run all
+the applications on the host machine that would typically be running in the parent EC2
+VM for successful communication with the enclave VM.
+
+Then run the nitro-enclave VM using the following command where ``hello.eif`` is
+an EIF file you would use to spawn a real AWS nitro enclave virtual machine:
+
+  $ qemu-system-x86_64 -M nitro-enclave,vsock=c,id=hello-world \
+     -kernel hello-world.eif -nographic -m 4G --enable-kvm -cpu host \
+     -chardev socket,id=c,path=/tmp/vhost4.socket
+
+In this example, the nitro-enclave VM has CID 4. If there are applications that
+connect to the enclave VM, run them on the host machine after enclave VM starts.
+You need to modify the applications to connect to CID 1 (instead of the enclave
+VM's CID) and use the forward-listen (e.g., 9001+9002) option of vhost-device-vsock
+to forward the ports they connect to.
+
+.. _vhost-device-vsock: https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock#using-the-vsock-backend
-- 
2.39.2


