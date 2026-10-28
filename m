Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654F4606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 06:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WH9yBU1Q;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MoL5E1Rp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLxY0-00065B-Ev; Wed, 28 Oct 2026 02:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLxXw-00064m-01
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 02:54:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLxXu-00074w-7A
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 02:54:03 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S4PRDE655302
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 06:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dUd32yJksJOL+17pXKnKYIz5A6sgupNR/rfnyBa806c=; b=WH9yBU1QCLRtpE8Z
 pna1Zgz80/h2WVDOsZFlzM52G/6vczArPIHVrFx2sszzYtMqcchNmWbDNHOOADJi
 a0alGkZk9VC+SxdRJnodHCAhNiBgQnxljqO0B/7OhNmfOd3IUBAb3THgW6YT3Mre
 54La6M7R8cjup4sCRvqJPgifdDal99buXCwtI8IQK1TRucscLiVivhtzYDXiOn2u
 0teTsLElIlf1PXQC8VNbniJveKenjShvPCGtwjnJesEQYRF89H7qRXlzAjOMTHJ2
 ALJdjyv1Wqa733EDf+QeYTjYA3IolIDYsfi/ctlWZXfxJWeI9yVpJbjbPr69LsXh
 r8OjCg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk7g7gyec-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 06:53:49 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91b7e7d5f56so14889106d6.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 23:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793170428; x=1793775228; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dUd32yJksJOL+17pXKnKYIz5A6sgupNR/rfnyBa806c=;
 b=MoL5E1Rpi1kgXCBmBMk9EdoVI08mNJM8LgGRuloiOWBQK7vTiuSdBztIZ6iNKRz6Qt
 murnvzxYJ5QGaoJL9rf3ZfqBLv7snQI+W/lp0fdnDH2abULwxz1YR1jADfGo/Y4qZw9O
 z9/qkkZWR1h+vOsFQ5gV1JrVHpkZo73H8Xuuh8jgM5dJCCFrSLnWTWM1pL+ZJ7P9tamu
 5UsVL2zXWAEVpn1Dic8OzdJwqEfLnVcwaQ/MgiZ9GHp1BjFT1oJyQNhFST2o93zKeaqD
 z1ZtMx9yYRLeZcWeNwqqy+XeRnuziWtghGOZ0glq+sVyiOlPbWlpL7Fs2wEBMg93vTTb
 4Cuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793170428; x=1793775228;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dUd32yJksJOL+17pXKnKYIz5A6sgupNR/rfnyBa806c=;
 b=uvubADt1sadng9/BSdLhI/HZXMgz9p+9ZoMP94kghob/5OUaPLnLK7q+QqzJQpW54r
 iRd512J0uH/b90ycShlbUbFEijet2Qq3wMvSRrHM9aK4D3h/hogvpFQX9bS88jiJLrY5
 6nNLyCLuuXmMLZ/vTKQkegh5iE7gtwy5loLJ9uUuJ5rZPnRRCRlqOdcJjQVIoU7Rovjy
 YG4Z6voPb7ddio+FAq7WXTGkIKOZ2W7luXdQApxGdphTAajVTQEYsUS3iOXCAkCrvebf
 Eq9np9K8KSOLx00hq5fpEJlFasQtBViB+INQmF1XBSQ8ney1Vca6dLbKQE6SAzCA5U+N
 AHkQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxrm8qBo14mdUpwu4xnSqNLDrwQvM9tuhTSgLVxL7w51CgKmnx/QOzR0pTJ/gw9pvYDKhSzXginh3M@nongnu.org
X-Gm-Message-State: AFq9FYK+8NK9xKsAkoVXQAQhiG6qhfneQ/xEukiEcP9M1iT/2E4Y64wS
 2esFX1DPONT9rLE1xBeWnMW/NbvVziXANVqrTOBgvc7xCMQogagtA3nzTFp+jagCq2Cx0pc41/s
 5iGW4Inx5wK9xs6U6F4+j1IvUN1NF70bwdTqv3HJBaP8U+G3hNTJ5D2EWJQ==
X-Gm-Gg: AYBFou1+YhbkAOTc7wO2lGvn2O3OQxm935AcY5yAf/bvrqb0Cnvq12vHcKq/Xhv2cqe
 ysgsNRMMwE7uOUCqgVp6s4eXkHgpYY7PKAu50NQcCTgAhtU2/TZ3+X5E+VgFn2TNZ2qIAb3tHue
 G4GgmhR+LC1vn+HlJdilrnRn0i9GEqDmDRuIiBOYJ1+vFdBLmZzGu5eBGjmTm7BnVXeaBUS0lNf
 az+sTcE1ttyGqbdKTYeXmV8PPzohvNR85BJaHW3FM1PD2LR6iXNWPojGbs3q3WX9lZOaL94HZ11
 4FuulZ8y2xvvjsSq5OeVfZwWO9ul5vlEoocspZgepm9u188j9D4NYdQVPz7fiCOehszXZmVMYZF
 Q0E6o92JHj4YBagD6xscan7kVLWFmfHUh+8liTWjE3LZpBiue3/hiY4RT5L1FwqkIexCLK9CDsu
 52GVW2+4AC6iwkIN1daDkUQIs=
