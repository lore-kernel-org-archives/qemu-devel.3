Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043B3CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xERZg-0000L2-PH; Wed, 07 Oct 2026 09:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xERZW-0000Ki-1i
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:20:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xERZT-0001C4-Ey
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:20:37 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697DJqnA4057849
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 13:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3bAUurAMjdd9838yiMUYqDq5XOtd1Xca72ydMvrK1fc=; b=GCnxw9codYajiqoS
 2dsD1I+cI9mvuZm61QtuCldono/qx9iFA9JaN4o8GhS163AtE2ksCDPqRe+blcU9
 OLuuyELRJRdwt7/dbpt6ti9h+Pk0So/rzOAfW6Cuy2maXCSv0UKUolJxkr1sEaW+
 3rDzMqZqDVvx2Rw+RivocgPk1lXEyW5QA+vh2Y3WA1Hb1POQzZwDDctZOMMv27NQ
 IeXAN3dJa7fBM/50g6VZdIyT4eRG19atF3hEnC90CTEwm69tIm8bYHhDdHKHOxik
 GNGO6WHMQ5rtErmi/IyQD2q6p5BVR5y6czJJQOol2plM+mbesjspdV3WvE1fYDYP
 ocbUDg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5pv7004a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 13:20:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93e46c120dfso432079485a.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 06:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791379232; x=1791984032; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3bAUurAMjdd9838yiMUYqDq5XOtd1Xca72ydMvrK1fc=;
 b=JYKEB2stc9CKAjv/EdYUqcRWm8gQbik388o/6jPOouCAbmKCRECl+WGtkC9QE5hnQ8
 8sd/xQ21Xrt72WXmngCVpozGxy+yggepEYzoOJCdCdCKi9LzsmeV6NYJHP4YdPDNZ58s
 Sv2ELFR40Ze2ytkN5X6621MudJmXXqJUjI16+GftNZogbuPBHpOAEENUCAXuoRCW0uBX
 5gzHpFbtMBwEAW22CbcYOxlrWWdQjRfYL9Htpi9cp7nrKUn1GBlOhqOEqEnGfKEp5zQC
 H5PnG7cxS7DruWhocNIO7yIUVBTQ+NiUGsRzC6pbhUhGXrquk5RCuVt5Eeg+HEQeD6rj
 0chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791379232; x=1791984032;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3bAUurAMjdd9838yiMUYqDq5XOtd1Xca72ydMvrK1fc=;
 b=ExcUfLUtaU8iTbIB9DrGEaqE7t4u2DKmQzaqGThfmRQyrkmawOFNE9xjHGmgvti6mW
 qUiodSx9bbymMnkVVqIeFeDmzt83V/A5TpBEkTxnDYifWEUvqSaC+ockSZJhYLosDrKn
 LBvr4UyQSucnlVe419ZeIM8VhHJp8OqyvVHJRKSQ4LLKoVadTZSMqdlSKEXWGGTEgzVN
 08mP9oXkdWe9U2SUIjIVJnmrEHOPkiBjp3rx6kHKBfEur3wv1uXN9oDyenGI04IovANW
 f1MLnnrkt53pkjetc05XQmZekzT7onbsEMoOm9du1QfYJQXKRJYbZn0XVOj3EenGCpcP
 HESg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnzjrN4uV98LgGYhpgXkHRzIkQDfe88+n0AzimgIO2Cg9Dh2/Hmo5xdFKekivZwEsJx5x01c5QMAvX@nongnu.org
X-Gm-Message-State: AFuF++nqWdE3QWNzqNMxQcqZv6urNBku75UDXxXb90lMnkbBYivKnfW6
 RJP20vmsKAWuCnmCCjQxn9jPwuGGQ6UFLmiMwFhqi8zNMtavw5H/HLEJPaPWW/J0Fj59VJw2Vu8
 bd6s0Qgyf/m2xvWqCCF7eKLTSLnLcY58jJuyicsfn/kSZBV1/Po2bcBw+EA==
X-Gm-Gg: AYBFou3A6SOJVZX3nCug9cFpwkmwEOXmy6BJWvpgdUDO+Ji5g1fjv/Vy2fURpkaTRyy
 i39gfm0XtB8sdIgD4tJm0D8WfEtuyyjoYFyJ953zh8Yc+LFE+46yrazcSvyAhmOaazp56lt4sPu
 WUSv4YKt3rEHAbbL9imNohT69LY2q0ez7kYbqQe7m1ZVfTcKykSKx5UQSP+HtNhTVB/GfBwhdDW
 8idpj5i4qPJoGQm5rSfQSQck4SwEGi4eXUYnj1sm5vRN87zbQjiz5+fOFKv3CvmZ0TBLg94MFfu
 eXohr/XebfgSoCIFg1mLVvDS7dqqHNu2sqah/Qlsy1iOJZnCzCeXOLgwJFvdAKQAZuJ+PK6iBUj
 cSq2esMgSkmCMewpWTMAaKv+BpmYSl2r3jw==
