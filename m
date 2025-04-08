Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D2AC3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 04:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u20d4-0006Tp-Tr; Tue, 08 Apr 2025 00:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1u20d2-0006TN-MW
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 00:32:04 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1u20d0-0005cS-Rs
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 00:32:04 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-224341bbc1dso44682755ad.3
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 21:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744086721; x=1744691521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tFsyiFKRhSvGR0pMC95Wd+px084AVEIKUIaNuSDojhQ=;
 b=GBZBmQTDksfXRNESG07zJDqNmXMCTU0ZIl7Kedkh+IsgIe62sOFELZBByRZegg2zHX
 ftCUGXoNRPsekAvsUO/Dk9sld8jamo1LW7CygW6KBj0RspkAOEYfKN9tVzvWOAMMCoF6
 nvNQJv/N6WicpulyIOCHgIQclIU+bDXu9IbS/yOl2q0dfCxIwyIh5lzoIVp8C3vR0XpE
 AaNbqpyhaKWX2eLZatCGQqhVyzcJQM8ScGas0zcrOlty81zut3mLcKt3PAtO+hAicUXS
 4RuVYVn95bMJTvNzAeKkr0X+YauzEb/R/re34muFBoxY6aDWJtIWvdzxHoDruMlGSklz
 nubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744086721; x=1744691521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tFsyiFKRhSvGR0pMC95Wd+px084AVEIKUIaNuSDojhQ=;
 b=QnnOLpyx3dp2xhZ6whBhtoZXhq/LQH9YK6JGhQ+IwfqY9ZxCsmhkWZsFEq1ChjdgoK
 oVK6k2Hu2wz7T80qHpniQH1jUTJ3HkbIZOH9nYK9QnSOm55NXTc2/iK3ZDvsDwGdtfNw
 RWpZWJbytaEQgicGxflu/ZKl7IZwj9CPTHtx2thBKQ0inWvERjPi8lU6itQWBu6cZbqR
 9ruLHdg7ri5ETYZ199fYl0KtDnIc+kI1NlYkP3CuZ76CBDa21D9rAyswAu620t1TQIxj
 KmoveUmIDe/59hsJRvWEy2rA1dDgdVVE9mE9fjUeRslnqrEOehFrtkWvpCXFNR4pcT7Z
 nz3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9vVqqcpLpbiGXSZeGjC+L6tLdFi7Ot+t8Uv7cW01PAUdaEL4FO2sONeSyBCmlh4Uvhq4l56VYZ16J@nongnu.org
X-Gm-Message-State: AOJu0YytBzfviKc8sFEKaJ5f/0xptL4KHzeBV7n+UWGK7HtKXsFObV52
 2lDLmTZYdDmQ1m1rZE3Y1LmdBhPbtBaGNkQ/icTiur/+wKtrvFxm
X-Gm-Gg: ASbGncsc5YjDjVG97fSC9pES3pZHs2LNUn4T0M/28+7/z6J+aBZCUkmGMubOmyarlUd
 hHHVlgoHHuHisyuwyiSWMdZZLg3K1RtmlQJlK/5oybBk6s6HQhp6KpMOqmR7vqlE6JlmijHTKDG
 Kyi8uLinB2zdlDfk0hDLgETX6Hb0/PWm4h0vsu1PGyOhjx/9n3bAl/iyz/Wz1c0eldSuWRTmZ71
 O9w2NK/fXWLSVT93pOAmBfDXOkiOv8o9qrJb1967kYduiJxk0I5yxaFZ4vgDFPVuZIrSC0zsDcR
 jmMBzlHPbnJJ1EvdLGxGS+8b4QilXEloQG3vry/tLrgrT7g+PEkT+cjI400uVQ==
X-Google-Smtp-Source: AGHT+IGGOYorAenJf9WDhLYuxrPuFrkDogX1/FSN2ZuwsnOPs6m3hMh2XFNgWY70xxDdmBZ82edybw==
X-Received: by 2002:a17:902:f610:b0:223:3396:15e8 with SMTP id
 d9443c01a7336-22a9552b6damr173880685ad.22.1744086720905; 
 Mon, 07 Apr 2025 21:32:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297865e0a9sm90055385ad.149.2025.04.07.21.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 21:32:00 -0700 (PDT)
From: nifan.cxl@gmail.com
To: jonathan.cameron@huawei.com,
	qemu-devel@nongnu.org
Cc: linux-cxl@vger.kernel.org, a.manzanares@samsung.com, dave@stgolabs.net,
 nmtadam.samsung@gmail.com, nifan.cxl@gmail.com, anisa.su887@gmail.com,
 gourry@gourry.net, Fan Ni <fan.ni@samsung.com>
