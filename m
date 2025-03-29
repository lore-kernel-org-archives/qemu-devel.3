Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B96C36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 06:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyPJR-0001PS-V8; Sat, 29 Mar 2025 02:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1tyPJQ-0001P7-Qu; Sat, 29 Mar 2025 02:04:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1tyPJO-0006A9-R9; Sat, 29 Mar 2025 02:04:56 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52T0Nwtp029535;
 Sat, 29 Mar 2025 06:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+ZzzJH
 3p2rV1zvGbybtVUm7eLx6a4Pa47nY+lwOtCEs=; b=N1JwwQg01a1uQphN7z8+Qx
 ZtqeWV1iT3xih3gd4+E8Zoap7Vt5daygQyIThmq9IY30SahB7Stuk6SGk14zO0zn
 aCWy4BPaZ0pVjCgzTiy3yrCFVy20BorL369A2SnQiqYbImZchm+Vj2zIPjQQu+Wy
 ZH0jkFuPKthHuTnwdyQITDuNw9wG2fIzWwzK68xxf0Tje1iEF0e3hQLnwEaENyUy
 SiUJhgFb8Qzb3q3dt7wRpymtUZ8FbmeLqMQl/Lae2y7diRMyNNETSjjaeZiTR0dx
 RUDMkE1Wu8InIYp1gkHcHBK9Nvg/dtCHy58/Y03Gk3vKSJZoA4CGUeHTvgAAAmIQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45p69ns4g3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 29 Mar 2025 06:04:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52T2m6Si030299;
 Sat, 29 Mar 2025 06:04:47 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7htxndw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 29 Mar 2025 06:04:47 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52T64lWM23790324
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 29 Mar 2025 06:04:47 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15C1058060;
 Sat, 29 Mar 2025 06:04:47 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B5FD5803F;
 Sat, 29 Mar 2025 06:04:46 +0000 (GMT)
Received: from [9.61.241.221] (unknown [9.61.241.221])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 29 Mar 2025 06:04:46 +0000 (GMT)
Message-ID: <12d6079e-5972-4055-91ea-34eca56dc388@linux.ibm.com>
Date: Fri, 28 Mar 2025 23:04:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] block/nvme: Use QEMU PCI MMIO API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: mjrosato@linux.ibm.com, schnelle@linux.ibm.com, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org, stefanha@redhat.com, fam@euphon.net,
 kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com
References: <20250328190627.3025-1-alifm@linux.ibm.com>
 <20250328190627.3025-4-alifm@linux.ibm.com>
 <43922be5-e1cb-4a57-8341-4a9dea9c6af4@linaro.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <43922be5-e1cb-4a57-8341-4a9dea9c6af4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QnGB9h9BIMTcbc4dUDk6UYMCB0h1h15G
X-Proofpoint-ORIG-GUID: QnGB9h9BIMTcbc4dUDk6UYMCB0h1h15G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-29_01,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503290040
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 3/28/2025 1:41 PM, Philippe Mathieu-Daudé wrote:
> On 28/3/25 20:06, Farhan Ali wrote:
>> Use the QEMU PCI MMIO functions to read/write
>> to NVMe registers, rather than directly accessing
>> them.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   block/nvme.c | 37 +++++++++++++++++++++----------------
>>   1 file changed, 21 insertions(+), 16 deletions(-)
>
>
>> @@ -805,16 +807,17 @@ static int nvme_init(BlockDriverState *bs, 
>> const char *device, int namespace,
>>       bs->bl.request_alignment = s->page_size;
>>       timeout_ms = MIN(500 * NVME_CAP_TO(cap), 30000);
>>   -    ver = le32_to_cpu(regs->vs);
>> +    ver = qemu_pci_mmio_read_32(&regs->vs);
>>       trace_nvme_controller_spec_version(extract32(ver, 16, 16),
>>                                          extract32(ver, 8, 8),
>>                                          extract32(ver, 0, 8));
>>         /* Reset device to get a clean state. */
>> -    regs->cc = cpu_to_le32(le32_to_cpu(regs->cc) & 0xFE);
>> +    cc = qemu_pci_mmio_read_32(&regs->cc);
>> +    qemu_pci_mmio_write_32(&regs->cc, (cc & 0xFE));
>
> Extra parenthesis not needed, otherwise:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>
Sure, will fix. Thanks for reviewing!



