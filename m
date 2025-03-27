Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC103C36011
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 19:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txtEI-0007R2-Ra; Thu, 27 Mar 2025 15:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1txtEG-0007QW-90; Thu, 27 Mar 2025 15:49:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1txtED-0006DW-3e; Thu, 27 Mar 2025 15:49:26 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RE37o9008015;
 Thu, 27 Mar 2025 19:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=erRQWK
 hJbocVt/qiiJBWcuiohUuxVJWrXDMz9uEYjLE=; b=c37aP9ubVRfmD8deV5DQ4D
 f5/NhQFX+dwZCmGs90L5z3ewl1G72OGvN9IqOdXttdO6B+nTipKMvNaZUiRllLXL
 bjyFyTrm+1XLmsvQn8WHb2otZDwYemJanetnHjjghRjh7Gi1r9jDDBcPXw9Mwd2a
 GyItM9Fa8o/M7A58tLIVw0U4T8SWarR1bSgJRQYUvStGepR/hjRAHELBzLSYGmGK
 8SeG2konLY0QPzOFZb395lbLv8bHy43Nu/fbY+sMTJcXfzpMZVCBi7y1qJ5ngS94
 PJjP6fBpzOs4O3PqxW2mbtaLS25xiSWQFAUXFlY3YGUGeaamsUHnMoZwk1DNyYEQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45n83pa08q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Mar 2025 19:49:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52RIFsvK030325;
 Thu, 27 Mar 2025 19:49:15 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7htq6t6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Mar 2025 19:49:15 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52RJnDVv34341474
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Mar 2025 19:49:14 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FAE158051;
 Thu, 27 Mar 2025 19:49:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC1CA5805E;
 Thu, 27 Mar 2025 19:49:12 +0000 (GMT)
Received: from [9.61.251.62] (unknown [9.61.251.62])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Mar 2025 19:49:12 +0000 (GMT)
Message-ID: <9ce01416-b0db-4bde-a608-2fc4f95fc718@linux.ibm.com>
Date: Thu, 27 Mar 2025 12:49:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] block/nvme: Enable NVMe userspace driver for s390x
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, mjrosato@linux.ibm.com, schnelle@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-block@nongnu.org, fam@euphon.net,
 philmd@linaro.org, kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com
References: <20250326181007.1099-1-alifm@linux.ibm.com>
 <20250326181007.1099-3-alifm@linux.ibm.com> <20250327192659.GD46883@fedora>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250327192659.GD46883@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kUKH61jC_2C5XpsLVewvv1FqQ5LCmhNo
X-Proofpoint-ORIG-GUID: kUKH61jC_2C5XpsLVewvv1FqQ5LCmhNo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_03,2025-03-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=729 impostorscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503270131
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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


On 3/27/2025 12:26 PM, Stefan Hajnoczi wrote:
> On Wed, Mar 26, 2025 at 11:10:07AM -0700, Farhan Ali wrote:
>> +static inline uint32_t nvme_mmio_read_32(const void *addr)
>> +{
>> +    uint32_t ret;
>> +
>> +#ifdef __s390x__
>> +    ret = s390x_pci_mmio_read_32(addr);
>> +#else
>> +    /* Prevent the compiler from optimizing away the load */
>> +    ret = *((volatile uint32_t *)addr);
>> +#endif
> The NVMe driver should not need to worry about s390 PCI MMIO specifics.
> It would be nice to add a QEMU PCI MMIO load/store API that hides this.
>
> block/nvme.c would use the API to access MMIO registers instead of
> accessing them directly. The functions could be static inline in the
> header file to minimize overhead on platforms that can directly access
> PCI MMIO registers.

Hi Stefan,

Thanks for reviewing. I do agree, having a generic QEMU PCI MMIO 
load/store API for this would be good. And we can hide architecture 
specifics there. I didn't add that to begin with was NVMe driver would 
be the only place to consume it so thought might be unnecessary. I will 
refactor this in v2.

Thanks

Farhan



