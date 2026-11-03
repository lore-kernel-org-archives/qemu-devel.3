Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D149606A33F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NwF43Cuh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R3vU4FIN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOCvV-0000pG-FK; Tue, 03 Nov 2026 06:43:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xOCvU-0000ou-7c
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:43:40 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xOCvS-0007u4-JG
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:43:39 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3AA3ho3577893
 for <qemu-devel@nongnu.org>; Tue, 3 Nov 2026 11:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lUpj1XyIUcdWcYKTf8w/ZWxcgNOAaWqvUmuMHKh8QNs=; b=NwF43CuhqeO/E4ge
 vIS6rj5mAmQiUkXkgnMucFyiTa7KvYUCyhil2KHVHuCpmFMRgtjVm5BOB/Da6cI7
 Wh1m1Xb7VqqqbNOLz6NbWTNGilgg/7TzsNnJn3+lAyUlWfmWNX+c9Bsy/ADSQZnQ
 08fhZ5+jqFOHZVkj56TUrb5BdUljyjcRe7IWWT2mophHdBuZpX7LQYttWxzaq0WZ
 LXORIK9IsDbAfPL7Ee6t5zdvvoc5w4TZ5krZd5ZsdhPYvksCXv81fgq5sE151u/Z
 anmHlByNt9wC5u5HF/sEowjHf4okt+yVfOAegzALSV4mDFAB8q2TFVwqEuHchS2M
 3Zg1pg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq76d9xde-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 11:43:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93e49a1d3b1so963659285a.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793706216; x=1794311016; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lUpj1XyIUcdWcYKTf8w/ZWxcgNOAaWqvUmuMHKh8QNs=;
 b=R3vU4FINuW+fqOQGe+HRXVJuCKrsDfEqTLN8ysylclCnOFWaMM8WWI5sAZuoHzJIcA
 1hGT+phIRf1zuewWn8AkrFGgkjtjAE1yWANu2Xh3SChNKXvWxRwF061/rAaa0N84RnP7
 C6kVG8BNWeVqWe4hFWPZaIRM9vP8qmQevNi5gHUwCqfJxOQezqsTm/GvQK1aYvAGWsgo
 mQkKEiT9dLBRE/Kflm7CJIi5MwCZKzjbwBcTQ+QMW9AU6cLaHtvrkMUc/TJFPr3E9GRe
 ZylcGT3gLV+H3UIpdZzLNiPq72gOd9CISw3eFsqVV6ISW1Ihc+fnNcksXMVkSVZ2HMmZ
 VX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793706216; x=1794311016;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lUpj1XyIUcdWcYKTf8w/ZWxcgNOAaWqvUmuMHKh8QNs=;
 b=xCkGKrxZ3rQFzCF+Mtsa2D/2v3y3VpxvbAsWr9TQcwZSNARfwdyxHjrbPp6LnxG8LT
 nziwQqOiZpnjzWvD1PmrrASh2DRlvXUkbaQ6ebEkqlaUCGyNR0vzVyGpB49kwx5IXX2V
 2n8ZPmAaNv3PKZOB3q0bKHTiYPWb8OWOlMO8f5ZoRmc3NIWJIo01ZJjhRO7DAg+Ryg0l
 ltb6y4j0vrwAMp7w5InS+OJJ1ax3IzVHHQ0nVuwuD4tGwbBTwnlEkXhcHzCkOBAMdXg1
 TWg0l8kyol4U3QSfztdXwFGc6xC7e0JOZVNZ58vjnrnd+ymnuwx3Tp7AkORPHTF5ShmC
 g5Uw==
X-Forwarded-Encrypted: i=1;
 AKwUvBznkRhPrRn4fs7Li9uYe5XD6tXckCzudSV7Ik8WsTsFAA/O8taLzWAdJxqAslXWwD6C6HY8A7Kh7zuB@nongnu.org
X-Gm-Message-State: APuU4Z9emjxZhwm/+et3V9M2PJIS438hoVniWJe4pSf0TwvP07/2p3bO
 Vh4Nd97YmgmO6MRUtAXyjOmTVy8/6WLu/RgYVSlwUQbepyrYI2l/5Nnl8bBfsJAhR9gJv4WAKrO
 3/LEOmbqtjhbrNL/isFhmnfsRZSnrCr2+4tQCIApTY7DdtxsENp+KzkrWlQ==
X-Gm-Gg: AYBFou0dx+ClSYwRi58WVsNeHBfdVj0oFDcLka5ZQDQewJTRDC35nxiA+uWBZu5zEjU
 4IhoUCUp6ubpO9W+jzW0Qbtl4cEz8z4ftawazrNpqXPWeC1RUJ1+IP8ta4AUY1LyN0eF/8eswuG
 1Yerhbd8LQQOB6ClJwM/lOruDSk866LG33bt8i2JLmdCnwx8jPBGjopJfGYTzeuNcOAYFYHwTh6
 WmQ+p5lk9s+YLNLxsTYGhE1EWUn74yo1+/FKkOKP0cTofBwC+yC9+7JA+mlFlc5BjeeURJivrlw
 rRme2ltQGZIvmbsZ9RwtUg5VUyYMPrQZS8xihr8UV1/wrLjF4c0kE9Po3IJijNA9XIH2vzUnBPW
 RjagBA1KGF2J/2pz/t1/aPYcn5sHEqxGHvKDe0gFMIR+kf3hMgEs4fDAOQIeSWAZOfCKV07sG+/
 CsAkICYQ==
