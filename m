Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9811C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQle-0001LO-Ob; Thu, 16 Jul 2026 14:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkQlc-0001Kb-AT
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:25:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkQla-0004Ww-CA
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:25:04 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGSqlm3301975
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KIOst/QVY/uMwNwrWmJdwqpr5OV9vYaDLLOs+fIzpdQ=; b=ffJ8CPYPxPW3W2Rv
 yqqOptf3XIe80RsyW3lRf9r3jlpOeXeJfPScXwiwQFSSiUhdnlXg82V94NKVA4W4
 mEI0dcSgei9d99RtdRUzXeq8PAZZl6Vcer0agHMZ3q8GV5zDzMbGMfozQGdzzz8g
 sXezWKxeMx9wmWlmf1OgDPYkgyEJXtBXXboYatn78pyJZdCQV3f990CNo4cS3f/b
 2ZvmSNABwytQBezmGiuNIO8af1oklx/RQc+0d/oYS3n4FWTDAcZspALVkcyMlDcT
 GQgbpBVlciW5jS0du3JvtCgeLU6V85oIEHo5bTOLD2UrHggJhuxUdMHMFcgxR1KL
 JGvWzA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feuex2qvm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:25:00 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8f08560ea44so69275856d6.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 11:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784226300; x=1784831100; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KIOst/QVY/uMwNwrWmJdwqpr5OV9vYaDLLOs+fIzpdQ=;
 b=aB/Q0ieSX3/YcmHb1YS+B4H6BxbAaZz5agLGF0zlpvQnuG8BX5hHfO/ghue6M5NN2x
 5pORk3A797SUns9272iGGBiNJCQa2wmZml7mvSIc0F8GsU29ecuTrFECoF+chQ+7ZY+b
 149K1XKOghpDK77ts4hmnL/YbFtS1age5orlEe4J+LtFax0py0ERgyCue3bEyWhPmj/w
 3kvSQ02dstLG89Hp+2Br80EUbUAspjJ4PKIvkaUXUalLluidLW5a4mIpp9DI6FXrW3Mb
 NLFl1U7dlRccoxx+OLQqgxjhaDM7tHCgLF/Z/OaiZf1rAycJ0rHAO698dpbnLoIk6/CS
 do2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784226300; x=1784831100;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KIOst/QVY/uMwNwrWmJdwqpr5OV9vYaDLLOs+fIzpdQ=;
 b=HiidyehKC4l8vYoHg5hJS6rCo40wcbJNVXj1eZF1xKandsUtP3WM4YVcU7vzeAM2Dq
 NgCIp/3vgL+SUI7064HgYdOJ4qW6rRDZifScSYnEjURc+IKP04IbVHPBWrJi35LoKOeV
 8LWzzX/UJ0I2jMp6AXi7WqGckl0BVQ5hRtzomYWmI2aeP8Szv1Dyz8JlaJNVIv3RTQE8
 qZQ50V00MsaYInnGVnd0dRYUPbemTVipZHmS50Q9POykD81b94oF2VHhl1fjD4uWIrtV
 SQWcFB0W8INkjh7TP/f/xTDO4GRgPHF60FfSfROhvmJbTqRI5LI1frzQRkux2coMGS5I
 voTA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrU/U7iQu29OVV54yQhrzYhxti5XOlpl84RejL8klvBg426uKMD+O2HdKxkb9esjpFmL5hPOpCdq52b@nongnu.org
X-Gm-Message-State: AOJu0YyM/PKOG1ekQWmpeKZyH/fZxQjYLWpOLR0rbhesBf9KGxaAD1/n
 qDsXBYnEgMs1yRT8lpxV5nxA4rOfIKVplQ06KpUR99GvrDmSxNXOETygn8sPcP1ItO7KfZ3YYa0
 ekJtmOmZla90RwcGvRD3oER1/IBrUiG4T2CkUKiLC3bGg++Bwg7ooFWRs7g==
X-Gm-Gg: AfdE7clODcrstWd3MnYZNf7DZ/oXEkjM35nFyANEmoPh0ir2LU7AGAL/EVq5Ecspz/f
 Z3kzg4LCQuzhyhK5mVBGBAlKjAgEMC2KLUBTQOaK6pZxyuuafs87/SPl4a9701Xi5wcFEVWJrdo
 fuSNr2lwNqPOMf+a/gfoVRZHzr46NHYhxidOJGeeOQm/MwHRG/ZegTTj/Ryapa7MOBTuDnXT8Ug
 1mGTkCWeEr40Pl5V+4/Tmd1hkYE1bft2QyHi03tgfUAeIvaRfvM6pOxELHOciYDSiBnCWSC+zGX
 woXTSeb1Xi0b/+0ACEF2LIT9q/5J0eaFHcYu4B6nqJk4kSg/KjryEV+IbuUNjRrUk95IwnGEHTj
 Bwg7wxz88k8HjReJ77lAovCoHpWww1brlyeup1g==
X-Received: by 2002:a05:620a:640a:b0:92e:529b:b802 with SMTP id
 af79cd13be357-930b0827c95mr63498385a.70.1784226299466; 
 Thu, 16 Jul 2026 11:24:59 -0700 (PDT)
X-Received: by 2002:a05:620a:640a:b0:92e:529b:b802 with SMTP id
 af79cd13be357-930b0827c95mr63493985a.70.1784226298806; 
 Thu, 16 Jul 2026 11:24:58 -0700 (PDT)
