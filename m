Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6847CC55171
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 14:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqX0C-0000cn-1R; Sun, 02 Aug 2026 10:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqX04-0000a2-F2
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:17:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqX03-0006LK-78
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:17:12 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672B8oqP1795705
 for <qemu-devel@nongnu.org>; Sun, 2 Aug 2026 14:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s+qtO/F8f+qjdSiFJDRe2PJpgtHHmBWm4QHen/FW32M=; b=RXicdJQl7vetjt8L
 ncCmk0VqPOqG0LFTHFw1TktQ9zH4vU3IaFb4b5zTHyoI0CHWprftOktbEgOtoagp
 jgDET4KMMF39a+NtSMU+uM8pDYBX/z9c0Nr41ZNVYW7Iwkhc8sczI7ii+eppXO+M
 VjZxVRJDe5esNLr0wW1+FazeeFrQE0+eJOxDRHwFzVS12ri0Ln+ZLNSZ2DoajSv3
 4OqA8Gq7pT+7ZuJGWpQOb8XI3A64CFeBtPmXfxiNo57X31CvZUOAXzcQgpVbX/iV
 DALxL6NWYFU1c3G57PhbBI0JDSUn1ebGqmVgj9AYqoEJc/L4k0x1GqV6WcWxTPCK
 Nabn6w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8tx30sn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 14:17:10 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1e6f602cso40158871cf.3
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 07:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785680230; x=1786285030; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=s+qtO/F8f+qjdSiFJDRe2PJpgtHHmBWm4QHen/FW32M=;
 b=Qlbdk97ybAE+uUeBz+830PvqbdU3sKN5pdHX6vvFLN8Zc7luHpkEeg/GaccQQNB8hO
 tlNOg1sf/Y65wOWKz1hrYd67bXMgpxzopsB21rjOKrhaDd/UFI3ndU8jvdXDY1/eiWlj
 4HnMqI6vdU6CKYzdl+CDmhkk4IP5wH8RHPjRmK/fCiBfDHryHezaU3N4kFIxn+l5JMq/
 Dfzi6kwLpmcltxnU3Q4vfGq4AzMMVZN9CapHRTjwRmPmOWF9Jibg7FZe/Ma1s9fZYQBJ
 7WVjZoMz5ZRrlYsqfPE98pxgX43WF78YRXMDmHLhFVA2P+bIobembpnZdceSCDElj6HL
 l/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785680230; x=1786285030;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s+qtO/F8f+qjdSiFJDRe2PJpgtHHmBWm4QHen/FW32M=;
 b=WxCZML93UfUOYwKfSA4WcGlkPRxhB/L1lipG30wKcKriSiKPXAGjVfI10evYHClAnO
 MflDf/qjfWyF35EeRKziTWcKcdvcdwC5dUHYDACCl+X3v0QUN11NPAAS2i8ZEO3LwUrU
 XCOm1Elc7u9KWFHlVOk97/mkho3k6M6bB/oYh9oBoRuZI5pc1TQyMgOAuuOwVz6LDvnv
 Cu2UiskrOdTwgnHJubNE7bqxELZSCOPu9DUuIoImK1tuZFNfqa3yL9xzf8nJZwMR1Ikv
 rtF3FhvHdtHlHCKZf3Kt8jJ7+8impi7X/2d++TnGroFjeuUK7k0XjbCdTRm1S01CC1sg
 /XXg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpR5siLrr3cbnygkRum6dX5FSHZQCfivvYWPH7/Qgg/0PTceDBKgBPdZU192KLi6+BIpaqj59Iar3LB@nongnu.org
X-Gm-Message-State: AOJu0YwNqeFQtkmYih+kCzVTFNBrbZ9Igvq8PnlVDXEYCrRxBIpLJV1B
 p+UvJ2+/TOy+DKBTiTzKKNbd2IBKTBD7/L3WlkoFqisdUaeESCHp/7mDSHcIebOOMfQWpb3MIu/
 kaRGAXZDgEbP83Ugc2Qj9uER9YIwGn4eKdBQN75ASe7af9hWacaB8n/4ptxWNzGHAvg==
