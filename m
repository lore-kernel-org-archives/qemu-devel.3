Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5C7C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzVka-0005Uf-8u; Thu, 27 Aug 2026 04:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVkU-0005Ts-1m
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:46:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVkS-0007YP-EB
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:46:13 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R6RFqI087957
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o8gAehL94WGGN1MYx9UOXC1P0U6rV2eAzOiDC442g08=; b=T3HddhlTbANOJj00
 HThYhJfCvbWklEh1yY2jKb33k9RqISF1w0Oeu7QJ9eKCLoYdT1GpE/WaX0wX5j78
 lu2O+O2CbchLjUbaD8huzphnpkeAkvxnuUxFUx/13wQJR0Mi8LRFp6Ml/86vw9/U
 0+f8CWGUPqzpKqz8nUYUfmQQsk9gYqnd6Cs7t+celcjrwvwQxVyFfL/Zx11GLpud
 U09WX9lEQueinKm1HPaBlqNUqZBQr/Aws9w9l0/Lk6izsd2RXMkAT0CEZr6b/l67
 8smF6OaEH7QDSFFmR5MlPCOn+sNvrr06SYJjqUVgsFuGwLNhZGj+wnxozg0yCKeV
 ZibtrQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga8m5hvud-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:46:09 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so19048971cf.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 01:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787820369; x=1788425169; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o8gAehL94WGGN1MYx9UOXC1P0U6rV2eAzOiDC442g08=;
 b=blchUnDVY8aCdogN7XboJoQ69aeM4A5/wgjKAXCvo9wri/63h1vvVL0dkLmeylppbh
 a/dX8ukkWP283OqR88EKuiuh6WWSjR/0HS4CwCGkYppPlIdHga7VwmXl+vmtPjyM6LFf
 1z+x0ANRbG42v890yPBEo1xk4vTsYRGGkW32OywP7V+XIpre7IcSObVkffBou48NAgC2
 w3mteCplOJURgk/qMcKk8hf5m+axsQ6DG3TJUjCNAKnYzqIe8ftayxRlHWi61TAJhdTg
 /SslRKuiK7PpL5QhIDuj/wPrdoKbtXhEqVhN+0zjcNQ0JpT+K+XJfGxCfJMqeOCVgWyQ
 XYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787820369; x=1788425169;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o8gAehL94WGGN1MYx9UOXC1P0U6rV2eAzOiDC442g08=;
 b=Bk3qgkyOElDOQk6X7IkH1WOcYR+ThFlN0RamaNC8OSTsJimFAgehWeVw1pTkM1SYV3
 /4suh9TRg4P2b3zTknZy3xBLCDyBCJccV4RvhlKU5Ga4LZ6F0Csb9mW3s16K3B/dVNrw
 QBVEVQGC4GvbF/+jfw3xVfTZC5PecWWur0zlBJT0CKrSEmx1dl0E/HH9Wt9pu2SANbJh
 pUKBA1FuTtwI0boxgC/nGPnvyCj3P+KyAo9ioSCcpRQogW8tRm2X1JOK7AZKnUfQd3uo
 SIbDepjENW+/8w+Wo71xmajxO+ErMcUG8qqjzwGX/yRo91jIojeMF7RqLgAi83wx7LHS
 6Ybg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvDOzRYE/7LbKa4tNFV0G5YWCUjb1IMkZsYXmAHjWKm1WJpPxJLUFPtOZW4r7zPAb8FpS4PtqBnaJk@nongnu.org
X-Gm-Message-State: AFuF++lVejSynXpVhNbQ0idHkkV2jVTzmfj+J1AAjWLXZiZlgQIrfsT7
 uLS1oH+Hl6ISllJCIPN6CV/GIXlk29JckR09D6IKlT5Olx7D3nSP3EIDn8H6lWopVm9ShJyYmhr
 JkuLwIhBH1gyVo4ieowrC2YkV/c5M5Gfltkku6NaUFcaVp0ngYu3c2hIufg==
X-Gm-Gg: AR+sD13AjjgPrz1GAOA1Ge5kNihswiUUoLCB1jGvfKWLfS3cT+nVigSZS3qPIQBJx53
 Rd7Z66qv9gV+vgEftIXGQcg/GuaR8CIZoboYzlq1k5KLxcSNHGjxhdWB1Wc4jUgJcFOPfqCYPMK
 4Q3uv11WSgXC0+UOHYexzX0flc9iWmG13f278woJKGmKq1Z/VoC5uMGfBOyfRqGDCUOQ28h9oex
 O6oB/70B3Qr0XL7E6rALZqhruvYPMiKegYb1/lwOAyrgAoLvcWxaEpDdMzhhlcXnLasVrFUA2Qm
 H+HJVBHEK7zEf858j/jSgXLittD02Gbzfrx+KmEBLZTlsvZC6oJMScLw3LMgy8ODS6wH7HsBo5H
 cS7oa4qU79pZButTVWYF1go3IwVogJwT34k0jFZAi2djL9ng9
