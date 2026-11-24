Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF26606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pKJwgFyK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVoGq-0000Zb-HO; Tue, 24 Nov 2026 06:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1xVoGb-0000X6-RT; Tue, 24 Nov 2026 06:01:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1xVoGY-0001Je-UI; Tue, 24 Nov 2026 06:00:53 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO34wtc002250; Tue, 24 Nov 2026 11:00:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=6H+y1C1ZM4c7IvNlJsWpjbAV9ZU8EeS6ndJN2qbC2
 /g=; b=pKJwgFyKh6E4jCqYmQ1L3WR6uVWCZ6fviHXugK6Jj+oHLeGz8yviYCsVU
 ubsWSDsONRombDp5IqoDU4FbQiEP28eZEw8J80zpNVVYuyL3gG4cNJ+k693qnoOE
 N8bWqCUuxQRBYbW+uipIfqQ8X5KyZGpFJKut5IWvnLkjyE8fsqwXssGZyylnvjRR
 66JsBrry+hG6kM29eEg+rb4CwP0nHvkvIbj7VsrcWeXed0dCoG/oGvC5i9sycujz
 aQdQCMKDaAqxOWfQzMdjS4axf4ygDBGLo66DSdzz8ac54ssGjh6qL2FKZan3QaCL
 fbcLuZ9lDHIX+uRVLQnF8CdfJOpOQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4esx2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 24 Nov 2026 11:00:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO8gfYY2087090; Tue, 24 Nov 2026 11:00:44 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3p0vje62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Nov 2026 11:00:44 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AOB0hXQ61997406
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Nov 2026 11:00:43 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 527545805D;
 Tue, 24 Nov 2026 11:00:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EC6858052;
 Tue, 24 Nov 2026 11:00:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.26.151])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Nov 2026 11:00:38 +0000 (GMT)
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
Subject: [PATCH v3 0/4] tests/functional/ppc64: add pseries hotplug and caps
 tests
Date: Tue, 24 Nov 2026 16:30:26 +0530
Message-ID: <20261124110030.30097-1-anushree.mathur@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0MSBTYWx0ZWRfX6opB1CfCeA4e
 BmSUM652MJ5X8/lKOG8Lt/BxA86pVuYbzZr/qnCDH/L5eulQqby7I9wgrllZejIN6fBxFL6c/t6
 jihB/uSnIDtkAqZneCUeyopBJkxRRXU=
X-Proofpoint-GUID: uHpZPtcZ98LwVr7Su1HBgwqgcFATVEc1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0MSBTYWx0ZWRfX6zDUf08p/jT2
 6HaFNjb1JxBdqV37oXV7KqaRjmqbF+LIXF6Y1U0064SPC8YKvG3HjIeJq35WbiOb3BZU1dOl2U/
 +5K8Wveb2CXlJKHN0Lg2oPbed67HfPnjWExl1G1livlkLj81JfGZns72xxyvS0Bd/tuA0GFMJi0
 oAcxn1wfJjZN5Vf6cC30I5PY0g8JqEt+/wDRSDNQf2Qjpbv7P7HyFUnPjaxz+3pG4RweEeg3Xsg
 H85wjHlWZAD4fHZJn/Jdsm3stXCOYMQFpiaT+l2ES9Le6LuIqXZUJzxBnvzQsbPjq4nIrHHCxTQ
 r2DGEl0e22zhFayGEyTx7Y5XdnR1RJ1C46juFMDHMU6lH8UwpJCFwNsFaX79MR6uFpHr55VMQZe
 OxqKnV54nygr8ChQiGZihZBNNsvDDBkr+LZUqlPcNE+Va4e9lkXHj4m7l0D1eiw5AoAeAtBtzvn
 GaO2Ee/fwDre5rJ/JuA==
X-Proofpoint-ORIG-GUID: PejHFZXuyeKZb_8KBSkK0qAHuCWx4J6V
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b056e5d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ZSCl_0Pw3aZwxkiSnmcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240041
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=anushree.mathur@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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
from 0-1 to 0-3.  It then hot-removes the core with device_del, waits
for the QMP DEVICE_DELETED event and for the guest to be back at 0-1.
It runs with TCG and, if available, with KVM.

Patch 2 adds test_pseries_caps.py, a quick test that does not boot a
guest.  QEMU is started halted (-S) and QMP is used to check that
pseries starts with the security capability options (cap-cfpc,
cap-sbbc, cap-ibs, cap-ccf-assist, cap-nested-hv) and that qom-get
returns the values that were set, that pseries-7.2, 9.2 and 10.0 can be
instantiated, and that cap-hpt-max-page-size is visible under /machine
in the QOM tree.

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
The three tests were run on a ppc64le POWER host with both TCG and KVM
and pass.  checkpatch.pl reports no errors or warnings on any patch
(apart from the expected "MAINTAINERS needs updating" notices on
patches 1-3, resolved by patch 4), and pylint with
tests/functional/pylintrc reports nothing for the new files.

Links to previous versions:
- v2:
  https://lore.kernel.org/qemu-devel/20261119062951.83498-1-anushree.mathur@linux.ibm.com/
- v1 for CPU hotplug and caps tests:
  https://lore.kernel.org/qemu-devel/20261030131025.32219-1-anushree.mathur@linux.ibm.com/
- RFC v1 for virtio-blk hotplug test:
  https://lore.kernel.org/qemu-devel/20261103141938.41147-1-anushree.mathur@linux.ibm.com/

Changes in v3 (review comments from Utkarsh Verma on v2):
- Patch 1: put the -smp option on its own line and replaced the arrow
  characters with ASCII; added snapshot=on to the rootfs drive; bounded
  the guest wait loops to 45 seconds with a failure message; wait for
  the QMP DEVICE_DELETED event after device_del.
- Patch 2: the caps tests now check the values with qom-get instead of
  only checking that QEMU starts; dropped the redundant "pseries" from
  the -machine arguments; the compat machine check now uses is-default,
  as is-current is not a query-machines field and the old assertion
  could never fail.
- Patch 3: the rtas_errd start and the initial /dev/vda checks matched
  the echoed command and always passed, so they now use the shell
  variable sentinel and rtas_errd is verified with pidof; bounded the
  wait loops to 60 seconds with a failure message; assert that
  DEVICE_DELETED was received.
- Patch 4: no changes.

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
 tests/functional/ppc64/test_hotplug_blk.py  | 206 +++++++++++++++++++
 tests/functional/ppc64/test_hotplug_cpu.py  | 207 ++++++++++++++++++++
 tests/functional/ppc64/test_pseries_caps.py | 169 ++++++++++++++++
 5 files changed, 590 insertions(+)
 create mode 100755 tests/functional/ppc64/test_hotplug_blk.py
 create mode 100755 tests/functional/ppc64/test_hotplug_cpu.py
 create mode 100755 tests/functional/ppc64/test_pseries_caps.py


base-commit: 6883fb508cb7a93e2e7b44c0582bfd9fc2196d4d
-- 
2.55.0