Subject: [RFC 1/3] cxl_type3: Preparing information sharing between VMs
Date: Mon,  7 Apr 2025 21:20:28 -0700
Message-ID: <20250408043051.430340-2-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250408043051.430340-1-nifan.cxl@gmail.com>
References: <20250408043051.430340-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fan Ni <fan.ni@samsung.com>

Add two data structures for sharing information between multiple VMs.
The global cci_map_buf is used to provide mappings between cci name and cci
pointer.
Each VM has its own cci_map_buf. However, since we expect the two VMs share
the same configuration, the same CCI name should points to its own CCI.
On the FM, we need to use the cci pointer to find the cci name.
While on the test VM, we use the name to find cci pointer for MCTP
message process.
The mctp_shared_buffer is used to pass MCTP command information between
FM and test VM for QMP command process.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c                | 125 +++++++++++++++++++++++++++++-
 include/hw/cxl/cxl_device.h       |   6 ++
 include/hw/cxl/cxl_mctp_message.h |  40 ++++++++++
 3 files changed, 170 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/cxl/cxl_mctp_message.h

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 11c38a9292..7f85616ca1 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -29,6 +29,9 @@
 #include "system/numa.h"
 #include "hw/cxl/cxl.h"
 #include "hw/pci/msix.h"
+#include "hw/cxl/cxl_mctp_message.h"
+
+struct CXLCCINamePtrMaps *cci_map_buf;
 
 /* type3 device private */
 enum CXL_T3_MSIX_VECTOR {
@@ -998,6 +1001,97 @@ static void init_alert_config(CXLType3Dev *ct3d)
     };
 }
 
+static int ct3_mctp_buf_open(const char *filename, int flags)
+{
+    char name[128];
+    snprintf(name, sizeof(name), "/%s", filename);
+    return shm_open(name, flags, 0666);
+}
+
+static int ct3_mctp_buf_unlink(const char *filename)
+{
+    char name[128];
+    snprintf(name, sizeof(name), "/%s", filename);
+    return shm_unlink(name);
+}
+
+static struct CXLMCTPSharedBuf *ct3_mctp_buf_map(int fd, int size)
+{
+    void *map;
+
+    if (fd < 0) {
+        return NULL;
+    }
+
+    map = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+    if (map == MAP_FAILED) {
+        return NULL;
+    }
+
+    return (CXLMCTPSharedBuf *)map;
+}
+
+
+static int ct3_mctp_buf_create(const char *filename, size_t size)
+{
+    int fd, rc;
+
+    fd = ct3_mctp_buf_open(filename, O_RDWR | O_CREAT);
+    if (fd == -1) {
+        return -1;
+    }
+
+    rc = ftruncate(fd, size);
+
+    if (rc) {
+        close(fd);
+        return -1;
+    }
+
+    return fd;
+}
+
+static int ct3_setup_mctp_command_share_buffer(CXLType3Dev *ct3d, bool create)
+{
+    int fd;
+    int size = sizeof(*ct3d->mctp_shared_buffer);
+    sprintf(ct3d->mctp_buf_name, MCTP_MESSAGE_BUF_NAME);
+
+    if (create) {
+        fd = ct3_mctp_buf_create(ct3d->mctp_buf_name, size);
+    } else {
+        fd = ct3_mctp_buf_open(ct3d->mctp_buf_name, O_RDWR | O_CREAT);
+    }
+
+    if (fd == -1) {
+        return fd;
+    }
+    ct3d->mctp_buf_fd = fd;
+    ct3d->mctp_shared_buffer = ct3_mctp_buf_map(ct3d->mctp_buf_fd, size);
+    if (ct3d->mctp_shared_buffer) {
+        return 0;
+    }
+    return -1;
+}
+
+static int init_cci_name_ptr_mapping(void)
+{
+    if (!cci_map_buf) {
+        cci_map_buf = g_malloc(sizeof(*cci_map_buf));
+    }
+    return 0;
+}
+
+static void add_cci_name_ptr_mapping(const char *name, void *p)
+{
+    int n = cci_map_buf->num_mappings;
+    struct CXLCCINamePtrMap *map = &cci_map_buf->maps[n];
+
+    strcpy(map->cci_name, name);
+    map->cci_pointer = p;
+    cci_map_buf->num_mappings++;
+}
+
 void ct3_realize(PCIDevice *pci_dev, Error **errp)
 {
     ERRP_GUARD();
@@ -1108,6 +1202,14 @@ void ct3_realize(PCIDevice *pci_dev, Error **errp)
         ct3d->ecs_attrs.fru_attrs[count].ecs_flags = 0;
     }
 
+    if (ct3d->allow_fm_attach) {
+        init_cci_name_ptr_mapping();
+        if (ct3d->mctp_buf_init) {
+            ct3_setup_mctp_command_share_buffer(ct3d, true);
+        } else {
+            ct3_setup_mctp_command_share_buffer(ct3d, false);
+        }
+    }
     return;
 
 err_release_cdat:
