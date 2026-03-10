Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2E4FCC9C8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 05:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzq4y-0007E5-1E; Tue, 10 Mar 2026 01:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq4w-0007DL-P7
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:56:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq4u-0006HF-PK
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773122184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wlFFomUU0KYOnMpq3yQ4LmNW3UDXKMKW6eMP4G4s9Gk=;
 b=f/J2XnxHkGTa2xsbvFAtVuRLIUq5FKgt4oaumCsyYq8fcbg54w+eQsbJBfoIh6XMgeMdj5
 t84Eyr+pox0cQyJhHT3T3J1nEdBrv8xbwYDN9ypIJlR+ynbPF+sLQUYKvtRYKCGPIGuOGw
 BI0QzcfC7H7RgiKB+D5StlRCf4M8pE8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-OSp7BOFENh6WsBLNbSC97g-1; Tue,
 10 Mar 2026 01:56:21 -0400
X-MC-Unique: OSp7BOFENh6WsBLNbSC97g-1
X-Mimecast-MFC-AGG-ID: OSp7BOFENh6WsBLNbSC97g_1773122180
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7C8C19560A3; Tue, 10 Mar 2026 05:56:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.69])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 651AC1956095; Tue, 10 Mar 2026 05:56:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Jared Rossi <jrossi@linux.ibm.com>
Subject: [PULL 12/25] s390x: Remove duplicate definitions of IPL types
Date: Tue, 10 Mar 2026 06:55:17 +0100
Message-ID: <20260310055530.8893-13-thuth@redhat.com>
In-Reply-To: <20260310055530.8893-1-thuth@redhat.com>
References: <20260310055530.8893-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jared Rossi <jrossi@linux.ibm.com>

Remove the duplicate definitions from hw/s390x/ipl.h and pc-bios/s390-ccw/iplb.h
and add a shared definition.  The new definition is an enum to enforce default
handling in switches.

Because the IPL type is determined by the IPLB, and because an IPLB is not
strictly necessary, the IPL type is set to a default value if not otherwise
specified.  A default IPL type is required so future functionality may add
IPL new bus and/or device types that dictate specific behavior during IPL.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Message-ID: <20260309003601.242634-5-jrossi@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/ipl.h              |  5 -----
 include/hw/s390x/ipl/qipl.h | 10 ++++++++++
 pc-bios/s390-ccw/iplb.h     |  4 ----
 pc-bios/s390-ccw/virtio.h   |  1 +
 pc-bios/s390-ccw/main.c     | 14 ++++++++++----
 5 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 086e57681c2..c542d30ce2d 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -103,11 +103,6 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
 #define DIAG308_PV_STORE            9
 #define DIAG308_PV_START            10
 
-#define S390_IPL_TYPE_FCP 0x00
-#define S390_IPL_TYPE_CCW 0x02
-#define S390_IPL_TYPE_PV 0x05
-#define S390_IPL_TYPE_QEMU_SCSI 0xff
-
 #define S390_IPLB_HEADER_LEN 8
 #define S390_IPLB_MIN_PV_LEN 148
 #define S390_IPLB_MIN_CCW_LEN 200
diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index 6824391111c..6dc12dd859f 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -20,6 +20,16 @@
 #define LOADPARM_LEN    8
 #define NO_LOADPARM "\0\0\0\0\0\0\0\0"
 
+enum S390IplType {
+    S390_IPL_TYPE_FCP = 0x00,
+    S390_IPL_TYPE_CCW = 0x02,
+    S390_IPL_TYPE_PV = 0x05,
+    S390_IPL_TYPE_QEMU_SCSI = 0xff
+};
+typedef enum S390IplType S390IplType;
+
+#define QEMU_DEFAULT_IPL S390_IPL_TYPE_CCW
+
 /*
  * The QEMU IPL Parameters will be stored at absolute address
  * 204 (0xcc) which means it is 32-bit word aligned but not
diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index 08f259ff319..926e8eed5d4 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -23,10 +23,6 @@ extern QemuIplParameters qipl;
 extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 extern bool have_iplb;
 
-#define S390_IPL_TYPE_FCP 0x00
-#define S390_IPL_TYPE_CCW 0x02
-#define S390_IPL_TYPE_QEMU_SCSI 0xff
-
 static inline bool manage_iplb(IplParameterBlock *iplb, bool store)
 {
     register unsigned long addr asm("0") = (unsigned long) iplb;
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 06ba4e45aca..391d6ff2f7f 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -238,6 +238,7 @@ struct VDev {
     VirtioGDN guessed_disk_nature;
     SubChannelId schid;
     SenseId senseid;
+    S390IplType ipl_type;
     union {
         VirtioBlkConfig blk;
         VirtioScsiConfig scsi;
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 8e2c99bee13..2e9261904fa 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -149,7 +149,7 @@ static bool find_subch(int dev_no)
     return false;
 }
 
-static void menu_setup(void)
+static void menu_setup(VDev *vdev)
 {
     if (memcmp(loadparm_str, LOADPARM_PROMPT, LOADPARM_LEN) == 0) {
         menu_set_parms(QIPL_FLAG_BM_OPTS_CMD, 0);
@@ -162,11 +162,13 @@ static void menu_setup(void)
         return;
     }
 
-    switch (iplb.pbt) {
+    switch (vdev->ipl_type) {
     case S390_IPL_TYPE_CCW:
     case S390_IPL_TYPE_QEMU_SCSI:
         menu_set_parms(qipl.qipl_flags & BOOT_MENU_FLAG_MASK,
                        qipl.boot_menu_timeout);
+        /* fall through */
+    default:
         return;
     }
 }
@@ -190,6 +192,7 @@ static void css_setup(void)
 static void boot_setup(void)
 {
     char lpmsg[] = "LOADPARM=[________]\n";
+    VDev *vdev = virtio_get_device();
 
     if (have_iplb && memcmp(iplb.loadparm, NO_LOADPARM, LOADPARM_LEN) != 0) {
         ebcdic_to_ascii((char *) iplb.loadparm, loadparm_str, LOADPARM_LEN);
@@ -198,7 +201,10 @@ static void boot_setup(void)
     }
 
     if (have_iplb) {
-        menu_setup();
+        vdev->ipl_type = iplb.pbt;
+        menu_setup(vdev);
+    } else {
+        vdev->ipl_type = QEMU_DEFAULT_IPL;
     }
 
     memcpy(lpmsg + 10, loadparm_str, 8);
@@ -216,7 +222,7 @@ static bool find_boot_device(void)
     VDev *vdev = virtio_get_device();
     bool found = false;
 
-    switch (iplb.pbt) {
+    switch (vdev->ipl_type) {
     case S390_IPL_TYPE_CCW:
         vdev->scsi_device_selected = false;
         debug_print_int("device no. ", iplb.ccw.devno);
-- 
2.53.0


