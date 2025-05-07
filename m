Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AFDC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 16:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uChQc-0002tg-7m; Wed, 07 May 2025 12:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uChQa-0002sr-JN
 for qemu-devel@nongnu.org; Wed, 07 May 2025 12:15:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uChQX-0005cP-0d
 for qemu-devel@nongnu.org; Wed, 07 May 2025 12:15:24 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54791vUF006987;
 Wed, 7 May 2025 16:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=LpknKq
 7oixuOz6wiMqlOCA1CCvzM/H+9MMVV7GPl3LE=; b=CfRtotO9PAiRXNpYZawZbV
 8lfqSXlkfTyPvrfxjcvPzteozgUiK1lFgBfKgyqd4sY1eIdizTtpS9DpidedC/g0
 Y6dWm++UPlscI5F8DHTi9mjb/XCirOPBjdP4ehMgZ21k2RE4Gs6kCZyK8LpqEkma
 Z1qJhZEfzDNPbeduObW1QNQVYaEX99Lqt6cwk9/ucXjs08j4nn3w5OXSIG/z4FZo
 rdFJJmoZb7Q4kIMTXmgzWaIZDyHTT4czDurvX/sx7eZABajR+GouPE57yn04pJW1
 T/qY42hGKwR3G6f37Ki9+FYwUIVhTtOD/z4Y6kLtHqeMIoE3LOd4F49XqMqCvpRQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fth8cnuw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 16:15:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 547GDb76001324;
 Wed, 7 May 2025 16:15:14 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dwfthqn7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 16:15:14 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 547GFDpW19989196
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 May 2025 16:15:13 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5EF1D5805B;
 Wed,  7 May 2025 16:15:13 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 49DF05804B;
 Wed,  7 May 2025 16:15:12 +0000 (GMT)
Received: from [9.61.248.26] (unknown [9.61.248.26])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  7 May 2025 16:15:12 +0000 (GMT)
Message-ID: <986a9cff-708f-496d-81d9-6c465674699b@linux.ibm.com>
Date: Wed, 7 May 2025 09:15:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] include: Add a header to define host PCI MMIO
 functions
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, stefanha@redhat.com, mjrosato@linux.ibm.com,
 schnelle@linux.ibm.com, philmd@linaro.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net
References: <20250430185012.2303-1-alifm@linux.ibm.com>
 <20250430185012.2303-3-alifm@linux.ibm.com>
 <0e1bcc40-7429-4aec-8632-31cd49f9d333@redhat.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <0e1bcc40-7429-4aec-8632-31cd49f9d333@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v85YVgRgWR8PjwYIflEUCwprrAI43QIw
X-Proofpoint-ORIG-GUID: v85YVgRgWR8PjwYIflEUCwprrAI43QIw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE1MSBTYWx0ZWRfX6MZvwPHoeL4G
 W+xO2Irk4qZKJ09OlnyOmmgS+Vk/gz2Qb/Jy6vcJucQyE8u3whLS2uw2z4YVfkn9uxYDzJHabSx
 Y1D9bg1JpfSlR0dnLpSUxZ6Ee8FZ6hEOFF/6oc/ytM3ub69XAUwKLEs03D/qOw8nLoBqJiBTYN/
 POmkfXjMdThyLd0j3LI0RxA1NaFQc9MG/NTHWc4389URlEhUmgcz5BoaCnnJmRJkJ3yD2LXnJ22
 VWK+ruxk4sm49P9gTThlpoZId4ZlJU4P13di09Z3lW78hYjtgWzBih6rDupReZwZ2F94nVSHpky
 eBiBTCJ3ADnnmubXMRVRmCHucm2Tb+gBNaQ0lh1dcEoFVE2/P01NxNMBkQ0uDe1wZvu9wsZvh8W
 GCtMN6Ylp5GeHf97lNrDhQhr9V8ZiG6lbTRE1M5BoZ2a8z+vteag0eEwb6V4C/CZnWksdoL8
X-Authority-Analysis: v=2.4 cv=KOlaDEFo c=1 sm=1 tr=0 ts=681b8713 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=5ouQw2PSCVBumTyJpSEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_05,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxlogscore=938 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070151
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 5/5/2025 2:38 AM, Thomas Huth wrote:
> On 30/04/2025 20.50, Farhan Ali wrote:
>> Add a generic API for host PCI MMIO reads/writes
>> (e.g. Linux VFIO BAR accesses). The functions access
>> little endian memory and returns the result in
>> host cpu endianness.
>>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
> ...
>> +static inline uint8_t host_pci_ldub_p(const void *ioaddr)
>> +{
>> +    uint8_t ret = 0;
>> +#ifdef __s390x__
>> +    ret = s390x_pci_mmio_read_8(ioaddr);
>> +#else
>> +    ret = ldub_p(ioaddr);
>> +#endif
>> +
>> +    return ret;
>> +}
> ...
>> +static inline void host_pci_stb_le_p(void *ioaddr, uint8_t val)
>> +{
>> +#ifdef __s390x__
>> +    s390x_pci_mmio_write_8(ioaddr, val);
>> +#else
>> +    stb_p(ioaddr, val);
>> +#endif
>> +}
>
> Cosmetic nit: host_pci_ldub_p() does not have a "_le_" in its name, 
> while host_pci_stb_le_p() has it. Could be fixed up while picking up 
> the patch, so no need to respin just because of this.
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
>

Thanks Thomas! if there are no other concerns with the patches would 
these patches go through the s390x tree or the block tree?

Thanks
Farhan


