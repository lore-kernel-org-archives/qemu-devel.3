Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73609606A33F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cD0binhk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT1bl-0006z4-Fz; Mon, 16 Nov 2026 13:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xT1bc-0006xD-Sr
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 13:39:05 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xT1ba-0007Gc-2k
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 13:39:04 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGGIcBG154781
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 18:38:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=7ZcvOJMx2agGyyVx12a6AAJuXJYeJwsrSXn
 NMlQ4BrY=; b=cD0binhkcKjIrOfjj2dcPxlZLJeqkNpmOQV5qQ/8DMfAO1PXc1w
 V8tVjuacKo94Bbg19xiU939nj6+fGfJ660X77JqO1tvUFpLniTC1/eakEx6YjBqI
 eqGih9Cms2nOPJuLGd8joyxFSCz5JjR9sMEF6PO3nW+O3q2T97pukFjvGTu/Cs0O
 /z8y6iFMKhTEV6pk25BCvA4OrePclSrxetJxCbu7ps0LsfRTd4a2B8ZjdUnKWhGt
 TOThu/DeAGXUgsSkhYOZBLjQ5GzfuuKgcM9DeGkQIhNySpwcjUjLR8WtvE49tdqy
 XWMJMNPtGD1eXQAmG0rUg1L49WfVauTBa+A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyy6gj4wp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 18:38:56 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGIctTp752336; Mon, 16 Nov 2026 18:38:55 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AGIctPq752329
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 16 Nov 2026 18:38:55 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 179F924E22; Mon, 16 Nov 2026 10:38:55 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH] tests/functional/hexagon: add MTTCG regression coverage
Date: Mon, 16 Nov 2026 10:38:55 -0800
Message-ID: <20261116183855.817574-1-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA3NCBTYWx0ZWRfX4VGRO7UE5lYM
 CW8aHXCBH/U+x2AV8DaSttdpOLvZ/qQ10nQpd64f5950bg9YI/LwCiruIBJDxZEJgylxbBQXey1
 j7afdSh17A6Cpi62U22Ow9lL0Jh2dvKuoOPnaoGVTiJnSiuuLKOqzwFZXuXqa5QaoeliUjO4ugM
 VfaaVbJp/SGIA+mVzPwU3TKic2zEav7rVBL4MeBySxPMeGzQPtcMe1QnWls3nPNr6/RitLkUlpQ
 RQt8uTUjz+iUqpdHer35JNpDwNkkc/XSJ2pNb8CQ/GMiVZRFnJAO8e0JE56SbZF3DhoXA3msUhI
 YaHDlYYq70uwjDAuIhKL+cg0fLZpy1JmOK1rbpaIGo/OHP8THPcxft49F5JW2T4l+2qFeFln/7g
 Tj75rsJ9mg+AYSaFba0ZaIVnoElsmtjZyw9KHXqDV3FoIB8L9bRtx1r5kgaTUZ0ulkMOODceogP
 FEbUJUr+j0iVmdGAkgw==
X-Proofpoint-GUID: fZiptm4IDO9g5c-1sEgLe_bCXMDMYrJo
X-Proofpoint-ORIG-GUID: fZiptm4IDO9g5c-1sEgLe_bCXMDMYrJo
X-Authority-Analysis: v=2.4 cv=D/DSufRj c=1 sm=1 tr=0 ts=6afb4dc0 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8
 a=jQLl1QyC_yQM8aTTLnYA:9 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA3NCBTYWx0ZWRfX/HOcrskg+Z/6
 kVZS+ugePFfci8cltigJ3kWb98o8jG48Sdi4hABK8Tg6wYuxFSlwKwNUIDq26R9WtTQ9f9tBvMj
 kQTKiE7dO+qKy2ZQAZ2bFmO+WxvL47w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160074
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

Use the v0.3.4 standalone test package to cover guest fault state,
virtual RTE stack state, and concurrent TLB and IMASK updates.
Run guest state in both TCG modes and force MTTCG for the concurrent
tests so they exercise cross-thread updates.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 tests/functional/hexagon/test_systests.py | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tests/functional/hexagon/test_systests.py b/tests/functional/hexagon/test_systests.py
index 76e2480c1d3..6935d0dd3ab 100755
--- a/tests/functional/hexagon/test_systests.py
+++ b/tests/functional/hexagon/test_systests.py
@@ -22,9 +22,9 @@ class SysTestsStandaloneTests(QemuSystemTest):
 
     ASSET_TARBALL = Asset(
         "https://github.com/qualcomm/qemu-hexagon-testing/releases/"
-        "download/v0.3.1/systests_standalone.tar.gz",
-        "40163fa94d67a63e5ef645fc83682e4e"
-        "b56e1d79a9068614055e74f35d4cf70d",
+        "download/v0.3.4/systests_standalone.tar.gz",
+        "cee40e9f788dc021797e66cbae68e994"
+        "0b9382f0f89fc601ae35890eac2e5eea",
     )
 
     def setUp(self):
@@ -108,6 +108,18 @@ def test_bestwait(self):
     def test_mmu_multi_tlb(self):
         self.run_exit_zero("mmu_multi_tlb")
 
+    def test_guest_state(self):
+        self.run_exit_zero("guest_state", "-accel", "tcg,thread=single")
+
+    def test_guest_state_mttcg(self):
+        self.run_exit_zero("guest_state", "-accel", "tcg,thread=multi")
+
+    def test_mttcg_tlb(self):
+        self.run_exit_zero("mttcg_tlb", "-accel", "tcg,thread=multi")
+
+    def test_mttcg_imask(self):
+        self.run_exit_zero("mttcg_imask", "-accel", "tcg,thread=multi")
+
     def test_timer_reg(self):
         self.run_exit_zero("timer_reg")
 
-- 
2.43.0


