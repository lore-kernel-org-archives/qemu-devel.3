Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A8ECD98C6
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXMLU-0002Ss-T9; Wed, 10 Jun 2026 13:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wXMLS-0002SN-PR; Wed, 10 Jun 2026 13:04:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wXMLR-0007qo-8v; Wed, 10 Jun 2026 13:04:02 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65A55Hl73408398; Wed, 10 Jun 2026 17:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Sp6YjH
 84dVEswKJPeWf+N2eAB185rjguOZ15NcVo814=; b=NRRr/WQ62nRypBeZx5GIgX
 WnMeyjErrgrySHYRXwVnGooT2ldtTaf9Am7qqMBuopKtq1jFgGGNd8lcE0HqNkFb
 c642mZG3ZUNZMSJlOj4HV8245b2fLN7KahKli8Ksp0c5uGHe9IsOo5Twd7AQosM2
 XCbFRHSkeCDkfgfVOm1sXavtUz6I8u98+0qy9E5Lym4FWHOXEcZEK08dYwdWudWh
 ywgC2AewoQp+CgWJB9aR2ZCHv2fh8YPTNdRZ2jFLZ4+ZX2jop8oNbI+Np19/ZYDK
 Lwc2DppHbjpXWVRD2atVP7kPTFOXGewQKXHPThl5YJJ7Ps6BJzR3a1ajFqH5+osQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yj1ysg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2026 17:03:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AGnefk010824;
 Wed, 10 Jun 2026 17:03:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq7r4p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2026 17:03:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65AH3sam31588616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jun 2026 17:03:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1508420063;
 Wed, 10 Jun 2026 17:03:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 189F82004E;
 Wed, 10 Jun 2026 17:03:51 +0000 (GMT)
Received: from [9.39.29.179] (unknown [9.39.29.179])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 10 Jun 2026 17:03:50 +0000 (GMT)
Message-ID: <0dc91b46-a643-4e2f-b452-59ee2ec49ded@linux.ibm.com>
Date: Wed, 10 Jun 2026 22:33:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ppc/spapr: make fadump collect regs for maxcpus
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: anushree.mathur@linux.vnet.ibm.com, harshpb@linux.ibm.com,
 mahesh@linux.ibm.com, sourabhjain@linux.ibm.com
References: <20260429065127.366813-1-shivangu@linux.ibm.com>
 <20260520092857.1079193-1-shivangu@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20260520092857.1079193-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE1NiBTYWx0ZWRfX/clq/GmV631C
 8pyBCoUaEpQ/qNjtbWQl1Nhm90i+cSmb86mGZfgWsxMIu436eFMpI9pTBJ9+lG2XrfGDUimpYfd
 yGakNpiiy1MnCmLSXrsKS1TfzfWNPWRag8jRQAwIQ115sIcDCVEsM26UXD2H266YGH1ArUddgPn
 ZEzlOM5Vk6jhMvvC/aWF4hs2cwYg9n9DGLBIDBNhdAcvYrlKV1c08jUWv9EHoofD7mQNtq0NSeJ
 5aLQcR1zW0cTalaaH2uM/1XqwX5/A0eCoa0gVBACIx93lo7+B9NPyNbij5nuEA4rA3pyIrlvdWN
 aV5exxYRvfJFAYocNa/M56eWqTs1i4B1Fff2ChAJs3RbQrOdoiJfSrihmqnOd+cI7wNWBFr3MUK
 a33pI5sNCq8nOQC1W35U7UpEQh8dsX7UtM9170XpmKCzKtolakcwXP9nkN1sIKPG2rZx7qonADF
 GWNHxfg4hQIiL26k7nA==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a2998ff cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=fcUNh9kyHpcDjGgfmsAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6yNCBLURTj1rYWZhdIpFw6nFhznt946F
X-Proofpoint-GUID: 6yNCBLURTj1rYWZhdIpFw6nFhznt946F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100156
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 20/05/26 14:58, Shivang Upadhyay wrote:

> When a ppc machine is started with maxcpus greater than the number > of present CPUs (e.g., -smp cpus=2,maxcpus=8), firmware allocates > 
the CPU state data buffer based on maxcpus and advertises this size > to 
the kernel during fadump registration. > > However, fadump currently 
fails to generate a vmcore during the > rebooted kernel because: > > 1. 
The CPU state buffer length does not match what firmware > advertised 
(QEMU only populates entries for present CPUs, not > maxcpus) > 2. The 
kernel cannot find CPU data for all maxcpus slots
Hello Shivang, same thing from our discussion offline, can you see if this
fix belongs in the kernel instead of qemu ?

PAPR (section H.1) states:

> Only CPUs that are online at the start of the Firmware Assisted Dump > will have their register data saved.
QEMU's implementation is aligned with PAPR.
The PAPR doesn't say anything about the offline CPUs, so that may be
considered as undefined.
Let's see if it's an assumption from kernel side, and if it's possible to be
fixed there, else if we will take this patch in qemu.

Thanks,
- Aditya G


