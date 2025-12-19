Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80075D78770
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdbm-0001Ts-Nj; Fri, 19 Dec 2025 11:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vWdbb-0001RW-6B
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:45:27 -0500
Received: from 10.mo552.mail-out.ovh.net ([87.98.187.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vWdbZ-00025f-7h
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:45:26 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.158])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4dXtgh3H1Rz5x8x;
 Fri, 19 Dec 2025 16:45:20 +0000 (UTC)
Received: from kaod.org (37.59.142.105) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 19 Dec
 2025 17:45:19 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G006f7628f75-cf3e-4ef4-934c-44610e89775c,
 13AF5B8175AA3308F51DC8C03696883D036152F7) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <d7c18b54-3d53-4204-8dc1-3c1bc4fe4cb4@kaod.org>
Date: Fri, 19 Dec 2025 17:45:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] hw/gpio/aspeed_sgpio: Add Aspeed Serial GPIO
 (SGPIO) controller model
To: Yubin Zou <yubinz@google.com>, <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kane-Chen-AS <kane_chen@aspeedtech.com>, Nabih Estefan
 <nabihestefan@google.com>, <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20251219-aspeed-sgpio-v5-0-fd5593178144@google.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251219-aspeed-sgpio-v5-0-fd5593178144@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG4EX2.mxp5.local (172.16.2.32) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: d097085f-bbbc-4dca-8399-cdc900165e2e
X-Ovh-Tracer-Id: 9304436832663931777
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFgoksgUP8+ymXtERTAqiaijetLKzgDiqYu1iPQB9Ru7iWmD9TYoc8mFB6XH5ZL32qPYEIoO3Iaz/fOqYZcGIvOuVfIkh/5kYvxDFA0uINmfJ6FmqvtD9ygJhIUzz6gw7/giaV5Vk0daKudaRADXjeNPuG/XAvrVVw6maLEfEEwXaF9Lh4ykXX3BVJHS5bXklnq3ABw7MxrCkb/2KXk+BAhDFHp4mu3GJO6cIjNxt6SkkdqX6LYxnMlxsRdDb4RDgeYGmlowZh1zqqCrfJtZgrIMquTWOzLgJl0rPZhSJGyDlEbUly0+NvgjcFZD1baA71sS9ceiZdZ+akOEnMyJDMHp0I1M3T8hDlUoxfMcA3TmRyXSzYx68NuVJvBPMX2OFEBTcjX7YZqRvdOfiTEOkdssxrOVfeGAy4+Q3MOGlZZvN+jMt2K7bGpTVgC+SKy9Y3/eRUfo8qAiuG4CZYXklZ0z1dm0gTr2h6b3d+B7ohOOdJI8nKsl+Z24wt6dMXY/ky1OwExW40tlOO6nuQk3/vT5T4fyYQIBNNfNnoZ6NOKX3rvHCWLGpmWYu36QtqL+sV7Z+DJablmh8V5RhQmstVQ3BFglbu+Ur6wY4RN/OTUmsmlPMTu/queqRyuGX9cbqEVF2vBfjthOQaHEsOxzRuis/F45HC4p65TxXZ4N6kPZw
DKIM-Signature: a=rsa-sha256; bh=z0g3H2Upviv+uTWy8jS8O4FeUGQp8YAm/pxa3/ZIAcI=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1766162722; v=1;
 b=IZ0l4EJ8fuJGBZiVDhnEkfnB7vbKXEA+t327mkX6n46VrdoF+Y0m7rQybgitZRTzDd9Qciv6
 o7J7uY6JKvrAp/0v+uegA86luddpwdq+18DezkaUiZ2K1CJ+ZZ8+8rvHdB+twD7a7NrgkNuazkP
 RiXSMgUYccW7biHvN/Ild2Wd/SDqaBCV4mHByQIugeB2AlbdVpsRO2YQ3WDH70Vo6HvmLSFJACM
 aN7hx9SEIuFEu3ZbMn6V4j/vh49m39a2uXYVbuDKvJqAafw6uz7Rmn9uPPagFDvrWeYwltCmj4I
 15rVg1GYjoZyhfJq+Ra6KYamqEjTJ2j7DgIapjPAna7MQ==
Received-SPF: pass client-ip=87.98.187.244; envelope-from=clg@kaod.org;
 helo=10.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/19/25 08:04, Yubin Zou wrote:
