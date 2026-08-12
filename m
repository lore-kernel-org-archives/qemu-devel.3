Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9766BC5B567
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu3BG-00070A-J0; Wed, 12 Aug 2026 03:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu3BF-0006zx-5n
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 03:15:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu3BD-0003B5-J6
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 03:15:16 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C79Wa63144294
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 07:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TOMWju2MqrEewraL1Y2IdtZinY7l+nQWIh30uq9bD08=; b=ftv0Z/JCgv4IUk78
 N8kZvg+jx5+nduopYJrK8FLNeCGIOi5tvuVimcK6sfPeMfNxtXISPbH9A+LB68Cr
 Rjtd6EtNzqqZXhKF6EXqLU4QXxrnCdBBzwccrPFIAFcbkXZdmktngPJEEUfYj4d1
 FXaZXvdBsLZPU0atHdWV00LZv0CBThxDz/Gkcznj4tWrVWo9VfRx2ILqxmTPuCBY
 5iZIl6nBe4S08uMBxTr8kn3vkLvktJwUz7lE2iYsFFkzR37ZeRirdkgzMQjNvQWe
 L7pbdMUyb7d6TyDl7eD7n/LYsEU/7olZDD+6dOOL7tXMin24IzPOR8gCm9X3uC3V
 6Q7rpQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0m6rg0s2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 07:15:12 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52ce3c7cb2eso11643871cf.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 00:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786518912; x=1787123712; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TOMWju2MqrEewraL1Y2IdtZinY7l+nQWIh30uq9bD08=;
 b=DKcjaTrVa9uUXjjj45YjRXbOHyjyeTaEBYugCIIsGDxG0fifl3pftjYEvxmLRb4rlC
 PBWDISacXSBGDWkedYykQr9xkPj54mUwOhprq1TrmasGr4BilW2jFwJ+buf4+TwS5sMq
 5bZjC3BMEUYoKtbylqA/qhDWJNFHaxUDcLyeAU3VoWKOpjpLUGCo5pme5Eyybw4d5I1c
 1rDeZ8s/Hn0zHWTHJNK6yurGXm9JSc2ZpK5tU400AZGFYdZwYyQhQt8Wf7rKYXY1CQ9+
 iPB5gIqRXKWErqi/XjAJ9JKZywGwti6JrG22qT3MDb1t1mY7xytkmmxNYcmQaRFM/XLc
 0ztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786518912; x=1787123712;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TOMWju2MqrEewraL1Y2IdtZinY7l+nQWIh30uq9bD08=;
 b=sHzhEguBTAwB40OHz2Ex/9Q/QRXgvtwTvB2/g2FImJvwqXCNuq1/OFEk5CqL2NLD8Y
 5sY7DizrAyL8iaRAtW5D3C8stkII3s0TS8OnZeM65Di6ObMFwKVntgds/0505M7zNMj2
 Nq5UK+X1FFl08ztikLMAGJLXIFU8Po7UItuaPqiaWQNb3kzIBPAa9b0SdwwyiE++FJbX
 J4qOrK5FSrqRJ+ZG1WVbAipnRawqlQiVfZy+V7DCf3mQdCoSSB/FRpG9pRyG//LD04N3
 3lYa7eRLiTo8t/rJ87U4qnkkcBPtJfZh5FTc46U87xwiGTqddkBt+U21acl9aeZ2JsR+
 ayMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqfIXGDc2SYkqwpYgIJfDpkFRsaI27D23LywJF9CwagKmzHkBkGsT3ZY1kv3SWVllZ/F8MUzGMWhbXw@nongnu.org
X-Gm-Message-State: AOJu0Yx/OeFnpSttXx47UnxPwynVufNYi2N6/yWvKmbAMwSdnSVkmKQk
 SMSVcBmfIeA5p3fcEuLlPq8+eAvX99An7+AMSMdF4SapYFKMsKyobPrVY+5hU3z5p0G21eIls5T
 +DNpeAKbu82BjDpEFyH2lMEN/S5r6I6355/hwqBq5JbfIfAxRDubLbjDRdA==
