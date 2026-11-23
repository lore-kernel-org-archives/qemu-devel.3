Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03904606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=rrlnT+DI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVho-0005yj-O9; Mon, 23 Nov 2026 10:11:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xVVgs-0005hj-MV
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:10:54 -0500
Received: from smtpout2.mo537.mail-out.ovh.net ([51.210.91.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xVVgp-00057U-0Q
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:10:46 -0500
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [79.137.60.225])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4jY8Wt5f9qz493C;
 Mon, 23 Nov 2026 15:10:34 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Mon, 23 Nov 2026 15:10:34 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.118.193])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jY8Wh3Mgzz6NRD; Mon, 23 Nov 2026 15:10:24 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id E181894219F; 
 Mon, 23 Nov 2026 15:10:22 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001437c4dc8-e6f8-4f3d-a758-19c57a1e0fd6,
 B6C8A908DA241A829C2EE32824EAF31EC75DFE0A) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <c6bdf631-52f8-49db-b2a2-c028671a2753@kaod.org>
Date: Mon, 23 Nov 2026 16:10:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] m25p80: Clear write_enable after page program and
 flash erase operation
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Alistair Francis <alistair@alistair23.me>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20261110-m25p80_write_enable_fix-v1-0-3a2abc0072b0@oss.tenstorrent.com>
 <20261110-m25p80_write_enable_fix-v1-2-3a2abc0072b0@oss.tenstorrent.com>
 <39176a72-7756-477a-842b-e277ec07d321@kaod.org>
 <CAEev2e_SbbLENO3YhkJPtBXyd2JKZktmnxzD6UbbDyfyih6C2Q@mail.gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <CAEev2e_SbbLENO3YhkJPtBXyd2JKZktmnxzD6UbbDyfyih6C2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 6296032282695805997
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFbuPeI+AdPfVRb3IHHiJm7tlQXSMQOhloTl4mTsLcOa4T4YGQPayN6xkFqBv4Az4LCDQhgu0PTA4HhNgR4m3fK4WHbEy3yMMqHuNzyPM5ugfCXl6mibmjlxFZUxjnXyoA45uzE1dN7/ZCjlrL1H8O11NEe7NARZ9tYorX7p5x3ysrJFihctLpeD07g9JFIHk0xG0k6u8qcOfkr3Qgox89hWiZ84OAqFhYKd/ovPZ4SZc6D0Ie0tdxrr/psVTNBsRld8PK55HcYJVR0w/lxIgkk9l8y5Pasv5MtOcwQ6CPqfG9PBx0OUMZlHyC5X3Skn0+SBbq6ssDIQybLnq76BT6dN/C1REWILiua1oRchMHJ8spHm/wP41YkZF20j1KNOGjPjGQ/Fbe7e2Xne5bSPZrkTSUB47SSYuc0kpUyF/eQAQkkUF7zNZEH3rzdJwM3Vugq79BmXVdhyJ7mv1THZwXW7U/oEpVzet+O8tMY1yCDVsv6afkldMw//A0sv+7uwX8FWdKQ39rG1is9H+bcKlUy4mr8anv3CXtLUkolYsvz6dqTDI8jIWLDKoaVMIUQlztyotsW6jJT236QrM0cof9EEkKTK4OLI7VAqFLB2+5F34AOYMRo2Zo59f+MFBljPMSeogYlH5h+taf+7AhnZRKXk7hZvJwZQYiFsQVGaFOLXA
DKIM-Signature: a=rsa-sha256; bh=Nf3owP+YWfGjGC8Fx+6oPaOEyGm/mEoorovfafFvvtc=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1795446634; v=1;
 b=rrlnT+DI5emWjqhtpTr7TntuMSGEKnDZv+SuZdO1CcwLXVXTQWB+/aWyzDQabYK3tio+Bjzz
 cCqK4rkP6WhgbWIe6i3om1HEAO2SbxW+D6xwEG3u0NQlnHWd9ybjodLZfukP4huseTTacHMSUFe
 Lky8OIy4+rPAVzdX4MR5YbSSbxWn/2CB8BNG+8b2P6z49nvEOR5Ke4C6BnyuA5XbfpcvGWdjzqo
 rU971FCULd1r5DxKAiOuj9A9CxhvbfpsFv/600w9aP9q6r95qZwtye+e4K6QZQcfCmj2V/nxNuD
 lsDhGiTYOcPh9mq9a7igC2nc69lRclP2reXSgR6fYwe+Q==
