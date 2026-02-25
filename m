Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD34FFCEE8D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 11:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvDE4-0006yt-4G; Wed, 25 Feb 2026 06:38:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <siddhi.katage@oracle.com>)
 id 1vvDE1-0006y7-P4
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:38:42 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <siddhi.katage@oracle.com>)
 id 1vvDDz-0008K6-9N
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:38:41 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61P9kKKn4019509; Wed, 25 Feb 2026 11:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=QFpsK
 2V28xWECQEY6mL7tUetN6RK9PquLOLJJGmRp6o=; b=keco0kRAMTT7GOy/JVzrA
 Jr8K9M5kYZWQx1M4kgKrMoMu2SURYl/JnYEmY/EdInpEHkqOAo913dbZwRxVkFlf
 n8rvfw2Wo0cKmWXke7wv8VrMOfe4f+Xljt+RMTK56kkb6/t15MVbexhQU3aV2Xxr
 QNzjwP9gyRgVMLCzSfEHVCyE/SVhScvRWg5ULYXZ2mNVML63cDKWe/VlYnH9R+Ml
 V9QGINcE0h0gj38cuCknQlRsc2Ei2J/dvwLxdRJaCpUnDtjr/OZYrewH/r0gDxq9
 imYqzJC4s35sYpFXJhlBToBlJbPapWFKXG3GGTft/hw+QGKBDQ09L3i2/FVa2nYN
 A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3a062hf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Feb 2026 11:38:34 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 61PAhcb7027861; Wed, 25 Feb 2026 11:38:33 GMT
Received: from skatage-ol9.osdevelopmeniad.oraclevcn.com
 (skatage-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.50])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4cf35g0xec-1; Wed, 25 Feb 2026 11:38:33 +0000
From: Siddhi Katage <siddhi.katage@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, fam@euphon.net
Subject: Re: [PATCH 1/1] tests/functional: Add hotplug_scsi test to hotplug
 virtio-scsi disk
Date: Wed, 25 Feb 2026 11:36:15 +0000
Message-ID: <20260225113804.1919226-1-siddhi.katage@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210113135.771697-1-siddhi.katage@oracle.com>
References: <20260210113135.771697-1-siddhi.katage@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=570 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602250114
X-Authority-Analysis: v=2.4 cv=IskTsb/g c=1 sm=1 tr=0 ts=699edf3a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=9U_JvOwzwmrxwb6SCtoA:9 cc=ntf awl=host:12262
X-Proofpoint-ORIG-GUID: I7SxQQQoJMjMIV9bLd4TMApya_9qReJV
X-Proofpoint-GUID: I7SxQQQoJMjMIV9bLd4TMApya_9qReJV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDExNCBTYWx0ZWRfXwvJrz5asR82l
 MPESdgMdihqeN/mQ6LZcmbBmV406tLWHlbn3nl9f7AFpE9eN678f0GcWUfKbWvoI7BddPT3oMCF
 nfnTcpdItFZk2w6WnjqrCXt8mNSrKCBFSDXnRsbYAwPz2WB0wXMdB1ArbfphjEhwhx3bgFfK1D3
 WvxJyl5H9pCHAH//r/xAiBTMfci5x0iTydpwrngyK2V2Ny785wdophDxnTHhZiHDnDoRhLxeHJD
 XOQGKEc/ZUYyIHdOjYZpyJKoi9WNl17e+mRBZt3QXF1VvgjFsOYq1vfsjnXB/MnCiV7QPdafya7
 gXlJJpxj784+4Yezl3MHUHUmGZrDTllsHN3J0buX8OoViP5j/oZwQgQuxkIBrIOQgFEDjX/5Ct2
 UbAYa2nnZ9E3PczIHqGYUlPHZ5sOXpwJBCiOBUvYtiWr1D+bjH28aKwFKNj4lkenKfriNPtcjrn
 bb9GJ5JOxUl43pjnqc5gnepXCQ4slMYQgSRUukBw=
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=siddhi.katage@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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

Hi,

A gentle reminder to review this patch.


Thank you,
Siddhi.


