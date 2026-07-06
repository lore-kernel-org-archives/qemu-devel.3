Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B254C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 19:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgofj-0001z2-Eg; Mon, 06 Jul 2026 15:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wgofe-0001yF-RF; Mon, 06 Jul 2026 15:07:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wgofd-0002h0-8o; Mon, 06 Jul 2026 15:07:58 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666FIsGc757035; Mon, 6 Jul 2026 19:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ZNYduZ
 bpkSvJ30wmFuuyHx0a+UJB0Bl92D3QwrHwcPw=; b=XfSwzTis3AM4IqCIvMYR78
 eZCRHW2s8rvRoBU10qNwIaVTQGJ90sCBrNR3m7yaHCsPMrLpUudWA9s1Y6J2Rsvz
 CU1yUs+w+UZDvaI0duVlvAdq8SQo2USTlBUbie0Z2HmBKflcv3wxpJEFoQjkLoic
 IIlgAoRYMmTvsEyqJJCU7blNjHk4DXGasmOF1UExGyMQgdwtyaEB9pcUg3ZlE+x0
 wflU45nRA9PIDuqZVX3zM2fsQG/nNYlLET5z9jlTlWyFourgVxGfEkXM1EkscsWj
 TUkzKPtQA/d0qCL7ff1AUf6NNeI5kmhhOFOB9NO3MV4sDxYeV1/34ZjEueR3CzdQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknb2a1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 19:07:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666J4aEF006293;
 Mon, 6 Jul 2026 19:07:51 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfxnfw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 19:07:50 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 666J7FvA24707638
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 19:07:15 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 148875805E;
 Mon,  6 Jul 2026 19:07:49 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3694C58051;
 Mon,  6 Jul 2026 19:07:48 +0000 (GMT)
Received: from [9.61.247.63] (unknown [9.61.247.63])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 19:07:48 +0000 (GMT)
Message-ID: <01aa5c21-e683-4d4a-84d0-b1df212490b3@linux.ibm.com>
Date: Mon, 6 Jul 2026 12:07:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] s390x/pci: Shrink RPCIT ranges to registered window
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, qemu-stable@nongnu.org
References: <20260706091909.864405-1-borntraeger@linux.ibm.com>
 <20260706091909.864405-4-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260706091909.864405-4-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4bfd07 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=CQ8MyErfSB4qLgmcVMYA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: 2A0ur-1jETlnnJJc48eLN2rQXI6fkrgh
X-Proofpoint-ORIG-GUID: 2A0ur-1jETlnnJJc48eLN2rQXI6fkrgh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE5MCBTYWx0ZWRfXwt78ZtvrBWWl
 uoaingbHgw+sY9UM0IOtj1Bt8huZ3nya07mqXa6xANYncZeXGfT5m9KgFQSy+cebv1HxLNR8wdC
 XXnuKX19+/0IdKDOmKl8fb94VHuXdd4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE5MCBTYWx0ZWRfX61CuiuP4ZZOG
 yWDe/PnZWl/HTe8f5H3rziS5bc6EfTT47++yXFAAOuG/HOkaPoee6+/86/fqCrCLjYav93J+mEG
 CAu5NCHyMEg64aH7D1PFhDKu0egdOu6dLx0q2qeWlyoWWx6Dni8jYGZMG8+tY+78PcV/mStGff7
 BZAhOxDPFk5EXPQpgIXMkE4WFfhlK57uqTTOGWos4OhH6GHbHWNbLs86RWNi7oGme22d4RdQbAB
 8YzXrsrpIROl91z/7PeE+NIeOnbPK4AuZekCrM54iIqI+/rVoRa3GN0dzLDJe3yoa8pMesaO/iL
 I+CNJedqdzyjPZCx3FkQDrjaTHz6AxiESqX21+5PqyeZkfIJEIsBfmtqOcBgi15ILrtiKhcLDhg
 1CVSZTZhP4nLHr75l7wTVYs4+03FRxsBprimqZfL306HWfdIkRZCNOmmSy+E8zekXAmLkDrSRlE
 acEjiNR8flUxl3UaCOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060190
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


On 7/6/2026 2:19 AM, Christian Borntraeger wrote:
> From: Matthew Rosato<mjrosato@linux.ibm.com>
>
> Today, if a RPCIT instruction is presented from the guest whose range
> exceeds the previously-registered IOAT, QEMU will process the range
> so long as 1) the specified range at least partially overlaps with
> what was previously registered and 2) the guest has valid IOAT entries
> in its table.  If the entries are not present (invalid), then the
> RPCIT will unnecessarily spend time reporting the invalid
> region/segment entries.
>
> Optimize this path by exiting immediately if the requested range falls
> completely outside of the previously-registered range or if the
> requested range ends before it starts (which would only occur if the
> guest-specified address + length would overflow a u64).  Otherwise,
> clamp the request to only the portion of the range that overlaps with
> what was previously registered, effectively ignoring the portion
> outside of the registered range.
>
> Cc:qemu-stable@nongnu.org
> Fixes: 5d1abf2344 ("s390x/pci: enforce zPCI state checking")
> Reviewed-by: Christian Borntraeger<borntraeger@linux.ibm.com>
> Signed-off-by: Matthew Rosato<mjrosato@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-inst.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



