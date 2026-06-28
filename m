Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BAFC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2026 23:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdytH-000627-1e; Sun, 28 Jun 2026 19:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wdytF-00061s-FM; Sun, 28 Jun 2026 19:26:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wdytD-0000Hf-VB; Sun, 28 Jun 2026 19:26:17 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65SMJUlO1372322; Sun, 28 Jun 2026 23:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=PlWL+e
 ODAXBX+n4csgG9TpTb520Jf2Xe53VxY+bNJ/k=; b=ruhQ3NHYCnvcV7xMpjyC25
 P0LH/XmmwGY2KXk92B/ImIpOQIoKGPAO64dPdmbBbDoYuH+F2s4kGKYt8jYfAeCX
 0ciKbiTIGLEiqedxaXkUxM5bwOa1MHeHlIuCkbBlaJshBHtdZaefqxqnSGi3ekL+
 QzB2esmih1Tnobdx0FxJj41NS2RxbH6Ka1CDgScdpr8iQpqX0jt1z+F2L0Mbdy4H
 2ZHhpFyyRNU7M2bqd4jAVsnxaxuvp/AI8FvRr9ZQqdeNVFVK+epsZnyU5vlj1W7P
 jxKUX0KDPLaVTOXeYgGcV1mZbC6MgahgPndA/iwQxhxxYjdIGOD/iTlfrAhe0OtQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjej3k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Jun 2026 23:26:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65SNJggp022262;
 Sun, 28 Jun 2026 23:26:13 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2suju2pd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Jun 2026 23:26:13 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65SNQBch31457856
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 28 Jun 2026 23:26:12 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D94475805A;
 Sun, 28 Jun 2026 23:26:11 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47DC058052;
 Sun, 28 Jun 2026 23:26:11 +0000 (GMT)
Received: from [9.61.16.187] (unknown [9.61.16.187])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Sun, 28 Jun 2026 23:26:11 +0000 (GMT)
Message-ID: <857c6967-b8b8-4e8d-b07e-19cafefc3a0c@linux.ibm.com>
Date: Sun, 28 Jun 2026 19:26:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] pc-bios/s390-ccw: write IPLB location for
 virtio-blk-pci IPL
To: Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: zycai@linux.ibm.com, jdaley@linux.ibm.com, jjherne@linux.ibm.com
References: <20260623002539.126124-1-jrossi@linux.ibm.com>
 <20260623002539.126124-4-jrossi@linux.ibm.com>
 <5528e528250b5e67ea33fe433842601f5eeaa292.camel@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <5528e528250b5e67ea33fe433842601f5eeaa292.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDIxMSBTYWx0ZWRfX6qnBZofIPtHM
 AoCfHRySGHAKTJqoYg4b92nloIK1O9vv5mrKUwbHzuls+f1Sk3EiSCZnmYhmsX20Z61WkmizPCg
 keGPEMBnyIkxGx9CQx6PdYaYynytBj2/7pOSZbVzwT9ZNBkJiFMppMVsFEgOg2BN39Gl8AE4kcj
 rIzcHfEUeaaeu+VZVgrM/MeFZJpHjrWi5LF6jhS52MPYiXwMSwTA0emS3okhGV3gthJcFL/1aAw
 cn30wSajBx5oLH/rUMa6+skJ5I2w/AbpTQHE//Ic3Vqam6NU17CFxuzlR9rh8vx1Hh/Wvvy0Ctd
 g5iI8Ejmej0zG4cIIb53Jpu9uRoL05SYHlNeNBvk5gckyv93MW3yo11I/zJEa+kEgeYpReNcOHy
 KxIyggU6DaX1YAFw0txG8vDp+h4DKOIFrjHK3zbbkBvD6U2tGlPnSyXiie8nS8aMtaCw+EGV82C
 GP936CigXV4lv3ks36g==
X-Proofpoint-GUID: wPGm5nUtEuP_T_nB4zjuyfLn-ZoHx9OR
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a41ad95 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=pFnGCSypWFfCd6UU2cYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDIxMSBTYWx0ZWRfX1WWYAPEo46fm
 Au+D5PT1MLTIEukuuMwIIazDAWBuLAFvp6wqEy5bGbo8t5rTTHMp9MNQJ4RodVUlGZfzCBXX2u+
 taTy9n3zeASS5wXYwPzlfDHA1iBbo/A=
X-Proofpoint-ORIG-GUID: wPGm5nUtEuP_T_nB4zjuyfLn-ZoHx9OR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280211
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 6/23/26 3:33 PM, Eric Farman wrote:
> On Mon, 2026-06-22 at 20:25 -0400, jrossi@linux.ibm.com wrote:
>> From: Joshua Daley <jdaley@linux.ibm.com>
>>
>> When IPL type is PCI, cutype is unknown, so the IPLB location does not
>> get written to lowcore. Update the condition to check IPL type as well.
>>
>> Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
>> signed-off-by: Jared Rossi <jrossi@us.ibm.com>
> I suppose "signed" is to be capitalized, but you mentioned this line is to be fixed anyway.
>
>> ---
>>   pc-bios/s390-ccw/main.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>> index 26287cfd81..1059fda03c 100644
>> --- a/pc-bios/s390-ccw/main.c
>> +++ b/pc-bios/s390-ccw/main.c
>> @@ -52,7 +52,8 @@ void write_subsystem_identification(void)
>>   
>>   void write_iplb_location(void)
>>   {
>> -    if (cutype == CU_TYPE_VIRTIO && virtio_get_device_type() != VIRTIO_ID_NET) {
>> +    if ((cutype == CU_TYPE_VIRTIO || iplb.pbt == S390_IPL_TYPE_PCI) &&
> Why iplb.pbt and not virtio_get_device()->ipl_type?

It should have been, but I think an even better solution would be to use 
virtio_is_supported(). I’ll reorder the patches so that the 
is_virtio_supported() fix discussed in the comments on Patch 4 come 
before this, then use the generic call covering both CCW and PCI here.


>> +        virtio_get_device_type() != VIRTIO_ID_NET) {
>>           lowcore->ptr_iplb = ptr2u32(&iplb);
>>       }
>>   }
Thanks again,
Jared Rossi

