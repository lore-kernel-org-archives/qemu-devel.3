Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7056C4452B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wllgC-0008Tn-Hy; Mon, 20 Jul 2026 06:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wllgB-0008T1-Am
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:56:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wllg9-0002Bj-Ez
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:56:59 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K9veOH2023739
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 10:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nDrEoawgct2wult/B9vVFm6sozr36X4stSAAekays60=; b=mbBIc32fZKCJcfpz
 7M7aU/rBkQ0OYd9F7j+mMgf3Fw0Gtz1jHzVvsd3CGOtFvYcKVgQsLc0WO8s6JFHZ
 QhBSe4s5MGJW3jarp+EG5+WFnRz2n1shjAp2vYHU+Vio2x9RNFMVToMJ+rCUO7Yw
 QbpEXPw0igJj8CeJk5qyQKLFXLiSO+9VvHDVAvQXW3Zq4ZEMIJMj1VpKArZR1YAS
 0taO0u8qMn+LekyeJ4h8xkpnKE9Xo4zfUN8GHA7Y2zkEnKcRBAX1R5Hdrzdv8aaf
 VHYUaDT0VM28C6WWYIbvS97LHHvBm3akLO6gCqLoNyV/XuYXRQ0+9WKJslxfnz94
 6BRJLg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgs00dj7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 10:56:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51a8c689b5fso191924771cf.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 03:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784545014; x=1785149814; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nDrEoawgct2wult/B9vVFm6sozr36X4stSAAekays60=;
 b=EUhcMUmwYh9cx1tlhjrE5ibCukivE2xKfEqtqsRsgkhTIt8gfEp4UHwtG/nHd1dmJa
 X5rqsiScsGXnmE/GDvA3L6eRK25LISStgJg9fwGeenfN4Z2EUFAlVC7Y4iGtEP+sgxoz
 eFQhW4r36C+RuJr6mRfCML6VJQOTRH/6kxXJv3gjGvlRNHxV5tQJa1Kw+TkPFFUNnTe6
 qRgLVhTS6IeiXtkIV2yu+ZkK4mktUpYLj0Qa/SG6BVJaXm31pi4n3bx4zcZuxNJOwMxp
 4nwgBBwtIjfVASNT+9wRe3S8vGfRbjBujnATGvvskrPV9DO8fiJyPatRVVtejWwCUe/r
 TF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784545014; x=1785149814;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nDrEoawgct2wult/B9vVFm6sozr36X4stSAAekays60=;
 b=bB1eq/Zg7mx8bYrNz5DmGEQUjwNxjW1dm+xEzbbc/KIR56lpOKSKo9oydDmfyFqM75
 xJqFw9eg1T5KeXsv25TxiJLC68CjQz+8POiMRYUcrOi0WKMp26gnjFB7uEj155gnAamA
 +zTcuo1yQZ155GeR18XguI6mrUOHDz5rXFFKFocjtPQaRBLdiS8PV/O1ys1ZYZaZ+Hxd
 IyPpQloZa8Pg72tN/srWrheuJbt+mF99u5ZOG5t+ZNyPxwbXHNRYm43X2kZAxBd84m+I
 jOOK2nb9cz6Cym1Rr2gn8zAtMC3IOzarq5fuoEgwjam9U/RhmAhlT6P8P2Y+9Vfia/v+
 dC6g==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro3o+tGh260g70gGZ3441dCTrPl8D1D6NIcm57u+NO/K3zWl9pbkdxklo8XJ/TYabqhJUqPVfGjXcCw@nongnu.org
X-Gm-Message-State: AOJu0YzCEt2ouZ7wh+9iRIW86XrSXU/wEoXm9/x+OR2Q6klox1x773eu
 PMvzo3RlCqq8D+hRxWL0KcDWrVjtwaOsvIID3RLbXpNGZzBivRYgIQEQOoBz9ZwA2+hOfwEvZX/
 HpmCMvG6Q/ha1Ksx5YhRBjGTsdHm5/mmZifnAbVVS8H+72667n7ksl33n9Q==
X-Gm-Gg: AfdE7clZmIgrSn0JL28I4Epl5MOpOi7GyxWuWE5YRYUr2lI/dXKgfx3yrBlGWQaHXux
 D/XFflRLbdLgAS+jLovSYEdA0XbArDmKz/N/76O35GNYGoJvOVERoRH7aA2s7DV0FCp0yvBpj4H
 sImJEUj6wzX8OZ3fkYIs4dIfntF9Dpl+munsYttZnEpnGtHMp5vJ/Qulaeo5XPNikPglIezJZ9e
 uGeIng6D7PgfzR21HZWC0C1OZAkrJnWbGKA1NmbM0DZKGxMfKohiXxqUep2cstd6GcqErrar9mw
 WDVXRiPH+bi7HXtBDngUo7u84qXZ0bSo9Er0BoOwl4WkMOGeYWPv/dcYh6Z3A2gTcQPNIID5CoL
 3CUEmJP2o78u8IdV4EgVEiJVvb5vEPpxOBnYHacAnAu/8wcvO6Rc=
