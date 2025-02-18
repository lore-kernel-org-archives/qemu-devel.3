Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B1AC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 18:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkSka-0001xc-6N; Tue, 18 Feb 2025 13:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1tkSkY-0001xC-1f; Tue, 18 Feb 2025 13:55:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1tkSkW-00035H-GF; Tue, 18 Feb 2025 13:55:17 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IIPHmi031953;
 Tue, 18 Feb 2025 18:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nbfIeF
 TYew+yO/GHK/XLddfsmeuZL05BYJ5gDy+kQ34=; b=Wvt0J2CIpTG5NjrQyXNdf5
 lBUuDsgaGChEPd5QNqjR4sLhjLLKbPIT5jROrdaL+rDTFh/HxipP5Zz7OAqYsZuN
 arVNhY2Dc16ci1o4r5KPvDT3sv3NzAsdKfuebjKT5PeJjjc6f6v5GpmOwGVTFUK6
 NOEdEcH7OPhjYFCcS8KcHzu4G2jV+Bgls7Wyyg38XkLZqWxxjITu3R32kEdDofjy
 ykWSoE0hshX6yrDh4ifKvht9KfuUPm2nUzCh74tiGvSFlu9ybvJVbWLeMT1rJJvx
 68fYY62IFJs9m/Q7jAcW2tHQUaX09RNoSCZh2H7Mq/ON65J0I1HTRSMXEyT+7/nQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vm18uyf9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Feb 2025 18:55:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51IHj0xS029537;
 Tue, 18 Feb 2025 18:55:12 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44v9mmnmpp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Feb 2025 18:55:12 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51IItCXc38601226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Feb 2025 18:55:12 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 402265805E;
 Tue, 18 Feb 2025 18:55:12 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C82858043;
 Tue, 18 Feb 2025 18:55:09 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Feb 2025 18:55:09 +0000 (GMT)
Message-ID: <ab8d4cb4-ad3a-48f3-ae6e-deb054ef66ec@linux.ibm.com>
Date: Tue, 18 Feb 2025 13:55:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/3] TPM TIS SPI Support
To: dan tan <dantan@linux.ibm.com>
Cc: dan tan <dantan@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, stefanb@linux.vnet.ibm.com, pbonzini@redhat.com,
 farosas@suse.de, lvivier@redhat.com
References: <20250216221155.30013-1-dantan@linux.vnet.ibm.com>
 <413fd61d-a30d-4061-bc71-d0efe92e625f@linux.ibm.com>
 <3a63ef12967ef52ca18d1ca140c283cb@linux.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <3a63ef12967ef52ca18d1ca140c283cb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Wp4Dwlu5U28GOjHk-F-dU_h-q1BHF11S
X-Proofpoint-ORIG-GUID: Wp4Dwlu5U28GOjHk-F-dU_h-q1BHF11S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_09,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180129
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2/17/25 3:24 PM, dan tan wrote:
> Stefan,
> 
> I have yet found a ppc64le Linux distro that has SPI enabled in the 
> kernel. Attempts to build my own was not successful either. I am trying 
> to get the LTC (Linux Technology Center) involved. They have more 
> expertise in building the ppc64le kernel. I am hoping to get that tested 
> soon.

I'll wait for this then.

Once it works it may be worth to try an experiment with the last 
remaining wait state and see whether also that one can be removed. I am 
not sure whether we should have it since it only negatively affects 
performance and it is also part of the device's state, so it would not 
be so easy to remove once we have it.


> 
> thank you,
> ---
> dan tan
> power simulation
> phone:+1.7373.099.138
> email:dantan@linux.ibm.com
> 
> 
> On 2025-02-17 14:12, Stefan Berger wrote:
>> On 2/16/25 5:11 PM, dan tan wrote:
>>> *** BLURB HERE ***
>>>
>>> Version 9 summary:
>>>      1/3 tpm/tpm_tis_spi: Support TPM for SPI
>>>          - rebased with the master, and conform with the latest
>>>            device property definition
>>>      3/3 tests/qtest/tpm: add unit test to tis-spi
>>>          - remove unnecessary tpm-tis-spi qtest start parameters
>>
>> Were you able to test it with Linux now?


