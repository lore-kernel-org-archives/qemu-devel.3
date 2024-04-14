Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED50C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2024 13:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvzTC-0006GA-HV; Sun, 14 Apr 2024 09:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rvzSt-0006EI-Bd; Sun, 14 Apr 2024 09:00:13 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rvzSr-00068c-Gh; Sun, 14 Apr 2024 09:00:11 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 53BC44E6005;
 Sun, 14 Apr 2024 15:00:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id czvfo-2I-PKT; Sun, 14 Apr 2024 15:00:00 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 64B884E601D; Sun, 14 Apr 2024 15:00:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 62DED7456B4;
 Sun, 14 Apr 2024 15:00:00 +0200 (CEST)
Date: Sun, 14 Apr 2024 15:00:00 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2] ppc440_pcix: Do not expose a bridge device on PCI bus
In-Reply-To: <eecb616c-ad00-42da-ac49-1ebe51d0a1ec@linaro.org>
Message-ID: <81128dae-f01e-ff40-c2cc-ff721dfdf288@eik.bme.hu>
References: <20240411192443.B4D644E6026@zero.eik.bme.hu>
 <eecb616c-ad00-42da-ac49-1ebe51d0a1ec@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-1313889683-1713099600=:647"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1313889683-1713099600=:647
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 13 Apr 2024, Philippe Mathieu-Daudé wrote:
> On 11/4/24 21:24, BALATON Zoltan wrote:
>> Real 460EX SoC apparently does not expose a bridge device and having
>> it appear on PCI bus confuses an AmigaOS file system driver that uses
>> this to detect which machine it is running on.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>> Here's another version that keeps the values and only drops the device
>> so it's even less likely it could break anything, in case this can be
>> accepted for 9.0.
>>
>>   hw/pci-host/ppc440_pcix.c | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks. Nick, could you ack this please so it could be merged if you 
won't send more pull requests? (I'm the maintainer of this file as it's 
only used by sam460ex so maybe an ack is not needed but it could help to 
show you have no problem with it.)

Regards,
BALATON Zoltan
--3866299591-1313889683-1713099600=:647--

