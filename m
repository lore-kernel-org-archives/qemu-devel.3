Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB86D26D68
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 15:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veEEQ-0003r8-Iy; Fri, 09 Jan 2026 10:16:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1veEEL-0003pa-Fr; Fri, 09 Jan 2026 10:16:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1veEEJ-000751-RX; Fri, 09 Jan 2026 10:16:49 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 609Ej8UY010621;
 Fri, 9 Jan 2026 15:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2sKlZH
 xZfNy0rMOorWuCtDCvaiW1mayzr3dNYYJv2xg=; b=dbt2byBUELrNM109kmju6N
 m0iR+s/H0fo5gEFTT0j/WTfHDMRt/4JymeaXlknDdq9uR0rOVP/5pw9YKHHtxzbe
 8VLeXslSD2Ib87BQtPm0NkTtQyLf+6+wb9zmi6HT8wToZLbvBr186sqyKVczuie8
 EUljsM0NjNqUBxE/ERrtdPPImwZRSFNHS8PxnU6ZNRtW7LktEDIa+yAM9m1tybGE
 qELn3gk+lDjJ/N6eBR1aSH5O23c4UCpBWK15jnzuy9PB+ufPJlZevbztmRlg4lau
 atDwdvyWtEbk1NZJuekYgjVStecm/hpQQGi0y9+57BigwJ+HUbP1H6K7aL0OFSUw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4beshfad0a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Jan 2026 15:16:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 609ESWhx019341;
 Fri, 9 Jan 2026 15:16:42 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfg51n7d7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Jan 2026 15:16:41 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 609FGeMX31588970
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Jan 2026 15:16:40 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 60ED258055;
 Fri,  9 Jan 2026 15:16:40 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7EB7A5804B;
 Fri,  9 Jan 2026 15:16:39 +0000 (GMT)
Received: from [9.61.39.95] (unknown [9.61.39.95])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Fri,  9 Jan 2026 15:16:39 +0000 (GMT)
Message-ID: <79cc756d-bab9-4d6d-b4d3-9a10c8b68125@linux.ibm.com>
Date: Fri, 9 Jan 2026 10:16:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] pc-bios/s390-ccw: Add support for virtio-blk-pci IPL
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
 <20251210205449.2783111-8-jrossi@linux.ibm.com>
 <386824c5-d0f9-4384-a4de-d2ff5a3445d7@redhat.com>
 <2f2bb112-34d7-4a5f-aad0-c5d0630bb064@linux.ibm.com>
 <27476b00-d248-40a0-8432-39dec070e290@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <27476b00-d248-40a0-8432-39dec070e290@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDExNCBTYWx0ZWRfX557x6FT3kLEA
 rKyH+CJEvtiBAvoGg3KvKue01tgUlD3F73lBPB5r6OX5KA378oRWjF4fqb+r/Us7FwusTrGAFCs
 k2A/feCgf0iQY2smqTdtXx3LBxb+47ggXtneLNzFn+Ue7AOOwmhByaY4TpbAbKEqH6N0d2v2yRH
 F+2iCw/k6fM3i+UqSNUDGMCtozITiyO43OFD0Yy9rL2GtnDktBuD8LY9tjdgn+tPDoJVJe7H+Gl
 nHFmEHbXr4nz9qBe2lKP+msbaCEjQtiXI8Xt70GIPWkZifkNtQ/Um5TliMpq8ryzDWYOiWnG2Ry
 Cux3d9xJAK3EVCHGXSheQcIpgA/F4CnEXPaeug6ZhUy8TOYlxKtlqar1JCos48BIWJRFctuK1lq
 tdVnokOHXu113CLboH8F+Hqw16n1ZHqowGd/r6iNxYbHPzr/4O+VzVRIwdUb1EouyXpQu3ymc0k
 RyLiUKQw6ink4SaeZ3Q==
