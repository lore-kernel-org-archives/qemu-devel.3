Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FB1F428C0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 18:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD58F-0004aN-82; Wed, 15 Apr 2026 14:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wD58E-0004aA-1R; Wed, 15 Apr 2026 14:38:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wD58C-0006JM-IA; Wed, 15 Apr 2026 14:38:33 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FGwOpJ1733768; Wed, 15 Apr 2026 18:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VXUDRL
 zP2t4a7Dz933Ce5SkTlEUxtstRgAeiy2ItUy4=; b=of6ws8oZpRVmA3JH4Ctges
 QNi78oOMvMnfQIm65fgLlVEKdC2hse8KsgrzYqkHGLg8gvq03lz/un0Wxhd6oKR4
 4NZrGfL6mbuz7B/5RFrYDvRK8Q+GI6/HjZIUW2QLnm5Ivpusgfs932Zb2kFfV52e
 xrJrAbPb2prr1GC8Mf21HD5o2rF3vGw3gD594IGxCIGHw4sWollIn+QkDAvuHCZ+
 Q00bzMZPGx6QlNhnrxMqx/9V3e6vzbyMJYh8ZQQ/mOFiW1sKWSqVDnS//DNaXVV6
 5LJJulwOPII9lDvYUVxp9MwfZPTV89Gak0Tlb6Kpn2lMomHcjLGFZhWsAUsSMksQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89m92v9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Apr 2026 18:38:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63FHiBBa003385;
 Wed, 15 Apr 2026 18:38:27 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4djbh9141h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Apr 2026 18:38:27 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63FIcPr264946638
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Apr 2026 18:38:25 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB0645805A;
 Wed, 15 Apr 2026 18:38:25 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 211CB58054;
 Wed, 15 Apr 2026 18:38:24 +0000 (GMT)
Received: from [9.61.11.27] (unknown [9.61.11.27])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Apr 2026 18:38:24 +0000 (GMT)
Message-ID: <31cedd4c-daba-420f-a46a-364e15911e37@linux.ibm.com>
Date: Wed, 15 Apr 2026 14:38:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 15/30] hw/s390x/ipl: Add IPIB flags to IPL Parameter
 Block
To: walling@linux.ibm.com, Jared Rossi <jrossi@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 pierrick.bouvier@linaro.org, david@kernel.org, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 jdaley@linux.ibm.com
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
 <20260402221453.1602899-16-zycai@linux.ibm.com>
 <575cc67c-3f78-4600-8be1-df92696a372b@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <575cc67c-3f78-4600-8be1-df92696a372b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=69dfdb24 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=c_Byt48B1GHtWo4dOTYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xrrbr0jAa8dsZ5P4SlkySbAcNTM2k-ET
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE3MSBTYWx0ZWRfX2OGWNeB/2ius
 oDNR3J16DNYCnfFo6LXqmi1/2K+V8mpiNaVPUlB4g7jKLzq1eUBcYIfe0+QWbfksKvhjw3sUBrR
 YSBm0AStvz/bpryT7qKQxaCDGKUGsU1ndRlUoJPIRHeznjEQRxDdyaWf3vF0fKLdQrQHTQnQeVu
 rgcgSuJyj2/qrFlMnXC7LhtbvN/lpETFVh1yvkzwY/YPBsoRZcZku6DO/kWI4RgEKzIsQ3Yzte7
 QhnrYatkE70pG0Gt/MT/mLA+q5zNYjUGe4jODNGzyJsLceBingHi2aiXPxsTsXKRJnSLBryHIfN
 BuOt8Vx8lz7RWgl2efm4IGSEjGH4eBfhuXnB7FP9UunfP2HE+078ZTEtzQ23uUwoCm4gLndqQm8
 wZbOHClgoeNXrlZmvzdXBIhNARr3lrGzXL+oPNBvq4v9QgaIuarA521xEFvcIbsxRj0mZmeIS7j
 puIQ9tDBepIBOp1HlBQ==
X-Proofpoint-ORIG-GUID: xrrbr0jAa8dsZ5P4SlkySbAcNTM2k-ET
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150171
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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

On 4/10/26 3:16 PM, Jared Rossi wrote:
> 
> 
> On 4/2/26 6:14 PM, Zhuoying Cai wrote:
>> <snip...>
>>   
>> -#define DIAG_308_RC_OK              0x0001
>> -#define DIAG_308_RC_NO_CONF         0x0102
>> -#define DIAG_308_RC_INVALID         0x0402
>> -#define DIAG_308_RC_NO_PV_CONF      0x0902
>> -#define DIAG_308_RC_INVAL_FOR_PV    0x0a02
>> -
>> -#define DIAG308_RESET_MOD_CLR       0
>> -#define DIAG308_RESET_LOAD_NORM     1
>> -#define DIAG308_LOAD_CLEAR          3
>> -#define DIAG308_LOAD_NORMAL_DUMP    4
>> -#define DIAG308_SET                 5
>> -#define DIAG308_STORE               6
>> -#define DIAG308_PV_SET              8
>> -#define DIAG308_PV_STORE            9
>> -#define DIAG308_PV_START            10
>> +#define S390_IPL_TYPE_FCP 0x00
>> +#define S390_IPL_TYPE_CCW 0x02
>> +#define S390_IPL_TYPE_PV 0x05
>> +#define S390_IPL_TYPE_QEMU_SCSI 0xff
>>   
>>   #define S390_IPLB_HEADER_LEN 8
>>   #define S390_IPLB_MIN_PV_LEN 148
>> @@ -112,6 +100,7 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
>>   #define S390_IPLB_MIN_FCP_LEN 384
>>   #define S390_IPLB_MIN_PCI_LEN 376
>>   #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
>> +#define S390_IPLB_MAX_LEN 4096
>>   
>> <..snip>
> 
> Collin correctly pointed out that S390_IPL_TYPE* already exists as an 
> enum in 'include/hw/s390x/ipl/qipl.h', so no need to define here.
> 
> I suggest we also move the various IPLB length definitions to qipl.h 
> while we are cleaning this up, since they are architected values anyway.
> 
> Regards,
> Jared Rossi

Thanks for pointing this out. I'll also move the other IPLB related
definitions to qipl.h in the next version.

