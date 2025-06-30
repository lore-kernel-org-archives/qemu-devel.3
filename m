Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448CEC83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 17:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWHzJ-0006bm-8R; Mon, 30 Jun 2025 13:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1uWHzE-0006ah-5K; Mon, 30 Jun 2025 13:08:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1uWHz4-0002jX-ON; Mon, 30 Jun 2025 13:08:03 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UBxQET032398;
 Mon, 30 Jun 2025 17:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sEcXwc
 z1pz3X8R1QJyzlEUyqaH76dVX3YJ6vCni8G4w=; b=aske7w3j1SLwpsjUzSQAnu
 r5RXIlHr4aY7BTbzqoICcBpXYEYN9wYiPxXJ6Exf3u6BfEUigW+/V1qKJDzUPCSI
 TGneu6mx0a3oDPhBwMyBfe3msLzVTAJpDLzrbSwhZ6OSp9WgmSUypgnDjnySnr6A
 jIE77iKXNckakdkcPf2rBPbIyBX7MzrCjApXGEn0Ol+mFvM3g2jV0DeoZ5qyDGvl
 uQIksPB0CFutrVpR5YUihJ9fNcCmdC1vqLty0GxS27MStSlRPIQ1Vbq9chlPf0gn
 lAZ47L30KLgkF9+z0fPXQyepON0Vh3k2Ub8LRI84qVEcJYLpE33hZHB3vL3q5khA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84d2r1f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Jun 2025 17:07:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55UEtIij006835;
 Mon, 30 Jun 2025 17:07:53 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jvxm6md8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Jun 2025 17:07:53 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55UH7q6327329212
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Jun 2025 17:07:52 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70E0458054;
 Mon, 30 Jun 2025 17:07:52 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C91858052;
 Mon, 30 Jun 2025 17:07:51 +0000 (GMT)
Received: from [9.61.135.168] (unknown [9.61.135.168])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 30 Jun 2025 17:07:50 +0000 (GMT)
Message-ID: <e4a4426c-c524-4faf-b1e4-6b66bbfc29cd@linux.ibm.com>
Date: Mon, 30 Jun 2025 13:07:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v13 4/4] s390: implementing CHSC SEI for AP config
 change
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, clg@redhat.com
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250609164418.17585-1-rreyes@linux.ibm.com>
 <20250609164418.17585-5-rreyes@linux.ibm.com>
 <5c6f7f80-cfa3-432f-9ff3-ae57f8b4cf5a@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <5c6f7f80-cfa3-432f-9ff3-ae57f8b4cf5a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bNOZb12jvLA-n2FxtlooPLqHLuPHMMCq
X-Proofpoint-GUID: bNOZb12jvLA-n2FxtlooPLqHLuPHMMCq
X-Authority-Analysis: v=2.4 cv=Ib6HWXqa c=1 sm=1 tr=0 ts=6862c46a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=vGrOW3-fzNPHAIPYim4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDEzOCBTYWx0ZWRfX8D4eZMEAcPLU
 4Rs60lgHs0URuI4hR02RxOcY+O6eKw+UjJ+Ya66l5MDZiJRVON13N3Wl9mMSLzt7hS/JiKeR7Dz
 WNXx6SdmKx52mrKBGZxO2QtFFmZp4w6O6BmkSC/ZUPqHOsAYi4uPIgbXuLdrrOigD8CABkr6bV+
 yXFQC4r8YypLWh448jmkL0d1pkywF3C5W6EImEi9UTaTuj0CIn1UFa1UUkE4nVGe53dCWMvglgD
 LUol0VRQKEfYt2KxPbxQF5f9/qOFA1RWqKbj75o/v46QUXrvAvHdza+0+4wP0iEb1uuBLulN7OP
 wVGrKVrUgmjLvV6RFoq98qRFOlT3JMzWR4vHm0UiiKcKJ3Pk5Jr828ZShhPYBxfX/93ob2m+h+o
 W/zCneytb5FTuQHVRxqdmuIeDwYa4uRPdOAbB8thrKVwCSjZIhO/SHf+6qIwSzfT+AFQ3PSe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300138
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/26/25 12:19 PM, Matthew Rosato wrote:
> On 6/9/25 12:44 PM, Rorie Reyes wrote:
>> Handle interception of the CHSC SEI instruction for requests
>> indicating the guest's AP configuration has changed.
>>
>> If configuring --without-default-devices, hw/s390x/ap-stub.c
>> was created to handle such circumstance. Also added the
>> following to hw/s390x/meson.build if CONFIG_VFIO_AP is
>> false, it will use the stub file.
>>
>> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
>> Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> 
> FYI, this patch (or some part of this series) breaks hotplug for PCI devices on s390x.  I verified it breaks with both PCI passthrough and virtio-pci via virsh attach-device.
> 

I was unaware of 639ff87a1a ("attribute constructor for cfg_chg_events_lock") which apparently was already sitting in vfio-next and merged to master the day after I reported this issue.

FWIW, 639ff87a1a resolves the issue by ensuring the mutex_init happens even if there is no vfio-ap device attached so long as vfio_ap is configured/built (and I like the use of the constructor).

I also now see the stub functions in hw/s390x/ap-stub.c that will be called if vfio_ap is not configured.

So: my concerns are resolved.  Thanks!

