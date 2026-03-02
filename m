Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE93EB3624
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 17:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx7WM-0004Ey-9B; Mon, 02 Mar 2026 12:57:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vx7WK-0004Eg-Im
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 12:57:28 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vx7WI-0005Oz-QL
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 12:57:28 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 622GVwFx3630829
 for <qemu-devel@nongnu.org>; Mon, 2 Mar 2026 17:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V242aLlBjSi3OM10MErzQPYB6JFho9ZnBmcnHbQYLks=; b=TGlWZ2nLPC8w3nWf
 aJ+yeKqCDgRzLUgLj3BharMkvvvmmYh5M6vusVyklaAYDPhgiurQpxtVPmDc4NCc
 G1+ATG+u5NHT+ZQ7WDQm5KuqQxwo/M9DUR7W92jvwOz5kHwsJtE71kbdSM8oXe2F
 By/qiKA8ljVRiebkcDuickbWffmcoOqluqZ8MqVVa33CQC+8IjwaPfDvvcJwdcrc
 xo1IPXUuKEo+qD833eK2/D7crUkhUdiUFZ1n9Ji17+Z0c7F74gfUZNBR/vwxc63V
 jBOKRkVz244VMWj7gzei/HAOp0UwhcT6YuLyVhmyqemecLZiL7BFf1zyIH/bhr4k
 UpI47w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn7rhssc8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 17:57:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8c70ab7f67fso5708235785a.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 09:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772474244; x=1773079044; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V242aLlBjSi3OM10MErzQPYB6JFho9ZnBmcnHbQYLks=;
 b=OD1UploKXn9zgZNcLmM/b/xCAJZPF8FeynXB09wAeE3mav63avAXrD2iJUobTR6S5j
 GU/uEmxEzHG+2PXFIoW/yVPL3Jffhd4Ki9EDay91rnmA/99dEvJeQgjktC9yUPl7QTIt
 bFE4UT9oJEvnuSGQ1VTJSWw6xtDWFQS5ZfugOiYo+ObAs7OZvQjkaXxA8hz4cTi+igI8
 s0/WZ6fCQuy+177f6oJtXwDR7LCO5+HjUclSIPCyagvvidCypiyJ9zRAUgC18hFX/HfH
 +0r6uTc138o6rwd+1akxYr+1pEQMwFIOQugp9zLTSAIK7uFtgNNkSuX/53xHxe4TtCD4
 8UmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772474244; x=1773079044;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V242aLlBjSi3OM10MErzQPYB6JFho9ZnBmcnHbQYLks=;
 b=LyNwVzASm5m03S4/Xf/P0bB8sjbNqX8RDcP8RbdKHLJTwIN8oTqTcF1yzKXZnNGpU4
 Qk9EpT0dsosd5MjLOKZqQMZVprBXypoPLCZVF9r/8IF9C4ujUXEZYu1RNm1WucQGK0WL
 U70+T8zQ3qC3c/TG13gsqhR4nJ+iI/Qr/LqUtJA+wOqUMMTbVesKvtRnWuzlN3UYn1NT
 Fa3Go50vpWqVDBLyTqyQNG5yLbrAlox8JP1ITS/UgxLafXsRgfQacZLSX6QRNZLTFHJG
 Z2W/IXgoi3BzvmbF666Ny7Ce4C8DPCXJXDCEN7+2yt+q2CvaAHdLbu0GKXb3XAG7OaQ/
 RzsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiKZvSN13TYJuZc3VNHrBAOVGjusRy7GRoDjbBTy0/c0pFpaPFbqSuo/yC/+8xI7EMvqi2SI7Coxib@nongnu.org
X-Gm-Message-State: AOJu0YxhjQw5AkeYnX4pXsLZqV2zSxeEfhS3t52jDjtzmI8VUfVBiUzK
 YG/V0SSRj/JW1OnfG2bjQNtvSKIwcZBVwq0HBX7PJ5BGabszcY2gn6fQ/6euQ7Kl9vV2PKrP2vo
 6R6gQu0YqI/rcSJq9dEQlzfAx3fkOCuG4JgoP5Dn2T2yJtLZpTxXC0S5CAw==
X-Gm-Gg: ATEYQzyCAhFkCNTGp2zUahRx1MvWnfzpowyg6Mie/Vs5d2gZJQNBSRktWgAolYJ4tDd
 5UerOn75KZdVfiD/o4nZsyImfPd2EU8sPTIqRJKu1H3S8woTlwCX0MnxUZZbdN+XAZQKtogWN0X
 h5/NBONH4kDz2Z2xWAvmAYfSVEUHcGdYgdWDZ3B0VNS9lyNITRPGD/OQQhfkRHbJp+yBW8JNU6C
 LaxLEwAbWPGz3W4/4v2TTyk8LEGsq06ViJkOY2m4m+JTgpuXKLRU5H2y7xEE/bv8TWlbIrK2Jdt
 Fmf2AT1woiy/OSdqByzYEwy1SqMOg5OQ1ImS1LAf0ON154L0s4bHhW6hkjL9Dc+QacCo5uZquoi
 QRr2xTxz7xkTm3YE7DDf72Ebfi8sXfKgoIOAOM/SD3Zcq3D3tOLWvgegahZQ=
X-Received: by 2002:a05:620a:4004:b0:8cb:4b1f:8155 with SMTP id
 af79cd13be357-8cbc8e79b19mr1765679185a.58.1772474243584; 
 Mon, 02 Mar 2026 09:57:23 -0800 (PST)
