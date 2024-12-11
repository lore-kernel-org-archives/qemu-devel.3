Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC3CE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 15:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLOTZ-0000IK-Ug; Wed, 11 Dec 2024 10:18:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tLOTK-0000HA-6S; Wed, 11 Dec 2024 10:17:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tLOTI-0007j2-DR; Wed, 11 Dec 2024 10:17:53 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBCqAMN007279;
 Wed, 11 Dec 2024 15:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=x/Qyeh
 RfoalIw5pgygEv6C5tvbp8dNhSJSB6tJ3cBaY=; b=bRhfw6CRR5XpTdgVozasoz
 7mq9SWHaNg8ai1q/VKP0/tiUdwUjpBMVv8c5wt51lMwRSIJuiusblsFE/sqXYgE1
 naZrvYt0mt5NQ7WAipej1ePBUFv0c2rko2BV7TwEiXOu5k49fk6JKdiu8MTtmnzh
 ZUlZ6wzvHyvLmEq6Ht3OuRk2N3CeD+snzCrD6BlMJz3EZij4i4Ei/OKGOsQ11QIp
 tWTSvgmb7McD7XXaPSBh4TACQGLh2fzp2U0XctrD7aD5caRnhLFVcnJ8k9vw10n7
 D3FvwoJ/V18yNiicJMv0Oo9xaEKjPmSBQ2WV6Qn6+Vuu0NMF//IfPHCVBIpDAM+A
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv8x42s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Dec 2024 15:17:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBD91m1032496;
 Wed, 11 Dec 2024 15:17:46 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d1pna4v4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Dec 2024 15:17:46 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BBFHi4r6357748
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Dec 2024 15:17:45 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9AFA58055;
 Wed, 11 Dec 2024 15:17:44 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A9AC5804B;
 Wed, 11 Dec 2024 15:17:43 +0000 (GMT)
Received: from [9.61.107.222] (unknown [9.61.107.222])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 11 Dec 2024 15:17:43 +0000 (GMT)
Message-ID: <9f97d172-15c2-4253-9450-7cfc9ffb4ce5@linux.ibm.com>
Date: Wed, 11 Dec 2024 10:17:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] s390x/pci: add support for guests that request direct
 mapping
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>,
 qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org
References: <20241209192927.107503-1-mjrosato@linux.ibm.com>
 <20241209192927.107503-2-mjrosato@linux.ibm.com>
 <cc6d2f65-1d71-4a78-9a9a-0fe7d16957d5@redhat.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <cc6d2f65-1d71-4a78-9a9a-0fe7d16957d5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 724mf47xns8goCPGMCIl0tZCCNh2hhF3
X-Proofpoint-ORIG-GUID: 724mf47xns8goCPGMCIl0tZCCNh2hhF3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=883
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110108
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 12/11/24 9:40 AM, Cédric Le Goater wrote:
> On 12/9/24 20:29, Matthew Rosato wrote:

>>   static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
>>                       uintptr_t ra)
>>   {
>> @@ -1008,7 +1036,7 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
>>       }
>>         /* currently we only support designation type 1 with translation */
>> -    if (!(dt == ZPCI_IOTA_RTTO && t)) {
>> +    if (t && !(dt == ZPCI_IOTA_RTTO)) {
> 
> Is this change part of the patchset ? It looks like some other issue.
> I might be wrong.
> 

Definitely part of this patch.
Before we only allow a single type of translation request from the guest.  So, guest needed to be requesting translation (t) and it had to be of a certain type (dt==ZPCI_IOTA_RTTO) else we fail.
Now we are allowing either that same single translation type (so t && dt==ZPCI_IOTA_RTTO) OR no translation (!t).  So it becomes valid to have (!t) but still invalid to have (t) with any other dt value besides (dt==ZPCI_IOTA_RTTO), hence the new check.

>>           error_report("unsupported ioat dt %d t %d", dt, t);
>>           s390_program_interrupt(env, PGM_OPERAND, ra);
>>           return -EINVAL;
>> @@ -1018,13 +1046,23 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
>>       iommu->pal = pal;
>>       iommu->g_iota = g_iota;
>>   -    s390_pci_iommu_enable(iommu);
>> +    if (t) {
>> +        s390_pci_iommu_enable(iommu);
>> +    } else {
>> +        s390_pci_iommu_dm_enable(iommu);
>> +        /* If not translating, map everything now */
>> +        s390_pci_setup_stage2_map(iommu);
>> +    }
> 
> 
> I don't understand how we can enter "map everything" case.
> Could you explain a bit more the scenario ?
> 

Sure, this actually relates directly to the check I discussed up above...

Before, we would only ever accept a guest MPCIFC instruction of type ZPCI_MOD_FC_REG_IOAT that specified "designation type 1 with translation".  All else would be rejected.
Now, we would accept either the above OR a guest MPCIFC instruction that specifies "no translation" - this is the case that gets us into the "map everything" scenario.

Patch 2 adds a CLP indication that we advertise to the guest that tells them whether or not the device group in question supports the "map everything case", so it's safe/allowable to issue a MPCIFC instruction that specifies "no translation" to a device in that group.

The referenced kernel series in the cover letter implements the linux guest behavior necessary to exploit this "no translation" case via the optional kernel parameter iommu.passthrough=1.  

Hope that helps,
Matt



