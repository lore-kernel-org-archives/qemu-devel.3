Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1296C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 22:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtY2W-0002Ek-OD; Mon, 10 Aug 2026 18:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtY2U-0002BK-Rp
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 18:00:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtY2T-0002Ix-7f
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 18:00:10 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ALXWuK2830912
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 22:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ac/zO01AnBGVjMtA2xEMGdxLwOUplaoTa6PPUlfgQ40=; b=ej2TRxQ4wAEQMq14
 WtAsPgq5aH1no9n2levfEY97RTtt3dVh7mkrPrq8yWASpXErYd47rcSjnX97LWjx
 V7PFsduZUDPlviHljo/64A9xuh9xhZPAPQuMuTp+7e6OTcxxdsy8GHMhdK5/mWh/
 98j/AkhTHJ/GOeXeNHQHYjR6JLXHQbqheBE5q97hLOFVvXiDwQ3BoEQ9Sq86ug3l
 MvfrijdYuk+A6Bu1MztZ5nzzxw8Sb76Sa0HBTjry83rEvJhqITfq57OQ5jg6nclO
 AuSjZS+qQvuxjRmvAh8NJFB608Uu32FKdgPb3vsxeqeGf4seXYjCydgH5MMkU7aX
 4W/EQw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjyf133k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 22:00:07 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c12e43b98so2611271cf.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 15:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786399207; x=1787004007; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ac/zO01AnBGVjMtA2xEMGdxLwOUplaoTa6PPUlfgQ40=;
 b=RiS+e3BLgJ2HuZscK+lYdxAl7sL8o3k/Atvzm4WxQ0ljx8Z4bSBorrjbGDZIvlaMb7
 3vXfHOey9PLWKkE+e5bybYMgEKjks1f6B6kfKeT38KcwZ75blaRVEQ3jHY17IBih7JpQ
 Ih5yabMNrT7Z1zrDCybX8L84fLm4fLzJ6/BBkEVEIAWab5Gpw7t5Q9gUXxloKt2U22fX
 doucLThRcD+EDxz0JcFz4SG1xvQcEM3SILOw3x7vrRw/p3eLiCr/JMocqTPn0iTXZOg+
 xGrkZaVw20XuZ4eB71+v1pMIhELMVM16l3ll7vXzWjl6iiEtG0UliywxmdVS9eTyxJLS
 0zPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786399207; x=1787004007;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ac/zO01AnBGVjMtA2xEMGdxLwOUplaoTa6PPUlfgQ40=;
 b=MyEyABKAiV/e3hsujGNQ9JJgkea07Fe/FSyrC7tCK/vQRcTvi/YJAc9KvHtr2Pvw62
 m6TfglI/I5GBBsA5JjHsgNczr+R3/RIN6MWhoA5aWfw7VV8WfkI13PIwjasDESuU9YnD
 n+qNnVpNN3kmh//5MC1ZgNqQFtalNDOrGNkJRFrTjOTOoKnnDN6lzYctRu+0T+Qz633n
 ojXHLe/7ZZ7k/klvv+PooCLtyt/xMtSRxOxcFFwdbJp+gDzsQDECcPwMiPlwjLOmlnrh
 6eedLoBoG4xO33WW32jOedd/9uGeQTK+RVVtJrOXtev8V927ViSzW/spXZEGkMshSJAm
 oDGA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqqDxXQyt8BRKU8IrJciJxHF3wmyhBBNWMcH/WEGy9OVKrWDGgB1ZSaJG7r32ExO1swRrXhyM2HoDs4@nongnu.org
X-Gm-Message-State: AOJu0YyeOLRfhVz6QxUe+snZmFUbTHsxQHIr9spSpr4KGZvZga+XPiog
 EVVYgovQVr/AFi6fVua4rO8gdmAABTwCXGKgsm5yShi6N/Q2+JK9yJri2U1xKkiVi83jIPb+V6w
 Bi+FKLtJJTuyn/BperDJkoENxSRT7c6P5lst1KiMvHmWzE+9L0e4gbCvBZg==
X-Gm-Gg: AR+sD132eA9upwoQLiNTJXrOYL6sMWS3i4QnHxyF34rEItmyWKRZzRt2C2NCQWDQCRs
 Z4lSYY7OuY+pC0BNrXlQ8wD9dsOzo0pDbkRliIizuLvCy7J3GK+0HcgsKo3qbV3hpGbWihN91p1
 VVIkcxXa0fkzH1N2m52oZFpppH4PjDg5hkBb33+XZC3uO7wPyMAhDz3b2sLTKd6r9zS3Lvv2MTp
 YbXngkG0VLKoZRPeAruHsn8Zm4BO7BiQFFdLJgbccHNT3Q9uQ0F/E70fbi1KJ5hisljJwIHDyAD
 l4724pQdHC8C5xndBUUx0IZW7KGjc667tXRD0YrqAWsEhlDeYpdlZB9vbvgU58WzaIdWQK0SdGF
 Z+OfxbylUsWgBEPzqQBOHQtwxO/yq7ydgH9bOgsza
