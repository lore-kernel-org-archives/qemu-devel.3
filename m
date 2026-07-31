Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B690C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpgPv-0003rD-E9; Fri, 31 Jul 2026 02:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpgPu-0003ql-7o
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 02:08:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpgPs-0004Hz-RZ
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 02:08:22 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V67CcR144290
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 06:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6mPEOvygjFhN+4bYhTKrNFRknYSGv09479CS+UvaIFg=; b=fRGGtrrjfRGU88eZ
 i1xg/WZjGJgMh5yoVXd1XF9guoI2qQqwjFR26a1eFu16cr/XqBuUPTsQtDtP1BWb
 w6WnsKttpBr/fAvMhpEAlKZFC//JR9DbPyeHn5SXwmcCGo9fn5Kpk/Xkuv7Gd8K7
 g5xW9g/h/oa8R/VII1T5WXJePeEHiY2HVP1E4lK2TUXegip9K54vC2I1mWyvp5Px
 4nVr6ll2yDsIsYnFjvNOg263Pu6XuzFU4yHhAUxVIVTZ5NLwh4ZXdZw9Zp3LSiDQ
 T/aK2HzhebV+UwfO754p3/t00QmWmaPisvwyFAIHsG7aHHJQK9N3jWnSusHcB2O1
 L0TqRA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frp5k003y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 06:08:19 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51a8b0a08d2so4800301cf.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 23:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785478088; x=1786082888; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6mPEOvygjFhN+4bYhTKrNFRknYSGv09479CS+UvaIFg=;
 b=g8ep8BNFmkVnJyeEcWn9qrGRMNy0TsKS9aZAt8KNgJEDfHvRhcU7z5EopC1a67fTb6
 AXWmnhRERXbjE2cVD+NFjWB15/MFkBybQhXm3IN7pb8RiK/w0HmGevFsqfraUXkPCbkK
 DWxRiueI0ZJ9HENS1DiVD/+9LLdcRubUcrJ5vcDfT59iZwbV3fLZrAxsErlMepoS4RT2
 bBbP/XgP/nZAqrzif6FyfzdN/JiaNyT8VfSDRpVCnk9BB7do7eEjVq+uWfGoIp1Bc3ZU
 mQbnJUiRHYohbQUm6MuYjp8tE5fsMM2acJaaMOkwJf04eg+FXbJ5pjB2MpfPOD76iEOM
 iVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785478088; x=1786082888;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6mPEOvygjFhN+4bYhTKrNFRknYSGv09479CS+UvaIFg=;
 b=blcLNKsm2FCbWAHsBte5g0HuUJ5eEMqsHXOUV9Tfi+q6cxUzoz2LuH9H9ZDGRYrdWD
 GAQFJFveJLJL49fJzTOcZydowb/Ek7lNKj60oh9u90ISN2wyyG4nPjQQ89ykmyO6tgit
 3pVXSrqDuIAaicvDOWDgH6NISIo0pflimiPMEJ0Z3OvDW/emP5IqNE87pX5Pz9t02Zld
 iu34g+x7AavJUTwtbCQNvG+Z1OC1SQWy9A9905752CwqjzFQbLcc02APykt7jLgXyXNs
 6kPbcZQiERXh1NSLMrICqn5onHKcyr/W2i8ZKZxE35Zxtuc+Vbor5pw51hCEbWZW3ogE
 DaTg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpfLOo/fw36F9EITx8gvCkkKb4h59Akte4rurY77WV4vSeSQnPeiS7yVyBY2EFpayMv5QSxvr/g22cd@nongnu.org
X-Gm-Message-State: AOJu0Yz1d/qX9MWn3nYiLV4r5Yvg/6nd7Yg89AEzLfRPT+whLFienxZA
 akMewEWaMN5M6aXHDoIt9KaygUHvResoMxEGERFO7Omyry6PJe1QndgenpXmMV5oJNNMKcNwisi
 e6S3xCkE3Oc96y/WbChsUXhS6+ARfhmEOtDhTq9zPsGCi56lIsZvAbf5DLQ==
