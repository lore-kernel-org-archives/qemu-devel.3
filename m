Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF91BD767F4
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZNj-0004Cp-Cf; Thu, 31 Oct 2024 13:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMJ-0001fw-0B
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMG-0007OP-LT
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VPdQs/eU0eLxHZX4ykpj4J7dasQCSGu9C84+ZaDA+gc=;
 b=JVqViZxhfZhSnJjs47uNX24NDtWGiGeUcpdggv+xLUw1e11UOCMVPqaMFHmpk6UzfvHMN0
 i7hjDDNlygTKhMjSRXfoil3BxJYyaBbbEwpam/nb5lpwSXsad3KbQJ55XKe4pZEdij6j9i
 1Wck+Bt47NHJ713iPSVJfb4I3anOjQ0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-CT4qfynaPRCHK7tDfbhKbQ-1; Thu, 31 Oct 2024 13:53:17 -0400
X-MC-Unique: CT4qfynaPRCHK7tDfbhKbQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d5ca5bfc8so583455f8f.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397195; x=1731001995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VPdQs/eU0eLxHZX4ykpj4J7dasQCSGu9C84+ZaDA+gc=;
 b=UWw+Cb2I0iuPBmHp+ZxHwhZ/0A9tWFpKK+cjjcq3ithVWCbx7r2AfSx9DiWQU2FUN2
 4TfvC1D1MVxvhh6wpCrgjiiE1+HnLcTy5FM8wlRafmPrGLbUpJFN7L+dk+htosocFQVj
 Y7A1xe0cq26JBzG/l3hEdxIl32lOR2Y8zKxeARG8+xjLrH1od/JiXSfOG9m2+H/exoUr
 E7smS9UzcjZJvhdsILNP80ygeJzjy+4wuNGpdA3Eu2ZFL0ta+9BCyJKsFhTMJQ7lD87j
 Ik6GUBpKfBlbu8mbT6Dwe15sOpS8mqWx5YadzTr+ApLi2TWypEAiy6SOTD/KJDVG9O9w
 XzuA==
X-Gm-Message-State: AOJu0YwwUYajK2MWFp7WOS461UOlGrtpSLd23qsTZ9/0/jNOiHKsVi4L
 ZzmKaHMXc6y9yktbgxnLvXxMHNkDXegfkQiRlqRrQVWr1sjDsliX7Yeae4Vfl1h7KLYwJBhdMal
 zfKOnJNLkbee04QnWp1vfNQko2gAFuHUqt3HqMnQo+cYTQBKdo+TKRjRz54FNgBYcDyiiXlCxu7
 fZRvLDSnyl5dQnnmkUjiY3jRqeTzJpo1qI/wh9he4=
X-Received: by 2002:a05:6000:1ac5:b0:37c:d276:f04 with SMTP id
 ffacd0b85a97d-381be906dbamr3451981f8f.45.1730397195238; 
 Thu, 31 Oct 2024 10:53:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnp+JE9WB9iiSVp/nMFau7nPBpO7tMJagEWLsKexTz1ytY1iq8/9NZvigzmhFLnJtoxarSXQ==
X-Received: by 2002:a05:6000:1ac5:b0:37c:d276:f04 with SMTP id
 ffacd0b85a97d-381be906dbamr3451952f8f.45.1730397194704; 
 Thu, 31 Oct 2024 10:53:14 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116abf3sm2787225f8f.101.2024.10.31.10.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:53:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, Alexander Graf <graf@amazon.com>
Subject: [PULL 26/49] docs/nitro-enclave: Documentation for nitro-enclave
 machine type
Date: Thu, 31 Oct 2024 18:51:50 +0100
Message-ID: <20241031175214.214455-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Dorjoy Chowdhury <dorjoychy111@gmail.com>

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Reviewed-by: Alexander Graf <graf@amazon.com>
Link: https://lore.kernel.org/r/20241008211727.49088-7-dorjoychy111@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                        |  1 +
 docs/system/i386/nitro-enclave.rst | 78 ++++++++++++++++++++++++++++++
 docs/system/target-i386.rst        |  3 +-
 tests/qtest/libqtest.c             |  3 +-
 4 files changed, 83 insertions(+), 2 deletions(-)
 create mode 100644 docs/system/i386/nitro-enclave.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d3501ac289..4e5018a5e19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1842,6 +1842,7 @@ F: hw/core/eif.c
 F: hw/core/eif.h
 F: hw/i386/nitro_enclave.c
 F: include/hw/i386/nitro_enclave.h
+F: docs/system/i386/nitro-enclave.rst
 
 Machine core
 M: Eduardo Habkost <eduardo@habkost.net>
diff --git a/docs/system/i386/nitro-enclave.rst b/docs/system/i386/nitro-enclave.rst
new file mode 100644
index 00000000000..73e3edefe5b
--- /dev/null
+++ b/docs/system/i386/nitro-enclave.rst
@@ -0,0 +1,78 @@
+'nitro-enclave' virtual machine (``nitro-enclave``)
+===================================================
+
+``nitro-enclave`` is a machine type which emulates an *AWS nitro enclave*
+virtual machine. `AWS nitro enclaves`_ is an Amazon EC2 feature that allows
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
+AWS nitro enclaves are based on `Firecracker`_ microvm. This is useful for
+local testing of EIF files using QEMU instead of running real AWS Nitro Enclaves
+which can be difficult for debugging due to its roots in security. The vsock
+device emulation is done using vhost-user-vsock which means another process that
+can do the userspace emulation, like `vhost-device-vsock`_ from rust-vmm crate,
+must be run alongside nitro-enclave for the vsock communication to work.
+
+``libcbor`` and ``gnutls`` are required dependencies for nitro-enclave machine
+support to be added when building QEMU from source.
+
+.. _AWS nitro enclaves: https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html
+.. _Enclave Image Format: https://github.com/aws/aws-nitro-enclaves-image-format
+.. _vhost-device-vsock: https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock
+.. _Firecracker: https://firecracker-microvm.github.io
+
+Using the nitro-enclave machine type
+------------------------------------
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
+First, run `vhost-device-vsock`__ (or a similar tool that supports vhost-user-vsock).
+The forward-cid option below with value 1 forwards all connections from the enclave
+VM to the host machine and the forward-listen (port numbers separated by '+') is used
+for forwarding connections from the host machine to the enclave VM.
+
+__ https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock#using-the-vsock-backend
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
diff --git a/docs/system/target-i386.rst b/docs/system/target-i386.rst
index 23e84e3ba76..ab7af1a75d6 100644
--- a/docs/system/target-i386.rst
+++ b/docs/system/target-i386.rst
@@ -14,8 +14,9 @@ Board-specific documentation
 .. toctree::
    :maxdepth: 1
 
-   i386/microvm
    i386/pc
+   i386/microvm
+   i386/nitro-enclave
 
 Architectural features
 ~~~~~~~~~~~~~~~~~~~~~~
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 9d07de1fbd4..817fd7aac52 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1648,7 +1648,8 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
         /* Ignore machines that cannot be used for qtests */
         if (!strncmp("xenfv", machines[i].name, 5) ||
             g_str_equal("xenpv", machines[i].name) ||
-            g_str_equal("xenpvh", machines[i].name)) {
+            g_str_equal("xenpvh", machines[i].name) ||
+            g_str_equal("nitro-enclave", machines[i].name)) {
             continue;
         }
         if (!skip_old_versioned ||
-- 
2.47.0


