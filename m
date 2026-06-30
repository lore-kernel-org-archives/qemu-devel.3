Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE97C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 14:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weZiJ-0004R8-5y; Tue, 30 Jun 2026 10:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1weZiG-0004N3-Mw
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 10:45:24 -0400
Received: from smtpout6.mo536.mail-out.ovh.net ([51.210.91.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1weZiC-0006B4-RL
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 10:45:23 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [57.128.106.70])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4gqQt204ynz82lT;
 Tue, 30 Jun 2026 14:45:13 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Tue, 30 Jun 2026 14:45:13 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.188.3])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gqQt141Khz7t8k; Tue, 30 Jun 2026 14:45:13 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 EC79C1923CE9; Tue, 30 Jun 2026 14:45:10 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S00429cb3646-372b-4002-97e7-fd4cf846f178,
 C9F07EB534A46111D337A1875201B4A1724CF27E) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <da018c65-3cd1-40f0-bc16-28551f191a84@kaod.org>
Date: Tue, 30 Jun 2026 16:45:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] hw/{block,ssi}: Fix spi-nor flash dummy byte
 handling
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Hanna Reitz <hreitz@redhat.com>, Hao Wu <wuhaotsh@google.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Kane Chen <kane_chen@aspeedtech.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, Joel Bueno <buenocalvachejoel@gmail.com>
References: <20260630135729.466264-1-bin.meng@processmission.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260630135729.466264-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 15454383599328537739
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEwjQ90nLJ8WSO3sU6rBY1jWoN5RqdBC4YtictgPSKeOzTpOHV0HXYogliSzyzw9skccflC9Uz2ePnXCH/NVaKagxAYKLikAf+1h6Wksnm/KMe4FnARmWHv7Jt3SshE13xinu5jVyrIaotzHu7WyytWU1WcsiPyr9TOTQjensbwSpyCwnjzmzCLbUJ0N0Wbl0TRoiBWyHqIzt7R3iOTv1YCsIP6LLTxZ9vMTim982v3e97l1Mzr/+LNYScIEpnN7iYVxIvfUimRvuR0Uedsx4bdIUgly3YU/ePy9eGYWmt865SpYdX194k2GzgfkmaXI43RMncNQzf+Lt1FLiZOfvSUYfHNzdpqUo8x8224bv2LZ+W/f6KdSITjFP4W004ykOaYKnodi870cQI2qRgoBc/aysYvfMVKB0EbnQO/51Qria5GSiR0rIAyiroO3VG8unmh7VeTZP5Mps7QbCXUjvOH+Azr/zP9BpLd/aHhruAiGoL4juC4+4CKmBPFO81IGhThQpCn1IGDfRtnSJBZVHgtdImHKd8nhQjfkTTHiLdJaABD6A7yg3WOXvscgnjHwCqztNFd/nHAZQAuz0Qbjo8FmVcLRVRE6U+CE6BGHqSrFcnzFwXPbH+O5bEl10CzvDCSQJ3XD7MkrJg/lWrWIf8pLmGvuCBYQwNTVjNpmh9vtg
DKIM-Signature: a=rsa-sha256; bh=0SChvd0whtSsIN+2G/Y70UK2p59QA4KpdDQAZVFUuQI=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1782830716; v=1;
 b=IfOsMAiD+lzL72587MosCXK8xCL8wxfowV+J8xzb2DGvJT63Q1RvRjnTv6XZKIPwmg4Hteek
 P+cooKaGdZ6+HEuIbz0X+O7J/dCYINQ8dvePsh81qMn3Y+7dPN8F7M3uuC/7USQ99T9TLMu8KHI
 IglUXbMFO/9S+pDlLgQBy/wKxzFxVU5VsKLihkuamNPpwCSAegr+MLXWwW86BS7dWsVQEhKs41P
 PpQzEDo63pojhvC7Uu/quu++owcWU7ZfF6OvEjNBRWoWlXs2SrNXsCRqBx5PySQDRhLmW/lPYKE
 AMa9LcOmANQ33KKvEgKzEuHSts4dL01RBiEDEwZZkUuMQ==
