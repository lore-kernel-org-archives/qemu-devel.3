Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE01C52D7C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2024 11:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfeK7-0003bs-Rl; Sun, 18 Aug 2024 07:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sfeK2-0003am-CQ
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 07:43:47 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sfeJr-0001bY-7V
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 07:43:45 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-70938328a0aso1789426a34.1
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 04:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723981413; x=1724586213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BpttYhHnPM+huelBNQ4yO/oz0L1BTguXsb4YaRzWkMg=;
 b=Jm+sDatnt+1q7hpclkZWYmBPvDkx5MAJyH5Jf3ktegxynhTrFKWkGX1FuTcrduIxU6
 DHhhpyCaQPoOk0WMpz6aucbeJ2433A4HryRlARLw4kKrF10Cs7oqm1ZmpO5qpxZCxvof
 1fhSw2OWoRY7Y9d4H/pYsWgHCJ4FxBNHqtkUYi458p4MIw2xumsq4mHAN7qIzu+AdqP+
 7b5zt1f7Q5XduB+sUc96vpUippPJ1Kg0NYqMot3JfIXLGzupncMLzHlHLQCvmkXJUh7U
 CTfXGBU/mgeG9gRasDL7jJJ2Qb4FV3o48y9QEl8MUW8ZMd4xzE8sdtsa3kh+31yZV968
 Soww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723981413; x=1724586213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BpttYhHnPM+huelBNQ4yO/oz0L1BTguXsb4YaRzWkMg=;
 b=R+c3cZzvoIPdYBq8geIIV1n5e9XH7pizmJZnKuD9z9SLLfChPAq5Dt+91nKI6onM4F
 fxakivFxz/pF0MFddY9r9bT5Y1lgyjyqOhSymMuGoWCYo2GKWwo9HaeOz4jIm1NJ9sKB
 prdS4CwclZ1uoM92ydYs91Vg3fsfRfh2uEsRP/L+E1BxA8US/KaBIb55/JsSashfyc44
 snvmztfvhXHY52vTOhvHTLlcZ7oDzgvszKTKZ3S0ojs3kfaTXaFJBWuEHEtZt3BEOGw0
 I3P9miTIYL+WKwneYh8fCKiWVn8jifZkgI7jaGdtFjNkkQqdnCaiLvHmlO6xi+lx+a0k
 rMag==
X-Gm-Message-State: AOJu0YyMYvlCsgVimB2DMYEgtkOMTGPGSjKl+aYo/VmOVW460iOTnu5Q
 XZzyRxDDHHFmkVL0sxg13TNQBtgqr1jVhtLWOcAHsrngMzBO2wqmTK3qBw==
X-Google-Smtp-Source: AGHT+IF1J4K3U9XS6GEFJOWEZIZ0oPYirSJvpkyZeRHTfC4wk6pHfoIMgCI2mlveufknE8CfxsBQ5g==
X-Received: by 2002:a05:6830:2656:b0:708:f88a:e3e7 with SMTP id
 46e09a7af769-70cac8d4e13mr12141825a34.34.1723981413510; 
 Sun, 18 Aug 2024 04:43:33 -0700 (PDT)
Received: from localhost.localdomain ([103.103.35.174])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3e2c61fe4sm5303617a91.4.2024.08.18.04.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Aug 2024 04:43:33 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com, pbonzini@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v4 6/6] docs/nitro-enclave: Documentation for nitro-enclave
 machine type
Date: Sun, 18 Aug 2024 17:42:57 +0600
Message-Id: <20240818114257.21456-7-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240818114257.21456-1-dorjoychy111@gmail.com>
References: <20240818114257.21456-1-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=dorjoychy111@gmail.com; helo=mail-ot1-x32b.google.com
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

---
 docs/system/i386/nitro-enclave.rst | 82 ++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 docs/system/i386/nitro-enclave.rst

diff --git a/docs/system/i386/nitro-enclave.rst b/docs/system/i386/nitro-enclave.rst
new file mode 100644
index 0000000000..291a8ae357
--- /dev/null
+++ b/docs/system/i386/nitro-enclave.rst
@@ -0,0 +1,82 @@
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


