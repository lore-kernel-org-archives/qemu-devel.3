Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258C7C54791
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 01:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjUGy-00018T-SL; Sun, 10 Mar 2024 21:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rjUGx-00016O-Sy; Sun, 10 Mar 2024 21:16:11 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rjUGv-0004g9-LH; Sun, 10 Mar 2024 21:16:11 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e655a12c81so2761986b3a.1; 
 Sun, 10 Mar 2024 18:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710119767; x=1710724567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DBw4kk6c+Yv+z25mHpFpfys753Tg8G+xM3yDnaDirPs=;
 b=evMF8XqON5HYUvbSg1dhgICwEBHfMltGZT3cEMAbQ3IhVjwwsG9sob3qdJALs8z61K
 5y+qhPLvl7F42QJhOQla/ogpPiKMeuwRdtUHb6mVjdRwgOdjrtBOfN9AvXlL18DMXpBx
 KLCkjxnWnDSyv0JO87gyVgsASm28zpM8W+FkdvSlpo9cQESwmp14ajJUxt5OowfRzPz4
 O4KUoW3NMEYfJ4YeVADOphQDfezUvMlx9UZmuS8zQI8RES268Py89+3iMt+VPAFsGNHB
 xhyEUmMr0/j9EdaAnzVA5DYaIiZG8bpZC8Cv+dDVDZ8O6tdhli6buLKLm99x+0KvTaex
 v3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710119767; x=1710724567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DBw4kk6c+Yv+z25mHpFpfys753Tg8G+xM3yDnaDirPs=;
 b=DUjPWXRcyEstF1NhG4RGOd8gSYiXSqUSVw9nCrhN6e2XE0VlwPq9KHYSS8BmG4HHqf
 m/w9ea8npp6O2gEDeRlqUBUN9HIUUFCimHgzb4mZbVNU/8WpHb9R65aTTtHIn1LAtZT2
 ea2OnFLSST+eVz+PM7CbEEiPRNoUFzozBJCOJL9sQ2vgCKQC+WzH6MOs/1fSQ95FltjS
 usUEsEJw8H14dhGFbhYLzY1XrZqn7GbzEP6SCVsWIdD7SzZpfCieNTCzE5ENRr/9Lk0m
 wNgpxhNjSu4R/8AdbfpWR98ECKfptX7YR4kJxoBmsbs3VUVf8kV1MkXVintZ8l+m1QSJ
 l+bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGhsppfyK/kQ2gIx9lG8wGvPCaJKVaIai+09eWiFE8EaK0h9uTwx00Jq+WO2fwiSrqpIF/5fhZOmsYT8rN2H79P32FTxc=
X-Gm-Message-State: AOJu0Yy6jrtv8Y3A9lmNzz+sGvIq/pD3ZG1eZw2oeYZL/ptHToV7cP5m
 owv/wvxv+vNz30IkIcnLVkMpVxIvKXgqP1Pz/3Nu82xnuOWKiTY2IFcT8D+s
X-Google-Smtp-Source: AGHT+IGvtgKvjhi9mxVV5dUcEMA52hLpKfM7VSKSjzMXokR9Oxu4+Kkp4MpXcRX46xwBBVMUTtKp2A==
X-Received: by 2002:a05:6a20:8e24:b0:1a3:d48:6eef with SMTP id
 y36-20020a056a208e2400b001a30d486eefmr4788443pzj.31.1710119767444; 
 Sun, 10 Mar 2024 18:16:07 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a8-20020a62bd08000000b006e68984419asm92116pff.105.2024.03.10.18.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Mar 2024 18:16:06 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org, Jonathan.Cameron@Huawei.com, jiewen.yao@intel.com,
 mst@redhat.com, hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
 marcel.apfelbaum@gmail.com, lukas@wunner.de, its@irrelevant.dk,
 wilfred.mallawa@wdc.com, kbusch@kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, alistair23@gmail.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v6 3/3] hw/nvme: Add SPDM over DOE support
Date: Mon, 11 Mar 2024 11:15:37 +1000
Message-ID: <20240311011537.65043-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311011537.65043-1-alistair.francis@wdc.com>
References: <20240311011537.65043-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Setup Data Object Exchance (DOE) as an extended capability for the NVME
controller and connect SPDM to it (CMA) to it.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Klaus Jensen <k.jensen@samsung.com>
---
 docs/specs/index.rst        |   1 +
 docs/specs/spdm.rst         | 122 ++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci_device.h |   5 ++
 include/hw/pci/pcie_doe.h   |   3 +
 hw/nvme/ctrl.c              |  57 +++++++++++++++++
 5 files changed, 188 insertions(+)
 create mode 100644 docs/specs/spdm.rst

diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index 1484e3e760..e2d907959a 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -29,6 +29,7 @@ guest hardware that is specific to QEMU.
    edu
    ivshmem-spec
    pvpanic
+   spdm
    standard-vga
    virt-ctlr
    vmcoreinfo
