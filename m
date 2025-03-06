Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB2BC28B23
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq4O6-0005nK-LM; Thu, 06 Mar 2025 01:07:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tq4O4-0005n3-Sp
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:07:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tq4O3-0002KC-0M
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:07:16 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525LCwT1000389;
 Thu, 6 Mar 2025 06:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=KF0K7WXnSlPxtYfcySYIHBSFh8/Jg4wf4y4TWH+Wl
 jw=; b=gc1RumkCYQSx746OL8GYP7Q3bUi2RXnyjc3i3qJSMoZURCvQt6APMqJjQ
 EnAoL9PJc3uFwv/619L/tCSOlK5NRYcGMoWnb62GTEk40qhqddx+vlx9bbrTpTKG
 KVQhcdP6zAdIs0No/E4wubOex7nCkxAabJgYzXmJsvotmCP5jdI1KTENQbx9i4VG
 UwOqc3oPATXbaDsrmpb7ZegzYRUv2Lqi1i/WHr0h4HSmWReXw1vR2AP5LRr4SN13
 FEjp+kdP2Sj9w0m6/BrCTLyzlKSwPL//TN4BvjdaKOqPQdDTnKxXTipIRMYIXWSB
 SxKXtqrnfABc5VWb5UkjCOlOyy9cw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456pnavh5h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 06:07:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 526407EU025026;
 Thu, 6 Mar 2025 06:07:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 454f926m3u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 06:07:11 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 526678Ox42271138
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Mar 2025 06:07:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50B0720043;
 Thu,  6 Mar 2025 06:07:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5671F20040;
 Thu,  6 Mar 2025 06:07:07 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.160])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  6 Mar 2025 06:07:07 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] doc: add missing 'Asset' type in function test doc
Date: Thu,  6 Mar 2025 11:37:06 +0530
Message-ID: <20250306060706.1982992-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p4oxg_KkcPFFZC3fSdZCbe_84XC6hel6
X-Proofpoint-GUID: p4oxg_KkcPFFZC3fSdZCbe_84XC6hel6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_03,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060042
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Seems 'Asset' got missed in the documentation by mistake.

Also fix the one spellcheck issue pointed by spellcheck

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 docs/devel/testing/functional.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
index ecc738922b7c..50fca2a0291e 100644
--- a/docs/devel/testing/functional.rst
+++ b/docs/devel/testing/functional.rst
@@ -251,7 +251,7 @@ Many functional tests download assets (e.g. Linux kernels, initrds,
 firmware images, etc.) from the internet to be able to run tests with
 them. This imposes additional challenges to the test framework.
 
-First there is the the problem that some people might not have an
+First there is the problem that some people might not have an
 unconstrained internet connection, so such tests should not be run by
 default when running ``make check``. To accomplish this situation,
 the tests that download files should only be added to the "thorough"
@@ -274,7 +274,9 @@ the tests are run. This pre-caching is done with the qemu_test.Asset
 class. To use it in your test, declare an asset in your test class with
 its URL and SHA256 checksum like this::
 
-    ASSET_somename = (
+    from qemu_test import Asset
+
+    ASSET_somename = Asset(
         ('https://www.qemu.org/assets/images/qemu_head_200.png'),
         '34b74cad46ea28a2966c1d04e102510daf1fd73e6582b6b74523940d5da029dd')
 
-- 
2.48.1