X-Received: by 2002:a05:620a:1789:b0:93e:9292:1b9e with SMTP id
 af79cd13be357-9440891bc3fmr179240185a.1.1793170428342; 
 Tue, 27 Oct 2026 23:53:48 -0700 (PDT)
X-Received: by 2002:a05:620a:1789:b0:93e:9292:1b9e with SMTP id
 af79cd13be357-9440891bc3fmr179238385a.1.1793170427844; 
 Tue, 27 Oct 2026 23:53:47 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4115f496sm25577021f8f.5.2026.10.27.23.53.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 23:53:47 -0700 (PDT)
Message-ID: <9d09b025-1bb7-4f6a-9821-400141437126@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 07:53:45 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] hw/riscv/atlantis: Back RCPU memory region by
 unimplemented device
Content-Language: en-US
To: Portia Stephens <portias@oss.tenstorrent.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Ellerman <mpe@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261028043059.600498-1-portias@oss.tenstorrent.com>
 <20261028043059.600498-8-portias@oss.tenstorrent.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261028043059.600498-8-portias@oss.tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAyNyBTYWx0ZWRfXzKi+IoIVCMh3
 uvq35bkmcK065wonN8N0pUPaal2mJ9xdKGTm82jx1afrFwdVi0dKE0BGKSqG07mWnhc996qPc7V
 7C8iskfn4ONULuPK5FyMx9g51KlV494=
X-Authority-Analysis: v=2.4 cv=SoIFe/O0 c=1 sm=1 tr=0 ts=6ae19bfd cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=t9496tuAAAAA:8 a=X0qeV9UViFyIYScYyhYA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=4wQ91nGE5lQcD7eh5OX0:22
X-Proofpoint-GUID: 8UBDtyF5DUvW5qY1RN0XQY6E0tKtdvbo
X-Proofpoint-ORIG-GUID: 8UBDtyF5DUvW5qY1RN0XQY6E0tKtdvbo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAyNyBTYWx0ZWRfX3lohGEZ07s7z
 WeI9IV4eR62JsrGT5MWwL/hRKtsJ4SGbytXF0vK9Bai+eXdml8UHtqvmJ1YmI7wX+krlE1NMeTx
 UkIGr53VHq5hZfKNjRDAYqVwzGa1pYSO27upJzItOmfZOIZgmDdvmrkauCyXbM+EwemcC/o51zO
 kuweuR4q5v5XbNs3114zJV1DMou0qTGcovXkeIcHn3H2HdT8koMh+VYF1tKHwRPCQmfww1kwk3Y
 HaySjd6kPjoJeBGnPoDEVqwlrfaGXdhcOGX0MKefO6sROuUmqwytcwcPAMm9/mgB8B4hLr3K/jP
 tnsTkadvfdvGgnN6Z5KNE/zt3/YSWmcEPgBA1F1cDHJXQBsUm9TVlcFz275K+LFk1+1lLV210ID
 RuQ6o9PXOYjcHmocUZh30XzMEWx1/C3bI0e6n+JJaFokRCs6tXjHNB6O9rHLvUDafj++7e+Izxk
 sMzwyfD02XY/ak6w8XA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280027
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

On 28/10/26 05:30, Portia Stephens wrote:
> Most devices on the RCPU memmap are not modeled yet in QEMU. Back the
> entire 4G memory view of the RCPU by a low priority unimplemented
> device. This prevents accesses to non-modeled device from faulting.
> 
> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
> ---
>   hw/riscv/Kconfig               |  1 +
>   hw/riscv/tt_atlantis.c         | 20 ++++++++++++++++++++
>   include/hw/riscv/tt_atlantis.h |  6 ++++++
>   3 files changed, 27 insertions(+)

> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index edf2180a98..66cbb2b8cf 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -519,6 +519,17 @@ static void load_fdt(TTAtlantisState *ams)
>       create_fdt_memory(ms->fdt, ac->memmap, ms->ram_size);
>   }
>   
> +static void mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
> +                                   const char *name, hwaddr addr, uint64_t size)
> +{
> +    qdev_prop_set_string(DEVICE(dev), "name", name);
> +    qdev_prop_set_uint64(DEVICE(dev), "size", size);
> +    sysbus_realize(dev, &error_abort);
> +
> +    memory_region_add_subregion_overlap(memory, addr,
> +                                        sysbus_mmio_get_region(dev, 0), -1000);
> +}
Please use create_unimplemented_devices() (see commit 782dbd23fd10).

