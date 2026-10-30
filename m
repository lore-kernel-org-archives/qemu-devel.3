Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668C5606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rDPERT/p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmOg-0005cW-0M; Fri, 30 Oct 2026 09:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1xMmOe-0005c7-Q1; Fri, 30 Oct 2026 09:11:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1xMmOc-0004o8-Pz; Fri, 30 Oct 2026 09:11:52 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBIKBg2752175; Fri, 30 Oct 2026 13:11:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=oMVQ+y5IVo+6CuixK+pnnNWCewslZb9ERdT2qUhcm
 FI=; b=rDPERT/paHOxS+sK+FJXYL28D+hQCZ7DuwUXOsIOGdzz9K9HvpLtnY/Bd
 jtM4fT4zW/pbC6g2eYP2Cuuvcfe5AYI+WAEW4dm2iKYryy8t3Q0bWnZU4G4YGs2t
 /71keSpXZYYpSnY2wb5ffwox64Ud/4FEK+NIqZYEaBnT0bdrukCj0ZPePg8xcblw
 5on0vqcn9LYhZ+HbSM4ymriO4h6deR9rahlJ7/SwGMfyRkg3Ao3lc09Z5vr7ip9q
 y1hpU7+Cm/BtS5+1wY6LGfkD9pqDWOmiJFE9OY1vbWOqdixfax0Q7XiGvJfud7Um
 KXVrbbL8m5dVn3Qzo3NTVeJBYWdqA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hmeay2uqa-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2026 13:11:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBK1YS369454; Fri, 30 Oct 2026 13:11:45 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hm8qpbxkn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2026 13:11:45 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69UDBinv12976738
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Oct 2026 13:11:44 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0AF7F58043;
 Fri, 30 Oct 2026 13:11:44 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6AB4D5805E;
 Fri, 30 Oct 2026 13:11:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.21.33])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Oct 2026 13:11:36 +0000 (GMT)
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, amachhiw@linux.ibm.com, clg@redhat.com,
 thuth@redhat.com, adityag@linux.ibm.com, milesg@linux.ibm.com,
 misanjum@linux.ibm.com, Anushree Mathur <anushree.mathur@linux.ibm.com>
Subject: [PATCH 0/3] tests/functional/ppc64: add pseries CPU hotplug and
 security caps tests
Date: Fri, 30 Oct 2026 18:40:21 +0530
Message-ID: <20261030131025.32219-1-anushree.mathur@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: izvva0WWpBNH1WD_kJ771cSzbSMKg2kI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1MCBTYWx0ZWRfX3dc6IEU3f+gE
 6QecUswyKA82Oxd8R6Pt4lb0M5gLwdY1nTd7WjmR2m3+uD7T5xIj4dW/imEh5NYlKUG+DxMjvyg
 saUkonps4yLCUSXLv5aLVHy+fze26U4lUORFWNPdJQ0SiM2dKE+/2V3U/uNwRGIfbu/56DP+g6W
 os0sE0gDgddu6RE/o3od7zckiAI0fe66qYAHnClANLVCzHBNph2mJuLHbFyGNH/hakzm+xsVBBr
 5crBjZSBGIYU+j1/KpxAie0uhbI42MgKTNGU2UgkeANshmZwBQj/KsAnRYu0NuVJEKyNAeqX4S0
 q6nAecMzRUdqNZ57UtvEyr5N/7EG93CXaFUCo7BZAJ78YcvvbicVDJdrB78r+AFf0fs46y4msuz
 XcUIx57n+dSXRTdaLi2vjUkJVwrBf60T2BTupwBgTGIjxC3miAZzQTx2qcJxEZ1Xa3OyLGtyOML
 G9vcPJcnkGJLRLQB64Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1MCBTYWx0ZWRfXwj5JCygHxL5w
 h49Lf+EnDgKQ3oj3eouhCrtYvzwy3Zwx5UT1hBg5eb2CjQmGuHoZsmWQF95pmHGyD/LsRrM94PP
 6NYwPuyx5FOrigbXZ4+Gqi731DcOjpk=
X-Authority-Analysis: v=2.4 cv=QbjzLcbv c=1 sm=1 tr=0 ts=6ae49793 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=p0WdMEafAAAA:8 a=Htddfhv7B4_m3RFTIZEA:9
X-Proofpoint-ORIG-GUID: auaH1qnRWEzWkZEoSGVekEm97vqeZa-f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300050
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

This series adds two new functional tests for the pseries (sPAPR/PAPR)
machine type:

Patch 1 adds a DLPAR CPU hotplug/unplug test.  It boots a minimal
buildroot Linux guest with one active core and uses QMP device_add /
device_del to attach and detach a second core at runtime, verifying
the guest kernel's view via /sys/devices/system/cpu/online.  Two
variants are provided: TCG (runs on any host) and KVM (ppc64le only,
with an explicit kvm-hv module check).

Patch 2 adds a lightweight no-boot capability test suite.  Each test
starts QEMU halted (-S) and exercises the QMP interface to verify
that security capability properties (cap-cfpc, cap-sbbc, cap-ibs,
cap-ccf-assist, cap-nested-hv) are accepted, that versioned compat
machines (pseries-7.2, pseries-9.2, pseries-10.0) can be
instantiated and are correctly marked non-current, and that
cap-hpt-max-page-size is reachable via the QOM tree.  All tests
complete in under 5 seconds and are registered in the quick suite.

Patch 3 registers both new test files in MAINTAINERS under the
sPAPR (pseries) section.

Both tests have been run on a ppc64le Power11 LPAR and pass cleanly
under both TCG and KVM.

GitLab CI pipeline (check-dco, check-patch, build-system-* pass):
  https://gitlab.com/Anushree-Mathur1/qemu/-/pipelines/3003562135

Anushree Mathur (3):
  tests/functional/ppc64: add pseries CPU hotplug test
  tests/functional/ppc64: add pseries security caps test
  MAINTAINERS: add pseries CPU hotplug and caps functional tests

 MAINTAINERS                                 |   2 +
 tests/functional/ppc64/meson.build          |   3 +
 tests/functional/ppc64/test_hotplug_cpu.py  | 183 ++++++++++++++++++++
 tests/functional/ppc64/test_pseries_caps.py | 178 +++++++++++++++++++
 4 files changed, 366 insertions(+)
 create mode 100755 tests/functional/ppc64/test_hotplug_cpu.py
 create mode 100755 tests/functional/ppc64/test_pseries_caps.py


base-commit: b574eaf640f02c4edf28cbee6417378f0d79cda0
-- 
2.55.0