diff --git a/docs/specs/spdm.rst b/docs/specs/spdm.rst
new file mode 100644
index 0000000000..06b5ccac09
--- /dev/null
+++ b/docs/specs/spdm.rst
@@ -0,0 +1,122 @@
+======================================================
+QEMU Security Protocols and Data Models (SPDM) Support
+======================================================
+
+SPDM enables authentication, attestation and key exchange to assist in
+providing infrastructure security enablement. It's a standard published
+by the `DMTF`_.
+
+QEMU supports connecting to a SPDM responder implementation. This allows an
+external application to emulate the SPDM responder logic for an SPDM device.
+
+Setting up a SPDM server
+========================
+
+When using QEMU with SPDM devices QEMU will connect to a server which
+implements the SPDM functionality.
+
+SPDM-Utils
+----------
+
+You can use `SPDM Utils`_ to emulate a responder. This is the simplest method.
+
+SPDM-Utils is a Linux applications to manage, test and develop devices
+supporting DMTF Security Protocol and Data Model (SPDM). It is written in Rust
+and utilises libspdm.
+
+To use SPDM-Utils you will need to do the following steps. Details are included
+in the SPDM-Utils README.
+
+ 1. `Build libspdm`_
+ 2. `Build SPDM Utils`_
+ 3. `Run it as a server`_
+
+spdm-emu
+--------
+
+You can use `spdm emu`_ to model the
+SPDM responder.
+
+.. code-block:: shell
+
+    $ cd spdm-emu
+    $ git submodule init; git submodule update --recursive
+    $ mkdir build; cd build
+    $ cmake -DARCH=x64 -DTOOLCHAIN=GCC -DTARGET=Debug -DCRYPTO=openssl ..
+    $ make -j32
+    $ make copy_sample_key # Build certificates, required for SPDM authentication.
+
+It is worth noting that the certificates should be in compliance with
+PCIe r6.1 sec 6.31.3. This means you will need to add the following to
+openssl.cnf
+
+.. code-block::
+
+    subjectAltName = otherName:2.23.147;UTF8:Vendor=1b36:Device=0010:CC=010802:REV=02:SSVID=1af4:SSID=1100
+    2.23.147 = ASN1:OID:2.23.147
+
+and then manually regenerate some certificates with:
+
+.. code-block:: shell
+
+    $ openssl req -nodes -newkey ec:param.pem -keyout end_responder.key \
+        -out end_responder.req -sha384 -batch \
+        -subj "/CN=DMTF libspdm ECP384 responder cert"
+
+    $ openssl x509 -req -in end_responder.req -out end_responder.cert \
+        -CA inter.cert -CAkey inter.key -sha384 -days 3650 -set_serial 3 \
+        -extensions v3_end -extfile ../openssl.cnf
+
+    $ openssl asn1parse -in end_responder.cert -out end_responder.cert.der
+
+    $ cat ca.cert.der inter.cert.der end_responder.cert.der > bundle_responder.certchain.der
+
+You can use SPDM-Utils instead as it will generate the correct certificates
+automatically.
+
+The responder can then be launched with
+
+.. code-block:: shell
+
+    $ cd bin
+    $ ./spdm_responder_emu --trans PCI_DOE
+
+Connecting an SPDM NVMe device
+==============================
+
+Once a SPDM server is running we can start QEMU and connect to the server.
+
+For an NVMe device first let's setup a block we can use
+
+.. code-block:: shell
+
+    $ cd qemu-spdm/linux/image
+    $ dd if=/dev/zero of=blknvme bs=1M count=2096 # 2GB NNMe Drive
+
+Then you can add this to your QEMU command line:
+
+.. code-block:: shell
+
+    -drive file=blknvme,if=none,id=mynvme,format=raw \
+        -device nvme,drive=mynvme,serial=deadbeef,spdm=2323
+
+At which point QEMU will try to connect to the SPDM server.
+
+
+.. _DMTF:
+   https://www.dmtf.org/standards/SPDM
+
+.. _SPDM Utils:
+   https://github.com/westerndigitalcorporation/spdm-utils
+
+.. _spdm emu:
+   https://github.com/dmtf/spdm-emu
+
+.. _Build libspdm:
+   https://github.com/westerndigitalcorporation/spdm-utils?tab=readme-ov-file#build-libspdm
+
+.. _Build SPDM Utils:
+   https://github.com/westerndigitalcorporation/spdm-utils?tab=readme-ov-file#build-the-binary
+
+.. _Run it as a server:
+   https://github.com/westerndigitalcorporation/spdm-utils#qemu-spdm-device-emulation
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index d3dd0f64b2..b8379c78f1 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -3,6 +3,7 @@
 
 #include "hw/pci/pci.h"
 #include "hw/pci/pcie.h"
+#include "hw/pci/pcie_doe.h"
 
 #define TYPE_PCI_DEVICE "pci-device"
 typedef struct PCIDeviceClass PCIDeviceClass;
