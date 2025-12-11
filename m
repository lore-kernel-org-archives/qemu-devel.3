Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC366D41C14
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 10:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTduN-0008LI-4G; Thu, 11 Dec 2025 05:28:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vTduL-0008Kz-MA; Thu, 11 Dec 2025 05:28:25 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vTduJ-0006hP-JH; Thu, 11 Dec 2025 05:28:25 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDn6ZXDnDppiCpUAw--.388S2;
 Thu, 11 Dec 2025 18:28:19 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDHH+20nDpp4jILAA--.6467S4;
 Thu, 11 Dec 2025 18:28:17 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC 1/1] hw/pci: Add sec-sid property to PCIDevice
Date: Thu, 11 Dec 2025 18:27:29 +0800
Message-Id: <20251211102729.227376-2-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211102729.227376-1-tangtao1634@phytium.com.cn>
References: <20251211102729.227376-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDHH+20nDpp4jILAA--.6467S4
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQABBWk51DEEXAAAso
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7uF4UGr1fuFWkXryrJw4Dtwb_yoW8uF15pF
 Z3JFyIkrZ5GFy8Zanaqa17Gr4UJFZrG3y3Gr4UK3ZrAF47AryYqa1YkFyUuw4UXrWFgF1j
 kFy29ry8Gr1jv3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Arm SMMUv3 uses SEC_SID to control how it interprets the security
state of incoming DMA requests. When SEC_SID=Secure, the SMMU
examines additional signals to distinguish Secure vs Non-secure
streams; when SEC_SID=Non-secure, all requests are treated as
Non-secure streams regardless of other signals.

The SMMU spec states that SEC_SID is a system-defined property.
And devices capable of SEC_SID=Secure should be statically marked
by the system.

This adds a uint8_t sec_sid field and "sec-sid" QOM property to
PCIDevice, allowing boards to configure this attribute. Values are
0 (Non-secure, default) and 1 (Secure).

Note: This is not a PCIe architectural feature. It is purely an
SMMU integration mechanism and does not affect PCIe transactions.

Future RME-DA/TDISP work will use the PCIe TDISP/DTI protocol to model
Realm and Non-secure streams, instead of extending this static field.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/pci/pci.c                | 7 +++++++
 include/hw/pci/pci_device.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index b1eba348e0..1f944d0e39 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -98,6 +98,13 @@ static const Property pci_props[] = {
     DEFINE_PROP_STRING("sriov-pf", PCIDevice, sriov_pf),
     DEFINE_PROP_BIT("x-pcie-ext-tag", PCIDevice, cap_present,
                     QEMU_PCIE_EXT_TAG_BITNR, true),
+
+    /*
+     * System-defined, statically configured SEC_SID for this PCI device, used
+     * by Arm SMMU. Currently only support Non-secure (0) and Secure (1)
+     * security states.
+     */
+    DEFINE_PROP_UINT8("sec-sid", PCIDevice, sec_sid, 0),
     { .name = "busnr", .info = &prop_pci_busnr },
 };
 
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 88ccea5011..16364731da 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -184,6 +184,9 @@ struct PCIDevice {
     uint32_t max_bounce_buffer_size;
 
     char *sriov_pf;
+
+    /* Arm SMMU SEC_SID */
+    uint8_t sec_sid;
 };
 
 static inline int pci_intx(PCIDevice *pci_dev)
-- 
2.34.1


