Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6091EC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 04:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0tuC-0000Rz-0T; Mon, 31 Aug 2026 00:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0tu1-0000Nt-4c
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 00:45:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0ttz-0005M2-Bb
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 00:45:48 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V1bdLV1582933
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 04:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fY+RQxWD/IDVoVUNeJEQwHM3Y02AvqOUqCQ76Cr/RMs=; b=nWXrOMww8zg0jdId
 rxU+5mOsYQeB4yPEhLyzqJrnM2rom5pBRntjErRCPkmuMG4AB514G69ZesannrAJ
 6Rn3fDYAjSW3jx+dFLSk7t19L1qAQ8HckBKvlmqlrvbFgWlXz9EROoutDoR9Hsgq
 uPBtHPcXl3b6iVbfNX4A14The8z6TDfFHbhp/sBolyu1amfJ8vqd/boLVaITeIBq
 qcKmUM7xvHV16cXV3GXKGLJh3ZvkraJx3Kj70rpPhfV5lgbI9wvgsnzGXaTRvu/4
 22zeg3eNmRMCLXQqZrYMhv/AIUIi/YZkampZB3XyK0/J344hzRJ6Le0LLjXl419H
 MyXtbg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqt6mgtj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 04:45:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e4f946461so505504485a.2
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 21:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788151544; x=1788756344; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fY+RQxWD/IDVoVUNeJEQwHM3Y02AvqOUqCQ76Cr/RMs=;
 b=ZgS2PgqI59oObqgUkhW4tc363OOfEzwoB8hzJFm9EkIl/gs+Vn5UPO0doV1P8Ry/Vy
 hAe2Gu6thvtAq+IUL0YdsT0tohZ9naKA5/rxrUeMTtkuO9wSTYPT6RcUzz1MPz3bGFIz
 LsxdIEiQxSntyz+evqi9GOXozMi2Bljzsnb6eDS+ck5aO9Uo8KRv1YHe28Mq7f9OrERL
 xdt+8DnsRc7npnC89rs9pfhX7uOMedlLLv5NGYXaNPP/jlf0xbrYI0GjFF5+n6HdQ46B
 XBqZWx7SAWvyqJ+Qd0AIi7Vy3rO+iS3YoQrwqtC/LbVbn9/n0eEedYNZfNvxEOW5hqEh
 pvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788151544; x=1788756344;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fY+RQxWD/IDVoVUNeJEQwHM3Y02AvqOUqCQ76Cr/RMs=;
 b=r2jkFj64dN1TmhTatBKZCCwZOW13rIGbMQ8RuGoGiv8JSqbt19m+VXA+tA/tT7KrQY
 VTzniRLGVNfLlvOEzjT4Qzhhp5ZLalfC/du84McUEnXbokcWfqw0fKzSmKM9r1whXK04
 JoiJYWvKZOUk7LdKvGlFN83DBObTRu0U5lPyamm5AF/yIcl78OYcCpIWYAHjqh9qlodJ
 TMU2526AANloz75qph4pcBUsx6Mmm/P/LJmpWbiJFjByGyHLYoYlshh1IqddOBySU1Vv
 IKPvCzZiutdTcplSJnaQOmzVn/AX7DIILa/3JDndDe4oQMMYLOT+2O+g0RMt8y/tcXvI
 jGjg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrU9Z/apdfUHLOMBOD2WH3PmriPBzFin61zVA5B3EKxNMSD5S/eg33cSP4TyEU6Muz/hjnXxNdo52uh@nongnu.org
X-Gm-Message-State: AFuF++mX6thzh4KFd9g2W7pMacQI1lzWvarebd6CvE0RF1dvloFrqR0r
 vpFxLHACzjahxEbbowQpE20ZYr5JdA9q6iUjmjEUEaIWqt3ufQqQSyiMBFqXSeq4hDX5bOkqkvi
 GJZ3WATm645X1Ud3ofnevxh0FCXmVBrDUNy1g/qVhRkKZffKS6Otyr1y1Hw==
