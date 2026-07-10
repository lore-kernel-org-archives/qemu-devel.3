Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA058C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJZD-0004w5-68; Fri, 10 Jul 2026 18:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJZC-0004vx-3G
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:19:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJZA-0005FJ-FE
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:19:29 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3S8A1697345
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9FP4t3RBgLTor+Cjcn8Dnut9fM4NzStxUlgVMrdmBvc=; b=pAZnoo9j4f/Bi6pF
 3fw6dD/VrC6Q2Kqhn25Fvdp86mqRsoHT21HASx5Zqs7sd9CbqJiOrRvKE2+ib07U
 2tV/Vv7xL9xdAZ+ru6aSlf3ozoxWEzjEZd5FHLbAocEFhxCAXPeyJ4YFAdn2q7MC
 AQcaZ1k4ostsZKLw0tai9IHzhp87toAb78QTTsllOTm+Yl3bUEeL1QQFgb5p3T3f
 HV6PA2gnTQTXkyYrVqDkCO5lkVWlZSa6MZr2BlmsiEgv0ZUjdBaIn1LZq2szjgnT
 j25J75FuFDW6/G9ksHde+9EHLjFLE2TZFNJBGGRW74hu1Y9elx49uC67/pCFAQHE
 WFT0+g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5djkp3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:19:26 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso19223571cf.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783721965; x=1784326765; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9FP4t3RBgLTor+Cjcn8Dnut9fM4NzStxUlgVMrdmBvc=;
 b=ENTLSyvvaj/2NewZSv6IfSTyvYwlsnHKHh5SjAfH0hOeKTLpcHSGt1CY/LrDwRBWoC
 AtItikerBrHO2q8Yuq1ayF5ydEXAfRaR9UyGvl31wCwMVXEgxgul4eMiY/AM9p3NnZDU
 Z4SU+4qpjSoqARAgfbnuoyFtmSSGL5EA7iVK3Iw747+RA1vxNKUwM0jtPOijdeYkWVqn
 GznLuRAsN9dHWqjnPVvZ4pxXusx1/yn9pbGHp49zsoSTSV08727YM8lIYoInbU6crxOd
 25/7sXiEsfphvE37iz05eIKuhkQwZ9SajVBIqOfFPTzVEmFWnuFuTyrWSUMuoqZzq5Yj
 tDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783721965; x=1784326765;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9FP4t3RBgLTor+Cjcn8Dnut9fM4NzStxUlgVMrdmBvc=;
 b=b2PZU4VL2/frNPy5W3GDb6amQcr8xrMOwHkdkXr4cCcZnMxdimDWFh+C3SWFnXfxHi
 pjc4HxysgO7vsUQtQ+3iLyB2opjiPStAuLklKyd0xpzxk+GL/RfDOuIPU7y1m7B3HGeD
 hStRJiugMp754gwWe5Q+Lt1Xc6VBi1/SjDKazpHUs6L+yu8zMzZyReYeE0pnrvGMlc3U
 x4c0T6Eeg9mmvEhCT1012XFl0u3MofcQ98uAWIi7Q93yOFrF3E2PgQ1PD9mIQjGuvVaC
 5AeVV5i6MtlB6W5dM/3eyDhofTSTHJ6DfMndy8p9SPyCjCjhIo1euFNSfdqRRfft4aaI
 JFoA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpo5VbH3ct19XzMek4ryQfh06dBzhSmSjEjAIhCEF0BcPvrdqeIGGd/DKO/99t2P3H2pY9JBd4PYuZo@nongnu.org
X-Gm-Message-State: AOJu0YyQj/QIMY8eSE/vesqLoDmKiazemqUwx10or8UUM78i5yMBXCFJ
 2S3rKW2NwphHIY7CRDuy2mUXcht1SMIyd/yLDMTGXagsV83NV8np1zHrc7FBIv7uTAk6aOMECVN
 sxCNuzXo6vJj5NhyvbVVnz9e8JlSehsrCGMWxxk4yE1C5jLu37DrqEZYleg==
