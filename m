Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D980C9EC76
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 11:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFzl-00089F-F8; Mon, 12 Jan 2026 06:22:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vfFzj-00088a-KT; Mon, 12 Jan 2026 06:21:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vfFzi-0000hy-6w; Mon, 12 Jan 2026 06:21:59 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60BJQdjH006734;
 Mon, 12 Jan 2026 11:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GOWZ5z
 J/94AYEr2M/a6Ci3KwqR5iN/OCh/wSGtQY8lM=; b=VWzLYBBxaerpJNkaK2JBRQ
 4wRpnnjQOm6mWxTxa98nT/Ag0QNovmFMW4XT80qEeTYV7ZlhWqPTkCnm88c/pidX
 dVGfjsAX+Dm0tLKMUHnj9odIEdHrFZt7BzF/Y7uHAAbLGP+BXs7dMjvtZevAaSZB
 sn5tXLi2gTaTSSGCJG2MuWB9xFNUPzdiFqfp8fQJwNaK0n6ik3hhlKW0LV0R2tXu
 wRUvOT8ixUHSQ74uHU/THw8IwHgzZoZPWMclaw9uxFn0G2k6rmT1Qx/vF9qqdKk3
 oXhO4gwsR9bn3oBVAbHPcSM4uK43RyBIKlwG6dsjUebcXJOdrWb8kZVVSrKVI66g
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkd6dxj9m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 11:21:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60CAMMef025835;
 Mon, 12 Jan 2026 11:21:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm2kk5gwf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 11:21:50 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60CBLnjg47907206
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Jan 2026 11:21:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F04FA20040;
 Mon, 12 Jan 2026 11:21:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99BFC20043;
 Mon, 12 Jan 2026 11:21:48 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.153.49])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Jan 2026 11:21:48 +0000 (GMT)
Message-ID: <ea6eeec1-3f38-4723-9799-e0746dc09496@linux.ibm.com>
Date: Mon, 12 Jan 2026 12:21:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] target/s390x: Fix infinite loop during replay
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
References: <20251201215514.1751994-1-iii@linux.ibm.com>
 <1a857ac7-ca7b-4c70-9f17-83b304feadb0@redhat.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <1a857ac7-ca7b-4c70-9f17-83b304feadb0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lmPWoNzHa3Frcw3XGCweueOpvDnBtszd
X-Authority-Analysis: v=2.4 cv=LLxrgZW9 c=1 sm=1 tr=0 ts=6964d94f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7izjeeDwzKX8gIOcXygA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA5MCBTYWx0ZWRfX1At2bo5qwioe
 B9Uhwg4bk1GAFdi1A+U9oC0r2iLBq91moVELi8OAV5N1KTnuSfLE3l0jeChcLjd8QKmlO/cKI69
 xOzLYsi/V1Y9WIOMb//BOoXnuSMr84GH0LPrnoDFNkuhaBkWF63BVZrxok7WqxP7/CUNmHLZkL8
 Z9Na4XrjcJAd6kriLcG+ASvILrnILsVSWKPEnX4fdLk9hgtYiEdYvLsq6uTVgy8L45aDs1xzCd9
 8NDHD1Bk7RnJROE/YHANQbBTAnJS9+1ihospsG4z0Z5vPGm2ifYUb2CoFdhVSSwMNCpwbYypr/s
 7NFO8bkHNicA26bSBwudBG2PEqYgnZAQSrncRlIvNk7Iw82YQm9c/Bxjxun34UVA2cgBIO8vpqC
 2pzXjuPy3n39slUbMlay/h5XOwMQdW/aU/NSBdAL7JyVYeRL+FrFPvd8Jd3KlhYX2ekiMVURtRw
 BusDEIegKF5/hyu9JDw==
X-Proofpoint-ORIG-GUID: lmPWoNzHa3Frcw3XGCweueOpvDnBtszd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601120090
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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


On 1/12/26 12:15, Thomas Huth wrote:
> On 01/12/2025 22.49, Ilya Leoshkevich wrote:
>> Hi,
>>
>> Here is my attempt to fix [1] based on the discussion in [2].
>>
>> I'm sending this as an RFC, because I have definitely misunderstood a
>> thing or two about record-replay, missed some timer bookkeeping
>> intricacies, and haven't split arch-dependent and independent parts
>> into different patches.
>>
>> This survives "make check" and "make check-tcg" with the test from [2],
>> both with and without extra load in background.
>>
>> Please let me know what you think about the approach.
> ...
>> diff --git a/stubs/async-run-on-cpu.c b/stubs/async-run-on-cpu.c
>> new file mode 100644
>> index 00000000000..adf1867ad21
>> --- /dev/null
>> +++ b/stubs/async-run-on-cpu.c
>> @@ -0,0 +1,7 @@
>> +#include "qemu/osdep.h"
>> +#include "hw/core/cpu.h"
>> +
>> +void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, 
>> run_on_cpu_data data)
>> +{
>> +    abort();
>> +}
>> diff --git a/stubs/cpus-queue.c b/stubs/cpus-queue.c
>> new file mode 100644
>> index 00000000000..fd678f42969
>> --- /dev/null
>> +++ b/stubs/cpus-queue.c
>> @@ -0,0 +1,4 @@
>> +#include "qemu/osdep.h"
>> +#include "hw/core/cpu.h"
>> +
>> +CPUTailQ cpus_queue = QTAILQ_HEAD_INITIALIZER(cpus_queue);
>
> FYI, I'll add a "SPDX-License-Identifier: GPL-2.0-or-later" to the new 
> stubs files to avoid an error with checkpatch.pl here. Please let me 
> know if you'd rather use another license identifier instead.
>
>  Thomas 

GPL-2.0 is fine. Sorry about forgetting this!


