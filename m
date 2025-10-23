Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F268ECCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 17:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBzXx-0000QA-8b; Thu, 23 Oct 2025 13:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vBzXt-0000N5-HS; Thu, 23 Oct 2025 13:56:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vBzXp-0003bk-Pd; Thu, 23 Oct 2025 13:56:16 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NAJO1R026789;
 Thu, 23 Oct 2025 17:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5COfb/
 MEiDxlgd0dT/x8GocJeOIBifB2uMRPbuRSAkA=; b=D+m8ntC/tl13Jx4NY/4E6S
 89ZkKjSqqHV8i+YyT1IRE8JUZbTaS4UeuxUG2ISxPTowmfKnJhMFeOx3Q3tjF7TL
 5/IwA5vUp7m7PEO6DMwOZZD9eZELM26TSI5wzIETcoTxHMWiEf72vu4cDhpieMYc
 /nW2gbL/AGJZx6Us0O8cPgYdvcqkwH3OrfYMWG5GfokFAEANI7NdPPIQNgKml2ki
 rF7UUMu2l3W8s4R1WfSnbCFxZ1zvDrY8qGMfGDUNqquueBplLNVjiGgOg4LK84vs
 GbI76+1w1yq+PisPBvSe30ll1HnWtTKJBsfJkBx4gxwi8LIWxZDMVLYYhjDjYgrg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30w25wn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 17:56:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NHZlG3024953;
 Thu, 23 Oct 2025 17:56:11 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqk71a1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 17:56:11 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NHu9GY22151690
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 17:56:09 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6CD3758058;
 Thu, 23 Oct 2025 17:56:09 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB90758059;
 Thu, 23 Oct 2025 17:56:08 +0000 (GMT)
Received: from [9.61.246.20] (unknown [9.61.246.20])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 17:56:08 +0000 (GMT)
Message-ID: <1839cf44-81f1-4eb6-8243-e2cf6853c92a@linux.ibm.com>
Date: Thu, 23 Oct 2025 10:56:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] pc-bios/s390-ccw: Introduce PCI device IPL format
From: Farhan Ali <alifm@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com
Cc: jjherne@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
References: <20251020162023.3649165-1-jrossi@linux.ibm.com>
 <20251020162023.3649165-5-jrossi@linux.ibm.com>
 <49301ff9-894c-4341-bd9e-7b2213aa184b@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <49301ff9-894c-4341-bd9e-7b2213aa184b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CAsF-ay5sCcEV5-ESSk0kViXGVrKG9f1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX33fkjsleiZ9s
 Q0vJV5TMy+PeEOITGFvluqDbCekhD0xzsKueZrOF63IKiwjpmJx1yk6zjZAYyZH1wAyRwO/yyyP
 J74vBsUKXybdxguLImx9m0pnewihQwkSjBShyly+w5VEhM+IessGcCi70sE+btodMrOcIG99hFH
 38Q03ZlFWarZrk1xzfKGm60wqbmW57M69mvESCDnsPbXLHTt7DQ9P5MKdJhniJ4nRiKudu2AE9o
 Jwvs7IezYZ/Bd8G3hIpittRXb6LZdwhz6LMOB1+7+Z6+oBnc3/0kISEhxR3q5S56oAGTigAfH3w
 MgW2vZYM+CfT+GU/M4TJzvY96163ACSjpYAXpMQOFq0lQwZfrv349uo2Y5wRqodBopMIzk2JiGx
 oTv3Xz8w4N2ZiVYBraJ/Af/Xh0j5/g==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68fa6c3b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=eZw9B4C5VJsgSpDazncA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CAsF-ay5sCcEV5-ESSk0kViXGVrKG9f1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 10/23/2025 10:31 AM, Farhan Ali wrote:
>> + * Find the position of the capability config within PCI configuration
>> + * space for a given cfg type.  Return the position if found, 
>> otherwise 0.
>> + */
>> +uint8_t find_cap_pos(uint32_t fhandle, uint64_t cfg_type) {
>> +    uint64_t req, next, cfg;
>> +    uint8_t status;
>> +    int rc;
>> +
>> +    req = ZPCI_CREATE_REQ(fhandle, 0xf, 1);
>> +    rc = pcilg(&next, req, PCI_CAPABILITY_LIST, &status);
>> +    rc = pcilg(&cfg, req, next + 3, &status);
>
> Why are we reading next + 3 into cfg? If I understand this correctly 
> next will be the address of the first capability in the linked list, 
> and so we should just read the first byte from next to get the 
> capability id? I think we should have helper function like 
> qpci_find_capability to find the capabilities?
>
>
>> +
>> +    while (!rc && (cfg != cfg_type) && next) {
>> +        rc = pcilg(&next, req, next + 1, &status);
>> +        rc = pcilg(&cfg, req, next + 3, &status);
>
> Same question here?
>
>
>> +    }
>> +
>> +    return rc ? 0 : next;
>> +}
>> +
>
> [..snip..]
>
Ah I see in patch 5 we are using this function to get virtio config 
type, which is a vendor specific capability and according to spec the 
virtio config type is defined in the 4th byte. Maybe we could just move 
the function to virtio-pci.c? I would expect a function defined here 
will try to find a specific PCI capability by searching through the PCI 
capability list.

Thanks

Farhan




