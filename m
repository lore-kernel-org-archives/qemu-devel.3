Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6991EC5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 21:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtXxE-0000xL-II; Mon, 10 Aug 2026 17:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtXxC-0000wz-OV
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:54:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtXxB-0001ZT-9i
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:54:42 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ALXdtF3388616
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 22vKV7/LFGU7N/jL0Kn49WvxmrzIeoLhGNDHcv3+syM=; b=aB+qhAVe0eVmjicG
 dTth6j55hayLXgFq4QQo6M4A50FH77OsIIDeXZgr6iUs9IZukBuKWyUcmgstvUeV
 /FjTq7/dAHroQEHEN7f/zBnOm2UJErMCbkCTJivNmUPGrY7ttw/Pzh9fbuoMaAI6
 KjsYaEi5vIQ3av+aDENqHyVJ13yQJWxYTH9xRrqXTKJ6PUqioC5IFCqrPWVdiB+c
 DjuuLG+W5TEUcqw8c0QtuIodIYXNPeWkKl3jaP5R4yTTMNQU2OPr+dz5QNW6/DyP
 r6zq8QuVecg/nc8KcIAXqRb0rwpwa5Ja90RgPvb0GkutCfFDXs3FrKpv9k7mYFeg
 UV3+Dg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy8v3uwww-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:54:39 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso46013581cf.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 14:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786398879; x=1787003679; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=22vKV7/LFGU7N/jL0Kn49WvxmrzIeoLhGNDHcv3+syM=;
 b=O4GdS9xXVu4uPcRCNf+A8a8hkiKXBvfNin67JVaxarsIeTrOEVgGjXZhcLyvC9AU99
 t2JJlTWnEv3Wb9BUdlcFkJK8GrBOL8j189etohOnf4Q5wSsLrpMUThdG5EiKsm6Y/z/R
 D1BmNUXJT4UMddu9IlpIgxw0K2ssd+frp38qXrCPUaG9UaFRzcMF342J9MlSt9s6plrH
 hcw8jlt/LFgTsFfuBYVcWTa1wCCe739oFghvXWzNM+sovCR+ais+dMN+IePBjhFgwk/M
 HESAFurXb/IRqaJe4UlFKEhdmTjZB/Pjw9rPUh+DVUTICzmJnSBPFDGRHN0Gex5G9rEN
 HHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786398879; x=1787003679;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=22vKV7/LFGU7N/jL0Kn49WvxmrzIeoLhGNDHcv3+syM=;
 b=PF0fg57Z2KWazR5KN5c2Y7r4WDNuTRsj303cTRHaJ+0K2SQzcMj57t549giTkciz8I
 R6LgjS9aHhOluwoZewMClCC3TdCJHYETX8OstSo2zVa6tWEjpPDgEpkePxnQ1XiWKdja
 GpskcW/Nvg4VhZb7qqKiX0p/DdO5yt5FJSJxfPi/p6Be5qhcumFVJM7dankU6y4QtK8d
 Ntncf8RsHysqXAb32MAf76GxDo+xMcmJNmbiO4OR/CWuyVHCfqWa/zCIETkhYsMUAW6B
 95EkGdUhc9a6RWB7IrAXTSjem2/UaHaF1b7KC3b9pQG/b6Ufb6p4ORybExIcTLvqnauu
 MDuQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYsIXWZ6a2u/ue6G87ra24h+6pvnIiaOtNWWzC5FYMSy2xUofs6Rasdhu3WoRam0osIepVqhB4mk1i@nongnu.org
X-Gm-Message-State: AOJu0YxX7rOs0f2ncMAWKrGCBEbCsQRii7j9R5VOFb9AmHt0MYPjFgn8
 yS2xewoePaE5BppMRHfxDshlpYLnGpB+M/MTBmi04NWYpR0jXmlWsjM69EfaJ+LQQYBIzhuO8y2
 LttR5/sD+F7pwAFTHhgS76yIlsdrVC65RYHkxiZf+lA/vFIXgoKbLp9B6Uw==
