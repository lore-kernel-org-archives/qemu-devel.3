Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD72C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpgSL-0004vX-Jd; Fri, 31 Jul 2026 02:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpgSH-0004tq-PK
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 02:10:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpgSF-0004df-KI
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 02:10:48 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V67YQH3011074
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 06:10:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3VQ5v4Cl5+KDDSQSkvxb4ZSRbn5yJJyBI5nrrIbtRvg=; b=GZJrBg00hwDU4BMg
 YuEbbyODqgYNverZ6L/l2S5F9tKIrS58BhcVEDFUEwKZFZGXKOooIubL4KCHR6nY
 2Ebi59XuUR5thXdeuX8hldTiLBKTUrFlxwQYr+Gjw4f2v4doqU19va57bnsZIVkC
 AL3uYhotKaGwx8jt9m/VDMTPm9FVfJT7FBx2yCgSIldwXLIKD9I2fNy8jUb4HGzz
 7TH9ZWAZnUltZba57SSii75mSqi18hX5A4MdUC5wwxo/Aa+s/OKSTd0MR1lqZ+LH
 KmqFFDC/rkhu4LIqQmSviP6MC+C640awTbbL2+zn6kOKksHNbyLlBSUgSlHMgANo
 v9f0cQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frp5n80bk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 06:10:46 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso5517671cf.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 23:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785478246; x=1786083046; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3VQ5v4Cl5+KDDSQSkvxb4ZSRbn5yJJyBI5nrrIbtRvg=;
 b=Zqjy79EKmyA+LrdceGhCMaVkTJhJUHKk02kYkUlUetAPjryIccx0cpyjwfT5KZGRyM
 Tjey3X2uy+rCB9JZ1ryTyTWURIMX/cOfip4qLopgI9Y+kb3ZvlCyvOzMk+LLkJFGVVxO
 WHmAetF5MuhusWGYoayNjjoMy817xe+mxGYvpJtWwJF+mH381kLgolxpP3kYnkV0WyIS
 BISwwlpmG7h3qT/qezVt/qggXJ2RJx/4Pz+H+oziqj8hY/r4D9AKV3rB9szEtztepRD9
 9aqe8/efMeQlXSISGE/b58u0EvDtqP3tJRHAjGnXqzMZKBu7KXOQyiKECp7yF1HkckM4
 5Z7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785478246; x=1786083046;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3VQ5v4Cl5+KDDSQSkvxb4ZSRbn5yJJyBI5nrrIbtRvg=;
 b=bPPWUAhdGxzArL2fBgo8lTxl8WFQIFoWT7nZ7ewntIIhzFEM+5skD9U8tIwVuIFif1
 qjEPWQ5SMhPkcDB7oYNXF/LrCJrPVneUhs5ukizCQKKKQTU4zxQI8k03EjtdIn3bQcsl
 a4ceQX9JrxkWyUvd418sHT1F67JapvK6M6OjOFIzfcG2KtQciM7GLoKwutw6NFcVDL7/
 fZcYailbI8e+cVBhVJuZtaD3Nco1bnvZOeUZ1XPuad75Maqu9iFZXO1vmwi/5Rh+5m80
 lofMAiFd7EKSBs2zl2/ZRAPX9VMXV3YW7EnHbsa2v5VqMjOKPYkJ/ijbSqx9OOW6wqDz
 33LQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNjXFytqVAa/3O6pWGf8o5IWttuLFngkRqPoHg/AQdmiqPdfvrxuKxfbkQkhf/iaXvW8YWgokc2eoa@nongnu.org
X-Gm-Message-State: AOJu0YyPNDuJeFcR//hD3fuBGFbVAmoua2kggsgRT3G1zTj5GmDkGtN4
 +q6KcaR2UjDPCtgPVlR2Er/7/2Xv0/gIOsexpyHPazHZ52ZoAJfI1d3JuvkAAWCB/fr8IxhmsEr
 4nKOpNJCxm9HYs3nkFbwgNRWfz4DyaC2u0KYSTc9BXUtV3K4AQx+EN/1KMg==
