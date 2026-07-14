Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE5AC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjcWF-0007qs-EJ; Tue, 14 Jul 2026 08:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjcWB-0007q8-Sl; Tue, 14 Jul 2026 08:45:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjcW9-00085Q-Sf; Tue, 14 Jul 2026 08:45:47 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EBfY8o3511619; Tue, 14 Jul 2026 12:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=HhYwgm
 ynnSafL77DqvrOlsXxNsZKoj2Fs5JEu67r+5c=; b=UD8xT1rshGVGDolJLOwWDD
 a//caSN93233A6Rhq47VpGdTA0LZYO7k/LNtzD7iiVoYAxVTD0LMMDTCL2AWIgix
 uwlMQvTTqnEI46uaL/8BbN6oFD7b8msWDTOIkC+P6xyegJ7bwtYuOLQaoe2Ykyma
 ed1HRYqU2mxRKt1ty3SehDgM/kXMYDyosDdBmL+rONBr01pWXesKXGZSqUXpWUz+
 VDl+3S8G/s9m6WX404ViAY1kZDzPuB8e3M+uyC8B3hljngDdMDxGIWK1zaYK5SZC
 /J9ynPfHc17358STgInDBQiDHUOjWfXIALCfMCq+hCpR+BSh7GTD430OE9ju2ZpQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv336pk1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 12:45:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ECYdR6028534;
 Tue, 14 Jul 2026 12:45:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgakce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 12:45:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ECjcZI60752198
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 12:45:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C58912004B;
 Tue, 14 Jul 2026 12:45:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B0FE20043;
 Tue, 14 Jul 2026 12:45:38 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.75.242])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 12:45:38 +0000 (GMT)
Message-ID: <d8f05694-ef41-49f0-8587-d55a757cb186@linux.ibm.com>
Date: Tue, 14 Jul 2026 14:45:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/51] gdbstub: Report actual watchpoint trigger address
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-18-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710205401.836304-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzMiBTYWx0ZWRfX7Qn6OHj0eDjV
 Uo63BQuatWuBS+mYphRje/OBpikyVVSZiDshRUYYkA9N25v6Q7ox6PIGuuGnOxxMig37kjEpV/Y
 3OoZRO+Dgoci8v2FO2KE+IOYDuNJefo=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a562f75 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=ge5hdUQLQkj_eIuYbJEA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: -jnKQgiZxavSHLSh-jnGkdevD2wKw0OT
X-Proofpoint-ORIG-GUID: 2UYeQLxAXpTsPQBXTNRV46lQN2PNPojr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzMiBTYWx0ZWRfXxVr7Y3pOugaY
 QESumVyNzssAc4uxul+WaXOg8Rkclw5it3RL1pcaooIZMcGeYweUYHKpjyjEKoqJPtsAG2zIWhA
 h53dDVo2bFaUxqWHZYbfngYk0v2tO9cx2t1JSCds5K3fBDjm28e3sKt0FQHO6FqkWA9GBapmj8K
 EDAc2VH8HIZJUCmsZD390fI4ZeAKibfjOazgt5Mx+6bPgIU3l8s0SPVkwyYwyNmuGR64bAGwolk
 OWM0B/PTBKPzOdqEvIXjtkY+vSOBAnoQzpwlPU6FnkhLbX6tKeJE2xxaxhHBLOXB3S+jyrDV232
 RDhLYxec3jIPu7SvhdeCnn+YceGyga95WqWU6u8IDDoHN/iC3729W6yES/VVFm2hAopbJdKxTlA
 Uj/RPENPzakwA51UjiaSN3Rk+eUXSO0Gd/Tw77LBw1WLqvDNE0usETBQe8zWznV2uDLBbLwxNzG
 WELY86fdCu8d045Z9cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140132
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



On 7/10/26 22:53, Richard Henderson wrote:
> While gdb doesn't care either way, it seems more correct to
> report the address of the watchpoint hit, rather than the
> beginning of the watchpoint region.
> 
> Adjust all virtualization hosts which construct a dummy
> CPUWatchpoint structure.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   gdbstub/system.c       | 4 ++--
>   target/arm/hvf/hvf.c   | 1 +
>   target/arm/kvm.c       | 1 +
>   target/i386/kvm/kvm.c  | 4 ++--
>   target/ppc/kvm.c       | 4 ++--
>   target/s390x/kvm/kvm.c | 2 +-
>   6 files changed, 9 insertions(+), 7 deletions(-)

GDB seems to be copying stopped_data_address around quite a bit, but at
the end of the day it seems like the only thing that matters is whether
it's present or not.


Reviewed-by: Ilya Leoskevich <iii@linux.ibm.com>

