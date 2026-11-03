Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CC5606A31B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZRBYNPgO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOLNJ-00049x-Hg; Tue, 03 Nov 2026 15:44:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOLN8-00049M-1h
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 15:44:47 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOLN6-0008N1-Bz
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 15:44:45 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8b0ca1ebc8bso106767b3.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 12:44:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793738682; cv=none;
 d=google.com; s=arc-20260327;
 b=rWK2+BN8S3qi0OW6+C1qjGwFjuX0ssyxhFyj7kurIz9I/DrvbfRVW8QIL/yxrstoRl
 209vM44yeLInCF0WnUk4MXjR6Xy7eZJ6FC9iNsRNSEwKdF/jx23bCbEwHS7N221ZwMP+
 KE2NLTj0dhEPrHMcMRf9m2ohdKtSWqwI1pEVlrjSaZPVWMNJtbmy/1V/77hoGbJg8gVC
 Zkg0QIYMAKIC5BBvHDasDyD7sw9K/AVfT+51e95+pFojXQdDC6awqiAZslxvcaJRP6Al
 ge1kq/9xlU8tAUADqQc9e24gN3qv0VwD+alSFRtnMV5oymKouBI4mSTHeDNfYFl8zJw6
 d/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tOR04m8W0tOihvuA6cXeYZN68WHmw29UqYw3WO948yw=;
 fh=PdPBA1yue37O75a6jNTUoovXlel6hPMXGSvWj+tAMrM=;
 b=BKR8wulmPrCPryWRf1lKhdfmRk81oiVlCiwRl3OrvWxK5I0AQFt2klTfdJGJOG1BLr
 8XXrJg2Rzrfz7HiaeJSsvJu2QIJVHReNpoXbiehB59mv3DwldxwoztCD7I7ffcPMIJkO
 RAuS/XbPyfVwhAdI5BPn4BxZNM+GLDQLdgeWTJS5AATdyyuzsTL/6aPFOoJje5GwRAdO
 NDsQFibIDXqAcorpJp3WuyUkhoRqLl55PWGXKAklhYZt95jdrRPVvsx80Bh53wty4pAL
 Gl7XvBpaefMuB9efCIBmcQDhfijCpFvHoIjPY1NXW4LtJEEurHGt7Lc9UskAiMnCAlzF
 LUEg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793738682; x=1794343482; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tOR04m8W0tOihvuA6cXeYZN68WHmw29UqYw3WO948yw=;
 b=ZRBYNPgONlWrp0prrJ4ciNB1hI7IW5SI1novlNiaVoqlpZ78CRjP/MaDJM11a5Hynz
 5f3aIwLyK44sQZvTbMTpCq8a8CHDcgBNqeixFuxXF9h25RBFEczaD3yx5YsX6U/Yl4K5
 0VXAKQ8QXB0xQLSdsJAGK6sVq5AGfJe+sHyBYW+PLmz4ONKu/+wkoLZkea9VGAGqj35P
 jBSve0vA54xEC6EJmItQCNei+zArYWe7zlgexeupSQMjFT8kae5YtoXW7ElsEm1ufKtR
 fjvksY7qPXlEfbI3QAke/iNPBFmqAPvNkeygfagufpKNzQiivuXlFPXj9GtNDsICms3N
 OmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793738682; x=1794343482;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tOR04m8W0tOihvuA6cXeYZN68WHmw29UqYw3WO948yw=;
 b=lM4wjuNrFYUEWHqiPiiU2e6MsTZTgsy2V6LzJZyMN1KKs7M53MuQaCDC7Hlx47bCJe
 Wza5bagZxCjeajcMWom2cjjf6/7+tETPlgX1ZSiwYoRy5nrO1GYOJ3K/BUDbKlliYy9/
 6oIO7KkHUCYCLXfrLg26nkeUsUZ0zmDAelXFshPtVNqHOqgLRJMUGfT8c1sN0R333RNL
 ZQUWHME3N8GMBbS/ZhtHY7cqff1TTvp4p9N1WFirc1JOpQB4BWxdG9Hx6XWJKv4JzoUz
 TlBAn/2LMuVFpwcA/ikCHBe3c6K8sB0hWQEP2K4QWcJ3BwLiUKKo4yJKf7tTA8c5r1aq
 d36A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqJTzQNmoWQo4ReovD64gXnZVbSl1Pm2qc3H8UKuRmd/V5ARkqW/Yzs6jrjMFpA/4RtQDrOFuNZ3aO@nongnu.org
X-Gm-Message-State: APuU4Z9cM00OadGOpEsyImHT4W9YJW30TYsYY9o/qVBuhj1TRNWN3wYw
 yKdZz84tQFvgjvuLjui2umpx9/G/of/ECkp4OMGScbFINqAPUibUihuqskEXSY+VawGVXRjOJ9B
 3AAoVRx/HJc64/SBIcf7XErf4SO2m7xHBOJrCzEJ8Ag==