X-Gm-Gg: AR+sD10YAAPUxvNNnbN0OuqJX2pqv0zpjDMECZ66VwU8z5jZwlaZsBPtiQSfdJD1SZW
 npl5oMuLai47e6OOt+bz46c37hFFfecbRJTk+N8cuC1lpyGR7r5JH2TeZV3ffq9RDvQarWBi5Pk
 fk77F80xLAPv4ZC66IUqU2RCjS8QpoATi2+iwN1zowkuBn/pUeX2KiEUB09yp4MW3mztbI+G30M
 J9wh/At3BcCM0KflODPErXyIbPzYmgEtw2LWLcInAP3iTvle09u6RiCybToXDeSEKOXVumcRcib
 ryUsgccLbKyj8DhxweG8G78lpIyoTwu8YMdj24sq14jNPjT5kUzJKuBaBqHSSS1/WubP9lt3k7Y
 nlBTFw3qd1FnGY3zu1YGrRif5rXSP23gzdq4KJB2MuyRuT4Szajw=
X-Received: by 2002:a05:622a:c3:b0:517:6b31:8058 with SMTP id
 d75a77b69052e-52b4b074af5mr7476421cf.40.1785478245814; 
 Thu, 30 Jul 2026 23:10:45 -0700 (PDT)
X-Received: by 2002:a05:622a:c3:b0:517:6b31:8058 with SMTP id
 d75a77b69052e-52b4b074af5mr7476151cf.40.1785478245397; 
 Thu, 30 Jul 2026 23:10:45 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e2961sm979666f8f.13.2026.07.30.23.10.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 23:10:44 -0700 (PDT)
Message-ID: <3bc2fed6-dcae-4735-849c-1bdc06c127fd@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 08:10:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] target/loongarch: Use generic tcg_gen_revbit*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, qemu-arm@nongnu.org, git@xen0n.name, 17746591750@163.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, philmd@mailo.com
References: <20260731000503.170446-1-richard.henderson@linaro.org>
 <20260731000503.170446-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260731000503.170446-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: W5I-IXa9o-SiYu84q8wBjZ_0n8-uH0_w
X-Proofpoint-ORIG-GUID: W5I-IXa9o-SiYu84q8wBjZ_0n8-uH0_w
X-Authority-Analysis: v=2.4 cv=bKwm5v+Z c=1 sm=1 tr=0 ts=6a6c3c66 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ZHt8mgqs0VnmK-j-M60A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA0MCBTYWx0ZWRfX+NW4qK8eZkwC
 v7IdfFeTjMlu0mrBMG1I6Im1UChTqAdtjpmoCbnVBsw6AmZKXfPqK/jUqKsBNokcQI/vODksP5k
 r64YFWi86XHyYznBR2+j6oI0R+hnD8Mih4/K+6mAA0MyUSUwbmj0FWty0MmHrAo07DPrm9+5IEQ
 Mcfc21m3bm1S1bJgXy+1c7e0+fQVKIPCPYGssVRr7x9WdvlEWyt6k6HG5v3nfmRlb4+/QEKtxdf
 d3ylGb6afmKaUxFf9cmmTTnPrjqLdxohh6bs+m15ZGsSGZFK5TxAsWJYn0dq+thBnWiqOITAGkc
 cyrz1tSM8OhUFxOaDeXYNREQTlG0pI1qlW+/69BvPoGGTjg7wVMyyDAcSTf98Gj5JIpw/TpgDW0
 P+DaTVYsfH5ajYN+eO2aKbct4yuGXBdVXGGJia1CjeJdQZ4Saw3/iPAofUjdXbiscHwhdAF8vNo
 VGh+CCgnYm+yQd8E5Lg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA0MCBTYWx0ZWRfXyjXAEpF5a1K+
 poCTPUkbGpSC6QmxASINscy0FoesDgJkGgmWdzP347hGi1TYjCU0+COzTfypcMXZOJMY19PFhMl
 uL1s1hhfgQYCIKXrr4et/wMby6VU/gw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310040
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

On 31/7/26 02:04, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/loongarch/tcg/helper.h                   |  2 --
>   target/loongarch/tcg/op_helper.c                | 10 ----------
>   target/loongarch/tcg/insn_trans/trans_bit.c.inc |  9 +++++++--
>   3 files changed, 7 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