@@ -1150,6 +1252,15 @@ void ct3_exit(PCIDevice *pci_dev)
     if (ct3d->hostvmem) {
         address_space_destroy(&ct3d->hostvmem_as);
     }
+
+    if (ct3d->mctp_shared_buffer) {
+        munmap(ct3d->mctp_shared_buffer, sizeof(*ct3d->mctp_shared_buffer));
+        close(ct3d->mctp_buf_fd);
+        ct3_mctp_buf_unlink(ct3d->mctp_buf_name);
+        ct3d->mctp_shared_buffer = NULL;
+    }
+    g_free(cci_map_buf);
+    cci_map_buf = NULL;
 }
 
 /*
@@ -1352,6 +1463,16 @@ void ct3d_reset(DeviceState *dev)
     }
     cxl_initialize_t3_ld_cci(&ct3d->ld0_cci, DEVICE(ct3d), DEVICE(ct3d),
                              512); /* Max payload made up */
+    if (ct3d->allow_fm_attach) {
+        char name[64];
+
+        memset(name, 0, 64);
+        sprintf(name, "%lu:%s", ct3d->sn, "oob_mctp_cci");
+        add_cci_name_ptr_mapping(name, &ct3d->oob_mctp_cci);
+        cxl_initialize_t3_fm_owned_ld_mctpcci(&ct3d->oob_mctp_cci,
+                                              DEVICE(ct3d), DEVICE(ct3d),
+                                              MCTP_CXL_MAILBOX_BYTES);
+    }
 }
 
 static const Property ct3_props[] = {
@@ -1372,7 +1493,9 @@ static const Property ct3_props[] = {
                                 speed, PCIE_LINK_SPEED_32),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLType3Dev,
                                 width, PCIE_LINK_WIDTH_16),
-    DEFINE_PROP_UINT16("chmu-port", CXLType3Dev, cxl_dstate.chmu[0].port, 0), 
+    DEFINE_PROP_UINT16("chmu-port", CXLType3Dev, cxl_dstate.chmu[0].port, 0),
+    DEFINE_PROP_BOOL("allow-fm-attach", CXLType3Dev, allow_fm_attach, false),
+    DEFINE_PROP_BOOL("mctp-buf-init", CXLType3Dev, mctp_buf_init, false),
 };
 
 static uint64_t get_lsa_size(CXLType3Dev *ct3d)
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ca515cab13..9a00ef7a1e 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -707,6 +707,12 @@ struct CXLType3Dev {
     } dc;
 
     struct CXLSanitizeInfo *media_op_sanitize;
+
+    bool allow_fm_attach;
+    bool mctp_buf_init;
+    struct CXLMCTPSharedBuf *mctp_shared_buffer;
+    char mctp_buf_name[64];
+    int mctp_buf_fd;
 };
 
 #define TYPE_CXL_TYPE3 "cxl-type3"
diff --git a/include/hw/cxl/cxl_mctp_message.h b/include/hw/cxl/cxl_mctp_message.h
new file mode 100644
index 0000000000..85b3664cf7
--- /dev/null
+++ b/include/hw/cxl/cxl_mctp_message.h
@@ -0,0 +1,40 @@
+#ifndef CXL_MCTP_MESSAGE_H_H
+#define CXL_MCTP_MESSAGE_H_H
+#include<stdint.h>
+
+#define MCTP_CXL_MAILBOX_BYTES 512
+#define MCTP_MESSAGE_BUF_NAME "mctp-message-buf"
+
+struct CXLMCTPCommandBuf {
+    /* uint8_t cci_name[64]; */
+    uint8_t command_set;
+    uint8_t command;
+    size_t len_in;
+    size_t len_out;
+    uint8_t payload[MCTP_CXL_MAILBOX_BYTES];
+    uint8_t payload_out[MCTP_CXL_MAILBOX_BYTES];
+    bool bg_started;
+    int ret_val;
+};
+
+typedef struct CXLMCTPCommandBuf CXLMCTPCommandBuf;
+
+struct CXLCCINamePtrMap {
+    char cci_name[64];
+    void *cci_pointer; /* This should be filled by the target VM */
+};
+
+struct CXLCCINamePtrMaps {
+    int num_mappings;
+    struct CXLCCINamePtrMap maps[32];
+};
+
+struct CXLMCTPSharedBuf {
+    /* set to 1 when sent to target VM and wait for 0 as it completes */
+    int status;
+    CXLMCTPCommandBuf command_buf;
+};
+
+typedef struct CXLMCTPSharedBuf CXLMCTPSharedBuf;
+extern struct CXLCCINamePtrMaps *cci_map_buf;
+#endif
-- 
2.47.2