X-Gm-Gg: AR+sD12MKRQTc4jcz4GzIUmwRNdC1nap5P+h/uLNTrm8X6lu0YukAOJFCH3RzRDqFbI
 kUIGlCkO98TKUmNm+qf7PJvpsxQMK/D+ziZWPvaosA8lcQlVTg8NPlGDfQg6xpgCXh0V3+QwRgN
 3CuAIfhyKxNA4qJRbuZYSoz7pkSIU/j0PLj6ZEiAH112rAokrKkxkC/eDmql8k6kgJHCR/rAu0D
 EcK8wCBblACWhfLZX5KT23j+1YcN4DrKMLZ1OHCdtB0KWcmQM0Pd8hIQwYZxRPVerNqPlZzJW2i
 1R4TfyD1MQSQFKt2jN/p1RB/9t4HQi4MbNl6qkvG7blqr6SLLebAkUdn1i152jjET4jjn+27liQ
 xEtiZB+9PVYbfchTtKGJfru3YqT8gRiiXyw==
X-Received: by 2002:a05:620a:440b:b0:939:27b1:66b4 with SMTP id
 af79cd13be357-939427ea3bamr60535885a.6.1788151544582; 
 Sun, 30 Aug 2026 21:45:44 -0700 (PDT)
X-Received: by 2002:a05:620a:440b:b0:939:27b1:66b4 with SMTP id
 af79cd13be357-939427ea3bamr60533785a.6.1788151544156; 
 Sun, 30 Aug 2026 21:45:44 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48436e2af3asm9403422f8f.12.2026.08.30.21.45.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 21:45:43 -0700 (PDT)
Message-ID: <eca22099-1d8d-4cf1-9a85-40240300b4f1@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 06:45:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] target/arm: Move ID_AA64PFR2 feature tests together
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260828222639.1432046-1-richard.henderson@linaro.org>
 <20260828222639.1432046-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828222639.1432046-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: d7vhzH1rec0FoJ9acIxElrfwvAyw2Euv
X-Proofpoint-GUID: d7vhzH1rec0FoJ9acIxElrfwvAyw2Euv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDAzOCBTYWx0ZWRfXx5L5jYmx5hgc
 sjz7Iw9wAT9T9tg06nHEmknr6+apHxP7t9g1WH4nO0X7tgbLrkK7jAALHEWdw+smD1ZJZIUN0zF
 a0LqNlSqR9KmIGRtUwHNFgMsF4oiG7/zLGEE/GRb5jiqLxuDakvE+7V4aG3I+Pj7lACN/1xSgYb
 fBLEW231vyf6we2AMuxa+urwFVfeSTa2biI1y2WGjnmNk07DB5b98jY+7mPqfYeDZeJVPZBWqjs
 4TLHDjowqPYvPSntrUuWSqvm/J8qwlkXltwhns+g+pCz8fmllZM5e3vkvFvisyLH9HGiM+TMksn
 /QY1ZPAQeD8SAA5BcYPhAfrZMqFRm9nGBsAxxpy4b1bDmflOj5OD/Op+ZaOQs97hWPMtbaHQFvu
 vdwferBzaTCmpvVBvjGC0aeWKRZzV0xm7unY5yX9uD8Mo5YwvzK9A7tpuizKId9ZvsJGk/mv78A
 zTpUL1zgX2NNHpNvmAw==
X-Authority-Analysis: v=2.4 cv=S8/pBosP c=1 sm=1 tr=0 ts=6a9506f9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDAzOCBTYWx0ZWRfX72fCtQzOyysg
 C/JNYKC1d820oB9tcG3iTnUbw7UZ8NNd4ib9WOlorobnEDIwo7jRCf1Iz1lpgdgEb3MMlDqzLlt
 NTC2zi4CLKxiYAmck6ZLZjkouFry0Oo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310038
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 29/8/26 00:26, Richard Henderson wrote:
> Currently the MTE feature tests are clustered together,
> but those are spread across two ID registers.  Sort the
> functions by ID reg and bitfield order, like most others.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu-features.h | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

