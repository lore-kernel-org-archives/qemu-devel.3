Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED00BCC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGaev-0002lf-5O; Tue, 13 Oct 2026 07:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGaes-0002kq-KB
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 07:27:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGaeq-0004Ay-VN
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 07:27:02 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D8B2Z9922923
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 11:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 meU4xqtQvfFk9wsDGe2IxnFiPI9aCSinYcXkiuvfWmM=; b=imGXdAF/HZ218krA
 fKEmwl7h9CMsE4oubx8HARx+OLeQ/dEkNI766gpA1NilIMJyOsbxBk0zDBy+3+Uc
 P5rSegDU25vw+U48JQb4k3qaub0z3c2Cs5ULymgNAtqfVxPIZ6fukt370xGyADnn
 D8JSDsNTg/dKcJZjuuQwDmmikj080Ige32nV9ItK7W3GWuM90RQmC1fe1mSriKvG
 W1v9xutXMkfyLttBlIOyl3rju1l6tJ5Jus9MlnR5Ttjgj3fAKlvYQvBYjBd34kfT
 Fom4XE7EdvCKmcOoKl9P/HZZF64MALbgPwIe/Xx1NB5cUmnkYr+zmIz1g4xMz/pH
 V8F1Mg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98h1tny2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 11:26:58 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-917a7c17166so56187556d6.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 04:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791890818; x=1792495618; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=meU4xqtQvfFk9wsDGe2IxnFiPI9aCSinYcXkiuvfWmM=;
 b=KtcSK0s5XUVF2p55EkF7CX7nXLU9zkh2NmROaKZZbVFHEa/sAoIOGl4Fok6RBNXM+J
 v4hMIwNjnnpZ3C21fCy/AlHP0WEBMAbN5AmWYpt9sfIwaMD7u5EuvTXcAalZqDF63TZM
 Qid1l5Iwr3BGZEra08Nhq+ih1X5A/PzdHCI8FyxFM/d6Ozea/aSIcY5zLRO8aOgEKPHk
 QSrO+KUuMsu78hoFw06fvgMKjk4aVt48TcaMGD8oumk0BFwRLk6s82Tp9hLYeecoW445
 9KVPKqFmKXEeOcIFBVCDGxo2Hl4Y1pXRNr8QJG8iTDhjdJmfKVxoOL7Gzs9JvN5W9dBi
 JT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791890818; x=1792495618;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=meU4xqtQvfFk9wsDGe2IxnFiPI9aCSinYcXkiuvfWmM=;
 b=TcS0Wthch+ZZoC2S5JrvLN2R90vZsDiBjZKo2/b3GACqPIDA8fvw9hWKzqeeJG725o
 yb+GMPvxe31dLr+XNcH2MtzYGbJ1GI79G6H79DIICyJ6IAll+K/MGxZSsSiju/67cEfU
 K+eXKH/cK3uyFuiRhLT1iRTZ1GTEJFJsajGyGUYv7rJsi2/8KOaqSHlwu70movx6Z8la
 iF8nZgMZW0tdYjNdfCeFKBdAmfT7GMRtj0X/jOfDpbqhysMoDkw6nb5KO5YdMMx/vPJz
 1Tugx87Z/wcsTMC5tjep2hNcGe7ntIxBgjOmUV3d1/hwFQskL5HoojVs3oUnF0sw8f1D
 2aaw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwi5PQhpaD0/F26FRzzbz2lq3FifR6NKg4joZ1Pmxu4ZxrqPYtJi4EuFDia3Mn7M7Ye3ozcoOkznpAB@nongnu.org
X-Gm-Message-State: AFq9FYLi3+Ord6bSrFlee65GZ3ApzDahIY5cUXuW8gHtOZJjQmXY3qKg
 NGb0x+YVOgqT3rhePyrKCwHLasAd+AeJdLtO2w9P6f1kyw8OlzX80KwKpoOIo12cwKa2WiF8sNg
 ZMVSbRveVM/2sGQ0cdgIC+7SehTeKQPGXbFfgi271tGvurouEVk1kWEivYQ==
