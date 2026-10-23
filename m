Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A969606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pbhK8fzW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HY90XOFK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKEP5-0000sZ-PF; Fri, 23 Oct 2026 08:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKEOw-0000rK-44
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:29:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKEOt-0004Tg-Dg
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:29:37 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAAZ9P3045405
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 12:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Fj6OMv0wccoWTGGaG2kGuc1KDBXZvKZFzS57NBjvpYY=; b=pbhK8fzWfJ6hOam3
 0dR5edD4iEvlKzsw6E12gmon2Pqq6ev2DVHXXH/DzyApDja4/EGjUslQbZWmAcbR
 q7GQ3rrexLRT8bmIeeRBhww4kPS06rRdvZOGJSXiVKClwAK+SEF9r1BmZCx5mDgI
 S2LtWGTAY/pWveSDACgDZJL07D2finMYP9zQnl5mQh75k5bnm5ZKJ4icTZzuPCKr
 Un+FM6X+z/LvqARCpKS0OtmPX3YNDUr/571Zm1+Kmzr7m2jIZ/1FHy20/k9cQ7Ac
 rP0ypT8VHEwQCcKl6Y40H2cjzLkMZQ37mIokFTgnGto8/8KVGI7R8XJOjAyqzdQH
 ukcT3w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmjbp1g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 12:29:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f568dee56so175154385a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 05:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792758572; x=1793363372; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Fj6OMv0wccoWTGGaG2kGuc1KDBXZvKZFzS57NBjvpYY=;
 b=HY90XOFKA5Obsdtn1rOh53EMcrWhjUMeJfnUsjDko73AtN9gewwhKTN109ZosDeKKM
 h9sg/7erjBLhvnxu9Ittb76pyTmLRbiwIsW7eJK0n646wlXHAaitVTebedC2h0QfH6Cn
 gUQircB5CEvqhQqCXLMppgFKqI7GgNvbxERZYBVEpW6Lr1RZTaiUbOAlmEiq494Z/a4Q
 Mz7F0HxGkJ1bufUM8ZHVeFhhyayP+d7hVJ1NNbpP8suAOgnZxBuyT/VkOjFbzcg7nlD6
 CHjwVWwv3doUHNhkaIxPFYJW4jl2B901SsvgK/cHc6IdwLvsPv3/y26mi5Rq+TePgJaU
 EPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792758572; x=1793363372;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fj6OMv0wccoWTGGaG2kGuc1KDBXZvKZFzS57NBjvpYY=;
 b=uwXmyPdPzyVChrusv7+di4lozUtAxYbxzybuDbpYhKVq8Go2VHn7iQs9siBOfGDBZc
 h/8wOrdg4L56kmVSsvvHOdF+dAVoOG42SmODggttdhWlAf5/w/cf0qnMgXtuSNtpg16F
 vDLWOSoC4Yi2wBIV2Ln5msL6UQfhl96v29XEELmhwP6DziF1+hhBsZ5/Y9UzuUHh3R7s
 gGX7XC5zvVLnaLD4SKmjsR7E0kU+q7hdLaicMeA/jWDbpu08NwMClFPK8i4Cd+qW8BnM
 zYGAdslQAhayi3c1SVLqOWMrwfb4akzNokm+yui8yVBNhE8imLLxTKKXpQ3YyUd6Meoh
 APpg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwoYwKdFznEr+y90zDmE2ssY8AVmgbZQ7hUyEzwC8CyJ0b5ZYtmPhZuvii6+d731NhZJawfwMmif+Vu@nongnu.org
X-Gm-Message-State: AFq9FYISbIIrFoa310cKVP3iRLbwE87Fgf7uBIu0B6jsc14ZacrTjEA+
 c84qshyMsX/T8zv6Gq0rEdFNM8EWE3EV4/3/hC7VkHB8bHHFxfxw5L6OeofhurNkBTLXXXs+xnY
 aO9A4rQBAdRFe3zTKCC1fvjIODQPAHokZTa7BXnLCqWIIZuIAyq7YnuVcKg==
