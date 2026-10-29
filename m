Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EF1606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BJ5nYVa9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W8waei82
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUFY-0005Nc-9G; Thu, 29 Oct 2026 13:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xMUFR-00054F-7e
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:49:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xMUFP-0004BD-Is
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:49:09 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDIRq227450
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cHbtURLlpwMmkNshmZKhwV0pzhPmlNhIdtdUA6h5gkw=; b=BJ5nYVa9oLkjHtFt
 p+LXvw4Kp2bawv0jk193jZBjUXve8KmtUZa1+bhlB0/tzkMG+f7xFtWotT3z4Et/
 +VbDzyXtZAFGqAPlsBKdOIhIe4HljstYMeJvm9NKc/ILp7adc/y6WhBBzzUuhzBn
 4/G9mRKtNuQq73eRrSYFWjiEZK7vFObUMjHyrtAzqAKdZy9qaFtCTt6Q6zKLJ5vH
 fMbPgaMS5DYvUM9rJwvMDD+IaAxmw6MM7nEAO+/CCdDCuM86/t7IqgfjSTCOjToZ
 CfTYrHW/zkM3UxgonWOwANJkY2EJ2BLCWu9GG6Xr+K9JBeSGKt6rqCnrEynLbBWX
 HvIE/A==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm42fjmvv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:49:04 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91c920517b3so20282046d6.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793296144; x=1793900944; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cHbtURLlpwMmkNshmZKhwV0pzhPmlNhIdtdUA6h5gkw=;
 b=W8waei82xVkCB31HDgEeoNaD2azcy70/XfT3ALCfKqmc4D8n9xhGbtPf7fWgvVI9Gc
 P3NwyXkNQlef3mgs4UGpGL6J57sQvMkUmq7UBysvM8TSmJHYcpWeYVzd82WmYHUZiJqP
 ZuoemayMIuC/BXDyfbtRD8+9jiX2Evf3xWz+sy9Z15fQV33nz+80XcwDA1rqGaDVTLfA
 nil4p8YuUPCELhGFigyVJcK0+6S76yJnbHLPnLwBKf2Vr5VnT47qzxPiO6RZaQOB/Z7I
 GpsqCP6CKEG3/BUOMX0YMcFY2M+ayOPpFBXCxMGEv86ZWuhTv8Fxy1oR+PIjCP0dIkOS
 KSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793296144; x=1793900944;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cHbtURLlpwMmkNshmZKhwV0pzhPmlNhIdtdUA6h5gkw=;
 b=sC8udyq0yuZ1JWo+Z5i3a+GAYq4TgF+zfj6wDLRdXUCp1CbD+b8YYij5eulrp4KbTU
 ar3Oo3WKEZcXlvAlTuOaTLfo6x8Q48EIB+S+sG7gUjetg2wwrq9kL6KrtEBlz8yfRqe5
 2bZClCPtdPPVLcGbszMZuBsb4kEv09QIsIr+aXZyPCb5DvjjYIluv8ArZdz77WOpviBY
 yfSxszw13TgrkZlmxV7D5wahKio9n3LTvlwZP69qo2SXoT5trfxCcdkSQMlZMRS0CEKC
 LHPq79UDxat0NvrIusmkfO6bEMyQPtsTw5gyivlhT4aWHo2JZevQR8Fgb7WgO9GiZi/K
 1xSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxO/hDIq4GeCxYivh2h+Zfp0DvnkOv5996u/jHeOaMKnMfz5otLKv+53A3Z/4S2gfM0LNs9Jeg9DQmQ@nongnu.org
X-Gm-Message-State: AFq9FYId/gb+U/3+8bPi2Kl2q+2lL5kh0I9NoWm9bQ6n+Qd02VtP6+XU
 9DWumggG3jTGa+kx+iLN43ODLUwuWNiTCFd0ute2Ulc6gwYo7psespdZxQ6CCET94KGseHNlGi1
 OmUqchzhwKsYcAB4lqYZ9Nzj+qdwMaFkl4esNlyMA+mC4qnPtarpxntSm8w==
X-Gm-Gg: AYBFou04BdxBCeZJQXcFHIvIgghzanfOcMgxLsEOb4pZ9chQLb/hs5Q7Hs/bD4vwqwH
 Cgwldml29TEJrOoQFTsfO38MaVLgf9djA7rP6knjEtO2HIJ+7db8eUxD0tuYaZxQFitx7PmIcVH
 RN+M7rje2DUjiyPWNZyLNJhsqT11DQ3u9mtUvVK85+De66CpbfiKj3SSloJsxI2JPHhObzvwGsd
 wKMs8u2Ba4slaqQtCkGp7cM6qERmaIZYTcAJPBCmMK+w+zge9Pl5CrxIWAvzcUuHfTwHHu2pRlx
 7dC9P8eMkxr5HyTu9lxpDoD3it4BifOA4g+qZYO1Bj6n8OPMztnKPnmvyfCtHEsMzF/zFibc8aT
 nH1GTR478KhWdCGX2c6hz2Ed5Fyj+P3RevH7CtTTQhOvWw64O0Jb1nelLcxRxpifpG1cccA4trA
 Iv4zYruvKGwQ==
