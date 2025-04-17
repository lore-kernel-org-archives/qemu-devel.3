Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E469CC369CF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 14:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Pzd-00058Y-9q; Thu, 17 Apr 2025 10:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u5PzX-00054N-Ne; Thu, 17 Apr 2025 10:13:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u5PzV-0008Rk-NY; Thu, 17 Apr 2025 10:13:23 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HAipwR016518;
 Thu, 17 Apr 2025 14:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nrZsTJ
 gmG7utdFjJkRLKSgg4w2qVlc6QHy3XFTDPVCw=; b=jPJCYwpuIE57zvI6vOKnSm
 YbXfoNs4NRSqIC+F6INUSXg1XMG/mmVpAUyY0GLgFOKeDYRdo09lfmO9phkqamIQ
 qZC+BFidw/UX+v2R6082bNl25CwABbaMeo9aqmwqxGaEMVZUZixxn3JGeE6fVB1R
 hSuFxI6Lj5muecxtHvT90FMi38rS35oW5RKi3znE4fbtGCQslrkfVRwMvAVvp281
 uBY6KiJQ6IEeU7X+F6F2fU2LKYgWwb9IYKrpoRfHzNjMseZBH1fpq32MWBCkc954
 rTqb7ECoaxhITMDni49l1Xkl8psZ2xRvqMf4L5odbwaMxxHGjVqvrYvALWNd7LAQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462mn7v0uk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Apr 2025 14:13:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53HB8NgL017233;
 Thu, 17 Apr 2025 14:13:16 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46040m5vmm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Apr 2025 14:13:16 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53HEDFiH6029936
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 14:13:15 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D3B1358059;
 Thu, 17 Apr 2025 14:13:14 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5BF5D58055;
 Thu, 17 Apr 2025 14:13:13 +0000 (GMT)
Received: from [9.61.39.227] (unknown [9.61.39.227])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 17 Apr 2025 14:13:13 +0000 (GMT)
Message-ID: <bc000c83-979a-4ec6-9628-f2b48a433558@linux.ibm.com>
Date: Thu, 17 Apr 2025 10:13:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 24/24] hw/s390x/ipl: Handle secure boot without
 specifying a boot device
To: Collin Walling <walling@linux.ibm.com>, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com
Cc: jjherne@linux.ibm.com, jrossi@linux.ibm.com, fiuczy@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250408155527.123341-1-zycai@linux.ibm.com>
 <20250408155527.123341-25-zycai@linux.ibm.com>
 <93f3cb7f-9dda-4ff4-b3e9-81a6c870d115@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <93f3cb7f-9dda-4ff4-b3e9-81a6c870d115@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ANnAolku c=1 sm=1 tr=0 ts=68010c7d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=0UfI22MnMs8H_QUV0GAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GEOfZQyamL3opzB5atMhv0CJHP6iohqG
X-Proofpoint-ORIG-GUID: GEOfZQyamL3opzB5atMhv0CJHP6iohqG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_04,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170101
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 4/16/25 6:11 PM, Collin Walling wrote:
> On 4/8/25 11:55 AM, Zhuoying Cai wrote:
>> If secure boot in audit mode or True Secure IPL mode is enabled without
>> specifying a boot device, the boot process will terminate with an error.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>  hw/s390x/ipl.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index 60bafcbd2e..0510f16a7d 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -767,6 +767,16 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
>>          s390_ipl_create_cert_store(&ipl->cert_store);
>>          if (!ipl->iplb_valid) {
>>              ipl->iplb_valid = s390_init_all_iplbs(ipl);
>> +
>> +            /*
>> +             * Secure IPL without specifying a boot device.
>> +             * IPLB is not generated if no boot device is defined.
>> +             */
>> +            if ((s390_has_certificate() || s390_secure_boot_enabled()) &&
>> +                !ipl->iplb_valid) {
>> +                error_report("No boot devicie defined for Secure IPL");
>> +                exit(1);
>> +            }
> 
> I'm confused why this check is needed.  If there is no valid iplb, won't
> boot just fail outright anyway?
> 

If no boot device is specified, the BIOS will still scan all channels to
find a bootable device (as defined in probe_boot_device() within
pc-bios/s390-ccw/main.c).

Boot will proceed if a bootable device is found, but the IPLB will not
be generated on the host side in this case. We cannot determine whether
secure boot is enabled, since it's indicated by the IPLB flags.

Therefore, specifying secure IPL without a boot device cause the process
to terminate early.

>>          } else {
>>              ipl->qipl.chain_len = 0;
>>          }
> 
> 


