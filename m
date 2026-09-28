Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FA9CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB88g-0003QR-Ra; Mon, 28 Sep 2026 05:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB88e-0003Ps-WF
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:59:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB88d-0000JN-Fu
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:59:12 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9MHLq1212677
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6avouMp246UlvvIsNYkqkGjG2DbkBH9slXdIgfyMocI=; b=IALZqgmEJXYnUeXc
 V7kldUlEQcfPkec7nfA3vp2eP0rLfLPW62bB1fzcSz9+IKLtTDosipsvXPC9SbE2
 yKJpdeqH8vdO/ESh2dKKHfcUvhE+jdzDUGfVRiWciKwgEiXk4+KWKuy+t6NsoJCP
 0Ov9TUr+A6+JAEfJOXGlTaAW99lp1EiP/sL0/Yu/XmFuOiyEV6xaZG/ZjPHa9j9m
 UWGJdJQ0jmHg68qmWUBL0WW2mehlh5fbIulkqQaiM+NHcQlZSrdz43j/tbI6I0bS
 M43Qsc1U3TPxnmhl3vZyQ8pqIhhKsg3ydFAvkSUIpD19SsnGujhP8I1/BgziRdFP
 uOOqRw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjkxgvk5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:59:10 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a0c7126e7so529417085a.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790589550; x=1791194350; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6avouMp246UlvvIsNYkqkGjG2DbkBH9slXdIgfyMocI=;
 b=NCHwdrJjCBY799BDADujtu2JJFIyQLJWT9KzKAmfH/JsFz9nrlL/3S44aCSDJsuhFy
 bqc0PrvAu/ouUXLHCoRUWiAUe9OjuxAutdhX+GySTZ5baVbcklqst3RIvptDqaKIx6Kr
 7HOg7gvGFekCFHaU9N0v9bwiKW3Mvv5eNQwGG/h4OcjATO03/QhoBXTx7Wf7BgUrX+bu
 3IUIY5oIBdGzNNvPr+/8Onk2WPYEWjeo1Vmt0MSPIOvUmGVQyEamgsOeLCUjv0Scemx7
 khBaCjCfp/oImOvGQUa9qiXC5HXD83WSHXZptAaQs9SQiwnREK8l8Z0+6y+IObQU0LMM
 511g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790589550; x=1791194350;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6avouMp246UlvvIsNYkqkGjG2DbkBH9slXdIgfyMocI=;
 b=zvD3Nt9DYeKSN3f79aXiNXK6Fh+1utU/2gnChHn9FVIbQOTCvedxfzs/xB2zOFYsl2
 McQCVspRW7/u1Ymc59obHu8JU8vs80GgHY2ns7nxtjVdm1f2svDDI/wL8JF+4+/yu8fD
 E8qIJi1+MDP+FyaTEHVuXaLncLiSjWvGGNfReJdNpiXmBPAeGy27JtRBK4EECNAyvHfj
 5qmWAC9GCLbeqRTCFnv7mNqdBklGphPPmrcjtfq6Y2+K2AsfBYSI/Fe0Po2hDnCEnD3t
 6UC7G3zqsVp+WRcZC3nbrcaS39/Tu450JqaThV6Vf6BxPhk4j5orwezCZMBm3rmchZjr
 XI3g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMh1vk292+/JiOTWls3WcnuRhDaV9SOOKxSOXsoC7mQsTf83hN8sGHZV5v5wCbHgFqeS9jFMnZGMuU@nongnu.org
X-Gm-Message-State: AFuF++k9KVfRNpHdPv3ltihibkX5Z3oZ0XDlvQKI+q3MV2k+lRattLq/
 Osb/EJmz/v9v5C7Ylos5TWe9L30RZDdoIEiQPhzmdfMy2ud88whM8WGk5WTX6BCar4ooJtJ9mrG
 6wuIGhrEx2e/M5tjl2mo04qXCwTt8YzmJJ43DUAY5puanoScj7SSi5Af/wACmllXJYQ==
