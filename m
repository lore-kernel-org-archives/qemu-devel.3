Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C958C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 15:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh9Ry-0000uv-5A; Thu, 22 Aug 2024 11:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sh9Rv-0000ao-Hf
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 11:10:07 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sh9Rs-0005D6-IY
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 11:10:06 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71439adca73so593553b3a.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 08:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724339403; x=1724944203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C+tKt5A2xkc4zSdNubRVhA8MqjwLBWMFSUXPn4nm9SI=;
 b=NUwDqWKaZ96Lyz6Zw1rIPOuy8gjGH6prDaChBI3bI48AVqIVUenvMva/nOX98aJmBt
 obt8SeSpO7EyBKO53a9sEEHvC3MgsjKH4RglTS4+3YN7luj3BQ97QQiBMP2Ae401Ei8k
 bxss2xrZ4HhWtISm/fIHyJjRO7imIyNErlOg/LlMxHj9A2NrAMRkn0qh4Zk8E2/gAG5p
 LoBqVIV1WEHEUZPS57CTD6S4JeLKZhRT8Zsrgz10uN6E8jz85LBVCtkZzOn4+cUe+SAA
 CXrgclJBlC4h0Ikr1sDZV6+WXa7zB1grkb5V0lw5i0nAY8JunW7uUGGlcjJJwqFNkecv
 RyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724339403; x=1724944203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C+tKt5A2xkc4zSdNubRVhA8MqjwLBWMFSUXPn4nm9SI=;
 b=O0dVyOvgfu5M5cKPI7GR6ohM4CCDW8MERT7o7kmf1Jr7OsqCjC9Yqw20UjeJ0Ek2HB
 sy9pPrJTRkNflFhdn+/lBYEslGFmQIujGwgy8mLCT+Jaas5K5i5tUuuCj0eGBilZKoBf
 nA/csgtzQnLszgAaGp8cjuH2MxlMG6VOFhVrA1xdUQEdHli+KdMb2PamnjUNnLhZNe0Q
 mQsEZsizKNNBpv+9W5/3TKvmaJz7GRcNXKmTqEorRwLaFPPhMJNxdFbCMHv1xDBfpH4f
 XKo3z7RcDnJRTUO+yERM6omKFaHlvk2YFc1ayBJGaMGDJsvETwzWTJypho7ClzMM6BAG
 ouIQ==
X-Gm-Message-State: AOJu0Ywx7irOQZxRzKqTh4k5qj0wZy2jxxqOMcaSC9LLTlXXpezzDprU
 j4zdaDyJQaZ6ZuwoAm3jvZCHcczSmKDKjN4loJPq4s0Q0AFF5H7D/c0JAQ==
X-Google-Smtp-Source: AGHT+IHG44E7WUwshdv0brLX+eGXs6E91pzQe8j/zIkhF/rOrnFHHqxWmNgFsQKCXCnqPyJ9tq/CmA==
X-Received: by 2002:a17:90a:ce14:b0:2cf:c9ab:e727 with SMTP id
 98e67ed59e1d1-2d5e9ec96b5mr6515368a91.31.1724339402624; 
 Thu, 22 Aug 2024 08:10:02 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.175])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d613919fd2sm1991567a91.13.2024.08.22.08.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 08:10:02 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v5 8/8] docs/nitro-enclave: Documentation for nitro-enclave
 machine type
Date: Thu, 22 Aug 2024 21:08:49 +0600
Message-Id: <20240822150849.21759-9-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822150849.21759-1-dorjoychy111@gmail.com>
References: <20240822150849.21759-1-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pf1-x42b.google.com
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
 docs/system/i386/nitro-enclave.rst | 85 ++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 docs/system/i386/nitro-enclave.rst

diff --git a/docs/system/i386/nitro-enclave.rst b/docs/system/i386/nitro-enclave.rst
new file mode 100644
index 0000000000..966691c396
--- /dev/null
+++ b/docs/system/i386/nitro-enclave.rst
@@ -0,0 +1,85 @@
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
+First, run vhost-device-vsock (or a similar tool that supports vhost-user-vsock)
+
+  $ vhost-device-vsock \
+     --vm guest-cid=4,uds-path=/tmp/vm4.vsock,socket=/tmp/vhost4.socket \
+     --vm guest-cid=3,uds-path=/tmp/vm3.vsock,socket=/tmp/vhost3.socket
+
+Then, run the parent VM that has the necessary vsock communication support.
+
+  $ qemu-system-x86_64 -machine q35,memory-backend=mem0 -enable-kvm -m 8G \
+     -nic user,model=virtio -drive file=test_vm.qcow2,media=disk,if=virtio \
+     --display sdl -object memory-backend-memfd,id=mem0,size=8G \
+     -chardev socket,id=char0,reconnect=0,path=/tmp/vhost3.socket \
+     -device vhost-user-vsock-pci,chardev=char0
+
+Inside this VM the necessary applications should be run so that the nitro-enclave
+VM applications' vsock communication works. For example, the nitro-enclave VM's
+init process connects to CID 3 and sends a single byte hello heartbeat (0xB7) to
+let the parent VM know that it booted expecting a heartbeat (0xB7) response.
+
+Now run the nitro-enclave VM using the following command where ``hello.eif`` is
+an EIF file you would use to spawn a real AWS nitro enclave virtual machine:
+
+  $ qemu-system-x86_64 -M nitro-enclave,vsock=c,id=hello-world \
+     -kernel hello-world.eif -nographic -m 4G --enable-kvm -cpu host \
+     -chardev socket,id=c,path=/tmp/vhost4.socket
+
+In this example, the nitro-enclave VM has CID 4.
+
+
+Limitations
+-----------
+
+AWS nitro enclave emulation support in QEMU requires users to run vhost-device-vsock
+or similar tool for vhost-user-vsock support and another VM with CID 3 with necessary
+vsock communication support. Requirement of running another VM and necessary applications
+inside it can be lifted if some proxying support is added to vhost-device-vsock to
+forward all packets to the host machine, in which case, users can run the necessary
+applications in the host machine instead of the parent VM with CID 3.
-- 
2.39.2


