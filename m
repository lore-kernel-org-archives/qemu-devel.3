Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D7EC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 02:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf6lj-0007wQ-Rl; Wed, 01 Jul 2026 22:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wf6li-0007wC-OK; Wed, 01 Jul 2026 22:03:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wf6lh-0001Zj-8q; Wed, 01 Jul 2026 22:03:10 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621KJ8A2450358; Thu, 2 Jul 2026 02:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ts5TJE
 qobOn1hEsf55RqVVIez8f/Oi7AOSoWYwpClwY=; b=XxnfyyM8lnCIxrFn8Sd+Cc
 oEXj7rX2Q+bsPH5Hy8DRskPTl+venkO22xKyyWXwfFORGTYSsnF1aPa/Ns2VKA/T
 aJszpvgehBkS8htaefyAlNhLfyKSg9qCxcehUbOMW6904CV6axgmXhoU7jtbM0qc
 4PUWWdQLQTL7f6X9Dq4MQflFSR2cLYmrFM32LW6+3Mm3N7d4ceMmZf86hUnVPk/C
 TV1Nj1yOkaRWNjAcO9n6cAUcQMWqGPNY0bUBelrqPCxgqnsM9gZM0AcuCykw4wCW
 CvPbL2o/V/F3glPLD/C5ksgW2+GCakHl/96ueJRL7Akj9SKs9bNnV8f6/ptAPEUQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5ymgq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 02:03:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6621nd9w021439;
 Thu, 2 Jul 2026 02:03:06 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhhwwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 02:03:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 662234ZV14418574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 02:03:05 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC71258060;
 Thu,  2 Jul 2026 02:03:04 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7A3D58055;
 Thu,  2 Jul 2026 02:03:03 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.136.69]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 02:03:03 +0000 (GMT)
Message-ID: <c0e2bd2e7c2759b4e7e2b0a9e3e8ee046a188ea9.camel@linux.ibm.com>
Subject: Re: [PATCH v2 4/6] pc-bios/s390-ccw: Verify virtio support when
 booting from virtio PCI device on s390x
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: zycai@linux.ibm.com, jdaley@linux.ibm.com, jjherne@linux.ibm.com,
 nrb@linux.ibm.com
Date: Wed, 01 Jul 2026 22:03:03 -0400
In-Reply-To: <20260630141917.673995-5-jrossi@linux.ibm.com>
References: <20260630141917.673995-1-jrossi@linux.ibm.com>
 <20260630141917.673995-5-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxNiBTYWx0ZWRfX6PMHjK+ClskZ
 lBFOLde/fwI9Y7cjHQO17Bmmpn3hEgVlDPg5qL9e48qdlEdXI2uxVho4JYNxF0KdCJes8DhFfos
 TGt9Q9Ei009yxhCz6fJEwYBw0tjHPmEGCWfsUcw7togl3lyTm/r7r4D+MUVYxoe/sXs8sX6M7/0
 EnC4W0Bb5aPFrt4kBbhpP9vh5NJhx2Wyjqnlxc4IJrDKt+D5ed4ejFqC6PhFCRAYJSTQsVUHA1k
 7LS6nZ3DHT8BbXcV1eDu6eRTmxZIsuMfkMyK1xJa1edBRYnchUpOrrfMoWzfYTVI/aMn2sRiDED
 LS2OXVuW6xCdlPptptiueTRq2pMMLPFJ4nEar7x1RZjAHV3hPYXlWHlFBAsMZAOtpuVxGUZiFyV
 pWIb3ojNQ47NNyGi1dOhSI0UIquXUqsSDlSfacTY9lEcs/aIDRvHSXqzyHqvLFF/kSZiZ0gqxRW
 sy5mTgMjdXwIZbYXKgA==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a45c6db cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=UJnXFHHSjimePnNXT_MA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: 1wcqVS7amHB6XLGQX0b0anYtLS0XTSBP
X-Proofpoint-GUID: 1wcqVS7amHB6XLGQX0b0anYtLS0XTSBP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxNiBTYWx0ZWRfXwcnMDoa9qvJi
 5mmxrwn6XMVCTS/suPrcCfhnmb2Z1MIzjHiW31xvJd1ZC6y4wR0eZPZr4zQOLWO3zkA4ATd+lxX
 SRQFV6XcFTNx1qAvmKVMVGZhO7L05zw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020016
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

On Tue, 2026-06-30 at 10:19 -0400, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
>=20
> The virtio specification requires that each PCI device has a vendor ID of
> 0x1af4.  Verify this value before continuing with boot process.
>=20
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/main.c       |  1 +
>  pc-bios/s390-ccw/virtio-pci.c | 19 +++++++++++++++++++
>  pc-bios/s390-ccw/virtio-pci.h |  3 +++
>  pc-bios/s390-ccw/virtio.c     |  2 ++
>  pc-bios/s390-ccw/virtio.h     |  1 +
>  5 files changed, 26 insertions(+)

Looks nice.

Reviewed-by: Eric Farman <farman@linux.ibm.com>