X-Gm-Gg: AYBFou2AT8H3arNU5Fj1r9qSSiWFv71DmAdnvYpm/YKfITNRlyOsi3QyoYoyEwbEvWC
 Zuub6SkTNfuL8Ak5qL4HE4dqe5UP7Fzo303nm+pvEoeROWOO31UGShSRx5aJL3YvRjGt9IVDRQI
 dqPtocD1uj86g7d4qgaTdIJXIIULLqQngzaU4k/5wGJu2Qv5H0KI0nciBHAIxelBEUKIuw83Xmh
 ekjJMNfpaA7VHMxFsI7oBI6/HDqr91zsQ/qW8vp69/YVk6jCeKTfTyA+zdzJCLnagUpFdGVei/Z
 3JwV4Loi+DFhFl+xNtu9KelBSo1jCBJ7nCi/7rZIKgRS9O9tg1MNHHeqh4/6dmM+1/HdwzEUQz5
 C8hR9AyS4zXNB89IercN44Ur8r6+2IkBPLw==
X-Received: by 2002:a05:620a:4692:b0:93c:5b11:d44c with SMTP id
 af79cd13be357-93ebd0cb2a3mr1932394585a.1.1791890817471; 
 Tue, 13 Oct 2026 04:26:57 -0700 (PDT)
X-Received: by 2002:a05:620a:4692:b0:93c:5b11:d44c with SMTP id
 af79cd13be357-93ebd0cb2a3mr1932392685a.1.1791890816983; 
 Tue, 13 Oct 2026 04:26:56 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be8c5e7sm447990815e9.4.2026.10.13.04.26.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 04:26:56 -0700 (PDT)
Message-ID: <98415c6b-cf23-4576-9c07-7f833daa4ba8@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 13:26:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/86] target/arm: GICv5 cpuif: Implement ICV_CR0_EL1
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
 <20261013083933.1024405-25-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261013083933.1024405-25-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VqC2kO2n c=1 sm=1 tr=0 ts=6ace1582 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=hlWRNKTsWnwO4BYjXMUA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: djUiwGbRrkY1EMAG-YFqf_Ly9o1sh4rM
X-Proofpoint-ORIG-GUID: djUiwGbRrkY1EMAG-YFqf_Ly9o1sh4rM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0NSBTYWx0ZWRfX2PojcozSdQaM
 TBJdcRM9ZSCZ1USa7VerpkEScDxnjL0FUUZoHyXnjhOtVZjTYWd7X7wKjK12Av0YxcudUNn8y2v
 J2sbhoRuNLkVVQiwKKz49uxqEHERNjk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0NSBTYWx0ZWRfXz4oKa6vkqDuY
 C1XdtHCst7/0im6YQNMWbDYUX/egSuuhvId7lxmPVgAAOEdSjgjxXgLD+33jS6WdS68po2Kkhk7
 1fq6LtCy3BeDbBS6ck+JBQWDRbpMMAhiO/BsizsOlExL/1f68c2IsaEbldXmTTyapDqkuLHVkiq
 M6CMxhgfGvXNK5pnL+Wcdwr0IcpiLr7dfeLq15Y4SUohGmrUxApP95xwEKiaA2gBBXr0GeR7l5u
 UR29v+WcHsH61EVMq8JN6erBDtrGpEFRLsiecPMCKfabemEcZKCNVFwSaHVZy/i7A67MSnRH4El
 xWPaSLgTVbeYkp2GxOi1S4cbbVEBYVJ9tJYJu3Cs3uaCQpwGIb/zAMQUnT75xOlkg2yzpZ8I+u6
 aXdyd5m6XdVLtnsEpJAoiM0YOeSLV0gKlr/kr8eoX2LmShHU1jNXzaAzxds3WlKiNPQ4SEOJhDR
 7o2t9gc9GOHzzh9mHmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130045
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 13/10/26 10:38, Peter Maydell wrote:
> Implement the redirection of the ICC_CR0_EL1 encoding to the
> hypervisor guest's view ICV_CR0_EL1.  This has only one bit in it,
> the enable (EN) bit, which is stored in ICH_VMCR_EL2.EN at the
> same bit location (0).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/gicv5-cpuif.c | 41 +++++++++++++++++++++++++-----------
>   1 file changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
> index b183c8a6e79..247cefd9e68 100644
> --- a/target/arm/tcg/gicv5-cpuif.c
> +++ b/target/arm/tcg/gicv5-cpuif.c
> @@ -67,6 +67,9 @@ FIELD(ICC_HPPIR_EL1, ID, 0, 24)
>   FIELD(ICC_HPPIR_EL1, TYPE, 29, 3)
>   FIELD(ICC_HPPIR_EL1, HPPIV, 32, 1)
>   
> +FIELD(ICH_VMCR_EL2, EN, 0, 1)
> +FIELD(ICH_VMCR_EL2, VMPR, 27, 5)

s/VMPR/VPMR/ "Virtual Priority Mask Register"