X-Gm-Gg: AR+sD13ABqHCexd12RzteE19LpVApGhk7rp/QnJpgjW72pwuhF1ZBrHRso7K7KqAHg3
 60e8y0qmliztdtZOClYKiVIzKf7qnL5j8tsMt5eACOGgyMBecR2yL8xLum3ukDpGYIEKSe+vuLc
 4BO9UEablrMvISJH6Oce8o6Mt8gwuicJ7MMd5g56sq/jt9WZHyoyMqBri5hibgbn1zCh1ShGF21
 5+9iFhys99wfyC0USEEgcYfVWfEhRBDaHyuvu5YXtRVsLBzDzBVwDMiojgwkS6diGHFqv/yy6OR
 sXT8yeL+11VfvFnchmVh/apdQEsbrNoGLShBbBMY7xvk0U0HxwuTPH9nrz8Byqk9RI64/FyQ9t/
 junIlRWKYUN322tzNzzWUO9gCbxKfzfafPqtapju+5QUTpUsU2iw=
X-Received: by 2002:a05:622a:588e:b0:517:5bc1:e1f5 with SMTP id
 d75a77b69052e-52b565216cbmr136890351cf.0.1785680229835; 
 Sun, 02 Aug 2026 07:17:09 -0700 (PDT)
X-Received: by 2002:a05:622a:588e:b0:517:5bc1:e1f5 with SMTP id
 d75a77b69052e-52b565216cbmr136889741cf.0.1785680229460; 
 Sun, 02 Aug 2026 07:17:09 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd45895b6sm24544884f8f.26.2026.08.02.07.17.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Aug 2026 07:17:08 -0700 (PDT)
Message-ID: <93c6725a-c8ac-4ace-a5bc-a2f24467333e@oss.qualcomm.com>
Date: Sun, 2 Aug 2026 16:17:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] target/s390x: Convert op_ld16u to op_ld
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
References: <20260731185628.23161-1-richard.henderson@linaro.org>
 <20260731185628.23161-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260731185628.23161-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDEyNiBTYWx0ZWRfX951VPU65KdBt
 dXh2FbLITxBzIeTbSqFUuCj6Y/5evhOhZ/SCMloQZvFirx3l5ug3ExjRv6BOrTekri7tysxgaeE
 ZFzf2KNcAgDa1GU4Ka4EM5ObdrQG1coFoQQERdajhNYp9rhifU49fcy55BC4IpOzMhoNA5MGB5G
 6bry6k3lEBv3/RxH3KwzzH3AW5MpyAPErRZ5Yvb0xY7rdIv9zCFcu7l9Xz0fkzFqWMUwOEjwH/7
 BZxznzPi003PXVQ/WmT5By5evw8XQoiroJ2PwC1pCIRIiNC++HmYC/6wFswwPzWOMM2/Xc7sepI
 QnNqJkLsYli4dwfO58o6wcUNhl/hddN1LUvkQqJW5lJSsROaDN6V0HRdUw3ntBAAMFI76/D5KMP
 Ep6E0yjN1FmzrFtjEow4MYpe87vmNsPOT/YcQnEyFUjPsS5IyrQ4+3F0u/r6R+M3wOiw2MEwxrv
 byQ8UNmOx1JnDwrvjsA==
X-Proofpoint-GUID: kCw5NaTKwWqZn22L0pfe86u9LOX9BJHO
X-Authority-Analysis: v=2.4 cv=T9C8ifKQ c=1 sm=1 tr=0 ts=6a6f5166 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDEyNiBTYWx0ZWRfX9Tod7mHlv/0H
 FGvrHIYuZjyScGP9xB7hA1OC4SmEr1kxMjsrYMqBEiBAlqsJ/meqtuA89EDJt+hr0l0EZZuQtmq
 8ZU1xhPyerEs8ODmB+OgMNJP3IntvZU=
X-Proofpoint-ORIG-GUID: kCw5NaTKwWqZn22L0pfe86u9LOX9BJHO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608020126
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

On 31/7/26 20:56, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c     |  6 ------
>   target/s390x/tcg/insn-data.h.inc | 10 +++++-----
>   2 files changed, 5 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

