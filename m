Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D42FCD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZjgZ-0002BC-LL; Wed, 17 Jun 2026 02:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjfN-0001r0-BR; Wed, 17 Jun 2026 02:22:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjfL-0003pg-Sw; Wed, 17 Jun 2026 02:22:25 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GLnJWt2655585; Wed, 17 Jun 2026 06:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=xnwZbF
 x90X8io1/yJjA6B0vYUmxctagu2fgzmXer1cg=; b=kUPqDsQSUwmOzFkU0VByZJ
 Bugf/Vh7Tynxm8KwF6FvaRbG+tn0orTUOOJSmCEidQbsT2iCqUV/WxFj4XlRgepe
 4y8Sk1Tn4fAfbFg44O8lAgBQLhfd/Ec8/whWq3YRK8T9XUaGmzPUdlDHXK6wuZdA
 7aNIAWqKwodTlQXi8C/EYk6W83Ri6HVM1nLX7smSxhpciEnRmFnEfv7ICmdYpepV
 ncD+C23Dg/S1iQPvYSByCUeahq6hC7R0KFFU1Ko6/b8Pv+DoSJSO15CwTd/rM+UI
 fgEmC29W+BEt5+5gsT8TdHfXBrlza7CdCJVvIwviiRHjua2lyDq/XbHtm9rR/DHw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx9fqr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 06:22:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H6JjtK016974;
 Wed, 17 Jun 2026 06:22:13 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eudva9txd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 06:22:13 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H6MCfC26411612
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 06:22:12 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C51858060;
 Wed, 17 Jun 2026 06:22:12 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44AE05803F;
 Wed, 17 Jun 2026 06:22:08 +0000 (GMT)
Received: from [9.43.52.172] (unknown [9.43.52.172])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2026 06:22:07 +0000 (GMT)
Message-ID: <c9276fb1-f531-49be-bb43-42b1bba7162b@linux.ibm.com>
Date: Wed, 17 Jun 2026 11:52:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] pnv/phb4: Implement sticky reset logic in PHB4
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-4-saif.abrar@linux.vnet.ibm.com>
 <28b35521-245f-48b8-a97e-f77f08afecc5@linux.ibm.com>
 <91f9c6eb-5319-42d5-8c02-304ee16d904b@linux.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.ibm.com>
In-Reply-To: <91f9c6eb-5319-42d5-8c02-304ee16d904b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OcSoyBTY c=1 sm=1 tr=0 ts=6a323d16 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VhDJpBkvjiqVS8tfwcIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA1NyBTYWx0ZWRfX/gCzie8KVHkM
 ba7PT++LYugU6Ka195obJ/+7717qXMQl7FcfrBXxqQ1t/Ac102Vp8GllIsy8UhQ+4UwND/fGdaz
 /EY7hWsTbr73z0yGIeQ+56iP3D2WuQrdkzDVd2ik77STPi4XEmO+48rcPqOBHpu0KiqWXMEnFtb
 0uOjQKMmOI7NIgScmmXnkDAi6vAGLmuk7gD6RyrgnN38hUGy8fw3sAHPOnz8C8Gm2v9UyuGGpai
 YiBf72o3HMw1EnxOOQVRC5P+P6KlK3z/tG7nJXQ7eTrdlLAcFQUBSuMzv6uDnUlDQwqQijUOzLa
 RcNQIFPEV7ZntrKtNOEPGea6HCjcK1mjYTv3xWFUN4uHKxOBbp9Lt3nKKyfskXo2N6d/21O8L2w
 d5nBFhy2Nhi1sawd/lhcpSFpg7EjLOLtKa3BQGX9O1yqISeARc2fKaFtBspXqO8pCieZdzQ32eb
 3ko6K0PbjhKYFfeEuvg==
X-Proofpoint-GUID: pAXPE9nxkwuOdcYfq7gfTYOKB-Zj-t8d
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA1NyBTYWx0ZWRfX9ry20Xhqcrjg
 XqMmQIbFmQCsjmuG/B2u2XdSptZb5fKKvzOEc+MTIIrkMUHpvc9dqMAymrRtlBHcHUT/OAn07QW
 MktiivXCd9l79uA5If8z+3AB9m0sySI=
X-Proofpoint-ORIG-GUID: f-4gexFKBN42edcKb553XjJUf2WHhJjo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170057
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=saif.abrar@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Jun 2026 02:23:38 -0400
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


On 05-05-2026 20:38, Harsh Prateek Bora wrote:
>
>
> On 05/05/26 7:59 pm, Harsh Prateek Bora wrote:
>>
>>
>> On 05/03/26 11:39 am, Saif Abrar wrote:
>>> Sticky bits retain their values on reset and are not overwritten with
>>> the reset value.
>>> Added sticky reset logic for all required registers,
>>> i.e. CFG core, PBL core, PHB error registers, PCIE stack registers and
>>> REGB error registers.
>>>
>>> Tested by writing all 1's to the reg PHB_PBL_ERR_INJECT.
>>> This will set the bits in the reg PHB_PBL_ERR_STATUS.
>>> Reset the PBL core by setting PHB_PCIE_CRESET_PBL in reg 
>>> PHB_PCIE_CRESET.
>>> Verify that the sticky bits in the PHB_PBL_ERR_STATUS reg are still 
>>> set.
>>>
>>> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
>>> ---
>>> v3: Updates for coding guidelines.
>>>
>>>   hw/pci-host/pnv_phb4.c              | 123 
>>> +++++++++++++++++++++++++++-
>>>   include/hw/pci-host/pnv_phb4_regs.h |  20 ++++-
>>>   tests/qtest/pnv-phb4-test.c         |  41 ++++++++++
>>>   3 files changed, 179 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
>>> index 763e9c9776..b3f46f7fe1 100644
>>> --- a/hw/pci-host/pnv_phb4.c
>>> +++ b/hw/pci-host/pnv_phb4.c
>>> @@ -511,6 +511,18 @@ static uint32_t get_exp_offset(PCIDevice *pdev)
>>>       return rpc->exp_offset;
>>>   }
>>> +/*
>>> + * Apply sticky-mask 's' to the reset-value 'v' and write to the 
>>> address 'a'.
>>> + * RC-config space values and masks are LE.
>>> + * Method pnv_phb4_rc_config_read() returns BE, hence convert to LE.
>>> + * Compute new value in LE domain.
>>> + * New value computation using sticky-mask is in LE.
>>> + * Convert the computed value from LE to BE before writing back.
>>> + */
>>> +#define RC_CONFIG_STICKY_RESET(a, v, s) \
>>> +    (pci_set_word(conf + (a), bswap32( \
>>> +                     (bswap32(pci_get_word(conf + (a))) & (s)) | 
>>> ((v) & ~(s)))))
>>
>> Shouldn't we be using bswap16 here ?
>
> If 32-bit helper is needed, we need to use pci_[get|set]_long instead.
>

Using be16_to_cpu now.


Thanks,

Saif