> This series introduces a model for the Aspeed Serial GPIO (SGPIO) controller,
> commonly found on Aspeed SoCs such as the AST2700. The SGPIO peripheral
> provides a large number of GPIO pins that can be controlled and monitored
> serially.
> 
> Improvement to QEMU:
> These patches enhance QEMU's hardware emulation capabilities for platforms
> using Aspeed SoCs, particularly for BMC simulations. By modeling the SGPIO
> controller, QEMU can more accurately represent the hardware, allowing for
> better development and testing of firmware and software that relies on these
> GPIOs for various functions like sensor monitoring, presence detect, and
> system control signals.
> 
> Impact (Before/After):
> 
> Before:
> QEMU lacked a model for the Aspeed SGPIO controller. Any guest software
> attempting to interact with the SGPIO register space would find no device.
> Firmware features depending on SGPIO pin states or interrupts could not be
> tested in QEMU.
> 
> After:
> QEMU emulates the Aspeed SGPIO controller on supported machines (e.g.,
> ast2700-evb).
> - Guest firmware can configure SGPIO pins, set output values, and read input
>    values through the memory-mapped registers.
> - External entities (like test scripts or other QEMU components) can interact
>    with the pins via QOM properties (e.g., to simulate external signal changes).
>    Path example: /machine/soc/sgpio[0]/sgpio0
> - The model generates interrupts based on input pin transitions, according to
>    the configured mode (level/edge), enabling testing of interrupt handlers.
> 
> Signed-off-by: Yubin Zou <yubinz@google.com>
> ---
> Changes in v5:
> - Fix logging, typo and indentation in 1/6.
> - Fix typo and empty line in 3/6.
> - Fix duplicate definition in 6/6.
> - Link to v4: https://lore.kernel.org/qemu-devel/20251217-aspeed-sgpio-v4-0-28bbb8dcab30@google.com
> 
> Changes in v4:
> - Fix indentation issue, replace SysBusDevice by SysBusDeviceClass,
>    remove unused function in 1/6.
> - Fix g_autofree usage in 2/6.
> - Switch to use  %03d in unit test, remove unused headers in 6/6.
> - Link to v3: https://lore.kernel.org/qemu-devel/20251210-aspeed-sgpio-v3-0-eb8b0cf3dd51@google.com
> 
> Changes in v3:
> - Fix commit message typo and address several review feedback in
>    commit 2/6.
> - Switch to use g_autofree and drop g_free.
> - Use "%03d" instead of "%d".
> - Link to v2: https://lore.kernel.org/qemu-devel/20251209-aspeed-sgpio-v2-0-976e5f5790c2@google.com
> 
> Changes in v2:
> Split the v1 into smaller commits and reorder it for better review:
> - Link to v1: https://lore.kernel.org/qemu-devel/20251106-aspeed-sgpio-v1-0-b026093716fa@google.com
> 
> ---
> Yubin Zou (6):
>        hw/gpio/aspeed_sgpio: Add basic device model for Aspeed SGPIO
>        hw/gpio/aspeed_sgpio: Add QOM property accessors for SGPIO pins
>        hw/gpio/aspeed_sgpio: Implement SGPIO interrupt handling
>        hw/arm/aspeed_soc: Update Aspeed SoC to support two SGPIO controllers
>        hw/arm/aspeed_ast27x0: Wire SGPIO controller to AST2700 SoC
>        test/qtest: Add Unit test for Aspeed SGPIO
> 
>   include/hw/arm/aspeed_soc.h      |   8 +-
>   include/hw/gpio/aspeed_sgpio.h   |  68 ++++++++
>   hw/arm/aspeed_ast10x0.c          |   6 +-
>   hw/arm/aspeed_ast27x0.c          |  26 +++
>   hw/gpio/aspeed_sgpio.c           | 346 +++++++++++++++++++++++++++++++++++++++
>   tests/qtest/ast2700-sgpio-test.c | 165 +++++++++++++++++++
>   hw/gpio/meson.build              |   1 +
>   tests/qtest/meson.build          |   1 +
>   8 files changed, 616 insertions(+), 5 deletions(-)
> ---
> base-commit: 917ac07f9aef579b9538a81d45f45850aba42906
> change-id: 20251105-aspeed-sgpio-1d49de6cea66
> 
> Best regards,

Applied to aspeed-next.

Thanks,

C.

