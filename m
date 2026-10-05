Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8976CCA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 21:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDpwy-00041q-W2; Mon, 05 Oct 2026 17:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDpws-00040K-Br
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:10:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDpwq-00009g-NN
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:10:14 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695KMiC71535283
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 21:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KMQwEgxn/MF5iV0a+c3UNRabac8BzucF0gho9/+Vp1o=; b=e/tHTECucFgNUEU8
 yJgbKD2N+WD2280FMBAtwtrjxaK+qH7VnoO3ZGJHhDzZ7Gzhfg54N4a8RnkgmHom
 ROX1vh3Kbrr8NtxnOIm2loA8iBWW+sByc82mzqIKamgTCf6p7seORwjvJxeIUJk7
 yrTaLRJALJMX5fJNNHMeiv7nA0G16Qc2Ozl9P6gcHps8qcQ3vmtBX1WrAbH5jDLm
 K4t077zPs1r4d0evPOyhSPWyZVkkED4yyNVmbmUnpZ5bubF5VEiGHL1aSPCfwHNb
 BJujJMuma99NDjtV3zAiwrm8Kz0ChsotlfmQyvrfTkOJ9X9LNG+6h+vSgk7e/TES
 cTHekg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4dnchhnt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 21:10:10 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso4345436eec.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 14:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791234609; x=1791839409; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KMQwEgxn/MF5iV0a+c3UNRabac8BzucF0gho9/+Vp1o=;
 b=gjJ3AqUaPhxT2/19ypQABA0y6a5T0Jhvhdxaqr3WDRtcdzCBHlIXJi/iU0JCedChkF
 TB4vFzhWGRNqSxFlA4c55ZrwxVGzUPRHqbfe5Q0C3XcNZaE/xuLYGs0VNPSYVAcu3p0s
 C/SEemajN0+OPVfxS3WvTNtD/qnuYc5WcR9yXtfW9vKtJwpt4hhVltt5/V58ctR+G2jw
 jwKUPx3ySKz6a4Qxozm/Dxu059utReJ6hoIBFI7MJ1sKo8dpT8EGJVeJlSiKyfT6fF26
 hG/0cFjhRzrUAZ+PCjQJoYtjcBwwvm1BcGaUlJM71kwrMygLnX0v5Fudlx6kUNilZR59
 zfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791234609; x=1791839409;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KMQwEgxn/MF5iV0a+c3UNRabac8BzucF0gho9/+Vp1o=;
 b=xIgNBqhNE2j0b0tByc17uxRn9J39IiXhX5YltTN1WUPEm2bJa41notuLsBBWJlZuBz
 dhI2XWzLGozMNScwQg0+QAmlslLYeAVOXUFxFG4k6SxySc0777PW5pk7kWulZPdfKmpY
 XWhbWPlsFyXkIMYys9gldi4Hri+8ujRZT+p4qF2qabiLcVKXFE7d8BZYPJoLh57fqTp6
 4UtJcXDIA4iihoNNowX+M48+yB5pue0KA3c92fKTDnKJBbPSpcLO/pSU2csr6CRsyAX8
 F9BnCsJqlpD5fmtqy1em9ZVe+Zi0c0BN6Fpsa1u6DZYfTKGd4QU5Jvg1EirvEFHkmgbS
 gynA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx497QgTnwVJLCp5PHV8OEp6WSmJnFpuO2dMlNf29FC0+j5acYu3G2KOqDH6juLPALrD6clpFofMt6W@nongnu.org
X-Gm-Message-State: AFuF++lIQe4wWqpfY1gL4HHx96BjBTEQFdRD9cyfoaqWw7z0i8IK/e3q
 j4SV0RHaqOHoLr4lgC5vDL2EhKhN+cxbIkWzmLPiBk6AzM7Bn12GAsohcQ0nnl4kiDGRXPPWrKe
 nOcws7BgDaFifgSEj46WFz43AGCWww0cnmz/xO2bnDHA4hQqKJ8GEkQPQ7w==
X-Gm-Gg: AYBFou2S9bKz3ZlPaGcBFgH4wIxbSMJbhIQA/RilSv1WXFATLa8L6SjvM+JuwTM9xLn
 Q6KYXB4H4xXXUsGn35YcoRfep8orL4tn4o5ABVbTx+u/4xPYrCjNO8PkNkNwNoWhSpzHHtHVpiW
 xSJW3I655duA0nhTs96jtOY3xl4sjz1EIe94F04YLrdjlOLTj1RUabE4mH0Vjfobf2i0gsd3Bt3
 0N07HJuW+LKb0wuvxLNjdCkmkc/Uj0CIVQQsIVsKibcFz53GWgm+6GJ60p11KFOSBU1m23ahy2L
 Ow4vaqTj7/BKdS7sFIZzOsd+6Q4LC9Sxw9u0HE6gJB6PkHpOPPJO6PE5HOzuey8DaL0Zx1j5b1E
 MJjKCIl5BiMAQpRarZMPLHj458GyfzGPAkA2ARCX5txYGcGuGrdVFdSP+g/kr7vku/5Cfwg==