X-Gm-Gg: AYBFou2Nys+kgRxsJEDQXGY78vXeCNL356m1krgkTCc6K8iBOi7C6xOrZl5HXAZQOun
 1+3gAJdqC16YvuwF4gkj0htQI5OMfMitt9a+l6z64dJGhv8Dt+6mfh7CZ9PP+1WFYpsnlnIiU4K
 JhqJJNJGRxT1iaeNIKRd/4Db4FePzIQDMdg9DbwMnReKHvu79npIeZNXxDmlZ5T+lxVUkQLoAdq
 Z+a8NaMa0D9eOUvlXtJTNTrSjvNsD66eQ+x4R0tvsqqb2hvV43ZCYREHsprQmik0G3BpYu2Jzb6
 d/OPrHNQby7iLS2xmpCgf9ul0Wy1mtSHajuADHRNDC7M5CxCOV9G6Qywj8XOaQDVrwF7bEz2hh0
 TUxCbHgqLOC9qxnVpWXop+rb8YxNpmd+VeV4MLy86k5vYhU9U2jef+YYVDNk1e9jae4W+ZWX+dg
 FXlbpdaU3QeZ4yr9ETZxcp
X-Received: by 2002:a05:690c:fca:b0:8b1:4267:3ed8 with SMTP id
 00721157ae682-8b2b67c673cmr99069707b3.65.1793738681640; Tue, 03 Nov 2026
 12:44:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103185659.698079-1-sw@weilnetz.de>
In-Reply-To: <20261103185659.698079-1-sw@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Nov 2026 20:44:28 +0000
X-Gm-Features: AclHuK_V_qXek2alfo-hb1yaJ6GO_pkLunIfSd3mF7aKLq3i-6NHJXxZOY2sJdY
Message-ID: <CAFEAcA-RixfaoDk6vUf9qoWZGPdKqhkrNG5v7=7DuwONt9Cm0A@mail.gmail.com>
Subject: Re: [PATCH] hw/net/eepro100: fix use-after-free on reset after
 hot-unplug
To: Stefan Weil <sw@weilnetz.de>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, 
 Hui Peng <benquike@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 3 Nov 2026 at 18:57, Stefan Weil <sw@weilnetz.de> wrote:
>
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
> I am not shure whether this is acceptable to small and rather mechnical
> changes like in this case.
>
> The Reported-by for issue 4058 was not added because I did not
> find the required full name and email of the reporter.

Looking at the git logs it looks like we tend to handle
gitlab bug reporters as

Reported-by: MyeonghunPak <https://gitlab.com/mhun512>

>  hw/net/eepro100.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
> index aaa3eb60f8a..e1cd8346941 100644
> --- a/hw/net/eepro100.c
> +++ b/hw/net/eepro100.c
> @@ -617,6 +617,13 @@ static void nic_reset(void *opaque)
>      nic_selective_reset(s);
>  }
>
> +static void eepro100_reset_hold(Object *obj, ResetType type)
> +{
> +    EEPRO100State *s = DO_UPCAST(EEPRO100State, dev, PCI_DEVICE(obj));

Why the DO_UPCAST macro here rather than a standard QOM cast?

> +
> +    nic_reset(s);
> +}
> +
>  #if defined(DEBUG_EEPRO100)
>  static const char * const e100_reg[PCI_IO_SIZE / 4] = {
>      "Command/Status",
> @@ -1881,8 +1888,6 @@ static void e100_nic_realize(PCIDevice *pci_dev, Error **errp)
>      qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
>      TRACE(OTHER, logout("%s\n", qemu_get_queue(s->nic)->info_str));
>
> -    qemu_register_reset(nic_reset, s);
> -
>      s->vmstate = g_memdup(&vmstate_eepro100, sizeof(vmstate_eepro100));
>      s->vmstate->name = qemu_get_queue(s->nic)->model;
>      vmstate_register_any(VMSTATE_IF(&pci_dev->qdev), s->vmstate, s);

There's also a call to nic_reset() lurking in the realize
function, which should be removed.

> @@ -2064,6 +2069,7 @@ static void eepro100_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>      E100PCIDeviceInfo *info;
>
>      info = eepro100_get_class_by_name(object_class_get_name(klass));
> @@ -2080,6 +2086,7 @@ static void eepro100_class_init(ObjectClass *klass, const void *data)
>      k->revision = info->revision;
>      k->subsystem_vendor_id = info->subsystem_vendor_id;
>      k->subsystem_id = info->subsystem_id;
> +    rc->phases.hold = eepro100_reset_hold;
>  }

thanks
-- PMM

