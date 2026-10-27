Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1229606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TzJb7lha;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NnOHBrV0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmU7-0004bp-Bp; Tue, 27 Oct 2026 15:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmU5-0004bb-Ot
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:05:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmU2-0000Is-Fl
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:05:21 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHoXK4036021
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 45vmp1ssoi1klKZ2hb22+gEefnvbpY9FKmBFUSpyP9U=; b=TzJb7lhaRzbHPrfB
 pxLUtuLjxtGkTpk44UXaj2yHzFCa2Bmb17y5y6FBzeU3hn40P77if6LUKI96abiS
 PREnmw1paawBOVTbF03hBkCb7iMPO2AtfFswf15dW6X2YJtoW2lqbikhCuQP7cLk
 vU6WZXcRRTU28n2xqEc4ZW8+dZdPgCTGPhxpc6IP488JfPbxQMri7HqqAqA6IIl0
 pfCR497LaKG2I6HR9cEQ8CfJftc40TeLnipZisY5cDFEYyKM3McE38LVCgDkTlgf
 03KualuHT3GY28ZXG6KmxAiIIhOXeVxsYv2A/yA1ctELMqzcltVYEfzobpgQJWfX
 E2jGTQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjyjprn72-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:05:15 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5ead18311ebso87323e0c.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793127915; x=1793732715; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=45vmp1ssoi1klKZ2hb22+gEefnvbpY9FKmBFUSpyP9U=;
 b=NnOHBrV0jgJRwN0cQzb1V/hQc69A6FHVyfqQSZ2YW8FpSiCiEsilQaj4eRbuXFljzR
 RfxEOUOY2jw7HIcE2cfVeIPk9U2Zls0r+fjWsNgk0WWNGiOvjMINp8BYVmVDXYl7BxyI
 4Qmd80Rnf19d2TW/bLjfo0sFaiMOQfVwHKNPbql04d8OsQTXw3E0qQsTalpH2UHxTUbD
 D4sqyZSRdOWcvo6cIb5O5KCxOy2g181VV8+N5Fk0Q95YO7rTuHABvqLpuwfCEvskMxd9
 0m+sLYRTuhmPlFKOoKhSYqaeThmuWRr1Ug+HC32ih1ISh7hpOwCkzGuRHyU0bNfhQXJG
 utcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793127915; x=1793732715;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=45vmp1ssoi1klKZ2hb22+gEefnvbpY9FKmBFUSpyP9U=;
 b=Op5YqvRg/1tsAttgB+aDBn/c9b21dJHER60QQVDvjTk3sNH+fhC+AsjRmWIlFyzz69
 Ff0yIMOeT3/fTtc0dPBfmCTqgHWNYxxCLs+xEAMtaMCEt1fwDiI1BjTsHF7UV7UKrbdg
 itKMGFyBAWF8EVnAEBWz5jad3930mR93hdWgYAAh1JEj4XxwxXP9nmJUZsEwKWCyYjEP
 zVWMbfih6j1yaFEOygaWqKSZ/ggFrhpQolSmNUkD5yzcTtYPoJ4xfsDyTxFurBsgCgti
 Z/5D4HY8dLXDp0AwOxhE0+PAZuANNsJyaMdRkHsQ9UkGZ/6okXkfnMzQPaHYdeldHfgi
 Tn8g==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2uYN1haSa4vpAKxuPFTAVbYddIqyI7+iz7684dIODUTP5+/ha7vRtfl7HtyORyoWQtkBp9zmz1xCU@nongnu.org
X-Gm-Message-State: AFq9FYJ/yFI0DCUc/HNkudklE31+9BuPWYmDT3HMaVAmEbuIHcpOy0eo
 N1UW8UiFvkOCHegMbV2GC05VXR/e6gYHscjfVVXkw8NabXubJEtd8gFFMj7oALhO9f5r/jyhHiq
 TZO54K03xEHTDoBBWxV3hBwdR5ghvMJ2LMU1h89yy4t55dE1lKGnb6y4xEg==
X-Gm-Gg: AYBFou3839LmSarxvGAVKvpb/k8qipvtoeECYYWVrdA14X6a2MTys6+h+GCSdXGXida
 VAbgPlf8qICt4NpdUCPw6n/WH8yARdXl0RSbAfY9dNA7kwxgvlD93uXQ5K5kNDTWt94IyFQ5vSf
 uRny/EoZ4b5z4SOiBkeuYV7Nx/6IB5jVM5X3/CqUbtagFVgqILcoXvEpLzJC7xziLGZbSBsd7vr
 eB1G/wfaKE9PMg0eD4WziykNVwyeROAH+M1d9xwbj2Jx89uU6AXbtU2obEzop+0MSN71kNV4Mp/
 ytZXH8gyWXUa3sdgI6qNRKlJ6Y6dq2x9475FESkghr7YrtGZthBxhgNAc3Pg5WWzSbjArt2O90f
 3zSe2AkC4ZzjkvK/I/qkKeqwsWRi2k1hpNyNmgUL3ePVmZya7fA==
