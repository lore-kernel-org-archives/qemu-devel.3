Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AF1CF0423
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 21:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syHau-00019o-BN; Tue, 08 Oct 2024 17:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1syHal-00012B-Mn
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 17:18:04 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1syHaj-0000Jx-TI
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 17:18:03 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71df8585a42so2662331b3a.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 14:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728422280; x=1729027080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0kS8YQwczBgf+RqDUfbpUQqBA8yPAv6c2JTRX1QDMoA=;
 b=TIxW9QtgRMoQq6wH1ra+r2S9PYwOw9NwnCGBAsLsAakfJXJfu+SURcVJ1mPmErDIcW
 WrLijH7U4JMQp2mN2ZKZMchnFi/2nTh3e5zIMkppvLAlpAMe9wsmKFfFGhLPJvTsBP4K
 fwsqgYxvPzxp8mSIzu0k17nCDO+8gFtgbQKMKTjxaOKe4ECGuPQyZySppi7MhKMj98yV
 nyv+8HXHnzGrxspJg+sWjAJaC6dMCOQ6oHskMbgX6m/QQ/ExgdjJN/iKk3L6H89SjT86
 hhlBOeviBFNdOzSpmoUf/W/Fh/QMxSPYt8+hQAVt12mTpa+zp4/HRbamw74BJA9HQlFY
 ROIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728422280; x=1729027080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0kS8YQwczBgf+RqDUfbpUQqBA8yPAv6c2JTRX1QDMoA=;
 b=nID9NUde6D4gx/OP7p0VkPsqxxYS2rbWf02SczfRiOR+k+8Wd4yy/TBBkzygMkl3gv
 ffQkE//xmNrXg33NxQaVYvLwswGR93YLB1sIs0ZiP0PntcvzbVhSgcPQXyOqX8i7hOtK
 Ej9L6vs7JB7pB8SAut0JHaViIa0BYJV+2roBiZzwCo9HKzAu20RyR+hyLcWqJyM4Nfec
 Fny7246epAmj4ZbyMkUXDMD9ZLCs4zJGQitfomF07i8vmW6C7lhXZ0ci5xtmn0cdDrf0
 neOdZpGWefXZHFBGpH5dS4+XGcWGcRiQnlscraPx7HgM8Aiz/3xj6zEf3/sMV4DdeMfx
 7B9g==
X-Gm-Message-State: AOJu0Yxofddzeq/5XyjI2peJoCyu/eOJj2lCEoS5Be0bjaPVRqhFeo/R
 J4AU5s3Iojx7U0EIkPZhuoSk5KddMJbNGAFPX8bRmpRwl3+tos5O03s2PQ==
X-Google-Smtp-Source: AGHT+IHAUmEMQwHSxKenGR6p99nTbHvZwElWnP+Iw3yuQ12g1/LT9T+0aEa1onFKTeEj9Pp37wdvWw==
X-Received: by 2002:a05:6a20:e18a:b0:1cf:3b22:fec3 with SMTP id
 adf61e73a8af0-1d8a3c1d7d2mr398900637.24.1728422280193; 
 Tue, 08 Oct 2024 14:18:00 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.151])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d6254dsm6549078b3a.153.2024.10.08.14.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 14:17:59 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v8 6/6] docs/nitro-enclave: Documentation for nitro-enclave
 machine type
Date: Wed,  9 Oct 2024 03:17:27 +0600
Message-Id: <20241008211727.49088-7-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241008211727.49088-1-dorjoychy111@gmail.com>
References: <20241008211727.49088-1-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pf1-x429.google.com
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

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 MAINTAINERS                        |  1 +
 docs/system/i386/nitro-enclave.rst | 78 ++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 docs/system/i386/nitro-enclave.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index f78a7cca06..a857e056e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1827,6 +1827,7 @@ F: hw/core/eif.c
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
2.39.5


