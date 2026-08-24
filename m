Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA91C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyUOt-0004Xr-3g; Mon, 24 Aug 2026 09:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wyUOq-0004Me-2P
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:07:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wyUOo-0000f3-GP
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:07:39 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD1dSn1936003; Mon, 24 Aug 2026 13:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=pmg+73
 z5P8uhcb5TwqWcGWZ5b3W4A8jAvVF2LtQa4FE=; b=K2Kchwplei7So1V91BFDrX
 aI31nbCX3fZ8yWG2sXFUyVzSA0tAb7tu18cizcTJB891Tl7O2fyiZ1Tqv+pOzQ5M
 Ni3x+LlZYb/8l4u54H7724vTjUdVOiW4diYCLRXS1RAdKciDwz0m10GUe7oS+mai
 kRzT+tH2jHwBa7Aty2+ZljmBLSjSu89wMA5VQWMdypEQ45iMcJFByX7y0D77LMDU
 L3url3TwR8jvb3hM51sCa52Fj54oMtyDiqTtyTd0rUOK8zVFFszCmBrd0+yG4LQA
 sCIEwdpnk03+vc9acTC0FsbZcCVFpe3+6L1cHODuUwZ+WrD8uk175gCqNYE0ZIGQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7393sfkk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 13:07:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OCvAFR007479;
 Mon, 24 Aug 2026 13:07:34 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfvx52f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 13:07:34 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OD7XDS31392328
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 13:07:33 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC58458052;
 Mon, 24 Aug 2026 13:07:33 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C6DF58056;
 Mon, 24 Aug 2026 13:07:32 +0000 (GMT)
Received: from [9.124.213.171] (unknown [9.124.213.171])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 13:07:32 +0000 (GMT)
Message-ID: <a29af509-75dd-4f42-b8ae-6589cbb3d19e@linux.ibm.com>
Date: Mon, 24 Aug 2026 18:37:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] target/ppc: PPC ISA 2.07 flag cleanup and updates
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260820142717.337686-1-rathc@linux.ibm.com>
 <42b7ff75-6d1a-4486-a2a5-772dd729a780@linaro.org>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <42b7ff75-6d1a-4486-a2a5-772dd729a780@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8l2PCwgK-j4Kg0pkUjMo1__JmB-ebWNQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEwOSBTYWx0ZWRfXyMwtlkUYkAJj
 nHQnmeP7FyP8kxDVjFfizX1TKZmrAsdRsGB3jN+JfbKD4P60SuxCrYjmFA3C4P36rF1cx1MqIN2
 R29t0ZrUldtYRzt7uE3UshQb9TLnIxoxS1iSbBbh3SwSBGRVm9LVo83ZhDmke74Ny4QpFVhE06c
 0Q0uzN3LYQAA0m3dLkvzTLRmFHCHOgq7VNJEM4N4USEeikSspnzQwhmpBhWPnVUJhUAxu8cBd5G
 BEB9tqT6wkIES3ep81q1q+S6STQG5vLVGs4hhlX+ZlOgl9YorgK/moI+tf2yC8UEizchr4yIYjf
 RhtPdRUMJLANe57nnLMt9mCS82iFMIe6jMBLh1Gv5PFdyxMHiYhZm6MiwlV1JIa5vXeEwbA2OBl
 KQhTf29G/hCV7Ac+CkfmFapxfgLGaENlCgg7rpxXqXKfIv0eWQVF8yBdvXlTou1G7gljNQQK7NX
 dx+IcLkN4ZyIJAi6lag==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8c4217 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=KKAkSRfTAAAA:8
 a=f9oWXPKYZ_FP_3Z52vYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEwOSBTYWx0ZWRfX5EsKXHNHBK3w
 HM495Sm5Evc5rA+yPS5d6z/Kpd6bGpxsz69zj9M3+rT7S6iz0bcUJJm62KQHPoGKJwkFHg7J9D+
 zk+UAeFjTZrxYZsk5Y+4GvpKanJeXMI=
X-Proofpoint-ORIG-GUID: 8l2PCwgK-j4Kg0pkUjMo1__JmB-ebWNQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240109
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 8/22/26 02:14, Richard Henderson wrote:
> On 8/20/26 07:26, Chinmay Rath wrote:
>> Chinmay Rath (7):
>>    target/ppc: Replace PPC2_VSX207 flag with PPC2_ISA207
>>    target/ppc: Use PPC2_ISA207 instead of PPC2_BCTAR_ISA207
>>    target/ppc: Use PPC2_ISA207 instead of PPC2_LSQ_ISA207
>>    target/ppc: Use PPC2_ISA207 instead of PPC2_ALTIVEC_207
>>    target/ppc: Use PPC2_ISA207 instead of PPC2_ISA207S
>>    target/ppc: Reorder PPC2 flags
>>    target/ppc: Add ICBT support for ISA version 2.07
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
Thanks Richard !
> r~
>

