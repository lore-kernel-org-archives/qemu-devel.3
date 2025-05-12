Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4882EC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 16:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEW5G-0006Rj-7l; Mon, 12 May 2025 12:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1uERxl-0005i5-Dy; Mon, 12 May 2025 08:08:54 -0400
Received: from mxhk.zte.com.cn ([63.216.63.40])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1uERxh-000165-HL; Mon, 12 May 2025 08:08:52 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Zwz0H57mqz8R045;
 Mon, 12 May 2025 20:08:31 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
 by mse-fl1.zte.com.cn with SMTP id 54CC7DSC031745;
 Mon, 12 May 2025 20:07:13 +0800 (+08)
 (envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp01[null]) by mapi (Zmail) with MAPI id mid32;
 Mon, 12 May 2025 20:07:17 +0800 (CST)
Date: Mon, 12 May 2025 20:07:17 +0800 (CST)
X-Zmail-TransId: 2af96821e475ffffffffc46-daa40
X-Mailer: Zmail v1.0
Message-ID: <202505122007170451_WeaVnOMOCnJghLHZ5zH@zte.com.cn>
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>,
 <peterx@redhat.com>, <farosas@suse.de>
Cc: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
Subject: =?UTF-8?B?W1BBVENIIHYyXSBtaWdyYXRpb246IEZpeCBtaWdyYXRpb24gZmFpbHVyZSB3aGVuIGFpYSBpcyBjb25maWd1cmVkIGFzCiAnYXBsaWMtaW1zaWMn?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 54CC7DSC031745
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6821E4BF.004/4Zwz0H57mqz8R045
Received-SPF: pass client-ip=63.216.63.40; envelope-from=liu.xuemei1@zte.com.cn;
 helo=mxhk.zte.com.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 12 May 2025 12:32:52 -0400
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

From: Xuemei Liu <liu.xuemei1@zte.com.cn>

Address an error in migration when aia is configured as 'aplic-imsic' in
riscv kvm vm by adding riscv_aplic_state_needed() and
riscv_imsic_state_needed() to determine whether the corresponding sates are
needed.

Previously, the fields in the vmsds of 'riscv_aplic' and 'riscv_imsic' can
only be initialized under certain special conditions in commit 95a97b3fd2.
However, the corresponding ses of these vmsds are inserted into the
savevm_state.handlers unconditionally. This led to migration failure
characterized by uninitialized fields when save vm state:
qemu-system-riscv64: ../migration/vmstate.c:433: vmstate_save_state_v:
Assertion 'first_elem || !n_elems || !size' failed.

Fixes: 95a97b3fd2 ("target/riscv: update APLIC and IMSIC to support KVM AIA")

Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
---

 Changes in v2:

 - Dropped the modifications in vmstate_register_with_alias_id()
 - Added riscv_aplic_state_needed() and riscv_imsic_state_needed()

 hw/intc/riscv_aplic.c | 8 ++++++++
 hw/intc/riscv_imsic.c | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 8bcd9f4697..c9abef2e0f 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -962,10 +962,18 @@ static const Property riscv_aplic_properties[] = {
     DEFINE_PROP_BOOL("mmode", RISCVAPLICState, mmode, 0),
 };

+static bool riscv_aplic_state_needed(void *opaque)
+{
+    RISCVAPLICState *aplic = opaque;
+
+    return riscv_use_emulated_aplic(aplic->msimode);
+}
+
 static const VMStateDescription vmstate_riscv_aplic = {
     .name = "riscv_aplic",
     .version_id = 2,
     .minimum_version_id = 2,
+    .needed = riscv_aplic_state_needed,
     .fields = (const VMStateField[]) {
             VMSTATE_UINT32(domaincfg, RISCVAPLICState),
             VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index 2169988167..92a7254076 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -398,10 +398,16 @@ static const Property riscv_imsic_properties[] = {
     DEFINE_PROP_UINT32("num-irqs", RISCVIMSICState, num_irqs, 0),
 };

+static bool riscv_imsic_state_needed(void *opaque)
+{
+    return !kvm_irqchip_in_kernel();
+}
+
 static const VMStateDescription vmstate_riscv_imsic = {
     .name = "riscv_imsic",
     .version_id = 1,
     .minimum_version_id = 1,
+    .needed = riscv_imsic_state_needed,
     .fields = (const VMStateField[]) {
             VMSTATE_VARRAY_UINT32(eidelivery, RISCVIMSICState,
                                   num_pages, 0,
-- 
2.27.0