Received-SPF: pass client-ip=51.210.91.15; envelope-from=clg@kaod.org;
 helo=smtpout6.mo536.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

+ Joel

On 6/30/26 15:57, Bin Meng wrote:
> 
> This series fixes dummy-cycle accounting for SPI NOR fast-read
> operations across the m25p80 flash model and several SSI controller
> models.
> 
> The root problem is that the affected code paths mixed two different
> units. Flash datasheets and controller registers often describe
> fast-read dummy phases in clock cycles, while the SSI bus interface used
> by these models transfers byte-sized words to the flash. As a result,
> some paths treated cycle counts as byte counts directly, and other paths
> compensated in controller-specific ways that duplicated flash command
> semantics.
> 
> The first four patches fix the flash side. They make m25p80 keep
> `needed_bytes` as a byte count and convert manufacturer-specific
> dummy-cycle requirements to dummy byte transfers for Winbond,
> Numonyx/Micron, Macronix, and Spansion flashes. The Numonyx/Micron
> change also handles the standard-mode case where the dummy phase follows
> the address bus width for output fast-read commands.
> 
> The next patches fix controller-generated dummy phases. NPCM7xx FIU
> and Xilinx ZynqMP GQSPI now convert programmed dummy-cycle fields to
> SSI byte transfers using the bus width selected for the dummy phase.
> The ASPEED SMC direct-read path is updated the same way. The two ASPEED
> reverts then remove older workarounds that either hard-coded FAST_READ_4
> dummy behavior or snooped manual user-mode SPI streams to inject extra
> dummy cycles. With m25p80 accounting fixed, user-mode byte streams
> should be forwarded as supplied by the guest.
> 
> The final patch documents the intended ownership boundary: flash models
> own command semantics and dummy-byte consumption, while controller
> models own hardware-generated dummy phases and cycle-to-byte conversion.
> 
> Some background:
> 
> While recently working on some device modeling, I hit this issue
> again. I then realized that I had sent a fix series for it more than
> five years ago, but it never made it upstream.
> 
> This series picks up that old work, refreshes it against the current
> tree, and fixes several issues in the SPI controller models. The original
> series is available at [1]. I have tried to verify all the SPI controller
> changes by booting real-world guest software to ensure the change does
> not break anything.
> 
> [1] https://lore.kernel.org/qemu-devel/20210114150902.11515-1-bmeng.cn@gmail.com/
> 
> 
> Bin Meng (10):
>    hw/block: m25p80: Fix dummy byte handling for Winbond flash
>    hw/block: m25p80: Fix dummy byte handling for Numonyx/Micron flash
>    hw/block: m25p80: Fix dummy byte handling for Macronix flash
>    hw/block: m25p80: Fix dummy byte handling for Spansion flash
>    hw/ssi: npcm7xx_fiu: Correct the dummy cycle emulation logic
>    hw/ssi: xilinx_spips: Fix dummy phase handling
>    hw/ssi: aspeed_smc: Fix direct-read dummy bytes
>    Revert "aspeed/smc: Fix number of dummy cycles for FAST_READ_4
>      command"
>    Revert "aspeed/smc: snoop SPI transfers to fake dummy cycles"
>    docs/devel: Document SSI dummy-cycle ownership
> 
>   docs/devel/index-internals.rst |   1 +
>   docs/devel/ssi.rst             | 132 +++++++++++++++++++++++++++++
>   include/hw/ssi/aspeed_smc.h    |   2 -
>   include/hw/ssi/xilinx_spips.h  |   2 +-
>   hw/block/m25p80.c              | 146 ++++++++++++++++++++++-----------
>   hw/ssi/aspeed_smc.c            | 135 ++++--------------------------
>   hw/ssi/npcm7xx_fiu.c           |  25 ++----
>   hw/ssi/xilinx_spips.c          | 120 +++++++++++++++++++--------
>   hw/ssi/trace-events            |   1 -
>   9 files changed, 345 insertions(+), 219 deletions(-)
>   create mode 100644 docs/devel/ssi.rst
> 

Thanks for the cleanup, Bin.

Tested-by: Cédric Le Goater <clg@redhat.com>

C.


