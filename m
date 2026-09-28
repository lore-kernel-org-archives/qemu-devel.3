Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB79CA5FA1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDY2-0007Sn-Qq; Mon, 28 Sep 2026 11:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBDXz-0007SL-Sf
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:45:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBDXy-0005FE-3i
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:45:43 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SEeUMJ941416
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 15:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kO+W3lQEfMQaTiY1FIRSRvf5d3j1++J0wzO/R/iXbzg=; b=WADo3izZsBKaJkke
 dXNu6K6lzLzxC9qj4MCoqWfLW8Hfb9GkGGA8fzAOV1g/zBnRM9vse4c8wuHdXQzy
 N2+1/WphpL5EG2Oq9omB5kvAQjjCfNkY0iOLeRr91btKhFgsCGHB9WD29Gxcrm6p
 QYQclkRYwm2Fs+xNSujPZIolpbkNjwOiuKwbtC70cwdLcGfsx/D0yNqO/zVJfLA4
 SM7uVSTvQICdFV//IlXiycE7Jw+7hRy63OkOpUr/B66ZaPMaiXu82MrI89dJLN/K
 Fo8d1OguZoksId/JFdexP5OJCPVsCeJ1F4CLDTgWVsmtqE3v/BUEFvMbtAjgCZFI
 83pehQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjt126k9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 15:45:40 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-986e5cae3a9so1744690241.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 08:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790610340; x=1791215140; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kO+W3lQEfMQaTiY1FIRSRvf5d3j1++J0wzO/R/iXbzg=;
 b=JO11/dqKyF+H0dTy+D/HRFAztqBkJxHofJAYjXMQrETFfsGU4896+TwkQhJ4xdkiLF
 IMtVrksuo2HCP+xz+ETRPpKnXSqCbWRYJnjjckJV1Uz1mJNU9UQ7H6Q7+rKRcrdbvDYf
 5SA9tRaTYqi4ZrkgGwczsz629P2cRQ7CnuOHdNX9xgFZRLffglJFTfqwGSIpjjwf2PFi
 tCYfFPx9VNB5orc0Yqu5az0vVpfZty/Gq25oGgL6oReTT/4p9kIThiFCQM21Ck9AHsxa
 mYx08TyGzWJRhkiQIEZB0ohoaM1tRMsQgu2MThZe3Ek9Oz2x7T4YUjwqT7JYHSIaUrCx
 iIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790610340; x=1791215140;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kO+W3lQEfMQaTiY1FIRSRvf5d3j1++J0wzO/R/iXbzg=;
 b=mptOQzPgJpzy9369LawSKYzsuZImDxSN8aLIyUjX+YLNNu/3zdl2o10BRaMPARfaJF
 YfvessQ/dJg+clGaFiO43b6gdKC63gTuMHYod29pUtFgFGs0TS7WJhF3gZoBT73kxueQ
 nfYYd3tBgL73J/Nl1an0+rzfMNh6+C3E35DrQLDxod3vCH+JtrkGYJyc2dBkMbXEjHuj
 0Nmz1Kq7P/RoH8Vi+/OaIozr2nQtV3VLXhOSBQp+BNpmdTJHxgCrQbBfrigzzKDusDbl
 W2FAeMdPZOh9rGVnRhqroRpXdxr7TPGdx02TShaiGuPVzp2mfVRR9NrdgQMzlDXadUdC
 Fdpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIQY6pMEZwzIM9f0rDHqDHDLBcV9tsFVoDbbH+FGRXA43qXZyXcLraRr/40jHuZloQqHdo7nSwgxYr@nongnu.org
X-Gm-Message-State: AFq9FYKsswyYMK1eQtrZTqgtq45gu+gz0T/t64yafsLskQwKaCWLCuu4
 m9G9JpdLg1JWIR0Izz9CAUNJvVTgyw6lmricfx+plngRwWTh9BSXm/HIml383MChWc3VLGQP2rU
 othlGrz4xlsrAk0pDzpUq5YlE/lGU904vp8KWDpq5NUQfOqwTmAD59qYvCg==
