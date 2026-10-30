Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D11F606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 01:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j9gzLfOm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IrRWGmRe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMb3V-0001pA-TL; Thu, 29 Oct 2026 21:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xMb3U-0001op-A6
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:05:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xMb3S-000608-CP
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:05:16 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TNKXJ1506071
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 01:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WW1mK7YWRhEi8nOJNc8YcXciUvp7NsDnAdrPs9VF5qA=; b=j9gzLfOmHjnEUs4z
 iHI4zCrcpqCXgp1Utgmop0ZOuSPzMt64Bc+iS1QlQoS7dwz3HR0yHby0uYO3xfzU
 YYi51qjFXlyrCHkNET5eDeko/nSaLlj1sSilzhXtN67H9rffmPaPfbrNw8QKgIuB
 yTd9Lx6IildQHq0l8VQTFZmTT+0inyRk0nwZ5EkQFIEmEx93cT5OMiezc4zNgbGo
 zarejAYFPmoYG6T+BXmS5vsuO8T21FDtzZhB30u5+M90X9CRMPqswcw4xOC2ZcVg
 yqNg4xfD56XLKg9RkmM40sNjCMx8s7U7PFgligu77oXW/OcHtZQPRK09iIeEflsl
 VVwClQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p0kcf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 01:05:11 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-83edc5c5ae9so226501a34.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 18:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793322311; cv=none;
 d=google.com; s=arc-20260327;
 b=FxWqlJs0VPur5P5OB24kckjozTF13Q0q5uYtLHGgB3MiKTwJQ+Q7W7zH5jMdaEtlO4
 za5j/Fmq7umgSBktGBCvrmoQTvNHC2tZKR/R2jOFEnBMm9aPQuHW8DbnCCibXZGDYKVw
 BUdDkBv4brqynS9CORe8h7aJDP0m5aQOOzytrtn84N//iCc+aVP4eRiNY8pirA4Su7/W
 /NIC+pJx04omApwROwGd6UBQPbRauDfq8BO/QtyZ2P/fC295aIUOB52UWd6VDLF/KMss
 HQ2vMgtbxOXarjSOZoAzNlj7vq1WDfvJhX919FJ/5Nnvz//8Rlnas7o+4tOgH9pjSKhK
 QjzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WW1mK7YWRhEi8nOJNc8YcXciUvp7NsDnAdrPs9VF5qA=;
 fh=AvdUgREFPBGnLKtDjjPes0731VMeA8MKp16N55VMDg4=;
 b=O1rnb5HkORTZOb7rgdOd52ml/0yfUV0xIrOQrA2MhxPRPYogM8kW11+9ltBe+LBOH4
 Qg2uta52EQ7kGGfmzicHgr0ylkXVla/s9giqMGaJ9/wLZlztZcVkZ+vf2FFD4JI1nEUO
 YVWrurQW5n5Tf8Tctc3+zAhvrJ2CwcnqzuiJVOtLfNs4T01hVbbhy80iNslkyQRjMFuV
 uoHQMNBlHcXF/4ctSSaz9VLhoZINqlwAiOJjY8Q62chz+qcEt5yD/CUQvyVWXsISV0Q6
 mEKd3bxX5xlXFu5z72mgUR1pnbOqrT36WdLsHih1S2NVUikyZI9IAUbVMGT3ruC0BImK
 Z1Bg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793322311; x=1793927111; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WW1mK7YWRhEi8nOJNc8YcXciUvp7NsDnAdrPs9VF5qA=;
 b=IrRWGmReWEmgfKN2iIMJ7kyvBujYuzTQkM3gJEPBvFsCxguGfp61WSyaneAk2QBduk
 vlJ/LaHr/Xu5lPETcHi+/NtF8mjlyUhmqjUhkyBUSZYWni+IMonEWlPlD0LTBU8eDT/Y
 qki0zlfazjdinxtsQ1BH+RI187SM/Lqq1ftAlchECMKF90GIYBVubgRKLk5FqoTzZhM+
 sA546ZavvJGspyuQDc2PTOYEUpaSpTIudyvC/qnOzTcot5ksur8FJwA6ZRN8lSHDOiJ0
 i9pDAickWcxi6REnfDO+OsnJ+gxoYuQXIjbHaOrYAKrlei41Rgoep0BR4AYokPERHxWF
 ZbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793322311; x=1793927111;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WW1mK7YWRhEi8nOJNc8YcXciUvp7NsDnAdrPs9VF5qA=;
 b=A1Fs8P9Sxo+/E6N1I4HC5x6Xlmf1J2mwlr2djll8TwYGP5glm/IOQnqyMJGLeonJDI
 NMoMYhdD6CJHigOwHKRYly4gEO4Gx5DP/X+R4oMux65SAdObH1Uxv6ts3UgVbQBGkJhx
 k4Z6bHFez0D0wSSiPnkO5kaWpx39lKSsTzt6R7VxennYrRll7dPXcT0AxE0Vuyx3z5Me
 5NMRVpeuzYEokRnhZUqcs6H5A0ga5vdIFDCy+n9kiJDsbodaRJEN2u9uck1MVrKt1iLr
 e3wS6e5Tq8b3dp+dHb7pmcIaYce8DzCqJY0rjIJCuUOAvivuwC8p/KbmdF4HjnJ1/MTv
 ulzA==
