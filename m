Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D657CC5AC7C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws2Gq-0003EG-S1; Thu, 06 Aug 2026 13:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1ws2Gp-00038u-EF
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:52:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1ws2Go-0004bu-1V
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:52:43 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676HPYsc2587151
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 17:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AJ4nsKvGMdQgfz3R0offYCfnKoPNRYgF0uSUC93BE5k=; b=HJZ9iCDva55uhWbc
 YwiawpqQAKxfxhY2tdJIBWcBx2iFxlqgrLRl2unuRACAMaAvCUCs4kUJVOtjAJF8
 GauN4p8Sx7rgnuIMUNCNZV76ifxeae3H5K8sAyulvoVmQx66ZtzFd2hJHIkKJjp/
 xm2ZRZ+PpEfnX/jWoTeiNS1xMOv6qweOjDKurY3iuJYlXLwYoYBQNmPJr3sitcSf
 7wZURGjM1ncEVsErqAlip74vorc8Us1Rfj2iGcwqpiJAl/0KatNA2v7dKFUEboc1
 K+SkxlpXsZw60IJSKfcVOcOKldCNsDagUVkqUMTjt2RKkdCcC18/W8OZ/KGTwm0G
 /4QYtQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvxnk04kc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 17:52:40 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-526da7e3c9dso23834201cf.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 10:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786038760; x=1786643560; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AJ4nsKvGMdQgfz3R0offYCfnKoPNRYgF0uSUC93BE5k=;
 b=bBXMD/qV/qu0srPrNaPLvMvMXX8Jv9dY6CYM0IPefhrBVjfq6S7DTb1ciJVl+qhGi6
 LRmTatD+XXdgHoNvMZSy/rN972I1oUwvTSX+xB+Z10k7sY7pxylXkwHuutaFGmuya2ax
 t3ayOqNRgtffYY94JJQH+4frOZMu4mKlRa62nxuMS7gDrEk2U6V5awGsPbK0MM7tuIbl
 48E2HLDRuFCeCc5XRuWOMWrf7I/j/Qku2lUPZkwlpSD73AupvQ61C15bW96zI3ZdfTAn
 u07sjP2q3kzLPbWs1st9awjNr5VBpdl70O/e7acuTh0H+CkZ/5e9EiW7FdqZ9xjy3vjT
 77mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786038760; x=1786643560;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AJ4nsKvGMdQgfz3R0offYCfnKoPNRYgF0uSUC93BE5k=;
 b=JL8c8lTmF7siOF/UDaCeXHGTg+LrtYKGFxTScXQLQfW7yUiMv86Mx+XA6jpgVNowdf
 TWUaJbtiwt8daKilmNyG49G1sW6i0jb63Amf/iznfNEtiMuDxZUHz59pTViKl/iAD1vU
 Vy1aP27uXmjYJ186BSSpd6ZWe35oLnlXo4NY+oiqmkP+Uq+ds9qZN5XkigzS+P/klpOv
 Bu30/1uKUvkX8cW3CGOua0fKEfljabIMdBVtukycoYKOybGYnsTiFjmAmyKb7L/fWE7F
 9vz0jOH1dms9lylD9pUgZ9qrrfnPGqxHeTMpdBpqh+y7DelHl59YgPbT2GGDmAxxHP0t
 x/Wg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro7Wppo0x36ZjLvGmUTNMhdERZyw04oufHJ8YoSkXDI3yqg4FTQCWO6RILDTSgmlDTM12D/Cm+AStMV@nongnu.org
X-Gm-Message-State: AOJu0Yy7+iuYi9ooKnAqB1+Rr+3YAHQyu2iCwh5lyM3+5oidhjSD6Ojy
 pzF9CBL5D1UGLnxiqKjA7dHRNBB2CHgfBLNDANj0LbgHHmouhqq4LHcobfgDFT9x6++suNTSLSE
 UOlweUmZ/5zm6oBjdaWQmQFtqp6rPJK8ArsTd0czEBAWnPiclSDVrpXiscw==
