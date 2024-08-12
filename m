Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EF3C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 13:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdUl2-0004s6-8T; Mon, 12 Aug 2024 09:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sdUkz-0004jC-Re
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 09:06:41 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sdUku-00047w-Jh
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 09:06:39 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ef2cce8be8so46637901fa.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 06:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723467993; x=1724072793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKBi8KqYhGDFlqsXHx9Zw2bI17GecQkQjZL9UWM7DqA=;
 b=ENr8ymcmNgj1khfmppTxJ2xywUieaXcm6qSao96G9KwRrQ4jKI6cqKrO6ms2ayRRFb
 2BrTV9bKn2yKs7PDyk92IEHwKW9xK2DWxI+d1GfriZDBN7R/f7b6BipQbkM1YXXxLw0O
 /V5PuTJ3fN6jcLh+NEETrQ4ObHDJd0JRgWES+8Y3r53JbFR/xMx392EpeY65ZsXcX/a1
 ofuo1n6AeDa3gD4eCk53oi+n5L0uhn2Yo8AZn0mnjV8Q49Eyyy1BTdChDQsAzSXbTP8T
 Rmnq9ZXpwKFO8LaneS5ajl4ahap5vU3pylV+cGTGXHpEIP822oov6fxAK8iWGq7ZFct8
 6e3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723467993; x=1724072793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mKBi8KqYhGDFlqsXHx9Zw2bI17GecQkQjZL9UWM7DqA=;
 b=jGBHEbyujCl3LmvheFqja89dKhMXPCnTbuguPlSX/XEUFDfiowt4tZ+XvQBpwvhtGP
 4nPPTaDVJaFzBQrLJaU5/sHTWDuWOVhOp8R5AOEYK3bYi4nr30pPycirB1zES9u+2ObW
 ca1oAa6N8QLmWPbZglzW39sGEoxUdmEhSbYfEFb3a6kIvFMS7v/MyASvYTu3UrT+zH0u
 5ozdNYAVy038LCQ2ey9Sy57X1tqOi1u/bLZomKxKI3VnFdKbgTjg83LA0PCI4zTbz1mX
 fXP6sHQ2401Fxokc6uTK1oVbEpp5c+Kb+WpA7EFs/epl5BtVnCfRLl2M2IxXIk2WnGoh
 w5Lw==
X-Gm-Message-State: AOJu0YyoohgtFC6NBBXA9edRFx8IMlKydsPHcubOMsxa3xd3rJt750n8
 vnX14A7UGWoXLe2ceimG7jrsAf4vgOPKG/Cxlmk7N9jsfPAGBtPDveEcaf11
X-Google-Smtp-Source: AGHT+IFc8uBG8fAqe8QiFu7qL5vOSuGxpFRzQNhkfUh2olLgNFB3zwVq8FCW9cJURrXcMaKyPvPWuQ==
X-Received: by 2002:a2e:9c10:0:b0:2ef:22bc:6fb0 with SMTP id
 38308e7fff4ca-2f2b7179ecbmr1400471fa.34.1723467992891; 
 Mon, 12 Aug 2024 06:06:32 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2f29203d7ebsm8631921fa.83.2024.08.12.06.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 06:06:31 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 10/10] docs/system/i386: xenpvh: Add a basic description
Date: Mon, 12 Aug 2024 15:06:05 +0200
Message-ID: <20240812130606.90410-11-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812130606.90410-1-edgar.iglesias@gmail.com>
References: <20240812130606.90410-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 MAINTAINERS                 |  1 +
 docs/system/i386/xenpvh.rst | 49 +++++++++++++++++++++++++++++++++++++
 docs/system/target-i386.rst |  1 +
 3 files changed, 51 insertions(+)
 create mode 100644 docs/system/i386/xenpvh.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index a24c2e14d9..da4c9d4d46 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -560,6 +560,7 @@ F: include/sysemu/xen.h
 F: include/sysemu/xen-mapcache.h
 F: stubs/xen-hw-stub.c
 F: docs/system/arm/xenpvh.rst
+F: docs/system/i386/xenpvh.rst
 
 Guest CPU Cores (NVMM)
 ----------------------
diff --git a/docs/system/i386/xenpvh.rst b/docs/system/i386/xenpvh.rst
new file mode 100644
index 0000000000..354250f073
--- /dev/null
+++ b/docs/system/i386/xenpvh.rst
@@ -0,0 +1,49 @@
+Xen PVH machine (``xenpvh``)
+=========================================
+
+Xen supports a spectrum of types of guests that vary in how they depend
+on HW virtualization features, emulation models and paravirtualization.
+PVH is a mode that uses HW virtualization features (like HVM) but tries
+to avoid emulation models and instead use passthrough or
+paravirtualized devices.
+
+QEMU can be used to provide PV virtio devices on an emulated PCIe controller.
+That is the purpose of this minimal machine.
+
+Supported devices
+-----------------
+
+The x86 Xen PVH QEMU machine provide the following devices:
+
+- RAM
+- GPEX host bridge
+- virtio-pci devices
+
+The idea is to only connect virtio-pci devices but in theory any compatible
+PCI device model will work depending on Xen and guest support.
+
+Running
+-------
+
+The Xen tools will typically construct a command-line and launch QEMU
+for you when needed. But here's an example of what it can look like in
+case you need to construct one manually:
+
+.. code-block:: console
+
+    qemu-system-i386 -xen-domid 3 -no-shutdown        \
+      -chardev socket,id=libxl-cmd,path=/var/run/xen/qmp-libxl-3,server=on,wait=off \
+      -mon chardev=libxl-cmd,mode=control             \
+      -chardev socket,id=libxenstat-cmd,path=/var/run/xen/qmp-libxenstat-3,server=on,wait=off \
+      -mon chardev=libxenstat-cmd,mode=control        \
+      -nodefaults                                     \
+      -no-user-config                                 \
+      -xen-attach -name g0                            \
+      -vnc none                                       \
+      -display none                                   \
+      -device virtio-net-pci,id=nic0,netdev=net0,mac=00:16:3e:5c:81:78 \
+      -netdev type=tap,id=net0,ifname=vif3.0-emu,br=xenbr0,script=no,downscript=no \
+      -smp 4,maxcpus=4                                \
+      -nographic                                      \
+      -machine xenpvh,ram-low-base=0,ram-low-size=2147483648,ram-high-base=4294967296,ram-high-size=2147483648,pci-ecam-base=824633720832,pci-ecam-size=268435456,pci-mmio-base=4026531840,pci-mmio-size=33554432,pci-mmio-high-base=824902156288,pci-mmio-high-size=68719476736 \
+      -m 4096
diff --git a/docs/system/target-i386.rst b/docs/system/target-i386.rst
index 1b8a1f248a..23e84e3ba7 100644
--- a/docs/system/target-i386.rst
+++ b/docs/system/target-i386.rst
@@ -26,6 +26,7 @@ Architectural features
    i386/cpu
    i386/hyperv
    i386/xen
+   i386/xenpvh
    i386/kvm-pv
    i386/sgx
    i386/amd-memory-encryption
-- 
2.43.0