X-Gm-Message-State: AFq9FYIJ4NTt6X+8m36VMEg98b/uosyZQK9Ln0mBigI6G7040Ky92d6G
 DlmEvg9NY9/JIkMkmNF1y42TCgy/RfBduVwWnSR5zgJCAVVZ6MYnfV4CWmJYV1qhhnWOVLzaoNr
 CGT4+2qoGeQ09yjPf9sah0pDosAr/+emsNgdCbP65rwjWZ2ySlMtC5vg5tVflaXlKA/TbPLDlb0
 DghbjU5OheatzLI+pVZkjmdAPqgceyXL6n
X-Gm-Gg: AYBFou3Q4xCFisKrOhROCOdw4dekJvFFVVdK5+/+IV05DZxp18gC+NxJk2QcqfKkEiT
 +wln238/l7c4v6G1VWfTvmDDNpuBOxOG8qelBhUvnIZR54e8oRWjOyGV74mR051MGOegCU9z+S/
 +UMcxP8Z13O86LZsAK22/rHKDNzcWTZkHuWK1bjOgoh8akKZYb1n1UBob4nc39YDIovQgAhHA6H
 qT1JtwoyUutTMTkF9g=
X-Received: by 2002:a05:6808:2207:b0:563:c491:8b5f with SMTP id
 5614622812f47-5640de2851dmr705983b6e.47.1793322311164; 
 Thu, 29 Oct 2026 18:05:11 -0700 (PDT)
X-Received: by 2002:a05:6808:2207:b0:563:c491:8b5f with SMTP id
 5614622812f47-5640de2851dmr705966b6e.47.1793322310685; Thu, 29 Oct 2026
 18:05:10 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029230310.1632334-1-brian.cain@oss.qualcomm.com>
 <20261029230310.1632334-4-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029230310.1632334-4-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 20:04:59 -0500
X-Gm-Features: AclHuK-FXoO0OZRYgCTawcI8ezvXuQzyqr1JWZJ9ffbWWyr--TxY1AB7JoUqOZs
Message-ID: <CAJ+KCYNCFb4JjXHqi086TZjth296mzsD-zRS-zhF-JX-ENA6mw@mail.gmail.com>
Subject: Re: [PATCH 3/8] target/hexagon: add per-CPU HMX configuration
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAwNCBTYWx0ZWRfXy5kDrO0ptkR/
 8/R9YZRQFapJOnKywxF8TgvVhjheZOpUuiEn010iw0R90fTxO+SMFTs2M4geZ3WS1Wz1IZg6EK4
 OsbOlVxhQqlFiC/Ze/OOszSV6cx4YPGITEUoL4/B/z0QkEOUg3CXr1XEumynB+3wBUFxz7HcRBs
 3ivDcXax/NugYva4efn/2QfLpWZIDn2hpTPjeigunq8BpDu6JAG8l93IfJj9Vf7YVqf4zk8B+JS
 muN1v9ygqBLnTDiCUxGL4Qx3rF3WnkSHNLkW+kJzn7C3eGVquaWbOzTPpol4MJ6kTTpQi5HtEVg
 tqTYRGbeiCERCplY5xHQRz9VaoFIfDXnMniWoDl3BxmEmoC7kTB1aY+0YIoJBpn9BCWtLxL5LE9
 BdfgvyLdfBMlFssygrlsGDHnwCwQ28N0e7hYTfHvBdMsrHLK6XcpGcvJR7udVpHh+2bvX9AURfg
 /AknZpla7BkGbTb6qcA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAwNCBTYWx0ZWRfX7+hH0U2fiimf
 MI+9yuLZ2n5u+8gJ6KR/C4eo0ExFh77fqGGWaVaEkjTScrlngw9dT1SHjewIxPOFE9v2/BrT8mU
 8ySCkZmBJZnXyaY8DHbX9VJZsxZzgmU=
X-Proofpoint-ORIG-GUID: a6kpJ50qluqy9OXP3qU8WRArsKLy-TNG
X-Proofpoint-GUID: a6kpJ50qluqy9OXP3qU8WRArsKLy-TNG
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae3ed47 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=oiUj86p4EGMqR00RCskA:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300004
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 6:03=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Add HmxConfig and hmx_init_config(), which derive the HMX configuration
> from the CPU revision.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h        |  8 ++++++++
>  target/hexagon/hmx_config.h | 17 +++++++++++++++++
>  hw/hexagon/hex-subsys.c     |  7 +++++++
>  target/hexagon/cpu.c        | 23 +++++++++++++++++++++++
>  target/hexagon/hmx_config.c | 15 +++++++++++++++
>  target/hexagon/meson.build  |  1 +
>  6 files changed, 71 insertions(+)
>  create mode 100644 target/hexagon/hmx_config.h
>  create mode 100644 target/hexagon/hmx_config.c
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

