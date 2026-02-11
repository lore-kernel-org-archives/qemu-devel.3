Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEEDE9E2FB
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 12:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq93F-0007ys-K3; Wed, 11 Feb 2026 07:10:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vq93D-0007v7-2J
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 07:10:35 -0500
Received: from 1.mo552.mail-out.ovh.net ([178.32.96.117])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vq93A-0004qM-EM
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 07:10:34 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.43.177])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4f9y1b5CzBz5vqb;
 Wed, 11 Feb 2026 12:10:27 +0000 (UTC)
Received: from kaod.org (37.59.142.97) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 11 Feb
 2026 13:10:26 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0024cdb55b5-40a3-4a5e-8c68-072e0e0ebb55,
 3A8D629C33260B61B1BB8F65C34560168E726884) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <64835c35-cab5-4ead-b94c-66f527ee2efb@kaod.org>
Date: Wed, 11 Feb 2026 13:10:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] tests/functional/arm/aspeed_ast2600: Enhance OTP
 test with functional validation
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaeluno1@gmail.com"
 <kaeluno1@gmail.com>
References: <20260211052326.430475-1-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260211052326.430475-1-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG13EX2.mxp5.local (172.16.2.132) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: 735c0af4-3778-4538-8e4e-bd8912c90eae
X-Ovh-Tracer-Id: 8192892147810470901
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFsMF2/ZQ5gxs1/YVFkwlqE+t77dJBB7DI0vFAg/XZc3oohs9l7fhbw0Z49We/oEkW1wz8DJRJw+xcTsuYmV0VghcxlDA65fmXluruU8ttOdN0skx4vre5b7JA6DjIsiQpyymTsHOfZh2nkoY2/KWoqr7I0m221x1kHbZcBLwojELYzSFnRbNnIVBquuM8urqZvN4u9Rm05YYInbiiiJVHZu+q8uePCprYzU13Fik3e6CQKiRAi51Awu7UQnREewxe+2ArWucDd8OHjGekf7xS/Xae99yNsyFB/Fdd8aIj4tgJ8zTLe7JIQEgJqdKthzrifFzp58yCw9PRHZU2SGGAlRX+XFIA23Y49FQbvCDAHFrSVU1mXitqwBlLKMc1aRkNh9p63Q5Q2L/YS7OODv/4fwnMk8oZleHvgCCKnaOp0fv0jXtyv+coE42KlRtjqlxmJ11hCirS77fFf011Cc/zVt/+Wrzo3IBxKlQABJlgDtmTVlKm4sTTxm284wimddtb6Q72ZVVGsc1HB6LSxhrKk9iORDLaexmPEQOFjVKYZH6KpsWn28at2Ehi0ApJF8S5yb+fho19/H41e7WMziWYyZAzZR5LNoVWyEQLzuTjrDaIhwm5vZqEJpTh5R/yBYFq/tzcuPm8s/dRDRIGWLgKQEBTsuImRLF5xHVU6H1DvIg
DKIM-Signature: a=rsa-sha256; bh=W9N7e/MlDr3OWUqQCkoIp+H2NW1z4gxiZOI5W+Zzvyw=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770811829; v=1;
 b=jsMa+HedT4tVCJmkCU+fkeFkZ7Lk7IHZDaTrUDhlXnOipa/1qZ5+JX9eqQtgpYpipN0ZrpU0
 uM90BHQxL3i6t8P/FteAsNaMX8y29AdQ+TjTeh73KkjQ2pUKRlaJjF7QyiCpMwiF/jRI1MQmvys
 7gXTbN0u8Ball9fkVTZqTAOos39yJSUMJqZhPBDnhM/u53yVMRkWYsYDu8NBfA7SMPY4OgzviZ+
 ezMQ/TyXbc2/4otekm9pF3CT4YkGFosbxvZ7VpJQMeoks/qFV8du2b4ZRyzzOnwoL1No3xn1F1V
 yZyEiabvs1UIudSYuDjSh25sUZzyO2wfTH2OcMngDR9+g==
Received-SPF: pass client-ip=178.32.96.117; envelope-from=clg@kaod.org;
 helo=1.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2/11/26 06:23, Kane Chen wrote:
> Hi all,
> 
> This series enhances the AST2600 OTP functional test by introducing
> cross-stage verification. While the previous test focused on basic
> system boot-up, this update ensures OTP data persistence and
> correctness through various execution environments (U-Boot and Linux).
> 
> The updated test logic implements the following flow:
> 1. Boot into U-Boot and modify OTP strap settings via CLI.
> 2. Boot into Linux to verify the consistency of these settings.
> 3. Trigger a reboot to ensure that OTP configurations persist back
>     into the U-Boot stage.
> 
> Note: This series is based on the aspeed-next branch.
> 
> Any feedback or suggestions are appreciated.
> 
> Best Regards,
> Kane
> ---
> Changlog:
> v3: Restore missing blank line and move require_netdev() to the top
>      of the test function.
> 
> v2: Change title for grouping the patch
> 
> v1: Initial version
> ---
> 
> Kane-Chen-AS (1):
>    tests/functional/arm/aspeed_ast2600: Enhance OTP test with functional
>      validation
> 
>   .../arm/test_aspeed_ast2600_sdk_otp.py        | 34 +++++++++++++++++--
>   1 file changed, 31 insertions(+), 3 deletions(-)
> 

Applied to aspeed-next.

Thanks,

C.



