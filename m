Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5EB606A32F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 06:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iVZAaSq7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTvfV-0004Le-Nw; Thu, 19 Nov 2026 01:30:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1xTvfA-0004KV-Fu; Thu, 19 Nov 2026 01:30:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1xTvf7-00053M-4E; Thu, 19 Nov 2026 01:30:27 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ4jOJb1532178; Thu, 19 Nov 2026 06:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=cG3T2d4FX07lPqZml
 ez/V62r4bLX0XBVzdPHxbsCb+o=; b=iVZAaSq74mAZXTkmpdmoBs5sQlXN4SIG3
 26PgXzw2uwD05cWeD3IEAgJmWHfCOYQ9rJrY+2PYG7574eRd+3+EwJU0UudlTlcm
 jSGjLNCvgUgHxqoTdAFJCUmOlWmM84/7aAV3YRObjK8nNZp0LTPdXGuEo13EqL9T
 7iQ7OBNcG+7LdvU5BRj0E/WwvCB162qDvDYTcAyidf/pq9E2pxwZLEHeVd1kflje
 N2QM06Tj9s7Y5yyIryTdtGGc8fLQEP/QunMKwobFkM4ubNUGKV0PVTj5iHN2E8+z
 a8zKWyxMY+LA1WRgVeBRIy6boUflVKkgsfN0hp07k5KEvcMQdyAdA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105rpytx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 06:30:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ4wopb063209; Thu, 19 Nov 2026 06:30:16 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1hd6tkdk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 06:30:16 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AJ6UFbs30147236
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Nov 2026 06:30:15 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8CDCE58059;
 Thu, 19 Nov 2026 06:30:15 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BC7258060;
 Thu, 19 Nov 2026 06:30:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.221.175])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Nov 2026 06:30:10 +0000 (GMT)
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Amit Machhiwal <amachhiw@linux.ibm.com>,
 Miles Glenn <milesg@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>, misanjum@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>, Utkarsh Verma <uverma@linux.ibm.com>
Subject: [PATCH v2 0/4] tests/functional/ppc64: add pseries hotplug and caps
 tests
Date: Thu, 19 Nov 2026 11:59:46 +0530
Message-ID: <20261119062951.83498-1-anushree.mathur@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030131025.32219-1-anushree.mathur@linux.ibm.com>
References: <20261030131025.32219-1-anushree.mathur@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: LW4DU1uPJiHCnWGM1T7qZ09FmBGlZXRq
X-Authority-Analysis: v=2.4 cv=e8uT2qp/ c=1 sm=1 tr=0 ts=6afe977a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=wRa4uucDvQeYp0uuPlcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAyNSBTYWx0ZWRfX+FE+9G3ogqZg
 Z2ys77ZnQyJ7gaj1XQaiL0tLsQYj1o9nLhw2sOn3nPsHNYMmkbRCLsxT1SKp4qlEgTUZtlCUxNT
 ANP1pJAQwDv/adaQBR3s1WEWRCtGFuo=
X-Proofpoint-ORIG-GUID: dy7uwhEPR8I63jY7DSHeJlH8ImYohU7_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAyNSBTYWx0ZWRfX4khqRVTvyMFf
 47HNRNEz/oJMkDKHhHewOXwMNjjTobaYpB2hMc+jZ4RnqBsGua4I+WFkcEcbeb6Ej6VLb/dw7TM
 6M28MQly/MTr6RSJdhOnao51lxNbU3S4vRSl727wK9DZLccV+l3mPf5SR7+xDPnPnOUc8eOquIR
 1PQTYX56aSNrCsdX8rl/w/MGuACZ0YZMWQxlsjFPBqsXu2hCvH6PxLpmVzZmU8R4TIvlDzu7Cc7
 QYrVotAtQuSRTp3Cyu+jPvhUt0UzVJMWJETEItOEINuFuKcIFZ9NRoBD3bUQI/SxhmqovUqcfyE
 QrzRrtpOr4W4tN0ZYiwpnBZhCfTKvdiBsKgd325T6XJoYxwObUtbkQGJtNByQFnKRUdNQPX6ypl
 sHPZXtNM0zxV6Szt/kXEeQiOpU1ZPM9Kf6Ldqjv0uhbZAODkIlGQJg1jSrXDjIf8Kv5h6WhYMDk
 AL1z9UvSNttJ2daztEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190025
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=anushree.mathur@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

This series adds three new functional tests for the pseries (sPAPR/PAPR)
machine type and registers them in MAINTAINERS.

Patch 1 adds test_hotplug_cpu.py.  It boots a buildroot guest with one
core (-smp 2,threads=2,cores=1,maxcpus=4), hot-adds a second core with
QMP device_add and waits until /sys/devices/system/cpu/online changes
from 0-1 to 0-3.  It then hot-removes the core with device_del and waits
for the guest to be back at 0-1.  It runs with TCG and, if available,
with KVM.

