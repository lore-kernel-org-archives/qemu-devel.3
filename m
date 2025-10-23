Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835A4CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 18:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBzuZ-0001Nq-7o; Thu, 23 Oct 2025 14:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vBzuX-0001Mj-06; Thu, 23 Oct 2025 14:19:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vBzuV-0006Eo-3E; Thu, 23 Oct 2025 14:19:40 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NI3cZu025916;
 Thu, 23 Oct 2025 18:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wRW0y0
 6f2gyZKV1XUtoU6daUuYD7VXbFLk6LfWb8qdA=; b=GmfmzVKX1w+pYO5lJPrwIh
 IO16ocPbC6+v3SgQyj+yZcjzxPC3D5gqLKagWpAnbApwyxiG/5pMiCRqmpM13HNe
 KNWERixnWU7fetO5kWi0BP43Ix5GkabQyy+7r+ErbMBFVmJ6BhGb8b1kC9w+Kp9+
 hkOO+Jel0w1V2t6jF/Eag3t1aXVkZczlKuZslFqDK7m/itUR7XvFp4+xrjXMbn5F
 PZAH6aDlB3e+EHEFzfB4czRMgMqLNUejRzbdIrAl/CANnokeWmeJM09jxIvHyRyd
 krx9ADd78z3S1CF2vG9V2gnZvmiOe5Gw0Yzfk5xE7OKrueM+EWAGnEXV5qrqCawg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fktjb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 18:19:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NH32K6024303;
 Thu, 23 Oct 2025 18:19:36 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqk7516-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 18:19:36 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NIJYQr8258158
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 18:19:34 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC7D258061;
 Thu, 23 Oct 2025 18:19:34 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11F9E58059;
 Thu, 23 Oct 2025 18:19:34 +0000 (GMT)
Received: from [9.61.130.101] (unknown [9.61.130.101])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 23 Oct 2025 18:19:33 +0000 (GMT)
Message-ID: <62ab7aaa-212a-4f27-b70d-989ae54bbfaf@linux.ibm.com>
Date: Thu, 23 Oct 2025 14:19:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] pc-bios/s390-ccw: Introduce PCI device IPL format
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, thuth@redhat.com
Cc: jjherne@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
References: <20251020162023.3649165-1-jrossi@linux.ibm.com>
 <20251020162023.3649165-5-jrossi@linux.ibm.com>
 <49301ff9-894c-4341-bd9e-7b2213aa184b@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <49301ff9-894c-4341-bd9e-7b2213aa184b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68fa71b9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=UgB_kW2KEPTkg6t8hWEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: j4fKV9fTPsHV4N5uZ8-_ww1Hmk2faqco
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX7PNXMCTm0w0g
 7nom9LqefabxK2nNm4njVKj88pUHP92+s4KnaUVHIuVKRlpORsWsq0u7hQiqf6y4+uQVfrhCweM
 5Piqo2YUqJS+7RDd9y0OkaeBdQUT7NRD5PlwU3jVlaeUKbIArQMdyC6LEY+iwnkx4WZZkaVL+cU
 qleF4ReoUgvBLtMyO5VxY2R0SFXSvq4dl4ukoEV0alBRHZBkPEpYB4rYr7jxA7/+p1qwgBQAGQv
 1E6WF+kI8UbUTgQEOreld7/umtGjZDPOL4H8UC9NyB2oWk8EjuEV9TaXcWzp3D7NgOxHbx4ZAuI
 hFQZ/ZbLfhAsTZVd++SxLieuLGlkDivkpwDyuJgYIPC6neB4Tete49eQqvZ8tMEfoMSC6mqGCWY
 HNtRY7Y6SNGl3i2mtRaLucefVKZf+Q==
X-Proofpoint-ORIG-GUID: j4fKV9fTPsHV4N5uZ8-_ww1Hmk2faqco
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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

Thanks Farhan,

On 10/23/25 1:31 PM, Farhan Ali wrote:
> [snip]
>> +
>> +int pci_write(uint32_t fhandle, uint64_t offset, uint64_t data, 
>> uint8_t len)
>> +{
>> +
>> +    uint64_t req = ZPCI_CREATE_REQ(fhandle, 4, len);
>
> This assumes that we will only read to BAR 4? I think we should pass 
> the PCIAS here as well if we want to generalize this function?
I was thinking about this too and I agree that it should be 
generalized.  Also when reading the capabilities from the configuration 
space, I did not check that the location is, actually, BAR 4.  I will 
generalize the functions so that we do not make any assumptions about BAR 4.

>
>> +    uint8_t status;
>> +    int rc;
>> +
>> +    rc = pcistg(data, req, offset, &status);
>> +    if (rc == 1) {
>> +        return status;
>> +    } else if (rc) {
>> +        return rc;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +int pci_read(uint32_t fhandle, uint64_t offset, uint8_t picas, void 
>> *buf, uint8_t len)
>> +{
>> +    uint64_t req;
>> +    uint64_t data;
>> +    uint8_t status;
>> +    int readlen;
>> +    int i = 0;
>> +    int rc = 0;
>> +
>> +    while (len > 0 && !rc) {
>> +        data = 0;
>> +        readlen = len > 8 ? 8 : len;
>> +        req = ZPCI_CREATE_REQ(fhandle, picas, readlen);
>> +        rc = pcilg(&data, req, offset + (i * 8), &status);
>
> Shouldn't this be offset + (i * readlen)? but I guess this works 
> because we will only increment i on reads greater than 8 bytes. Maybe 
> we could try to simplify this and have a single pci_read function and 
> several other helper functions that uses pci_read to read sizes of 
> 1/2/4/8 bytes. For reads greater than 8 bytes we can have another 
> function (similar to zpci_memcpy_from_io, in the kernel). From what I 
> can tell most of the pci_read calls reads are 8 bytes in the rest of 
> the patches, except maybe for one case which reads greater than 8?
Yes I agree.  Thomas mentioned something similar.  I think using some 
helper functions will make the code easier to read also.

>
>> +        ((uint64_t *)buf)[i] = data;
>> +        len -= readlen;
>> +        i++;
>> +    }
>> +
>> +    if (rc == 1) {
>> +        return status;
>> +    } else if (rc) {
>> +        return rc;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +/*
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
I see you already answered this yourself in a follow-up mail, but you 
are correct that this is for the vendor-specific capabilities. I will 
move it to virtio-pci.c and add a comment for clarity.

>
>> +    }
>> +
>> +    return rc ? 0 : next;
>> +}
>> +
>
> [..snip..]
>

Regards,
Jared Rossi

