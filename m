Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199B2CE7B04
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 02:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smlP8-00079Q-DR; Fri, 06 Sep 2024 22:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1smlMr-0006uP-ND
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 22:40:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1smlMo-000127-PH
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 22:40:05 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4871pDm5014818;
 Sat, 7 Sep 2024 02:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=9AB4zNOMtmFA45y0KPMVPF
 nzvGBNszj1XYJAue1bA4U=; b=bJWEY9uslpDzHUb7KceMGbz3YdbjloHsBluhGC
 GM3mYkvDE0AekdEvcyb3N+oP/Vo8MygDdyWNqVJ+qJWyVviSol80oRrFbsg14fJR
 Lc0LsjXwZdpnGKArLeyvmCAKOKbbbikR6WyLpVZUuGkbeYRgcLWD+rl+PZvRx5u+
 I0IuXFSwv2FJQ6thSzrSaFxOCqVpD96qWQr7HWDmxV9fu5oeNOLlR9YS2BbfOjP6
 kz3mmIx0KPirc6mxTQqFepw0H+2ks6ELZ/eAhzFqKgwXySF2rYOCbRunMNh3ifVT
 JPSZSzO/z63RB8SthRUdZnLeeBsXu+4ErTHwZQdP/ZZ+HRmQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gdhd01m3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Sep 2024 02:39:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4872dqqR031759
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 7 Sep 2024 02:39:52 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 6 Sep 2024 19:39:52 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <alex.bennee@linaro.org>, Brian Cain <bcain@quicinc.com>
Subject: [PATCH] tests/tcg/multiarch: Define _LARGEFILE64_SOURCE
Date: Fri, 6 Sep 2024 19:39:24 -0700
Message-ID: <20240907023924.1394728-1-bcain@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: 51xZ-2wu4yIBnhYC7ai8-ufkXA_k7Vki
X-Proofpoint-GUID: 51xZ-2wu4yIBnhYC7ai8-ufkXA_k7Vki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=823
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409070019
Received-SPF: pass client-ip=205.220.168.131; envelope-from=bcain@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

With newer clang builds (19.x), there's a warning for implicit function
declarations and it rejects linux-test.c.

glibc/musl's readdir64() declaration in dirent is guarded by
_LARGEFILE64_SOURCE, so we'll define it to fix the warning.

      BUILD   hexagon-linux-user guest-tests
    /local/mnt/workspace/upstream/toolchain_for_hexagon/qemu/tests/tcg/multiarch/linux/linux-test.c:189:14: error: call to undeclared function 'readdir64'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      189 |         de = readdir64(dir);
          |              ^

Signed-off-by: Brian Cain <bcain@quicinc.com>
---
 tests/tcg/multiarch/linux/linux-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/multiarch/linux/linux-test.c b/tests/tcg/multiarch/linux/linux-test.c
index 64f57cb287..4e0e862ad9 100644
--- a/tests/tcg/multiarch/linux/linux-test.c
+++ b/tests/tcg/multiarch/linux/linux-test.c
@@ -17,6 +17,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #define _GNU_SOURCE
+#define _LARGEFILE64_SOURCE
 #include <stdarg.h>
 #include <stdlib.h>
 #include <stdio.h>
-- 
2.34.1


