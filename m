Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10BBC282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 07:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpMfq-00067F-7U; Tue, 04 Mar 2025 02:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=B2sr=VX=kaod.org=clg@ozlabs.org>)
 id 1tpMfd-0005xK-1t; Tue, 04 Mar 2025 02:26:29 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=B2sr=VX=kaod.org=clg@ozlabs.org>)
 id 1tpMfX-0007E9-La; Tue, 04 Mar 2025 02:26:27 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Z6S0V13yLz4x8P;
 Tue,  4 Mar 2025 18:26:18 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Z6S0Q0y3Vz4x3q;
 Tue,  4 Mar 2025 18:26:13 +1100 (AEDT)
Message-ID: <d15c851e-355c-4abf-a97b-63df517b31be@kaod.org>
Date: Tue, 4 Mar 2025 08:26:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/23] docs/specs: Add aspeed-intc
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250303095457.2337631-1-jamin_lin@aspeedtech.com>
 <20250303095457.2337631-24-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250303095457.2337631-24-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=B2sr=VX=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/3/25 10:54, Jamin Lin wrote:
> Add AST2700 INTC design guidance and its block diagram.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   docs/specs/aspeed-intc.rst | 136 +++++++++++++++++++++++++++++++++++++
>   docs/specs/index.rst       |   1 +
>   2 files changed, 137 insertions(+)
>   create mode 100644 docs/specs/aspeed-intc.rst
> 
> diff --git a/docs/specs/aspeed-intc.rst b/docs/specs/aspeed-intc.rst
> new file mode 100644
> index 0000000000..9cefd7f37f
> --- /dev/null
> +++ b/docs/specs/aspeed-intc.rst
> @@ -0,0 +1,136 @@
> +===========================
> +ASPEED Interrupt Controller
> +===========================
> +
> +AST2700
> +-------
> +There are a total of 480 interrupt sources in AST2700. Due to the limitation of
> +interrupt numbers of processors, the interrupts are merged every 32 sources for
> +interrupt numbers greater than 127.
> +
> +There are two levels of interrupt controllers, INTC (CPU Die) and INTCIO
> +(I/O Die).
> +
> +Interrupt Mapping
> +-----------------
> +- INTC: Handles interrupt sources 0 - 127 and integrates signals from INTCIO.
> +- INTCIO: Handles interrupt sources 128 - 319 independently.
> +
> +QEMU Support
> +------------
> +Currently, only GIC 192 to 201 are supported, and their source interrupts are
> +from INTCIO and connected to INTC at input pin 0 and output pins 0 to 9 for
> +GIC 192-201.
> +
> +Design for GICINT 196
> +---------------------
> +The orgate has interrupt sources ranging from 0 to 31, with its output pin
> +connected to INTCIO "T0 GICINT_196". The output pin is then connected to INTC
> +"GIC_192_201" at bit 4, and its bit 4 output pin is connected to GIC 196.
> +
> +INTC GIC_192_201 Output Pin Mapping
> +-----------------------------------
> +The design of INTC GIC_192_201 have 10 output pins, mapped as following:
> +
> +====  ====
> +Bit   GIC
> +====  ====
> +0     192
> +1     193
> +2     194
> +3     195
> +4     196
> +5     197
> +6     198
> +7     199
> +8     200
> +9     201
> +====  ====
> +
> +AST2700 A0
> +----------
> +It has only one INTC controller, and currently, only GIC 128-136 is supported.
> +To support both AST2700 A1 and AST2700 A0, there are 10 OR gates in the INTC,
> +with gates 1 to 9 supporting GIC 128-136.
> +
> +Design for GICINT 132
> +---------------------
> +The orgate has interrupt sources ranging from 0 to 31, with its output pin
> +connected to INTC. The output pin is then connected to GIC 132.
> +
> +Block Diagram of GICINT 196 for AST2700 A1 and GICINT 132 for AST2700 A0
> +------------------------------------------------------------------------
> +
> +.. code-block::
> +
> +   |-------------------------------------------------------------------------------------------------------|
> +   |                                                   AST2700 A1 Design                                   |
> +   |           To GICINT196                                                                                |
> +   |                                                                                                       |
> +   |   ETH1    |-----------|                    |--------------------------|        |--------------|       |
> +   |  -------->|0          |                    |         INTCIO           |        |  orgates[0]  |       |
> +   |   ETH2    |          4|   orgates[0]------>|inpin[0]-------->outpin[0]|------->| 0            |       |
> +   |  -------->|1         5|   orgates[1]------>|inpin[1]-------->outpin[1]|------->| 1            |       |
> +   |   ETH3    |          6|   orgates[2]------>|inpin[2]-------->outpin[2]|------->| 2            |       |
> +   |  -------->|2        19|   orgates[3]------>|inpin[3]-------->outpin[3]|------->| 3  OR[0:9]   |-----| |
> +   |   UART0   |         20|-->orgates[4]------>|inpin[4]-------->outpin[4]|------->| 4            |     | |
> +   |  -------->|7        21|   orgates[5]------>|inpin[5]-------->outpin[5]|------->| 5            |     | |
> +   |   UART1   |         22|   orgates[6]------>|inpin[6]-------->outpin[6]|------->| 6            |     | |
> +   |  -------->|8        23|   orgates[7]------>|inpin[7]-------->outpin[7]|------->| 7            |     | |
> +   |   UART2   |         24|   orgates[8]------>|inpin[8]-------->outpin[8]|------->| 8            |     | |
> +   |  -------->|9        25|   orgates[9]------>|inpin[9]-------->outpin[9]|------->| 9            |     | |
> +   |   UART3   |         26|                    |--------------------------|        |--------------|     | |
> +   |  ---------|10       27|                                                                             | |
> +   |   UART5   |         28|                                                                             | |
> +   |  -------->|11       29|                                                                             | |
> +   |   UART6   |           |                                                                             | |
> +   |  -------->|12       30|     |-----------------------------------------------------------------------| |
> +   |   UART7   |         31|     |                                                                         |
> +   |  -------->|13         |     |                                                                         |
> +   |   UART8   |  OR[0:31] |     |                |------------------------------|           |----------|  |
> +   |  -------->|14         |     |                |            INTC              |           |     GIC  |  |
> +   |   UART9   |           |     |                |inpin[0:0]--------->outpin[0] |---------->|192       |  |
> +   |  -------->|15         |     |                |inpin[0:1]--------->outpin[1] |---------->|193       |  |
> +   |   UART10  |           |     |                |inpin[0:2]--------->outpin[2] |---------->|194       |  |
> +   |  -------->|16         |     |                |inpin[0:3]--------->outpin[3] |---------->|195       |  |
> +   |   UART11  |           |     |--------------> |inpin[0:4]--------->outpin[4] |---------->|196       |  |
> +   |  -------->|17         |                      |inpin[0:5]--------->outpin[5] |---------->|197       |  |
> +   |   UART12  |           |                      |inpin[0:6]--------->outpin[6] |---------->|198       |  |
> +   |  -------->|18         |                      |inpin[0:7]--------->outpin[7] |---------->|199       |  |
> +   |           |-----------|                      |inpin[0:8]--------->outpin[8] |---------->|200       |  |
> +   |                                              |inpin[0:9]--------->outpin[9] |---------->|201       |  |
> +   |-------------------------------------------------------------------------------------------------------|
> +   |-------------------------------------------------------------------------------------------------------|
> +   |  ETH1    |-----------|     orgates[1]------->|inpin[1]----------->outpin[10]|---------->|128       |  |
> +   | -------->|0          |     orgates[2]------->|inpin[2]----------->outpin[11]|---------->|129       |  |
> +   |  ETH2    |          4|     orgates[3]------->|inpin[3]----------->outpin[12]|---------->|130       |  |
> +   | -------->|1         5|     orgates[4]------->|inpin[4]----------->outpin[13]|---------->|131       |  |
> +   |  ETH3    |          6|---->orgates[5]------->|inpin[5]----------->outpin[14]|---------->|132       |  |
> +   | -------->|2        19|     orgates[6]------->|inpin[6]----------->outpin[15]|---------->|133       |  |
> +   |  UART0   |         20|     orgates[7]------->|inpin[7]----------->outpin[16]|---------->|134       |  |
> +   | -------->|7        21|     orgates[8]------->|inpin[8]----------->outpin[17]|---------->|135       |  |
> +   |  UART1   |         22|     orgates[9]------->|inpin[9]----------->outpin[18]|---------->|136       |  |
> +   | -------->|8        23|                       |------------------------------|           |----------|  |
> +   |  UART2   |         24|                                                                                |
> +   | -------->|9        25|                       AST2700 A0 Design                                        |
> +   |  UART3   |         26|                                                                                |
> +   | -------->|10       27|                                                                                |
> +   |  UART5   |         28|                                                                                |
> +   | -------->|11       29| GICINT132                                                                      |
> +   |  UART6   |           |                                                                                |
> +   | -------->|12       30|                                                                                |
> +   |  UART7   |         31|                                                                                |
> +   | -------->|13         |                                                                                |
> +   |  UART8   |  OR[0:31] |                                                                                |
> +   | -------->|14         |                                                                                |
> +   |  UART9   |           |                                                                                |
> +   | -------->|15         |                                                                                |
> +   |  UART10  |           |                                                                                |
> +   | -------->|16         |                                                                                |
> +   |  UART11  |           |                                                                                |
> +   | -------->|17         |                                                                                |
> +   |  UART12  |           |                                                                                |
> +   | -------->|18         |                                                                                |
> +   |          |-----------|                                                                                |
> +   |                                                                                                       |
> +   |-------------------------------------------------------------------------------------------------------|
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index d7675cebc2..f19d73c9f6 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -38,3 +38,4 @@ guest hardware that is specific to QEMU.
>      rocker
>      riscv-iommu
>      riscv-aia
> +   aspeed-intc


