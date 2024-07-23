Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA670C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDGt-0003pp-T8; Tue, 23 Jul 2024 07:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDGq-0003Mc-U0
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:01:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDGn-00037T-UM
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ents0T9O23OXsCQtfncMUcPntmQHxFloICVjUgGeuy0=;
 b=Eg2L/BqMSj+7yxkRaNszGg93SYz4q9bZnHVOtdS0PSlBOHhzKTnKcBy/JHmv1uM1zZXk6B
 A90BGxrDh1HIBBCekJqRcX8dw/wandh71GTP2cRLwn7tV8ZTBxCJBcN7Unz/EoGPJW0m2b
 Pk0es0g1zbmvmTB0crRcVMan0AsXYH8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-Jor61nVzMFWp_UIpY--IXg-1; Tue, 23 Jul 2024 07:01:23 -0400
X-MC-Unique: Jor61nVzMFWp_UIpY--IXg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a77c6ea022fso115469866b.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 04:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732482; x=1722337282;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ents0T9O23OXsCQtfncMUcPntmQHxFloICVjUgGeuy0=;
 b=TyqFeQdPNi1im9a6zLzKvMy97xKBhv5bF5JfYZiIQM2msFIYJ3sfw2xwU8UqbHdMXS
 oaIIFze9KwgCbIctHuDXSSWAqhC5vsICqlTU3TgoenGCb9kVHmAd7cOqbaL0biqEqhS0
 0K0yPJuTruU5s+nSjytIIbC9esDvHq+DN/Pxd654M17II9sI220XmuW7dJivoHfKltqG
 0u1GdaCKwbkB41iwTeg1WVh1Za9rjwIdoHmVO4qBUIx1vqwz7vS9MdFCFqWhauZA5Ru7
 iMsOQYznsTAsk9KOBia2m9NPfTxd+fX3s+M9pvJFPx+pB+rJe/POsiazcq4Z4UOQYGzX
 YxOA==
X-Gm-Message-State: AOJu0YybMFoNTkEOwm1o+CM/w3DEN6N/EwfZI/m024Zc04SUrkzFui/z
 Aamr1lUnYjnfi7gl6zwcHg3HZdbqmscDJvzlR7ET0qPYTTC58i8XEZg+bSkQ84u5kjUONMTseZy
 AzDZiBrelp1E3+pWrCdZMBKtZXaU9vQGT+RjiQ2AA4c8cnnE9lRFdsqyRRgeAvxPlx59RTX4PJ+
 T76WyR8ZqtDQuCh7GiH6hLZk3Nl9s0Bg==
X-Received: by 2002:a17:907:968e:b0:a6f:5609:954f with SMTP id
 a640c23a62f3a-a7a9424f8abmr191016366b.12.1721732481857; 
 Tue, 23 Jul 2024 04:01:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzhrm6oRIkal/3g+8hl1Qd+d93FkXIakgUOWiPKALl8AYc4nkxKfqJjrncyCuyhTgtIKNHdg==
X-Received: by 2002:a17:907:968e:b0:a6f:5609:954f with SMTP id
 a640c23a62f3a-a7a9424f8abmr191010366b.12.1721732481125; 
 Tue, 23 Jul 2024 04:01:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c785ea4sm524248266b.37.2024.07.23.04.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 04:01:20 -0700 (PDT)
Date: Tue, 23 Jul 2024 07:01:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Klaus Jensen <k.jensen@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Huai-Cheng Kuo <hchkuo@avery-design.com.tw>,
 Chris Browy <cbrowy@avery-design.com>, qemu-block@nongnu.org
Subject: [PULL v2 61/61] hw/nvme: Add SPDM over DOE support
Message-ID: <4f947b10d525958578002848a92eeb6152ffbf0d.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Setup Data Object Exchange (DOE) as an extended capability for the NVME
controller and connect SPDM to it (CMA) to it.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Klaus Jensen <k.jensen@samsung.com>
Message-Id: <20240703092027.644758-4-alistair.francis@wdc.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci_device.h |   7 ++
 include/hw/pci/pcie_doe.h   |   3 +
 hw/nvme/ctrl.c              |  62 +++++++++++++++++
 docs/specs/index.rst        |   1 +
 docs/specs/spdm.rst         | 134 ++++++++++++++++++++++++++++++++++++
 5 files changed, 207 insertions(+)
 create mode 100644 docs/specs/spdm.rst

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index cefd6f7640..e7e41cb939 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -3,6 +3,7 @@
 
 #include "hw/pci/pci.h"
 #include "hw/pci/pcie.h"
+#include "hw/pci/pcie_doe.h"
 
 #define TYPE_PCI_DEVICE "pci-device"
 typedef struct PCIDeviceClass PCIDeviceClass;
