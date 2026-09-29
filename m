Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BCFCA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWmR-0000qN-AT; Tue, 29 Sep 2026 08:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWmE-0000pW-7e
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:17:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWmC-0002yR-NA
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:17:41 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCE6Et3757512
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2Y0hBR+Lqn5a4iWwY/zG55AFG6reGos3uYivL2CCnro=; b=mFv8usVLnE95xbY8
 JJrN8QO1pYS2/DqsdLIz5m4RZN4rrwLpctTVhvMNscfN0HVl4CsXt0kIRKq/rhSR
 A1UamtqdRsMCYozcW4wu5hpCB8T0XmsGsaeHIgA928wXO6lzPqpdydfq3q6bFHEh
 aVXTyOR87CZcKhtOQA2ALcaZJUc6TXLHiitqxMYEemNNMSiFx3kYROhTi0Cm0Gmj
 x6+gQYeUcpuQyfPbOKNXl0OhrgORkSrkduAA9wKwDwJiAW2XcCkuzRpnXfQUegTh
 1TzfGYh9fm+4fMULF6TvPsdgGs1cblhcPcdsTObfLM+tMk3Z0rKQpZmivM8sUtiC
 njBvqA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0b0v8kkc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:17:38 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-78a6d5cc851so526931137.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790684258; x=1791289058; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2Y0hBR+Lqn5a4iWwY/zG55AFG6reGos3uYivL2CCnro=;
 b=DhxNeAVInOT9VwQt6or0WcB8VOQ8ceniAlZocpYxsSW7M+B/n3fbIQfYbBvbVKi0eS
 W2da3i/uHwvxVNDoF0pNynqKXgcjQUE8Vv4bTtZq+/vbDs0ak8oQ39O93XcbXJUn/JyF
 +WXlatlqarYNfjK7S21+qF9HCGAJyUeYlxjs35V+fr2hjS836eo1A++k28i9FeKjT5Ms
 O7t+znIpW6+BE3YckoC8i/t8WNOE58z22CB61ehIauHQjje/yQYO75KUfKWwuw0+PMaq
 7SEdbdJOiOpSgQpcRM5WvDaDKvQXsNmgqhgotrhSsMKmVQLNJfx4dntAHzjkjHpdV6BJ
 B5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790684258; x=1791289058;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2Y0hBR+Lqn5a4iWwY/zG55AFG6reGos3uYivL2CCnro=;
 b=ood3RAObC459+SzmMPxAqxJEgP1aI6o5OcT4Srr5P5G+KTWCLuOhXzgYJpLUEr7L6k
 M29VPAQxoTc2Cks5pyhoa+N2eDmfYycSxtLstsA0sfYJWnJ98meR8cuWmFgCs/iVflsX
 i5jnLpoSg7oVVbh9BYcgGfGjXeISbr8voOtpc2iV5QKA/3O0ioTCuw+OfhBpVnYDR2Vb
 RinEbWRIxiHW/4XcAP1vdE0kg0eEm8cGBCzCgs79c7LeTJTAFGpM4uEh8U1xvjwsaMcJ
 owfMbWo0qbwa2P1kIJnTbPXMntL29yiwx2pIfKSHPNy/wtlY17EXh6Baxn4sxchDnLRo
 xO4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwT3KxgcdsDkIG/pmFhX/JTL0SMvxtzBwjRYV+1CYwfavqQBwZncxfMPMGsc+WnHDmWYlwhA5M7bo3s@nongnu.org
X-Gm-Message-State: AFq9FYKPqAuZEcZkx0pTLF4L772DX7gaqwUBuFMMlhJ1yilJDB58r+nm
 luwTU1uxzNQJrLdoMXjbbW7LSMm6MNJyvIkmrtsnalZp/Rpq3h4pemuTDkUexpugS5veHvMPOfE
 Vjggc5/Zx+y3pJiKLD97HroHr6FLdFrs3uCg1kcHXSriBEpBBvUTdH4EkgA==
