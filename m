Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B714EFCE4C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 22:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxuX9-0005DZ-3L; Wed, 04 Mar 2026 17:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vxuX5-0005D2-IW; Wed, 04 Mar 2026 17:17:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vxuX3-0005N4-9g; Wed, 04 Mar 2026 17:17:31 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 624KAGdO1233029; Wed, 4 Mar 2026 22:17:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YRk2QV
 9qZZXaPBBK33ZusSJOaSjOqATsWhIKb3pXaJM=; b=MK86MQMLPKxVXJJ9VQ9Fln
 s/dXmO72xlHWoFFY75QDiqiP8YqYFoZruiTlaP7rxwUoPuxNllo3kO4CjwK/T5hd
 Weav1IqJof+Nxyx/vUpCPN8hgzwD1MgD+8vthLYOYs/7PRbAR0AafIrkmyaKM7xa
 9x012pTkwNnANpH50T4ILbfH8hbf1VOQj6lGnudcKfiwG2/bSVsuFGHuivQuAxhZ
 NejGuq1EijOIo1qzkGJxiBTF+PeYW6R1CyjeWMQALGr/yfEjRVxDPimxJRlEkA+6
 xaQLaR4oGvh6mtwd1TBc8BMEiDZD5wO2PtoJXEhVuNjAFSbnVBsRDKah6IHZn/RQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk40yq2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 22:17:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 624IBbwl003266;
 Wed, 4 Mar 2026 22:17:22 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2y8rak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 22:17:22 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 624MHLhl29229768
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2026 22:17:21 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E7025805A;
 Wed,  4 Mar 2026 22:17:21 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E15758054;
 Wed,  4 Mar 2026 22:17:19 +0000 (GMT)
Received: from [9.61.37.248] (unknown [9.61.37.248])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2026 22:17:19 +0000 (GMT)
Message-ID: <d3207adf-e23d-4c8f-a5f9-0a2a0e56c564@linux.ibm.com>
Date: Wed, 4 Mar 2026 17:17:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 19/30] pc-bios/s390-ccw: Add signature verification for
 secure IPL in audit mode
To: Farhan Ali <alifm@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, brueckner@linux.ibm.com
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
 <20260212204352.1044699-20-zycai@linux.ibm.com>
 <e434be13-1099-4d4d-b689-e4f6b7752b45@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <e434be13-1099-4d4d-b689-e4f6b7752b45@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UAv3JHgYd7q4de0QBvQbbUGDO9fwiiSX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE4MiBTYWx0ZWRfX7iK3LsseQPFX
 OyaF8qhPqLmdOE0dRUyRGaamj6Yed7r58V+teYVQj1pPHMXOy9Rd/eAER2a6kh0x/QoL20auPm4
 ptIWTqB7e0cMwATIhwGZJM0p8ECxlTZR7sTXbzKlA2PHyvyDHZDnH8v/ncMGXib46JYIRXkAAhu
 8b6CO8emJj3LHRcs2cWI186A/zK4h1KDnLUuIWVZeg5JBKBbnBgOAEBa1m+w8GIdLOwaV4rj7PK
 bV6b4ehEP9B/Z/bQvwM0taC5YfG6nUkJQqbflOEft2BXL66WyqtyNfO7oNwQ1sgSJcbRHrULvTr
 KOktEdka2fFlOSh20q0tbB/ng6GLeQgVKU2BuouS04dYpCILnxnfF97OJ068ozczfpHIF7GRZd4
 6Xbq7kdfvv5gJhnwTnvN9Z/elpydRLfPIMXEvvlTMZfn2bycVmebw0LSxGPcOdenCtzDBhRdIx2
 FXbaBeR9SP4MuValddw==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69a8af73 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=abkHmWJOmZPixc9wqO0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: UAv3JHgYd7q4de0QBvQbbUGDO9fwiiSX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_08,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040182
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/3/26 4:46 PM, Farhan Ali wrote:
> <...snip...>
> 
> On 2/12/2026 12:43 PM, Zhuoying Cai wrote:
>> uint8_t vcssb_data[VCSSB_MIN_LEN] __attribute__((__aligned__(PAGE_SIZE)));
> 
> I don't see us setting vcssb_data set to 0 before we even start secure 
> ipl verification. I think we should be safe and set it to 0 before the 
> first time we touch this? otherwise if its pointing to garbage data it 
> can break the length checks.
> 
> Thanks
> 
> Farhan
> 

I'll declare the array as static, as Thomas suggested. My understanding
is that an explicit zero initialization isn’t required, since static
variables are initialized to zero by default. Please let me know if I’m
missing anything.

>> +
>> +VCStorageSizeBlock *zipl_secure_get_vcssb(void)
>> +{
>> +    VCStorageSizeBlock *vcssb;
>> +
>> +    vcssb = (VCStorageSizeBlock *)vcssb_data;
>> +    /* avoid retrieving vcssb multiple times */
>> +    if (vcssb->length >= VCSSB_MIN_LEN) {
>> +        return vcssb;
>> +    }
>> +
>> +    if (!is_cert_store_facility_supported()) {
>> +        puts("Certificate Store Facility is not supported by the hypervisor!");
>> +        return NULL;
>> +    }
>> +
>> +    vcssb->length = VCSSB_MIN_LEN;
>> +    if (diag320(vcssb, DIAG_320_SUBC_QUERY_VCSI) != DIAG_320_RC_OK) {
>> +        return NULL;
>> +    }
>> +
>> +    return vcssb;
>> +}
> 
> <...snip...>
> 
> 