X-Gm-Gg: AYBFou11lLgC+v6dIZXt3YLjKBSbq2d9JdWoIDcjz4kl3zI5Y8Ahlp0WOvAfKYqviGI
 H8iGXGgxXlTC59Xr8JR3XzzLhgfFbTNXKdWYmz2HaZIkqeS6hY1jDhxiMXT9tZf+qbVW1Rm1GUG
 bu7xOTX5VtRfhIUV7ru+ih57Bi6k3ltdlSZ6SQAYSzirGvzpkgIxhhFjE3oAM4wOrTRfWDWmn88
 5DuZiOnNQc04skHRFX32BFWgTullB94VI88pzYxGjMiU/bLKWWwfGAKqkye4vbssMMGATik0gJX
 ALSGeT9rMgVpuhIyr5uw+Hm9D/CnbKm89Y0urX1DXuFYmAjXwDCEFPdmeTtGu8VzQOQ65Xejl5d
 cDtEMfbMRknq0mXcFKS55373k95KRMub+fA==
X-Received: by 2002:a05:620a:4483:b0:93b:ef24:bc8c with SMTP id
 af79cd13be357-93f6f9731ddmr372888185a.47.1792758571630; 
 Fri, 23 Oct 2026 05:29:31 -0700 (PDT)
X-Received: by 2002:a05:620a:4483:b0:93b:ef24:bc8c with SMTP id
 af79cd13be357-93f6f9731ddmr372881885a.47.1792758570914; 
 Fri, 23 Oct 2026 05:29:30 -0700 (PDT)
Received: from [192.168.69.209] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a21534a306sm27902895e9.0.2026.10.23.05.29.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 05:29:30 -0700 (PDT)
Message-ID: <893d338d-86cf-4f5b-9941-cf40f8000a79@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 14:29:28 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target/m68k: Convert to translate_for_debug
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Song Gao <17746591750@163.com>,
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261022125858.310252-1-peter.maydell@linaro.org>
 <20261022125858.310252-5-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261022125858.310252-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MhjQDHeK81qywKMalETn0I6WnHefuomB
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6adb532c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=WRGDsuEPkw-HInEnNlIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA0OCBTYWx0ZWRfX+FNMbLqQpXDW
 zTvIlynlPPSq4g80h4rk2U2gPlAcCnHMa9tughSuGtL5VbKui0El3xnHmePjZgPvFakyEGcXkYu
 ZL8MVNuhx1wjnc43CFF2t/+10gaaI8k=
X-Proofpoint-ORIG-GUID: MhjQDHeK81qywKMalETn0I6WnHefuomB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA0OCBTYWx0ZWRfX2Bq/rLa6BMaM
 8glal1ROuGMtRqKWUQ7sAEmblvxXTpg8A/eSNw4eb9CNqaXpGC522Rnbne9FVJcaMT567KVqOTA
 5kDduwdA1ZYVFWxBe3XJo4qPbhuFE0w8oUwNSzbmHa4We3t+sFFAMMhOUj5/mIABFNE+EcbICSd
 PdpAa7HZdI7z86/nYeBOsgXzXJVv5KjePmYSJilNMV/WHnPF/0gNPfIayRPG5yCrjabWk9KZUFV
 4DmNFAUNbbAFzlO6O9ijjtSrUn+HfOKNl6fWfuD6tAf6qKzMmKSh9JArP2w49d69UbCZBQsxW29
 +tpeItgHjXcYx4tAar7DtKtzqmLtDEGo7e4r+I93pfAKpIBpjJ5VxY1kltzF+/AA52csR2UNa+Q
 mYMgf2t3Ku0tB9Rh6FMsC+y78uSBlraI6rgn4xt2CQEfqOVAhltL2Wq7KLY8Zkw3DCiWPqbPx/o
 0EzUS512xhb4aMIvOUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230048
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 22/10/26 14:58, Peter Maydell wrote:
> Convert m68k to providing the translate_for_debug method rather
> than the deprecated get_phys_addr_debug method.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/m68k/cpu.h    |  3 ++-
>   target/m68k/cpu.c    |  2 +-
>   target/m68k/helper.c | 16 ++++++++++++----
>   3 files changed, 15 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

