Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73926C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YlQ-0001Yc-Cd; Thu, 02 May 2024 11:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2YlE-00017I-9d
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:54:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Yl9-0002P0-JY
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714665251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PBc91Al63eay/PNo3RVE1I5QeuiworYFdD0LlT+cZG4=;
 b=jTNp0e7vxDJdmWFS800v6XHiSjB7AqlNuzml1jQLnNAL1fSgI82ad+s7mSDy5EW4TbvHCW
 4uzl5W9bqGPZLwGoxJ/kYuc382TgEX+GRJ9tw0hrv/WYBl/iC0NeyMIQtEMBayQUwMBhim
 3uNA9Tjj/qFCFOoLJJFcDRzPsmbfLtE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660--OmuU557OrKqDm7he4i-hg-1; Thu, 02 May 2024 11:54:09 -0400
X-MC-Unique: -OmuU557OrKqDm7he4i-hg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-571fdbf99f4so465158a12.3
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 08:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714665248; x=1715270048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PBc91Al63eay/PNo3RVE1I5QeuiworYFdD0LlT+cZG4=;
 b=t8JD6nUwBpqNSa+uYP6LPoVG0KMj7vZ1cdnWxGSWePG8CuOS8b6kC4TteuVBAEGjrQ
 edSB9mylLyzWOHYhUKpRbELt4uO4YbQb8+P0xjm/DnCujTSWPrEzyZUPE8Do3QpJsS+v
 AMY7gxXZxa7Q4hBP4d0AB7cvR9yH30GQXVMQDjNcrbFKnCEgty/sdopSX00VJHFyzo9s
 deGD4XDPhd1AqelniS0LFYJ7KT98F2kZASsi/q9GcVSUBuNL47+HVFS8lAHms+LY7KXw
 NMG/z/AH5/vrt6MQndax1cFANlH/TrxR8R3lcSCfcAgP+F1ziMu5hOJpUsc3TQIf78qJ
 a/YA==
X-Gm-Message-State: AOJu0Yy/PBtP0wCwdWyCGn/YqOKLNSSuonaOb8F6Elbhtw1Yigf8noNU
 1IzljgUTm5CJQjRD7vuwcfcb2kxF5vu0aM/mv4J+FmiZpJtNvYc7Ot5l8xKvfYV+Ns1cPNkmhnI
 EqH7tPSXfbvO/nj/PYW/yYb+5zdHb0yeyhruk+cBsd3dSPL+XGUr2hvcDeRHaPxhuWrRrksjYJG
 +5K9TPhcZBtN5DlPtxJBFUCbJAM2SAo+aQWehD
X-Received: by 2002:a50:bb02:0:b0:56e:2cb6:480e with SMTP id
 y2-20020a50bb02000000b0056e2cb6480emr4816816ede.38.1714665248279; 
 Thu, 02 May 2024 08:54:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGriFC25raM7vICZKZk1VvmSfhez5MMIgmve613I0TnVQrSmUVvmLJOXH1DZmvVCbu4QPQSAA==
X-Received: by 2002:a50:bb02:0:b0:56e:2cb6:480e with SMTP id
 y2-20020a50bb02000000b0056e2cb6480emr4816802ede.38.1714665247940; 
 Thu, 02 May 2024 08:54:07 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 w14-20020a056402128e00b0057278b1b139sm653698edv.29.2024.05.02.08.54.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 08:54:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/13] pci: remove some types from typedefs.h
Date: Thu,  2 May 2024 17:53:31 +0200
Message-ID: <20240502155331.109297-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502155331.109297-1-pbonzini@redhat.com>
References: <20240502155331.109297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

For types that are embedded in structs defined by pci.h, the definition
is pretty much required to be available.  Remove them from typedefs.h.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/pci/pcie.h       |  3 +++
 include/hw/pci/pcie_aer.h   | 38 ++++++++++++++++++-------------------
 include/hw/pci/pcie_sriov.h |  8 ++++----
 include/qemu/typedefs.h     |  5 -----
 4 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 11f5a91bbb7..5eddb909769 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -27,6 +27,9 @@
 #include "hw/pci/pcie_sriov.h"
 #include "hw/hotplug.h"
 
