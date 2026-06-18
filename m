Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9895DCD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCAA-0001jv-Gg; Thu, 18 Jun 2026 08:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fcallies@linux.ibm.com>)
 id 1wa5Z2-0007EF-4l; Thu, 18 Jun 2026 01:45:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fcallies@linux.ibm.com>)
 id 1wa5Z0-00055Y-Iy; Thu, 18 Jun 2026 01:45:19 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HHnElK979390; Thu, 18 Jun 2026 05:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YdQ54H
 7S7LT+jb3Ctuc5OQZ/JikAaTTJJHUsT6yHa9Q=; b=rS0/VG0mqpD6il3skRg6SW
 90TmvdNXG6J5+OUYsBUWm1Ltbcd827V0Xjl0r8LoQEQq0ChLEA6uILOIUEndE1Rv
 x9C09rTq2SbC095fQYG9xI1QMmHgbrXxCo/Vf2T48NjZDclSSvwi8pR72/bSIJIu
 w7r1ZWAPn7CXG5Rl/B03hK3R74hI9pfetpURsdbs5w6b+U4cffYzIgO/Y70ZhxNt
 3ETJtM4xSgzvVoelXxoDw3wite6Z43Aw/dMlaJ3eLy9Bzsn8r7cDWrjPy9tyg3OV
 NivskBsDpLfpNr5YmNFcihmsoM0wuIdPIO17T3TmSyUnArOIteqS20of/ftq15hw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx6e60-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 05:45:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I5Z0Jt032180;
 Thu, 18 Jun 2026 05:45:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172a66q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 05:45:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65I5j99p50987436
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jun 2026 05:45:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A70A120040;
 Thu, 18 Jun 2026 05:45:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75A922004B;
 Thu, 18 Jun 2026 05:45:09 +0000 (GMT)
Received: from [9.224.89.241] (unknown [9.224.89.241])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jun 2026 05:45:09 +0000 (GMT)
Message-ID: <f3d24c22-ae20-4f06-9c08-4fb7063d2c23@linux.ibm.com>
Date: Thu, 18 Jun 2026 07:45:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/17] target/s390x: Support AES XTS for cpacf km
 instruction
Content-Language: en-GB
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 iii@linux.ibm.com, david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, cohuck@redhat.com
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-9-freude@linux.ibm.com>
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260617094820.34402-9-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L180RiLWnN2vzZjrNpC5zp28Tw1_3kbY
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a3385ea cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=E14sLqMX2J24vDWi-R0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA0NSBTYWx0ZWRfXzwsYs5ICb+Wk
 Fc/p7tqsIFx4JHYUO9MOMNrKjHdFVg7mlAF8h04jjczSIM8rQMCjHdSdNzwVNLgD4uyVVwIrEoG
 qYERBv1lPTJuj/fmHj5Yagh1JKiTLSM=
X-Proofpoint-ORIG-GUID: L180RiLWnN2vzZjrNpC5zp28Tw1_3kbY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA0NSBTYWx0ZWRfX3v7HfWqXqd5q
 9GVhvLDC2LRcwLLoM5MEQT2jGK/MbiXD2NHBPdBk5Bi/0+uSyaTAgsISsJBSNXSE5FkptVtC1dV
 oeztKY+HeTjHc5zIT0+WZ05g2u1vHLKfT72GT2NHFhGlZi0bzn4g9VvwYBkpz46bBkSnrFGz3qm
 5Q2D1Y7zGWMygZ4lN28UptHn4NmgEI4g7HFcsH0whTgtqU7uFhNJslb3//cvsyyMZENFt3KTvPa
 i5VOKuBAdC1kpNwuq32irwYrJgNW9cDGtEwBhNzlOtkvmvLzytfV/gjf60dRlgCAOBLF/ZiSHyl
 nosRWKoLBBvkZYv0uzzSVeBK1UiVhhj+eGfentBlIXB1NCv12HUrruRePDtz1baSm5uXiXfoNQV
 Nz4ZmCbEIW/w+niyKuStEEy7uPY8KXqbrnNbAetQQGu7W/fwN17VZ/tRvSWbmrZI1ZcSDzHykvW
 HNXY0YQ3L3pJoOjkiug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180045
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=fcallies@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Jun 2026 08:48:01 -0400
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



On 17.06.26 11:48, Harald Freudenberger wrote:
> Support the subfunctions XTS-AES-128 and XTS-AES-256
> for the cpacf km instruction.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |   2 +
>   target/s390x/tcg/cpacf.h         |   4 ++
>   target/s390x/tcg/cpacf_aes.c     | 107 +++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |   6 ++
>   4 files changed, 119 insertions(+)

[ snip ]

> +
> +    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
> +    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {

I guess this has the same "feature" as the real xts where the pcc part 
is not included if not explicitly done beforehand by the user right? But 
since CPACF does it that way I guess you can't do it the "correct" way. 
Instead of XTS + PCC you could implement Full XTS... just something to 
think about.

> +        /* fetch one AES block into buf1  */
> +        aes_read_block(env, mmu_idx, *src_ptr_reg + done, buf1, ra);
> +        /* buf1 xor tweak => buf2 */

[ snip ]