X-Gm-Gg: AYBFou1DUlw7Y1hs7ykQUSdyYmaXu8644Y0zt9/Z/eGeMo9Ny/6fXZYkbUX1u9xhRXG
 vrb8vxW3WwqpYODqbAIWHtpKX4eO/gtpcqqQK4ttTlwWw7rneb20Oii+KFdLRJJ/xVUDrKk4+RY
 +fCFQjTluBYg0dsdij8eaA8zCFSbjKzWuIeIkn5hh6ykFw7g/2Bk3Zv0jokSdVkfMyoA0ZqSxWL
 2gBHqITVp2yZie7m2E6OhmWDpRoj+zifQLv2KUNwiYCjQ7OiFuGz3pPYdOBiv1cwEEdGccpCw6Q
 eeFt9W/qNfrVRVAVV3zRwFPI1xl9kv3DVJ39t6aK3E2Cn4Q4skpHE0Se4X5CdNUQXazSGVBKGtQ
 6fDDu3S/0y2Y+Mn1yD+9WJYrRras80BysbA==
X-Received: by 2002:a05:620a:2b44:b0:93a:14c:32ad with SMTP id
 af79cd13be357-93c439cfe6cmr1960832985a.0.1790589549773; 
 Mon, 28 Sep 2026 02:59:09 -0700 (PDT)
X-Received: by 2002:a05:620a:2b44:b0:93a:14c:32ad with SMTP id
 af79cd13be357-93c439cfe6cmr1960830985a.0.1790589549414; 
 Mon, 28 Sep 2026 02:59:09 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017656cesm122969125e9.3.2026.09.28.02.59.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:59:08 -0700 (PDT)
Message-ID: <3e937f4e-0489-45c3-b8d2-54d1ed86b662@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:59:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 093/101] tcg: Generic expansion of tcg_gen_st_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-94-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-94-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cM5VWT2jr6ncGvIDqNLMhjCjsO5DXi_m
X-Proofpoint-ORIG-GUID: cM5VWT2jr6ncGvIDqNLMhjCjsO5DXi_m
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX209eH9vA1Mz5
 KiaiSytbuw7lyS7rE5wgYnnNkhg3n+49V2i6ynB0RYfqdEjhtt1xZOEHODmfDSSYyGQ7SiK16dM
 uF7LGHDVOoIABkwvY3Z0poqmD5EHZ+M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfXyng0/BjyCuL1
 JnQJG4L/JdmJUIljyW3Az/RgLCebF7q+6IUXND/tWDvKzLtLYB1XzjgL/M5AtwoJAVWX5nt1+fy
 EbiUbiDyUCm3cccaFW3uzB13qg5r+bB+k932m91CcHCSpkLILlYl7dp+U33k10zGCCYRt9vzrjn
 5tRMhF50P11NdSbJZs7wv45wyAirHnp7mDEFNV+4XcTkS48TZJc5SS4rj6cokCs0iv7ZO0nIZlm
 2OogVAuwHC/JCDdXMFKrHzBvUvlZLujKa4vceTDd1wm5QLpK3WNW02I1waKvZrVgn5KZGULHqod
 WOm6jNRoB8HWug9OkwG/cf1yxncSgFzhsNCNM++w6V6uKi0y3twxykNsda3eLLF9Ra0kg2f9sqh
 tXP077Pv++OK2eSq56MQVMToLAmXna+/5wPNrxs0o8N0TKLT5t4Fyws3WBJg+SJ3doEkUNuo+/f
 vKrjT5RNM/YVARxtMLw==
X-Authority-Analysis: v=2.4 cv=QZfzLcbv c=1 sm=1 tr=0 ts=6aba3a6e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280039
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

On 27/9/26 11:00, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 16 +++++-----------
>   3 files changed, 6 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