X-Gm-Gg: AYBFou0eNknd1e6zmzTIqXq/NkQ2AIofPneqMoenYjjgNzDJbNzcpWLrs1AsuMlF+UU
 7lveF3cdfXpRyx4fOuC/k/Izd7K2N/YdQpVtff6xAAWYeLCk6Zr6oG0InH/a8kZX6X3NefcZA2P
 UZSGDRJtQh+R/sTmkpZyF7WLx8fuNOVMwn2JBx5yJW5INQGUXBn94QFSPZJpmMXJQfuy+rb5dnk
 jegn0lNrdqw0BoD+XahlxUcGDsZ1js5nBgEMyqRtzwioFspJuR7eTb4AaaM8gYpd0n3tH76nOTx
 aZJ6QQmiIt8xCr30oXBwkB0R6rKGpwPDENgzzI7q9V7PX1zmjc+b6tCS+1umioaHtcJbLHKb4dm
 +97uqJSwIRNwApm57VMN+6F3QK7CSr1BF0A==
X-Received: by 2002:a05:6102:fa0:b0:7b3:3b4e:f0 with SMTP id
 ada2fe7eead31-7b33b4e2a24mr2502332137.4.1790684257592; 
 Tue, 29 Sep 2026 05:17:37 -0700 (PDT)
X-Received: by 2002:a05:6102:fa0:b0:7b3:3b4e:f0 with SMTP id
 ada2fe7eead31-7b33b4e2a24mr2502322137.4.1790684257014; 
 Tue, 29 Sep 2026 05:17:37 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af5078a0asm4070937f8f.23.2026.09.29.05.17.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:17:36 -0700 (PDT)
Message-ID: <5df641c3-2d7e-482a-9243-6169945e1a84@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:17:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/42] hw/arm/fsl-imx25: Derive from TYPE_SYS_BUS_DEVICE
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
References: <20260921214710.29422-1-shentey@gmail.com>
 <20260921214710.29422-12-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260921214710.29422-12-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: jonDrpbJMj25idesD3HGYASY5nd_FWSG
X-Proofpoint-GUID: jonDrpbJMj25idesD3HGYASY5nd_FWSG
X-Authority-Analysis: v=2.4 cv=Z+55j3RA c=1 sm=1 tr=0 ts=6abbac62 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=CMsNXiuhlSFg7qIHwAwA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX2jymMvUGlmA4
 Pd3goml3B/0BZa1DOw9PjCPFrpD8Lz4lKSseYOWe3V5llyPWMt5DH1+BMLmyjMBLeggTtFdpaTK
 ZC54WoeCJXzk/lTzOkbJ3FBvZTpVeNV+ihUDdP1AeGDe270VlpLplcasWfDlBITUxu75Nns19Yz
 QfM6gDYhQrjnCX54SUXsqil0Ptc1+cpQnwgltN/xiEmtSDnKD+I3qFvK1b9TcFZsYssqv8vNf75
 TGL4QGrD7ZYIDrBY/Lz8HeJR6D20EtQjXkfbk2Jl3r8AnpB6j6wtTVQDN4nFp6N3KbdMwer+Kik
 kMxHZDAOQLSok1TVY+rEbIte/mBQmm2SM4Bv0XDTLoOw86vCVIIoTt0XwjucrDQ5WqB/Z7Hjlfu
 6WR6KgCzbyMoNmRB74s/7Irs2hMP0mMSu/CC67mGgZAgurtcjFoTZjIbc1ilRfNhc6OQ5JLiTZV
 +wmQ8ZpTZx/lX1sGLBg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX21hAa1gQX1VF
 QMGottvmp5gs7M/67q3kjtzhiyHhLoH3FaV3O5yzQLxyzZJ5hjBPxrovMf1lPZ94RX/NW4p21Kx
 9DOgiCyuYL8TzNIpLacNCBU6mlJqbEo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290048
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

On 21/9/26 23:46, Bernhard Beschow wrote:
> Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be reset upon
> machine reset.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/arm/fsl-imx25.h | 5 ++---
>   hw/arm/fsl-imx25.c         | 7 +------
>   hw/arm/imx25_pdk.c         | 2 +-
>   3 files changed, 4 insertions(+), 10 deletions(-)


> diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
> index 7f65f4ca4b..efb22359c5 100644
> --- a/hw/arm/fsl-imx25.c
> +++ b/hw/arm/fsl-imx25.c
> @@ -317,16 +317,11 @@ static void fsl_imx25_class_init(ObjectClass *oc, const void *data)
>       device_class_set_props(dc, fsl_imx25_properties);
>       dc->realize = fsl_imx25_realize;
>       dc->desc = "i.MX25 SOC";
> -    /*
> -     * Reason: uses serial_hds in realize and the imx25 board does not
> -     * support multiple CPUs
> -     */
> -    dc->user_creatable = false;

Distinct logical change? Group in the same patch, same for
sysbus conversion?

>   }