X-Proofpoint-GUID: 4A50CNddkI97aPbaTcrfCiNswdE3lyAY
X-Proofpoint-ORIG-GUID: 4A50CNddkI97aPbaTcrfCiNswdE3lyAY
X-Authority-Analysis: v=2.4 cv=AOkvhdoa c=1 sm=1 tr=0 ts=69611bdc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=HBOc--1Cofpw9K5WD4EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601090114
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 1/9/26 6:32 AM, Thomas Huth wrote:
> On 07/01/2026 19.32, Jared Rossi wrote:
>>
>>
>> On 1/7/26 9:44 AM, Thomas Huth wrote:
>>> On 10/12/2025 21.54, jrossi@linux.ibm.com wrote:
>>>> From: Jared Rossi <jrossi@linux.ibm.com>
>>>>
>>>> Enable virt-queue PCI configuration and add routines for 
>>>> virtio-blk-pci devices.
>>>>
>>>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>>>> ---
>>>>   include/hw/s390x/ipl/qipl.h      |  10 +
>>>>   pc-bios/s390-ccw/virtio-pci.h    |  79 +++++++
>>>>   pc-bios/s390-ccw/virtio.h        |   1 +
>>>>   pc-bios/s390-ccw/main.c          |  60 +++++-
>>>>   pc-bios/s390-ccw/virtio-blkdev.c |   3 +
>>>>   pc-bios/s390-ccw/virtio-pci.c    | 360 
>>>> +++++++++++++++++++++++++++++++
>>>>   pc-bios/s390-ccw/virtio.c        |   5 +
>>>>   pc-bios/s390-ccw/Makefile        |   2 +-
>>>>   8 files changed, 517 insertions(+), 3 deletions(-)
>>>>   create mode 100644 pc-bios/s390-ccw/virtio-pci.h
>>>>   create mode 100644 pc-bios/s390-ccw/virtio-pci.c
>>>>
>>>> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
>>>> index 8199b839f0..5c7779a1c3 100644
>>>> --- a/include/hw/s390x/ipl/qipl.h
>>>> +++ b/include/hw/s390x/ipl/qipl.h
>>>> @@ -22,6 +22,7 @@
>>>>     #define S390_IPL_TYPE_FCP 0x00
>>>>   #define S390_IPL_TYPE_CCW 0x02
>>>> +#define S390_IPL_TYPE_PCI 0x04
>>>>   #define S390_IPL_TYPE_PV 0x05
>>>>   #define S390_IPL_TYPE_QEMU_SCSI 0xff
>>>>   @@ -105,6 +106,14 @@ struct IplBlockQemuScsi {
>>>>   } QEMU_PACKED;
>>>>   typedef struct IplBlockQemuScsi IplBlockQemuScsi;
>>>>   +struct IplBlockPci {
>>>> +    uint32_t reserved0[80];
>>>> +    uint8_t  opt;
>>>> +    uint8_t  reserved1[3];
>>>> +    uint32_t fid;
>>>> +} QEMU_PACKED;
>>>> +typedef struct IplBlockPci IplBlockPci;
>>>
>>> Is this supposed to have the same positions for "fid" and "opt" as 
>>> in the ipl_pb0_nvme structure in the kernel 
>>> (arch/s390/include/uapi/asm/ipl.h)?
>>
>> Yes, I think.  That was my intention anyway. Are you suggesting it 
>> shouldn't?
>
> Having the same positions sound like a good idea. But if I'm counting 
> right, it currently does not match:
>
> In the code above, there are 80 * 4 = 320 bytes between the end of the 
> loadparm[] array and the "opt" field.
>
> In the kernel, there is the reserved2 field with 304 bytes between the 
> end of the loadparm[] array and the "opt" field.
>
> So either I'm counting wrong, or your reserved0 field should be 
> decreased in size?
>
>  Thomas
>
Ah, now I see.  Your are correct.  I will fix it.  Thanks for catching that!

Regards,
Jared Rossi

