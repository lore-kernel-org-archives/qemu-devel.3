Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00C0606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOJwj-0008P4-0G; Tue, 03 Nov 2026 14:13:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sw@weilnetz.de>) id 1xOJwb-0008Oj-Bo
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 14:13:19 -0500
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sw@weilnetz.de>) id 1xOJwV-0007Su-Iw
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 14:13:15 -0500
Received: from [192.168.178.76] (pd9ec36c0.dip0.t-ipconnect.de
 [217.236.54.192])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTPSA id 27F87DA05A7;
 Tue, 03 Nov 2026 20:13:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weilnetz.de; s=dkim1; 
 t=1793733186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xEn8oVy9ofMJRgIiYMXjcPm/FNz6zHXt9J+nwgans/I=;
 b=S7YXoMIAfzCbka3zD4XGT0Vy2MWVcZ0v0iZALDTY7rThcaOYCfYTOHbk4EC1K51Ot+iALF
 inNOgB9bRI7ij99rzuFywhk7ZvMDnoo1t3B6bqWF+c+W9ser5wGDvnjGtm2zN4Jky2H+UX
 gTgHagxRt/jXGnYCHB7DYzRWAR77V7M=
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=stefan.weil@weilnetz.de smtp.mailfrom=sw@weilnetz.de
Message-ID: <bb582945-7ce8-429a-9aac-a7e7bc24b1b4@weilnetz.de>
Date: Tue, 3 Nov 2026 20:13:05 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/eepro100: fix use-after-free on reset after
 hot-unplug
To: "Jason Wang <Jason Wang" <jasowangio@gmail.com>
Cc: qemu-devel@nongnu.org, Hui Peng <benquike@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20261103185659.698079-1-sw@weilnetz.de>
Autocrypt: addr=sw@weilnetz.de; keydata=
 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
In-Reply-To: <20261103185659.698079-1-sw@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: v2201612906741603
X-Rspamd-Queue-Id: 27F87DA05A7
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.10 / 10.00]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[weilnetz.de:s=dkim1];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[nongnu.org,gmail.com,linaro.org];
 RCPT_COUNT_THREE(0.00)[4];
 ASN(0.00)[asn:3320, ipnet:217.224.0.0/11, country:DE];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_ZERO(0.00)[0];
 MID_RHS_MATCH_FROM(0.00)[]; TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action
Received-SPF: pass client-ip=37.120.169.71; envelope-from=sw@weilnetz.de;
 helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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
Reply-to:  Stefan Weil <sw@weilnetz.de>
From:  Stefan Weil via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Sorry for using an outdated address for Jason Wang in my previous email, 
now forwarded to the current address ...

Am 03.11.26 um 19:56 schrieb Stefan Weil:

> e100_nic_realize() registers a system reset handler via
> qemu_register_reset(nic_reset, s), but pci_nic_uninit() never
> unregisters it. After the device is hot-unplugged, the LegacyReset
> object stored in the root reset container still holds the raw pointer
> to the freed EEPRO100State, so the next system reset invokes
> nic_reset() on freed memory.
>
> Instead, define a reset phase on the device itself: assign
> phases.hold in eepro100_class_init() to a wrapper around nic_reset().
> The device is already part of the resettable tree via its parent bus
> (TYPE_DEVICE implements the Resettable interface), so no explicit
> registration is needed, and the reset state is automatically dropped
> when the device is unplugged. This follows the approach used by the
> e1000, e1000e and igb emulations.
>
> Reported-by: Hui Peng <benquike@gmail.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4058
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4510
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>
> Note that I used AI assistance to create and test the patch.
> I am not sure whether this is acceptable to small and rather mechanical
> changes like in this case.
>
> The Reported-by for issue 4058 was not added because I did not
> find the required full name and email of the reporter.
>
> Stefan W.
>
>
>   hw/net/eepro100.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
> index aaa3eb60f8a..e1cd8346941 100644
> --- a/hw/net/eepro100.c
> +++ b/hw/net/eepro100.c
> @@ -617,6 +617,13 @@ static void nic_reset(void *opaque)
>       nic_selective_reset(s);
>   }
>   
> +static void eepro100_reset_hold(Object *obj, ResetType type)
> +{
> +    EEPRO100State *s = DO_UPCAST(EEPRO100State, dev, PCI_DEVICE(obj));
> +
> +    nic_reset(s);
> +}
> +
>   #if defined(DEBUG_EEPRO100)
>   static const char * const e100_reg[PCI_IO_SIZE / 4] = {
>       "Command/Status",
> @@ -1881,8 +1888,6 @@ static void e100_nic_realize(PCIDevice *pci_dev, Error **errp)
>       qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
>       TRACE(OTHER, logout("%s\n", qemu_get_queue(s->nic)->info_str));
>   
> -    qemu_register_reset(nic_reset, s);
> -
>       s->vmstate = g_memdup(&vmstate_eepro100, sizeof(vmstate_eepro100));
>       s->vmstate->name = qemu_get_queue(s->nic)->model;
>       vmstate_register_any(VMSTATE_IF(&pci_dev->qdev), s->vmstate, s);
> @@ -2064,6 +2069,7 @@ static void eepro100_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>       E100PCIDeviceInfo *info;
>   
>       info = eepro100_get_class_by_name(object_class_get_name(klass));
> @@ -2080,6 +2086,7 @@ static void eepro100_class_init(ObjectClass *klass, const void *data)
>       k->revision = info->revision;
>       k->subsystem_vendor_id = info->subsystem_vendor_id;
>       k->subsystem_id = info->subsystem_id;
> +    rc->phases.hold = eepro100_reset_hold;
>   }
>   
>   static void eepro100_register_types(void)

