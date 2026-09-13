Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8238C88E5C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 22:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5sfg-0005GH-OM; Sun, 13 Sep 2026 18:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1x5sff-0005G4-7H; Sun, 13 Sep 2026 18:27:35 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1x5sfc-0007f0-RF; Sun, 13 Sep 2026 18:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=tro7dAwP1PiNoIhRhoap6OJJpok3qbhAMRm4bENb8QU=; b=GqHL2bxEDhwsg0svScQzTHre3y
 nueQqdsYxdW7Pzc/RPOleXdYEnJxVrTdJre1HLeCV8aYymKa1UyRad7Lps2TWTEpHz+oz056x2cIp
 IDLIuaCQidhlu08hQKkWKOfwseGMhib+zB3f5OjwIpCqyAIMdFIq3iCjfQnhmmd0cb9ro0crravw8
 QOrenHKEPO7V3LrMdOuHVhl4EhTw1Rr3uFA7Ac3iTf/S5yw8WvL7zaUdo14RB8BgtjGcFKSgMC9e9
 J+xXnApiCNxJ68tk+3sarQTZjHUDPY3k/PPjDHfRsdlieMk2JsTIVlYieIM6L7x7DEmSoLt746tUO
 erKtCCYw==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1x5sfX-000Hgg-1L; Mon, 14 Sep 2026 00:27:27 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1x5sfE-000MKE-16; Mon, 14 Sep 2026 00:27:08 +0200
Message-ID: <7dcfa12f-50e5-4f98-a8b2-972ce2331499@sayyadumar.com>
Date: Mon, 14 Sep 2026 00:27:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 0/2] target/rx: add RXv2/RXv3 CPU support
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org
References: <20260913-umar-rx-series-v1-0-5a5841a5d1e9@sayyadumar.com>
 <7e3a07b7-9ebe-42a2-8561-650ddcfe9026@linaro.org>
Content-Language: en-US
From: "Umar, Sayyad Mahammad" <contact@sayyadumar.com>
In-Reply-To: <7e3a07b7-9ebe-42a2-8561-650ddcfe9026@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28122/Sun Sep 13 08:26:25 2026)
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/13/26 23:39, Richard Henderson wrote:
> On 9/13/26 08:21, Sayyad Mahammad Umar wrote:
>> This series extends the RX target with RXv2 and RXv3 CPU support,
>> forming the foundation for the RX65N, RX651, and RX72M machine models.
>>
>> The first patch adds the CPU definitions, instruction support, and
>> translator changes required by the newer RX cores.
>>
>> The second patch adds the initial RX machine and peripheral support.
>>
>> Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
>> ---
>> Sayyad Mahammad Umar (2):
>>        target/rx: add RXv2 and RXv3 CPU support
>>        hw/rx: add common RX peripherals
>>
>>   MAINTAINERS                           |   20 +
>>   hw/adc/renesas_s12ad.c                |  324 +++++++++
>>   hw/dma/renesas_rx_dmac.c              |  317 +++++++++
>>   hw/dma/renesas_rx_dtc.c               |  169 +++++
>>   hw/gpio/renesas_rx_gpio.c             |  256 +++++++
>>   hw/misc/renesas_rx_crc.c              |  219 ++++++
>>   hw/misc/renesas_rx_fcu.c              |  985 
>> ++++++++++++++++++++++++++
>>   hw/misc/renesas_rx_romcache.c         |  139 ++++
>>   hw/misc/rx65n_sysclk.c                |  190 +++++
>>   hw/net/renesas_etherc.c               |  955 +++++++++++++++++++++++++
>>   hw/rtc/renesas_rx_rtc.c               |  330 +++++++++
>>   hw/ssi/renesas_rspi.c                 |  319 +++++++++
>>   hw/timer/renesas_mtu3.c               |  509 ++++++++++++++
>>   hw/watchdog/renesas_rx_wdt.c          |  193 ++++++
>>   include/hw/adc/renesas_s12ad.h        |   61 ++
>>   include/hw/dma/renesas_rx_dmac.h      |   57 ++
>>   include/hw/dma/renesas_rx_dtc.h       |   42 ++
>>   include/hw/gpio/renesas_rx_gpio.h     |   64 ++
>>   include/hw/misc/renesas_rx_crc.h      |   30 +
>>   include/hw/misc/renesas_rx_fcu.h      |  191 +++++
>>   include/hw/misc/renesas_rx_romcache.h |   30 +
>>   include/hw/misc/rx65n_sysclk.h        |   37 +
>>   include/hw/net/renesas_etherc.h       |  109 +++
>>   include/hw/rtc/renesas_rx_rtc.h       |   52 ++
>>   include/hw/ssi/renesas_rspi.h         |   61 ++
>>   include/hw/timer/renesas_mtu3.h       |   73 ++
>>   include/hw/watchdog/renesas_rx_wdt.h  |   48 ++
>>   target/rx/cpu-param.h                 |    3 +
>>   target/rx/cpu-qom.h                   |    2 +
>>   target/rx/cpu.c                       |   57 +-
>>   target/rx/cpu.h                       |  124 ++++
>>   target/rx/disas.c                     |  383 ++++++++++-
>>   target/rx/gdbstub.c                   |   44 +-
>>   target/rx/helper.c                    |   56 +-
>>   target/rx/helper.h                    |   22 +
>>   target/rx/insns.decode                |  125 +++-
>>   target/rx/meson.build                 |    6 +-
>>   target/rx/op_helper.c                 |  357 ++++++++++
>>   target/rx/translate.c                 | 1225 
>> ++++++++++++++++++++++++++-------
>>   39 files changed, 7873 insertions(+), 311 deletions(-)
> With 7500+ new lines in two patches, no one is going to look at this. 
> This patch set must be split into many many more patches. For example, 
> one per new instruction, one per new device, one per logical change to 
> existing code.
>
>
> r~ 

Hello Mr Henderson,

Thanks for the comment. You are right this patch is rather large. I will 
split this into smaller patches and have another go at it.

Regards,

Umar