X-Received: by 2002:a05:620a:404c:b0:93e:c12c:f149 with SMTP id
 af79cd13be357-9442183db3amr2059462185a.83.1793706216069; 
 Tue, 03 Nov 2026 03:43:36 -0800 (PST)
X-Received: by 2002:a05:620a:404c:b0:93e:c12c:f149 with SMTP id
 af79cd13be357-9442183db3amr2059458585a.83.1793706215511; 
 Tue, 03 Nov 2026 03:43:35 -0800 (PST)
Received: from [192.168.15.12] ([187.56.223.122])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca80887acsm114546156d6.45.2026.11.03.03.43.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 03:43:35 -0800 (PST)
Message-ID: <a84eb5d4-9542-4eaf-b3bd-96f2ade046db@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 08:43:32 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hw/riscv: Build device-common only for its users
To: Tan Chi <tanchi25@mails.ucas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
References: <20261101031547.125591-1-tanchi25@mails.ucas.ac.cn>
 <20261101031547.125591-3-tanchi25@mails.ucas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261101031547.125591-3-tanchi25@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KJTPn1Fo c=1 sm=1 tr=0 ts=6ae9c8e9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=bus90iwuyia7r0C3gDGjVg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=tKkgsBWQpxOD88fezzIA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NiBTYWx0ZWRfX7J+qKH/L97u1
 0XneIklOlS/sZu1rSRcDFJNSpgaU5J8tTyogaxb1mOZPPifSRGWfe17ElFKTCcoLiWj/1zsvtH+
 MOZZUQGSdgiYnC5tBbNXkd59F1pBKY4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NiBTYWx0ZWRfX8ijRtIkazyRK
 kixID9be5Nq7iwMfU1IBad7xUd30rkLdyZ99y8cgfdbOSbM8IsOSivHfEV6ylAUysmGlaPdk466
 uESl/edOr/bY/POFNaBRZ90k45ffUBZRgtEWOE4yZJ7/4TXWB3g0VFrKTSTai2+BC79ODVqlk/i
 VBGS6MGyVqHHo6rsegP8jTCwBQJooOOR3+mboVAE6kQEhvoIAlE1h2IJ3cjGeR4WwGEFEsBC+ru
 3KeYDCTJQms2b2SJ5xdH4qOrIcnaRduCUDqm4I7V9SrTb3d/Agh9atu6PdpgNsvIwVyOJO99z/y
 +v0+aE1aCtnrO/Z/NyJlFSWfigHhHHDoFIb6i/XrQfGIS+Nt3j3k8iJtdJF5RtNTQ4TLFHMuiDz
 RD0cDi2DFUjPjo24vdtztZutemrbWhRv5teIN5OaKfzQxMm73+Iw+U0pgn6yLgoAsFa9gupkBc9
 Uf2QxOjt2Rlrxcue3dQ==
X-Proofpoint-GUID: FT8xoiUVLsnw3Z4wEeL_vrXwAGVoJwJw
X-Proofpoint-ORIG-GUID: FT8xoiUVLsnw3Z4wEeL_vrXwAGVoJwJw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030046
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/1/2026 12:15 AM, Tan Chi wrote:
> hw/riscv/device-common.c is built unconditionally, although its
> helpers are only used by the virt and server reference machines.
> 
> In minimal builds without these machines, device-common.c can
> reference device implementations that are not built, resulting
> in an undefined reference to gpex_set_irq_num().
> 
> Introduce CONFIG_RISCV_DEVICE_COMMON and select it from the two
> machines that use these helpers. Build device-common.c only
> when this option is enabled.
> 
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/Kconfig     | 5 +++++
>   hw/riscv/meson.build | 2 +-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index fb05031228..27f03b687c 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -7,6 +7,9 @@ config RISCV_NUMA
>   config IBEX
>       bool
>   
> +config RISCV_DEVICE_COMMON
> +    bool
> +
>   # RISC-V machines in alphabetical order
>   
>   config MICROCHIP_PFSOC
> @@ -68,6 +71,7 @@ config RISCV_VIRT
>       select PLATFORM_BUS
>       select ACPI
>       select ACPI_PCI
> +    select RISCV_DEVICE_COMMON
>   
>   config RISCV_SERVER_PLATFORM_REF
>       bool
> @@ -85,6 +89,7 @@ config RISCV_SERVER_PLATFORM_REF
>       select RISCV_IOMMU
>       select RISCV_NUMA
>       select SERIAL_MM
> +    select RISCV_DEVICE_COMMON
>   
>   config SHAKTI_C
>       bool
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 957031c07d..b60108787d 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -2,7 +2,7 @@ riscv_ss = ss.source_set()
>   riscv_ss.add(when: ['CONFIG_RISCV_APLIC', 'CONFIG_RISCV_IMSIC'],
>                if_true: files('aia.c'))
>   riscv_ss.add(files('boot.c'))
> -riscv_ss.add(files('device-common.c'))
> +riscv_ss.add(when: 'CONFIG_RISCV_DEVICE_COMMON', if_true: files('device-common.c'))
>   riscv_ss.add(files('fdt-common.c'))
>   riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
>   riscv_ss.add(files('riscv_hart.c'))


