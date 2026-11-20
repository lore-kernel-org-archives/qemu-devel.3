Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13FC606A330
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ctYePPdt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xULOl-0008BD-Kv; Fri, 20 Nov 2026 04:59:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1xULOj-0008Aj-UT; Fri, 20 Nov 2026 04:59:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1xULOi-0007ce-5i; Fri, 20 Nov 2026 04:59:13 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK7uSrU2482174; Fri, 20 Nov 2026 09:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=sZCOW/3h17nQKT+2L86P1XnUOiXuGeVuS46CNmuiz
 ek=; b=ctYePPdtwkHFV6Qg+gQdDqUT+uAmYaJ1mw+/VzoyIHrdIeKcHyoWUcZPP
 2yev6GpLtk5z8Jp7Qz2qfIMo8n9uuglscggXO8LHMwc6ZY1/2XIsZHRPyk8Ucdb7
 tlfL4FCfgk/j8r0igLdfpGybDFuE4M/C8gw7SrM8JJykrGcWMzq62//Rq0BOWPxd
 4wRgr3d/CIht2N5xWtvWnwlWjSB0v2u/nurnerqfZXv12hEWielh/xvafYr4xKby
 SeBBXH4Rr8j6K+dZdWCazUQStz2q5FFojW7/pDGAKLwTg5rE/N61AZQgn/zBK7Il
 DKI3dLFmBU87+TEmOr0UXBeOBhQwg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105x789x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 09:59:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK7oOQ51951878; Fri, 20 Nov 2026 09:59:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1m3j1etn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 09:59:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AK9x4lO38338842
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Nov 2026 09:59:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EEB662004E;
 Fri, 20 Nov 2026 09:59:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F7A320043;
 Fri, 20 Nov 2026 09:58:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.22.205])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Nov 2026 09:58:59 +0000 (GMT)
From: Aniket Sahu <asahu1x@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, peterx@redhat.com, farosas@suse.de, npiggin@gmail.com,
 adityag@linux.ibm.com, milesg@linux.ibm.com, harshpb@linux.ibm.com,
 rathc@linux.ibm.com, anushree.mathur@linux.ibm.com,
 misanjum@linux.ibm.com, gautam@linux.ibm.com, thuth@redhat.com,
 amachhiw@linux.ibm.com, asahu1x@linux.ibm.com
Subject: [PATCH 0/5] tests/functional/ppc64: Fixes and improvements for
 hypervisor tests
Date: Fri, 20 Nov 2026 15:28:53 +0530
Message-ID: <20261120095854.35941-7-asahu1x@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: _HKXsBrC0BRS8KqRgPek3zljsePQjFvs
X-Proofpoint-GUID: RpwDxi1bt_aNSw5X1F1S_Xat5S7_gtzm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzOSBTYWx0ZWRfX0DvQB+o8dkNF
 WP6baDVC/ZtiHhthRQxs8FdOql4VFg3kIbLoRD5zIwAHE3oTeC+cMfLpDy1IoTbGtJzxfprd0iM
 8gQQanhpDBTaAwIBd/s0K6UOQNJXItgOtUspmvsfCSBxgUcDDQSQBvysELE1tKmGDM37/h/gcFk
 JaHA6xqE6XdZnzCsETbY9Z84Bbuc4fo4qvfHULBwZ6D13r8BAjgfSeGII4vaOntGGP/OCLokRWU
 TG9Ofwbb2lDXIHWWbip8hmIMKq0tgrFTKKPYT/FYB+xAOzrV91+ASw41NTkQxOEJw6Kg5hX2LsW
 CPWiRUy+1xHbBYCAMTymXK4WxhFZW2+9Qeh7GHL8nh0RoGsWuywL0zSYJCK1keLbXMDZOLLK1mX
 Qv6wa0f9H04/blDP2A/ooqZSTHJv2L7fwrcukjpLE8aPz4U5Id7EGXW45SaF7XZXvZljB7Rw9bm
 r1raFk8Kyau6ePtOfUA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzOSBTYWx0ZWRfX2mxJpnAPfBcb
 CWOreGsrnwPjIW7cP4q7Q31mjUlZ2vBpxOy4xlH/gMTlpdaybYrT2gCK52HEXFbatiAg1cvmJZt
 pgmcHXk2UC03yBQw37e1NLj9/pI4uN4=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6b0019ed cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=KcMjM4aba7ZdOZSx--8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1011 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200039
Received-SPF: pass client-ip=148.163.158.5; envelope-from=asahu1x@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes several issues in the PPC64 hypervisor functional tests
and improves their robustness and reliability.

Changes in this series:
-----------------------

1. Replace deprecated datetime.utcnow() with datetime.now(timezone.utc)
   to avoid deprecation warnings in Python 3.12+.

2. Pin machine types to avoid CPU compatibility issues between the L0
   QEMU (which now defaults to power11) and the L1 Alpine guest's
   packaged QEMU (which doesn't recognize power11). This fixes
   "Register sync failed" errors in L2.

3. Add kernel command line parameters (console=hvc0 usbcore.nousb) and
   early panic detection to fail fast when L2 encounters issues, plus
   retry logic for apk update to handle transient network failures.

4. Dynamically resolve the NVMe device path in L1 instead of hardcoding
   it, as the device name varies by machine type (nvme0n1 vs nvme1n1).
   Also adds comprehensive debug logging throughout the test flow and
   writes the L2 launch command to a script to avoid terminal line-wrap
   issues.

5. Increase the test timeout from 1000 to 6000 seconds to accommodate
   the longer runtime due to apk update retries and additional testing.

Testing:
--------
All tests pass on our PPC64 test machines running Ubuntu 26.04 in an
LPAR.

Aniket Sahu (3):
  tests/functional/ppc64: replace deprecated datetime.utcnow()
  tests/functional/ppc64: add kernel params and early panic detection
  tests/functional/ppc64: dynamically resolve NVMe device path

Misbah Anjum N (2):
  tests/functional/ppc64: pin machine types for hypervisor tests
  tests/functional/ppc64: increase timeout for hypervisor tests

 tests/functional/ppc64/meson.build |   2 +-
 tests/functional/ppc64/test_hv.py  | 140 +++++++++++++++++++++++++----
 2 files changed, 117 insertions(+), 25 deletions(-)

-- 
2.52.0