X-Received: by 2002:a05:7301:d795:b0:351:1567:41b7 with SMTP id
 5a478bee46e88-3511567798emr10432697eec.29.1791234608962; 
 Mon, 05 Oct 2026 14:10:08 -0700 (PDT)
X-Received: by 2002:a05:7301:d795:b0:351:1567:41b7 with SMTP id
 5a478bee46e88-3511567798emr10432648eec.29.1791234608181; 
 Mon, 05 Oct 2026 14:10:08 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35146b3b5aesm1587556eec.29.2026.10.05.14.10.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 14:10:07 -0700 (PDT)
Message-ID: <c87183cf-bb24-42be-a51c-d700ff6b8a1f@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 14:10:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/hexagon: yield on system-mode pause
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261005194519.2945862-1-brian.cain@oss.qualcomm.com>
 <20261005194519.2945862-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261005194519.2945862-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4MyBTYWx0ZWRfX0PgGCcvOWpp1
 QdqwagWsiq9I6okcf35bzDa1eoSbaQBkM0xbVwEDlZZDK2q4sykqBcu9B6Bzof8b1zCdUBk2021
 IC1l8lJHczTjJs0irQ8bFZamvj8dVGU=
X-Authority-Analysis: v=2.4 cv=Vdxir1p9 c=1 sm=1 tr=0 ts=6ac41232 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Hgqyw1ebcACVWZcZZt0A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: L_tAtMs80xN50alXHyRfT2vtAO5iAp3H
X-Proofpoint-ORIG-GUID: L_tAtMs80xN50alXHyRfT2vtAO5iAp3H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4MyBTYWx0ZWRfXzf2f95crOFGF
 mNQoJF987GXhMc1IbUX28z7WczlJlpqvBnoCpczlQznklcWHak26bAx7+/tTDYEBJ5STye2zkon
 4J5qtcb8G6gN2AK2Y9SNjOxXaPTmqkatwr4hf+gN63okVFZ3Al7cbQdgSsNgMjVpn9BaP5fXo3T
 9H42PXeOvX/SAvERc3vleipYparqPs/gSzzlzo3rr9ZeoGNP+3V7siGjF4ppnpruElTUSoY/wxE
 oNc6T8SzJEtOzRLaWgCbWfggbhOL38KhCNyt6+gJ6trOeaLuYyEPn2pbvNX79YPaWLN3Dg6drVX
 qXjH5tWWy5QImxGtYd2SrmbWzV+F35q8F9QQS6ubgFG3YSP4pE3E3NB6bQdZQ9vN23fTbDKY784
 HHlgwwMPq4515rxutNK4ewrYpd3BfmuuN8jy7qDyeHI0nMMbVG4UhWHtBLBSgUrFHD9FudT9UYq
 P0tuCicYdUfTCnV4Fug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050083
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/5/2026 12:45 PM, Brian Cain wrote:
> System-mode pause currently advances the PC and continues execution instead
> of yielding the vCPU. Raise EXCP_YIELD with the next packet PC so execution
> returns to the CPU loop and another hardware thread can run. Keep the
> linux-user behavior unchanged.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
> index 5f7df66ae67..80d8a7b6bac 100644
> --- a/target/hexagon/gen_tcg.h
> +++ b/target/hexagon/gen_tcg.h
> @@ -1125,11 +1125,21 @@
>  #define fGEN_TCG_Y2_break(SHORTCODE)
>  #define fGEN_TCG_J2_unpause(SHORTCODE)
>  
> +#ifdef CONFIG_USER_ONLY
>  #define fGEN_TCG_J2_pause(SHORTCODE) \
>      do { \
>          uiV = uiV; \
>          tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->next_PC); \
>      } while (0)
> +#else
> +#define fGEN_TCG_J2_pause(SHORTCODE) \
> +    do { \
> +        uiV = uiV; \
> +        gen_helper_raise_exception(tcg_env, \
> +            tcg_constant_i32(EXCP_YIELD), \
> +            tcg_constant_i32(ctx->next_PC)); \
> +    } while (0)
> +#endif
>  
>  /* r0 = asr(r1, r2):sat */
>  #define fGEN_TCG_S2_asr_r_r_sat(SHORTCODE) \

How is this working at the moment?
In system mode, if a given cpu never really yield, a given "thread"
could keep it spinning with a busy loop forever.