X-Gm-Gg: AYBFou0ELGKbR6yWaF8O02P2iWXpnaHmst8sNcPw8foa7jAFZDDTO8VwpjvBbOK7pvf
 L4RoUB/7ozzxKZj4fR8jG80KJH5XenZnXKg2VT1DZ2sFRltTGsFfJCkYLMh2lHkYdoy1oZPym1k
 ZNtLTVVbdOVH2hsDdmsqTN0hbB4GS8RulHZjCHbvaxcyKHUp383Jii+6n6mlzBABgJYUhTBJLY9
 NsKaE5TaCehaV4qs2L9a429JVSn7w5fMtqLE38ya+c5Ts5GAqVMKgwLuuBr/E+YZiM/WY3uhROo
 WoioZqSPtUQHGktbD4xZf5hEeIJq0Teosm59XwxRKKO3lglG27G3YtJWzp12TSLm7bHTRQQ3uko
 pT4TYbkKty0BqsYFH806UBma5SE0YCq/Sqg==
X-Received: by 2002:a05:6102:4b12:b0:7a6:cd3d:49ad with SMTP id
 ada2fe7eead31-7af1c691adcmr5405568137.7.1790610340038; 
 Mon, 28 Sep 2026 08:45:40 -0700 (PDT)
X-Received: by 2002:a05:6102:4b12:b0:7a6:cd3d:49ad with SMTP id
 ada2fe7eead31-7af1c691adcmr5405555137.7.1790610339485; 
 Mon, 28 Sep 2026 08:45:39 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a6470b7sm28756157f8f.27.2026.09.28.08.45.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 08:45:38 -0700 (PDT)
Message-ID: <d742c67a-8714-4174-87f5-d17635c97d28@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 17:45:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 035/101] tcg: Generic expansion of tcg_gen_rem_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-36-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-36-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2MiBTYWx0ZWRfXwMcUvGAR6M2h
 27JDmGGhhGG1SApraGubbDwq/Y1RSFFRzoDQBI6etjhPEj0cSOASl6l9cJ008u+2PLPsVVdhp9z
 yYLZ02MMaOKpoFHw1323CGHz94+1aLscNdr82Xt2MkLUQohHFA5fGAdmLcAeOcyXg8q/HoNhPcB
 p8QwzdvYS/69kmz+bN1Cmc9XSGrmDdZABslVoqHmBbGYLTGYMsQag4JdDHY51Lo5AbS8eW/gAKh
 xlrig8hNOOIeVP2zOmRa0FtqVHX1Xzh0SwaT/sMxNwcpVHte320Tge/TPtO91qEgewSF+sx89kL
 4C4fy5eW3jikP3LKZriHRGRgpK+8d0IAko3/LX0J1E3aut+wNB6HMJQdXtZqbiqLLo+Ik8ZQzFs
 DOV7oh3FxOFiVhFhM1qm8QIB1a61ipeqV5DchTBMjrya2QaJ48BiYC1bfHed8GJPjRyB8vlSUSj
 MRleVA4j8cCfExfm9SA==
X-Authority-Analysis: v=2.4 cv=V8foQuni c=1 sm=1 tr=0 ts=6aba8ba4 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: yto8bGsws4JjemWVyO48q-QE0i64iJr0
X-Proofpoint-GUID: yto8bGsws4JjemWVyO48q-QE0i64iJr0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2MiBTYWx0ZWRfX55NlCqhAguJQ
 xondabOFyXIqTC3LPsDplTwz6v6fRPzqz2eiSD0meJYNahZGzah88VRKjFkI1Jf7hig6VntpTts
 BPusxbwFd7rUyImirGmVIjvfkXvvZOc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280062
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 61 +++++++++++++-----------------------
>   3 files changed, 22 insertions(+), 42 deletions(-)

We can use tcg_type_bits(), otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

