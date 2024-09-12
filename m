Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64789EE6450
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 12:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sojEQ-0000NP-RS; Thu, 12 Sep 2024 08:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1sojEM-0000Cm-Fu
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 08:47:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1sojEK-00028q-Qc
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 08:47:26 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CBbXSp007674;
 Thu, 12 Sep 2024 12:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=KusYu2paOafwMALw/CvdPh
 W4OwUTipqbYltQrh3cTfg=; b=niXJpQVfyw3LdCCGcw8/EdCcaUILWC/069QPPX
 t6tFNe8MNv+7C8WJJ+xZiqWRtS8vp3bXPzUj+Yj5ktKSmJPNFFYxmrhXtQYGHF4e
 67Gan9RLye4CtaZwILFn146dLgzk6dQl7k+jImlfpBGlS/GZ86H429fe4N4wVMtE
 aboFuE2S/QrvVLvMJacjZ8tZGVz/tHhWSwZXCbzhCuBaxI60FosjPUHKZ/eMU57P
 a53eEbrZikaCBuvZqgK5JIU3njGGRwLN0njb5OswgyURv+6Od0pBM/M1A5R7Oajn
 mRXzEEqJlI3ME6XVohnByWxw/jdifw9DL0zogn/O0EYPVcgA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41j6gn1fcd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 12:47:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48CClJeV012435
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 12:47:19 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Sep 2024 05:47:19 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>, <thuth@redhat.com>, <bcain@quicinc.com>
Subject: [PATCH] docs/fuzz: fix outdated mention to enable-sanitizers
Date: Thu, 12 Sep 2024 09:47:09 -0300
Message-ID: <a788215960b94d863baeffb736f06e3fb94275e7.1726145226.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: G1q1BkzEReOWFzUokHLBbfyM24KIrXiw
X-Proofpoint-GUID: G1q1BkzEReOWFzUokHLBbfyM24KIrXiw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0
 clxscore=1011 phishscore=0 mlxlogscore=594 lowpriorityscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This options has been removed at cb771ac1f5 (meson: Split
--enable-sanitizers to --enable-{asan, ubsan}, 2024-08-13), so let's
update its last standing mention in the docs.

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
---
 docs/devel/testing/fuzzing.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/devel/testing/fuzzing.rst b/docs/devel/testing/fuzzing.rst
index dfe1973cf8..e42d64d6ec 100644
--- a/docs/devel/testing/fuzzing.rst
+++ b/docs/devel/testing/fuzzing.rst
@@ -21,8 +21,9 @@ Building the fuzzers
 
 To build the fuzzers, install a recent version of clang:
 Configure with (substitute the clang binaries with the version you installed).
-Here, enable-sanitizers, is optional but it allows us to reliably detect bugs
-such as out-of-bounds accesses, use-after-frees, double-frees etc.::
+Here, enable-asan and enable-ubsan are optional but they allows us to reliably
+detect bugs such as out-of-bounds accesses, use-after-frees, double-frees
+etc.::
 
     CC=clang-8 CXX=clang++-8 /path/to/configure \
         --enable-fuzzing --enable-asan --enable-ubsan
-- 
2.37.2


