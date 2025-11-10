Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79407CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 14:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vISbk-0003VR-O7; Mon, 10 Nov 2025 09:11:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vISW7-0006Zt-Mr
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:05:12 -0500
Received: from 7.mo548.mail-out.ovh.net ([46.105.33.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vISW4-00005b-Go
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:05:11 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.134])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4d4ryk37VBz5xyk;
 Mon, 10 Nov 2025 14:05:02 +0000 (UTC)
Received: from kaod.org (37.59.142.114) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 10 Nov
 2025 15:05:00 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-114S008630e832b-99e4-4cda-aac2-ca3157944bbd,
 2CC8F654BF9A736B588295E2BFA8A60E013487DB) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <5fdca7c7-e9aa-42df-8eff-1ea45b2467ce@kaod.org>
Date: Mon, 10 Nov 2025 15:04:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/12] hhw/misc/aspeed_scu: Add AST1060 A2 silicon
 revision definition
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20251106084925.1253704-1-jamin_lin@aspeedtech.com>
 <20251106084925.1253704-5-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251106084925.1253704-5-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.114]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 7ef8ea20-cbec-4fb1-87fe-67f5ab594c7d
X-Ovh-Tracer-Id: 17369539340142807870
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFXswTJJHzhsn0abB9hdsQSmehlkPhRAADzeu9n3hXwRttC1CdG2VACr6xE2JZqK0IWt+nKeNCX6+u8oifV7mw1+MHilWh6sOZVl6Gyb7cwmQnZyfOsreTDHoRkT8v1agZn5jNuTfnBtAR8kT6Ly75WxECgsWDyTgWevpiMCTmUxCI0zHT5h5M0fd9fLb3XHhX0L/vegDptr8pPFxcJm2F1VnDxJ1WFUpwfJ+nj+zFNb90HtgPrHKlH3Vc9y+0wjqkpf7HBJiAbUBixBQoH76Mb3ehzxBRUH7NNjPj+PNLGiKfrYFZBRZqM+y4i4SEBiv+wMFLnMaSCw4d9r1jBVkW9p909xTwPQUDGH5xu+ARQqXG8pbeMydNQhm+Zwp2Ogt336YD9gaeyb9VQ9+W9qWqy7vCPIzHEkWBd9UyHjFOFRZaFqY7WwZuYv+Hkz7sgMbZ1PD/EOqIYjOjvQKpk3QK6eR3em9uFJesghp/uZrvJ2HTDu9KUXAr1ed9AWr/vIvtAZfs07EUk8eVYpayjXDlmuhFx4v6rVxA3ahiOUVrSwSBHGacCWgi6KDFwmG4MUjL67bPxbfLNvtoj+n1wtVnb9Ly1hInUO9TdrX8IRtSCvSH0zU9Tm4bZz8BNoZY9UwdnVCOKDSK5oM0ts90kMO1U5vF0fRe7x5M+EYyZLhbPgA
DKIM-Signature: a=rsa-sha256; bh=z4/ir0Iw5O6DNAtNIidU+Kijl11HHHzS3nb1xqh1sHY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1762783504; v=1;
 b=ZtThXI0DHOjHkUGcmk+58LiGB7rLe1wR7886F+q7jj42eJNWnePlmpfsvWbzRBaY20cpWBBv
 Tt8KfBL3Ct4vYuh7QoIOmX+KCcyoYuclG8Sk1b95fTx2thkHKAH1IvR5+wCGrogIpDgHABXkJba
 uCt/TTPiVSY1/F+cOjmuU+LOK0jQuXD6N74A4Z4a67FOMXtInKBAFV03sSz6Wg/T4JT8u9Ln1M9
 HPIZO5tnWS8z38n/DEl5GfFVVMsWkLnBkC+roup5n5qRKWWU34qc5ENpX7umic/kQstAogBalPb
 8cMvQNUyPzcwLRM61PNI6zbDJiPTDsjE0lPzMpNOREw4A==
Received-SPF: pass client-ip=46.105.33.25; envelope-from=clg@kaod.org;
 helo=7.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/6/25 09:49, Jamin Lin wrote:
> Add a new silicon revision constant AST1060_A2_SILICON_REV for the
> AST1060 SoC. This allows the SCU model and related SoC layers to
> identify and handle AST1060 A2 revision properly in the same way as
> other Aspeed SoC families.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/misc/aspeed_scu.h | 1 +
>   hw/misc/aspeed_scu.c         | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
> index 684b48b722..76ef8dc592 100644
> --- a/include/hw/misc/aspeed_scu.h
> +++ b/include/hw/misc/aspeed_scu.h
> @@ -51,6 +51,7 @@ struct AspeedSCUState {
>   #define AST2600_A3_SILICON_REV   0x05030303U
>   #define AST1030_A0_SILICON_REV   0x80000000U
>   #define AST1030_A1_SILICON_REV   0x80010000U
> +#define AST1060_A2_SILICON_REV   0xA0030000U
>   #define AST2700_A0_SILICON_REV   0x06000103U
>   #define AST2720_A0_SILICON_REV   0x06000203U
>   #define AST2750_A0_SILICON_REV   0x06000003U
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index 1f996d5398..300571256a 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -565,6 +565,7 @@ static uint32_t aspeed_silicon_revs[] = {
>       AST2600_A3_SILICON_REV,
>       AST1030_A0_SILICON_REV,
>       AST1030_A1_SILICON_REV,
> +    AST1060_A2_SILICON_REV,
>       AST2700_A0_SILICON_REV,
>       AST2720_A0_SILICON_REV,
>       AST2750_A0_SILICON_REV,


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