X-Received: by 2002:a05:622a:1447:b0:527:43a:2f30 with SMTP id
 d75a77b69052e-52ce5f6013emr470978841cf.1.1786399206800; 
 Mon, 10 Aug 2026 15:00:06 -0700 (PDT)
X-Received: by 2002:a05:622a:1447:b0:527:43a:2f30 with SMTP id
 d75a77b69052e-52ce5f6013emr470975561cf.1.1786399206194; 
 Mon, 10 Aug 2026 15:00:06 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4800215078asm36785674f8f.12.2026.08.10.15.00.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 15:00:05 -0700 (PDT)
Message-ID: <50dd37b4-39d0-4bfc-a987-73516b8f681c@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 00:00:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] MAINTAINERS: take over TriCore and add peripheral
 file paths
Content-Language: en-US
To: Parthiban Nallathambi <parthiban@linumiz.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 christoph.seitz@infineon.com
References: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com>
 <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-9-1c39053e5e95@linumiz.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-9-1c39053e5e95@linumiz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7ax2Rl0ura4B-dm5o-4-fSHXyLSqoduU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE4NiBTYWx0ZWRfX2ImPxhYnsfOU
 bkxGArixgtfgBGHkAFpWTv4T4WyrqGWrNWnPnpfrmB1gy6CccZYthOTWVgquTI1pBA0GKUaq+g+
 UDG4zYFraueX+aA3+lDHVzje2Nl5gN4=
X-Proofpoint-GUID: 7ax2Rl0ura4B-dm5o-4-fSHXyLSqoduU
X-Authority-Analysis: v=2.4 cv=NqnhtcdJ c=1 sm=1 tr=0 ts=6a7a49e7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=vU9dKmh3AAAA:8 a=EUspDBNiAAAA:8 a=wCO55ekECHlw7XZBzokA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=rsP06fVo5MYu2ilr0aT5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE4NiBTYWx0ZWRfX0NzeE9wQeQfS
 39jGfGsdqTOkUDmTqL5+Jr9/eCip7io7ujXdmrsx8p731YlaKAWnsghIInbf9UKjRVB5B2vQ6e+
 6qQazCB2ltnvr/LTGc3wtsA1qgyOL+tTkWJHwOIgVEda5YrZ7tfP8N2vWSkv1WYLgpAcznaHIBt
 g650VVfGyn5Kx3k28MO9nn11zXnLXpStnUKqXfMivO7okpgo2EIZ0loTOIzyI+Q55xXWmGg0Fb5
 HYRsPCQCiqx7wKDu2QVyMtJ9eb/Z179G//frp/Pmt0SbA4pQUPrlTI8/TbsXUC5m/p1YcM2TT8O
 wZLPOGZqakqpe6snDkKS+NXBbVe5q6c1uoAElt0ENJ1WWGKV1rDJot6CVUNWPELtoifN975MbbK
 Bzx+VazRbF3ies2rdVk2h3CLsr+0Fe7ansOU4zCYp4U4/K2CGKlKEX9ndCkJ5QxX3/UEkg+GgDT
 kHyb+za/tNdFs5y5mmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100186
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

On 31/5/26 11:31, Parthiban Nallathambi wrote:
> TriCore was Orphan.  Add maintainer and register the new
> peripheral files that live outside hw/tricore/.
> 
> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
> ---
>   MAINTAINERS | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7752917d8c..489be83fb2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -454,10 +454,17 @@ F: include/hw/xtensa/xtensa-isa.h
>   F: configs/devices/xtensa*/default.mak
>   
>   TriCore TCG CPUs
> -S: Orphan
> +M: Parthiban Nallathambi <parthiban@linumiz.com>
> +S: Maintained
>   F: target/tricore/
>   F: hw/tricore/
>   F: include/hw/tricore/
> +F: hw/intc/tricore_ir.c
> +F: include/hw/intc/tricore_ir.h

Move to "[PATCH 04/10] hw/intc: add TriCore interrupt router"

> +F: hw/char/tricore_asclin.c
> +F: include/hw/char/tricore_asclin.h

Move to "[PATCH 05/10] hw/char: add TriCore ASCLIN UART controller"

> +F: hw/timer/tricore_stm.c
> +F: include/hw/timer/tricore_stm.h

Move to "[PATCH 06/10] hw/timer: add TriCore System Timer Module (STM)"

>   F: tests/docker/dockerfiles/debian-tricore-cross.docker
>   F: tests/tcg/tricore/

Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Thanks!


