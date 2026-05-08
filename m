Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0A7CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 16:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLOSD-0008Dr-5q; Fri, 08 May 2026 12:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wLOSB-0008DY-8n; Fri, 08 May 2026 12:53:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wLOS9-0002Of-H3; Fri, 08 May 2026 12:53:31 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6487LOlS1302390; Fri, 8 May 2026 16:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=RS1YIH
 HUGygkoOspMVavlhC/8YxMMkOqx/JEV0aGWi4=; b=Foz+/wgsD6RWpSjwPm7tWh
 JdVIwwTXthijYblBC4mXr2edemEltTpiat6ap/x9sOD7fgc3nKslPQpxKltkvToK
 P18ZJzBV5RFGBgmWvoJFQlsnHkuOcFa/PVDbjfN0vvMfq5FSjX6kD2HCQ2GTPtk0
 aPpgJmo3EinjseSfiaYlOp3ki4M7ryozf0XLuzB5aluSfauUH6jvrUJmUZDcBuRk
 hVEFNc1FxlJZN6K/PFLh6rjm0lPKXNgqavgGsqOHyQthK6cVzD6Iw/5o42jvMWrI
 JGarIrWOTxfULEOSWfIBLMuTCahLM/skwXAQDQgdw1hT66HebqjBrXA00rReUQjQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7vs8d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 16:53:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648Gdi0P022763;
 Fri, 8 May 2026 16:53:24 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e100744kn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 16:53:24 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 648GrN3f13238848
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 May 2026 16:53:23 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99D5F58059;
 Fri,  8 May 2026 16:53:23 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19EB058043;
 Fri,  8 May 2026 16:53:23 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.111.34]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 May 2026 16:53:23 +0000 (GMT)
Message-ID: <7001016dca4e72d9f1a566def9d753ce1dca1325.camel@linux.ibm.com>
Subject: Re: [PATCH 1/6] s390x: Rename SCSI IPL type to indicate CCW bus
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com
Cc: jjherne@linux.ibm.com, mjrosato@linux.ibm.com, zycai@linux.ibm.com
Date: Fri, 08 May 2026 12:53:22 -0400
In-Reply-To: <20260504221613.826825-2-jrossi@linux.ibm.com>
References: <20260504221613.826825-1-jrossi@linux.ibm.com>
 <20260504221613.826825-2-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE2NiBTYWx0ZWRfX7BUtxiEg19r+
 1N9JZoiUJM5/DCcWrsvANYXKMVs1hPtb3DhKaiFXT4/pwqpEU/K/HABupdHo6VP5bX3LwX2j+LU
 Me0Haw1QuisCoD+TGJ23uPMM6S/nAp4GYqy60dST6HIxpCrh69MvO3AVvsH3yBuAbosItoMqHQd
 V0ut4BDTdr2lUwInVLZh39W1Uctpnkb0uEOnqP02Z1FWvI3GSqWzgaZQVpqjzI9aAZDjdcRAvgJ
 OCSeTd6iyT33RhARq1kBo+JeSKo/4PpXhdtpVx2+FuEUFTSuJ4cmsvkmchinLVcDKrYgaQKyEw1
 AZYdPeBivHEc33/IAoLG/ov9UTipQqvK01IjrM8H4e3CCJhjHWkgDKxwsTf37i5Sj5R0wjDDdKv
 rJ9UP3/OSHY6X7RgSGhPC0BHoF7nbpf8jK0IVq6ysn9Q1KlbhmMd62GidyBIx9VbTq5xEftYzFG
 lokIg4BiEne6xgE6NDQ==
X-Proofpoint-GUID: vjlh9olDiukuR8db2LWguhs3YxGU_M18
X-Proofpoint-ORIG-GUID: vjlh9olDiukuR8db2LWguhs3YxGU_M18
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69fe1505 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=ApcgM9WvzdXaAz7lgx8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080166
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 2026-05-04 at 18:16 -0400, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
>=20
> As IPL support is being added for some PCI devices it is necessary to spe=
cify
> the bus type of the SCSI controller when booting from a SCSI device.  The=
refore
> the IPL type S390_IPL_TYPE_QEMU_SCSI is changed to to S390_IPL_TYPE_CCW_S=
CSI.
>=20
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  hw/s390x/ipl.c                   | 14 +++++++-------
>  hw/s390x/ipl.h                   |  2 +-
>  include/hw/s390x/ipl/qipl.h      |  8 ++++----
>  pc-bios/s390-ccw/jump2ipl.c      |  4 ++--
>  pc-bios/s390-ccw/main.c          | 16 ++++++++--------
>  pc-bios/s390-ccw/virtio-blkdev.c |  2 +-
>  pc-bios/s390-ccw/virtio.c        | 12 ++++++------
>  target/s390x/diag.c              |  2 +-
>  8 files changed, 30 insertions(+), 30 deletions(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

