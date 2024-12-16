Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CFCE77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 13:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNAz4-00028P-CS; Mon, 16 Dec 2024 08:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif.lindholm@oss.qualcomm.com>)
 id 1tNAz2-000280-Uu
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 08:18:00 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif.lindholm@oss.qualcomm.com>)
 id 1tNAz1-0000W0-D3
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 08:18:00 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG7Sdua025421
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 13:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ixcO2wLBqHGC8YgPmM/l6g6j
 yheKFuiwzE+l0049XwA=; b=lTA0mwAYjBVfRg9MakQXaS0nsdyfPXUFA5CfkQt4
 RN2p4e2BHMRNsZvFGa5V2XovTKAx8tTiKOBS8NAsmpDG7dLvtgxqo+xh+B8OXqLE
 MhU32ATWJ/QAANHE4lHpgLg458V69WN8oPJpK1E8PaVRUzeK4cQLD8N5LoFPZAW7
 nkynB+manhzyiiOGnx0NqMS47Ops+UlFEGTjwCDOMK64r6zSDoOHtiKCef6lJqmY
 tgzSnR2hD639MB4+m0veXeGOcIbAkrPbMk/N4XXYQ+fh3/dpU9sz3IvRL9zGOmC1
 ELqlMC7E92UGKH4vzG0TFr9UL8CJn0Vq09nqNCqZYQ9oHw==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jfus0xdj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 13:17:56 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-6f2a2ab50f6so14099427b3.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 05:17:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734355076; x=1734959876;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ixcO2wLBqHGC8YgPmM/l6g6jyheKFuiwzE+l0049XwA=;
 b=pRLoavNNvSipv0hVTq3CmqcrB6YcW46upTD3DxhpuJI33sathgsK0WvtA+wjyJEOKu
 IFG/Hy92keSEJkQ8NVXKPQ43hZyD6VInlD8QaO+BlViQGiUs8C2aAsyfhqbNUmwiqvnx
 iCFjWK9bavQZkE1X3xxGkKEm5EoxjGWw9rNC8Yg+Xr1+LUO/Mz0gntTdQiTwQ1A1x5KM
 v+pmF/vIGaayGXH2VVOga7ZtCm+p7EUtx/Bkq2dJ5ruR71tQuGa1xis7biSzvHkio+af
 Ra9CP/uwI/GrrE3cLcu2IJlIfeNTjIgFLkX3X5TXS+bImSEIUHp79/tIn77qMGmMYUFA
 OUcg==
X-Gm-Message-State: AOJu0YxBBQF99K8M0lzhh6kvxyV2MaNJOBLgylUQhAqv8SKmjajLZtb7
 mgY7agb41v+Or0KZX0b9854wuGPWwdxzH1R0EGm/l60AIHJPEXSWnGf7oB/szmMlkCwoSBONhpG
 8JWlFri6a1wxdz6VdrSvKh9p6KjtAlxv2TD2EKX1wIeesd5MAUyMk1Y+63o/jydg4rvtipFS25m
 6MskSL5lpZSMJfSjD80QgNkrYijjuA
X-Gm-Gg: ASbGncuTBbVUN7hGqBo/0vAMrIotAcDLoXB7A1ya+HWvIVsslwYSJAfCycJL/RxNcA5
 r+bT4ofYyc08PAXjk41n3dufT0kOxoiVzNlIK8XMPhjkwlt3V1lgohHsT2JNbLOB2LNhyvdM=
X-Received: by 2002:a05:690c:7404:b0:6ef:48ac:9d0c with SMTP id
 00721157ae682-6f279b3bcacmr100265197b3.25.1734355075746; 
 Mon, 16 Dec 2024 05:17:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpWTlxBrpPOSRHPpK/tBltrycnhXxMw8rN6RpUHggltzUc3xKKtd72/kJ9BEOM1dVtTL1GNtClgUJtB/XSh8w=
X-Received: by 2002:a05:690c:7404:b0:6ef:48ac:9d0c with SMTP id
 00721157ae682-6f279b3bcacmr100264967b3.25.1734355075482; Mon, 16 Dec 2024
 05:17:55 -0800 (PST)
MIME-Version: 1.0
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213193004.2515684-1-richard.henderson@linaro.org>
 <20241213193004.2515684-5-richard.henderson@linaro.org>
In-Reply-To: <20241213193004.2515684-5-richard.henderson@linaro.org>
From: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Date: Mon, 16 Dec 2024 13:17:44 +0000
Message-ID: <CAD=n3R1rqSTEyfYy=TW=Cw35PvE6KNLn+1L3-WipVThdKWGFdg@mail.gmail.com>
Subject: Re: [PATCH 67/71] hw/watchdog: Constify all Property
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 "open list:SBSA-REF" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: xQGWe5XjMAZ_WCSlVOtADR4KLVxnz_LF
X-Proofpoint-GUID: xQGWe5XjMAZ_WCSlVOtADR4KLVxnz_LF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160112
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=leif.lindholm@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 13 Dec 2024 at 19:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

For sbsa:
Reviewed-by: Leif Lindholm <leif.lindholm@oss.qualcomm.com>

/
    Leif

> ---
>  hw/watchdog/sbsa_gwdt.c  | 2 +-
>  hw/watchdog/wdt_aspeed.c | 2 +-
>  hw/watchdog/wdt_imx2.c   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
> index 80f9b36e79..2e25d4b4e9 100644
> --- a/hw/watchdog/sbsa_gwdt.c
> +++ b/hw/watchdog/sbsa_gwdt.c
> @@ -262,7 +262,7 @@ static void wdt_sbsa_gwdt_realize(DeviceState *dev, Error **errp)
>                  dev);
>  }
>
> -static Property wdt_sbsa_gwdt_props[] = {
> +static const Property wdt_sbsa_gwdt_props[] = {
>      /*
>       * Timer frequency in Hz. This must match the frequency used by
>       * the CPU's generic timer. Default 62.5Hz matches QEMU's legacy
> diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
> index 39c3f362a8..c95877e5c7 100644
> --- a/hw/watchdog/wdt_aspeed.c
> +++ b/hw/watchdog/wdt_aspeed.c
> @@ -288,7 +288,7 @@ static void aspeed_wdt_realize(DeviceState *dev, Error **errp)
>      sysbus_init_mmio(sbd, &s->iomem);
>  }
>
> -static Property aspeed_wdt_properties[] = {
> +static const Property aspeed_wdt_properties[] = {
>      DEFINE_PROP_LINK("scu", AspeedWDTState, scu, TYPE_ASPEED_SCU,
>                       AspeedSCUState *),
>      DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
> index 8162d58afa..61fbd91ee4 100644
> --- a/hw/watchdog/wdt_imx2.c
> +++ b/hw/watchdog/wdt_imx2.c
> @@ -281,7 +281,7 @@ static void imx2_wdt_realize(DeviceState *dev, Error **errp)
>      }
>  }
>
> -static Property imx2_wdt_properties[] = {
> +static const Property imx2_wdt_properties[] = {
>      DEFINE_PROP_BOOL("pretimeout-support", IMX2WdtState, pretimeout_support,
>                       false),
>      DEFINE_PROP_END_OF_LIST()
> --
> 2.43.0
>

