Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B6DC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 18:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rifKS-0002me-44; Fri, 08 Mar 2024 13:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1rifKQ-0002kn-Pw
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:52:22 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1rifKO-0003l5-L2
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:52:22 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-6e617b39877so2022123b3a.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 10:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709923938; x=1710528738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RI2QqTGqwpsTau2Sp9GUkbezFZgHUgZwJDQkapsHsHE=;
 b=Q5sIdvpmgI6hTyKovqHYT/YgVKIT74UO03GQG0voJ0UYQ215fWzf77wXFaQHrCnDh9
 mTioIBuT6ZefznmSOP1c3mqzrciWhlm20CgP2bS6aN7j466U2AjZ/pPfsNGMBSZMT/Xj
 bEAcsDlYslsH8/no3hIGF3/fQipPsI4uWYPhBuEbNHxQGoV0x5fEiw5jaFYq7cooYdUW
 C+JNNZlsS5m2mKOl1LGjXaXxlVUkQa7bXHX893kcdmuZKPNuV4ar8QU+iDlb08j0ex+X
 X4KU/AbYnv8+ovYC5X5RLYJgF0AV2d5bqN+qvnSOO7zYGlmAsuAz/tW8dSnkrb+iRHm9
 YpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709923938; x=1710528738;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RI2QqTGqwpsTau2Sp9GUkbezFZgHUgZwJDQkapsHsHE=;
 b=uJTExkT9Nr2Mltl9tdDrg60c8lfqKP7mr6egXGW44GZ8wcaO/HtaoO5LiaK0Fha+cZ
 33V22cwr3OgpJvqqCWj0/yfD1JPHOVXwbJdMrqRzcr8KDXdKSNRsECMTJmOXxR50Gvyg
 +wK2KS/Np5BAIUlsCSrOzlw0h9+RzPIiLhf27SDkPy75kApAAv6fnDkkwMM6eg+Uh/fK
 AaASeblJ8RL+ycx97W+hajExzsbIWwK7LRv0E8a54WMbnFn6wiXIfPkoDljjXY/xnT76
 dvMsBWc8yJNd3hd4piS6z9mNXISPworDyCZVrOoT/T8zXBzs1Hrjb5WzdcbmDcJKp9y5
 2+Bg==
X-Gm-Message-State: AOJu0Ywyfwck+AOEv7Zly06h5wgL/WLstXy/pttyam2dCxm/vmUoqahk
 s1J2ep9mISmLMzMWQjx8/ATSD19I9TvXQcMZB7tuCTM1zkhvYUpYiC8i7mMJ0g==
X-Google-Smtp-Source: AGHT+IEeehJisw2EAcpb3pnbjmBvod5uActFDtAXrJjAqqMZIvzM5aUQIOaz8Kzs5BLWXx0LiZiR4Q==
X-Received: by 2002:a17:902:f705:b0:1dd:689a:6fef with SMTP id
 h5-20020a170902f70500b001dd689a6fefmr3044224plo.61.1709923938270; 
 Fri, 08 Mar 2024 10:52:18 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net.
 [173.79.56.208]) by smtp.gmail.com with ESMTPSA id
 h6-20020a170902eec600b001dd63494820sm2098784plb.166.2024.03.08.10.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 10:52:17 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 nifan.cxl@gmail.com, Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH INCOMPLETE] cxl: Multi-headed Single Logical Device (MHSLD)
Date: Fri,  8 Mar 2024 13:52:11 -0500
Message-Id: <20240308185211.277116-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=gourry.memverge@gmail.com; helo=mail-pf1-x443.google.com
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

Implement the scaffolding for an MHSLD with a simple multi-headed
command set. This device inherits the cxl-type3 device and will
provide the hooks needed to serialize multi-system devices.

This device requires linux, as it uses shared memory (shmem) to
implement the shared state.  This also limits the emulation of
multiple guests to a single host.

To instantiate:

-device cxl-mhsld,bus=rp0,volatile-memdev=mem0,id=cxl-mem0,sn=66666,mhd-head=0,mhd-shmid=15

The MH-SLD shared memory region must be initialized via 'init_mhsld'
tool located in the cxl/mhsld directory.

usage: init_mhsld <heads> <shmid>
    heads         : number of heads on the device
    shmid         : shmid produced by ipcmk

Example:
$shmid1=ipcmk -M 131072
./init_mhseld 4 $shmid


What we should discuss:
* What state needs to be in MHSLDSharedState
  - for DCD
  - for other CXL extentions? (RAS?)

* What hooks we need to add to cxl-type3 for MHDs
  - Example: cvc->mhd_access_valid was added for Niagara
  - Additional calls will need to be added for things like DCD

