Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998B8CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 13:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDiOq-0001Ym-4g; Mon, 05 Oct 2026 09:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xDiOa-0001Ub-Kz
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 09:06:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xDiOX-0002s1-Nh
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 09:06:20 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695CFljn2226474
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 13:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 68/MEj2aCnTszQcG+42MXKwOQtnPqyWZO3EspYwBapY=; b=dpawgZD59/svzDvA
 5eyEAYiHv2bphtiWRdbm98p0zG4ASH7l9aodoZmPfNdd9tJZXy1OgTlyU/IBuDZI
 HMoU5QtoRKm4WWYYjGkRVIu1onMT3aNaKjFdeORaxQ9KGGWvk7g8jZ5eG9bQcg6l
 Gf3TSvWV7AFgw+CAeYalbTi18XoYO/gSdKTdMkfUR2S0/S8AGWtKTTWzthENpTrd
 LqOcWwW73dMW5+BZ2mOf3MWnIBjri23EfBFOfeg9ZkxvyelGJkDLQekPerJpZoBv
 v7glvw/Dat37P7uQkZJALSWGl7jvLJKVjZetBltp5/j/4JRQq2KXoeQ15N3aX1xq
 ar9oeg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4bhg06wh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 13:06:15 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7c10b8abe29so1866690137.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 06:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791205574; x=1791810374; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=68/MEj2aCnTszQcG+42MXKwOQtnPqyWZO3EspYwBapY=;
 b=g5Cx83D5stos0gxNU15npIEX1sGZNY42Cgo6EpxiVrSmqLZ/Y2u1QtWovE8Lr5mj5m
 hQvOJRr4dYhygDCdoJiXoOMpurQ4r71XeHHQAwZlm2XUi7qyvvUzNniYG6DQrXbsAbO2
 FqUnKC6viPD44KtTRFRrABS8kOXjXyjsEpOV/1YedUDKIeQy2RFojxWB782UL4p2KWB/
 Wa4Lb+t8Vh9PAiGjoNmQs/+i1fLeRg4fiJHh6DlpuRhCq77XRiYTUt1E07zNCpZpiORh
 rK7HyI73GCSnaD+2LkMCGUKhRDSbWb+7Ee3cjt72OlaHPePWkUSuPSex7KQaCW9yk1IY
 rjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791205574; x=1791810374;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=68/MEj2aCnTszQcG+42MXKwOQtnPqyWZO3EspYwBapY=;
 b=aGjQxZ3no3nfvL7XSfWTGHzv6/bJbj32a1qs5Zvbn2FJFZFmt8Um8uyORGzkFZMWFe
 kxrZhPmx92U6iwGzkvQbKi1gm8rkY/DfdUMTiEgdplf5D/NZsGsiUfMqevdXEMsYSfFN
 UC0tY30F53xm81IU4uiTJOGvRiC1eFrQebkBge8qoHtHXfzUOr/0dwOalv86bL/5ofAr
 8fIyxhVW3FQpr03LKHPmx6bpE/CMyrT1HWyNZOhzCWtVBFd1Vm6n4Nq81ZLrCNCz6qpL
 r3er0mAh7PD67qwGJRR6traGl1GKEb13z0W/D7/E5m5BN9H6zLYumvQT36VUt4m8EJI0
 bnyA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYfwWTunlg3UCbjGAi/dmPJe4PQp96bWm4R/HzRh3W2O7SfbH2OdOzU0YBeS5zb49HGamSMMO6fQZW@nongnu.org
X-Gm-Message-State: AFq9FYJAffWyDI/qZiOpaq7apoq380ncPwQx43SrV0PDok6/Qw8Wb/Hd
 2Koy80NRyoXp6MW8KQjMZ4haZ5CvbWS60KveKuNTqUUM34j8gMQeGVNdcLb3o+f516rxasvhSfy
 Qcrain2uD+0fL0VR6oU5jjkTHHdsVUevC7Pa1hsbVl4Vx4hDcUzG/jNdx/A==
X-Gm-Gg: AYBFou1i1fau1HkGTwhivUgVtI/sgVqrKby3FgeNYdvJ7fYOP/VSnkq3ib59e/Ezfp0
 ULS4k2vnV7NexuPIRrahfgoW3iqtMYmrbkCJs8oDdegTJtJUcOYOH5fABaebrWKF1aLGR3RZbTF
 wT0qfFK4qudmBrlOUl4aPFqbpMLdkOe8LJxwHY2e83yoxatqfYQ2sBFwMejr78Uze3/9fwqHf1o
 3pDyzRgA2P8wqvLCtONMEEhBo/Y3Ut0zQBLNxffSqH0SqvHcKnxlz+xC1ojGMwXV1wGB3XK9mPM
 BQym/6qKYwb4YAMQJTy7OvUP8c/nulmLFBP2diUsznOsATRQT1MOuvicPtCzpzRA52KLrbq6vpF
 yJb1gq7R0D0ylh0PDMkN0EWrbWCZ7nEnBcA==
