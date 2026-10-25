Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2070606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL26T-0004St-E6; Sun, 25 Oct 2026 13:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL25g-0002nU-3h; Sun, 25 Oct 2026 13:33:14 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL25e-0007Q4-47; Sun, 25 Oct 2026 13:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=9V6WqJ0lisQW5LW8pfgAcMCHZOVg8jFdL3JLCLERuYI=; b=rHa0hHnB1WjOiJQ2lvGGbhDxu1
 1igss0We6AonfSFc6LQ/NR8qlXjihbhIHWRXkMjEPGFPTBcxUx8RYKpXiw8+4ozAU1HkKiGpe9QRf
 tOyS1WEc1jiQdSl3mmWQ9PbTXpsYl2g0FvE0HxS9MAkUqRvnNa4frqluAKDkZZz4AoFB3Hk3jeIkj
 69Dl9qcmLoEy4VgaVPoTlg1KgXODs20JvZDCtV1Qv3D91YNvjxAnQQ8//bwSczZvhTjDjLwaiEm5J
 5c8EcGYbwLvXqzMHN+Xpb6vbk2jSd8a7CptYsjLJfUVyq6vDx0au+2/VBvbLj0ubrfauko3UIWP3V
 dLnCI45w==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1es-0008qf-35; Sun, 25 Oct 2026 18:05:22 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1es-0006cY-0w; Sun, 25 Oct 2026 18:05:22 +0100
Message-ID: <cd09d506-75f1-4b82-bfe6-a45707609b3f@sayyadumar.com>
Date: Sun, 25 Oct 2026 18:05:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/rx: add RXv2/RXv3 CPU support
To: yoshinori.sato@nifty.com
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org
References: <20260913-umar-rx-series-v1-0-5a5841a5d1e9@sayyadumar.com>
 <87o6e06pqs.wl-yoshinori.sato@nifty.com>
 <c31dd9df-b82b-4cbc-814c-35d299f19c5c@sayyadumar.com>
 <87tsn0s609.wl-yoshinori.sato@nifty.com>
Content-Language: en-US
From: "Umar, Sayyad Mahammad" <contact@sayyadumar.com>
In-Reply-To: <87tsn0s609.wl-yoshinori.sato@nifty.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28164/Sun Oct 25 07:24:12 2026)
Received-SPF: pass client-ip=85.10.213.182;
 envelope-from=contact@sayyadumar.com; helo=www675.your-server.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/5/26 14:09, yoshinori.sato@nifty.com wrote:
> On Mon, 05 Oct 2026 06:16:54 +0900,
> Umar, Sayyad Mahammad wrote:
>> On 9/14/26 13:23, yoshinori.sato@nifty.com wrote:
>>> On Mon, 14 Sep 2026 03:21:04 +0900,
>>> Sayyad Mahammad Umar wrote:
>>>> This series extends the RX target with RXv2 and RXv3 CPU support,
>>>> forming the foundation for the RX65N, RX651, and RX72M machine models.
>>>>
>>>> The first patch adds the CPU definitions, instruction support, and
>>>> translator changes required by the newer RX cores.
>>>>
>>>> The second patch adds the initial RX machine and peripheral support.
>>>>
>>>> Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
>>>> ---
>>>> Sayyad Mahammad Umar (2):
>>>>         target/rx: add RXv2 and RXv3 CPU support
>>>>         hw/rx: add common RX peripherals
>>>>
>>>>    MAINTAINERS                           |   20 +
>>>>    hw/adc/renesas_s12ad.c                |  324 +++++++++
>>>>    hw/dma/renesas_rx_dmac.c              |  317 +++++++++
>>>>    hw/dma/renesas_rx_dtc.c               |  169 +++++
>>>>    hw/gpio/renesas_rx_gpio.c             |  256 +++++++
>>>>    hw/misc/renesas_rx_crc.c              |  219 ++++++
>>>>    hw/misc/renesas_rx_fcu.c              |  985 ++++++++++++++++++++++++++
>>>>    hw/misc/renesas_rx_romcache.c         |  139 ++++
>>>>    hw/misc/rx65n_sysclk.c                |  190 +++++
>>>>    hw/net/renesas_etherc.c               |  955 +++++++++++++++++++++++++
>>>>    hw/rtc/renesas_rx_rtc.c               |  330 +++++++++
>>>>    hw/ssi/renesas_rspi.c                 |  319 +++++++++
>>>>    hw/timer/renesas_mtu3.c               |  509 ++++++++++++++
>>>>    hw/watchdog/renesas_rx_wdt.c          |  193 ++++++
>>>>    include/hw/adc/renesas_s12ad.h        |   61 ++
>>>>    include/hw/dma/renesas_rx_dmac.h      |   57 ++
>>>>    include/hw/dma/renesas_rx_dtc.h       |   42 ++
>>>>    include/hw/gpio/renesas_rx_gpio.h     |   64 ++
>>>>    include/hw/misc/renesas_rx_crc.h      |   30 +
>>>>    include/hw/misc/renesas_rx_fcu.h      |  191 +++++
>>>>    include/hw/misc/renesas_rx_romcache.h |   30 +
>>>>    include/hw/misc/rx65n_sysclk.h        |   37 +
>>>>    include/hw/net/renesas_etherc.h       |  109 +++
>>>>    include/hw/rtc/renesas_rx_rtc.h       |   52 ++
>>>>    include/hw/ssi/renesas_rspi.h         |   61 ++
>>>>    include/hw/timer/renesas_mtu3.h       |   73 ++
>>>>    include/hw/watchdog/renesas_rx_wdt.h  |   48 ++
>>>>    target/rx/cpu-param.h                 |    3 +
>>>>    target/rx/cpu-qom.h                   |    2 +
>>>>    target/rx/cpu.c                       |   57 +-
>>>>    target/rx/cpu.h                       |  124 ++++
>>>>    target/rx/disas.c                     |  383 ++++++++++-
>>>>    target/rx/gdbstub.c                   |   44 +-
>>>>    target/rx/helper.c                    |   56 +-
>>>>    target/rx/helper.h                    |   22 +
>>>>    target/rx/insns.decode                |  125 +++-
>>>>    target/rx/meson.build                 |    6 +-
>>>>    target/rx/op_helper.c                 |  357 ++++++++++
>>>>    target/rx/translate.c                 | 1225 ++++++++++++++++++++++++++-------
>>>>    39 files changed, 7873 insertions(+), 311 deletions(-)
>>>> ---
>>>> base-commit: ff1d2d19d7e24893e2012d879f8e73077e17b9bd
>>>> change-id: 20260913-umar-rx-series-0bfbbfe6b074
>>>>
>>>> Best regards,
>>>> --
>>>> Sayyad Mahammad Umar <contact@sayyadumar.com>
>>>>
>>> Thanks.
>>> I also implemented some peripheral functions to emulate the actual board.
>>> I haven't verified every single change, but if there are any missing features,
>>> it would be best to combine them with my changes.
>> Hi Mr Sato,
>>
>> Sorry for the late reply, i was sick for couple of weeks.
>>
>> I have now started to work on splitting my last patch series from 2
>> patches to about ~31 smaller patches.
>>
>> I will be submitting those in the coming days after i test the changes
>> with real firmware.
>>
>> The real hardware i want to support are rx65n-2mb, rx660-tb and rx72m-rsk.
>>
>> Which boards/peripherals are you working on ?
>>
>> Regards,
>>
>> Umar
>>
> OK. I have high hopes.
>
> I am implementing this targeting an RX62N board.
> This board was released only in Japan, but it is no longer available.
> While this board allows for the use of almost all the RX62N's features,
> I wanted to use USB, Ethernet, and SPI, so I implemented those functions
> along with some GPIOs.

Hello Mr Sato,

I have now sent my second patch series. Please have a look.

I have added support for  Ethernet and SPI. It would be good to have USB 
as well i guess.

Regards,

Umar