X-Received: by 2002:ad4:5cad:0:b0:91b:8724:8a28 with SMTP id
 6a1803df08f44-91c7d1b1484mr91387186d6.34.1793296144103; 
 Thu, 29 Oct 2026 10:49:04 -0700 (PDT)
X-Received: by 2002:ad4:5cad:0:b0:91b:8724:8a28 with SMTP id
 6a1803df08f44-91c7d1b1484mr91386786d6.34.1793296143424; 
 Thu, 29 Oct 2026 10:49:03 -0700 (PDT)
Received: from [192.168.68.103] ([152.234.122.251])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca2fb5c9bsm2293746d6.4.2026.10.29.10.49.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 10:49:02 -0700 (PDT)
Message-ID: <54728202-684c-4559-a3f6-8e2d6594342a@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 14:49:00 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/riscv: Honor Zama16b for halfword AMOs
To: GavinQin <qinzhengxiang@foxmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com
References: <tencent_7F0BF077B0C2A71AE38EA05BC3F112773207@qq.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <tencent_7F0BF077B0C2A71AE38EA05BC3F112773207@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX7anPRC7ezXKL
 ASOjCnmFd6BHB/2fqE5RIJ/+qMQe/rzeLYxlfJm0BcliHj+AZdnxbc/0QW0I3eCX2Lg2ur50634
 q8slt5xM/VS4+LUKY5AQXKuGNNHwHcTC2ZS7AGqSGitTyj7/GlnCGhR1g2kMrJK/ekeBVsAU4B2
 gARYIlcBb5M+Rr4vF25A3kgKkjEyzxZdC0oltErwnwuWnAFHItsY49fjLmcryGMGVn9osWrumGO
 vDkJt+X3lf19Pt5wbRhksW7ZCJZeJdE2fX0QBF3NxuxEiVRqtsVCsAg5/HFMz/ytEK6Kev1Qnpi
 lUKlsP2/Dbt2ol54Y/4WhlNyABvE7+ai4H920VuYuzK5wRKYuxRYajVzIgCDuAwfhVvTc7j/EZN
 FJVbrOcPsinA6ItHJhr/npj48PTqAA==
X-Proofpoint-GUID: _zGJzycRThVmQ6_ZWuIp4bnFXnYEzdfj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX72vJDlmrmV+C
 JiVbliLcLMsd94x2EH2tk2HrVnvzaSR00F7/3pPdx14luum3f9osdVzbp9c4/ysL2Ij8YXJg8o1
 /J+fccQiBK1VUj4nZZwwwe+iPy2DnXI=
X-Authority-Analysis: v=2.4 cv=UN9Ijyfy c=1 sm=1 tr=0 ts=6ae38710 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=QOY8BskYDu05dfarAz2gNQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=bDN84i_9AAAA:8 a=EUspDBNiAAAA:8 a=bbsZSauHe3uP5S6po8IA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=J2PsDwZO0S0EpbpLmD-j:22
X-Proofpoint-ORIG-GUID: _zGJzycRThVmQ6_ZWuIp4bnFXnYEzdfj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610290069
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/24/2026 9:02 AM, GavinQin wrote:
> gen_amo() only applies the Zama16b atomicity requirement to accesses
> of at least 32 bits. Halfword AMOs therefore retain MO_ALIGN and
> raise an address-misaligned exception even when the access is
> contained within a naturally aligned 16-byte granule.
> 
> Include halfword accesses in the existing Zama16b handling.
> 
> Signed-off-by: GavinQin <qinzhengxiang@foxmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
> index ede9c2563f..70c1088338 100644
> --- a/target/riscv/tcg/translate.c
> +++ b/target/riscv/tcg/translate.c
> @@ -1159,7 +1159,7 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
>       MemOp size = mop & MO_SIZE;
>   
>       mop |= ctx->mo_endianness;
> -    if (ctx->cfg_ptr->ext_zama16b && size >= MO_32) {
> +    if (ctx->cfg_ptr->ext_zama16b && size >= MO_16) {
>           mop |= MO_ATOM_WITHIN16;
>       } else {
>           mop |= MO_ALIGN;


