Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986E9C5DF81
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 05:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy1BG-00068V-Ic; Sun, 23 Aug 2026 01:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wy1BC-00066L-Hf; Sun, 23 Aug 2026 01:55:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wy1BB-0001FV-0X; Sun, 23 Aug 2026 01:55:38 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67N4Vqlv2100003; Sun, 23 Aug 2026 05:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=xVuUon
 urQTrIDQ2gav4xcu3m/I3ALB/eBdV3bfjYwSM=; b=eFDKd1yld3FwPGX9Qk6pIv
 PhSiRMxULAKeoB414/UO6/MZnrUjVf3USCJ+XDu/GiQi0E9OZr+taPZklOF3E5v9
 uOnKzaigi6QdIhltQrW3x6y7vD3O2xzDg1u3AdObayTSFJC8XqG7xR3uNfZ8htKl
 6zJYkaA4mTtXAJNHKT0H/AcfpMUx3BXulVOvoBYxsMgtP7BW4R6QlJYLYye2fId3
 Fv+acnoHwULnwU9bozyD94jy3YiHz9DobodfcAnw/oG1zINJKg6cCDag29BpE+K9
 8mu6LPbY/7xG3Rh9xCpeN0/KAKtalPo2y3Z//CV2vLfK5RsGuiDkHFeVuwYqnlXg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hc4kx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Aug 2026 05:55:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67N5fsoF013872;
 Sun, 23 Aug 2026 05:55:34 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3prqhh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Aug 2026 05:55:34 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67N5tWOj59965702
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 23 Aug 2026 05:55:32 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 731515804B;
 Sun, 23 Aug 2026 05:55:32 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05CC158059;
 Sun, 23 Aug 2026 05:55:28 +0000 (GMT)
Received: from [9.39.19.238] (unknown [9.39.19.238])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 23 Aug 2026 05:55:27 +0000 (GMT)
Message-ID: <eb8f5972-e494-483a-b093-5d67f64f70f8@linux.ibm.com>
Date: Sun, 23 Aug 2026 11:25:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci-host/pnv_phb4: fix guest-triggerable abort on
 8-byte config access
To: adityag@linux.ibm.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,
 Nikhil Kumar Singh <nikhilks@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: qemu-stable@nongnu.org, npiggin@gmail.com, milesg@linux.ibm.com,
 Jishnu Warrier <jishnuvw@linux.ibm.com>
References: <20260805090530.1333997-1-nikhilks@linux.ibm.com>
 <501df67e-28d0-4630-b98a-769abb41086b@oss.qualcomm.com>
 <c21c72fc-672a-4674-a8d6-0b999502b4ad@linux.ibm.com>
 <19c3ff9e-6559-491d-a3f5-b1786db6b9da@oss.qualcomm.com>
Content-Language: en-GB
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <19c3ff9e-6559-491d-a3f5-b1786db6b9da@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIzMDA0OCBTYWx0ZWRfX6qXVTrD3+ZcM
 6orQSqQ/RP8fHkjM0bjvfvdBNBU2vjt88s/wUQtHoIeNkjY9S3F1Y5eBEgKG1W5broM1GbZTz11
 4akE2huflXCV8jahnYu3e23hZsBkLhc=
X-Proofpoint-GUID: 9SmFhNiUKFabJuHC3ckuER4AoFsiyOAv
X-Proofpoint-ORIG-GUID: b0YXDO7vQotfuDXH6qW9CTg1K6EeJKwF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIzMDA0OCBTYWx0ZWRfXyVZCoAlwX4y3
 3P2ba6C5tCc2HbUe/2uuQ3Us79NOqyw37liU89d6yl5dacZWFCOpJmZQ3N05zatiw61DwMlQno/
 vlbCa/CxunsBcdtIaNTyuRPDwMI44QvL9z3QRwl8u4840j5/2zC9qDuLkpF7dcaTDZuQPphG8/x
 qCH1TmG9rQ95zWnpJm0f/al7XQ2R+phel6yMZQFsdbkbKdlLLiM6nHgZH90PVqwpf8NfGawGxwY
 C/zKhcREIWsQRcts1p7q1wTIZk73lvnfwc78oGEOxuw2Z3TCZuONnVU/ENRrA1v6g/pdEGGXWBb
 wWe0wGF5LoJVHLS6Y+ruQMSwHkqmOvrn+gzI3qOqlpR0l4Lo61UipapB40iX0ozuaHxAJnZvt50
 jwsBFp0jrdVgQLbLrqLwhgAlz+MUb9Q/x7p+Wo8Kosp9ogV5p1aF+Cs47U0di+S6qhLTiN5VYMm
 Kg1oWZgTUsdq4A31sLw==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8a8b57 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=rZOK0zkt5JoHfpZkP_EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-23_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608230048
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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

+ Jishnu

Thanks Philippe for your inputs.

Hi Aditya,
Are we expecting a v2 or a follow-up patch here?
Needs your ack, thanks.

regards,
Harsh

On 05/08/26 9:23 pm, Philippe Mathieu-Daudé wrote:
> On 5/8/26 15:53, Nikhil Kumar Singh wrote:
>> Hi Philippe,
>>
>> Thanks for the review.
>>
>> 1. Regarding MIN(size, 4): I avoided this because silently truncating 
>> an 8-byte guest read to 4 bytes leaves the upper 32 bits 
>> unpredictable, which might mask guest OS bugs. Returning ~0ull 
>> explicitly matches standard PCI behaviour for invalid reads and is safer.
> 
> OK.
> 
>> 2. Regarding pci_host_data_le_ops: I agree this is the right way to 
>> handle it. However, PHB_CONFIG_DATA is currently interleaved inside 
>> the larger big-endian PHB4 MMIO region. Moving it to generic little- 
>> endian ops requires a memory region refactor using overlays.
> 
> Yeah, "if it ain't broke, don’t fix it", so let's keep maintaining
> something old and different.
> 
>> Since this patch addresses an immediate DoS crash, I kept the scope 
>> minimal.
> 
> OK, no objection to your patch, just my 2 cents ;)
> 
>> Memory region refactoring can be picked up as a separate follow-up patch.
>>
>> Regards,
>> ~ Nikhil
>>
> 