X-Gm-Gg: AR+sD11tOBTQ3HFAxqYDSb6jZsN7JOPNCH43q6gpbZzrg3tp9df4pNdvqKqxTiH7aiK
 dJtimU75IaQALdjP/UQmKOHy3LJhSwZIW/dQRPHpWP/m4wdzV4En/0rWpSR591R3figxNcaMAKh
 wSULfdCwcA50yjExVtanNnWcYWu+/AdnApBHxz5hXDhHAHyb5vs9WXTtLDympl3L92XvEawLEos
 G+PEfG1ta5seOjuGMeFUVJ91oD4cjEYL5FUYW6A6Vj3ym+wTBRsWx8bLozi7mYX05B2+CGh5znj
 +795IQS+pPaneFRaeONkAxCwIrRo6qniV8kCMVXP+mRYsW2v3lHo5r0NC0okN17h99dT7Gkbt7y
 8hOQjv5R8kaKVRumJcSIuBUsZINkLcg2eACY=
X-Received: by 2002:a05:622a:2605:b0:50d:900e:c1c1 with SMTP id
 d75a77b69052e-52ce5f82386mr196484041cf.7.1786038760293; 
 Thu, 06 Aug 2026 10:52:40 -0700 (PDT)
X-Received: by 2002:a05:622a:2605:b0:50d:900e:c1c1 with SMTP id
 d75a77b69052e-52ce5f82386mr196483491cf.7.1786038759863; 
 Thu, 06 Aug 2026 10:52:39 -0700 (PDT)
Received: from [192.168.69.212] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499542241c4sm72997595e9.11.2026.08.06.10.52.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 10:52:39 -0700 (PDT)
Message-ID: <1c9ac096-d3f8-4bc9-a32b-ce1d11ea9399@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 19:52:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] target/arm: Use -cpu max-v8 with aarch64=off
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260806163939.328201-1-richard.henderson@linaro.org>
 <20260806163939.328201-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260806163939.328201-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0MCBTYWx0ZWRfX7t9/uDfvhOYQ
 dTTNVZYchsQYi8dyAj9rfYB+d+x9ggwE2czPVoYiDgsqevxdZPX5b/TgTvxVxyz4M1XHz3zI03K
 ns537a8BbjjRfsZjj6eL11irkSqzS4YR7vWu4uKmouWnNPjtzT9K0QwPvyqyUHGuRznsMJLnaHi
 N0QVzwVuni4LrrhBLM7/eXss+YoRGTlBHuIKoLwhLGxrLB+73cpPUJcvtKrKNPdcoyK/45pe/Ls
 69bbbkDR6lDVuth1c7D1dAkyrix4E54FcrLi/pq3So5BdSLcEl/W5N4b0OpU2WVF+3cytee9KGB
 YrWLxomp4albpz9VJVwkIIlUQf1dyFP5GCLrfcSTC46sw+4fqBNuhmxf8BsLzOJNh1iP5EMF/dY
 Vmixq8r/WEE3S2LEEv/2LV5K7hmCLmVsVz0QmRhGPCsNsW6AhO9+xxdktHjnrVOnmNh/MOH/utN
 PbB3XCKTELtc2ugT2cQ==
X-Proofpoint-GUID: Nech7EYlmhIdsnz-N7td8ouPcBtTh-en
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0MCBTYWx0ZWRfXw5paASTxBMbM
 SdrsD5bHwJl81KD4Z481SXQIGU8bVj017x/sy05eOUWyO0hoyj3/2aZpQ91jc7QAkmvpvIthRF6
 eikXSo0kATjArJLYgsC+mwNCGblJePI=
X-Authority-Analysis: v=2.4 cv=UaphjqSN c=1 sm=1 tr=0 ts=6a74c9e8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Nech7EYlmhIdsnz-N7td8ouPcBtTh-en
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 clxscore=1015 suspectscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060140
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

On 6/8/26 18:39, Richard Henderson wrote:
> Armv9 does not support privileged aarch32 execution, so
> aarch64 cannot be disabled.  These tests must use Armv8.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tests/qtest/arm-cpu-features.c                    | 4 ++--
>   tests/functional/aarch64/test_virt_aarch64_off.py | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

