Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B59F531D9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCPPG-0000WY-Sa; Mon, 13 Apr 2026 18:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wCPPE-0000W3-M1; Mon, 13 Apr 2026 18:05:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wCPPC-00083r-Rm; Mon, 13 Apr 2026 18:05:20 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DLIjJq1843301; Mon, 13 Apr 2026 22:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=p0MpYA
 tEHwnmYmWSGNNTh5w887w5kxQw5lM0a0k95KQ=; b=j1tjXT5pUWEMCGNm0mvXRa
 Y+LtoxSNAw1MZuCX0Lb4k+q4NpxHQ3OTEokxbtvVOLoxXr+imQYlzB6TsIXMVJUo
 91UQJbY60VmzuXnJy3WRDFDUQ3NNdRyrb7s7lkiheuyltE8rAMM9+No6N1SICeuH
 mjdUBoTmdByBRW98lOBQ/jWueaCjHh+4UclOw/dF+cuNWWOhgo2x7uH5FLdjPnnW
 p3RO1+VJ/MkU29gQyJg2qv7CvW7iIC4f+B9LM9pS44x1RzmScozGRPUpiSCPuSwT
 4bjMzYSYYn1g8vq98y4jqvdxP0oESRoOTKEWSv4cpBT/lbhaM8kxZDXAaI0UBu9w
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89mg3wv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Apr 2026 22:05:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63DLhkVo015149;
 Mon, 13 Apr 2026 22:05:10 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0msf51u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Apr 2026 22:05:10 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63DM4gTm16450116
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Apr 2026 22:04:43 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2EEE358059;
 Mon, 13 Apr 2026 22:05:08 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB6AC58043;
 Mon, 13 Apr 2026 22:05:06 +0000 (GMT)
Received: from [9.61.251.241] (unknown [9.61.251.241])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 13 Apr 2026 22:05:06 +0000 (GMT)
Message-ID: <0c315300-bfdd-4fab-b083-13997e7d36ab@linux.ibm.com>
Date: Mon, 13 Apr 2026 18:05:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 19/30] pc-bios/s390-ccw: Add signature verification
 for secure IPL in audit mode
To: Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 pierrick.bouvier@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
 <20260402221453.1602899-20-zycai@linux.ibm.com>
 <c941097f-4c48-45ec-af8b-2068c446e33b@linux.ibm.com>
Content-Language: en-US
From: Joshua Daley <jdaley@linux.ibm.com>
In-Reply-To: <c941097f-4c48-45ec-af8b-2068c446e33b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDIxNCBTYWx0ZWRfX2XF1APwpQvqn
 HhsPyYOuhMFHXXhI/TPFRTPY2vq/DwN9n18/eAK9+xT2jf6p1kPbCTJVfPN2xTnLTH8h9umai0O
 dXlW+bP27KfYaOkcu5lchI0AjMAu0VMlEt7XuszOU1ydNljVwKUGgea2tHyVCCgO1cZCEvWkkI1
 kEHpBPCe9IfJtXZipjjk6B4fVYF3I4KQvPae4Z3hsVF01N3bn1T+2SP/cETqSv1EHp064xp1D9b
 mb+GgvhnojRdglAPMmrM4h9Up7FX2qm+wtBXZjJQ9E/6rV5hqIi71gA05Eh/qH0zVq9wDRzmkBa
 m1qZCwcEOnDyvREDgfWGf4nbCoo4u9KhfmdrWHZg2hh108ra23UYcw6eyNpTXCViXiqDUI4Pfcy
 HznV4tOmRvZxGdiwppSfiWl2ObrWxutYAiuGiEREW5mcRS665KRWQD9QLCcIrAP9sZx0Z3NhpeS
 l/7RGxz4jWAeqBk/q4g==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=69dd6897 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=1gfuZGPUVoj4r_BVOqoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: m99N0rB8zN1BQHeiLPKm_rzWBxWOZkeH
X-Proofpoint-ORIG-GUID: m99N0rB8zN1BQHeiLPKm_rzWBxWOZkeH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1011 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604130214
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jdaley@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

On 4/13/2026 3:59 PM, Jared Rossi wrote:
> 
> 
> On 4/2/26 6:14 PM, Zhuoying Cai wrote:
>> Enable secure IPL in audit mode, which performs signature verification,
>> but any error does not terminate the boot process. Only warnings will be
>> logged to the console instead.
>>
>> Add a comp_len variable to store the length of a segment in
>> zipl_load_segment. comp_len variable is necessary to store the
>> calculated segment length and is used during signature verification.
>> Return the length on success, or a negative return code on failure.
>>
>> Secure IPL in audit mode requires at least one certificate provided in
>> the key store along with necessary facilities (Secure IPL Facility,
>> Certificate Store Facility and secure IPL extension support).
>>
>> Note: Secure IPL in audit mode is implemented for the SCSI scheme of
>> virtio-blk/virtio-scsi devices.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>   docs/system/s390x/secure-ipl.rst |  35 +++
>>   pc-bios/s390-ccw/Makefile        |   2 +-
>>   pc-bios/s390-ccw/bootmap.c       |  36 +++-
>>   pc-bios/s390-ccw/bootmap.h       |  11 +
>>   pc-bios/s390-ccw/main.c          |   6 +
>>   pc-bios/s390-ccw/s390-ccw.h      |  27 +++
>>   pc-bios/s390-ccw/sclp.c          |  37 ++++
>>   pc-bios/s390-ccw/sclp.h          |   6 +
>>   pc-bios/s390-ccw/secure-ipl.c    | 359 +++++++++++++++++++++++++++++++
>>   pc-bios/s390-ccw/secure-ipl.h    | 110 ++++++++++
>>   10 files changed, 626 insertions(+), 3 deletions(-)
>>   create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>>   create mode 100644 pc-bios/s390-ccw/secure-ipl.h
>>

...

>> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
>> new file mode 100644
>> index 0000000000..6d65cd5596
>> --- /dev/null
>> +++ b/pc-bios/s390-ccw/secure-ipl.h
>> @@ -0,0 +1,110 @@
>> +/*
>> + * S/390 Secure IPL
>> + *
>> + * Copyright 2025 IBM Corp.
>> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef _PC_BIOS_S390_CCW_SECURE_IPL_H
>> +#define _PC_BIOS_S390_CCW_SECURE_IPL_H
>> +
>> +#include <diag320.h>
>> +#include <diag508.h>
>> +
>> +VCStorageSizeBlock *zipl_secure_get_vcssb(void);
>> +int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec);
>> +
>> +/* Custom struct for secure IPL component entry information */
>> +typedef struct SecureIplCompEntryInfo {
>> +    uint64_t addr;
>> +    uint64_t len;
>> +    uint16_t cert_index;
>> +    uint8_t  flags;
>> +} SecureIplCompEntryInfo;
>> +
>> +static inline void zipl_secure_handle(const char *message)
>> +{
>> +    switch (boot_mode) {
>> +    case ZIPL_BOOT_MODE_SECURE_AUDIT:
>> +        IPL_check(false, message);
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +}
> I think calling this something like 'secure_ipl_print' would make more sense.
> Maybe skip IPL_check and use printf directly since it's always false.
> 
When true secure IPL mode is introduced (patch 25), this function is updated
such that it will panic in that mode. How about 'secure_ipl_error'?

