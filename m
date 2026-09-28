Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B200CA5FA1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDqR-00050z-4S; Mon, 28 Sep 2026 12:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBDqK-0004z7-DR
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:04:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBDqI-00070L-2N
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:04:39 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SEdvxE1016640
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 16:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MHfLMA9tAH/2pAuT/UCQH9GSdrABKBKefRvaw3Wl7S8=; b=LM9QA+wkxgHbmflh
 gkxO0a6IUmRv0nHS2tZxhHljOOsPQbc1ZCa22JtiPeyzBpjUFbk7gH5Js8RFSICV
 qMLvCxO61CFAOPfVRXklYlxAN6/y18foi08dEQlfXstiREbnG+rUFOq+Ccak83Ms
 guNnLbESfErUud3iM5BsaAV6I4fFZT55ASFs6QlgiS8/lQK+yQicEE3X4Hq75CeS
 FldsmuBFttAIi3yqCV3wsycY3oTz/TRc7Wvymuu5gknKZC6ZZ70EWZ8vS5jaLcvl
 pZ1uAtYe1PIm+FP9VSu6IqoetTe5NNq16FWSw9ulMUkLpaat0x1TSHMtsasP9Agk
 f++4Zw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyebq30sm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 16:04:35 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7b497a7878cso156694137.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790611474; x=1791216274; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MHfLMA9tAH/2pAuT/UCQH9GSdrABKBKefRvaw3Wl7S8=;
 b=hnjoMWx16D1zqJftKcRcFbl+x/Z3Xsh8jPlZ3e2BwwI/uiaFCXmaZiRwzLSNXvopk9
 mnYSqDCsgwRObc9O9dvMtGc1TNuo9AAJiGtIjvOy7Id5mOV7GtjDtZsBgNntgu1eklxq
 KPQA34ed6CtAQKTCypeS2jgJna886PTOrFcOp8Hn/A7tmugndTN7BfbRFib21726TMbr
 W4BrOH5RQ1nACcrUNUs3ogp7dGcb8Tb8AMBAzTIH7c/jj3puhXEFQQdoXAlml0d0/H7S
 41oPd1FbDNE6O95YDmfeCeNVErRgAJDUs1AiW9rVp4I0XjzBvc7mSEbJCe/1Itfv4UK4
 CTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790611474; x=1791216274;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MHfLMA9tAH/2pAuT/UCQH9GSdrABKBKefRvaw3Wl7S8=;
 b=2p2S6o8q1BiKrOSt5peN8aUQd26Osy4JKXUw2eysMqopIbCujYLw50DXWDh/VQ+B3s
 SN6/IfHNGilIpUsUieHCEO7lMz6eiYiknOty+ltTJtHAuW2CYTCR11S53XMio0gm1sEc
 IbFWOIQ/KYxIO4iJCE1escHGYFOggybAa/qWkFszZI0+1H9AHwPakX0xNJcFlgwigA3d
 G0sEWuvgsMgTVXAQgFYypvMEp/HNNrtTWlKs4/aVHvkRM1nhhJLEAF53t1U4RxcSn89A
 5r6+YiDjwCPt+UBptM97ELh/XO9crVaIPmNFPzYmw3UlbS6Zh+O30fnzp1geMGM3RnoH
 e/7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3/2PYcXVu8YqWD6dNC0zxKKDYZdVYCrlNIV2DnGjCMTPe+Z2KQfYx9t4ztRPF0RQXxHSxMufKY69n@nongnu.org
X-Gm-Message-State: AFq9FYJFiFeWEfuetKkrAnysZoF82QCsbtO+JTrnLnsNR4wjrdxVhBmT
 aNbOsM/yYA/7B3Bi6z/jl/mTiGBI7NqoA4AobhVHQi1dm7rJjVSKxFaXu+A39Di89m9BAP3kHAz
 Nw2FAmn2bUyPHLlYRKoL2nJY8k6kS1eSzYD6ZZKXVTMT6sHWVduAYdimS3fIXG0vo+w==
