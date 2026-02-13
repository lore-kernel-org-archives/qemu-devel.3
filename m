Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022CAEDF176
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 15:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqvK3-0000E1-5h; Fri, 13 Feb 2026 10:43:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1vqvK1-0000Df-3T
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:43:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1vqvJz-0006Mz-Er
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:43:08 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61DEPef72420123; Fri, 13 Feb 2026 15:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=huUTJg
 KQrTabGo88SZghjmv0RFQENjGKTNvEdWLlNA8=; b=RxGZjC2LnLgsUxib2pC6Lr
 5U1EwA/Nw02uVshZXIZeb3yc9i2s2LD5K9SGPtSO5OeS1MspntzBtA68M2yT/pJj
 9AlSn3OPGSmlW7pplSvOW7QJ+8HEyd5sWrOSiHV9bKXU6utg2HRJAj87wQtIqg3x
 m7e8756gV6eOjaVK/MgSOphET17vjs/BotHnUyTd37R4/ViN7uVk+VWV2BjJbNCc
 AbUH+cpGmS7AtuXiIXQ/81eKUmtymE+bk9ger5Ysw0C9WON9mDhW4A3ggf8zgLH1
 TWLFEQao2Mg5O6IbQrCRnkzxwn9zHhcVl8C0q3RiMqXmNyAod+l4aXqNU6nYeGDg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696wkpxj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 15:43:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61DE3SFI013013;
 Fri, 13 Feb 2026 15:43:04 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6h7kq7rd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 15:43:04 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61DFghnN56164748
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Feb 2026 15:42:43 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF5A35805E;
 Fri, 13 Feb 2026 15:43:03 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77A4558055;
 Fri, 13 Feb 2026 15:43:03 +0000 (GMT)
Received: from [9.61.24.3] (unknown [9.61.24.3])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Feb 2026 15:43:03 +0000 (GMT)
Message-ID: <92e37f70-a2b3-465e-8712-36034fc12dce@linux.ibm.com>
Date: Fri, 13 Feb 2026 10:43:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] hw/vfio: What is the best way to detect start of vfio
 device migration
To: Alex Williamson <alex@shazbot.org>
Cc: qemu-devel@nongnu.org
References: <72283828-6d7e-4c80-ba24-8c114c8d052d@linux.ibm.com>
 <20260212095804.3ad5b4a4@shazbot.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260212095804.3ad5b4a4@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YeCwJgRf c=1 sm=1 tr=0 ts=698f4689 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=n4C5IOH4TsmGSRh6:21 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VnNF1IyMAAAA:8 a=xpTFYaawLdgd9gg7ORIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: j7k3FaJZ4IJ5HWUuxuGUXiw_VQBk85jT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDExOSBTYWx0ZWRfX0AJzJK2Hcgeh
 fjSQIyqwxv0gIO3iFzY7rOeko90/ONVCvS5NGnn21DQcpkMbPFMGu+PET4n84irWy+NmuLYY88G
 zc8OExPjnucCanPyZctCSfhkE1CsJa7UCoD7cbiCGw/NZBxcriAGGSkdRnWLZr9ZBR38t2CUJLC
 j8ziCtwFYRIFh4/jNQwSaRA8jzFwji1NPd51654wQey9AbIycyLsc/tEoL+CogIpGw/WsO2i6Bl
 6v7m6VQJFErs2Fx3RJWCmHjZroOz03DUs3/R8cN7z1CS5sBjfKmPHjIRzjuVJk6m0QlMOYoAIxD
 TCScY61Hpv8jEOAQVcCiLy98lCp+hzYtUVSSL8YSWNuyWDf+luoW0bPJjHKC7qOj6lPT7y6HgIU
 9DKu0GhGuaRojMXViJpeEsP4cREXEADYqj6vQGZXjyQbm2BMyLNZgTeCTttWkW9QoakJ7q+X91y
 2KlXlDX4Z+/6gDP94xw==
X-Proofpoint-ORIG-GUID: j7k3FaJZ4IJ5HWUuxuGUXiw_VQBk85jT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130119
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2/12/26 11:58 AM, Alex Williamson wrote:
> On Thu, 12 Feb 2026 10:45:47 -0500
> Anthony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> I created a sysfs attribute for a mediated device to enable/block migration
>> of the associated VFIODevice in QEMU. When the sysfs attribute is changed,
>> an eventfd is signaled to QEMU to enable or block migration. In response,
>> QEMU adds a migration blocker to the VFIODevice object and sets it's
>> 'enable_migration' field to 'ON_OFF_AUTO_OFF'.
> If some userspace entity has an inclination to block migration, why
> wouldn't it just coordinate with the VM orchestration tools rather than
> take this inherently racy and vfio specific path of the device
> signaling up through QEMU?  Thanks,
>
> Alex

Hi Alex, thanks for the response. I have never used a VM orchestration
tool, so I have no idea how this would, or even if it would accomplish
what I need. What I need is to prevent migration while changes to
the source and destination devices passed through to the guest
are made, without having to terminate the guests. These changes
can only be made while the devices are online and must be
synchronized, so they cannot occur during a migration, so I need
a way for a sysadmin to dynamically prevent migration while this
synchronization is completed.



