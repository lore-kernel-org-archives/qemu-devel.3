Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10725F46122
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 14:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4fop-0000TY-77; Mon, 23 Mar 2026 09:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1w4foG-0008St-25
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:59:16 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1w4foD-0006wZ-Gf
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:59:11 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id ABB9020B703B;
 Mon, 23 Mar 2026 06:59:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ABB9020B703B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1774274346;
 bh=57Nxf0HUrehtTgIAOHD4gvpLgPO803KCA3BRX10c6L0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k6q8KWt76IFtPQRx4EoxjLyHAczwTAFAwykWgBnbrySJ5CVrdRKhDXqe6Cew6CL3U
 ni4M+EKnPKg5GVjHoRek7pE+EXgM93XwPqSJrr/ujI+4kQykNENxVPRIsWFJecihSi
 oztEOE7VsjSEq7kc9185RWpDVYSXqE1oC9zJLSdE=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Wei Liu <wei.liu@kernel.org>, Alex Williamson <alex@shazbot.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC 13/32] accel/mshv: remove redundant msi controller
Date: Mon, 23 Mar 2026 14:57:53 +0100
Message-Id: <20260323135812.383509-14-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
References: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The remaining MsiControl infrastructure can be removed now

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/irq.c          | 11 -----------
 accel/mshv/mshv-all.c     |  2 --
 include/system/mshv_int.h |  3 ---
 3 files changed, 16 deletions(-)

diff --git a/accel/mshv/irq.c b/accel/mshv/irq.c
index 52b8ac9479..4828ac51ac 100644
--- a/accel/mshv/irq.c
+++ b/accel/mshv/irq.c
@@ -25,17 +25,6 @@
 #define MSHV_IRQFD_RESAMPLE_FLAG (1 << MSHV_IRQFD_BIT_RESAMPLE)
 #define MSHV_IRQFD_BIT_DEASSIGN_FLAG (1 << MSHV_IRQFD_BIT_DEASSIGN)
 
-static MshvMsiControl *msi_control;
-static QemuMutex msi_control_mutex;
-
-void mshv_init_msicontrol(void)
-{
-    qemu_mutex_init(&msi_control_mutex);
-    msi_control = g_new0(MshvMsiControl, 1);
-    msi_control->gsi_routes = g_hash_table_new(g_direct_hash, g_direct_equal);
-    msi_control->updated = false;
-}
-
 /* Pass an eventfd which is to be used for injecting interrupts from userland */
 static int irqfd(int vm_fd, int fd, int resample_fd, uint32_t gsi,
                  uint32_t flags)
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 08bc26713f..056b19b3b8 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -426,8 +426,6 @@ static int mshv_init(AccelState *as, MachineState *ms)
 
     mshv_init_mmio_emu();
 
-    mshv_init_msicontrol();
-
     ret = create_vm(mshv_fd, &vm_fd);
     if (ret < 0) {
         close(mshv_fd);
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 9bc56e70cf..7af5bcf022 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -118,7 +118,4 @@ typedef struct MshvMsrEntries {
 int mshv_configure_msr(const CPUState *cpu, const MshvMsrEntry *msrs,
                        size_t n_msrs);
 
-/* interrupt */
-void mshv_init_msicontrol(void);
-
 #endif
-- 
2.34.1


