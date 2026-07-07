Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB31C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1qC-0004Eo-3n; Tue, 07 Jul 2026 05:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wh1q8-0003zf-5t; Tue, 07 Jul 2026 05:11:40 -0400
Received: from smtpout1.mo2.mail-out.ovh.net ([79.137.123.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wh1q4-0002KS-KS; Tue, 07 Jul 2026 05:11:39 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo2.mail-out.ovh.net (Postfix) with ESMTPS id 4gvb7Y3Bn3z3wvt;
 Tue,  7 Jul 2026 09:11:21 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Tue,  7 Jul 2026 09:11:21 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.178.206])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gvb7Y14pyz7tLP; Tue,  7 Jul 2026 09:11:21 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.0])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 9601D941962; 
 Tue,  7 Jul 2026 09:11:18 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002d1860c17-9992-4d57-804a-1eeb8f4c926a,
 7260B8E4F09D2588E97168B383347FBEBF8FD1E0) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <5a5b4d33-29d8-4bc6-866a-b226c6b99f22@kaod.org>
Date: Tue, 7 Jul 2026 11:11:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] hw/{block,ssi}: Fix spi-nor flash dummy byte
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
 Tyrone Ting <kfting@nuvoton.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org
References: <20260707083431.219671-1-bin.meng@processmission.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260707083431.219671-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 14031246116435111051
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEjxG7JGwZm+cRYv3d3l68iaLwHb53xT72wpWh5/jDmYcE2ECO7k8xHFM+s+L9AePqRs725u0bM/WfEEAmJpu5sT44eN0S+bW7oX/g6m5UsLHoOpURw0ZyFvoYXEK2ReuRNCpc4xtAURWj9+VO1Ykt8vjO8JRYVaQNJUkYCgpGHqXps5LoXokKoFXnOz9G0Jf6v5aNTwlOwPr+OQhhNpI6hNDlwspimx9SECJQrV11O/CY/qTn+m4OkAi5B10sFvrZbSue+cCTX7g6A0dA3pzvXjlruYx/tKDNz/tEPBvi5hSBicfwKhWmXj9WuOlYBSA0I8jEjOaJhL/rIqKFsgxb3GgFx1Zybg6E9AU1q6osUHukr3Q64j89b5knvPy1YMQ7XqBmTHZVg+TgfPc6cmHUOneRwfo61PQbGIn543o7tejX4KJ1IqTvMrvsFv6vdTfkONbS4pH7sHI3/Qp2BWB4Bis1i6yLlL7YLph9ZJV9x1Mote7ZAJbInueJ0Ol53w53wzCj1yRFcvrTFRAt0YjuoL+Il7nq1g+ENxVFzEsfbnh4IedrYCqHLegULrHPesQ0I8YO5qbEZztPyoeITRGZRLje+NuXzEVDTZfdnr8EWoZBEiy4YTnsPJkUz3qFcuYzooiK6vV/PrlrPQVNnDLg9JeHwNNp8GQ7vOGLSnodptg
DKIM-Signature: a=rsa-sha256; bh=fSlmyQgM6t5ZVUpwB5dWXc2e9ma0CKLGZBbJvSTW/wQ=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1783415483; v=1;
 b=rdM9UezJaRa5PTpy0h9+7xjo6D+BaqaTEhqITeJXlFTaeCHQ7arRw4YhUYFzMxkjog7cILRg
 o1KwuAVWDNJ6jSsFstbDhihWrLmBoBv9zfKkgI8LG3P/CgMF4TtY5BZ1DEt0zLtTz6vTojz7Fl3
 qnIWCOAMWq1WAcy/OcTI01nOJPDwYYEio998J2E8uwNIgwZmrP5Rl9w+DOIWNCdCMul37WwUn+u
 0heNxTSa7s/N5tjyeNUnMx62JfZ6+ZbswDG10RWT7mbePNYPfiwe4PuX2DwbWVsVjk4+eaN8AhF
 36hSWgZw0Co+OpFAikLuH9qzNsraolAsd2L4RRHjHu0yQ==
Received-SPF: pass client-ip=79.137.123.219; envelope-from=clg@kaod.org;
 helo=smtpout1.mo2.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/7/26 10:34, Bin Meng wrote:
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
> Changes in v2:
> - correct the typo in the commit message: instrunction => instruction
> - correct the typo in the commit message: genenic => generic
> - change numonyx_extract_cfg_num_dummies() to numonyx_extract_cfg_dummy_bytes()
>    to avoid confusion
> - change macronix_extract_cfg_num_dummies() to macronix_extract_cfg_dummy_bytes()
>    to avoid confusion
> - change spansion_extract_cfg_num_dummies() to spansion_extract_cfg_dummy_bytes()
>    to avoid confusion
> - use assert() when the dummy bit count is not byte-aligned
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
>   docs/devel/ssi.rst             | 132 ++++++++++++++++++++++++++++
>   hw/block/m25p80.c              | 154 +++++++++++++++++++++------------
>   hw/ssi/aspeed_smc.c            | 135 ++++-------------------------
>   hw/ssi/npcm7xx_fiu.c           |  25 ++----
>   hw/ssi/trace-events            |   1 -
>   hw/ssi/xilinx_spips.c          | 122 +++++++++++++++++++-------
>   include/hw/ssi/aspeed_smc.h    |   2 -
>   include/hw/ssi/xilinx_spips.h  |   2 +-
>   9 files changed, 348 insertions(+), 226 deletions(-)
>   create mode 100644 docs/devel/ssi.rst
> 
> ---
> base-commit: 94826ec1370328375c3b6d1e80fdc94c8f46c348
> branch: m25p80-v2


