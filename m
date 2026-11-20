Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFFF606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gi4xx+4c
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUOSr-0002vS-Hi; Fri, 20 Nov 2026 08:15:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andy0x48@linux.ibm.com>)
 id 1xUOSi-0002uN-02; Fri, 20 Nov 2026 08:15:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andy0x48@linux.ibm.com>)
 id 1xUOSf-00046y-UW; Fri, 20 Nov 2026 08:15:31 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKAuV5p2878744; Fri, 20 Nov 2026 13:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=uhH+mascWjLQkvzIcxF6xxJI5i3DzEkxFbLQYapIq
 ec=; b=gi4xx+4ckkI2KsIESKVpGuobQs7G1tRjCW5MAe+UoZLiC2CvJQZ5WBv36
 e0rQugDl9rgWjtB0LSAUDAbyeefoCc5ZQr02t5KQlom1briqLVHI8bYeYWDWacl4
 nrxlbDl39Oc7SwCJUvKvV3MQ1W6/wrX/VUl0vY673HRCZcdISmOJPbRLMTxOXvK0
 FScj/ichn6pKmoSCpfUXtxwCOd7LKkwzayHCEx5dDqmxsbeD79yQk95KDUBmMfC4
 QGgHS9XlUIZmiUv9AOHF2rKAernj+KSpKzR9WrUqpFqb/DUyLEjZNx944Ngi0GyU
 OEduV+dY6rlUhavjNSfMzDI5m+hiQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105tgmds-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 13:15:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKAo3Vw1107175; Fri, 20 Nov 2026 13:15:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1bb5m957-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 13:15:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AKDF7U150397452
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Nov 2026 13:15:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E709A20043;
 Fri, 20 Nov 2026 13:15:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 81E9C2004D;
 Fri, 20 Nov 2026 13:15:06 +0000 (GMT)
Received: from work.ibm.com (unknown [9.111.34.217])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Nov 2026 13:15:06 +0000 (GMT)
From: Andrew Holden <andy0x48@linux.ibm.com>
To: qemu-devel@nongnu.org, iii@linux.ibm.com, freude@linux.ibm.com
Cc: qemu-s390x@nongnu.org, richard.henderson@linaro.org, david@kernel.org,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 Andrew Holden <andy0x48@linux.ibm.com>
Subject: [PATCH v2 0/3] Fix AES/PAES CPACF register update on faults
Date: Fri, 20 Nov 2026 13:14:40 +0000
Message-ID: <20261120131443.61606-1-andy0x48@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6b0047df cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=woak3cZVeigv11IYnT8A:9
X-Proofpoint-ORIG-GUID: n3fIzyX6G0WBWWKo7vHhImUUHXHXwmBx
X-Proofpoint-GUID: n3fIzyX6G0WBWWKo7vHhImUUHXHXwmBx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1MSBTYWx0ZWRfX4HYjhD2exvWh
 ovtFG48CtH0mwI2a5Q2tv5v4wQtFBm+M8G3ioV4yKgxvrqzAcXvWgXHrI7tXbwrU8UPE8QintZ6
 jEUpfxb1WZRXWTgFdV0MCw4OmyFvDTE9ykU1Hku0mccyKQKxEHtxHnzVK+u5a3cOVWgAEhi5eTg
 AU5gnUuN03WGTk8oFzaUmv11zP1o2+MO4czdsDDHqf3ddJjwSYkkombYYVh/B8JmFtWvGbksAFW
 RECjbI19I8+TUgCWCUiepoKdszt6LC36wL5GzRNK5hBLYA+HK5Fu5PXinZBUUMdnW8jQWyyxS+q
 wX4xCB/Vz6vf/EtqL0IDVsqOIFmzSSYwSHap6KOJ8uE9LAuvM5rzaVd83OTTqvyFSUfYB/ZlYxD
 zKNk79cYD9QqkG/EeCvBeP/01NtPN7yOEcb4hN4aL3ZJ3FPLzgAOV9VeIedgDFCae6rspjUsqjy
 Da164sCUJNzIlN5UnLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1MSBTYWx0ZWRfX1qw/VUCBSk9m
 per44EFfdkzT03L4xwzQYaec2hf9Gp3W/4yT9mU2zxd1/qV+N6cvRt3v6aNdUsaKqWWSB1aUIFy
 3CNmFNQjySkxAzUqDj8oXpvZsimxoeg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200051
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=andy0x48@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes how the CPACF AES helpers (ECB, CBC, CTR, XTS, with
both clear key and protected keys) behave when a guest memory access
faults in the middle of an instruction. A fault could leave a block
partially written, and the registers, CBC IV and XTS tweak not matching
the completed blocks, so the instruction would not continue where it
stopped.

Each block is now probed with access_prepare() before anything is 
written, which applies to the source, destination, and IV/tweak. The
registers are now updated last, so a fault leaves the block unwritten
and a re-invocation redoes it. Block copying is handled by
aes_read_block() and aes_write_block(), shared by the clear-key and
prot-key functions. 

The IV/tweak range is probed before the block is written, so a fault on
this is unlikely. The data and IV stores are still two separate steps
however. If the IV/tweak store fails after the data store, e.g. because
another thread changed the page post-probe, a re-invocation would not
redo the block cleanly when the source and destination overlap.
Currently, I can't make the two stores a single operation.

Testing:
qemu-s390x and qemu-system-s390x build, with current cpacf tests
passing, along with four fault tests written by Harald Freudenberger -
these were built and excercised in linux-user mode, targeting the
relevant instructions.

Notes:
  - Prot-key functions are covered by existing cpacf tests, but no fault
    test currently exist. 
  - Access helpers declared in s390x-internal.h - is this acceptable?

---
Changelog:
v2:
  - Probe src, dst, and IV/tweak ranges with access_prepare() before
    writing, so a fault leaves block unwritten, incl. block that crosses
    page boundary.
  - Share AES w/r block helper for all functions.
  - Extend fix to prot-key functions.
  - Squash each cipher mode fix commits into one.
  - Include testcases in this series

Links:
v1: https://lore.kernel.org/qemu-devel/20261008154455.369004-1-andy0x48@linux.ibm.com/

---

Andrew Holden (2):
  target/s390x: export access_prepare() and byte accessors
  target/s390x/tcg: update regs and IV/tweak per block in CPACF AES/PAES

Harald Freudenberger (1):
  tests/s390x/tcg: Add cpacf clear key register update tests

 target/s390x/s390x-internal.h           |  25 ++
 target/s390x/tcg/cpacf_aes.c            | 380 ++++++++++++------
 target/s390x/tcg/mem_helper.c           |  33 +-
 tests/tcg/s390x/cpacf-km-ecb-fault.c    | 368 +++++++++++++++++
 tests/tcg/s390x/cpacf-km-xts-fault.c    | 511 ++++++++++++++++++++++++
 tests/tcg/s390x/cpacf-kmc-cbc-fault.c   | 472 ++++++++++++++++++++++
 tests/tcg/s390x/cpacf-kmctr-ctr-fault.c | 414 +++++++++++++++++++
 tests/tcg/s390x/cpacf.h                 | 103 +++--
 tests/tcg/s390x/meson.build             |   4 +
 9 files changed, 2138 insertions(+), 172 deletions(-)
 create mode 100644 tests/tcg/s390x/cpacf-km-ecb-fault.c
 create mode 100644 tests/tcg/s390x/cpacf-km-xts-fault.c
 create mode 100644 tests/tcg/s390x/cpacf-kmc-cbc-fault.c
 create mode 100644 tests/tcg/s390x/cpacf-kmctr-ctr-fault.c

-- 
2.56.0


