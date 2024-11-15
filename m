Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8275AD6A25F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 00:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBkCm-0001a1-8B; Thu, 14 Nov 2024 19:28:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tBkCi-0001ZS-RD; Thu, 14 Nov 2024 19:28:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tBkCh-0006bL-45; Thu, 14 Nov 2024 19:28:52 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF0SkC9020854;
 Fri, 15 Nov 2024 00:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=QY/6JwSNt97JEUJVbgVSkBE5b1rnKajIZEuVYnmkA
 74=; b=Fh5do4ydsL0xR329L/45m0QcMsvnvPt/EDqQ8B6xts3rxtp4gOWtob9g3
 fTvKWhhG3bzumzDwApLLtU6rmaM8coYBHIf1vIjyfHkKN5Mt6GhoNR+WOu1bU2cz
 XUiOW3qn4S3khUtJQOMF42GdAoo5A6CjpLrOah4gvSdsxmLsL1LDkbA8Wolao6Lj
 DHxqIbnA6rDWXQn+FRFBd/bhgh8LrArjNLgUs7PS/yLWvP5SUus9JRtaVI1fMjBr
 Nz8MFSfx+MoKy4l/yU2v5bnhc3hGcj5M1jBqcXsS1np1nn+FIocegZuMEHEgutTJ
 bXidXyRzMPpDo6jZxBah8lyPBn3/Q==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wu2vr5cv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Nov 2024 00:28:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AENpRIT008076;
 Fri, 15 Nov 2024 00:27:46 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tjf0d66a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Nov 2024 00:27:46 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4AF0Rk1957737498
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Nov 2024 00:27:46 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41C845805A;
 Fri, 15 Nov 2024 00:27:46 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D174858052;
 Fri, 15 Nov 2024 00:27:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.167.191])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 15 Nov 2024 00:27:45 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: jrossi@linux.ibm.com
Subject: [PATCH] docs/system/s390x/bootdevices: Update loadparm documentation
Date: Thu, 14 Nov 2024 19:27:42 -0500
Message-ID: <20241115002742.3576842-1-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AHtDr8ROq4r_X9rxjpt_2br6uxqq33z_
X-Proofpoint-GUID: AHtDr8ROq4r_X9rxjpt_2br6uxqq33z_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=962 impostorscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140190
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Update documentation to include per-device loadparm support.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 docs/system/s390x/bootdevices.rst | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/docs/system/s390x/bootdevices.rst b/docs/system/s390x/bootdevices.rst
index 1a1a764c1c..ecb22de04a 100644
--- a/docs/system/s390x/bootdevices.rst
+++ b/docs/system/s390x/bootdevices.rst
@@ -79,7 +79,29 @@ The second way to use this parameter is to use a number in the range from 0
 to 31. The numbers that can be used here correspond to the numbers that are
 shown when using the ``PROMPT`` option, and the s390-ccw bios will then try
 to automatically boot the kernel that is associated with the given number.
-Note that ``0`` can be used to boot the default entry.
+Note that ``0`` can be used to boot the default entry. If the machine
+``loadparm`` is not assigned a value, then the default entry is used.
+
+By default, the machine ``loadparm`` applies to all boot devices. If multiple
+devices are assigned a ``bootindex`` and the ``loadparm`` is to be different
+between them, an independent ``loadparm`` may be assigned on a per-device basis.
+
+An example guest using per-device ``loadparm``::
+
+  qemu-system-s390x -drive if=none,id=dr1,file=primary.qcow2 \
+                   -device virtio-blk,drive=dr1,bootindex=1 \
+                   -drive if=none,id=dr2,file=secondary.qcow2 \
+                   -device virtio-blk,drive=dr2,bootindex=2,loadparm=3
+
+In this case, the primary boot device will attempt to IPL using the default
+entry (because no ``loadparm`` is specified for this device or for the
+machine). If that device fails to boot, the secondary device will attempt to
+IPL using entry number 3.
+
+If a ``loadparm`` is specified on both the machine and a device, the per-device
+value will superseded the machine value.  Per-device ``loadparm`` values are
+only used for devices with an assigned ``bootindex``. The machine ``loadparm``
+is used when attempting to boot without a ``bootindex``.
 
 
 Booting from a network device
-- 
2.45.1


