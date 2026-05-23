Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD604CD5BAC
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 16:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQpCN-0007Wg-5l; Sat, 23 May 2026 12:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wQpCM-0007WT-By
 for qemu-devel@nongnu.org; Sat, 23 May 2026 12:27:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wQpCK-0001Mn-D8
 for qemu-devel@nongnu.org; Sat, 23 May 2026 12:27:38 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64N3mvIp2452266
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 16:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=uZYpxU4ehW8qRF3fGHd1di+MVy4sGE9sqUeDI0Qr5
 68=; b=ZitGk/oYK3nUHyr7+lqdbatvne5X+F4BTUvur78KzzxX/uDi3Y/GDzETv
 KhfIE9HJTl9yFXFboOOpUTZvebPDPowu3ZiigJTuo51zpRAyDxis7hLTH2s/RNzU
 plnxeA6d5zJS8xcATz4OCuyp2RDaw8mTzFpP3Qpa23OX70tlb3Ua57xHPhWNYju7
 lfwetpy5gwTLThp7mgIWc78ESqueHjJH9wp8WX9MpxUKtaIC1d7knPVNRzRRN4CK
 u+JV4iCkLfdm7d6UrJNUKp2S1FgaTd2l+yO2d7apt+UNlivPYQF3dYRMee5fEsSS
 GHFR5JtoIIWPIGqy7rxRQZDlwit+A==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nbsc3q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 16:27:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64NG9M4L001387
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 16:27:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eb46bsr3t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 16:27:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64NGRWOp29688270
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 16:27:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E80F2004B
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 16:27:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D38C120043
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 16:27:31 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.135])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 16:27:31 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] PPC Queue for 2026-05-23
Date: Sat, 23 May 2026 21:57:19 +0530
Message-ID: <20260523162724.95229-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=VvYTxe2n c=1 sm=1 tr=0 ts=6a11d576 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=-AnQz9JOAAAA:8
 a=p0WdMEafAAAA:8 a=F4ZD4lpSBr2GUrNKNI0A:9 a=3bnadFWGKyIZm4bBUiDd:22
X-Proofpoint-ORIG-GUID: TJzoJ1PWrx-bMbMlizVjwmt_MNgrOng5
X-Proofpoint-GUID: TJzoJ1PWrx-bMbMlizVjwmt_MNgrOng5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDE2NSBTYWx0ZWRfX7uMQlyRaO6Gd
 m9bu2IwwynesoSct+fSlk+IXVFPFb+/F3uO+QG0ZYeIsK5O0rw2TsfqqHf7PIIs2p1k2b1JghyF
 HmjnMBiByyeER/iTgqRR5RgZue1SNDNK/5cH/4613zn9I94+FcAJ+7PMcyOaEmoewYg9qqPt4g3
 3pEhICKtm4TeNkvpUOw+ogzhZBmni+s5TCIok6nKI/302UdbDVr6yTULvsWYwfYq5PTjKHEgZ4F
 psS0oM6P8/l4MQKLLicV9iohhlvfPU8TtIuSdGOwjArr7frzL/Dsg8+/vKp8xGlAR9DQse7C7YU
 UeSJzmNvmRAaC0naYTRRIWVrPyg5K3UUCO2qZuX5P2U3MzDgZgzCW2Y6niwC74TyGJXXzpiwYdr
 PPMpcNk2dEVeZprgjmESdKhgc0oHYZxLFPaH1PbJjFjzoZO/MAa56kTrXHKw3NN443KrgDLbTbR
 3QH1lQyTnvINnklAamw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605230165
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit f5a2438405d4ae8b62de7c9b39fac0b2155ee544:

  Merge tag 'pull-qapi-2026-05-21' of https://repo.or.cz/qemu/armbru into staging (2026-05-21 09:00:22 -0400)

are available in the Git repository at:

  https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-11.1-0523-20260523

for you to fetch changes up to 31064eb74c8635d3747d091f455d232665e06a2e:

  ppc/spapr: Make Power11 as default cpu for pseries (2026-05-23 20:34:10 +0530)

----------------------------------------------------------------
PPC Queue for 2026-05-23
* ppc/spapr: Make Power11 as default cpu for pseries
* ppc/pnv: Make PowerNV11 as the default powernv machine
* ppc/spapr: skip system reset for quiesced CPUs
* ppc/pnv: Fix uninitialized MpiplProcDumpArea struct
* target/ppc/kvm: Fix const violation when trimming CPU alias suffix

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEa4EM1tK+EPOIPSFCRUTplPnWj7sFAmoR0bUACgkQRUTplPnW
j7vdng//Zpave2r0fGigk/qyjvpbHUvPO3bM57EAVHn7AiaO9okF9Mc+1k8jBS1s
DvzTEwj24TorMq/ndz5I6JVjRL0o/0a/+cGGn8/8nu7D0zsbCqiD5LUiulicc7Nj
JmOnFxaO8FebEZoQvizG0CwbW6KetxFVbq4vFUnG9Hn16ZVn3vasnL7QRVOTfDUJ
Kc59OXrtoUsrOOp5ODQEDXGt57WsoTaIhGhFDr+/pcWHk7H75pKXoezmzW4Ba5KB
Zf78V+Bai7tAhaUghAlmvf+BSJr5aXpxC1nuKfFnFI+VDgbHdv0/bKFKtCmGBVzg
XK1cjR6zip1qxmjYF9hCIp7SS/DTmQ3F6rVzyTz4L+/16XtV+gU9gBw5zyFkTJdQ
/U0HOwMD2mxhf8fhtlquq456Dveb7RXOSj+pq9D4NwUB1qgG1G0d+u20oL1OXi33
C2AxH4yu0F84dWLX/s1+266pEccLYNiEPAv+nQH2awjISBGphteIOZuMv49R+a68
me4HJ3BWxtCDjed20+PURtnHDzoaeF6QvG9Qs8xkZsnlvVZ4o4MbchythZkYFhRJ
RnWj1WpIiOMtem6QhcX3wm/XR26yZhp/1Znv2MypFoi7NBZY/cNtzc+kFYq8mwZq
quJFxjDZ5TFg38ngomvlUsVnQrHuohNGktJsNnVNy5W8DtaeyUs=
=+DsC
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Aditya Gupta (2):
      ppc/pnv: Make PowerNV11 as the default powernv machine
      ppc/spapr: Make Power11 as default cpu for pseries

Amit Machhiwal (1):
      target/ppc/kvm: Fix const violation when trimming CPU alias suffix

Shivang Upadhyay (2):
      ppc/spapr: Skip system reset for quiesced CPUs
      ppc/pnv: Fix uninitialized MpiplProcDumpArea struct

 hw/ppc/pnv.c         | 20 ++++++--------------
 hw/ppc/spapr.c       |  3 ++-
 hw/ppc/spapr_hcall.c |  9 +++++++++
 target/ppc/kvm.c     | 11 +++++------
 4 files changed, 22 insertions(+), 21 deletions(-)

