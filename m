Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E85606A93B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PscMuQ9a
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8vO-0003ES-1K; Thu, 19 Nov 2026 15:40:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xU8vA-0003B7-0d
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:39:55 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xU8v3-0007Jp-U4
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:39:50 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJKFpoi3354957
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kLGFjAZekQM
 rnOWQURYvjxdaFgHeFlhem0RNmV+idrk=; b=PscMuQ9a9wYep13Bk9ZhanbKEle
 jOhr1TxnPXueLEdrl7F0QNBw+6mtd7ixQ0qZZxuo8GYIl1KDqutyhPZa3w0qZaFd
 nD0OCN7ld25VEnv/GtjkmSF/6NNwk3PEfBlzV4Tyo3+3gObteKrFesuPmPW6cvM1
 UNI6xumzELTR19tVQWjrzDw4CN7BM9136NUXWt8bq0xLuODcAuXQ3xVa4w628F7p
 AooltMEuyr6QQawW0Bktn1qJ4ZVvvkbxsbRK2E5Yw7vGGHgJaqNz2XRp6gcbcqfE
 geRPuJiJOQQTOokQP1EJqu1bAwYRtkw+u49E3tOrvByl0jqvKQ4ZRe13+bw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27fyg916-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:39:42 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJKdgdO3698928; Thu, 19 Nov 2026 20:39:42 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AJKdfZK3698909
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 20:39:41 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id A4DD625791; Thu, 19 Nov 2026 12:39:41 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v2 13/13] tests/functional/hexagon: add packet regression tests
Date: Thu, 19 Nov 2026 12:39:41 -0800
Message-ID: <20261119203941.899748-14-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119203941.899748-1-marco.liebel@oss.qualcomm.com>
References: <20261119203941.899748-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4MiBTYWx0ZWRfX9RECaoyTHn0g
 lPVVQNfcKNHzBDv1d9lvKqMvP1oOQH9lTN6ie7gtDT6UrNHdqGeN7QLKWzswxNk6pp9gIyIcudx
 7M6rDm/LXxifE84Zoz2o9RziUxo9AfM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4MiBTYWx0ZWRfX3ry0GO8jpGi6
 VmOx2uxjAKNe9qKD80Ldjz0uwjuIv/Or0C1Z8yg743PovoxJBl8QKzLLb3IB+5Dp37K3I9yOqIm
 HYxdy1mC2QIgF53VkxE6J2x02OtGGa76vloHiZsOotoxcAqsfEncxX8A7pWmUUNqAS7A8PxAXxS
 h/7G/tadjNZHuxu9J7hzmJWkeVS9dmQe1RPFqvYZMJSYAhPF6r83qWkV3MV32ZqHv/3eGouuKrB
 G3XwM00U0Iizw4Rqt89WKOVeOJuVriCsmJ6fc9z3cilROwlNMMwmAuxwPSZOutqLr2yQeVnYGuY
 W0g+9qR8l+uG1l+gMu0HwZRoY9ViiiB1b3U03rAEGs1/T22X0j6X4hqmGykhgLVb/8PA+jURi42
 TsAWgxGpW4zQVQlH8sqoJmVsT7XQhXhXfdDYURIu0BPcvQi0qfFyVUxYnoUfs0PDI6Z9mVN9GJS
 4gIJl8PML4bHf3mB/dg==
X-Authority-Analysis: v=2.4 cv=GZKCDgXL c=1 sm=1 tr=0 ts=6aff5e8e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8
 a=Z9VDHF9Blclki5krBAIA:9 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: lwIfdOUZQfhm2jxbQmoMp02jPmJtKplF
X-Proofpoint-GUID: lwIfdOUZQfhm2jxbQmoMp02jPmJtKplF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Run the standalone packet binary from qemu-hexagon-testing v0.3.5 and
check all 11 system case results and the final summary. Use the existing
standalone archive layout with a checksum-verified release archive.
Stop QEMU after the runtime prints the results.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 tests/functional/hexagon/meson.build     |  2 +
 tests/functional/hexagon/test_packets.py | 47 ++++++++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 tests/functional/hexagon/test_packets.py

diff --git a/tests/functional/hexagon/meson.build b/tests/functional/hexagon/meson.build
index 3dd40ed046..a653a4fa76 100644
--- a/tests/functional/hexagon/meson.build
+++ b/tests/functional/hexagon/meson.build
@@ -6,6 +6,7 @@ tests_hexagon_system_thorough = [
   'systests',
   'hlx',
   'minivm',
+  'packets',
 ]
 
 test_hexagon_timeouts = {
@@ -13,4 +14,5 @@ test_hexagon_timeouts = {
   'qcom_dsp_firmware': 240,
   'systests': 180,
   'hlx': 180,
+  'packets': 180,
 }
diff --git a/tests/functional/hexagon/test_packets.py b/tests/functional/hexagon/test_packets.py
new file mode 100644
index 0000000000..00ea7bf49b
--- /dev/null
+++ b/tests/functional/hexagon/test_packets.py
@@ -0,0 +1,47 @@
+#!/usr/bin/env python3
+#
+# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from pathlib import Path
+
+from qemu_test import Asset, QemuSystemTest, wait_for_console_pattern
+
+
+class PacketTests(QemuSystemTest):
+    timeout = 180
+
+    ASSET_TARBALL = Asset(
+        "https://github.com/qualcomm/qemu-hexagon-testing/releases/"
+        "download/v0.3.5/systests_standalone.tar.gz",
+        "640b0aa60af7d3e561c25c33079c31dd6a7077fed757f9d29c0ad9ee9f2eca19",
+    )
+
+    def test_packets(self):
+        self.archive_extract(self.ASSET_TARBALL)
+        kernel = Path(self.scratch_file(
+            "systests_standalone_package",
+            "StandaloneSysTests_6.7.0.0_v68", "bin", "packet_tests"))
+        self.assertTrue(kernel.is_file(), str(kernel))
+        self.set_machine("V85NA_1")
+        self.set_vm_arg("-display", "none")
+        self.set_vm_arg("-kernel", str(kernel))
+        self.vm.set_console(semihosting=True)
+        self.vm.launch()
+        names = (
+            "hmx_address", "hlx_disable", "fetch_cause", "fetch_pc", "fault_slot",
+            "fault_validity", "inactive_badva", "store_priority",
+            "alignment_priority", "store_rollback", "vmemu_fault",
+        )
+        try:
+            for name in names:
+                wait_for_console_pattern(self, "PASS " + name, "FAIL")
+            wait_for_console_pattern(self, "PASS packet_tests: 11 cases",
+                                     "FAIL")
+        finally:
+            self.vm.kill()
+
+
+if __name__ == "__main__":
+    QemuSystemTest.main()
-- 
2.43.0


