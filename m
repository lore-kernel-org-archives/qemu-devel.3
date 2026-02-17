Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B3BE68169
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 10:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsIVx-0003Sn-9o; Tue, 17 Feb 2026 05:41:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hbathini@linux.ibm.com>)
 id 1vsIVu-0003SQ-Jl; Tue, 17 Feb 2026 05:41:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hbathini@linux.ibm.com>)
 id 1vsIVs-0001xh-CK; Tue, 17 Feb 2026 05:41:06 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61GMjKBY2301761; Tue, 17 Feb 2026 10:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=KjL7ji
 va1IxFVZt+ngKCGhFEJFXfi9is3Rj1ezq/0r0=; b=rWj0t+7V5dTeU6lMegWqOA
 w6s5/DheyUZ0ciJN4HvDSi/vsmEvd/Dx17PoqmvhQpkaprdHHDnJUKyj0iEPS260
 sSVzHyW2JC88at6qkD+/fjg53m/Z5TlFc/ndOq6qSOoHvplSSwxkOvFxFxwjLzB/
 ZceshV8/Wmhr+kyH9eL0OAVmZ05GAG7T9wlm5seHGHbn4UIYrWaiXwzvSmwhOynk
 fmZc+Tw12wSMuwZNFes6eBsk6HTUjOdztR18KcAFD5ulxNTIwli8r5+JuYIF9I87
 LUDJJwdC+D/y5YAJCQ4LUpLSXQHB4fhr7RjbRrHMinKIDiO/6e9wBVvCklslsgoA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj642q1x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Feb 2026 10:41:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61H8pibn023889;
 Tue, 17 Feb 2026 10:41:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb452260-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Feb 2026 10:41:00 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61HAevxL27918994
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Feb 2026 10:40:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00F202004B;
 Tue, 17 Feb 2026 10:40:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD30020040;
 Tue, 17 Feb 2026 10:40:55 +0000 (GMT)
Received: from [9.78.106.17] (unknown [9.78.106.17])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Feb 2026 10:40:55 +0000 (GMT)
Message-ID: <017a0a00-60e9-42c6-974a-a66b111f5a83@linux.ibm.com>
Date: Tue, 17 Feb 2026 16:10:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] hw/ppc: Implement S0 SBE interrupt as cpu_pause
 then host reset
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20251206055648.1908734-1-adityag@linux.ibm.com>
 <20251206055648.1908734-3-adityag@linux.ibm.com>
 <9b6db774-cba5-49f7-b0ec-d56232cbeb99@linux.ibm.com>
 <aZQIJHZekWD-sWqI@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <aZQ2qJhGhdKo-cGI@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <aZQ2qJhGhdKo-cGI@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ecp4lFIUTFs0ODVzMNv_t6jUywf_KEM4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA4OCBTYWx0ZWRfX/oo+ZjARGlYH
 7Lr0uoZLdcjBDdXtarUV9U3WTHosp4pL3PSy1ZcKzmEJk2C2uAB4sujek36MjiSHLZlTuN+hEzT
 /LtzwshDvOgV/LAmiFuSSWkEnu2MhXCZMu5VtdPaLQrYSugFJbjBegLcl+aMMYhYjzGyOkCQu4P
 bsgpNKhepn4X0zhNIvy+6E7M2fno0sWPtDOMtQRh2m5QQGcYUgePGNFKxnyp0yYVZDAQ6FH3vSR
 nsxOLxNg2AIkA2RBCv4yYAMrEeBjEfJcvzsfiQDQ/lce8f6a+n3Y23nKF4TUf0g0UA6Uqb5+/73
 BGTB6Nire6+T3FoYgv0jsXbAU6WExhL8qdQ82vwSTEyQDeEFBaZ9110l1HWCukkgg8qy81QLtgL
 yF6mwffHAvZvlP/c42y0bVy7IHA6ZCDLFpQFE1evreMnekCxGk69wP41cdJejvCZexJU6OC3fm6
 NG32/7sGc1Dm0Fdkgdw==
X-Proofpoint-GUID: Ecp4lFIUTFs0ODVzMNv_t6jUywf_KEM4
X-Authority-Analysis: v=2.4 cv=U+mfzOru c=1 sm=1 tr=0 ts=699445bd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=P2EAv-b9zTbMH-od8MgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170088
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=hbathini@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



On 17/02/26 3:07 pm, Aditya Gupta wrote:
> On 26/02/17 11:48AM, Aditya Gupta wrote:
>> On 26/01/19 01:11PM, Hari Bathini wrote:
>>>
>>>
>>> On 06/12/25 11:26 am, Aditya Gupta wrote:
>>>> During MPIPL (aka fadump), OPAL triggers the S0 SBE interrupt to trigger
>>>> MPIPL.
>>>
>>> As mentioned in cover letter, add more clarity by mentioning that
>>> kernel initiates fadump with OPAL call. Skiboot then triggers S0
>>> SBE interrupt...
>>
>> Will add here also. Thanks Hari !
> 
> Does this look okay Hari ?
> 
>      During MPIPL (aka fadump), after a kernel crash, the kernel does
>      opal_cec_reboot2 opal call, signifying an abnormal termination.
>      When OPAL recieves this opal call, it further triggers SBE S0 interrupt,
>      to trigger a MPIPL boot.
> 
>      Currently S0 interrupt is unimplemented in QEMU.
> 

Yeah. That offers better insight.

- Hari