X-Gm-Gg: AR+sD12/5lKHbBbKZ9MmCV/3LE8puOPH4aM8mTdBXylOD+5VZXgX1DUiAnXhOkEBa8E
 eNoLZ34s7y1HIyVFc0wAQtafsKpY8ffuPxbEOTFLZYY8aprccDXl6M1gZK81LiXfeMGSIgyt3kB
 I95fQLk86+kB5X3M43her2NU7ceZMaBgmR1mPTQK2O0O+dzZsKjOqmH3l8jomSvymS4yPItbUJC
 V7EigkmgyNdzFw5dEP24sB47EN7OpieXwEJ+AzpZIhjfhqd3C63Zt38/xkYvlGumVVIlrl5/BMP
 zvEaH9gitVhTJCFqZjegeIGnc0swLtSurFkGbj83Z5WBR6MBvofEPlR90C+2QRq64HegfMaFOiX
 Uw/TAJwdh3JOhjCc57s9YJcCocgVJmHvSkNo0UhZl
X-Received: by 2002:ac8:7f8c:0:b0:519:f884:b587 with SMTP id
 d75a77b69052e-52d4bc6b729mr57616581cf.27.1786398878832; 
 Mon, 10 Aug 2026 14:54:38 -0700 (PDT)
X-Received: by 2002:ac8:7f8c:0:b0:519:f884:b587 with SMTP id
 d75a77b69052e-52d4bc6b729mr57616251cf.27.1786398878428; 
 Mon, 10 Aug 2026 14:54:38 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4800220ab04sm34762492f8f.37.2026.08.10.14.54.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 14:54:37 -0700 (PDT)
Message-ID: <94b900b6-5d9e-4f49-9857-68dd62c7ca9a@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 23:54:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/nvme: add SPDM_SOCKET Kconfig dependency
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Jesper Devantier <foss@defmacro.it>
References: <20260810214846.76805-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260810214846.76805-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: r_z15ilSiOErXRZW7kXIL-r9lac9k3Ad
X-Proofpoint-ORIG-GUID: r_z15ilSiOErXRZW7kXIL-r9lac9k3Ad
X-Authority-Analysis: v=2.4 cv=c+mbhx9l c=1 sm=1 tr=0 ts=6a7a489f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=-mrvvLfIadwLpt3n5O4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE4NSBTYWx0ZWRfX4UmwP6+sqDD+
 ZBjRHNPZfn1zMZEOgp7qa/wDIvDptgSO2ln8XELG5bUCn8EDlSm9TN3/Assp2K/6HRkgtDSlK3V
 pfozf2e4Q8yOlPKs87tv8WeKfBQZaKL/iLXcmuuyfs/x6G3wEyvA+RU8hpG2mfjW47u1Q889Cac
 obh/RFRx9ZKMhP5Ntd22CceZdnQjy9hoKFgzcQVkCQQlZnoNqA75XN51EYd5hk7bk8QhicS0Lzh
 pt924vf3I4uRnJ85lJqdgG8899bGxmhERqhBZgevtNOe6GPoLG7Ml1L02hzGD/QaAPuA5Yye+IG
 YJvdFv3Cx01azxS21+qStHh6NGoaB5IlSxOqW/CQB9VvyjM8DSBDaPNzaW7H9kUPhWtaiYfdh28
 jXJ7+HsJYBbZaydWCFAntKqKEJdfUw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE4NSBTYWx0ZWRfXytujwEgH0Zn4
 Sa7Q2zL2PN82WYNEeAY/dtx5V5Hq6AU4F2UW8sfUbUEFV04AwcfT/IyD9KORBLV9jbzQwsvHgLK
 RN2NFD45BnXPYxfs0WfWS5JLuO6hKss=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2608100185
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

On 10/8/26 23:48, Stefan Hajnoczi wrote:
> The NVMe emulation code unconditionally calls spdm_socket_*() APIs. Add
> a Kconfig dependency to avoid build errors when NVME_PCI is enabled
> without SPDM_SOCKET.
> 

Fixes: 4f947b10d52 ("hw/nvme: Add SPDM over DOE support")

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   hw/nvme/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/nvme/Kconfig b/hw/nvme/Kconfig
> index cfa2ab0f9d5..cfeeed64cd7 100644
> --- a/hw/nvme/Kconfig
> +++ b/hw/nvme/Kconfig
> @@ -2,3 +2,4 @@ config NVME_PCI
>       bool
>       default y if PCI_DEVICES || PCIE_DEVICES
>       depends on PCI
> +    select SPDM_SOCKET