X-Received: by 2002:a05:6122:894:b0:5ea:f220:fd6e with SMTP id
 71dfb90a1353d-5ec4cc889famr57894e0c.11.1793127914710; 
 Tue, 27 Oct 2026 12:05:14 -0700 (PDT)
X-Received: by 2002:a05:6122:894:b0:5ea:f220:fd6e with SMTP id
 71dfb90a1353d-5ec4cc889famr57865e0c.11.1793127914185; 
 Tue, 27 Oct 2026 12:05:14 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd35c2sm23993049f8f.39.2026.10.27.12.05.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 12:05:13 -0700 (PDT)
Message-ID: <1b1f25e9-89e0-422a-b72b-bfd79c3c1bac@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 20:05:12 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] rust/hw/char: add QUP GENI UART device model
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261027183823.383806-1-brian.cain@oss.qualcomm.com>
 <20261027183823.383806-4-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261027183823.383806-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3NiBTYWx0ZWRfX3KvpLqdAtLxs
 Tfby2Ytp0OvsrUt7MkuXKmRvb1g+iWhNGNsrbiYV6PTGHjXfHw9qmMgOvpdBYALMC3K+HY4ooP8
 u83sz8drRVewnrYhfDT4oj+L4UW4f572P7hmhwbBkRSob/4kUOXMk7eocjoVADItn3R7tsdDnT5
 +oaWx/CS7krq2oAhsOw9S3YHdTJWF1YRP62qMmwcTin6KiJxqSkhLboL+MPCAdnfojClYBpNA36
 /ntRDpnVhO6RYG6cVl0QbP7+v/NFJR4cRfcLEs0Bj3EKjdkzyrDC8PU0yoyD8s4//rJBftfhBhU
 sE8MUfYaPgZ3V6wHg7qBMo/fOIx/iS5geaBbLrxh+gZaA7ndf3gi+ebVI2lHbkrdv3meA7eGDwY
 3zVJ+t3yfWU7f6iv1pYdADcZ2z1SSas9aRdfPP5RB/CZFy+dgPVYRHj6sLuPyHiqXSQrmX/qQTk
 NAf6lHIXRpdxIp2h7mw==
X-Proofpoint-ORIG-GUID: la9MV5b4icHqyRAP8t0umZuO938nCaer
X-Proofpoint-GUID: la9MV5b4icHqyRAP8t0umZuO938nCaer
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3NiBTYWx0ZWRfX+J21ZI2jXT0j
 VJw2/ZXvZ2S11wJ0wC7RagLKNgoaKu7I2ZVDNb7qH84FZC+X26TCPaQoysf7K3V2iOkOpS5k66d
 yKFoMN39oakOxl0PiY8SgTzKIpVFQdo=
X-Authority-Analysis: v=2.4 cv=JodkP84C c=1 sm=1 tr=0 ts=6ae0f5eb cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=9LxoPiivgX8PBtvbXuYA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270076
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 27/10/26 19:38, Brian Cain wrote:
> Add a model of the QUP GENI serial engine in UART mode.
> 
> Supports FIFO, DMA, loopback modes - DMA via memory link.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   MAINTAINERS                                 |    1 +
>   docs/system/device-emulation.rst            |    1 +
>   docs/system/devices/qup.rst                 |   10 +
>   Cargo.lock                                  |   15 +
>   Cargo.toml                                  |    1 +
>   rust/hw/char/Kconfig                        |    4 +
>   rust/hw/char/meson.build                    |    1 +
>   rust/hw/char/qup_geni_uart/Cargo.toml       |   27 +
>   rust/hw/char/qup_geni_uart/meson.build      |   28 +
>   rust/hw/char/qup_geni_uart/src/device.rs    | 1293 +++++++++++++++++++

Too big for me to review (not sure if easily splittable), I'll skip.

>   rust/hw/char/qup_geni_uart/src/lib.rs       |    9 +
>   rust/hw/char/qup_geni_uart/src/registers.rs |  160 +++
>   12 files changed, 1550 insertions(+)
>   create mode 100644 docs/system/devices/qup.rst
>   create mode 100644 rust/hw/char/qup_geni_uart/Cargo.toml
>   create mode 100644 rust/hw/char/qup_geni_uart/meson.build
>   create mode 100644 rust/hw/char/qup_geni_uart/src/device.rs
>   create mode 100644 rust/hw/char/qup_geni_uart/src/lib.rs
>   create mode 100644 rust/hw/char/qup_geni_uart/src/registers.rs


