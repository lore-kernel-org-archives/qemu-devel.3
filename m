Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37145C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 19:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubOOg-0000vW-EU; Mon, 14 Jul 2025 14:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1ubNGx-0001P5-Uw; Mon, 14 Jul 2025 13:47:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1ubNGq-0007on-TY; Mon, 14 Jul 2025 13:47:23 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGIZuw028372;
 Mon, 14 Jul 2025 17:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UtNbU8
 9/mn+icfZ0kcH6kLcLLmnAi9GFwbMpzXezI7c=; b=R/4zo1vu0hS4SVZLcU96zd
 hREdnfHmGFQKxpRpjeBcX5nER0HFUv6Rd13/QAw7zrsVdTmdyeOmZF4b4Z3J34fO
 V7IPZughRjThsof4Pn85aMg2A48bM40TPNoHWMmun1YTdl1hUj3OQF7skSqifgwL
 sX0l3fRtuA/2T8mdG1Dp/TZO1phg36Sd8JQmj4Fdd0Q6iaVCrKm31SsAk/89YWu/
 5l+Zxb1IHtNtlyYSFkjWqVaXACf6hctneoNCx5zPpZL7PoalGAT8fCbfoIqtouTR
 ubjpp/B7DAnniEGcpUZpua+vOEZaHoOHYCcJrhZ52uZKMOFRmdT/6quWkfUJTTAg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vdfmdw48-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Jul 2025 17:47:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56EHK5UQ008150;
 Mon, 14 Jul 2025 17:46:37 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v2e0f2e3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Jul 2025 17:46:37 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56EHkaT06357724
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 17:46:36 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D55D58050;
 Mon, 14 Jul 2025 17:46:36 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE05E58045;
 Mon, 14 Jul 2025 17:46:34 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 14 Jul 2025 17:46:34 +0000 (GMT)
Message-ID: <cdfb6342-dcbb-4b01-b88a-38c75d924ac7@linux.ibm.com>
Date: Mon, 14 Jul 2025 13:46:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/28] pc-bios/s390-ccw: Add signature verification for
 secure IPL in audit mode
To: Thomas Huth <thuth@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-21-zycai@linux.ibm.com>
 <eccbac31-7c1d-4b75-a284-a46ad98675db@linux.ibm.com>
 <80ebd632-5b56-4391-b60d-f6a64f311e7f@linux.ibm.com>
 <2c1bd3f0-731c-4ca7-9f43-50c3c572aaa6@redhat.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <2c1bd3f0-731c-4ca7-9f43-50c3c572aaa6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q5ZQL4ezKx_hX6FDNf3z6WA28IfzdSqi
X-Authority-Analysis: v=2.4 cv=JOI7s9Kb c=1 sm=1 tr=0 ts=687542a3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=uV63gYRwOBysfW4DI5UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: q5ZQL4ezKx_hX6FDNf3z6WA28IfzdSqi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDExMiBTYWx0ZWRfX3OxEfzrmPVkW
 3VmSIoERJOmy4F5UZplRN5xugc/oNBibLnZVZoGeh8uqlwmoBnO3jTFHKWKlkEt/icy3J/ifiDK
 WvD/5JkUTOB9nqhJEhuJggcBuKJLVH5rK9cD4QCY6IjfydI9GQQ1vcDp8nevqeilYBdMqgpMOS/
 3LOb6tjOsli56saHdFPK6PZ74niQTg+MXEA5hrEhhm1b/1ca4IfKMMPCalbNqJLbTnCZsrAIEUS
 icKj3Llpk6kd8mIpD1yscygm4+SZZfVffvYozquBUkGJsJs0iBB3HD5DDxpTg9EllDlLqGuGY6C
 tUR40ThOSec21eTvUUJ/La2F+A2aofncAuTFHM100PoKdh8IZrdjPef8IOfuVJLLEghyBYE28d7
 /yH6HmokVanTnGg0m8/RZw6OZ0Pex5THEwR9NZrI+Qu83hQf+Y1Q2FwVMo027oiKkWxDY9Ty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140112
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/14/25 11:34 AM, Thomas Huth wrote:
> On 14/07/2025 16.54, Jared Rossi wrote:
>>
>> [snip...]
>>>> +
>>>> +        entry++;
>>>> +
>>>> +        if ((uint8_t *)(&entry[1]) > tmp_sec + MAX_SECTOR_SIZE) {
>>>> +            puts("Wrong entry value");
>>>> +            return -EINVAL;
>>>> +        }
>>> Can someone who is more informed than I am of the IPL process please
>>> explain to me what is the purpose of the above check?  Why does it check
>>> if the next entry, the one which isn't going to be inspected/loaded, is
>>> within the bounds of tmp_sec?  This has been here since this file's
>>> inception and I can't find any documentation or mention that supports it.
>>>
>>> This code precludes any of the secure IPL changes.
>>>
>>> Was this actually meant to be entry[0] to ensure the actual entry we
>>> want to work on is not outside the bounds of tmp_sec?  Or perhaps it was
>>> meant to be done before the increment to entry?
>>>
>>
>> I noticed that as well and came to the same conclusions as you, which is to 
>> say,
>> it has always been that way and it is not clear what the purpose is, but it 
>> does
>> not appear to have any impact on the proposed secure IPL functionality.

Fair enough.  Let's keep the current code in and address it later.
Thanks, Jared.

> 
> I think it's meant as a check for the *end* of entry[0], so it's likely just 
> a quirky way of saying:
> 
>     if (((uint8_t *)entry) + sizeof(*entry) > tmp_sec + MAX_SECTOR_SIZE)
> 
> ?
> 
>   Thomas
> 

This makes a lot more sense to me.  Thanks, Thomas.

-- 
Regards,
  Collin