+typedef struct PCIEPort PCIEPort;
+typedef struct PCIESlot PCIESlot;
+
 typedef enum {
     /* these bits must match the bits in Slot Control/Status registers.
      * PCI_EXP_HP_EV_xxx = PCI_EXP_SLTCTL_xxxE = PCI_EXP_SLTSTA_xxx
diff --git a/include/hw/pci/pcie_aer.h b/include/hw/pci/pcie_aer.h
index 4a9f0ea69dc..4d8c0e05077 100644
--- a/include/hw/pci/pcie_aer.h
+++ b/include/hw/pci/pcie_aer.h
@@ -25,8 +25,23 @@
 
 /* definitions which PCIExpressDevice uses */
 
+/* error */
+typedef struct PCIEAERErr {
+    uint32_t status;    /* error status bits */
+    uint16_t source_id; /* bdf */
+
+#define PCIE_AER_ERR_IS_CORRECTABLE     0x1     /* correctable/uncorrectable */
+#define PCIE_AER_ERR_MAYBE_ADVISORY     0x2     /* maybe advisory non-fatal */
+#define PCIE_AER_ERR_HEADER_VALID       0x4     /* TLP header is logged */
+#define PCIE_AER_ERR_TLP_PREFIX_PRESENT 0x8     /* TLP Prefix is logged */
+    uint16_t flags;
+
+    uint32_t header[4]; /* TLP header */
+    uint32_t prefix[4]; /* TLP header prefix */
+} PCIEAERErr;
+
 /* AER log */
-struct PCIEAERLog {
+typedef struct PCIEAERLog {
     /* This structure is saved/loaded.
        So explicitly size them instead of unsigned int */
 
@@ -48,11 +63,11 @@ struct PCIEAERLog {
 
     /* Error log. log_max-sized array */
     PCIEAERErr *log;
-};
+} PCIEAERLog;
 
 /* aer error message: error signaling message has only error severity and
    source id. See 2.2.8.3 error signaling messages */
-struct PCIEAERMsg {
+typedef struct PCIEAERMsg {
     /*
      * PCI_ERR_ROOT_CMD_{COR, NONFATAL, FATAL}_EN
      * = PCI_EXP_DEVCTL_{CERE, NFERE, FERE}
@@ -60,7 +75,7 @@ struct PCIEAERMsg {
     uint32_t severity;
 
     uint16_t source_id; /* bdf */
-};
+} PCIEAERMsg;
 
 static inline bool
 pcie_aer_msg_is_uncor(const PCIEAERMsg *msg)
@@ -69,21 +84,6 @@ pcie_aer_msg_is_uncor(const PCIEAERMsg *msg)
         msg->severity == PCI_ERR_ROOT_CMD_FATAL_EN;
 }
 
-/* error */
-struct PCIEAERErr {
-    uint32_t status;    /* error status bits */
-    uint16_t source_id; /* bdf */
-
-#define PCIE_AER_ERR_IS_CORRECTABLE     0x1     /* correctable/uncorrectable */
-#define PCIE_AER_ERR_MAYBE_ADVISORY     0x2     /* maybe advisory non-fatal */
-#define PCIE_AER_ERR_HEADER_VALID       0x4     /* TLP header is logged */
-#define PCIE_AER_ERR_TLP_PREFIX_PRESENT 0x8     /* TLP Prefix is logged */
-    uint16_t flags;
-
-    uint32_t header[4]; /* TLP header */
-    uint32_t prefix[4]; /* TLP header prefix */
-};
-
 extern const VMStateDescription vmstate_pcie_aer_log;
 
 int pcie_aer_init(PCIDevice *dev, uint8_t cap_ver, uint16_t offset,
diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index b77eb7bf58a..450cbef6c20 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -15,17 +15,17 @@
 
 #include "hw/pci/pci.h"
 
-struct PCIESriovPF {
+typedef struct PCIESriovPF {
     uint16_t num_vfs;   /* Number of virtual functions created */
     uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
     const char *vfname; /* Reference to the device type used for the VFs */
     PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
-};
+} PCIESriovPF;
 
-struct PCIESriovVF {
+typedef struct PCIESriovVF {
     PCIDevice *pf;      /* Pointer back to owner physical function */
     uint16_t vf_number; /* Logical VF number of this function */
-};
+} PCIESriovVF;
 
 void pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
                         const char *vfname, uint16_t vf_dev_id,
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index d23020ed232..5d999e20d7c 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -78,13 +78,8 @@ typedef struct ObjectClass ObjectClass;
 typedef struct PCIBridge PCIBridge;
 typedef struct PCIBus PCIBus;
 typedef struct PCIDevice PCIDevice;
-typedef struct PCIEAERErr PCIEAERErr;
-typedef struct PCIEAERLog PCIEAERLog;
-typedef struct PCIEAERMsg PCIEAERMsg;
 typedef struct PCIEPort PCIEPort;
 typedef struct PCIESlot PCIESlot;
-typedef struct PCIESriovPF PCIESriovPF;
-typedef struct PCIESriovVF PCIESriovVF;
 typedef struct PCIExpressDevice PCIExpressDevice;
 typedef struct PCIExpressHost PCIExpressHost;
 typedef struct PCIHostDeviceAddress PCIHostDeviceAddress;
-- 
2.44.0