Received-SPF: pass client-ip=51.210.91.21; envelope-from=clg@kaod.org;
 helo=smtpout2.mo537.mail-out.ovh.net
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 16:01, Anirudh Srinivasan wrote:
> Hello Cédric, Alistair,
> 
> On Mon, Nov 23, 2026 at 1:13 AM Cédric Le Goater <clg@kaod.org> wrote:
>>
>> On 11/10/26 19:11, Anirudh Srinivasan wrote:
>>> NOR flash drivers in EDK2[1] and its forks[2] poll for write enable
>>> (WEL) to be deasserted at the end of a SPI operation to indicate that
>>> the operation has been completed. The m25p80 spec[3] indicates that real
>>> hardware would desassert WEL at the end of page program and erase
>>> operations.
>>>
>>> The m25p80 model does not deassert WEL at the end of these operations.
>>> Update the model to do so to match hardware behaviour.
>>>
>>> [1] https://github.com/tianocore/edk2/blob/3c890c11dfdb5908dcbc84f977dddc6c6d43789f/MdeModulePkg/Bus/Spi/SpiNorFlashJedecSfdp/SpiNorFlash.c#L987
>>> [2] https://github.com/spacemit-com/edk2-platforms/blob/0b8b7182d8a20a771b97a487d0e6f4ab89fb3492/Silicon/Spacemit/Drivers/Spi/SpiNorFlashDxe/SpiNorFlashDxe.c#L532
>>> [3] https://www.alldatasheet.com/datasheet-pdf/download/22807/STMICROELECTRONICS/M25P80.html
>>>
>>> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
>>
>>
>> If this change is to be merged in QEMU 11.2, could you please provide
>> a Fixes: tag ?
> 
> Looks like Alistair has picked up these to his branch already.

b4 handles trailers updates nicely.
  
> These would be the fixes tags. Not sure if i should send another
> version or if Alistair could apply these tags.
> 
> Patch 1/2 (aspeed smc test)
> Fixes: 3e62a32ddb ("test/qtest: Introduce a new aspeed-smc-utils.c to
> place common testcases")

hmmm, this is for patch 1 and you have just replied to patch 2.

> This bug was introduced in 7a2334f720 ("tests: add a m25p80 test")
> back in 2016. The commit in the previous line refactored these tests,
> so I think the fixes tag should mention that one.
> 
> Patch 2/2 (m25p80)
> Fixes: m25p80 ("Initial implementation of SPI flash device")

This is not a git commit it.

I think you should send a v2, the tools are now quite confused :

$ b4 am 20261110-m25p80_write_enable_fix-v1-0-3a2abc0072b0@oss.tenstorrent.com
Analyzing 7 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Analyzing 0 code-review messages
Checking attestation on all messages, may take a moment...
---
   ✗ [PATCH 1/2] test/qtest/aspeed_smc-test: Send write enable before each page program command
   ✗ [PATCH 2/2] m25p80: Clear write_enable after page program and flash erase operation
     + Fixes: 3e62a32ddb ("test/qtest: Introduce a new aspeed-smc-utils.c to place common testcases") (✓ DKIM/tenstorrent.com)
     + Fixes: m25p80 ("Initial implementation of SPI flash device") (✓ DKIM/tenstorrent.com)
   ---
   ✗ BADSIG: DKIM/tenstorrent.com


Thanks,

C.