X-Gm-Gg: AfdE7cnW4KOp+lumAMBO7H7Mwwxrj2ABf4tBRqQx3RcxTmSpSNLogxsExvO3ZhlHQAL
 azPDd2K6EbpYejXEkZdk502C9zUTxDMI1331qqW3YPixBG/KBJLagDtdt29Frr3amOeoZOv0IeX
 Gy2D7jLhrUWYVUg/ZDhuuwyT7MRjowSRyOVIJqD7Cwc+cGHUr9kT2f0dGtyv7DTKUdBQX/G8XU7
 a7TzVqA4e3FwRNi+Om7Cfr0n4QF6vO3bIkJ0xcxlNZZmWBkIJF7J61VdAOWRgPLpsKYB2nv99sn
 RkputAtry4anuz0A0FUN9ZOtqdS4JvbSHb7uu4viniS980F+1pMHV4Sh9mwlb+qianmvFB4j0PM
 c+l1Cd2KBrCChZ846rwAN5hw2MlNy7fpE1KbjfF6+2B+LfCXIb0aH1Vo2LeVzOw==
X-Received: by 2002:a05:622a:1928:b0:51c:7b13:62f3 with SMTP id
 d75a77b69052e-51cbf30dcfbmr8099551cf.73.1783721965145; 
 Fri, 10 Jul 2026 15:19:25 -0700 (PDT)
X-Received: by 2002:a05:622a:1928:b0:51c:7b13:62f3 with SMTP id
 d75a77b69052e-51cbf30dcfbmr8099341cf.73.1783721964748; 
 Fri, 10 Jul 2026 15:19:24 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d83bdsm63071820f8f.13.2026.07.10.15.19.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 15:19:24 -0700 (PDT)
Message-ID: <a0210af0-f92b-4939-8fb9-90672d156b82@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 00:19:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 v3 48/51] target/arm: Be more defensive for
 invalid tlbi_aa64_get_range
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com, qemu-stable@nongnu.org
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-49-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710205401.836304-49-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyNCBTYWx0ZWRfX9oC1579UFfiO
 4URZCGBA4FJp6EhvsrseQ2dIV9XHkMsYhxPY1zEto1DpOpFV2Tu7AqBDKbaAbqean3qUtsg4OUz
 JNI57V5qm1QyLmtfYFmlCptn9qqvNcc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyNCBTYWx0ZWRfX3cD1DVXBTCsu
 Ui2Hba75ziYJyvDsnD5EmRYJ2LUvsK0ryRFCM0YSf0PXQZzr1Vk6l3Lh1EA2biI7r8VQNfBiZFY
 xFtJbzDdfpBFGPyerrBxfRRqbAbwmUAAHP5kkQkhNBWcm9J1DyiTw4hTydYjUWn9lqqXFzw9pcv
 +Le1KidUxL6VOjQQ6/Yz8gus5v4Sk3Z7/XEHMvzR9RssbBuFAn3eAU6SubNNx5ucnQCXX9WysvF
 o9Qoy9kQsBSdlZBq8pc5kL4ee2kvq6yeRFisrPv8h7D8kIpxTWSrJMN27NIySvisr1ROg7BRddK
 RcaaruY26GnSnjEhj0XYAXQ9E3x3h/tzRjM4D3CU+MWSrrAyQycEdIVuCgtmiSZtlVyEGi5fulJ
 Xvnk3C5VR7cuJ+1yRf8E2lGK/05YTWmBujdvyZCiuiMMiCmn1bL+Q01SleGvXKC84gJMxYwk0rW
 X1yefe3YRcEXmK+Fe8A==
X-Proofpoint-GUID: -yMizGdKh6KMBgUL_ARttMzVGRP12xU2
X-Proofpoint-ORIG-GUID: -yMizGdKh6KMBgUL_ARttMzVGRP12xU2
X-Authority-Analysis: v=2.4 cv=M/x97Sws c=1 sm=1 tr=0 ts=6a516fee cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VM2QREBHC_YskJq0tasA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100224
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 10/7/26 22:53, Richard Henderson wrote:
> It's possible to program TCR_ELx with an invalid granule size,
> which could match passing an invalid granule size to TLBI RVA,
> which would then fall through to assert in arm_granule_bits.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 3c003f7029e ("target/arm: Use ARMGranuleSize in ARMVAParameters")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/tlb-insns.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
> index 1a0a332583..b24eb57788 100644
> --- a/target/arm/tcg/tlb-insns.c
> +++ b/target/arm/tcg/tlb-insns.c
> @@ -854,7 +854,7 @@ static TLBIRange tlbi_aa64_get_range(CPUARMState *env, ARMMMUIdx mmuidx,
>       gran = tlbi_range_tg_to_gran_size(page_size_granule);
>   
>       /* The granule encoded in value must match the granule in use. */
> -    if (gran != param.gran) {
> +    if (gran != param.gran || gran == GranInvalid) {
>           qemu_log_mask(LOG_GUEST_ERROR, "Invalid tlbi page size granule %d\n",
>                         page_size_granule);
>           return ret;

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


