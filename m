Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07DBEE6B46
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQ8j-0006el-6I; Fri, 06 Feb 2026 13:01:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1voQ8h-0006Zt-HI; Fri, 06 Feb 2026 13:01:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1voQ8f-0000Cq-P3; Fri, 06 Feb 2026 13:01:07 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 616Dsu9a007530;
 Fri, 6 Feb 2026 18:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=xyTjvH
 nIIQVft2aIB8kCYsRUzZ5imzSjoy9BvB6pvKc=; b=C33FCo+KvRMseKSa+Nq4/6
 dFpD9fsHzh7EK0oHIM2QXXWzAG4h8AAP1HwAFOGXOZ8lJsdeb6vQBY6ToHWEuDWY
 23m8HD0E++tpkMMM4jOPRSfiepujrNrSJdywyob3cT5wpaMTVsJ2HiLq37RRmIQf
 P08Z0tN+9yVg8Quyltz2jQa8ONhdEn2O9ZrMMEEhziLwoD7S0d9SSDeEirEye39H
 vb6PiaahZ34GXbZNd6fCW3I3m1om2D+HtJeW2GGNGAzfSBMhvIE6HkJbxkk9/XGy
 qlqeqmdt7NdDpt/4hS5rcH+eIlj6cjlUOAo2Vl8NqXHg48e2fDY99aRFHMeqAgoA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c175n9r4u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Feb 2026 18:00:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 616HSPdo005996;
 Fri, 6 Feb 2026 18:00:57 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1x9jpys9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Feb 2026 18:00:57 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 616I0anE66847046
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Feb 2026 18:00:36 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D523658063;
 Fri,  6 Feb 2026 18:00:55 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D82858056;
 Fri,  6 Feb 2026 18:00:55 +0000 (GMT)
Received: from [9.61.91.248] (unknown [9.61.91.248])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Feb 2026 18:00:55 +0000 (GMT)
Message-ID: <66469953-bb8e-4c7e-b3ab-1459a512a229@linux.ibm.com>
Date: Fri, 6 Feb 2026 13:00:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390x/pci: Fix endianness for zPCI BAR values.
To: JAEHOON KIM <jhkim@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org
References: <20260206164645.1845366-1-jhkim@linux.ibm.com>
 <92933127-8c06-44b9-8db0-cbb4c8b00431@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <92933127-8c06-44b9-8db0-cbb4c8b00431@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U0Da8TQaB0CK8Sh76-XGik9zKIArVNG4
X-Authority-Analysis: v=2.4 cv=VcX6/Vp9 c=1 sm=1 tr=0 ts=69862c5a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=v0iPHH8QV7TH8pC0mscA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: U0Da8TQaB0CK8Sh76-XGik9zKIArVNG4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEzMSBTYWx0ZWRfX/Z3PYK27hs6Y
 erI/hGcU9iCe68LHPZpi6KOl66HLd7K04r3tTVd+sTFqID4TJoZ+VvLs/rp2Y4FRNfM6JNodaWO
 jrKJkkvMikjnk4KCCBDOmlpXdbC+gpj7elkFG7V7ZoEnQCGBzrYjHSuHE+IHZ4ouFRjhDPZ/Swy
 vfmclNryIlZ2qxBIhTVzkqXD6PtsDg6QVtgKwW7shyUSA9HH21UrBGvFXFpm5eQvVb+jhtdorFR
 6tEsuSksSa/nMqC+f5aNDLJoZk0k93uRlRiuo8BhFSWKzGXV7yvfXFXeaErcfIdZHhybUYkH4Jn
 /GM21cqZt9ptm/HKFLpHRU2lduPIzriJW8v99gmExhiSFJMFKvHJ7lEIBZzu2f9IUkkOR3WO0mA
 cT1mOyUB7T0KCqaGt4gtLvNaeiUFcszDhDQ/ax+kcXgnYgpRkFe7+kqN/nSEvlAxibIOmy8iEH1
 Zt8YM9w82Z0GUXCCbSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2602060131
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 2/6/26 12:08 PM, JAEHOON KIM wrote:
> On 2/6/2026 10:46 AM, Jaehoon Kim wrote:
> 
> The previous mail didn't reach one reviewer; resending to the correct address.
> 
>> During zPCI scan, BAR configuration data retrieved via CLP Query was
>> misinterpreted due to an endianness mismatch between QEMU and the guest
>> kernel.
>>
>> The guest kernel's clp_store_query_pci_fn() expects BAR values in
>> little-endian format and converts them with le32_to_cpu(). However, QEMU

And indeed that's what the platform documentation says specifically for the BAR values - they should be presented in the CLP response in LE, exactly as in config sapce.

AFAICT this was subtly wrong since the initial QEMU implementation.  A simple git blame would point at c76c86fba5 ("hw/s390x: Use explicit big-endian LD/ST API"), but prior to this commit stl_p was used instead which still would depend on the target CPU type (BE).

Meanwhile, common code will always use PCI config space accesses (which are unaffected by this) rather than looking at the CLP response -- I think this is ultimately why it went quietly unnoticed.  

I don't see it mentioned here, but I also asked Jaehoon to regression test with both virtio-pci and vfio-pci passthrough on s390.  I also asked him to test it with tcg on a little-endian host and verify we see the same fix works as expected there too.

Thanks for finding this Jaehoon!

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

>> was incorrectly sending them in big-endian format, not following the
>> architecture specification. This caused incorrect bit-swapping in the
>> kernel, leading zpci_setup_bus_resources() to perform registration checks
>> against invalid flags, making the process ineffective.
>>
>> Observation values for zPCI device (NVMe passthrough):
>> LPAR from real CLP:
>> [    0.865595] Resource: PCI Bus 0000:00 -> zdev->bar[0].val: 0x4
>> [    0.865597]  start: 0x4000000000000000
>> [    0.865598]  end:   0x4000000000003fff
>> [    0.865600]  flags: 0x100200
>>
>> QEMU before fix (wrong):
>> [    0.601083] Resource: PCI Bus 0001:00 -> zdev->bar[0].val: 0x4000000
>> [    0.601085]  start: 0x4003000000000000
>> [    0.601086]  end:   0x4003000000003fff
>> [    0.601087]  flags: 0x200
>>
>> QEMU after fix (correct):
>> [    0.601116] Resource: PCI Bus 0001:00 -> zdev->bar[0].val: 0x4
>> [    0.601117]  start: 0x4003000000000000
>> [    0.601118]  end:   0x4003000000003fff
>> [    0.601119]  flags: 0x100200
>>
>> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-inst.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>> index 6b67c3c109..10066ca618 100644
>> --- a/hw/s390x/s390-pci-inst.c
>> +++ b/hw/s390x/s390-pci-inst.c
>> @@ -307,7 +307,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
>>               uint32_t data = pci_get_long(pbdev->pdev->config +
>>                   PCI_BASE_ADDRESS_0 + (i * 4));
>>   -            stl_be_p(&resquery->bar[i], data);
>> +            stl_le_p(&resquery->bar[i], data);
>>               resquery->bar_size[i] = pbdev->pdev->io_regions[i].size ?
>>                                       ctz64(pbdev->pdev->io_regions[i].size) : 0;
>>               trace_s390_pci_bar(i,
> 
> 


