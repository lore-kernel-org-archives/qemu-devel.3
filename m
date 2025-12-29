Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D7BE8FDBE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 15:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaF1n-0001XK-63; Mon, 29 Dec 2025 10:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaF1h-0001Vl-Bg
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 10:19:19 -0500
Received: from p-west1-cluster4-host10-snip4-10.eps.apple.com ([57.103.65.171]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaF1e-0004dJ-T6
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 10:19:16 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-10-percent-1 (Postfix) with ESMTPS id
 B66C51800143; Mon, 29 Dec 2025 15:19:09 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=szFA/LKTL8zYcXa07dWwkVr1kJdkuzI3VcaFYOV+ul4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=HaSxMyiVkw6tdBsU/Nm74gQcxYHjH9afpSzVDz7jWZ+3wC7w31KsL1XmJud8mrDNfNgbomv4YRGgz86oGXtHa7uovwV5dF2L3yBTCd/qCEuj+3xk2uoCQAt3Q2MwgeHEWtCnyXwx2TPjB3boQnYsyaTutWSu1ymogLKbMDz5s5p4T5zAGULOr7p8hLMM5ieZJRbu76w51Nn98ZxFmx6v/EuqMkhNV295z1U2eYTF/DbcMhlDSLyRB0i28zDLcTQcmYTqhb4CxyAVI0FjyK1TTQRZ2V9PIRKJUBxFayIZKnXybM8fxos+9O4KrZKc7rVkvJ9GfdutwM0bMvutsywoxA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-10-percent-1 (Postfix) with ESMTPSA id
 CB29018005B1; Mon, 29 Dec 2025 15:19:06 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [RFC v3 1/4] vmapple: add gicv2m
Date: Mon, 29 Dec 2025 16:18:47 +0100
Message-ID: <20251229151850.96852-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251229151850.96852-1-mohamed@unpredictable.fr>
References: <20251229151850.96852-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RIEjxuMWSsA07UFRTdNFqFO4ecZ7ihjr
X-Proofpoint-ORIG-GUID: RIEjxuMWSsA07UFRTdNFqFO4ecZ7ihjr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE0MCBTYWx0ZWRfX7CjdVtL7N9g1
 XCZylIMcIgLcm3x9cT3J2H7doodBLGV1aCO3VDeOURRxvH0aQ2m1r8U+iKrwQqIB0KzUIIr59Wn
 YYEKE/FDWJOLhPgt/qkr8xuqlNzrJyzQ46OnbtUt9fZ0OnIMh/b4DRKqTbY3TxHCo5z0TEw2DUV
 9xsFBcODU5xtPYzg1Mb5+CrQQ9EWBfiUGv4Sqax9Ack6m2i+KSTx0GwXYNgoNBix0eg0wT/T4NM
 LQEwyCwuAALYcePvu4Z9pSxIIumz/HIVkDlCb/U++B3P8JmQyu8id8y4mQPGM+iSYcou3zIylls
 shkSENDC7MOS/HjZkij
X-Authority-Info: v=2.4 cv=JNo2csKb c=1 sm=1 tr=0 ts=69529bef cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=sAlVIecbGMDsLuTEZI0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_04,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=859 adultscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2512290140
X-JNJ: AAAAAAABiiQYHiswxJVzJRd7t73xdrkLyRNNQC5dwPPgcZzLkhbnDqVDWNAKnNnSQCEpTcdTr2wvhm2P3AvtM+q+fcWxNmIxOEdCHA5qgPnjtWAlfS8BZCjXgNXfPro3KoGuSw09nDXQaL3Ioblxd4mB8Ht4THMc0Ys3m09lEJnPh2XDr5WtIqv7WEMpGgJuoxcQaGeunnvoNAn889qvmTBkdWD7lx04xHi+GuUSskixxlHv9OImiSP/qxUhg3uaDIVAzeSsI23wiGGrqgg73+o/grqwqhDFYHr+2oT2DuYyvEpuCTRieXi0u91VWJ69GenFgpamDhXbN0nPxc143Apw8YIlOHXjLP8/Gr33UIejpFnVHTsR7F+xjOzFJFJOGic/Cv2oAuzHikgC2/bJ/LIcbpq876wJiQpnWyVqIzqt0/MoNlR7CNhA44tqYY1U9aEIhU0VVqcwHLFXbTFo5hzzN3BXpjE7mnlWdmghMT2Qe+mrExkRl1Ul2SPsgBaQBjsh3t/ezFodR7Yo9Hck21KQIiWIGKZZ+ZqHCvIlg0V2plzBunwfgGBdQMd+lf+I6Q6iyGsDI4D0yFLWOvLQdA05n9hGkkrmeKvEwnnm5KjAKSk2STsX0Bplv7igwTYDDtk7JaR+UTukfoj4hFhdk/ZzPCpssBu14DHAcN73lQbbR3Eb7xajzw+dbNewYqDQQbvN1K4=
Received-SPF: pass client-ip=57.103.65.171;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This device is used by newer macOS guest releases.

Note that macOS does memory accesses through LDP
to this device that don't meet isv=1 conditions.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/vmapple/vmapple.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index b1379eafef..8de7bbe6cd 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -83,6 +83,7 @@ enum {
     VMAPPLE_MEM,
     VMAPPLE_GIC_DIST,
     VMAPPLE_GIC_REDIST,
+    VMAPPLE_GICV2M,
     VMAPPLE_UART,
     VMAPPLE_RTC,
     VMAPPLE_PCIE,
@@ -104,6 +105,7 @@ static const MemMapEntry memmap[] = {
 
     [VMAPPLE_GIC_DIST] =           { 0x10000000, 0x00010000 },
     [VMAPPLE_GIC_REDIST] =         { 0x10010000, 0x00400000 },
+    [VMAPPLE_GICV2M] =             { 0x1FFF0000, 0x00010000 },
 
     [VMAPPLE_UART] =               { 0x20010000, 0x00010000 },
     [VMAPPLE_RTC] =                { 0x20050000, 0x00001000 },
@@ -286,6 +288,26 @@ static void create_gic(VMAppleMachineState *vms, MemoryRegion *mem)
     }
 }
 
+#define NUM_GICV2M_SPIS       128
+
+static void create_gicv2m(VMAppleMachineState *vms)
+{
+    int i;
+    int irq = vms->irqmap[VMAPPLE_GICV2M];
+    DeviceState *dev;
+
+    dev = qdev_new("arm-gicv2m");
+    qdev_prop_set_uint32(dev, "base-spi", irq);
+    qdev_prop_set_uint32(dev, "num-spi", NUM_GICV2M_SPIS);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VMAPPLE_GICV2M].base);
+
+    for (i = 0; i < NUM_GICV2M_SPIS; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
+                           qdev_get_gpio_in(vms->gic, irq + i));
+    }
+}
+
 static void create_uart(const VMAppleMachineState *vms, int uart,
                         MemoryRegion *mem, Chardev *chr)
 {
@@ -496,6 +518,7 @@ static void mach_vmapple_init(MachineState *machine)
                                 machine->ram);
 
     create_gic(vms, sysmem);
+    create_gicv2m(vms);
     create_bdif(vms, sysmem);
     create_pvpanic(vms, sysmem);
     create_aes(vms, sysmem);
-- 
2.50.1 (Apple Git-155)