Received: from [192.168.68.105] ([152.234.123.183])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd248e666sm223119276d6.0.2026.07.16.11.24.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 11:24:58 -0700 (PDT)
Message-ID: <ba4ea9a1-dd4d-4a96-aca5-1c14193420cb@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 15:24:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] disas/riscv.c: Correct indent for checkpatch
To: frederic.petrot@univ-grenoble-alpes.fr, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: julien.thillard@univ-grenoble-alpes.fr
References: <20260716154615.1545145-1-frederic.petrot@univ-grenoble-alpes.fr>
 <20260716154615.1545145-2-frederic.petrot@univ-grenoble-alpes.fr>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260716154615.1545145-2-frederic.petrot@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JeeMa0KV c=1 sm=1 tr=0 ts=6a5921fc cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=szoPuAicwqWYzOEwwuIrwA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=9Zw2DNSAMAMWkiGVaAMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: XmZNB4EU79V1HvmAEhoeNgPscg3jV1yX
X-Proofpoint-GUID: XmZNB4EU79V1HvmAEhoeNgPscg3jV1yX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4OSBTYWx0ZWRfXzO8llasUTjhE
 ggZA64kkftlPjU2ZqghuxPQaHfXu1Lh+m43A3JWTxmFccw0aXDYjW4Im1yepgoQskzC8qTeyXvm
 XavogIDoD3KXMaUrpRRLIoNYAeDgil4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4OSBTYWx0ZWRfXyk/q7CHQ2Lhp
 2IqyszTaS5Rx/wCWf9G+1L6xEWyqOYwjJNHg3H5re6i7CckluD4R6zzsAMC23mrw2PsLubW4zIU
 uCUqf7QHifdrKrr9pLO9FbEmbhkkCPkVL1iEceJ5K2NNWuxT7m5F0WWqyq7zHjvTbDpKBMUoSi9
 AQy5+mVeHpIZq13zOy44ZdrLXYF3cT69nzkug4+kWHZc0l6ith+8IjRwYp+ppan0fnQ09+yOvzJ
 jsTUle3d6YCgQ8nRHQ2SXjZ03+AH5oTpfagMaDx8FUjP1Q463QLILdj48pr96DJHRRumn6JfAR5
 HRS/Gvk2WkPdqA0dStwITVZ/FeIWNkGIFKy2UAOxiUPQ2BXl2SGVM5Qq7zcO6BGUNGC515mf8e8
 zMd5PHpKQmO7W7cBTIGKzWUL3LrZs0Km87JmDXdVW/QJtDAFfEOyIYqp9mk4E+4X85tGYesW7zT
 /gudaYuOSt2DCEkzXDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160189
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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



On 7/16/2026 12:46 PM, frederic.petrot@univ-grenoble-alpes.fr wrote:
> From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> 
> Trival indentation patch on the cbo/lq relevant code, in preparation

s/Trival/Trivial


> for modifications in that part.
> 


Fixes: 9273cda722 ("disas/riscv.c: add 'cbo' insns to disassembler")

> Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>



If no more changes are need I believe the maintainer can fixup the typo before
queuing. No need to send a v3 because of it.


Cheers,
Daniel




>   disas/riscv.c | 38 +++++++++++++++++++-------------------
>   1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 7f1b262773..689502f083 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2887,25 +2887,25 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
>               case 0: op = rv_op_fence; break;
>               case 1: op = rv_op_fence_i; break;
>               case 2:
> -               /*
> -                * 'lq' shares the "(...) 010 ..... 0001111" opcode space
> -                * with 'cbo' insns.  Check the next 5 bits to select
> -                * what we want:
> -                *
> -                * cbo_inval  0000000 00000 ..... 010 00000 0001111
> -                * cbo_clean  0000000 00001 ..... 010 00000 0001111
> -                * cbo_flush  0000000 00010 ..... 010 00000 0001111
> -                * cbo_zero   0000000 00100 ..... 010 00000 0001111
> -                *
> -                * Anything that doesn't match these will default to 'lq'.
> -                */
> -               switch ((inst >> 17) & 0b11111) {
> -               case 0: op = rv_op_cbo_inval; break;
> -               case 1: op = rv_op_cbo_clean; break;
> -               case 2: op = rv_op_cbo_flush; break;
> -               case 4: op = rv_op_cbo_zero; break;
> -               default: op = rv_op_lq; break;
> -               }
> +                /*
> +                 * 'lq' shares the "(...) 010 ..... 0001111" opcode space
> +                 * with 'cbo' insns.  Check the next 5 bits to select
> +                 * what we want:
> +                 *
> +                 * cbo_inval  0000000 00000 ..... 010 00000 0001111
> +                 * cbo_clean  0000000 00001 ..... 010 00000 0001111
> +                 * cbo_flush  0000000 00010 ..... 010 00000 0001111
> +                 * cbo_zero   0000000 00100 ..... 010 00000 0001111
> +                 *
> +                 * Anything that doesn't match these will default to 'lq'.
> +                 */
> +                switch ((inst >> 17) & 0b11111) {
> +                case 0: op = rv_op_cbo_inval; break;
> +                case 1: op = rv_op_cbo_clean; break;
> +                case 2: op = rv_op_cbo_flush; break;
> +                case 4: op = rv_op_cbo_zero; break;
> +                default: op = rv_op_lq; break;
> +                }
>               }
>               break;
>           case 4:


