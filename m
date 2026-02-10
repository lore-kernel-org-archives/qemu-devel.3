Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E14BEA3F0F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 07:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vphyA-00057m-F9; Tue, 10 Feb 2026 02:15:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vphy8-00056t-Tc
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 02:15:32 -0500
Received: from smtpout3.mo529.mail-out.ovh.net ([46.105.54.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vphy5-0006Yk-Vt
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 02:15:32 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.231.70])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4f9CWd1hxsz5w7w;
 Tue, 10 Feb 2026 07:15:24 +0000 (UTC)
Received: from kaod.org (37.59.142.109) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 10 Feb
 2026 08:15:23 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S003349606d8-72e2-49b8-a129-19043621f8c0,
 013E132ABECAD38B5622F7607EFF7317793E1520) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <4f186aa6-0a17-4a98-8682-fa03ec6d7765@kaod.org>
Date: Tue, 10 Feb 2026 08:15:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] tests/functional/aarch64/test_aspeed_ast2700:
 Rename AST2700 A1 test to reduce test runtime
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260210051008.355149-1-jamin_lin@aspeedtech.com>
 <20260210051008.355149-8-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260210051008.355149-8-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.109]
X-ClientProxiedBy: DAG5EX2.mxp5.local (172.16.2.42) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: ddbadceb-b15e-451a-8aa9-2939b5808c4f
X-Ovh-Tracer-Id: 15783990796620630846
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFHiW2+7QZFsEYh77kjHA3/ZftvkdHr6WeZNYElZqP6GjNLvsSF5utcdWTsFmDVGMSEuVFoMr9ZGmKtEz6hwVbEzPDN+3DH3P1mgbDDV2UKVZnIcs3WYianbw5wkRQLe1JARrnvTvSbhmsvKoyESzSEICJNWwKIWxlPXkeEFrMJy/84jHoP6vF+UsROQO1+h6PapPo9hEC+0sGbBPasPvTHTUwIN+1+JbGTEwg4raMeRfc2g7N5vQIpNlnRaNIey+pX1th4z7r3jQ2WDJtFdkiXbORlA6OZalmDVd/dUdclqMvte5B2bL/MaDtCsO66oAfJhPQcFssbXo87jisIJOJLIp3ogti91ppy2tb4hw9mykgRIH04k21numT7Z1h196RLhsAr3nOfftg6YuXHkV7xza55MuilbZGmz1impUhKxYh3kdr0iw0DPpkiyWsRR9Ai0LWsggcGA6YBynzbS+Ys8PP1DLP0eYgE+kRw5Z80Ee/+Mq0U4x+8+qfRXUpcm4oI+Jh2b+z7gGN57PbOWfUbXs1YV3huChUdElGBjm10T2ferdmB6Ohs28HebUfWYfb4Hwp3eqLp7a2uiPW8ul4AuLHj7qBVMZf5auMdwIKgPDGxkllPWpC5Q7Eoan54+X6F+f3JWtnKL1c6+fq9XtdlqsDaK8TVfmzHeRducsz6Ww
DKIM-Signature: a=rsa-sha256; bh=xkAYScyWIlVwCYgopdeq1b7auyU1k9yed+atV05xq8A=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770707726; v=1;
 b=WzfxaYtBZO7146zS6O/3tlqvkJ0o2kuwMESkkHZLeG7uYR/P4Mp/6NaAuYmNfzapyopU2gP5
 ltpEcl2PLctgbnep+gw8RpA1Z+zU+b8QeEP8G8CjEdzt6+tkL/rt2LdKWVButNvH7HQanYZ/l4F
 t6WTYPnstgmdU399X+h/WBa1FRirGuByHAOfzOKf5Uu5CBjt/FWP9Xtp/rHzEktr58tpv1OU7HM
 2AeLYX5Ks1MdFLlzO9n2GGuu9wbWHzVtmXN7sfdwhQR5zrBDn5R04HbWsWydpP6p1aV3JBoLPIJ
 NIPHwLxIonlgx4uHB74uKD94FFVtnKjDM98fx/6XfCUTQ==
Received-SPF: pass client-ip=46.105.54.81; envelope-from=clg@kaod.org;
 helo=smtpout3.mo529.mail-out.ovh.net
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

On 2/10/26 06:10, Jamin Lin wrote:
> Adding additional test cases to test_aspeed_ast2700.py makes the test
> suite significantly larger and increases the overall test runtime.
> 
> To keep testing efficient and better scoped, rename the existing test
> to test_aspeed_ast2700a1.py and dedicate it to AST2700 A1 specific tests.
> 
> A new test_aspeed_ast2700.py will be introduced later to always cover
> the latest revision of the AST2700 SoC.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   tests/functional/aarch64/meson.build                          | 4 ++--
>   .../{test_aspeed_ast2700.py => test_aspeed_ast2700a1.py}      | 0
>   2 files changed, 2 insertions(+), 2 deletions(-)
>   rename tests/functional/aarch64/{test_aspeed_ast2700.py => test_aspeed_ast2700a1.py} (100%)
> 
> diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
> index 5ad52f93e1..b5dd674bac 100644
> --- a/tests/functional/aarch64/meson.build
> +++ b/tests/functional/aarch64/meson.build
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   
>   test_aarch64_timeouts = {
> -  'aspeed_ast2700' : 600,
> +  'aspeed_ast2700a1' : 600,
>     'aspeed_ast2700fc' : 600,
>     'device_passthrough' : 720,
>     'imx8mp_evk' : 240,
> @@ -23,7 +23,7 @@ tests_aarch64_system_quick = [
>   ]
>   
>   tests_aarch64_system_thorough = [
> -  'aspeed_ast2700',
> +  'aspeed_ast2700a1',
>     'aspeed_ast2700fc',
>     'device_passthrough',
>     'hotplug_pci',
> diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700a1.py
> similarity index 100%
> rename from tests/functional/aarch64/test_aspeed_ast2700.py
> rename to tests/functional/aarch64/test_aspeed_ast2700a1.py

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



