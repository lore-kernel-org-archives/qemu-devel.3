Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA207606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hyC+7fKF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVPED-0007jK-Un; Mon, 23 Nov 2026 03:16:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xVPE8-0007hU-AV; Mon, 23 Nov 2026 03:16:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xVPE6-0000Ck-An; Mon, 23 Nov 2026 03:16:40 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AN54iZr2766698; Mon, 23 Nov 2026 08:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=2Cz4iQC1XgEr3eif6
 y8EjhF1kpS5gAHLYJrBg4XNJjk=; b=hyC+7fKFg61IdT/RH5HVjaafTvAU288mJ
 QLZKh70ATqR4atDTLt2PgRiaFShIydvbjjHTqfDyBPt+zpSqlhnPz1VCV16F0Z13
 jYJ2EKLZfooGJMhovNUkNkSPNZPaAVBaDHf1NbmK9AWXl5fQfWiUhPxnSCc/O0LW
 pEzdE8VsxzlLROPGfF11w2nsgu0vf0GZlNQ3foYmyVSC6D9E1wpSlwGiTjOewKUv
 HUR1USJyvUSayW34o4WfxsDRWcbMYjOt1XrjtS4kx7Y7YijWTmfAC2x3nIpOU7g1
 OrOySSOo2ZljGcILvCPwjsJEh1xMUnObhX6VvKxLo6zMDvcJtxi7A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fa26k8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 23 Nov 2026 08:16:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AN54Ln72487380; Mon, 23 Nov 2026 08:16:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3q4h5u95-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Nov 2026 08:16:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AN8GT4B47972700
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Nov 2026 08:16:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B42402004D;
 Mon, 23 Nov 2026 08:16:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 39C7B20049;
 Mon, 23 Nov 2026 08:16:27 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.bl1-in.ibm.com (unknown [9.123.4.64])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Nov 2026 08:16:27 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sbhat@linux.ibm.com,
 mahesh@linux.ibm.com, sourabhjain@linux.ibm.com, adityag@linux.ibm.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, alex@shazbot.org, clg@redhat.com
Cc: amachhiw@linux.ibm.com, hbathini@linux.ibm.com, shivangu@linux.ibm.com,
 anushree.mathur@linux.ibm.com
Subject: [PATCH v3 1/2] vfio/pci: Add persistent BAR mmap blocking helper
Date: Mon, 23 Nov 2026 13:45:48 +0530
Message-ID: <20261123081546.49210-5-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123081546.49210-4-nnmlinux@linux.ibm.com>
References: <20261123081546.49210-4-nnmlinux@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzMiBTYWx0ZWRfX8KHNeQMEAsIy
 +MdO8b4ZcA+sQy/GvaHQoanz2bQ2G9r8a2qp5UfN5hUsIxS5+zjDZFzO8FTCT6/jw+CpNYldr9A
 GLzbJPuqvMlY4NqznwnvpwXEKyd9azmdsBdhwp+DaqVnd0K+hxHLzdo+nkvwaupE5orydR0tWU8
 mBK/oj4aAAIjoZWTUOWIuBIFm5isZLf/TMJ+8Zd5B4elpacJPyhuOSNZzWAEXbBxzJZvojjqRH5
 nISaRZn3GxLcrboURacU/LVyNFsQPixea5/RVqArQLgESpjubanB/NfZddoWu0uW6L9mqSYuE7K
 q84zkudWYGMLuw/8fqbmIIMZL3+6e2Fl6YtVhnn6bn6GSLBA1MLz4aQlkdL8N3iRoUFaQfDcjXt
 flgbXr1GDb1m1SvnLbhcK5wYm2d6nQzWhSn+drx+2ShETCDxj3VvCKbqxvhkSge+02jFkJysPsb
 hqWhUYVW335CAUcJ0oQ==
X-Proofpoint-ORIG-GUID: 9sYxKfkzdHaK7xLeqR0IQDrw9OF5se36
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b03f663 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Bd8M855nNT3eeMdd3qoA:9
X-Proofpoint-GUID: WWf_qMQJXqZLVNvbc4yPhiOjWN-N-Gyb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzMiBTYWx0ZWRfX6iLgRLikGLdg
 9oPCpQDX+2xshmdhVqv3YuaL4IG8xN0F8a10O5qamgY7iYMnAUrSdDaoMyRkKOEQT8OQtFOfGu+
 DGeFcuUNlbR4GuQRQkxTf9UhY7AhcUU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230032
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some platform recovery flows need to stop using direct mmap-backed BAR
subregions after a device reset.  Disabling the subregions once is not
sufficient because the VFIO INTx mmap timer and interrupt-mode
transitions can later call vfio_mmap_set_enabled() with enabled=true.