X-Received: by 2002:a05:6102:148c:b0:7bc:696f:a5fb with SMTP id
 ada2fe7eead31-7c0f5baadd7mr2929704137.29.1791205572743; 
 Mon, 05 Oct 2026 06:06:12 -0700 (PDT)
X-Received: by 2002:a05:6102:148c:b0:7bc:696f:a5fb with SMTP id
 ada2fe7eead31-7c0f5baadd7mr2929564137.29.1791205570734; 
 Mon, 05 Oct 2026 06:06:10 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6229ce17sm3389247f8f.29.2026.10.05.06.06.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 06:06:10 -0700 (PDT)
Message-ID: <f1481bad-4dbb-414c-801e-aa24a6977b18@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 15:06:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/28] hw: mark secure machines for x86, s390, ppc, arm,
 loonarch, riscv
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-2-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260911143627.2743803-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Au4XxLOvgnlVChXRiA2-uBU27YEQ1Fjt
X-Authority-Analysis: v=2.4 cv=GMGdgeNK c=1 sm=1 tr=0 ts=6ac3a0c7 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=tVdpVsJRxwjYG60tULUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1MSBTYWx0ZWRfX6Zs9YfqJ13fI
 zMX/RmExvbLrew8lW/0r+9EoiUQ7A8wWAMIZLY6kYkoeSc+5JnhlfeMghc3d2doLqBbAO2Ddre4
 3IfTC8efxAZlP8O1ce81ncfdTLwaS2w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1MSBTYWx0ZWRfX65f1z4K95lod
 zrsPj0k3OOnz8AVTGGSN3Zaz3BkDwIjrp279bN7nuK21tzulx6OKFGke0zzccp29ijrYGsBStRL
 Czk1ebhEQZgDrlngeSkXucHfFPAahyMXloeNTf0AsCYgqcFotFQG6U0UiRjKYrwjemav6vmo2X/
 1PGFhAt1b87bOZhfA1wq1uRzHZ86MkC+UFoAf+I05OpjPdsGO3KI0Zt2fUAcWHcKCtfHBHnjGvQ
 nqpQrF+z9prmZZCxDiD7dL3M4T3Z0hbDTZSsB3lL7TeUY2Kg7eAgwthtSqAiyOU5y+HiF8gyZ0I
 6ryztqblpcn94XoHerc3m0XnKPGhk1Dr7dfOvl/GbjjoOo4CMss4sJStx8mmX8HwhWKEMTZGZMR
 /NcOLoNdAvLx48yDCahsHoo7EZnGM3nBFgbbAX0x2xX6gb/KjcLZyOcGyJ/xrmu5cnP5XC24tD9
 8OekRd8ZdoedwtkWmWw==
X-Proofpoint-GUID: Au4XxLOvgnlVChXRiA2-uBU27YEQ1Fjt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050051
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

Hi,

On 11/9/26 16:36, Daniel P. BerrangÃ© wrote:
> The versioned machine types are typically present for use in
> virtualization use cases and can be expected to provide a security
> barrier. The only exceptions are the m68k versioned machine types
> which are only used with TCG. There are also a handful of other
> machines declared secure in docs/system/security.rst, notably
> the Xen machine variants and microvm.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/arm/virt.c              | 1 +
>   hw/arm/xen-pvh.c           | 1 +
>   hw/i386/microvm.c          | 1 +
>   hw/i386/pc_piix.c          | 4 ++--
>   hw/i386/xen/xen-pvh.c      | 1 +
>   hw/loongarch/virt.c        | 2 ++
>   hw/ppc/spapr.c             | 1 +
>   hw/riscv/virt.c            | 1 +
>   hw/s390x/s390-virtio-ccw.c | 1 +
>   hw/xen/xen-pvh-common.c    | 1 +
>   hw/xenpv/xen_machine_pv.c  | 2 +-
>   include/hw/i386/pc.h       | 1 +
>   12 files changed, 14 insertions(+), 3 deletions(-)

This patch should be split per machine / area of maintenance,
so maintainers can officially Ack their commitment to security
boundary for their machine.

I'm not sure LoongArch / RISCV / PPC are. If this was previously
discussed, then pointer to the public discussions should be listed
in the patch description.

Regards,

Phil.

