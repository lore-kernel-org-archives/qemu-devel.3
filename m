Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9896EC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtmMc-0000Dy-D3; Tue, 11 Aug 2026 09:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wtmMW-0000Bl-St; Tue, 11 Aug 2026 09:17:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wtmMT-0005sP-NJ; Tue, 11 Aug 2026 09:17:47 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BCVZxX3500134; Tue, 11 Aug 2026 13:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2OGt9g
 BsUi4J8PTVyKF1fkD8ytiFuj7t2gQNLP94I+A=; b=LHbJKyClIk+tFiFvqIVQcZ
 +M86DtSrIV/i+AintnCXKTsEDU2VFa7TBLz5adCWKhkmp0PoC2AG6NlmXAH0y9tL
 swSntUQ4OUtX4tLjCJtVxLsFjczPbMqhx30zd26zWqLcyCqHB6yvH42SjZRqLZiK
 RzEZP4iGllp8fg38knhPiSccukmn+bd/RjY8Rvaza+kVrHyVfuSAalSflYAuhqlM
 +Huqau/f5xN4FFQxQHjDJwc0HVJhs5Qk7VdeJIH/w2lUvwNEe5qaUkfxFfoiWb/7
 GOTr42YRQqTAxqZfsFlU+XLuKM4lpAMnne8GpxX0hjKsPzU80YEYjQ15INkMRoVw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23ns57-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 13:17:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BDBEmI013140;
 Tue, 11 Aug 2026 13:17:37 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h0xxt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 13:17:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67BDHaYd63046040
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2026 13:17:36 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 020E958052;
 Tue, 11 Aug 2026 13:17:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B042F58056;
 Tue, 11 Aug 2026 13:17:32 +0000 (GMT)
Received: from [9.124.218.109] (unknown [9.124.218.109])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Aug 2026 13:17:32 +0000 (GMT)
Message-ID: <97953d1c-8777-4e25-9669-16a5e2a47602@linux.ibm.com>
Date: Tue, 11 Aug 2026 18:47:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Validate HTABMASK and reserved bits in SDR1
 for 32-bit mode
To: sesame_h@qq.com, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, harshpb@linux.ibm.com,
 Minhang Zhang <zhangminhang@kylinos.cn>
References: <tencent_8A3172131A5ED2AD86D441389EB32CF67809@qq.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <tencent_8A3172131A5ED2AD86D441389EB32CF67809@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7b20f2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=dZbOZ2KzAAAA:8
 a=TO_pBULcb9OLBtObqa0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEwOSBTYWx0ZWRfX/AJfJUdG2nja
 hqeQTXp27puOF69DccShhms/eAHKM0Sz5kkYNdjG+yXA9Rpw3uKsTNY4CDl1y/WLsSgFKbTPSoG
 QBNYgywsxzUQgee5I4M+3mhZzuomtzJGLzv9Bb6E/wYZKFIO829l6adaz4k1K4vPMDTP+s+Nz1U
 dB3KCYkyR+jqeWUJBD1oQ5/omU5LDWcIWFIyz3I90E0a6gMXpKImRSH4eOZqDWa18ZOhNPyebDk
 OdqHyFliBhE6pJqyWfuHvnAFaawcEBKYyD1jTjzsLOBWepQREKBfdxqitVoAVkESpVLL+PNk+Ls
 hzPnWUopn7SATRuimU1dTESZgxB0DxO+F5ZGGzj6uNVBFMfP6EI5iyPAFv6Uru5weoqEio65rBN
 gsHa86E7lLPApmclmusXn8mVkfZW4lFm/uf0/l1w6PN3dElCKgd++zyytO0MUxmxyn6o+/JAT3c
 TZaAT2j6dgb/J8uNX1g==
X-Proofpoint-ORIG-GUID: c3ZC9JBPUN3jU7OnIyAgMh-8SMa1sLjy
X-Proofpoint-GUID: PKFRJqJusZir7m7jdV1_6GXccbZABMTV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEwOSBTYWx0ZWRfXzo4uHo5qrbvO
 3MxvHAkpZ9etsaHMYDcZiy170/QJ0QQxMMYHGQ7EoPy8l8lsqALZu/QL7V/2O53jvWDP/0rkjvb
 P2697ETXF0i26xj/ttP4jflwUe3WICQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110109
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
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

Hi Minhang,
Thanks for fixing this. Took me a while to get hold of the docs for 32 
bit mmu, hence the late response.

On 8/7/26 14:47, sesame_h@qq.com wrote:
> From: Minhang Zhang <zhangminhang@kylinos.cn>
>
> ppc_store_sdr1() had validation for 64-bit SDR1 values but lacked
> corresponding checks for the 32-bit case.  According to the Power ISA,
> in 32-bit mode SDR1 bits 16-22 are reserved (must be zero) and
> HTABMASK (bits 23-31) must consist of a consecutive string of
> 1-bits starting from the LSB, i.e., be of the form 2^n-1.
>
> Add checks to reject invalid HTABMASK values and log a guest error
> for non-zero reserved bits, following the same pattern used by the
> existing 64-bit validation.
>
> Signed-off-by: Minhang Zhang <zhangminhang@kylinos.cn>
> ---
>   target/ppc/mmu_common.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 2499e61..59e8324 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -57,9 +57,23 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
>                        " stored in SDR1", htabsize);
>               return;
>           }
> -    }
> +    } else
>   #endif /* defined(TARGET_PPC64) */
> -    /* FIXME: Should check for valid HTABMASK values in 32-bit case */
> +    {
> +        target_ulong htabmask = value & SDR_32_HTABMASK;
> +        if (value & 0x007F0000UL) {
 From what I see in the programming manual, shouldn't the bits of this 
flag be the other way around : 0x0000FE00 ?
Nevertheless, it would be better to form the mask by ORing the 
SDR_32_HTABORG and SDR_32_HTABMASK fields from mmu-hash32.h, instead of 
hardcoding it; the way it is already done for 64 bits in the same function.

Regards,
Chinmay
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "Invalid SDR1: reserved bits 0x" TARGET_FMT_lx
> +                          " set\n", value & 0x007F0000UL);
> +            value &= ~0x007F0000UL;
> +        }
> +        if ((htabmask & (htabmask + 1)) != 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "Invalid HTABMASK 0x" TARGET_FMT_lx
> +                          " in SDR1 (must be of form 2^n-1)\n", htabmask);
> +            return;
> +        }
> +    }
>       env->spr[SPR_SDR1] = value;
>   }
>   

