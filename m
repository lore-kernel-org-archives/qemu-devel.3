Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B8E606A915
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dRmo1Bgw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNugB-0001Iz-MN; Mon, 02 Nov 2026 11:14:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xNug5-0001FW-8H; Mon, 02 Nov 2026 11:14:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xNug3-0000es-LV; Mon, 02 Nov 2026 11:14:33 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2G0gvG3330874; Mon, 2 Nov 2026 16:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=HAtoXHFlfyxZBIhOT/A3DsAIQHBF
 uMo4E9OIfHRnpTc=; b=dRmo1Bgw6YOFJv3b8BP6KNAI1HZFDk/YiYzkOpMsfZPw
 FT40enSnxyi0QUUVfamX2I7sBYJ7FpU9dAfBgQsdDTRj1iOPRpp2V7w9BQMaJppp
 ouc46RBZfsYjDVw9W60Abcm0V3K+XTxWR6aS8XsFyScn1iQqghTNVmAb1WIthX8y
 +Fvlsx1gQsNV/JRXti6teOur6c/KFjj/PstMm/vQDCegzDH/uSlQzqZl9zOvefm+
 ft9ZcfuHh66GduPny1hmyrgVNgqYOgSNWTOHieoPFqNUQdLUtjhJBeSE8IZY5odK
 ezie5sQ21yFa8iWUwYuaJlPKPujHOP2YyWlN9joihw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn826hjg0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 16:14:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2Dp4Zh1046640; Mon, 2 Nov 2026 16:14:28 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hnwbxxfv2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 16:14:28 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A2GERck32506532
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Nov 2026 16:14:27 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2183C58045;
 Mon,  2 Nov 2026 16:14:27 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5168D58050;
 Mon,  2 Nov 2026 16:14:26 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8058-b2c04f424b34.ibm.com.com (unknown
 [9.61.98.239]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Nov 2026 16:14:26 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 0/2] s390x fixes for 11.2
Date: Mon,  2 Nov 2026 11:14:22 -0500
Message-ID: <20261102161424.241623-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: E0oeA7lgxvdFCQK0xyjGA8S71TU47H4W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2NCBTYWx0ZWRfXx+IzvIBDuajd
 0FwU8fwCngGBU0i0DVZQnwAxboFanxHM8fJIKI5eSE6yeV41jezjc4FQrxc4RtgGBy51kChapXq
 Un9eArjD4T0jnUQrVasUTHThryh1dLH5M/R4xndVb2ax4RgN/EirPHS6+YzWOlz1pdtSbZx97C3
 E8vxcH+psJhAsGaICKEpjI6rYXGzf6S70RSXJw3rY7mOrRWHwPUmogIwsZqtmQ8fSWYvyIlMFk9
 l5zycCGdpwLDQkBCrd6sEnkH9QpJtvNXQKlBHMzM0ydh6ANKUw+FT4jptpcjBqUlk1DqAWP95ie
 nbsErVq2zGtttOJ33UcBZUVxesT8/maphfh2MBUrcNtXOouBUbP8D9YwI1s7WpbyIB5z4PZij8z
 a5tUumTQdNhs+0rjXTXHUlrNRUkzylZgH+iE30pYbMfwKmLqXss1J/qg3CnM40KKkCXPSlou7zZ
 dQCFauKKPXbIpEbHLow==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2NCBTYWx0ZWRfX1Xa3A4v1Lr2n
 5F3ICB570RA/ixPIs7K7EBiFRCka8hyiOJC/MoouuPt+FS9UktJK4i/dEhSCuA5b+7pOy8mqVtQ
 a7H89Y28sSSuqWK3NEQCUTr/zH1palk=
X-Proofpoint-GUID: E0oeA7lgxvdFCQK0xyjGA8S71TU47H4W
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6ae8b6e5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=NEAV23lmAAAA:8
 a=p0WdMEafAAAA:8 a=BvedxiNuGJZQJuEApUkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020064
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 73294d096cc591e122fde9e63db4739de6d84f2b:

  Merge tag 'qga-pull-2026-10-28' of https://github.com/kostyanf14/qemu into staging (2026-10-28 06:21:59 -0500)

are available in the Git repository at:

  https://gitlab.com/efarman/qemu.git tags/s390x-20261102

for you to fetch changes up to b71287f0078200b07ee2fa9a28991645a3a92777:

  s390x/pci: Change reset method from legacy to resettable exit (2026-10-29 14:43:37 -0400)

----------------------------------------------------------------
s390x fixes for 11.2:
 - Fix zPCI cleanup during unplug/system reset

----------------------------------------------------------------

Farhan Ali (2):
  s390x/pci: Free FMB timer on zPCI device unplug
  s390x/pci: Change reset method from legacy to resettable exit

 hw/s390x/s390-pci-bus.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.56.0


