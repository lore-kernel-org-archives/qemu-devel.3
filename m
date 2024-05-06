Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC38C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tAT-0000dm-7F; Mon, 06 May 2024 03:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tA0-0008PL-Qj
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9y-0001of-UP
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PBc91Al63eay/PNo3RVE1I5QeuiworYFdD0LlT+cZG4=;
 b=cNq2BTobDjocPm1/yTfp1O7DNVuRCluSiC1/AQnu9ckH0Ik9HsPgIHDRauM4lT5XFNTYH3
 /LYyxM8R0Yy4Z+jnvLBiB3DzE0xm5PTlElATHwo0HjdujUmY2z7zQu0wchkLJX7UlBsSKk
 OxCUdjxojbtG0ktu3DACB/202TEgcRE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-bmG9KkvQPpOeiBemyqq2-g-1; Mon, 06 May 2024 03:53:16 -0400
X-MC-Unique: bmG9KkvQPpOeiBemyqq2-g-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-572eea3758dso936519a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981995; x=1715586795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PBc91Al63eay/PNo3RVE1I5QeuiworYFdD0LlT+cZG4=;
 b=UesV82iQorBGvkZPfRBJhRpqLXT9vhHy7ecRWkAc8PdSe9DOM4ViBOUZEO2XAU7GYA
 yp1OJvo9y0ItxzQl9ausd5VP3w942ufHbKJxSBVOZ8qtrFAAVdK27TkP4HVPBv71m1UI
 Ggod/lOWBgtpmzSKaIVPbqFpV6QfxCK3flwOt8GzkbnVX0zXjw0HPu/2P+6AnAa5poS5
 mf7Uw8N+FD+TuUNyJM5yZlMgA68p+YmEA7ZOymFP9Kw95oksnD3GJPLq0byByr+1mmAi
 VbVCTjxH6hy9gtDhCW0aG8uieiqDs4WC/fHU+JO8RXYYUcz2DkuxZx6+NVFusHP/wzni
 Ajtg==
X-Gm-Message-State: AOJu0Yy+1Q7OboZZzhGLljxzjGGMPM5w0uZEPFHZDR7GjNwQzk3WTYNs
 uezfavEawFx8evC3JJY1mR7i9WPZRPJ3cYeqaP0ZP/GAZvqEQW7EzmsGcFqswGbjgq63E3BdSmg
 Gnhaww3EFY+fyHWaMUVyO8GQ3IuFm21cEf1W9ecAwv3U+Q4I450S/mucbuiBN25WCgoh7vv/84C
 Wwj05IlfHwLFAW1cG8kKXAMwF6kOxw0B2FAxNF
X-Received: by 2002:a50:9517:0:b0:572:3b3c:754f with SMTP id
 u23-20020a509517000000b005723b3c754fmr7817519eda.4.1714981994733; 
 Mon, 06 May 2024 00:53:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGppqGdAs2zybrcxN9jzvl1TwJaaSQzyrl25XUDjUHrwZtGd5YDk4Dq/WziKo44smKaXQHFMg==
X-Received: by 2002:a50:9517:0:b0:572:3b3c:754f with SMTP id
 u23-20020a509517000000b005723b3c754fmr7817492eda.4.1714981994282; 
 Mon, 06 May 2024 00:53:14 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 c21-20020aa7df15000000b005727bdb1eafsm4805919edy.40.2024.05.06.00.53.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:53:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 43/46] pci: remove some types from typedefs.h
Date: Mon,  6 May 2024 09:51:22 +0200
Message-ID: <20240506075125.8238-44-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


