Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5382C4829D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 02:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZimm-0002K2-Rx; Mon, 12 Feb 2024 21:44:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rZiml-0002Jj-CZ; Mon, 12 Feb 2024 21:44:39 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rZimj-0003J7-55; Mon, 12 Feb 2024 21:44:39 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d953fa3286so30088325ad.2; 
 Mon, 12 Feb 2024 18:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707792275; x=1708397075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZKkr5+DQKGp6erkKh1K3GEPolXV7PYCCwVRgNyLgHro=;
 b=lezvASRGELoyiqGRd7CWjoFsVqjr+nVxoobSOGuPBCg8GRBnzIRDvy7r2ZIvE9V9ED
 HWRkW/ACRgjj1XUme72l3/nm9MjibUPI0xye0T4c56DnPrhlMXtfIs3Dzu5KKicyeMW1
 JNQ+3BJ2eyvrVNNiIOWuYj/I+ZgWYmPB+HN5YCTqyLQ+ZOW7E54ERw6MTwjcJonWug5d
 k0nPG5vSxmn9H8oRS8qvJyXLF3hpu8LQWjXbwQsksJ12/B8rRXeQYRSL4H1mpu1Cyxgf
 5nwYS5ewpsmm5DU+QlxlOLJsgU3qKQAbTWtqkpxx+iuniFh/iRVBfHFjRSsslwGZnGzV
 Tm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707792275; x=1708397075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZKkr5+DQKGp6erkKh1K3GEPolXV7PYCCwVRgNyLgHro=;
 b=QY9mxf68z/grnzjxIIXKviEzz01/kbvUoPkTkOLNxo6eJfylEcVE/UJeNzYcdd26Jf
 SaX2pjCzMfZQgjN2V6gvmJEjgJBiKB7otwMjAa2BJCoKxDMsa7bvPcKxx7xUhXRdvubE
 oaBPN9aHJAY2f8F8gXhGSxf9oD723q7zsjJ2byQCjTluNcQElHW3Yw+JlzLh/sZBvCMN
 UgGHXKh9fOwtulP8Z52hUbi8VREqK5iJd0W9GXC8zi6PtnsUPnr3lke3M/5zvS80R+z1
 OZBlxR5VumREztz/2MC/Bjbcunm+lCha2T3HFeTY/7sqTE8w71AWSv6QFHrTEDxut9lw
 bpaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/NGPJYGUSVX6xT/CBIslUVUcmjowVl9rtxQSjhF+GgeOGwmLumLhFcHFIZQhgMajJ71bs4riRJfEfMkMDLqP6GQfcDVxugzPmjQB5itMftFw01H7qhK2ki51YGA==
X-Gm-Message-State: AOJu0YwZPuQHegxKboPBgbd70O2f20VldEDZl4sQFAe1kdhwJ32Ir0Eq
 FmzCf7U4So8NDsvG8inL2pLHOcxRJtoHGWA9ksCZcRrdMTVYjSAt
X-Google-Smtp-Source: AGHT+IEildF3BQvgT2IAB/XCQlRIFN8G71MTOo8pT6qhQ8e0zh8QA6ljPVVP6VbEFovlAldakMrFrw==
X-Received: by 2002:a17:902:ce90:b0:1d8:fc65:b601 with SMTP id
 f16-20020a170902ce9000b001d8fc65b601mr11463893plg.38.1707792275288; 
 Mon, 12 Feb 2024 18:44:35 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUHGkT6lMhcte9mM9j+0NIuGZicxowrC9NMf08hGLXHDTfDzyJmbjbnhLiuv/CS40Gj8XuH4uYlM9XaalzFRMIi7arWCjodMyOiVdiqj2nG5WvOnrSbOVFQU/6QMBbDAXOF/UnS8euiRfYPWnoJWb6fo87W5E+Ua8L5Cx5qgT+z3Kx1BCjMXxUr65LuWipA3mHz93IwL64dPLUedNevGGa2xJu7o181wrG5CiSX4/tF2xoQHpP0nBePBGr5z8lRsU/LkdfJ4hOGz9gVA3QHLkgJ0P9HXvJxAeOf98sr/pAviFwQvjagFlXgc8FhOe7qeYmqTH1zlV1muwQEuepbMI86n/1Lh7WbrelQof8/xxKFcVgOxuy8ymK7E/IxjebtnCMb8WddP9enNgtsth9LTSKw0Nhs9NGO0pFxCSpMaiG0lmhuWa6nylM0XAIU+gtp7EEySBa/ExfoutHz3wBwKJafHJOVuxNlIJL9Mg==
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a170902f2cc00b001da0a698095sm22852plc.282.2024.02.12.18.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 18:44:34 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: hchkuo@avery-design.com.tw, kbusch@kernel.org, lukas@wunner.de,
 Jonathan.Cameron@Huawei.com, its@irrelevant.dk, marcel.apfelbaum@gmail.com,
 wilfred.mallawa@wdc.com, cbrowy@avery-design.com, mst@redhat.com,
 qemu-devel@nongnu.org, jiewen.yao@intel.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v4 3/3] hw/nvme: Add SPDM over DOE support
Date: Tue, 13 Feb 2024 12:44:03 +1000
Message-ID: <20240213024403.1060188-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213024403.1060188-1-alistair.francis@wdc.com>
References: <20240213024403.1060188-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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
 hw/nvme/ctrl.c              |  53 ++++++++++++++++
 5 files changed, 184 insertions(+)
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
index 0000000000..4d0942c1ad
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
+ 2. `Build SPDM Utils using Cargo`_
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
+.. _Build SPDM Utils:
+   https://github.com/westerndigitalcorporation/spdm-utils#building
+
+.. _Generate the certificates:
+   https://github.com/westerndigitalcorporation/spdm-utils#generate-mutable-certificates
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
index 15d94661f9..eb8f4e393d 100644
--- a/include/hw/pci/pcie_doe.h
+++ b/include/hw/pci/pcie_doe.h
@@ -108,6 +108,9 @@ struct DOECap {
     /* Protocols and its callback response */
     DOEProtocol *protocols;
     uint16_t protocol_num;
+
+    /* Used for spdm-socket */
+    int socket;
 };
 
 void pcie_doe_init(PCIDevice *pdev, DOECap *doe_cap, uint16_t offset,
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f026245d1e..661ebe3725 100644
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
+    recvd = spdm_socket_rsp(doe_cap->socket,
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
@@ -8126,6 +8149,24 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
 
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
+        pci_dev->doe_spdm.socket = spdm_socket_connect(pci_dev->spdm_port, errp);
+
+        if (pci_dev->doe_spdm.socket < 0 ) {
+            error_setg(errp, "Failed to connect to SPDM socket");
+            return -ENOTSUP;
+        }
+    }
+
     if (n->params.cmb_size_mb) {
         nvme_init_cmb(n, pci_dev);
     }
@@ -8412,6 +8453,7 @@ static Property nvme_props[] = {
                       params.sriov_max_vi_per_vf, 0),
     DEFINE_PROP_UINT8("sriov_max_vq_per_vf", NvmeCtrl,
                       params.sriov_max_vq_per_vf, 0),
+    DEFINE_PROP_UINT16("spdm", PCIDevice, spdm_port, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -8494,10 +8536,20 @@ static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
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
@@ -8510,6 +8562,7 @@ static void nvme_class_init(ObjectClass *oc, void *data)
 
     pc->realize = nvme_realize;
     pc->config_write = nvme_pci_write_config;
+    pc->config_read = nvme_pci_read_config;
     pc->exit = nvme_exit;
     pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
     pc->revision = 2;
-- 
2.43.0