@@ -159,6 +160,12 @@ struct PCIDevice {
     MSIVectorReleaseNotifier msix_vector_release_notifier;
     MSIVectorPollNotifier msix_vector_poll_notifier;
 
+    /* SPDM */
+    uint16_t spdm_port;
+
+    /* DOE */
+    DOECap doe_spdm;
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
index 5b1b0cabcf..6ee72014cf 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -203,6 +203,7 @@
 #include "sysemu/hostmem.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pcie_sriov.h"
+#include "sysemu/spdm-socket.h"
 #include "migration/vmstate.h"
 
 #include "nvme.h"
@@ -8113,6 +8114,27 @@ static int nvme_add_pm_capability(PCIDevice *pci_dev, uint8_t offset)
     return 0;
 }
 
+static bool pcie_doe_spdm_rsp(DOECap *doe_cap)
+{
+    void *req = pcie_doe_get_write_mbox_ptr(doe_cap);
+    uint32_t req_len = pcie_doe_get_obj_len(req) * 4;
+    void *rsp = doe_cap->read_mbox;
+    uint32_t rsp_len = SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE;
+
+    uint32_t recvd = spdm_socket_rsp(doe_cap->spdm_socket,
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
@@ -8200,6 +8222,25 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
 
     nvme_update_msixcap_ts(pci_dev, n->conf_msix_qsize);
 
+    pcie_cap_deverr_init(pci_dev);
+
+    /* DOE Initialisation */
+    if (pci_dev->spdm_port) {
+        uint16_t doe_offset = n->params.sriov_max_vfs ?
+                                  PCI_CONFIG_SPACE_SIZE + PCI_ARI_SIZEOF
+                                  : PCI_CONFIG_SPACE_SIZE;
+
+        pcie_doe_init(pci_dev, &pci_dev->doe_spdm, doe_offset,
+                      doe_spdm_prot, true, 0);
+
+        pci_dev->doe_spdm.spdm_socket = spdm_socket_connect(pci_dev->spdm_port,
+                                                            errp);
+
+        if (pci_dev->doe_spdm.spdm_socket < 0) {
+            return false;
+        }
+    }
+
     if (n->params.cmb_size_mb) {
         nvme_init_cmb(n, pci_dev);
     }
@@ -8446,6 +8487,11 @@ static void nvme_exit(PCIDevice *pci_dev)
         g_free(n->cmb.buf);
     }
 
+    if (pci_dev->doe_spdm.spdm_socket > 0) {
+        spdm_socket_close(pci_dev->doe_spdm.spdm_socket,
+                          SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE);
+    }
+
     if (n->pmr.dev) {
         host_memory_backend_set_mapped(n->pmr.dev, false);
     }
@@ -8491,6 +8537,7 @@ static Property nvme_props[] = {
     DEFINE_PROP_BOOL("msix-exclusive-bar", NvmeCtrl, params.msix_exclusive_bar,
                      false),
     DEFINE_PROP_UINT16("mqes", NvmeCtrl, params.mqes, 0x7ff),
+    DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -8562,11 +8609,25 @@ static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
 {
     uint16_t old_num_vfs = pcie_sriov_num_vfs(dev);
 
+    if (pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE)) {
+        pcie_doe_write_config(&dev->doe_spdm, address, val, len);
+    }
     pci_default_write_config(dev, address, val, len);
     pcie_cap_flr_write_config(dev, address, val, len);
     nvme_sriov_post_write_config(dev, old_num_vfs);
 }
 
+static uint32_t nvme_pci_read_config(PCIDevice *dev, uint32_t address, int len)
+{
+    uint32_t val;
+    if (dev->spdm_port && pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE)) {
+        if (pcie_doe_read_config(&dev->doe_spdm, address, len, &val)) {
+            return val;
+        }
+    }
+    return pci_default_read_config(dev, address, len);
+}
+
 static const VMStateDescription nvme_vmstate = {
     .name = "nvme",
     .unmigratable = 1,
@@ -8579,6 +8640,7 @@ static void nvme_class_init(ObjectClass *oc, void *data)
 
     pc->realize = nvme_realize;
     pc->config_write = nvme_pci_write_config;
+    pc->config_read = nvme_pci_read_config;
     pc->exit = nvme_exit;
     pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
     pc->revision = 2;
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
index 0000000000..f7de080ff0
--- /dev/null
+++ b/docs/specs/spdm.rst
@@ -0,0 +1,134 @@
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
+        -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323
+
+At which point QEMU will try to connect to the SPDM server.
+
+Note that if using x64-64 you will want to use the q35 machine instead
+of the default. So the entire QEMU command might look like this
+
+.. code-block:: shell
+
+    qemu-system-x86_64 -M q35 \
+        --kernel bzImage \
+        -drive file=rootfs.ext2,if=virtio,format=raw \
+        -append "root=/dev/vda console=ttyS0" \
+        -net none -nographic \
+        -drive file=blknvme,if=none,id=mynvme,format=raw \
+        -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323
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
-- 
MST


