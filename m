Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3CCFED9E4
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2W1n-0000KS-TL; Tue, 17 Mar 2026 11:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1w2W1l-0000KH-CK
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 11:08:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1w2W1j-00071w-Nc
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 11:08:13 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62HEOHuO3853770
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 15:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=axND4xlA8p4NKRQW/G47Au9QYklXnG+K/JzgiSwu+
 HQ=; b=qYLnWENJ1OIiyuPhKPtoZcr+2g738YT0Wra7+3KHqA+BZHOgpJJ+OK4d6
 b4YLwthzyzCA5esvqdts+TCvmlbZY0Furk2lkJdTEnp5GncvSduP+obeBwoHU2xl
 Bfe7IoqkPMuvT20ntoLva3NQ181fuIlOkoM/eMThM0Kbd4Nn5UUhc6pdBChsia55
 3A5CcFJtf1DpTV1NGwSsVs3AUxU2+3oP5PxZEA1GqwxDuC0Vl9wrN1QetXQfCVHe
 fMR+3wpbTPVCtsRdREkZhwcNR4aSS8ENaxWUtPaGTxiY/IRbAHg5BbF3RdSEsI4a
 efi1OnZQfrULvNsXSgUdh5dOmQQig==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs5cn6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 15:08:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HCUN0b028501
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 15:08:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq19fqf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 15:08:07 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62HF86w661080008
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 15:08:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1664C20043
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 15:08:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6ED0E20040
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 15:08:05 +0000 (GMT)
Received: from Mac.com (unknown [9.39.22.133])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 15:08:05 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] ppc-for-11.0-hardfreeze queue
Date: Tue, 17 Mar 2026 20:37:57 +0530
Message-ID: <20260317150758.53781-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b96e58 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=p0WdMEafAAAA:8
 a=lvJexoOC8j4WlqM8shQA:9
X-Proofpoint-ORIG-GUID: -CJyjX7KCbixzgpa03oCwTfQmfmMNmWx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEzMCBTYWx0ZWRfXxeuadiJU/e+G
 KojMiphjQaIplQS0eKgV45GcsHaEPcT8zitye2Z+wtqAjiDONxIpRqfiE79bl6WqeUOv2JNoLVu
 Uqcwt2xYl3+O+vZpzh86FAayoaY2DwrW+EY4ekF0y35hrhTQ7pOhLyHELXUx6g+ncRgvLVvXy8L
 A5kw7tCNYU2H57g0sb/9kLkqcofEwGx7jqBKJzUIUSX82NzrUgepLMrMrSyzaHmuFVkU16dIX3W
 nfJBmxjo6hCUhemuypKjh4Kyjsoze99F+NDOuM701ZMg1O/k8b+iR2yHgjAyONCxVxLoVuC/JWe
 LcTU/LYpHQxmQE1nO4J5OBX7ExWvfyOxdIGUtGZf3mVqs5bwhY8Zz39gNOhA2SaPwAKY4S31KaL
 ABXfVCRZAMeBUDU5gHFvoURnJ6bkaEzkFbAov9iogPgZrLRW3oe7lLj7Ls3tCs47yMrfKi12nRo
 cud2HDACpg9E6eyb8Tw==
X-Proofpoint-GUID: -CJyjX7KCbixzgpa03oCwTfQmfmMNmWx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170130
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit 6667668e0cf369e47aa9dd0bae40989896e9ed9f:

  Merge tag 'pr-plugins-20260316' of https://gitlab.com/pbo-linaro/qemu into staging (2026-03-17 10:20:30 +0000)

are available in the Git repository at:

  https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-11.0-hardfreeze-20260317

for you to fetch changes up to a16d4c2f162a86db1f84ef0836d42eabaf57fe69:

  ppc/pnv: fix dumpdtb option (2026-03-17 20:31:42 +0530)

----------------------------------------------------------------
ppc queue for 11.0

* ppc/powernv: fix dumpdtb option

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEa4EM1tK+EPOIPSFCRUTplPnWj7sFAmm5bZ4ACgkQRUTplPnW
j7vZvQ/9HlYrlHQD3eQSEyUlVoEkR4piSh/D8sdigOOOdYhPEQZ6spluHg3OLEml
MvDv2Uz1t8GVKzGuZ19Y18H8wOW0zbjsOa9bfbtO7Mral7LIMbBFLej391czQVQC
NQ64Wms2B2TwjKDam8msekMkME646m5SanzgT1hGkKmIAKKSCBLwA9Na1HfxdcwQ
1TcDpjHBLg0x3OOmkh7V1PYyb7RSIAFRcYEkPnvgEWvIOaGubTVpB7/syb2n+cdq
ToPy0MvoIdlPID0wFd0t7t3tRPah/ubXD4ubrOEvWLDZ40BtLiB3p1Ou+MUU6lj1
GfPx7gjW4QG4o5aV4MmsAKxEP6K3RfJcRVjJUa3tl8oJvggS9uwvewEqHT07XBWc
NmxdEGzgkLCUXAVZLkKjqInz5VJlHROUWpsS8bq1edK09wju1o1CR0B0WDK//Cek
oqfZtb/6XHvmFrNnJprJvPNOWuhash1XRbL+iyfYxJJwuqIZPkQWjABeD7Fu8/aZ
Gpw3/2V+CiWJvThe9Z/vIEw/ksl1qigdNCtdVMeO9S8pQAtORZnUvNzWN5QKaVvL
VjxsFXhiEEn6bdoycJE0V6mfuPGaKcvE/APTDA4dT1b4du8IaUiiqGvGvVY+F1vg
p7ZpDlJmKd48jbkXnim8YiyXZO3sUUk7tw0N/xwPvCj+56nTv64=
=OUEg
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Shivang Upadhyay (1):
      ppc/pnv: fix dumpdtb option

 hw/ppc/pnv.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

