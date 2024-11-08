Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C0BD5E158
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 10:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9MX2-0002eh-7B; Fri, 08 Nov 2024 05:48:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=J98Z=SD=kaod.org=clg@ozlabs.org>)
 id 1t9MWz-0002e2-Ot; Fri, 08 Nov 2024 05:47:57 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=J98Z=SD=kaod.org=clg@ozlabs.org>)
 id 1t9MWw-0006e6-UI; Fri, 08 Nov 2024 05:47:56 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XlFyK3kq6z4wb1;
 Fri,  8 Nov 2024 21:47:37 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XlFyG1461z4w2K;
 Fri,  8 Nov 2024 21:47:33 +1100 (AEDT)
Message-ID: <05cb2ca9-8610-4d85-8f05-c70074e3ad77@kaod.org>
Date: Fri, 8 Nov 2024 11:47:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: Allow user creation of eMMCs
To: jlu@pengutronix.de, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>
References: <20241015135649.4189256-1-jlu@pengutronix.de>
 <CAFEAcA9sjszCj=Fu-A-=qQV_jawnomJ-Nqnd=Vx2vLKmYZ1-nQ@mail.gmail.com>
 <CAFEAcA_a4bYU=KQbKQmWtqvPF3fmtttbhgi0BB0hS1wcCV_U4w@mail.gmail.com>
 <eaf053e4fa01827a188bfa5abe3af92e1f90fabd.camel@pengutronix.de>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <eaf053e4fa01827a188bfa5abe3af92e1f90fabd.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=J98Z=SD=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

On 11/8/24 10:29, Jan Lübbe wrote:
> On Tue, 2024-10-29 at 15:06 +0000, Peter Maydell wrote:
>> On Fri, 18 Oct 2024 at 16:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On Tue, 15 Oct 2024 at 14:57, Jan Luebbe <jlu@pengutronix.de> wrote:
>>>> For testing eMMC-specific functionality (such as handling boot
>>>> partitions), it would be very useful to attach them to generic VMs such
>>>> as x86_64 via the sdhci-pci device:
>>>>   ...
>>>>   -drive if=none,id=emmc-drive,file=emmc.img,format=raw \
>>>>   -device sdhci-pci \
>>>>   -device emmc,id=emmc0,drive=emmc-drive,boot-partition-size=1048576 \
>>>>   ...
>>>>
>>>> While most eMMCs are soldered to boards, they can also be connected to
>>>> SD controllers with just a passive adapter, such as:
>>>>   https://docs.radxa.com/en/accessories/emmc-to-usd
>>>>   https://github.com/voltlog/emmc-wfbga153-microsd
>>>>
>>>> The only change necessary to make the options above work is to avoid
>>>> disabling user_creatable, so do that. The SDHCI-PCI driver in the Linux
>>>> kernel already supports this just fine.
>>>>
>>>> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
>>>
>>> Applied to target-arm.next, thanks (unless anybody would
>>> prefer it to go via some other route).
>>
>> I'm dropping this from target-arm.next since it seems like
>> we have a problem with the handling of boot partitions
>> and how the user should provide an image for an emmc card
>> that has boot partitions). Since that's an emmc specific
>> thing, sorting that out with a minimum of breaking
>> compatibility with previously working setups is going to
>> be easier if we stay temporarily in the state of "emmc
>> only happens for the specific board that creates them
>> and the user can't arbitrarily create them on the
>> command line".
>>
>> I expect this to just be a temporary delay while we sort
>> out in the other thread how emmc boot partitions should work.
> 
> With Cédric's e8f3acdbb8 ("aspeed: Don't set always boot properties of the emmc
> device") and my c078298301 ("hw/sd/sdcard: Fix calculation of size when using
> eMMC boot partitions") in master, compatibility for existing setups should be
> taken care of.
> 
> As mentioned in Cédric's patch, allowing user creatable eMMC devices is still
> desirable. With my patch, that would work for machines where the SD controller
> is user-created as well (e.g. x86_64 with sdhci-pci).
> 
> For machines where the SD controller and SD/eMMC are pre-created, additional
> changes seem to be needed.

Yes. That's a problem to fix for the emmc/sd devices created on the
Aspeed machines. They should only be created when defaults_enabled(),
just like the flash devices.

Also, to be able to assign a device to a sd bus from the command line,
more changes are required. A first series would be to avoid referencing
"sd-bus" where possible :

-        qdev_realize_and_unref(card,
-                               qdev_get_child_bus(DEVICE(sdhci), "sd-bus"),
-                               &error_fatal);
+        qdev_realize_and_unref(card, BUS(&sdhci->sdbus), &error_fatal);

the final touch would be :

  void sdhci_initfn(SDHCIState *s)
  {
-    qbus_init(&s->sdbus, sizeof(s->sdbus), TYPE_SDHCI_BUS, DEVICE(s), "sd-bus");
+    qbus_init(&s->sdbus, sizeof(s->sdbus), TYPE_SDHCI_BUS, DEVICE(s), NULL);

I haven't looked at all the machines though. Aspeed works fine with that
and emmc devices can be defined using :

   -blockdev node-name=emmc0,driver=file,filename=mmc-ast2600-evb-noboot.raw
   -device emmc,bus=sdhci-bus.2,drive=emmc0,id=foo

> Would you consider taking this patch to solve the
> simple case first?

I think we need to address the above first for sd and emmc devices.

Thanks,

C.

