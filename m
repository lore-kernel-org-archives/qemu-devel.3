Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3784C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 16:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0jfa-0004rb-6s; Fri, 04 Apr 2025 12:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0jfW-0004rJ-H8
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 12:13:22 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0jfU-0003yh-1F
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 12:13:22 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso23674405e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 09:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743783195; x=1744387995; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9a12gCA/6Kq1t+NCdJQVFsLrQlxLsLT75310yiUowq8=;
 b=MocOfPfjXBotTlIxEDa43COaWagaxpirPwPRjwW0EGOEMMaqVm7S9VIIbkb+hnXg7H
 a8lXpSr/r2q/UQCc/bNLGiAcTJU9aMtVd7gfLpBrAeSwvfJlQNnM7So75hWIec8pfp2+
 TyK1yMOBy7dBBz5bmjiEu2Tv6saL1Q3A7vqefX57XK5pNjQxTDsm833//zi2K5H4uxus
 Qukc/Evx12Jpi16gbxKtbRjQHq/ZzA/Lo1E0rGiGiYXVl2nSd4U4OP3f5UXbRtD0JeDB
 DIoQd1U0LrjFbVHJt9wNOmWAYh9GP8fSikV79lmuoZutpRFuj185mAijiWicNsKZWzuM
 Rftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743783195; x=1744387995;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9a12gCA/6Kq1t+NCdJQVFsLrQlxLsLT75310yiUowq8=;
 b=PhjQh/51m2fu59DBZClVaVeRpag7NU9qZVeH+wDsGy81EBRteyrGZxUOnSfamUxMXw
 VTFQbqaphQ4FYE0JyZWgJVMF23TdK+KFC5heIRfHwK+F8bvgSh9E3hPaOnDnVz/mwoSL
 xv50OEVif4GJ8XFVCRwMEjlnZnWKMGbNZJ39wVvmp8Tqmu7gaj4ZA0yEQeu5i9k9IrjB
 cIs9HDsabLONoWk3q0zJTuN3wHGdZ9Z28RZUdKt10O2YSxacozVD95aaWIV3aNoJhCLe
 R1SPps27/SUHOCEmfP7V9lysWlgm3W7FPAD2JpylvfBejYfMz+kaCs1MBZ1XS8T3HRLN
 i4Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxQvNPrJOr0ADvBjsmu/3i7+udEPL/Bcd8jbPOA7p9Ms5sbbfxlHcPbJ29Qnyi6SDcWjeomLokRR/p@nongnu.org
X-Gm-Message-State: AOJu0Yxui3DHRvmgaEmn6tmy4dS7Y5Dj9YKPBYkp8gM9kNaHPi5xZ+/7
 xZyKHYHHIx2Ki9pb+Zo7TrVONVX7eLBF01tLO6y1Bs1N4yjxxW0ZiZAG86iC438=
X-Gm-Gg: ASbGnctavOiuGB7tG2hHFruxD8XiJNUMoZdzCJjH3vrmxuIjBmPT2MKG5YHP5+IOUZJ
 UwoXAbcC1/Rdku5g5XWBOC2OPbguL4Oa4Ka8RTBenX5Fgi8IaDichwaDz152EbpLyeJNQab5HyW
 M/mPOnh68XPcJsNZp3Op5oTwDgSF7mSW9/8P1mZEUuwGF6TRsIDUe5FFW0C07chqN6o9/YWDkQh
 TyhQvocPcdusChODoxIg0shgWMbPi6lLoPAk4AcwxrP25YN44TnhV7Rd3I5+1Sug1vg3fjIORlC
 4FGrzxWQ1eK2Aifoxrt8aXhCg+BLGcxLx10GVFJd1O5C4+/ywTrw/ud1ybSQ4SjxM8DRanPLg0W
 eoZ0IvZUNzVXF2Gup3w==
X-Google-Smtp-Source: AGHT+IHHAI/7/xMesCgwPa8GED5kHVXHEhHWqENfIxIL8Xbj8orHhfrpG07HxfPJFj6gMmlqBzAMDQ==
X-Received: by 2002:a05:600c:3b9f:b0:43c:fdbe:4398 with SMTP id
 5b1f17b1804b1-43ed0b80b25mr28855785e9.6.1743783194791; 
 Fri, 04 Apr 2025 09:13:14 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020da22sm4800374f8f.68.2025.04.04.09.13.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 09:13:14 -0700 (PDT)
Message-ID: <fffd6cf6-16f7-4b93-9b81-cf1ab6c35435@linaro.org>
Date: Fri, 4 Apr 2025 18:13:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ipmi: Move vmsd registration to device class
To: corey@minyard.net, qemu-devel@nongnu.org
References: <Z_AAPdpBWQjXq6fJ@mail.minyard.net>
Content-Language: en-US
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z_AAPdpBWQjXq6fJ@mail.minyard.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Cc'ing migration maintainers

On 4/4/25 17:52, Corey Minyard wrote:
> It's the right way to do it now, and it handles multiple instances
> properly.  I need multiple instances for some testing I'm doing so this
> is the right thing to do.
> 
> Tested by doing:
> 
>     (qemu) migrate -d exec:cat>filen.mig
> 
> before and after the fix, then:
> 
>     scripts/analyze-migration.py -d desc -f file1.mig >file1.json
>     scripts/analyze-migration.py -d desc -f file2.mig >file2.json
>     diff file1.json file2.json
> 
> with no differences.
> 
> Signed-off-by: Corey Minyard <corey@minyard.net>
> ---
>   hw/ipmi/ipmi_bmc_extern.c |  3 +--
>   hw/ipmi/ipmi_bmc_sim.c    |  3 +--
>   hw/ipmi/isa_ipmi_bt.c     |  3 +--
>   hw/ipmi/isa_ipmi_kcs.c    | 12 +++++-------
>   4 files changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
> index d015500254..3e9f8c5a50 100644
> --- a/hw/ipmi/ipmi_bmc_extern.c
> +++ b/hw/ipmi/ipmi_bmc_extern.c
> @@ -497,8 +497,6 @@ static void ipmi_bmc_extern_realize(DeviceState *dev, Error **errp)
>   
>       qemu_chr_fe_set_handlers(&ibe->chr, can_receive, receive,
>                                chr_event, NULL, ibe, NULL, true);
> -
> -    vmstate_register(NULL, 0, &vmstate_ipmi_bmc_extern, ibe);
>   }
>   
>   static void ipmi_bmc_extern_init(Object *obj)
> @@ -528,6 +526,7 @@ static void ipmi_bmc_extern_class_init(ObjectClass *oc, void *data)
>       bk->handle_reset = ipmi_bmc_extern_handle_reset;
>       dc->hotpluggable = false;
>       dc->realize = ipmi_bmc_extern_realize;
> +    dc->vmsd = &vmstate_ipmi_bmc_extern;
>       device_class_set_props(dc, ipmi_bmc_extern_properties);
>   }
>   
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index 6157ac7120..bc0ddc52a9 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -2187,8 +2187,6 @@ static void ipmi_sim_realize(DeviceState *dev, Error **errp)
>       register_cmds(ibs);
>   
>       ibs->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, ipmi_timeout, ibs);
> -
> -    vmstate_register(NULL, 0, &vmstate_ipmi_sim, ibs);
>   }
>   
>   static const Property ipmi_sim_properties[] = {
> @@ -2212,6 +2210,7 @@ static void ipmi_sim_class_init(ObjectClass *oc, void *data)
>   
>       dc->hotpluggable = false;
>       dc->realize = ipmi_sim_realize;
> +    dc->vmsd = &vmstate_ipmi_sim;
>       device_class_set_props(dc, ipmi_sim_properties);
>       bk->handle_command = ipmi_sim_handle_command;
>   }
> diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
> index a1b66d5ee8..474a792c9a 100644
> --- a/hw/ipmi/isa_ipmi_bt.c
> +++ b/hw/ipmi/isa_ipmi_bt.c
> @@ -117,8 +117,6 @@ static void isa_ipmi_bt_realize(DeviceState *dev, Error **errp)
>       qdev_set_legacy_instance_id(dev, iib->bt.io_base, iib->bt.io_length);
>   
>       isa_register_ioport(isadev, &iib->bt.io, iib->bt.io_base);
> -
> -    vmstate_register(NULL, 0, &vmstate_ISAIPMIBTDevice, dev);
>   }
>   
>   static void isa_ipmi_bt_init(Object *obj)
> @@ -147,6 +145,7 @@ static void isa_ipmi_bt_class_init(ObjectClass *oc, void *data)
>       AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(oc);
>   
>       dc->realize = isa_ipmi_bt_realize;
> +    dc->vmsd = &vmstate_ISAIPMIBTDevice;
>       device_class_set_props(dc, ipmi_isa_properties);
>   
>       iic->get_backend_data = isa_ipmi_bt_get_backend_data;
> diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
> index d9ebdd5371..94bbe45d35 100644
> --- a/hw/ipmi/isa_ipmi_kcs.c
> +++ b/hw/ipmi/isa_ipmi_kcs.c
> @@ -72,6 +72,10 @@ static bool vmstate_kcs_before_version2(void *opaque, int version)
>       return version <= 1;
>   }
>   
> +/*
> + * Version 1 had an incorrect name, it clashed with the BT IPMI
> + * device, so receive it, but transmit a different version.
> + */
>   static const VMStateDescription vmstate_ISAIPMIKCSDevice = {
>       .name = TYPE_IPMI_INTERFACE,
>       .version_id = 2,
> @@ -119,13 +123,6 @@ static void ipmi_isa_realize(DeviceState *dev, Error **errp)
>       qdev_set_legacy_instance_id(dev, iik->kcs.io_base, iik->kcs.io_length);
>   
>       isa_register_ioport(isadev, &iik->kcs.io, iik->kcs.io_base);
> -
> -    /*
> -     * Version 1 had an incorrect name, it clashed with the BT
> -     * IPMI device, so receive it, but transmit a different
> -     * version.
> -     */
> -    vmstate_register(NULL, 0, &vmstate_ISAIPMIKCSDevice, iik);
>   }
>   
>   static void isa_ipmi_kcs_init(Object *obj)
> @@ -154,6 +151,7 @@ static void isa_ipmi_kcs_class_init(ObjectClass *oc, void *data)
>       AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(oc);
>   
>       dc->realize = ipmi_isa_realize;
> +    dc->vmsd = &vmstate_ISAIPMIKCSDevice;
>       device_class_set_props(dc, ipmi_isa_properties);
>   
>       iic->get_backend_data = isa_ipmi_kcs_get_backend_data;

LGTM!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


