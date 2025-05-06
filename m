Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0864DC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 13:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCI6N-0005rK-1w; Tue, 06 May 2025 09:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uCI6K-0005qi-Ed; Tue, 06 May 2025 09:12:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uCI6I-0005gP-GW; Tue, 06 May 2025 09:12:48 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546BOa1m014054;
 Tue, 6 May 2025 13:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0grfUi
 GOmGFBi1b73JI6frIbEWhSsOcfr0G3U61O4JE=; b=QH2xiIwNiNbx/WEJRe7Ke5
 x+E6V0hUaypbtWUchxIZ5IAJltpJ1LQQErZpoYDI8YfxvlDeWCjLe3tbevoe7cUw
 l42KPKr1y/zaFDACQx5RJd0okXOUyMR4LIjUCHuV2S8btPCwa4zn+WMsHOvbDEVH
 RTJoJUAYnwYrY/4Y3tDnFj17vden3pNdpTWaZASoeb+LEHxHL2UG8iYe2aCZPlxQ
 RtbAE9es1BQ73HBdyfcr5sie1z4x80xbVRL4lcQG0KLgrpt5tebfTbxRuTxOtJnC
 tNw85PpKwhT7ivbdC/D/CdPBhIGN6AKCbhmKfzCOg17uxu3yxAB7UOFvmePYel1Q
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46f5fw39jf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 May 2025 13:12:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 546CJNNt004235;
 Tue, 6 May 2025 13:12:41 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46fjb206er-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 May 2025 13:12:41 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 546DCeVW33096356
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 May 2025 13:12:40 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26D765805B;
 Tue,  6 May 2025 13:12:40 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31E1B5805C;
 Tue,  6 May 2025 13:12:39 +0000 (GMT)
Received: from [9.61.243.11] (unknown [9.61.243.11])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 May 2025 13:12:39 +0000 (GMT)
Message-ID: <262dfdc3-0f8c-4ff0-88e7-4c08cf134233@linux.ibm.com>
Date: Tue, 6 May 2025 09:12:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] Report vfio-ap configuration changes
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250425052401.8287-1-rreyes@linux.ibm.com>
 <e35561c9-f104-4be0-8bf4-cae726118028@redhat.com>
 <172a4e60-8c3e-4c02-98b2-2f4a1fcfae17@redhat.com>
Content-Language: en-US
From: Rorie Reyes <rreyes@linux.ibm.com>
In-Reply-To: <172a4e60-8c3e-4c02-98b2-2f4a1fcfae17@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDEyNiBTYWx0ZWRfX5fZUSgh2Vhoz
 E+GOEl4YpadfDoyzK01Qeo/2R8VyowHB7mo77kfvINjfal35xsIWaeS5fzBLwm1JIuo2FSkOUaz
 S4DfJvjHFfaglVR3bO/7zNbakulMgxINN0EtJaMDEMZIiCtDkfudIDhMwTfQGKV5ypAY1U1r+w5
 Qp0d+Q0OOyO9h/Vyyw/EFikzWRONAecPwupMHU4WnevgjDSNR6VDWKWbJN6OuHRYuWvG/vl8eeE
 8pFpZYL6gN6omPUYZanyFKfDyBHlqYPcXUbRMf4VjVTHcR0MlTjtX98hHpDBUBP9L3Tk/TIlvto
 rg0o3xkA+/51+qFFrl+FnbbG7GeOFvMK/DythF2XSxklPrXr1ujRqDs7pryOMGXAI57O+WhlyTY
 DrH9+ZdQCrg8SNReNiJcF71TVUvlV2Ia5b8u4WaN7oaOK7Lh9Suhx1iYobjbqVNfW1uFO0r6
X-Proofpoint-ORIG-GUID: uJo_GS6AD3-yVQZAfdxYfxSTLHUyVSME
X-Proofpoint-GUID: uJo_GS6AD3-yVQZAfdxYfxSTLHUyVSME
X-Authority-Analysis: v=2.4 cv=IaaHWXqa c=1 sm=1 tr=0 ts=681a0aca cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=4tGXwOiPxwkLvBoLXisA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_06,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060126
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On 5/6/25 3:00 AM, Cédric Le Goater wrote:
> On 4/28/25 23:29, Cédric Le Goater wrote:
>> On 4/25/25 07:23, Rorie Reyes wrote:
>>> Changelog:
>>> v7:
>>> - Dropped initial commit for linux-header file vfio.h since I 
>>> created two new commits
>>> to address the changes made in v6
>>> - Moved patches 6 and 7 to the beginning of the series after 
>>> dropping the first patch
>>>     - Because I dropped the initial commit for linux-header file 
>>> vfio.h, I had to add
>>> VFIO_AP_CFG_CHG_IRQ_INDEX
>>> - Resyncing latest to v6.15-rc3
>>> - Still need Thomas Huth's review of v5 changes for patch 6/6
>>
>> I checked the build without default devices.
>>
>> Applied to vfio-next.
>
> I kept patch 1,2 in vfio-next and dropped 3-6 because of the build break.
>
> C.
>
No problem. I'm currently working on a fix for the windows build fail