X-Gm-Gg: AR+sD11qLknd9A/i24M0ADq88W7ir564PuKqoDe9tz7hGL9Jk337XeysyTnWLSKqJwv
 23HVziLnBqnFPjL4rg1X8kE+Bfa9ZK+UT7SiS7h0tMt+NgsjKCaAM4vK++wCcX4IROQVjlUaZMr
 qI3KlTEM2xHKS/fhkkFHAs5k+rk2AS+ELUqp8MAenkZGfm2WSeXE1KLljyQ+Dhg1uHJbp/jW4eA
 Y2SZBfJCcgO/l4tUJaIPy07nBAmBd2pdv7rba7Hh5ajl/cNgbmvDfoZKFj9IAraxN2RCOBdyI2u
 B1VwnEfenLJZexduzF9+cNBkBAEejGWtA8dpqrBc8LR40vnNKmTWaJYWBjThP8Gr8lkRIDQlm1n
 QHp5VV0OUX42+IKGgQ+8kCy3LOIMihrqvRaM=
X-Received: by 2002:a05:622a:4015:b0:52d:2ddd:27c with SMTP id
 d75a77b69052e-52d64828bb8mr25249121cf.31.1786518911657; 
 Wed, 12 Aug 2026 00:15:11 -0700 (PDT)
X-Received: by 2002:a05:622a:4015:b0:52d:2ddd:27c with SMTP id
 d75a77b69052e-52d64828bb8mr25248831cf.31.1786518911272; 
 Wed, 12 Aug 2026 00:15:11 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150bf7767sm4477288f8f.5.2026.08.12.00.15.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 00:15:10 -0700 (PDT)
Message-ID: <62354a86-66dd-47cb-bb63-f96e7d372778@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 09:15:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] tcg/aarch64: Implement min/max with FEAT_CSSC
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260812003143.225228-1-richard.henderson@linaro.org>
 <20260812003143.225228-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260812003143.225228-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1NSBTYWx0ZWRfX9rFU1uFYEmjF
 XLlKLIdUZcvSaEtL2pnLTSxWIZrDkDSeSmoxxbjTG6BAsuXEv/LfUw9u/4IGBQJ7T5Tp4p8pbnR
 HKPCdmORM6WjsKP72WjV3RFmzIYVyyonOEU8qNyfPEaGcVg8KS3Jpt0DS7umXze+8PUG9V9MP9u
 iU/OmOsbYe7csl4/P7SULJz9dqaZfjLpGj8fVd13XMHez89jf+mpVbV6ju0KWnI0WWbv0chSB9O
 DtUoVXkJaVe4fBFvTFsK/z7r4C9x7xQMxptosVNBc+xF5+l3wj6Vp3bpLNtYJL+oaFxtx8kTJd4
 0lP63HBxgS9kG7eyBQSrMtxjvLno56UpJhTLTFMvKSObwyymyHQdGmJ+ha7Hq7YaOQNUUAYTzYh
 PbIVuK6sKYx82PgHW5zuRNOMUnsNYda/88w1JPrEofOM5LCgjL9L2J8Yb6zFF1M1Zv4mrgLehGy
 RF80LqVjI2T5M2IF3ZQ==
X-Authority-Analysis: v=2.4 cv=Wb08rUhX c=1 sm=1 tr=0 ts=6a7c1d80 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: uvupWuUg0W6dbmelqbV5Pcj3bNXLlAIY
X-Proofpoint-ORIG-GUID: uvupWuUg0W6dbmelqbV5Pcj3bNXLlAIY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1NSBTYWx0ZWRfX6a/bsv8Tnbvv
 roLbIB0gRZnaXtCAkyWKtr2oear34W5XG4f0ESeuuTG7UWhB5zIuY7llRGPkT9z6Hckom5D0Wlr
 2oXF55oqEZF2dv4uXCKAz0/4llU++uY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120055
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

On 12/8/26 02:31, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target-con-set.h |   2 +
>   tcg/aarch64/tcg-target-con-str.h |   2 +
>   tcg/aarch64/tcg-target.c.inc     | 103 +++++++++++++++++++++++++++++--
>   3 files changed, 103 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

