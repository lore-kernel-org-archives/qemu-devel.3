Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1FACCF2C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhb4-0008QY-Eu; Fri, 16 Oct 2026 09:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHew5-0001jy-Mu; Fri, 16 Oct 2026 06:13:14 -0400
Received: from out203-205-221-155.mail.qq.com ([203.205.221.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHew2-000222-Ps; Fri, 16 Oct 2026 06:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792145586; bh=T2aVuixcbXg2L63BOa+6sJHS5UVg7DPyy+uwZi5T7tw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=wSn4XXs0W1mySK9lgAPN0KnFNCU57/K0/Pao598cATXb8bgJdz5ztebOJeTx4oOD+
 qJ2257yyLlJn9HDI3iRVdY6ABoh2FBCMt4eir+GhfMAxmeoWZFc++tQzPGzCLTe/Qq
 DCYyfolgHtqvdfe8bNAm/lglpPJLYCDNgMuMhFVo=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
 id 343008B3; Fri, 16 Oct 2026 18:13:03 +0800
X-QQ-mid: xmsmtpt1792145583t6pns1ewc
Message-ID: <tencent_88B063FC15FDB4BD89164484DB67A9B61907@qq.com>
X-QQ-XMAILINFO: Mpk1SqVBRfAQ6JqY3QMRRJ5HkzCkyYB4xjUI95uJg/3U3QYE9USr+HDeOLn8xq
 uGtP2TE1LaTm96Trj1SQ5NY+dVEny56lLa3+xjkhjw5cLtSs0wx/SEEigkWsWlGluLyIRQ+KcRF1
 HRJHRSZIp5CPb35EjDs0I9audG4ohQpuRZEaK8N6edcrtWKyxMitJLA3ozYXbknZowrq6PLmx13w
 3eswCz2nnLb0Ff4fVuo+1VnwlnWY3ZeAn2+kWa0DK5xRBqy3LKRqXHWEgzO1gQNeT7zSLc/G7XXD
 N2YKtvO/5pROpjSUwohdpQ7fMbo/p0Or+jqu2lAwBHhvU7GUwTV7NvK0bI03cLzMYWGgmEOAU+AO
 JPfpRHvMeyu+/iYFNSIZhbDvdFxsZIR8FpajeGEIqAqYE5yLF1ozNnQ0EpDfmKjqNOS+TTVxs6bq
 GQ3ToNATpVznV7D5RxDA2khw1y2C+q6iZ446BVhWXQZVYyZsVRb10qNkvsT5NcVVRv83ED6W0/5Q
 +8NEop/9ulySebocRlq8fgDX2XsWT6j+LvDK70EnS2R9ZehgI1/c9d2oZ+15LUSEvgicDsdZ1d8F
 CZxgom0Uo9uFaIUMVQgRzJHs5aOOrjeLYjbIXu+XZhawBjIwUGxM7NAbZwy0kKqeciJuRuO+5mVm
 KJ54Rwd2cJgMhqyEperLRwYmFS17yK2RxtOJ/Et7mivTtIBoKajUHKSsjSmcbHi7IoIqI1L3wGP4
 zGm2H1Jz08lInMc9r/qdmxSgkOXGg3wwt4UPH7bH5ivzWx1LTtMoysNfQreuwl2K6He2kb3lwKaq
 rCa5J5n6d4FQEuTnMAKKp5zBmEcOOSGIHSQjRQvUqebYdVm0Y4iivumQ3OtY2o5NFmpbgcYCAvDu
 BHsyrwrTwu44ZIfZR81yjX/+4hMhtNIvk+aRIFnX8jGYmDnsbyUfNQuYRvk3ChcadORtO9Qbq/67
 dvpF6fWMJc/3bXt4bginoPfV1mAvAq5wFdAcS3IvMPUCfC7gwfqDkCb1A3XzTLsGQludCFhA1cWC
 lGO16Oi7XXdzh2tHOifnqUNVEqnciDJsG273mjGdpkR3+zgurs2Ulv65+F5QX+wosMPvvuVFig2V
 GLZ+GADYeCatSR6xaeFADCXAjgaA3TTTRm2Unt6hzk1DYaYtaxBD9DjSP/KA==
X-QQ-XMRINFO: N+gupeqCsbX2VDY1MJ80Zvm2Nd9q8sTYww==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 17/37] hw/arm/virt: Add mpam and mpam-min-msc machine
 properties
Date: Fri, 16 Oct 2026 18:10:37 +0800
X-OQ-MSGID: <20261016101058.1900808-3-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016101058.1900808-1-2118537295@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.155; envelope-from=2118537295@qq.com;
 helo=out203-205-221-155.mail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:42 -0400
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

Add the two MPAM machine properties: mpam=on enables MSC emulation
for the virt board, and mpam-min-msc=on collapses the per-node
memory MSCs into a single MSC with one RIS per node.  The state
fields and the property accessors only; MSC creation arrives with
the later patches.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/virt.c         | 47 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/virt.h |  2 ++
 2 files changed, 49 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9d19251..aaadff6 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2133,6 +2133,14 @@ static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
     }
 }
 
+/*
+ * Partitioning geometry for board-created MSCs: 256 request PARTIDs
+ * narrowed to 32 internal PARTIDs (enables HAS_PARTID_NRW, so resctrl
+ * reports num_closids=32).
+ */
+#define MPAM_VIRT_NUM_PARTID     256
+#define MPAM_VIRT_NUM_INTPARTID  32
+
 static void create_pcie(VirtMachineState *vms)
 {
     hwaddr base_mmio = vms->memmap[VIRT_PCIE_MMIO].base;
@@ -3498,6 +3506,34 @@ static void virt_set_virtio_transports(Object *obj, Visitor *v,
     vms->virtio_transports = transports;
 }
 
+static bool virt_get_mpam(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    return vms->mpam;
+}
+
+static void virt_set_mpam(Object *obj, bool value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    vms->mpam = value;
+}
+
+static bool virt_get_mpam_min_msc(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    return vms->mpam_min_msc;
+}
+
+static void virt_set_mpam_min_msc(Object *obj, bool value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    vms->mpam_min_msc = value;
+}
+
 static bool virt_get_dtb_randomness(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -4303,6 +4339,17 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "guest CPU which implements the ARM "
                                           "Memory Tagging Extension");
 
+    object_class_property_add_bool(oc, "mpam", virt_get_mpam, virt_set_mpam);
+    object_class_property_set_description(oc, "mpam",
+                                          "Set on/off to enable/disable "
+                                          "emulation of MPAM MSCs");
+
+    object_class_property_add_bool(oc, "mpam-min-msc", virt_get_mpam_min_msc,
+                                   virt_set_mpam_min_msc);
+    object_class_property_set_description(oc, "mpam-min-msc",
+                                          "Use RIS to reduce the number of "
+                                          "MSCs exposed");
+
     object_class_property_add_bool(oc, "its", virt_get_its,
                                    virt_set_its);
     object_class_property_set_description(oc, "its",
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 22e66d1..c847136 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -177,6 +177,8 @@ struct VirtMachineState {
     bool ras;
     bool mte;
     bool dtb_randomness;
+    bool mpam;
+    bool mpam_min_msc;
     bool second_ns_uart_present;
     OnOffAuto acpi;
     VirtGICType gic_version;
-- 
2.43.0