* Shared state design and serialization
  - right now we use the same shared memory solution, this makes
    serialization a little easier since we can use a mutex in shmem
  - This limits emulation of MHSLD devices to QEMU guests located
    on the same host, but this seems fine for functional testing.

* Shared state initialization
  - right now i use the external tool, but if we want to limit
    the ability to test things like restarting hosts, we could
    instead add an explicit `initialize_state=true` option to the
    device and ditch the extra program.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/cxl/Kconfig            |   1 +
 hw/cxl/meson.build        |   1 +
 hw/cxl/mhsld/.gitignore   |   1 +
 hw/cxl/mhsld/Kconfig      |   4 +
 hw/cxl/mhsld/init_mhsld.c |  76 ++++++++++++++++
 hw/cxl/mhsld/meson.build  |   3 +
 hw/cxl/mhsld/mhsld.c      | 177 ++++++++++++++++++++++++++++++++++++++
 hw/cxl/mhsld/mhsld.h      |  64 ++++++++++++++
 8 files changed, 327 insertions(+)
 create mode 100644 hw/cxl/mhsld/.gitignore
 create mode 100644 hw/cxl/mhsld/Kconfig
 create mode 100644 hw/cxl/mhsld/init_mhsld.c
 create mode 100644 hw/cxl/mhsld/meson.build
 create mode 100644 hw/cxl/mhsld/mhsld.c
 create mode 100644 hw/cxl/mhsld/mhsld.h

diff --git a/hw/cxl/Kconfig b/hw/cxl/Kconfig
index e603839a62..919e59b598 100644
--- a/hw/cxl/Kconfig
+++ b/hw/cxl/Kconfig
@@ -1,3 +1,4 @@
+source mhsld/Kconfig
 source vendor/Kconfig
 
 config CXL
diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
index e8c8c1355a..394750dd19 100644
--- a/hw/cxl/meson.build
+++ b/hw/cxl/meson.build
@@ -16,4 +16,5 @@ system_ss.add(when: 'CONFIG_I2C_MCTP_CXL', if_true: files('i2c_mctp_cxl.c'))
 
 system_ss.add(when: 'CONFIG_ALL', if_true: files('cxl-host-stubs.c'))
 
+subdir('mhsld')
 subdir('vendor')
