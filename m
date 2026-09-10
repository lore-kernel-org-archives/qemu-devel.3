Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA22C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 01:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4pfI-0000FW-VB; Thu, 10 Sep 2026 21:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4oB4-000622-6h
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:27:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4oB2-0002tr-3k
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:27:33 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ALUCSN2034252
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 23:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z4vaNDyX9O+JUnMV7/3q9pIyHMFeddET1m4YsRGhATU=; b=V/FWHo8mEfsYhCC4
 8jlf8ua+cvRZ+OrItG7A82GC9fhDkKLzSy8XhSVHWVbCTlaihG8JdfaNaTR5Fn0T
 xAfW3qVkk7rzTQ9vcydLzx5iLFq3+MO4BupjxBrdE1h4Jgh2V1oHjv+J5xv1lsme
 LRMi7qMNOqsMroVpUwwQHZ/KBb1EvJZXDvdzSjFoAain4aqZOEEdleSIohDDwj63
 SRqGql37TiypQxax1JNhgGma4O003owBhZBh60uxFEehyDnwcjhMDJsIC//eEMwm
 uSsyWuSy2JbVVW6sbVDaI1Om4Nf/BwFAqsnHcrKUoVXsRIHrAzmT5zUtZc0Y7FXP
 UUVEzg==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm1k290k4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 23:27:30 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-6c0d7a44f35so294505eaf.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 16:27:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789082849; cv=none;
 d=google.com; s=arc-20260327;
 b=OjrvICKZojPq2G5xW8tkgDYAhXHkECPCjcZbIXRh+XasTs8RmhTJxTV8u3OkjTxNlr
 OsjnJYf5r9RraPwC74OPkH4uMmx7JD0eavWWG5vbOaohr13vx8c/kiA805vt/jzXE6Ow
 D5fYYJGs4JOOrLJsh+2rEwYUiiOwLCIbZCy22LsUjTCvzhFekDYMeIs+32tn1he5w7E0
 nRdtg2o1OSOM+Pn+y+e+ZZSnwAvy9FRIXufUbTwECm/d8q5CrfkAya7CoTH+nxyPz1sJ
 ldu25wdaDWfMdukHdy8rYww8OrafXKqne+3q1e7GwMkVisnvgvW7CqXNzLxe2GeNLYg0
 s0fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=z4vaNDyX9O+JUnMV7/3q9pIyHMFeddET1m4YsRGhATU=;
 fh=qg98UZd52pNVEuj/ZQwsxHLtQgNBn3+BQsxmg45i5+I=;
 b=kiKERSA9fpRw0IU25oGHwpBPdYT4RVfqGiDoP5892YrGGwBOgdWzz/1T6rIMMDJepe
 cd3L1EDSuMBGS8YGgZuh/5di07oWYWyvL0/zmZMA68v1M33M/ajTtHc9kiqUWdjLAkLP
 plz1e8aJSh8ljk8kNwDF7fhtMqpMUuWJgSR48bisYm/w/LmIKFPxd7Ku4ntgf5qMiQT4
 gSK0dFXbvCiY2j8pEAtzsbI+kHE9TV2a6o8BM8AlsTMkB/9q3iOxylxqxSehzMilSPn8
 VLpLj7EQysbKXTedbyGzW0Ivzzwu3iPYvIoNm6aPpbYAjyOR3XBWMaal9gSlnBuKBCCp
 AmkA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789082849; x=1789687649; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z4vaNDyX9O+JUnMV7/3q9pIyHMFeddET1m4YsRGhATU=;
 b=KrxC05RcJaxQn38Fo8umNWXlg90MYtAvW3AnTqIPLAJuK2urND4JGciwbOmoFi0RMY
 GIdpvuwV5RBA0ZapvjB3wFO9VM0F91XVLcGJTmY/J5BWNWlloI65rBemewNSz4Xa7WHp
 UsJxQfZGdDjRKNEzqKKLiHFx9xqy54rGOlOz3Ts7zKy7NK42x+7uj4/BrlEbJu1zykH7
 GqR1j5Z9VQnQSYwlJCvvzBZKfKeuJh34RAXMj6qrLdkre2AdHMI/ZML4KaiwbjvysUNn
 nH4t1UVqFA8SXoD6wdDXghchJPF3U0/objae8bee7dOtQ8B4ZerbNQc2mkyDowuxoKc7
 HIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789082849; x=1789687649;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z4vaNDyX9O+JUnMV7/3q9pIyHMFeddET1m4YsRGhATU=;
 b=HnhgV6vwsatSQ8mXaJVaOq9N7UO6U4E8Bb8jOKZswegmUJ0Mgzcyt0s8l2HE6fvIFe
 3x0Foc2tDDwCW22H6mXkapQzPb9VI4+e+1XU3zgUuIJqneO7gxob+HFecY6KWvhO9ZkI
 OG6L0JQpikUx/fLv61nVwjMjqzvIn0cyCKuqbHx9NvOoFJp4/BCVN72VNbPI24peuwVM
 Find0XBlF0o27h3dhwLHP5N99kAyVlOgeEqoDXIpO83TEry80aLZDs/aQQjyZpHPxohe
 d36CU4XPS9ttfsJn//AjU8t26wQKM1VAbg7Hype65JmoA1I94ACElaERE2gP7you0QNM
 BxkQ==
X-Gm-Message-State: AFuF++nl7n2lKRqXOlWnOrzNddLSS9DnAZfhhMQ1yltBPGZwgtU1b39j
 wcLvSCK93NdpqCnYgKUAGew3JW6WFwU0szG6cp0c5x47QYCnGluABUhTVWoLS57VAESXI4V6C3F
 jSnyYfAOf7h/YghX2yywfzUSNUfRf/aCDpCIW2ACxmeM/ftMtuCtScmgPCXThN9/r7E2aI/hSOV
 eELNZDYu4ODLi2eaB+QEycVMjtzNt4kdYk