X-Received: by 2002:a05:620a:27cd:b0:93d:78e0:30b2 with SMTP id
 af79cd13be357-93e9b721dd7mr451684085a.29.1791379231395; 
 Wed, 07 Oct 2026 06:20:31 -0700 (PDT)
X-Received: by 2002:a05:620a:27cd:b0:93d:78e0:30b2 with SMTP id
 af79cd13be357-93e9b721dd7mr451677985a.29.1791379230783; 
 Wed, 07 Oct 2026 06:20:30 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17a0fc2e4sm149808745e9.3.2026.10.07.06.20.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 06:20:30 -0700 (PDT)
Message-ID: <79f974bd-dcda-42cf-be57-6360f796ab0d@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 15:20:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] target/arm: GICv5 cpuif: Use arm_cpu_set_irq() to
 set IRQ/FIQ status
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260914160020.327787-1-peter.maydell@linaro.org>
 <20260914160020.327787-7-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260914160020.327787-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1MiBTYWx0ZWRfX+t/ONz1ZggP7
 dBfXNw60P5LU9XyHy6Tig5lXE9Smbs7K/p7Wi4ZdK4h1ybJzRsLwy0lewmqQbzUuNoMzKm8mPuf
 41ahW+20qe1s4ba7Ei+lKJ0AFqRtIjI=
X-Authority-Analysis: v=2.4 cv=J4I/fwnS c=1 sm=1 tr=0 ts=6ac64720 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=s5kuZBEdcB38ouE1BJ8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: q4dHvs8Sny_mYgZyjUhNRfS69bKHj1At
X-Proofpoint-GUID: q4dHvs8Sny_mYgZyjUhNRfS69bKHj1At
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1MiBTYWx0ZWRfX39eNbOUlzdoY
 aBBwyqDDkVuTa/JUO5kfxD88j1ArfQz6GWpboNkqTkN/eIxkdDBj6+Yg4IfqpYAinY0b1XJyLUr
 k+LuJZEB80NW0R4xlT4FR1AaEFYWyir1/wdNnZvqOMw/K3QLpL3YB2ZZwo9ASfUYBP4MiJEk54O
 GHZLhOkMZdsxBhHDpqUK+WUXZr8dQ62DkI/ihZBrbFxMMbAxLm25tKrgZkAGiQWrU26eLsJudZl
 VB8C1B7/lkThLFGYkwlWDOOkMszr2U91zAz9wk+RkwIBrRgM1WIRCN68Vh1UJu+oyJgZ5j4BJ0Q
 xILWP7W3VUdlrLGvN65tKMx7juu9ckWcyghG0KLibbRonKl1Nl7QNzy6gc+JEP5Ca3R6oMkKP2b
 lxpBSNaBjjpP+98lVudcpnepP0LIp0anSvNVu43rEKhg4tdTqLb1aCpbpkbrO9daWPx5PqKSJhe
 ObxjlEgKzNO1kkrsJLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070052
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

On 14/9/26 18:00, Peter Maydell wrote:
> Currently the GICv5 cpu interface directly calls cpu_interrupt() and
> cpu_reset_interrupt() to raise and lower IRQ and FIQ.  This is almost
> but not exactly what we do for GICv2/GICv3 external GPIO IRQ/FIQ line
> changes.  Those are handled by arm_cpu_set_irq(), and as well as
> calling cpu_interrupt() or cpu_reset_interrupt() they also update
> env->irq_line_state.
> 
> For IRQ and FIQ it doesn't matter whether we set and clear the bits
> in irq_line_state, because nothing looks at them.  But for VIRQ and
> VFIQ it will matter, because VIRQ and VFIQ are the logical OR of the
> line state and some bits in HCR_EL2.  We're going to need to call
> arm_cpu_set_irq() for VIRQ and VFIQ; for consistency, handle IRQ and
> FIQ that way too.
> 
> Since arm_cpu_set_irq() is now a function called from other parts of
> the CPU code, we make its first argument a properly typed one, with a
> wrapper taking void* for when we need to use it as a
> qemu_irq_handler.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu.c             | 14 +++++++++++---
>   target/arm/internals.h       | 14 ++++++++++++++
>   target/arm/tcg/gicv5-cpuif.c | 35 ++++-------------------------------
>   3 files changed, 29 insertions(+), 34 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

