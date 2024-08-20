Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0337DC531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgPt5-0002tL-Qe; Tue, 20 Aug 2024 10:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sgPsI-0001xc-JQ
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:30:20 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sgPsG-0001uj-UY
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:30:18 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2f3f0a31ab2so6157631fa.0
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 07:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724164215; x=1724769015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KdxPAmDEdUAtpsJzqv9PT9FKB3N+OoRAOYXGitcO7RQ=;
 b=H5h4oBu+8Bm7wLMOkmyP1pY2LoGx5SKmUBmPaoVbrjysmWZHrzwoi0fTTOAXO+qZ5b
 kiu8JrNbQ66iwOQshtEsyeMAnoZ5g2BzVgWDc+iKWSGOHuq1DfjNFf+akbDd4gg1NAgw
 oJXD85qUE2btrds8pAwlErMicNPhXUvz/ra/1sQ1ilT73auIhhq7HUYF8YoEWpmRpMUN
 LOBNqmFv38pIcH853L4yRb7unp2IXbwrq7nL52WO9JtUJkqfm930xS0G1RjlFOWfmZ5K
 2hSdRCS+5XnE+BKETtndA4AkBpQ5ZffWHGBqGJ494vOen1lp8Psj7OiwFQuOkjDcA+oI
 cxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724164215; x=1724769015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KdxPAmDEdUAtpsJzqv9PT9FKB3N+OoRAOYXGitcO7RQ=;
 b=Sc/iSEC1p0cyFaUgzJ6xJYCr2+UxruyKhi+gPOqHmRPDwjS6O6MGOQLiMtj09l4xZq
 t96sMJ/zM4eX+qkAnaA4rtyO1VgOKh++i5JyVPndOsoDSQBzlTzzpaLisGiTgA0YBE5l
 VK6rdb4Z+1/dhose5bw4rmGBdzsQivbNR1PkD77VsSM2vrmRKdivO6VG7mfn1EAQhXdW
 yGtlwojhSh9f2lL7giQZ1HJdBNsAgEfxLYcd7g9bUnyiBwg1EHJfwRasNZCRDn5IqKGX
 eNWo2IKx/3xgRXK2a2jsMVlhhXZYhFS1R97s3a2VU5YoD5/8aR5azxATnkEebDPmxCk5
 TGGg==
X-Gm-Message-State: AOJu0YyPHQmOPRU1TLExVqJLaIMQCuKRcUto7eTegvrmtz66HiKd5bE3
 lV8fniLB93SypsS9Da09SH8T8okutQAMWrMiAjGsKTjKrM8IxCQeBcJgt9sB
X-Google-Smtp-Source: AGHT+IH2aSjaMdTU2w0L6jdfmyJXJpGAlgjDdskYkq7lMNexOEvEkzPUF5ILk79x6nw61ZRcBw/gvA==
X-Received: by 2002:a05:6512:3195:b0:530:d088:233f with SMTP id
 2adb3069b0e04-5331c6d99c0mr9799180e87.40.1724164213973; 
 Tue, 20 Aug 2024 07:30:13 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5330d41ec8bsm1774535e87.217.2024.08.20.07.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 07:30:13 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 12/12] docs/system/i386: xenpvh: Add a basic description
Date: Tue, 20 Aug 2024 16:29:49 +0200
Message-ID: <20240820142949.533381-13-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820142949.533381-1-edgar.iglesias@gmail.com>
References: <20240820142949.533381-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x230.google.com
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
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 MAINTAINERS                 |  1 +
 docs/system/i386/xenpvh.rst | 49 +++++++++++++++++++++++++++++++++++++
 docs/system/target-i386.rst |  1 +
 3 files changed, 51 insertions(+)
 create mode 100644 docs/system/i386/xenpvh.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index c2fb0c2f42..c14ac014e2 100644
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


