Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9CEC98332
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 15:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqur-00066n-BR; Sun, 27 Sep 2026 11:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAquq-00066G-5l
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:35:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAquo-0002cx-JZ
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:35:47 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QLexgW3733205
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=; b=B1VGTjm7G27q6Gq2
 XCm6bosPIpA9X93s/eRAk3ntqk0UGxucT7EOsKW1WIVHZJn5JVcrCJH74I21cXnM
 psEbfvhkxyEa0wsvwnvSBmzHp+dZamm4G1T6lE8IBx7j0w+m+R3lxpem+iSiZ5zX
 kqXsrLcbGW0mTBN6HnMBcyDW+O1dSuv/8xg1b9v1alJVAMPYwGW/yqQ81Dt5dwlo
 ZKP9nWnL1JEL1K2zVLs4j97UjoIa3DxSlSbn4GvfiQVZR1mIvNovv5fDfoS95iq4
 S18eR8OKmOqhoK4EpUkSblhwaslGqq9AcFXCKTP1BSEqRYtFZJBShIS1mOPMK3og
 lpwr+g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx77ju360-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:35:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a0c7126e7so434240385a.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 08:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790523344; x=1791128144; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=;
 b=cl0wbLDwdbr1K3x0+uXQBWDeDQAD3fi+TR+qgcjgOp1XyjjyRCCF/nhHYCIf3hq2fS
 JMuWH4TMOVe2MHIUGl+x444f9eQGahgqJ6M08NPjFEI32OEleKz9z1hTjXFba2WKuMRq
 uXPKiwJfyvkRFjDmXue70xyPmGYaUz0uRNHUML4eejcZ7wYsA4kvcIhxqoGu/0tVDPJ5
 m5RgdXwelQGHkgP4hhD8i0W0/uZjsucgyEt/Bb+zt/0+dyumTOmgLx/zWDRrrhA3T/XA
 gy5dnZET5utL875OwzVUii/vgCPRM23hvMDf8czXZQZwZ88tmioof0z/ZMu5AbMD+g/X
 /DZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790523344; x=1791128144;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=;
 b=edlbTycsQMKFaNCOeENoWlK6kr3mJOJWh8n5q16kgZL3vxqbZa7WwN6AgXc1+vfu1J
 4c+pmvXCmxWvZaHSMRGDLe+45ktNEoQhV7sN0EqcJ5KxT9pSt58hWwafbqXJQKr0pZ/t
 FT3oc9Lnz5MIRrn/TPk4Iz3qbuL/f8PAjZOAfib5e4a1Z0RYsTBBg834mWs/5zMgfiTW
 skCDYO6idxGrqK9XH/nYCrX4ngYHPZ48peyCXBz42u71cF0OU/H70RLyadtVb+G48t6b
 jTM0Zul209PSCRvC0KhswQY6fr5ZIzf9h3qUPZt0cM5DIdHI4dUE8i9DJC7TvM8ycu9c
 4HLg==
X-Forwarded-Encrypted: i=1;
 AKwUvBybUKFgnyYIorfW8irFbLM9nTfsMxufRv1DoaDfa8E6SSgFl75dYXKYhp6+fTCrALhepFtBpzXabiNT@nongnu.org
X-Gm-Message-State: AFuF++nesAQru1dtaJHpX5s+R3nD9ba9se0gWobsd9YoKVdzd9ueo3dC
 D73c3nnxZm/nV9ll+P6iyFjx0c1ifWmR/lCT3MRBGB9UryZ2BD9rVW47TxGhQWBNgUxBCairBQ8
 zON1P6WqzjRiKODbrHGuwlLRqypdy8LoGLVeQDE/4IMBiNZPPpObGJfH9xw==
X-Gm-Gg: AYBFou236U4cGqFnBdvt7nkcbO4fhY7za+JVv0vS21vyWdzBiPgKTVqNxWve7eyhx0I
 ANDwofkzVaZt53MQftCNQpqcuwP1aN7uayWxNhEiSEK1uE9snv2FXgJvDRTAuIT5TV36pKQhUW1
 zpU2nN/ienvvwshCXXWlvYYiuCThV2UwanhKEgMxn7bZz94zq8+SV2Ci59jhiiTDAT3A51+jT6g
 tCKub7Q6M3lozgZsR0dFh+1jUMpFskGS3OUko616Vx1qlXCopAyR273PRB4kbUAa/HLx+IhJCdU
 B7Ka69d6tn9Y7X10SijHe3+Wl8am74/pE7iLOQzRUK9VZ+1pHQNfLQBaUiG8WzMVrNdsYUlGRkC
 XdWK1DOqhiYjpVklssk/WTIx/FJTdMpUFAQ==
X-Received: by 2002:a05:620a:4111:b0:939:733d:cbe0 with SMTP id
 af79cd13be357-93c43b83081mr1579343085a.3.1790523344204; 
 Sun, 27 Sep 2026 08:35:44 -0700 (PDT)
X-Received: by 2002:a05:620a:4111:b0:939:733d:cbe0 with SMTP id
 af79cd13be357-93c43b83081mr1579340685a.3.1790523343846; 
 Sun, 27 Sep 2026 08:35:43 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a35fb05sm23222322f8f.20.2026.09.27.08.35.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 08:35:39 -0700 (PDT)
Message-ID: <7831f8e8-7a93-4aa2-a89c-61fb38f45807@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 17:35:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 024/101] tcg: Generic expansion of tcg_gen_mul_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-25-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA2MiBTYWx0ZWRfX+9DNaFO72uxu
 X2yfbPFJjqqGnZoLB0UzEuj0gnPAX+UUXEfbukz784m4Ul/Q1SwH0VLiQ/Zbazfiaso3sABBuXq
 OhrCgabFvUYTYw7jRTqz4iy0XNSGuIw=
X-Proofpoint-GUID: -h7LgQU_aR2G8flB5LGFrvrz4mYOKfAK
X-Proofpoint-ORIG-GUID: -h7LgQU_aR2G8flB5LGFrvrz4mYOKfAK
X-Authority-Analysis: v=2.4 cv=J8U/fwnS c=1 sm=1 tr=0 ts=6ab937d1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA2MiBTYWx0ZWRfXxCEbi/nE1QR+
 0MHO48i/VlWMrd/34o/2BhvUC4Lo+IyYY2G/k/wk7ZlLQQq89o4cYu/ePUgoESgyvRhDGkVBdhc
 i1w0uTvt9NYaY5hqL2dufbOSVTkO4MidSiUrtg0IfqJm/Jch92dkxxG1EhPMG6L5BFbehoZtltK
 DUElVr/j9elipAzoXmXevzXZaC4ChzK/T3+eZARCdSZp3+1Gx/Y1fAFBrXKXLyAGZJ+Iv3X5Pfc
 1iOCCeDVwjhhmJNugWUSdumfKCvzBQ9LVvaiazRM/snICM0DE1AasRXbxBbHIV/ymOTEyxPCGHP
 fq63qdmAjsjluOndmqaM/9ZUBm4QGGfKKMGkg8jw94xBEyeV/clLVdtd3TQuvf1Kli34LuXgu0E
 ZtemRGubfJkqlY/QBNg3KJRTyx5r31uEMqmFSRM2Hu13gn9MjLw8qOwEm+GqyYTaHkBNndAJHU5
 bKYqfULj9q3vtmA53Zg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270062
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

On 27/9/26 10:58, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 15 +++++----------
>   3 files changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