With some help of claude, here is a summary of the functional test coverage :


   ┌───────┬───────────────────┬──────────────────────────────────────────────────────────────────┐
   │ Patch │     Component     │                     Functional Test Coverage                     │
   ├───────┼───────────────────┼──────────────────────────────────────────────────────────────────┤
   │ 0001  │ m25p80 (Winbond)  │ COVERED — ast2600-evb (6), bletchley-bmc, catalina-bmc,          │
   │       │                   │ ast2700a1-evb (3), ast2700a2-evb (3), ast2700fc (2), anacapa-bmc │
   ├───────┼───────────────────┼──────────────────────────────────────────────────────────────────┤
   │ 0002  │ m25p80 (Numonyx)  │ PARTIAL — palmetto-bmc, romulus-bmc                              │
   │       │                   │ (default config only, no QIO/DIO mode test)                      │
   ├───────┼───────────────────┼──────────────────────────────────────────────────────────────────┤
   │ 0003  │ m25p80 (Macronix) │ PARTIAL — ast2500-evb (3), witherspoon-bmc, anacapa-bmc,         │
   │       │                   │ fby4-bmc, gb200nvl-bmc, quanta-gsj (default DC only)             │
   ├───────┼───────────────────┼──────────────────────────────────────────────────────────────────┤
   │ 0004  │ m25p80 (Spansion) │ NOT COVERED — no machine uses Spansion flash                     │
   ├───────┼───────────────────┼──────────────────────────────────────────────────────────────────┤
   │ 0005  │ npcm7xx_fiu       │ PARTIAL — quanta-gsj (direct-read path only)                     │
   ├───────┼───────────────────┼──────────────────────────────────────────────────────────────────┤
   │ 0006  │ xilinx_spips      │ NOT COVERED — no ZynqMP GQSPI machine in the suite               │
   ├───────┼───────────────────┼──────────────────────────────────────────────────────────────────┤
   │ 0007  │ aspeed_smc        │ COVERED — palmetto-bmc, ast2500-evb (3), romulus-bmc,            │
   │       │ direct-read       │ witherspoon-bmc, ast2600-evb (6), anacapa-bmc, bletchley-bmc,    │
   │       │                   │ catalina-bmc, gb200nvl-bmc, fby4-bmc, ast2700a1-evb (3),         │
   │       │                   │ ast2700a2-evb (3), ast2700fc (2)                                 │
   ├───────┼───────────────────┼──────────────────────────────────────────────────────────────────┤
   │ 0008  │ aspeed_smc        │ COVERED — superseded by 0009                                     │
   │       │ snoop table       │                                                                  │
   ├───────┼───────────────────┼──────────────────────────────────────────────────────────────────┤
   │ 0009  │ aspeed_smc        │ COVERED — all Aspeed Linux boot tests: ast2500-evb (3),          │
   │       │ snoop removal     │ romulus-bmc, witherspoon-bmc, ast2600-evb (6), anacapa-bmc,      │
   │       │                   │ bletchley-bmc, catalina-bmc, gb200nvl-bmc, fby4-bmc,             │
   │       │                   │ ast2700a1-evb (3), ast2700a2-evb (3), ast2700fc (2)              │
   ├───────┼───────────────────┼──────────────────────────────────────────────────────────────────┤
   │ 0010  │ docs only         │ N/A                                                              │
   └───────┴───────────────────┴──────────────────────────────────────────────────────────────────┘

   Coverage Gaps

   1. Spansion flash — No functional test at all. Need a machine with
      s25fl*/s25fs* flash or a dedicated unit test.
   
   2. Xilinx ZynqMP GQSPI — No functional test. The xlnx-zcu102 or
      xlnx-versal-virt machines would exercise this, but no test with
      SPI flash operations exists in the suite.
   
   3. Non-default volatile configuration — All tests boot with default
      flash config register values. The complex dummy-cycle scaling
      tables (Macronix DC[1:0], Numonyx volatile_cfg, Spansion CR2V)
      are only tested at their default settings.
   
   4. QIO/DIO command families — The U-Boot and Linux drivers used in
      tests typically issue standard or dual/quad-output fast
      reads. The quad-I/O and dual-I/O read commands (EBh, BBh) that
      have the most different dummy handling may not be exercised.
   
   5. NPCM UMA path — Only the direct-read FIU path is confirmed
      exercised; the UMA transaction path in npcm7xx_fiu_uma_transaction()
      may or may not be hit during kernel boot.

To be cross checked.

Thanks,

C.



