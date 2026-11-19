Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B21606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e0X2JyBc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU0NQ-0004LB-7N; Thu, 19 Nov 2026 06:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xU0NN-0004KP-A8
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:32:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xU0NL-0000Ef-L1
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:32:25 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJAuRlC4106938
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=D1w1AJNk+Km/536G3886ZCxe6Jm1q0ZQtoU+QAijc
 do=; b=e0X2JyBcNf34FJi1Qb6vKsuunHUlSdBTTsVd2cyL+9y3oWQ4jcU/q/hal
 uBWC2X1YvyUTT5pMzeSMRtD1uHt7kwH4yO44mdqE3rcA1kY0Tg99qvmkyvz2FNhW
 FUQCeF/vS6YQ7JjWySzrn/DARIGHx5ggfrZvTcH7QC2buf4n8WTMry2MtBSUxUpB
 TgtWlE64L1OcTiB7fEOA7BZliQvsqsfb1EoaQTdeg0QOHsxymv1xmKxN8XQ8Yets
 FO6pwBh+Q48B9zvS7tLTmJA2E0j7Z+BYjTfghQ1BlNusb05VVVxiUn0PEY/c6Qfr
 NLbtKUkUx7kT1yVt9VjqxCj8TgoZQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105ngmhk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJB5BWK3540701
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j17c4x2et-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AJBWIf141288150
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 429172004D
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB22E2004B
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:17 +0000 (GMT)
Received: from Mac.com (unknown [9.43.71.183])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:17 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] ppc-for-11.2-rc2 queue
Date: Thu, 19 Nov 2026 17:02:08 +0530
Message-ID: <20261119113207.79328-8-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfX2ZVa/4TJlhrM
 Os2Y7qWEIC+DJIbDri/aN9XPO+9x/OOaBEdif5vNHUM7mdAbXt2gy7SjhfG+BDwndKM85Kx41Wg
 rC7iMtCe1CjJX9WKMQqNbRxUP0QBI9L3bUNBn+PgqI5iOWDTa1ZtFNRLqvs+gqsXRmnFaJ6yWaS
 0Io3RlG36+rZr3rSnasYqlIS+VzpYYvytnLFgz6wJ0YtrEO9y7nQ7iev1fNjJmCqqboNmBlfLDY
 q/SkMNsGozjbzG1vgK2ImjMwt70iV4U5kCW83ZTelip97qfco2FHNo3dy0xqzjlQrQnsaH7Xt5n
 AJsig9yP5Y6fkthbRVEd6C+SnefTpnH9OcJ1rXvrUpxJYwlfMwZABxFrcP+bVMNhzBpj6/sw0Uz
 4njmAH/8WzIFdBQQTKlrLzD4dZCYPWi3cW+Vz/+/LbT+ie7dj1WwuBiwXxtFoQvSK9iOawkd+VB
 EjYyocz4EFOF3k8YYSw==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afede44 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=p0WdMEafAAAA:8
 a=gmDIBkXwTAZDaFmLb4QA:9
X-Proofpoint-GUID: CIwyX5zw9EMZBapS1gl1W7AO7cZoGH3y
X-Proofpoint-ORIG-GUID: CIwyX5zw9EMZBapS1gl1W7AO7cZoGH3y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfX6dqeSsUyaTSJ
 bbk0buZRbe8aVb7rIIFNkDgRz5hHNu484TA29B0vzbtRXrvOgj+fftnbpiP2qsem5fTWs3e5jcR
 DXbvM6FmpuLrgPttVr8LscPwq8M8mVU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190045
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

The following changes since commit 08c9bbb825148dec9669f5184ecf18823bb6d631:

  Update version for v11.2.0-rc1 release (2026-11-18 12:57:24 -0800)

are available in the Git repository at:

  https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-11.2-rc2-20261119

for you to fetch changes up to 8f2e232b9c6a0610564a1aed9ee92214ab76d5c1:

  MAINTAINERS: Change XIVE status to Maintained, adding self as co-maintainer (2026-11-19 16:34:47 +0530)

----------------------------------------------------------------
ppc queue for 11.2 -rc2
* Fix for CVE-2026-132127
* MAINTAINERS updates:
  - Odd Fixes -> Maintained (PPC TCG, PPC KVM, sPAPR, PowerNV, XIVE)
  - R: -> M: (Amit for PPC KVM, Gautam for XIVE)

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEa4EM1tK+EPOIPSFCRUTplPnWj7sFAmr+2JIACgkQRUTplPnW
j7tofRAAh+MyE9vYyn0DxCrSH3SLQfpC8s3ntf+PEtNMHeq9zmpmgSroB+pdMpVY
kaOQaKW1tcrYTkSQP4C51hv4GIOmwng7b/IRnSdzqnil+i5nnEKiuHXUwZd86nCX
lJ/hv1rFjHa8HzhE1OQAxbFkofJlTNbr2oD+GkgE6OkjjseWrFe/zXU35f06doUj
WoOg54HD8AAANj53jSbe5JmYeFPGUK/lTcoXnBv1pLLLh6cLiqrqGa9yk8szwjRZ
FpH/DgSqb+nGwu3mmKmiJDbOx2Eb4mDB8BgmERRGe0DSOQcZ9tO2/yiRGRBJjjZX
fjChiZ8/aqaPyMgc1YwiFvTDRoj2FZKhWe1Ki+pzVFxZYLHP4hNcf7se8nqIo9jR
P8xQPCoBiJwxqbsv3GiKfjGtmzLQF8a3nFUUSCObtdhK9XAhlUPPcDIpKssvDIJs
sNXwfWsCcZh2opeMhB6tNRL/OZxUEEO+kgwFP/BvC3yR5XyeimciR/rqKl+5FYfF
KIYqhev/+3KUrkgUAXzLSsc/Do8yP4tBSjnRFUsP1bWLfXocq19uTe1UN12UOmSi
OgbXDvpcwb0ulpGKj+lX+mOejzv7WpElRHHz5arv5cWj3sYZTnVUBg9d53J+854Q
1IjAFBNI0eY1qZkrt6DtkvX4XxILiN5HfKGiZX8hrWO7+a9uJ6c=
=HTQE
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Aditya Gupta (1):
      MAINTAINERS: Mark PowerNV as Maintained

Amit Machhiwal (2):
      MAINTAINERS: Step up as maintainer for PPC KVM CPUs
      MAINTAINERS: update sPAPR status to Maintained

Chinmay Rath (2):
      hw/scsi: validate IU buffer bounds in vscsi_preprocess_desc()
      MAINTAINERS: Mark PPC TCG CPUs as Maintained

Gautam Menghani (1):
      MAINTAINERS: Change XIVE status to Maintained, adding self as co-maintainer

 MAINTAINERS           | 14 +++++++-------
 hw/scsi/spapr_vscsi.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 45 insertions(+), 12 deletions(-)

