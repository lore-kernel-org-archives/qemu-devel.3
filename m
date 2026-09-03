Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1E3C624DA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2CoO-00063t-MG; Thu, 03 Sep 2026 15:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1x2CoK-0005zu-Ca; Thu, 03 Sep 2026 15:09:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1x2CoG-0004zs-Fs; Thu, 03 Sep 2026 15:09:18 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G2RMo3425260; Thu, 3 Sep 2026 19:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=7VmwPH
 xTi3Al0+nraokWVbQxnt3BMtciJ1M3/Tp0Ppw=; b=D4gwgY8ksHDrZu1N63wVIb
 bf5qzShUTLrq95N8otM7G+Zh0oRAJ2G6SEuvH97e3CQbLfK7s52BKN1FaaZ8N7yZ
 92TeKSQLRiBGOLJQ+Iy9buAKOmaad6/Ds0DwafNmE7Lo1gDS5+i/iXOtJYqgdVve
 TdDSX4eIiMlGew903o9v+OkMdtaPi/lcpqycGBiw8MjYmgqRGwnjuMpSKNnRlwyd
 fNTmT82cm/ytXaUN6MQNyRq20TfTi7f8pmN5SZsHSjfy9yua1rSB7unXK7RknOQl
 u3wF223uDZGsIrJ//ho349NFmQhlMpi/N/2yREf8dkDEp0nBz6BxZJ6y8wUQFHtg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5xmfw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 19:09:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683IuOGT019121;
 Thu, 3 Sep 2026 19:09:13 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjasgm2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 19:09:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 683J9CEf31785488
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2026 19:09:12 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29D0558051;
 Thu,  3 Sep 2026 19:09:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACD715805A;
 Thu,  3 Sep 2026 19:09:11 +0000 (GMT)
Received: from [9.61.21.65] (unknown [9.61.21.65])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Sep 2026 19:09:11 +0000 (GMT)
Message-ID: <177dbb13-b70c-4879-96f1-d6f32677e06a@linux.ibm.com>
Date: Thu, 3 Sep 2026 15:07:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] s390x: Find scsi-pci boot device and build IPLB
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, zycai@linux.ibm.com
References: <20260831194919.3830270-1-jrossi@linux.ibm.com>
 <20260831194919.3830270-8-jrossi@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260831194919.3830270-8-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a99c5da cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=kxJs7cjikYy-4yQhQJIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rfxWVqWkixgoKW4ltrtpowYVTGM7h6Qz
X-Proofpoint-ORIG-GUID: rfxWVqWkixgoKW4ltrtpowYVTGM7h6Qz
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2NiBTYWx0ZWRfXzdZUM/EXcAze
 QdFf4aQ0v+qRpq0Luk3rd37QxHrc2Oo9W6WURZe1Brc1HSzqpNrxz+XkE4o7FTaFmu9x2VpQrzs
 uFfeuLPeP0sLGiKY1FKcBeVM2LcfgRI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2NiBTYWx0ZWRfX8dqcS2JPDpUj
 HM8sVXX4p8Ak/YYM+z39j1TLWPhK3XMEy0sdl8AqZ1RQUHS3GlIP+jSpNqv4eksHUEoucmpJVYk
 Be1CtaJNpHA/QUN0AIoktgXSflTPGmshME/Vha3zrDqWB2zCz47rf7BdxsnTmHvktBxvZhOmlmw
 N2RgCQfss9ONhamQD1XaO8I+HBLYYm2/TKsWFE53jTggW3Og4pCkTlx2rL1tqUnj8fDeA6L87n/
 cB0bL9MllfItblxm67z3FxPAoS356o9VKJvOP3wb7ymdIHm/NayynHuSJ7Oxgm81P6eSN3SILDf
 +2d3e9VaUh7djUWj4SbzJrt3F1se/T6z1/EIFRLKt3Cfscs2+kh5qOVOCMljqmgxFA40x1dQ+/m
 H+fxN+wPWfhDH3gjE/LLAZC3ZAdk1+z1hOqX6bmf7/44kb6hYBoRM91zUp4IL04NLq/83n286An
 J0wlkvvB/ctKnI4nJoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030166
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jjherne@linux.ibm.com;
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

On 8/31/26 3:49 PM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Add logic to identify a virtio-pci scsi controller and target lun with
> assigned bootindex, then build IPLB for it.
> 
> Unfence PCI case for scsi devices in BIOS.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   hw/s390x/ipl.c          | 37 +++++++++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/main.c |  3 +++
>   2 files changed, 40 insertions(+)
lgtm
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>