X-Gm-Gg: AR+sD11Wl97ZDWKgS3TLNeUWNijZfLgmChCsDD7EIv9eM2j1aRhzIH3ELJ/62/uKtZ4
 dW6FcoYzUhPTuUfC3iNLpfwX2yIvkw1NgvjPYdPZAGpRQXaJfwsC376mT5PPWAVoZ10yCKBN3FB
 AB1x1yIHH+kgueQRoT04YD9/Yh7TVhpHKk8+UULgngKojyJK1BzJ0e9ZKBFRJ4OkrJ+RxHW5C/F
 syLt203hyDsq6U2QNnwr6GeSjzaVZa49LBxQV5AD0lFlFcRfIUWrXAoUPLExObdBwwYkL5RSeMt
 g81VLBtADQ7ZLgojJPUeKmgcgrxDewOrimUg9EfESxKkSFGItxgz/yzGpxS4rWD82GByZVuq9jA
 OE4vJoLpqeEgEEPvMFsG5OnrF9Di2e6UDeUFtQJFLSNgk8bjh4z8=
X-Received: by 2002:a05:622a:1f95:b0:51c:1005:d096 with SMTP id
 d75a77b69052e-52b4af4fbb4mr8884541cf.24.1785478087700; 
 Thu, 30 Jul 2026 23:08:07 -0700 (PDT)
X-Received: by 2002:a05:622a:1f95:b0:51c:1005:d096 with SMTP id
 d75a77b69052e-52b4af4fbb4mr8884341cf.24.1785478087368; 
 Thu, 30 Jul 2026 23:08:07 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e2484sm921319f8f.11.2026.07.30.23.08.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 23:08:06 -0700 (PDT)
Message-ID: <9ed4f5ac-c51c-4fe6-8517-488913ecf50c@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 08:08:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] tcg: Add tcg_gen_revbit{32,64}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, qemu-arm@nongnu.org, git@xen0n.name, 17746591750@163.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, philmd@mailo.com
References: <20260731000503.170446-1-richard.henderson@linaro.org>
 <20260731000503.170446-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260731000503.170446-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=L7stheT8 c=1 sm=1 tr=0 ts=6a6c3bd3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: _7pv0v-WLB5Rz-delc4eiaJ5O0l7cGHz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA0MCBTYWx0ZWRfXxHwnFGPnwWV+
 XA6a6c72KJwMF/7OXuh9S9r/hC9QggQL8yOoeXa4o1OaBaxeFs46iwF3vLgRxkqHcnqz0c6YeCf
 RGKRQPp/kdrFfiExZsh5a+h/HHNdxlo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA0MCBTYWx0ZWRfX1I/A8YnQERdx
 m2dhbe6iGIC3Yayz2qcKuN1D2MF1/DIZUJfwqy8KJrWQvQrw3YMeUXBzOFp1BX2QEDcpxfPdI0a
 paAPdSsfpm8sRjHAJEm30936ym2/0MneCnwQ8KQc2PuxcZUJY9/iFKUFEGBDxQqpu/q5zx289Vv
 EEVKJhiOi6CKx4pDnSqO6q13MI9OSTQiLtDPC7EA1aiheX1APqMBzHvNAtwlieroAWIpD+s3H8F
 BmX2DPIchXpl6qALvTVK1X91r2UUdSNPJT5RGgJLOlyNsQ434x6Yrr9WRoeyeXi1WKT22kWtV7l
 /kRlJfNWel4UHLjzzq447vrqHdHjYVNKnE2bKp5oeMDlu4I0gvWZPymvcSHReKEHHCjC76DvRTH
 vp4NB7pEebweJag2g//7NXalR18FxQ8nCVJXWe9FjEfAEU9MsMn/x9Fiumfu7rcvyJW9MhdUhbq
 EmET1yKYcFIXwEdn3IQ==
X-Proofpoint-ORIG-GUID: _7pv0v-WLB5Rz-delc4eiaJ5O0l7cGHz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310040
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

On 31/7/26 02:04, Richard Henderson wrote:
> Add generic expanders for reversing bits within a word.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h |  3 ++
>   include/tcg/tcg-op.h        |  5 ++++
>   tcg/tcg-op.c                | 59 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 67 insertions(+)

Missing listing in docs/devel/tcg-ops.rst, otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


