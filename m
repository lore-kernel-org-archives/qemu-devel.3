Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714E3CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 22:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wahlT-0005UM-EZ; Fri, 19 Jun 2026 18:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wahlR-0005UA-7A; Fri, 19 Jun 2026 18:32:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wahlO-0005f3-9b; Fri, 19 Jun 2026 18:32:39 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JMIAlA3417183; Fri, 19 Jun 2026 22:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1Gnu/F
 kGFSMtpidktD6tQx3vsQcQgX7hKveHXGY6d6c=; b=s8VX7RBZUeQQ09EFwv90rb
 ZSGXOSQ4XcFe/jzvH0BV/MGABU+PRlLHySJIUVjd38yl3j8Cv75EMUCtWlvgoX7D
 e24j3eD3/q9pQXcDMx7HbMmEfBFOEjS3aw+GyBk5TFC1uW+HZuK4QvZOjDJiaY7F
 CF8n6di7oLQatggAeqP9RCOhjP7CwhTr7Yg1vd0vmi/nJbSZ0QafJO1yiR/yDEk1
 8ph6+s8VH7RGWKqbvznWbMsd3q//A47UgFaTeJ4G5kWD7ntSz6J4ZV98wooW0ufA
 NnnUtf+WKMoKTX35ORJx+k4m53TtMV4AggDtDFpsofKeBwSMTq9ksFdpaoYFSUSg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxfjku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2026 22:32:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JMJiGG030697;
 Fri, 19 Jun 2026 22:32:33 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev172avc9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2026 22:32:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65JMWWZo1573488
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jun 2026 22:32:32 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F42255805C;
 Fri, 19 Jun 2026 22:32:31 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6EC158066;
 Fri, 19 Jun 2026 22:32:30 +0000 (GMT)
Received: from [9.61.241.74] (unknown [9.61.241.74])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 19 Jun 2026 22:32:30 +0000 (GMT)
Message-ID: <c320ea4e-0046-4239-ab91-b6dbf27abf3e@linux.ibm.com>
Date: Fri, 19 Jun 2026 15:32:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/15] s390x/pci: Add a comment explaining S390PCIIOMMU
 purpose
To: Matthew Rosato <mjrosato@linux.ibm.com>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260605021728.1125090-1-kshk@linux.ibm.com>
 <20260605021728.1125090-14-kshk@linux.ibm.com>
 <1db93e1b-b7a6-4aa4-8432-fa7f114b9985@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <1db93e1b-b7a6-4aa4-8432-fa7f114b9985@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dEKzbLP5ixdpbfWqh2zrPs5LsTIiW5wz
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a35c382 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=7BgoatAGXH3n0dY3WgUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIxNSBTYWx0ZWRfX0xRK+DEppm13
 wJQzpHDlHvvso8/EamD6oRoHHH9KuaY8Hnax5vrzp3idmMHw54tku7s9V6/30kBEaVpw29M+Rw6
 rA6LpyKru0GmIpiMjI9rRFnhSsmaRqk=
X-Proofpoint-ORIG-GUID: dEKzbLP5ixdpbfWqh2zrPs5LsTIiW5wz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIxNSBTYWx0ZWRfX4kl6tqqYgH/8
 FedoJirIQvheWV16DRDUJxsmHb6ChEYRdZYJTAd6gT1acfcQX77kzGDHxfJWxgJlm5WaOk6BLvD
 ZkviAMroixbl4XsYv6/jlN7arstZYcZuX8whYPrN1S3a/DJ5pASW9rlNtK0N3CZv8Q6anFZU/vH
 3GCS+z4K9xSZf5sJ+KLqb+o09zcSbu4W8jsWtKyx5sQJpm/V4kzt4cuuynrNSCoCHc/6OMhnEcH
 80ztT1uU79HSVD1yjZlXKwV6/Bq7Vs9wVO/ABl9ibd1MThYsFUGMIAon1hxrstdQP/RAYcyViwW
 Xqg/XJsfty3hSGQ+6cLWpWNPnXaIoEj55aDwB6iloJ0uSLtXvKCBf5c/0dsRFp5kzrYa791Jo61
 7nVw44VUE8cZALnIyCKEGIJv/rv60dzPYW/80lcx+mwwvX68thD7IxC43OX2gZJ8NGubpofjBex
 3sbZvGVfOs6xpUocbsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190215
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
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


On 6/19/2026 10:39 AM, Matthew Rosato wrote:
> On 6/4/26 10:17 PM, Konstantin Shkolnyy wrote:
>> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> Commit message needs something here -- You don't need to include the
> explanation of the structure (that's in the commit itself) but maybe
> describe the context (e.g. you're adding the comment because you just
> moved most of the contents of the structure out in support of migration
> and are now describing the remaining purpose)
>
>> ---
>>   include/hw/s390x/s390-pci-bus.h | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
>> index e3cbee2695..2fab28e6e0 100644
>> --- a/include/hw/s390x/s390-pci-bus.h
>> +++ b/include/hw/s390x/s390-pci-bus.h
>> @@ -271,6 +271,14 @@ typedef struct S390PCIDMACount {
>>       QTAILQ_ENTRY(S390PCIDMACount) link;
>>   } S390PCIDMACount;
>>   
>> +/*
>> + * This structure holds the PCI device AddressSpace that QEMU needs to link
>> + * into its internal structures before the zPCI and PCI devices are fully
>> + * initialized. It's a QEMU requirement to provide this "root" AddressSpace
>> + * early. The AddressSpace is only actually used for I/O while the PCI
>> + * device is plugged in and configured by the guest, at which time it gets
>> + * additional memory subregions from zPCI device, that can do real work.
>> + */
> To be more clear, it's not that it is required 'early' so much as that
> it is required to be there at the time the PCI device is plugged.
>
> The lifecycle has always been a bit odd here; it is an attribute of the
> zPCI device, but is required by the PCI device in order to function and
> the necessary linkage between the 2 (PCI->zPCI) is established via the
> iommu_table in the S390pciState.  Would be good to work some of that
> into this explanation.

+1 I think we moving few fields from the struct, so having an 
explanation why do we need the remaining fields would be helpful. Also 
can this struct be extended in the future without any issues and 
breaking? If not then maybe adding something about would that would also 
be helpful.

Thanks

Farhan


>>   struct S390PCIIOMMU {
>>       Object parent_obj;
>>       AddressSpace as;