X-Received: by 2002:a05:620a:4004:b0:8cb:4b1f:8155 with SMTP id
 af79cd13be357-8cbc8e79b19mr1765674185a.58.1772474243048; 
 Mon, 02 Mar 2026 09:57:23 -0800 (PST)
Received: from [192.168.68.104] ([152.250.131.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a07f690c1sm2385126d6.44.2026.03.02.09.57.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 09:57:22 -0800 (PST)
Message-ID: <60ee477c-f00d-42b8-85f1-a0f793d57783@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 14:57:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv: Remove deprecated 'riscv, delegate' device-tree
 property
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Conor Dooley <conor@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>, devel@lists.libvirt.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260227232838.23392-1-philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260227232838.23392-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: b59J9MdizQ8uVyDyfRe6FEvKBZJvoCHc
X-Proofpoint-GUID: b59J9MdizQ8uVyDyfRe6FEvKBZJvoCHc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE0MyBTYWx0ZWRfX8MLiSTNPauEq
 PKw0ow6jH0MbR49sqjX2CjP9ZqB3jJp/Dqiflp+4yd4493ER8U/ZC6PURlAmaKEfwj+AcmAMYeJ
 A+YBPZpNAUQiUoXiXCealKBb37TljKWTFPjXqc7shYW2XM/OzjZaX5VK+XGgmOuGlMG+4IAlhTy
 lnkCXrZRh3HNsdkDiaouDpc1bff3+5wAbzbUqD1MgvOWef0upw1JcvQjtVoPoUO+a95ekl1JGwp
 C0zS5or1yqCw9nXpKKHXVH3ftgiWhxAL6iFwKDt2ExNGYpxnhXiwA9bP3ZMANVRDLc08KTfHvrv
 CC27UTzBfx7tmLD96XKjYVIW4EqXb8xJ0CbOSUUWHIutdn7GI4pGC5tCHTlY0MPU1e+yxGGS10o
 kH7wPmiJoyWg2pYuRke4Ch89iQIV5hUyYlw96QCN92ZADrUV9pQvyel8PveY4oy+6cQN8fo130h
 PsPk+5RgPaHyszvsMQg==
X-Authority-Analysis: v=2.4 cv=cLntc1eN c=1 sm=1 tr=0 ts=69a5cf84 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=pkECnv++/aO9mEczatB6sw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=dXRDz5lpHdRaHOKBsvIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_04,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020143
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
From:  Daniel Henrique Barboza via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2/27/2026 8:28 PM, Philippe Mathieu-Daudé wrote:
> The "riscv,delegate" DT property was added in QEMU 7.0 as part of
> the AIA APLIC support.  The property changed name during the
> review process in Linux and the correct name ended up being
> "riscv,delegation". The incorrect name was added as alias, and
> deprecated in v9.1 (commit 38facfa8432), so can be removed for
> v11.0.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Binary file pc-bios/opensbi-riscv32-generic-fw_dynamic.bin matches
> Binary file pc-bios/opensbi-riscv64-generic-fw_dynamic.bin matches
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   docs/about/deprecated.rst       | 11 -----------
>   docs/about/removed-features.rst | 11 +++++++++++
>   hw/riscv/virt.c                 |  9 ---------
>   3 files changed, 11 insertions(+), 20 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 1d5c4f3707c..cc5502e5394 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -494,17 +494,6 @@ versions, aliases will point to newer CPU model versions
>   depending on the machine type, so management software must
>   resolve CPU model aliases before starting a virtual machine.
>   
> -RISC-V "virt" board "riscv,delegate" DT property (since 9.1)
> -''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> -
> -The "riscv,delegate" DT property was added in QEMU 7.0 as part of
> -the AIA APLIC support.  The property changed name during the review
> -process in Linux and the correct name ended up being
> -"riscv,delegation".  Changing the DT property name will break all
> -available firmwares that are using the current (wrong) name.  The
> -property is kept as is in 9.1, together with "riscv,delegation", to
> -give more time for firmware developers to change their code.
> -
>   x86 "isapc" board use of modern x86 CPUs (since 10.2)
>   '''''''''''''''''''''''''''''''''''''''''''''''''''''
>   
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index 41bec8b8e38..0a62e87ee35 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -1232,6 +1232,17 @@ converting to using TCG plugins they should contact the qemu-devel
>   mailing list.
>   
>   
> +Firmware, ACPI, Device Tree
> +---------------------------
> +
> +RISC-V "virt" board "riscv,delegate" DT property (removed in 11.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The "riscv,delegate" DT property was added in QEMU 7.0 as part of
> +the AIA APLIC support.  The property changed name during the review
> +process in Linux and the correct name ended up being "riscv,delegation".
> +
> +
>   System emulator devices
>   -----------------------
>   
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index bbce2fb6671..a1c323e66df 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -666,15 +666,6 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
>           qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegation",
>                                  aplic_child_phandle, 0x1,
>                                  VIRT_IRQCHIP_NUM_SOURCES);
> -        /*
> -         * DEPRECATED_9.1: Compat property kept temporarily
> -         * to allow old firmwares to work with AIA. Do *not*
> -         * use 'riscv,delegate' in new code: use
> -         * 'riscv,delegation' instead.
> -         */
> -        qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegate",
> -                               aplic_child_phandle, 0x1,
> -                               VIRT_IRQCHIP_NUM_SOURCES);
>       }
>   
>       riscv_socket_fdt_write_id(ms, aplic_name, socket);