Patch 2 adds test_pseries_caps.py, a quick test that does not boot a
guest.  QEMU is started halted (-S) and QMP is used to check that
pseries starts with the security capability options (cap-cfpc,
cap-sbbc, cap-ibs, cap-ccf-assist, cap-nested-hv), that pseries-7.2,
9.2 and 10.0 can be instantiated, and that cap-hpt-max-page-size is
visible under /machine in the QOM tree.

Patch 3 adds test_hotplug_blk.py.  It boots a similar guest with a
second PCI host bridge (phb1), hot-adds a virtio-blk-pci disk backed by
a null-co node with QMP device_add and waits for /dev/vda to appear in
the guest.  It then hot-removes the disk with device_del and waits for
the DEVICE_DELETED event and for /dev/vda to disappear.  The guest
needs rtas_errd and drmgr to enumerate the new device, so the test uses
a rootfs that includes them.  I raised the patch that adds this image
(rootfs-hotplug.ext2) to qemu-ppc-boot, see
https://github.com/raphael502/qemu-ppc-boot/pull/1.  It has been merged,
so the test downloads the image from that repository.  The test runs
with TCG, and also with KVM if KVM is enabled.

Patch 4 adds the MAINTAINERS entries for the three tests.

Testing
-------
v1 of the CPU hotplug, caps and virtio-blk tests were run on a ppc64le
POWER host with both TCG and KVM and passed.  The changes below do not
touch the test logic.  checkpatch.pl reports no errors or warnings on
any patch (apart from the expected "MAINTAINERS needs updating" notices
on patches 1-3, resolved by patch 4), and pylint with
tests/functional/pylintrc reports nothing for the new files.

CI
--
GitLab pipeline: https://gitlab.com/Anushree-Mathur1/qemu/-/pipelines/3084104292
The jobs that fail are all allow_failure: Rust nightly (bitops.rs),
tuxrun/armbian asset downloads, and aarch64 timeout/migration tests.
None of them involve this series, which only adds ppc64 tests and
MAINTAINERS entries.

Links to v1:
- v1 for CPU hotplug and caps tests:
  https://lore.kernel.org/qemu-devel/20261030131025.32219-1-anushree.mathur@linux.ibm.com/
- RFC v1 for virtio-blk hotplug test:
  https://lore.kernel.org/qemu-devel/20261103141938.41147-1-anushree.mathur@linux.ibm.com/

Changes in v2:
- Combined the two v1 postings above into one series.
- Patch 1: buildroot kernel and rootfs assets now point to
  raphael502/qemu-ppc-boot instead of legoater/qemu-ppc-boot.  They are
  the same files; the sha256 values are unchanged and were re-verified.
  Wrapped the long URL lines to keep checkpatch quiet.
- Patch 2: reworded the commit message to say what is actually checked
  (the options are accepted and the machine starts), fixed docstrings
  that did not match the code, and dropped the skipped
  query-cpu-model-expansion placeholder test.
- Patch 3: no longer an RFC.  v1 was an RFC because rootfs-hotplug.ext2
  was not available yet; it is now merged in qemu-ppc-boot and the
  asset URLs point to it (the sha256 is unchanged).  The vmlinux asset
  also points to qemu-ppc-boot, and the test file is now executable
  like the other functional tests.
- Patch 4: a single MAINTAINERS patch covering all three tests
  (previously a separate patch for the CPU and caps tests, and an
  entry inside the virtio-blk patch).
- Rebased on current master (6883fb508c).

Anushree Mathur (4):
  tests/functional/ppc64: add pseries CPU hotplug test
  tests/functional/ppc64: add pseries security caps test
  tests/functional/ppc64: add pseries virtio-blk hotplug test
  MAINTAINERS: add pseries hotplug and caps functional tests

 MAINTAINERS                                 |   3 +
 tests/functional/ppc64/meson.build          |   5 +
 tests/functional/ppc64/test_hotplug_blk.py  | 188 ++++++++++++++++++++
 tests/functional/ppc64/test_hotplug_cpu.py  | 185 +++++++++++++++++++
 tests/functional/ppc64/test_pseries_caps.py | 162 +++++++++++++++++
 5 files changed, 543 insertions(+)
 create mode 100755 tests/functional/ppc64/test_hotplug_blk.py
 create mode 100755 tests/functional/ppc64/test_hotplug_cpu.py
 create mode 100755 tests/functional/ppc64/test_pseries_caps.py


base-commit: 6883fb508cb7a93e2e7b44c0582bfd9fc2196d4d
-- 
2.55.0


