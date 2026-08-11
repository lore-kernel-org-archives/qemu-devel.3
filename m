Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1363C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 17:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtq73-0007Vt-IZ; Tue, 11 Aug 2026 13:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wtq71-0007UJ-0U; Tue, 11 Aug 2026 13:18:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wtq6z-0004nW-KU; Tue, 11 Aug 2026 13:18:02 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BGVY9e4029538; Tue, 11 Aug 2026 17:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UVJGL9
 Vo9HQz3OHEUN5wGRLlrcnCh1whhn6gyJOtRR8=; b=shqZExRXLPurDAUj3qUKqV
 F+FABoOUXFG38vrNLD2q/5BsM8i+ADOK8GaVmAinnEfS2y/EWQNO3EqmAWh/mBVn
 FN0KoGQvHYAQpTCOHpyzzgDDkbxAfqb8UqRVzLT16zKfwuk4DojdjS36/TdKscCq
 JkQc3ffWVuOiSi3QYU8FPcDJEL1VKgWym2Na+5+AzSKB0P07nW8oQSTCHAL4QAiE
 zpuIK/zpMj6iW5vcN0H9kPaGQ6FGLZMerrqKoiYr4MxJrwv/SdCrai9+Y+2gwvwa
 5mhNM/q2mHtYkvTM1wrr4nRyfcpRbb+iFcQPoz5GLjDYFvL5XULRA1TUx4IWR5FQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23pukt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 17:17:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BHBJHj028286;
 Tue, 11 Aug 2026 17:17:57 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjsy2k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 17:17:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67BHHt6C60883352
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2026 17:17:56 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B80B05805A;
 Tue, 11 Aug 2026 17:17:55 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3D9B58052;
 Tue, 11 Aug 2026 17:17:54 +0000 (GMT)
Received: from [9.61.240.229] (unknown [9.61.240.229])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Aug 2026 17:17:54 +0000 (GMT)
Message-ID: <fd106f03-b83c-4474-8606-6b1459ed7e32@linux.ibm.com>
Date: Tue, 11 Aug 2026 10:17:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/15] s390x/pci: Remove a ptr to S390PCIBusDevice from
 S390PCIIOMMU
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260807170812.658820-1-kshk@linux.ibm.com>
 <20260807170812.658820-7-kshk@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260807170812.658820-7-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7b5945 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=zUHB8zuuR7IJGuvsoxsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE0MiBTYWx0ZWRfX86LBU4KgzlY/
 GuYDdjoPlbHDaT1ujksKVMlXV9B2Yz8j8D8idzffWJ7wRtOX5QJlt5r+R5UuezRgKMEkAYHQNiq
 HVYwvStDEGl+VVR3QNbQzBPTULS1GTs5SX5D2DvSHQk2fNETO532pTubIzmOn8GNHjeTKkMq3xW
 +zb3zvcrYwunNKL1Uc5tLZPQbLcncjjRLotJ/6wn5VArXmmeSu7LfuF9Z7YyhznbAV3eJ2B7IXQ
 92/iPTcegqJad5sZ+zwpwIItwv68zVEWG8OuwGLh/eNHML6TWpWeRc2DmIZ1Nt4qg2NVYe74ZD1
 LqUtm76k8N2mmDDCloauMbYBxaIQKn25uYkvcTgyoyf3jWNpa4l2mzwP6VeTV8lnVyi3JuEgknM
 kEhtryVO/Ku7IgDmlMVewqYwQAm6EPYVjmx3U5JPpRAt6qWj8FgJ2uvY6rGxjXZRVaczyjdjXJn
 DdypNoHgXp+YYwS26Ng==
X-Proofpoint-ORIG-GUID: qdlKneQnKiErxK-bSfxeLHYEU6sUxTXL
X-Proofpoint-GUID: qdlKneQnKiErxK-bSfxeLHYEU6sUxTXL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE0MiBTYWx0ZWRfX9PO7QvTK0g1R
 7TxVk0/gE8U14nZ5yQek+D9zHlmf94N48UwXZYe5uAm9o5adJm0/voX/g34QwVDnl+g/6HQ5QFS
 ENgFgvRoWfRKTDheS8wBLalFl5rcKa8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110142
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


On 8/7/2026 10:08 AM, Konstantin Shkolnyy wrote:
> This pointer is no longer used, after fields were moved from S390PCIIOMMU
> to S390PCIBusDevice.
>
> Signed-off-by: Konstantin Shkolnyy<kshk@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c         | 15 +++++++--------
>   include/hw/s390x/s390-pci-bus.h |  1 -
>   2 files changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



