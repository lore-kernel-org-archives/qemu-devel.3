Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AFEFF887E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIFDX-00069L-AC; Wed, 29 Apr 2026 20:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIFD1-0005p2-DU
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:25:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIFCz-0007Ai-Pq
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:24:51 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKbrai1133009
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 00:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5Kkdc3OQFPGK6WIcxjNrvWLnswrUNrhK1wroj+ZbsJ0=; b=KHRPdymNUHpSeqq3
 am+Dnq0eD62STgCJlu4xlNTBzEPKDHvL9Lidtqiawl1ZRmzeEd7lexzDx8CUwopm
 nvYnxaG2AwpTtqNyqB/CVJfTANJCuBoORZ8SWXJazL0KTPfiVa/Onxi0gX3XRM7I
 bQG0pQRbcyoHA/89P0lNZqq164N1B0dRTeu0MLrpfv3U3XfJdRxSmsjdrB0STY7K
 vWU8LFqZ7QRoUjOlcgjwhpq42z3Lhk/Ezp8dNlqdc6PpXoPueNO42vZSVT+wqN1T
 8ERtq/+XMEhVYqLLh0F+FhcN3nO1wZ5VqZKdx7RBdQHGMFaIlpbmC5eIzjUuyyQZ
 t+XjBg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duch1m12b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 00:24:47 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12c20d5d7f4so712166c88.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777508687; x=1778113487; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5Kkdc3OQFPGK6WIcxjNrvWLnswrUNrhK1wroj+ZbsJ0=;
 b=HGFunM0QBpI5Tnu4O3x4H4V6fAQPN/gdSfk63z5dpEVzhSdz/dTx40NddNzvLVa5KN
 n3oIRDu/5vXTb9EA5g8S3/Fmk1NWIoRA62vfU4iqpMVw7rws5faC5Uq0vcInxGNDq1Tg
 iKH/BJgVt/EMtlCSog870EJnydRajepSJyhIHJSQRPwC0/DqsVsQcIL7BCNtalW4GU5U
 rygQSFDWshFGyNSyPLnpjetIfa4R6XsWR6M4kz3OUUKl5iRdNG+qZN3l0KwwOZAR0FKB
 GJHek3uLeaVH0mT5R+b5VHIKDvjfezQOJ0CvdduiWNtcHAUl5CUrdOwah7XLTv9/0Knh
 hRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508687; x=1778113487;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Kkdc3OQFPGK6WIcxjNrvWLnswrUNrhK1wroj+ZbsJ0=;
 b=Hnz5bpFtOi2tTnixiju35JaRR+wOgYTfJ/wSGSOJuOqJKwQLTLtXSJ3tlyiMsv21ly
 xfsDZJFdo2saTVIagEL6xwx2SqoP4dOBuvjY3Bc0r9CprsoEGJMdKkx+Ovj0reJNkDkI
 K1700Fnk0zqVScL+OGUhIhPQXL1B5fWXEQ9Z3x2Zce4IeD4baMNniCmr1p8ni6AiR+I2
 f039eeySB0u/MwfOfpoYZ9Y2OJqvw64v5MPVsl0NP3NGrBLrXAg9XlxZlkltvs0uAG9a
 zcI6uBeK4N9DK3O3+acVeGcNUdIa9jqXIY56endoSyejfy4xUqebIDNpSriH2EmslW6O
 7Dxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8T2vV1KzouzuOy5XLKRe9c5xaBSjUqiYO+ZJRX4ybhzKS4ansIasSFNZaNMR9PWaYREvCjfE8LZjOS@nongnu.org
X-Gm-Message-State: AOJu0YzFVpHXhzV8iWDmnKXLy8jKgOn0BnPRvp98FCGL5AWVMokatIUQ
 iELOskTJdnL9uJrHst8yJT4J2qN4SAg7IARxnNtciKITClDKf7lfgcpuImquhjWzo9eUggfFLWv
 ugIepuGlWJSzC0b9bbN06i6WFnnP1FkICjjHT+xqAMnNOv+7wIymQOsZZAQ==
