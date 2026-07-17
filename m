Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C97C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkfSd-0002HV-HB; Fri, 17 Jul 2026 06:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wkfSb-0002Gz-SB
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 06:06:26 -0400
Received: from smtpout6.mo539.mail-out.ovh.net ([51.210.91.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wkfSY-0006VC-NL
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 06:06:25 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4h1ltJ5sSsz3wcw;
 Fri, 17 Jul 2026 10:06:16 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Fri, 17 Jul 2026 10:06:16 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.188.54])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4h1ltJ4lQyz230R; Fri, 17 Jul 2026 10:06:16 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 889921B43DDD;
 Fri, 17 Jul 2026 10:06:14 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G0013d3d9c8a-014c-4a97-b0a4-73f3cc8d205f,
 D28FE153D5A3AE5C5EC95691E5B856C14C2CAAE9) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <177abc72-5068-4d13-bac1-037d3b7d1922@kaod.org>
Date: Fri, 17 Jul 2026 12:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] Refactor AST2700 SCU preparation for coprocessors
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260717084559.3477061-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260717084559.3477061-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 18345413085241125933
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFIDc5SN+F73DBaMt+G7q2A7bfI5EkTbuk6dDtmTxU+yX1L7wQDm4aLzH1rDUC6pF34cEQxL24goHhx3SNycYgYspQJ69CQFcj9xPTVJlyBOWTwHIdWhLe7xSP3+p1K6LIUkg7AnsvGZR8K93xXjWv+8IAAPqvtHD3BkwVu8i3XifbZdV+eaRPtdrPxqNMCnhqm8xMVEYFRT9/biEyhtg/FB7iy06s2vJHYCWMi7QlsHfK8/0oz3X8AqBDaNPuB1hodQidBT9ub8YrRAY+FGHiAFWd60vnzZ/5mUZIcmVi6NhJEdD3l+wadWBNJOWRs5Ik4Ar+3AElv/IUe+jT8A7YvBCciqjmByLmpwOxedFLfRJe4Yuest4LYaKNrmy3bcrSYjufyN1BSQfD2OOH5F6slE3vIFn4ibyWgmA93EZHb5UBaxJj23l9RUM0ZyioSEemyHL5V9UokwHai3bimsWFNwgsEqOGMcucp1RKQ6guBTaJs9OFfg0ypoJMykBxGAITmnET36DFQGlMh0HB4FU/nNA0dDizbgA4bapCSSa3OgVKA6WmO0p1qqf6EYDeeC/58WYVh+h7UMemdYeveJZI/IbCLheUwZnsbOojwQezeIgga/fIgPtO5DeNrJ8dbZwDNXVpqwITLft4VUN9FUPbfpZ2kbt0SNRbycu0XzpLbYg
DKIM-Signature: a=rsa-sha256; bh=bTq3ajt42FUZHheEM7Rh/6K9LAYzA56s2uAzcMz0vwA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1784282778; v=1;
 b=X3spGolL+Gjbw3sjrU68F98RsLrW1asliIzNyikuLr0zJGKMKIch4EShVyaICPcSZNsc1T4e
 jUFQE+ed+2mTgA+WY4luoW1kNyTb0h9OmPor6dF22f2VuNuKEd3fd0KjaAlEhL9qAjLzuVXQFyo
 d4Mez/nsGn33fGrDI8jeLpnW8IinsTOzFr7ZpuZrhFWZy1Su2YbPAAT5rPZLbzElxkB9ezgUk2U
 dTjVWsY4t8yumfLbL7SQWPukLqp8dnA1e4qIh6bfvE/VtOk3SnyP8/N8cy6YH6VKtdxRQMpGs+l
 CjPVm/pJ9ChIv1g0Nw3EfTEUnpddS1ys93W28qSNPOeVg==
Received-SPF: pass client-ip=51.210.91.45; envelope-from=clg@kaod.org;
 helo=smtpout6.mo539.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 7/17/26 10:46, Jamin Lin wrote:
