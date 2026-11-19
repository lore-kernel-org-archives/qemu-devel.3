Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8BA606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pZgqUkXt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUA9k-00038v-8c; Thu, 19 Nov 2026 16:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xUA9i-00038O-H9
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:58:58 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xUA9g-0006a3-Qr
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:58:58 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJUX6A3367475
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kLGFjAZekQM
 rnOWQURYvjxdaFgHeFlhem0RNmV+idrk=; b=pZgqUkXtJepWeofvgKBXjCi+TgL
 5PS/lDszjDdoUHItsh7y40BevxxzzOLIogg7i1rsQD/NXli/wqPz1iVvcu3Nmv+e
 yoW7Kp7Y18iNOoyGP7DvlNxUm9fEOWWer0RokuyhehprVkT/3yF48fdA2gQ0mKva
 cOMvsfYsdV95n9xudVQDJgb9q4AyCctnKk1/7sVKSWC0iMB7Kn+No/JP5dpzoA7T
 oz4M7RnWXlQTJ6AB/1d1UM3nbpp6nZEVWyPMEHQGf3fSwmZkHPJ2bwwIlSM5uss2
 zhkB7NRa45o1quZNvh9r/bIUNBLGLgKOZVp9iI1bfLedjtW5nMRRlPzQRcQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27b5rnbh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:55 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJLwsaJ3812819; Thu, 19 Nov 2026 21:58:54 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AJLwsTU3812803
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 21:58:54 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 7CCDD257A4; Thu, 19 Nov 2026 13:58:53 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v3 15/15] tests/functional/hexagon: add packet regression tests
Date: Thu, 19 Nov 2026 13:58:53 -0800
Message-ID: <20261119215853.987158-16-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
References: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfX5kHCm/uNbZdE
 emIpUa6j5mLta2ikMsDNTlNyYjdIFjp5r8wv5sFqZ53le3ITrFSGI8PJKXXAwECqTH0BuyPL6Jm
 vtJuLtXQW5jFAMHJuSzSuUoB3s+0lKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfXz+fLwjNHACM2
 PYb/knFQNbqBmED3M40alcIa21N795GLsy/fDrDZDepG8hjdaei//0ss+KdHOQnZhAMg0WM4qDy
 VkVuIFOa1NKk2Kr1FiGBEPD8MdTJab2HO/3sKlE0DmxKILIEDnRCTLzZe/p+7bQ9CLaZzByO7BQ
 ykk9ttQA3Fy9oNs2gXpI3PG/+a9aATk8wUVgS6Jn6f+4ZQx1VATZcs/lVKr1A9iwq63WXFn/5Y9
 9fjHiTBXt4BDTZY9DFeb+u+FdQOV5MVdKjuXoXy7uNEhfHG5VCUX/ChgmpG7AoRiKFtFpM322/p
 cl6q6XoyCoX4AHAxPpTfcyhm7ue+9X/SSNyZPmwZ7bPA3qV/qXWg32TmrHoe2/0gj7eTO1/zFjo
 Tr9X+ugzwCEOYidSoZmDLhyFYewK8WrfaOeS89+MMqua4dIkfV689TGERil/C9jH75nL8QwLb9r
 XhJgczEfExsH+K2xQHg==
X-Proofpoint-GUID: 7ijGMSbH75KTOOugNIzjzez06vK3pLdn
X-Proofpoint-ORIG-GUID: 7ijGMSbH75KTOOugNIzjzez06vK3pLdn
X-Authority-Analysis: v=2.4 cv=LPTz05W9 c=1 sm=1 tr=0 ts=6aff711f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8
 a=Z9VDHF9Blclki5krBAIA:9 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190088
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