diff --git a/hw/cxl/mhsld/.gitignore b/hw/cxl/mhsld/.gitignore
new file mode 100644
index 0000000000..f9f6a37cc0
--- /dev/null
+++ b/hw/cxl/mhsld/.gitignore
@@ -0,0 +1 @@
+init_mhsld
diff --git a/hw/cxl/mhsld/Kconfig b/hw/cxl/mhsld/Kconfig
new file mode 100644
index 0000000000..dc2be15140
--- /dev/null
+++ b/hw/cxl/mhsld/Kconfig
@@ -0,0 +1,4 @@
+config CXL_MHSLD
+    bool
+    depends on CXL_MEM_DEVICE
+    default y
diff --git a/hw/cxl/mhsld/init_mhsld.c b/hw/cxl/mhsld/init_mhsld.c
new file mode 100644
index 0000000000..d9e0cd54e0
--- /dev/null
+++ b/hw/cxl/mhsld/init_mhsld.c
@@ -0,0 +1,76 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2024 MemVerge Inc.
+ *
+ */
+
+#include <signal.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ipc.h>
+#include <sys/shm.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+struct mhsld_state {
+    uint8_t nr_heads;
+    uint8_t nr_lds;
+    uint8_t ldmap[65536];
+};
+
+int main(int argc, char *argv[])
+{
+    int shmid = 0;
+    uint32_t sections = 0;
+    uint32_t section_size = 0;
+    uint32_t heads = 0;
+    struct mhsld_state *mhsld_state = NULL;
+    size_t state_size;
+    uint8_t i;
+
+    if (argc != 3) {
+        printf("usage: init_mhsld <heads> <shmid>\n"
+                "\theads         : number of heads on the device\n"
+                "\tshmid         : /tmp/mytoken.tmp\n\n"
+                "It is recommended your shared memory region is at least 128kb\n");
+        return -1;
+    }
+
+    /* must have at least 1 head */
+    heads = (uint32_t)atoi(argv[1]);
+    if (heads == 0 || heads > 32) {
+        printf("bad heads argument (1-32)\n");
+        return -1;
+    }
+
+    shmid = (uint32_t)atoi(argv[2]);
+    if (shmid == 0) {
+        printf("bad shmid argument\n");
+        return -1;
+    }
+
+    mhsld_state = shmat(shmid, NULL, 0);
+    if (mhsld_state == (void *)-1) {
+        printf("Unable to attach to shared memory\n");
+        return -1;
+    }
+
+    /* Initialize the mhsld_state */
+    state_size = sizeof(struct mhsld_state) + (sizeof(uint32_t) * sections);
+    memset(mhsld_state, 0, state_size);
+    mhsld_state->nr_heads = heads;
+    mhsld_state->nr_lds = heads;
+
+    memset(&mhsld_state->ldmap, '\xff', sizeof(mhsld_state->ldmap));
+    for (i = 0; i < heads; i++) {
+        mhsld_state->ldmap[i] = i;
+    }
+
+    printf("mhsld initialized\n");
+    shmdt(mhsld_state);
+    return 0;
+}
diff --git a/hw/cxl/mhsld/meson.build b/hw/cxl/mhsld/meson.build
new file mode 100644
index 0000000000..c595558f8a
--- /dev/null
+++ b/hw/cxl/mhsld/meson.build
@@ -0,0 +1,3 @@
+if host_os == 'linux'
+	system_ss.add(when: 'CONFIG_CXL_MHSLD', if_true: files('mhsld.c',))
+endif
diff --git a/hw/cxl/mhsld/mhsld.c b/hw/cxl/mhsld/mhsld.c
new file mode 100644
index 0000000000..bef50e1483
--- /dev/null
+++ b/hw/cxl/mhsld/mhsld.c
@@ -0,0 +1,177 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2024 MemVerge Inc.
+ *
+ */
+
+#include <sys/shm.h>
+#include "qemu/osdep.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_mailbox.h"
+#include "hw/cxl/cxl_device.h"
+#include "hw/pci/pcie.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/qdev-properties.h"
+#include "mhsld.h"
+
+#define TYPE_CXL_MHSLD "cxl-mhsld"
+OBJECT_DECLARE_TYPE(CXLMHSLDState, CXLMHSLDClass, CXL_MHSLD)
+
+/*
+ * CXL r3.0 section 7.6.7.5.1 - Get Multi-Headed Info (Opcode 5500h)
+ *
+ * This command retrieves the number of heads, number of supported LDs,
+ * and Head-to-LD mapping of a Multi-Headed device.
+ */
+static CXLRetCode cmd_mhd_get_info(const struct cxl_cmd *cmd,
+                                   uint8_t *payload_in,
+                                   size_t len_in,
+                                   uint8_t *payload_out,
+                                   size_t *len_out,
+                                   CXLCCI * cci)
+{
+    CXLMHSLDState *s = CXL_MHSLD(cci->d);
+    MHDGetInfoInput *input = (void *)payload_in;
+    MHDGetInfoOutput *output = (void *)payload_out;
+
+    uint8_t start_ld = input->start_ld;
+    uint8_t ldmap_len = input->ldmap_len;
+    uint8_t i;
+
+    if (start_ld >= s->mhd_state->nr_lds) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    output->nr_lds = s->mhd_state->nr_lds;
+    output->nr_heads = s->mhd_state->nr_heads;
+    output->resv1 = 0;
+    output->start_ld = start_ld;
+    output->resv2 = 0;
+
+    for (i = 0; i < ldmap_len && (start_ld + i) < output->nr_lds; i++) {
+        output->ldmap[i] = s->mhd_state->ldmap[start_ld + i];
+    }
+    output->ldmap_len = i;
+
+    *len_out = sizeof(*output) + output->ldmap_len;
+    return CXL_MBOX_SUCCESS;
+}
+
+static const struct cxl_cmd cxl_cmd_set_mhsld[256][256] = {
+    [MHSLD_MHD][GET_MHD_INFO] = {"GET_MULTI_HEADED_INFO",
+        cmd_mhd_get_info, 2, 0},
+};
+
+static Property cxl_mhsld_props[] = {
+    DEFINE_PROP_UINT32("mhd-head", CXLMHSLDState, mhd_head, ~(0)),
+    DEFINE_PROP_UINT32("mhd-shmid", CXLMHSLDState, mhd_shmid, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void cxl_mhsld_realize(PCIDevice *pci_dev, Error **errp)
+{
+    CXLMHSLDState *s = CXL_MHSLD(pci_dev);
+
+    ct3_realize(pci_dev, errp);
+
+    if (!s->mhd_shmid || s->mhd_head == ~(0)) {
+        error_setg(errp, "is_mhd requires mhd_shmid and mhd_head settings");
+        return;
+    }
+
+    if (s->mhd_head >= 32) {
+        error_setg(errp, "MHD Head ID must be between 0-31");
+        return;
+    }
+
+    s->mhd_state = shmat(s->mhd_shmid, NULL, 0);
+    if (s->mhd_state == (void *)-1) {
+        s->mhd_state = NULL;
+        error_setg(errp, "Unable to attach MHD State. Check ipcs is valid");
+        return;
+    }
+
+    /* For now, limit the number of LDs to the number of heads (SLD) */
+    if (s->mhd_head >= s->mhd_state->nr_heads) {
+        error_setg(errp, "Invalid head ID for multiheaded device.");
+        return;
+    }
+
+    if (s->mhd_state->nr_lds <= s->mhd_head) {
+        error_setg(errp, "MHD Shared state does not have sufficient lds.");
+        return;
+    }
+
+    s->mhd_state->ldmap[s->mhd_head] = s->mhd_head;
+    return;
+}
+
+static void cxl_mhsld_exit(PCIDevice *pci_dev)
+{
+    CXLMHSLDState *s = CXL_MHSLD(pci_dev);
+
+    ct3_exit(pci_dev);
+
+    if (s->mhd_state) {
+        shmdt(s->mhd_state);
+    }
+}
+
+static void cxl_mhsld_reset(DeviceState *d)
+{
+    CXLMHSLDState *s = CXL_MHSLD(d);
+
+    ct3d_reset(d);
+    cxl_add_cci_commands(&s->ct3d.cci, cxl_cmd_set_mhsld, 512);
+}
+
+/* TODO: Implement shared device hooks
+ *
+ * Example: DCD-add events need to validate that the requested extent
+ *          does not already have a mapping (or, if it does, it is
+ *          a shared extent with the right tagging).
+ *
+ * Since this operates on the shared state, we will need to serialize
+ * these callbacks across QEMU instances via a mutex in shared state.
+ */
+
+static void cxl_mhsld_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
+
+    pc->realize = cxl_mhsld_realize;
+    pc->exit = cxl_mhsld_exit;
+    dc->reset = cxl_mhsld_reset;
+    device_class_set_props(dc, cxl_mhsld_props);
+
+    /* TODO: type3 class callbacks for multi-host access validation
+     * CXLType3Class *cvc = CXL_TYPE3_CLASS(klass);
+     * cvc->mhd_access_valid = mhsld_access_valid;
+     * cvc->dcd_extent_action = mhsld_dcd_extent_action;
+     */
+}
+
+static const TypeInfo cxl_mhsld_info = {
+    .name = TYPE_CXL_MHSLD,
+    .parent = TYPE_CXL_TYPE3,
+    .class_size = sizeof(struct CXLMHSLDClass),
+    .class_init = cxl_mhsld_class_init,
+    .instance_size = sizeof(CXLMHSLDState),
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_CXL_DEVICE },
+        { INTERFACE_PCIE_DEVICE },
+        {}
+    },
+};
+
+static void cxl_mhsld_register_types(void)
+{
+    type_register_static(&cxl_mhsld_info);
+}
+
+type_init(cxl_mhsld_register_types)
diff --git a/hw/cxl/mhsld/mhsld.h b/hw/cxl/mhsld/mhsld.h
new file mode 100644
index 0000000000..0cde86ea8b
--- /dev/null
+++ b/hw/cxl/mhsld/mhsld.h
@@ -0,0 +1,64 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2024 MemVerge Inc.
+ *
+ */
+
+#ifndef CXL_MHSLD_H
+#define CXL_MHSLD_H
+#include <stdint.h>
+#include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_mailbox.h"
+#include "hw/cxl/cxl_device.h"
+#include "qemu/units.h"
+
+#define MHSLD_MIN_MEMBLK (128 * MiB)
+
+/*
+ * The shared state cannot have 2 variable sized regions
+ * so we have to max out the ldmap.
+ */
+typedef struct MHSLDSharedState {
+    uint8_t nr_heads;
+    uint8_t nr_lds;
+    uint8_t ldmap[65536];
+    /* TODO: shared state Mutex */
+    /* TODO: Extent information */
+} MHSLDSharedState;
+
+struct CXLMHSLDState {
+    CXLType3Dev ct3d;
+    uint32_t mhd_head;
+    uint32_t mhd_shmid;
+    MHSLDSharedState *mhd_state;
+};
+
+struct CXLMHSLDClass {
+    CXLType3Class parent_class;
+};
+
+enum {
+    MHSLD_MHD = 0x55,
+        #define GET_MHD_INFO 0x0
+};
+
+/*
+ * MHD Get Info Command
+ * Returns information the LD's associated with this head
+ */
+typedef struct MHDGetInfoInput {
+    uint8_t start_ld;
+    uint8_t ldmap_len;
+} QEMU_PACKED MHDGetInfoInput;
+
+typedef struct MHDGetInfoOutput {
+    uint8_t nr_lds;
+    uint8_t nr_heads;
+    uint16_t resv1;
+    uint8_t start_ld;
+    uint8_t ldmap_len;
+    uint16_t resv2;
+    uint8_t ldmap[];
+} QEMU_PACKED MHDGetInfoOutput;
+#endif
-- 
2.39.1


