Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F263E606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 06:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=okmZz8W6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTvfe-0004VY-6q; Thu, 19 Nov 2026 01:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1xTvfS-0004Oz-BH; Thu, 19 Nov 2026 01:30:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1xTvfQ-0006mq-1y; Thu, 19 Nov 2026 01:30:45 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ4iiXI3146444; Thu, 19 Nov 2026 06:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=k6Hm7J0bQP0GpIaeK
 dykoSNDI3Q9s4GthdV0yo+x/UI=; b=okmZz8W6XZ4QIUtmR9BGHT63VphXEBli+
 1ae+IbBJW8HNPm4a2LYJkn6NHmePtG5JA00rIW99N2I1i64w4Jxn3saRYHGcwwQ7
 +hQnAi0N2Gv2tneGLOvDhG9H+EJJrhumpgWkOUijIZOj3Y2XLxaSAM8z59HnjxXU
 qlWZYFhGkCowgR5oOXsqQs0J9xUUM9d9gOGTF4LydhxHpyZTv0iPua31xoddUVoT
 NuhtelwoCgNCunkbIJ0nr9CTz55WgRjOlxNOu8a4eIwITXqi49qheQ+RqKIPynON
 eAKOiTZ6xmFBbl7GdTfpTJFXcCcR7P2aGdwojKJqPwPaYvL/gJm3w==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105wxsk2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 06:30:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ4rN8d063061; Thu, 19 Nov 2026 06:30:41 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1hd6tkfy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 06:30:41 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AJ6UdcO26542672
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Nov 2026 06:30:40 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C752958061;
 Thu, 19 Nov 2026 06:30:39 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDB0D5805D;
 Thu, 19 Nov 2026 06:30:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.221.175])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Nov 2026 06:30:34 +0000 (GMT)
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
Subject: [PATCH v2 4/4] MAINTAINERS: add pseries hotplug and caps functional
 tests
Date: Thu, 19 Nov 2026 11:59:50 +0530
Message-ID: <20261119062951.83498-5-anushree.mathur@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119062951.83498-1-anushree.mathur@linux.ibm.com>
References: <20261030131025.32219-1-anushree.mathur@linux.ibm.com>
 <20261119062951.83498-1-anushree.mathur@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: _JFZh3fGENcqaHLBmjrhZ4IHDTPs4qMK
X-Proofpoint-GUID: IzSLNZ6b4nxQ2xYN3i5FuxGxNP4hJzOb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAyNSBTYWx0ZWRfXyVYzWSpuUxsc
 AFk1yQALZ5x+Fpt+Z5Y5NfY9rB80SxSOeq/YigDtbRYhvbiWLqVYn0EMvHy4NIqcvJ87ukZocaw
 V49GljRIOJ0q2/ligQV8q3lPl0opeDMVQfEiPTqrirn7zKLNSUnVJ1yDNY/bvXMfxl2zKPhFtm9
 4U6PBHqQmyvD0uqd0zQ5XMY/9Q3eP1jNgKABp87YcTcUjOsk7Jf7S14tQufhv18TPuYdn4CGsZ3
 Y9CbaCexyMnXn6JuaVJzpgzTE8e8SO9klbLZKdXLjVvFxjACBciqHVxv5zcoBj/55FttbbOqDW4
 bjQEv0ueEirFsxtgQCTZ0qCXm8781LuI45uS2kZZqvifm16/rEYj9C3wUg0+cikgbwHJDnvltYu
 3lq1sbfKwsKsyb+COLNyAn/mTf/xoOk0RQ5yyb5b1FHLj6rJWyHGgdE77scmqC/Oi3uH6Ge6v1+
 6/rt4k9c3Esbh3YVELA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAyNSBTYWx0ZWRfXw3J3Dtz1gkqL
 b9sD4iPrUZ0dxUrjTyOF3mtNwmq2e78Xl1aOto9DnQikGfNCa3aJ8uNIoxI99+DByLYz2KKVCrM
 Dv9V/b+S/Cq1RKMouz8Cb2ucJdP57wk=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6afe9792 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=We0Iha30fGkoBXOV-LwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190025
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
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add entries for the three new pseries functional tests introduced in
the preceding commits:
  - tests/functional/ppc64/test_hotplug_blk.py
  - tests/functional/ppc64/test_hotplug_cpu.py
  - tests/functional/ppc64/test_pseries_caps.py

All of them belong under the sPAPR (pseries) section.

Signed-off-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
---
v2: now a single patch covering all three tests (previously a
separate patch plus an entry in the virtio-blk patch).

 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15942aaba3..8456c5fbec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1705,6 +1705,9 @@ F: tests/qtest/libqos/rtas*
 F: tests/functional/ppc64/test_pseries.py
 F: tests/functional/ppc64/test_hv.py
 F: tests/functional/ppc64/test_tuxrun.py
+F: tests/functional/ppc64/test_hotplug_blk.py
+F: tests/functional/ppc64/test_hotplug_cpu.py
+F: tests/functional/ppc64/test_pseries_caps.py
 
 PowerNV (Non-Virtualized)
 M: Nicholas Piggin <npiggin@gmail.com>
-- 
2.55.0