> The original AST2700 FC support series [1] is fairly large, making it
> difficult to review all changes together.
> 
> To help speed up the review process, this series extracts the SCU/FMC-related
> refactoring into a standalone prerequisite series.
> 
> This series depends on https://github.com/legoater/qemu.git at aspeed-next branch.
> 
> v1:
> Compared with the original series, the SCU preparation patch has been
> split into three smaller patches:
> 
> Introduce Aspeed2700SCUState.
> Convert AST1700/AST27x0 users to the new SCU subclass.
> Move the SCU link property into the AST27x0-specific coprocessor
> implementation.
> 
> In addition, the SCUIO reset handling has been separated into an
> independent patch.
> 
> This series contains no functional changes. It is purely a refactoring
> to isolate AST2700-specific SCU support from the generic implementation
> and prepare for the subsequent AST2700 FC support.
> 
> v2:
>   1. Pass realized PSP SoC to SSP/TSP initialization
>   2. Share single SCUIO instance across PSP, SSP, and TSP
>   3. Share FMC controller with SSP and TSP
>   4. Add Data FIFO-based flash access support for
> 
> v3:
>    1. Add Data FIFO mode test
>    2. Clarify SCU/SCUIO/FMC fields are shared with PSP SoC to AST2700
>    3. Bump vmstate version after ASPEED_SMC_R_MAX increase
> 
> v4:
>    1. Fix to apply patch failure
> 
> Supersedes the following patches from the original FC support series [1]:
> 
> Patch 1:
> https://patchwork.kernel.org/project/qemu-devel/patch/20260417032837.2664122-2-jamin_lin@aspeedtech.com/
> 
> Patch 2:
> https://patchwork.kernel.org/project/qemu-devel/patch/20260417032837.2664122-3-jamin_lin@aspeedtech.com/
> 
> Patch 4:
> https://patchwork.kernel.org/project/qemu-devel/patch/20260417032837.2664122-12-jamin_lin@aspeedtech.com/
> 
> Patch 15:
> https://patchwork.kernel.org/project/qemu-devel/patch/20260417032837.2664122-16-jamin_lin@aspeedtech.com/
> 
> Patch 18:
> https://patchwork.kernel.org/project/qemu-devel/patch/20260417032837.2664122-19-jamin_lin@aspeedtech.com/
> 
> Patch
> [1] Original AST2700 FC support series:
> https://patchwork.kernel.org/project/qemu-devel/cover/20260417032837.2664122-1-jamin_lin@aspeedtech.com/
> 
> Jamin Lin (9):
>    hw/misc/aspeed_scu: Introduce Aspeed2700SCUState
>    hw/arm/aspeed: Use Aspeed2700SCUState for AST2700 users
>    hw/arm/aspeed_ast27x0: Move SCU link into AST27x0 coprocessors
>    hw/misc/aspeed_scu: Add separate reset handler for AST2700 SCUIO
>    hw/arm/aspeed_ast27x0: Pass realized PSP SoC to SSP/TSP initialization
>    hw/arm/ast27x0: Share single SCUIO instance across PSP, SSP, and TSP
>    hw/arm/ast27x0: Share FMC controller with SSP and TSP
>    hw/ssi/aspeed_smc: Add Data FIFO-based flash access support for
>      AST2700
>    tests/qtest/ast2700-smc-test: Add Data FIFO mode test
> 
>   include/hw/arm/aspeed_ast1700.h     |   2 +-
>   include/hw/arm/aspeed_coprocessor.h |  16 +++-
>   include/hw/arm/aspeed_soc.h         |   1 +
>   include/hw/misc/aspeed_scu.h        |   5 ++
>   include/hw/ssi/aspeed_smc.h         |   3 +-
>   tests/qtest/aspeed-smc-utils.h      |   4 +
>   hw/arm/aspeed_ast27x0-fc.c          |  38 ++++++---
>   hw/arm/aspeed_ast27x0-ssp.c         |  56 ++++++++++---
>   hw/arm/aspeed_ast27x0-tsp.c         |  56 ++++++++++---
>   hw/arm/aspeed_ast27x0.c             |  16 ++--
>   hw/arm/aspeed_coprocessor_common.c  |   2 -
>   hw/misc/aspeed_scu.c                |  20 ++++-
>   hw/ssi/aspeed_smc.c                 | 117 +++++++++++++++++++++++++---
>   tests/qtest/aspeed-smc-utils.c      | 102 ++++++++++++++++++++++++
>   tests/qtest/ast2700-smc-test.c      |   4 +
>   15 files changed, 384 insertions(+), 58 deletions(-)
> 

Applied to

     https://github.com/legoater/qemu aspeed-next

Thanks,

C.


