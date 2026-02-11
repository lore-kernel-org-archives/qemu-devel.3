Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FD8EB5969
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 05:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq2nz-0001Yi-92; Wed, 11 Feb 2026 00:30:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vq2nu-0001Xs-G2; Wed, 11 Feb 2026 00:30:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vq2ns-0007DC-Go; Wed, 11 Feb 2026 00:30:22 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61AN1LB1369791; Wed, 11 Feb 2026 05:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cQmbyb
 qY7/C2XPrAp1gm/18Cr0unDXohlP0lV0QL/WQ=; b=QT5AV4Yk1Vbz5lu8cfeRPX
 8NZefX4YGFzwWCa7luRTFWGRbEE4xBmFlV1A0JgnnYlz+UjA1e3+8nvbZ+RrUJGK
 J+R6yXwd3r5GNI1ntCS34Blf//jadryliF3lImb47uVoU7bQxMBW+US6D1wVXRgv
 +56tZw6Gm5b6T3JSmmzhky3REdqhBNf9nh7HvqzYjJ8Zv1aD9Kl2sIwBy1qJ32qh
 bAPIIIrOsJWHecRNvb0PrLXWwbPo9ifBigQrJOd0ms3xfhQNdEOBkHfxXV5q4J71
 iHbCE4cOyfKiEWm181GOlC09e1ADE/PLCgm0nFeDNYiPsiucG1ihzGFyEDc8PlFQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696wwbum-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Feb 2026 05:30:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61B5F4TL012616;
 Wed, 11 Feb 2026 05:30:09 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6h7kce3w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Feb 2026 05:30:09 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61B5U9ut8848070
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Feb 2026 05:30:09 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DBE758051;
 Wed, 11 Feb 2026 05:30:09 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 594795805A;
 Wed, 11 Feb 2026 05:30:05 +0000 (GMT)
Received: from [9.61.251.100] (unknown [9.61.251.100])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 11 Feb 2026 05:30:05 +0000 (GMT)
Message-ID: <d697fff6-23e8-4e9a-93ec-949a78eacf52@linux.vnet.ibm.com>
Date: Wed, 11 Feb 2026 11:00:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] : pnv/phb4: Update PHB4 to the latest PHB5 spec
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com
References: <20251230102156.886288-1-saif.abrar@linux.vnet.ibm.com>
 <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260210084319-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
In-Reply-To: <20260210084319-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=WZYBqkhX c=1 sm=1 tr=0 ts=698c13e2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=mDV3o1hIAAAA:8
 a=2uh124viathmZvQnMIoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EkUNVW0KQh9zN8lQpcmIIdnsOv7PdevG
X-Proofpoint-ORIG-GUID: iJ_CjpWxsbEAvo1kQCA4RfEs5jWCE904
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA0MCBTYWx0ZWRfX+5WYHp6bIg5m
 IyHdqxG6Mr5Fk+EuBTuHk08LTMWf1xLj41JdKDNEqTVpY1ZqaL7jlMd7IoirPisaiR++hEwd40R
 ROqjyciuMk7PHJjkf5JfrhHDNCa6579SGNyQCFAx+XqBDKH31vM+QIFu7DAi2QAFfYeDZw7lJhI
 JADuPTRAqR2qDa7iBNqL8RR0C8YiDOYN5jcrq9Df39o98W05rmgAjhzej3kpofwccd/uZQ6fa/n
 10uIRK/cWk/syjz8Riy/lV+j9Xfyrx6g7RlTJ2sSJi+zyiDhzBOvgrljUfpkqVWdThaXH1ob4vJ
 9HOGMuTfSP7GQytEPWhBX11fDbQhi5UEuN/VfYNtsu8jun/FvjSrbAdrxA8wlnOkuELKM4aBUsa
 aJ+bD12biLYfSr58nOO6bkoeqHZ/ZllpQbTXBec9f5qWw5s5CUB8Izuk85KRxlk4emJqZQ0mNVJ
 NZRB46Sq3W95UPf6n6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110040
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 10-02-2026 07:13 pm, Michael S. Tsirkin wrote:
> On Tue, Feb 10, 2026 at 07:40:50AM -0600, Saif Abrar wrote:
>> Hello,
>>
>> Addressing the review comments for the series v2:
>> https://lists.gnu.org/archive/html/qemu-devel/2025-12/msg03768.html
> pls include a detailed changelog.
> No one wants to plough through all of it on each revision.

Please see individual patches for the detailed changelogs.
Each patch has its own changelog mentioned therein.

>> This series updates the existing PHB4 model to the latest spec:
>> "Power Systems Host Bridge 5 (PHB5) Functional Specification Version 0.5_00".
>>
>> Updates include the following:
>> - implemented sticky reset logic
>> - implemented read-only, write-only, W1C and WxC logic
>> - return all 1's on read to unimplemented registers
>> - update PCIE registers for link status, speed and width
>> - implement IODA PCT debug table without any functionality
>> - update LSI Source-ID register based on small/big PHB number of interrupts
>>
>> Also, a new testbench for PHB4 model is added that does XSCOM read/writes
>> to various registers of interest and verifies the values.
>>
>> Regards.
>>
>> Saif Abrar (9):
>>    qtest/phb4: Add testbench for PHB4
>>    pnv/phb4: Add reset logic to PHB4
>>    pnv/phb4: Implement sticky reset logic in PHB4
>>    pnv/phb4: Implement read-only and write-only bits of registers
>>    pnv/phb4: Implement write-clear and return 1's on unimplemented reg read
>>    pnv/phb4: Set link-active status in HPSTAT and LMR registers
>>    pnv/phb4: Set link speed and width in the DLP training control register
>>    pnv/phb4: Implement IODA PCT table
>>    pnv/phb4: Mask off LSI Source-ID based on number of interrupts
>>
>>   hw/pci-host/pnv_phb.c               |   1 +
>>   hw/pci-host/pnv_phb4.c              | 583 +++++++++++++++++++++++++---
>>   include/hw/pci-host/pnv_phb4.h      |  16 +-
>>   include/hw/pci-host/pnv_phb4_regs.h |  66 +++-
>>   tests/qtest/meson.build             |   1 +
>>   tests/qtest/pnv-phb4-test.c         | 228 +++++++++++
>>   6 files changed, 837 insertions(+), 58 deletions(-)
>>   create mode 100644 tests/qtest/pnv-phb4-test.c
>>
>> -- 
>> 2.47.3