Add a generic per-device mmap_blocked state and
vfio_pci_mmap_block().  Once a device is blocked, attempts to re-enable
its direct BAR mmap subregions are ignored.  The helper also cancels a
pending INTx mmap re-enable timer and disables all currently active BAR
mmap subregions.

The parent VFIO MemoryRegion remains enabled, so BAR accesses continue
through vfio_region_read()/vfio_region_write() using the VFIO device fd.
The helper contains no platform or EEH policy; callers decide when a
recovery flow requires direct mmap to remain blocked.

The block is intentionally persistent for the lifetime of the VFIO
device object.  No unblock operation is added until there is a proven
safe point at which an existing direct BAR mmap can be reused after such
a reset.  The state is not migrated because it controls a local access
path optimization rather than guest-visible device state.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 hw/vfio/pci.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h |  7 ++++++
 2 files changed, 66 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 0da2e143b8..49d6b7d3f4 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1949,11 +1949,70 @@ static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled)
 {
     int i;
 
+    /*
+     * Some recovery flows require direct BAR mmap to remain disabled
+     * after a device reset.  Honour mmap_blocked so that INTx timer
+     * callbacks and interrupt-mode transitions cannot re-enable
+     * the direct mmap subregions once the device has been blocked.
+     */
+    if (enabled && vdev->mmap_blocked) {
+        return;
+    }
+
     for (i = 0; i < PCI_ROM_SLOT; i++) {
         vfio_region_mmaps_set_enabled(&vdev->bars[i].region, enabled);
     }
 }
 
+/**
+ * vfio_pci_mmap_block - Persistently block direct BAR mmap access
+ * @vdev: the VFIO PCI device
+ *
+ * Some recovery flows cannot safely resume direct BAR mmap access using
+ * mappings that were established before the device was reset.  Once the
+ * device is blocked, keep accesses on the VFIO region read/write path
+ * rather than allowing later interrupt-mode or timer activity to restore
+ * the direct mmap subregions.
+ *
+ * This helper:
+ *   1. Sets mmap_blocked so that no subsequent interrupt-mode
+ *      transition or INTx mmap timer callback can re-enable direct
+ *      BAR mmap access.
+ *   2. Cancels any pending INTx mmap re-enable timer.
+ *   3. Disables all currently active BAR mmap subregions.
+ *
+ * The parent slow-path VFIO MemoryRegion remains enabled, so BAR
+ * accesses continue via vfio_region_read()/vfio_region_write() which
+ * use pread()/pwrite() on the VFIO device fd.  This is slower than
+ * the direct mmap path but remains available while mmap is blocked.
+ *
+ * The flag is intentionally not cleared by this helper.  Blocking is
+ * persistent for the lifetime of the VFIO device object unless a future
+ * change introduces an explicit, proven-safe unblock operation.
+ *
+ * The function is idempotent.
+ */
+void vfio_pci_mmap_block(VFIOPCIDevice *vdev)
+{
+    if (vdev->mmap_blocked) {
+        return;
+    }
+
+    vdev->mmap_blocked = true;
+
+    /*
+     * Cancel any pending INTx mmap re-enable timer.  Without this the
+     * timer could still fire and call vfio_mmap_set_enabled() with
+     * enabled=true.  That would be blocked by the flag above, but
+     * cancelling it avoids the unnecessary wakeup.
+     */
+    if (vdev->intx.mmap_timer) {
+        timer_del(vdev->intx.mmap_timer);
+    }
+
+    vfio_mmap_set_enabled(vdev, false);
+}
+
 static void vfio_bar_prepare(VFIOPCIDevice *vdev, int nr)
 {
     VFIOBAR *bar = &vdev->bars[nr];
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 7ff52e9a52..d4c3c9eeae 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -187,6 +187,12 @@ struct VFIOPCIDevice {
     bool defer_kvm_irq_routing;
     bool clear_parent_atomics_on_exit;
     bool skip_vsc_check;
+    /*
+     * Block direct BAR mmap subregions for the lifetime of this
+     * VFIO device.  Calls that would re-enable mmap are ignored
+     * while this flag is set.
+     */
+    bool mmap_blocked;
     uint16_t vpasid_cap_offset;
     OnOffAuto ats;
     VFIODisplay *dpy;
@@ -243,6 +249,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
 /* BARs */
 void vfio_pci_bars_exit(VFIOPCIDevice *vdev);
 void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev);
+void vfio_pci_mmap_block(VFIOPCIDevice *vdev);
 
 /* Capabilities */
 bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp);
-- 
2.54.0