X-Received: by 2002:a05:622a:11d5:b0:51c:7b11:41ae with SMTP id
 d75a77b69052e-5213ed76974mr121068421cf.74.1784545014497; 
 Mon, 20 Jul 2026 03:56:54 -0700 (PDT)
X-Received: by 2002:a05:622a:11d5:b0:51c:7b11:41ae with SMTP id
 d75a77b69052e-5213ed76974mr121068271cf.74.1784545013973; 
 Mon, 20 Jul 2026 03:56:53 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954c0a81f7sm185177445e9.1.2026.07.20.03.56.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 03:56:50 -0700 (PDT)
Message-ID: <3118a11c-a5b5-4d03-8059-c8c66bd9b89a@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 12:56:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] hw/riscv/virt: add opt-in RPMI base support
Content-Language: en-US
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260714075659.2258023-5-subrahmanya.lingappa@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260714075659.2258023-5-subrahmanya.lingappa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEyMSBTYWx0ZWRfXxpiwbpx7X2AD
 ftzPdIwDiTMA4yvJZqPpmICg1SxjH8qGUrC9LgiIGnHPWnfa5ztc1S6KDytJzAkbHDgNqzEGV+P
 qQHbEB+JflT6vI9TV0KUbYcSJkK/6T4=
X-Proofpoint-ORIG-GUID: M4znvTB6-dMrOzInbqhQ8IykOyz5F0lW
X-Authority-Analysis: v=2.4 cv=DMS/JSNb c=1 sm=1 tr=0 ts=6a5dfef7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=UxDOYudmPUsJcct1o5oA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: M4znvTB6-dMrOzInbqhQ8IykOyz5F0lW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEyMSBTYWx0ZWRfX1OQRKAqSfZ3Q
 eBYHeJsNFp66bWsBPtrXLf4mEnmpLYfUV1km1PuUIrNrce2tRt29t84gNtqvl4MDbA2meHHwY31
 Npvzkw5q94qjArVSxevJKpZDabToqSvb7L6eyDl+UnX0eWAawNGkNmfqxJ5sHXSo4BSYGEGNBzl
 xIcyEM4+nrRQkKplc0viuevbq8y5ioFu0rLgpWe0kM+OmMxUQ/NZ9k4zkBG0Bcvs/9AwGT0sn6E
 2BWLCZ2AX1XAMVJ+6XYLzHS9Y/Y7lXZYK3XXBQbjS5uGr60UY5I7kIH7n0R/J0siWY56kzs5iAW
 IP5gTerVhyjigdn8Ms307D/9RqywWGHvPRT1AwXhv6GYnwQZdD1gQ+xhCENlC23qyNkk4QpXQWa
 luJF1fdSY247C6GVg0p52c5aU+pMpEEZZXKE/VOxmQJ77DAP9Cen5qUrVAdYYpsTHop9qKRi0NW
 KWs0AO3VZXKqgCw6lIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200121
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

On 14/7/26 09:56, Subrahmanya Lingappa wrote:
> Add the virt machine rpmi=on/off option and wire the initial RPMI Base
> transport into machine realization.
> 
> The option remains disabled by default and requires TCG plus librpmi.
> Invalid accelerator/build combinations fail during machine
> initialization. When enabled, virt allocates the RPMI shared-memory
> transport, creates the RPMI device, configures Base service metadata,
> and emits the corresponding device-tree nodes for firmware discovery.
> 
> Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> ---
>   hw/riscv/Kconfig             |  1 +
>   hw/riscv/virt.c              | 96 ++++++++++++++++++++++++++++++++++++
>   include/hw/misc/riscv_rpmi.h | 10 ++++
>   include/hw/riscv/virt.h      |  3 ++
>   4 files changed, 110 insertions(+)


> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 33775a61fd..e52ccfae1f 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c


> @@ -1410,6 +1452,18 @@ static void virt_machine_init(MachineState *machine)
>           exit(1);
>       }
>   
> +
> +    if (s->have_rpmi) {
> +#ifndef CONFIG_LIBRPMI
> +        error_report("RISC-V RPMI support is not compiled in");
> +        exit(1);
> +#else
> +        if (kvm_enabled()) {
> +            error_report("RISC-V RPMI support is not available with KVM");
> +            exit(1);
> +        }
> +#endif
> +    }


> diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.h
> index cb2658e57e..b5d8a32f9b 100644
> --- a/include/hw/misc/riscv_rpmi.h
> +++ b/include/hw/misc/riscv_rpmi.h
> @@ -85,6 +85,16 @@ struct RiscvRpmiState {
>       bool has_shmem;
>   };
>   
> +#ifdef CONFIG_LIBRPMI
>   DeviceState *riscv_rpmi_create(const RiscvRpmiConfig *cfg, Error **errp);
> +#else
> +static inline DeviceState *riscv_rpmi_create(const RiscvRpmiConfig *cfg,
> +                                             Error **errp)
> +{
> +    (void)cfg;
> +    (void)errp;
> +    return NULL;
> +}
> +#endif

Could we use a stub file instead?