X-Gm-Gg: AeBDietW0l9X1qurROgbXUfYAivkKemK5bVSGkPxYuw8J620SAZk6CNiyS/okF+8ctf
 fDLBzxfnh5732agkOccNhaqrWzpX5paGCb2zI7MJ4ZUoEseLMzu+gRxMHXPYYjuDjR2S6FGAFvN
 7r4BN/PQUk0ap96jBmJsNO2tmHybzJeXdK3jbSWAVY3ZJF/fsjr6IkanlW6H7viq2CXNWoT7gVH
 yu37g/W9dtZIeYs7/nocPAUoWIF7dJSp4VECtUJAa2gF8GIXH03ek675SJQ10vSwCydWZ0swmWV
 YPRJ0tN/qTPmJ3uaqtlTSHfGVX6NF6t4TPbqlSJW3xDjSxEYBaluZbFjQjqsozRoN/GY3L4M5rq
 j8PRv1tcg0nJpk4eL/9o9c1oW3ysFRxnmLY20lir0KhycoG8b30pi2hS3FXrSg35iTjcvF5frFU
 Pi+wJM0W7vVroQuYtKmYsC4jF3
X-Received: by 2002:a05:7022:5f1c:b0:12d:ed19:e6a2 with SMTP id
 a92af1059eb24-12ded19e754mr56835c88.36.1777508686896; 
 Wed, 29 Apr 2026 17:24:46 -0700 (PDT)
X-Received: by 2002:a05:7022:5f1c:b0:12d:ed19:e6a2 with SMTP id
 a92af1059eb24-12ded19e754mr56823c88.36.1777508686300; 
 Wed, 29 Apr 2026 17:24:46 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de3261533sm5180046c88.9.2026.04.29.17.24.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 17:24:45 -0700 (PDT)
Message-ID: <ef8e4474-7237-4857-b425-902cb61573cd@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 17:24:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/47] target/arm: Implement FEAT_FP8
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org
References: <20260430002046.59739-1-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=arGCzyZV c=1 sm=1 tr=0 ts=69f2a14f cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=mKqt3sDg1JzNYCk9nD0A:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDAwMiBTYWx0ZWRfX/89X00EmZVOr
 /+IT+a0b+gOfDEnHWvdL0d/TfTmRdjUzyKSkhwkid1P2baqD1Qep6THgb2J0smCMVC7BZoBdBID
 ulbKV9q1bv9oFBOgF/3rkWH85MunE8X6aGXfb2cJDf+oa1DJPUV8p5LbJvupGElBQBwmsvQETB+
 l1/4cX8//SSuwEm6pDvdHWD3dtx5rqnoxiXpC/90zQ1mWqDhdN1TTJxMPm+LiEl9WycGOqQsQ/l
 oGKnG47g2SKT/Bc/gvvUNzf811MTgNtAOAVBgfR2RnK5IMeESbmHMrOBN5pfpON93uczSgTOLD3
 dwenTy86iviYFqeeuxIFCQg1VqMfwaW6DBAZugSoNDXexA3NjZlXUQ60CEpjjAa9RmIDZhs2CiB
 m+p7eQ/8BZN8Gm1/EPKXdGvwyWAoE2yUXMAbgWxKcgdHUk0eXCShVhiIIb/Mr55r10RNk2CFw/M
 CnH8pMVYc9hyNhcc6KQ==
X-Proofpoint-GUID: E_3M8IQ9cn3XGrkRnF-pop_QX1aXO8kU
X-Proofpoint-ORIG-GUID: E_3M8IQ9cn3XGrkRnF-pop_QX1aXO8kU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300002
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 4/29/2026 5:19 PM, Richard Henderson wrote:
> Based-on: 20260430000524.56046-1-richard.henderson@linaro.org
> ("[PATCH v2 00/40] fpu: Export some internals for targets")
> 
> v2: https://lore.kernel.org/qemu-devel/20260424043014.46305-1-richard.henderson@linaro.org/
> 
> Changes for v3:
>   - Rebase on softfloat-parts.h, which allows us to drop some
>     local changes to fpu/.
>   - Enable ID_AA64FPFR0.F8{E5M2,E4M3}.
>   - Implement FEAT_SME_LUTv2.
>   - Implement FEAT_FP8FMA, FEAT_SSVE_FP8FMA.
> 
> I still haven't addressed the required firmware update for
> 
>   tests/functional/aarch64/test_rme_virt.py
>   tests/functional/aarch64/test_rme_sbsaref.py
>

Feel free to send me the needed TF-A (and TF-RMM if needed) patches, and
I'll apply this, and send you update url for assets.

Regards,
Pierrick

