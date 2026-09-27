Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A601C9832F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 15:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xArAO-0008Hz-ST; Sun, 27 Sep 2026 11:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xArAG-0008Hq-VU
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:51:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xArAF-0003q8-DB
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:51:44 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QMF8sO2083722
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bX2YixwEiNQPthjL26P4t32OlM6aCc2Vy3K/bh1CsMk=; b=MW2k1I6vU1drPT31
 OCUfV4KAb+aEPh6kTvBis54+EeP7WsSIeTFfbJ8eY56KjVR3s8AjvN486URDEmlp
 RfvFWFScqcFgZMkdouw/gGCEf3evHIOPZhgdOxC9LJTExPdrDXXMcxVi+SlkpDrA
 9BYo3BbeiV//CHiqq2SVATC/cjp0PAHXs+66OZxlgwLVycibnng+6+yp2H6ZtadI
 JMA/kaknJEpU6aOV/fw8gwqoa2ZQV5c1bYR09AYraEKKkmFR3q/8MA7NzUWSTBO+
 Jnpj7w0xcrY6qRqNwL3n5BV/WLQozGuZmdXSC9N3cMe3uvil4nwN9ZIF4nMGP+Zr
 E9qtOw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3rfuht3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:51:39 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9123be39eeaso49701696d6.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 08:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790524299; x=1791129099; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bX2YixwEiNQPthjL26P4t32OlM6aCc2Vy3K/bh1CsMk=;
 b=Azta7VozV7pWSJyz2SWAA99Q+7Uk1itJAImqTdZi8VQeiz6ETGrxGsW26F5pkOWDV8
 JFY5BJ22p74onZ3TPhqqGyu0vlPLxkaidXWC8jh484SwUZ5iPvCR99BYFGZ/HmyBTJ7n
 sjgHfFduUh8Qw+7ovr/2MfXHpxXYe6uzSgtS3Dsc09vNpY+xvqWQ3drkdWPjYDCq+0tv
 GQNbIt+wOGUTsNFOuwAZq1k/NXiV2gAi3+iQQLnpZ/YRa561UXnNQGus0uNS0tv/vdwi
 mVXvsuClI9bNQuoU9PQMLVtHUvIYfy8ZaZedzt1ppnhAZqRZ44JQzte8Dih97ZXf1zC+
 /tKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790524299; x=1791129099;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bX2YixwEiNQPthjL26P4t32OlM6aCc2Vy3K/bh1CsMk=;
 b=VQXt2ux2t1klFjL/eM9oZHV43tIST2og/WjNjiMDwY661PIL3bkKYjZpzaLrZEeAGU
 Y0+bNPOQK5VCMzWgMXb9dC3sJmE9jYi5PsiDFOsDd6b0JPMVI89SRKGessFHr4Mo2QMl
 v0IAmw3cQQIDIohk/pjAFl3cOvELW7faZcelvN5p5xbe5g/niY9aN5cV7Jf9K241UHJ8
 6IKOC8mDPRgOvK8C6PUvWpU4Zt/4YyaEgTrvNtYMYldjlvR35U7/TvqfhQ8Tva171jJs
 P8hAxE7V+ir6vHM28Asthj+5TGGFygkPMvIS54nnOpCIDdOqcOL0Y7lAB9Fr+8qZGzq7
 zmOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByxjXTbW824eyqNF6cyhxD/0263q4yfzVz81Ut3WpYttOOATf6RsyLkhgw2k3tdOygZlDiGoeb7hk6j@nongnu.org
X-Gm-Message-State: AFuF++nEMQ/+b64Jv0Hm+h5DtBEINp1XsQgu7iIgBAgj86d+52IGuQqE
 2AmZ1eBidaUsJsNw3jUuXjyz/5ASHx9vlcOoHCxA6yG5JpS/lI/X3F9erayOIMMUxCrhw6UJvfo
 gWfmznaDQTWFfWb62DfhBYDEgZnSg+1auQqOY+L01F8PO9URt/QPngGD0dQ==