@@ -157,6 +158,10 @@ struct PCIDevice {
     MSIVectorReleaseNotifier msix_vector_release_notifier;
     MSIVectorPollNotifier msix_vector_poll_notifier;
 
+    /* DOE */
+    DOECap doe_spdm;
+    uint16_t spdm_port;
+
     /* ID of standby device in net_failover pair */
     char *failover_pair_id;
     uint32_t acpi_index;
diff --git a/include/hw/pci/pcie_doe.h b/include/hw/pci/pcie_doe.h
index 15d94661f9..9e1275db8a 100644
--- a/include/hw/pci/pcie_doe.h
+++ b/include/hw/pci/pcie_doe.h
@@ -108,6 +108,9 @@ struct DOECap {
     /* Protocols and its callback response */
     DOEProtocol *protocols;
     uint16_t protocol_num;
+
+    /* Used for spdm-socket */
+    int spdm_socket;
 };
 
 void pcie_doe_init(PCIDevice *pdev, DOECap *doe_cap, uint16_t offset,
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 76fe039704..f2377745a9 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -203,6 +203,7 @@
 #include "sysemu/hostmem.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pcie_sriov.h"
+#include "sysemu/spdm-socket.h"
 #include "migration/vmstate.h"
 
 #include "nvme.h"
@@ -8070,6 +8071,28 @@ static int nvme_add_pm_capability(PCIDevice *pci_dev, uint8_t offset)
     return 0;
 }
 
+static bool pcie_doe_spdm_rsp(DOECap *doe_cap)
+{
+    void *req = pcie_doe_get_write_mbox_ptr(doe_cap);
+    uint32_t req_len = pcie_doe_get_obj_len(req) * 4;
+    void *rsp = doe_cap->read_mbox;
+    uint32_t rsp_len = SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE;
+    uint32_t recvd;
+
+    recvd = spdm_socket_rsp(doe_cap->spdm_socket,
+                             SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE,
+                             req, req_len, rsp, rsp_len);
+    doe_cap->read_mbox_len += DIV_ROUND_UP(recvd, 4);
+
+    return recvd != 0;
+}
+
+static DOEProtocol doe_spdm_prot[] = {
+    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_CMA, pcie_doe_spdm_rsp },
+    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_SECURED_CMA, pcie_doe_spdm_rsp },
+    { }
+};
+
 static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
 {
     ERRP_GUARD();
@@ -8126,6 +8149,23 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
 
     nvme_update_msixcap_ts(pci_dev, n->conf_msix_qsize);
 
+    pcie_cap_deverr_init(pci_dev);
+
+    /* DOE Initialisation */
+    if (pci_dev->spdm_port) {
+        uint16_t doe_offset = n->params.sriov_max_vfs ?
+                                  PCI_CONFIG_SPACE_SIZE + PCI_ARI_SIZEOF
+                                  : PCI_CONFIG_SPACE_SIZE;
+
+        pcie_doe_init(pci_dev, &pci_dev->doe_spdm, doe_offset, doe_spdm_prot, true, 0);
+
+        pci_dev->doe_spdm.spdm_socket = spdm_socket_connect(pci_dev->spdm_port, errp);
+
+        if (pci_dev->doe_spdm.spdm_socket < 0 ) {
+            return false;
+        }
+    }
+
     if (n->params.cmb_size_mb) {
         nvme_init_cmb(n, pci_dev);
     }
@@ -8370,6 +8410,11 @@ static void nvme_exit(PCIDevice *pci_dev)
         g_free(n->cmb.buf);
     }
 
+    if (pci_dev->doe_spdm.spdm_socket > 0 ) {
+        spdm_socket_close(pci_dev->doe_spdm.spdm_socket,
+                          SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE);
+    }
+
     if (n->pmr.dev) {
         host_memory_backend_set_mapped(n->pmr.dev, false);
     }
@@ -8412,6 +8457,7 @@ static Property nvme_props[] = {
                       params.sriov_max_vi_per_vf, 0),
     DEFINE_PROP_UINT8("sriov_max_vq_per_vf", NvmeCtrl,
                       params.sriov_max_vq_per_vf, 0),
+    DEFINE_PROP_UINT16("spdm", PCIDevice, spdm_port, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -8494,10 +8540,20 @@ static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
                                   uint32_t val, int len)
 {
     nvme_sriov_pre_write_ctrl(dev, address, val, len);
+    pcie_doe_write_config(&dev->doe_spdm, address, val, len);
     pci_default_write_config(dev, address, val, len);
     pcie_cap_flr_write_config(dev, address, val, len);
 }
 
+static uint32_t nvme_pci_read_config(PCIDevice *dev, uint32_t address, int len)
+{
+    uint32_t val;
+    if (pcie_doe_read_config(&dev->doe_spdm, address, len, &val)) {
+        return val;
+    }
+    return pci_default_read_config(dev, address, len);
+}
+
 static const VMStateDescription nvme_vmstate = {
     .name = "nvme",
     .unmigratable = 1,
@@ -8510,6 +8566,7 @@ static void nvme_class_init(ObjectClass *oc, void *data)
 
     pc->realize = nvme_realize;
     pc->config_write = nvme_pci_write_config;
+    pc->config_read = nvme_pci_read_config;
     pc->exit = nvme_exit;
     pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
     pc->revision = 2;
-- 
2.44.0