X-Gm-Gg: AYBFou3or/s/VTgRCjUYIDoszTHZ/JAjUPkfd6GwrSxq7s4sZljgURcbHXxsgt6nFYI
 abSLhjWcXk1TgHxN7QZDf/NdK4jA+6uBQxbnyUOuvQnXJt9y7zRLZpTLxHBwzlOhrkjQrQSo238
 tNH2eg/tiv4Nq5HDMIq1865uAjQEhkkM9nvi1bj5s8y0Sb2i2sR9D1bOIfenG9vQ2B+QEvFKBEz
 EZnGPUHW8PAhmzfO2Bt2AKpYdeV5fVnlKv1CfN04zGUlS78zI/WYWTJnr9JBKvr5cCPQOem2O/7
 tx6TfYgdSsnRfbXkQD6TtYan/w9ungW7wpWr/P+7ybf7OMkKLPNdd55bKh5Tzb34ZK7AyBKYHjm
 YDydny3MGmwmEMNfnzCDe7lgAFbqR1iAhVg==
X-Received: by 2002:a05:6102:358d:b0:7a1:f7d2:e843 with SMTP id
 ada2fe7eead31-7af1e9f2334mr3608353137.19.1790611474550; 
 Mon, 28 Sep 2026 09:04:34 -0700 (PDT)
X-Received: by 2002:a05:6102:358d:b0:7a1:f7d2:e843 with SMTP id
 ada2fe7eead31-7af1e9f2334mr3608344137.19.1790611474111; 
 Mon, 28 Sep 2026 09:04:34 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfae123sm2118105e9.13.2026.09.28.09.04.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 09:04:33 -0700 (PDT)
Message-ID: <f114f142-f181-458b-bb54-c31f7cfa687e@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:04:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 045/101] tcg: Generic expansion of tcg_gen_setcond_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-46-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-46-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -florEaNX-hTZntylgmj999_tQDF63vw
X-Proofpoint-GUID: -florEaNX-hTZntylgmj999_tQDF63vw
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfXwPT42Z6FzjrS
 dCYX+I5ldnACuMCmJ2m+2nAb2oLBDA6mRqjHNiYz2JCTgTqmfBqAjLP2PtA9q1GbguO2w0rx6P6
 4XgIPH0EGFsBfDLs1AczjEpSeX07iPc=
X-Authority-Analysis: v=2.4 cv=EqRHPicA c=1 sm=1 tr=0 ts=6aba9013 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX+v5xaOmiMzSs
 jvtGAic0/VRVZgLbQreZf2bboT/4k6ExzuzEUm3R8aAIYMRfMxsced2gOA7qC/h2gGBCDqErKpq
 TNtUdEXiNZldmQ1zlTkIw7JBSC7s61pU2O65sZrb65KHzefBkhVyYNNyRsJn70OPO5TbYuwyLqF
 QhEvgjLq2CWVrdtbMrbCrOu3+YOuBMYdEOdJt0XXHFNrqzB3x9gb54LZVseUqjUCH6lZr2yC7B2
 FN0HEqZqURq7GuWMpGvbctCv27fMZY95xwW6pMQ+66FKhPK1SnJce65MyqEhiFx1mvnoj3+DePl
 V4orBdIfHYuqV5a+rqe0+LqUXww34Hw1Y7g5PKKyiidrpcC5wdRxrk3iehInez6vYxfUGQJ0MEd
 gbpzLK78fDYQb0m12lZJDs98ZWCXLIsORDUut8OV2GkVn6Q+jtznoYij1YG3wT5O52gaCyxISTr
 zm7Faarw9xXA4ZkO1JQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280064
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

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  4 ----
>   tcg/tcg-internal.h           |  6 ++++++
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 36 ++++++++++++------------------------
>   4 files changed, 19 insertions(+), 28 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