X-Gm-Gg: AYBFou21CamMsFYT3nlBfiKMfuRUXPPEc3EtImSoaLJ7ojvByPUcbmDmG9VwcxytH5o
 7y1iBKLwXgzNw/u21ZA8KjPksL40hd4BSKj1gWtDNTTvmRGkenS4uY9vqGdZL6V7PoyOzxPmxvQ
 zEgIEmHonV5tkghCfHqmhjCT9T5iLjajnFN1CwnUNWIvwwAVqBZErXznmECY3TFkgAbjJpC3St6
 LO0RW+AOZZk3udqiA==
X-Received: by 2002:a05:6820:c44c:10b0:6be:6f42:3a86 with SMTP id
 006d021491bc7-6c0bb8f67bemr671314eaf.47.1789082849382; 
 Thu, 10 Sep 2026 16:27:29 -0700 (PDT)
X-Received: by 2002:a05:6820:c44c:10b0:6be:6f42:3a86 with SMTP id
 006d021491bc7-6c0bb8f67bemr671305eaf.47.1789082848966; Thu, 10 Sep 2026
 16:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260910153221.1674285-1-brian.cain@oss.qualcomm.com>
 <20260910153221.1674285-8-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260910153221.1674285-8-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 18:27:17 -0500
X-Gm-Features: AcwNN1X6SAyKINdpdYrC1_c7rqgK_iHXUWOOljQnccveufK4q-E_RywT6a4kE7Y
Message-ID: <CAJ+KCYMm3KSVDX=HTT4uu=X5wpDFuPsM49ooDggjO_b7=XADeQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] target/hexagon: move the HVX register file into a QOM
 object
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=cM11IVeN c=1 sm=1 tr=0 ts=6aa33ce2 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=6Nm4WbyXsb_ODJfPrFsA:9
 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-GUID: CvMLraLaR43XWGlDo_bbXe5SNiMbS_9P
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDI5NSBTYWx0ZWRfX/9x2gAa538zr
 8qyDCEW1Qlz6CWh5jpIkm1dkNWigl+6AK9OMz3LEwkdWsVwwsTsX8AH9ymc/RXVqZ+SCACfJw3v
 xTXM7bJ3blmF1cbgZ1Vuubrvr/VmACU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDI5NSBTYWx0ZWRfX9xN9G4FEWmBK
 loI+dbpBIBurmwj0yADkTS12zyomYsJU6stoZVcQtr+MgwcOPwc/ucbvkAvTBZufOElHD7H4/2P
 rKYAo7ioW/nmJkG/lzWtFJUIFdr+fFutAYZMPgWLNYn8bO3Ot/FjKufrtk18uUP3Sqr7f9CmGDj
 7EG47qymfDvxeLYIwy1vAmDAh1GbEjgBXvaDrFcwGYyQL7budvdh8SXf2kq5/XBMXb8AQHq7/S8
 26CgV87lQJHuZFUt3U2yqica2R0rObP228ODwzji8DELnMuXFIu/d2tnjfBPFCn5RuIP/+1P1Vw
 y0ULZDjCFXOy7jJMm7qdmhI3WIwk9SHYBpdybFbReeNcfZN3BePNPY0gs2n09SmjXZjrEHBQDp7
 5iAEGfUKOlxAHaBj5zo+HY9rrf/SyCszBgQxd8GYnsuh6QfaehYqncqQb5XHMgs6OFHa0aJuAmW
 XwKRsJ1GiRX0ITS6uzQ==
X-Proofpoint-ORIG-GUID: CvMLraLaR43XWGlDo_bbXe5SNiMbS_9P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_07,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100295
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Thu, Sep 10, 2026 at 10:32=E2=80=AFAM Brian Cain <brian.cain@oss.qualcom=
m.com> wrote:
>
> Each DSP ordinarily has fewer HVX contexts than hw threads.  The thread's
> SSR:XA selects the one it's bound to.
>
> Add a hexagon-hvx-context device holding the register file.  The machine
> creates as many as the config table specifies, linked to every vCPU.
> The CPU picks among the links at run time.
>
> The linux-user side keeps one context per CPU, w/o need for a device.
>
> SSR:XA is not consulted yet, the CPU always uses context 0.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon.h             |  1 +
>  include/hw/hexagon/hexagon_hvx_context.h | 27 ++++++++
>  target/hexagon/cpu.h                     |  9 ++-
>  hw/hexagon/hex-subsys.c                  | 36 ++++++++++
>  hw/hexagon/hexagon_hvx_context.c         | 83 ++++++++++++++++++++++++
>  linux-user/hexagon/cpu_loop.c            |  2 +-
>  linux-user/main.c                        |  3 +
>  target/hexagon/cpu.c                     | 19 +++++-
>  hw/hexagon/meson.build                   |  1 +
>  9 files changed, 175 insertions(+), 6 deletions(-)
>  create mode 100644 include/hw/hexagon/hexagon_hvx_context.h
>  create mode 100644 hw/hexagon/hexagon_hvx_context.c
>
> -#ifndef CONFIG_USER_ONLY
> +#ifdef CONFIG_USER_ONLY
> +    HexagonHVXContext hvx_ctx QEMU_ALIGNED(16);
> +#else
> +    HexagonHVXContextState *hvx_ctx[HVX_CONTEXTS_MAX];
> +    HexagonHVXContext hvx_fallback QEMU_ALIGNED(16);

Why is `hvx_fallback` needed?

