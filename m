Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7065FCAC5AA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 00:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0r17-00035t-Mw; Mon, 22 Sep 2025 20:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=8360245811=erick.shepherd@ni.com>)
 id 1v0odt-0007x2-1L
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 18:04:18 -0400
Received: from mx0a-00300601.pphosted.com ([148.163.146.64])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=8360245811=erick.shepherd@ni.com>)
 id 1v0odn-00026I-AO
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 18:04:16 -0400
Received: from pps.filterd (m0484888.ppops.net [127.0.0.1])
 by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MD9A1K004027
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 22:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=PPS11142024; bh=gbXmatQ4SZ61oXaf1tBu
 DKILdbSyYXGKhOeR8KsPzYo=; b=bnP39rwinjFY3DMmiA2CUqlR0P6Eal3yi/t7
 gHB5kWEHdVSVsNemK7B4vxaKX2h0kTIblPTwq2sTEZ6TyU/uGarCC+VLx/rWCy8T
 WGt0P34VNUYeBDmqHh2yYBu3bNf6sChKVwZilOZbcXt3cWkgMY2oIckFCQ9f939/
 TSLQne2HegR26jNjmMwW/Vzu8hGJkRpAr/7QqhoPRTKr9WMAiRiRT/s3IeFhJ2z7
 rJiz/QwZ7AcgwP1VWFxh3NqUB2wmNpSvXbNQW1caV5gcFcUr1g5rYSsMNJMWFbl+
 QQ6BtlYCtUGt42MRCUJ0hldGQwyTakh9IuV32sjyqWZp/D9q5A==
Received: from us-aus-excas-p2.ni.corp.natinst.com ([130.164.94.74])
 by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 49a9u4u0tn-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 22:04:06 +0000 (GMT)
Received: from us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 22 Sep 2025 17:04:03 -0500
Received: from ershephe-ubuntu.ni.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Mon, 22 Sep 2025 17:04:03
 -0500
From: Erick Shepherd <erick.shepherd@ni.com>
To: <qemu-devel@nongnu.org>
CC: Erick Shepherd <erick.shepherd@ni.com>
Subject: [PATCH] .gitmodules: Update URLs for the u-boot submodules
Date: Mon, 22 Sep 2025 17:04:01 -0500
Message-ID: <20250922220401.74802-1-erick.shepherd@ni.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: uHCOfN1VukvWCcYfHcZohfcBTuIZVauR
X-Authority-Analysis: v=2.4 cv=X7BSKHTe c=1 sm=1 tr=0 ts=68d1c7d6 cx=c_pps
 a=VUOoxcgKHUMpfFMIT0tLvw==:117 a=VUOoxcgKHUMpfFMIT0tLvw==:17
 a=yJojWOMRYYMA:10 a=p0WdMEafAAAA:8 a=gVGD3344AAAA:8 a=mA4Pze_8lZw_loYj9NkA:9
 a=xQEvYfgLW3QvObN0DhJi:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIxMDAzNSBTYWx0ZWRfX1oFxCaKmcGm/
 OPtSIaPhrAACJ4ENRO7DXraRV+D4HnxzQEx87dQjWa6WTwJxkZt5i2kgP7GgZvB6q1xRFwHoYwT
 uy5PXvZN9PEB9cG4RkVLF20Mduiqs1v+supQ4uE03+VOmtUyEO0xQUkwwlFXzaWFV6VBBlFg/HU
 IzOmfBKcGVgjHM+loej7tMdJZkSN5S5KbuUlOnjenfHEIrNvDKKl/oy51n1v+z+aSmhAFk0BEGF
 AMxkSsCSMxYJykEUg4ylDWZ6ls0Oru8zTkFG2OnQ73F7zLnGWBiTyC5B2RWH84EE/UleUE9Hg6o
 93lSkunDd0eLiAlOjVbIVTiPSAJ87hIzo02MWW691tgcdXdV5lyyRy90UZGEDpX4fsCp87bpw3I
 Pwbbf5Vv
X-Proofpoint-ORIG-GUID: uHCOfN1VukvWCcYfHcZohfcBTuIZVauR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_04,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 clxscore=1011 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509210035
Received-SPF: pass client-ip=148.163.146.64;
 envelope-from=prvs=8360245811=erick.shepherd@ni.com;
 helo=mx0a-00300601.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 22 Sep 2025 20:36:23 -0400
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

The u-boot and u-boot-sam460ex submodule repositories were moved to new
locations. Update .gitmodules to use the new URLs.

Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
---
 .gitmodules | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitmodules b/.gitmodules
index 73cae4cd4d..e27dfe8c2c 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -15,7 +15,7 @@
 	url = https://gitlab.com/qemu-project/qemu-palcode.git
 [submodule "roms/u-boot"]
 	path = roms/u-boot
-	url = https://gitlab.com/qemu-project/u-boot.git
+	url = https://gitlab.com/qemu-project-mirrors/u-boot.git
 [submodule "roms/skiboot"]
 	path = roms/skiboot
 	url = https://gitlab.com/qemu-project/skiboot.git
@@ -27,7 +27,7 @@
 	url = https://gitlab.com/qemu-project/seabios-hppa.git
 [submodule "roms/u-boot-sam460ex"]
 	path = roms/u-boot-sam460ex
-	url = https://gitlab.com/qemu-project/u-boot-sam460ex.git
+	url = https://gitlab.com/qemu-project-mirrors/u-boot-sam460ex.git
 [submodule "roms/edk2"]
 	path = roms/edk2
 	url = https://gitlab.com/qemu-project/edk2.git
-- 
2.50.1


