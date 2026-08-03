Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67798C55182
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 12:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqrbU-0007e4-OB; Mon, 03 Aug 2026 08:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqrbQ-0007dS-4n; Mon, 03 Aug 2026 08:17:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqrbO-00005B-Bs; Mon, 03 Aug 2026 08:17:07 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672Llp5o243824; Mon, 3 Aug 2026 12:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=L5AJbh
 RlrS9E9peb96SJWWUmtPYs0/a/tQXm/5IJnVo=; b=RID2c3Nd/mu55u33B4UsVc
 E8on05Edh7cfxDfPM4bVEZC4OT3RfJu/5CjBjQfoNQFGNTTZDfAj22inqWbIyXJz
 XiDsKbafT2LXu1NyTyZDDxmHSWFXbXafOwWW/hz6GZ4gUM7vJ9ZQS32DcCIFYo22
 jvexGdhvbZHF00AEfT3OCfMD7gT3+PtpAsNupVLBlhWFBY+Jp94e6Vks4uh3peVM
 UiVfPtd/Mg1/zjbR/VwYO1nTe+2lfgcsC+7bMm3BU1BuHmjzJcPok3GTxdt4obcY
 TcK/r8bGbQ5jUsWUddLwto11QOOxVsfzF36mSX0wgp4nWQU6q5bhTZkivL0IgPow
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4rmhf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 12:17:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673CBj0f009140;
 Mon, 3 Aug 2026 12:17:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyd14n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 12:17:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 673CH1Nl26804504
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Aug 2026 12:17:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12F642005A;
 Mon,  3 Aug 2026 12:17:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCD4E2004F;
 Mon,  3 Aug 2026 12:17:00 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.49.55])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Aug 2026 12:17:00 +0000 (GMT)
Message-ID: <17db4534-53f8-44dd-8484-f673d120a8fc@linux.ibm.com>
Date: Mon, 3 Aug 2026 14:17:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] target/s390x: Simplify LRVR
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
References: <20260731185628.23161-1-richard.henderson@linaro.org>
 <20260731185628.23161-15-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260731185628.23161-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwNSBTYWx0ZWRfXxbjHZVD9T+Jc
 lzaPLJShqQVxBo/G8GE3Ij4pkgWwzbeecPU8VaelqcbLQ8qkciuvUiUpLF6dNzufpZbzafBdj3C
 QbVbQkeMBThd40ekQ3Ea1aLFLZwBssA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwNSBTYWx0ZWRfX6dn7rh77l8bf
 psdfr+iebxlj5wzmRSj8KVlq1zPZw+Pxqad5j8je1/0IujGeVuGqXvHUOb2ifgROEVy3Yk2A+Lz
 M/IOwjXbZiz2UcPbH0k08+y7nYrGMMZEM5T9r0ceQs7gbkkLSOIyScsGtYGPYRCG3XyQJiswcZ9
 vi4LNgqEbM+CPzKEWl5YRU1RD6rCDKi5kOsZk3vXYz8wcGoYtmgHJhQFu48NV9orkS4vn9jsfsA
 gadmindoYlL+KWIsHmWF5maVMtVxwKBY0/6lXn13RCTuaCILUVFgFo8I51UzPDEFoxS7Sh7R77Z
 wzT4sHr+onp0foxbDYmtRySHFU4PuPQzCuRojl5eNRbzGDNVCTKjbpayq3n6WzeCB+j7/FV2iYJ
 rdNcPyaog6chEsicgFeCBXCNW1ffDZEBMdt3EkVewtxHxzn8LGun0yJ6XasBzjCkOV0meCU8TyK
 tHputZoUN//2Ze8pYAA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a7086bf cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=5zL2Hipd8QgHIU9NEIYA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 18nE96YoB83XcbP64blgjEZEiKNdwI25
X-Proofpoint-GUID: 18nE96YoB83XcbP64blgjEZEiKNdwI25
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030105
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



On 7/31/26 20:56, Richard Henderson wrote:
> If we drop TCG_BSWAP_IZ, we don't need to zero-extend r1 on input.
> Since the output gets passed to deposit in wout_r1_32, the high
> bits of the bswap output need not have any specific value, so we
> can drop TCG_BSWAP_OZ.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c     | 2 +-
>   target/s390x/tcg/insn-data.h.inc | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>



