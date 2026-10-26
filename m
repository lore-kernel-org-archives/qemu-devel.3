Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F374606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BPZBBBkD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLHU-0007VA-FJ; Mon, 26 Oct 2026 10:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xLLH0-0006vP-4T; Mon, 26 Oct 2026 10:02:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xLLGy-000184-4j; Mon, 26 Oct 2026 10:02:01 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QBEJQR3357291; Mon, 26 Oct 2026 14:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Rb9XlNe+zANcwXq40SkqmcTNaGuLVSdYjxbaa0AAc
 /0=; b=BPZBBBkDDX+NYuMLb3RkowoTUWehos3bEM3B7xDbAsNxOIfC6GTlXyM0s
 FpeSKXyLbrdG+DYweoBhj96E05LBHdkEKOZgvOxEl4uCHL2JoVK5pkSEBI9x1+Ek
 674fNhJOn0xDCdAaMbiCxBrXdGnRrmsEzNkkXNkXnl//HZudiAbOwGIbVN6zipi+
 ya/pgDH6O0clP3ZT1TZjE/X8ouVwgMoqq9nCbkqEHEvvR1F9yBWA7rlRC45+/Chs
 TgTAxZC7urycaSWZnhg3aMyU+Ebv8jMadatTxSGyPcaxvzfuCGb6mxkUKXM8KAPQ
 xSWus1CpTt01rAMPZy0JkVwxE8Qxg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmav9xfb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 14:01:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QB4wPT2500610; Mon, 26 Oct 2026 14:01:57 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh8ggx4nu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 14:01:57 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69QE1uVm3605316
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Oct 2026 14:01:56 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C35D5805F;
 Mon, 26 Oct 2026 14:01:56 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6995658053;
 Mon, 26 Oct 2026 14:01:55 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.109.57]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 26 Oct 2026 14:01:55 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 0/6] s390x queue for 11.2
Date: Mon, 26 Oct 2026 10:01:47 -0400
Message-ID: <20261026140153.2072253-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1NCBTYWx0ZWRfXyWCf5x+rB7OE
 WmD7Dryt34l98a96KB/Q6f+tHM8CL4z7IpGEYqA8AvETKbsB5GQgKStputyKNKO0eExcHSOQDv4
 q2ShTdffNjRLms0DsuLE7Rhl9O7g5DM=
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6adf5d55 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=p0WdMEafAAAA:8 a=OHoHsdKHgrCAsEdHe_UA:9
X-Proofpoint-ORIG-GUID: v5aG6ZNBf4T67eR56kVTR3B7rzYhNJ5t
X-Proofpoint-GUID: v5aG6ZNBf4T67eR56kVTR3B7rzYhNJ5t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1NCBTYWx0ZWRfX/WeeBPSAMsod
 O3gt4tz+55HHV9YoRnN+0mBG2tou4UWR+BLXvOM7l8sbCQBnk2B9t9R9WMCcJKZt0EugdJlXXrM
 gfrDavwP8kRrpoJSzaDFhs0sypHb6k3LafJi5i+SU0VWj6oAQc6cngcqykBJxVlN+LgppV6cmlC
 LXTSOQZ5gdJ1fpQLf3nRlo02IM0DPyQJqCyn4cZtYnAVfxpRG4UR4BkOf/i8ryBK4C7/e1pPpfn
 VNaqw8pOpUS0ACm7NWhrNgcU9cjLcNIWa7xWXviMVnRIJzpuff1irP8Y36vF02QImdGHY3KmJ9Q
 x2gTo46uRJrEoDahRob5U3pIgn+Kh5cl7jDFYRaTSltZleTb3IxoA4Y7ugEHvdyU1Qn4hzaHvXm
 nUQzNPwV5KRBVFOftbGWAEYDrAMZIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610260054
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 288b6c9e78913401fac4880b3281ce431540b8df:

  Merge tag 'pull-nbd-2026-10-08-v4' of https://gitlab.com/ebblake/qemu into staging (2026-10-19 10:54:44 +0200)

are available in the Git repository at:

  https://gitlab.com/efarman/qemu.git tags/s390x-20261026

for you to fetch changes up to 2ddae8799cc52591846f3a0a901a77e2284f8751:

  MAINTAINERS: Update s390 boot reviewer (2026-10-26 08:10:58 -0400)

----------------------------------------------------------------
s390x fixes/features for 11.2:
 - Implement resizable vt220 console
 - Deprecate dependencies of deprecated features
 - Reclaim DMA slots during, for example, guest reboot
 - MAINTAINERS updates

----------------------------------------------------------------

Collin L. Walling (2):
  target/s390x: externalize feat dependency array
  target/s390x: mark feats dependent on deprecated feats as deprecated

Eric Farman (2):
  MAINTAINERS: Add other s390x tree
  MAINTAINERS: Update s390 boot reviewer

Maximilian Immanuel Brandtner (1):
  s390x/sclpconsole: implement resizing for vt220 consoles

Omar Elghoul (1):
  s390x/pci: reclaim DMA slots upon IOMMU disable

 MAINTAINERS                 |   3 +-
 hw/char/sclpconsole.c       |  76 ++++++++++++++++++--
 hw/s390x/s390-pci-bus.c     |   8 +++
 target/s390x/cpu_features.c | 139 ++++++++++++++++++++++++++++++++++++
 target/s390x/cpu_features.h |   4 ++
 target/s390x/cpu_models.c   | 133 ++--------------------------------
 6 files changed, 230 insertions(+), 133 deletions(-)

-- 
2.56.0