X-Gm-Gg: AYBFou36aK/h4J6im9IZ9nLQAigAxUzUCXzk1FAMaRIHODaSYP/8ZMrgmrII2PWIfA9
 WXKJFUhU1j+g3tvEWROAT102QdFlSQkZ9eEtQ63TfJIf4ZhYJQqoz35Xr+Vy7yQ22+/959ayYTr
 J59PqDRDV1DjD/kjyvgiYzptDVocKlXiCb5xd2pjfAfJQQiT9b4PgflE+ezUM84pQeS01kS5zKx
 9xK3jaIEqn+vPHtp3Z4fMsMRYaD4ex8isjipMNXNjpEmmF5jVCk769u9fTFcR2Whls4gcQGZy3x
 cF36vf5FTQ7yTrOKhgWdUpFexmvstg/J0ZfSzJgbh6KoXRly92HvNb3UkxuLTxR9Njk/LVc5rEW
 pcntYl2VjaRI0iT4ofHy4ZLKvdNNR1j6ADQ==
X-Received: by 2002:a05:620a:294e:b0:93c:6d02:9d0f with SMTP id
 af79cd13be357-93c6d02a148mr428019385a.31.1790524298777; 
 Sun, 27 Sep 2026 08:51:38 -0700 (PDT)
X-Received: by 2002:a05:620a:294e:b0:93c:6d02:9d0f with SMTP id
 af79cd13be357-93c6d02a148mr428016185a.31.1790524298369; 
 Sun, 27 Sep 2026 08:51:38 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017652d1sm104957145e9.5.2026.09.27.08.51.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 08:51:37 -0700 (PDT)
Message-ID: <9e71b3a6-4afb-4208-a6a8-9c100775b061@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 17:51:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 002/101] include/qemu/compiler: Define QEMU_ALIAS
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA2MyBTYWx0ZWRfXzRlz5NzaXkef
 QhaYQX5zwFvpVhOXhJeZl1L8TXRx+s1FLvhP0tit/MqFz7HZBeNo4S+5NVYxG7mban5+JRawcy3
 VCpmB/brnnuNJaXpqsbvD4iviCT2/FU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA2MyBTYWx0ZWRfX00j+u/gFqSTz
 eH6Joz4qdu4tgyng9GxbsbqqqGhqbIozLl/sD0psH6h4bfoamnE1yoBoaOZNn9Vr3cVxEii7Crw
 Vm7W1wyJGrfJ3LHUrCnAWmpLyQcT1d4pIFY2dFHokypJS5BHmHPts+18lOIfj1hVrKI1L5h+HTv
 4RPamaRTDcJoRpUPlg7hwDFRprxVOO5nOtPtfroShKrUK4KVrp7xYNva2/rX1jU0PSI3UR11k/+
 Hj5y3KBnktnV17rvLnpeUGI2eUNWdHPu2sCinB5wIDAccmhzEOgzxIFArvzzJb9lm/UaM9754dA
 EawfxKBasWa/Zmi3tCb1a9zmpLxtCQb9ZEt/pwM6RBC0SeWxYSbvGM/k0Nt0CkjPowfEtdv3TzB
 0TDsUlh2cR09kIZtqaLATmPqZW3XYAhluO1CrgyaH/Vh+OCXsds8dbDxGdz2fd4E63+b8BPDor3
 OWl/V5l0RshfW18lHKA==
X-Proofpoint-GUID: IM1IEsC2r7iDvtRfBcsEJIluiN5VVRoy
X-Proofpoint-ORIG-GUID: IM1IEsC2r7iDvtRfBcsEJIluiN5VVRoy
X-Authority-Analysis: v=2.4 cv=K6G3jCWI c=1 sm=1 tr=0 ts=6ab93b8b cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=Twlkf-z8AAAA:8 a=KKAkSRfTAAAA:8 a=6g75kJ9nBWDuDCmtAv8A:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=-74SuR6ZdpOK_LpdRCUo:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270063
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
>   include/qemu/compiler.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index 3661dc5fbaa..8fa4552ef8f 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -230,6 +230,13 @@
>   # define QEMU_UNINITIALIZED
>   #endif
>   
> +/*
> + * Alias the current function definition to another.
> + */
> +
> +#define QEMU_ALIAS(N) \
> +    __attribute__((alias(stringify(glue(__USER_LABEL_PREFIX__, N)))))
> +
>   /*
>    * http://clang.llvm.org/docs/ThreadSafetyAnalysis.html
>    *

On macOS:

../../tcg/tcg-op.c:1820:38: error: aliases are not supported on darwin
  1820 | void tcg_gen_discard_ptr(TCGv_ptr a) 
QEMU_ALIAS(tcg_gen_discard_i64);
       |                                      ^
include/qemu/compiler.h:238:20: note: expanded from macro 'QEMU_ALIAS'
   238 |     __attribute__((alias(stringify(glue(__USER_LABEL_PREFIX__, 
N)))))
       |                    ^


