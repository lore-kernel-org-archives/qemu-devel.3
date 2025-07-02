Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12287C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 17:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX0r8-0003gW-In; Wed, 02 Jul 2025 13:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uX0qt-0003en-Sm
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uX0qs-0003Zn-AV
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751475749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ruSGpmkFJBGyYr3CHYyTnKbMvkvQxsYmlHonL6/H1HE=;
 b=YhelRL0EBAPC91R5IW3qmmwUJIXwDRXHLpSQen4zmcOuszd+Vyp+4OMLvVAJjhLSGGzC8e
 ROlK0YBC/oiph/+Nb2czk+lo1nwL/Os7OlynwfhJ56E5Ig7VoFNBtojJigE4z35FAstu2/
 VNPoOwgYUROJa9cSVtcmQv9IuJAywkE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-OqbMTZ1HOdarB0P5o5sEjg-1; Wed,
 02 Jul 2025 13:02:27 -0400
X-MC-Unique: OqbMTZ1HOdarB0P5o5sEjg-1
X-Mimecast-MFC-AGG-ID: OqbMTZ1HOdarB0P5o5sEjg_1751475747
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D8F6193F069; Wed,  2 Jul 2025 17:02:22 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.23])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 86ED31956048; Wed,  2 Jul 2025 17:02:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Sean Wei <me@sean.taipei>
Subject: [PULL 5/9] treewide: fix paths for relocated files in comments
Date: Wed,  2 Jul 2025 19:02:00 +0200
Message-ID: <20250702170206.212303-6-thuth@redhat.com>
In-Reply-To: <20250702170206.212303-1-thuth@redhat.com>
References: <20250702170206.212303-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Sean Wei <me@sean.taipei>

After the docs directory restructuring, several comments
refer to paths that no longer exist.

Replace these references to the current file locations
so readers can find the correct files.

Related commits
---------------

  189c099f75f (Jul 2021)
    docs: collect the disparate device emulation docs into one section
    Rename  docs/system/{ => devices}/nvme.rst

  5f4c96b779f (Feb 2023)
    docs/system/loongarch: update loongson3.rst and rename it to virt.rst
    Rename  docs/system/loongarch/{loongson3.rst => virt.rst}

  fe0007f3c1d (Sep 2023)
    exec: Rename cpu.c -> cpu-target.c
    Rename  cpus-common.c => cpu-common.c

  42fa9665e59 (Apr 2025)
    exec: Restrict 'cpu_ldst.h' to accel/tcg/
    Rename  include/{exec/cpu_ldst.h => accel/tcg/cpu-ldst.h}

Signed-off-by: Sean Wei <me@sean.taipei>
Message-ID: <20250616.qemu.relocated.06@sean.taipei>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/spin/tcg-exclusive.promela | 4 ++--
 hw/nvme/ctrl.c                  | 2 +-
 target/arm/cpu.c                | 2 +-
 target/loongarch/README         | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/docs/spin/tcg-exclusive.promela b/docs/spin/tcg-exclusive.promela
index c91cfca9f73..1d03af850b7 100644
--- a/docs/spin/tcg-exclusive.promela
+++ b/docs/spin/tcg-exclusive.promela
@@ -1,6 +1,6 @@
 /*
  * This model describes the implementation of exclusive sections in
- * cpus-common.c (start_exclusive, end_exclusive, cpu_exec_start,
+ * cpu-common.c (start_exclusive, end_exclusive, cpu_exec_start,
  * cpu_exec_end).
  *
  * Author: Paolo Bonzini <pbonzini@redhat.com>
@@ -65,7 +65,7 @@
                              }
 #define COND_BROADCAST(c)    c++
 
-// this is the logic from cpus-common.c
+// this is the logic from cpu-common.c
 
 mutex_t mutex;
 cond_t exclusive_cond;
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 220002830de..e764ec7683a 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -22,7 +22,7 @@
  *
  * Usage
  * -----
- * See docs/system/nvme.rst for extensive documentation.
+ * See docs/system/devices/nvme.rst for extensive documentation.
  *
  * Add options:
  *      -drive file=<file>,if=none,id=<drive_id>
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a59a5b57af6..ebac86f70d3 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2644,7 +2644,7 @@ static const char *arm_gdb_get_core_xml_file(CPUState *cs)
  * linux syscall TIF_TAGGED_ADDR setting, not TBI in general.
  *
  * There should be a better place to put this, but we need this in
- * include/exec/cpu_ldst.h, and not some place linux-user specific.
+ * include/accel/tcg/cpu-ldst.h, and not some place linux-user specific.
  *
  * Note that arm-*-user will never set tagged_addr_enable.
  */
diff --git a/target/loongarch/README b/target/loongarch/README
index 0b9dc0d40a0..1ffd3422d22 100644
--- a/target/loongarch/README
+++ b/target/loongarch/README
@@ -11,7 +11,7 @@
 
 - System emulation
 
-  You can reference docs/system/loongarch/loongson3.rst to get the information about system emulation of LoongArch.
+  You can reference docs/system/loongarch/virt.rst to get the information about system emulation of LoongArch.
 
 - Linux-user emulation
 
-- 
2.50.0


