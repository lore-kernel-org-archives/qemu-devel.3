Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A06C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 14:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJZyS-0007Xm-2T; Tue, 18 Jun 2024 10:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sJZyQ-0007XW-OS
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 10:38:14 -0400
Received: from wfhigh8-smtp.messagingengine.com ([64.147.123.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sJZyO-000181-Nv
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 10:38:14 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.west.internal (Postfix) with ESMTP id 93C8518000A6;
 Tue, 18 Jun 2024 10:38:06 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Tue, 18 Jun 2024 10:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1718721486;
 x=1718807886; bh=I7htI+Gx7J+REZgXKOeuMOnSqTujf4HriPbwCBSP93E=; b=
 LAUlTJEcNbqVEIVJcEuoB9tA/svckInkRQKAceaBaYUoWuGfDcMwo/cO1fpYiF2C
 5Ks/I3TSGwCk8INH8mTZZLtEJ+fa754kf1hb1jYBINrLgv2TKFu5lM4FXaHOXH/d
 mnGF/TMnjfGtUoNkwvaP/4T02KdU5NsqWxpjwSCzVt/03+KvZ0TKj/rYeViMRAEt
 CFuJodDwpunMIjZ1iUTB3QFr6yOBI7yQqeI8MGmJ0CoYIMX/+sWtPgRjLblSKZca
 6dqWS4goRtj4l8N+zmhbPEH2/OHH7JvxKPrP2vpQZxd3NJfaEX+9NczxbCFjuLAa
 ZJb3yOcEDa5T5hRINpLyxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718721486; x=
 1718807886; bh=I7htI+Gx7J+REZgXKOeuMOnSqTujf4HriPbwCBSP93E=; b=Y
 6eTNuO5GLR1iRln5uOOfTGcYBxLVr9gdwceXbaoDdj94DCM9B2UKx+CPw/UphKFP
 rMdcwkSqnS+k2RfS0ZHJvQ/BgLR/FqZ11LQDA9Kk40AWAk9LCiaNGDl0MVMfVQKw
 RVArlFY9/hmrQdzCncWrIHULIh/MZH2712tSaRF4xGzFVA9kczvq7ImJtYPwf9/i
 96IOjSw2CN+le109fyKZMRqZOjlE3nexgmr4EArdGLoJBwm8C7nq4gCQstDfslWv
 YZBdukZt6dUS9p+eHih04XC3Dv4Um85ESo6IURxjLegYKpe0dTaFAGmnj6udPxZc
 SU8gejJRwy6+KVmBR985A==
X-ME-Sender: <xms:zZtxZqfmRPmbaFZ6TEy9UKvqGzKvH_wb06EdO_qPTKrKwKYOVkPKKw>
 <xme:zZtxZkNbesXsngKfWPfYo1Q3NgzhynpOSsz2G7wu_-_eN9CrZFciLkqPLSt089hIr
 iZmLyyavPzFd3jM5AU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvkedggeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:zZtxZrhlOzahYt3ajTNKosr0GAbj5nqstfm7IXX2vr2WZXjEc7RxhA>
 <xmx:zZtxZn8LMQ85GVM7dpgxG8y8KxMUktshxjsPmNxQSs72Hz7zqAncVg>
 <xmx:zZtxZmvDjX88KrQ8RpK8GW8jrAI_ApSUtA2Kmxr9CEiG3iX3ZAh35Q>
 <xmx:zZtxZuHyeB6cp_UEteGQHc5HLawxcMF96i0TnCvysXi7raizFT1OXg>
 <xmx:zptxZoXUGQdlF5jdPhOhLWiiRJpQchbaQYCzQ3GKU2QaI0bXv2EugFgG>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id CC4F336A0074; Tue, 18 Jun 2024 10:38:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
MIME-Version: 1.0
Message-Id: <16f2e94d-7229-472a-9059-f89c3d0db93b@app.fastmail.com>
In-Reply-To: <150942af-8727-4594-a817-c53c5bb8e04f@linaro.org>
References: <20240527-m68k-bios-v1-0-6de26552fa77@flygoat.com>
 <20240527-m68k-bios-v1-3-6de26552fa77@flygoat.com>
 <150942af-8727-4594-a817-c53c5bb8e04f@linaro.org>
Date: Tue, 18 Jun 2024 15:37:45 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Paolo Bonzini" <pbonzini@redhat.com>,
 "Laurent Vivier" <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Cornelia Huck" <cohuck@redhat.com>
Subject: Re: [PATCH 3/4] hw/m68k/virt: Add a pflash controller for BIOS
 firmware
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=64.147.123.159;
 envelope-from=jiaxun.yang@flygoat.com; helo=wfhigh8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



=E5=9C=A82024=E5=B9=B46=E6=9C=8818=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=E5=
=8D=8812:47=EF=BC=8CPhilippe Mathieu-Daud=C3=A9=E5=86=99=E9=81=93=EF=BC=9A
> Hi Jiaxun,
>
> On 27/5/24 19:15, Jiaxun Yang wrote:
>> Add a 8 MiB pflash controller for BIOS firmware, and boot
>> from it if possible.
>>=20
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>   hw/m68k/Kconfig                                   |  1 +
>>   hw/m68k/virt.c                                    | 44 ++++++++++++=
+++++++++++
>>   include/standard-headers/asm-m68k/bootinfo-virt.h |  1 +
>>   3 files changed, 46 insertions(+)
>>=20
>> diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
>> index 4501da56ff6d..f233a5948f19 100644
>> --- a/hw/m68k/Kconfig
>> +++ b/hw/m68k/Kconfig
>> @@ -42,6 +42,7 @@ config M68K_VIRT
>>       select M68K_IRQC
>>       select FW_CFG_DMA
>>       select VIRT_CTRL
>> +    select PFLASH_CFI01
>>       select GOLDFISH_PIC
>>       select GOLDFISH_TTY
>>       select GOLDFISH_RTC
>> diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
>> index 7590e6515ac3..a2eebc0f2243 100644
>> --- a/hw/m68k/virt.c
>> +++ b/hw/m68k/virt.c
>> @@ -8,6 +8,7 @@
>>    */
>>  =20
>>   #include "qemu/osdep.h"
>> +#include "qemu/datadir.h"
>>   #include "qemu/units.h"
>>   #include "qemu/guest-random.h"
>>   #include "sysemu/sysemu.h"
>> @@ -28,6 +29,7 @@
>>   #include "sysemu/runstate.h"
>>   #include "sysemu/reset.h"
>>  =20
>> +#include "hw/block/flash.h"
>>   #include "hw/intc/m68k_irqc.h"
>>   #include "hw/misc/virt_ctrl.h"
>>   #include "hw/char/goldfish_tty.h"
>> @@ -97,6 +99,10 @@
>>   #define VIRT_XHCI_MMIO_BASE 0xff020000    /* MMIO: 0xff020000 - 0xf=
f023fff */
>>   #define VIRT_XHCI_IRQ_BASE  PIC_IRQ(1, 2) /* PIC: #1, IRQ: #2 */
>>  =20
>> +#define VIRT_PFLASH_MMIO_BASE 0xff800000      /* MMIO: 0xff800000 - =
0xffffffff */
>> +#define VIRT_PFLASH_SIZE      0x800000        /* 8 MiB */
>
> Do you need a real RW pflash or a ROM would be enough?

U-Boot needs somewhere to store env vars :-(
Probably a NVRAM would fit the purpose?

Thanks

>

--=20
- Jiaxun

