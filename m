Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD597EB26F3
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 17:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vps0e-0008DS-AU; Tue, 10 Feb 2026 12:58:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vps0b-0008Ct-Sh; Tue, 10 Feb 2026 12:58:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vps0Z-0001EK-QZ; Tue, 10 Feb 2026 12:58:45 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61A91W3W225970; Tue, 10 Feb 2026 17:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VehbGE
 MoH7EEFbMtXUtBd1e9Ynd1cvv+G6wLI6jEodU=; b=ZEtJeFyYc6zEDAtqLAzrKv
 RKXBD82lgTDyEuxWEQ7SEvDhKE3OHFtGLKHIP8anoFcb6BlcxiJOACzMrjke5xQV
 5xFUv912lRT7uCCCG6cKJZ9ZQE1+45cPFkpd9NLUhh5ZXv1P4mjSU6iRtd0dJf5H
 ic8yzQoEKGQxzmOHIASRB+hLN3XjWCylPGcG0AcXCa6nrll25OSO2cEivseJA4RN
 UJ8S2Mhgemi60yKJMpQRh+K7PthvJWw8P7mzjsVtoJhbFKC/TOmKP47RFGSXLMqK
 Eyjhp9PFWncQcKrR3jDc/pHbQgUtA8P+s3sUa/mMpQZ8fLyti5ng6wuAlia+K5Ng
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696udkuc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 17:58:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61AHeCcw008404;
 Tue, 10 Feb 2026 17:58:27 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6g3yajyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 17:58:27 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61AHwQME29819572
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 17:58:26 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 136785805C;
 Tue, 10 Feb 2026 17:58:26 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A89C858059;
 Tue, 10 Feb 2026 17:58:24 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Feb 2026 17:58:24 +0000 (GMT)
Message-ID: <fae6eb21-6ed4-41fb-ad6f-4ef44b2e7f44@linux.ibm.com>
Date: Tue, 10 Feb 2026 12:58:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4 qemu] Exclude TPM ioctls definitions for the
 GNU/Hurd
To: Damien Zammit <damien@zamaudio.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 bug-hurd@gnu.org
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, manolodemedici@gmail.com,
 peter.maydell@linaro.org, kwolf@redhat.com, berrange@redhat.com,
 eblake@redhat.com, bugaevc@gmail.com
References: <20260130031954.1661880-1-damien@zamaudio.com>
 <20260130031954.1661880-4-damien@zamaudio.com>
 <ac182e8e-cd4f-467b-b6a8-31f03b70b3b9@redhat.com>
 <26b39a30-8ef0-4f68-af65-58a6718226a6@linux.ibm.com>
 <5d9dd511-117f-21a6-1e2e-eed22077aaa1@zamaudio.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <5d9dd511-117f-21a6-1e2e-eed22077aaa1@zamaudio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=YZiwJgRf c=1 sm=1 tr=0 ts=698b71c4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=oPMGwu8xAAAA:20
 a=yrR22Ep7q6gAgLJqXqQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: iwhm67VvmF9dAE9YdBovIqHRZylSsUxw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE0OCBTYWx0ZWRfX7AABInWNqeXZ
 tC8zIHu2pMLPWtgg25pRvuyAK1B2WXXBobdM2oL9QsTCY17kyj2LEOafrBuupkQLM7hucDvANfC
 egk5aIEmk+YpqG7qp4HFWVo6xaAPd0jgJLbiI1CE6xyIcLrAk0d+01DWIrzU6DY4EwARHQo3DUY
 GXJlI3j2opZvwWBG2Z35UGZ47atL0YreujVWkqkV9z7v4IDkUJ6nLvzDvO3i8mU1OZQ/cSXAbQY
 ZZFJLc9jzVT17YPG49mSu/hpYqcFp4VvgMOnWwR/GK4bDqbV8otQ53Z/NrMnAf0rSCsCx4HLr5X
 C/sNzUrPOw0naU+u1r1EVXzGgqwfgTQk2lThRrmMYSlfKMxa5U4h4q2jpYNBm5QIi+0lg2zmI0w
 MtlMtK+9QP3mpclboVGpOF/VeL+FI7QdkSrZ0DXrW+LLxiLWqcHNknZetgnVe0/c9hA0vr4pv1Z
 1hKnQuROXDBnaNZCBpQ==
X-Proofpoint-GUID: wzkBe3jr2a_9Jy0VDkRWFn0OC4rEqSkk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_02,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100148
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 2/7/26 11:03 PM, Damien Zammit wrote:
> Hi Stefan,
> 
> On 2/4/26 2:21 AM, Stefan Berger wrote:
>> So this file comes originally from swtpm here:
>> https://github.com/stefanberger/swtpm/blob/master/include/swtpm/tpm_ioctl.h
>>
>> To keep them in sync as much as possible -- would this here work?
>>
>> #ifndef _WIN32
>> #include <sys/uio.h>
>> #include <sys/ioctl.h>
>> #endif
>>
>> #ifdef HAVE_SYS_IOCCOM_H
>> #include <sys/ioccom.h>
>> #endif
>>
>> #ifdef __gnu_hurd__
>> #include <mach/x86_64/ioccom.h>
>> #endif
>>
>> and then keep this as-is?
>>
>> #if !defined(_WIN32)
>> enum {
>>        PTM_GET_CAPABILITY     = _IOR('P', 0, ptm_cap),
>>        PTM_INIT               = _IOWR('P', 1, ptm_init),
>>        PTM_SHUTDOWN           = _IOR('P', 2, ptm_res),
> 
> No, this wont work because the _IOT__IOTBASE_* symbols are missing for
> the tpm structs on GNU platform:

> 
> In file included from /usr/include/x86_64-gnu/sys/ioctl.h:26,
>                    from ../backends/tpm/tpm_ioctl.h:17,
>                    from ../backends/tpm/tpm_emulator.c:39:
> ../backends/tpm/tpm_ioctl.h:290:30: error: ‘_IOT__IOTBASE_ptm_cap’
> undeclared here (not in a function)
>     290 |     PTM_GET_CAPABILITY     = _IOR('P', 0, ptm_cap),
>         |                              ^~~~

I have it compile because I added this here (above):

#ifdef __gnu_hurd__
#include <mach/x86_64/ioccom.h>
#endif

Without this header I do see these errors as well. Either way, am fine 
with your suggestion in v5.

  Stefan