X-Received: by 2002:a05:622a:5a19:b0:51c:2022:cef5 with SMTP id
 d75a77b69052e-52e42344bd3mr159220951cf.26.1787820368660; 
 Thu, 27 Aug 2026 01:46:08 -0700 (PDT)
X-Received: by 2002:a05:622a:5a19:b0:51c:2022:cef5 with SMTP id
 d75a77b69052e-52e42344bd3mr159220721cf.26.1787820368316; 
 Thu, 27 Aug 2026 01:46:08 -0700 (PDT)
Received: from [10.254.188.74] (164.170.88.92.rev.sfr.net. [92.88.170.164])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4d08d86dsm33940955e9.12.2026.08.27.01.46.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 01:46:07 -0700 (PDT)
Message-ID: <d12e77d8-e9a8-4a79-a952-06853b7162e7@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 10:46:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] edk2: rename risc-v firmware builds
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv <qemu-riscv@nongnu.org>
References: <20260824164751.1700783-1-kraxel@redhat.com>
 <20260824164751.1700783-7-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260824164751.1700783-7-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 43jdDN2ciC3swkPZg9llyvwgiDPjixbw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3MSBTYWx0ZWRfX1n5R80hpDiLf
 L0UKjXL6gmpgDj/1yZ18/lMyc5BhwOfQDu5zNhGgbWXGr4bcjpWnMnFeBTSgRFTFab8eF7rE5cu
 xBG5hMOnHUveCducZscZ1qb+GmlCsZ4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3MSBTYWx0ZWRfX7BqYxxn0v5td
 Nre1AlPlrLTnxIkBUAI580P43hGHgtqpM6DhF4tyOfjARO2ntB+zTiGhLMcxEspAud0f0uH0CKH
 GKuSMei4z3jZycvQYxGWbKs0S+Q0HSYyy5o3rY0E6JYlpmxjAuLOuo87Oq5AroZzJ6D/0Gv8YeG
 Q63ZbFx3zn6R6UuLjAgFkNAPbH1g/8MzQ+OWzzgM2IviMMATShBJ4AOh4hBa6gz/Z3e58T9W9EC
 SEp4eIZUfE+Appi7/t9Uo4uZZfKRLInN6byi/ieW2PX5MhSaSa3BiBIZVS3NjzYTE0YJ2rdMixm
 0MfdLviTjjQ/DkdgF5/E9EuyRPohuo2Aa+NEJcTNZ5W+44wL53Bl8VE333+jkTASqaT0Ri86Oxq
 ijaKi2iWB52dSUwNMSlVl0PhV1jApjGzSRpvoQgxUecOjRYz+i+akq3IENswQgXeGl3qRcb1wxx
 DVPaM4FWWSbbVxEH+tw==
X-Proofpoint-GUID: 43jdDN2ciC3swkPZg9llyvwgiDPjixbw
X-Authority-Analysis: v=2.4 cv=SomgLvO0 c=1 sm=1 tr=0 ts=6a8ff951 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=T/Q9W4kDmp1FI4VDxy1skw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270071
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

On 24/8/26 18:47, Gerd Hoffmann wrote:
> 'riscv' => 'riscv64', for consistency with the other
> architectures which all have '64' in the name.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   tests/qtest/bios-tables-test.c                      |  12 ++++++------
>   pc-bios/descriptors/60-edk2-riscv64.json            |   4 ++--
>   ...2-riscv-code.fd.bz2 => edk2-riscv64-code.fd.bz2} | Bin
>   ...2-riscv-vars.fd.bz2 => edk2-riscv64-vars.fd.bz2} | Bin
>   pc-bios/meson.build                                 |   4 ++--
>   roms/edk2-build.config                              |   8 ++++----
>   6 files changed, 14 insertions(+), 14 deletions(-)
>   rename pc-bios/{edk2-riscv-code.fd.bz2 => edk2-riscv64-code.fd.bz2} (100%)
>   rename pc-bios/{edk2-riscv-vars.fd.bz2 => edk2-riscv64-vars.fd.bz2} (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

